﻿using Newtonsoft.Json;
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

        public UsuarioModel userData { get; set; }

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
                    var taskApi = Task.Run(() => ObtenerOfertasDelDiaDesdeApi(userData.CampaniaID, userData.CodigoConsultora, userData.FechaInicioCampania));

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

        private async Task<List<BEEstrategia>> ObtenerOfertasDelDiaDesdeApi(int campaniaId, string codigoConsultora, DateTime fechaInicioCampania)
        {
            var estrategias = new List<BEEstrategia>();

            var diaInicio = DateTime.Now.Date.Subtract(fechaInicioCampania.Date).Days;

            var path = string.Format("api/Oferta/ODD/{0}/{1}/{2}", campaniaId, codigoConsultora, diaInicio);

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

        private async Task<string> respSBMicroservicios(string jsonParametros, string requestUrlParam, string responseType)
        {
            using (var client = new HttpClient())
            {
                string url =WebConfig.UrlMicroservicioPersonalizacionSearch;
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
                    Dictionary<string, string> jsonValue = new Dictionary<string, string>
                    {
                        {"jsonValue",jsonString }
                    };
                    var encodedContent = new FormUrlEncodedContent(jsonValue);
                    response = await client.PostAsync(requestUrl, encodedContent);
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

        public int CargarWebApi(List<string> EstrtegiasIds)
        {
            int iCantidadActualizada = 0;
            string jsonParameters = JsonConvert.SerializeObject(EstrtegiasIds);
            string requestUrl = "estrategia/cargar/";
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put"));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return 0;
            }
            iCantidadActualizada = content.Equals("true")?1:0;
            return iCantidadActualizada;
        }

        public Dictionary<string,int> GetCantidadOfertasParaTiWebApi(string tipoCodigo, int campania)
        {
            Dictionary<string,int> iCantidadOfertas = new Dictionary<string,int>();
            iCantidadOfertas.Add("EC", -1);
            iCantidadOfertas.Add("EF", -1);
            string requestUrl = "estrategia/contar";
            string jsonParameters = "?tipo=" + tipoCodigo + "&campania=" + campania.ToString();
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get"));
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
                        Imagen = d.FlagImagenURL ? 1:0,
                    }

                }).ToList();
            return mapList;
        }


        public List<EstrategiaMDbAdapterModel> ListarWebApi(string CampaniaID,string tipoEstrategiaCodigo,int Activo = -1, string CUV2="",int Imagen=-1)
        {
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "?";
            if (Activo != -1)
            {
                jsonParameters += "status=" + (Activo == -1 ? "" : Activo == 1 ? "true" : "false");
            }
            if (!string.IsNullOrEmpty(CUV2.Trim()) && !CUV2.Equals("0"))
            {
                jsonParameters += jsonParameters.Length > 1 ? "&": "";
                jsonParameters += "cuv=" + CUV2;
            }
            if (Imagen != -1)
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "tieneImagen=" + (Imagen == -1 ? "" : Imagen == 1 ? "true" : "false");
            }
            
            //entidad.Imagen
            string requestUrl = "estrategia/listar/"+CampaniaID+"/"+ tipoEstrategiaCodigo;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get"));
            Task.WhenAll(taskApi);
            string content = taskApi.Result ;
            var WaModelList = JsonConvert.DeserializeObject <List<WaEstrategiaModel>> (content);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.setEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public List<EstrategiaMDbAdapterModel> preCargarWebApi(string campaniaId, string tipoEstrategiaCodigo)
        {
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "";
            
            //entidad.Imagen
            string requestUrl = "estrategia/precargar/" + campaniaId + "/" + tipoEstrategiaCodigo;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get"));
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

        public List<EstrategiaMDbAdapterModel>FiltrarEstrategia(string _id)
        {
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = _id;
            string requestUrl = "estrategia/";
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "get"));
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



        public string InsertarEstrategiWebApi(BEEstrategia entidad)
        {
            string requestUrl = "";
            var waModel = new 
            {
                CodigoCampania = entidad.CampaniaID.ToString(),
                CodigoCampaniaFin = entidad.CampaniaIDFin.ToString(),
                entidad.NumeroPedido,
                Activo = entidad.Activo == 1 ? true : false,
                entidad.ImagenURL,
                entidad.LimiteVenta,
                entidad.DescripcionCUV2,
                FlagDescripcion = entidad.FlagDescripcion == 1 ? true : false,
                CUV = entidad.CUV1,
                EtiquetaId = entidad.EtiquetaID,
                Precio = (float)entidad.Precio,
                FlagCep = entidad.FlagCEP == 1 ? true : false,
                entidad.CUV2,
                EtiquetaId2 = entidad.EtiquetaID2,
                entidad.Precio2,
                FlagCep2 = entidad.FlagCEP2 == 1 ? true : false,
                entidad.TextoLibre,
                FlagTextoLibre = entidad.FlagTextoLibre == 1 ? true : false,
                entidad.Cantidad,
                FlagCantidad = entidad.FlagCantidad == 1 ? true : false,
                entidad.Zona,
                entidad.Orden,
                FlagNueva = entidad.FlagNueva == 1 ? true : false,
                entidad.ColorFondo,
                FlagEstrella = entidad.FlagEstrella == 1 ? true : false,
                entidad.CodigoEstrategia,
                TieneVariedad = entidad.TieneVariedad == 1 ? true : false,
                entidad.EsOfertaIndependiente,
                entidad.PrecioPublico,
                entidad.Ganancia,
                entidad.CodigoPrograma,
                FlagImagenUrl = entidad.Imagen == 1 ? true : false,
                entidad.CodigoConcurso,
                ImagenMiniaturaUrl = entidad.ImagenMiniaturaURL,
                EsSubCampania = entidad.EsSubCampania == 1 ? true : false,
                FlagActivo = entidad.Activo == 1 ? true:false,
                FlagMostrarImg = entidad.FlagMostrarImg == 1 ? true : false,
                entidad.CodigoTipoEstrategia,
                entidad.CodigoProducto,
                IndicadorMontoMinimo = entidad.IndicadorMontoMinimo == 1 ? true : false,
                MarcaId = entidad.MarcaID,
                MarcaDescripcion = entidad.DescripcionMarca,
                MatrizComercialId = entidad.IdMatrizComercial,
                CodigoSap = entidad.CodigoSAP,
                entidad.UsuarioCreacion,
                entidad.UsuarioModificacion
            };
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "post"));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }

        public bool desactivarWebApi(string _id,string usuario)
        {
            bool bDeshabilitado = true;
            string jsonParameters = "{\"usuario\":" + usuario + "}";
            string requestUrl = "estrategia/desactivar/" + _id;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParameters, requestUrl, "put"));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return false;
            }
            bDeshabilitado = content.Equals("true");
            return bDeshabilitado;
        }

        public bool ActivarDesactivarEstrategias(List<string>estrategiasActivas, List<string>estrategiasInactivas, string usuario)
        {
            bool activarResponse = true;bool inactivarResponse = true;
            string jsonParametersActivas = JsonConvert.SerializeObject(estrategiasActivas);
            string requestUrl = "estrategia/activar?usuario="+ usuario;
            var taskApi = Task.Run(() => respSBMicroservicios(jsonParametersActivas, requestUrl, "put"));
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
            string requestUrlInactivar = "estrategia/desactivar?usuario="+ usuario;
            taskApi = Task.Run(() => respSBMicroservicios(jsonParametersInactivas, requestUrlInactivar, "put"));
            Task.WhenAll(taskApi);
            content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                inactivarResponse = false;
            }
            inactivarResponse = content.Equals("true");

            return activarResponse || activarResponse;
        }
    }
}