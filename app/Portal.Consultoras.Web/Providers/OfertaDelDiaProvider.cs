using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
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
    public class OfertaDelDiaProvider:OfertaBaseProvider
    {
        private readonly ILogManager logManager = LogManager.LogManager.Instance;
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        private readonly static HttpClient httpClient = new HttpClient();
        static OfertaDelDiaProvider()
        {
            httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public OfertaDelDiaModel ObtenerOfertas()
        {
            OfertaDelDiaModel model = null;

            var userData = sessionManager.GetUserData();

            try
            {
                if (userData.TipoUsuario != Constantes.TipoUsuario.Consultora)
                    return null;

                if (!sessionManager.GetFlagOfertaDelDia())
                    return null;

                var paisHabilitado = WebConfig.PaisesMicroservicioPersonalizacion.Contains(userData.CodigoISO);

                if (paisHabilitado)
                {
                    var taskApi = Task.Run(() => ObtenerOfertasDelDiaDesdeApi(userData.CodigoISO, userData.CampaniaID, userData.CodigoConsultora, userData.FechaInicioCampania));

                    Task.WhenAll(taskApi);

                    var listOfertasDelDias = taskApi.Result;

                    model = ObtenerOfertaDelDiaModel(userData.PaisID, userData.CodigoISO, listOfertasDelDias);
                }
                else
                {
                    var ofertasDelDia = sessionManager.GetOfertasDelDia();

                    if (ofertasDelDia == null)
                    {
                        var listOfertasDelDias = ObtenerOfertasDelDiaDesdeSoap(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, userData.FechaInicioCampania);

                        model = ObtenerOfertaDelDiaModel(userData.PaisID, userData.CodigoISO, listOfertasDelDias);

                        sessionManager.SetOfertasDelDia(model);
                    }
                }

                if (model != null)
                {
                    model.TeQuedan = CountdownODD(userData.PaisID, userData.EsDiasFacturacion, userData.HoraCierreZonaNormal);

                    sessionManager.SetFlagOfertaDelDia(1);
                }
                else
                {
                    sessionManager.SetFlagOfertaDelDia(0);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.CodigoISO, "OfertaDelDiaProvider.ObtenerOfertas");
            }

            return model;
        }

        private List<BEEstrategia> ObtenerOfertasDelDiaDesdeSoap(int paisId, int campaniaId, string codigoConsultora, DateTime fechaInicioCampania)
        {
            BEEstrategia[] estrategias = null;
            using (var svc = new PedidoServiceClient())
            {
                estrategias = svc.GetEstrategiaODD(paisId, campaniaId, codigoConsultora, fechaInicioCampania.Date);
            }
            return estrategias.ToList();
        }

        private async Task<List<BEEstrategia>> ObtenerOfertasDelDiaDesdeApi(string paisIso, int campaniaId, string codigoConsultora, DateTime fechaInicioCampania)
        {
            var estrategias = new List<BEEstrategia>();

            var diaInicio = DateTime.Now.Date.Subtract(fechaInicioCampania.Date).Days;

            var path = string.Format("api/Oferta/{0}/ODD/{1}/{2}/{3}", paisIso, campaniaId, codigoConsultora, diaInicio);

            var httpResponse = await httpClient.GetAsync(path);

            if (httpResponse.IsSuccessStatusCode)
            {
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                foreach (var item in list)
                {
                    var estrategia = new BEEstrategia
                    {
                        EstrategiaID = Convert.ToInt32(item.estrategiaId),
                        CodigoEstrategia = item.codigoEstrategia,
                        CUV2 = item.cuV2,
                        DescripcionCUV2 = item.descripcionCUV2,
                        Precio = Convert.ToDecimal(item.precio),
                        Precio2 = Convert.ToDecimal(item.precio2),
                        FotoProducto01 = item.imagenURL,
                        ImagenURL = item.imagenEstrategia,
                        LimiteVenta = Convert.ToInt32(item.limiteVenta),
                        TextoLibre = item.textoLibre,
                        MarcaID = Convert.ToInt32(item.marcaId),
                        DescripcionMarca = item.marcaDescripcion,
                        IndicadorMontoMinimo = Convert.ToInt32(item.indicadorMontoMinimo),
                        CodigoProducto = item.codigoProducto,
                        DescripcionEstrategia = item.descripcionTipoEstrategia,
                        Orden = Convert.ToInt32(item.orden),
                        TipoEstrategiaID = Convert.ToInt32(item.tipoEstrategiaId),
                        FlagNueva = 0,
                        TipoEstrategiaImagenMostrar = 6
                    };

                    estrategias.Add(estrategia);
                }
            }

            return estrategias;
        }

        private OfertaDelDiaModel ObtenerOfertaDelDiaModel(int paisId, string codigoIso, List<BEEstrategia> ofertasDelDia)
        {
            OfertaDelDiaModel model = null;

            if (!ofertasDelDia.Any())
                return null;

            var personalizacionesOfertaDelDia = ObtenerPersonalizacionesOfertaDelDia(paisId);
            if (!personalizacionesOfertaDelDia.Any())
                return null;

            ofertasDelDia = ofertasDelDia.OrderBy(odd => odd.Orden).ToList();

            var tablaLogica9301 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9301) ?? new BETablaLogicaDatos();
            var tablaLogica9302 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9302) ?? new BETablaLogicaDatos();

            var contOdd = 0;
            short posicion = 1;
            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;
            var ofertasDelDiaModel = new List<OfertaDelDiaModel>();

            foreach (var oferta in ofertasDelDia)
            {
                if (!string.IsNullOrEmpty(oferta.ImagenURL))
                {
                    oferta.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, oferta.ImagenURL, carpetaPais);
                }

                if (!string.IsNullOrEmpty(oferta.FotoProducto01))
                {
                    oferta.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, oferta.FotoProducto01, carpetaPais);
                }

                oferta.URLCompartir = Util.GetUrlCompartirFB(codigoIso);

                var oddModel = new OfertaDelDiaModel
                {
                    ID = contOdd++,
                    Position = posicion++,
                    CodigoIso = codigoIso,
                    TipoEstrategiaID = oferta.TipoEstrategiaID,
                    EstrategiaID = oferta.EstrategiaID,
                    CUV2 = oferta.CUV2,
                    MarcaID = oferta.MarcaID,
                    DescripcionMarca = oferta.DescripcionMarca,
                    TipoEstrategiaDescripcion = oferta.DescripcionEstrategia,
                    LimiteVenta = oferta.LimiteVenta,
                    IndicadorMontoMinimo = oferta.IndicadorMontoMinimo,
                    TipoEstrategiaImagenMostrar = oferta.TipoEstrategiaImagenMostrar,
                    ImagenFondo1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"), codigoIso),
                    ColorFondo1 = tablaLogica9301.Codigo ?? string.Empty,
                    ImagenBanner = oferta.FotoProducto01,
                    ImagenSoloHoy = ObtenerUrlImagenOfertaDelDia(codigoIso, ofertasDelDia.Count),
                    ImagenFondo2 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"), codigoIso),
                    ColorFondo2 = tablaLogica9302.Codigo ?? string.Empty,
                    ImagenDisplay = oferta.FotoProducto01,
                    NombreOferta = ObtenerNombreOfertaDelDia(oferta.DescripcionCUV2),
                    DescripcionOferta = ObtenerDescripcionOfertaDelDia(oferta.DescripcionCUV2),
                    PrecioOferta = oferta.Precio2,
                    PrecioCatalogo = oferta.Precio,
                    TieneOfertaDelDia = true,
                    Orden = oferta.Orden
                };

                ofertasDelDiaModel.Add(oddModel);
            }

            model = ofertasDelDiaModel.First().Clone();

            model.ListaOfertas = ofertasDelDiaModel;

            return model;
        }

        private List<BETablaLogicaDatos> ObtenerPersonalizacionesOfertaDelDia(int paisId)
        {
            BETablaLogicaDatos[] personalizacionesOfertaDelDia = null;

            using (var svc = new SACServiceClient())
            {
                personalizacionesOfertaDelDia = svc.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.PersonalizacionODD);
            }

            return personalizacionesOfertaDelDia.ToList();
        }

        private TimeSpan CountdownODD(int paisId, bool esDiasFacturacion, TimeSpan horaCierreZonaNormal)
        {
            DateTime hoy;
            DateTime d2;
            using (var svc = new SACServiceClient())
            {
                hoy = svc.GetFechaHoraPais(paisId);
            }
            var d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);

            if (esDiasFacturacion)
            {
                var t1 = horaCierreZonaNormal;
                d2 = new DateTime(hoy.Year, hoy.Month, hoy.Day, t1.Hours, t1.Minutes, t1.Seconds);
            }
            else
            {
                d2 = d1.AddDays(1);
            }
            var t2 = (d2 - hoy);
            return t2;
        }

        private string ObtenerUrlImagenOfertaDelDia(string codigoIso, int cantidadOfertas)
        {
            var imgSh = string.Format(ConfigurationManager.AppSettings.Get("UrlImgSoloHoyODD"), codigoIso);
            var exte = imgSh.Split('.')[imgSh.Split('.').Length - 1];
            imgSh = imgSh.Substring(0, imgSh.Length - exte.Length - 1) + (cantidadOfertas > 1 ? "s" : "") + "." + exte;
            return imgSh;
        }

        private string ObtenerNombreOfertaDelDia(string descripcionCuv2)
        {
            var nombreOferta = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                nombreOferta = descripcionCuv2.Split('|').First();
            }

            return nombreOferta;
        }

        private string ObtenerDescripcionOfertaDelDia(string descripcionCuv2)
        {
            var descripcionOdd = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                var temp = descripcionCuv2.Split('|').ToList();
                temp = temp.Skip(1).ToList();

                var txtBuil = new StringBuilder();
                foreach (var item in temp)
                {
                    if (!string.IsNullOrEmpty(item))
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

    }
}