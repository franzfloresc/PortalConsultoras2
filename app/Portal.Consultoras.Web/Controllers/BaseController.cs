using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.LogManager;
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
using System.Web.Configuration;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseController : Controller
    {
        #region Variables

        protected UsuarioModel userData;
        protected RevistaDigitalModel revistaDigital;
        protected GuiaNegocioModel guiaNegocio;
        protected ISessionManager sessionManager;
        protected ILogManager logManager;

        #endregion

        #region Constructor

        public BaseController()
        {
            userData = new UsuarioModel();
            logManager = LogManager.LogManager.Instance;
            sessionManager = SessionManager.SessionManager.Instance;
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
                    string urlSignOut = ObtenerUrlCerrarSesion();

                    filterContext.Result = new RedirectResult(urlSignOut);
                    return;
                }

                revistaDigital = sessionManager.GetRevistaDigital();
                guiaNegocio = sessionManager.GetGuiaNegocio();

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
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            finally
            {
                pedidoWeb = pedidoWeb ?? new BEPedidoWeb();
                sessionManager.SetPedidoWeb(pedidoWeb);
            }

            return pedidoWeb;
        }

        protected int EsOpt()
        {
            var esOpt = revistaDigital.TieneRDR
                    || revistaDigital.TieneRDC && revistaDigital.EsActiva
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
                        var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                        {
                            PaisId = userData.PaisID,
                            CampaniaId = userData.CampaniaID,
                            ConsultoraId = userData.ConsultoraID,
                            Consultora = userData.NombreConsultora,
                            EsBpt = EsOpt() == 1,
                            CodigoPrograma = userData.CodigoPrograma,
                            NumeroPedido = userData.ConsecutivoNueva
                        };

                        detallesPedidoWeb = pedidoServiceClient.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                    }
                }

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

        protected List<BEPedidoWebDetalle> PedidoConObservaciones(List<BEPedidoWebDetalle> pedido, List<ObservacionModel> observaciones)
        {
            var pedObs = pedido;
            var txtBuil = new StringBuilder();

            if (userData.NuevoPROL && userData.ZonaNuevoPROL)
            {
                foreach (var item in pedObs)
                {
                    item.Mensaje = string.Empty;
                    var temp = observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp.Count != 0)
                    {
                        if (temp[0].Caso == 0)
                        {
                            item.ClaseFila = string.Empty;
                            item.TipoObservacion = 0;
                        }
                        else
                        {
                            item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                            item.TipoObservacion = temp[0].Tipo;
                        }

                        foreach (var ob in temp)
                        {
                            txtBuil.Append(ob.Descripcion + "<br/>");
                        }
                        item.Mensaje = txtBuil.ToString();
                        txtBuil.Clear();
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                    }
                }
            }
            else
            {
                foreach (var item in pedObs)
                {
                    item.Mensaje = string.Empty;
                    var temp = observaciones.Where(o => o.CUV == item.CUV).ToList();
                    if (temp.Count != 0)
                    {
                        item.ClaseFila = temp[0].Tipo == 1 ? "f1" : "f2";
                        item.TipoObservacion = temp[0].Tipo;
                        foreach (var ob in temp)
                        {
                            txtBuil.Append(ob.Descripcion + "<br/>");
                        }
                        item.Mensaje = txtBuil.ToString();
                        txtBuil.Clear();
                    }
                    else
                    {
                        item.ClaseFila = string.Empty;
                        item.TipoObservacion = 0;
                    }
                }
            }
            return pedObs.OrderByDescending(p => p.TipoObservacion).ToList();
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

                var ambiente = GetConfiguracionManager(Constantes.ConfiguracionManager.Ambiente);
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
                    mensaje = "Se sessión expiró, por favor vuelva a loguearse.";
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
            var consultoraId = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID;

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
                if (userData.TieneValidacionMontoMaximo)
                {
                    if (userData.MontoMaximo != Convert.ToDecimal(9999999999.00))
                    {
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

        public List<PermisoModel> BuildMenu(UsuarioModel userData, RevistaDigitalModel revistaDigital)
        {
            if (userData.Menu != null)
            {
                ViewBag.ClaseLogoSB = userData.ClaseLogoSB;
                return SepararItemsMenu(userData.Menu);
            }

            var permisos = GetPermisosByRol(userData.PaisID, userData.RolID);

            if (!GetMostrarOpcionClienteOnline(userData.CodigoISO) &&
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
                    permiso.EsSoloImagen = true;
                    permiso.UrlImagen = GetUrlImagenMenuOfertas(userData, revistaDigital);
                }

                if (permiso.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower() &&
                    (revistaDigital.TieneRDC || revistaDigital.TieneRDR))
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

                        if (permiso.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower()
                            && (revistaDigital.TieneRDC || revistaDigital.TieneRDR))
                        {
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

        private bool GetMostrarOpcionClienteOnline(string codigoIso)
        {
            return GetMostrarPedidosPendientesFromConfig() && GetPaisesConConsultoraOnlineFromConfig().Contains(codigoIso);
        }

        protected virtual bool GetMostrarPedidosPendientesFromConfig()
        {
            var mostrarPedidoAppSetting = GetConfiguracionManager(Constantes.ConfiguracionManager.MostrarPedidosPendientes);

            return mostrarPedidoAppSetting == "1";
        }

        protected string GetPaisesConConsultoraOnlineFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.Permisos_CCC);
        }

        protected virtual string GetDefaultGifMenuOfertas()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.GIF_MENU_DEFAULT_OFERTAS);
        }

        public virtual string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
        {
            var urlImagen = string.Empty;
            var tieneRevistaDigital = revistaDigital.TieneRDC || revistaDigital.TieneRDR;
            var tieneEventoFestivoData = sessionManager.GetEventoFestivoDataModel() != null &&
                sessionManager.GetEventoFestivoDataModel().ListaGifMenuContenedorOfertas != null &&
                sessionManager.GetEventoFestivoDataModel().ListaGifMenuContenedorOfertas.Any();

            if (!tieneRevistaDigital)
            {
                urlImagen = GetDefaultGifMenuOfertas();
                urlImagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS, urlImagen);
                }
            }

            if (tieneRevistaDigital && !revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            if (tieneRevistaDigital && (revistaDigital.EsSuscrita || revistaDigital.EsActiva))
            {
                urlImagen = revistaDigital.LogoMenuOfertasActiva;
                urlImagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS, urlImagen);
                }
            }

            if (revistaDigital.TieneRDI)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
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


            if (!GetMostrarOpcionClienteOnline(userData.CodigoISO))
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
                        && (revistaDigital.TieneRDC || revistaDigital.TieneRDR))
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

        #endregion

        #region eventoFestivo        

        public string EventoFestivoPersonalizacionSegunNombre(string nombre, string valorBase = "")
        {
            var eventoFestivo = new EventoFestivoModel();
            try
            {
                eventoFestivo = sessionManager.GetEventoFestivoDataModel().ListaGifMenuContenedorOfertas.FirstOrDefault(p => p.Nombre == nombre) ?? new EventoFestivoModel();
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
            sessionManager.SetUserData(model);
        }

        public UsuarioModel UserData()
        {
            UsuarioModel model;

            try
            {
                model = sessionManager.GetUserData();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "UserData - sessionManager.GetUserData()");
                model = null;
            }

            if (model == null)
                return new UsuarioModel();

            #region Cargar variables

            if (!model.CargoEntidadesShowRoom) CargarEntidadesShowRoom(model);

            model.UsuarioNombre = string.IsNullOrEmpty(model.Sobrenombre) ? model.NombreConsultora : model.Sobrenombre;

            model.FechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
            model.EsDiasFacturacion = model.FechaHoy >= model.FechaInicioCampania.Date && model.FechaHoy <= model.FechaFinCampania.Date;

            model.MenuNotificaciones = 1;

            #endregion

            return model;
        }

        private bool CumpleOfertaDelDia()
        {
            var result = false;
            if (!NoMostrarBannerODD())
            {
                result = (!userData.TieneOfertaDelDia ||
                          (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2 || userData.IndicadorGPRSB == 0)
                          && !userData.CloseOfertaDelDia) && userData.TieneOfertaDelDia;
            }

            return result;
        }

        private string GetFormatDecimalPais(string isoPais)
        {
            var listaPaises = GetConfiguracionManager(Constantes.ConfiguracionManager.KeyPaisFormatDecimal);
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
            List<BEProductoFaltante> olstProductoFaltante;
            using (var sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(userData.PaisID, userData.CampaniaID, userData.ZonaID, cuv, descripcion).ToList();
            }
            return olstProductoFaltante ?? new List<BEProductoFaltante>();
        }

        private string NombreCampania(string campania)
        {
            var result = campania;
            campania = Util.Trim(campania);
            if (campania.Length == 6)
                result = string.Format("Campaña {0}", campania.Substring(4, 2));
            return result;
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
            if (string.IsNullOrEmpty(codigoIsoPais))
                return false;

            var paisesShowRoom = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesShowRoom);
            var tieneShowRoom = paisesShowRoom.Contains(codigoIsoPais);
            return tieneShowRoom;
        }

        protected int ObtenerNivelId(List<BEShowRoomNivel> niveles)
        {
            var showRoomNivelPais = niveles.FirstOrDefault(p => p.Codigo == "PAIS") ??
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

            List<BEFichaProducto> listFichaProducto;
            using (var sv = new PedidoServiceClient())
            {
                listFichaProducto = sv.GetFichaProducto(entidad).ToList();
            }

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

            listaProductoModel.ForEach(fichaProducto =>
            {
                var prodModel = new FichaProductoDetalleModel
                {
                    CampaniaID = fichaProducto.CampaniaID,
                    EstrategiaID = fichaProducto.EstrategiaID,
                    CUV2 = fichaProducto.CUV2,
                    TipoEstrategiaImagenMostrar = fichaProducto.TipoEstrategiaImagenMostrar,
                    CodigoEstrategia = fichaProducto.TipoEstrategia.Codigo,
                    CodigoVariante = fichaProducto.CodigoEstrategia,
                    FotoProducto01 = fichaProducto.FotoProducto01,
                    ImagenURL = fichaProducto.ImagenURL,
                    DescripcionMarca = fichaProducto.DescripcionMarca,
                    DescripcionResumen = fichaProducto.DescripcionResumen,
                    DescripcionCortada = fichaProducto.DescripcionCortada,
                    DescripcionDetalle = fichaProducto.DescripcionDetalle,
                    DescripcionCompleta = fichaProducto.DescripcionCUV2.Split('|')[0],
                    Simbolo = userData.Simbolo,
                    Precio = fichaProducto.Precio,
                    Precio2 = fichaProducto.Precio2,
                    PrecioTachado = fichaProducto.PrecioTachado,
                    PrecioVenta = fichaProducto.PrecioString,
                    //prodModel.ClaseBloqueada = (fichaProducto.CampaniaID > 0 && fichaProducto.CampaniaID != userData.CampaniaID) ? "btn_desactivado_general" : "";
                    ProductoPerdio = false,
                    TipoEstrategiaID = fichaProducto.TipoEstrategiaID,
                    FlagNueva = fichaProducto.FlagNueva,
                    IsAgregado = listaPedido.Any(p => p.CUV == fichaProducto.CUV2.Trim()),
                    ArrayContenidoSet = fichaProducto.FlagNueva == 1 ? fichaProducto.DescripcionCUV2.Split('|').Skip(1).ToList() : new List<string>(),
                    ListaDescripcionDetalle = fichaProducto.ListaDescripcionDetalle ?? new List<string>(),
                    TextoLibre = Util.Trim(fichaProducto.TextoLibre),

                    MarcaID = fichaProducto.MarcaID,
                    UrlCompartir = fichaProducto.UrlCompartir,

                    TienePaginaProducto = fichaProducto.PuedeVerDetalle,
                    TienePaginaProductoMob = fichaProducto.PuedeVerDetalleMob,
                    TieneVerDetalle = true,

                    TipoAccionAgregar = fichaProducto.TieneVariedad == 0 ? fichaProducto.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas ? 1 : 2 : 3,
                    LimiteVenta = fichaProducto.LimiteVenta
                };
                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        public List<FichaProductoModel> FichaProductoModelFormato(List<BEFichaProducto> listaProducto)
        {
            listaProducto = listaProducto ?? new List<BEFichaProducto>();
            var listaProductoModel = Mapper.Map<List<BEFichaProducto>, List<FichaProductoModel>>(listaProducto);
            return FichaProductoModelFormato(listaProductoModel);
        }

        public List<FichaProductoModel> FichaProductoModelFormato(List<FichaProductoModel> listaProductoModel)
        {
            if (!listaProductoModel.Any())
                return listaProductoModel;

            var listaPedido = ObtenerPedidoWebDetalle();

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
                }

                ficha.ImagenURL = ficha.FlagMostrarImg == 1 ? "/Content/Images/oferta-ultimo-minuto.png" : "";

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
                if (ficha.TieneVariedad == 0 && ficha.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas)
                    ficha.PuedeCambiarCantidad = 0;

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
                    return null;

                fichaProductoModelo.Hermanos = new List<ProductoModel>();
                fichaProductoModelo.TextoLibre = Util.Trim(fichaProductoModelo.TextoLibre);
                fichaProductoModelo.CodigoVariante = Util.Trim(fichaProductoModelo.CodigoVariante);
                fichaProductoModelo.UrlCompartir = GetUrlCompartirFB();

                var listaPedido = ObtenerPedidoWebDetalle();
                fichaProductoModelo.IsAgregado = listaPedido.Any(p => p.CUV == fichaProductoModelo.CUV2);

                if (fichaProductoModelo.CodigoVariante == "")
                    return fichaProductoModelo;

                string separador = "|";
                var txtBuil = new StringBuilder();
                txtBuil.Append(separador);

                fichaProductoModelo.CampaniaID = fichaProductoModelo.CampaniaID > 0 ? fichaProductoModelo.CampaniaID : userData.CampaniaID;

                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    List<BEProducto> listaHermanosE;
                    using (var svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, fichaProductoModelo.CampaniaID, fichaProductoModelo.CUV2).ToList();
                    }

                    foreach (var item in listaHermanosE)
                    {
                        item.CodigoSAP = Util.Trim(item.CodigoSAP);
                        if (item.CodigoSAP != "" && !txtBuil.ToString().Contains(separador + item.CodigoSAP + separador))
                            txtBuil.Append(item.CodigoSAP + separador);
                    }
                }

                var listaProducto = new List<BEEstrategiaProducto>();
                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    var estrategiaX = new EstrategiaPedidoModel() { PaisID = userData.PaisID, EstrategiaID = fichaProductoModelo.EstrategiaID };
                    using (var svc = new PedidoServiceClient())
                    {
                        listaProducto = svc.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, BEEstrategia>(estrategiaX)).ToList();
                    }

                    foreach (var item in listaProducto)
                    {
                        item.SAP = Util.Trim(item.SAP);
                        if (item.SAP != "" && !txtBuil.ToString().Contains(separador + item.SAP + separador))
                            txtBuil.Append(item.SAP + separador);
                    }
                }

                string joinCuv = txtBuil.ToString();

                if (joinCuv == separador) return fichaProductoModelo;

                joinCuv = joinCuv.Substring(separador.Length, joinCuv.Length - separador.Length * 2);

                List<Producto> listaAppCatalogo;
                using (var svc = new ProductoServiceClient())
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
                        ProductoModel hermano;
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
                        for (var i = 0; i < hermano.FactorCuadre - 1; i++)
                        {
                            listaHermanosCuadre.Add((ProductoModel)hermano.Clone());
                        }
                    }
                }

                #endregion

                fichaProductoModelo.Hermanos = listaHermanosCuadre;
            }
            catch (Exception ex)
            {
                fichaProductoModelo = new FichaProductoDetalleModel
                {
                    Hermanos = new List<ProductoModel>()
                };
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
            var ambiente = GetConfiguracionManager(Constantes.ConfiguracionManager.Ambiente);
            var pais = UserData().CodigoISO;
            var key = ambiente.Trim().ToUpper() + "_Prol_" + pais.Trim().ToUpper();
            return ConfigurationManager.AppSettings[key];
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

        protected int AddCampaniaAndNumero(int campania, int numero)
        {
            return Util.AddCampaniaAndNumero(campania, numero, userData.NroCampanias);
        }

        public string FormatearHora(TimeSpan hora)
        {
            var tiempo = DateTime.Today.Add(hora);
            var displayTiempo = tiempo.ToShortTimeString().Replace(".", " ").Replace(" ", "");
            displayTiempo = displayTiempo.Insert(displayTiempo.Length == 6 ? 4 : 5, " ");

            return displayTiempo;
        }

        public BarraConsultoraModel GetDataBarra(bool inEscala = true, bool inMensaje = false)
        {
            var objR = new BarraConsultoraModel
            {
                ListaEscalaDescuento = new List<BarraConsultoraEscalaDescuentoModel>(),
                ListaMensajeMeta = new List<BEMensajeMetaConsultora>()
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

            if (Session["ListadoEstadoCuenta"] == null)
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

                Session["ListadoEstadoCuenta"] = lst;
            }
            else
            {
                lst = Session["ListadoEstadoCuenta"] as List<EstadoCuentaModel>;
            }

            return lst;
        }

        public string GetFechaPromesaEntrega(int paisId, int campaniaId, string codigoConsultora, DateTime fechaFact)
        {
            var sFecha = Convert.ToDateTime("2000-01-01").ToString();
            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    sFecha = sv.GetFechaPromesaCronogramaByCampania(paisId, campaniaId, codigoConsultora, fechaFact);
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
            DateTime hoy;

            using (var svc = new SACServiceClient())
            {
                hoy = svc.GetFechaHoraPais(model.PaisID);
            }

            var d1 = new DateTime(hoy.Year, hoy.Month, hoy.Day, 0, 0, 0);
            DateTime d2;

            if (model.EsDiasFacturacion)
            {
                var t1 = model.HoraCierreZonaNormal;
                d2 = new DateTime(hoy.Year, hoy.Month, hoy.Day, t1.Hours, t1.Minutes, t1.Seconds);
            }
            else
            {
                d2 = d1.AddDays(1);
            }

            var t2 = (d2 - hoy);
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
            model.ListaOfertas = userData.OfertasDelDia;
            short posicion = 1;
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
            model.BEShowRoom = userData.BeShowRoom ?? new BEShowRoomEvento();

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

            var diasFalta = userData.FechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes) - fechaHoy;
            model.DiasFalta = diasFalta.Days;
            model.DiasFaltantes = diasFalta.Days;

            model.MesFaltante = userData.FechaInicioCampania.Month;
            model.AnioFaltante = userData.FechaInicioCampania.Year;


            foreach (var item in userData.ListaShowRoomPersonalizacionConsultora)
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

        #region Catalogos y Revistas Issuu

        protected string GetRevistaCodigoIssuu(string campania)
        {
            string codigo = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;

            var zonas = GetConfiguracionManager(Constantes.ConfiguracionManager.RevistaPiloto_Zonas + userData.CodigoISO + campania);
            var esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
            if (esRevistaPiloto) codigo = GetConfiguracionManager(Constantes.ConfiguracionManager.RevistaPiloto_Codigo + userData.CodigoISO + campania);
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = GetConfiguracionManager(Constantes.ConfiguracionManager.CodigoRevistaIssuu);

            if (campania.Length >= 6)
                nroCampania = campania.Substring(4, 2);
            if (campania.Length >= 6)
                anioCampania = campania.Substring(0, 4);
            return string.Format(codigo, userData.CodigoISO.ToLower(), nroCampania, anioCampania);
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
            var zonas = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Zonas_" + userData.CodigoISO + campania] ?? "";
            var esCatalogoPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
            if (esCatalogoPiloto) codigo = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + userData.CodigoISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = GetConfiguracionManager(Constantes.ConfiguracionManager.CodigoCatalogoIssuu);
            return string.Format(codigo, nombreCatalogoIssuu, GetPaisNombreByISO(userData.CodigoISO), campania.Substring(4, 2), campania.Substring(0, 4));
        }

        protected string GetPaisNombreByISO(string paisISO)
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

        protected IEnumerable<RegionModel> DropDownListRegiones(int paisId)
        {
            IList<BERegion> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllRegiones(paisId);
            }
            return Mapper.Map<IList<BERegion>, IEnumerable<RegionModel>>(lst.OrderBy(zona => zona.Codigo).ToList());
        }

        protected IEnumerable<ZonaModel> DropDownListZonas(int paisId)
        {
            IList<BEZona> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllZonas(paisId);
            }
            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lst);
        }

        public JsonResult ObtenerZonasByRegion(int paisId, int regionId)
        {
            var listaZonas = DropDownListZonas(paisId);
            if (regionId > -1) listaZonas = listaZonas.Where(x => x.RegionID == regionId).ToList();
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


                var urlApi = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);

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
                model.CuerpoDetalles.Add(string.Format("Tener una <b>deuda</b> de {0} {1}", userData.Simbolo, Util.DecimalToStringFormat(deuda.FirstOrDefault().Valor, userData.CodigoISO)));
                model.CuerpoMensaje2 = "Te invitamos a <b>cancelar</b> el saldo pendiente y <b>reservar</b> tu pedido el día de hoy para que sea facturado exitosamente.";
                model.MotivoRechazo = Constantes.GPRMotivoRechazo.ActualizacionDeuda;
            }
        }

        #endregion

        protected int GetDiasFaltantesFacturacion(DateTime fechaInicioCampania, double zonaHoraria)
        {
            var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;
            return fechaHoy >= fechaInicioCampania.Date ? 0 : (fechaInicioCampania.Subtract(DateTime.Now.AddHours(zonaHoraria)).Days + 1);
        }

        public string GetUrlCompartirFB()
        {
            var urlBaseFb = "";
            if (System.Web.HttpContext.Current.Request.UserAgent != null)
            {
                var request = HttpContext.Request;
                if (request.Url != null)
                    urlBaseFb = request.Url.Scheme + "://" + request.Url.Authority + "/Pdto.aspx?id=" +
                                userData.CodigoISO + "_[valor]";
            }
            return urlBaseFb;
        }

        public string GetUrlCompartirFBSR(int ofertaShowRoomId)
        {
            var urlBaseFb = "";
            if (System.Web.HttpContext.Current.Request.UserAgent != null)
            {
                var request = HttpContext.Request;
                if (request.Url != null)
                    urlBaseFb = request.Url.Scheme + "://" + request.Url.Authority + "/Set.aspx?id=" +
                                userData.CodigoISO + "_" + ofertaShowRoomId.ToString() + "_" +
                                userData.CampaniaID.ToString() + "_F";
            }
            return urlBaseFb;
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
            var controllerName = ControllerContext.RouteData.Values["controller"].ToString();
            switch (controllerName)
            {
                case "OfertaLiquidacion":
                    return true;
                case "CatalogoPersonalizado":
                    return true;
                case "ShowRoom":
                    return true;
                default:
                    return false;
            }
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
            var url = HttpContext.Request.UrlReferrer != null ?
                Util.Trim(HttpContext.Request.UrlReferrer.LocalPath).ToLower() :
                Util.Trim(HttpContext.Request.FilePath).ToLower();
            url = url.Replace("#", "/") + "/";
            return url.Contains("/mobile/") || url.Contains("/g/");
        }

        public List<BETablaLogicaDatos> ObtenerParametrosTablaLogica(int paisId, short tablaLogicaId, bool sesion = false)
        {
            var datos = sesion ? (List<BETablaLogicaDatos>)Session[Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()] : null;
            if (datos == null)
            {
                using (var sv = new SACServiceClient())
                {
                    datos = sv.GetTablaLogicaDatos(paisId, tablaLogicaId).ToList();
                }

                if (sesion)
                    Session[Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()] = datos;
            }

            return datos;
        }

        public string ObtenerValorTablaLogica(int paisId, short tablaLogicaId, short idTablaLogicaDatos, bool sesion = false)
        {
            return ObtenerValorTablaLogica(ObtenerParametrosTablaLogica(paisId, tablaLogicaId, sesion), idTablaLogicaDatos);
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
            }

            return origenActual;
        }

        #region CDR
        protected string MensajeGestionCdrInhabilitadaYChatEnLinea()
        {
            var mensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitada();
            if (string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return mensajeGestionCdrInhabilitada;
            return mensajeGestionCdrInhabilitada + " " + Constantes.CdrWebMensajes.ContactateChatEnLinea;
        }

        protected string MensajeGestionCdrInhabilitada()
        {
            if (userData.EsCDRWebZonaValida == 0) return Constantes.CdrWebMensajes.ZonaBloqueada;
            if (userData.IndicadorBloqueoCDR == 1) return Constantes.CdrWebMensajes.ConsultoraBloqueada;
            if (CumpleRangoCampaniaCDR() == 0) return Constantes.CdrWebMensajes.SinPedidosDisponibles;

            var diasFaltantes = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            if (diasFaltantes == 0) return Constantes.CdrWebMensajes.FueraDeFecha;

            var cdrDiasAntesFacturacion = 0;
            var cdrWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.DiasAntesFacturacion);
            if (cdrWebDatos != null) int.TryParse(cdrWebDatos.Valor, out cdrDiasAntesFacturacion);
            if (diasFaltantes <= cdrDiasAntesFacturacion) return Constantes.CdrWebMensajes.FueraDeFecha;

            return string.Empty;
        }

        private int CumpleRangoCampaniaCDR()
        {
            var listaMotivoOperacion = CargarMotivoOperacion();
            // get max dias => plazo para hacer reclamo
            // calcular las campañas existentes en ese rango de dias
            // obtener todos pedidos facturados de esas campañas existentes

            var maxDias = 0;
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

                List<BEPedidoWeb> listaPedidoFacturados;
                using (var sv = new PedidoServiceClient())
                {
                    listaPedidoFacturados = sv.GetPedidosFacturadoSegunDias(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, maxDias).ToList();
                }

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

                List<BECDRWebMotivoOperacion> listaMotivoOperacion;
                using (var sv = new CDRServiceClient())
                {
                    listaMotivoOperacion = sv.GetCDRWebMotivoOperacion(userData.PaisID, new BECDRWebMotivoOperacion()).ToList();
                }

                var diasFaltantes = 0;
                var cdrWebDatos = ObtenerCdrWebDatosByCodigo(Constantes.CdrWebDatos.ValidacionDiasFaltante);
                if (cdrWebDatos != null) int.TryParse(cdrWebDatos.Valor, out diasFaltantes);

                if (diasFaltantes > 0)
                {
                    var operacionFaltanteList = new List<string> { "F", "G" };
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

                List<BECDRWebDatos> lista;
                var entidad = new BECDRWebDatos();
                using (var sv = new CDRServiceClient())
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

                List<BECDRWebDetalle> lista;
                var entidad = new BECDRWebDetalle { CDRWebID = model.CDRWebID };
                using (var sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDetalle(userData.PaisID, entidad, model.PedidoID).ToList();
                }

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
                    var add = new BECDRMotivoReclamo
                    {
                        CodigoReclamo = item.CodigoReclamo,
                        DescripcionReclamo = desc.Descripcion
                    };
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
            var fechaSys = userData.FechaActualPais.Date;
            var fechaFinCampania = pedido.FechaRegistro.Date;
            var diferencia = fechaSys - fechaFinCampania;
            var differenceInDays = diferencia.Days;

            if (differenceInDays <= 0) return new List<BECDRWebMotivoOperacion>();

            var listaMotivoOperacion = CargarMotivoOperacion();
            var listaFiltro = listaMotivoOperacion.Where(mo => mo.CDRTipoOperacion.NumeroDiasAtrasOperacion >= differenceInDays).ToList();
            return listaFiltro.OrderBy(p => p.Prioridad).ToList();
        }

        protected BECDRWebDescripcion ObtenerDescripcion(string codigoSsic, string tipo)
        {
            codigoSsic = Util.SubStr(codigoSsic, 0);
            tipo = Util.SubStr(tipo, 0);
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

                List<BECDRWebDescripcion> lista;
                var entidad = new BECDRWebDescripcion();
                using (var sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDescripcion(userData.PaisID, entidad).ToList();
                }

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

            var maxDias = 0;
            if (listaMotivoOperacion.Any())
            {
                maxDias += int.Parse(listaMotivoOperacion.Max(m => m.CDRTipoOperacion.NumeroDiasAtrasOperacion).ToString());
            }

            var listaPedidoFacturados = CargarPedidosFacturados(maxDias);

            var listaCampanias = new List<CampaniaModel>();
            var campania = new CampaniaModel
            {
                CampaniaID = 0,
                NombreCorto = "¿En qué campaña lo solicitaste?"
            };
            listaCampanias.Add(campania);
            foreach (var facturado in listaPedidoFacturados)
            {
                var existe = listaCampanias.Where(c => c.CampaniaID == facturado.CampaniaID) ?? new List<CampaniaModel>();
                if (!existe.Any())
                {
                    campania = new CampaniaModel
                    {
                        CampaniaID = facturado.CampaniaID,
                        NombreCorto = facturado.CampaniaID.ToString()
                    };
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

                List<BECDRParametria> lista;
                var entidad = new BECDRParametria();
                using (var sv = new CDRServiceClient())
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
            List<BECDRWeb> entidadLista;
            try
            {
                if (Session[Constantes.ConstSession.CDRWeb] != null)
                {
                    return (List<BECDRWeb>)Session[Constantes.ConstSession.CDRWeb];
                }

                var entidad = new BECDRWeb
                {
                    CampaniaID = model.CampaniaID,
                    PedidoID = model.PedidoID,
                    ConsultoraID = int.Parse(userData.ConsultoraID.ToString())
                };

                using (var sv = new CDRServiceClient())
                {
                    entidadLista = sv.GetCDRWeb(userData.PaisID, entidad).ToList();
                }

                Session[Constantes.ConstSession.CDRWeb] = null;
                if (entidadLista.Count == 1)
                {
                    Session[Constantes.ConstSession.CDRWeb] = entidadLista;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRWeb] = null;
                entidadLista = new List<BECDRWeb>();
            }

            return entidadLista;
        }
        #endregion

        protected string GetPaisesEsikaFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesEsika);
        }

        #region Configuracion Seccion Palanca
        public List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion()
        {
            var menuActivo = GetSessionMenuActivo();

            if (menuActivo.CampaniaId <= 0)
                menuActivo.CampaniaId = userData.CampaniaID;

            var sessionNombre = Constantes.ConstSession.ListadoSeccionPalanca + menuActivo.CampaniaId;

            List<BEConfiguracionOfertasHome> listaEntidad;

            if (Session[sessionNombre] != null)
            {
                listaEntidad = (List<BEConfiguracionOfertasHome>)Session[sessionNombre];
            }
            else
            {
                #region  Obtenido de la cache de Amazon

                using (var sv = new SACServiceClient())
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

                #region Pre Validacion

                if (entConf.ConfiguracionPais.Codigo != "")
                {
                    var configPis = ConfiguracionPaisObtener(entConf.ConfiguracionPais.Codigo);
                    if (!configPis.Excluyente && configPis.ConfiguracionPaisID <= 0)
                    {
                        continue;
                    }
                }

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
                else if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
                {
                    if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR) continue;

                    if (menuActivo.CampaniaId != userData.CampaniaID) entConf.UrlSeccion = "Revisar/" + entConf.UrlSeccion;
                }

                #endregion

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

                seccion.TituloBtnAnalytics = seccion.Titulo.Replace("'", "");
                seccion.ImagenFondo = ConfigS3.GetUrlFileS3(carpetaPais, seccion.ImagenFondo);

                #region ConfiguracionPais.Codigo

                switch (entConf.ConfiguracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                        if (!GNDValidarAcceso())
                            continue;

                        seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + "GuiaNegocio";
                        seccion.UrlObtenerProductos = "";
                        break;
                    case Constantes.ConfiguracionPais.OfertasParaTi:
                        seccion.UrlObtenerProductos = "OfertasParaTi/ConsultarEstrategiasOPT";
                        seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor : Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedor;
                        seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedorPopup : Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedorPopup;
                        seccion.VerMas = false;
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        seccion.UrlObtenerProductos = "RevistaDigital/RDObtenerProductosLan";
                        seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor : Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedor;
                        seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup : Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedorPopup;
                        seccion.VerMas = false;
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + (menuActivo.CampaniaId > userData.CampaniaID ? "RevistaDigital/Revisar" : "RevistaDigital/Comprar");
                        seccion.UrlObtenerProductos = "RevistaDigital/RDObtenerProductos";
                        seccion.OrigenPedido = isMobile ? 0 : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedor;
                        seccion.OrigenPedidoPopup = isMobile ? 0 : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedorPopup;
                        break;
                    case Constantes.ConfiguracionPais.ShowRoom:
                        ConfiguracionSeccionShowRoom(ref seccion);
                        if (seccion.UrlLandig == "")
                            continue;

                        seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.DesktopShowRoomContenedor : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedor;
                        break;
                    case Constantes.ConfiguracionPais.OfertaDelDia:
                        if (!userData.TieneOfertaDelDia)
                            continue;
                        break;
                }
                #endregion

                #region TipoPresentacion

                seccion.TemplatePresentacion = "";
                seccion.TemplateProducto = "";
                switch (seccion.TipoPresentacion)
                {
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselSimple:
                        seccion.TemplatePresentacion = "seccion-simple-centrado";
                        seccion.TemplateProducto = "#producto-landing-template";
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselPrevisuales:
                        seccion.TemplatePresentacion = "seccion-carrusel-previsuales";
                        seccion.TemplateProducto = "#lanzamiento-carrusel-template";
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado:
                        seccion.TemplatePresentacion = "seccion-simple-centrado";
                        seccion.TemplateProducto = "#producto-landing-template";
                        seccion.CantidadMostrar = isMobile ? 1 : seccion.CantidadMostrar > 3 || seccion.CantidadMostrar <= 0 ? 3 : seccion.CantidadMostrar;
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.Banners:
                        seccion.TemplatePresentacion = "seccion-banner";
                        seccion.CantidadMostrar = 0;
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.ShowRoom:
                        seccion.TemplatePresentacion = "seccion-showroom";
                        seccion.TemplateProducto = "#template-showroom";
                        break;
                    case Constantes.ConfiguracionSeccion.TipoPresentacion.OfertaDelDia:
                        seccion.TemplatePresentacion = "seccion-oferta-del-dia";
                        break;

                    case Constantes.ConfiguracionSeccion.TipoPresentacion.DescagablesNavidenos:
                        seccion.TemplatePresentacion = "seccion-descargables-navidenos";
                        break;
                }

                if (seccion.TemplatePresentacion == "") continue;
                #endregion

                modelo.Add(seccion);
            }

            return modelo.OrderBy(s => s.Orden).ToList();

        }

        private void ConfiguracionSeccionShowRoom(ref ConfiguracionSeccionHomeModel seccion)
        {
            seccion.UrlLandig = "";

            if (!sessionManager.GetEsShowRoom())
                return;

            if (!sessionManager.GetMostrarShowRoomProductos() &&
                !sessionManager.GetMostrarShowRoomProductosExpiro())
            {

                seccion.UrlLandig = (seccion.IsMobile ? "/Mobile/" : "/") + "ShowRoom/Intriga";
                seccion.UrlObtenerProductos = "ShowRoom/GetDataShowRoomIntriga";

                if (!IsMobile())
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

            if (sessionManager.GetMostrarShowRoomProductos() &&
                !sessionManager.GetMostrarShowRoomProductosExpiro())
            {
                seccion.UrlLandig = (seccion.IsMobile ? "/Mobile/" : "/") + "ShowRoom";
                seccion.UrlObtenerProductos = "ShowRoom/CargarProductosShowRoomOferta";
                if (!IsMobile())
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

                var listaShowRoom = (List<BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom] ?? new List<BEShowRoomOferta>();
                seccion.CantidadProductos = listaShowRoom.Count(x => !x.EsSubCampania);
                seccion.CantidadMostrar = Math.Min(3, seccion.CantidadProductos);
            }
        }

        public bool RDObtenerTitulosSeccion(ref string titulo, ref string subtitulo, string codigo)
        {
            if (codigo == Constantes.ConfiguracionPais.RevistaDigital && !revistaDigital.TieneRDC) return false;

            if (codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida && !revistaDigital.TieneRDR) return false;

            titulo = revistaDigital.TieneRDC
                ? (revistaDigital.EsActiva || revistaDigital.EsSuscrita)
                    ? "OFERTAS CLUB GANA+"
                    : "OFERTAS GANA+"
                : revistaDigital.TieneRDR ? "OFERTAS GANA+" : "";

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
            var path = Request.Path;
            var listMenu = BuildMenuContenedor();

            path = path.ToLower().Replace("/mobile", "");

            if (path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) >= 0)
                path = path.Substring(path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) + 39);

            var pathStrings = path.Split('/');
            var newPath = "";
            newPath += "/" + (pathStrings.Length > 1 ? pathStrings[1] : "");
            newPath += "/" + (pathStrings.Length > 2 ? pathStrings[2] : "");

            var menuActivo = new MenuContenedorModel { CampaniaId = userData.CampaniaID, ConfiguracionPais = new ConfiguracionPaisModel() };

            var campaniaIdStr = Util.Trim(Request.QueryString["campaniaid"]);
            var pathOrigen = Util.Trim(Request.QueryString["origen"]);

            var campaniaid = 0;
            if (int.TryParse(campaniaIdStr, out campaniaid))
            {
                menuActivo.CampaniaId = int.Parse(campaniaIdStr);
            }

            newPath = newPath.EndsWith("/") ? newPath.Substring(0, newPath.Length - 1) : newPath;

            switch (newPath.ToLower())
            {
                case Constantes.UrlMenuContenedor.Inicio:
                case Constantes.UrlMenuContenedor.InicioIndex:
                case Constantes.UrlMenuContenedor.RdInicio:
                case Constantes.UrlMenuContenedor.RdInicioIndex:
                    menuActivo.Codigo = revistaDigital.TieneRDC || revistaDigital.TieneRDR ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MContenedorHome
                        : Constantes.OrigenPantallaWeb.DContenedorHome;
                    break;
                case Constantes.UrlMenuContenedor.InicioRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRDC || revistaDigital.TieneRDR ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MContenedorHomeRevisar
                        : Constantes.OrigenPantallaWeb.DContenedorHomeRevisar;
                    break;
                case Constantes.UrlMenuContenedor.RdComprar:
                    menuActivo.Codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MRevistaDigital
                        : Constantes.OrigenPantallaWeb.DRevistaDigital;
                    break;
                case Constantes.UrlMenuContenedor.RdRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalRevisar
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalRevisar;
                    break;
                case Constantes.UrlMenuContenedor.RdInformacion:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Informacion;
                    menuActivo.CampaniaId = 0;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalInfo
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalInfo;
                    break;
                case Constantes.UrlMenuContenedor.RdDetalle:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Lanzamiento;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalDetalle
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalDetalle;
                    break;
                case Constantes.UrlMenuContenedor.SwInicio:
                case Constantes.UrlMenuContenedor.SwIntriga:
                case Constantes.UrlMenuContenedor.SwDetalle:
                case Constantes.UrlMenuContenedor.SwInicioIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.ShowRoom;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MShowRoom
                        : Constantes.OrigenPantallaWeb.DShowRoom;
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
                case Constantes.UrlMenuContenedor.GuiaDeNegocio:
                case Constantes.UrlMenuContenedor.GuiaDeNegocioIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MGuiaNegocio
                        : Constantes.OrigenPantallaWeb.DGuiaNegocio;
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

            menuActivo.ConfiguracionPais = configMenu;
            if (revistaDigital.TieneRDC || revistaDigital.TieneRDI)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
                menuActivo.CampaniaX1 = AddCampaniaAndNumero(userData.CampaniaID, 1);
            }
            Session[Constantes.ConstSession.MenuContenedorActivo] = menuActivo;
            return menuActivo;
        }

        public string GetMenuActivoOptCodigoSegunActivo(string pathOrigen)
        {
            var codigo = "";
            try
            {
                var origrn = int.Parse(pathOrigen);
                switch (origrn)
                {
                    case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor:
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
                    case Constantes.OrigenPedidoWeb.OfertasParaTiMobileHome:
                    case Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido:
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

            if (menuActivo.CampaniaId == userData.CampaniaID && !sessionManager.GetTieneLan())
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (menuActivo.CampaniaId != userData.CampaniaID && !sessionManager.GetTieneLanX1())
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (!sessionManager.GetTieneOpt())
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.OfertasParaTi).ToList();
            }
            if (menuActivo.CampaniaId == userData.CampaniaID &&
                !sessionManager.GetTieneOpm())
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigital).ToList();
            }
            if (menuActivo.CampaniaId != userData.CampaniaID &&
                !sessionManager.GetTieneOpmX1())
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigital).ToList();
            }
            if (menuActivo.CampaniaId == userData.CampaniaID &&
              !sessionManager.GetTieneRdr())
            {
                listMenu = listMenu.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigitalReducida).ToList();
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

            var paisCarpeta = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesEsika).Contains(userData.CodigoISO) ? "Esika" : "Lbel";

            foreach (var confiModel in lista)
            {
                confiModel.Codigo = Util.Trim(confiModel.Codigo).ToUpper();
                confiModel.MobileLogoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.MobileLogoBanner);
                confiModel.DesktopLogoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.DesktopLogoBanner);
                confiModel.MobileFondoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.MobileFondoBanner);
                confiModel.DesktopFondoBanner = ConfigS3.GetUrlFileS3(carpetaPais, confiModel.DesktopFondoBanner);
                confiModel.CampaniaId = userData.CampaniaID;

                switch (confiModel.Codigo)
                {
                    case Constantes.ConfiguracionPais.InicioRD:
                        if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
                            continue;

                        confiModel.UrlMenu = "Ofertas";
                        confiModel.DesktopFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_ImagenFondo, confiModel.DesktopFondoBanner);
                        confiModel.DesktopTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_TituloBanner, confiModel.DesktopTituloBanner);
                        confiModel.DesktopSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_SubTituloBanner, confiModel.DesktopSubTituloBanner);

                        confiModel.MobileFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_ImagenFondo, confiModel.MobileFondoBanner);
                        confiModel.MobileTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_TituloBanner, confiModel.MobileTituloBanner);
                        confiModel.MobileSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_SubTituloBanner, confiModel.MobileSubTituloBanner);

                        confiModel.Logo = "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.svg";
                        confiModel.Descripcion = "";

                        break;
                    case Constantes.ConfiguracionPais.Inicio:
                        if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                            continue;

                        confiModel.UrlMenu = "Ofertas";

                        confiModel.DesktopFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenFondo, confiModel.DesktopFondoBanner);
                        confiModel.DesktopLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenLogo, confiModel.DesktopLogoBanner);
                        confiModel.DesktopTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_TituloBanner, confiModel.DesktopTituloBanner);
                        confiModel.DesktopSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_SubTituloBanner, confiModel.DesktopSubTituloBanner);

                        confiModel.MobileFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenFondo, confiModel.MobileFondoBanner);
                        confiModel.MobileLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenLogo, confiModel.MobileLogoBanner);
                        confiModel.MobileTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_TituloBanner, confiModel.MobileTituloBanner);
                        confiModel.MobileSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_SubTituloBanner, confiModel.MobileSubTituloBanner);

                        confiModel.Logo = "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.svg";
                        confiModel.Descripcion = "";
                        break;
                    case Constantes.ConfiguracionPais.ShowRoom:

                        if (!sessionManager.GetEsShowRoom())
                            continue;

                        confiModel.UrlMenu = "";
                        if (!sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {

                            confiModel.UrlMenu = "ShowRoom/Intriga";
                        }

                        if (sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            confiModel.UrlMenu = "ShowRoom";

                        }
                        if (confiModel.UrlMenu == "")
                            continue;

                        break;
                    case Constantes.ConfiguracionPais.OfertaDelDia:
                        if (!userData.TieneOfertaDelDia)
                            continue;

                        confiModel.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
                            continue;

                        confiModel.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                        if (revistaDigital.TieneRDC || !revistaDigital.TieneRDR)
                            continue;

                        confiModel.UrlMenu = "RevistaDigital/Comprar";
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        if (!revistaDigital.TieneRDC)
                            continue;

                        confiModel.UrlMenu = "RevistaDigital/Comprar";
                        break;
                    case Constantes.ConfiguracionPais.OfertasParaTi:
                        if (revistaDigital.TieneRDC || revistaDigital.TieneRDR)
                            continue;

                        confiModel.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                        if (!GNDValidarAcceso())
                            continue;

                        confiModel.UrlMenu = "GuiaNegocio";
                        break;
                }

                confiModel.UrlMenuMobile = "/Mobile/" + confiModel.UrlMenu;
                confiModel.EsAncla = confiModel.UrlMenu != null && confiModel.UrlMenu.Contains("#");

                var config = confiModel;

                if (confiModel.Codigo == Constantes.ConfiguracionPais.RevistaDigitalSuscripcion
                    || config.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida
                    || config.Codigo == Constantes.ConfiguracionPais.RevistaDigital)
                {
                    var valBool = BuilTituloBannerRD(ref config);
                    if (!valBool)
                        continue;
                }
                SepararPipe(ref config);
                RemplazarTagNombreConfiguracion(ref config);

                listaMenu.Add(config);
            }

            // Menú inicio
            if (listaMenu.Any() && (revistaDigital.TieneRDI || revistaDigital.TieneRDR || revistaDigital.TieneRDC))
            {
                listaMenu.ForEach(m =>
                {
                    if (m.Codigo == Constantes.ConfiguracionPais.InicioRD
                        || m.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
                    {
                        if (revistaDigital.TieneRDC)
                        {
                            m.DesktopLogoBanner = revistaDigital.EsSuscrita
                                ? revistaDigital.DLogoComercialFondoActiva
                                : revistaDigital.DLogoComercialFondoNoActiva;

                            m.MobileLogoBanner = revistaDigital.EsSuscrita
                                ? revistaDigital.MLogoComercialFondoActiva
                                : revistaDigital.MLogoComercialFondoNoActiva;
                        }
                        else
                        {
                            m.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
                            m.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                        }
                    }
                    if (m.Codigo == Constantes.ConfiguracionPais.Inicio)
                    {
                        BuilTituloBannerRD(ref m);
                    }

                });

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

        private bool BuilTituloBannerRD(ref ConfiguracionPaisModel confi)
        {
            var codigo = "";
            var codigoMobile = "";

            if (revistaDigital.TieneRDC)
            {
                if (revistaDigital.EsActiva)
                {
                    if (revistaDigital.EsSuscrita)
                    {
                        codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerActivaSuscrita;
                        codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerActivaSuscrita;
                    }
                    else
                    {
                        codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerActivaNoSuscrita;
                        codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerActivaNoSuscrita;
                    }
                }
                else
                {
                    if (revistaDigital.EsSuscrita)
                    {
                        codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerNoActivaSuscrita;
                        codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerNoActivaSuscrita;
                    }
                    else
                    {
                        codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerNoActivaNoSuscrita;
                        codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerNoActivaNoSuscrita;
                    }
                }

                confi.MobileLogoBanner = revistaDigital.EsSuscrita ? revistaDigital.MLogoComercialFondoActiva : revistaDigital.MLogoComercialFondoNoActiva;
                confi.DesktopLogoBanner = revistaDigital.EsSuscrita ? revistaDigital.DLogoComercialFondoActiva : revistaDigital.DLogoComercialFondoNoActiva;

            }
            else if (revistaDigital.TieneRDR)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RDR.DRDRLandingBanner;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RDR.MRDRLandingBanner;
                confi.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                confi.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
            }
            else if (revistaDigital.TieneRDI)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RDI.DLandingBannerIntriga;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RDI.MLandingBannerIntriga;
                confi.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                confi.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
            }

            if (codigo == "" || codigoMobile == "")
                return false;

            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            confi.DesktopTituloBanner = Util.Trim(dato.Valor1);
            confi.DesktopSubTituloBanner = Util.Trim(dato.Valor2);

            dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigoMobile) ?? new ConfiguracionPaisDatosModel();

            confi.MobileTituloBanner = Util.Trim(dato.Valor1);
            confi.MobileSubTituloBanner = Util.Trim(dato.Valor2);

            return true;

        }
        #endregion

        #region RD
        public MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();

            string codigo;
            if (revistaDigital.EsSuscrita)
            {
                model.MensajeIconoSuperior = true;
                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaSuscrita;
                model.BtnInscribirse = false;
            }
            else
            {
                model.MensajeIconoSuperior = false;
                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaNoSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaNoSuscrita;
                model.BtnInscribirse = true;
            }

            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            model.MensajeTitulo = dato == null ? "" : Util.Trim(dato.Valor1);

            return model;
        }
        #endregion

        #region Guia de Negocio Digitalizada
        public virtual bool GNDValidarAcceso()
        {
            var acceso = !(revistaDigital.TieneRDC && revistaDigital.EsActiva);
            return acceso;
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
            string result;

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
            return sessionManager.GetConfiguracionesPaisModel() ??
                   new List<ConfiguracionPaisModel>();
        }

        public ConfiguracionPaisModel ConfiguracionPaisObtener(string codigo)
        {
            codigo = Util.Trim(codigo).ToUpper();
            var listado = ListConfiguracionPais();
            var entidad = listado.FirstOrDefault(c => c.Codigo == codigo) ?? new ConfiguracionPaisModel();

            return entidad;
        }
        public EventoFestivoDataModel GetEventoFestivoData()
        {
            return sessionManager.GetEventoFestivoDataModel() ??
                   new EventoFestivoDataModel();
        }


        public OfertaFinalModel GetOfertaFinal()
        {
            return sessionManager.GetOfertaFinalModel() ??
                   new OfertaFinalModel();
        }

        public MenuContenedorModel GetSessionMenuActivo()
        {
            return GetSession(Constantes.ConstSession.MenuContenedorActivo) as MenuContenedorModel ??
                   new MenuContenedorModel();
        }

        #endregion

        #region ConfigurationManager

        public string GetConfiguracionManager(string key)
        {
            key = Util.Trim(key);
            if (key == "") return "";

            var keyvalor = ConfigurationManager.AppSettings.Get(key);

            #region LOG CASO NULL
            //if (keyvalor == null)
            //{
            //    // Validar si el key es dinamico no generar log, ejem KEY = Name_PAis_Campania
            //    var sinLog = key.StartsWith(Constantes.ConfiguracionManager.DES_UBIGEO)
            //        || key.StartsWith(Constantes.ConfiguracionManager.FechaChat)
            //        || key.StartsWith(Constantes.ConfiguracionManager.TokenAtento)
            //        || key.StartsWith(Constantes.ConfiguracionManager.RevistaPiloto_Zonas)
            //        || key.StartsWith(Constantes.ConfiguracionManager.Contrato_ActualizarDatos)
            //        || key.StartsWith(Constantes.ConfiguracionManager.URL_FAMILIAPROTEGIDA_);
            //    if (!sinLog)
            //        LogManager.LogManager.LogErrorWebServicesBus(new Exception(), 
            //            userData.CodigoConsultora, 
            //            userData.CodigoISO, 
            //            "BaseController.GetConfiguracionManager el key " + key + " no existe");
            //}
            #endregion

            return Util.Trim(keyvalor);
        }

        #endregion

        #region Resize Imagen Default       

        public List<EntidadMagickResize> ObtenerListaImagenesResize(string rutaImagen)
        {
            var listaImagenesResize = new List<EntidadMagickResize>();

            if (Util.ExisteUrlRemota(rutaImagen))
            {
                var extensionNombreImagenSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall;
                var rutaImagenSmall = Util.GenerarRutaImagenResize(rutaImagen, extensionNombreImagenSmall);

                var extensionNombreImagenMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium;
                var rutaImagenMedium = Util.GenerarRutaImagenResize(rutaImagen, extensionNombreImagenMedium);

                var listaValoresImagenesResize = ObtenerParametrosTablaLogica(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, true);

                EntidadMagickResize entidadResize;
                if (!Util.ExisteUrlRemota(rutaImagenSmall))
                {
                    entidadResize = new EntidadMagickResize();
                    entidadResize.RutaImagenOriginal = rutaImagen;
                    entidadResize.RutaImagenResize = rutaImagenSmall;
                    entidadResize.Width = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhSmall);
                    entidadResize.Height = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightSmall);
                    entidadResize.TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenSmall;
                    entidadResize.CodigoIso = userData.CodigoISO;
                    listaImagenesResize.Add(entidadResize);
                }

                if (!Util.ExisteUrlRemota(rutaImagenMedium))
                {
                    entidadResize = new EntidadMagickResize();
                    entidadResize.RutaImagenOriginal = rutaImagen;
                    entidadResize.RutaImagenResize = rutaImagenMedium;
                    entidadResize.Width = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMedium);
                    entidadResize.Height = ObtenerTablaLogicaDimensionImagen(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightMedium);
                    entidadResize.TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenMedium;
                    entidadResize.CodigoIso = userData.CodigoISO;
                    listaImagenesResize.Add(entidadResize);
                }
            }

            return listaImagenesResize;
        }

        public int ObtenerTablaLogicaDimensionImagen(List<BETablaLogicaDatos> lista, short tablaLogicaDatosId)
        {
            int resultado = 0;
            var resultadoString = ObtenerValorTablaLogica(lista, tablaLogicaDatosId);

            var esInt = int.TryParse(resultadoString, out resultado);

            return esInt ? resultado : 0;
        }

        #endregion

        #region Obtener URL Cerrar Sesión

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
            ViewBag.Campania = NombreCampania(userData.NombreCorto);
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

            ViewBag.Dias = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            ViewBag.PeriodoAnalytics = userData.FechaHoy >= userData.FechaInicioCampania.Date && userData.FechaHoy <= userData.FechaFinCampania.Date ? "Facturacion" : "Venta";
            ViewBag.SemanaAnalytics = "No Disponible";

            #region mensaje Cierre Campania y fecha promesa

            DateTime FechaHoraActual = DateTime.Now.AddHours(userData.ZonaHoraria);
            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var TextoPromesaEspecial = false;
            var TextoPromesa = ".";
            var TextoNuevoPROL = "";

            if (userData.ZonaValida)
            {
                if (!userData.DiaPROL)
                {
                    if (userData.NuevoPROL && userData.ZonaNuevoPROL)
                    {
                        ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                        if (!("BO CL VE").Contains(userData.CodigoISO))
                            TextoNuevoPROL = " Revisa tus notificaciones o correo y verifica que tu pedido esté completo.";
                    }
                    else
                    {
                        if (userData.CodigoISO == "VE")
                        {
                            ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                        }
                        else
                        {
                            ViewBag.MensajeCierreCampania = "El <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> desde las <b>" + FormatearHora(userData.HoraFacturacion) + "</b> hasta las <b>" + FormatearHora(HoraCierrePortal) + "</b> podrás validar los productos que te llegarán en el pedido";
                        }
                    }
                }
                else
                {
                    if (userData.DiasCampania != 0 && FechaHoraActual < userData.FechaInicioCampania)
                    {
                        ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                    }
                    else
                    {
                        if (userData.NuevoPROL && userData.ZonaNuevoPROL)
                        {
                            ViewBag.MensajeCierreCampania = "Pasa o modifica tu pedido hasta el día de <b>hoy a las " + FormatearHora(HoraCierrePortal) + "</b>";
                        }
                        else
                        {
                            if (userData.CodigoISO == "VE")
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
            else ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";

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
                        TextoPromesa = " Recibirás tu pedido el <b>" + userData.FechaPromesaEntrega.Day + " de " + NombreMes(userData.FechaPromesaEntrega.Month) + "</b>.";

                    else
                        TextoPromesa = " y recíbelo el <b>" + userData.FechaPromesaEntrega.Day + " de " + NombreMes(userData.FechaPromesaEntrega.Month) + "</b>.";
                }
            }

            ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa + TextoNuevoPROL;

            #endregion

            ViewBag.FechaFacturacionPedido = userData.FechaFacturacion.Day + " de " + NombreMes(userData.FechaFacturacion.Month);
            ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", userData.NombreConsultora.ToUpper(), userData.CodigoISO, userData.CodigoConsultora, userData.EMail, (userData.Telefono ?? "").Trim() + ((userData.Celular ?? "").Trim() == string.Empty ? "" : "; " + (userData.Celular ?? "").Trim()));
            ViewBag.QSBR = ViewBag.QSBR.Replace("\n", "").Trim();

            ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
            ViewBag.NombreC = userData.PrimerNombre;
            ViewBag.ApellidoC = userData.PrimerApellido;
            ViewBag.Lider = userData.Lider;
            ViewBag.PortalLideres = userData.PortalLideres;
            ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + userData.CodigoISO];
            ViewBag.FormatDecimalPais = GetFormatDecimalPais(userData.CodigoISO);
            ViewBag.OfertaFinal = userData.OfertaFinal;
            ViewBag.CatalogoPersonalizado = userData.CatalogoPersonalizado;
            ViewBag.Simbolo = userData.Simbolo;

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

                ViewBag.TieneOfertaDelDia = CumpleOfertaDelDia();
                ViewBag.MostrarOfertaDelDiaContenedor = userData.TieneOfertaDelDia;

                var configuracionPaisOdd = ListConfiguracionPais().FirstOrDefault(p => p.Codigo == Constantes.ConfiguracionPais.OfertaDelDia);
                configuracionPaisOdd = configuracionPaisOdd ?? new ConfiguracionPaisModel();
                ViewBag.CodigoAnclaOdd = configuracionPaisOdd.Codigo;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            #endregion Banner

            ViewBag.Efecto_TutorialSalvavidas = ConfigurationManager.AppSettings.Get("Efecto_TutorialSalvavidas") ?? "1";
            ViewBag.ModificarPedidoProl = userData.NuevoPROL && userData.ZonaNuevoPROL ? 0 : 1;
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

            ViewBag.SaludoFestivo = GetEventoFestivoData().EfSaludo;

            #endregion

            ViewBag.TieneRDI = revistaDigital.TieneRDI;
            ViewBag.MenuContenedorActivo = GetMenuActivo();
            ViewBag.MenuContenedor = ObtenerMenuContenedor();

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

            ViewBag.UrlRaizS3 = string.Format("{0}/{1}/{2}/", ConfigurationManager.AppSettings["URL_S3"], ConfigurationManager.AppSettings["BUCKET_NAME"], ConfigurationManager.AppSettings["ROOT_DIRECTORY"]);

            ViewBag.ServiceController = (ConfigurationManager.AppSettings["ServiceController"] == null) ? "" : ConfigurationManager.AppSettings["ServiceController"].ToString();
            ViewBag.ServiceAction = (ConfigurationManager.AppSettings["ServiceAction"] == null) ? "" : ConfigurationManager.AppSettings["ServiceAction"].ToString();

            ViewBag.EsMobile = 1;//EPD-1780

            ViewBag.FotoPerfil = userData.FotoPerfil;

            ViewBag.TokenPedidoAutenticoOk = (Session["TokenPedidoAutentico"] != null) ? 1 : 0;
            ViewBag.CodigoEstrategia = GetCodigoEstrategia();
        }

        #endregion

        protected string GetUrlFranjaNegra()
        {
            var oModel = sessionManager.GetEventoFestivoDataModel();
            var urlFranjaNegra = oModel == null ? string.Empty : oModel.EfRutaPedido;

            if (string.IsNullOrEmpty(urlFranjaNegra))
                urlFranjaNegra = "../../../Content/Images/Esika/background_pedido.png";

            return urlFranjaNegra;
        }

        protected string GetBucketNameFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.BUCKET_NAME);
        }

        protected int GetMostradoPopupPrecargados()
        {
            var flag = 1;
            try
            {
                if (userData.CodigoISO == "BO" && userData.CampaniaID == 201717)
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
            if (string.IsNullOrWhiteSpace(usuario.CodigoUsuario))
                usuario.CodigoUsuario = UserData().CodigoUsuario;

            if (string.IsNullOrWhiteSpace(usuario.EMail))
                usuario.EMail = UserData().EMail;

            if (string.IsNullOrWhiteSpace(usuario.Celular))
                usuario.Celular = UserData().Celular;

            if (string.IsNullOrWhiteSpace(usuario.Telefono))
                usuario.Telefono = UserData().Telefono;

            if (string.IsNullOrWhiteSpace(usuario.TelefonoTrabajo))
                usuario.TelefonoTrabajo = UserData().TelefonoTrabajo;

            if (string.IsNullOrWhiteSpace(usuario.Sobrenombre))
                usuario.Sobrenombre = UserData().Sobrenombre;

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

            return resultado;
        }


    }
}
