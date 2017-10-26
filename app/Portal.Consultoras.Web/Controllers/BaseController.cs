using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;
using Portal.Consultoras.Web.Helpers;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseController : Controller
    {
        #region Variables

        protected UsuarioModel userData;
        protected RevistaDigitalModel revistaDigital;
        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;

        #endregion

        #region Constructor

        public BaseController()
        {
            userData = new UsuarioModel();
        }

        public BaseController(ISessionManager sessionManager)
            : this()
        {
            this.sessionManager = sessionManager;
        }

        #endregion

        #region Overrides

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                userData = UserData();
                revistaDigital = sessionManager.GetRevistaDigital() ?? new RevistaDigitalModel();
                if (userData == null || userData == default(UsuarioModel))
                {
                    string URLSignOut = string.Empty;
                    if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().Contains(Request.Url.Host))
                        URLSignOut = "/Login/SesionExpirada";
                    else
                        URLSignOut = "/Login/UserUnknown";

                    Session.Clear();
                    Session.Abandon();
                    FormsAuthentication.SignOut();

                    filterContext.Result = new RedirectResult(URLSignOut);
                    return;
                }

                if (Request.IsAjaxRequest())
                {
                    base.OnActionExecuting(filterContext);
                    return;
                }

                ViewBag.MenuContenedorActivo = GetMenuActivo();
                ViewBag.MenuContenedor = ObtenerMenuContenedor();

                ViewBag.MenuMobile = BuildMenuMobile(userData);
                ViewBag.Permiso = BuildMenu();

                ViewBag.ProgramaBelcorpMenu = BuildMenuService();
                ViewBag.codigoISOMenu = userData.CodigoISO;

                /*** EPD 2170 ***/
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
                        ViewBag.SegmentoConsultoraMenu = userData.SegmentoInternoID.HasValue ? userData.SegmentoInternoID.Value : userData.SegmentoID;
                    }
                }
                /*** FIN EPD 2170 ***/

                ViewBag.UrlRaizS3 = string.Format("{0}/{1}/{2}/", ConfigurationManager.AppSettings["URL_S3"], ConfigurationManager.AppSettings["BUCKET_NAME"], ConfigurationManager.AppSettings["ROOT_DIRECTORY"]);

                ViewBag.ServiceController = (ConfigurationManager.AppSettings["ServiceController"] == null) ? "" : ConfigurationManager.AppSettings["ServiceController"].ToString();
                ViewBag.ServiceAction = (ConfigurationManager.AppSettings["ServiceAction"] == null) ? "" : ConfigurationManager.AppSettings["ServiceAction"].ToString();

                ObtenerPedidoWeb();
                ObtenerPedidoWebDetalle();

                ViewBag.EsMobile = 1;//EPD-1780

                if (userData.TieneLoginExterno)
                {
                    var loginFacebook = userData.ListaLoginExterno.Where(x => x.Proveedor == "Facebook").FirstOrDefault();
                    if (loginFacebook != null)
                    {
                        ViewBag.FotoPerfil = loginFacebook.FotoPerfil;
                    }
                }

                ViewBag.TokenPedidoAutenticoOk = (Session["TokenPedidoAutentico"] != null) ? 1 : 0;
                ViewBag.CodigoEstrategia = GetCodigoEstrategia();

                base.OnActionExecuting(filterContext);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        #endregion

        #region Métodos

        #region Pedido

        public virtual BEPedidoWeb ObtenerPedidoWeb()
        {
            var pedidoWeb = (BEPedidoWeb)null;

            try
            {
                pedidoWeb = sessionManager.GetPedidoWeb();

                if (pedidoWeb == null)
                    using (var pedidoServiceClient = new PedidoServiceClient())
                    {
                        pedidoWeb = pedidoServiceClient.GetPedidoWebByCampaniaConsultora(
                            userData.PaisID,
                            userData.CampaniaID,
                            userData.ConsultoraID
                        );
                    }

                pedidoWeb = pedidoWeb ?? new BEPedidoWeb();
                sessionManager.SetPedidoWeb(pedidoWeb);
            }
            catch (Exception ex)
            {
                pedidoWeb = pedidoWeb ?? new BEPedidoWeb();
                sessionManager.SetPedidoWeb(pedidoWeb);

                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return pedidoWeb;
        }

        protected int EsOpt()
        {
            var esOpt = revistaDigital.TieneRDR
                    || (revistaDigital.TieneRDC && revistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                    ? 1 : 2;
            return esOpt;
        }

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle()
        {
            var detallesPedidoWeb = (List<BEPedidoWebDetalle>)null;
            try
            {
                detallesPedidoWeb = sessionManager.GetDetallesPedido();

                if (detallesPedidoWeb == null)
                {
                    using (var pedidoServiceClient = new PedidoServiceClient())
                    {
                        detallesPedidoWeb = pedidoServiceClient.SelectByCampania(
                            userData.PaisID,
                            userData.CampaniaID,
                            userData.ConsultoraID,
                            userData.NombreConsultora,
                            EsOpt()
                        ).ToList();
                    }
                }

                detallesPedidoWeb = detallesPedidoWeb ?? new List<BEPedidoWebDetalle>();

                foreach (var item in detallesPedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre;
                }
                var observacionesProl = sessionManager.GetObservacionesProl();
                if (detallesPedidoWeb.Count > 0 && observacionesProl != null)
                {
                    detallesPedidoWeb = PedidoConObservaciones(detallesPedidoWeb, observacionesProl);
                }

                userData.PedidoID = detallesPedidoWeb.Count > 0 ? detallesPedidoWeb[0].PedidoID : 0;

                SetUserData(userData);

                sessionManager.SetDetallesPedido(detallesPedidoWeb);
            }
            catch (Exception ex)
            {
                detallesPedidoWeb = detallesPedidoWeb ?? new List<BEPedidoWebDetalle>();
                sessionManager.SetDetallesPedido(detallesPedidoWeb);

                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return detallesPedidoWeb;
        }

        protected List<BEPedidoWebDetalle> PedidoConObservaciones(List<BEPedidoWebDetalle> Pedido, List<ObservacionModel> Observaciones)
        {
            List<BEPedidoWebDetalle> PedObs = Pedido;

            if (userData.NuevoPROL && userData.ZonaNuevoPROL)
            {
                foreach (var item in PedObs)
                {
                    List<ObservacionModel> temp = Observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp != null && temp.Count != 0)
                    {
                        if (temp[0].Caso == 0)
                        {
                            item.ClaseFila = string.Empty;
                            item.TipoObservacion = 0;
                            item.Mensaje = string.Empty;
                        }
                        else
                        {
                            item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                            item.TipoObservacion = temp[0].Tipo;
                            item.Mensaje = string.Empty;
                        }
                        foreach (var ob in temp)
                        {
                            item.Mensaje += ob.Descripcion + "<br/>";
                        }
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                        item.Mensaje = string.Empty;
                    }
                }
            }
            else
            {
                foreach (var item in PedObs)
                {
                    List<ObservacionModel> temp = Observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp != null && temp.Count != 0)
                    {
                        item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                        item.TipoObservacion = temp[0].Tipo;
                        item.Mensaje = string.Empty;
                        foreach (var ob in temp)
                        {
                            item.Mensaje += ob.Descripcion + "<br/>";
                        }
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                        item.Mensaje = string.Empty;
                    }
                }
            }
            return PedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }

        protected List<ObjMontosProl> ServicioProl_CalculoMontosProl(bool session = true)
        {
            if (Session[Constantes.ConstSession.PROL_CalculoMontosProl] != null)
            {
                if (session)
                {
                    return (List<ObjMontosProl>)Session[Constantes.ConstSession.PROL_CalculoMontosProl];
                }
            }

            List<BEPedidoWebDetalle> listProducto = ObtenerPedidoWebDetalle();
            var rtpa = new List<ObjMontosProl>();
            if (listProducto.Any())
            {
                string ListaCUVS = string.Join("|", listProducto.Select(p => p.CUV).ToArray());
                string ListaCantidades = string.Join("|", listProducto.Select(p => p.Cantidad).ToArray());

                var ambiente = ConfigurationManager.AppSettings["Ambiente"] ?? "";
                var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    sv.Url = ConfigurationManager.AppSettings[keyWeb]; // Se envían los codigos de concurso.
                    rtpa = sv.CalculoMontosProlxIncentivos(userData.CodigoISO, userData.CampaniaID.ToString(), userData.CodigoConsultora, userData.CodigoZona, ListaCUVS, ListaCantidades, userData.CodigosConcursos).ToList();
                }
            }
            else
            {
                rtpa.Add(new ObjMontosProl());
            }

            rtpa = rtpa ?? new List<ObjMontosProl>();
            Session[Constantes.ConstSession.PROL_CalculoMontosProl] = rtpa;
            return rtpa;
        }

        protected void InsIndicadorPedidoAutentico(BEIndicadorPedidoAutentico indPedidoAutentico, string cuv)
        {
            try
            {
                var detallesPedido = sessionManager.GetDetallesPedido();

                if (detallesPedido != null && detallesPedido.Any())
                {
                    var detallePedido = detallesPedido.Where(x => x.CUV == cuv).FirstOrDefault();
                    if (detallePedido != null)
                    {
                        indPedidoAutentico.PedidoID = detallePedido.PedidoID;
                        indPedidoAutentico.PedidoDetalleID = detallePedido.PedidoDetalleID;

                        using (PedidoServiceClient svc = new PedidoServiceClient())
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
            ObjMontosProl oRespuestaProl = null;
            string Puntajes = string.Empty;
            string PuntajesExigidos = string.Empty;

            userData.EjecutaProl = false;

            var lista = ServicioProl_CalculoMontosProl(false);

            if (lista != null)
            {
                if (lista.Count > 0)
                {
                    oRespuestaProl = lista[0];

                    Decimal.TryParse(oRespuestaProl.AhorroCatalogo, out montoAhorroCatalogo);
                    Decimal.TryParse(oRespuestaProl.AhorroRevista, out montoAhorroRevista);
                    Decimal.TryParse(oRespuestaProl.MontoTotalDescuento, out montoDescuento);
                    Decimal.TryParse(oRespuestaProl.MontoEscala, out montoEscala);

                    if (oRespuestaProl != null)
                    {
                        if (oRespuestaProl.ListaConcursoIncentivos != null)
                        {
                            Puntajes = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => c.puntajeconcurso.Split('|')[0]).ToArray());
                            PuntajesExigidos = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => (c.puntajeconcurso.IndexOf('|') > -1 ? c.puntajeconcurso.Split('|')[1] : "0")).ToArray());
                        }
                    }
                }
            }

            BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
            bePedidoWeb.PaisID = userData.PaisID;
            bePedidoWeb.CampaniaID = userData.CampaniaID;
            bePedidoWeb.ConsultoraID = userData.ConsultoraID;
            bePedidoWeb.CodigoConsultora = userData.CodigoConsultora;
            bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
            bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
            bePedidoWeb.DescuentoProl = montoDescuento;
            bePedidoWeb.MontoEscala = montoEscala;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                sv.UpdateMontosPedidoWeb(bePedidoWeb);

                // Insertar/Actualizar los puntos de la consultora.
                //if (lista[0].ListaConcursoIncentivos != null)
                if (!string.IsNullOrEmpty(userData.CodigosConcursos))
                    sv.ActualizarInsertarPuntosConcurso(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID.ToString(), userData.CodigosConcursos, Puntajes, PuntajesExigidos);
            }

            // poner en Session
            sessionManager.SetPedidoWeb(null);
            userData.EjecutaProl = true;
            ObtenerPedidoWeb();
        }

        protected bool ReservadoEnHorarioRestringido(out string mensaje)
        {
            try
            {
                if (userData == null)
                {
                    mensaje = "Se sessión expiró, por favor vuelva a loguearse.";
                    HttpContext.Session["UserData"] = null;
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
                return false;
            }
        }

        protected bool ValidarPedidoReservado(out string mensaje)
        {
            mensaje = string.Empty;
            var ConsultoraID = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID;

            BEConfiguracionCampania oBEConfiguracionCampania = null;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {

                oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (oBEConfiguracionCampania != null && oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                !oBEConfiguracionCampania.ModificaPedidoReservado && !oBEConfiguracionCampania.ValidacionAbierta)
            {
                mensaje = "Ya tienes un pedido reservado para esta campaña.";
                return true;
            }
            return false;
        }

        protected string ValidarMontoMaximo(decimal montoCuv, int Cantidad, out bool resul)
        {
            string mensaje = "";
            resul = false;
            try
            {                
                if (userData.TieneValidacionMontoMaximo)
                {
                    if (userData.MontoMaximo == Convert.ToDecimal(9999999999.00)) /*monto sin limites*/
                        mensaje = "";
                    else
                    {                        
                        var listaProducto = ObtenerPedidoWebDetalle();

                        var totalPedido = listaProducto.Sum(p => p.ImporteTotal);
                        decimal _dTotalPedido = Convert.ToDecimal(totalPedido);
                        decimal descuentoProl = 0;

                        if (_dTotalPedido > userData.MontoMaximo && Cantidad < 0)
                        {
                            resul = true;
                        }
                        
                        if (listaProducto.Count() > 0)
                            descuentoProl = listaProducto[0].DescuentoProl;

                        decimal montoActual = (montoCuv * Cantidad) + (_dTotalPedido - descuentoProl);
                        if (montoActual <= userData.MontoMaximo)
                            mensaje = "";
                        else
                        {
                            string strmen = (userData.EsDiasFacturacion) ? "VALIDADO" : "GUARDADO";
                            mensaje += "Haz superado el límite de tu línea de crédito de " + userData.Simbolo + userData.MontoMaximo.ToString();
                            mensaje += ". Por favor modifica tu pedido para que sea " + strmen + " con éxito.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
            }
            return mensaje;
        }

        #endregion

        #region Menú

        private List<PermisoModel> BuildMenu()
        {
            List<PermisoModel> lista1 = new List<PermisoModel>();

            if (userData.Menu != null)
            {
                ViewBag.ClaseLogoSB = userData.ClaseLogoSB;
                lista1 = userData.Menu;
                return SepararItemsMenu(lista1);
            }

            IList<BEPermiso> lst = new List<BEPermiso>();

            using (SeguridadServiceClient sv = new SeguridadServiceClient())
            {
                lst = sv.GetPermisosByRol(userData.PaisID, userData.RolID).ToList();
            }

            string mostrarPedidosPendientes = ConfigurationManager.AppSettings.Get("MostrarPedidosPendientes");
            string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            bool mostrarClienteOnline = (mostrarPedidosPendientes == "1" && strpaises.Contains(userData.CodigoISO));
            if (!mostrarClienteOnline) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "consultoraonline/index"));
            if (!userData.PedidoFICActivo) lst.Where(m => m.Codigo == Constantes.MenuCodigo.PedidoFIC).ToList().ForEach(m => lst.Remove(m));
            if (userData.IndicadorPermisoFIC == 0) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "pedidofic/index"));
            if (userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "catalogopersonalizado/index"));

            lista1 = Mapper.Map<List<PermisoModel>>(lst);

            List<PermisoModel> lstModel = new List<PermisoModel>();

            foreach (var permiso in lista1)
            {
                permiso.Codigo = Util.Trim(permiso.Codigo).ToLower();
                permiso.Descripcion = Util.Trim(permiso.Descripcion);
                permiso.UrlItem = Util.Trim(permiso.UrlItem);
                permiso.UrlImagen = Util.Trim(permiso.UrlImagen);
                permiso.DescripcionFormateada = Util.RemoveDiacritics(permiso.DescripcionFormateada.ToLower()).Replace(" ", "-");

                if (permiso.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                {
                    permiso.EsSoloImagen = true;
                    string imagenContenedorOfertasDefault = ConfigurationManager.AppSettings.Get("GIF_MENU_DEFAULT_OFERTAS");
                    string imagenContenedorOfertasDefaultBpt = ConfigurationManager.AppSettings.Get("GIF_MENU_DEFAULT_OFERTAS_BPT");

                    bool tieneRevistaDigital = revistaDigital.TieneRDC || revistaDigital.TieneRDR;
                    string urlGifContenedorOfertas = tieneRevistaDigital ? imagenContenedorOfertasDefaultBpt : imagenContenedorOfertasDefault;
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    permiso.UrlImagen = ConfigS3.GetUrlFileS3(carpetaPais, urlGifContenedorOfertas);

                    if (GetEventoFestivoData().ListaGifMenuContenedorOfertas.Any())
                    {
                        permiso.UrlImagen = tieneRevistaDigital
                            ? EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT, permiso.UrlImagen)
                            : EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS, permiso.UrlImagen);
                    }
                }

                if (permiso.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower())
                {
                    if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                        continue;
                }

                // por ahora esta en header, ponerlo para tambien para el Footer
                // Objetivo que el Html este limpio, la logica no deberia estar en la vista
                #region header
                if (permiso.Posicion.ToLower() == "header")
                {
                    if (!permiso.Mostrar)
                        continue;

                    if (permiso.Descripcion.ToUpperInvariant() == "SOCIA EMPRESARIA" && permiso.IdPadre == 0)
                    {
                        if (!(ViewBag.Lider == 1 && ViewBag.PortalLideres))
                        {
                            continue;
                        }
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

                        if (permiso.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                        {
                            if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                                userData.ClaseLogoSB = "negro";
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

                    lstModel.Add(permiso);

                    continue;
                }
                #endregion

                lstModel.Add(permiso);
            }

            // Separar los datos obtenidos y para generar el 
            userData.Menu = lstModel;

            ViewBag.ClaseLogoSB = userData.ClaseLogoSB;

            return SepararItemsMenu(lstModel);
        }

        public List<MenuMobileModel> BuildMenuMobile(UsuarioModel userData)
        {
            if (userData.MenuMobile != null)
            {
                SetConsultoraOnlineViewBag(userData);
                return userData.MenuMobile;
            }

            userData.MenuMobile = new List<MenuMobileModel>();
            userData.ConsultoraOnlineMenuResumen = new ConsultoraOnlineMenuResumenModel();
            if (userData.RolID != Constantes.Rol.Consultora)
            {
                SetConsultoraOnlineViewBag(userData);
                return userData.MenuMobile;
            }

            IList<BEMenuMobile> lst;
            using (var sv = new SeguridadServiceClient())
            {
                lst = sv.GetItemsMenuMobile(userData.PaisID).ToList();
            }

            if (userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida)
                lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "mobile/catalogopersonalizado/index"));
            ValidateConsultoraOnlineMenu(userData, lst);

            var listadoMenu = Mapper.Map<List<MenuMobileModel>>(lst);
            var listadoMenuFinal = new List<MenuMobileModel>();
            foreach (var menu in listadoMenu)
            {
                menu.Codigo = Util.Trim(menu.Codigo).ToLower();

                menu.UrlItem = Util.Trim(menu.UrlItem);
                menu.UrlImagen = Util.Trim(menu.UrlImagen);
                menu.Descripcion = Util.Trim(menu.Descripcion);
                menu.MenuPadreDescripcion = Util.Trim(menu.MenuPadreDescripcion);
                menu.Posicion = Util.Trim(menu.Posicion);

                if (menu.MenuMobileID == 1039)
                {
                    menu.EstiloMenu = "background: url(" + menu.UrlImagen.Replace("~", "") + ") no-repeat; background-position: 7px 16px; background-size: 12px 12px;";
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

                menu.UrlItem = menu.Version == "Completa"
                    ? menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}Mobile/Menu/Ver?url={1}", Util.GetUrlHost(Request), menu.UrlItem)
                    : menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}{1}", Util.GetUrlHost(Request), menu.UrlItem);
                menu.UrlItem = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "javascript:;" : menu.UrlItem;
                menu.UrlItem = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "javascript:;" : menu.UrlItem;

                if (menu.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                {
                    bool tieneRevistaDigital = revistaDigital.TieneRDC || revistaDigital.TieneRDR;

                    string imagenContenedorOfertasDefault = ConfigurationManager.AppSettings.Get("GIF_MENU_DEFAULT_OFERTAS");
                    string imagenContenedorOfertasDefaultBpt = ConfigurationManager.AppSettings.Get("GIF_MENU_DEFAULT_OFERTAS_BPT");

                    string urlGifContenedorOfertas = tieneRevistaDigital ? imagenContenedorOfertasDefaultBpt : imagenContenedorOfertasDefault;
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    menu.UrlImagen = ConfigS3.GetUrlFileS3(carpetaPais, urlGifContenedorOfertas);
                    var eventofestivo = GetEventoFestivoData();
                    if (eventofestivo.ListaGifMenuContenedorOfertas.Any())
                    {
                        if (tieneRevistaDigital)
                        {
                            var eventoFestivoGifBpt = eventofestivo.ListaGifMenuContenedorOfertas.FirstOrDefault(p => p.Nombre == Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT);

                            if (eventoFestivoGifBpt != null)
                            {
                                menu.UrlImagen = eventoFestivoGifBpt.Personalizacion;
                            }
                        }
                        else
                        {
                            var eventoFestivoGif = eventofestivo.ListaGifMenuContenedorOfertas.FirstOrDefault(p => p.Nombre == Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS);

                            if (eventoFestivoGif != null)
                            {
                                menu.UrlImagen = eventoFestivoGif.Personalizacion;
                            }
                        }
                    }
                }

                listadoMenuFinal.Add(menu);
            }

            //Agregamos los menú Padre
            var lstModel = listadoMenuFinal.Where(item => item.MenuPadreID == 0).OrderBy(item => item.OrdenItem).ToList();
            //Agregamos los items para cada menú Padre
            foreach (var item in lstModel)
            {
                var subItems = listadoMenuFinal.Where(p => p.MenuPadreID == item.MenuMobileID).OrderBy(p => p.OrdenItem);
                foreach (var subItem in subItems)
                {
                    subItem.Codigo = Util.Trim(subItem.Codigo).ToLower();
                    if (subItem.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower())
                    {
                        if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                            continue;
                    }

                    item.SubMenu.Add(subItem);
                }
            }

            if (lstModel.Any(m => m.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower()))
            {
                var menuCo = lstModel.Find(m => m.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower());
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

        private List<PermisoModel> SepararItemsMenu(List<PermisoModel> menuOriginal)
        {
            // Crear lista resultante
            var menu = new List<PermisoModel>();

            // Separar los items desde la raiz (0)
            SepararItemsMenu(ref menu, menuOriginal, 0);

            return menu;
        }

        private void SepararItemsMenu(ref List<PermisoModel> menu, List<PermisoModel> menuOriginal, int idPadre)
        {
            // Asignar los hijos
            menu = menuOriginal.Where(x => x.IdPadre == idPadre && (x.Descripcion != "" || x.UrlItem != "" || x.UrlImagen != ""))
                .OrderBy(x => x.Posicion)
                .ToList();

            // Por cada uno buscar si se tienen hijos y agregarlos
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
            if (userData.MenuService == null)
            {
                int Campaniaid = userData.CampaniaID;
                IList<ServiceSAC.BEServicioCampania> lstTemp_1 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lstTemp_2 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lst = new List<ServiceSAC.BEServicioCampania>();

                SACServiceClient sv = null;
                try
                {
                    sv = new SACServiceClient();
                }
                catch (Exception) { }

                if (sv != null)
                {
                    lstTemp_1 = sv.GetServicioByCampaniaPais(userData.PaisID, userData.CampaniaID).ToList();
                }

                /*** EPD 2170 ***/
                int SegmentoID;
                if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                {
                    SegmentoID = 1;
                }
                else
                {
                    if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                    {
                        SegmentoID = userData.SegmentoID;
                    }
                    else
                    {
                        SegmentoID = userData.SegmentoInternoID.HasValue ? userData.SegmentoInternoID.Value : userData.SegmentoID;
                    }
                }
                /*** FIN EPD 2170 ***/

                int SegmentoServicio = userData.EsJoven == 1 ? 99 : SegmentoID;

                lstTemp_2 = lstTemp_1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString())).ToList();
                lst = lstTemp_2.Where(p => p.Segmento == "-1" || p.Segmento == SegmentoServicio.ToString()).ToList();

                Mapper.CreateMap<ServiceSAC.BEServicioCampania, ServicioCampaniaModel>()
                        .ForMember(x => x.ServicioId, t => t.MapFrom(c => c.ServicioId))
                        .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                        .ForMember(x => x.Url, t => t.MapFrom(c => c.Url));

                userData.MenuService = Mapper.Map<IList<ServiceSAC.BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            }
            return userData.MenuService;
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

        private void ValidateConsultoraOnlineMenu(UsuarioModel userData, IList<BEMenuMobile> lst)
        {
            var menuConsultoraOnlinePadre = lst.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID == 0);
            var menuConsultoraOnlineHijo = lst.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID != 0);
            string mostrarPedidosPendientes = ConfigurationManager.AppSettings.Get("MostrarPedidosPendientes");
            string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            bool mostrarClienteOnline = (mostrarPedidosPendientes == "1" && strpaises.Contains(userData.CodigoISO));

            if (!mostrarClienteOnline)
            {
                lst.Remove(menuConsultoraOnlinePadre);
                lst.Remove(menuConsultoraOnlineHijo);
                userData.ConsultoraOnlineMenuResumen.TipoMenuConsultoraOnline = 0;
            }
            else if (menuConsultoraOnlinePadre != null || menuConsultoraOnlineHijo != null)
            {
                int esConsultoraOnline = -1;
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
                        lst.Remove(menuConsultoraOnlinePadre);
                    }
                }

                if (menuConsultoraOnlineHijo != null)
                {
                    string[] arrayUrlConsultoraOnlineHijo = menuConsultoraOnlineHijo.UrlItem.Split(new string[] { "||" }, StringSplitOptions.None);
                    menuConsultoraOnlineHijo.UrlItem = arrayUrlConsultoraOnlineHijo[esConsultoraOnline == -1 ? 0 : arrayUrlConsultoraOnlineHijo.Length - 1];
                }
            }
        }

        #endregion

        #region eventoFestivo        

        public string EventoFestivoPersonalizacionSegunNombre(string nombre, string valorBase = "")
        {
            var eventoFestivo = new EventoFestivoModel();
            try
            {
                eventoFestivo = GetEventoFestivoData().ListaGifMenuContenedorOfertas.FirstOrDefault(p => p.Nombre == nombre) ?? new EventoFestivoModel();
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            var valor = Util.Trim(eventoFestivo.Personalizacion);
            valor = valor == "" ? Util.Trim(valorBase) : valor;
            return valor;
        }
        #endregion

        #region UserData        
        protected void SetUserData(UsuarioModel model)
        {
            Session["UserData"] = model;
        }

        public UsuarioModel UserData()
        {
            UsuarioModel model = null;

            try
            {
                model = (UsuarioModel)Session["UserData"];
            }
            catch (Exception)
            {
                model = null;
            }

            if (model == null)
                return new UsuarioModel();

            string UrlEMTELCO = "";
            try
            {
                UrlEMTELCO = ConfigurationManager.AppSettings["UrlBelcorpChat"];
            }
            catch (Exception)
            {
                UrlEMTELCO = "";
            }

            #region Cargar variables

            if (!model.CargoEntidadesShowRoom) CargarEntidadesShowRoom(model);
            
            model.UsuarioNombre = string.IsNullOrEmpty(model.Sobrenombre) ? model.NombreConsultora : model.Sobrenombre;
            ViewBag.UsuarioNombre = (Util.Trim(model.Sobrenombre) == "" ? model.NombreConsultora : model.Sobrenombre);
            ViewBag.Usuario = "Hola, " + model.UsuarioNombre;
            ViewBag.Rol = model.RolID;
            ViewBag.Campania = NombreCampania(model.NombreCorto);
            ViewBag.CampaniaCodigo = model.CampaniaID;
            ViewBag.BanderaImagen = model.BanderaImagen;
            ViewBag.NombrePais = model.NombrePais;
            ViewBag.CambioClave = model.CambioClave;
            ViewBag.UrlAyuda = string.IsNullOrEmpty(model.UrlAyuda) ? string.Empty : model.UrlAyuda;
            ViewBag.UrlCapedevi = string.IsNullOrEmpty(model.UrlCapedevi) ? string.Empty : model.UrlCapedevi;
            ViewBag.UrlTerminos = string.IsNullOrEmpty(model.UrlTerminos) ? string.Empty : Url + model.UrlTerminos;
            ViewBag.CodigoZonaConsultora = model.CodigoZona;
            ViewBag.RolAnalytics = model.RolDescripcion;
            ViewBag.EdadAnalytics = Util.Edad(model.FechaNacimiento);
            ViewBag.ZonaAnalytics = model.CodigoZona;
            ViewBag.PaisAnalytics = model.CodigoISO;
            ViewBag.CodigoISODL = model.CodigoISO;
            ViewBag.MensajeAniversario = string.Empty;
            ViewBag.MensajeCumpleanos = string.Empty;
            ViewBag.IndicadorPermisoFIC = model.IndicadorPermisoFIC;
            ViewBag.IndicadorPermisoFlexipago = model.IndicadorPermisoFlexipago;
            ViewBag.HorasDuracionRestriccion = model.HorasDuracionRestriccion;
            ViewBag.UrlBelcorpChat = String.Format(UrlEMTELCO, model.SegmentoAbreviatura.Trim(), model.CodigoUsuario.Trim(), model.PrimerNombre.Split(' ').First().Trim(), model.EMail == null ? string.Empty : model.EMail.Trim(), model.CodigoISO.Trim());

            ViewBag.RegionAnalytics = model.CodigorRegion;
            ViewBag.SegmentoAnalytics = model.Segmento != null && model.Segmento != "" ?
                (string.IsNullOrEmpty(model.Segmento) ? string.Empty : model.Segmento.ToString().Trim()) : "(not available)";
            ViewBag.esConsultoraLiderAnalytics = model.esConsultoraLider == true ? "Socia" : model.RolDescripcion;
            ViewBag.SeccionAnalytics = model.SeccionAnalytics != null && model.SeccionAnalytics != "" ? model.SeccionAnalytics : "(not available)";
            ViewBag.CodigoConsultoraDL = model.CodigoConsultora != null && model.CodigoConsultora != "" ? model.CodigoConsultora : "(not available)";
            ViewBag.SegmentoConstancia = model.SegmentoConstancia != null && model.SegmentoConstancia != "" ? model.SegmentoConstancia.Trim() : "(not available)";
            ViewBag.DescripcionNivelAnalytics = model.DescripcionNivel != null && model.DescripcionNivel != "" ? model.DescripcionNivel : "(not available)";
            ViewBag.ConsultoraAsociada = model.ConsultoraAsociada;

            if (model.RolID == Constantes.Rol.Consultora)
            {
                if (model.ConsultoraNueva != Constantes.ConsultoraNueva.Sicc && model.ConsultoraNueva != Constantes.ConsultoraNueva.Fox)
                {
                    if (model.NombreCorto != null && model.AnoCampaniaIngreso.Trim() != "")
                    {
                        int campaniaActual = int.Parse(model.NombreCorto);
                        int campaniaIngreso = int.Parse(model.AnoCampaniaIngreso);
                        int diferencia = campaniaActual - campaniaIngreso;
                        if (diferencia >= 12)
                        {
                            if (model.AnoCampaniaIngreso.Trim().EndsWith(model.NombreCorto.Trim().Substring(4)))
                            {
                                ViewBag.MensajeAniversario = string.Format("!Feliz Aniversario {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                            }
                        }
                    }
                }

                if (model.FechaNacimiento.Date != DateTime.Now.Date)
                {
                    if (model.FechaNacimiento.Month == DateTime.Now.Month && model.FechaNacimiento.Day == DateTime.Now.Day)
                    {
                        ViewBag.MensajeCumpleanos = string.Format("!Feliz Cumpleaños {0}!", (string.IsNullOrEmpty(model.Sobrenombre) ? model.PrimerNombre + " " + model.PrimerApellido : model.Sobrenombre));
                    }
                }
            }

            DateTime fechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
            model.EsDiasFacturacion = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date;

            ViewBag.FechaActualPais = fechaHoy.ToShortDateString();
            ViewBag.Dias = GetDiasFaltantesFacturacion(model.FechaInicioCampania, model.ZonaHoraria);
            //ViewBag.Dias = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? 0 : (model.FechaInicioCampania.Subtract(DateTime.Now.AddHours(model.ZonaHoraria)).Days + 1);

            ViewBag.PeriodoAnalytics = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date ? "Facturacion" : "Venta";
            ViewBag.SemanaAnalytics = "No Disponible";
            DateTime FechaHoraActual = DateTime.Now.AddHours(model.ZonaHoraria);
            TimeSpan HoraCierrePortal = model.EsZonaDemAnti == 0 ? model.HoraCierreZonaNormal : model.HoraCierreZonaDemAnti;

            //Mensaje Cierre Campania y Fecha Promesa
            #region mensaje fecha promesa
            var TextoPromesaEspecial = false;
            var TextoPromesa = ".";
            var TextoNuevoPROL = "";

            if (model.ZonaValida)
            {
                if (!model.DiaPROL)
                {
                    if (model.NuevoPROL && model.ZonaNuevoPROL)
                    {
                        ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                        if (!("BO CL VE").Contains(model.CodigoISO))
                            TextoNuevoPROL = " Revisa tus notificaciones o correo y verifica que tu pedido esté completo.";
                    }
                    else
                    {
                        if (model.CodigoISO == "VE")
                        {
                            ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                        }
                        else
                        {
                            ViewBag.MensajeCierreCampania = "El <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> desde las <b>" + FormatearHora(model.HoraFacturacion) + "</b> hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b> podrás validar los productos que te llegarán en el pedido";
                        }
                    }
                }
                else
                {
                    if (model.DiasCampania != 0 && FechaHoraActual < model.FechaInicioCampania)
                    {
                        ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                    }
                    else
                    {
                        if (model.NuevoPROL && model.ZonaNuevoPROL)
                        {
                            ViewBag.MensajeCierreCampania = "Pasa o modifica tu pedido hasta el día de <b>hoy a las " + FormatearHora(HoraCierrePortal) + "</b>";
                        }
                        else
                        {
                            if (model.CodigoISO == "VE")
                            {
                                ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                            }
                            else
                            {
                                ViewBag.MensajeCierreCampania = "Recuerda que tienes hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b> para validar lo que vas a recibir en el pedido";
                                TextoPromesaEspecial = true;
                            }
                        }
                    }
                }
            }
            else ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + model.FechaInicioCampania.Day + " de " + NombreMes(model.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";

            if (model.TipoCasoPromesa != "0")
            {
                if (model.TipoCasoPromesa == "1" && model.DiasCasoPromesa != -1)
                {
                    TextoPromesa = " y recíbelo en ";
                    TextoPromesa += model.DiasCasoPromesa.ToString() + (model.DiasCasoPromesa == 1 ? " día." : " días.");

                }
                else if (("2 3 4").Contains(model.TipoCasoPromesa) && model.DiasCasoPromesa != -1) //casos 2,3 y 4
                {
                    model.FechaPromesaEntrega = FechaHoraActual.AddDays(model.DiasCasoPromesa);
                    if (TextoPromesaEspecial)
                        TextoPromesa = " Recibirás tu pedido el <b>" + model.FechaPromesaEntrega.Day + " de " + NombreMes(model.FechaPromesaEntrega.Month) + "</b>.";

                    else
                        TextoPromesa = " y recíbelo el <b>" + model.FechaPromesaEntrega.Day + " de " + NombreMes(model.FechaPromesaEntrega.Month) + "</b>.";
                }
            }

            #endregion

            ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa + TextoNuevoPROL;
            ViewBag.FechaFacturacionPedido = model.FechaFacturacion.Day + " de " + NombreMes(model.FechaFacturacion.Month);
            ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", model.NombreConsultora.ToUpper(), model.CodigoISO, model.CodigoConsultora, model.EMail, (model.Telefono ?? "").Trim() + ((model.Celular ?? "").Trim() == string.Empty ? "" : "; " + (model.Celular ?? "").Trim()));
            string ss = ViewBag.QSBR;
            ViewBag.QSBR = ss.Replace("\n", "").Trim();

            model.MenuNotificaciones = 1;
            ViewBag.TieneFechaPromesa = 0;
            ViewBag.MensajeFechaPromesa = string.Empty;
            ViewBag.DiaFechaPromesa = 0;

            ViewBag.TieneNotificaciones = model.TieneNotificaciones;
            ViewBag.EsUsuarioComunidad = model.EsUsuarioComunidad ? 1 : 0;
            ViewBag.NombreC = model.PrimerNombre;
            ViewBag.ApellidoC = model.PrimerApellido;
            ViewBag.CorreoC = model.EMail;
            ViewBag.Lider = model.Lider;
            ViewBag.PortalLideres = model.PortalLideres;
            ViewBag.LogOutComunidad = ConfigurationManager.AppSettings["URL_COM_LO"] + "&dest_url=" + ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
            ViewBag.LogOutSB = ConfigurationManager.AppSettings["URL_SB"] + "/WebPages/ComunidadLogout.aspx";
            ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + model.CodigoISO];
            ViewBag.IdbelcorpChat = "belcorpChat" + model.CodigoISO;
            ViewBag.FormatDecimalPais = GetFormatDecimalPais(model.CodigoISO);
            ViewBag.OfertaFinal = model.OfertaFinal;
            ViewBag.CatalogoPersonalizado = model.CatalogoPersonalizado;
            ViewBag.Simbolo = model.Simbolo;
            string paisesConTrackingJetlore = ConfigurationManager.AppSettings.Get("PaisesConTrackingJetlore") ?? "";
            ViewBag.PaisesConTrackingJetlore = paisesConTrackingJetlore.Contains(model.CodigoISO) ? "1" : "0";
            ViewBag.EsCatalogoPersonalizadoZonaValida = model.EsCatalogoPersonalizadoZonaValida;

            #region Banner

            try
            {
                // Postulante
                ViewBag.MostrarBannerPostulante = false;
                if (model.TipoUsuario == 2 && model.CerrarBannerPostulante == 0)
                {
                    ViewBag.MostrarBannerPostulante = true;
                }

                //GPR
                ViewBag.IndicadorGPRSB = model.IndicadorGPRSB;      //0=OK,1=Facturando,2=Rechazado
                ViewBag.CerrarRechazado = model.CerrarRechazado;
                ViewBag.MostrarBannerRechazo = model.MostrarBannerRechazo;

                ViewBag.GPRBannerTitulo = model.GPRBannerTitulo ?? "";
                ViewBag.GPRBannerMensaje = model.GPRBannerMensaje ?? "";
                ViewBag.GPRBannerUrl = model.GPRBannerUrl;

                // ODD
                //ViewBag.MostrarODD = NoMostrarBannerODD();
                //ViewBag.TieneOfertaDelDia = false;
                //if (!ViewBag.MostrarODD)
                //{
                //    ViewBag.TieneOfertaDelDia = model.TieneOfertaDelDia
                //        && (
                //            !(
                //                (!model.ValidacionAbierta && model.EstadoPedido == 202 && model.IndicadorGPRSB == 2)
                //                || model.IndicadorGPRSB == 0)
                //            || model.CloseOfertaDelDia
                //        )
                //        ? false
                //        : model.TieneOfertaDelDia;
                //}
                ViewBag.TieneOfertaDelDia = CumpleOfertaDelDia(model);
                ViewBag.MostrarOfertaDelDiaContenedor = model.TieneOfertaDelDia;

                var configuracionPaisOdd = ListConfiguracionPais().FirstOrDefault(p => p.Codigo == Constantes.ConfiguracionPais.OfertaDelDia);
                configuracionPaisOdd = configuracionPaisOdd ?? new ConfiguracionPaisModel();
                ViewBag.CodigoAnclaOdd = configuracionPaisOdd.Codigo;

                // ShowRoom (Mobile)

            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
            }
            #endregion Banner

            ViewBag.Efecto_TutorialSalvavidas = ConfigurationManager.AppSettings.Get("Efecto_TutorialSalvavidas") ?? "1";
            ViewBag.ModificarPedidoProl = model.NuevoPROL && model.ZonaNuevoPROL ? 0 : 1;
            ViewBag.TipoUsuario = model.TipoUsuario;
            ViewBag.MensajePedidoDesktop = userData.MensajePedidoDesktop;
            ViewBag.MensajePedidoMobile = userData.MensajePedidoMobile;

            #region RegaloPN
            try
            {
                ViewBag.ConsultoraTieneRegaloPN = false;
                if (model.ConsultoraRegaloProgramaNuevas != null)
                {
                    ViewBag.ConsultoraTieneRegaloPN = true;
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
            }
            #endregion

            #region EventoFestivo
            ViewBag.SaludoFestivo = GetEventoFestivoData().EfSaludo;
            #endregion

            #endregion

            return model;
        }

        private bool CumpleOfertaDelDia(UsuarioModel model)
        {
            //ViewBag.MostrarODD = NoMostrarBannerODD();
            //ViewBag.TieneOfertaDelDia = false;
            var result = false;
            if (!NoMostrarBannerODD())
            {
                result = model.TieneOfertaDelDia
                    && (
                        !(
                            (!model.ValidacionAbierta && model.EstadoPedido == 202 && model.IndicadorGPRSB == 2)
                            || model.IndicadorGPRSB == 0)
                        || model.CloseOfertaDelDia
                    )
                    ? false
                    : model.TieneOfertaDelDia;
            }

            return result;
        }

        private string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = ConfigurationManager.AppSettings["KeyPaisFormatDecimal"] ?? "";
            if (listaPaises == "" || isoPais == "") return ",|.|2";
            if (listaPaises.Contains(isoPais)) return ".||0";
            return ",|.|2";
        }

        protected List<BEProductoFaltante> GetProductosFaltantes()
        {
            return this.GetProductosFaltantes("", "");
        }

        protected List<BEProductoFaltante> GetProductosFaltantes(string cuv, string descripcion)
        {
            List<BEProductoFaltante> olstProductoFaltante = new List<BEProductoFaltante>();
            using (SACServiceClient sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(userData.PaisID, userData.CampaniaID, userData.ZonaID, cuv, descripcion).ToList();
            }
            return olstProductoFaltante;
        }

        private string NombreCampania(string Campania)
        {
            string Result = Campania;
            try
            {
                if (Campania.Length == 6)
                {
                    return Result = string.Format("Campaña {0}", Campania.Substring(4, 2));
                }
            }
            catch { }
            return Result;
        }

        public string GetIPCliente()
        {
            //string IP = string.Empty;
            //try
            //{
            //    IP = HttpContext.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            //}
            //catch { }
            //return IP;
            string IP = string.Empty;
            try
            {
                string ipAddress = string.Empty;

                if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
                {
                    ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
                }

                else if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"] != null && System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"].Length != 0)
                {
                    ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"];
                }

                else if (System.Web.HttpContext.Current.Request.UserHostAddress.Length != 0)
                {
                    ipAddress = System.Web.HttpContext.Current.Request.UserHostName;
                }

                if (ipAddress.IndexOf(":") > 0)
                {
                    ipAddress = ipAddress.Substring(0, ipAddress.IndexOf(":") - 1);
                }

                return ipAddress;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message.ToString());
            }
            return IP;
        }

        protected void CargarEntidadesShowRoom(UsuarioModel model)
        {
            try
            {
                const int SHOWROOM_ESTADO_ACTIVO = 1;

                sessionManager.SetEsShowRoom("0");
                sessionManager.SetMostrarShowRoomProductos("0");
                sessionManager.SetMostrarShowRoomProductosExpiro("0");

                model.BeShowRoomConsultora = null;
                model.BeShowRoom = null;

                model.CargoEntidadesShowRoom = false;

                if (!PaisTieneShowRoom(model.CodigoISO))
                {
                    SetUserData(model);
                    return;
                }

                var codigoConsultora = model.UsuarioPrueba == 1
                    ? model.ConsultoraAsociada
                    : model.CodigoConsultora;
                List<BEShowRoomPersonalizacionNivel> personalizacionesNivel = null;

                using (var pedidoService = new PedidoServiceClient())
                {
                    model.BeShowRoom = pedidoService.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);
                    model.BeShowRoomConsultora = pedidoService.GetShowRoomConsultora(
                        model.PaisID,
                        model.CampaniaID,
                        codigoConsultora,
                        model.BeShowRoom != null && model.BeShowRoom.TienePersonalizacion);

                    model.ListaShowRoomNivel = pedidoService.GetShowRoomNivel(model.PaisID).ToList();
                    model.ListaShowRoomPersonalizacion = pedidoService.GetShowRoomPersonalizacion(model.PaisID).ToList();
                    model.ShowRoomNivelId = ObtenerNivelId(model.ListaShowRoomNivel);

                    if (model.BeShowRoom != null && model.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO)
                    {
                        personalizacionesNivel = pedidoService.GetShowRoomPersonalizacionNivel(model.PaisID,
                            model.BeShowRoom.EventoID, model.ShowRoomNivelId, 0).ToList();
                    }
                }

                if (model.BeShowRoom != null && model.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO && model.BeShowRoomConsultora != null)
                {
                    sessionManager.SetEsShowRoom("1");

                    var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                    if (userData.FechaInicioCampania != default(DateTime))
                        ViewBag.DiasFaltan = (userData.FechaInicioCampania.AddDays(-model.BeShowRoom.DiasAntes) - fechaHoy).Days;

                    if (fechaHoy >= model.FechaInicioCampania.AddDays(-model.BeShowRoom.DiasAntes).Date
                        && fechaHoy <= model.FechaInicioCampania.AddDays(model.BeShowRoom.DiasDespues).Date)
                    {
                        sessionManager.SetMostrarShowRoomProductos("1");
                    }

                    if (fechaHoy > model.FechaInicioCampania.AddDays(model.BeShowRoom.DiasDespues).Date)
                        sessionManager.SetMostrarShowRoomProductosExpiro("1");
                }

                if (personalizacionesNivel != null && personalizacionesNivel.Any())
                {
                    var personalizacionesModel = Mapper.Map<List<BEShowRoomPersonalizacion>, List<ShowRoomPersonalizacionModel>>(model.ListaShowRoomPersonalizacion);

                    var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;
                    Session["carpetaPais"] = carpetaPais;

                    foreach (var item in personalizacionesModel)
                    {
                        var personalizacionNivel = personalizacionesNivel.FirstOrDefault(
                            p => p.NivelId == model.ShowRoomNivelId &&
                                 p.EventoID == model.BeShowRoom.EventoID &&
                                 p.PersonalizacionId == item.PersonalizacionId);

                        if (personalizacionNivel == null)
                        {
                            item.PersonalizacionNivelId = 0;
                            item.Valor = string.Empty;
                            continue;
                        }

                        item.PersonalizacionNivelId = personalizacionNivel.PersonalizacionNivelId;
                        item.Valor = personalizacionNivel.Valor;

                        if (item.TipoAtributo == "IMAGEN")
                        {
                            item.Valor = string.IsNullOrEmpty(item.Valor)
                                ? string.Empty
                                : ConfigS3.GetUrlFileS3(carpetaPais, item.Valor,
                                    Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                        }
                    }

                    model.ListaShowRoomPersonalizacionConsultora = personalizacionesModel;
                }

                model.CargoEntidadesShowRoom = true;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                model.CargoEntidadesShowRoom = false;
            }

            SetUserData(model);
        }

        protected bool PaisTieneShowRoom(string codigoIsoPais)
        {
            var tieneShowRoom = false;
            if (string.IsNullOrEmpty(codigoIsoPais))
                // ReSharper disable once ConditionIsAlwaysTrueOrFalse
                return tieneShowRoom;
            var paisesShowRoom = ConfigurationManager.AppSettings["PaisesShowRoom"];
            tieneShowRoom = paisesShowRoom.Contains(codigoIsoPais);
            //
            return tieneShowRoom;
        }

        protected int ObtenerNivelId(List<BEShowRoomNivel> niveles)
        {
            const string CODIGO_PERSONALIZACION_NIVEL_PAIS = "PAIS";
            var showRoomNivelPais = niveles.FirstOrDefault(p => p.Codigo == CODIGO_PERSONALIZACION_NIVEL_PAIS) ??
                                    new BEShowRoomNivel();
            return showRoomNivelPais.NivelId;
        }

        #endregion

        #region FichaProducto
        public List<FichaProductoModel> ConsultarFichaProductoPorCuv(string cuv = "", int campanaId = 0)
        {
            var entidad = new BEFichaProducto
            {
                PaisID = userData.PaisID,
                CampaniaID = campanaId > 0 ? campanaId : userData.CampaniaID,
                ConsultoraID = (userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID).ToString(),
                CUV2 = Util.Trim(cuv),
                Zona = userData.ZonaID.ToString(),
                ZonaHoraria = userData.ZonaHoraria,
                FechaInicioFacturacion = userData.FechaFinCampania,
                ValidarPeriodoFacturacion = true,
                Simbolo = userData.Simbolo,
                CodigoAgrupacion = Util.Trim("")
            };
            var listFichaProducto = new List<BEFichaProducto>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listFichaProducto = sv.GetFichaProducto(entidad).ToList();
            }
            listFichaProducto = listFichaProducto ?? new List<BEFichaProducto>();
            listFichaProducto = listFichaProducto.Where(e => e.Precio2 > 0).ToList();

            listFichaProducto.Where(e => (e.Precio <= e.Precio2) && e.FlagNueva != 1).ToList().ForEach(e =>
            {
                e.Precio = 0;
                e.PrecioTachado = Util.DecimalToStringFormat(e.Precio, userData.CodigoISO);
            });
            var listaProductoModel = FichaProductoModelFormato(listFichaProducto);
            return listaProductoModel;
        }

        public List<FichaProductoDetalleModel> FichaProductoFormatearModelo(List<FichaProductoModel> listaProductoModel)
        {
            var listaRetorno = new List<FichaProductoDetalleModel>();
            if (!listaProductoModel.Any())
                return listaRetorno;

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            listaProductoModel.ForEach(fichaProducto =>
            {
                var prodModel = new FichaProductoDetalleModel();
                prodModel.CampaniaID = fichaProducto.CampaniaID;
                prodModel.EstrategiaID = fichaProducto.EstrategiaID;
                prodModel.CUV2 = fichaProducto.CUV2;
                prodModel.TipoEstrategiaImagenMostrar = fichaProducto.TipoEstrategiaImagenMostrar;
                prodModel.CodigoEstrategia = fichaProducto.TipoEstrategia.Codigo;
                prodModel.CodigoVariante = fichaProducto.CodigoEstrategia;
                prodModel.FotoProducto01 = fichaProducto.FotoProducto01;
                prodModel.ImagenURL = fichaProducto.ImagenURL;
                prodModel.DescripcionMarca = fichaProducto.DescripcionMarca;
                prodModel.DescripcionResumen = fichaProducto.DescripcionResumen;
                prodModel.DescripcionCortada = fichaProducto.DescripcionCortada;
                prodModel.DescripcionDetalle = fichaProducto.DescripcionDetalle;
                prodModel.DescripcionCompleta = fichaProducto.DescripcionCUV2.Split('|')[0];
                prodModel.Simbolo = userData.Simbolo;
                prodModel.Precio = fichaProducto.Precio;
                prodModel.Precio2 = fichaProducto.Precio2;
                prodModel.PrecioTachado = fichaProducto.PrecioTachado;
                prodModel.PrecioVenta = fichaProducto.PrecioString;
                //prodModel.ClaseBloqueada = (fichaProducto.CampaniaID > 0 && fichaProducto.CampaniaID != userData.CampaniaID) ? "btn_desactivado_general" : "";
                prodModel.ProductoPerdio = false;
                prodModel.TipoEstrategiaID = fichaProducto.TipoEstrategiaID;
                prodModel.FlagNueva = fichaProducto.FlagNueva;
                prodModel.IsAgregado = listaPedido.Any(p => p.CUV == fichaProducto.CUV2.Trim());
                prodModel.ArrayContenidoSet = fichaProducto.FlagNueva == 1 ? fichaProducto.DescripcionCUV2.Split('|').Skip(1).ToList() : new List<string>();
                prodModel.ListaDescripcionDetalle = fichaProducto.ListaDescripcionDetalle ?? new List<string>();
                prodModel.TextoLibre = Util.Trim(fichaProducto.TextoLibre);

                prodModel.MarcaID = fichaProducto.MarcaID;
                prodModel.UrlCompartir = fichaProducto.UrlCompartir;

                prodModel.TienePaginaProducto = fichaProducto.PuedeVerDetalle;
                prodModel.TienePaginaProductoMob = fichaProducto.PuedeVerDetalleMob;
                prodModel.TieneVerDetalle = true;

                prodModel.TipoAccionAgregar = fichaProducto.TieneVariedad == 0 ? fichaProducto.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas ? 1 : 2 : 3;
                prodModel.LimiteVenta = fichaProducto.LimiteVenta;
                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        public List<FichaProductoModel> FichaProductoModelFormato(List<BEFichaProducto> listaProducto)
        {
            listaProducto = listaProducto ?? new List<BEFichaProducto>();
            List<FichaProductoModel> listaProductoModel = Mapper.Map<List<BEFichaProducto>, List<FichaProductoModel>>(listaProducto);
            return FichaProductoModelFormato(listaProductoModel);
        }

        public List<FichaProductoModel> FichaProductoModelFormato(List<FichaProductoModel> listaProductoModel)
        {
            if (!listaProductoModel.Any())
                return listaProductoModel;

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            listaProductoModel.ForEach(ficha =>
            {
                ficha.ClaseBloqueada = ficha.CampaniaID > 0 && ficha.CampaniaID != userData.CampaniaID ? "btn_desactivado_general" : "";
                ficha.IsAgregado = listaPedido.Any(p => p.CUV == ficha.CUV2.Trim());
                ficha.DescripcionResumen = "";
                ficha.DescripcionDetalle = "";
                if (ficha.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    var listadescr = ficha.DescripcionCUV2.Split('|');
                    ficha.DescripcionResumen = listadescr.Length > 0 ? listadescr[0] : "";
                    ficha.DescripcionCortada = listadescr.Length > 1 ? listadescr[1] : "";
                    if (listadescr.Length > 2)
                    {
                        ficha.ListaDescripcionDetalle = new List<string>(listadescr.Skip(2));
                        ficha.DescripcionDetalle = string.Join("<br />", listadescr.Skip(2));
                    }
                    ficha.DescripcionCortada = Util.SubStrCortarNombre(ficha.DescripcionCortada, 40);
                }
                else if (ficha.FlagNueva == 1)
                {
                    ficha.DescripcionCortada = ficha.DescripcionCUV2.Split('|')[0];
                    ficha.DescripcionDetalle = ficha.DescripcionCUV2.Split('|')[1];
                    ficha.DescripcionResumen = "";
                }
                else
                {
                    ficha.DescripcionCortada = Util.SubStrCortarNombre(ficha.DescripcionCUV2, 40);
                };

                if (ficha.FlagMostrarImg == 1)
                {
                    ficha.ImagenURL = "/Content/Images/oferta-ultimo-minuto.png";
                }
                else
                {
                    ficha.ImagenURL = "";
                }

                ficha.ID = ficha.EstrategiaID;
                if (ficha.FlagMostrarImg == 1)
                {
                    if (ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        if (ficha.FlagEstrella == 1)
                        {
                            ficha.ImagenURL = "/Content/Images/oferta-ultimo-minuto.png";
                        }
                    }
                    else if (!(ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas
                        || ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.Lanzamiento))
                    {
                        ficha.ImagenURL = "";
                    }
                }
                else
                {
                    ficha.ImagenURL = "";
                }

                ficha.PuedeCambiarCantidad = 1;
                if (ficha.TieneVariedad == 0)
                {
                    if (ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas)
                    {
                        ficha.PuedeCambiarCantidad = 0;
                    }
                }
                ficha.PuedeAgregar = 1;
                ficha.PuedeVerDetalle = false;
                ficha.PuedeVerDetalleMob = false;
            });

            return listaProductoModel;
        }

        public FichaProductoDetalleModel FichaProductoHermanos(FichaProductoDetalleModel fichaProductoModelo)
        {
            try
            {
                if (fichaProductoModelo == null)
                    return fichaProductoModelo;
                fichaProductoModelo.Hermanos = new List<ProductoModel>();
                fichaProductoModelo.TextoLibre = Util.Trim(fichaProductoModelo.TextoLibre);
                fichaProductoModelo.CodigoVariante = Util.Trim(fichaProductoModelo.CodigoVariante);
                fichaProductoModelo.UrlCompartir = GetUrlCompartirFB();

                var listaPedido = ObtenerPedidoWebDetalle();
                fichaProductoModelo.IsAgregado = listaPedido.Any(p => p.CUV == fichaProductoModelo.CUV2);

                if (fichaProductoModelo.CodigoVariante == "")
                    return fichaProductoModelo;

                string joinCuv = "|", separador = "|";

                fichaProductoModelo.CampaniaID = fichaProductoModelo.CampaniaID > 0 ? fichaProductoModelo.CampaniaID : userData.CampaniaID;

                var listaHermanosE = new List<BEProducto>();
                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    using (ODSServiceClient svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, fichaProductoModelo.CampaniaID, fichaProductoModelo.CUV2).ToList();
                    }

                    foreach (var item in listaHermanosE)
                    {
                        item.CodigoSAP = Util.Trim(item.CodigoSAP);
                        if (item.CodigoSAP != "" && !joinCuv.Contains(separador + item.CodigoSAP + separador))
                            joinCuv += item.CodigoSAP + separador;
                    }
                }

                var listaProducto = new List<BEEstrategiaProducto>();
                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    var estrategiaX = new EstrategiaPedidoModel() { PaisID = userData.PaisID, EstrategiaID = fichaProductoModelo.EstrategiaID };
                    using (PedidoServiceClient svc = new PedidoServiceClient())
                    {
                        listaProducto = svc.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, BEEstrategia>(estrategiaX)).ToList();
                    }

                    foreach (var item in listaProducto)
                    {
                        item.SAP = Util.Trim(item.SAP);
                        if (item.SAP != "" && !joinCuv.Contains(separador + item.SAP + separador))
                            joinCuv += item.SAP + separador;
                    }
                }

                if (joinCuv == separador) return fichaProductoModelo;

                joinCuv = joinCuv.Substring(separador.Length, joinCuv.Length - separador.Length * 2);

                var listaAppCatalogo = new List<Producto>();
                using (ProductoServiceClient svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosByCodigoSap(userData.CodigoISO, fichaProductoModelo.CampaniaID, joinCuv).ToList();
                }

                if (!listaAppCatalogo.Any()) return fichaProductoModelo;

                var listaHermanos = Mapper.Map<List<Producto>, List<ProductoModel>>(listaAppCatalogo);

                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    if (listaHermanos.Count <= 1)
                    {
                        listaHermanos = new List<ProductoModel>();
                    }
                    else
                    {
                        listaHermanos.ForEach(h =>
                        {
                            h.CUV = Util.Trim(h.CUV);
                            h.FactorCuadre = 1;
                        });
                        listaHermanos = listaHermanos.OrderBy(h => h.Orden).ToList();
                    }
                }
                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    var listaHermanosX = new List<ProductoModel>();
                    listaProducto = listaProducto.OrderBy(p => p.Grupo).ToList();
                    listaHermanos = listaHermanos.OrderBy(p => p.CodigoProducto).ToList();

                    var idPk = 1;
                    listaHermanos.ForEach(h => h.ID = idPk++);

                    idPk = 0;
                    foreach (var item in listaProducto)
                    {
                        var prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto) ?? new ProductoModel()).Clone();
                        if (Util.Trim(prod.CodigoProducto) == "")
                            continue;

                        var listaIgual = listaHermanos.Where(p => item.SAP == p.CodigoProducto);
                        if (listaIgual.Count() > 1)
                        {
                            prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.ID > idPk) ?? new ProductoModel()).Clone();
                        }

                        prod.Orden = item.Orden;
                        prod.Grupo = item.Grupo;
                        prod.PrecioCatalogo = item.Precio;
                        prod.PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO);
                        prod.Digitable = item.Digitable;
                        prod.CUV = Util.Trim(item.CUV);
                        prod.Cantidad = item.Cantidad;
                        prod.FactorCuadre = item.FactorCuadre > 0 ? item.FactorCuadre : 1;
                        listaHermanosX.Add(prod);
                        idPk = prod.ID;
                    }

                    listaHermanos = listaHermanosX;

                    if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija)
                    {
                        listaHermanos.ForEach(h => { h.Digitable = 0; h.NombreComercial = Util.Trim(h.NombreComercial); });
                        listaHermanos = listaHermanos.Where(h => h.NombreComercial != "").ToList();
                    }
                    else if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                    {
                        var listaHermanosR = new List<ProductoModel>();
                        var hermano = new ProductoModel();
                        foreach (var item in listaHermanos)
                        {
                            hermano = (ProductoModel)item.Clone();
                            hermano.Hermanos = new List<ProductoModel>();
                            if (hermano.Digitable == 1)
                            {
                                var existe = false;
                                foreach (var itemR in listaHermanosR)
                                {
                                    existe = itemR.Hermanos.Any(h => h.CUV == hermano.CUV);
                                    if (existe) break;
                                }
                                if (existe) continue;

                                hermano.Hermanos = listaHermanos.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                            }
                            listaHermanosR.Add(hermano);
                        }
                        listaHermanos = listaHermanosR.OrderBy(p => p.Orden).ToList();
                    }
                }
                #region Factor Cuadre

                var listaHermanosCuadre = new List<ProductoModel>();

                foreach (var hermano in listaHermanos)
                {
                    listaHermanosCuadre.Add((ProductoModel)hermano.Clone());

                    if (hermano.FactorCuadre > 1)
                    {
                        for (int i = 0; i < hermano.FactorCuadre - 1; i++)
                        {
                            listaHermanosCuadre.Add((ProductoModel)hermano.Clone());
                        }
                    }
                }

                #endregion

                fichaProductoModelo.Hermanos = listaHermanosCuadre ?? new List<ProductoModel>();
            }
            catch (Exception ex)
            {
                fichaProductoModelo = new FichaProductoDetalleModel();
                fichaProductoModelo.Hermanos = new List<ProductoModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return fichaProductoModelo;
        }
        #endregion



        public string NombreMes(int mes)
        {
            var result = string.Empty;
            switch (mes)
            {
                case 1:
                    result = "Enero";
                    break;
                case 2:
                    result = "Febrero";
                    break;
                case 3:
                    result = "Marzo";
                    break;
                case 4:
                    result = "Abril";
                    break;
                case 5:
                    result = "Mayo";
                    break;
                case 6:
                    result = "Junio";
                    break;
                case 7:
                    result = "Julio";
                    break;
                case 8:
                    result = "Agosto";
                    break;
                case 9:
                    result = "Septiembre";
                    break;
                case 10:
                    result = "Octubre";
                    break;
                case 11:
                    result = "Noviembre";
                    break;
                case 12:
                    result = "Diciembre";
                    break;
            }
            return result;
        }

        protected string ConfigurarUrlServiceProl()
        {
            string ambiente = ConfigurationManager.AppSettings["Ambiente"];
            string pais = UserData().CodigoISO;
            string key = ambiente.Trim().ToUpper() + "_Prol_" + pais.Trim().ToUpper();
            return ConfigurationManager.AppSettings[key];
        }

        protected BEGrid SetGrid(string sidx, string sord, int page, int rows)
        {
            BEGrid grid = new BEGrid();
            grid.PageSize = rows <= 0 ? 10 : rows;
            grid.CurrentPage = page <= 0 ? 1 : page;
            grid.SortColumn = sidx ?? "";
            grid.SortOrder = sord ?? "asc";
            return grid;
        }

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
                BEConfiguracionProgramaNuevas oBEConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas();
                oBEConfiguracionProgramaNuevas.CampaniaInicio = userData.CampaniaID.ToString();
                oBEConfiguracionProgramaNuevas.CodigoRegion = userData.CodigorRegion;
                oBEConfiguracionProgramaNuevas.CodigoZona = userData.CodigoZona;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionProgramaNuevas = sv.GetConfiguracionProgramaNuevas(userData.PaisID, oBEConfiguracionProgramaNuevas);
                }

                Session[constSession] = oBEConfiguracionProgramaNuevas ?? new BEConfiguracionProgramaNuevas();
            }
            catch (Exception)
            {
                Session[constSession] = new BEConfiguracionProgramaNuevas();
            }

            return (BEConfiguracionProgramaNuevas)Session[constSession];
        }

        protected Converter<decimal, string> CreateConverterDecimalToString(int paisID)
        {
            if (paisID == 4) return new Converter<decimal, string>(p => p.ToString("n0", new System.Globalization.CultureInfo("es-CO")));
            return new Converter<decimal, string>(p => p.ToString("n2", new System.Globalization.CultureInfo("es-PE")));
        }

        protected int AddCampaniaAndNumero(int campania, int numero)
        {
            return AddCampaniaAndNumero(campania, numero, userData.NroCampanias);
        }

        protected int AddCampaniaAndNumero(int campania, int numero, int nroCampanias)
        {
            if (campania <= 0 || nroCampanias <= 0) return 0;

            int anioCampania = campania / 100;
            int nroCampania = campania % 100;

            int sumNroCampania = (nroCampania + numero) - 1;
            int anioCampaniaResult = anioCampania + (sumNroCampania / nroCampanias);
            int nroCampaniaResult = (sumNroCampania % nroCampanias) + 1;

            if (nroCampaniaResult < 1)
            {
                anioCampaniaResult = anioCampaniaResult - 1;
                nroCampaniaResult = nroCampaniaResult + nroCampanias;
            }
            return (anioCampaniaResult * 100) + nroCampaniaResult;
        }

        public string FormatearHora(TimeSpan hora)
        {
            DateTime tiempo = DateTime.Today.Add(hora);
            string displayTiempo = tiempo.ToShortTimeString().Replace(".", " ").Replace(" ", "");
            if (displayTiempo.Length == 6)
                displayTiempo = displayTiempo.Insert(4, " ");
            else
                displayTiempo = displayTiempo.Insert(5, " ");

            return displayTiempo;
        }

        public BarraConsultoraModel GetDataBarra(bool inEscala = true, bool inMensaje = false)
        {
            var objR = new BarraConsultoraModel();
            objR.ListaEscalaDescuento = new List<BarraConsultoraEscalaDescuentoModel>();
            objR.ListaMensajeMeta = new List<BEMensajeMetaConsultora>();

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
                        var oBEConsultorasProgramaNuevas = GetConsultorasProgramaNuevas(Constantes.ConstSession.TippingPoint_MontoVentaExigido, tp.CodigoPrograma);

                        objR.TippingPoint = oBEConsultorasProgramaNuevas.MontoVentaExigido;
                        objR.TippingPointStr = Util.DecimalToStringFormat(objR.TippingPoint, userData.CodigoISO);
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

                var listProducto = ObtenerPedidoWebDetalle();
                objR.TotalPedido = listProducto.Sum(d => d.ImporteTotal);
                objR.TotalPedidoStr = Util.DecimalToStringFormat(objR.TotalPedido, userData.CodigoISO);

                objR.CantidadProductos = listProducto.Sum(p => p.Cantidad);
                objR.CantidadCuv = listProducto.Count();

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
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaEscalaDescuento = sv.GetEscalaDescuento(userData.PaisID).ToList() ?? new List<BEEscalaDescuento>();
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
                var oBEConsultorasProgramaNuevas = new BEConsultorasProgramaNuevas();
                oBEConsultorasProgramaNuevas.CodigoConsultora = userData.CodigoConsultora;
                oBEConsultorasProgramaNuevas.Campania = userData.CampaniaID.ToString();
                oBEConsultorasProgramaNuevas.CodigoPrograma = codigoPrograma;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConsultorasProgramaNuevas = sv.GetConsultorasProgramaNuevas(userData.PaisID, oBEConsultorasProgramaNuevas);
                }

                Session[constSession] = oBEConsultorasProgramaNuevas ?? new BEConsultorasProgramaNuevas();
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
                var lista = new List<BEMensajeMetaConsultora>();
                var entity = new BEMensajeMetaConsultora();
                entity.TipoMensaje = tipoMensaje ?? "";
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lista = sv.GetMensajeMetaConsultora(userData.PaisID, entity).ToList();
                }

                Session[constSession] = lista ?? new List<BEMensajeMetaConsultora>();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[constSession] = new List<BEMensajeMetaConsultora>();
            }

            return (List<BEMensajeMetaConsultora>)Session[constSession];
        }

        public List<EstadoCuentaModel> ObtenerEstadoCuenta()
        {
            List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();

            if (Session["ListadoEstadoCuenta"] == null)
            {
                List<BEEstadoCuenta> EstadoCuenta = new List<BEEstadoCuenta>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        EstadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                if (EstadoCuenta != null && EstadoCuenta.Count > 0)
                {
                    foreach (var ec in EstadoCuenta)
                    {
                        lst.Add(new EstadoCuentaModel
                        {
                            Fecha = ec.FechaRegistro,
                            Glosa = ec.DescripcionOperacion,
                            Cargo = ec.Cargo,
                            Abono = ec.Abono
                        });
                    }

                    decimal monto = userData.MontoDeuda;

                    lst.Add(new EstadoCuentaModel
                    {
                        Fecha = userData.FechaLimPago,
                        Glosa = "MONTO A PAGAR",
                        Cargo = monto > 0 ? monto : 0,
                        Abono = monto < 0 ? 0 : monto
                    });
                }

                Session["ListadoEstadoCuenta"] = lst;
            }
            else
            {
                lst = Session["ListadoEstadoCuenta"] as List<EstadoCuentaModel>;
            }

            return lst;
        }

        public String GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
        {
            string sFecha = Convert.ToDateTime("2000-01-01").ToString();
            DateTime Fecha = Convert.ToDateTime("2000-01-01");
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    sFecha = sv.GetFechaPromesaCronogramaByCampania(PaisId, CampaniaId, CodigoConsultora, FechaFact);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return sFecha;
        }

        public TimeSpan CountdownODD(UsuarioModel model)
        {
            //DateTime hoy = DateTime.Now;
            //DateTime d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);
            DateTime hoy;

            using (SACServiceClient svc = new SACServiceClient())
            {
                hoy = svc.GetFechaHoraPais(model.PaisID);
            }

            DateTime d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);
            DateTime d2;

            if (model.EsDiasFacturacion)  // dias de facturacion
            {
                TimeSpan t1 = model.HoraCierreZonaNormal;
                d2 = new DateTime(hoy.Year, hoy.Month, hoy.Day, t1.Hours, t1.Minutes, t1.Seconds);
            }
            else
            {
                d2 = d1.AddDays(1);
            }

            TimeSpan t2 = (d2 - hoy);
            return t2;
        }

        #endregion

        protected OfertaDelDiaModel GetOfertaDelDiaModel()
        {
            if (userData.OfertasDelDia == null)
                return null;

            if (!userData.OfertasDelDia.Any())
                return null;

            var model = userData.OfertasDelDia.First().Clone();
            //
            model.ListaOfertas = userData.OfertasDelDia;
            //
            short posicion = 0;
            var tiposEstrategia = sessionManager.GetTiposEstrategia();
            if (tiposEstrategia == null)
            {
                tiposEstrategia = GetTipoEstrategias();
                sessionManager.SetTiposEstrategia(tiposEstrategia);
            }
            foreach (var oferta in model.ListaOfertas)
            {
                oferta.Position = posicion++;
                oferta.DescripcionMarca = GetDescripcionMarca(oferta.MarcaID);
                oferta.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == oferta.CUV2) ? "block" : "none";

                if (tiposEstrategia != null && tiposEstrategia.Any(x => x.TipoEstrategiaID == oferta.TipoEstrategiaID))
                    oferta.TipoEstrategiaDescripcion = tiposEstrategia.First(x => x.TipoEstrategiaID == oferta.TipoEstrategiaID).DescripcionEstrategia ?? string.Empty;
            }

            model.TeQuedan = CountdownODD(userData);
            model.FBRuta = GetUrlCompartirFB();
            return model;
        }

        public ShowRoomBannerLateralModel GetShowRoomBannerLateral()
        {
            var model = new ShowRoomBannerLateralModel();

            if (!PaisTieneShowRoom(userData.CodigoISO))
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            if (!userData.CargoEntidadesShowRoom)
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            model.BEShowRoomConsultora = userData.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
            model.BEShowRoom = userData.BeShowRoom ?? new BEShowRoomEvento(); ;

            if (model.BEShowRoom.Estado != 1)
                return new ShowRoomBannerLateralModel { EventoNoEncontrado = true };

            model.EstaActivoLateral = true;
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes).Date &&
                fechaHoy <= userData.FechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date))
            {
                model.MostrarShowRoomProductos = true;
                sessionManager.SetMostrarShowRoomProductos("1");
            }
            if (fechaHoy > userData.FechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date)
                model.EstaActivoLateral = false;

            TimeSpan DiasFalta = userData.FechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes) - fechaHoy;
            model.DiasFalta = DiasFalta.Days;
            model.DiasFaltantes = DiasFalta.Days;

            model.MesFaltante = userData.FechaInicioCampania.Month;
            model.AnioFaltante = userData.FechaInicioCampania.Year;


            foreach (var item in userData.ListaShowRoomPersonalizacionConsultora)
            {
                if (item.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.PopupImagenIntriga &&
                    item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile)
                {
                    model.ImagenPopupShowroomIntriga = item.Valor;
                }

                if (item.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenIntriga &&
                    item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile)
                {
                    model.ImagenBannerShowroomIntriga = item.Valor;
                }

                if (item.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.PopupImagenVenta &&
                    item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile)
                {
                    model.ImagenPopupShowroomVenta = item.Valor;
                }

                if (item.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenVenta &&
                    item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile)
                {
                    model.ImagenBannerShowroomVenta = item.Valor;
                }
            }

            return model;
        }

        #region Catalogos y Revistas Issuu

        protected string GetRevistaCodigoIssuu(string campania)
        {
            string codigo = null;

            string zonas = ConfigurationManager.AppSettings["RevistaPiloto_Zonas_" + userData.CodigoISO + campania] ?? "";
            bool esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
            if (esRevistaPiloto) codigo = ConfigurationManager.AppSettings["RevistaPiloto_Codigo_" + userData.CodigoISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            //if (revistaDigital.TieneRDR)
            //{
            //    zonas = ConfigurationManager.AppSettings["RevistaPiloto_RDRIssuu_Zona_" + userData.CodigoISO + campania] ?? "";
            //    esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
            //    if (esRevistaPiloto) codigo = ConfigurationManager.AppSettings["CodigoRevistaIssuu"];
            //    if (!string.IsNullOrEmpty(codigo)) return codigo;

            //    codigo = ConfigurationManager.AppSettings["CodigoRevistaDigitalIssuu"].ToString();
            //    return string.Format(codigo, campania.Substring(4, 2), campania.Substring(2, 2), userData.CodigoISO.ToLower()); ;
            //}

            codigo = ConfigurationManager.AppSettings["CodigoRevistaIssuu"].ToString();
            return string.Format(codigo, userData.CodigoISO.ToLower(), campania.Substring(4, 2), campania.Substring(0, 4));
        }

        protected string GetCatalogoCodigoIssuu(string campania, int idMarcaCatalogo)
        {
            string nombreCatalogoIssuu = null, nombreCatalogoConfig = null;
            switch (idMarcaCatalogo)
            {
                case Constantes.Marca.LBel:
                    nombreCatalogoIssuu = "lbel";
                    nombreCatalogoConfig = "Lbel";
                    break;
                case Constantes.Marca.Esika:
                    nombreCatalogoIssuu = "esika";
                    nombreCatalogoConfig = "Esika";
                    break;
                case Constantes.Marca.Cyzone:
                    nombreCatalogoIssuu = "cyzone";
                    nombreCatalogoConfig = "Cyzone";
                    break;
                case Constantes.Marca.Finart:
                    nombreCatalogoIssuu = "finart";
                    break;
            }

            string codigo = null;
            string zonas = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Zonas_" + userData.CodigoISO + campania] ?? "";
            bool esCatalogoPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
            if (esCatalogoPiloto) codigo = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + userData.CodigoISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoCatalogoIssuu"].ToString();
            return string.Format(codigo, nombreCatalogoIssuu, getPaisNombreByISO(userData.CodigoISO), campania.Substring(4, 2), campania.Substring(0, 4));
        }

        protected string getPaisNombreByISO(string paisISO)
        {
            switch (paisISO)
            {
                case "AR": return "argentina";
                case "BO": return "bolivia";
                case "CL": return "chile";
                case "CO": return "colombia";
                case "CR": return "costarica";
                case "DO": return "republicadominicana";
                case "EC": return "ecuador";
                case "GT": return "guatemala";
                case "MX": return "mexico";
                case "PA": return "panama";
                case "PE": return "peru";
                case "PR": return "puertorico";
                case "SV": return "elsalvador";
                case "VE": return "venezuela";
                default: return "sinpais";
            }
        }

        #endregion

        #region Zonificacion

        protected IEnumerable<RegionModel> DropDownListRegiones(int paisID)
        {
            IList<BERegion> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllRegiones(paisID);
            }
            return Mapper.Map<IList<BERegion>, IEnumerable<RegionModel>>(lst.OrderBy(zona => zona.Codigo).ToList());
        }

        protected IEnumerable<ZonaModel> DropDownListZonas(int PaisID)
        {
            IList<BEZona> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllZonas(PaisID);
            }
            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lst);
        }

        //EPD-2598 INICIO

        //protected IEnumerable<EstadoActividadModel> DropDownListEstadoActividad(int PaisID)
        //{
        //    IList<BEConsultorasProgramaNuevas> lst;
        //    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
        //    {
        //        lst = sv.sele(PaisID);
        //    }
        //    return Mapper.Map<IList<BEZona>, IEnumerable<EstadoActividadModel>>(lst);
        //}
        //EPD-2598  FIN

        public JsonResult ObtenerZonasByRegion(int PaisID, int RegionID)
        {
            var listaZonas = DropDownListZonas(PaisID);
            if (RegionID > -1) listaZonas = listaZonas.Where(x => x.RegionID == RegionID).ToList();
            return Json(new { success = true, listaZonas = listaZonas }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region LogDynamo

        protected void RegistrarLogDynamoDB(string aplicacion, string rol, string pantallaOpcion, string opcionAccion)
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
                    Version = "2.0",
                };


                var urlApi = ConfigurationManager.AppSettings.Get("UrlLogDynamo");

                if (string.IsNullOrEmpty(urlApi)) return;

                HttpClient httpClient = new HttpClient();
                httpClient.BaseAddress = new Uri(urlApi);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                dataString = JsonConvert.SerializeObject(data);

                HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

                HttpResponseMessage response = httpClient.PostAsync("Api/LogUsabilidad", contentPost).GetAwaiter().GetResult();

                var noQuitar = response.IsSuccessStatusCode;

                httpClient.Dispose();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, dataString);
            }
        }

        #endregion

        #region Notificaciones

        protected void CargarMensajesNotificacionesGPR(NotificacionesModel model, List<BELogGPRValidacion> LogsGPRValidacion)
        {
            model.CuerpoDetalles = new List<string>();
            if (LogsGPRValidacion.Count == 0) return;

            var deuda = LogsGPRValidacion.Where(x => x.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.ActualizacionDeuda));
            model.CuerpoMensaje1 = "Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar por:";

            // Monto mínimo - deuda
            var items = LogsGPRValidacion.Where(l => l.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.MontoMinino));
            if (items.Any() && deuda.Any())
            {
                //TextoMotivoRechazo.Append(string.Format("Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar porque no cumple con el <b>monto mínimo</b> de {0} {1} y adicionalmente por tener una <b>deuda pendiente</b> con nosotros de {0} {2}. <br>Te invitamos a añadir más productos, cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMinimo, deuda.FirstOrDefault().Valor));
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto mínimo</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO)));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any()) // Monto mínimo
            {
                //TextoMotivoRechazo.Append(string.Format("Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar porque no cumple con el <b>monto mínimo</b> de {0} {1}. <br>Te invitamos a añadir más productos y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMinimo));
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto mínimo</b> de  {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMinino;
                return;
            }

            //Monto máximo - deuda:
            items = LogsGPRValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.MontoMaximo));
            if (items.Any() && deuda.Any())
            {
                //TextoMotivoRechazo.Append(string.Format("Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar por superar el <b>monto máximo</b> permitido de {0} {1} y adicionalmente por tener una <b>deuda pendiente</b> con nosotros de {0} {2}. <br>Te invitamos a modificar tu pedido, cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMaximo, deuda.FirstOrDefault().Valor));
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto máximo</b> de {0} {1} ", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMaximo, userData.CodigoISO)));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1} ", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>modificar</b> tu pedido, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())//Monto máximo
            {
                //TextoMotivoRechazo.Append(string.Format("Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar por superar el <b>monto máximo</b> permitido de {0} {1}. <br>Te invitamos a modificar y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMaximo));
                model.CuerpoDetalles.Add(string.Format("No cumplir con el <b>monto máximo</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(userData.MontoMaximo, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>modificar</b> y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMaximo;
                return;
            }
            //Monto mínimo stock + deuda:
            items = LogsGPRValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock));
            if (items.Any() && deuda.Any())
            {
                //TextoMotivoRechazo.Append(string.Format("Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar porque no cumple con el <b>monto mínimo</b> debido a que no contamos con stock de algunos productos, y adicionalmente por tener una <b>deuda pendiente</b> con nosotros de {0} {1}. <br>Te invitamos a añadir más productos, cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, deuda.FirstOrDefault().Valor));
                model.CuerpoDetalles.Add("No cumplir con el <b>monto mínimo</b>");
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos, <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                return;
            }
            if (items.Any())//Monto mínimo stock
            {
                //TextoMotivoRechazo.Append("Luego de haber revisado tu pedido, te informamos que este no se ha podido facturar porque no cumple con el <b>monto mínimo</b> debido a que no contamos con stock de algunos productos. <br> Te invitamos a añadir más productos y reservar tu pedido el día de hoy para que sea facturado exitosamente.");
                model.CuerpoDetalles.Add("No cumplir con el <b>monto mínimo</b>");
                model.CuerpoMensaje2 = "Te invitamos a <b>añadir</b> más productos y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock;
                return;
            }

            if (deuda.Any()) //Deuda
            {
                //TextoMotivoRechazo.Append(string.Format("Lamentamos informarte que tu pedido no se ha podido facturar porque tiene una <b>deuda pendiente</b> con nosotros de {0} {1} <br>Te invitamos a cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, deuda.FirstOrDefault().Valor));
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ActualizacionDeuda;
            }
        }

        #endregion

        protected int GetDiasFaltantesFacturacion(DateTime fechaInicioCampania, double zonaHoraria)
        {
            DateTime fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;
            return fechaHoy >= fechaInicioCampania.Date ? 0 : (fechaInicioCampania.Subtract(DateTime.Now.AddHours(zonaHoraria)).Days + 1);
        }

        protected JsonResult ErrorJson(string message)
        {
            return Json(new { success = false, message = message }, JsonRequestBehavior.AllowGet);
        }

        public String GetUrlCompartirFB()
        {
            //var urlWs = "";
            string urlBase_fb = "";
            if (System.Web.HttpContext.Current.Request.UserAgent != null)
            {
                var request = HttpContext.Request;

                //var urlBase_wsp = request.Url.Scheme + "://" + request.Url.Authority + "/Pdto.aspx?id=" + userData.CodigoISO + "_[valor]";
                //urlWs = urlBase_wsp; //"whatsapp://send?text=" + urlBase_wsp;

                urlBase_fb = request.Url.Scheme + "://" + request.Url.Authority + "/Pdto.aspx?id=" + userData.CodigoISO + "_[valor]";
            }
            return urlBase_fb;
        }

        public String GetUrlCompartirFB(int id = 0)
        {
            //var urlWs = "";
            string urlBase_fb = "";
            if (System.Web.HttpContext.Current.Request.UserAgent != null)
            {
                var request = HttpContext.Request;

                //var urlBase_wsp = request.Url.Scheme + "://" + request.Url.Authority + "/Pdto.aspx?id=" + userData.CodigoISO + "_[valor]";
                //urlWs = urlBase_wsp; //"whatsapp://send?text=" + urlBase_wsp;

                urlBase_fb = request.Url.Scheme + "://" + request.Url.Authority + "/Pdto.aspx?id=" + userData.CodigoISO + "_" + (id > 0 ? id.ToString() : "[valor]");
            }
            return urlBase_fb;
        }

        public string GetUrlCompartirFBSR(int OfertaShowRoomID)
        {
            string urlBase_fb = "";
            if (System.Web.HttpContext.Current.Request.UserAgent != null)
            {
                var request = HttpContext.Request;
                urlBase_fb = request.Url.Scheme + "://" + request.Url.Authority + "/Set.aspx?id=" + userData.CodigoISO + "_" + OfertaShowRoomID.ToString() + "_" + userData.CampaniaID.ToString() + "_F";
            }
            return urlBase_fb;
        }

        protected JsonResult ErrorJson(string message, bool allowGet = false)
        {
            return Json(new { success = false, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }

        protected JsonResult SuccessJson(string message, bool allowGet = false)
        {
            return Json(new { success = true, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }

        private bool NoMostrarBannerODD()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "OfertaLiquidacion") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            //if (controllerName == "MisPedidos") return true;
            //if (controllerName == "Pedido") return true;
            if (controllerName == "ShowRoom") return true;
            return false;
        }

        public string ObtenerValorPersonalizacionShowRoom(string codigoAtributo, string tipoAplicacion)
        {
            if (userData.ListaShowRoomPersonalizacionConsultora == null)
                return string.Empty;

            var model = userData.ListaShowRoomPersonalizacionConsultora.FirstOrDefault(p => p.Atributo == codigoAtributo && p.TipoAplicacion == tipoAplicacion);

            return model == null
                ? string.Empty
                : model.Valor;
        }

        public string GetCodigoEstrategia()
        {
            var codigo = Constantes.TipoEstrategiaCodigo.OfertaParaTi;
            if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
            {
                codigo = Constantes.TipoEstrategiaCodigo.RevistaDigital;
            }
            return codigo;
        }

        public bool ValidarPermiso(string codigo, string codigoConfig = "")
        {
            codigo = Util.Trim(codigo).ToLower();
            codigoConfig = Util.Trim(codigoConfig);

            var listaConfigPais = ListConfiguracionPais();
            var existe = new ConfiguracionPaisModel();

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
                if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
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
                        bool esVenta = (sessionManager.GetMostrarShowRoomProductos());
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

        public bool IsMobile()
        {
            //// todo: better aproach HttpContext.Request.Browser.IsMobileDevice;
            var url = string.Empty;

            url = HttpContext.Request.UrlReferrer != null ?
                Util.Trim(HttpContext.Request.UrlReferrer.LocalPath).ToLower() :
                Util.Trim(HttpContext.Request.FilePath).ToLower();
            url = url.Replace("#", "/") + "/";
            return url.Contains("/mobile/") || url.Contains("/g/");
        }

        public List<BETablaLogicaDatos> ObtenerParametrosTablaLogica(int paisID, short tablaLogicaId, bool sesion = false)
        {
            var datos = sesion ? (List<BETablaLogicaDatos>)Session[Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()] : null;
            if (datos == null)
            {
                datos = new List<BETablaLogicaDatos>();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    datos = sv.GetTablaLogicaDatos(userData.PaisID, tablaLogicaId).ToList();
                }
                datos = datos ?? new List<BETablaLogicaDatos>();

                if (sesion)
                    Session[Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()] = datos;
            }

            return datos;
        }

        public string ObtenerValorTablaLogica(int paisID, short tablaLogicaId, short idTablaLogicaDatos, bool sesion = false)
        {
            return ObtenerValorTablaLogica(ObtenerParametrosTablaLogica(paisID, tablaLogicaId, sesion), idTablaLogicaDatos);
        }

        public string ObtenerValorTablaLogica(List<BETablaLogicaDatos> datos, short idTablaLogicaDatos)
        {
            var valor = "";
            if (datos.Any())
            {
                var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == idTablaLogicaDatos) ?? new BETablaLogicaDatos();
                valor = Util.Trim(par.Codigo);
            }
            return valor;
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
            };

            return origenActual;
        }

        #region CDR
        protected string MensajeGestionCdrInhabilitadaYChatEnLinea()
        {
            string mensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitada();
            if (string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return mensajeGestionCdrInhabilitada;
            return mensajeGestionCdrInhabilitada + " " + Constantes.CdrWebMensajes.ContactateChatEnLinea;
        }

        protected string MensajeGestionCdrInhabilitada()
        {
            if (userData.EsCDRWebZonaValida == 0) return Constantes.CdrWebMensajes.ZonaBloqueada;
            if (userData.IndicadorBloqueoCDR == 1) return Constantes.CdrWebMensajes.ConsultoraBloqueada;
            if (CumpleRangoCampaniaCDR() == 0) return Constantes.CdrWebMensajes.SinPedidosDisponibles;

            int diasFaltantes = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            if (diasFaltantes == 0) return Constantes.CdrWebMensajes.FueraDeFecha;

            int cDRDiasAntesFacturacion = 0;
            BECDRWebDatos cDRWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.DiasAntesFacturacion);
            if (cDRWebDatos != null) Int32.TryParse(cDRWebDatos.Valor, out cDRDiasAntesFacturacion);
            if (diasFaltantes <= cDRDiasAntesFacturacion) return Constantes.CdrWebMensajes.FueraDeFecha;

            return string.Empty;
        }

        private int CumpleRangoCampaniaCDR()
        {
            var listaMotivoOperacion = CargarMotivoOperacion();
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            int maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(maxDias);
            return (listaPedidoFacturados.Count > 0) ? 1 : 0;
        }

        protected List<BEPedidoWeb> CargarPedidosFacturados(int maxDias = 0)
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRPedidosFacturado] != null)
                {
                    return (List<BEPedidoWeb>)Session[Constantes.ConstSession.CDRPedidosFacturado];
                }

                if (maxDias <= 0) return new List<BEPedidoWeb>();

                var listaPedidoFacturados = new List<BEPedidoWeb>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaPedidoFacturados = sv.GetPedidosFacturadoSegunDias(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, maxDias).ToList();
                }

                listaPedidoFacturados = listaPedidoFacturados ?? new List<BEPedidoWeb>();
                Session[Constantes.ConstSession.CDRPedidosFacturado] = listaPedidoFacturados;
                return listaPedidoFacturados;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRPedidosFacturado] = null;
                return new List<BEPedidoWeb>();
            }
        }

        protected List<BECDRWebMotivoOperacion> CargarMotivoOperacion()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRMotivoOperacion] != null)
                {
                    return (List<BECDRWebMotivoOperacion>)Session[Constantes.ConstSession.CDRMotivoOperacion];
                }

                var listaMotivoOperacion = new List<BECDRWebMotivoOperacion>();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    listaMotivoOperacion = sv.GetCDRWebMotivoOperacion(userData.PaisID, new BECDRWebMotivoOperacion()).ToList();
                }

                int diasFaltantes = 0;
                BECDRWebDatos cDRWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.ValidacionDiasFaltante);
                if (cDRWebDatos != null) Int32.TryParse(cDRWebDatos.Valor, out diasFaltantes);

                if (diasFaltantes > 0)
                {
                    List<string> operacionFaltanteList = new List<string> { "F", "G" };
                    listaMotivoOperacion.Where(mo => operacionFaltanteList.Contains(mo.CodigoOperacion))
                        .Update(mo =>
                        {
                            mo.CDRTipoOperacion.NumeroDiasAtrasOperacion = Math.Min(diasFaltantes, mo.CDRTipoOperacion.NumeroDiasAtrasOperacion);
                        });
                }
                Session[Constantes.ConstSession.CDRMotivoOperacion] = listaMotivoOperacion;
                return listaMotivoOperacion;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRMotivoOperacion] = null;
                return new List<BECDRWebMotivoOperacion>();
            }
        }

        protected BECDRWebDatos ObtenerCdrWebDatosByCodigo(string codigo)
        {
            return CargarCdrWebDatos().FirstOrDefault(p => p.Codigo == codigo);
        }

        protected List<BECDRWebDatos> CargarCdrWebDatos()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRWebDatos] != null)
                {
                    var listacdrWebDatos = (List<BECDRWebDatos>)Session[Constantes.ConstSession.CDRWebDatos];
                    if (listacdrWebDatos.Count > 0)
                        return listacdrWebDatos;
                }

                var lista = new List<BECDRWebDatos>();
                var entidad = new BECDRWebDatos();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDatos(userData.PaisID, entidad).ToList();
                }

                Session[Constantes.ConstSession.CDRWebDatos] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWebDatos] = null;
                return new List<BECDRWebDatos>();
            }
        }

        protected List<BECDRWebDetalle> CargarDetalle(MisReclamosModel model)
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRWebDetalle] != null)
                {
                    return (List<BECDRWebDetalle>)Session[Constantes.ConstSession.CDRWebDetalle];
                }

                model = model ?? new MisReclamosModel();

                var lista = new List<BECDRWebDetalle>();
                var entidad = new BECDRWebDetalle();
                entidad.CDRWebID = model.CDRWebID;
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDetalle(userData.PaisID, entidad, model.PedidoID).ToList();
                }

                lista = lista ?? new List<BECDRWebDetalle>();

                lista.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                lista.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);
                lista.Update(p => p.FormatoPrecio1 = Util.DecimalToStringFormat(p.Precio, userData.CodigoISO));
                lista.Update(p => p.FormatoPrecio2 = Util.DecimalToStringFormat(p.Precio2, userData.CodigoISO));
                Session[Constantes.ConstSession.CDRWebDetalle] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWebDetalle] = null;
                return new List<BECDRWebDetalle>();
            }
        }

        protected List<BECDRMotivoReclamo> CargarMotivo(MisReclamosModel model)
        {
            var listaRetorno = new List<BECDRMotivoReclamo>();
            try
            {
                model.Operacion = Util.SubStr(model.Operacion, 0);
                var listaFiltro = CargarMotivoOperacionPorDias(model);
                foreach (var item in listaFiltro)
                {
                    if (item.CodigoOperacion != model.Operacion && model.Operacion != "")
                        continue;

                    if (listaRetorno.Any(r => r.CodigoReclamo == item.CodigoReclamo))
                        continue;

                    var desc = ObtenerDescripcion(item.CDRMotivoReclamo.CodigoReclamo, Constantes.TipoMensajeCDR.Motivo);
                    var add = new BECDRMotivoReclamo();
                    add.CodigoReclamo = item.CodigoReclamo;
                    add.DescripcionReclamo = desc.Descripcion;
                    listaRetorno.Add(add);
                }

                return listaRetorno;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return listaRetorno;
            }
        }

        protected List<BECDRWebMotivoOperacion> CargarMotivoOperacionPorDias(MisReclamosModel model)
        {
            var listaPedidoFacturado = CargarPedidosFacturados();
            var pedido = listaPedidoFacturado.FirstOrDefault(p => p.PedidoID == model.PedidoID) ?? new BEPedidoWeb();
            DateTime fechaSys = userData.FechaActualPais.Date;
            DateTime fechaFinCampania = pedido.FechaRegistro.Date;
            TimeSpan diferencia = fechaSys - fechaFinCampania;
            int differenceInDays = diferencia.Days;
            //Para Pruebas
            //differenceInDays = 30;

            if (differenceInDays <= 0) return new List<BECDRWebMotivoOperacion>();

            var listaMotivoOperacion = CargarMotivoOperacion();
            var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDRTipoOperacion.NumeroDiasAtrasOperacion >= differenceInDays).ToList();
            return listaFiltro.OrderBy(p => p.Prioridad).ToList();
        }

        protected BECDRWebDescripcion ObtenerDescripcion(string codigoSsic, string tipo)
        {
            codigoSsic = Util.SubStr(codigoSsic, 0);
            //codigoSsic = codigoSsic.ToLower();
            tipo = Util.SubStr(tipo, 0);
            //tipo = tipo.ToLower();
            var listaDescripcion = CargarDescripcion();
            var desc = listaDescripcion.FirstOrDefault(d => d.CodigoSSIC == codigoSsic && d.Tipo == tipo) ?? new BECDRWebDescripcion();

            desc.Descripcion = Util.SubStr(desc.Descripcion, 0);
            return desc;
        }

        private List<BECDRWebDescripcion> CargarDescripcion()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRDescripcion] != null)
                {
                    var listaDescripcion = (List<BECDRWebDescripcion>)Session[Constantes.ConstSession.CDRDescripcion];
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                var lista = new List<BECDRWebDescripcion>();
                var entidad = new BECDRWebDescripcion();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDescripcion(userData.PaisID, entidad).ToList();
                }

                lista = lista ?? new List<BECDRWebDescripcion>();
                //lista.Update(d => d.Tipo = d.Tipo.ToLower());
                Session[Constantes.ConstSession.CDRDescripcion] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRDescripcion] = null;
                return new List<BECDRWebDescripcion>();
            }
        }

        protected void CargarInformacion()
        {
            Session[Constantes.ConstSession.CDRWebDetalle] = null;
            Session[Constantes.ConstSession.CDRWeb] = null;

            var listaMotivoOperacion = CargarMotivoOperacion();
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            int maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(maxDias);

            var listaCampanias = new List<CampaniaModel>();
            var campania = new CampaniaModel();
            campania.CampaniaID = 0;
            campania.NombreCorto = "¿En qué campaña lo solicitaste?";
            listaCampanias.Add(campania);
            foreach (var facturado in listaPedidoFacturados)
            {
                var existe = listaCampanias.Where(c => c.CampaniaID == facturado.CampaniaID) ?? new List<CampaniaModel>();
                if (!existe.Any())
                {
                    campania = new CampaniaModel();
                    campania.CampaniaID = facturado.CampaniaID;
                    campania.NombreCorto = facturado.CampaniaID.ToString();
                    listaCampanias.Add(campania);
                }
            }

            Session[Constantes.ConstSession.CDRCampanias] = listaCampanias;

            CargarParametriaCdr();
            CargarCdrWebDatos();
        }

        protected List<BECDRParametria> CargarParametriaCdr()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRParametria] != null)
                {
                    var listaDescripcion = (List<BECDRParametria>)Session[Constantes.ConstSession.CDRParametria];
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                var lista = new List<BECDRParametria>();
                var entidad = new BECDRParametria();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRParametria(userData.PaisID, entidad).ToList();
                }

                Session[Constantes.ConstSession.CDRParametria] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRParametria] = null;
                return new List<BECDRParametria>();
            }
        }

        protected List<BECDRWeb> CargarBECDRWeb(MisReclamosModel model)
        {
            var entidadLista = new List<BECDRWeb>();
            try
            {
                if (Session[Constantes.ConstSession.CDRWeb] != null)
                {
                    return (List<BECDRWeb>)Session[Constantes.ConstSession.CDRWeb];
                }

                //if (model.PedidoID * model.CampaniaID <= 0)
                //    return entidadLista;

                var entidad = new BECDRWeb();
                entidad.CampaniaID = model.CampaniaID;
                entidad.PedidoID = model.PedidoID;
                entidad.ConsultoraID = Int32.Parse(userData.ConsultoraID.ToString());

                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    entidadLista = sv.GetCDRWeb(userData.PaisID, entidad).ToList();
                }

                Session[Constantes.ConstSession.CDRWeb] = null;
                if (entidadLista.Count() == 1)
                {
                    Session[Constantes.ConstSession.CDRWeb] = entidadLista;
                }

                return entidadLista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWeb] = null;
                entidadLista = new List<BECDRWeb>();
                return entidadLista;
            }
        }
        #endregion

        protected string GetPaisesEsikaFromConfig()
        {
            return ConfigurationManager.AppSettings.Get("PaisesEsika") ?? string.Empty;
        }

        #region Configuracion Seccion Palanca
        public List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion()
        {
            var menuActivo = GetSessionMenuActivo();

            if (menuActivo.CampaniaId <= 0)
            {
                menuActivo.CampaniaId = userData.CampaniaID;
                //MenuContenedorGuardar(menuActivo.Codigo, menuActivo.CampaniaId);
            }

            var sessionNombre = Constantes.ConstSession.ListadoSeccionPalanca + menuActivo.CampaniaId;

            var listaEntidad = new List<BEConfiguracionOfertasHome>();

            if (Session[sessionNombre] != null)
            {
                listaEntidad = (List<BEConfiguracionOfertasHome>)Session[sessionNombre];
            }
            else
            {
                #region  Obtenido de la cache de Amazon

                using (SACServiceClient sv = new SACServiceClient())
                {
                    listaEntidad = sv.ListarSeccionConfiguracionOfertasHome(userData.PaisID, menuActivo.CampaniaId).ToList();
                }
                #endregion

                Session[sessionNombre] = listaEntidad;
            }

            if (menuActivo.CampaniaId > userData.CampaniaID)
            {
                listaEntidad = listaEntidad.Where(entConf
                => entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento
                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.InicioRD).ToList();
            }

            var modelo = new List<ConfiguracionSeccionHomeModel>();

            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var isMobile = IsMobile();
            var isBpt = revistaDigital.TieneRDC || revistaDigital.TieneRDR;
            foreach (var beConfiguracionOfertasHome in listaEntidad)
            {
                var entConf = beConfiguracionOfertasHome;
                entConf.ConfiguracionPais.Codigo = Util.Trim(entConf.ConfiguracionPais.Codigo).ToUpper();

                string titulo = "", subTitulo = "";

                if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
                {
                    if (!RDObtenerTitulosSeccion(ref titulo, ref subTitulo, entConf.ConfiguracionPais.Codigo))
                        continue;

                    entConf.DesktopTitulo = titulo;
                    entConf.DesktopSubTitulo = subTitulo;

                    entConf.MobileTitulo = titulo;
                    entConf.MobileSubTitulo = subTitulo;

                    if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
                    {
                        entConf.MobileCantidadProductos = 0;
                        entConf.DesktopCantidadProductos = 0;
                    }

                    if (menuActivo.CampaniaId > userData.CampaniaID)
                    {
                        entConf.UrlSeccion = "RevistaDigital/Revisar";
                    }
                }
                if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
                {
                    if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR) continue;

                    if (menuActivo.CampaniaId != userData.CampaniaID) entConf.UrlSeccion = "Revisar/" + entConf.UrlSeccion;
                }

                RemplazarTagNombreConfiguracionOferta(ref entConf);

                var seccion = new ConfiguracionSeccionHomeModel
                {
                    CampaniaID = menuActivo.CampaniaId,
                    Codigo = entConf.ConfiguracionPais.Codigo ?? entConf.ConfiguracionOfertasHomeID.ToString().PadLeft(5, '0'),
                    Orden = isBpt ? isMobile ? entConf.MobileOrdenBpt : entConf.DesktopOrdenBpt : isMobile ? entConf.MobileOrden : entConf.DesktopOrden,
                    ImagenFondo = isMobile ? entConf.MobileImagenFondo : entConf.DesktopImagenFondo,
                    Titulo = isMobile ? entConf.MobileTitulo : entConf.DesktopTitulo,
                    SubTitulo = isMobile ? entConf.MobileSubTitulo : entConf.DesktopSubTitulo,
                    TipoPresentacion = isMobile ? entConf.MobileTipoPresentacion : entConf.DesktopTipoPresentacion,
                    TipoEstrategia = isMobile ? entConf.MobileTipoEstrategia : entConf.DesktopTipoEstrategia,
                    CantidadMostrar = isMobile ? entConf.MobileCantidadProductos : entConf.DesktopCantidadProductos,
                    UrlLandig = "/" + (isMobile ? "Mobile/" : "") + entConf.UrlSeccion,
                    VerMas = true
                };

                seccion.ImagenFondo = ConfigS3.GetUrlFileS3(carpetaPais, seccion.ImagenFondo);

                switch (entConf.ConfiguracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.OfertasParaTi:
                        seccion.UrlObtenerProductos = "OfertasParaTi/ConsultarEstrategiasOPT";
                        seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.RevistaDigitalMobileLanding : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopLanding;
                        seccion.VerMas = false;
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        seccion.UrlObtenerProductos = "RevistaDigital/RDObtenerProductosLan";
                        seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.RevistaDigitalMobileLandingCarrusel : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopLandingCarrusel;
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        seccion.UrlObtenerProductos = "RevistaDigital/RDObtenerProductos";
                        seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.RevistaDigitalMobileLanding : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopLanding;
                        break;
                    case Constantes.ConfiguracionPais.ShowRoom:

                        if (sessionManager.GetEsShowRoom() &&
                            !sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            seccion.UrlObtenerProductos = "ShowRoom/GetDataShowRoomIntriga";

                            if (!isMobile)
                            {
                                seccion.ImagenFondo =
                                    ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomIntriga,
                                                                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                            }
                            else
                            {
                                seccion.ImagenFondo =
                                    ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasIntriga,
                                                                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                            }
                        }

                        if (sessionManager.GetEsShowRoom() &&
                            sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            seccion.UrlObtenerProductos = "ShowRoom/CargarProductosShowRoomOferta";
                            if (!isMobile)
                            {
                                seccion.ImagenFondo =
                                    ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomVenta,
                                                                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                            }
                            else
                            {
                                seccion.ImagenFondo =
                                    ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasVenta,
                                                                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                            }

                        }
                        break;
                    case Constantes.ConfiguracionPais.OfertaDelDia:
                        if (!userData.TieneOfertaDelDia) continue;
                        break;
                    default:
                        break;
                }

                seccion.TemplatePresentacion = "";
                seccion.TemplateProducto = "";
                switch (seccion.TipoPresentacion)
                {
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselSimple:
                        seccion.TemplatePresentacion = "seccion-simple-centrado";
                        seccion.TemplateProducto = "#producto-landing-template";
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselPrevisuales:
                        seccion.TemplatePresentacion = "carrusel-previsuales";
                        seccion.TemplateProducto = "#lanzamiento-carrusel-template";
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado:
                        seccion.TemplatePresentacion = "seccion-simple-centrado";
                        seccion.TemplateProducto = "#producto-landing-template";
                        seccion.CantidadMostrar = isMobile ? 1 : seccion.CantidadMostrar > 3 || seccion.CantidadMostrar <= 0 ? 3 : seccion.CantidadMostrar;
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.Banners:
                        seccion.TemplatePresentacion = "seccion-banner";
                        seccion.Titulo = "";
                        seccion.SubTitulo = "";
                        seccion.CantidadMostrar = 0;
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.ShowRoom:
                        if (sessionManager.GetEsShowRoom())
                        {
                            seccion.TemplatePresentacion = "seccion-showroom";
                            seccion.TemplateProducto = "#template-showroom";
                        }
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.OfertaDelDia:
                        seccion.TemplatePresentacion = "seccion-oferta-del-dia";
                        break;

                    case Constantes.ConfiguracionSeccion.TipoPresentacion.DescagablesNavidenos:
                        seccion.TemplatePresentacion = "seccion-descargables-navidenos";
                        break;
                }

                if (seccion.TemplatePresentacion == "") continue;                

                modelo.Add(seccion);
            }

            return modelo.OrderBy(s => s.Orden).ToList();

        }

        public ConfiguracionSeccionHomeModel ObtenerSeccionHomePalanca(string codigo, int campaniaId)
        {
            var seccion = new ConfiguracionSeccionHomeModel();
            var modelo = ObtenerConfiguracionSeccion();
            if (codigo != "") modelo = modelo.Where(m => m.Codigo == codigo).ToList();
            if (campaniaId > -1)
            {
                var modeloX = modelo.Where(m => m.CampaniaID <= campaniaId).OrderByDescending(m => m.CampaniaID).ToList();
                if (modeloX.Any()) seccion = modeloX[0];
            }
            return seccion;
        }

        public bool RDObtenerTitulosSeccion(ref string titulo, ref string subtitulo, string codigo)
        {
            if (codigo == Constantes.ConfiguracionPais.RevistaDigital)
            {
                if (!revistaDigital.TieneRDC) return false;
            }

            if (codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida)
            {
                if (!revistaDigital.TieneRDR) return false;
            }

            titulo = "OFERTAS ÉSIKA PARA MÍ";
            subtitulo = userData.Sobrenombre.ToUpper() + ", PRUEBA LAS VENTAJAS DE COMPRAR OFERTAS PERSONALIZADAS";

            if (codigo == Constantes.ConfiguracionPais.OfertasParaTi)
            {
                if (revistaDigital.TieneRDC) return false;
                if (revistaDigital.TieneRDR) return false;

                titulo = "MÁS OFERTAS PARA TI " + userData.Sobrenombre.ToUpper();
                subtitulo = "EXCLUSIVAS SÓLO POR WEB";
            }

            return true;
        }
        #endregion

        #region MenuContenedor
        public MenuContenedorModel GetMenuActivo()
        {
            string path = Request.Path;
            var listMenu = BuildMenuContenedor();

            path = path.ToLower().Replace("/mobile", "");

            //// guid length + /g/ length
            if (path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) >= 0)
                path = path.Substring(path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) + 39);

            var pathStrings = path.Split('/');
            var newPath = "";
            var pathOrigen = "";
            var menuActivo = new MenuContenedorModel { CampaniaId = userData.CampaniaID, ConfiguracionPais = new ConfiguracionPaisModel() };
            try
            {
                newPath += "/" + pathStrings[1];
                newPath += "/" + pathStrings[2];
            }
            catch (Exception)
            {
                // ignored
            }

            try
            {
                int campaniaid = 0;
                var campaniaIdStr = Util.Trim(Request.QueryString["campaniaid"]);
                pathOrigen = Util.Trim(Request.QueryString["origen"]);
                if (Int32.TryParse(campaniaIdStr, out campaniaid))
                {
                    menuActivo.CampaniaId = Int32.Parse(campaniaIdStr);
                }
            }
            catch (Exception)
            {
                // ignored
            }

            newPath = newPath.EndsWith("/") ? newPath.Substring(0, newPath.Length - 1) : newPath;

            switch (newPath.ToLower())
            {
                case Constantes.UrlMenuContenedor.Inicio:
                case Constantes.UrlMenuContenedor.InicioIndex:
                    menuActivo.Codigo = revistaDigital.TieneRDC || revistaDigital.TieneRDR ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    break;
                case Constantes.UrlMenuContenedor.InicioRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRDC || revistaDigital.TieneRDR ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    break;
                case Constantes.UrlMenuContenedor.RdInicio:
                case Constantes.UrlMenuContenedor.RdInicioIndex:
                    menuActivo.Codigo = revistaDigital.TieneRDC || revistaDigital.TieneRDR ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    break;
                case Constantes.UrlMenuContenedor.RdComprar:
                    menuActivo.Codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                    break;
                case Constantes.UrlMenuContenedor.RdRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    break;
                case Constantes.UrlMenuContenedor.RdInformacion:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Informacion;
                    menuActivo.CampaniaId = 0;
                    break;
                case Constantes.UrlMenuContenedor.RdDetalle:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Lanzamiento;
                    break;
                case Constantes.UrlMenuContenedor.SwInicio:
                case Constantes.UrlMenuContenedor.SwIntriga:
                case Constantes.UrlMenuContenedor.SwDetalle:
                case Constantes.UrlMenuContenedor.SwInicioIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.ShowRoom;
                    break;
                case Constantes.UrlMenuContenedor.OptDetalle:
                    menuActivo.Codigo = GetMenuActivoOptCodigoSegunActivo(pathOrigen);
                    if (menuActivo.Codigo == "")
                        menuActivo = GetSessionMenuActivo();
                    break;
                case Constantes.UrlMenuContenedor.OfertaDelDia:
                case Constantes.UrlMenuContenedor.OfertaDelDiaIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.OfertaDelDia;
                    break;
                default:
                    break;
            }

            var configMenu = listMenu.FirstOrDefault(m => m.Codigo == menuActivo.Codigo && m.CampaniaId == menuActivo.CampaniaId);
            if (menuActivo.Codigo == Constantes.ConfiguracionPais.Informacion)
                if (revistaDigital.TieneRDR || revistaDigital.TieneRDC)
                    configMenu = listMenu.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.InicioRD && m.CampaniaId == userData.CampaniaID);
                else
                    configMenu = listMenu.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.Inicio && m.CampaniaId == userData.CampaniaID);

            if (configMenu == null)
                configMenu = new ConfiguracionPaisModel();

            configMenu.Codigo = Util.Trim(configMenu.Codigo);
            if (configMenu.Codigo == "")
            {
                configMenu.CampaniaId = configMenu.CampaniaId > 0 ? configMenu.CampaniaId : userData.CampaniaID;
                configMenu.Codigo = Constantes.ConfiguracionPais.Inicio;
            }

            menuActivo.ConfiguracionPais = configMenu ?? new ConfiguracionPaisModel();
            if (revistaDigital.TieneRDC)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
                menuActivo.CampaniaX1 = AddCampaniaAndNumero(userData.CampaniaID, 1);
            }
            Session[Constantes.ConstSession.MenuContenedorActivo] = menuActivo;
            return menuActivo;
        }

        public string GetMenuActivoOptCodigoSegunActivo(string pathOrigen)
        {
            string codigo = "";
            try
            {
                int origrn = Int32.Parse(pathOrigen);
                switch (origrn)
                {
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileLandingCarrusel:
                        codigo = Constantes.ConfiguracionPais.Lanzamiento;
                        break;
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeLanzamiento:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoLanzamiento:
                        codigo = Constantes.ConfiguracionPais.Lanzamiento;
                        break;
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccionMasOfertas:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccionOfertas:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion:
                        codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                        break;
                    case Constantes.OrigenPedidoWeb.MobileHomeOfertasParaTi:
                    case Constantes.OrigenPedidoWeb.MobilePedidoOfertasParaTi:
                        codigo = Constantes.ConfiguracionPais.OfertasParaTi;
                        break;
                }

            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return codigo;
        }

        public List<ConfiguracionPaisModel> ObtenerMenuContenedor()
        {
            var menuActivo = GetSessionMenuActivo();
            var listMenu = BuildMenuContenedor();
            listMenu = listMenu.Where(e => e.CampaniaId == menuActivo.CampaniaId).ToList();

            if (menuActivo.CampaniaId == userData.CampaniaID &&
                !(Session[Constantes.ConstSession.TieneLan] != null ? Session[Constantes.ConstSession.TieneLan].ToBool() : false))
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (menuActivo.CampaniaId != userData.CampaniaID &&
                !(Session[Constantes.ConstSession.TieneLanX1] != null ? Session[Constantes.ConstSession.TieneLanX1].ToBool() : false))
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (!(Session[Constantes.ConstSession.TieneOpt] != null ? Session[Constantes.ConstSession.TieneOpt].ToBool() : false))
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.OfertasParaTi).ToList();
            }
            return listMenu;
        }

        public List<ConfiguracionPaisModel> BuildMenuContenedor()
        {
            var listaMenu = (List<ConfiguracionPaisModel>)Session[Constantes.ConstSession.MenuContenedor]
                            ?? new List<ConfiguracionPaisModel>();
            if (listaMenu.Any()) return listaMenu;

            var lista = ListConfiguracionPais();
            if (!lista.Any()) return listaMenu;

            listaMenu = new List<ConfiguracionPaisModel>();
            lista = lista.Where(c => c.TienePerfil).ToList();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            var paisCarpeta = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO) ? "Esika" : "Lbel";

            foreach (var confiModel in lista)
            {
                confiModel.Codigo = Util.Trim(confiModel.Codigo).ToUpper();
                confiModel.MobileLogoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.MobileLogoBanner);
                confiModel.DesktopLogoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.DesktopLogoBanner);
                confiModel.MobileFondoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.MobileFondoBanner);
                confiModel.DesktopFondoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.DesktopFondoBanner);
                confiModel.UrlMenuMobile = "/Mobile/" + confiModel.UrlMenu;
                confiModel.EsAncla = confiModel.UrlMenu == null ? false : confiModel.UrlMenu.Contains("#");
                confiModel.CampaniaId = userData.CampaniaID;

                if (confiModel.Codigo == Constantes.ConfiguracionPais.InicioRD)
                {
                    if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
                        continue;

                    confiModel.DesktopFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_ImagenFondo, confiModel.DesktopFondoBanner);
                    confiModel.DesktopLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_ImagenLogo, confiModel.DesktopLogoBanner);
                    confiModel.DesktopTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_TituloBanner, confiModel.DesktopTituloBanner);
                    confiModel.DesktopSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_SubTituloBanner, confiModel.DesktopSubTituloBanner);

                    confiModel.MobileFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_ImagenFondo, confiModel.MobileFondoBanner);
                    confiModel.MobileLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_ImagenLogo, confiModel.MobileLogoBanner);
                    confiModel.MobileTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_TituloBanner, confiModel.MobileTituloBanner);
                    confiModel.MobileSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_SubTituloBanner, confiModel.MobileSubTituloBanner);

                    confiModel.Logo = IsMobile() ? "/Content/Images/Mobile/" + paisCarpeta + "/Contenedor/inicio_normal.png" : "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.png";
                    confiModel.Descripcion = "";
                }

                if (confiModel.Codigo == Constantes.ConfiguracionPais.Inicio)
                {
                    if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                        continue;

                    confiModel.DesktopFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenFondo, confiModel.DesktopFondoBanner);
                    confiModel.DesktopLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenLogo, confiModel.DesktopLogoBanner);
                    confiModel.DesktopTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_TituloBanner, confiModel.DesktopTituloBanner);
                    confiModel.DesktopSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_SubTituloBanner, confiModel.DesktopSubTituloBanner);

                    confiModel.MobileFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenFondo, confiModel.MobileFondoBanner);
                    confiModel.MobileLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenLogo, confiModel.MobileLogoBanner);
                    confiModel.MobileTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_TituloBanner, confiModel.MobileTituloBanner);
                    confiModel.MobileSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_SubTituloBanner, confiModel.MobileSubTituloBanner);

                    confiModel.Logo = IsMobile() ? "/Content/Images/Mobile/" + paisCarpeta + "/Contenedor/inicio_normal.png" : "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.png";
                    confiModel.Descripcion = "";
                }

                if (confiModel.Codigo == Constantes.ConfiguracionPais.ShowRoom)
                {
                    if (Session["EsShowRoom"] == null || (Session["EsShowRoom"] != null && Session["EsShowRoom"].ToString() != "1"))
                        continue;
                }

                if (confiModel.Codigo == Constantes.ConfiguracionPais.OfertaDelDia)
                {
                    if (!userData.TieneOfertaDelDia)
                        continue;
                }

                if (confiModel.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
                {
                    if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
                        continue;
                }

                if (confiModel.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
                {
                    if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                        continue;
                }

                var config = confiModel;

                if (confiModel.Codigo == Constantes.ConfiguracionPais.RevistaDigitalSuscripcion
                    || config.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida
                    || config.Codigo == Constantes.ConfiguracionPais.RevistaDigital)
                {
                    BuilTituloBannerRD(ref config);
                    if (config.DesktopSubTituloBanner == "")
                        continue;

                    config.MobileTituloBanner = config.DesktopTituloBanner;
                    config.MobileSubTituloBanner = config.DesktopSubTituloBanner;
                }
                SepararPipe(ref config);
                RemplazarTagNombreConfiguracion(ref config);

                listaMenu.Add(config);
            }

            listaMenu.AddRange(BuildMenuContenedorBloqueado(listaMenu));

            var isMob = IsMobile();
            listaMenu = (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                ? isMob ? listaMenu.OrderBy(m => m.MobileOrdenBPT).ToList() : listaMenu.OrderBy(m => m.OrdenBpt).ToList()
                : isMob ? listaMenu.OrderBy(m => m.MobileOrden).ToList() : listaMenu.OrderBy(m => m.Orden).ToList();

            Session[Constantes.ConstSession.MenuContenedor] = listaMenu;
            return listaMenu;
        }

        public List<ConfiguracionPaisModel> BuildMenuContenedorBloqueado(List<ConfiguracionPaisModel> lista)
        {
            var listaMenu = new List<ConfiguracionPaisModel>();
            foreach (var configuracionPais in lista)
            {
                ConfiguracionPaisModel config;
                switch (configuracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.InicioRD:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/Ofertas/Revisar";
                        config.UrlMenuMobile = "/Mobile/Ofertas/Revisar";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        listaMenu.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "#";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        listaMenu.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/RevistaDigital/Revisar";
                        config.UrlMenuMobile = "/Mobile/RevistaDigital/Revisar";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        listaMenu.Add(config);
                        break;
                }
            }
            return listaMenu;
        }

        public void BuilTituloBannerRD(ref ConfiguracionPaisModel confi)
        {
            confi.DesktopTituloBanner = userData.UsuarioNombre.ToUpper();
            confi.DesktopSubTituloBanner = "";

            if (revistaDigital.TieneRDC)
            {
                if (revistaDigital.SuscripcionModel.CampaniaID > userData.CampaniaID)
                    return;

                if (revistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    confi.DesktopTituloBanner += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
                    confi.DesktopSubTituloBanner = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    return;
                }

                if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    if (revistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                    {
                        confi.DesktopTituloBanner += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA";
                        confi.DesktopSubTituloBanner = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    }
                    else if (revistaDigital.SuscripcionModel.CampaniaID == AddCampaniaAndNumero(userData.CampaniaID, -1))
                    {
                        confi.DesktopTituloBanner += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
                        confi.DesktopSubTituloBanner = "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS. RECUERDA QUE PODRÁS AGREGARLOS A PARTIR DE LA PRÓXIMA CAMPAÑA";
                    }
                }
                else
                {
                    confi.DesktopTituloBanner += ", BIENVENIDA A ÉSIKA PARA MÍ TU NUEVA REVISTA ONLINE PRESONALIZADA";
                    confi.DesktopSubTituloBanner = "ENCUENTRA LAS MEJORES OFERTAS Y BONIFICACIONES EXTRAS. INSCRÍBETE PARA DISFRUTAR DE TODAS ELLAS";
                }

                return;
            }

            if (revistaDigital.TieneRDS)
            {
                if (!revistaDigital.TieneRDR)
                {
                    if (revistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                    {
                        confi.DesktopTituloBanner += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA";
                        confi.DesktopSubTituloBanner = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    }
                    else
                    {
                        confi.DesktopTituloBanner += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA";
                        confi.DesktopSubTituloBanner = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    }

                    return;
                }
            }
            else if (!revistaDigital.TieneRDR)
            {
                return;
            }

            confi.DesktopTituloBanner += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA";
            confi.DesktopSubTituloBanner = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
        }
        #endregion

        #region Helper contenedor 
        private void SepararPipe(ref ConfiguracionPaisModel config)
        {
            if (!string.IsNullOrEmpty(config.DesktopTituloMenu) && config.DesktopTituloMenu.Contains("|"))
            {
                config.DesktopSubTituloMenu = config.DesktopTituloMenu.SplitAndTrim('|').LastOrDefault();
                config.DesktopTituloMenu = config.DesktopTituloMenu.SplitAndTrim('|').FirstOrDefault();
            }
            if (!string.IsNullOrEmpty(config.MobileTituloMenu) && config.MobileTituloMenu.Contains("|"))
            {
                config.MobileSubTituloMenu = config.MobileTituloMenu.SplitAndTrim('|').LastOrDefault();
                config.MobileTituloMenu = config.MobileTituloMenu.SplitAndTrim('|').FirstOrDefault();
            }
        }

        private void RemplazarTagNombreConfiguracionOferta(ref BEConfiguracionOfertasHome config)
        {
            config.DesktopTitulo = RemplazaTag(config.DesktopTitulo);
            config.DesktopSubTitulo = RemplazaTag(config.DesktopSubTitulo);
            config.MobileTitulo = RemplazaTag(config.MobileTitulo);
            config.MobileSubTitulo = RemplazaTag(config.MobileSubTitulo);
        }

        private void RemplazarTagNombreConfiguracion(ref ConfiguracionPaisModel config)
        {
            config.DesktopTituloBanner = RemplazaTag(config.DesktopTituloBanner);
            config.DesktopSubTituloBanner = RemplazaTag(config.DesktopSubTituloBanner);
            config.MobileTituloBanner = RemplazaTag(config.MobileTituloBanner);
            config.MobileSubTituloBanner = RemplazaTag(config.MobileSubTituloBanner);
            config.DesktopTituloMenu = RemplazaTag(config.DesktopTituloMenu);
            config.DesktopSubTituloMenu = RemplazaTag(config.DesktopSubTituloMenu);
            config.MobileTituloMenu = RemplazaTag(config.MobileTituloMenu);
            config.MobileSubTituloMenu = RemplazaTag(config.MobileSubTituloMenu);
        }

        private string RemplazaTag(string cadena)
        {
            cadena = cadena ?? "";
            cadena = cadena.Replace("#Nombre", userData.Sobrenombre);
            cadena = cadena.Replace("#nombre", userData.Sobrenombre);
            cadena = cadena.Replace("#NOMBRE", userData.Sobrenombre);
            return cadena;
        }

        protected string GetDescripcionMarca(int marcaId)
        {
            var result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "L'bel";
                    break;
                case 2:
                    result = "Ésika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 4:
                    result = "S&M";
                    break;
                case 5:
                    result = "Home Collection";
                    break;
                case 6:
                    result = "Finart";
                    break;
                case 7:
                    result = "Generico";
                    break;
                case 8:
                    result = "Glance";
                    break;
                default:
                    result = "NO DISPONIBLE";
                    break;
            }

            return result;
        }

        protected List<BETipoEstrategia> GetTipoEstrategias()
        {
            List<BETipoEstrategia> tiposEstrategia;
            var entidad = new BETipoEstrategia
            {
                PaisID = userData.PaisID,
                TipoEstrategiaID = 0
            };
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                tiposEstrategia = pedidoServiceClient.GetTipoEstrategias(entidad).ToList();
            }

            return tiposEstrategia;
        }

        protected bool EsConsultoraNueva()
        {
            return userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Registrada ||
                   userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Retirada;
        }
        #endregion

        #region Sesiones 
        public object GetSession(string nameSession)
        {
            return System.Web.HttpContext.Current.Session[nameSession] ?? new object();
        }

        public List<ConfiguracionPaisModel> ListConfiguracionPais()
        {
            return GetSession(Constantes.ConstSession.ConfiguracionPaises) as List<ConfiguracionPaisModel> ??
                   new List<ConfiguracionPaisModel>();
        }

        public EventoFestivoDataModel GetEventoFestivoData()
        {
            return GetSession(Constantes.ConstSession.EventoFestivo) as EventoFestivoDataModel ??
                   new EventoFestivoDataModel();
        }

        public OfertaFinalModel GetOfertaFinal()
        {
            return GetSession(Constantes.ConstSession.OfertaFinal) as OfertaFinalModel ??
                   new OfertaFinalModel();
        }

        public MenuContenedorModel GetSessionMenuActivo()
        {
            return GetSession(Constantes.ConstSession.MenuContenedorActivo) as MenuContenedorModel ??
                   new MenuContenedorModel();
        }
        #endregion
    }
}
