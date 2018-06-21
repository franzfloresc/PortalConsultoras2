using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Response;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class AdministrarEstrategiaProvider
    {
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;

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

                if (response != null && !response.IsSuccessStatusCode)
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

        public int CargarEstrategia(List<string> estrategiasIds, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = JsonConvert.SerializeObject(estrategiasIds);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlCargarWebApi, pais);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return 0;
            }
            return JsonConvert.DeserializeObject<GenericResponse>(content).Success.Equals(true) ? 1 : 0; ;
        }

        public Dictionary<string, int> ObtenerCantidadOfertasParaTi(string tipoCodigo, int campania, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            Dictionary<string, int> iCantidadOfertas = new Dictionary<string, int> { { "CUV_ZE", -1 }, { "CUV_OP", -1 } };
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlCantidadOfertas, pais, tipoCodigo, campania);

            //string jsonParameters = "?tipo=" + tipoCodigo + "&campania=" + campania + "&pais=" + pais;

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
                        CodigoEstrategia = d.CodigoEstrategia,
                        CodigoTipoEstrategia = d.CodigoTipoEstrategia,
                        //cambiar por CodigoProducto cuando se corrija el servicio
                        CodigoProducto = string.IsNullOrEmpty(d.CodigoSap) ? d.CodigoProducto : d.CodigoSap,
                        IndicadorMontoMinimo = d.IndicadorMontoMinimo ? 1 : 0,
                        IdMatrizComercial = d.MatrizComercialId,
                        MarcaID = d.MarcaId,
                        DescripcionMarca = d.MarcaDescripcion,
                        UsuarioCreacion = d.UsuarioCreacion,
                        UsuarioModificacion = d.UsuarioModificacion,
                        ImagenMiniaturaURL = "",
                        TipoEstrategiaID = d.TipoEstrategiaId,
                        Imagen = d.FlagImagenURL ? 1 : 0,
                        DescripcionEstrategia = d.DescripcionTipoEstrategia,                    
                        CodigoSAP = string.IsNullOrEmpty(d.CodigoSap) ? d.CodigoProducto : d.CodigoSap,
                        Zona = d.Zona
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
            //entidad.Imagen
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
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = EstablecerEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public List<EstrategiaMDbAdapterModel> PreCargar(string campaniaId, string tipoEstrategiaCodigo, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "";

            //entidad.Imagen
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlPreCargarWebApi, pais, tipoEstrategiaCodigo, campaniaId);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            var WaModelList = (respuesta.Result != null) ? JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(respuesta.Result.ToString()) : new List<WaEstrategiaModel>();
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = EstablecerEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public List<EstrategiaMDbAdapterModel> FiltrarEstrategia(string id, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "";
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlFiltrarEstrategia, pais,id);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            var WaObject = (respuesta.Result != null) ? JsonConvert.DeserializeObject<WaEstrategiaModel>(respuesta.Result.ToString()) : null;
            var WaModelList = new List<WaEstrategiaModel>();
            if (WaObject != null)
                WaModelList.Add(WaObject);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = EstablecerEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }

        public void RegistrarEstrategia(ServicePedido.BEEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlRegistrarWebApi, pais);
            WaEstrategiaModel waModel = ObtenerEstrategia(entidad, "");
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);
            if (!respuesta.Success)
            {
                throw new Exception(respuesta.Message);
            }
        }

        public void EditarEstrategia(ServicePedido.BEEstrategia entidad, string mongoId, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEditarWebApi, pais);
            WaEstrategiaModel waModel = ObtenerEstrategia(entidad, mongoId);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);
            if (!respuesta.Success)
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
                MatrizComercialId = entidad.IdMatrizComercial,
                PrecioPublico = (float)entidad.PrecioPublico,
                Zona = entidad.Zona
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
                FlagActivo = tipoEstrategia.FlagActivo == 1 ? true : false,
                FlagNueva = tipoEstrategia.FlagNueva == 1 ? true : false,
                FlagRecoProduc = tipoEstrategia.FlagRecoProduc == 1 ? true : false,
                FlagRecoPerfil = tipoEstrategia.FlagRecoPerfil == 1 ? true : false,
                CodigoPrograma = tipoEstrategia.CodigoPrograma,
                OfertaId = tipoEstrategia.OfertaID,
                FlagMostrarImg = tipoEstrategia.FlagMostrarImg == 1 ? true : false,
                MostrarImgOfertaIndependiente = tipoEstrategia.MostrarImgOfertaIndependiente,
                ImagenOfertaIndependiente = tipoEstrategia.ImagenOfertaIndependiente,
                Codigo = tipoEstrategia.Codigo,
                FlagValidarImagen = tipoEstrategia.FlagValidarImagen == 1 ? true : false,
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

            if (!respuesta.Success)
            {
                throw new Exception(respuesta.Message);
            }
        }

        public bool ActivarDesactivarEstrategias(List<string> estrategiasActivas, List<string> estrategiasInactivas, string usuario, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParametersActivas = JsonConvert.SerializeObject(estrategiasActivas);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlActivarEstrategias, pais, usuario);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParametersActivas, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            bool activarResponse = !string.IsNullOrEmpty(content) && content.Equals("true");

            string jsonParametersInactivas = JsonConvert.SerializeObject(estrategiasInactivas);
            string requestUrlInactivar = string.Format(Constantes.PersonalizacionOfertasService.UrlDesactivarEstrategias, pais, usuario);
            taskApi = Task.Run(() => RespSBMicroservicios(jsonParametersInactivas, requestUrlInactivar, "put", userData));
            Task.WhenAll(taskApi);
            content = taskApi.Result;
            bool inactivarResponse = !string.IsNullOrEmpty(content) && content.Equals("true");

            return activarResponse || inactivarResponse;
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

            if (!respuesta.Success)
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

        public List<DescripcionEstrategiaModel> UploadCsv(List<BEDescripcionEstrategia> descripcionEstrategiaLista, string pais)
        {
            var descripcionEstrategiaListaWA = descripcionEstrategiaLista.Select(d => new
            {
                d.Cuv,
                d.Descripcion,
                d.Estado
            }).ToList();

            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = JsonConvert.SerializeObject(descripcionEstrategiaListaWA);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlUploadCsv, pais);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            List<DescripcionEstrategiaModel> descripcionList = new List<DescripcionEstrategiaModel>();

            var respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (respuesta.Success)
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

            if (!respuesta.Success)
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

            if (!respuesta.Success)
                throw new Exception(respuesta.Message);
        }
    }
}