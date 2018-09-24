using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseController : Controller
    {
        #region Variables

        protected UsuarioModel userData
        {
            get
            {
                var model = new UsuarioModel();
                if (SessionManager != null && SessionManager.GetUserData() != null) model = SessionManager.GetUserData();
                model.MenuNotificaciones = 1;
                return model;
            }
        }
        protected RevistaDigitalModel revistaDigital
        {
            get
            {
                return SessionManager.GetRevistaDigital();
            }
        }
        protected HerramientasVentaModel herramientasVenta;
        protected GuiaNegocioModel guiaNegocio;
        protected DataModel estrategiaODD;
        protected ConfigModel configEstrategiaSR;
        protected BuscadorYFiltrosModel buscadorYFiltro;
        protected ILogManager logManager;
        protected string paisesMicroservicioPersonalizacion;
        protected string estrategiaWebApiDisponibilidadTipo;
        protected readonly TipoEstrategiaProvider _tipoEstrategiaProvider;
        protected readonly TablaLogicaProvider _tablaLogicaProvider;
        protected readonly BaseProvider _baseProvider;
        private readonly LogDynamoProvider _logDynamoProvider;
        protected readonly GuiaNegocioProvider _guiaNegocioProvider;
        protected readonly ShowRoomProvider _showRoomProvider;
        protected readonly RevistaDigitalProvider revistaDigitalProvider;
        protected readonly RevistaDigitalProvider _revistaDigitalProvider;
        protected readonly PedidoWebProvider _pedidoWebProvider;
        protected OfertaViewProvider _ofertasViewProvider;  // Mover donde se utiliza
        protected readonly OfertaPersonalizadaProvider _ofertaPersonalizadaProvider; // Mover donde se utiliza
        protected readonly OfertaDelDiaProvider _ofertaDelDiaProvider;
        protected readonly MenuContenedorProvider _menuContenedorProvider;
        protected readonly EventoFestivoProvider _eventoFestivoProvider;
        protected readonly EstrategiaComponenteProvider _estrategiaComponenteProvider;
        protected readonly ConfiguracionPaisProvider _configuracionPaisProvider;
        protected readonly ConfiguracionManagerProvider _configuracionManagerProvider;
        protected readonly AdministrarEstrategiaProvider administrarEstrategiaProvider;
        protected readonly MenuProvider _menuProvider;
        protected readonly ChatEmtelcoProvider _chatEmtelcoProvider;
        protected readonly ComunicadoProvider _comunicadoProvider;

        protected ISessionManager SessionManager
        {
            get;
            private set;
        }

        #endregion

        #region Constructor

        public BaseController() : this(Web.SessionManager.SessionManager.Instance, LogManager.LogManager.Instance)
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
            administrarEstrategiaProvider = new AdministrarEstrategiaProvider();
            _showRoomProvider = new ShowRoomProvider(_tablaLogicaProvider);
            revistaDigitalProvider = new RevistaDigitalProvider();
            _baseProvider = new BaseProvider();
            _guiaNegocioProvider = new GuiaNegocioProvider();
            _ofertaPersonalizadaProvider = new OfertaPersonalizadaProvider();
            _configuracionManagerProvider = new ConfiguracionManagerProvider();
            _ofertasViewProvider = new OfertaViewProvider();
            _revistaDigitalProvider = new RevistaDigitalProvider();
            _ofertaDelDiaProvider = new OfertaDelDiaProvider();
            _logDynamoProvider = new LogDynamoProvider();
            _eventoFestivoProvider = new EventoFestivoProvider();
            _pedidoWebProvider = new PedidoWebProvider();
            _estrategiaComponenteProvider = new EstrategiaComponenteProvider();
            _tipoEstrategiaProvider = new TipoEstrategiaProvider();
            _configuracionPaisProvider = new ConfiguracionPaisProvider();
            _menuContenedorProvider = new MenuContenedorProvider();
            _menuProvider = new MenuProvider(_configuracionManagerProvider, _eventoFestivoProvider);
            _chatEmtelcoProvider = new ChatEmtelcoProvider();
            _comunicadoProvider = new ComunicadoProvider();
        }

        public BaseController(ISessionManager sessionManager)
        {
            //userData = new UsuarioModel();
            this.SessionManager = sessionManager;
        }

        public BaseController(ISessionManager sessionManager, ILogManager logManager)
        {
            //userData = new UsuarioModel();
            SessionManager = sessionManager;
            this.logManager = logManager;
        }

        public BaseController(ISessionManager sessionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider)
        {
            //userData = new UsuarioModel();
            SessionManager = sessionManager;
            this.logManager = logManager;
            this._ofertaPersonalizadaProvider = ofertaPersonalizadaProvider;
        }

        public BaseController(ISessionManager sessionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider, OfertaViewProvider ofertaViewProvider)
        {
            //userData = new UsuarioModel();
            SessionManager = sessionManager;
            this.logManager = logManager;
            this._ofertaPersonalizadaProvider = ofertaPersonalizadaProvider;
            this._ofertaPersonalizadaProvider = ofertaPersonalizadaProvider;
            this._ofertasViewProvider = ofertaViewProvider;
        }

        public BaseController(ISessionManager sessionManager, ILogManager logManager, EstrategiaComponenteProvider estrategiaComponenteProvider)
        {
            //userData = new UsuarioModel();
            SessionManager = sessionManager;
            this.logManager = logManager;
            this._estrategiaComponenteProvider = estrategiaComponenteProvider;
        }

        #endregion

        #region Overrides

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                //userData = UserData();
                if (userData == null)
                {
                    string urlSignOut = ObtenerUrlCerrarSesion();
                    filterContext.Result = new RedirectResult(urlSignOut);
                    return;
                }

                //revistaDigital = SessionManager.GetRevistaDigital();
                herramientasVenta = SessionManager.GetHerramientasVenta();
                guiaNegocio = SessionManager.GetGuiaNegocio();
                estrategiaODD = SessionManager.OfertaDelDia.Estrategia;
                configEstrategiaSR = SessionManager.GetEstrategiaSR() ?? new ConfigModel();
                buscadorYFiltro = SessionManager.GetBuscadorYFiltros();

                if (!configEstrategiaSR.CargoEntidadesShowRoom)
                {
                    _showRoomProvider.CargarEntidadesShowRoom(userData);
                    configEstrategiaSR = SessionManager.GetEstrategiaSR();
                }
                    
                if (Request.IsAjaxRequest())
                {
                    base.OnActionExecuting(filterContext);
                    return;
                }

                ObtenerPedidoWeb();
                ObtenerPedidoWebDetalle();

                GetUserDataViewBag();

                var controllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
                var actionName = filterContext.ActionDescriptor.ActionName;
                if (!Constantes.AceptacionContrato.ControladoresOmitidas.Contains(controllerName) && !Constantes.AceptacionContrato.AcionesOmitidas.Contains(actionName))
                {
                    if (ValidarContratoPopup())
                    {
                        bool esMobile = EsDispositivoMovil();
                        filterContext.Result = !esMobile ? new RedirectResult(Url.Action("Index", "Bienvenida")) :
                            new RedirectResult(Url.Action("Index", "Bienvenida", new { Area = "Mobile" }));
                        return;
                    }
                }

                base.OnActionExecuting(filterContext);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }
        #endregion

        #region Metodos

        #region Pedido

        protected int EsOpt()
        {
            var esOpt = revistaDigital.TieneRevistaDigital() && revistaDigital.EsActiva
                    ? 1 : 2;
            return esOpt;
        }

        public virtual BEPedidoWeb ObtenerPedidoWeb()
        {
            return _pedidoWebProvider.ObtenerPedidoWeb(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
        }

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle()
        {
            return _pedidoWebProvider.ObtenerPedidoWebDetalle(EsOpt());
        }

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado(bool noSession = false)
        {
            return _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado(EsOpt(), noSession);
        }

        protected List<ObjMontosProl> ServicioProl_CalculoMontosProl(bool session = true)
        {
            var montosProl = new List<ObjMontosProl> { new ObjMontosProl() };

            if (session && SessionManager.GetMontosProl() != null)
            {
                return SessionManager.GetMontosProl();
            }

            var detallesPedidoWeb = ObtenerPedidoWebDetalle();

            if (detallesPedidoWeb.Any())
            {
                var cuvs = string.Join("|", detallesPedidoWeb.Select(p => p.CUV).ToArray());
                var cantidades = string.Join("|", detallesPedidoWeb.Select(p => p.Cantidad).ToArray());

                var ambiente = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.Ambiente);
                var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    sv.Url = ConfigurationManager.AppSettings[keyWeb];
                    montosProl = sv.CalculoMontosProlxIncentivos(userData.CodigoISO, userData.CampaniaID.ToString(), userData.CodigoConsultora, userData.CodigoZona, cuvs, cantidades, userData.CodigosConcursos).ToList();
                }
            }

            SessionManager.SetMontosProl(montosProl);

            return montosProl;
        }

        protected void InsIndicadorPedidoAutentico(BEIndicadorPedidoAutentico indPedidoAutentico, string cuv)
        {
            try
            {
                var detallesPedido = SessionManager.GetDetallesPedido();

                if (detallesPedido != null && detallesPedido.Any())
                {
                    var detallePedido = detallesPedido.FirstOrDefault(x => x.CUV == cuv);
                    if (detallePedido != null)
                    {
                        indPedidoAutentico.PedidoID = detallePedido.PedidoID;
                        indPedidoAutentico.PedidoDetalleID = detallePedido.PedidoDetalleID;

                        using (var svc = new PedidoServiceClient())
                        {
                            svc.InsIndicadorPedidoAutentico(userData.PaisID, indPedidoAutentico);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        protected void UpdPedidoWebMontosPROL()
        {
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
            var puntajes = string.Empty;
            var puntajesExigidos = string.Empty;

            userData.EjecutaProl = false;

            var lista = ServicioProl_CalculoMontosProl(false) ?? new List<ObjMontosProl>();

            if (lista.Any())
            {
                var oRespuestaProl = lista[0];

                decimal.TryParse(oRespuestaProl.AhorroCatalogo, out montoAhorroCatalogo);
                decimal.TryParse(oRespuestaProl.AhorroRevista, out montoAhorroRevista);
                decimal.TryParse(oRespuestaProl.MontoTotalDescuento, out montoDescuento);
                decimal.TryParse(oRespuestaProl.MontoEscala, out montoEscala);

                if (oRespuestaProl.ListaConcursoIncentivos != null)
                {
                    puntajes = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => c.puntajeconcurso.Split('|')[0]).ToArray());
                    puntajesExigidos = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => (c.puntajeconcurso.IndexOf('|') > -1 ? c.puntajeconcurso.Split('|')[1] : "0")).ToArray());
                }
            }

            var bePedidoWeb = new BEPedidoWeb
            {
                PaisID = userData.PaisID,
                CampaniaID = userData.CampaniaID,
                ConsultoraID = userData.ConsultoraID,
                CodigoConsultora = userData.CodigoConsultora,
                MontoAhorroCatalogo = montoAhorroCatalogo,
                MontoAhorroRevista = montoAhorroRevista,
                DescuentoProl = montoDescuento,
                MontoEscala = montoEscala
            };

            using (var sv = new PedidoServiceClient())
            {
                sv.UpdateMontosPedidoWeb(bePedidoWeb);

                if (!string.IsNullOrEmpty(userData.CodigosConcursos))
                    sv.ActualizarInsertarPuntosConcurso(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID.ToString(), userData.CodigosConcursos, puntajes, puntajesExigidos);
            }

            SessionManager.SetPedidoWeb(null);
            userData.EjecutaProl = true;
            ObtenerPedidoWeb();
        }

        protected bool ReservadoEnHorarioRestringido(out string mensaje)
        {
            try
            {
                mensaje = "";
                if (userData == null)
                {
                    mensaje = "Su sessión expiró, por favor vuelva a loguearse.";
                    SessionManager.SetUserData(null);
                    HttpContext.Session.Clear();
                    HttpContext.Session.Abandon();
                    return true;
                }

                using (var sv = new PedidoServiceClient())
                {
                    var result = sv.ValidacionModificarPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA);
                    mensaje = result.Mensaje;
                    return result.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                mensaje = "Ocurrió un error al intentar validar si puede modificar su pedido.";
                return true;
            }
        }

        protected bool ValidarPedidoReservado(out string mensaje)
        {
            mensaje = string.Empty;
            var consultoraId = userData.GetConsultoraId();

            BEConfiguracionCampania obeConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                obeConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, consultoraId, userData.ZonaID, userData.RegionID);
            }

            if (obeConfiguracionCampania != null
                && obeConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && !obeConfiguracionCampania.ModificaPedidoReservado && !obeConfiguracionCampania.ValidacionAbierta)
            {
                mensaje = "Ya tienes un pedido reservado para esta campaña.";
                return true;
            }

            return false;
        }

        protected string ValidarMontoMaximo(decimal montoCuv, int cantidad, out bool resul)
        {
            var mensaje = "";
            resul = false;
            try
            {
                if (!userData.TieneValidacionMontoMaximo)
                    return mensaje;

                if (userData.MontoMaximo == Convert.ToDecimal(9999999999.00))
                    return mensaje;


                var listaProducto = ObtenerPedidoWebDetalle();

                var totalPedido = listaProducto.Sum(p => p.ImporteTotal);
                var dTotalPedido = Convert.ToDecimal(totalPedido);
                decimal descuentoProl = 0;

                if (dTotalPedido > userData.MontoMaximo && cantidad < 0)
                {
                    resul = true;
                }

                if (listaProducto.Any())
                    descuentoProl = listaProducto[0].DescuentoProl;

                var montoActual = (montoCuv * cantidad) + (dTotalPedido - descuentoProl);
                if (montoActual > userData.MontoMaximo)
                {
                    var strmen = (userData.EsDiasFacturacion) ? "VALIDADO" : "GUARDADO";
                    mensaje = "Haz superado el límite de tu línea de crédito de " + userData.Simbolo + userData.MontoMaximo.ToString()
                            + ". Por favor modifica tu pedido para que sea " + strmen + " con éxito.";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
            }
            return mensaje;
        }

        #endregion

        #region Menu

        public List<PermisoModel> BuildMenu(UsuarioModel userData, RevistaDigitalModel revistaDigital)
        {
            if (userData.Menu != null)
            {
                ViewBag.ClaseLogoSB = userData.ClaseLogoSB;
                return _menuProvider.SepararItemsMenu(userData.Menu);
            }

            userData = _menuProvider.GetPermisosByRol(userData, revistaDigital);
            
            ViewBag.ClaseLogoSB = userData.ClaseLogoSB;
            return _menuProvider.SepararItemsMenu(userData.Menu);
        }
        
        public List<MenuMobileModel> BuildMenuMobile(UsuarioModel userData, RevistaDigitalModel revistaDigital)
        {
            if (userData == null)
                throw new ArgumentNullException("userData");

            if (revistaDigital == null)
                throw new ArgumentNullException("revistaDigital");

            if (userData.MenuMobile != null ||
                userData.RolID != Constantes.Rol.Consultora)
            {
                SetConsultoraOnlineViewBag(userData);
                return userData.MenuMobile;
            }

            bool tieneTituloCatalogo = ((revistaDigital.TieneRDC && !userData.TieneGND && !revistaDigital.EsSuscrita) || revistaDigital.TieneRDI)
                || (!revistaDigital.TieneRDC || (revistaDigital.TieneRDC && !revistaDigital.EsActiva));

            userData = _menuProvider.GetMenuMobileModel(userData, revistaDigital, Request, tieneTituloCatalogo);
            
            SetConsultoraOnlineViewBag(userData);
            return userData.MenuMobile;
        }

        private void SetConsultoraOnlineViewBag(UsuarioModel userData)
        {
            userData.ConsultoraOnlineMenuResumen = userData.ConsultoraOnlineMenuResumen ?? new ConsultoraOnlineMenuResumenModel();
            ViewBag.TipoMenuConsultoraOnline = userData.ConsultoraOnlineMenuResumen.TipoMenuConsultoraOnline;
            ViewBag.CantPedidosPendientes = userData.ConsultoraOnlineMenuResumen.CantPedidosPendientes;
            ViewBag.TeQuedanConsultoraOnline = userData.ConsultoraOnlineMenuResumen.TeQuedanConsultoraOnline;
            ViewBag.MenuHijoIDConsultoraOnline = userData.ConsultoraOnlineMenuResumen.MenuHijoIDConsultoraOnline;
            ViewBag.MenuPadreIDConsultoraOnline = userData.ConsultoraOnlineMenuResumen.MenuPadreIDConsultoraOnline;
        }
        
        private List<ServicioCampaniaModel> BuildMenuService()
        {
            _menuProvider.BuildMenuService(userData);
            return userData.MenuService;
        }
        #endregion

        #region UserData

        //public UsuarioModel UserData()
        //{
        //    var model = SessionManager.GetUserData() ?? new UsuarioModel();

        //    model.MenuNotificaciones = 1;

        //    return model;
        //}
        
        public string GetIPCliente()
        {
            var ip = string.Empty;
            try
            {
                var ipAddress = string.Empty;

                if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
                {
                    ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
                }

                else if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"] != null && System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"].Length != 0)
                {
                    ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"];
                }

                else if (!string.IsNullOrEmpty(System.Web.HttpContext.Current.Request.UserHostAddress))
                {
                    ipAddress = System.Web.HttpContext.Current.Request.UserHostName;
                }

                if (ipAddress != null)
                {
                    var indOf = ipAddress.IndexOf(":");
                    if (indOf > 0)
                    {
                        ipAddress = ipAddress.Substring(0, indOf - 1);
                    }
                }

                return ipAddress;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return ip;
        }
        
        #endregion

        #region Facturacion Electronica
        public string GetDatosFacturacionElectronica(int paidID, short TablaLogicaID, string codigo)
        {
            try
            {
                List<BETablaLogicaDatos> datos;
                using (var sv = new SACServiceClient())
                    datos = sv.GetTablaLogicaDatos(userData.PaisID, TablaLogicaID).ToList() ?? new List<BETablaLogicaDatos>();
                if (datos.Count != 0)
                    return datos.Where(a => a.Codigo == codigo).Select(b => b.Valor).FirstOrDefault();
                return "";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "";
            }
        }
        #endregion  

        protected BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas()
        {
            if (SessionManager.ConfiguracionProgramaNuevas != null) return SessionManager.ConfiguracionProgramaNuevas;
            try
            {
                var usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    SessionManager.ConfiguracionProgramaNuevas = sv.GetConfiguracionProgramaNuevas(usuario) ?? new BEConfiguracionProgramaNuevas();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                SessionManager.ConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas();
            }
            return SessionManager.ConfiguracionProgramaNuevas;
        }

        protected string GetCuvKitNuevas()
        {
            if (SessionManager.CuvKitNuevas != null) return SessionManager.CuvKitNuevas;
            try
            {
                var usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    SessionManager.CuvKitNuevas = sv.GetCuvKitNuevas(usuario, GetConfiguracionProgramaNuevas()) ?? "";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                SessionManager.CuvKitNuevas = "";
            }
            return SessionManager.CuvKitNuevas;
        }
        
        private BarraTippingPoint GetTippingPoint(string TippingPointStr, string codigoPrograma)
        {
            string nivel = Convert.ToString(userData.ConsecutivoNueva + 1).PadLeft(2, '0');
            try
            {
                BEActivarPremioNuevas beActive;
                ServicePedido.BEEstrategia estrategia;

                using (var sv = new PedidoServiceClient())
                {
                    beActive = sv.GetActivarPremioNuevas(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                    if (beActive == null || !beActive.ActiveTooltip) return new BarraTippingPoint();

                    estrategia = sv.GetEstrategiaPremiosTippingPoint(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);                    
                }
                if (estrategia == null) return new BarraTippingPoint();

                var tippingPoint = Mapper.Map<BarraTippingPoint>(beActive);
                tippingPoint = Mapper.Map(estrategia, tippingPoint);
                tippingPoint.LinkURL = getUrlTippingPoint(estrategia.ImagenURL);
                tippingPoint.TippingPointMontoStr = TippingPointStr;
                return tippingPoint;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new BarraTippingPoint();
            }
        }

        private string getUrlTippingPoint(string noImagen)
        {
            /*
              string url = string.Format
                        ("{0}/{1}/{2}/{3}/{4}/{5}",
                            _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_S3),
                            _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.BUCKET_NAME),
                            _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ROOT_DIRECTORY),
                            _configuracionManagerProvider.GetConfiguracionManager(ConfigurationManager.AppSettings["Matriz"] ?? ""),
                            userData.CodigoISO ?? "",
                            noImagen ?? ""
                         );
             */
            string urlExtension = string.Format("{0}/{1}", _configuracionManagerProvider.GetConfiguracionManager(ConfigurationManager.AppSettings["Matriz"] ?? ""), userData.CodigoISO ?? "");
            string url = ConfigCdn.GetUrlFileCdn(urlExtension, noImagen ?? "");
            return url;
        }

        public BarraConsultoraModel GetDataBarra(bool inEscala = true, bool inMensaje = false, bool Agrupado = false)
        {
            var objR = new BarraConsultoraModel
            {
                ListaEscalaDescuento = new List<BarraConsultoraEscalaDescuentoModel>(),
                ListaMensajeMeta = new List<BEMensajeMetaConsultora>(),
                TippingPointBarra = new BarraTippingPoint()
            };

            try
            {
                var rtpa = ServicioProl_CalculoMontosProl(userData.EjecutaProl);
                userData.EjecutaProl = true;

                if (!rtpa.Any())
                    return objR;

                var obj = rtpa[0];

                #region Tipping Point

                objR.TippingPointStr = "";
                objR.TippingPoint = 0;
                if (userData.MontoMaximo > 0)
                {
                    var tippingPoint = GetConfiguracionProgramaNuevas();
                    if (tippingPoint.IndExigVent == "1")
                    {
                        objR.TippingPoint = tippingPoint.MontoVentaExigido;
                        objR.TippingPointStr = Util.DecimalToStringFormat(objR.TippingPoint, userData.CodigoISO);
                        if (objR.TippingPoint > 0) objR.TippingPointBarra = GetTippingPoint(objR.TippingPointStr, tippingPoint.CodigoPrograma);
                    }
                }

                #endregion

                objR.MontoMaximo = 0;
                objR.MontoEscala = 0;
                objR.MontoDescuento = 0;

                objR.MontoMinimoStr = Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO);
                objR.MontoMinimo = userData.MontoMinimo;

                objR.MontoMaximoStr = Util.ValidaMontoMaximo(userData.MontoMaximo, userData.CodigoISO);
                if (objR.MontoMaximoStr != "")
                    objR.MontoMaximo = userData.MontoMaximo;

                objR.MontoEscalaStr = Util.DecimalToStringFormat(obj.MontoEscala, userData.CodigoISO);
                objR.MontoDescuentoStr = Util.DecimalToStringFormat(obj.MontoTotalDescuento, userData.CodigoISO);
                if (objR.MontoEscalaStr != "")
                    objR.MontoEscala = decimal.Parse(obj.MontoEscala);
                if (objR.MontoDescuentoStr != "")
                    objR.MontoDescuento = decimal.Parse(obj.MontoTotalDescuento);

                objR.MontoAhorroCatalogoStr = Util.DecimalToStringFormat(obj.AhorroCatalogo, userData.CodigoISO);
                if (objR.MontoAhorroCatalogoStr != "")
                    objR.MontoAhorroCatalogo = decimal.Parse(obj.AhorroCatalogo);

                objR.MontoAhorroRevistaStr = Util.DecimalToStringFormat(obj.AhorroRevista, userData.CodigoISO);
                if (objR.MontoAhorroRevistaStr != "")
                    objR.MontoAhorroRevista = decimal.Parse(obj.AhorroRevista);

                objR.MontoGanancia = objR.MontoAhorroCatalogo + objR.MontoAhorroRevista;
                objR.MontoGananciaStr = Util.DecimalToStringFormat(objR.MontoGanancia, userData.CodigoISO);

                List<BEPedidoWebDetalle> listProducto;
                if (Agrupado)
                {
                    listProducto = ObtenerPedidoWebSetDetalleAgrupado();
                    ObtenerPedidoWebDetalle();
                }
                else
                {
                    listProducto = ObtenerPedidoWebDetalle();
                }

                objR.TotalPedido = listProducto.Sum(d => d.ImporteTotal);
                objR.TotalPedidoStr = Util.DecimalToStringFormat(objR.TotalPedido, userData.CodigoISO);

                objR.CantidadProductos = listProducto.Sum(p => p.Cantidad);
                objR.CantidadCuv = listProducto.Count;

                #region listaEscalaDescuento
                var listaEscalaDescuento = new List<BEEscalaDescuento>();
                if (inEscala)
                {
                    listaEscalaDescuento = GetListaEscalaDescuento() ?? new List<BEEscalaDescuento>();
                }

                foreach (var escala in listaEscalaDescuento)
                {
                    objR.ListaEscalaDescuento.Add(new BarraConsultoraEscalaDescuentoModel
                    {
                        MontoDesde = escala.MontoDesde,
                        MontoDesdeStr = Util.DecimalToStringFormat(escala.MontoDesde, userData.CodigoISO),
                        MontoHasta = escala.MontoHasta,
                        MontoHastaStr = Util.DecimalToStringFormat(escala.MontoHasta, userData.CodigoISO),
                        PorDescuento = escala.PorDescuento,
                    });
                }
                #endregion

                #region Mensajes
                objR.ListaMensajeMeta = new List<BEMensajeMetaConsultora>();
                if (inMensaje)
                    objR.ListaMensajeMeta = GetMensajeMetaConsultora(Constantes.ConstSession.MensajeMetaConsultora, "") ?? new List<BEMensajeMetaConsultora>();

                #endregion
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return objR;
        }

        private List<BEEscalaDescuento> GetListaEscalaDescuento()
        {
            List<BEEscalaDescuento> listaEscalaDescuento;

            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    listaEscalaDescuento = sv.GetEscalaDescuento(userData.PaisID).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaEscalaDescuento = new List<BEEscalaDescuento>();
            }

            return listaEscalaDescuento;
        }

        private List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(string constSession, string tipoMensaje)
        {
            constSession = constSession ?? "";
            constSession = constSession.Trim();
            if (constSession == "")
                return new List<BEMensajeMetaConsultora>();

            if (Session[constSession] != null)
                return (List<BEMensajeMetaConsultora>)Session[constSession];

            try
            {
                List<BEMensajeMetaConsultora> lista;
                var entity = new BEMensajeMetaConsultora { TipoMensaje = tipoMensaje ?? "" };
                using (var sv = new PedidoServiceClient())
                {
                    lista = sv.GetMensajeMetaConsultora(userData.PaisID, entity).ToList();
                }

                Session[constSession] = lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[constSession] = new List<BEMensajeMetaConsultora>();
            }

            return (List<BEMensajeMetaConsultora>)Session[constSession];
        }

        protected bool ValidarContratoPopup()
        {
            return userData.EsConsultora() && userData.CambioClave == 0 && userData.IndicadorContrato == 0 &&
                userData.CodigoISO.Equals(Constantes.CodigosISOPais.Colombia) &&
                SessionManager.GetIsContrato() == 1 && !SessionManager.GetAceptoContrato();
        }
        #endregion
        
        #region LogDynamo

        protected void RegistrarLogDynamoDB(string aplicacion, string rol, string pantallaOpcion, string opcionAccion, ServiceUsuario.BEUsuario entidad = null)
        { 
            string ipCliente = GetIPCliente();
            bool esMobile = EsDispositivoMovil();
            _logDynamoProvider.RegistrarLogDynamoDB(userData, aplicacion, rol, pantallaOpcion, opcionAccion, ipCliente, esMobile);
        }

        protected void ActualizarDatosLogDynamoDB(MisDatosModel p_modelo, string p_origen, string p_aplicacion, string p_Accion, string p_CodigoConsultoraBuscado = "", string p_Seccion = "")
        {
            bool esMobile = EsDispositivoMovil();
            _logDynamoProvider.ActualizarDatosLogDynamoDB(userData, esMobile, p_modelo, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, p_Seccion);
        }

        protected void EjecutarLogDynamoDB(string campomodificacion, string valoractual, string valoranterior, string origen, string aplicacion, string accion, string codigoconsultorabuscado, string seccion = "")
        {
            _logDynamoProvider.EjecutarLogDynamoDB(
                userData,
                EsDispositivoMovil(),
                campomodificacion,
                valoractual,
                valoranterior,
                origen,
                aplicacion,
                accion,
                codigoconsultorabuscado,
                seccion
            );
        }

        protected void RegistrarLogGestionSacUnete(string solicitudId, string pantalla, string accion)
        {
            _logDynamoProvider.RegistrarLogGestionSacUnete(userData, solicitudId, pantalla, accion);
        }
        
        public void RegistrarLogDynamoCambioClave(string accion, string consultora, string v_valoractual, string v_valoranterior, string Ruta, string Seccion)
        {
            bool esMobile = EsDispositivoMovil();
            _logDynamoProvider.RegistrarLogDynamoCambioClave(userData, esMobile, accion, consultora, v_valoractual, v_valoranterior, Ruta, Seccion);
        }
        
        public void RegistraLogDynamoCDR(MisReclamosModel model)
        {
            bool esMobile = EsDispositivoMovil();
            _logDynamoProvider.RegistraLogDynamoCDR(userData, esMobile, model);
        }

        #endregion

        protected JsonResult ErrorJson(string message, bool allowGet = false)
        {
            return Json(new { success = false, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }

        protected JsonResult SuccessJson(string message, bool allowGet = false)
        {
            return Json(new { success = true, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }
        
        public bool ValidarPermiso(string codigo, string codigoConfig = "")
        {
            codigo = Util.Trim(codigo).ToLower();
            codigoConfig = Util.Trim(codigoConfig);

            var listaConfigPais = SessionManager.GetConfiguracionesPaisModel();
            ConfiguracionPaisModel existe;

            if (codigoConfig != "" && codigo == "")
            {
                existe = listaConfigPais.FirstOrDefault(c => c.Codigo == codigoConfig) ?? new ConfiguracionPaisModel();
                return !(existe.ConfiguracionPaisID == 0 || !existe.Estado);
            }

            if (codigo == "") return false;

            if (codigo == Constantes.MenuCodigo.RevistaDigitalSuscripcion.ToLower())
            {
                existe = listaConfigPais.FirstOrDefault(c => c.Codigo == Constantes.ConfiguracionPais.RevistaDigitalSuscripcion) ?? new ConfiguracionPaisModel();
                if (existe.ConfiguracionPaisID == 0 || !existe.Estado)
                    return false;
                return true;
            }

            if (codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower())
            {
                if (userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida)
                    return false;
                if (revistaDigital.TieneRevistaDigital())
                    return false;
                return true;
            }

            return false;
        }
        
        public virtual bool IsMobile()
        {
            var result = false;
            try
            {
                var url = HttpContext.Request.Url != null ? HttpContext.Request.Url.AbsolutePath : null;

                var urlReferrer = HttpContext.Request.UrlReferrer != null ?
                    Util.Trim(HttpContext.Request.UrlReferrer.LocalPath) :
                    Util.Trim(HttpContext.Request.FilePath);

                url = (url ?? urlReferrer).Replace("#", "/").ToLower() + "/";

                result = url.Contains("/mobile/") || url.Contains("/g/");

                if (result)
                    return result;

                var headers = HttpContext.Request.Headers;
                var value = Convert.ToString(headers["isMobile"]);
                bool.TryParse(value,out result);

            }
            catch
            {
                //
            }

            return result;
        }
        
        public MobileAppConfiguracionModel MobileAppConfiguracion
        {
            get
            {
                return this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");
            }
        }

        /// <summary>
        /// Genera un codigo equivalente(inicial 4) para pedidos mobile generados desde el app
        /// </summary>
        /// <param name="origenActual">Pedido origen actual</param>
        /// <returns>Codigo de origen referente al app mobile</returns>
        protected int ProcesarOrigenPedido(int origenActual)
        {
            if (!MobileAppConfiguracion.EsAppMobile) return origenActual;
            if (origenActual.ToString().StartsWith("2") || origenActual.ToString().StartsWith("0"))
            {
                var nuevoOrigen = origenActual.ToString()
                .Remove(0, 1)
                .Insert(0, "4");

                origenActual = int.Parse(nuevoOrigen);
            }

            return origenActual;
        }
        
        #region Obtener URL Cerrar Sesion

        private string ObtenerUrlCerrarSesion()
        {
            string URLSignOut = string.Empty;
            if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().Contains(Request.Url.Host))
                URLSignOut = "/Login/SesionExpirada";
            else
                URLSignOut = "/Login/UserUnknown";

            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();

            return URLSignOut;
        }

        #endregion

        #region Cargar ViewBag

        private void GetUserDataViewBag()
        {
            var esMobile = IsMobile();

            ViewBag.EstadoInscripcionEpm = revistaDigital.EstadoRdcAnalytics;
            ViewBag.UsuarioNombre = (Util.Trim(userData.Sobrenombre) == "" ? userData.NombreConsultora : userData.Sobrenombre);
            ViewBag.Usuario = "Hola, " + userData.UsuarioNombre;
            ViewBag.Rol = userData.RolID;
            ViewBag.Campania = Util.NombreCampania(userData.NombreCorto);
            ViewBag.CampaniaCodigo = userData.CampaniaID;
            ViewBag.NombrePais = userData.NombrePais;
            ViewBag.UrlAyuda = string.IsNullOrEmpty(userData.UrlAyuda) ? string.Empty : userData.UrlAyuda;
            ViewBag.UrlCapedevi = string.IsNullOrEmpty(userData.UrlCapedevi) ? string.Empty : userData.UrlCapedevi;
            ViewBag.UrlTerminos = string.IsNullOrEmpty(userData.UrlTerminos) ? string.Empty : Url + userData.UrlTerminos;
            ViewBag.CodigoZonaConsultora = userData.CodigoZona;
            ViewBag.RolAnalytics = userData.RolDescripcion;
            ViewBag.EdadAnalytics = Util.Edad(userData.FechaNacimiento);
            ViewBag.ZonaAnalytics = userData.CodigoZona;
            ViewBag.PaisAnalytics = userData.CodigoISO;
            ViewBag.CodigoISODL = userData.CodigoISO;
            ViewBag.MensajeAniversario = string.Empty;
            ViewBag.MensajeCumpleanos = string.Empty;
            ViewBag.IndicadorPermisoFIC = userData.IndicadorPermisoFIC;
            ViewBag.IndicadorPermisoFlexipago = userData.IndicadorPermisoFlexipago;
            ViewBag.RegionAnalytics = userData.CodigorRegion;
            ViewBag.SegmentoAnalytics = userData.Segmento != null && userData.Segmento != ""
                ? (string.IsNullOrEmpty(userData.Segmento) ? string.Empty : userData.Segmento.ToString().Trim())
                : "(not available)";
            ViewBag.esConsultoraLiderAnalytics = userData.esConsultoraLider ? "Socia" : userData.RolDescripcion;
            ViewBag.SeccionAnalytics = userData.SeccionAnalytics != null && userData.SeccionAnalytics != "" ? userData.SeccionAnalytics : "(not available)";
            ViewBag.CodigoConsultoraDL = userData.CodigoConsultora != null && userData.CodigoConsultora != "" ? userData.CodigoConsultora : "(not available)";
            ViewBag.SegmentoConstancia = userData.SegmentoConstancia != null && userData.SegmentoConstancia != "" ? userData.SegmentoConstancia.Trim() : "(not available)";
            ViewBag.DescripcionNivelAnalytics = userData.DescripcionNivel != null && userData.DescripcionNivel != "" ? userData.DescripcionNivel : "(not available)";
            ViewBag.MensajeChat = userData.MensajeChat;
            

            if (userData.RolID == Constantes.Rol.Consultora)
            {
                if (userData.ConsultoraNueva != Constantes.EstadoActividadConsultora.Registrada && userData.ConsultoraNueva != Constantes.EstadoActividadConsultora.Ingreso_Nueva &&
                    userData.NombreCorto != null && userData.AnoCampaniaIngreso.Trim() != "")
                {
                    int campaniaActual = int.Parse(userData.NombreCorto);
                    int campaniaIngreso = int.Parse(userData.AnoCampaniaIngreso);
                    int diferencia = campaniaActual - campaniaIngreso;
                    if (diferencia >= 12 && userData.AnoCampaniaIngreso.Trim().EndsWith(userData.NombreCorto.Trim().Substring(4)))
                    {
                        ViewBag.MensajeAniversario = string.Format("!Feliz Aniversario {0}!", (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.PrimerNombre + " " + userData.PrimerApellido : userData.Sobrenombre));
                    }
                }

                if (userData.FechaNacimiento.Date != DateTime.Now.Date &&
                    userData.FechaNacimiento.Month == DateTime.Now.Month && userData.FechaNacimiento.Day == DateTime.Now.Day)
                {
                    ViewBag.MensajeCumpleanos = string.Format("!Feliz Cumpleaños {0}!", (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.PrimerNombre + " " + userData.PrimerApellido : userData.Sobrenombre));
                }
            }

            ViewBag.Dias = Util.GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            ViewBag.PeriodoAnalytics = userData.FechaHoy >= userData.FechaInicioCampania.Date && userData.FechaHoy <= userData.FechaFinCampania.Date ? "Facturacion" : "Venta";
            ViewBag.SemanaAnalytics = "No Disponible";

            #region mensaje Cierre Campania y fecha promesa

            DateTime FechaHoraActual = DateTime.Now.AddHours(userData.ZonaHoraria);
            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var TextoPromesaEspecial = false;
            var TextoPromesa = ".";
            var TextoNuevoPROL = "";

            if (!userData.ZonaValida) ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + Util.FormatearHora(HoraCierrePortal) + "</b>";
            else if (!userData.DiaPROL)
            {
                ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + Util.FormatearHora(HoraCierrePortal) + "</b>";
                if (!("BO CL VE").Contains(userData.CodigoISO)) TextoNuevoPROL = " Revisa tus notificaciones o correo y verifica que tu pedido esté completo.";
            }
            else
            {
                if (userData.DiasCampania != 0 && FechaHoraActual < userData.FechaInicioCampania)
                {
                    ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + Util.FormatearHora(HoraCierrePortal) + "</b>";
                }
                else
                {
                    ViewBag.MensajeCierreCampania = "Pasa o modifica tu pedido hasta el día de <b>hoy a las " + Util.FormatearHora(HoraCierrePortal) + "</b>";
                }
            }

            if (userData.TipoCasoPromesa != "0")
            {
                if (userData.TipoCasoPromesa == "1" && userData.DiasCasoPromesa != -1)
                {
                    TextoPromesa = " y recíbelo en ";
                    TextoPromesa += userData.DiasCasoPromesa.ToString() + (userData.DiasCasoPromesa == 1 ? " día." : " días.");
                }
                else if (("2 3 4").Contains(userData.TipoCasoPromesa) && userData.DiasCasoPromesa != -1) //casos 2,3 y 4
                {
                    userData.FechaPromesaEntrega = FechaHoraActual.AddDays(userData.DiasCasoPromesa);
                    if (TextoPromesaEspecial)
                        TextoPromesa = " Recibirás tu pedido el <b>" + userData.FechaPromesaEntrega.Day + " de " + Util.NombreMes(userData.FechaPromesaEntrega.Month) + "</b>.";

                    else
                        TextoPromesa = " y recíbelo el <b>" + userData.FechaPromesaEntrega.Day + " de " + Util.NombreMes(userData.FechaPromesaEntrega.Month) + "</b>.";
                }
            }

            ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa + TextoNuevoPROL;
            ViewBag.MensajeFechaPromesa = _baseProvider.GetFechaPromesa(HoraCierrePortal, ViewBag.Dias, userData.FechaInicioCampania, esMobile);

            #endregion

            ViewBag.FechaFacturacionPedido = userData.FechaFacturacion.Day + " de " + Util.NombreMes(userData.FechaFacturacion.Month);
            ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", userData.NombreConsultora.ToUpper(), userData.CodigoISO, userData.CodigoConsultora, userData.EMail, (userData.Telefono ?? "").Trim() + ((userData.Celular ?? "").Trim() == string.Empty ? "" : "; " + (userData.Celular ?? "").Trim()));
            ViewBag.QSBR = ViewBag.QSBR.Replace("\n", "").Trim();

            ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
            ViewBag.NombreC = userData.PrimerNombre;
            ViewBag.ApellidoC = userData.PrimerApellido;
            ViewBag.CorreoC = userData.EMail;
            ViewBag.Lider = userData.Lider;
            ViewBag.PortalLideres = userData.PortalLideres;
            ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + userData.CodigoISO];
            ViewBag.FormatDecimalPais = _baseProvider.GetFormatDecimalPais(userData.CodigoISO);
            ViewBag.OfertaFinal = userData.OfertaFinal;
            ViewBag.CatalogoPersonalizado = userData.CatalogoPersonalizado;
            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.ConsultoraId = userData.ConsultoraID;
            ViewBag.CodigoUsuario = userData.CodigoUsuario;

            string paisesConTrackingJetlore = ConfigurationManager.AppSettings.Get("PaisesConTrackingJetlore") ?? "";
            ViewBag.PaisesConTrackingJetlore = paisesConTrackingJetlore.Contains(userData.CodigoISO) ? "1" : "0";
            ViewBag.EsCatalogoPersonalizadoZonaValida = userData.EsCatalogoPersonalizadoZonaValida;

            #region Banner

            try
            {
                // Postulante
                ViewBag.MostrarBannerPostulante = false;
                if (userData.TipoUsuario == 2 && userData.CerrarBannerPostulante == 0)
                {
                    ViewBag.MostrarBannerPostulante = true;
                }

                //GPR
                ViewBag.IndicadorGPRSB = userData.IndicadorGPRSB;      //0=OK,1=Facturando,2=Rechazado
                ViewBag.CerrarRechazado = userData.CerrarRechazado;
                ViewBag.MostrarBannerRechazo = userData.MostrarBannerRechazo;

                ViewBag.GPRBannerTitulo = userData.GPRBannerTitulo ?? "";
                ViewBag.GPRBannerMensaje = userData.GPRBannerMensaje ?? "";
                ViewBag.GPRBannerUrl = userData.GPRBannerUrl;

                // odd
                ViewBag.OfertaDelDia = _ofertaDelDiaProvider.GetOfertaDelDiaConfiguracion(userData);
                ViewBag.TieneOfertaDelDia = _ofertaDelDiaProvider.CumpleOfertaDelDia(userData, GetControllerActual());
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion Banner

            ViewBag.Efecto_TutorialSalvavidas = ConfigurationManager.AppSettings.Get("Efecto_TutorialSalvavidas") ?? "1";
            ViewBag.ModificarPedidoProl = 0;
            ViewBag.TipoUsuario = userData.TipoUsuario;
            ViewBag.MensajePedidoDesktop = userData.MensajePedidoDesktop;
            ViewBag.MensajePedidoMobile = userData.MensajePedidoMobile;

            #region RegaloPN
            try
            {
                ViewBag.ConsultoraTieneRegaloPN = false;
                if (userData.ConsultoraRegaloProgramaNuevas != null)
                {
                    ViewBag.ConsultoraTieneRegaloPN = true;
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion

            #region EventoFestivo

            ViewBag.SaludoFestivo = SessionManager.GetEventoFestivoDataModel().EfSaludo;

            #endregion

            ViewBag.TieneRDI = revistaDigital.TieneRDI;
            ViewBag.TieneRevistaDigital = revistaDigital.TieneRevistaDigital();
            ViewBag.EsSuscrita = revistaDigital.EsSuscrita;
            ViewBag.EsActiva = revistaDigital.EsActiva;
            ViewBag.TieneRDC = revistaDigital.TieneRDC;
            ViewBag.TieneHV = herramientasVenta.TieneHV;
            ViewBag.revistaDigital = getRevistaDigitalShortModel();
            ViewBag.variableBase = _configuracionPaisProvider.getBaseVariablesPortal(userData.CodigoISO, userData.Simbolo);

            ViewBag.TituloCatalogo = ((revistaDigital.TieneRDC && !userData.TieneGND && !revistaDigital.EsSuscrita) || revistaDigital.TieneRDI)
                || (!revistaDigital.TieneRDC || (revistaDigital.TieneRDC && !revistaDigital.EsActiva));

            var menuActivo = _menuContenedorProvider.GetMenuActivo(userData, revistaDigital, herramientasVenta, Request, guiaNegocio, SessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);
            ViewBag.MenuContenedorActivo = menuActivo;
            ViewBag.MenuContenedor = _menuContenedorProvider.GetMenuContenedorByMenuActivoCampania(menuActivo.CampaniaId, userData.CampaniaID, userData, revistaDigital, guiaNegocio, SessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);

            var menuMobile = BuildMenuMobile(userData, revistaDigital);
            var menuWeb = BuildMenu(userData, revistaDigital);
            var descLiqWeb = "";
            var existItemLiqWeb = esMobile ? _menuProvider.FindInMenu(menuMobile, m => m.Codigo.ToLower() == Constantes.MenuCodigo.LiquidacionWeb.ToLower(), m => m.Descripcion, out descLiqWeb) :
                _menuProvider.FindInMenu(menuWeb, m => m.Codigo.ToLower() == Constantes.MenuCodigo.LiquidacionWeb.ToLower(), m => m.Descripcion, out descLiqWeb);

            ViewBag.MenuMobile = menuMobile;
            ViewBag.Permiso = menuWeb;
            ViewBag.TituloLiqWeb = existItemLiqWeb ? descLiqWeb : "Liquidación Web";

            ViewBag.ProgramaBelcorpMenu = BuildMenuService();
            ViewBag.codigoISOMenu = userData.CodigoISO;

            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
            {
                ViewBag.SegmentoConsultoraMenu = 1;
            }
            else
            {
                if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    ViewBag.SegmentoConsultoraMenu = userData.SegmentoID;
                }
                else
                {
                    ViewBag.SegmentoConsultoraMenu = userData.SegmentoInternoID ?? userData.SegmentoID;
                }
            }

            var urlS3 = ConfigurationManager.AppSettings["URL_S3"] ?? "";
            if (!string.IsNullOrEmpty(urlS3))
                urlS3 = urlS3 + "/";
            var bucket = ConfigurationManager.AppSettings["BUCKET_NAME"] ?? "";
            if (!string.IsNullOrEmpty(bucket))
                bucket = bucket + "/";
            var root = ConfigurationManager.AppSettings["ROOT_DIRECTORY"] ?? "";
            if (!string.IsNullOrEmpty(root))
                root = root + "/";
            ViewBag.UrlRaizS3 = string.Format("{0}{1}{2}", urlS3, bucket, root);

            ViewBag.ServiceController = (ConfigurationManager.AppSettings["ServiceController"] == null) ? "" : ConfigurationManager.AppSettings["ServiceController"].ToString();
            ViewBag.ServiceAction = (ConfigurationManager.AppSettings["ServiceAction"] == null) ? "" : ConfigurationManager.AppSettings["ServiceAction"].ToString();

            ViewBag.EsMobile = 1;

            ViewBag.FotoPerfil = userData.FotoPerfil;
            ViewBag.FotoPerfilAncha = userData.FotoPerfilAncha;
            ViewBag.FotoPerfilSinModificar = (string.IsNullOrWhiteSpace(userData.FotoOriginalSinModificar) ? "" : userData.FotoOriginalSinModificar);

            ViewBag.TokenPedidoAutenticoOk = (SessionManager.GetTokenPedidoAutentico() != null) ? 1 : 0;
            ViewBag.CodigoEstrategia = _revistaDigitalProvider.GetCodigoEstrategia();
            ViewBag.BannerInferior = _showRoomProvider.EvaluarBannerConfiguracion(userData.PaisID, SessionManager);
            ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
            int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
            if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

            ViewBag.HabilitarChatEmtelco = _chatEmtelcoProvider.HabilitarChatEmtelco(userData.PaisID, esMobile);

            var MostrarBuscador = false;
            var CaracteresBuscador = 0;
            var TotalListadorBuscador = 20;
            var CaracteresBuscadorMostrar = 15;
            var CantidadVecesInicioSesionNovedad = 0;

            if (buscadorYFiltro.ConfiguracionPaisDatos.Any())
            {
                foreach (var item in buscadorYFiltro.ConfiguracionPaisDatos)
                {
                    switch (item.Codigo)
                    {
                        case Constantes.TipoConfiguracionBuscador.MostrarBuscador:
                            MostrarBuscador = Convert.ToBoolean(item.Valor1.ToInt());
                            break;
                        case Constantes.TipoConfiguracionBuscador.CaracteresBuscador:
                            CaracteresBuscador = item.Valor1.ToInt();
                            break;
                        case Constantes.TipoConfiguracionBuscador.CaracteresBuscadorMostrar:
                            CaracteresBuscadorMostrar = item.Valor1.ToInt();
                            break;
                        case Constantes.TipoConfiguracionBuscador.TotalResultadosBuscador:
                            TotalListadorBuscador = item.Valor1.ToInt();
                            break;
                        case Constantes.TipoConfiguracionBuscador.CantidadInicioSesionNovedadBuscador:
                            CantidadVecesInicioSesionNovedad = item.Valor1.ToInt();
                            break;
                    }
                }
            }

            ViewBag.MostrarBuscadorYFiltros = MostrarBuscador;
            ViewBag.CaracteresBuscador = CaracteresBuscador;
            ViewBag.TotalListadorBuscador = TotalListadorBuscador;
            ViewBag.CaracteresBuscadorMostrar = CaracteresBuscadorMostrar;
            ViewBag.CantidadVecesInicioSesionNovedad = CantidadVecesInicioSesionNovedad;
            ViewBag.NovedadBuscador = userData.NovedadBuscador;
        }
        
        #endregion

        protected int GetMostradoPopupPrecargados()
        {
            var flag = 1;
            try
            {
                if (userData.CodigoISO == Constantes.CodigosISOPais.Bolivia && userData.CampaniaID == 201717)
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        flag = sv.GetFlagProductosPrecargados(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID);
                    }

                    if (flag == 0)
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            sv.UpdateMostradoProductosPrecargados(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.IPUsuario);
                        }

                        SessionManager.SetPedidoWeb(null);
                        SessionManager.SetDetallesPedido(null);
                        UpdPedidoWebMontosPROL();
                    }
                }

                return flag;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return flag;
            }
        }
        
        public RevistaDigitalShortModel getRevistaDigitalShortModel()
        {
            RevistaDigitalShortModel _RevistaDigitalShortModel = null;
            if (revistaDigital != null)
            {
                _RevistaDigitalShortModel = new RevistaDigitalShortModel();
                _RevistaDigitalShortModel.TieneRDC = revistaDigital.TieneRDC;
                _RevistaDigitalShortModel.TieneRDI = revistaDigital.TieneRDI;
                _RevistaDigitalShortModel.TieneRDS = revistaDigital.TieneRDS;
                _RevistaDigitalShortModel.EsSuscrita = revistaDigital.EsSuscrita;
                _RevistaDigitalShortModel.EsActiva = revistaDigital.EsActiva;
                _RevistaDigitalShortModel.CampaniaActiva = revistaDigital.CampaniaFuturoActiva;
            }

            return _RevistaDigitalShortModel;
        }
        
        public virtual bool EsDispositivoMovil()
        {
            var result = false;

            try
            {
                result = Request.Browser.IsMobileDevice; ;
            }
            catch
            {
            }

            return result;
        }

        public string GetControllerActual()
        {
            return ControllerContext.RouteData.Values["controller"].ToString();
        }

        public VariablesGeneralEstrategiaModel GetVariableEstrategia()
        {
            var variableEstrategia = new VariablesGeneralEstrategiaModel
            {
                PaisHabilitado = WebConfig.PaisesMicroservicioPersonalizacion,
                TipoEstrategiaHabilitado = WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion
            };
            return variableEstrategia;
        }

        public Tuple<bool, string> ObjectCaminoExito()
        {
            string URLConfig = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URLCaminoExisto);
            string URLCaminoExisto = string.Empty;
            bool ResultadoValidacion = false;
            try
            {
                using (var sv = new ServiceCliente.ClienteServiceClient())
                {
                    List<ServiceCliente.BEEscalaDescuentoZona> Lista = sv.ListarEscalaDescuentoZona(userData.PaisID, userData.CampaniaID, userData.CodigorRegion, userData.CodigoZona).ToList();
                    ResultadoValidacion = Lista.Count > 0;
                    if (ResultadoValidacion) URLCaminoExisto = string.Format("{0}{1}/{2}/{3}", URLConfig, userData.CodigoISO,userData.CampaniaID ,Util.Security.ToMd5(userData.CodigoConsultora));
                }
            }
            catch
            {
                ResultadoValidacion = false;
            }
            return Tuple.Create(ResultadoValidacion, URLCaminoExisto);
        }

    }
}
