﻿using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
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

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseController : Controller
    {
        #region Variables

        protected UsuarioModel userData;
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

                if (userData == null)
                {
                    string URLSignOut = string.Empty;

                    if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().Contains(Request.Url.Host))
                        URLSignOut = "/Login/SesionExpirada";
                    else
                        URLSignOut = "/Login/UserUnknown";

                    Session.Clear();
                    Session.Abandon();

                    filterContext.Result = new RedirectResult(URLSignOut);
                    return;
                }
                    
                if (Request.IsAjaxRequest())
                {
                    base.OnActionExecuting(filterContext);
                    return;
                }

                ViewBag.MenuContenedorActivo = GetMenuActivo(Request.Path);
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

                ViewBag.FingerprintOk = (Session["Fingerprint"] != null) ? 1 : 0;
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
            var esOpt = userData.RevistaDigital.TieneRDR
                    || (userData.RevistaDigital.TieneRDC && userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
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

                //if (permiso.Descripcion.ToLower() == "VENTA EXCLUSIVA WEB".ToLower())
                if (permiso.Codigo.ToLower() == Constantes.MenuCodigo.RevistaShowRoom.ToLower())
                {
                    if (sessionManager.GetEsShowRoom())
                        permiso.UrlItem = AccionControlador("sr");
                    else
                        continue;

                    permiso.EsSoloImagen = true;
                    var urlImagen = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoMenuShowRoom, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

                    if (urlImagen != "")
                        permiso.UrlImagen = urlImagen;
                    else
                        permiso.EsSoloImagen = false;
                }

                if (permiso.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
                {
                    if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                        if (!ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
                            continue;
                }

                if (permiso.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower())
                {
                    if (ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
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

                        if (permiso.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
                        {
                            userData.ClaseLogoSB = "negro";
                            if (!(userData.RevistaDigital.TieneRDC || userData.RevistaDigital.TieneRDR))
                                if (userData.RevistaDigital.TieneRDS)
                                    if (userData.RevistaDigital.NoVolverMostrar)
                                    {
                                        if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.NoPopUp
                                            || userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Desactivo)
                                        {
                                            continue;
                                        }
                                        if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.SinRegistroDB)
                                        {
                                            permiso.ClaseMenuItem = "oculto";
                                            userData.ClaseLogoSB = "";
                                        }
                                    }
                                    else
                                    {
                                        permiso.ClaseMenuItem = "oculto";
                                        userData.ClaseLogoSB = "";
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

                    lstModel.Add(permiso);

                    continue;
                }
                #endregion

                lstModel.Add(permiso);
            }

            lstModel = lstModel.Where(m => m.Codigo != Constantes.MenuCodigo.RevistaDigitalShowRoom.ToLower()).ToList();

            if (lstModel.Any(m => m.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower()))
            {
                var menuRd = lstModel.Find(m => m.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower());
                lstModel.ForEach(m =>
                m.UrlImagen = m.Codigo != Constantes.MenuCodigo.RevistaShowRoom.ToLower() || menuRd.ClaseMenuItem == "oculto"
                    ? m.UrlImagen : ""
                );
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

                if (menu.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
                {
                    if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                        if (!ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
                            continue;
                }

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

                if (menu.Codigo.ToLower() == Constantes.MenuCodigo.RevistaShowRoom.ToLower())
                {
                    if (sessionManager.GetEsShowRoom())
                    {
                        menu.OnClickFunt = "";
                        menu.MenuPadreDescripcion = menu.Descripcion;
                        if (sessionManager.GetMostrarShowRoomProductos())
                        {
                            menu.ClaseMenu = " etiqueta_showroom wsventa";
                        }
                        else
                        {
                            menu.ClaseMenu = " etiqueta_showroom wsintriga";
                        }

                        menu.UrlImagen = "";
                        menu.UrlItem = AccionControlador("sr", false, true);
                    }
                    else
                    {
                        continue;
                    }
                }
                else if (menu.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
                {
                    if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                        if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
                            if (userData.RevistaDigital.NoVolverMostrar)
                            {
                                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.NoPopUp
                                    || userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Desactivo)
                                {
                                    continue;
                                }
                                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.SinRegistroDB)
                                {
                                    menu.ClaseMenuItem = "oculto";
                                }
                            }
                            else
                            {
                                menu.ClaseMenuItem = "oculto";
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
                        if (ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                            continue;
                    }

                    item.SubMenu.Add(subItem);
                }
            }

            lstModel = lstModel.Where(m => m.Codigo != Constantes.MenuCodigo.RevistaDigitalShowRoom.ToLower()).ToList();

            if (lstModel.Any(m => m.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower()))
            {
                var menuRd = lstModel.Find(m => m.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower());
                if (menuRd.ClaseMenuItem != "oculto")
                {
                    var menuNego = lstModel.FirstOrDefault(m => m.Codigo == Constantes.MenuCodigo.MiNegocio.ToLower()) ?? new MenuMobileModel();
                    if (menuNego.MenuMobileID > 0)
                    {
                        lstModel.ForEach(m =>
                        {
                            m.OrdenItem = m.Codigo == Constantes.MenuCodigo.RevistaShowRoom.ToLower()
                                ? menuNego.OrdenItem + 1
                                : m.OrdenItem > menuNego.OrdenItem ? m.OrdenItem + 1 : m.OrdenItem;
                            m.UrlImagen = m.Codigo == Constantes.MenuCodigo.RevistaShowRoom.ToLower()
                                ? ""
                                : m.UrlImagen;
                        });

                        lstModel = lstModel.OrderBy(p => p.OrdenItem).ToList();
                    }
                }
            }

            userData.MenuMobile = lstModel;
            SetConsultoraOnlineViewBag(userData);
            return lstModel;
        }

        public List<ConfiguracionPaisModel> ObtenerMenuContenedor()
        {
            var menuActivo = MenuContenedorObtenerActivo();
            var listMenu = BuildMenuContenedor();
            listMenu = listMenu.Where(e => e.CampaniaId == menuActivo.CampaniaId).ToList();
            return listMenu;
        }

        /*
        * Retorna la lista de Menu vertical del contenedor en la campaña x
        */
        public List<ConfiguracionPaisModel> BuildMenuContenedor()
        {
            var listaMenu = (List<ConfiguracionPaisModel>)Session[Constantes.ConstSession.MenuContenedor] 
                ?? new List<ConfiguracionPaisModel>();
            if (listaMenu.Any()) return listaMenu;
            
            var lista = userData.ConfiguracionPais ?? new List<ConfiguracionPaisModel>(); ;
            if (!lista.Any()) return listaMenu;

            lista = lista.Where(c => c.TienePerfil).ToList();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            foreach (var confiModel in lista)
            {
                if (confiModel.Codigo == Constantes.ConfiguracionPais.ShowRoom)
                {
                    if (Session["EsShowRoom"] == null || (Session["EsShowRoom"] != null && Session["EsShowRoom"].ToString() != "1"))
                        continue;
                }

                if (confiModel.Codigo == Constantes.ConfiguracionPais.OfertaDelDia)
                {
                    if (!CumpleOfertaDelDia(userData))
                        continue;
                }

                var config = confiModel;
                config.Codigo = Util.Trim(confiModel.Codigo).ToUpper();
                config.MobileLogoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.MobileLogoBanner);
                config.DesktopLogoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.DesktopLogoBanner);
                config.MobileFondoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.MobileFondoBanner);
                config.DesktopFondoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.DesktopFondoBanner);
                config.UrlMenuMobile = "/Mobile/" + config.UrlMenu;
                config.EsAncla = config.UrlMenu?.Contains("#") ?? false;
                config.CampaniaId = userData.CampaniaID;

                if (config.Codigo == Constantes.ConfiguracionPais.RevistaDigitalSuscripcion
                    || config.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida
                    || config.Codigo == Constantes.ConfiguracionPais.RevistaDigital)
                {
                    BuilTituloBannerRD(ref config);
                    config.MobileTituloBanner = config.DesktopTituloBanner;
                    config.MobileSubTituloBanner = config.DesktopSubTituloBanner;
                }
                listaMenu.Add(config);
            }

            //List<ConfiguracionPaisModel> lista2 = new List<ConfiguracionPaisModel>();
            //lista2 = listaMenu.Where(m => (m.Codigo == Constantes.ConfiguracionPais.Inicio ||
            //                                    m.Codigo ==  Constantes.ConfiguracionPais.Lanzamiento ||
            //                                    m.Codigo == Constantes.ConfiguracionPais.RevistaDigital)).ToList();
            //lista2.ForEach(m => m.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1));
            listaMenu.AddRange(BuildMenuContenedor(listaMenu));
            listaMenu = listaMenu.OrderBy(m => m.Orden).ToList();
            Session[Constantes.ConstSession.MenuContenedor] = listaMenu;
            return listaMenu;
        }

        
        public List<ConfiguracionPaisModel> BuildMenuContenedor(List<ConfiguracionPaisModel> lista)
        {
            var listaMenu =  new List<ConfiguracionPaisModel>();
           foreach (var configuracionPais in lista)
            {
                ConfiguracionPaisModel config;
                switch (configuracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.Inicio:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/Ofertas/Revisar";
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
            
            if (userData.RevistaDigital.TieneRDC)
            {
                if (userData.RevistaDigital.SuscripcionModel.CampaniaID > userData.CampaniaID)
                    return;
                
                if (userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    confi.DesktopTituloBanner += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
                    confi.DesktopSubTituloBanner = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    return;
                }

                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                    {
                        confi.DesktopTituloBanner += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA";
                        confi.DesktopSubTituloBanner = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    }
                    else if (userData.RevistaDigital.SuscripcionModel.CampaniaID == AddCampaniaAndNumero(userData.CampaniaID, -1))
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

            if (userData.RevistaDigital.TieneRDS)
            {
                if (!userData.RevistaDigital.TieneRDR)
                {
                    if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
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
            else if (!userData.RevistaDigital.TieneRDR)
            {
                return;
            }
            
            confi.DesktopTituloBanner += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA";
            confi.DesktopSubTituloBanner = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
        }

        public MenuContenedorModel BuildMenuContenedorActivo()
        {
            var menu = new MenuContenedorModel();
            try
            {
                menu = MenuContenedorObtenerActivo();

                var listaMenus = ObtenerMenuContenedor();
                
                var configMenu = listaMenus.FirstOrDefault(m => m.Codigo == menu.Codigo && m.CampaniaId == menu.CampaniaId) ?? new ConfiguracionPaisModel();

                if (userData.RevistaDigital.TieneRDC)
                {
                    menu.CampaniaX0 = userData.CampaniaID;
                    menu.CampaniaX1 = AddCampaniaAndNumero(userData.CampaniaID, 1);
                }
                menu.ConfiguracionPais = configMenu;
                menu.Codigo = Util.Trim(menu.Codigo);
                //menu.LogoBanner = Util.Trim(menu.LogoBanner);
                //menu.FondoBanner = Util.Trim(menu.FondoBanner);
                //menu.TituloBanner = Util.Trim(menu.TituloBanner);
                //menu.SubTituloBanner = Util.Trim(menu.SubTituloBanner);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return menu;
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

        #region UserData        
        protected void SetUserData(UsuarioModel model)
        {
            Session["UserData"] = model;
        }

        public UsuarioModel UserData()
        {
            UsuarioModel model = null;
            string UrlEMTELCO = "";

            try
            {
                model = (UsuarioModel)Session["UserData"];
            }
            catch (Exception)
            {
                model = null;
            }

            try
            {
                UrlEMTELCO = ConfigurationManager.AppSettings["UrlBelcorpChat"];
            }
            catch (Exception)
            {
                UrlEMTELCO = "";
            }

            if (model == null)
            {
                return model;
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
            ViewBag.UrlBelcorpChat = String.Format(UrlEMTELCO, model.SegmentoAbreviatura.Trim(), model.CodigoUsuario.Trim(), model.PrimerNombre.Split(' ').First().Trim(), model.EMail.Trim(), model.CodigoISO.Trim());

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

            // ShowRoom (Mobile)

            #endregion Banner

            ViewBag.Efecto_TutorialSalvavidas = ConfigurationManager.AppSettings.Get("Efecto_TutorialSalvavidas") ?? "1";
            ViewBag.ModificarPedidoProl = model.NuevoPROL && model.ZonaNuevoPROL ? 0 : 1;
            ViewBag.TipoUsuario = model.TipoUsuario;
            ViewBag.MensajePedidoDesktop = userData.MensajePedidoDesktop;
            ViewBag.MensajePedidoMobile = userData.MensajePedidoMobile;

            #region RegaloPN
            ViewBag.ConsultoraTieneRegaloPN = false;
            if (model.ConsultoraRegaloProgramaNuevas != null)
            {
                ViewBag.ConsultoraTieneRegaloPN = true;
            }
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
                //
                model.BeShowRoomConsultora = null;
                model.BeShowRoom = null;
                //
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

            var model = userData.OfertasDelDia[0].Clone();
            model.ListaOfertas = userData.OfertasDelDia;
            int posicion = 0;
            model.ListaOfertas.Update(p => p.ID = posicion++);
            var listPedidosDetalles = ObtenerPedidoWebDetalle();
            foreach (var oferta in model.ListaOfertas) { oferta.Agregado = listPedidosDetalles.Any(d => d.CUV == oferta.CUV2) ? "block" : "none"; }

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

            model.BEShowRoomConsultora = userData.BeShowRoomConsultora?? new BEShowRoomEventoConsultora();
            model.BEShowRoom = userData.BeShowRoom?? new BEShowRoomEvento(); ;

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

            //if (userData.RevistaDigital.TieneRDR)
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
            if (ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
            {
                codigo = Constantes.TipoEstrategiaCodigo.RevistaDigital;
            }
            return codigo;
        }

        public bool ValidarPermiso(string codigo, string codigoConfig = "")
        {
            codigo = Util.Trim(codigo).ToLower();
            codigoConfig = Util.Trim(codigoConfig);

            var listaConfigPais = userData.ConfiguracionPais ?? new List<ConfiguracionPaisModel>();
            var existe = new ConfiguracionPaisModel();

            if (codigoConfig != "" && codigo == "")
            {
                existe = listaConfigPais.FirstOrDefault(c => c.Codigo == codigoConfig) ?? new ConfiguracionPaisModel();
                return !(existe.ConfiguracionPaisID == 0 || !existe.Estado);
            }

            if (codigo == "") return false;

            if (codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
            {
                existe = listaConfigPais.FirstOrDefault(c => c.Codigo == Constantes.ConfiguracionPais.RevistaDigital) ?? new ConfiguracionPaisModel();
                if (existe.ConfiguracionPaisID == 0 || !existe.Estado)
                {
                    existe = listaConfigPais.FirstOrDefault(c => c.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida) ?? new ConfiguracionPaisModel();
                    if (existe.ConfiguracionPaisID == 0 || !existe.Estado)
                    {
                        return false;
                    }
                }
                return true;
            }

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
                if (ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
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
            var url = string.Empty;

            url = HttpContext.Request.UrlReferrer != null ? 
                Util.Trim(HttpContext.Request.UrlReferrer.LocalPath).ToLower() : 
                Util.Trim(HttpContext.Request.FilePath).ToLower();

            return url.Contains("/mobile/");
        }

        public List<BETablaLogicaDatos> ObtenerParametrosTablaLogica(int paisID, short tablaLogicaId)
        {
            var datos = new List<BETablaLogicaDatos>();
            using (var svc = new SACServiceClient())
            {
                datos = svc.GetTablaLogicaDatos(paisID, tablaLogicaId).ToList();
            }
            return datos;
        }

        public string ObtenerValorTablaLogica(int paisID, short tablaLogicaId, short idTablaLogicaDatos)
        {
            return ObtenerValorTablaLogica(ObtenerParametrosTablaLogica(paisID, tablaLogicaId), idTablaLogicaDatos);
        }

        public string ObtenerValorTablaLogica(List<BETablaLogicaDatos> datos, short idTablaLogicaDatos)
        {
            var valor = "";
            if (datos.Any())
            {
                var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == idTablaLogicaDatos);
                if (par != null)
                {
                    valor = par.Codigo;
                }
            }
            return valor;
        }

        public MobileAppConfiguracionModel MobileAppConfiguracion
        {
            get
            {
                return Session["MobileAppConfiguracion"] == null
                    ? new MobileAppConfiguracionModel()
                    : (MobileAppConfiguracionModel)Session["MobileAppConfiguracion"];
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

        protected string GetPaisesEsikaFromConfig()
        {
            return ConfigurationManager.AppSettings.Get("PaisesEsika") ?? string.Empty;
        }

        #region Configuracion Seccion Palanca
        public List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion()
        {
            var menuActivo = MenuContenedorObtenerActivo();
            var sessionNombre = Constantes.ConstSession.ListadoSeccionPalanca + menuActivo.CampaniaId;
            if (menuActivo.CampaniaId <= 0)
            {
                menuActivo.CampaniaId = userData.CampaniaID;
                //MenuContenedorGuardar(menuActivo.Codigo, menuActivo.CampaniaId);
            }

            var listaEntidad = new List<BEConfiguracionOfertasHome>();

            if (Session[sessionNombre] != null)
            {
                listaEntidad = (List<BEConfiguracionOfertasHome>)Session[sessionNombre];
            }
            else
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    listaEntidad = sv.ListarSeccionConfiguracionOfertasHome(userData.PaisID, menuActivo.CampaniaId).ToList();
                }

                if (menuActivo.CampaniaId > userData.CampaniaID)
                {
                    listaEntidad = listaEntidad.Where(entConf => entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Inicio).ToList();
                }

                Session[sessionNombre] = listaEntidad;
            }

            var modelo = new List<ConfiguracionSeccionHomeModel>();

            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var isMobile = IsMobile();
            foreach (var entConf in listaEntidad)
            {
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
                }
                
                var seccion = new ConfiguracionSeccionHomeModel {
                    CampaniaID = menuActivo.CampaniaId,
                    Codigo = entConf.ConfiguracionPais.Codigo ?? entConf.ConfiguracionOfertasHomeID.ToString().PadLeft(5, '0'),
                    Orden = isMobile ? entConf.MobileOrden : entConf.DesktopOrden,
                    ImagenFondo = isMobile ? entConf.MobileImagenFondo : entConf.DesktopImagenFondo,
                    Titulo = isMobile ? entConf.MobileTitulo : entConf.DesktopTitulo,
                    SubTitulo = isMobile ? entConf.MobileSubTitulo : entConf.DesktopSubTitulo,
                    TipoPresentacion = isMobile ? entConf.MobileTipoPresentacion : entConf.DesktopTipoPresentacion,
                    TipoEstrategia = isMobile ? entConf.MobileTipoEstrategia : entConf.DesktopTipoEstrategia,
                    CantidadProductos = isMobile ? entConf.MobileCantidadProductos : entConf.DesktopCantidadProductos,
                    UrlLandig = "/" + (isMobile ? "Mobile/" : "") + entConf.UrlSeccion
                };

                switch (entConf.ConfiguracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.OfertasParaTi:
                        seccion.UrlObtenerProductos = "OfertasParaTi/ConsultarEstrategiasOPT";
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        seccion.UrlObtenerProductos = "RevistaDigital/RDObtenerProductos";
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        seccion.UrlObtenerProductos = "RevistaDigital/RDObtenerProductos";
                        break;
                    case Constantes.ConfiguracionPais.ShowRoom:
                        if (sessionManager.GetEsShowRoom() && 
                            !sessionManager.GetMostrarShowRoomProductos() && 
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            seccion.UrlObtenerProductos = "ShowRoom/PopupIntriga";
                        }

                        if (sessionManager.GetEsShowRoom() && 
                            sessionManager.GetMostrarShowRoomProductos() && 
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            seccion.UrlObtenerProductos = "ShowRoom/CargarProductosShowRoomOferta";
                        }
                        break;
                    case Constantes.ConfiguracionPais.OfertaDelDia:
                        //seccion.UrlObtenerProductos = "undefined";
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
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.Banners:
                        seccion.TemplatePresentacion = "seccion-banner";
                        seccion.Titulo = "";
                        seccion.SubTitulo = "";
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
                    default:
                        break;
                }

                if (seccion.TemplatePresentacion == "") continue;

                seccion.ImagenFondo = ConfigS3.GetUrlFileS3(carpetaPais, seccion.ImagenFondo);

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
        #endregion

        public MenuContenedorModel GetMenuActivo(string path)
        {
            var listMenu = BuildMenuContenedor();
            var menuActivo = new MenuContenedorModel();
            switch (path)
            {
                case  "/Ofertas":
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Inicio;
                    menuActivo.CampaniaId = userData.CampaniaID;
                    break;
                case "/Ofertas/Revisar":
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Inicio;
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    break;
                case "/RevistaDigital/Comprar":
                    menuActivo.Codigo = Constantes.ConfiguracionPais.RevistaDigital;
                    menuActivo.CampaniaId = userData.CampaniaID;
                    break;
                case "/RevistaDigital/Revisar":
                    menuActivo.Codigo = Constantes.ConfiguracionPais.RevistaDigital;
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    break;
                case "/RevistaDigital/Informacion":
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Informacion;
                    menuActivo.CampaniaId = 0;
                    break;
                case "/RevistaDigital":
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Inicio;
                    menuActivo.CampaniaId = userData.CampaniaID;
                    break;
            }
            var configMenu =
                listMenu.FirstOrDefault(m => m.Codigo == menuActivo.Codigo && m.CampaniaId == menuActivo.CampaniaId);
            if(menuActivo.Codigo == Constantes.ConfiguracionPais.Informacion)
                configMenu = listMenu.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.Inicio && m.CampaniaId == userData.CampaniaID);

            if (configMenu == null)
            {
                // Implementar las funciones por defecto
                configMenu = new ConfiguracionPaisModel();
            }
            menuActivo.ConfiguracionPais = configMenu;
            if (userData.RevistaDigital.TieneRDC)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
                menuActivo.CampaniaX1 = AddCampaniaAndNumero(userData.CampaniaID, 1);
            }
            Session[Constantes.ConstSession.MenuContenedorActivo] = menuActivo;


            return menuActivo;
        }

        //public void MenuContenedorGuardar(string codigo, int campania)
        //{
        //    Session[Constantes.ConstSession.MenuContenedorActivo] = new MenuContenedorModel
        //    {
        //        CampaniaId = campania,
        //        Codigo = Util.Trim(codigo) ?? Constantes.ConfiguracionPais.Inicio 
        //    };
        //}

        public MenuContenedorModel MenuContenedorObtenerActivo()
        {
            var menu = (MenuContenedorModel)Session[Constantes.ConstSession.MenuContenedorActivo] ?? new MenuContenedorModel();

            //menu.Codigo = Util.Trim(menu.Codigo);
            //if (menu.CampaniaId <= 0)
            //{
            //    menu.CampaniaId = menu.CampaniaId > 0 ? menu.CampaniaId : userData.CampaniaID;
            //    menu.Codigo = menu.Codigo == "" ? Constantes.ConfiguracionPais.Inicio : menu.Codigo;
            //}
            return menu;
        }

        #region Revista Digital 

        public bool RDObtenerTitulosSeccion(ref string titulo, ref string subtitulo, string codigo)
        {
            if (codigo == Constantes.ConfiguracionPais.RevistaDigital)
            {
                if (!userData.RevistaDigital.TieneRDC) return false;
            }

            if (codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida)
            {
                if (!userData.RevistaDigital.TieneRDR) return false;
            }

            titulo = "OFERTAS ÉSIKA PARA MÍ";
            subtitulo = userData.Sobrenombre.ToUpper() + ", PRUEBA LAS VENTAJAS DE COMPRAR OFERTAS PERSONALIZADAS";

            if (codigo == Constantes.ConfiguracionPais.OfertasParaTi)
            {
                if (userData.RevistaDigital.TieneRDC) return false;
                if (userData.RevistaDigital.TieneRDR) return false;
                
                titulo = "OFERTAS PARA TI " + userData.Sobrenombre.ToUpper();
                subtitulo = "EXCLUSIVAS SÓLO POR WEB";
            }

            return true;
        }

        #endregion

    }
}

