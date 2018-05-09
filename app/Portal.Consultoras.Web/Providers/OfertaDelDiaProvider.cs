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
    public class OfertaDelDiaProvider
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

        private async Task<string> respSBMicroservicios(string jsonParametros, string requestUrlParam, string responseType, UsuarioModel userData)
        {
            using (var client = new HttpClient())
            {
                string url = WebConfig.UrlMicroservicioPersonalizacionSearch;
                client.BaseAddress = new Uri(url);
                string jsonString = jsonParametros;

                string contentType = "application/json";

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

                if (!response.IsSuccessStatusCode)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("OfertaDelDiaProvider_respSBMicroservicios:" + response.StatusCode.ToString()), userData.CodigoConsultora, userData.CodigoISO);
                    return "";
                }
                var content = await response.Content.ReadAsStringAsync();

                if (string.IsNullOrEmpty(content))
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("OfertaDelDiaProvider_respSBMicroservicios: Null content"), userData.CodigoConsultora, userData.CodigoISO);
                    return "";
                }
                return content;
            }
        }

        public int CargarWebApi(List<string> EstrtegiasIds, string pais)
        {
            int iCantidadActualizada = 0;
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = JsonConvert.SerializeObject(EstrtegiasIds);
            string requestUrl = "estrategia/cargar?pais=" + pais;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return 0;
            }
            iCantidadActualizada = content.Equals("true") ? 1 : 0;
            return iCantidadActualizada;
        }

        public Dictionary<string, int> GetCantidadOfertasParaTiWebApi(string tipoCodigo, int campania, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            Dictionary<string, int> iCantidadOfertas = new Dictionary<string, int>();
            iCantidadOfertas.Add("EC", -1);
            iCantidadOfertas.Add("EF", -1);
            string requestUrl = "estrategia/contar";
            string jsonParameters = "?tipo=" + tipoCodigo + "&campania=" + campania.ToString() + "&pais=" + pais;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return iCantidadOfertas;
            }
            iCantidadOfertas = JsonConvert.DeserializeObject<Dictionary<string, int>>(content);
            return iCantidadOfertas;
        }

        private List<EstrategiaMDbAdapterModel> setEstrategiaList(List<WaEstrategiaModel> WaModelList)
        {
            List<EstrategiaMDbAdapterModel> mapList = WaModelList.Select(d =>
                new EstrategiaMDbAdapterModel
                {
                    _id = d._id,
                    FlagConfig = d.FlagConfig,
                    BEEstrategia = new BEEstrategia
                    {
                        EstrategiaID = d.EstrategiaId,
                        CampaniaID = int.Parse(d.CodigoCampania),
                        Activo = d.Activo ? 1 : 0,
                        ImagenURL = d.ImagenURL,
                        LimiteVenta = d.LimiteVenta,
                        DescripcionCUV2 = d.DescripcionCUV2,
                        Precio = (decimal)d.Precio,
                        CUV2 = d.CUV2,
                        Orden = d.Orden,
                        FlagNueva = d.FlagNueva ? 1 : 0,
                        CodigoEstrategia = d.CodigoEstrategia,
                        CodigoTipoEstrategia = d.CodigoTipoEstrategia,
                        CodigoProducto = d.CodigoProducto,
                        IndicadorMontoMinimo = d.IndicadorMontoMinimo ? 1 : 0,
                        MarcaID = d.MarcaId,
                        DescripcionMarca = d.MarcaDescripcion,
                        UsuarioCreacion = d.UsuarioCreacion,
                        UsuarioModificacion = d.UsuarioModificacion,
                        ImagenMiniaturaURL = "",
                        TipoEstrategiaID = d.TipoEstrategiaId,
                        Imagen = d.FlagImagenURL ? 1 : 0,
                        DescripcionEstrategia = d.DescripcionTipoEstrategia,
                        CodigoSAP = d.CodigoSap,
                        Zona = d.Zona
                    }

                }).ToList();
            return mapList;
        }


        public List<EstrategiaMDbAdapterModel> ListarWebApi(string CampaniaID, string tipoEstrategiaCodigo, string Pais, int Activo = -1, string CUV2 = "", int Imagen = -1)
        {
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "?pais=" + Pais;
            if (Activo != -1)
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "status=" + (Activo == -1 ? "" : Activo == 1 ? "true" : "false");
            }
            if (!string.IsNullOrEmpty(CUV2.Trim()) && !CUV2.Equals("0"))
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "cuv=" + CUV2;
            }
            if (Imagen != -1)
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "tieneImagen=" + (Imagen == -1 ? "" : Imagen == 1 ? "true" : "false");
            }
            var userData = sessionManager.GetUserData();
            //entidad.Imagen
            string requestUrl = "estrategia/listar/" + CampaniaID + "/" + tipoEstrategiaCodigo;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var WaModelList = JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(content);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.setEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public List<EstrategiaMDbAdapterModel> preCargarWebApi(string campaniaId, string tipoEstrategiaCodigo, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "?pais=" + Pais;

            //entidad.Imagen
            string requestUrl = "estrategia/precargar/" + campaniaId + "/" + tipoEstrategiaCodigo;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var WaModelList = JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(content);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.setEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public List<EstrategiaMDbAdapterModel> FiltrarEstrategia(string _id, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = _id + "?pais=" + Pais;
            string requestUrl = "estrategia/";
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var WaObject = JsonConvert.DeserializeObject<WaEstrategiaModel>(content);
            var WaModelList = new List<WaEstrategiaModel>();
            WaModelList.Add(WaObject);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.setEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public string RegistrarWebApi(BEEstrategia entidad, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = "estrategia/registrar?pais=" + Pais;
            WaEstrategiaModel waModel = getEstrategiaWa(entidad, "");
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "post",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }

        public string EditarWebApi(BEEstrategia entidad, string _mongoId, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = "estrategia/editar?pais=" + Pais;
            WaEstrategiaModel waModel = getEstrategiaWa(entidad, _mongoId);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }

        private WaEstrategiaModel getEstrategiaWa(BEEstrategia entidad, string _id)
        {
            WaEstrategiaModel waModel = new WaEstrategiaModel
            {
                _id = _id,
                EstrategiaId = entidad.EstrategiaID,
                CodigoCampania = entidad.CampaniaID.ToString(),
                Activo = entidad.Activo == 1 ? true : false,
                ImagenURL = entidad.ImagenURL,
                LimiteVenta = entidad.LimiteVenta,
                DescripcionCUV2 = entidad.DescripcionCUV2,
                Precio = (float)entidad.Precio,
                CUV2 = entidad.CUV2,
                Precio2 = (float)entidad.Precio2,
                TextoLibre = entidad.TextoLibre,
                Orden = entidad.Orden,
                FlagNueva = entidad.FlagNueva == 1 ? true : false,
                CodigoEstrategia = entidad.CodigoEstrategia,
                Ganancia = (float)entidad.Ganancia,
                FlagImagenURL = entidad.Imagen == 1 ? true : false,
                FlagActivo = entidad.Activo == 1 ? true : false,
                CodigoTipoEstrategia = entidad.CodigoTipoEstrategia,
                CodigoProducto = entidad.CodigoProducto,
                IndicadorMontoMinimo = entidad.IndicadorMontoMinimo == 1 ? true : false,
                MarcaId = entidad.MarcaID,
                MarcaDescripcion = entidad.DescripcionMarca,
                CodigoSap = entidad.CodigoSAP,
                UsuarioCreacion = entidad.UsuarioCreacion,
                UsuarioModificacion = entidad.UsuarioModificacion,
                TipoEstrategiaId = entidad.TipoEstrategiaID,
                TipoEstrategia = entidad.CodigoTipoEstrategia.Equals("009") ? "ODD" : "",
                DescripcionTipoEstrategia = entidad.DescripcionEstrategia,
                Zona = entidad.Zona
            };
            return waModel;
        }

        private WaTipoEstrategia getTipoEstrategiaWa(BETipoEstrategia tipoEstrategia)
        {
            WaTipoEstrategia tipoEstrategiaWa = new WaTipoEstrategia
            {
                TipoEstrategiaId = tipoEstrategia.TipoEstrategiaID,
                DescripcionTipoEstrategia = tipoEstrategia.DescripcionEstrategia,
                CodigoTipoEstrategia = tipoEstrategia.Codigo,
                ImagenEstrategia = tipoEstrategia.ImagenEstrategia,
                Orden = tipoEstrategia.Orden,
                FlagActivo = tipoEstrategia.FlagActivo == 1 ? true:false,
                FlagNueva = tipoEstrategia.FlagNueva == 1 ?  true:false,
                FlagRecoProduc = tipoEstrategia.FlagRecoProduc == 1 ? true:false,
                FlagRecoPerfil = tipoEstrategia.FlagRecoPerfil == 1 ? true:false,
                CodigoPrograma = tipoEstrategia.CodigoPrograma,
                OfertaId = tipoEstrategia.OfertaID,
                FlagMostrarImg = tipoEstrategia.FlagMostrarImg == 1 ? true:false,
                MostrarImgOfertaIndependiente = tipoEstrategia.MostrarImgOfertaIndependiente,
                ImagenOfertaIndependiente = tipoEstrategia.ImagenOfertaIndependiente,
                Codigo = tipoEstrategia.Codigo,
                FlagValidarImagen = tipoEstrategia.FlagValidarImagen == 1 ? true:false,
                PesoMaximoImagen = tipoEstrategia.PesoMaximoImagen,
                UsuarioCreacion = tipoEstrategia.UsuarioRegistro,
                UsuarioModificacion = tipoEstrategia.UsuarioModificacion                
            };
            return tipoEstrategiaWa;
        }


        public bool desactivarWebApi(string _id, string usuario, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            bool bDeshabilitado = true;
            string jsonParameters = "";
            string requestUrl = "estrategia/desactivar/" + _id + "?usuario=" + usuario + "&pais=" + Pais;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return false;
            }
            bDeshabilitado = content.Equals("true");
            return bDeshabilitado;
        }

        public bool ActivarDesactivarEstrategias(List<string> estrategiasActivas, List<string> estrategiasInactivas, string usuario, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            bool activarResponse = true; bool inactivarResponse = true;
            string jsonParametersActivas = JsonConvert.SerializeObject(estrategiasActivas);
            string requestUrl = "estrategia/activar?usuario=" + usuario + "&pais=" + Pais;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParametersActivas, requestUrl, "put",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                activarResponse = false;
            }
            activarResponse = content.Equals("true");
            content = "";
            //
            string jsonParametersInactivas = JsonConvert.SerializeObject(estrategiasInactivas);
            string requestUrlInactivar = "estrategia/desactivar?usuario=" + usuario + "&pais=" + Pais;
            taskApi = Task.Run(() => respSBMicroservicios(jsonParametersInactivas, requestUrlInactivar, "put",userData));
            Task.WhenAll(taskApi);
            content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                inactivarResponse = false;
            }
            inactivarResponse = content.Equals("true");

            return activarResponse || activarResponse;
        }

        public Dictionary<string, object> getEstrategiaCuv(string cuv, string campania, string tipoEstrategia, string pais, string prod, string perfil)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = "?pais=" + pais + "&prod=" + prod + "&perfil=" + perfil;
            string requestUrl = "estrategia/cuv/" + campania + "/" + tipoEstrategia + "/" + cuv;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            Dictionary<string, object> resultDictionary = new Dictionary<string, object>();
            resultDictionary.Add("result", null);
            resultDictionary.Add("mensaje", "No se pudo obtener datos");
            resultDictionary.Add("success", false);

            if (!string.IsNullOrEmpty(content))
            {
                resultDictionary = JsonConvert.DeserializeObject<Dictionary<string, object>>(content);
                if (resultDictionary["result"] != null)
                {
                    WaEstrategiaModel waModel = JsonConvert.DeserializeObject<WaEstrategiaModel>(resultDictionary["result"].ToString());
                    List<WaEstrategiaModel> waModelList = new List<WaEstrategiaModel>();
                    waModelList.Add(waModel);
                    List<EstrategiaMDbAdapterModel> estrategiaAdapterList = setEstrategiaList(waModelList);
                    resultDictionary["result"] = estrategiaAdapterList[0].BEEstrategia;
                }
            }
            return resultDictionary;
        }

        public List<DescripcionEstrategiaModel> uploadCsv(List<BEDescripcionEstrategia> descripcionEstrategiaLista, string Pais)
        {
            var descripcionEstrategiaListaWA = descripcionEstrategiaLista.Select(d => new
            {
                d.Cuv,
                d.Descripcion,
                d.Estado
            }).ToList();
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = JsonConvert.SerializeObject(descripcionEstrategiaListaWA);
            string requestUrl = "estrategia/actualizar?pais=" + Pais;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put",userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            Dictionary<string, object> resultDictionary = new Dictionary<string, object>();
            resultDictionary.Add("result", null);
            resultDictionary.Add("mensaje", "No se pudo obtener datos");
            resultDictionary.Add("success", false);
            List<DescripcionEstrategiaModel> descripcionList = new List<DescripcionEstrategiaModel>();
            if (!string.IsNullOrEmpty(content))
            {
                resultDictionary = JsonConvert.DeserializeObject<Dictionary<string, object>>(content);
                if (resultDictionary["result"] != null)
                {
                    var descripcionEstrategiaList = JsonConvert.DeserializeObject<List<dynamic>>(resultDictionary["result"].ToString());

                    List<DescripcionEstrategiaModel> estrategiaDescripcionList = descripcionEstrategiaList.Select(d =>
                        new DescripcionEstrategiaModel
                        {
                            Cuv = d.cuv,
                            Descripcion = d.descripcion,
                            Estado = (bool)d.estado ? 1 : 0
                        }
                    ).ToList();
                    descripcionList.AddRange(estrategiaDescripcionList);
                }
            }
            return descripcionList;
        }

        public string RegistrarTipoEstrategiaWebApi(BETipoEstrategia entidad, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = "tipo/registrar?pais=" + Pais;
            WaTipoEstrategia waModel = getTipoEstrategiaWa(entidad);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }

        public string EditarTipoEstrategiaWebApi(BETipoEstrategia entidad, string Pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = "tipo/editar?pais=" + Pais;
            WaTipoEstrategia waModel = getTipoEstrategiaWa(entidad);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }

    }
}