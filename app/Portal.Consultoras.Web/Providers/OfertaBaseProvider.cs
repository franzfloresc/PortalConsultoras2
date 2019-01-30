using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
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

        static OfertaBaseProvider()
        {
            if (string.IsNullOrEmpty(WebConfig.UrlMicroservicioPersonalizacionSearch)) return;
            httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public static async Task<List<ServiceOferta.BEEstrategia>> ObtenerOfertasDesdeApi(string path, string codigoISO)
        {
            var estrategias = new List<ServiceOferta.BEEstrategia>();
            var httpResponse = await httpClient.GetAsync(path);

            if (!httpResponse.IsSuccessStatusCode)
            {
                return estrategias;
            }

            var jsonString = await httpResponse.Content.ReadAsStringAsync();
            if (Util.Trim(jsonString) == "")
            {
                return estrategias;
            }

            var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString) ?? new List<dynamic>();
            var listaCuvPrecio0 = new List<string>();
            string codTipoEstrategia = "", codCampania = "";

            foreach (var item in list)
            {
                try
                {
                    var estrategia = new ServiceOferta.BEEstrategia
                    {
                        CampaniaID = item.codigoCampania,
                        CodigoEstrategia = item.codigoEstrategia,
                        CodigoProducto = item.codigoProducto,
                        CUV2 = item.cuV2,
                        DescripcionCUV2 = item.descripcionCUV2,
                        DescripcionEstrategia = item.descripcionTipoEstrategia,
                        DescripcionMarca = item.marcaDescripcion,
                        EstrategiaID = Convert.ToInt32(item.estrategiaId),
                        FlagNueva = Convert.ToBoolean(item.flagNueva).ToInt(),
                        FlagRevista = item.flagRevista,
                        FotoProducto01 = item.imagenURL,
                        ImagenURL = item.imagenEstrategia,
                        IndicadorMontoMinimo = Convert.ToInt32(item.indicadorMontoMinimo),
                        LimiteVenta = Convert.ToInt32(item.limiteVenta),
                        MarcaID = Convert.ToInt32(item.marcaId),
                        Orden = Convert.ToInt32(item.orden),
                        Precio = Convert.ToDecimal(item.precio),
                        Precio2 = Convert.ToDecimal(item.precio2),
                        PrecioString = Util.DecimalToStringFormat((decimal)item.precio2, codigoISO),
                        PrecioTachado = Util.DecimalToStringFormat((decimal)item.precio, codigoISO),
                        GananciaString = Util.DecimalToStringFormat((decimal)item.ganancia, codigoISO),
                        Ganancia = Convert.ToDecimal(item.ganancia),
                        TextoLibre = item.textoLibre,
                        TieneVariedad = Convert.ToBoolean(item.tieneVariedad).ToInt(),
                        TipoEstrategiaID = Convert.ToInt32(item.tipoEstrategiaId),
                        TipoEstrategiaImagenMostrar = 6,
                        EsSubCampania = Convert.ToBoolean(item.esSubCampania).ToInt(),
                    };
                    estrategia.TipoEstrategia = new ServiceOferta.BETipoEstrategia { Codigo = item.codigoTipoEstrategia };

                    if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento && item.estrategiaDetalle != null)
                    {
                        estrategia.EstrategiaDetalle = new ServiceOferta.BEEstrategiaDetalle();
                        int tablaLogicaDatosID;

                        foreach (var itemED in item.estrategiaDetalle)
                        {
                            if (itemED.tablaLogicaDatosID == null) continue;

                            tablaLogicaDatosID = Convert.ToInt32(itemED.tablaLogicaDatosID);

                            switch (tablaLogicaDatosID)
                            {
                                case Constantes.EstrategiaDetalleCamposID.FlagIndividual:
                                    estrategia.EstrategiaDetalle.FlagIndividual = (itemED.valor == "1");
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaDesktop:
                                    estrategia.EstrategiaDetalle.ImgFichaDesktop = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaFondoDesktop:
                                    estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaFondoMobile:
                                    estrategia.EstrategiaDetalle.ImgFichaFondoMobile = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFichaMobile:
                                    estrategia.EstrategiaDetalle.ImgFichaMobile = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFondoDesktop:
                                    estrategia.EstrategiaDetalle.ImgFondoDesktop = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgFondoMobile:
                                    estrategia.EstrategiaDetalle.ImgFondoMobile = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgHomeDesktop:
                                    estrategia.EstrategiaDetalle.ImgHomeDesktop = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.ImgHomeMobile:
                                    estrategia.EstrategiaDetalle.ImgHomeMobile = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.Slogan:
                                    estrategia.EstrategiaDetalle.Slogan = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.UrlVideoDesktop:
                                    estrategia.EstrategiaDetalle.UrlVideoDesktop = itemED.valor;
                                    break;
                                case Constantes.EstrategiaDetalleCamposID.UrlVideoMobile:
                                    estrategia.EstrategiaDetalle.UrlVideoMobile = itemED.valor;
                                    break;
                            }
                        }
                    }

                    if (estrategia.Precio2 > 0)
                    {
                        var compoponentes = new List<ServiceOferta.BEEstrategiaProducto>();
                        foreach (var componente in item.componentes)
                        {
                            var estrategiaTono = new ServiceOferta.BEEstrategiaProducto
                            {
                                Grupo = componente.grupo,
                                CUV = componente.cuv,
                                SAP = componente.codigoSap,
                                Orden = componente.orden,
                                Precio = componente.precioUnitario,
                                Digitable = Convert.ToBoolean(componente.indicadorDigitable).ToInt(),
                                Cantidad = componente.cantidad,
                                FactorCuadre = componente.factorCuadre,
                                IdMarca = componente.marcaId,
                                NombreMarca = componente.nombreMarca,
                                NombreComercial = componente.nombreComercial,
                                Volumen = componente.volumen,
                                NombreBulk = componente.nombreBulk
                            };

                            compoponentes.Add(estrategiaTono);
                        }

                        estrategia.EstrategiaProducto = compoponentes.ToArray();

                        estrategias.Add(estrategia);
                    }
                    else
                    {
                        listaCuvPrecio0.Add(estrategia.CUV2);
                        codTipoEstrategia = estrategia.CodigoTipoEstrategia;
                        codCampania = estrategia.CampaniaID.ToString();
                    }
                }
                catch (Exception ex)
                {
                    Common.LogManager.SaveLog(ex, "", codigoISO);
                }
            }

            if (listaCuvPrecio0.Any())
            {
                var logPrecio0 = string.Format("Log Precios0 => Fecha:{0} /Palanca:{1} /CodCampania:{2} /CUV(s):{3} /Referencia:{4}", DateTime.Now, codTipoEstrategia, codCampania, string.Join("|", listaCuvPrecio0), path);
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
            var paisHabilitado = WebConfig.PaisesMicroservicioPersonalizacion.Contains(pais);
            var tipoEstrategiaHabilitado = WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion.Contains(tipoEstrategia);
            return paisHabilitado && tipoEstrategiaHabilitado;
        }

        public bool UsarMsPersonalizacion(string tipoEstrategia)
        {
            var tipoEstrategiaHabilitado = WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion.Contains(tipoEstrategia);
            return tipoEstrategiaHabilitado;
        }
    }
}