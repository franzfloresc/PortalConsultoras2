using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ConsultaProl;
using Portal.Consultoras.Web.ServiceOferta;

namespace Portal.Consultoras.Web.Providers
{
    public class ConsultaProlProvider
    {
        private readonly static HttpClient httpClient = new HttpClient();
        protected TablaLogicaProvider _tablaLogicaProvider;

        public ConsultaProlProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        static ConsultaProlProvider()
        {
            var rutaServicio = WebConfig.RutaServiceConsultaPROL;

            if (!string.IsNullOrEmpty(rutaServicio))
            {
                httpClient.BaseAddress = new Uri(rutaServicio);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            }
        }

        private static async Task<string> RespMSConsultaProl(string jsonParametros, string requestUrlParam, string responseType, string codigoConsultora, string paisISO)
        {
            using (var client = new HttpClient())
            {
                string url = WebConfig.RutaServiceConsultaPROL;
                client.BaseAddress = new Uri(url);
                string jsonString = jsonParametros;

                const string contentType = "application/json";

                var httpContent = new StringContent(jsonString, Encoding.UTF8, contentType);
                string requestUrl = requestUrlParam;
                HttpResponseMessage response = null;
                if (responseType.Equals("get"))
                {
                    string completeRequestUrl = string.Format("{0}{1}", requestUrl, jsonString);
                    response = await client.GetAsync(completeRequestUrl);
                }
                else if (responseType.Equals("put"))
                {
                    response = await client.PutAsync(requestUrl, httpContent);
                }
                else if (responseType.Equals("post"))
                {
                    response = await client.PostAsync(requestUrl, httpContent);
                }
                else if (responseType.Equals("delete"))
                {
                    response = await client.DeleteAsync(requestUrl);
                }

                if (response != null && !response.IsSuccessStatusCode)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_RespMSConsultaProl:" + response.StatusCode.ToString()), codigoConsultora, paisISO);
                    return "";
                }

                if (response != null)
                {
                    var content = await response.Content.ReadAsStringAsync();

                    if (string.IsNullOrEmpty(content))
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_RespMSConsultaProl: Null content"), codigoConsultora, paisISO);
                        return "";
                    }
                    return content;
                }
            }
            return "";
        }

        public bool GetValidarDiasAntesStock(UsuarioModel userData)
        {
            var validar = false;
            var lstTablaLogicaDatos = _tablaLogicaProvider.GetTablaLogicaDatos(userData.PaisID, ConsTablaLogica.OfertasConsultora.TablaLogicaId, true);
            if (lstTablaLogicaDatos.Any())
            {
                var diasAntesStock = lstTablaLogicaDatos.FirstOrDefault(t => t.Codigo == ConsTablaLogica.OfertasConsultora.DiasAntesStock).Valor;

                if (!string.IsNullOrEmpty(diasAntesStock))
                {
                    var iDiasAntesStock = int.Parse(diasAntesStock);
                    if (Util.GetDiaActual(userData.ZonaHoraria) >= userData.FechaInicioCampania.AddDays(iDiasAntesStock))
                    {
                        validar = true;
                    }
                }
            }
            return validar;
        }
        
        public List<BEEstrategia> ActualizarEstrategiaStockProl(List<BEEstrategia> lista, string paisISO, int campaniaID, string codigoConsultora, bool esFacturacion)
        {
            try
            {
                if (lista.Count == 0) return lista;

                var listaCUVs = string.Join("|", lista.Where(e => !string.IsNullOrEmpty(e.CUV2)).Select(e => e.CUV2));
                ConsultaStockModel stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = listaCUVs,
                    FlagDetalle = Constantes.ConsultaPROL.StockPadre,
                    EsFacturacion = esFacturacion
                };

                string requestUrl = Constantes.ConsultaPROL.ConsultaStockProl;
                string jsonParameters = JsonConvert.SerializeObject(stock);
                var taskApi = Task.Run(() => RespMSConsultaProl(jsonParameters, requestUrl, "post", codigoConsultora, paisISO));
                Task.WhenAll(taskApi);
                string content = taskApi.Result;
                var respuesta = JsonConvert.DeserializeObject<List<RespuestaStockModel>>(content);

                if (respuesta.Count == 0)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_ActualizarEstrategiaStockPROL: Null content"), codigoConsultora, paisISO);
                }
                else
                {
                    lista.ForEach(x =>
                    {
                        var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_PADRE == x.CUV2);
                        if (temp != null)
                        {
                            x.TieneStock = temp.STOCK == 1;
                        }
                    });
                }

                return lista.OrderBy(x => x.TieneStock, false).ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, paisISO);
                return lista;
            }
        }

        public List<DetalleEstrategiaFichaModel> ActualizarEstrategiaStockProl(List<DetalleEstrategiaFichaModel> lista, string paisISO, int campaniaID, string codigoConsultora, bool esFacturacion)
        {
            if (lista.Count == 0) return lista;

            try
            {
                var listaCUVs = string.Join("|", lista.Where(e => !string.IsNullOrEmpty(e.CUV2)).Select(e => e.CUV2));
                ConsultaStockModel stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = listaCUVs,
                    FlagDetalle = Constantes.ConsultaPROL.StockPadre,
                    EsFacturacion = esFacturacion
                };

                string requestUrl = Constantes.ConsultaPROL.ConsultaStockProl;
                string jsonParameters = JsonConvert.SerializeObject(stock);
                var taskApi = Task.Run(() => RespMSConsultaProl(jsonParameters, requestUrl, "post", codigoConsultora, paisISO));
                Task.WhenAll(taskApi);
                string content = taskApi.Result;
                var respuesta = JsonConvert.DeserializeObject<List<RespuestaStockModel>>(content);

                if (respuesta.Count == 0)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_ActualizarEstrategiaStockPROL: Null content"), codigoConsultora, paisISO);
                }
                else
                {
                    lista.ForEach(x =>
                    {
                        var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_PADRE == x.CUV2);
                        if (temp != null)
                        {
                            x.TieneStock = temp.STOCK == 1;
                        }
                    });
                }

                return lista.OrderBy(x => x.TieneStock, false).ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, paisISO);
                return lista;
            }
        }

        public List<EstrategiaPersonalizadaProductoModel> ActualizarEstrategiaStockProl(List<EstrategiaPersonalizadaProductoModel> lista, string paisISO, int campaniaID, string codigoConsultora, bool esFacturacion)
        {
            try
            {
                if (lista.Count == 0) return lista;

                var listaCUVs = string.Join("|", lista.Where(e => !string.IsNullOrEmpty(e.CUV2)).Select(e => e.CUV2));
                var stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = listaCUVs,
                    FlagDetalle = Constantes.ConsultaPROL.StockPadre,
                    EsFacturacion = esFacturacion
                };

                var jsonParameters = JsonConvert.SerializeObject(stock);
                var taskApi = Task.Run(() => RespMSConsultaProl(jsonParameters, 
                    Constantes.ConsultaPROL.ConsultaStockProl, 
                    "" + "post", 
                    codigoConsultora, 
                    paisISO));

                Task.WhenAll(taskApi);
                var content = taskApi.Result;
                var respuesta = JsonConvert.DeserializeObject<List<RespuestaStockModel>>(content);

                if (respuesta.Count == 0)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_ActualizarEstrategiaStockPROL: Null content"), codigoConsultora, paisISO);
                    return lista;
                }
               
                lista.ForEach(x =>
                {
                    var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_PADRE == x.CUV2);
                    if (temp != null)
                    {
                        x.TieneStock = temp.STOCK == 1;
                    }
                });
                lista.RemoveAll(x => !x.TieneStock);
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, paisISO);
                return lista;
            }
        }

        public bool TieneStockPROLEstrategia(string cuv, string paisISO, int campaniaID, string codigoConsultora)
        {
            bool result = false;
            try
            {
                ConsultaStockModel stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = cuv,
                    FlagDetalle = Constantes.ConsultaPROL.StockPadre
                };

                string requestUrl = Constantes.ConsultaPROL.ConsultaStockProl;
                string jsonParameters = JsonConvert.SerializeObject(stock);
                var taskApi = Task.Run(() => RespMSConsultaProl(jsonParameters, requestUrl, "post", codigoConsultora, paisISO));
                Task.WhenAll(taskApi);
                string content = taskApi.Result;
                var respuesta = JsonConvert.DeserializeObject<List<RespuestaStockModel>>(content);

                if (respuesta.Count == 0)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_ActualizarEstrategiaStockPROL: Null content"), codigoConsultora, paisISO);
                }
                else
                {
                    var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_PADRE == cuv);
                    if (temp != null)
                    {
                        result = (temp.STOCK == 1);
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, paisISO);
                return false;
            }
        }

        public List<EstrategiaComponenteModel> ActualizarComponenteStockPROL(List<EstrategiaComponenteModel> lista, string cuvPadre, string paisISO, int campaniaID, string codigoConsultora, bool esFacturacion)
        {
            try
            {
                if (!lista.Any()) return lista;

                ConsultaStockModel stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = cuvPadre,
                    FlagDetalle = Constantes.ConsultaPROL.StockHijo,
                    EsFacturacion = esFacturacion
                };

                string requestUrl = Constantes.ConsultaPROL.ConsultaStockProl;
                string jsonParameters = JsonConvert.SerializeObject(stock);
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("Tracking ConsultaProlProvider_ActualizarComponenteStockPROL:");
                sb.AppendLine("Method: Post");
                sb.AppendLine(string.Format("Url:{0}", WebConfig.RutaServiceConsultaPROL));
                sb.AppendLine(string.Format("Parametros:{0}", jsonParameters));
                sb.AppendLine("Response: Null content");

                var taskApi = Task.Run(() => RespMSConsultaProl(jsonParameters, requestUrl, "post", codigoConsultora, paisISO));
                Task.WhenAll(taskApi);
                string content = taskApi.Result;
                var respuesta = JsonConvert.DeserializeObject<List<RespuestaStockModel>>(content);

                if (respuesta.Count == 0)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new ClientInformationException(sb.ToString()), codigoConsultora, paisISO);
                }
                else
                {
                    lista.ForEach(x =>
                    {
                        var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_HIJO == x.Cuv);
                        if (temp != null)
                        {
                            x.TieneStock = (temp.STOCK == 1);
                        }
                        if (x.Hermanos != null && x.Hermanos.Any())
                        {
                            x.Hermanos = ActualizarComponenteHermanos(x.Hermanos, respuesta);
                        }
                    });
                }

                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, paisISO);
                return lista;
            }
        }

        private List<EstrategiaComponenteModel> ActualizarComponenteHermanos(List<EstrategiaComponenteModel> lista, List<RespuestaStockModel> respuesta)
        {
            lista.ForEach(x =>
            {
                var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_HIJO == x.Cuv);
                if (temp != null)
                {
                    x.TieneStock = (temp.STOCK == 1);
                }
            });
            return lista;
        }
    }
}