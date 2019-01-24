using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ConsultaProl;
using Portal.Consultoras.Web.ServiceOferta;



namespace Portal.Consultoras.Web.Providers
{
    public class ConsultaProlProvider
    {
        private readonly static HttpClient httpClient = new HttpClient();

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

        public List<BEEstrategia> ActualizarEstrategiaStockPROL(List<BEEstrategia> lista, string paisISO, int campaniaID, string codigoConsultora)
        {
            if (lista.Count == 0) return lista;

            try
            {
                //var listaCUVs = string.Join("|", lista.Where(e => !string.IsNullOrEmpty(e.CUV2) && e.TieneStock).Select(e => e.CUV2));
                var listaCUVs = string.Join("|", lista.Where(e => !string.IsNullOrEmpty(e.CUV2)).Select(e => e.CUV2));
                ConsultaStockModel stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = listaCUVs,
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
                    lista.ForEach(x =>
                    {
                        var temp = respuesta.FirstOrDefault(r => r.COD_VENTA_PADRE == x.CUV2);
                        if (temp != null)
                        {
                            x.TieneStock = (temp.STOCK == 1);
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

        public List<EstrategiaComponenteModel> ActualizarComponenteStockPROL(List<EstrategiaComponenteModel> lista ,string cuvPadre,string paisISO, int campaniaID, string codigoConsultora)
        {
            if (lista.Count == 0) return lista;

            try
            {
                ConsultaStockModel stock = new ConsultaStockModel
                {
                    PaisISO = paisISO,
                    CampaniaID = campaniaID,
                    ListaCUVs = cuvPadre,
                    FlagDetalle = Constantes.ConsultaPROL.StockHijo
                };

                string requestUrl = Constantes.ConsultaPROL.ConsultaStockProl;
                string jsonParameters = JsonConvert.SerializeObject(stock);
                var taskApi = Task.Run(() => RespMSConsultaProl(jsonParameters, requestUrl, "post", codigoConsultora, paisISO));
                Task.WhenAll(taskApi);
                string content = taskApi.Result;
                var respuesta = JsonConvert.DeserializeObject<List<RespuestaStockModel>>(content);

                if (respuesta.Count == 0)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ConsultaProlProvider_ActualizarComponenteStockPROL: Null content"), codigoConsultora, paisISO);
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
                        x.Hermanos = ActualizarComponenteHermanos(x.Hermanos, respuesta);
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