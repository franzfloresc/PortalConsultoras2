using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseController : Controller
    {
        #region Variables
        protected UsuarioModel userData;
        protected RevistaDigitalModel revistaDigital;
        protected HerramientasVentaModel herramientasVenta;
        protected GuiaNegocioModel guiaNegocio;
        protected DataModel estrategiaODD;
        protected ConfigModel configEstrategiaSR;

        protected ISessionManager sessionManager;
        protected ILogManager logManager;

        protected readonly TablaLogicaProvider _tablaLogicaProvider;
        protected readonly BaseProvider _baseProvider;
        protected readonly GuiaNegocioProvider _guiaNegocioProvider;
        protected readonly ShowRoomProvider _showRoomProvider;
        protected readonly OfertaDelDiaProvider _ofertaDelDiaProvider;
        protected readonly OfertaPersonalizadaProvider _ofertaPersonalizadaProvider; // Mover donde se utiliza
        protected readonly ConfiguracionManagerProvider _configuracionManagerProvider;
        protected readonly OfertaViewProvider _ofertasViewProvider;  // Mover donde se utiliza
        protected readonly RevistaDigitalProvider _revistaDigitalProvider;
        protected readonly EventoFestivoProvider _eventoFestivoProvider;
        protected readonly PedidoWebProvider _pedidoWebProvider;
        protected readonly EstrategiaComponenteProvider _estrategiaComponenteProvider;
        protected readonly TipoEstrategiaProvider _tipoEstrategiaProvider;
        protected readonly ConfiguracionPaisProvider _configuracionPaisProvider;
        protected readonly MenuContenedorProvider _menuContenedorProvider;
        #endregion

        #region Constructor

        public BaseController() : this(SessionManager.SessionManager.Instance, LogManager.LogManager.Instance)
        {
            userData = UserData();
            _tablaLogicaProvider = new TablaLogicaProvider();
            _baseProvider = new BaseProvider();
            _guiaNegocioProvider = new GuiaNegocioProvider();
            _ofertaPersonalizadaProvider = new OfertaPersonalizadaProvider();
            _configuracionManagerProvider = new ConfiguracionManagerProvider();
            _ofertasViewProvider = new OfertaViewProvider();
            _revistaDigitalProvider = new RevistaDigitalProvider();
            _showRoomProvider = new ShowRoomProvider(_tablaLogicaProvider);
            _ofertaDelDiaProvider = new OfertaDelDiaProvider();
            _eventoFestivoProvider = new EventoFestivoProvider();
            _pedidoWebProvider = new PedidoWebProvider();
            _estrategiaComponenteProvider = new EstrategiaComponenteProvider(userData.PaisID, userData.CodigoISO);
            _tipoEstrategiaProvider = new TipoEstrategiaProvider();
            _configuracionPaisProvider = new ConfiguracionPaisProvider();
            _menuContenedorProvider = new MenuContenedorProvider();
        }

        public BaseController(ISessionManager sessionManager)
        {
            userData = new UsuarioModel();
            this.sessionManager = sessionManager;
        }

        public BaseController(ISessionManager sessionManager, ILogManager logManager)
        {
            userData = new UsuarioModel();
            this.sessionManager = sessionManager;
            this.logManager = logManager;
        }

        #endregion

        #region Overrides

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                userData = UserData();

                if (userData == null)
                {
                    string urlSignOut = ObtenerUrlCerrarSesion();

                    filterContext.Result = new RedirectResult(urlSignOut);
                    return;
                }

                revistaDigital = sessionManager.GetRevistaDigital();
                herramientasVenta = sessionManager.GetHerramientasVenta();
                guiaNegocio = sessionManager.GetGuiaNegocio();
                estrategiaODD = sessionManager.OfertaDelDia.Estrategia;
                configEstrategiaSR = sessionManager.GetEstrategiaSR() ?? new ConfigModel();

                if (!configEstrategiaSR.CargoEntidadesShowRoom)
                    _showRoomProvider.CargarEntidadesShowRoom(userData);

                if (Request.IsAjaxRequest())
                {
                    base.OnActionExecuting(filterContext);
                    return;
                }

                ObtenerPedidoWeb();
                ObtenerPedidoWebDetalle();

                GetUserDataViewBag();

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

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado()
        {
            return _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado(EsOpt());
        }

        protected List<ObjMontosProl> ServicioProl_CalculoMontosProl(bool session = true)
        {
            var montosProl = new List<ObjMontosProl> { new ObjMontosProl() };

            if (session && sessionManager.GetMontosProl() != null)
            {
                return sessionManager.GetMontosProl();
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

            sessionManager.SetMontosProl(montosProl);

            return montosProl;
        }

        protected void InsIndicadorPedidoAutentico(BEIndicadorPedidoAutentico indPedidoAutentico, string cuv)
        {
            try
            {
                var detallesPedido = sessionManager.GetDetallesPedido();

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

            sessionManager.SetPedidoWeb(null);
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
                    sessionManager.SetUserData(null);
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
                return SepararItemsMenu(userData.Menu);
            }

            var permisos = GetPermisosByRol(userData.PaisID, userData.RolID);

            if (!_configuracionManagerProvider.GetMostrarOpcionClienteOnline(userData.CodigoISO) &&
                permisos.Any(p => p.UrlItem.ToLower() == "consultoraonline/index"))
            {
                permisos.Remove(permisos.FirstOrDefault(p => p.UrlItem.ToLower() == "consultoraonline/index"));
            }

            if (!userData.PedidoFICActivo
                && permisos.Any(m => m.Codigo == Constantes.MenuCodigo.PedidoFIC))
            {
                permisos.Where(m => m.Codigo == Constantes.MenuCodigo.PedidoFIC).ToList().ForEach(m => permisos.Remove(m));
            }

            if (userData.IndicadorPermisoFIC == 0 &&
                permisos.Any(p => p.UrlItem.ToLower() == "pedidofic/index"))
            {
                permisos.Remove(permisos.FirstOrDefault(p => p.UrlItem.ToLower() == "pedidofic/index"));
            }

            if ((userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida) &&
                permisos.Any(p => p.UrlItem.ToLower() == "catalogopersonalizado/index"))
            {
                permisos.Remove(permisos.FirstOrDefault(p => p.UrlItem.ToLower() == "catalogopersonalizado/index"));
            }

            var lstMenuModel = new List<PermisoModel>();

            foreach (var permiso in permisos)
            {
                permiso.Codigo = Util.Trim(permiso.Codigo).ToLower();
                permiso.Descripcion = Util.Trim(permiso.Descripcion);
                permiso.UrlItem = Util.Trim(permiso.UrlItem);
                permiso.UrlImagen = Util.Trim(permiso.UrlImagen);
                permiso.DescripcionFormateada = Util.RemoveDiacritics(permiso.DescripcionFormateada.ToLower()).Replace(" ", "-");

                if (permiso.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                {
                    if (revistaDigital.TieneRevistaDigital())
                    {
                        userData.ClaseLogoSB = "negro";
                    }
                    permiso.EsSoloImagen = true;
                    permiso.UrlImagen = GetUrlImagenMenuOfertas(userData, revistaDigital);
                }

                if (permiso.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower() &&
                    (revistaDigital.TieneRevistaDigital()))
                {
                    continue;
                }

                // por ahora esta en header, ponerlo para tambien para el Footer
                // Objetivo que el Html este limpio, la logica no deberia estar en la vista
                #region header
                if (permiso.Posicion.ToLower() == "header")
                {
                    if (!permiso.Mostrar)
                        continue;

                    if (permiso.Descripcion.ToUpperInvariant() == "SOCIA EMPRESARIA" && permiso.IdPadre == 0
                        && !(ViewBag.Lider == 1 && ViewBag.PortalLideres))
                    {
                        continue;
                    }

                    permiso.PageTarget = permiso.PaginaNueva ? "_blank" : "_self";
                    permiso.ClaseSubMenu = permiso.Descripcion == "MI NEGOCIO" ? "sub_menu_home1" : "sub_menu_home2";

                    if (permiso.IdPadre == 0)
                    {
                        permiso.ClaseMenu = "";
                        permiso.ClaseMenuItem = "";
                        var urlSplit = permiso.UrlItem.Split('/');
                        permiso.OnClickFunt = "RedirectMenu('" + (urlSplit.Length > 1 ? urlSplit[1] : "") + "', '" + (urlSplit.Length > 0 ? urlSplit[0] : "") + "' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + ", '" + permiso.Descripcion + "')";

                        if (permiso.Descripcion.ToUpperInvariant() == "MI COMUNIDAD")
                        {
                            if (ViewBag.EsUsuarioComunidad == 0)
                            {
                                permiso.OnClickFunt = "AbrirModalRegistroComunidad()";
                            }
                            else
                            {
                                permiso.OnClickFunt = "RedirectMenu('" + (urlSplit.Length > 1 ? urlSplit[1] : "") + "', '" + (urlSplit.Length > 0 ? urlSplit[0] : "") + "', '' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                        }

                        if (permiso.Descripcion.ToUpperInvariant() == "SOCIA EMPRESARIA")
                        {
                            permiso.ClaseMenu = "menu_socia_empresaria";
                            if (ViewBag.Lider == 1 && ViewBag.PortalLideres)
                            {
                                permiso.OnClickFunt = "RedirectMenu('" + permiso.UrlItem + "', '' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                        }

                        permiso.UrlImagen = permiso.EsSoloImagen ? permiso.UrlImagen : "";
                    }
                    else
                    {
                        if (permiso.UrlItem != "")
                        {
                            if (permiso.EsDireccionExterior)
                            {
                                permiso.OnClickFunt = "RedirectMenu('" + permiso.UrlItem + "', '' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                            else
                            {
                                var urlSplit = permiso.UrlItem.Split('/');
                                permiso.OnClickFunt = "RedirectMenu('" + (urlSplit.Length > 1 ? urlSplit[1] : "") + "', '" + (urlSplit.Length > 0 ? urlSplit[0] : "") + "', " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                        }
                    }

                    lstMenuModel.Add(permiso);

                    continue;
                }
                #endregion

                lstMenuModel.Add(permiso);
            }

            userData.Menu = lstMenuModel;

            ViewBag.ClaseLogoSB = userData.ClaseLogoSB;

            return SepararItemsMenu(lstMenuModel);
        }

        protected virtual IList<PermisoModel> GetPermisosByRol(int paisId, int rolId)
        {
            IList<BEPermiso> permisos;

            using (var sv = new SeguridadServiceClient())
            {

                permisos = sv.GetPermisosByRol(paisId, rolId).ToList();
            }

            return Mapper.Map<List<PermisoModel>>(permisos);
        }

        public virtual string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
        {
            var urlImagen = string.Empty;
            var tieneRevistaDigital = revistaDigital.TieneRevistaDigital();
            var smEventoFestivo = sessionManager.GetEventoFestivoDataModel();
            var tieneEventoFestivoData = smEventoFestivo != null &&
                smEventoFestivo.ListaGifMenuContenedorOfertas != null &&
                smEventoFestivo.ListaGifMenuContenedorOfertas.Any();

            if (!tieneRevistaDigital)
            {
                urlImagen = _configuracionManagerProvider.GetDefaultGifMenuOfertas();
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS, urlImagen);
                }
            }

            if (tieneRevistaDigital && !revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            if (tieneRevistaDigital && revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS, urlImagen);
                }
            }

            if (revistaDigital.TieneRDI)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            return urlImagen;
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

            userData.ConsultoraOnlineMenuResumen = new ConsultoraOnlineMenuResumenModel();

            var lstMenuMobileModel = GetMenuMobileModel(userData.PaisID);

            if ((userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida) &&
                lstMenuMobileModel.Any(p => p.UrlItem.ToLower() == "mobile/catalogopersonalizado/index"))
            {
                lstMenuMobileModel.Remove(lstMenuMobileModel.FirstOrDefault(p => p.UrlItem.ToLower() == "mobile/catalogopersonalizado/index"));
            }

            var menuConsultoraOnlinePadre = lstMenuMobileModel.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID == 0);
            var menuConsultoraOnlineHijo = lstMenuMobileModel.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID != 0);


            if (!_configuracionManagerProvider.GetMostrarOpcionClienteOnline(userData.CodigoISO))
            {
                lstMenuMobileModel.Remove(menuConsultoraOnlinePadre);
                lstMenuMobileModel.Remove(menuConsultoraOnlineHijo);
            }
            else if (menuConsultoraOnlinePadre != null || menuConsultoraOnlineHijo != null)
            {
                int esConsultoraOnline;
                using (var svc = new UsuarioServiceClient())
                {
                    esConsultoraOnline = svc.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                    if (esConsultoraOnline >= 0)
                    {
                        userData.ConsultoraOnlineMenuResumen.CantPedidosPendientes = svc.GetCantidadSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                        userData.ConsultoraOnlineMenuResumen.TeQuedanConsultoraOnline = svc.GetSaldoHorasSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                        userData.ConsultoraOnlineMenuResumen.TipoMenuConsultoraOnline = 2;
                        userData.ConsultoraOnlineMenuResumen.MenuPadreIDConsultoraOnline = menuConsultoraOnlinePadre != null ? menuConsultoraOnlinePadre.MenuMobileID : 0;
                    }
                    else
                    {
                        userData.ConsultoraOnlineMenuResumen.TipoMenuConsultoraOnline = 1;
                        userData.ConsultoraOnlineMenuResumen.MenuHijoIDConsultoraOnline = menuConsultoraOnlineHijo != null ? menuConsultoraOnlineHijo.MenuMobileID : 0;
                        lstMenuMobileModel.Remove(menuConsultoraOnlinePadre);
                    }
                }

                if (menuConsultoraOnlineHijo != null)
                {
                    var arrayUrlConsultoraOnlineHijo = menuConsultoraOnlineHijo.UrlItem.Split(new string[] { "||" }, StringSplitOptions.None);
                    menuConsultoraOnlineHijo.UrlItem = arrayUrlConsultoraOnlineHijo[esConsultoraOnline == -1 ? 0 : arrayUrlConsultoraOnlineHijo.Length - 1];
                }
            }

            var listadoMenuFinal = new List<MenuMobileModel>();
            foreach (var menu in lstMenuMobileModel)
            {
                menu.Codigo = Util.Trim(menu.Codigo).ToLower();
                menu.UrlItem = Util.Trim(menu.UrlItem);
                menu.UrlImagen = Util.Trim(menu.UrlImagen);
                menu.Descripcion = Util.Trim(menu.Descripcion);
                menu.MenuPadreDescripcion = Util.Trim(menu.MenuPadreDescripcion);
                menu.Posicion = Util.Trim(menu.Posicion);

                if (menu.MenuMobileID == Constantes.MenuMobileId.NecesitasAyuda)
                {
                    menu.EstiloMenu = "background: url(" + menu.UrlImagen.Replace("~", "") + ") no-repeat; background-position: 7px 16px; background-size: 12px 12px;";
                }
                else if (menu.MenuMobileID == 1002)
                {
                    menu.Descripcion = ViewBag.TituloCatalogo ? menu.Descripcion : "Catálogos";
                }

                if (menu.Posicion.ToLower() != "menu")
                {
                    listadoMenuFinal.Add(menu);
                    continue;
                }

                menu.ClaseMenu = "";
                menu.ClaseMenuItem = "";

                menu.PageTarget = menu.PaginaNueva ? "_blank" : "_self";
                menu.OnClickFunt = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "onclick='return messageInfoPostulante();'" : "";
                menu.OnClickFunt = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "onclick='return messageInfoPostulante();'" : menu.OnClickFunt;

                try
                {
                    menu.UrlItem = menu.Version == "Completa"
                    ? menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}Mobile/Menu/Ver?url={1}", Util.GetUrlHost(Request), menu.UrlItem)
                    : menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}{1}", Util.GetUrlHost(Request), menu.UrlItem);
                }
                catch
                {
                    // ignored
                }


                menu.UrlItem = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "javascript:;" : menu.UrlItem;
                menu.UrlItem = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "javascript:;" : menu.UrlItem;

                if (menu.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                {
                    menu.UrlImagen = GetUrlImagenMenuOfertas(userData, revistaDigital);
                }

                listadoMenuFinal.Add(menu);
            }

            var lstModel = listadoMenuFinal.Where(item => item.MenuPadreID == 0).OrderBy(item => item.OrdenItem).ToList();
            foreach (var item in lstModel)
            {
                var subItems = listadoMenuFinal.Where(p => p.MenuPadreID == item.MenuMobileID).OrderBy(p => p.OrdenItem);
                foreach (var subItem in subItems)
                {
                    subItem.Codigo = Util.Trim(subItem.Codigo).ToLower();
                    if (subItem.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower()
                        && (revistaDigital.TieneRevistaDigital()))
                    {
                        continue;
                    }

                    item.SubMenu.Add(subItem);
                }
            }

            if (lstModel.Any(m => m.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower()))
            {
                var menuNego = lstModel.FirstOrDefault(m => m.Codigo == Constantes.MenuCodigo.MiNegocio.ToLower()) ?? new MenuMobileModel();

                if (menuNego.MenuMobileID > 0)
                {
                    lstModel.ForEach(m =>
                    {
                        m.OrdenItem = m.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower()
                            ? menuNego.OrdenItem + 1
                            : m.OrdenItem > menuNego.OrdenItem ? m.OrdenItem + 1 : m.OrdenItem;
                    });
                    lstModel = lstModel.OrderBy(p => p.OrdenItem).ToList();
                }
            }

            userData.MenuMobile = lstModel;
            SetConsultoraOnlineViewBag(userData);

            return lstModel;
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

        protected virtual List<MenuMobileModel> GetMenuMobileModel(int paisId)
        {
            List<BEMenuMobile> lstMenuMobile = null;

            try
            {
                using (var sv = new SeguridadServiceClient())
                {
                    lstMenuMobile = sv.GetItemsMenuMobile(paisId).ToList();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, paisId.ToString(), "BaseController.GetMenuMobileModel");
            }
            finally
            {
                lstMenuMobile = lstMenuMobile ?? new List<BEMenuMobile>();
            }


            return Mapper.Map<List<MenuMobileModel>>(lstMenuMobile);
        }

        private List<PermisoModel> SepararItemsMenu(List<PermisoModel> menuOriginal)
        {
            var menu = new List<PermisoModel>();

            SepararItemsMenu(ref menu, menuOriginal, 0);

            return menu;
        }

        private void SepararItemsMenu(ref List<PermisoModel> menu, List<PermisoModel> menuOriginal, int idPadre)
        {
            menu = menuOriginal.Where(x => x.IdPadre == idPadre && (x.Descripcion != "" || x.UrlItem != "" || x.UrlImagen != ""))
                .OrderBy(x => x.Posicion)
                .ToList();

            foreach (var itemMenu in menu)
            {
                var temp = new List<PermisoModel>();

                SepararItemsMenu(ref temp, menuOriginal, itemMenu.PermisoID);

                itemMenu.SubMenus = temp;
                itemMenu.SubMenus = itemMenu.SubMenus.OrderBy(p => p.OrdenItem).ToList();
            }
        }

        private List<ServicioCampaniaModel> BuildMenuService()
        {
            if (userData.MenuService != null)
            {
                return userData.MenuService;
            }

            var lstTemp1 = new List<BEServicioCampania>();

            try
            {
                using (var sv = new SACServiceClient())
                {
                    lstTemp1 = sv.GetServicioByCampaniaPais(userData.PaisID, userData.CampaniaID).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            int segmentoId;
            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
            {
                segmentoId = 1;
            }
            else
            {
                if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    segmentoId = userData.SegmentoID;
                }
                else
                {
                    segmentoId = userData.SegmentoInternoID ?? userData.SegmentoID;
                }
            }

            var segmentoServicio = userData.EsJoven == 1 ? 99 : segmentoId;

            var lstTemp2 = lstTemp1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString())).ToList();
            var lst = lstTemp2.Where(p => p.Segmento == "-1" || p.Segmento == segmentoServicio.ToString()).ToList();

            userData.MenuService = Mapper.Map<IList<BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            return userData.MenuService;
        }

        protected string GetMenuLinkByDescription(string description)
        {
            var menuItem = userData.Menu.FirstOrDefault(item => item.Descripcion == description);

            return menuItem == null ? string.Empty : menuItem.UrlItem;
        }
        #endregion

        #region UserData

        public UsuarioModel UserData()
        {
            var model = sessionManager.GetUserData() ?? new UsuarioModel();

            model.MenuNotificaciones = 1;

            return model;
        }

        protected List<BEProductoFaltante> GetProductosFaltantes()
        {
            return this.GetProductosFaltantes("", "", "", "");
        }

        protected List<BEProductoFaltante> GetProductosFaltantes(string cuv, string descripcion, string codCategoria, string codCatalogoRevista)
        {
            List<BEProductoFaltante> olstProductoFaltante;
            using (var sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(userData.PaisID, userData.CampaniaID, userData.ZonaID, cuv, descripcion, codCategoria, codCatalogoRevista).ToList();
            }
            return olstProductoFaltante ?? new List<BEProductoFaltante>();
        }

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
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return ip;
        }

        //public int TipoAccionAgregar(int tieneVariedad, string codigoTipoEstrategia, bool esConsultoraLider = false, bool bloqueado = false, string codigoTipos = "")
        //{
        //    var tipo = tieneVariedad == 0 ? codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackNuevas ? 1 : 2 : 3;
        //    if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada)
        //    {
        //        tipo = esConsultoraLider && revistaDigital.SociaEmpresariaExperienciaGanaMas && revistaDigital.EsSuscritaActiva() ? 0 : tipo;
        //    }
        //    else if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom)
        //    {
        //        tipo = codigoTipos == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoTipos == Constantes.TipoEstrategiaSet.CompuestaFija ? 2 : 3;
        //        tipo = bloqueado && revistaDigital.EsNoSuscritaInactiva() ? 4 : tipo;
        //        tipo = bloqueado && revistaDigital.EsSuscritaInactiva() ? 5 : tipo;
        //    }
        //    else if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertasParaMi
        //        || codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
        //        || codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento)
        //    {
        //        tipo = bloqueado && revistaDigital.EsNoSuscritaInactiva() ? 4 : tipo;
        //        tipo = bloqueado && revistaDigital.EsSuscritaInactiva() ? 5 : tipo;
        //    }
        //    return tipo;
        //}

        #endregion

        protected BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(string constSession)
        {
            constSession = constSession ?? "";
            constSession = constSession.Trim();
            if (constSession == "")
                return new BEConfiguracionProgramaNuevas();

            if (Session[constSession] != null)
                return (BEConfiguracionProgramaNuevas)Session[constSession];

            try
            {
                var obeConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas()
                {
                    CampaniaInicio = userData.CampaniaID.ToString(),
                    CodigoRegion = userData.CodigorRegion,
                    CodigoZona = userData.CodigoZona
                };
                using (var sv = new PedidoServiceClient())
                {
                    if (userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                        userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                        userData.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
                    {
                        var PaisesFraccionKit = WebConfigurationManager.AppSettings["PaisesFraccionKitNuevas"];
                        if (PaisesFraccionKit.Contains(userData.CodigoISO))
                        {
                            obeConfiguracionProgramaNuevas.CodigoNivel = userData.ConsecutivoNueva == 1 ? "02" : userData.ConsecutivoNueva == 2 ? "03" : "";
                            obeConfiguracionProgramaNuevas = sv.GetConfiguracionProgramaDespuesPrimerPedido(userData.PaisID, obeConfiguracionProgramaNuevas);
                        }
                    }
                    else
                        obeConfiguracionProgramaNuevas = sv.GetConfiguracionProgramaNuevas(userData.PaisID, obeConfiguracionProgramaNuevas);
                }

                Session[constSession] = obeConfiguracionProgramaNuevas ?? new BEConfiguracionProgramaNuevas();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[constSession] = new BEConfiguracionProgramaNuevas();
            }

            return (BEConfiguracionProgramaNuevas)Session[constSession];
        }

        protected Converter<decimal, string> CreateConverterDecimalToString(int paisId)
        {
            if (paisId == 4) return new Converter<decimal, string>(p => p.ToString("n0", new System.Globalization.CultureInfo("es-CO")));
            return new Converter<decimal, string>(p => p.ToString("n2", new System.Globalization.CultureInfo("es-PE")));
        }

        private BarraTippingPoint GetTippingPoint(string TippingPointParticipa, string TippingPointStr)
        {
            BarraTippingPoint TippingPoint = new BarraTippingPoint { ActiveTooltip = false, ActiveMonto = false };
            string nivel = Convert.ToString(userData.ConsecutivoNueva + 1).PadLeft(2, '0');
            string FlagParticipa = getValidaConsultoraProgramaNueva(TippingPointParticipa);
            try
            {
                // verifica si participa al programa de nuevas.
                if (FlagParticipa == Constantes.TipoEstrategiaCodigo.ParticipaProgramaNuevas)
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        var beActive = sv.GetActivarPremioNuevas(userData.PaisID, Constantes.TipoEstrategiaCodigo.ProgramaNuevasRegalo, userData.CampaniaID, nivel);
                        TippingPoint.ActiveTooltip = beActive != null && beActive.ActiveTooltip;
                        TippingPoint.ActiveMonto = beActive != null && beActive.ActiveMontoTooltip;
                        TippingPoint.Active = beActive != null && beActive.Active;
                        TippingPoint.TippingPointMontoStr = TippingPointStr;
                        // verifica si esta activado el tooltip
                        if (TippingPoint.ActiveTooltip)
                        {
                            var estrategia = sv.GetEstrategiaPremiosTippingPoint(userData.PaisID,
                                                                               Constantes.TipoEstrategiaCodigo.ProgramaNuevasRegalo,
                                                                               userData.CampaniaID,
                                                                               nivel);

                            TippingPoint.ActiveTooltip = estrategia == null ? false : TippingPoint.ActiveTooltip;
                            TippingPoint.ActiveMonto = estrategia == null ? false : TippingPoint.ActiveMonto;
                            TippingPoint.Active = estrategia == null ? false : TippingPoint.Active;

                            TippingPoint.CampaniaID = estrategia == null ? default(int) : estrategia.CampaniaID;
                            TippingPoint.CampaniaIDFin = estrategia == null ? default(int) : estrategia.CampaniaIDFin;
                            TippingPoint.CUV1 = estrategia == null ? default(string) : estrategia.CUV1;
                            TippingPoint.CUV2 = estrategia == null ? default(string) : estrategia.CUV2;
                            TippingPoint.ImagenURL = estrategia == null ? default(string) : estrategia.ImagenURL;
                            TippingPoint.DescripcionCUV2 = estrategia == null ? default(string) : estrategia.DescripcionCUV2;
                            TippingPoint.Ganancia = estrategia == null ? default(decimal) : estrategia.Ganancia;
                            TippingPoint.Precio = estrategia == null ? default(decimal) : estrategia.Precio;
                            TippingPoint.Precio2 = estrategia == null ? default(decimal) : estrategia.Precio2;
                            TippingPoint.PrecioPublico = estrategia == null ? default(decimal) : estrategia.PrecioPublico;
                            TippingPoint.PrecioUnitario = estrategia == null ? default(decimal) : estrategia.PrecioUnitario;
                            TippingPoint.LinkURL = estrategia == null ? default(string) : getUrlTippingPoint(estrategia.ImagenURL);
                        }
                    }
                }
                else
                {
                    TippingPoint = new BarraTippingPoint { ActiveTooltip = false, ActiveMonto = false };
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                TippingPoint = new BarraTippingPoint { ActiveTooltip = false, ActiveMonto = false };
            }
            return TippingPoint;
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

        private string getValidaConsultoraProgramaNueva(string participa)
        {
            //string resultado = string.Empty;
            // si el idestadoActividad es mayor a 1 o diferente a  1 entonces significa que el usuario pertenece al programa de nuevas[campo ConsecutivoNueva]
            //int ConsecutivoNueva = userData.ConsecutivoNueva;
            // este es el campo IdEstadoActividad en bd
            //int ConsultoraNueva = userData.ConsultoraNueva;
            //try
            //{
            string resultado = Util.Trim(participa);

                /*
                if (userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                        userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                        userData.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
                {
                    resultado = participa == null ? "" : participa.Trim();
                }
                else

                    resultado = Constantes.TipoEstrategiaCodigo.NotParticipaProgramaNuevas;
                    */
            //}
            //catch
            //{
            //    resultado = string.Empty;
            //}
            return resultado;
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
                    var tp = GetConfiguracionProgramaNuevas(Constantes.ConstSession.TippingPoint);
                    if (tp.IndExigVent == "1")
                    {
                        var obeConsultorasProgramaNuevas = GetConsultorasProgramaNuevas(Constantes.ConstSession.TippingPoint_MontoVentaExigido, tp.CodigoPrograma);
                        objR.TippingPoint = obeConsultorasProgramaNuevas.MontoVentaExigido;
                        objR.TippingPointStr = Util.DecimalToStringFormat(objR.TippingPoint, userData.CodigoISO);
                        // si el MontoVentaExigido es mayor a 0 entonces pertenece al programa de nuevas y se muestra el Tipping Point validacion a nivel de js y a nivel de cs
                        if (objR.TippingPoint > 0)
                            objR.TippingPointBarra = GetTippingPoint(obeConsultorasProgramaNuevas.Participa, objR.TippingPointStr);

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
                    listProducto = ObtenerPedidoWebSetDetalleAgrupado(); ObtenerPedidoWebDetalle();
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

        public List<BEEscalaDescuento> GetListaEscalaDescuento()
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

        protected BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(string constSession, string codigoPrograma)
        {
            constSession = constSession ?? "";
            constSession = constSession.Trim();
            if (constSession == "")
                return new BEConsultorasProgramaNuevas();

            if (Session[constSession] != null)
                return (BEConsultorasProgramaNuevas)Session[constSession];

            try
            {
                var obeConsultorasProgramaNuevas =
                    new BEConsultorasProgramaNuevas
                    {
                        CodigoConsultora = userData.CodigoConsultora,
                        Campania = userData.CampaniaID.ToString(),
                        CodigoPrograma = codigoPrograma
                    };
                using (var sv = new PedidoServiceClient())
                {
                    obeConsultorasProgramaNuevas = sv.GetConsultorasProgramaNuevas(userData.PaisID, obeConsultorasProgramaNuevas);
                }

                Session[constSession] = obeConsultorasProgramaNuevas ?? new BEConsultorasProgramaNuevas();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[constSession] = new BEConsultorasProgramaNuevas();
            }

            return (BEConsultorasProgramaNuevas)Session[constSession];
        }

        protected List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(string constSession, string tipoMensaje)
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

        public List<EstadoCuentaModel> ObtenerEstadoCuenta(long pConsultoraId = 0)
        {
            var lst = new List<EstadoCuentaModel>();

            if (pConsultoraId == 0)
                pConsultoraId = userData.ConsultoraID;

            //if (Session["ListadoEstadoCuenta"] == null)
            if (sessionManager.GetListadoEstadoCuenta() == null)
            {
                var estadoCuenta = new List<BEEstadoCuenta>();
                try
                {
                    using (var client = new SACServiceClient())
                    {
                        estadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, pConsultoraId).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                if (estadoCuenta.Count > 0)
                {
                    foreach (var ec in estadoCuenta)
                    {
                        lst.Add(new EstadoCuentaModel
                        {
                            Fecha = ec.FechaRegistro,
                            Glosa = ec.DescripcionOperacion,
                            Cargo = ec.Cargo,
                            Abono = ec.Abono
                        });
                    }

                    var monto = userData.MontoDeuda;

                    lst.Add(new EstadoCuentaModel
                    {
                        Fecha = userData.FechaLimPago,
                        Glosa = "MONTO A PAGAR",
                        Cargo = monto > 0 ? monto : 0,
                        Abono = monto < 0 ? 0 : monto
                    });
                }

                sessionManager.SetListadoEstadoCuenta(lst);
                //Session["ListadoEstadoCuenta"] = lst;
            }
            else
            {
                lst = sessionManager.GetListadoEstadoCuenta();
                //lst = Session["ListadoEstadoCuenta"] as List<EstadoCuentaModel>;
            }

            return lst;
        }

        #endregion

        #region Metodos Oferta del Dia

        //private bool CumpleOfertaDelDia()
        //{
        //    var result = false;
        //    if (!_ofertaDelDiaProvider.NoMostrarBannerODD(GetControllerActual()))
        //    {
        //        var tieneOfertaDelDia = sessionManager.GetFlagOfertaDelDia();
        //        result = (!tieneOfertaDelDia ||
        //                  (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2 || userData.IndicadorGPRSB == 0)
        //                  && !userData.CloseOfertaDelDia) && tieneOfertaDelDia;
        //    }

        //    return result;
        //}

        //protected EstrategiaPedidoModel GetOfertaDelDiaModel()
        //{
        //    if (!userData.EsConsultora())
        //        return new EstrategiaPedidoModel();

        //    estrategiaODD = estrategiaODD ?? sessionManager.OfertaDelDia.Estrategia;

        //    if (estrategiaODD != null && !estrategiaODD.TieneOfertaDelDia)
        //        return new EstrategiaPedidoModel();

        //    if (estrategiaODD != null &&
        //        estrategiaODD.ListaOferta.Any())
        //    {
        //        var oddModel = estrategiaODD.ListaDeOferta.First().Clone();
        //        //oddModel.TeQuedan = _ofertaDelDiaProvider.CountdownOdd(userData);
        //        oddModel.ListaOfertas = estrategiaODD.ListaDeOferta;
        //        return oddModel;
        //    }

        //    var ofertasOddModel = _ofertaDelDiaProvider.GetOfertas(userData);
        //    if (!ofertasOddModel.Any()) return new EstrategiaPedidoModel();

        //    var personalizacionesOdd = _tablaLogicaProvider.ObtenerConfiguracion(userData.PaisID, Constantes.TablaLogica.PersonalizacionODD);
        //    if (!personalizacionesOdd.Any()) return new EstrategiaPedidoModel();

        //    var tiposEstrategia = sessionManager.GetTiposEstrategia();
        //    if (tiposEstrategia == null)
        //    {
        //        tiposEstrategia = GetTipoEstrategias();
        //        sessionManager.SetTiposEstrategia(tiposEstrategia);
        //    }

        //    var colorFondoBanner = personalizacionesOdd.FirstOrDefault(x => x.TablaLogicaDatosID == Constantes.TablaLogicaDato.PersonalizacionOdd.ColorFondoBanner) ?? new TablaLogicaDatosModel();
        //    var coloFondoDisplay = personalizacionesOdd.FirstOrDefault(x => x.TablaLogicaDatosID == Constantes.TablaLogicaDato.PersonalizacionOdd.ColorFondoDisplay) ?? new TablaLogicaDatosModel();
        //    var countdown = _ofertaDelDiaProvider.CountdownOdd(userData);

        //    short posicion = 0;
        //    ofertasOddModel.Update(x =>
        //    {
        //        x.Position = posicion++;
        //        x.CodigoISO = userData.CodigoISO;
        //        //x.TeQuedan = countdown;
        //        x.ImagenFondo1 = string.Format(_configuracionManagerProvider.GetConfiguracionManager("UrlImgFondo1ODD"), userData.CodigoISO);
        //        x.ColorFondo1 = colorFondoBanner.Codigo ?? string.Empty;
        //        x.ImagenSoloHoy = _ofertaDelDiaProvider.ObtenerUrlImagenOfertaDelDia(userData.CodigoISO, ofertasOddModel.Count);
        //        x.ImagenFondo2 = string.Format(_configuracionManagerProvider.GetConfiguracionManager("UrlImgFondo2ODD"), userData.CodigoISO);
        //        x.ColorFondo2 = coloFondoDisplay.Codigo ?? string.Empty;
        //        //x.NombreOferta = ObtenerNombreOfertaDelDia(x.NombreOferta);
        //        //x.DescripcionLegal = ObtenerDescripcionOfertaDelDia(x.DescripcionLegal);
        //        x.NombreOferta = _ofertaDelDiaProvider.ObtenerNombreOfertaDelDia(x.NombreOferta);
        //        x.DescripcionOferta = _ofertaDelDiaProvider.ObtenerDescripcionOfertaDelDia(x.DescripcionOferta);
        //        x.TieneOfertaDelDia = true;
        //        x.DescripcionMarca = Util.GetDescripcionMarca(x.MarcaID);
        //        x.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == x.CUV2 && (d.TipoEstrategiaID == x.TipoEstrategiaID || d.TipoEstrategiaID == 0)) ? "block" : "none";
        //        if (tiposEstrategia != null && tiposEstrategia.Any(te => te.TipoEstrategiaID == x.TipoEstrategiaID))
        //            x.TipoEstrategiaDescripcion = tiposEstrategia.First(te => te.TipoEstrategiaID == x.TipoEstrategiaID).DescripcionEstrategia ?? string.Empty;
        //    });

        //    estrategiaODD = estrategiaODD ?? new DataModel();
        //    estrategiaODD.ListaDeOferta = ofertasOddModel;
        //    estrategiaODD.TieneOfertaDelDia = estrategiaODD.ListaDeOferta.Any();
        //    //sessionManager.SetUserData(userData);

        //    var odd = estrategiaODD.ListaDeOferta.First();
        //    odd.ConfiguracionContenedor = ObtenerConfiguracionSeccion(revistaDigital)
        //        .FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPais.OfertaDelDia);

        //    sessionManager.OfertaDelDia.Estrategia = estrategiaODD;

        //    var model = estrategiaODD.ListaDeOferta.First().Clone();
        //    model.ListaOfertas = estrategiaODD.ListaDeOferta;

        //    return model;
        //}

        #endregion

        #region Zonificacion

        //protected IEnumerable<RegionModel> DropDownListRegiones(int paisId)
        //{
        //    IList<BERegion> lst;
        //    using (var sv = new ZonificacionServiceClient())
        //    {
        //        lst = sv.SelectAllRegiones(paisId);
        //    }
        //    return Mapper.Map<IList<BERegion>, IEnumerable<RegionModel>>(lst.OrderBy(zona => zona.Codigo).ToList());
        //}

        //protected IEnumerable<ZonaModel> DropDownListZonas(int paisId)
        //{
        //    IList<BEZona> lst;
        //    using (var sv = new ZonificacionServiceClient())
        //    {
        //        lst = sv.SelectAllZonas(paisId);
        //    }
        //    return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lst);
        //}

        //public JsonResult ObtenerZonasByRegion(int paisId, int regionId)
        //{
        //    var listaZonas = DropDownListZonas(paisId);
        //    if (regionId > -1) listaZonas = listaZonas.Where(x => x.RegionID == regionId).ToList();
        //    return Json(new { success = true, listaZonas = listaZonas }, JsonRequestBehavior.AllowGet);
        //}

        #endregion

        #region LogDynamo

        protected void RegistrarLogDynamoDB(string aplicacion, string rol, string pantallaOpcion, string opcionAccion, ServiceUsuario.BEUsuario entidad = null)
        {
            var dataString = string.Empty;
            try
            {
                var data = new
                {
                    Fecha = "",
                    Aplicacion = aplicacion,
                    Pais = userData.CodigoISO,
                    Region = userData.CodigorRegion,
                    Zona = userData.CodigoZona,
                    Seccion = userData.SeccionAnalytics,
                    Rol = rol,
                    Campania = userData.CampaniaID.ToString(),
                    Usuario = userData.CodigoUsuario,
                    PantallaOpcion = pantallaOpcion,
                    OpcionAccion = opcionAccion,
                    DispositivoCategoria = Request.Browser.IsMobileDevice ? "MOBILE" : "WEB",
                    DispositivoID = GetIPCliente(),
                    Version = "2.0"
                };


                var urlApi = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);

                if (string.IsNullOrEmpty(urlApi)) return;

                var httpClient = new HttpClient { BaseAddress = new Uri(urlApi) };
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                dataString = JsonConvert.SerializeObject(data);

                HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

                var response = httpClient.PostAsync("Api/LogUsabilidad", contentPost).GetAwaiter().GetResult();

                var noQuitar = response.IsSuccessStatusCode;

                httpClient.Dispose();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, dataString);
            }
        }

        protected void EjecutarLogDynamoDB(object data, string requestUrl, string campomodificacion, string valoractual, string valoranterior, string origen, string aplicacion, string accion, string codigoconsultorabuscado, string seccion = "")
        {
            string dataString = string.Empty;
            string urlApi = string.Empty;
            bool noQuitar = false;

            /*** Se registra seccion Solo para Peru HD-881 ***/
            if (userData.CodigoISO != "PE")
                seccion = "";

            try
            {
                List<BETablaLogicaDatos> paisesAdmitidos;
                short codigoTablaLogica = 138;

                using (var tablaLogica = new SACServiceClient())
                {
                    paisesAdmitidos = tablaLogica.GetTablaLogicaDatos(userData.PaisID, codigoTablaLogica).ToList();
                }

                foreach (var item in paisesAdmitidos)
                {
                    if (Convert.ToInt32(item.Codigo) == Convert.ToInt32(userData.PaisID))
                    {
                        data = new
                        {
                            Usuario = userData.CodigoUsuario,
                            CodigoConsultora = userData.CodigoConsultora,
                            CampoModificacion = campomodificacion,
                            ValorActual = valoractual,
                            ValorAnterior = valoranterior,
                            Origen = origen,
                            Aplicacion = aplicacion,
                            Pais = userData.NombrePais,
                            Rol = userData.RolDescripcion,
                            Dispositivo = Request.Browser.IsMobileDevice ? "MOBILE" : "WEB",
                            Accion = accion,
                            UsuarioConsultado = codigoconsultorabuscado,
                            Seccion = seccion
                        };
                        urlApi = ConfigurationManager.AppSettings.Get("UrlLogDynamo");
                        if (string.IsNullOrEmpty(urlApi)) return;

                        HttpClient httpClient = new HttpClient();
                        httpClient.BaseAddress = new Uri(urlApi);
                        httpClient.DefaultRequestHeaders.Accept.Clear();
                        httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        dataString = JsonConvert.SerializeObject(data);
                        HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                        HttpResponseMessage response = httpClient.PostAsync(requestUrl, contentPost).GetAwaiter().GetResult();
                        noQuitar = response.IsSuccessStatusCode;
                        httpClient.Dispose();
                        break;
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, dataString);
            }
        }

        protected void ActualizarDatosLogDynamoDB(MisDatosModel p_modelo, string p_origen, string p_aplicacion, string p_Accion, string p_CodigoConsultoraBuscado = "", string p_Seccion = "")
        {
            string dataString = string.Empty;

            try
            {

                object data = null;

                //Data actual viene del Model       => model
                //Data anterior viene del userData  => userData 

                if (userData != null && p_modelo != null && p_Accion.Trim().ToUpper() == "MODIFICACION")
                {
                    string _seccion = "Mis Datos";

                    if (string.IsNullOrEmpty(userData.Sobrenombre)) userData.Sobrenombre = "";
                    if (string.IsNullOrEmpty(userData.EMail)) userData.EMail = "";
                    if (string.IsNullOrEmpty(userData.Telefono)) userData.Telefono = "";
                    if (string.IsNullOrEmpty(userData.Celular)) userData.Celular = "";
                    if (string.IsNullOrEmpty(userData.TelefonoTrabajo)) userData.TelefonoTrabajo = "";

                    if (string.IsNullOrEmpty(p_modelo.Sobrenombre)) p_modelo.Sobrenombre = "";
                    if (string.IsNullOrEmpty(p_modelo.EMail)) p_modelo.EMail = "";
                    if (string.IsNullOrEmpty(p_modelo.Telefono)) p_modelo.Telefono = "";
                    if (string.IsNullOrEmpty(p_modelo.Celular)) p_modelo.Celular = "";
                    if (string.IsNullOrEmpty(p_modelo.TelefonoTrabajo)) p_modelo.TelefonoTrabajo = "";

                    string v_campomodificacion = string.Empty;
                    string v_valoranterior = string.Empty;
                    string v_valoractual = string.Empty;

                    if (userData.Sobrenombre.ToString().Trim().ToUpper() != p_modelo.Sobrenombre.ToString().Trim().ToUpper())
                    {
                        v_campomodificacion = "SOBRENOMBRE";
                        v_valoractual = p_modelo.Sobrenombre.ToString().Trim();
                        v_valoranterior = userData.Sobrenombre.ToString().Trim();
                        userData.Sobrenombre = v_valoractual;
                        EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userData.EMail.ToString().Trim().ToUpper() != p_modelo.EMail.ToString().Trim().ToUpper())
                    {
                        v_campomodificacion = "EMAIL";
                        v_valoractual = p_modelo.EMail.ToString().Trim();
                        v_valoranterior = userData.EMail.ToString().Trim();
                        userData.EMail = v_valoractual;
                        EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userData.Telefono.ToString().Trim().ToUpper() != p_modelo.Telefono.ToString().Trim().ToUpper())
                    {
                        v_campomodificacion = "TELEFONO";
                        v_valoractual = p_modelo.Telefono.ToString().Trim();
                        v_valoranterior = userData.Telefono.ToString().Trim();
                        userData.Telefono = v_valoractual;
                        EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userData.Celular.ToString().Trim().ToUpper() != p_modelo.Celular.ToString().Trim().ToUpper())
                    {
                        v_campomodificacion = "CELULAR";
                        v_valoractual = p_modelo.Celular.ToString().Trim();
                        v_valoranterior = userData.Celular.ToString().Trim();
                        userData.Celular = v_valoractual;
                        EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userData.TelefonoTrabajo.ToString().Trim().ToUpper() != p_modelo.TelefonoTrabajo.ToString().Trim().ToUpper())
                    {
                        v_campomodificacion = "TELEFONO TRABAJO";
                        v_valoractual = p_modelo.TelefonoTrabajo.ToString().Trim();
                        v_valoranterior = userData.TelefonoTrabajo.ToString().Trim();
                        userData.TelefonoTrabajo = v_valoractual;
                        EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    sessionManager.SetUserData(userData);
                }
                else if (p_Accion.Trim().ToUpper() == "CONSULTA")
                {
                    EjecutarLogDynamoDB(data, "", "", "", p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, p_Seccion);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO, dataString);
            }

        }

        protected void EjecutarLogDynamoDB(object data, string campomodificacion, string valoractual, string valoranterior, string origen, string aplicacion, string accion, string codigoconsultorabuscado, string seccion = "")
        {
            string dataString = string.Empty;
            string apiController = string.Empty;

            try
            {
                string urlApi = ConfigurationManager.AppSettings.Get("UrlLogDynamo");
                if (string.IsNullOrEmpty(urlApi)) return;

                if (userData.CodigoISO != "PE")
                    seccion = "";

                List<BETablaLogicaDatos> paisesAdmitidos;
                short codigoTablaLogica = 138;

                using (var tablaLogica = new SACServiceClient())
                {
                    paisesAdmitidos = tablaLogica.GetTablaLogicaDatos(userData.PaisID, codigoTablaLogica).ToList();
                }

                bool noQuitar = false;
                foreach (var item in paisesAdmitidos)
                {
                    if (Convert.ToInt32(item.Codigo) == Convert.ToInt32(userData.PaisID))
                    {
                        data = new
                        {
                            Usuario = userData.CodigoUsuario,
                            CodigoConsultora = userData.CodigoConsultora,
                            CampoModificacion = campomodificacion,
                            ValorActual = valoractual,
                            ValorAnterior = valoranterior,
                            Origen = origen,
                            Aplicacion = aplicacion,
                            Pais = userData.NombrePais,
                            Rol = userData.RolDescripcion,
                            Dispositivo = Request.Browser.IsMobileDevice ? "MOBILE" : "WEB",
                            Accion = accion,
                            UsuarioConsultado = codigoconsultorabuscado,
                            Seccion = seccion
                        };

                        apiController = ConfigurationManager.AppSettings.Get("UrlLogDynamoApiController");


                        HttpClient httpClient = new HttpClient();
                        httpClient.BaseAddress = new Uri(urlApi);
                        httpClient.DefaultRequestHeaders.Accept.Clear();
                        httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                        dataString = JsonConvert.SerializeObject(data);
                        HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                        HttpResponseMessage response = httpClient.PostAsync(apiController, contentPost).GetAwaiter().GetResult();
                        noQuitar = response.IsSuccessStatusCode;
                        httpClient.Dispose();
                        break;
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, dataString);
            }
        }

        protected void RegistrarLogGestionSacUnete(string solicitudId, string pantalla, string accion)
        {
            var dataString = string.Empty;
            try
            {
                var urlApi = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);
                if (string.IsNullOrEmpty(urlApi)) return;

                var data = new
                {
                    FechaRegistro = "",
                    Pais = userData.CodigoISO,
                    Rol = userData.RolDescripcion,
                    Usuario = userData.CodigoUsuario,
                    Pantalla = pantalla,
                    Accion = accion,
                    SolicitudId = solicitudId
                };

                var httpClient = new HttpClient { BaseAddress = new Uri(urlApi) };
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                dataString = JsonConvert.SerializeObject(data);
                HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                var response = httpClient.PostAsync("Api/LogGestionSacUnete", contentPost).GetAwaiter().GetResult();
                var noQuitar = response.IsSuccessStatusCode;

                httpClient.Dispose();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, dataString);
            }

        }

        public void RegistrarLogDynamoCambioClave(string accion, string consultora, string v_valoractual, string v_valoranterior)
        {
            object data = null;
            var p_origen = "SAC/ACTUALIZAR CONTRASEÑA";
            var p_seccion = "Mantenimiento de contraseña";
            var p_aplicacion = Constantes.LogDynamoDB.AplicacionPortalConsultoras;

            if (accion.Trim().ToUpper() == "MODIFICACION")
            {
                EjecutarLogDynamoDB(data, "Contraseña", v_valoractual, v_valoranterior, p_origen, p_aplicacion, accion, "", p_seccion);
            }
            else
            {
                EjecutarLogDynamoDB(data, "", "", "", p_origen, p_aplicacion, accion, consultora, p_seccion);
            }
        }

        public void registraLogDynamoCDR(MisReclamosModel model)
        {
            try
            {
                object data = null;
                var p_origen = "MI NEGOCIO/CAMBIOS Y DEVOLUCIONES";
                var p_seccion = "Validacion de datos";
                var v_campomodificacion = "";
                var v_valoractual = "";
                var v_valoranterior = "";
                var p_aplicacion = Constantes.LogDynamoDB.AplicacionPortalConsultoras;
                var p_Accion = "Modificacion";

                if (string.IsNullOrEmpty(userData.EMail)) userData.EMail = "";
                if (string.IsNullOrEmpty(userData.Celular)) userData.Celular = "";

                if (string.IsNullOrEmpty(model.Email)) model.Email = "";
                if (string.IsNullOrEmpty(model.Telefono)) model.Telefono = "";

                if (userData.EMail.ToString().Trim().ToUpper() != model.Email.ToString().Trim().ToUpper())
                {
                    v_campomodificacion = "EMAIL";
                    v_valoractual = model.Email.ToString().Trim();
                    v_valoranterior = userData.EMail.ToString().Trim();
                    EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, "", p_seccion);
                }

                if (userData.Celular.ToString().Trim().ToUpper() != model.Telefono.ToString().Trim().ToUpper())
                {
                    v_campomodificacion = "CELULAR";
                    v_valoractual = model.Telefono.ToString().Trim();
                    v_valoranterior = userData.Celular.ToString().Trim();
                    EjecutarLogDynamoDB(data, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, "", p_seccion);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        #endregion

        #region Notificaciones

        protected void CargarMensajesNotificacionesGPR(NotificacionesModel model, List<BELogGPRValidacion> logsGprValidacion)
        {
            model.CuerpoDetalles = new List<string>();
            if (logsGprValidacion.Count == 0) return;

            var deuda = logsGprValidacion.Where(x => x.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.ActualizacionDeuda)).ToList();
            model.CuerpoMensaje1 = "Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar por:";

            var items = logsGprValidacion.Where(l => l.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.MontoMinino)).ToList();
            if (items.Any() && deuda.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto mínimo</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO)));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto mínimo</b> de  {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMinino;
                return;
            }

            items = logsGprValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.MontoMaximo)).ToList();
            if (items.Any() && deuda.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto máximo</b> de {0} {1} ", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMaximo, userData.CodigoISO)));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1} ", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>modificar</b> tu pedido, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())
            {
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto máximo</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMaximo, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>modificar</b> y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMaximo;
                return;
            }
            items = logsGprValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock)).ToList();
            if (items.Any() && deuda.Any())
            {
                model.CuerpoDetalles.Add("No cumplir con el <b>monto mínimo</b>");
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())
            {
                model.CuerpoDetalles.Add("No cumplir con el <b>monto mínimo</b>");
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock;
                return;
            }

            if (deuda.Any())
            {
                var item = deuda.FirstOrDefault();
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(item.Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ActualizacionDeuda;
                model.Campania = item.Campania;
            }
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

        //public string ObtenerValorPersonalizacionShowRoom(string codigoAtributo, string tipoAplicacion)
        //{
        //    if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
        //        return string.Empty;

        //    var model = configEstrategiaSR.ListaPersonalizacionConsultora.FirstOrDefault(p => p.Atributo == codigoAtributo && p.TipoAplicacion == tipoAplicacion);

        //    return model == null
        //        ? string.Empty
        //        : model.Valor;
        //}

        public bool ValidarPermiso(string codigo, string codigoConfig = "")
        {
            codigo = Util.Trim(codigo).ToLower();
            codigoConfig = Util.Trim(codigoConfig);

            var listaConfigPais = sessionManager.GetConfiguracionesPaisModel();
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

        public string AccionControlador(string tipo, bool onlyAction = false, bool mobile = false)
        {
            string controlador = "", accion = "";
            try
            {
                tipo = Util.Trim(tipo).ToLower();
                switch (tipo)
                {
                    case "sr":
                        controlador = "ShowRoom";
                        var esVenta = (sessionManager.GetMostrarShowRoomProductos());
                        accion = esVenta ? "Index" : "Intriga";
                        break;
                }

                if (onlyAction) return accion;
                return (mobile ? "/Mobile/" : "") + controlador + (controlador == "" ? "" : "/") + accion;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return accion;
            }
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
            }
            catch
            {
                //
            }

            return result;
        }

        public bool HabilitarChatEmtelco(int paisId)
        {
            bool Mostrar = false;
            List<TablaLogicaDatosModel> DataLogica = _tablaLogicaProvider.ObtenerParametrosTablaLogica(paisId, Constantes.TablaLogica.HabilitarChatEmtelco, false);

            if (IsMobile())
            {
                if (DataLogica.FirstOrDefault(x => x.Codigo.Equals("02")).Valor == "1")
                    Mostrar = true;
            }
            else
            {
                if (DataLogica.FirstOrDefault(x => x.Codigo.Equals("01")).Valor == "1")
                    Mostrar = true;
            }

            return Mostrar;
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

        #region Configuracion Seccion Palanca
        //public List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion(RevistaDigitalModel revistaDigital)
        //{
        //    var modelo = new List<ConfiguracionSeccionHomeModel>();

        //    try
        //    {
        //        if (revistaDigital == null)
        //            throw new ArgumentNullException("revistaDigital", "no puede ser nulo");

        //        var menuActivo = sessionManager.GetMenuContenedorActivo();

        //        if (menuActivo.CampaniaId <= 0)
        //            menuActivo.CampaniaId = userData.CampaniaID;


        //        var listaEntidad = sessionManager.GetSeccionesContenedor(menuActivo.CampaniaId);
        //        if (listaEntidad == null)
        //        {
        //            listaEntidad = GetConfiguracionOfertasHome(userData.PaisID, menuActivo.CampaniaId);
        //            sessionManager.SetSeccionesContenedor(menuActivo.CampaniaId, listaEntidad);
        //        }

        //        if (menuActivo.CampaniaId > userData.CampaniaID)
        //        {
        //            listaEntidad = listaEntidad.Where(entConf
        //            => entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
        //            || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento
        //            || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.InicioRD
        //            || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.HerramientasVenta).ToList();
        //        }

        //        var isMobile = IsMobile();
        //        foreach (var beConfiguracionOfertasHome in listaEntidad)
        //        {
        //            var entConf = beConfiguracionOfertasHome;
        //            entConf.ConfiguracionPais.Codigo = Util.Trim(entConf.ConfiguracionPais.Codigo).ToUpper();

        //            string titulo = "", subTitulo = "";

        //            #region Pre Validacion

        //            if (!SeccionTieneConfiguracionPais(entConf.ConfiguracionPais))
        //                continue;

        //            if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
        //                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida
        //                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
        //            {
        //                if (!RDObtenerTitulosSeccion(ref titulo, ref subTitulo, entConf.ConfiguracionPais.Codigo))
        //                    continue;

        //                entConf.DesktopTitulo = titulo;
        //                entConf.DesktopSubTitulo = subTitulo;

        //                entConf.MobileTitulo = titulo;
        //                entConf.MobileSubTitulo = subTitulo;

        //                if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
        //                {
        //                    entConf.MobileCantidadProductos = 0;
        //                    entConf.DesktopCantidadProductos = 0;
        //                }

        //            }
        //            else if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
        //            {
        //                if (!revistaDigital.TieneRevistaDigital()) continue;

        //                if (menuActivo.CampaniaId != userData.CampaniaID) entConf.UrlSeccion = "Revisar/" + entConf.UrlSeccion;
        //            }

        //            #endregion

        //            _configuracionPaisProvider.RemplazarTagNombreConfiguracionOferta(ref entConf, Constantes.TagCadenaRd.Nombre1, userData.Sobrenombre);

        //            var seccion = new ConfiguracionSeccionHomeModel
        //            {
        //                CampaniaID = menuActivo.CampaniaId,
        //                Codigo = entConf.ConfiguracionPais.Codigo ?? entConf.ConfiguracionOfertasHomeID.ToString().PadLeft(5, '0'),
        //                Orden = revistaDigital.TieneRevistaDigital() ? isMobile ? entConf.MobileOrdenBpt : entConf.DesktopOrdenBpt : isMobile ? entConf.MobileOrden : entConf.DesktopOrden,
        //                ColorFondo = isMobile ? (entConf.MobileColorFondo ?? "") : (entConf.DesktopColorFondo ?? ""),
        //                UsarImagenFondo = isMobile ? entConf.MobileUsarImagenFondo : entConf.DesktopUsarImagenFondo,
        //                ImagenFondo = isMobile ? (entConf.MobileImagenFondo ?? "") : (entConf.DesktopImagenFondo ?? ""),
        //                ColorTexto = isMobile ? entConf.MobileColorTexto ?? "" : entConf.DesktopColorTexto ?? "",
        //                Titulo = isMobile ? entConf.MobileTitulo : entConf.DesktopTitulo,
        //                SubTitulo = isMobile ? entConf.MobileSubTitulo : entConf.DesktopSubTitulo,
        //                TipoPresentacion = isMobile ? entConf.MobileTipoPresentacion : entConf.DesktopTipoPresentacion,
        //                TipoEstrategia = isMobile ? entConf.MobileTipoEstrategia : entConf.DesktopTipoEstrategia,
        //                CantidadMostrar = isMobile ? entConf.MobileCantidadProductos : entConf.DesktopCantidadProductos,
        //                UrlLandig = "/" + (isMobile ? "Mobile/" : "") + entConf.UrlSeccion,
        //                VerMas = true
        //            };

        //            seccion.TituloBtnAnalytics = seccion.Titulo.Replace("'", "");
        //            seccion.ImagenFondo = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, seccion.ImagenFondo);

        //            #region ConfiguracionPais.Codigo

        //            switch (entConf.ConfiguracionPais.Codigo)
        //            {
        //                case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
        //                    if (!_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
        //                        continue;

        //                    seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + "GuiaNegocio";
        //                    seccion.UrlObtenerProductos = "";
        //                    break;
        //                case Constantes.ConfiguracionPais.OfertasParaTi:
        //                    seccion.UrlObtenerProductos = "Estrategia/ConsultarEstrategiasOPT";
        //                    seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor : Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedor;
        //                    seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedorPopup : Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedorPopup;
        //                    seccion.VerMas = false;
        //                    break;
        //                case Constantes.ConfiguracionPais.Lanzamiento:
        //                    seccion.UrlObtenerProductos = "Estrategia/RDObtenerProductosLan";
        //                    seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor : Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedor;
        //                    seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup : Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedorPopup;
        //                    seccion.VerMas = false;
        //                    break;
        //                case Constantes.ConfiguracionPais.RevistaDigitalReducida:
        //                case Constantes.ConfiguracionPais.RevistaDigital:
        //                    seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + (menuActivo.CampaniaId > userData.CampaniaID ? "RevistaDigital/Revisar" : "RevistaDigital/Comprar");
        //                    seccion.UrlObtenerProductos = "Estrategia/RDObtenerProductos";
        //                    seccion.OrigenPedido = isMobile ? 0 : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedor;
        //                    seccion.OrigenPedidoPopup = isMobile ? 0 : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedorPopup;
        //                    break;
        //                case Constantes.ConfiguracionPais.ShowRoom:
        //                    ConfiguracionSeccionShowRoom(ref seccion);
        //                    if (seccion.UrlLandig == "")
        //                        continue;

        //                    seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.DesktopShowRoomContenedor : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedor;
        //                    break;
        //                case Constantes.ConfiguracionPais.OfertaDelDia:
        //                    if (!estrategiaODD.TieneOfertaDelDia)
        //                        continue;

        //                    sessionManager.OfertaDelDia.Estrategia.ConfiguracionContenedor = seccion;

        //                    break;
        //                case Constantes.ConfiguracionPais.HerramientasVenta:
        //                    seccion.UrlObtenerProductos = "Estrategia/HVObtenerProductos";
        //                    seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + (menuActivo.CampaniaId > userData.CampaniaID ? "HerramientasVenta/Revisar" : "HerramientasVenta/Comprar");
        //                    seccion.OrigenPedido = isMobile ? 0 : Constantes.OrigenPedidoWeb.HVDesktopContenedor;
        //                    seccion.OrigenPedidoPopup = isMobile ? 0 : Constantes.OrigenPedidoWeb.HVDesktopContenedorPopup;
        //                    break;
        //            }
        //            #endregion

        //            #region TipoPresentacion

        //            seccion.TemplatePresentacion = "";
        //            seccion.TemplateProducto = "";
        //            switch (seccion.TipoPresentacion)
        //            {
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselSimple:
        //                    seccion.TemplatePresentacion = "seccion-simple-centrado";
        //                    seccion.TemplateProducto = "#producto-landing-template";
        //                    break;
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselPrevisuales:
        //                    seccion.TemplatePresentacion = "seccion-carrusel-previsuales";
        //                    seccion.TemplateProducto = "#lanzamiento-carrusel-template";
        //                    break;
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado:
        //                    seccion.TemplatePresentacion = "seccion-simple-centrado";
        //                    seccion.TemplateProducto = "#producto-landing-template";
        //                    seccion.CantidadMostrar = isMobile ? 1 : seccion.CantidadMostrar > 3 || seccion.CantidadMostrar <= 0 ? 3 : seccion.CantidadMostrar;
        //                    break;
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.Banners:
        //                    seccion.TemplatePresentacion = "seccion-banner";
        //                    seccion.CantidadMostrar = 0;
        //                    break;
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.ShowRoom:
        //                    seccion.TemplatePresentacion = "seccion-simple-centrado";
        //                    //seccion.TemplateProducto = "#template-showroom";
        //                    seccion.TemplateProducto = "#producto-landing-template";
        //                    break;
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.OfertaDelDia:
        //                    seccion.TemplatePresentacion = "seccion-oferta-del-dia";
        //                    break;

        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.DescagablesNavidenos:
        //                    seccion.TemplatePresentacion = "seccion-descargables-navidenos";
        //                    break;
        //                case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselIndividuales:
        //                    seccion.TemplatePresentacion = "seccion-carrusel-individuales";
        //                    seccion.TemplateProducto = "#lanzamiento-carrusel-individual-template";
        //                    break;
        //            }

        //            if (seccion.TemplatePresentacion == "") continue;
        //            #endregion

        //            modelo.Add(seccion);
        //        }

        //        modelo = modelo.OrderBy(s => s.Orden).ToList();
        //    }
        //    catch (Exception ex)
        //    {
        //        logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseController.ObtenerConfiguracionSeccion");
        //    }

        //    return modelo;
        //}

        //private bool SeccionTieneConfiguracionPais(ServiceSAC.BEConfiguracionPais configuracionPais)
        //{
        //    var result = false;

        //    var configuracionesPais = sessionManager.GetConfiguracionesPaisModel();
        //    if (configuracionesPais != null)
        //    {
        //        var cp = configuracionesPais.FirstOrDefault(x => x.Codigo == configuracionPais.Codigo);
        //        result = cp != null && cp.ConfiguracionPaisID >= 0 && !string.IsNullOrWhiteSpace(cp.Codigo);

        //    }

        //    return result;
        //}

        //private List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
        //{
        //    List<BEConfiguracionOfertasHome> configuracionesOfertasHomes;

        //    using (var sv = new SACServiceClient())
        //    {
        //        configuracionesOfertasHomes = sv.ListarSeccionConfiguracionOfertasHome(paidId, campaniaId).ToList();
        //    }

        //    return configuracionesOfertasHomes;
        //}

        //private void ConfiguracionSeccionShowRoom(ref ConfiguracionSeccionHomeModel seccion)
        //{
        //    seccion.UrlLandig = "";

        //    if (!sessionManager.GetEsShowRoom())
        //        return;

        //    if (sessionManager.GetMostrarShowRoomProductosExpiro())
        //        return;

        //    if (!sessionManager.GetMostrarShowRoomProductos())
        //    {

        //        seccion.UrlLandig = (seccion.IsMobile ? "/Mobile/" : "/") + "ShowRoom/Intriga";
        //        seccion.UrlObtenerProductos = "ShowRoom/GetDataShowRoomIntriga";

        //        if (!IsMobile())
        //        {
        //            seccion.ImagenFondo =
        //                _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomIntriga,
        //                                                    Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
        //        }
        //        else
        //        {
        //            seccion.ImagenFondo =
        //                _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasIntriga,
        //                                                    Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
        //        }
        //    }
        //    else
        //    {
        //        seccion.UrlLandig = (seccion.IsMobile ? "/Mobile/" : "/") + "ShowRoom";
        //        seccion.UrlObtenerProductos = "ShowRoom/CargarProductosShowRoomOferta";
        //        if (!IsMobile())
        //        {
        //            seccion.ImagenFondo =
        //                _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomVenta,
        //                                                    Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
        //        }
        //        else
        //        {
        //            seccion.ImagenFondo =
        //                _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasVenta,
        //                                                    Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
        //        }

        //        var listaShowRoom = sessionManager.ShowRoom.Ofertas ?? new List<EstrategiaPersonalizadaProductoModel>();
        //        //seccion.CantidadProductos = listaShowRoom.Count(x => !x.EsSubCampania);
        //        seccion.CantidadProductos = listaShowRoom.Count();
        //        seccion.CantidadMostrar = Math.Min(3, seccion.CantidadProductos);
        //    }
        //}

        //private bool RDObtenerTitulosSeccion(ref string titulo, ref string subtitulo, string codigo)
        //{
        //    if (codigo == Constantes.ConfiguracionPais.RevistaDigital && !revistaDigital.TieneRDC) return false;

        //    titulo = revistaDigital.TieneRDC
        //        ? (revistaDigital.EsActiva || revistaDigital.EsSuscrita)
        //            ? "OFERTAS CLUB GANA+"
        //            : "OFERTAS GANA+"
        //        : "";

        //    subtitulo = userData.Sobrenombre.ToUpper() + ", PRUEBA LAS VENTAJAS DE COMPRAR OFERTAS PERSONALIZADAS";

        //    if (codigo == Constantes.ConfiguracionPais.OfertasParaTi)
        //    {
        //        if (revistaDigital.TieneRDC) return false;

        //        titulo = "MÁS OFERTAS PARA TI " + userData.Sobrenombre.ToUpper();
        //        subtitulo = "EXCLUSIVAS SÓLO POR WEB";
        //    }

        //    return true;
        //}
        #endregion

        protected List<ServicePedido.BETipoEstrategia> GetTipoEstrategias()
        {
            int PaisID = userData.PaisID, TipoEstrategiaID = 0;
            List<ServicePedido.BETipoEstrategia> tiposEstrategia = _tipoEstrategiaProvider.GetTipoEstrategias(PaisID, TipoEstrategiaID);
            return tiposEstrategia;
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
            ViewBag.MensajeFechaPromesa = GetFechaPromesa(HoraCierrePortal, ViewBag.Dias);

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
                //ViewBag.MostrarOfertaDelDiaContenedor = estrategiaODD.TieneOfertaDelDia;
                //ViewBag.oddConfiguracion = _ofertaDelDiaProvider.GetOfertaDelDiaConfiguracion(userData);
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

            ViewBag.SaludoFestivo = sessionManager.GetEventoFestivoDataModel().EfSaludo;

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

            var esMobile = IsMobile();
            var menuActivo = _menuContenedorProvider.GetMenuActivo(userData, revistaDigital, herramientasVenta, Request, guiaNegocio, sessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);
            ViewBag.MenuContenedorActivo = menuActivo;
            ViewBag.MenuContenedor = _menuContenedorProvider.GetMenuContenedorByMenuActivoCampania(menuActivo.CampaniaId, userData.CampaniaID, userData, revistaDigital, guiaNegocio, sessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);

            ViewBag.MenuMobile = BuildMenuMobile(userData, revistaDigital);
            ViewBag.Permiso = BuildMenu(userData, revistaDigital);

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

            ViewBag.TokenPedidoAutenticoOk = (Session["TokenPedidoAutentico"] != null) ? 1 : 0;
            ViewBag.CodigoEstrategia = _revistaDigitalProvider.GetCodigoEstrategia();
            ViewBag.BannerInferior = _showRoomProvider.EvaluarBannerConfiguracion(userData.PaisID, sessionManager);
            ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
            int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
            if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

            ViewBag.HabilitarChatEmtelco = HabilitarChatEmtelco(userData.PaisID);
        }

        private string GetFechaPromesa(TimeSpan horaCierre, int diasFaltantes)
        {
            var time = DateTime.Today.Add(horaCierre);
            string fecha = null;

            if (IsMobile())
            {
                string hrCierrePortal = time.ToString("hh:mm tt").Replace(". ", "").ToUpper();

                fecha = diasFaltantes > 0
                    ? " CIERRA EL " + userData.FechaInicioCampania.Day + " " + Util.NombreMes(userData.FechaInicioCampania.Month).ToUpper()
                    : " CIERRA HOY";


                return fecha + " - " + hrCierrePortal.Replace(".", "");
            }
            else
            {
                var culture = CultureInfo.GetCultureInfo("es-PE");
                fecha = diasFaltantes > 0
                    ? userData.FechaInicioCampania.ToString("dd MMM", culture).ToUpper()
                    : "HOY";

                return fecha + " - " + time.ToString("hh:mm tt", CultureInfo.InvariantCulture).ToLower();
            }

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

                        Session["PedidoWeb"] = null;
                        Session["PedidoWebDetalle"] = null;
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

        protected string ActualizarMisDatos(ServiceUsuario.BEUsuario usuario, string correoAnterior)
        {
            usuario.ZonaID = UserData().ZonaID;
            usuario.RegionID = UserData().RegionID;
            usuario.ConsultoraID = UserData().ConsultoraID;
            usuario.PaisID = UserData().PaisID;
            usuario.PrimerNombre = userData.PrimerNombre;
            usuario.CodigoISO = UserData().CodigoISO;

            var resultado = string.Empty;
            using (UsuarioServiceClient svr = new UsuarioServiceClient())
            {
                resultado = svr.ActualizarMisDatos(usuario, correoAnterior);
            }

            resultado = Util.Trim(resultado);
            if (resultado.Split('|')[0] != "0")
            {
                var userDataX = UserData();
                if (usuario.EMail != correoAnterior)
                {
                    userDataX.EMail = usuario.EMail;
                }
                userDataX.Celular = usuario.Celular;
                sessionManager.SetUserData(userDataX);
            }

            return resultado;
        }

        #region PaqueteDocumentario

        protected List<RVPRFModel> GetListPaqueteDocumentario(string codigoConsultora, string campania, string numeroPedido)
        {
            string errorMessage;
            return GetListPaqueteDocumentario(codigoConsultora, campania, numeroPedido, out errorMessage);
        }

        protected List<RVPRFModel> GetListPaqueteDocumentario(string codigoConsultora, string campania, string numeroPedido, out string errorMessage)
        {
            errorMessage = string.Empty;

            var lstRVPRFModel = new List<RVPRFModel>();
            try
            {
                var input = new
                {
                    Pais = userData.CodigoISO,
                    Tipo = "1",
                    CodigoConsultora = codigoConsultora,
                    Campana = campania,
                    NumeroPedido = numeroPedido
                };
                var urlService = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_PDF_NEW);
                var wrapper = ConsumirServicio<WrapperPDFWeb>(input, urlService);

                var result = (wrapper ?? new WrapperPDFWeb()).GET_URLResult;
                if (result != null)
                {
                    if (result.errorCode != "00000" && result.errorMessage != "OK") errorMessage = result.errorMessage;

                    if (string.IsNullOrEmpty(errorMessage) && result.objeto != null)
                    {
                        lstRVPRFModel = result.objeto.Select(item => new RVPRFModel
                        {
                            Nombre = "Paquete Documentario",
                            FechaFacturacion = item.fechaFacturacion,
                            Ruta = Convert.ToString(item.url)
                        }).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorMessage = Constantes.MensajesError.PaqueteDocumentario_ConsumirServicio;
            }
            return lstRVPRFModel;
        }

        protected List<CampaniaModel> GetListCampaniaPaqueteDocumentario(string codigoConsultora, out string errorMessage)
        {
            errorMessage = string.Empty;

            var lstCampaniaModel = new List<CampaniaModel>();
            try
            {
                var input = new
                {
                    Pais = userData.CodigoISO,
                    Tipo = "1",
                    CodigoConsultora = codigoConsultora
                };
                var urlService = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_Campanias_NEW);
                var wrapper = ConsumirServicio<WrapperCampanias>(input, urlService);

                var result = (wrapper ?? new WrapperCampanias()).LIS_CampanaResult;
                if (result != null)
                {
                    if (result.errorCode != string.Empty && result.errorCode != "00000") errorMessage = result.errorMessage;

                    if (string.IsNullOrEmpty(errorMessage) && result.lista != null)
                    {
                        lstCampaniaModel = result.lista.Select(p => p.campana).Distinct()
                            .Select(s => new CampaniaModel() { CampaniaID = Convert.ToInt32(s), Codigo = s })
                            .OrderBy(c => c.CampaniaID).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorMessage = Constantes.MensajesError.PaqueteDocumentario_ConsumirServicio;
            }
            return lstCampaniaModel;
        }

        private T ConsumirServicio<T>(object input, string metodo)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            WebRequest request = WebRequest.Create(metodo);
            request.Method = "POST";
            request.ContentType = "application/json; charset=utf-8";

            string inputJson = serializer.Serialize(input);
            using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
            {
                writer.Write(inputJson);
            }

            string outputJson;
            using (StreamReader reader = new StreamReader(request.GetResponse().GetResponseStream()))
            {
                outputJson = reader.ReadToEnd();
            }
            return serializer.Deserialize<T>(outputJson);
        }

        #endregion

        public async Task<List<BEComunicado>> ObtenerComunicadoPorConsultoraAsync()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = await sac.ObtenerComunicadoPorConsultoraAsync(UserData().PaisID, UserData().CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Desktop, UserData().CodigorRegion, UserData().CodigoZona, UserData().ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }

        protected MensajeProductoBloqueadoModel HVMensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();

            model.divId = "divHVMensajeBloqueada";
            model.IsMobile = IsMobile();
            model.MensajeIconoSuperior = true;
            model.BtnInscribirse = false;
            model.MensajeTieneDudas = false;

            string codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.HV.MPopupBloqueado : Constantes.ConfiguracionPaisDatos.HV.DPopupBloqueado;
            var dato = herramientasVenta.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            model.MensajeTitulo = dato == null ? "" : Util.Trim(dato.Valor1);

            return model;
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

        #region PagoEnLinea

        //public PagoEnLineaModel ObtenerValoresPagoEnLinea()
        //{
        //    var model = new PagoEnLineaModel();

        //    model.CodigoIso = userData.CodigoISO;
        //    model.Simbolo = userData.Simbolo;
        //    model.MontoDeuda = userData.MontoDeuda;
        //    model.FechaVencimiento = userData.FechaLimPago;

        //    var listaConfiguracion = _tablaLogicaProvider.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

        //    var porcentajeGastosAdministrativosString = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.PorcentajeGastosAdministrativos);
        //    int porcentajeGastosAdministrativos;
        //    bool esInt = int.TryParse(porcentajeGastosAdministrativosString, out porcentajeGastosAdministrativos);

        //    model.PorcentajeGastosAdministrativos = esInt ? porcentajeGastosAdministrativos : 0;

        //    return model;
        //}

        //public PagoVisaModel ObtenerValoresPagoVisa(PagoEnLineaModel model)
        //{
        //    var pagoVisaModel = new PagoVisaModel();

        //    #region Valores Configuracion Pago En Linea

        //    var listaConfiguracion = _tablaLogicaProvider.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

        //    pagoVisaModel.MerchantId = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MerchantId);
        //    pagoVisaModel.AccessKeyId = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.AccessKeyId);
        //    pagoVisaModel.SecretAccessKey = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.SecretAccessKey);
        //    pagoVisaModel.UrlSessionBotonPagos = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlSessionBotonPago);
        //    pagoVisaModel.UrlGenerarNumeroPedido = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlGenerarNumeroPedido);
        //    pagoVisaModel.UrlLibreriaPagoVisa = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLibreriaPagoVisa);
        //    pagoVisaModel.SessionToken = Guid.NewGuid().ToString().ToUpper();

        //    #endregion

        //    pagoVisaModel.Amount = model.MontoDeudaConGastos;

        //    #region Generar Sesion para el boton de pagos

        //    string urlCreateSessionTokenAPI = pagoVisaModel.UrlSessionBotonPagos + pagoVisaModel.MerchantId;

        //    string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(pagoVisaModel.AccessKeyId + ":" + pagoVisaModel.SecretAccessKey));

        //    DataToken datatoken = new DataToken();
        //    datatoken.amount = Convert.ToDouble(pagoVisaModel.Amount.ToString());

        //    string json = JsonHelper.JsonSerializer<DataToken>(datatoken);

        //    HttpWebRequest requestSesion;
        //    requestSesion = WebRequest.Create(urlCreateSessionTokenAPI) as HttpWebRequest;
        //    requestSesion.Method = "POST";
        //    requestSesion.ContentType = "application/json";
        //    requestSesion.Headers.Add("Authorization", "Basic " + credentials);
        //    requestSesion.Headers.Add("VisaNet-Session-Key", pagoVisaModel.SessionToken);

        //    StreamWriter postStreamWriterSesion = new StreamWriter(requestSesion.GetRequestStream());
        //    postStreamWriterSesion.Write(json);
        //    postStreamWriterSesion.Close();

        //    HttpWebResponse responseSesion;
        //    responseSesion = requestSesion.GetResponse() as HttpWebResponse;
        //    StreamReader postStreamReaderSesion = new StreamReader(responseSesion.GetResponseStream());

        //    postStreamReaderSesion.ReadToEnd();
        //    postStreamReaderSesion.Close();

        //    #endregion

        //    #region Generar Numero de Pedido

        //    string urlNextCounterAPI = pagoVisaModel.UrlGenerarNumeroPedido + pagoVisaModel.MerchantId + "/nextCounter";
        //    HttpWebRequest requestNumPedido;
        //    requestNumPedido = WebRequest.Create(urlNextCounterAPI) as HttpWebRequest;
        //    requestNumPedido.Method = "GET";
        //    requestNumPedido.ContentType = "application/json";
        //    requestNumPedido.Headers.Add("Authorization", "Basic " + credentials);

        //    HttpWebResponse responseNumPedido;
        //    responseNumPedido = requestNumPedido.GetResponse() as HttpWebResponse;
        //    StreamReader postStreamReaderNumPedido = new StreamReader(responseNumPedido.GetResponseStream());

        //    pagoVisaModel.PurchaseNumber = postStreamReaderNumPedido.ReadToEnd();
        //    postStreamReaderNumPedido.Close();

        //    #endregion

        //    #region Variables para el formulario de pago visa

        //    pagoVisaModel.MerchantLogo = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLogoPasarelaPago);
        //    pagoVisaModel.FormButtonColor = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.ColorBotonPagarPasarelaPago);
        //    pagoVisaModel.Recurrence = "FALSE";
        //    pagoVisaModel.RecurrenceFrequency = "";
        //    pagoVisaModel.RecurrenceType = "";
        //    pagoVisaModel.RecurrenceAmount = "0.00";

        //    #endregion

        //    #region Obtener Token de Tarjeta Guardada

        //    var tokenTarjetaGuardada = "";

        //    try
        //    {
        //        using (PedidoServiceClient ps = new PedidoServiceClient())
        //        {
        //            tokenTarjetaGuardada = ps.ObtenerTokenTarjetaGuardadaByConsultora(userData.PaisID, userData.CodigoConsultora);
        //        }
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
        //        tokenTarjetaGuardada = "";
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
        //        tokenTarjetaGuardada = "";
        //    }

        //    pagoVisaModel.TokenTarjetaGuardada = tokenTarjetaGuardada;

        //    #endregion

        //    return pagoVisaModel;
        //}

        //public bool ProcesarPagoVisa(ref PagoEnLineaModel model, string transactionToken)
        //{
        //    var resultado = false;

        //    try
        //    {
        //        string sessionToken = model.PagoVisaModel.SessionToken;
        //        string merchantId = model.PagoVisaModel.MerchantId;
        //        string accessKeyId = model.PagoVisaModel.AccessKeyId;
        //        string secretAccessKey = model.PagoVisaModel.SecretAccessKey;

        //        var respuestaAutorizacion = GenerarAutorizacionBotonPagos(sessionToken, merchantId, transactionToken, accessKeyId, secretAccessKey);
        //        var respuestaVisa = JsonHelper.JsonDeserialize<RespuestaAutorizacionVisa>(respuestaAutorizacion);

        //        BEPagoEnLineaResultadoLog bePagoEnLinea = GenerarEntidadPagoEnLineaLog(respuestaVisa);
        //        bePagoEnLinea.MontoPago = model.MontoDeuda;
        //        bePagoEnLinea.MontoGastosAdministrativos = model.MontoGastosAdministrativos;

        //        int pagoEnLineaResultadoLogId = 0;
        //        using (PedidoServiceClient ps = new PedidoServiceClient())
        //        {
        //            pagoEnLineaResultadoLogId = ps.InsertPagoEnLineaResultadoLog(userData.PaisID, bePagoEnLinea);
        //        }

        //        // Requerido en pago rechazado.
        //        model.NumeroOperacion = bePagoEnLinea.NumeroOrdenTienda;
        //        model.FechaCreacion = bePagoEnLinea.FechaTransaccion;
        //        model.DescripcionCodigoAccion = bePagoEnLinea.DescripcionCodigoAccion;

        //        if (bePagoEnLinea.CodigoError == "0" && bePagoEnLinea.CodigoAccion == "000")
        //        {
        //            model.PagoEnLineaResultadoLogId = pagoEnLineaResultadoLogId;
        //            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
        //            model.PrimerApellido = userData.PrimerApellido;
        //            model.TarjetaEnmascarada = bePagoEnLinea.NumeroTarjeta;
        //            model.FechaVencimiento = userData.FechaLimPago;
        //            model.SaldoPendiente = decimal.Round(userData.MontoDeuda - model.MontoDeuda, 2);

        //            using (PedidoServiceClient ps = new PedidoServiceClient())
        //            {
        //                ps.UpdateMontoDeudaConsultora(userData.PaisID, userData.CodigoConsultora, model.SaldoPendiente);
        //            }

        //            var listaConfiguracion = _tablaLogicaProvider.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
        //            var mensajeExitoso = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MensajeInformacionPagoExitoso);

        //            model.MensajeInformacionPagoExitoso = mensajeExitoso;

        //            userData.MontoDeuda = model.SaldoPendiente;
        //            sessionManager.SetUserData(userData);

        //            if (!string.IsNullOrEmpty(userData.EMail))
        //            {
        //                string template = ObtenerTemplatePagoEnLinea(model);
        //                Util.EnviarMail("no-responder@somosbelcorp.com", userData.EMail, "PAGO EN LINEA", template, true, userData.NombreConsultora);
        //            }

        //            resultado = true;
        //        }
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
        //    }

        //    sessionManager.SetDatosPagoVisa(null);
        //    Session["ListadoEstadoCuenta"] = null;

        //    return resultado;
        //}

        //public string GenerarAutorizacionBotonPagos(string sessionToken, string merchantId, string transactionToken, string accessKeyId, string secretAccessKey)
        //{
        //    var listaConfiguracion = _tablaLogicaProvider.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
        //    string urlAutorizacionBotonPago = _tablaLogicaProvider.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlAutorizacionBotonPago);

        //    string urlAuthorize = urlAutorizacionBotonPago + merchantId;
        //    string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(accessKeyId + ":" + secretAccessKey));

        //    Common.PagoEnLinea.Data data = new Common.PagoEnLinea.Data();

        //    DataRequestAut dataAutorizacionRQ = new DataRequestAut();
        //    dataAutorizacionRQ.transactionToken = transactionToken;
        //    dataAutorizacionRQ.sessionToken = sessionToken;
        //    dataAutorizacionRQ.data = data;

        //    string json = JsonHelper.JsonSerializer<DataRequestAut>(dataAutorizacionRQ);

        //    HttpWebRequest requestAutorizacion;
        //    requestAutorizacion = WebRequest.Create(urlAuthorize) as HttpWebRequest;
        //    requestAutorizacion.Method = "POST";
        //    requestAutorizacion.ContentType = "application/json";
        //    requestAutorizacion.Headers.Add("Authorization", "Basic " + credentials);
        //    StreamWriter postStreamWriterAutorizacion = new StreamWriter(requestAutorizacion.GetRequestStream());
        //    postStreamWriterAutorizacion.Write(json);
        //    postStreamWriterAutorizacion.Close();

        //    HttpWebResponse responseAutorizacion;
        //    StreamReader postStreamReaderAutorizacion;
        //    string respuestaAutorizacion;
        //    try
        //    {
        //        responseAutorizacion = requestAutorizacion.GetResponse() as HttpWebResponse;
        //        postStreamReaderAutorizacion = new StreamReader(responseAutorizacion.GetResponseStream());
        //        respuestaAutorizacion = postStreamReaderAutorizacion.ReadToEnd();
        //        postStreamReaderAutorizacion.Close();
        //    }
        //    catch (WebException ex)
        //    {
        //        postStreamReaderAutorizacion = new StreamReader(ex.Response.GetResponseStream(), true);
        //        respuestaAutorizacion = postStreamReaderAutorizacion.ReadToEnd();
        //        postStreamReaderAutorizacion.Close();
        //    }

        //    return respuestaAutorizacion;
        //}

        //public BEPagoEnLineaResultadoLog GenerarEntidadPagoEnLineaLog(RespuestaAutorizacionVisa respuestaVisa)
        //{
        //    BEPagoEnLineaResultadoLog bePagoEnLinea = new BEPagoEnLineaResultadoLog();

        //    bePagoEnLinea.ConsultoraId = userData.ConsultoraID;
        //    bePagoEnLinea.CodigoConsultora = userData.CodigoConsultora;
        //    bePagoEnLinea.NumeroDocumento = userData.DocumentoIdentidad;
        //    bePagoEnLinea.CampaniaId = userData.CampaniaID;
        //    bePagoEnLinea.FechaVencimiento = userData.FechaLimPago;
        //    bePagoEnLinea.TipoTarjeta = "VISA";
        //    bePagoEnLinea.CodigoError = respuestaVisa.errorCode ?? "";
        //    bePagoEnLinea.MensajeError = respuestaVisa.errorMessage ?? "";
        //    bePagoEnLinea.IdGuidTransaccion = respuestaVisa.transactionUUID ?? "";
        //    bePagoEnLinea.IdGuidExternoTransaccion = respuestaVisa.externalTransactionId ?? "";
        //    bePagoEnLinea.MerchantId = respuestaVisa.merchantId ?? "";
        //    bePagoEnLinea.IdTokenUsuario = respuestaVisa.userTokenId ?? "";
        //    bePagoEnLinea.AliasNameTarjeta = respuestaVisa.aliasName ?? "";

        //    var fechaTransaccion = string.IsNullOrEmpty(respuestaVisa.data.FECHAYHORA_TX) ? DateTime.MinValue.ToString() : respuestaVisa.data.FECHAYHORA_TX;
        //    bePagoEnLinea.FechaTransaccion = Convert.ToDateTime(fechaTransaccion);
        //    if (bePagoEnLinea.FechaTransaccion == DateTime.MinValue)
        //        bePagoEnLinea.FechaTransaccion = DateTime.Now;

        //    bePagoEnLinea.ResultadoValidacionCVV2 = respuestaVisa.data.RES_CVV2 ?? "";
        //    bePagoEnLinea.CsiMensaje = respuestaVisa.data.CSIMENSAJE ?? "";
        //    bePagoEnLinea.IdUnicoTransaccion = respuestaVisa.data.ID_UNICO ?? "";
        //    bePagoEnLinea.Etiqueta = respuestaVisa.data.ETICKET ?? "";
        //    bePagoEnLinea.RespuestaSistemAntifraude = respuestaVisa.data.DECISIONCS ?? "";
        //    bePagoEnLinea.CsiPorcentajeDescuento = Convert.ToDecimal(respuestaVisa.data.CSIPORCENTAJEDESCUENTO ?? "0");
        //    bePagoEnLinea.NumeroCuota = respuestaVisa.data.NROCUOTA ?? "";
        //    bePagoEnLinea.TokenTarjetaGuardada = respuestaVisa.data.cardTokenUUID ?? "";
        //    bePagoEnLinea.CsiImporteComercio = Convert.ToDecimal(respuestaVisa.data.CSIIMPORTECOMERCIO ?? "0");
        //    bePagoEnLinea.CsiCodigoPrograma = respuestaVisa.data.CSICODIGOPROGRAMA ?? "";
        //    bePagoEnLinea.DescripcionIndicadorComercioElectronico = respuestaVisa.data.DSC_ECI ?? "";
        //    bePagoEnLinea.IndicadorComercioElectronico = respuestaVisa.data.ECI ?? "";
        //    bePagoEnLinea.DescripcionCodigoAccion = respuestaVisa.data.DSC_COD_ACCION ?? "";
        //    bePagoEnLinea.NombreBancoEmisor = respuestaVisa.data.NOM_EMISOR ?? "";
        //    bePagoEnLinea.ImporteCuota = Convert.ToDecimal(respuestaVisa.data.IMPCUOTAAPROX ?? "0");
        //    bePagoEnLinea.CsiTipoCobro = respuestaVisa.data.CSITIPOCOBRO ?? "";
        //    bePagoEnLinea.NumeroReferencia = respuestaVisa.data.NUMREFERENCIA ?? "";
        //    bePagoEnLinea.Respuesta = respuestaVisa.data.RESPUESTA ?? "";
        //    bePagoEnLinea.NumeroOrdenTienda = respuestaVisa.data.NUMORDEN ?? "";
        //    bePagoEnLinea.CodigoAccion = respuestaVisa.data.CODACCION ?? "";
        //    bePagoEnLinea.ImporteAutorizado = Convert.ToDecimal(respuestaVisa.data.IMP_AUTORIZADO ?? "0");
        //    bePagoEnLinea.CodigoAutorizacion = respuestaVisa.data.COD_AUTORIZA ?? "";
        //    bePagoEnLinea.CodigoTienda = respuestaVisa.data.CODTIENDA ?? "";
        //    bePagoEnLinea.NumeroTarjeta = respuestaVisa.data.PAN ?? "";
        //    bePagoEnLinea.OrigenTarjeta = respuestaVisa.data.ORI_TARJETA ?? "";
        //    bePagoEnLinea.UsuarioCreacion = userData.CodigoUsuario;

        //    return bePagoEnLinea;
        //}

        //public string ObtenerTemplatePagoEnLinea(PagoEnLineaModel model)
        //{
        //    string templatePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_pago_en_linea.html";
        //    string htmlTemplate = FileManager.GetContenido(templatePath);

        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_NOMBRECOMPLETO#", model.NombreConsultora + " " + model.PrimerApellido);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMEROOPERACION#", model.NumeroOperacion);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAPAGO#", model.FechaCreacionString);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTODEUDA#", model.MontoDeudaString);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOGASTOSADMINISTRATIVOS#", model.MontoGastosAdministrativosString);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOTOTAL#", model.MontoDeudaConGastosString);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_SIMBOLO#", model.Simbolo);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_SALDOPENDIENTE#", model.SaldoPendienteString);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAVENCIMIENTO#", model.FechaVencimientoString);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_MENSAJEINFORMACION#", model.MensajeInformacionPagoExitoso);
        //    htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMTARJETA#", model.TarjetaEnmascarada);

        //    return htmlTemplate;
        //}

        #endregion

        protected void GetNotificacionesValAutoProl(long procesoId, int tipoOrigen, out List<BENotificacionesDetalle> lstObservaciones, out List<BENotificacionesDetallePedido> lstObservacionesPedido)
        {
            using (var service = new UsuarioServiceClient())
            {
                lstObservaciones = service.GetNotificacionesConsultoraDetalle(userData.PaisID, procesoId, tipoOrigen).ToList();
                lstObservacionesPedido = service.GetNotificacionesConsultoraDetallePedido(userData.PaisID, procesoId, tipoOrigen).ToList();
            }
            lstObservaciones = lstObservaciones.GroupBy(o => o.CUV).Select(g => g.First()).ToList();
        }

        public bool EsDispositivoMovil()
        {
            return Request.Browser.IsMobileDevice;
        }

        public string GetControllerActual()
        {
            return ControllerContext.RouteData.Values["controller"].ToString();
        }
        
    }
}
