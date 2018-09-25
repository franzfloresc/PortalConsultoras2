using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Response;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class AdministrarEstrategiaProvider
    {
        private readonly static HttpClient httpClientMicroservicioSync = new HttpClient();

        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;

        static AdministrarEstrategiaProvider()
        {
            if (!string.IsNullOrEmpty(WebConfig.UrlMicroservicioPersonalizacionSync))
            {
                httpClientMicroservicioSync.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSync);
                httpClientMicroservicioSync.DefaultRequestHeaders.Accept.Clear();
                httpClientMicroservicioSync.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            }
        }

        private static async Task<string> RespSBMicroservicios(string jsonParametros, string requestUrlParam, string responseType, UsuarioModel userData)
        {
            using (var client = new HttpClient())
            {
                string url = WebConfig.UrlMicroservicioPersonalizacionConfig;
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
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("OfertaDelDiaProvider_respSBMicroservicios:" + response.StatusCode.ToString()), userData.CodigoConsultora, userData.CodigoISO);
                    return "";
                }

                if (response != null)
                {
                    var content = await response.Content.ReadAsStringAsync();

                    if (string.IsNullOrEmpty(content))
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(new Exception("OfertaDelDiaProvider_respSBMicroservicios: Null content"), userData.CodigoConsultora, userData.CodigoISO);
                        return "";
                    }
                    return content;
                }
            }
            return "";
        }

        public Dictionary<string, List<string>> CargarEstrategia(List<string> estrategiasIds, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            Dictionary<string, List<string>> irespuesta = new Dictionary<string, List<string>>();
            string jsonParameters = JsonConvert.SerializeObject(estrategiasIds);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlCargarWebApi, pais,userData.UsuarioNombre);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return irespuesta;
            }
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            List<string> listaOK = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<string>>((((Newtonsoft.Json.Linq.JContainer)respuesta.Result).First).First.ToString()) : new List<string>();
            List<string> listaERROR = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<string>>((((Newtonsoft.Json.Linq.JContainer)respuesta.Result).Last).First.ToString()) : new List<string>();
            irespuesta.Add("CUVOK", listaOK);
            irespuesta.Add("CUVERROR", listaERROR);
            return irespuesta;
        }

        public Dictionary<string, int> ObtenerCantidadOfertasParaTi(string tipoCodigo, int campania, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            Dictionary<string, int> iCantidadOfertas = new Dictionary<string, int> { { "CUV_ZE", -1 }, { "CUV_OP", -1 } };
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlCantidadOfertas, pais, tipoCodigo, campania);
            
            var taskApi = Task.Run(() => RespSBMicroservicios("", requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return iCantidadOfertas;
            }

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (respuesta.Result != null)
                iCantidadOfertas = JsonConvert.DeserializeObject<Dictionary<string, int>>(respuesta.Result.ToString());

            return iCantidadOfertas;
        }

        private static List<EstrategiaMDbAdapterModel> EstablecerEstrategiaList(IEnumerable<WaEstrategiaModel> waModelList)
        {
            List<EstrategiaMDbAdapterModel> mapList = waModelList.Select(d =>
                new EstrategiaMDbAdapterModel
                {
                    _id = d._id,
                    FlagConfig = d.FlagConfig,
                    BEEstrategia = new ServicePedido.BEEstrategia
                    {
                        EstrategiaID = d.EstrategiaId,
                        CampaniaID = int.Parse(d.CodigoCampania),
                        Activo = d.Activo ? 1 : 0,
                        ImagenURL = d.ImagenURL,
                        LimiteVenta = d.LimiteVenta,
                        DescripcionCUV2 = d.DescripcionCUV2,
                        Precio = (decimal)d.Precio,
                        Precio2 = (decimal)d.Precio2,
                        PrecioPublico = (decimal)d.PrecioPublico,
                        Ganancia = (decimal)d.Ganancia,
                        CUV2 = d.CUV2,
                        Orden = d.Orden,
                        FlagNueva = d.FlagNueva ? 1 : 0,
                        FlagEstrella = d.FlagEstrella ? 1 : 0,
                        CodigoEstrategia = d.CodigoEstrategia,
                        CodigoTipoEstrategia = d.CodigoTipoEstrategia,
                        TextoLibre = d.TextoLibre,
                        //cambiar por CodigoProducto cuando se corrija el servicio
                        CodigoProducto = string.IsNullOrEmpty(d.CodigoSap) ? d.CodigoProducto : d.CodigoSap,
                        IndicadorMontoMinimo = d.IndicadorMontoMinimo ? 1 : 0,
                        IdMatrizComercial = d.MatrizComercialId,
                        MarcaID = d.MarcaId,
                        DescripcionMarca = d.MarcaDescripcion,
                        UsuarioCreacion = d.UsuarioCreacion,
                        UsuarioModificacion = d.UsuarioModificacion,
                        ImagenMiniaturaURL = d.ImagenMiniatura ?? string.Empty,
                        TipoEstrategiaID = d.TipoEstrategiaId,
                        Imagen = d.FlagImagenURL ? 1 : 0,
                        DescripcionEstrategia = d.DescripcionTipoEstrategia,                    
                        CodigoSAP = string.IsNullOrEmpty(d.CodigoSap) ? d.CodigoProducto : d.CodigoSap,
                        Zona = d.Zona,
                        EsSubCampania = d.EsSubCampania.HasValue ? (d.EsSubCampania.Value ? 1 : 0) : 0
                    }

                }).ToList();
            return mapList;
        }

        public List<EstrategiaMDbAdapterModel> Listar(string campaniaID, string tipoEstrategiaCodigo, string pais, int activo = -1, string cuv2 = "", int imagen = -1)
        {
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "";
            if (activo != -1)
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "status=" + (activo == -1 ? "" : activo == 1 ? "true" : "false");
            }
            if (!string.IsNullOrEmpty(cuv2.Trim()) && !cuv2.Equals("0"))
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "cuv=" + cuv2;
            }
            if (imagen != -1)
            {
                jsonParameters += jsonParameters.Length > 1 ? "&" : "";
                jsonParameters += "tieneImagen=" + (imagen == -1 ? "" : imagen == 1 ? "true" : "false");
            }
            var userData = sessionManager.GetUserData();

            if (jsonParameters != string.Empty)
            {
                jsonParameters = string.Format("?{0}", jsonParameters);
            }
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlListarWebApi, pais, tipoEstrategiaCodigo, campaniaID);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;


            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            var WaModelList = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(respuesta.Result.ToString()) : new List<WaEstrategiaModel>();
            if (WaModelList.Any())
            {
                List<EstrategiaMDbAdapterModel> mapList = EstablecerEstrategiaList(WaModelList);

                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public List<string> PreCargar(string campaniaId, string tipoEstrategiaCodigo, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = string.Empty;

            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlPreCargarWebApi, pais, tipoEstrategiaCodigo, campaniaId);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            List<string> listaEstrategias = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<string>>(respuesta.Result.ToString()) : new List<string>();
            return listaEstrategias;
        }
        
        public List<EstrategiaMDbAdapterModel> FiltrarEstrategia(string id, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    string.Empty,
                    string.Format(Constantes.PersonalizacionOfertasService.UrlFiltrarEstrategia, pais, id), 
                    "get", 
                    userData
                ));

            Task.WhenAll(taskApi);;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(taskApi.Result);

            var WaObject = (respuesta.Result != null) ? JsonConvert.DeserializeObject<WaEstrategiaModel>(respuesta.Result.ToString()) : null;

            var WaModelList = new List<WaEstrategiaModel>();
            if (WaObject != null)
                WaModelList.Add(WaObject);
            if (WaModelList.Any())
            {
                List<EstrategiaMDbAdapterModel> mapList = EstablecerEstrategiaList(WaModelList);

                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public void RegistrarEstrategia(ServicePedido.BEEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlRegistrarWebApi, pais);
            WaEstrategiaModel waModel = ObtenerEstrategia(entidad, string.Empty);
            waModel.FechaCreacion = DateTime.Now;
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);
            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                throw new Exception(respuesta.Message);
            }
        }

        public void EditarEstrategia(ServicePedido.BEEstrategia entidad, string mongoId, string pais, string prod, string perfil)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEditarWebApi, pais,prod,perfil);
            WaEstrategiaModel waModel = ObtenerEstrategia(entidad, mongoId);
            waModel.FechaModificacion = DateTime.Now;
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);
            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                throw new Exception(respuesta.Message);
            }
        }

        private static WaEstrategiaModel ObtenerEstrategia(ServicePedido.BEEstrategia entidad, string id)
        {
            WaEstrategiaModel waModel = new WaEstrategiaModel
            {
                _id = id,
                EstrategiaId = entidad.EstrategiaID,
                CodigoCampania = entidad.CampaniaID.ToString(),
                Activo = entidad.Activo == 1,
                ImagenURL = entidad.ImagenURL,
                LimiteVenta = entidad.LimiteVenta,
                DescripcionCUV2 = entidad.DescripcionCUV2,
                Precio = (float)entidad.Precio,
                CUV2 = entidad.CUV2,
                Precio2 = (float)entidad.Precio2,
                TextoLibre = entidad.TextoLibre,
                Orden = entidad.Orden,
                FlagNueva = entidad.FlagNueva == 1,
                CodigoEstrategia = entidad.CodigoEstrategia,
                Ganancia = (float)entidad.Ganancia,
                FlagImagenURL = entidad.Imagen == 1,
                FlagActivo = entidad.Activo == 1,
                CodigoTipoEstrategia = entidad.CodigoTipoEstrategia,
                CodigoProducto = entidad.CodigoProducto,
                IndicadorMontoMinimo = entidad.IndicadorMontoMinimo == 1,
                MarcaId = entidad.MarcaID,
                MarcaDescripcion = entidad.DescripcionMarca,
                CodigoSap = entidad.CodigoSAP,
                UsuarioCreacion = entidad.UsuarioCreacion,
                UsuarioModificacion = entidad.UsuarioModificacion,
                TipoEstrategiaId = entidad.TipoEstrategiaID,
                FlagEstrella = entidad.FlagEstrella == 1,
                DescripcionTipoEstrategia = entidad.DescripcionEstrategia,
                MatrizComercialId = entidad.IdMatrizComercial,
                PrecioPublico = (float)entidad.PrecioPublico,
                Zona = entidad.Zona,
                EsSubCampania = entidad.EsSubCampania == 1 ? true : false,
                ImagenMiniatura = entidad.ImagenMiniaturaURL ?? string.Empty
            };
            return waModel;
        }

        private static WaTipoEstrategia ObtenerTipoEstrategia(ServicePedido.BETipoEstrategia tipoEstrategia)
        {
            WaTipoEstrategia tipoEstrategiaWa = new WaTipoEstrategia
            {
                TipoEstrategiaId = tipoEstrategia.TipoEstrategiaID,
                DescripcionTipoEstrategia = tipoEstrategia.DescripcionEstrategia,
                CodigoTipoEstrategia = tipoEstrategia.Codigo,
                ImagenEstrategia = tipoEstrategia.ImagenEstrategia,
                Orden = tipoEstrategia.Orden,
                FlagActivo = tipoEstrategia.FlagActivo == 1,
                FlagNueva = tipoEstrategia.FlagNueva == 1,
                FlagRecoProduc = tipoEstrategia.FlagRecoProduc == 1,
                FlagRecoPerfil = tipoEstrategia.FlagRecoPerfil == 1,
                CodigoPrograma = tipoEstrategia.CodigoPrograma,
                OfertaId = tipoEstrategia.OfertaID,
                FlagMostrarImg = tipoEstrategia.FlagMostrarImg == 1,
                MostrarImgOfertaIndependiente = tipoEstrategia.MostrarImgOfertaIndependiente,
                ImagenOfertaIndependiente = tipoEstrategia.ImagenOfertaIndependiente,
                Codigo = tipoEstrategia.Codigo,
                FlagValidarImagen = tipoEstrategia.FlagValidarImagen == 1,
                PesoMaximoImagen = tipoEstrategia.PesoMaximoImagen,
                UsuarioCreacion = tipoEstrategia.UsuarioRegistro,
                UsuarioModificacion = tipoEstrategia.UsuarioModificacion
            };
            return tipoEstrategiaWa;
        }

        public void DesactivarEstrategia(string id, string usuario, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            const string jsonParameters = "";
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlDesactivarWebApi, pais,id , usuario);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                throw new Exception(respuesta.Message);
            }
        }

        public bool ActivarDesactivarEstrategias(List<string> estrategiasActivas, List<string> estrategiasInactivas, string usuario, string pais, string tipo)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParametersActivas = JsonConvert.SerializeObject(estrategiasActivas);
            
            string jsonParametersInactivas = JsonConvert.SerializeObject(estrategiasInactivas);
            string parametros = "{activar:" + jsonParametersActivas + ", desactivar:" +jsonParametersInactivas+ ", usuario: \"" + usuario + "\"}";
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlActivarDesactivarEstrategias, pais,tipo);
            var taskApi = Task.Run(() => RespSBMicroservicios(parametros, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            bool result = !string.IsNullOrEmpty(content) && content.Contains(Constantes.EstadoRespuestaServicio.Success);

            return result;
        }

        public ServicePedido.BEEstrategia ObtenerEstrategiaCuv(string cuv, string campania, string tipoEstrategia, string pais, string prod, string perfil)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = "?prod=" + prod + "&perfil=" + perfil;
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEstrategiaCuv, pais, tipoEstrategia, campania, cuv);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);

            if (respuesta.Result != null)
            {
                WaEstrategiaModel waModel = JsonConvert.DeserializeObject<WaEstrategiaModel>(respuesta.Result.ToString());
                List<WaEstrategiaModel> waModelList = new List<WaEstrategiaModel> { waModel };
                List<EstrategiaMDbAdapterModel> estrategiaAdapterList = EstablecerEstrategiaList(waModelList);
                return estrategiaAdapterList[0].BEEstrategia;
            }
            return null;
        }

        public List<DescripcionEstrategiaModel> UploadCsv(List<BEDescripcionEstrategia> descripcionEstrategiaLista, string pais, string tipoCodigo, string campaniaId)
        {
            var descripcionEstrategiaListaWA = descripcionEstrategiaLista.Select(d => new
            {
                d.Cuv,
                d.Descripcion,
                d.Estado
            }).ToList();

            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = JsonConvert.SerializeObject(descripcionEstrategiaListaWA);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlUploadCsv, pais, tipoCodigo, campaniaId);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            List<DescripcionEstrategiaModel> descripcionList = new List<DescripcionEstrategiaModel>();

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                List<Dictionary<string, object>> resultDictionary = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(respuesta.Result.ToString());

                descripcionList.AddRange(resultDictionary.Select(item => new DescripcionEstrategiaModel
                    {
                        Cuv = item["cuv"].ToString(),
                        Descripcion = item["descripcion"].ToString(), 
                        Estado = (bool) item["estado"] ? 1 : 0
                    }));
            }
            return descripcionList;
        }

        public void RegistrarTipoEstrategia(ServicePedido.BETipoEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlRegistrarTipoEstrategiaWebApi, pais);
            WaTipoEstrategia waModel = ObtenerTipoEstrategia(entidad);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);
        }

        public void EditarTipoEstrategia(ServicePedido.BETipoEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEditarTipoEstrategiaWebApi, pais);
            WaTipoEstrategia waModel = ObtenerTipoEstrategia(entidad);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);
        }

        public List<EstrategiaMDbAdapterModel> Listar(List<string> estrategiasIds, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = JsonConvert.SerializeObject(estrategiasIds);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlListarEstrategiaPorConfigurarWebApi, pais);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);
            if (respuesta == null) return new List<EstrategiaMDbAdapterModel>();
            List<WaEstrategiaModel> WaModelList = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(respuesta.Result.ToString()) : new List<WaEstrategiaModel>();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            if (WaModelList.Any())
            {
                List<EstrategiaMDbAdapterModel> mapList = EstablecerEstrategiaList(WaModelList);

                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public void EliminarShowRoomEvento(string id)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    string.Empty, 
                    string.Format(Constantes.PersonalizacionOfertasService.UrlEliminarShowRoomEvento, userData.CodigoISO, id), 
                    "delete", 
                    userData)
                );

            Task.WhenAll(taskApi);
            
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(taskApi.Result);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);
        }

        public List<ShowRoomEventoModelo> ConsultarShowRoom(string pais, int campaniaId)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    string.Empty
                    , string.Format(Constantes.PersonalizacionOfertasService.UrlConsultarShowRoom, pais, campaniaId)
                    , "get"
                    , userData
                ));
            Task.WhenAll(taskApi);

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(taskApi.Result);

            //if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            //    throw new Exception(respuesta.Message);

            List<ShowRoomEventoModelo> l = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<ShowRoomEventoModelo>>(respuesta.Result.ToString()) : new List<ShowRoomEventoModelo>();

            return l;
        }

        public void DeshabilitarShowRoomEvento(string id)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    string.Empty
                    ,string.Format(Constantes.PersonalizacionOfertasService.UrlDeshabilitarShowRoomEvento, userData.CodigoISO, id, userData.CodigoUsuario) 
                    , "put"
                    , userData
                ));

            Task.WhenAll(taskApi);

            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);
        }

        public int UploadFileSetStrategyShowroom(ServicePedido.BEEstrategiaMasiva m, List<ServicePedido.BEEstrategia> l, string TipoEstrategiaCodigo)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string p = JsonConvert.SerializeObject(l.Select(x => new {
                Cuv = x.CUV2
                , Descripcion = x.DescripcionCUV2
                , Estado = x.Activo
                , LimiteVenta = x.LimiteVenta
                , TextoLibre = x.TextoLibre
                , EsSubCampania = x.EsSubCampania
            }));

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    p
                    , string.Format(Constantes.PersonalizacionOfertasService.UrlUploadFileSetStrategyShowroom,userData.CodigoISO, TipoEstrategiaCodigo, m.CampaniaID, m.TipoEstrategiaID, userData.CodigoUsuario)
                    , "put"
                    , userData
                ));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            return Convert.ToInt32(respuesta.Result);
        }

        public int UploadFileProductStrategyShowroom(ServicePedido.BEEstrategiaMasiva m, List<ServicePedido.BEEstrategiaProducto> l, string TipoEstrategiaCodigo)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string p = JsonConvert.SerializeObject(l.Select(x => new {
                CUV = x.CUV,
                NombreProducto = x.NombreProducto,
                Descripcion = x.Descripcion1,
                Orden = x.Orden
            }));

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    p
                    , string.Format(Constantes.PersonalizacionOfertasService.UrlUploadFileProductStrategyShowroom, userData.CodigoISO, TipoEstrategiaCodigo, m.CampaniaID,userData.CodigoUsuario)
                    , "put"
                    , userData
                ));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            return Convert.ToInt32(respuesta.Result);
        }

        public int GuardarShowRoom(ShowRoomEventoModel o)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            string p = JsonConvert.SerializeObject(new {
                _id = o._id,
                eventoId = o.EventoID,
                campaniaId = o.CampaniaID,
                nombre = o.Nombre,
                tema = o.Tema,
                diasAntes = o.DiasAntes,
                diasDespues = o.DiasDespues,
                numeroPerfiles = o.NumeroPerfiles,
                usuarioCreacion = userData.CodigoUsuario,
                UsuarioModificacion = userData.CodigoUsuario,
                tieneCategoria = o.TieneCategoria,
                tieneCompraXcompra = o.TieneCompraXcompra,
                tieneSubCampania = o.TieneSubCampania,
                tienePersonalizacion = o.TienePersonalizacion,
                Estado = o.Estado
            });

            var taskApi = Task.Run(() => RespSBMicroservicios(
                p, 
                string.Format(Constantes.PersonalizacionOfertasService.UrlGuardarShowRoom, userData.CodigoISO), 
                "post", 
                userData));
            Task.WhenAll(taskApi);

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(taskApi.Result);

            return Convert.ToInt32(respuesta.Result);
        }

        public int UpdateShowRoomEvento(ShowRoomEventoModel o)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            string p = JsonConvert.SerializeObject(new
            {
                _id = o._id,
                eventoId = o.EventoID,
                campaniaId = o.CampaniaID,
                nombre = o.Nombre,
                tema = o.Tema,
                diasAntes = o.DiasAntes,
                diasDespues = o.DiasDespues,
                numeroPerfiles = o.NumeroPerfiles,
                usuarioCreacion = userData.CodigoUsuario,
                UsuarioModificacion = userData.CodigoUsuario,
                tieneCategoria = o.TieneCategoria,
                tieneCompraXcompra = o.TieneCompraXcompra,
                tieneSubCampania = o.TieneSubCampania,
                tienePersonalizacion = o.TienePersonalizacion,
                Estado = o.Estado
            });

            var taskApi = Task.Run(() => RespSBMicroservicios(
                p,
                string.Format(Constantes.PersonalizacionOfertasService.UrlUpdateShowRoomEvento, userData.CodigoISO),
                "put",
                userData));
            Task.WhenAll(taskApi);

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(taskApi.Result);

            return Convert.ToInt32(respuesta.Result);
        }

        public void EliminarEstrategia(int EstrategiaId, string _id)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    string.Empty,
                    string.Format(Constantes.PersonalizacionOfertasService.UrlEliminarEstrategia, userData.CodigoISO, string.Format("{0},{1}", _id, EstrategiaId)),
                    "delete",
                    userData)
                );

            Task.WhenAll(taskApi);

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(taskApi.Result);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);
        }

        public void RegistrarEventoPersonalizacion(string pais, string eventoId,string _id,  List<ShowRoomPersonalizacionModel> lstPersonalizacion) {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEventoPersonalizacion, pais, _id);
            string p = JsonConvert.SerializeObject(lstPersonalizacion.Select( x => new
            {
                personalizacionId = x.PersonalizacionId,
                tipoAplicacion = x.TipoAplicacion,
                atributo = x.Atributo,
                textoAyuda = x.TextoAyuda,
                tipoAtributo = x.TipoAtributo,
                tipoPersonalizacion = x.TipoPersonalizacion,
                orden = x.Orden,
                estado = x.Estado,
                valor = x.Valor,
                eventoId = eventoId,
                nivelId = x.NivelId
            }));

            var taskApi = Task.Run(() => RespSBMicroservicios(
                p,
                requestUrl,
                "post",
                userData
                ));

            Task.WhenAll(taskApi);
        }

        public void EliminarOfertaShowRoomDetalleNew(int estrategiaId, string cuv)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    JsonConvert.SerializeObject(new
                    {
                        estrategiaId = estrategiaId,
                        cuv = cuv,
                        usuario = userData.CodigoUsuario
                    }),
                    string.Format(Constantes.PersonalizacionOfertasService.UrlEliminarOfertaShowRoomDetalleNew, userData.CodigoISO),
                    "put",
                    userData
                ));

            Task.WhenAll(taskApi);
        }

        public void UpdateOfertaShowRoomDetalleNew(EstrategiaProductoModel o)
        {
            UsuarioModel userData = sessionManager.GetUserData();

            string p = JsonConvert.SerializeObject(new
            {
                EstrategiaId = o.EstrategiaID,
                cuvPadre = o.CUV2,
                campaniaId = o.Campania,
                cuv = o.CUV,
                //codigoEstrategia = 0,
                //grupo = 0,
                //codigoSap = string,
                //cantidad = 0,
                //precioUnitario = 0,
                //precioValorizado = 0,
                //orden = 0,
                //indicadorDigitable = true,
                //factorCuadre = 0,
                descripcion = o.Descripcion1,
                //marcaId = 0,
                nombreProducto = o.NombreProducto,
                //imagenProducto = string,
                //activo = true,
                //usuarioCreacion = string,
                //fechaCreacion = 2018 - 09 - 07T17 = 38 = 03.887Z,
                usuarioModificacion = userData.CodigoUsuario,
                fechaModificacion = DateTime.Now,
                //estrategiaId = 0,
                //estrategiaProductoId = 0,
                //nombreComercial = string,
                //descripcion = string,
                //volumen = string,
                //imagenBulk = string,
                //nombreBulk = string
            });

            var taskApi = Task.Run(() => RespSBMicroservicios(
                    p,
                    string.Format(Constantes.PersonalizacionOfertasService.UrlUpdateOfertaShowRoomDetalleNew, userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom),
                    "put",
                    userData
                ));

            Task.WhenAll(taskApi);
        }

        public void JobBuscador(string codigoCampania, string codigoEstrategia, UsuarioModel userData)
        {
            var tipoPersonalizacion = Util.GetTipoPersonalizacionByCodigoEstrategia(codigoEstrategia);

            var requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlJobBuscador, userData.CodigoISO, tipoPersonalizacion, codigoCampania);

            var httpContent = new StringContent(string.Empty, Encoding.UTF8);
            
            var taskApi = Task.Run(() => httpClientMicroservicioSync.PostAsync(requestUrl, httpContent));

            Task.WhenAll(taskApi);

            if (taskApi.Result != null && !taskApi.Result.IsSuccessStatusCode)
            {
                LogManager.LogManager.LogErrorWebServicesBus(new Exception("AdministrarEstrategiaProvider_JobBuscador:" + taskApi.Result.StatusCode.ToString()), userData.CodigoConsultora, userData.CodigoISO);
            }
        }
    }
}