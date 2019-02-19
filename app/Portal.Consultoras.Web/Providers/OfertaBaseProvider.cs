using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Oferta.ResponseOfertaGenerico;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaBaseProvider
    {
        private static readonly HttpClient httpClient = new HttpClient();

        private readonly ISessionManager _sessionManager = SessionManager.SessionManager.Instance;

        static OfertaBaseProvider()
        {
            if (string.IsNullOrEmpty(WebConfig.UrlMicroservicioPersonalizacionSearch)) return;
            httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public static async Task<List<ServiceOferta.BEEstrategia>> ObtenerOfertasDesdeApi(string path, string codigoISO)
        {
            List<ServiceOferta.BEEstrategia> estrategias = new List<ServiceOferta.BEEstrategia>();
            HttpResponseMessage httpResponse = await httpClient.GetAsync(path);

            if (!httpResponse.IsSuccessStatusCode)
            {
                return estrategias;
            }

            string jsonString = await httpResponse.Content.ReadAsStringAsync();
            if (Util.Trim(jsonString) == string.Empty)
            {
                return estrategias;
            }

            OutputOferta respuesta = new OutputOferta();
            var listaSinPrecio2 = new List<string>();
            try
            {
                respuesta = JsonConvert.DeserializeObject<OutputOferta>(jsonString);
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                return estrategias;
            }

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, codigoISO);
                return estrategias;
            }

            List<string> listaCuvPrecio0 = new List<string>();
            string codTipoEstrategia = string.Empty, codCampania = string.Empty;

            foreach (Models.Search.ResponseOferta.Estructura.Estrategia item in respuesta.Result)
            {
                try
                {
                    var estrategia = new ServiceOferta.BEEstrategia
                    {
                        CampaniaID = Convert.ToInt32(item.CodigoCampania),
                        CodigoEstrategia = item.CodigoEstrategia.ToString(),
                        CodigoProducto = item.CodigoProducto,
                        CUV2 = item.CUV2,
                        DescripcionCUV2 = item.DescripcionCUV2,
                        DescripcionEstrategia = item.DescripcionTipoEstrategia,
                        DescripcionMarca = item.MarcaDescripcion,
                        EstrategiaID = Convert.ToInt32(item.EstrategiaId),
                        FlagNueva = Convert.ToBoolean(item.FlagNueva) ? 1 : 0,
                        FlagRevista = item.FlagRevista,
                        FotoProducto01 = item.ImagenURL,
                        ImagenURL = item.ImagenEstrategia,
                        IndicadorMontoMinimo = Convert.ToInt32(item.IndicadorMontoMinimo),
                        LimiteVenta = Convert.ToInt32(item.LimiteVenta),
                        MarcaID = Convert.ToInt32(item.MarcaId),
                        Orden = Convert.ToInt32(item.Orden),
                        Precio = Convert.ToDecimal(item.Precio),
                        Precio2 = Convert.ToDecimal(item.Precio2),
                        PrecioString = Util.DecimalToStringFormat((decimal)item.Precio2, codigoISO),
                        PrecioTachado = Util.DecimalToStringFormat((decimal)item.Precio, codigoISO),
                        GananciaString = Util.DecimalToStringFormat((decimal)item.Ganancia, codigoISO),
                        Ganancia = Convert.ToDecimal(item.Ganancia),
                        TextoLibre = item.TextoLibre,
                        TieneVariedad = Convert.ToBoolean(item.TieneVariedad) ? 1 : 0,
                        TipoEstrategiaID = Convert.ToInt32(item.TipoEstrategiaId),
                        TipoEstrategiaImagenMostrar = 6,
                        EsSubCampania = Convert.ToBoolean(item.EsSubCampania) ? 1 : 0,
                        Niveles = item.Niveles
                    };
                    estrategia.TipoEstrategia = new ServiceOferta.BETipoEstrategia { Codigo = item.CodigoTipoEstrategia };
                    
                    if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento && item.EstrategiaDetalle != null)
                    {
                        estrategia.EstrategiaDetalle = new ServiceOferta.BEEstrategiaDetalle();
                        int tablaLogicaDatosID;

                        foreach (Models.Search.ResponseOferta.Estructura.EstrategiaDetalle itemED in item.EstrategiaDetalle)
                        {
                            if (itemED.TablaLogicaDatosID == 0) continue;

                            tablaLogicaDatosID = Convert.ToInt32(itemED.TablaLogicaDatosID);

                            switch (tablaLogicaDatosID)
                            {
                                case Constantes.EstrategiaDetalleCamposID.FlagIndividual:
                                    estrategia.EstrategiaDetalle.FlagIndividual = (itemED.Valor == "1" ? true : false);
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaDesktop:
                                    estrategia.EstrategiaDetalle.ImgFichaDesktop = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaFondoDesktop:
                                    estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = itemED.Valor;

                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaFondoMobile:
                                    estrategia.EstrategiaDetalle.ImgFichaFondoMobile = itemED.Valor;

                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaMobile:
                                    estrategia.EstrategiaDetalle.ImgFichaMobile = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFondoDesktop:
                                    estrategia.EstrategiaDetalle.ImgFondoDesktop = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFondoMobile:
                                    estrategia.EstrategiaDetalle.ImgFondoMobile = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgHomeDesktop:
                                    estrategia.EstrategiaDetalle.ImgHomeDesktop = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgHomeMobile:
                                    estrategia.EstrategiaDetalle.ImgHomeMobile = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.Slogan:
                                    estrategia.EstrategiaDetalle.Slogan = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.UrlVideoDesktop:
                                    estrategia.EstrategiaDetalle.UrlVideoDesktop = itemED.Valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.UrlVideoMobile:
                                    estrategia.EstrategiaDetalle.UrlVideoMobile = itemED.Valor;
                                    break;
                            }
                        }
                    }

                    if (estrategia.Precio2 > 0)
                    {
                        List<ServiceOferta.BEEstrategiaProducto> compoponentes = new List<ServiceOferta.BEEstrategiaProducto>();
                        foreach (Models.Search.ResponseOferta.Estructura.Componente componente in item.Componentes)
                        {
                            var estrategiaTono = new ServiceOferta.BEEstrategiaProducto
                            {
                                Grupo = componente.Grupo.ToString(),
                                CUV = componente.Cuv,
                                SAP = componente.CodigoSap,
                                Orden = componente.Orden,
                                Precio = componente.PrecioUnitario,
                                Digitable = Convert.ToBoolean(componente.IndicadorDigitable) ? 1 : 0,
                                Cantidad = componente.Cantidad,
                                FactorCuadre = componente.FactorCuadre,
                                IdMarca = componente.MarcaId,
                                NombreMarca = componente.NombreMarca,
                                NombreComercial = componente.NombreComercial,
                                Volumen = componente.Volumen,
                                NombreBulk = componente.NombreBulk
                            };

                            compoponentes.Add(estrategiaTono);
                        }

                        estrategia.EstrategiaProducto = compoponentes.ToArray();

                        estrategias.Add(estrategia);
                    }
                    else
                    {
                        listaSinPrecio2.Add(estrategia.CUV2);
                        codTipoEstrategia = estrategia.CodigoTipoEstrategia;
                        codCampania = estrategia.CampaniaID.ToString();
                    }
                }
                catch (Exception ex)
                {
                    Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                    return estrategias;
                }
            }
           
            if (listaSinPrecio2.Any())
            {
                string logPrecio0 = string.Format("Log Precios0 => Fecha:{0} /Palanca:{1} /CodCampania:{2} /CUV(s):{3} /Referencia:{4}", DateTime.Now, codTipoEstrategia, codCampania, string.Join("|", listaSinPrecio2), path);
                Common.LogManager.SaveLog(new Exception(logPrecio0), "", codigoISO);
            }

            return estrategias;
        }

        public string ObtenerDescripcionOferta(string descripcionCuv2)
        {
            var descripcionOdd = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                var temp = descripcionCuv2.Split('|').ToList();
                temp = temp.Skip(1).ToList();

                var txtBuil = new StringBuilder();
                foreach (var item in temp.Where(item => !string.IsNullOrEmpty(item)))
                {
                    txtBuil.Append(item.Trim() + "|");
                }

                descripcionOdd = txtBuil.ToString();
                descripcionOdd = descripcionOdd == string.Empty
                    ? string.Empty
                    : descripcionOdd.Substring(0, descripcionOdd.Length - 1);
                descripcionOdd = descripcionOdd.Replace("|", " +<br />");
                descripcionOdd = descripcionOdd.Replace("\\", "");
                descripcionOdd = descripcionOdd.Replace("(GRATIS)", "<b>GRATIS</b>");
            }
            return descripcionOdd;
        }

        public string ObtenerNombreOferta(string descripcionCuv2)
        {
            var nombreOferta = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                nombreOferta = descripcionCuv2.Split('|').First();
            }
            return nombreOferta;
        }

        public bool UsarMsPersonalizacion(string pais, string tipoEstrategia, bool dbDefault = false)
        {
            if (dbDefault) return false;

            bool paisHabilitado = _sessionManager.GetConfigMicroserviciosPersonalizacion().PaisHabilitado.Contains(pais); //WebConfig.PaisesMicroservicioPersonalizacion.Contains(pais);
            bool tipoEstrategiaHabilitado = _sessionManager.GetConfigMicroserviciosPersonalizacion().EstrategiaHabilitado.Contains(tipoEstrategia); //WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion.Contains(tipoEstrategia);
            return paisHabilitado && tipoEstrategiaHabilitado;
        }

        public bool UsarMsPersonalizacion(string tipoEstrategia)
        {
            bool tipoEstrategiaHabilitado = _sessionManager.GetConfigMicroserviciosPersonalizacion().EstrategiaHabilitado.Contains(tipoEstrategia); //WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion.Contains(tipoEstrategia);
            return tipoEstrategiaHabilitado;
        }
    }
}