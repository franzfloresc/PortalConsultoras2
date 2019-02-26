
using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    using Portal.Consultoras.Common.Response;
    using Portal.Consultoras.Web.Models.Estrategia;
    using Portal.Consultoras.Web.Models.Search.ResponseEvento;
    using Portal.Consultoras.Web.Models.Search.ResponseNivel;
    using System;
    using System.Text;

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
        const int SHOWROOM_ESTADO_ACTIVO = 1;

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
            var pl50configs = _tablaLogicaProvider.ObtenerConfiguracion(paisId, Pl50Key);
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
            try
            {
                if (UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    ShowRoomEventoConsultoraModel eventoConsultora = ObtenerEventoConsultoraApi(model.CodigoISO, model.CampaniaID, model.GetCodigoConsultora());

                    if (eventoConsultora == null)
                    {
                        eventoConsultora = RegistrarEventoConsultoraApi(showRoomEventoModel.EventoID, false);
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
            catch
            {
                return null;
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

        private OutputEvento ApiEventoPersonalizacion(UsuarioModel model)
        {
            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerEvento, model.CodigoISO, model.CampaniaID);

            Task<string> taskApi = Task.Run(() => RespSBMicroservicios(string.Empty,
                                                                  requestUrl,
                                                                  Constantes.MetodosHTTP.Get,
                                                                  model,
                                                                  Constantes.MicroServicio.PersonalizacionSearch));
            Task.WhenAll(taskApi);
            string jsonString = taskApi.Result;

            try
            {
                OutputEvento respuesta = JsonConvert.DeserializeObject<OutputEvento>(jsonString);

                if (respuesta == null)
                {
                    return new OutputEvento();
                }

                if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                {
                    Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, model.CodigoISO);
                    return new OutputEvento();
                }

                return respuesta;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO, "ShowroomProvider.ApiEventoPersonalizacion");
                return new OutputEvento();
            }
        }

        private ShowRoomEventoModel ObtieneEventoModel(IList<Models.Search.ResponseEvento.Estructura.Evento> eventoConsultora)
        {
            ShowRoomEventoModel modelo = new ShowRoomEventoModel();
            if (eventoConsultora == null)
            {
                return modelo;
            }

            try
            {
                foreach (Models.Search.ResponseEvento.Estructura.Evento evento in eventoConsultora)
                {
                    modelo.CampaniaID = evento.CampaniaId;
                    modelo.DiasAntes = evento.DiasAntes;
                    modelo.DiasDespues = evento.DiasDespues;
                    modelo.Estado = evento.Estado;
                    modelo.EventoID = evento.EventoId;
                    modelo.Nombre = evento.Nombre;
                    modelo.NumeroPerfiles = evento.NumeroPerfiles;
                    modelo.Tema = evento.Tema;
                    modelo.TieneCategoria = Convert.ToBoolean(evento.TieneCategoria);
                    modelo.TieneCompraXcompra = Convert.ToBoolean(evento.TieneCompraXcompra);
                    modelo.TienePersonalizacion = Convert.ToBoolean(evento.TienePersonalizacion);
                    modelo.TieneSubCampania = Convert.ToBoolean(evento.TieneSubCampania);
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, string.Empty);
                return modelo;
            }
            return modelo;
        }

        private List<ShowRoomPersonalizacionModel> ObtienePersonalizacionesModel(IList<Models.Search.ResponseEvento.Estructura.PersonalizacionNivel> personalizacionConsultora)
        {
            List<ShowRoomPersonalizacionModel> modelo = new List<ShowRoomPersonalizacionModel>();
            if (personalizacionConsultora == null)
            {
                return modelo;
            }

            try
            {
                foreach (Models.Search.ResponseEvento.Estructura.PersonalizacionNivel personalizacionNivel in personalizacionConsultora)
                {
                    ShowRoomPersonalizacionModel personalizacion = new ShowRoomPersonalizacionModel
                    {
                        PersonalizacionId = personalizacionNivel.PersonalizacionId,
                        TipoAplicacion = personalizacionNivel.TipoAplicacion,
                        Atributo = personalizacionNivel.Atributo,
                        TextoAyuda = personalizacionNivel.TextoAyuda,
                        TipoAtributo = personalizacionNivel.TipoAtributo,
                        TipoPersonalizacion = personalizacionNivel.TipoPersonalizacion,
                        Orden = personalizacionNivel.Orden,
                        Estado = Convert.ToBoolean(personalizacionNivel.Estado),
                        Valor = personalizacionNivel.Valor,
                        NivelId = personalizacionNivel.NivelId
                    };

                    modelo.Add(personalizacion);
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, string.Empty);
                return modelo;
            }

            return modelo;
        }

        public void CargarNivelShowRoom(UsuarioModel model)
        {
            var configEstrategiaSR = _sessionManager.GetEstrategiaSR() ?? new ConfigModel();
            try
            {
                if (!configEstrategiaSR.CargoEntidadNivel)
                {
                    configEstrategiaSR.ListaNivel = GetShowRoomNivel(model);
                    configEstrategiaSR.ShowRoomNivelId = (configEstrategiaSR.ListaNivel != null && configEstrategiaSR.ListaNivel.Count > 0) ?
                                                            ObtenerNivelId(configEstrategiaSR.ListaNivel) : 0;

                    configEstrategiaSR.CargoEntidadNivel = configEstrategiaSR.ListaNivel != null &&
                                                           configEstrategiaSR.ShowRoomNivelId != 0;
                    _sessionManager.SetEstrategiaSR(configEstrategiaSR);
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                configEstrategiaSR.CargoEntidadEventoConsultora = false;
                configEstrategiaSR.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            }
        }

        public void CargarEventoConsultora(UsuarioModel model)
        {
            var configEstrategiaSR = _sessionManager.GetEstrategiaSR() ?? new ConfigModel();

            try
            {
                if (!configEstrategiaSR.CargoEntidadEventoConsultora)
                {
                    if (model.CampaniaID != 0 && configEstrategiaSR.BeShowRoomConsultora == null)
                    {
                        CargarEventoPersonalizacion(model);
                        if (configEstrategiaSR.BeShowRoom != null)
                            configEstrategiaSR.BeShowRoomConsultora = GetShowRoomConsultora(model, configEstrategiaSR.BeShowRoom);
                    }


                    configEstrategiaSR.CargoEntidadEventoConsultora = configEstrategiaSR.BeShowRoomConsultora != null;
                    _sessionManager.SetEstrategiaSR(configEstrategiaSR);
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                configEstrategiaSR.CargoEntidadEventoConsultora = false;
                configEstrategiaSR.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            }
        }

        public void CargarEventoPersonalizacion(UsuarioModel model)
        {
            var configEstrategiaSR = _sessionManager.GetEstrategiaSR() ?? new ConfigModel();
            try
            {
                if (!configEstrategiaSR.CargoEntidadEventoPersonalizacion)
                {
                    _sessionManager.SetEsShowRoom("0");
                    _sessionManager.SetMostrarShowRoomProductos("0");
                    _sessionManager.SetMostrarShowRoomProductosExpiro("0");

                    if (UsarMsPersonalizacion(model.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                    {
                        OutputEvento eventoPersonalizacions = ApiEventoPersonalizacion(model);

                        configEstrategiaSR.BeShowRoom = ObtieneEventoModel(eventoPersonalizacions.Result);
                        configEstrategiaSR.ListaPersonalizacionConsultora = ObtienePersonalizacionesModel(eventoPersonalizacions.Result.FirstOrDefault().PersonalizacionNivel);
                    }
                    else
                    {
                        configEstrategiaSR.BeShowRoom = GetShowRoomEventoByCampaniaId(model);
                        configEstrategiaSR.ListaPersonalizacionConsultora = GetShowRoomPersonalizacion(model);

                    }

                    if (model.CampaniaID != 0)
                    {
                        if (configEstrategiaSR.BeShowRoom != null &&
                            configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO)
                        {
                            CargarNivelShowRoom(model);
                            ActualizarValorPersonalizacionesShowRoom(model, configEstrategiaSR);

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
                    }
                    configEstrategiaSR.CargoEntidadEventoPersonalizacion = configEstrategiaSR.BeShowRoom != null &&
                                                                           configEstrategiaSR.ListaPersonalizacionConsultora != null;
                    _sessionManager.SetEstrategiaSR(configEstrategiaSR);
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                configEstrategiaSR.CargoEntidadEventoPersonalizacion = false;
                configEstrategiaSR.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            }
        }

        [Obsolete("Se dejará de usar este método porque se ha divido su funcionalidad: CargarEventoPersonalizacion - CargarEventoConsultora - CargarNivelShowRoom")]
        public void CargarEntidadesShowRoom(UsuarioModel model)
        {
            ConfigModel configEstrategiaSR = _sessionManager.GetEstrategiaSR() ?? new ConfigModel();
            MSPersonalizacionConfiguracionModel msPersonalizacionModel = new MSPersonalizacionConfiguracionModel();

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
                        OutputEvento eventoPersonalizacions = ApiEventoPersonalizacion(model);

                        configEstrategiaSR.BeShowRoom = ObtieneEventoModel(eventoPersonalizacions.Result);
                        configEstrategiaSR.ListaPersonalizacionConsultora = ObtienePersonalizacionesModel(eventoPersonalizacions.Result.FirstOrDefault().PersonalizacionNivel);
                    }
                }
                else
                {
                    configEstrategiaSR.BeShowRoom = GetShowRoomEventoByCampaniaId(model);
                    configEstrategiaSR.ListaPersonalizacionConsultora = GetShowRoomPersonalizacion(model);
                }

                if (model.CampaniaID != 0)
                {
                    configEstrategiaSR.BeShowRoomConsultora = GetShowRoomConsultora(model, configEstrategiaSR.BeShowRoom);
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
            if (!configEstrategiaSR.CargoEntidadEventoConsultora)
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
            if (!configEstrategiaSR.CargoEntidadEventoPersonalizacion)
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

            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerEventoConsultora, pais, codigoCampania, codigoConsultora);

            Task<string> taskApi = Task.Run(() => RespSBMicroservicios(string.Empty,
                                                                      requestUrl,
                                                                      Constantes.MetodosHTTP.Get,
                                                                      userData,
                                                                      Constantes.MicroServicio.PersonalizacionSearch));

            Task.WhenAll(taskApi);
            string jsonString = taskApi.Result;

            try
            {
                OutputEventoConsultora respuesta = JsonConvert.DeserializeObject<OutputEventoConsultora>(jsonString);

                if (respuesta == null)
                {
                    Common.LogManager.SaveLog(new Exception("Servicio no responde"), string.Empty, pais);
                    throw new Exception();
                }

                if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                {
                    Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, pais);
                    throw new Exception(respuesta.Message);
                }

                ShowRoomEventoConsultoraModel modelo = new ShowRoomEventoConsultoraModel();

                if (respuesta.Result != null && respuesta.Result.Count() > 0)
                {
                    foreach (Models.Search.ResponseEvento.Estructura.EventoConsultora eventoConsultora in respuesta.Result.DefaultIfEmpty())
                    {
                        modelo.EventoConsultoraID = eventoConsultora.EventoConsultoraId;
                        modelo.EventoID = eventoConsultora.EventoId;
                        modelo.CampaniaID = Convert.ToInt32(eventoConsultora.CampaniaId);
                        modelo.CodigoConsultora = eventoConsultora.CodigoConsultora;
                        modelo.Segmento = eventoConsultora.Segmento;
                        modelo.MostrarPopup = eventoConsultora.MostrarPopup;
                        modelo.MostrarPopupVenta = eventoConsultora.MostrarPopupVenta;
                    }

                    return modelo;
                }

                return null;

            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, pais);
                throw ex;
            }
        }

        public List<ShowRoomNivelModel> ObtenerNivelApi(string pais)
        {
            UsuarioModel userData = _sessionManager.GetUserData();
            List<ShowRoomNivelModel> niveles = new List<ShowRoomNivelModel>();

            string requestUrl = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerNivel, pais);

            Task<string> taskApi = Task.Run(() => RespSBMicroservicios(string.Empty,
                                                                       requestUrl,
                                                                       Constantes.MetodosHTTP.Get,
                                                                       userData,
                                                                       Constantes.MicroServicio.PersonalizacionSearch));
            Task.WhenAll(taskApi);
            string jsonString = taskApi.Result;

            try
            {
                OutputNivel respuesta = JsonConvert.DeserializeObject<OutputNivel>(jsonString);

                if (respuesta == null)
                {
                    return new List<ShowRoomNivelModel>();
                }

                if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
                {
                    Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, pais);
                    return new List<ShowRoomNivelModel>();
                }

                foreach (Models.Search.ResponseNivel.Estructura.Nivel nivel in respuesta.Result)
                {
                    ShowRoomNivelModel modelo = new ShowRoomNivelModel
                    {
                        NivelId = nivel.NivelId,
                        Codigo = nivel.Codigo,
                        Descripcion = nivel.Descripcion
                    };

                    niveles.Add(modelo);
                }

                return niveles;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, pais);
                return new List<ShowRoomNivelModel>();
            }
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
                Task<string> taskApi = Task.Run(() => RespSBMicroservicios(jsonParameters, requestUrl, Constantes.MetodosHTTP.Put, userData, Constantes.MicroServicio.PersonalizacionConfig));
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

                if (urlBase == Constantes.MicroServicio.PersonalizacionConfig)
                    url = WebConfig.UrlMicroservicioPersonalizacionConfig;
                else
                    url = WebConfig.UrlMicroservicioPersonalizacionSearch;

                client.BaseAddress = new Uri(url);

                StringContent httpContent = new StringContent(jsonParametros, Encoding.UTF8, "application/json");
                HttpResponseMessage httpResponse = null;
                string requestUrl = requestUrlParam;

                if (responseType.Equals(Constantes.MetodosHTTP.Get))
                {
                    string completeRequestUrl = string.Format("{0}{1}", requestUrl, jsonParametros);
                    httpResponse = await client.GetAsync(completeRequestUrl);
                }
                else if (responseType.Equals(Constantes.MetodosHTTP.Put))
                {
                    httpResponse = await client.PutAsync(requestUrl, httpContent);
                }
                else if (responseType.Equals(Constantes.MetodosHTTP.Post))
                {
                    httpResponse = await client.PostAsync(requestUrl, httpContent);
                }
                else if (responseType.Equals(Constantes.MetodosHTTP.Delete))
                {
                    httpResponse = await client.DeleteAsync(requestUrl);
                }

                if (httpResponse != null && !httpResponse.IsSuccessStatusCode)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(new Exception("ShowRoomProvider_RespSBMicroservicios:" + httpResponse.StatusCode.ToString()), userData.CodigoConsultora, userData.CodigoISO);
                    return string.Empty;
                }

                if (httpResponse == null) return string.Empty;

                string jsonString = await httpResponse.Content.ReadAsStringAsync();

                if (!string.IsNullOrEmpty(jsonString)) return jsonString;

                LogManager.LogManager.LogErrorWebServicesBus(new Exception("ShowRoomProvider_RespSBMicroservicios: Null content"), userData.CodigoConsultora, userData.CodigoISO);
                return string.Empty;
            }
        }
    }
}