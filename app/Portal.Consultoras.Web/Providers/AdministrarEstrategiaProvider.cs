﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class AdministrarEstrategiaProvider
    {
        private readonly ILogManager logManager = LogManager.LogManager.Instance;
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        private readonly static HttpClient httpClient = new HttpClient();

        private async Task<string> RespSBMicroservicios(string jsonParametros, string requestUrlParam, string responseType, UsuarioModel userData)
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
        public int CargarEstrategia(List<string> estrategiasIds, string pais)
        {
            int iCantidadActualizada = 0;
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
            iCantidadActualizada = content.Equals("true") ? 1 : 0;
            return iCantidadActualizada;
        }
        public Dictionary<string, int> ObtenerCantidadOfertasParaTi(string tipoCodigo, int campania, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            Dictionary<string, int> iCantidadOfertas = new Dictionary<string, int>();
            iCantidadOfertas.Add("EC", -1);
            iCantidadOfertas.Add("EF", -1);
            string requestUrl = Constantes.PersonalizacionOfertasService.UrlCantidadOfertas;
            string jsonParameters = "?tipo=" + tipoCodigo + "&campania=" + campania.ToString() + "&pais=" + pais;
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return iCantidadOfertas;
            }
            iCantidadOfertas = JsonConvert.DeserializeObject<Dictionary<string, int>>(content);
            return iCantidadOfertas;
        }
        private List<EstrategiaMDbAdapterModel> EstablecerEstrategiaList(List<WaEstrategiaModel> waModelList)
        {
            List<EstrategiaMDbAdapterModel> mapList = waModelList.Select(d =>
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
        public List<EstrategiaMDbAdapterModel> Listar(string campaniaID, string tipoEstrategiaCodigo, string pais, int activo = -1, string cuv2 = "", int imagen = -1)
        {
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "?pais=" + pais;
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
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlListarWebApi, campaniaID, tipoEstrategiaCodigo);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var WaModelList = JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(content);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.EstablecerEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }
        public List<EstrategiaMDbAdapterModel> PreCargar(string campaniaId, string tipoEstrategiaCodigo, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = "?pais=" + pais;

            //entidad.Imagen
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlPreCargarWebApi, campaniaId, tipoEstrategiaCodigo);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var WaModelList = JsonConvert.DeserializeObject<List<WaEstrategiaModel>>(content);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.EstablecerEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }
        public List<EstrategiaMDbAdapterModel> FiltrarEstrategia(string id, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            List<EstrategiaMDbAdapterModel> listaEstrategias = new List<EstrategiaMDbAdapterModel>();
            string jsonParameters = id + "?pais=" + pais;
            string requestUrl = Constantes.PersonalizacionOfertasService.UrlFiltrarEstrategia;
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            var WaObject = JsonConvert.DeserializeObject<WaEstrategiaModel>(content);
            var WaModelList = new List<WaEstrategiaModel>();
            WaModelList.Add(WaObject);
            if (WaModelList.Count() > 0)
            {
                List<EstrategiaMDbAdapterModel> mapList = this.EstablecerEstrategiaList(WaModelList);
                mapList.Select((x, d) => x.BEEstrategia.ID = d + 1).ToList();
                listaEstrategias.AddRange(mapList);
            }
            return listaEstrategias;
        }
        public string RegistrarEstrategia(BEEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlRegistrarWebApi, pais);
            WaEstrategiaModel waModel = ObtenerEstrategia(entidad, "");
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }
        public string EditarEstrategia(BEEstrategia entidad, string mongoId, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEditarWebApi, pais);
            WaEstrategiaModel waModel = ObtenerEstrategia(entidad, mongoId);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }
        private WaEstrategiaModel ObtenerEstrategia(BEEstrategia entidad, string id)
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
                Zona = entidad.Zona
            };
            return waModel;
        }
        private WaTipoEstrategia ObtenerTipoEstrategia(BETipoEstrategia tipoEstrategia)
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
        public bool DesactivarEstrategia(string id, string usuario, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            bool bDeshabilitado = true;
            string jsonParameters = "";
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlDesactivarWebApi, id, usuario, pais);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                return false;
            }
            bDeshabilitado = content.Equals("true");
            return bDeshabilitado;
        }
        public bool ActivarDesactivarEstrategias(List<string> estrategiasActivas, List<string> estrategiasInactivas, string usuario, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            bool activarResponse = true; bool inactivarResponse = true;
            string jsonParametersActivas = JsonConvert.SerializeObject(estrategiasActivas);
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlActivarEstrategias, usuario, pais);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParametersActivas, requestUrl, "put", userData));
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
            string requestUrlInactivar = string.Format(Constantes.PersonalizacionOfertasService.UrlDesactivarEstrategias, usuario, pais);
            taskApi = Task.Run(() => RespSBMicroservicios(jsonParametersInactivas, requestUrlInactivar, "put", userData));
            Task.WhenAll(taskApi);
            content = taskApi.Result;
            if (string.IsNullOrEmpty(content))
            {
                inactivarResponse = false;
            }
            inactivarResponse = content.Equals("true");

            return activarResponse || inactivarResponse;
        }
        public Dictionary<string, object> ObtenerEstrategiaCuv(string cuv, string campania, string tipoEstrategia, string pais, string prod, string perfil)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string jsonParameters = "?pais=" + pais + "&prod=" + prod + "&perfil=" + perfil;
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEstrategiaCuv, campania, tipoEstrategia, cuv);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "get", userData));
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
                    List<EstrategiaMDbAdapterModel> estrategiaAdapterList = EstablecerEstrategiaList(waModelList);
                    resultDictionary["result"] = estrategiaAdapterList[0].BEEstrategia;
                }
            }
            return resultDictionary;
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
        public string RegistrarTipoEstrategia(BETipoEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlRegistrarTipoEstrategiaWebApi, pais);
            WaTipoEstrategia waModel = ObtenerTipoEstrategia(entidad);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "post", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }
        public string EditarTipoEstrategia(BETipoEstrategia entidad, string pais)
        {
            UsuarioModel userData = sessionManager.GetUserData();
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEditarTipoEstrategiaWebApi, pais);
            WaTipoEstrategia waModel = ObtenerTipoEstrategia(entidad);
            string jsonParameters = JsonConvert.SerializeObject(waModel);
            var taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;
            return content;
        }
    }
}