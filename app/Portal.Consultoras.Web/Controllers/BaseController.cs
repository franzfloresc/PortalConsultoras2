using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Common.PagoEnLinea;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Providers;
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
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.ServiceModel;
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
        protected ISessionManager sessionManager;
        protected ILogManager logManager;
        private readonly TablaLogicaProvider _tablaLogicaProvider;
        private readonly ShowRoomProvider _showRoomProvider;
        protected Models.Estrategia.OfertaDelDia.DataModel estrategiaODD;
        protected Models.Estrategia.ShowRoom.ConfigModel configEstrategiaSR;
        #endregion

        #region Constructor

        public BaseController()
        {
            userData = new UsuarioModel();
            logManager = LogManager.LogManager.Instance;
            sessionManager = SessionManager.SessionManager.Instance;
            _tablaLogicaProvider = new TablaLogicaProvider();
            _showRoomProvider = new ShowRoomProvider(_tablaLogicaProvider);
            estrategiaODD = sessionManager.GetEstrategiaODD() ?? new Models.Estrategia.OfertaDelDia.DataModel();
            configEstrategiaSR = sessionManager.GetEstrategiaSR() ?? new Models.Estrategia.ShowRoom.ConfigModel();

        }

        public BaseController(ISessionManager sessionManager)
            : this()
        {
            this.sessionManager = sessionManager;
        }

        public BaseController(ISessionManager sessionManager, ILogManager logManager)
            : this()
        {
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
                estrategiaODD = sessionManager.GetEstrategiaODD();
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
            var esOpt = revistaDigital.TieneRevistaDigital() && revistaDigital.EsActiva
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
                    item.DescripcionOferta = ObtenerDescripcionOferta(item);
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

        public virtual List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado()
        {
            var detallesPedidoWeb = (List<BEPedidoWebDetalle>)null;
            try
            {

                detallesPedidoWeb = sessionManager.GetDetallesPedidoSetAgrupado();

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
                            NumeroPedido = userData.ConsecutivoNueva,
                            AgruparSet = true
                        };

                        detallesPedidoWeb = pedidoServiceClient.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                    }
                }

                foreach (var item in detallesPedidoWeb)
                {
                    item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
                    item.Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre;
                    item.DescripcionOferta = ObtenerDescripcionOferta(item);
                }
                var observacionesProl = sessionManager.GetObservacionesProl();
                if (detallesPedidoWeb.Count > 0 && observacionesProl != null)
                {
                    detallesPedidoWeb = PedidoConObservacionesAgrupado(detallesPedidoWeb, observacionesProl);
                }

                userData.PedidoID = detallesPedidoWeb.Count > 0 ? detallesPedidoWeb[0].PedidoID : 0;

                SetUserData(userData);

                sessionManager.SetDetallesPedidoSetAgrupado(detallesPedidoWeb);
            }
            catch (Exception ex)
            {
                detallesPedidoWeb = detallesPedidoWeb ?? new List<BEPedidoWebDetalle>();
                sessionManager.SetDetallesPedido(detallesPedidoWeb);

                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return detallesPedidoWeb;
        }


        protected List<BEPedidoWebDetalle> PedidoConObservacionesAgrupado(List<BEPedidoWebDetalle> pedido, List<ObservacionModel> observaciones)
        {
            var pedObs = pedido;
            List<string> listaCUVsAEvaluar;
            var txtBuil = new StringBuilder();
            var nuevasObservaciones = new List<ObservacionModel>();

            List<BEPedidoWebDetalle> cuvHijos = TraerHijosFaltantesEnObsPROL(pedido);

            foreach (var item in pedObs)
            {
                listaCUVsAEvaluar = new List<string>();
                item.Mensaje = string.Empty;

                if (cuvHijos.Any(x => x.SetID == item.SetID))
                {
                    listaCUVsAEvaluar.AddRange(cuvHijos.Where(x => x.SetID == item.SetID).Select(x => x.CUV));
                }
                else
                    listaCUVsAEvaluar.Add(item.CUV);

                var temp = observaciones.Where(o => listaCUVsAEvaluar.Contains(o.CUV)).ToList();


                if (temp.Count != 0)
                {
                    if (temp.Any(o => o.Caso == 0)) item.TipoObservacion = 0;
                    else item.TipoObservacion = temp[0].Tipo;

                    foreach (var ob in temp)
                    {
                        txtBuil.Append(ob.Descripcion + "<br/>");
                    }
                    item.Mensaje = txtBuil.ToString();
                    txtBuil.Clear();
                }
                else item.TipoObservacion = 0;
            }

            //sessionManager.SetObservacionesProl(null);

            return pedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }


        protected List<BEPedidoWebDetalle> PedidoConObservaciones(List<BEPedidoWebDetalle> pedido, List<ObservacionModel> observaciones)
        {
            var pedObs = pedido;
            var txtBuil = new StringBuilder();

            foreach (var item in pedObs)
            {
                item.Mensaje = string.Empty;
                var temp = observaciones.Where(o => o.CUV == item.CUV).ToList();
                if (temp.Count != 0)
                {
                    if (temp.Any(o => o.Caso == 0)) item.TipoObservacion = 0;
                    else item.TipoObservacion = temp[0].Tipo;

                    foreach (var ob in temp)
                    {
                        txtBuil.Append(ob.Descripcion + "<br/>");
                    }
                    item.Mensaje = txtBuil.ToString();
                    txtBuil.Clear();
                }
                else item.TipoObservacion = 0;
            }
            return pedObs.OrderByDescending(p => p.TipoObservacion).ToList();
        }

        private List<BEPedidoWebDetalle> TraerHijosFaltantesEnObsPROL(List<BEPedidoWebDetalle> pedido)
        {
            var idSetList = pedido.Where(x => x.SetID != 0).Select(x => x.SetID).ToList();
            var cuvHijos = new List<BEPedidoWebDetalle>();

            if (idSetList.Any())
            {
                using (var sv = new PedidoServiceClient())
                {
                    cuvHijos = sv.ObtenerCuvSetDetalle(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.PedidoID, String.Join(",", idSetList)).ToList();

                }
            }

            return cuvHijos;
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
            var tieneRevistaDigital = revistaDigital.TieneRevistaDigital();
            var smEventoFestivo = sessionManager.GetEventoFestivoDataModel();
            var tieneEventoFestivoData = smEventoFestivo != null &&
                smEventoFestivo.ListaGifMenuContenedorOfertas != null &&
                smEventoFestivo.ListaGifMenuContenedorOfertas.Any();

            if (!tieneRevistaDigital)
            {
                urlImagen = GetDefaultGifMenuOfertas();
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS, urlImagen);
                }
            }

            if (tieneRevistaDigital && !revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            if (tieneRevistaDigital && revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS, urlImagen);
                }
            }

            if (revistaDigital.TieneRDI)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
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

            configEstrategiaSR = sessionManager.GetEstrategiaSR() ?? new Models.Estrategia.ShowRoom.ConfigModel();

            if (!configEstrategiaSR.CargoEntidadesShowRoom) CargarEntidadesShowRoom(model);

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

                configEstrategiaSR.BeShowRoomConsultora = null;
                configEstrategiaSR.BeShowRoom = null;

                configEstrategiaSR.CargoEntidadesShowRoom = false;

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
                    configEstrategiaSR.BeShowRoom = pedidoService.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);
                    configEstrategiaSR.BeShowRoomConsultora = pedidoService.GetShowRoomConsultora(
                        model.PaisID,
                        model.CampaniaID,
                        codigoConsultora,
                        true);

                    configEstrategiaSR.ListaNivel = pedidoService.GetShowRoomNivel(model.PaisID).ToList();



                    configEstrategiaSR.ListaPersonalizacionConsultora = Mapper.Map<IList<BEShowRoomPersonalizacion>, IList<ShowRoomPersonalizacionModel>>(pedidoService.GetShowRoomPersonalizacion(model.PaisID).ToList()).ToList();
                    configEstrategiaSR.ShowRoomNivelId = ObtenerNivelId(configEstrategiaSR.ListaNivel);

                    if (configEstrategiaSR.BeShowRoom != null && configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO)
                    {
                        personalizacionesNivel = pedidoService.GetShowRoomPersonalizacionNivel(model.PaisID,
                            configEstrategiaSR.BeShowRoom.EventoID, configEstrategiaSR.ShowRoomNivelId, 0).ToList();
                    }
                }

                if (configEstrategiaSR.BeShowRoom != null && configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO && configEstrategiaSR.BeShowRoomConsultora != null)
                {
                    sessionManager.SetEsShowRoom("1");

                    var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                    if (userData.FechaInicioCampania != default(DateTime))
                        ViewBag.DiasFaltan = (userData.FechaInicioCampania.AddDays(-configEstrategiaSR.BeShowRoom.DiasAntes) - fechaHoy).Days;

                    if (fechaHoy >= model.FechaInicioCampania.AddDays(-configEstrategiaSR.BeShowRoom.DiasAntes).Date
                        && fechaHoy <= model.FechaInicioCampania.AddDays(configEstrategiaSR.BeShowRoom.DiasDespues).Date)
                    {
                        sessionManager.SetMostrarShowRoomProductos("1");
                    }

                    if (fechaHoy > model.FechaInicioCampania.AddDays(configEstrategiaSR.BeShowRoom.DiasDespues).Date)
                        sessionManager.SetMostrarShowRoomProductosExpiro("1");
                }

                if (personalizacionesNivel != null && personalizacionesNivel.Any())
                {
                    var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;
                    Session["carpetaPais"] = carpetaPais;

                    foreach (var item in configEstrategiaSR.ListaPersonalizacionConsultora)
                    {
                        var personalizacionNivel = personalizacionesNivel.FirstOrDefault(
                            p => p.NivelId == configEstrategiaSR.ShowRoomNivelId &&
                                 p.EventoID == configEstrategiaSR.BeShowRoom.EventoID &&
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
                                : ConfigCdn.GetUrlFileCdn(carpetaPais, item.Valor);
                        }
                    }
                }

                configEstrategiaSR.CargoEntidadesShowRoom = true;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                configEstrategiaSR.CargoEntidadesShowRoom = false;
            }

            SetUserData(model);
            sessionManager.SetEstrategiaSR(configEstrategiaSR);
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

                    TipoEstrategiaID = fichaProducto.TipoEstrategiaID,
                    FlagNueva = fichaProducto.FlagNueva,
                    IsAgregado = listaPedido.Any(p => p.CUV == fichaProducto.CUV2.Trim()),
                    ArrayContenidoSet = fichaProducto.FlagNueva == 1 ? fichaProducto.DescripcionCUV2.Split('|').Skip(1).ToList() : new List<string>(),
                    ListaDescripcionDetalle = fichaProducto.ListaDescripcionDetalle ?? new List<string>(),
                    TextoLibre = Util.Trim(fichaProducto.TextoLibre),

                    MarcaID = fichaProducto.MarcaID,

                    TienePaginaProducto = fichaProducto.PuedeVerDetalle,
                    TienePaginaProductoMob = fichaProducto.PuedeVerDetalleMob,

                    TipoAccionAgregar = TipoAccionAgregar(fichaProducto.TieneVariedad, fichaProducto.TipoEstrategia.Codigo),
                    LimiteVenta = fichaProducto.LimiteVenta
                };
                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        public int TipoAccionAgregar(int tieneVariedad, string codigoTipoEstrategia, bool bloqueado = false, string codigoTipos = "")
        {
            var tipo = tieneVariedad == 0 ? codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackNuevas ? 1 : 2 : 3;

            if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada)
            {
                tipo = userData.esConsultoraLider && revistaDigital.SociaEmpresariaExperienciaGanaMas && revistaDigital.EsSuscritaActiva() ? 0 : tipo;
            }
            else if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom)
            {
                tipo = codigoTipos == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoTipos == Constantes.TipoEstrategiaSet.CompuestaFija ? 2 : 3;
                tipo = bloqueado && revistaDigital.EsNoSuscritaInactiva() ? 4 : tipo;
                tipo = bloqueado && revistaDigital.EsSuscritaInactiva() ? 5 : tipo;
            }
            else if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                || codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                || codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento)
            {
                tipo = bloqueado && revistaDigital.EsNoSuscritaInactiva() ? 4 : tipo;
                tipo = bloqueado && revistaDigital.EsSuscritaInactiva() ? 5 : tipo;
            }
            return tipo;
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

            var claseBloqueada = "btn_desactivado_general";

            listaProductoModel.ForEach(ficha =>
            {
                ficha.ClaseBloqueada = ficha.CampaniaID > 0 && ficha.CampaniaID != userData.CampaniaID ? claseBloqueada : "";
                ficha.IsAgregado = ficha.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.CUV == ficha.CUV2.Trim());
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
                    List<ServiceODS.BEProducto> listaHermanosE;
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

                var listaProducto = new List<ServicePedido.BEEstrategiaProducto>();
                if (fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || fichaProductoModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    var estrategiaX = new EstrategiaPedidoModel() { PaisID = userData.PaisID, EstrategiaID = fichaProductoModelo.EstrategiaID };
                    using (var svc = new PedidoServiceClient())
                    {
                        listaProducto = svc.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, ServicePedido.BEEstrategia>(estrategiaX)).ToList();
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
                        BEActivarPremioNuevas beActive = sv.GetActivarPremioNuevas(userData.PaisID, Constantes.TipoEstrategiaCodigo.ProgramaNuevasRegalo, userData.CampaniaID, nivel);
                        TippingPoint.ActiveTooltip = beActive == null ? false : beActive.ActiveTooltip;
                        TippingPoint.ActiveMonto = beActive == null ? false : beActive.ActiveMontoTooltip;
                        TippingPoint.Active = beActive == null ? false : beActive.Active;
                        TippingPoint.TippingPointMontoStr = TippingPointStr;
                        // verifica si esta activado el tooltip
                        if (TippingPoint.ActiveTooltip == true)
                        {
                            ServicePedido.BEEstrategia estrategia = sv.GetEstrategiaPremiosTippingPoint(userData.PaisID,
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
                            TippingPoint.LinkURL = getUrlTippingPoint(estrategia.ImagenURL);
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
                TippingPoint = new BarraTippingPoint { ActiveTooltip = false, ActiveMonto = false };
            }
            return TippingPoint;
        }

        private string getUrlTippingPoint(string noImagen)
        {
            /*
              string url = string.Format
                        ("{0}/{1}/{2}/{3}/{4}/{5}",
                            GetConfiguracionManager(Constantes.ConfiguracionManager.URL_S3),
                            GetConfiguracionManager(Constantes.ConfiguracionManager.BUCKET_NAME),
                            GetConfiguracionManager(Constantes.ConfiguracionManager.ROOT_DIRECTORY),
                            GetConfiguracionManager(ConfigurationManager.AppSettings["Matriz"] ?? ""),
                            userData.CodigoISO ?? "",
                            noImagen ?? ""
                         );
             */
            string urlExtension = string.Format("{0}/{1}", GetConfiguracionManager(ConfigurationManager.AppSettings["Matriz"] ?? ""), userData.CodigoISO ?? "");
            string url = ConfigCdn.GetUrlFileCdn(urlExtension, noImagen ?? "");
            return url;
        }

        private string getValidaConsultoraProgramaNueva(string participa)
        {
            string resultado = string.Empty;
            // si el idestadoActividad es mayor a 1 o diferente a  1 entonces significa que el usuario pertenece al programa de nuevas[campo ConsecutivoNueva]
            int ConsecutivoNueva = userData.ConsecutivoNueva;
            // este es el campo IdEstadoActividad en bd
            int ConsultoraNueva = userData.ConsultoraNueva;
            try
            {
                resultado = participa == null ? "" : participa.Trim();

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
            }
            catch
            {
                resultado = string.Empty;
            }
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

        public EstadoCuentaModel ObtenerUltimoMovimientoEstadoCuenta()
        {
            var ultimoMovimiento = new EstadoCuentaModel
            {
                Glosa = ""
            };

            if (userData.TienePagoEnLinea)
            {
                BEPagoEnLineaResultadoLog ultimoPagoEnLinea;
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    ultimoPagoEnLinea = ps.ObtenerUltimoPagoEnLineaByConsultoraId(userData.PaisID, userData.ConsultoraID);
                }

                if (ultimoPagoEnLinea != null && ultimoPagoEnLinea.PagoEnLineaResultadoLogId != 0)
                {
                    var fechaUltimoPagoEnLinea = ultimoPagoEnLinea.FechaCreacion;
                    var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                    if (fechaUltimoPagoEnLinea.ToString("dd/MM/yyyy") == fechaHoy.ToString("dd/MM/yyyy"))
                    {
                        ultimoMovimiento.Simbolo = userData.Simbolo;
                        ultimoMovimiento.Glosa = "PAGO EN LINEA";
                        ultimoMovimiento.Fecha = fechaUltimoPagoEnLinea;
                        ultimoMovimiento.FechaVencimiento = fechaUltimoPagoEnLinea.ToString("dd/MM/yyyy");
                        ultimoMovimiento.FechaVencimientoFormatDiaMes = ObtenerFormatoDiaMes(ultimoPagoEnLinea.FechaCreacion);
                        ultimoMovimiento.TipoMovimiento = Constantes.EstadoCuentaTipoMovimiento.Abono;
                        ultimoMovimiento.Abono = ultimoPagoEnLinea.MontoPago;
                        ultimoMovimiento.Cargo = 0;
                        ultimoMovimiento.MontoPagar = Util.DecimalToStringFormat(ultimoMovimiento.Abono, userData.CodigoISO);
                    }
                }
            }

            return ultimoMovimiento;
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
            if (estrategiaODD.ListaDeOferta == null)
                return null;

            if (!estrategiaODD.ListaDeOferta.Any())
                return null;

            var model = estrategiaODD.ListaDeOferta.First().Clone();
            model.ListaOfertas = estrategiaODD.ListaDeOferta;
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
                oferta.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == oferta.CUV2 && (d.TipoEstrategiaID == oferta.TipoEstrategiaID || d.TipoEstrategiaID == 0)) ? "block" : "none";

                if (tiposEstrategia != null && tiposEstrategia.Any(x => x.TipoEstrategiaID == oferta.TipoEstrategiaID))
                    oferta.TipoEstrategiaDescripcion = tiposEstrategia.First(x => x.TipoEstrategiaID == oferta.TipoEstrategiaID).DescripcionEstrategia ?? string.Empty;
            }

            model.TeQuedan = CountdownODD(userData);

            var configOdd = GetConfiguracionEstrategia(Constantes.ConfiguracionPais.OfertaDelDia);
            model.ConfiguracionContenedor = configOdd;
            return model;
        }

        public ConfiguracionSeccionHomeModel GetConfiguracionEstrategia(string codigoEstrategia)
        {
            ConfiguracionSeccionHomeModel configuracionModel;

            switch (codigoEstrategia)
            {
                case Constantes.ConfiguracionPais.OfertaDelDia:
                    configuracionModel = ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault(entConf => entConf.Codigo == codigoEstrategia);
                    break;
                default:
                    return null;
            }

            return configuracionModel;
        }

        public ShowRoomBannerLateralModel GetShowRoomBannerLateral()
        {
            var model = new ShowRoomBannerLateralModel();

            if (!PaisTieneShowRoom(userData.CodigoISO))
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            model.BEShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
            model.BEShowRoom = configEstrategiaSR.BeShowRoom ?? new BEShowRoomEvento();

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

        #region Catalogos y Revistas Issuu

        protected string GetRevistaCodigoIssuu(string campania)
        {
            string codigo = null;
            string requestUrl = null;
            bool esRevistaPiloto = false;
            var Grupos = GetConfiguracionManager(Constantes.ConfiguracionManager.RevistaPiloto_Grupos + userData.CodigoISO + campania);
            string codeGrupo = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;

            if (!string.IsNullOrEmpty(Grupos))
            {
                foreach (var grupo in Grupos.Split(','))
                {
                    var zonas = GetConfiguracionManager(Constantes.ConfiguracionManager.RevistaPiloto_Zonas + userData.CodigoISO + campania + "_" + grupo);
                    esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
                    if (esRevistaPiloto)
                    {
                        codeGrupo = grupo.Trim().ToString();
                        break;
                    }
                }
            }
            else
                esRevistaPiloto = false;

            codigo = GetConfiguracionManager(Constantes.ConfiguracionManager.CodigoRevistaIssuu);
            if (campania.Length >= 6)
                nroCampania = campania.Substring(4, 2);
            if (campania.Length >= 6)
                anioCampania = campania.Substring(0, 4);

            if (esRevistaPiloto)
                requestUrl = string.Format(codigo, userData.CodigoISO.ToLower(), nroCampania, anioCampania, codeGrupo.Replace(Constantes.ConfiguracionManager.RevistaPiloto_Escenario, ""));
            else
            {
                requestUrl = string.Format(codigo, userData.CodigoISO.ToLower(), nroCampania, anioCampania, "");
                if (requestUrl.Length > 0)
                    requestUrl = Util.Trim(requestUrl.Substring(requestUrl.Length - 1)) == "." ? requestUrl.Substring(0, requestUrl.Length - 1) : requestUrl;
            }
            requestUrl = GetRevistaCodigoIssuuRDR(requestUrl);
            return requestUrl;
        }

        public string GetRevistaCodigoIssuuRDR(string codigoRevista)
        {
            if (revistaDigital.TieneRDCR)
            {
                if (codigoRevista.EndsWith(Constantes.CatalogoUrlIssu.RDR + "1") || codigoRevista.EndsWith(Constantes.CatalogoUrlIssu.RDR + "2"))
                    return codigoRevista;

                string tipo = "1";
                if (GetConfiguracionManagerContains(Constantes.ConfiguracionManager.RevistaPiloto_Zonas_RDR_2 + userData.CodigoISO, userData.CodigoZona))
                {
                    tipo = "2";
                }

                codigoRevista += Constantes.CatalogoUrlIssu.RDR + tipo;

            }
            return codigoRevista;
        }

        protected string GetRevistaCodigoIssuu_Backup(string campania)
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

        protected string GetCatalogoCodigoIssuu_Backup(string campania, int idMarcaCatalogo)
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

        protected string GetCatalogoCodigoIssuu(string campania, int idMarcaCatalogo)
        {
            string nombreCatalogoIssuu = null;
            string nombreCatalogoConfig = null;
            string CodeGrup = null;
            string nroCampania = string.Empty;
            string anioCampania = string.Empty;
            string codigo = null;
            string requestUrl = null;
            bool esRevistaPiloto = false;
            string Grupos = null;
            string marcas = GetConfiguracionManager(Constantes.ConfiguracionManager.Catalogo_Marca_Piloto + userData.CodigoISO + campania) ?? "";
            bool esMarcaEspecial = false;

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

            Grupos = GetConfiguracionManager(Constantes.ConfiguracionManager.Catalogo_Piloto_Grupos + nombreCatalogoConfig + Constantes.ConfiguracionManager.SubGuion + userData.CodigoISO + campania);
            esMarcaEspecial = marcas.Split(new char[1] { ',' }).Select(marca => marca.Trim()).Contains(nombreCatalogoConfig);


            if (!string.IsNullOrEmpty(Grupos))
            {
                foreach (var grupo in Grupos.Split(','))
                {
                    var zonas = GetConfiguracionManager(Constantes.ConfiguracionManager.Catalogo_Piloto_Zonas + nombreCatalogoConfig + Constantes.ConfiguracionManager.SubGuion + userData.CodigoISO + campania + Constantes.ConfiguracionManager.SubGuion + grupo);
                    esRevistaPiloto = zonas.Split(new char[1] { ',' }).Select(zona => zona.Trim()).Contains(userData.CodigoZona);
                    if (esRevistaPiloto)
                    {
                        CodeGrup = grupo.Trim().ToString();
                        break;
                    }
                }
            }
            else
                esRevistaPiloto = false;

            codigo = GetConfiguracionManager(Constantes.ConfiguracionManager.CodigoCatalogoIssuu);
            if (campania.Length >= 6)
                nroCampania = campania.Substring(4, 2);
            if (campania.Length >= 6)
                anioCampania = campania.Substring(0, 4);

            if (esRevistaPiloto && esMarcaEspecial)
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, GetPaisNombreByISO(userData.CodigoISO), nroCampania, anioCampania, CodeGrup.Replace(Constantes.ConfiguracionManager.Catalogo_Piloto_Escenario, ""));
            else
            {
                requestUrl = string.Format(codigo, nombreCatalogoIssuu, GetPaisNombreByISO(userData.CodigoISO), campania.Substring(4, 2), campania.Substring(0, 4), "");
                requestUrl = Util.Trim(requestUrl.Substring(requestUrl.Length - 1)) == "." ? requestUrl.Substring(0, requestUrl.Length - 1) : requestUrl;
            }

            return requestUrl;
        }


        protected string GetPaisNombreByISO(string paisISO)
        {
            switch (paisISO)
            {
                case Constantes.CodigosISOPais.Argentina: return "argentina";
                case Constantes.CodigosISOPais.Bolivia: return "bolivia";
                case Constantes.CodigosISOPais.Chile: return "chile";
                case Constantes.CodigosISOPais.Colombia: return "colombia";
                case Constantes.CodigosISOPais.CostaRica: return "costarica";
                case Constantes.CodigosISOPais.Dominicana: return "republicadominicana";
                case Constantes.CodigosISOPais.Ecuador: return "ecuador";
                case Constantes.CodigosISOPais.Guatemala: return "guatemala";
                case Constantes.CodigosISOPais.Mexico: return "mexico";
                case Constantes.CodigosISOPais.Panama: return "panama";
                case Constantes.CodigosISOPais.Peru: return "peru";
                case Constantes.CodigosISOPais.PuertoRico: return "puertorico";
                case Constantes.CodigosISOPais.Salvador: return "elsalvador";
                case Constantes.CodigosISOPais.Venezuela: return "venezuela";
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

        protected void EjecutarLogDynamoDB(object data, string requestUrl, string campomodificacion, string valoractual, string valoranterior, string origen, string aplicacion, string accion, string codigoconsultorabuscado, string seccion = "")
        {
            string dataString = string.Empty;
            string urlApi = string.Empty;
            bool noQuitar = false;

            /*** Se registra sección Solo para Perú HD-881 ***/
            if (userData.CodigoISO != "PE")
                seccion = "";

            try
            {
                var paisesAdmitidos = new List<BETablaLogicaDatos>();
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

                //data = new
                //{
                //    Usuario = userData.CodigoUsuario,
                //    CodigoConsultora = userData.CodigoConsultora,
                //    CampoModificacion = campomodificacion,
                //    ValorActual = valoractual,
                //    ValorAnterior = valoranterior,
                //    Origen = origen,
                //    Aplicacion = aplicacion,
                //    Pais = userData.NombrePais,
                //    Rol = userData.RolDescripcion,
                //    Dispositivo = Request.Browser.IsMobileDevice ? "MOBILE" : "WEB",
                //    Accion = accion,
                //    UsuarioConsultado = codigoconsultorabuscado,
                //    Seccion = seccion
                //};

                //urlApi = ConfigurationManager.AppSettings.Get("UrlLogDynamo");
                //if (string.IsNullOrEmpty(urlApi)) return;

                //HttpClient httpClient = new HttpClient();
                //httpClient.BaseAddress = new Uri(urlApi);
                //httpClient.DefaultRequestHeaders.Accept.Clear();
                //httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                //dataString = JsonConvert.SerializeObject(data);
                //HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                //HttpResponseMessage response = httpClient.PostAsync(requestUrl, contentPost).GetAwaiter().GetResult();
                //noQuitar = response.IsSuccessStatusCode;
                //httpClient.Dispose();
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

                    SetUserData(userData);
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
                var urlApi = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);
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

        protected int GetDiasFaltantesFacturacion(DateTime fechaInicioCampania, double zonaHoraria)
        {
            var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;
            return fechaHoy >= fechaInicioCampania.Date ? 0 : (fechaInicioCampania.Subtract(DateTime.Now.AddHours(zonaHoraria)).Days + 1);
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
            if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
                return string.Empty;

            var model = configEstrategiaSR.ListaPersonalizacionConsultora.FirstOrDefault(p => p.Atributo == codigoAtributo && p.TipoAplicacion == tipoAplicacion);

            return model == null
                ? string.Empty
                : model.Valor;
        }

        public string GetCodigoEstrategia()
        {
            var codigo = Constantes.TipoEstrategiaCodigo.OfertaParaTi;
            if (revistaDigital.TieneRevistaDigital())
            {
                codigo = Constantes.TipoEstrategiaCodigo.RevistaDigital;
            }
            return codigo;
        }

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

        #region TablaLogica

        public List<TablaLogicaDatosModel> ObtenerParametrosTablaLogica(int paisId, short tablaLogicaId, bool sesion = false)
        {
            var datos = sesion ? (List<TablaLogicaDatosModel>)Session[Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()] : null;
            if (datos == null)
            {
                datos = _tablaLogicaProvider.ObtenerConfiguracion(paisId, tablaLogicaId);

                if (sesion)
                    Session[Constantes.ConstSession.TablaLogicaDatos + tablaLogicaId.ToString()] = datos;
            }

            return datos;
        }

        public string ObtenerValorTablaLogica(int paisId, short tablaLogicaId, short idTablaLogicaDatos, bool sesion = false)
        {
            return ObtenerValorTablaLogica(ObtenerParametrosTablaLogica(paisId, tablaLogicaId, sesion), idTablaLogicaDatos);
        }

        public string ObtenerValorTablaLogica(List<TablaLogicaDatosModel> datos, short idTablaLogicaDatos)
        {
            var valor = "";
            datos = datos ?? new List<TablaLogicaDatosModel>();
            if (datos.Any())
            {
                var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == idTablaLogicaDatos) ?? new TablaLogicaDatosModel();
                valor = Util.Trim(par.Codigo);
            }
            return valor;
        }

        public int ObtenerValorTablaLogicaInt(int paisId, short tablaLogicaId, short idTablaLogicaDatos, bool sesion = false)
        {
            var resultadoString = ObtenerValorTablaLogica(paisId, tablaLogicaId, idTablaLogicaDatos, sesion);
            int resultado;
            int.TryParse(resultadoString, out resultado);
            return resultado;
        }

        public int ObtenerValorTablaLogicaInt(List<TablaLogicaDatosModel> lista, short tablaLogicaDatosId)
        {
            var resultadoString = ObtenerValorTablaLogica(lista, tablaLogicaDatosId);

            int resultado;
            int.TryParse(resultadoString, out resultado);
            return resultado;
        }

        public bool HabilitarChatEmtelco(int paisId)
        {
            bool Mostrar = false;
            List<TablaLogicaDatosModel> DataLogica = ObtenerParametrosTablaLogica(paisId, Constantes.TablaLogica.HabilitarChatEmtelco, false);

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

        #endregion

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
        protected string MensajeGestionCdrInhabilitadaYChatEnLinea(bool EsAppMobile = false)
        {
            var mensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitada();
            if (string.IsNullOrEmpty(mensajeGestionCdrInhabilitada)) return mensajeGestionCdrInhabilitada;
            if (!EsAppMobile) mensajeGestionCdrInhabilitada = String.Format("{0} {1}", mensajeGestionCdrInhabilitada, Constantes.CdrWebMensajes.ContactateChatEnLinea);
            return mensajeGestionCdrInhabilitada;
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
        public List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion(RevistaDigitalModel revistaDigital)
        {
            var modelo = new List<ConfiguracionSeccionHomeModel>();

            try
            {
                if (revistaDigital == null)
                    throw new ArgumentNullException("revistaDigital", "no puede ser nulo");

                var menuActivo = sessionManager.GetMenuContenedorActivo();

                if (menuActivo.CampaniaId <= 0)
                    menuActivo.CampaniaId = userData.CampaniaID;


                var listaEntidad = sessionManager.GetSeccionesContenedor(menuActivo.CampaniaId);
                if (listaEntidad == null)
                {
                    listaEntidad = GetConfiguracionOfertasHome(userData.PaisID, menuActivo.CampaniaId);
                    sessionManager.SetSeccionesContenedor(menuActivo.CampaniaId, listaEntidad);
                }

                if (menuActivo.CampaniaId > userData.CampaniaID)
                {
                    listaEntidad = listaEntidad.Where(entConf
                    => entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.InicioRD
                    || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.HerramientasVenta).ToList();
                }

                var isMobile = IsMobile();
                foreach (var beConfiguracionOfertasHome in listaEntidad)
                {
                    var entConf = beConfiguracionOfertasHome;
                    entConf.ConfiguracionPais.Codigo = Util.Trim(entConf.ConfiguracionPais.Codigo).ToUpper();

                    string titulo = "", subTitulo = "";

                    #region Pre Validacion

                    if (!SeccionTieneConfiguracionPais(entConf.ConfiguracionPais))
                        continue;

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
                        if (!revistaDigital.TieneRevistaDigital()) continue;

                        if (menuActivo.CampaniaId != userData.CampaniaID) entConf.UrlSeccion = "Revisar/" + entConf.UrlSeccion;
                    }

                    #endregion

                    RemplazarTagNombreConfiguracionOferta(ref entConf, Constantes.TagCadenaRd.Nombre1, userData.Sobrenombre);

                    var seccion = new ConfiguracionSeccionHomeModel
                    {
                        CampaniaID = menuActivo.CampaniaId,
                        Codigo = entConf.ConfiguracionPais.Codigo ?? entConf.ConfiguracionOfertasHomeID.ToString().PadLeft(5, '0'),
                        Orden = revistaDigital.TieneRevistaDigital() ? isMobile ? entConf.MobileOrdenBpt : entConf.DesktopOrdenBpt : isMobile ? entConf.MobileOrden : entConf.DesktopOrden,
                        ColorFondo = isMobile ? (entConf.MobileColorFondo ?? "") : (entConf.DesktopColorFondo ?? ""),
                        UsarImagenFondo = isMobile ? entConf.MobileUsarImagenFondo : entConf.DesktopUsarImagenFondo,
                        ImagenFondo = isMobile ? (entConf.MobileImagenFondo ?? "") : (entConf.DesktopImagenFondo ?? ""),
                        ColorTexto = isMobile ? entConf.MobileColorTexto : entConf.DesktopColorTexto,
                        Titulo = isMobile ? entConf.MobileTitulo : entConf.DesktopTitulo,
                        SubTitulo = isMobile ? entConf.MobileSubTitulo : entConf.DesktopSubTitulo,
                        TipoPresentacion = isMobile ? entConf.MobileTipoPresentacion : entConf.DesktopTipoPresentacion,
                        TipoEstrategia = isMobile ? entConf.MobileTipoEstrategia : entConf.DesktopTipoEstrategia,
                        CantidadMostrar = isMobile ? entConf.MobileCantidadProductos : entConf.DesktopCantidadProductos,
                        UrlLandig = "/" + (isMobile ? "Mobile/" : "") + entConf.UrlSeccion,
                        VerMas = true
                    };

                    seccion.TituloBtnAnalytics = seccion.Titulo.Replace("'", "");
                    seccion.ImagenFondo = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, seccion.ImagenFondo);

                    #region ConfiguracionPais.Codigo

                    switch (entConf.ConfiguracionPais.Codigo)
                    {
                        case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                            if (!GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
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
                            seccion.UrlObtenerProductos = "Lanzamientos/RDObtenerProductosLan";
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
                        case Constantes.ConfiguracionPais.HerramientasVenta:
                            seccion.UrlObtenerProductos = "HerramientasVenta/HVObtenerProductos";
                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + (menuActivo.CampaniaId > userData.CampaniaID ? "HerramientasVenta/Revisar" : "HerramientasVenta/Comprar");
                            seccion.OrigenPedido = isMobile ? 0 : Constantes.OrigenPedidoWeb.HVDesktopContenedor;
                            seccion.OrigenPedidoPopup = isMobile ? 0 : Constantes.OrigenPedidoWeb.HVDesktopContenedorPopup;
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
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselIndividuales:
                            seccion.TemplatePresentacion = "seccion-carrusel-individuales";
                            seccion.TemplateProducto = "#lanzamiento-carrusel-individual-template";
                            break;
                    }

                    if (seccion.TemplatePresentacion == "") continue;
                    #endregion

                    modelo.Add(seccion);
                }

                modelo = modelo.OrderBy(s => s.Orden).ToList();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseController.ObtenerConfiguracionSeccion");
            }

            return modelo;
        }

        private bool SeccionTieneConfiguracionPais(ServiceSAC.BEConfiguracionPais configuracionPais)
        {
            var result = false;

            var configuracionesPais = sessionManager.GetConfiguracionesPaisModel();
            if (configuracionesPais != null)
            {
                var cp = configuracionesPais.FirstOrDefault(x => x.Codigo == configuracionPais.Codigo);
                result = cp != null && cp.ConfiguracionPaisID >= 0 && !string.IsNullOrWhiteSpace(cp.Codigo);

            }

            return result;
        }

        public virtual List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
        {
            List<BEConfiguracionOfertasHome> configuracionesOfertasHomes;

            using (var sv = new SACServiceClient())
            {
                configuracionesOfertasHomes = sv.ListarSeccionConfiguracionOfertasHome(paidId, campaniaId).ToList();
            }

            return configuracionesOfertasHomes;
        }

        private void ConfiguracionSeccionShowRoom(ref ConfiguracionSeccionHomeModel seccion)
        {
            seccion.UrlLandig = "";

            if (!sessionManager.GetEsShowRoom())
                return;

            if (sessionManager.GetMostrarShowRoomProductosExpiro())
                return;

            if (!sessionManager.GetMostrarShowRoomProductos())
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
            else
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

            titulo = revistaDigital.TieneRDC
                ? (revistaDigital.EsActiva || revistaDigital.EsSuscrita)
                    ? "OFERTAS CLUB GANA+"
                    : "OFERTAS GANA+"
                : "";

            subtitulo = userData.Sobrenombre.ToUpper() + ", PRUEBA LAS VENTAJAS DE COMPRAR OFERTAS PERSONALIZADAS";

            if (codigo == Constantes.ConfiguracionPais.OfertasParaTi)
            {
                if (revistaDigital.TieneRDC) return false;

                titulo = "MÁS OFERTAS PARA TI " + userData.Sobrenombre.ToUpper();
                subtitulo = "EXCLUSIVAS SÓLO POR WEB";
            }

            return true;
        }
        #endregion

        #region MenuContenedor
        public MenuContenedorModel GetMenuActivo(UsuarioModel userData, RevistaDigitalModel revistaDigital, HerramientasVentaModel herramientasVenta)
        {
            var contenedorPath = GetContenedorRequestPath();

            var menuActivo = CreateMenuContenedorActivo(userData.CampaniaID);
            menuActivo = UpdateCampaniaIdFromQueryString(menuActivo);
            menuActivo = UpdateCodigoCampaniaIdOrigenByContenedorPath(menuActivo, contenedorPath);
            menuActivo = UpdateConfiguracionPais(menuActivo, userData, revistaDigital);

            if (revistaDigital.TieneRDC || herramientasVenta.TieneHV)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
                menuActivo.CampaniaX1 = AddCampaniaAndNumero(userData.CampaniaID, 1);
            }
            if (revistaDigital.TieneRDI)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
            }

            sessionManager.SetMenuContenedorActivo(menuActivo);

            return menuActivo;
        }

        private MenuContenedorModel UpdateConfiguracionPais(MenuContenedorModel menuActivo, UsuarioModel userData, RevistaDigitalModel revistaDigital)
        {
            var menuContenedor = BuildMenuContenedor(userData, revistaDigital, guiaNegocio);
            menuActivo.ConfiguracionPais = GetConfiguracionPaisBy(menuContenedor, menuActivo, userData);
            return menuActivo;
        }

        private MenuContenedorModel UpdateCodigoCampaniaIdOrigenByContenedorPath(MenuContenedorModel menuActivo, string contenedorPath)
        {
            switch (contenedorPath)
            {
                case Constantes.UrlMenuContenedor.Inicio:
                case Constantes.UrlMenuContenedor.InicioIndex:
                case Constantes.UrlMenuContenedor.RdInicio:
                case Constantes.UrlMenuContenedor.RdInicioIndex:
                    menuActivo.Codigo = revistaDigital.TieneRevistaDigital() ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MContenedorHome
                        : Constantes.OrigenPantallaWeb.DContenedorHome;
                    break;
                case Constantes.UrlMenuContenedor.InicioRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRevistaDigital() ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
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
                case Constantes.UrlMenuContenedor.LanDetalle:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Lanzamiento;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalDetalle
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalDetalle;
                    break;
                case Constantes.UrlMenuContenedor.SwInicio:
                case Constantes.UrlMenuContenedor.SwIntriga:
                case Constantes.UrlMenuContenedor.SwDetalle:
                case Constantes.UrlMenuContenedor.SwInicioIndex:
                case Constantes.UrlMenuContenedor.SwPersonalizado:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.ShowRoom;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MShowRoom
                        : Constantes.OrigenPantallaWeb.DShowRoom;
                    break;
                case Constantes.UrlMenuContenedor.OptDetalle:
                    menuActivo.Codigo = GetMenuActivoOptCodigoSegunActivo(GetOrigenFromQueryString());
                    if (menuActivo.Codigo == "")
                        menuActivo = sessionManager.GetMenuContenedorActivo();
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
                case Constantes.UrlMenuContenedor.HerramientasVentaIndex:
                case Constantes.UrlMenuContenedor.HerramientasVentaComprar:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.HerramientasVenta;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MHerramientaVenta
                        : Constantes.OrigenPantallaWeb.DHerramientaVenta;
                    break;
                case Constantes.UrlMenuContenedor.HerramientasVentaRevisar:
                    menuActivo.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                    menuActivo.Codigo = Constantes.ConfiguracionPais.HerramientasVenta;
                    menuActivo.OrigenPantalla = IsMobile()
                        ? Constantes.OrigenPantallaWeb.MHerramientaVenta
                        : Constantes.OrigenPantallaWeb.DHerramientaVenta;
                    break;
            }

            return menuActivo;
        }

        private MenuContenedorModel UpdateCampaniaIdFromQueryString(MenuContenedorModel menuActivo)
        {
            var qsCampaniaId = GetCampaniaIdFromQueryString();
            int campaniaid;
            if (int.TryParse(Util.Trim(qsCampaniaId), out campaniaid))
            {
                menuActivo.CampaniaId = campaniaid;
            }
            return menuActivo;
        }

        private MenuContenedorModel CreateMenuContenedorActivo(int campaniaId)
        {
            return new MenuContenedorModel { CampaniaId = campaniaId };
        }

        protected virtual string GetContenedorRequestPath()
        {
            var path = GetRequestPath();
            path = path.ToLower().Replace("/mobile", "");
            if (path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) >= 0)
                path = path.Substring(path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) + 39);

            var pathStrings = path.Split('/');
            var newPath = "";
            newPath += "/" + (pathStrings.Length > 1 ? pathStrings[1] : "");
            newPath += "/" + (pathStrings.Length > 2 ? pathStrings[2] : "");
            newPath = newPath.EndsWith("/") ? newPath.Substring(0, newPath.Length - 1) : newPath;
            newPath = newPath.ToLower();

            return newPath;
        }

        protected virtual string GetRequestPath()
        {
            return Request.Path;
        }

        protected virtual string GetCampaniaIdFromQueryString()
        {
            string campaniaIdStr;
            const string qsCamapaniaId = "campaniaid";
            campaniaIdStr = GetQueryStringValue(qsCamapaniaId);

            return campaniaIdStr;
        }

        protected virtual string GetOrigenFromQueryString()
        {
            string pathOrigen;
            const string qsOrigen = "origen";
            pathOrigen = GetQueryStringValue(qsOrigen);
            return pathOrigen;
        }

        protected virtual string GetQueryStringValue(string key)
        {
            return Util.Trim(Request.QueryString[key]);
        }

        private ConfiguracionPaisModel GetConfiguracionPaisBy(List<ConfiguracionPaisModel> menuContenedor, MenuContenedorModel menuActivo, UsuarioModel userData)
        {
            var configuracionPaisMenu = menuContenedor.FirstOrDefault(m => m.Codigo == menuActivo.Codigo && m.CampaniaId == menuActivo.CampaniaId);

            if (menuActivo.Codigo == Constantes.ConfiguracionPais.Informacion && revistaDigital.TieneRevistaDigital())
                configuracionPaisMenu = menuContenedor.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.InicioRD && m.CampaniaId == userData.CampaniaID);
            else if (menuActivo.Codigo == Constantes.ConfiguracionPais.Informacion && !revistaDigital.TieneRevistaDigital())
                configuracionPaisMenu = menuContenedor.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.Inicio && m.CampaniaId == userData.CampaniaID);

            configuracionPaisMenu = configuracionPaisMenu ?? new ConfiguracionPaisModel() { Codigo = Constantes.ConfiguracionPais.Inicio, CampaniaId = userData.CampaniaID };

            return configuracionPaisMenu;
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

        public List<ConfiguracionPaisModel> GetMenuContenedorByMenuActivoCampania(int campaniaIdMenuActivo, int campaniaIdUsuario)
        {
            var menuContenedor = BuildMenuContenedor(userData, revistaDigital, guiaNegocio);

            menuContenedor = menuContenedor.Where(e => e.CampaniaId == campaniaIdMenuActivo).ToList();

            if (campaniaIdMenuActivo == campaniaIdUsuario && !sessionManager.GetTieneLan())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (campaniaIdMenuActivo != campaniaIdUsuario && !sessionManager.GetTieneLanX1())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (!sessionManager.GetTieneOpt())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.OfertasParaTi).ToList();
            }
            if (campaniaIdMenuActivo == campaniaIdUsuario && !sessionManager.GetTieneOpm())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigital).ToList();
            }
            if (campaniaIdMenuActivo != campaniaIdUsuario && !sessionManager.GetTieneOpmX1())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigital).ToList();
            }
            if (campaniaIdMenuActivo == campaniaIdUsuario && !sessionManager.GetTieneHv())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.HerramientasVenta).ToList();
            }
            if (campaniaIdMenuActivo != campaniaIdUsuario && !sessionManager.GetTieneHvX1())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.HerramientasVenta).ToList();
            }

            return menuContenedor;
        }

        public List<ConfiguracionPaisModel> BuildMenuContenedor(UsuarioModel userData,
            RevistaDigitalModel revistaDigital, GuiaNegocioModel guiaNegocio)
        {
            var menuContenedor = sessionManager.GetMenuContenedor();
            var configuracionesPais = sessionManager.GetConfiguracionesPaisModel();

            if (menuContenedor.Any() || !configuracionesPais.Any())
                return menuContenedor;

            menuContenedor = new List<ConfiguracionPaisModel>();
            configuracionesPais = configuracionesPais.Where(c => c.TienePerfil).ToList();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var paisCarpeta = GetPaisesEsikaFromConfig().Contains(userData.CodigoISO) ? "Esika" : "Lbel";
            foreach (var confiModel in configuracionesPais)
            {
                var config = confiModel;
                config.Codigo = Util.Trim(config.Codigo).ToUpper();
                config.CampaniaId = userData.CampaniaID;
                config.DesktopFondoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.DesktopFondoBanner);
                config.DesktopLogoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.DesktopLogoBanner);
                config.MobileFondoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.MobileFondoBanner);
                config.MobileLogoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.MobileLogoBanner);

                if (revistaDigital.TieneRDI)
                {
                    config.DesktopFondoBanner = revistaDigital.BannerOfertasNoActivaNoSuscrita;
                    config.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
                    config.MobileFondoBanner = string.Empty;
                    config.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                }
                if (revistaDigital.TieneRevistaDigital())
                {
                    config.DesktopFondoBanner = revistaDigital.BannerOfertasNoActivaNoSuscrita;
                    config.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
                    config.MobileFondoBanner = string.Empty;
                    config.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                    if (revistaDigital.EsSuscrita)
                    {
                        config.DesktopFondoBanner = revistaDigital.BannerOfertasActivaSuscrita;
                        config.DesktopLogoBanner = revistaDigital.DLogoComercialFondoActiva;
                        config.MobileFondoBanner = string.Empty;
                        config.MobileLogoBanner = revistaDigital.MLogoComercialFondoActiva;
                    }
                }

                switch (config.Codigo)
                {
                    case Constantes.ConfiguracionPais.InicioRD:
                        if (!revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "Ofertas";
                        config.DesktopFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_ImagenFondo, config.DesktopFondoBanner);
                        config.DesktopTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_TituloBanner, config.DesktopTituloBanner);
                        config.DesktopSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_SubTituloBanner, config.DesktopSubTituloBanner);

                        config.MobileFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_ImagenFondo, config.MobileFondoBanner);
                        config.MobileTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_TituloBanner, config.MobileTituloBanner);
                        config.MobileSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_SubTituloBanner, config.MobileSubTituloBanner);

                        config.DesktopLogoMenu = "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.svg";
                        config.MobileLogoMenu = "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.svg";
                        if (!revistaDigital.EsSuscrita && !string.IsNullOrEmpty(revistaDigital.DLogoMenuInicioNoActiva))
                        {
                            config.DesktopLogoMenu = revistaDigital.DLogoMenuInicioNoActiva;
                        }
                        if (revistaDigital.EsSuscrita && !string.IsNullOrEmpty(revistaDigital.DLogoMenuInicioActiva))
                        {
                            config.DesktopLogoMenu = revistaDigital.DLogoMenuInicioActiva;
                        }
                        if (!revistaDigital.EsSuscrita && !string.IsNullOrEmpty(revistaDigital.MLogoMenuInicioNoActiva))
                        {
                            config.MobileLogoMenu = revistaDigital.MLogoMenuInicioNoActiva;
                        }
                        if (revistaDigital.EsSuscrita && !string.IsNullOrEmpty(revistaDigital.MLogoMenuInicioActiva))
                        {
                            config.MobileLogoMenu = revistaDigital.MLogoMenuInicioActiva;
                        }
                        config.Descripcion = string.Empty;
                        config = ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;

                    case Constantes.ConfiguracionPais.Inicio:
                        if (revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "Ofertas";

                        config.DesktopFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenFondo, config.DesktopFondoBanner);
                        config.DesktopLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenLogo, config.DesktopLogoBanner);
                        config.DesktopTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_TituloBanner, config.DesktopTituloBanner);
                        config.DesktopSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_SubTituloBanner, config.DesktopSubTituloBanner);

                        config.MobileFondoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenFondo, config.MobileFondoBanner);
                        config.MobileLogoBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenLogo, config.MobileLogoBanner);
                        config.MobileTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_TituloBanner, config.MobileTituloBanner);
                        config.MobileSubTituloBanner = EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_SubTituloBanner, config.MobileSubTituloBanner);

                        config.DesktopLogoMenu = "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.svg";
                        config.MobileLogoMenu = "/Content/Images/" + paisCarpeta + "/Contenedor/inicio_normal.svg";
                        config.Descripcion = string.Empty;
                        config = ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;
                    case Constantes.ConfiguracionPais.ShowRoom:
                        if (!sessionManager.GetEsShowRoom())
                            continue;

                        config.UrlMenu = string.Empty;
                        if (!sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            config.UrlMenu = "ShowRoom/Intriga";
                        }

                        if (sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            config.UrlMenu = "ShowRoom";

                        }
                        if (config.UrlMenu == "")
                            continue;

                        break;
                    case Constantes.ConfiguracionPais.OfertaDelDia:
                        if (!userData.TieneOfertaDelDia)
                            continue;

                        config.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        if (!revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                        if (revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "RevistaDigital/Comprar";
                        config = ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        if (!revistaDigital.TieneRDC)
                            continue;

                        config.UrlMenu = "RevistaDigital/Comprar";
                        config = ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;
                    case Constantes.ConfiguracionPais.OfertasParaTi:
                        if (revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                        if (!GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                            continue;

                        config.UrlMenu = "GuiaNegocio";
                        break;
                    case Constantes.ConfiguracionPais.HerramientasVenta:
                        confiModel.UrlMenu = "HerramientasVenta/Comprar";
                        break;
                }

                config = ActualizarTituloYSubtituloMenu(config);
                config = RemplazarTagNombre(config, Constantes.TagCadenaRd.Nombre1, userData.Sobrenombre);

                menuContenedor.Add(config);
            }

            menuContenedor.AddRange(BuildMenuContenedorBloqueado(menuContenedor));
            menuContenedor = OrdenarMenuContenedor(menuContenedor, revistaDigital.TieneRevistaDigital());

            sessionManager.SetMenuContenedor(menuContenedor);
            return menuContenedor;
        }
        private ConfiguracionPaisModel ActualizarTituloYSubtituloBanner(ConfiguracionPaisModel cp, RevistaDigitalModel revistaDigital)
        {
            var codigo = string.Empty;
            var codigoMobile = string.Empty;

            if (cp.Codigo == Constantes.ConfiguracionPais.Inicio &&
                revistaDigital.TieneRDI)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RDI.DLandingBannerIntriga;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RDI.MLandingBannerIntriga;
            }

            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdActivaNoSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdNoActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdNoActivaNoSuscrita;
            }

            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerActivaSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerActivaNoSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerActivaNoSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerNoActivaSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerNoActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerNoActivaNoSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerNoActivaNoSuscrita;
            }

            if (!string.IsNullOrEmpty(codigo))
            {
                var datoDesktop = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
                cp.DesktopTituloBanner = Util.Trim(datoDesktop.Valor1);
                cp.DesktopSubTituloBanner = Util.Trim(datoDesktop.Valor2);
            }

            if (!string.IsNullOrEmpty(codigoMobile))
            {
                var datoMobile = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigoMobile) ?? new ConfiguracionPaisDatosModel();
                cp.MobileTituloBanner = Util.Trim(datoMobile.Valor1);
                cp.MobileSubTituloBanner = Util.Trim(datoMobile.Valor2);
            }


            return cp;
        }

        public List<ConfiguracionPaisModel> BuildMenuContenedorBloqueado(List<ConfiguracionPaisModel> menuContenedor)
        {
            var menuContenedorBloqueado = new List<ConfiguracionPaisModel>();
            foreach (var configuracionPais in menuContenedor)
            {
                ConfiguracionPaisModel config;
                switch (configuracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.InicioRD:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/Ofertas/Revisar";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        menuContenedorBloqueado.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "#";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        menuContenedorBloqueado.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/RevistaDigital/Revisar";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        menuContenedorBloqueado.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.HerramientasVenta:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/HerramientasVenta/Revisar";
                        config.CampaniaId = AddCampaniaAndNumero(userData.CampaniaID, 1);
                        menuContenedorBloqueado.Add(config);
                        break;
                }
            }
            return menuContenedorBloqueado;
        }

        protected virtual List<ConfiguracionPaisModel> OrdenarMenuContenedor(List<ConfiguracionPaisModel> menuContenedor, bool tieneRevistaDigital)
        {
            var esMobile = IsMobile();

            if (tieneRevistaDigital && esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.MobileOrdenBPT).ToList();
            }
            if (tieneRevistaDigital && !esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.OrdenBpt).ToList();
            }
            if (!tieneRevistaDigital && esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.MobileOrden).ToList();

            }
            if (!tieneRevistaDigital && !esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.Orden).ToList();
            }

            return menuContenedor;
        }

        #endregion

        #region RD
        public virtual MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();

            string codigo = String.Empty;
            ConfiguracionPaisDatosModel dato;
            if (revistaDigital.EsActiva)
            {
                model.MensajeIconoSuperior = true;
                model.BtnInscribirse = false;

                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaSuscrita;
                dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
                model.MensajeTitulo = Util.Trim(dato.Valor1);
                return model;
            }
            else
            {
                model.MensajeIconoSuperior = false;
                model.BtnInscribirse = !revistaDigital.EsSuscrita;

                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaNoSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaNoSuscrita;
                dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
                model.MensajeTitulo = Util.Trim(dato.Valor1);
            }

            if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            {
                model.MensajeBtnPopup = "DE ACUERDO";
                model.IdPopup = !model.IsMobile ? "divSNAPopupBloqueadoDesk" : "divSNAPopupBloqueadoMob";
                model.UrlBtnPopup = "javascript: void(0)";

                codigo = Constantes.ConfiguracionPaisDatos.RD.PopupBloqueadoSNA;
            }
            else if (!revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            {
                model.MensajeBtnPopup = "SUSCRIBETE GRATIS";
                model.IdPopup = !model.IsMobile ? "divNSPopupBloqueadoDesk" : "divNSPopupBloqueadoMob";
                model.UrlBtnPopup = (model.IsMobile ? "/Mobile" : "") + "/RevistaDigital/Informacion/";

                codigo = Constantes.ConfiguracionPaisDatos.RD.PopupBloqueadoNS;
            }

            dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            model.MensajePopupPrimero = RemplazaTag(dato.Valor1, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));
            model.MensajePopupSegundo = RemplazaTag(dato.Valor2, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));

            return model;
        }
        #endregion

        #region Guia de Negocio Digitalizada
        public virtual bool GNDValidarAcceso(bool esConsultoraLider, GuiaNegocioModel guiaNegocio, RevistaDigitalModel revistaDigital)
        {
            var tieneAcceso = (guiaNegocio.TieneGND && !(revistaDigital.EsSuscritaActiva() || revistaDigital.EsNoSuscritaActiva())) ||
                (esConsultoraLider && guiaNegocio.TieneGND && revistaDigital.SociaEmpresariaExperienciaGanaMas && revistaDigital.EsSuscritaActiva());
            return tieneAcceso;
        }
        #endregion

        #region Helper contenedor 
        private ConfiguracionPaisModel ActualizarTituloYSubtituloMenu(ConfiguracionPaisModel config)
        {
            if (config == null) return config;

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
            return config;
        }

        private void RemplazarTagNombreConfiguracionOferta(ref BEConfiguracionOfertasHome config, string tag, string valor)
        {
            config.DesktopTitulo = RemplazaTag(config.DesktopTitulo, tag, valor);
            config.DesktopSubTitulo = RemplazaTag(config.DesktopSubTitulo, tag, valor);
            config.MobileTitulo = RemplazaTag(config.MobileTitulo, tag, valor);
            config.MobileSubTitulo = RemplazaTag(config.MobileSubTitulo, tag, valor);
        }

        private ConfiguracionPaisModel RemplazarTagNombre(ConfiguracionPaisModel config, string tag, string valor)
        {
            if (config == null || string.IsNullOrEmpty(tag)) return config;

            config.DesktopTituloBanner = RemplazaTag(config.DesktopTituloBanner, tag, valor);
            config.DesktopSubTituloBanner = RemplazaTag(config.DesktopSubTituloBanner, tag, valor);
            config.MobileTituloBanner = RemplazaTag(config.MobileTituloBanner, tag, valor);
            config.MobileSubTituloBanner = RemplazaTag(config.MobileSubTituloBanner, tag, valor);
            config.DesktopTituloMenu = RemplazaTag(config.DesktopTituloMenu, tag, valor);
            config.DesktopSubTituloMenu = RemplazaTag(config.DesktopSubTituloMenu, tag, valor);
            config.MobileTituloMenu = RemplazaTag(config.MobileTituloMenu, tag, valor);
            config.MobileSubTituloMenu = RemplazaTag(config.MobileSubTituloMenu, tag, valor);

            return config;
        }

        public string RemplazaTag(string cadena, string tag, string valor)
        {
            cadena = cadena ?? "";
            tag = tag ?? "";
            valor = valor ?? "";

            cadena = cadena.Replace(tag, valor);
            cadena = cadena.Replace(tag.ToLower(), valor);
            cadena = cadena.Replace(tag.ToUpper(), valor);

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

        protected List<ServicePedido.BETipoEstrategia> GetTipoEstrategias()
        {
            List<ServicePedido.BETipoEstrategia> tiposEstrategia;
            var entidad = new ServicePedido.BETipoEstrategia
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

            return Util.Trim(keyvalor);
        }

        public bool GetConfiguracionManagerContains(string key, string compara)
        {
            var keyCongi = GetConfiguracionManager(key);
            return keyCongi.Contains(compara);
        }

        #endregion

        #region Resize Imagen Default       

        public string ImagenesResizeProceso(string urlImagen, bool esAppCalatogo = false)
        {
            string mensajeErrorImagenResize = "";
            bool actualizar = true;
            var listaImagenesResize = ObtenerListaImagenesResize(urlImagen, esAppCalatogo, actualizar);
            if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                mensajeErrorImagenResize = MagickNetLibrary.GuardarImagenesResize(listaImagenesResize, actualizar);
            return mensajeErrorImagenResize;
        }

        public List<EntidadMagickResize> ObtenerListaImagenesResize(string rutaImagen, bool esAppCalatogo = false, bool actualizar = false)
        {
            var listaImagenesResize = new List<EntidadMagickResize>();

            if (Util.ExisteUrlRemota(rutaImagen))
            {
                var rutaImagenSmall = "";
                var rutaImagenMedium = "";

                if (esAppCalatogo)
                {
                    string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                    string soloExtension = Path.GetExtension(rutaImagen);

                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    var extensionNombreImagenSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall;
                    var extensionNombreImagenMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium;

                    rutaImagenSmall = ConfigCdn.GetUrlFileCdn(carpetaPais, soloImagen + extensionNombreImagenSmall + soloExtension);
                    rutaImagenMedium = ConfigCdn.GetUrlFileCdn(carpetaPais, soloImagen + extensionNombreImagenMedium + soloExtension);
                }
                else
                {
                    rutaImagenSmall = Util.GenerarRutaImagenResize(rutaImagen, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall);
                    rutaImagenMedium = Util.GenerarRutaImagenResize(rutaImagen, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium);
                }

                var listaValoresImagenesResize = ObtenerParametrosTablaLogica(Constantes.PaisID.Peru, Constantes.TablaLogica.ValoresImagenesResize, true);

                int ancho = 0;
                int alto = 0;

                EntidadMagickResize entidadResize;
                if (!Util.ExisteUrlRemota(rutaImagenSmall) || actualizar)
                {
                    GetDimensionesImagen(rutaImagen, listaValoresImagenesResize, Constantes.ConfiguracionImagenResize.TipoImagenSmall, out alto, out ancho);

                    if (ancho > 0 && alto > 0)
                    {
                        entidadResize = new EntidadMagickResize
                        {
                            RutaImagenOriginal = rutaImagen,
                            RutaImagenResize = rutaImagenSmall,
                            Width = ancho,
                            Height = alto,
                            TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenSmall,
                            CodigoIso = userData.CodigoISO
                        };
                        listaImagenesResize.Add(entidadResize);
                    }
                }

                if (!Util.ExisteUrlRemota(rutaImagenMedium) || actualizar)
                {
                    GetDimensionesImagen(rutaImagen, listaValoresImagenesResize, Constantes.ConfiguracionImagenResize.TipoImagenMedium, out alto, out ancho);

                    if (ancho > 0 && alto > 0)
                    {
                        entidadResize = new EntidadMagickResize
                        {
                            RutaImagenOriginal = rutaImagen,
                            RutaImagenResize = rutaImagenMedium,
                            Width = ancho,
                            Height = alto,
                            TipoImagen = Constantes.ConfiguracionImagenResize.TipoImagenMedium,
                            CodigoIso = userData.CodigoISO
                        };
                        listaImagenesResize.Add(entidadResize);
                    }
                }
            }

            return listaImagenesResize;
        }

        private void GetDimensionesImagen(string urlImagen, List<TablaLogicaDatosModel> datosImg, string tipoImg, out int alto, out int ancho)
        {
            ancho = 0;
            alto = 0;

            if (!datosImg.Any())
                return;

            // valores estandar de base de datos
            var hBase = 0;
            var wMax = 0;
            if (tipoImg == Constantes.ConfiguracionImagenResize.TipoImagenSmall)
            {
                hBase = ObtenerValorTablaLogicaInt(datosImg, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightSmall);
                wMax = ObtenerValorTablaLogicaInt(datosImg, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMaxSmall);
            }
            else if (tipoImg == Constantes.ConfiguracionImagenResize.TipoImagenMedium)
            {
                hBase = ObtenerValorTablaLogicaInt(datosImg, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightMedium);
                wMax = ObtenerValorTablaLogicaInt(datosImg, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMaxMedium);
            }

            if (hBase == 0 && wMax == 0)
                return;

            // Obtener las dimensiones
            byte[] imageData = new WebClient().DownloadData(urlImagen);
            MemoryStream imgStream = new MemoryStream(imageData);
            Image img = Image.FromStream(imgStream);

            imgStream.Close();

            ancho = img.Width;
            alto = img.Height;

            img.Dispose();

            // calculo matematico para escalar
            if (alto > hBase && hBase > 0)
            {
                ancho = Convert.ToInt32(ancho * (Convert.ToDecimal(hBase) / Convert.ToDecimal(alto)));
                alto = hBase;
            }
            if (ancho > wMax && wMax > 0)
            {
                alto = Convert.ToInt32(alto * (Convert.ToDecimal(wMax) / Convert.ToDecimal(ancho)));
                ancho = wMax;
            }
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

            ViewBag.Dias = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            ViewBag.PeriodoAnalytics = userData.FechaHoy >= userData.FechaInicioCampania.Date && userData.FechaHoy <= userData.FechaFinCampania.Date ? "Facturacion" : "Venta";
            ViewBag.SemanaAnalytics = "No Disponible";

            #region mensaje Cierre Campania y fecha promesa

            DateTime FechaHoraActual = DateTime.Now.AddHours(userData.ZonaHoraria);
            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var TextoPromesaEspecial = false;
            var TextoPromesa = ".";
            var TextoNuevoPROL = "";

            if (!userData.ZonaValida) ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
            else if (!userData.DiaPROL)
            {
                ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                if (!("BO CL VE").Contains(userData.CodigoISO)) TextoNuevoPROL = " Revisa tus notificaciones o correo y verifica que tu pedido esté completo.";
            }
            else
            {
                if (userData.DiasCampania != 0 && FechaHoraActual < userData.FechaInicioCampania)
                {
                    ViewBag.MensajeCierreCampania = "Pasa tu pedido hasta el <b>" + userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month) + "</b> a las <b>" + FormatearHora(HoraCierrePortal) + "</b>";
                }
                else
                {
                    ViewBag.MensajeCierreCampania = "Pasa o modifica tu pedido hasta el día de <b>hoy a las " + FormatearHora(HoraCierrePortal) + "</b>";
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
                        TextoPromesa = " Recibirás tu pedido el <b>" + userData.FechaPromesaEntrega.Day + " de " + NombreMes(userData.FechaPromesaEntrega.Month) + "</b>.";

                    else
                        TextoPromesa = " y recíbelo el <b>" + userData.FechaPromesaEntrega.Day + " de " + NombreMes(userData.FechaPromesaEntrega.Month) + "</b>.";
                }
            }

            ViewBag.MensajeCierreCampania = ViewBag.MensajeCierreCampania + TextoPromesa + TextoNuevoPROL;
            ViewBag.MensajeFechaPromesa = GetFechaPromesa(HoraCierrePortal, ViewBag.Dias);

            #endregion

            ViewBag.FechaFacturacionPedido = userData.FechaFacturacion.Day + " de " + NombreMes(userData.FechaFacturacion.Month);
            ViewBag.QSBR = string.Format("NOMB={0}&PAIS={1}&CODI={2}&CORR={3}&TELF={4}", userData.NombreConsultora.ToUpper(), userData.CodigoISO, userData.CodigoConsultora, userData.EMail, (userData.Telefono ?? "").Trim() + ((userData.Celular ?? "").Trim() == string.Empty ? "" : "; " + (userData.Celular ?? "").Trim()));
            ViewBag.QSBR = ViewBag.QSBR.Replace("\n", "").Trim();

            ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
            ViewBag.NombreC = userData.PrimerNombre;
            ViewBag.ApellidoC = userData.PrimerApellido;
            ViewBag.CorreoC = userData.EMail;
            ViewBag.Lider = userData.Lider;
            ViewBag.PortalLideres = userData.PortalLideres;
            ViewBag.TokenAtento = ConfigurationManager.AppSettings["TokenAtento_" + userData.CodigoISO];
            ViewBag.FormatDecimalPais = GetFormatDecimalPais(userData.CodigoISO);
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

                ViewBag.TieneOfertaDelDia = CumpleOfertaDelDia();
                ViewBag.MostrarOfertaDelDiaContenedor = userData.TieneOfertaDelDia;

                var configuracionPaisOdd = sessionManager.GetConfiguracionesPaisModel().FirstOrDefault(p => p.Codigo == Constantes.ConfiguracionPais.OfertaDelDia);
                configuracionPaisOdd = configuracionPaisOdd ?? new ConfiguracionPaisModel();
                ViewBag.CodigoAnclaOdd = configuracionPaisOdd.Codigo;

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
            ViewBag.variableBase = getBaseVariablesPortal();

            ViewBag.TituloCatalogo = ((revistaDigital.TieneRDC && !userData.TieneGND && !revistaDigital.EsSuscrita) || revistaDigital.TieneRDI)
                || (!revistaDigital.TieneRDC || (revistaDigital.TieneRDC && !revistaDigital.EsActiva));

            var menuActivo = GetMenuActivo(userData, revistaDigital, herramientasVenta);
            ViewBag.MenuContenedorActivo = menuActivo;
            ViewBag.MenuContenedor = GetMenuContenedorByMenuActivoCampania(menuActivo.CampaniaId, userData.CampaniaID);

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
            ViewBag.CodigoEstrategia = GetCodigoEstrategia();
            ViewBag.BannerInferior = _showRoomProvider.EvaluarBannerConfiguracion(userData.PaisID, sessionManager);
            ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
            int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
            if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

            ViewBag.HabilitarChatEmtelco = HabilitarChatEmtelco(userData.PaisID);
        }

        private VariablesGeneralesPortalModel getBaseVariablesPortal()
        {
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var baseVariablesGeneral = new VariablesGeneralesPortalModel
            {
                UrlCompartir = Util.GetUrlCompartirFB(userData.CodigoISO),
                ExtensionImgSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall,
                //ExtensionImgMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium,
                ImgUrlBase = ConfigCdn.GetUrlCdn(carpetaPais),
                SimboloMoneda = userData.Simbolo
            };

            return baseVariablesGeneral;

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

        private string GetFechaPromesa(TimeSpan horaCierre, int diasFaltantes)
        {
            var time = DateTime.Today.Add(horaCierre);
            string fecha = null;

            if (IsMobile())
            {
                string hrCierrePortal = time.ToString("hh:mm tt").Replace(". ", "").ToUpper();

                fecha = diasFaltantes > 0
                    ? " CIERRA EL " + userData.FechaInicioCampania.Day + " " + NombreMes(userData.FechaInicioCampania.Month).ToUpper()
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

        protected string GetBucketNameFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.BUCKET_NAME);
        }

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
                var urlService = GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_PDF_NEW);
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
                var urlService = GetConfiguracionManager(Constantes.ConfiguracionManager.WS_RV_Campanias_NEW);
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

        public List<BEComunicado> ObtenerComunicadoPorConsultora()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = sac.ObtenerComunicadoPorConsultora(UserData().PaisID, UserData().CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Desktop, UserData().CodigorRegion, UserData().CodigoZona, UserData().ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }

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

        public string GetUrlTerminosCondicionesDatosUsuario()
        {
            var nombreCarpetaTc = GetConfiguracionManager(Constantes.ConfiguracionManager.NombreCarpetaTC);
            var nombreArchivoTc = GetConfiguracionManager(Constantes.ConfiguracionManager.NombreArchivoTC) + ".pdf";
            return ConfigCdn.GetUrlFileCdn(nombreCarpetaTc, userData.CodigoISO + "/" + nombreArchivoTc);
        }

        public void GetLimitNumberPhone(out int limiteMinimoTelef, out int limiteMaximoTelef)
        {
            switch (userData.PaisID)
            {
                case Constantes.PaisID.Mexico:
                    limiteMinimoTelef = 5;
                    limiteMaximoTelef = 15;
                    break;
                case Constantes.PaisID.Peru:
                    limiteMinimoTelef = 7;
                    limiteMaximoTelef = 9;
                    break;
                case Constantes.PaisID.Colombia:
                    limiteMinimoTelef = 10;
                    limiteMaximoTelef = 10;
                    break;
                case Constantes.PaisID.Guatemala:
                case Constantes.PaisID.ElSalvador:
                case Constantes.PaisID.Panama:
                case Constantes.PaisID.CostaRica:
                    limiteMinimoTelef = 8;
                    limiteMaximoTelef = 8;
                    break;
                case Constantes.PaisID.Ecuador:
                    limiteMinimoTelef = 9;
                    limiteMaximoTelef = 10;
                    break;
                default:
                    limiteMinimoTelef = 0;
                    limiteMaximoTelef = 15;
                    break;
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

        #region PagoEnLinea

        public PagoEnLineaModel ObtenerValoresPagoEnLinea()
        {
            var model = new PagoEnLineaModel();

            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.MontoDeuda = userData.MontoDeuda;
            model.FechaVencimiento = userData.FechaLimPago;

            var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

            var porcentajeGastosAdministrativosString = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.PorcentajeGastosAdministrativos);
            int porcentajeGastosAdministrativos;
            bool esInt = int.TryParse(porcentajeGastosAdministrativosString, out porcentajeGastosAdministrativos);

            model.PorcentajeGastosAdministrativos = esInt ? porcentajeGastosAdministrativos : 0;

            return model;
        }

        public PagoVisaModel ObtenerValoresPagoVisa(PagoEnLineaModel model)
        {
            var pagoVisaModel = new PagoVisaModel();

            #region Valores Configuracion Pago En Linea

            var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

            pagoVisaModel.MerchantId = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MerchantId);
            pagoVisaModel.AccessKeyId = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.AccessKeyId);
            pagoVisaModel.SecretAccessKey = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.SecretAccessKey);
            pagoVisaModel.UrlSessionBotonPagos = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlSessionBotonPago);
            pagoVisaModel.UrlGenerarNumeroPedido = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlGenerarNumeroPedido);
            pagoVisaModel.UrlLibreriaPagoVisa = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLibreriaPagoVisa);
            pagoVisaModel.SessionToken = Guid.NewGuid().ToString().ToUpper();

            #endregion

            pagoVisaModel.Amount = model.MontoDeudaConGastos;

            #region Generar Sesión para el boton de pagos

            string urlCreateSessionTokenAPI = pagoVisaModel.UrlSessionBotonPagos + pagoVisaModel.MerchantId;

            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(pagoVisaModel.AccessKeyId + ":" + pagoVisaModel.SecretAccessKey));

            DataToken datatoken = new DataToken();
            datatoken.amount = Convert.ToDouble(pagoVisaModel.Amount.ToString());

            string json = JsonHelper.JsonSerializer<DataToken>(datatoken);

            HttpWebRequest requestSesion;
            requestSesion = WebRequest.Create(urlCreateSessionTokenAPI) as HttpWebRequest;
            requestSesion.Method = "POST";
            requestSesion.ContentType = "application/json";
            requestSesion.Headers.Add("Authorization", "Basic " + credentials);
            requestSesion.Headers.Add("VisaNet-Session-Key", pagoVisaModel.SessionToken);

            StreamWriter postStreamWriterSesion = new StreamWriter(requestSesion.GetRequestStream());
            postStreamWriterSesion.Write(json);
            postStreamWriterSesion.Close();

            HttpWebResponse responseSesion;
            responseSesion = requestSesion.GetResponse() as HttpWebResponse;
            StreamReader postStreamReaderSesion = new StreamReader(responseSesion.GetResponseStream());

            postStreamReaderSesion.ReadToEnd();
            postStreamReaderSesion.Close();

            #endregion

            #region Generar Número de Pedido

            string urlNextCounterAPI = pagoVisaModel.UrlGenerarNumeroPedido + pagoVisaModel.MerchantId + "/nextCounter";
            HttpWebRequest requestNumPedido;
            requestNumPedido = WebRequest.Create(urlNextCounterAPI) as HttpWebRequest;
            requestNumPedido.Method = "GET";
            requestNumPedido.ContentType = "application/json";
            requestNumPedido.Headers.Add("Authorization", "Basic " + credentials);

            HttpWebResponse responseNumPedido;
            responseNumPedido = requestNumPedido.GetResponse() as HttpWebResponse;
            StreamReader postStreamReaderNumPedido = new StreamReader(responseNumPedido.GetResponseStream());

            pagoVisaModel.PurchaseNumber = postStreamReaderNumPedido.ReadToEnd();
            postStreamReaderNumPedido.Close();

            #endregion

            #region Variables para el formulario de pago visa

            pagoVisaModel.MerchantLogo = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLogoPasarelaPago);
            pagoVisaModel.FormButtonColor = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.ColorBotonPagarPasarelaPago);
            pagoVisaModel.Recurrence = "FALSE";
            pagoVisaModel.RecurrenceFrequency = "";
            pagoVisaModel.RecurrenceType = "";
            pagoVisaModel.RecurrenceAmount = "0.00";

            #endregion

            #region Obtener Token de Tarjeta Guardada

            var tokenTarjetaGuardada = "";

            try
            {
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    tokenTarjetaGuardada = ps.ObtenerTokenTarjetaGuardadaByConsultora(userData.PaisID, userData.CodigoConsultora);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
                tokenTarjetaGuardada = "";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
                tokenTarjetaGuardada = "";
            }

            pagoVisaModel.TokenTarjetaGuardada = tokenTarjetaGuardada;

            #endregion

            return pagoVisaModel;
        }

        public bool ProcesarPagoVisa(ref PagoEnLineaModel model, string transactionToken)
        {
            var resultado = false;

            try
            {
                string sessionToken = model.PagoVisaModel.SessionToken;
                string merchantId = model.PagoVisaModel.MerchantId;
                string accessKeyId = model.PagoVisaModel.AccessKeyId;
                string secretAccessKey = model.PagoVisaModel.SecretAccessKey;

                var respuestaAutorizacion = GenerarAutorizacionBotonPagos(sessionToken, merchantId, transactionToken, accessKeyId, secretAccessKey);
                var respuestaVisa = JsonHelper.JsonDeserialize<RespuestaAutorizacionVisa>(respuestaAutorizacion);

                BEPagoEnLineaResultadoLog bePagoEnLinea = GenerarEntidadPagoEnLineaLog(respuestaVisa);
                bePagoEnLinea.MontoPago = model.MontoDeuda;
                bePagoEnLinea.MontoGastosAdministrativos = model.MontoGastosAdministrativos;

                int pagoEnLineaResultadoLogId = 0;
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    pagoEnLineaResultadoLogId = ps.InsertPagoEnLineaResultadoLog(userData.PaisID, bePagoEnLinea);
                }

                // Requerido en pago rechazado.
                model.NumeroOperacion = bePagoEnLinea.NumeroOrdenTienda;
                model.FechaCreacion = bePagoEnLinea.FechaTransaccion;
                model.DescripcionCodigoAccion = bePagoEnLinea.DescripcionCodigoAccion;

                if (bePagoEnLinea.CodigoError == "0" && bePagoEnLinea.CodigoAccion == "000")
                {
                    model.PagoEnLineaResultadoLogId = pagoEnLineaResultadoLogId;
                    model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                    model.PrimerApellido = userData.PrimerApellido;
                    model.TarjetaEnmascarada = bePagoEnLinea.NumeroTarjeta;
                    model.FechaVencimiento = userData.FechaLimPago;
                    model.SaldoPendiente = decimal.Round(userData.MontoDeuda - model.MontoDeuda, 2);

                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        ps.UpdateMontoDeudaConsultora(userData.PaisID, userData.CodigoConsultora, model.SaldoPendiente);
                    }

                    var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
                    var mensajeExitoso = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MensajeInformacionPagoExitoso);

                    model.MensajeInformacionPagoExitoso = mensajeExitoso;

                    userData.MontoDeuda = model.SaldoPendiente;
                    sessionManager.SetUserData(userData);

                    if (!string.IsNullOrEmpty(userData.EMail))
                    {
                        string template = ObtenerTemplatePagoEnLinea(model);
                        Util.EnviarMail("no-responder@somosbelcorp.com", userData.EMail, "PAGO EN LINEA", template, true, userData.NombreConsultora);
                    }

                    resultado = true;
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            sessionManager.SetDatosPagoVisa(null);
            Session["ListadoEstadoCuenta"] = null;

            return resultado;
        }

        public string GenerarAutorizacionBotonPagos(string sessionToken, string merchantId, string transactionToken, string accessKeyId, string secretAccessKey)
        {
            var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
            string urlAutorizacionBotonPago = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlAutorizacionBotonPago);

            string urlAuthorize = urlAutorizacionBotonPago + merchantId;
            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(accessKeyId + ":" + secretAccessKey));

            Common.PagoEnLinea.Data data = new Common.PagoEnLinea.Data();

            DataRequestAut dataAutorizacionRQ = new DataRequestAut();
            dataAutorizacionRQ.transactionToken = transactionToken;
            dataAutorizacionRQ.sessionToken = sessionToken;
            dataAutorizacionRQ.data = data;

            string json = JsonHelper.JsonSerializer<DataRequestAut>(dataAutorizacionRQ);

            HttpWebRequest requestAutorizacion;
            requestAutorizacion = WebRequest.Create(urlAuthorize) as HttpWebRequest;
            requestAutorizacion.Method = "POST";
            requestAutorizacion.ContentType = "application/json";
            requestAutorizacion.Headers.Add("Authorization", "Basic " + credentials);
            StreamWriter postStreamWriterAutorizacion = new StreamWriter(requestAutorizacion.GetRequestStream());
            postStreamWriterAutorizacion.Write(json);
            postStreamWriterAutorizacion.Close();

            HttpWebResponse responseAutorizacion;
            StreamReader postStreamReaderAutorizacion;
            string respuestaAutorizacion;
            try
            {
                responseAutorizacion = requestAutorizacion.GetResponse() as HttpWebResponse;
                postStreamReaderAutorizacion = new StreamReader(responseAutorizacion.GetResponseStream());
                respuestaAutorizacion = postStreamReaderAutorizacion.ReadToEnd();
                postStreamReaderAutorizacion.Close();
            }
            catch (WebException ex)
            {
                postStreamReaderAutorizacion = new StreamReader(ex.Response.GetResponseStream(), true);
                respuestaAutorizacion = postStreamReaderAutorizacion.ReadToEnd();
                postStreamReaderAutorizacion.Close();
            }

            return respuestaAutorizacion;
        }

        public BEPagoEnLineaResultadoLog GenerarEntidadPagoEnLineaLog(RespuestaAutorizacionVisa respuestaVisa)
        {
            BEPagoEnLineaResultadoLog bePagoEnLinea = new BEPagoEnLineaResultadoLog();

            bePagoEnLinea.ConsultoraId = userData.ConsultoraID;
            bePagoEnLinea.CodigoConsultora = userData.CodigoConsultora;
            bePagoEnLinea.NumeroDocumento = userData.DocumentoIdentidad;
            bePagoEnLinea.CampaniaId = userData.CampaniaID;
            bePagoEnLinea.FechaVencimiento = userData.FechaLimPago;
            bePagoEnLinea.TipoTarjeta = "VISA";
            bePagoEnLinea.CodigoError = respuestaVisa.errorCode ?? "";
            bePagoEnLinea.MensajeError = respuestaVisa.errorMessage ?? "";
            bePagoEnLinea.IdGuidTransaccion = respuestaVisa.transactionUUID ?? "";
            bePagoEnLinea.IdGuidExternoTransaccion = respuestaVisa.externalTransactionId ?? "";
            bePagoEnLinea.MerchantId = respuestaVisa.merchantId ?? "";
            bePagoEnLinea.IdTokenUsuario = respuestaVisa.userTokenId ?? "";
            bePagoEnLinea.AliasNameTarjeta = respuestaVisa.aliasName ?? "";

            var fechaTransaccion = string.IsNullOrEmpty(respuestaVisa.data.FECHAYHORA_TX) ? DateTime.MinValue.ToString() : respuestaVisa.data.FECHAYHORA_TX;
            bePagoEnLinea.FechaTransaccion = Convert.ToDateTime(fechaTransaccion);
            if (bePagoEnLinea.FechaTransaccion == DateTime.MinValue)
                bePagoEnLinea.FechaTransaccion = DateTime.Now;

            bePagoEnLinea.ResultadoValidacionCVV2 = respuestaVisa.data.RES_CVV2 ?? "";
            bePagoEnLinea.CsiMensaje = respuestaVisa.data.CSIMENSAJE ?? "";
            bePagoEnLinea.IdUnicoTransaccion = respuestaVisa.data.ID_UNICO ?? "";
            bePagoEnLinea.Etiqueta = respuestaVisa.data.ETICKET ?? "";
            bePagoEnLinea.RespuestaSistemAntifraude = respuestaVisa.data.DECISIONCS ?? "";
            bePagoEnLinea.CsiPorcentajeDescuento = Convert.ToDecimal(respuestaVisa.data.CSIPORCENTAJEDESCUENTO ?? "0");
            bePagoEnLinea.NumeroCuota = respuestaVisa.data.NROCUOTA ?? "";
            bePagoEnLinea.TokenTarjetaGuardada = respuestaVisa.data.cardTokenUUID ?? "";
            bePagoEnLinea.CsiImporteComercio = Convert.ToDecimal(respuestaVisa.data.CSIIMPORTECOMERCIO ?? "0");
            bePagoEnLinea.CsiCodigoPrograma = respuestaVisa.data.CSICODIGOPROGRAMA ?? "";
            bePagoEnLinea.DescripcionIndicadorComercioElectronico = respuestaVisa.data.DSC_ECI ?? "";
            bePagoEnLinea.IndicadorComercioElectronico = respuestaVisa.data.ECI ?? "";
            bePagoEnLinea.DescripcionCodigoAccion = respuestaVisa.data.DSC_COD_ACCION ?? "";
            bePagoEnLinea.NombreBancoEmisor = respuestaVisa.data.NOM_EMISOR ?? "";
            bePagoEnLinea.ImporteCuota = Convert.ToDecimal(respuestaVisa.data.IMPCUOTAAPROX ?? "0");
            bePagoEnLinea.CsiTipoCobro = respuestaVisa.data.CSITIPOCOBRO ?? "";
            bePagoEnLinea.NumeroReferencia = respuestaVisa.data.NUMREFERENCIA ?? "";
            bePagoEnLinea.Respuesta = respuestaVisa.data.RESPUESTA ?? "";
            bePagoEnLinea.NumeroOrdenTienda = respuestaVisa.data.NUMORDEN ?? "";
            bePagoEnLinea.CodigoAccion = respuestaVisa.data.CODACCION ?? "";
            bePagoEnLinea.ImporteAutorizado = Convert.ToDecimal(respuestaVisa.data.IMP_AUTORIZADO ?? "0");
            bePagoEnLinea.CodigoAutorizacion = respuestaVisa.data.COD_AUTORIZA ?? "";
            bePagoEnLinea.CodigoTienda = respuestaVisa.data.CODTIENDA ?? "";
            bePagoEnLinea.NumeroTarjeta = respuestaVisa.data.PAN ?? "";
            bePagoEnLinea.OrigenTarjeta = respuestaVisa.data.ORI_TARJETA ?? "";
            bePagoEnLinea.UsuarioCreacion = userData.CodigoUsuario;

            return bePagoEnLinea;
        }

        public string ObtenerTemplatePagoEnLinea(PagoEnLineaModel model)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_pago_en_linea.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#FORMATO_NOMBRECOMPLETO#", model.NombreConsultora + " " + model.PrimerApellido);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMEROOPERACION#", model.NumeroOperacion);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAPAGO#", model.FechaCreacionString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTODEUDA#", model.MontoDeudaString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOGASTOSADMINISTRATIVOS#", model.MontoGastosAdministrativosString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOTOTAL#", model.MontoDeudaConGastosString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_SIMBOLO#", model.Simbolo);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_SALDOPENDIENTE#", model.SaldoPendienteString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAVENCIMIENTO#", model.FechaVencimientoString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MENSAJEINFORMACION#", model.MensajeInformacionPagoExitoso);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMTARJETA#", model.TarjetaEnmascarada);

            return htmlTemplate;
        }

        #endregion

        public string ObtenerFormatoDiaMes(DateTime fecha)
        {
            string resultado = "";

            var nombreMes = Util.NombreMes(fecha.Month);

            resultado = fecha.Day + " " + nombreMes;

            return resultado;
        }

        protected bool EsFacturacion()
        {
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
            return esFacturacion;
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

        private string ObtenerDescripcionOferta(BEPedidoWebDetalle item)
        {
            var descripcion = "";
            var pedidoValidado = sessionManager.GetPedidoValidado();

            if (pedidoValidado)
            {
                if (!string.IsNullOrWhiteSpace(item.DescripcionOferta))
                {
                    descripcion = (item.DescripcionOferta.Replace("[", "")).Replace("]", "");
                }
                else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Liquidacion)
                {
                    descripcion = "OFERTA LIQUIDACIÓN";
                }
                else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Flexipago)
                {
                    descripcion = "OFERTA FLEXIPAGO";
                }
                else
                {
                    descripcion = "";
                }
            }
            else
            {
                if (item.FlagConsultoraOnline)
                {
                    descripcion = "CLIENTE ONLINE";
                }
                else
                {
                    if (item.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinal)
                    {
                        descripcion = "";
                    }
                    else if (item.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinal)
                    {
                        descripcion = "";
                    }
                    else if (!string.IsNullOrWhiteSpace(item.DescripcionOferta))
                    {
                        descripcion = item.DescripcionOferta;
                    }
                    else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Liquidacion)
                    {
                        descripcion = "OFERTA LIQUIDACIÓN";
                    }
                    else if (item.ConfiguracionOfertaID == Constantes.TipoOferta.Flexipago)
                    {
                        descripcion = "OFERTA FLEXIPAGO";
                    }
                    else if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
                    {
                        descripcion = "OFERTAS ESPECIALES GANA+";
                    }
                    else
                    {
                        descripcion = "";
                    }
                }
            }

            return descripcion;
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

        #region Revista digital y Sección DORADA
        public ConfiguracionPaisDatosModel ObtenerPerdio(int campaniaId)
        {
            var dato = new ConfiguracionPaisDatosModel();
            if (TieneProductosPerdio(campaniaId))
            {
                var codigo = "";
                bool upper = false;
                if (!revistaDigital.EsSuscrita)
                {
                    codigo = Constantes.ConfiguracionPaisDatos.RD.NSPerdiste;
                    upper = true;
                }
                else if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
                {
                    codigo = Constantes.ConfiguracionPaisDatos.RD.SNAPerdiste;
                    upper = true;
                }
                else
                {
                    codigo = IsMobile() ? Constantes.ConfiguracionPaisDatos.RD.MPerdiste : Constantes.ConfiguracionPaisDatos.RD.DPerdiste;
                }

                dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();

                dato.Valor1 = RemplazaTag(dato.Valor1, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));
                dato.Valor2 = RemplazaTag(dato.Valor2, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));

                if (upper)
                {
                    dato.Valor1 = dato.Valor1.ToUpper();
                    dato.Valor2 = dato.Valor2.ToUpper();
                }

                dato.Estado = true;
            }

            dato.Valor1 = Util.Trim(dato.Valor1);
            dato.Valor2 = Util.Trim(dato.Valor2);

            return dato;
        }

        public bool TieneProductosPerdio(int campaniaId)
        {
            if (revistaDigital.TieneRDC && !revistaDigital.EsActiva &&
                campaniaId == userData.CampaniaID)
                return true;

            return false;
        }
        #endregion
    }
}
