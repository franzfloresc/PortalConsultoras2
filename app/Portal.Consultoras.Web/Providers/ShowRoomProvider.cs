using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    using System.Text;
    using Portal.Consultoras.Common.Response;

    /// <summary>
    /// Propiedades y metodos de ShowRoom
    /// </summary>
    public class ShowRoomProvider : OfertaBaseProvider
    {
        private const string ImageUrlCode = "bar_in_img";
        private const string RedirectCode = "bar_in_url";
        private const string EnabledCode = "bar_in_act";
        private const string NoUrlAllowed = "bar_in_no";
        private const short Pl50Key = 98;

        private readonly TablaLogicaProvider _tablaLogicaProvider;
        private readonly ILogManager _logManager;
        private readonly ISessionManager _sessionManager;
        private readonly ConfiguracionManagerProvider _configuracionManager;
        protected OfertaBaseProvider _ofertaBaseProvider;

        public ShowRoomProvider() : this(LogManager.LogManager.Instance,
            SessionManager.SessionManager.Instance,
            new ConfiguracionManagerProvider(),
            new OfertaBaseProvider())
        {

        }

        public ShowRoomProvider(
                   ILogManager logManager,
                   ISessionManager sessionManager,
                   ConfiguracionManagerProvider configuracionManagerProvider,
                   OfertaBaseProvider ofertaBaseProvider)
        {
            this._logManager = logManager;
            this._sessionManager = sessionManager;
            this._configuracionManager = configuracionManagerProvider;
            _ofertaBaseProvider = ofertaBaseProvider;
        }

        public ShowRoomProvider(TablaLogicaProvider tablaLogicaProvider) : this(
            LogManager.LogManager.Instance,
            SessionManager.SessionManager.Instance,
            new ConfiguracionManagerProvider(),
            new OfertaBaseProvider())
        {
            this._tablaLogicaProvider = tablaLogicaProvider;
        }


        /// <summary>
        /// Obtiene la configuracion de Base de datos
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <returns>Configuracion de Banner inferior</returns>
        public IBannerInferiorConfiguracion ObtenerBannerConfiguracion(int paisId)
        {
            var pl50configs = _tablaLogicaProvider.ObtenerParametrosTablaLogica(paisId, Pl50Key);
            var enabledObject = pl50configs.FirstOrDefault(c => c.Codigo == EnabledCode);
            var redirectUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == RedirectCode);
            var imageUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == ImageUrlCode);
            var NoUrlPermitidasObject = pl50configs.FirstOrDefault(c => c.Codigo == NoUrlAllowed);

            return new BannerInferiorConfiguracion
            {
                Activo = enabledObject != null && bool.Parse(enabledObject.Valor),
                UrlImagen = imageUrlObject != null ? imageUrlObject.Valor : string.Empty,
                UrlRedireccion = redirectUrlObject != null ? redirectUrlObject.Valor : string.Empty,
                RutasParcialesExcluidas = NoUrlPermitidasObject != null ? NoUrlPermitidasObject.Valor.Split(';') : new string[0]
            };
        }

        /// <summary>
        /// Obtiene y evalua la session (ShowRoom y Banner)
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <param name="session">Session Manager</param>
        /// <returns>Configuracion de Banner Inferior</returns>
        public IBannerInferiorConfiguracion EvaluarBannerConfiguracion(int paisId, ISessionManager session)
        {
            if (session.ShowRoom.BannerInferiorConfiguracion != null)
                return session.ShowRoom.BannerInferiorConfiguracion;

            var configuracion = ObtenerBannerConfiguracion(paisId);
            configuracion.Activo = configuracion.Activo && session.GetEsShowRoom();

            session.ShowRoom.BannerInferiorConfiguracion = configuracion;

            return configuracion;
        }

        public ShowRoomEventoModel GetShowRoomEventoByCampaniaId(UsuarioModel model)
        {
            using (var sv = new PedidoServiceClient())
            {
                var showRoomEvento = sv.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);
                return Mapper.Map<ServicePedido.BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
            }
        }

        public ShowRoomEventoConsultoraModel GetShowRoomConsultora(UsuarioModel model, ShowRoomEventoModel showRoomEventoModel)
        {
            if (UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
            {
                ShowRoomEventoConsultoraModel eventoConsultora = ObtenerEventoConsultoraApi(model.CodigoISO, model.CampaniaID, model.GetCodigoConsultora());

                if (eventoConsultora == null)
                {
                    eventoConsultora= RegistrarEventoConsultoraApi(showRoomEventoModel.EventoID, false);
                }

                return eventoConsultora;
            }
            else
            {
                using (PedidoServiceClient servicioWcf = new PedidoServiceClient())
                {
                    BEShowRoomEventoConsultora showRoomEventoConsultora = servicioWcf.GetShowRoomConsultora(
                        model.PaisID,
                        model.CampaniaID,
                        model.GetCodigoConsultora(),
                        true);
                    return Mapper.Map<BEShowRoomEventoConsultora, ShowRoomEventoConsultoraModel>(
                        showRoomEventoConsultora);
                }
            }
        }

        public List<ShowRoomNivelModel> GetShowRoomNivel(UsuarioModel model)
        {
            if (UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
            {
                return ObtenerNivelApi(model.CodigoISO);
            }
            else
            {
                using (PedidoServiceClient servicioWcf = new PedidoServiceClient())
                {
                    List<BEShowRoomNivel> showRoomNiveles = servicioWcf.GetShowRoomNivel(model.PaisID).ToList();
                    return Mapper.Map<List<BEShowRoomNivel>, List<ShowRoomNivelModel>>(showRoomNiveles);
                }
            }
        }

        public List<ShowRoomPersonalizacionModel> GetShowRoomPersonalizacion(UsuarioModel model)
        {
            using (var sv = new PedidoServiceClient())
            {
                var personalizacion = sv.GetShowRoomPersonalizacion(model.PaisID).ToList();
                return Mapper.Map<IList<ServicePedido.BEShowRoomPersonalizacion>, List<ShowRoomPersonalizacionModel>>(personalizacion).ToList();
            }
        }

        public List<ShowRoomPersonalizacionNivelModel> GetShowRoomPersonalizacionNivel(UsuarioModel model, int eventoId, int showRoomNivelId, int categoriaId)
        {
            using (var sv = new PedidoServiceClient())
            {
                var personalizacionesNivel = sv.GetShowRoomPersonalizacionNivel(model.PaisID, eventoId, showRoomNivelId, categoriaId).ToList();
                return Mapper.Map<List<ServicePedido.BEShowRoomPersonalizacionNivel>, List<ShowRoomPersonalizacionNivelModel>>(personalizacionesNivel).ToList();
            }
        }

        public void ShowRoomProgramarAviso(int paisId, ShowRoomEventoConsultoraModel showRoomConsultora)
        {
            var beShowRoomConsultora =
                Mapper.Map<ShowRoomEventoConsultoraModel, ServicePedido.BEShowRoomEventoConsultora>(showRoomConsultora);

            using (var sv = new PedidoServiceClient())
            {
                sv.ShowRoomProgramarAviso(paisId, beShowRoomConsultora);
            }
        }

        public bool GetEventoConsultoraRecibido(UsuarioModel usuario)
        {
            var result = false;

            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetEventoConsultoraRecibido(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID);
                }
            }
            catch (Exception ex)
            {
                _logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "ShowRoomProvider.GetEventoConsultoraRecibido");
            }

            return result;
        }

        public void UpdShowRoomEventoConsultoraEmailRecibido(string codigoConsultoraFromQueryString, int campaniaIdFromQueryString, UsuarioModel usuario)
        {
            try
            {
                var entidad = new ServicePedido.BEShowRoomEventoConsultora
                {
                    CodigoConsultora = codigoConsultoraFromQueryString,
                    CampaniaID = campaniaIdFromQueryString
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdShowRoomEventoConsultoraEmailRecibido(usuario.PaisID, entidad);
                }
            }
            catch (Exception ex)
            {
                _logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "ShowRoomProvider.GetEventoConsultoraRecibido");
            }
        }

        private async Task<List<dynamic>> ApiEventoPersonalizacion(UsuarioModel model)
        {
            try
            {
                string path = "";
                path = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerEvento, model.CodigoISO, model.CampaniaID);
                List<dynamic> lstResult = null;
                using (var httpClient = new HttpClient())
                {
                    httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
                    httpClient.DefaultRequestHeaders.Accept.Clear();
                    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    HttpResponseMessage httpResponse = await httpClient.GetAsync(path);

                    if (httpResponse.IsSuccessStatusCode)
                    {
                        lstResult = JsonConvert.DeserializeObject<List<dynamic>>(await httpResponse.Content.ReadAsStringAsync());

                    }
                }

                return lstResult;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private ShowRoomEventoModel ObtieneEventoModel(List<dynamic> lstResponse)
        {
            ShowRoomEventoModel modelo = new ShowRoomEventoModel();
            if (lstResponse == null)
            {
                return modelo;
            }

            foreach (dynamic list in lstResponse)
            {
                modelo.CampaniaID = Convert.ToInt32(list.campaniaId);
                modelo.DiasAntes = Convert.ToInt32(list.diasAntes);
                modelo.DiasDespues = Convert.ToInt32(list.diasDespues);
                modelo.Estado = Convert.ToInt32(list.estado);
                modelo.EventoID = Convert.ToInt32(list.eventoId);
                modelo.Imagen1 = list.imagen1;
                modelo.Imagen2 = list.imagen2;
                modelo.ImagenCabeceraProducto = list.imagenCabeceraProducto;
                modelo.ImagenPestaniaShowRoom = list.imagenPestaniaShowRoom;
                modelo.ImagenPreventaDigital = list.imagenPreventaDigital;
                modelo.ImagenVentaSetPopup = list.imagenVentaSetPopup;
                modelo.ImagenVentaTagLateral = list.imagenVentaTagLateral;
                modelo.Nombre = list.nombre;
                modelo.NumeroPerfiles = Convert.ToInt32(list.numeroPerfiles);
                modelo.Tema = list.tema;
                modelo.TieneCategoria = Convert.ToBoolean(list.tieneCategoria);
                modelo.TieneCompraXcompra = Convert.ToBoolean(list.tieneCompraXcompra);
                modelo.TienePersonalizacion = Convert.ToBoolean(list.tienePersonalizacion);
                modelo.TieneSubCampania = Convert.ToBoolean(list.tieneSubCampania);
            }

            return modelo;
        }

        private List<ShowRoomPersonalizacionModel> ObtienePersonalizacionesModel(List<dynamic> lstResponse)
        {
            List<ShowRoomPersonalizacionModel> personalizaciones = new List<ShowRoomPersonalizacionModel>();
            if (lstResponse == null)
            {
                return personalizaciones;
            }

            foreach (dynamic list in lstResponse)
            {
                foreach (dynamic item in list.personalizacionNivel)
                {
                    ShowRoomPersonalizacionModel personalizacion = new ShowRoomPersonalizacionModel
                    {
                        PersonalizacionId = Convert.ToInt32(item.personalizacionId),
                        TipoAplicacion = item.tipoAplicacion,
                        Atributo = item.atributo,
                        TextoAyuda = item.textoAyuda,
                        TipoAtributo = item.tipoAtributo,
                        TipoPersonalizacion = item.tipoPersonalizacion,
                        Orden = Convert.ToInt32(item.orden),
                        Estado = Convert.ToBoolean(item.estado),
                        Valor = item.valor,
                        NivelId = Convert.ToInt32(item.nivelId)
                    };
                    personalizaciones.Add(personalizacion);
                }
            }

            return personalizaciones;
        }

        public void CargarEntidadesShowRoom(UsuarioModel model)
        {
            var configEstrategiaSR = _sessionManager.GetEstrategiaSR() ?? new ConfigModel();
            try
            {
                const int SHOWROOM_ESTADO_ACTIVO = 1;

                _sessionManager.SetEsShowRoom("0");
                _sessionManager.SetMostrarShowRoomProductos("0");
                _sessionManager.SetMostrarShowRoomProductosExpiro("0");

                configEstrategiaSR.BeShowRoomConsultora = null;
                configEstrategiaSR.BeShowRoom = null;
                configEstrategiaSR.CargoEntidadesShowRoom = false;

                if (!PaisTieneShowRoom(model.CodigoISO))
                {
                    configEstrategiaSR.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
                    _sessionManager.SetEstrategiaSR(configEstrategiaSR);
                    return;
                }

                if (UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    if (model.CampaniaID != 0)
                    {
                        var lstResult = Task.Run(() => ApiEventoPersonalizacion(model));
                        Task.WhenAll(lstResult);
                        configEstrategiaSR.BeShowRoom = ObtieneEventoModel(lstResult.Result);
                        configEstrategiaSR.ListaPersonalizacionConsultora = ObtienePersonalizacionesModel(lstResult.Result);
                    }
                }
                else
                {
                    configEstrategiaSR.BeShowRoom = GetShowRoomEventoByCampaniaId(model);
                    configEstrategiaSR.ListaPersonalizacionConsultora = GetShowRoomPersonalizacion(model);
                }

                if (model.CampaniaID != 0)
                {
                    configEstrategiaSR.BeShowRoomConsultora = GetShowRoomConsultora(model, configEstrategiaSR.BeShowRoom );
                }

                configEstrategiaSR.ListaNivel = GetShowRoomNivel(model);
                configEstrategiaSR.ShowRoomNivelId = ObtenerNivelId(configEstrategiaSR.ListaNivel);


                if (configEstrategiaSR.BeShowRoom != null
                    && configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO)
                {
                    ActualizarValorPersonalizacionesShowRoom(model, configEstrategiaSR);
                }

                if (configEstrategiaSR.BeShowRoom != null &&
                    configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO &&
                    configEstrategiaSR.BeShowRoomConsultora != null)
                {
                    _sessionManager.SetEsShowRoom("1");

                    var fechaHoy = model.FechaHoy;

                    if (fechaHoy >= model.FechaInicioCampania.AddDays(-configEstrategiaSR.BeShowRoom.DiasAntes).Date
                        && fechaHoy <= model.FechaInicioCampania.AddDays(configEstrategiaSR.BeShowRoom.DiasDespues).Date)
                    {
                        _sessionManager.SetMostrarShowRoomProductos("1");
                    }

                    if (fechaHoy > model.FechaInicioCampania.AddDays(configEstrategiaSR.BeShowRoom.DiasDespues).Date)
                    {
                        _sessionManager.SetMostrarShowRoomProductosExpiro("1");
                        configEstrategiaSR.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
                    }
                }

                configEstrategiaSR.CargoEntidadesShowRoom = true;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                configEstrategiaSR.CargoEntidadesShowRoom = false;
                configEstrategiaSR.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            }

            _sessionManager.SetEstrategiaSR(configEstrategiaSR);
        }

        public bool PaisTieneShowRoom(string codigoIsoPais)
        {
            if (string.IsNullOrEmpty(codigoIsoPais))
                return false;

            var paisesShowRoom = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesShowRoom);
            var tieneShowRoom = paisesShowRoom.Contains(codigoIsoPais);
            return tieneShowRoom;
        }

        public ShowRoomBannerLateralModel GetShowRoomBannerLateral(string codigoIso, double zonaHoraria, DateTime fechaInicioCampania)
        {
            var model = new ShowRoomBannerLateralModel();


            if (!PaisTieneShowRoom(codigoIso))
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            var configEstrategiaSR = _sessionManager.GetEstrategiaSR();
            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            model.BEShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
            model.BEShowRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

            if (model.BEShowRoom.Estado != 1)
                return new ShowRoomBannerLateralModel { EventoNoEncontrado = true };

            model.EstaActivoLateral = true;
            var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;
            if ((fechaHoy >= fechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes).Date &&
                fechaHoy <= fechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date))
            {
                model.MostrarShowRoomProductos = true;
                _sessionManager.SetMostrarShowRoomProductos("1");
            }
            if (fechaHoy > fechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date)
                model.EstaActivoLateral = false;

            var diasFalta = fechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes) - fechaHoy;
            model.DiasFalta = diasFalta.Days;
            model.DiasFaltantes = diasFalta.Days;

            model.MesFaltante = fechaInicioCampania.Month;
            model.AnioFaltante = fechaInicioCampania.Year;

            if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
            {
                model.ImagenPopupShowroomIntriga = "";
                model.ImagenBannerShowroomIntriga = "";
                model.ImagenPopupShowroomVenta = "";
                model.ImagenBannerShowroomVenta = "";
                return model;
            }

            foreach (var item in configEstrategiaSR.ListaPersonalizacionConsultora)
            {
                switch (item.Atributo)
                {
                    case Constantes.ShowRoomPersonalizacion.Mobile.PopupImagenIntriga:
                        model.ImagenPopupShowroomIntriga =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                    case Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenIntriga:
                        model.ImagenBannerShowroomIntriga =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                    case Constantes.ShowRoomPersonalizacion.Mobile.PopupImagenVenta:
                        model.ImagenPopupShowroomVenta =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                    case Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenVenta:
                        model.ImagenBannerShowroomVenta =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                }
            }

            return model;
        }

        private void ActualizarValorPersonalizacionesShowRoom(UsuarioModel model, ConfigModel configEstrategiaSR)
        {
            if (_ofertaBaseProvider.UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
            {
                var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;
                configEstrategiaSR.ListaPersonalizacionConsultora.ForEach(item => item.Valor = item.TipoAtributo == "IMAGEN" ? ConfigCdn.GetUrlFileCdn(carpetaPais, item.Valor) : item.Valor);
            }
            else
            {
                var personalizacionesNivel = GetShowRoomPersonalizacionNivel(model,
                                    configEstrategiaSR.BeShowRoom.EventoID,
                                    configEstrategiaSR.ShowRoomNivelId,
                                    0);

                var personalizaciones = configEstrategiaSR.ListaPersonalizacionConsultora;

                if (personalizacionesNivel == null || !personalizacionesNivel.Any()) return;

                foreach (var item in personalizaciones)
                {
                    item.PersonalizacionNivelId = 0;
                    item.Valor = string.Empty;

                    var personalizacionNivel = personalizacionesNivel.Find(
                        p => p.NivelId == configEstrategiaSR.ShowRoomNivelId &&
                             p.EventoID == configEstrategiaSR.BeShowRoom.EventoID &&
                             p.PersonalizacionId == item.PersonalizacionId);

                    if (personalizacionNivel == null) continue;

                    item.PersonalizacionNivelId = personalizacionNivel.PersonalizacionNivelId;
                    item.Valor = personalizacionNivel.Valor;

                    if (item.TipoAtributo != "IMAGEN") continue;

                    if (string.IsNullOrEmpty(item.Valor))
                    {
                        item.Valor = string.Empty;
                        continue;
                    }
                
                    item.Valor = ConfigCdn.GetUrlFileCdnMatriz(model.CodigoISO, item.Valor);
                }
            }
        }

        private int ObtenerNivelId(List<ShowRoomNivelModel> niveles)
        {
            var showRoomNivelPais = niveles.FirstOrDefault(p => p.Codigo == "PAIS") ?? new ShowRoomNivelModel();
            return showRoomNivelPais.NivelId;
        }

        public string ObtenerValorPersonalizacionShowRoom(string codigoAtributo, string tipoAplicacion)
        {
            var configEstrategiaSR = _sessionManager.GetEstrategiaSR();
            if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
                return string.Empty;

            var model = configEstrategiaSR.ListaPersonalizacionConsultora.FirstOrDefault(p => p.Atributo == codigoAtributo && p.TipoAplicacion == tipoAplicacion);

            return model == null
                       ? string.Empty
                       : model.Valor;
        }

        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            var configEstrategiaSR = _sessionManager.GetEstrategiaSR();
            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return false;

            var resultado = false;
            var esShowRoom = _sessionManager.GetEsShowRoom();
            var mostrarShowRoomProductos = _sessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = _sessionManager.GetMostrarShowRoomProductosExpiro();

            if (esIntriga)
            {
                resultado = esShowRoom && !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }
            else
            {
                resultado = esShowRoom && mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            return resultado;
        }

        public static async Task<ShowRoomEventoModel> ObtenerEventoShowroomDesdeApi(string path, string codigoISO)
        {
            ShowRoomEventoModel modelo = new ShowRoomEventoModel();

            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage httpResponse = await httpClient.GetAsync(path);
                if (httpResponse.IsSuccessStatusCode)
                {
                    string json = await httpResponse.Content.ReadAsStringAsync();
                    foreach (dynamic evento in Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(json))
                    {
                        try
                        {
                            modelo.CampaniaID = Convert.ToInt32(evento.campaniaId);
                            modelo.DiasAntes = Convert.ToInt32(evento.diasAntes);
                            modelo.DiasDespues = Convert.ToInt32(evento.diasDespues);
                            modelo.Estado = Convert.ToInt32(evento.estado);
                            modelo.EventoID = Convert.ToInt32(evento.eventoId);
                            modelo.Imagen1 = evento.imagen1;
                            modelo.Imagen2 = evento.imagen2;
                            modelo.ImagenCabeceraProducto = evento.imagenCabeceraProducto;
                            modelo.ImagenPestaniaShowRoom = evento.imagenPestaniaShowRoom;
                            modelo.ImagenPreventaDigital = evento.imagenPreventaDigital;
                            modelo.ImagenVentaSetPopup = evento.imagenVentaSetPopup;
                            modelo.ImagenVentaTagLateral = evento.imagenVentaTagLateral;
                            modelo.Nombre = evento.nombre;
                            modelo.NumeroPerfiles = Convert.ToInt32(evento.numeroPerfiles);
                            modelo.Tema = evento.tema;
                            modelo.TieneCategoria = Convert.ToBoolean(evento.tieneCategoria);
                            modelo.TieneCompraXcompra = Convert.ToBoolean(evento.tieneCompraXcompra);
                            modelo.TienePersonalizacion = Convert.ToBoolean(evento.tienePersonalizacion);
                            modelo.TieneSubCampania = Convert.ToBoolean(evento.tieneSubCampania);
                        }
                        catch (Exception ex)
                        {
                            Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                        }
                    }
                }
            }
            return modelo;
        }

        public static async Task<List<ShowRoomPersonalizacionModel>> ObtenerPersonalizacionShowroomDesdeApi(string path, string codigoISO)
        {
            List<ShowRoomPersonalizacionModel> personalizaciones = new List<ShowRoomPersonalizacionModel>();
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage httpResponse = await httpClient.GetAsync(path);
                if (httpResponse.IsSuccessStatusCode)
                {
                    foreach (dynamic list in JsonConvert.DeserializeObject<List<dynamic>>(await httpResponse.Content.ReadAsStringAsync()))
                    {
                        try
                        {
                            foreach (dynamic item in list.personalizacionNivel)
                            {
                                ShowRoomPersonalizacionModel personalizacion = new ShowRoomPersonalizacionModel
                                {
                                    PersonalizacionId = Convert.ToInt32(item.personalizacionId),
                                    TipoAplicacion = item.tipoAplicacion,
                                    Atributo = item.atributo,
                                    TextoAyuda = item.textoAyuda,
                                    TipoAtributo = item.tipoAtributo,
                                    TipoPersonalizacion = item.tipoPersonalizacion,
                                    Orden = Convert.ToInt32(item.orden),
                                    Estado = Convert.ToBoolean(item.estado),
                                    Valor = item.valor,
                                    NivelId = Convert.ToInt32(item.nivelId)
                                };
                                personalizaciones.Add(personalizacion);
                            }
                        }
                        catch (Exception ex)
                        {
                            Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                        }
                    }
                }
            }
            return personalizaciones;
        }

        public static async Task<List<ShowRoomPersonalizacionNivelModel>> ObtenerPersonalizacionNivelShowroomDesdeApi(string path, string codigoISO)
        {
            List<ShowRoomPersonalizacionNivelModel> personalizacionNivel = new List<ShowRoomPersonalizacionNivelModel>();
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage httpResponse = await httpClient.GetAsync(path);
                if (httpResponse.IsSuccessStatusCode)
                {
                    foreach (dynamic list in JsonConvert.DeserializeObject<List<dynamic>>(await httpResponse.Content.ReadAsStringAsync()))
                    {
                        try
                        {
                            foreach (dynamic item in list.personalizacionNivel)
                            {
                                ShowRoomPersonalizacionNivelModel nivel = new ShowRoomPersonalizacionNivelModel
                                {
                                    PersonalizacionId = Convert.ToInt32(item.personalizacionId),
                                    EventoID = Convert.ToInt32(item.eventoId),
                                    Valor = item.valor,
                                    NivelId = Convert.ToInt32(item.nivelId)
                                };
                                personalizacionNivel.Add(nivel);
                            }
                        }
                        catch (Exception ex)
                        {
                            Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                        }
                    }
                }
            }
            return personalizacionNivel;
        }

        //public List<ServiceOferta.BEEstrategia> GetShowRoomOfertasConsultora()
        //{
        //    UsuarioModel userData = _sessionManager.GetUserData();
        //    string pathShowroom = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerOfertas,
        //       userData.CodigoISO,
        //       Constantes.ConfiguracionPais.ShowRoom,
        //       userData.CampaniaID,
        //       userData.CodigoConsultora,
        //       userData.CodigorRegion,
        //       userData.ZonaID,
        //       0);
        //    var taskApi = Task.Run(() => OfertaBaseProvider.ObtenerOfertasDesdeApi(pathShowroom, userData.CodigoISO));
        //    Task.WhenAll(taskApi);
        //    return taskApi.Result;
        //}


        public ShowRoomEventoConsultoraModel RegistrarEventoConsultoraApi(int eventoId, bool esGenerica)
        {
            UsuarioModel userData = _sessionManager.GetUserData();

            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlRegistrarEventoConsultora, userData.CodigoISO);

            WaEventoConsultora eventoConsultora = new WaEventoConsultora
            {
                EventoId = eventoId,
                CampaniaId = userData.CampaniaID.ToString(),
                CodigoConsultora = userData.CodigoConsultora,
                EsGenerica = esGenerica
            };

            string jsonParameters = JsonConvert.SerializeObject(eventoConsultora);
            Task<string> taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData, "CONFIG")); 
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            GenericResponse respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                throw new Exception(respuesta.Message);

            ShowRoomEventoConsultoraModel modelo = new ShowRoomEventoConsultoraModel();
            dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(respuesta.Result.ToString());
            modelo.EventoConsultoraID = Convert.ToInt32(data.eventoConsultoraId);
            modelo.EventoID = Convert.ToInt32(data.eventoId);
            modelo.CampaniaID = Convert.ToInt32(data.campaniaId);
            modelo.CodigoConsultora = data.codigoConsultora;
            modelo.Segmento = data.segmento;
            modelo.MostrarPopup = Convert.ToBoolean(data.mostrarPopup);
            modelo.MostrarPopupVenta = Convert.ToBoolean(data.mostrarPopupVenta);

            return modelo;
        }

        public ShowRoomEventoConsultoraModel ObtenerEventoConsultoraApi(string pais, int codigoCampania, string codigoConsultora)
        {
            UsuarioModel userData = _sessionManager.GetUserData();

            string requestUrl = string.Format(
                Constantes.PersonalizacionOfertasService.UrlObtenerEventoConsultora,
                pais,
                codigoCampania,
                codigoConsultora);

            Task<string> taskApi = Task.Run(() => RespSBMicroservicios(string.Empty, requestUrl, "get", userData, "SEARCH"));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            GenericResponse respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                throw new Exception(respuesta.Message);
            }

            ShowRoomEventoConsultoraModel modelo = new ShowRoomEventoConsultoraModel();

            if (respuesta.Result != null)
            {
                dynamic eventoConsultora = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(respuesta.Result.ToString());
                modelo.EventoConsultoraID = Convert.ToInt32(eventoConsultora.eventoConsultoraId);
                modelo.EventoID = Convert.ToInt32(eventoConsultora.eventoId);
                modelo.CampaniaID = Convert.ToInt32(eventoConsultora.campaniaId);
                modelo.CodigoConsultora = eventoConsultora.codigoConsultora;
                modelo.Segmento = eventoConsultora.segmento;
                modelo.MostrarPopup = Convert.ToBoolean(eventoConsultora.mostrarPopup);
                modelo.MostrarPopupVenta = Convert.ToBoolean(eventoConsultora.mostrarPopupVenta);
                return modelo;
            }

            return null;
        }

        public List<ShowRoomNivelModel> ObtenerNivelApi(string pais)
        {
            UsuarioModel userData = _sessionManager.GetUserData();

            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerNivel, pais);

            Task<string> taskApi = Task.Run(() => RespSBMicroservicios(string.Empty, requestUrl, "get", userData, "SEARCH"));
            Task.WhenAll(taskApi);
            string content = taskApi.Result;

            GenericResponse respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                throw new Exception(respuesta.Message);
            }

            List<dynamic> resultado = Newtonsoft.Json.JsonConvert.DeserializeObject<List<dynamic>>(respuesta.Result.ToString());

            List<ShowRoomNivelModel> niveles = new List<ShowRoomNivelModel>();
            foreach (dynamic nivel in resultado)
            {
                ShowRoomNivelModel modelo = new ShowRoomNivelModel
                {
                    NivelId = Convert.ToInt32(nivel.nivelId),
                    Codigo = nivel.codigo,
                    Descripcion = nivel.descripcion
                };
                niveles.Add(modelo);
            }

            return niveles;
        }

        public void ActualizarEventoConsultora(BEShowRoomEventoConsultora entidad, string tipoShowRoom)
        {
            UsuarioModel userData = _sessionManager.GetUserData();

            if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
            {
                string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlEditarEventoConsultora, userData.CodigoISO, tipoShowRoom);

                WaEventoConsultora eventoConsultora =
                    new WaEventoConsultora { UsuarioModificacion = userData.UsuarioNombre, EventoConsultoraId = entidad.EventoConsultoraID };

                string jsonParameters = JsonConvert.SerializeObject(eventoConsultora);
                Task<string> taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, "put", userData, "CONFIG"));
                Task.WhenAll(taskApi);
                string content = taskApi.Result;

                GenericResponse respuesta = JsonConvert.DeserializeObject<GenericResponse>(content);

                if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                    throw new Exception(respuesta.Message);
            }
            else
            {
                using (PedidoServiceClient sac = new PedidoServiceClient())
                {
                    sac.UpdEventoConsultoraPopup(userData.PaisID, entidad, tipoShowRoom);
                }
            }
        }

        private static async Task<string> RespSBMicroservicios(string jsonParametros, string requestUrlParam, string responseType, UsuarioModel userData, string urlBase)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = string.Empty;
                if (urlBase == "CONFIG")
                    url = WebConfig.UrlMicroservicioPersonalizacionConfig;
                else
                    url = WebConfig.UrlMicroservicioPersonalizacionSearch;

                client.BaseAddress = new Uri(url);
                string jsonString = jsonParametros;

                StringContent httpContent = new StringContent(jsonString, Encoding.UTF8, "application/json");
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
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ShowRoomProvider_RespSBMicroservicios:" + response.StatusCode.ToString()), userData.CodigoConsultora, userData.CodigoISO);
                    return string.Empty;
                }

                if (response == null) return string.Empty;
                string content = await response.Content.ReadAsStringAsync();

                if (!string.IsNullOrEmpty(content)) return content;
                LogManager.LogManager.LogErrorWebServicesBus(new Exception("ShowRoomProvider_RespSBMicroservicios: Null content"), userData.CodigoConsultora, userData.CodigoISO);
                return string.Empty;
            }
        }
    }
}