using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using WebGrease.Css.Extensions;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginController : Controller
    {
        private string pasoLog;
        private readonly string IP_DEFECTO = "190.187.154.154";
        private readonly string ISO_DEFECTO = "PE";
        private readonly int USUARIO_VALIDO = 3;

        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        protected ILogManager logManager = LogManager.LogManager.Instance;

        public LoginController()
        {

        }

        public LoginController(ISessionManager sessionManager)
        {
            this.sessionManager = sessionManager;
        }

        public LoginController(ILogManager logManager, ISessionManager sessionManager)
        {
            this.logManager = logManager;
            this.sessionManager = sessionManager;
        }

        [AllowAnonymous]
        public ActionResult Index(string returnUrl = null)
        {
            if (EsUsuarioAutenticado())
            {
                return EsDispositivoMovil() 
                    ? RedirectToAction("Index", "Bienvenida", new { area = "Mobile" }) 
                    : RedirectToAction("Index", "Bienvenida");
            }

            var ip = string.Empty;
            var iso = string.Empty;
            var model = new LoginModel();

            try
            {
                model.ListaPaises = ObtenerPaises();
                model.ListaEventos = ObtenerEventoFestivo(0, Constantes.EventoFestivoAlcance.LOGIN, 0);

                if (model.ListaEventos.Count == 0)
                    model.NombreClase = "fondo_estandar";
                else
                {
                    model.NombreClase = "fondo_festivo";

                    model.RutaEventoEsika =
                    (from g in model.ListaEventos
                        where g.Nombre == Constantes.EventoFestivoNombre.FONDO_ESIKA
                        select g.Personalizacion).FirstOrDefault();

                    model.RutaEventoLBel =
                    (from g in model.ListaEventos
                        where g.Nombre == Constantes.EventoFestivoNombre.FONDO_LBEL
                        select g.Personalizacion).FirstOrDefault();
                }

                if (EstaActivoBuscarIsoPorIp())
                {
                    ip = GetIpCliente();
                    iso = Util.GetISObyIPAddress(ip);

                    if (string.IsNullOrEmpty(iso))
                    {
                        ip = IP_DEFECTO;
                        iso = ISO_DEFECTO;
                    }
                }

                AsignarViewBagPorIso(iso);
                AsignarUrlRetorno(returnUrl);
                model.ListPaisAnalytics = GetLoginAnalyticsModel();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, ip, iso);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, ip, iso, "Login.GET.Index");
            }

            ViewBag.FBAppId = ConfigurationManager.AppSettings["FB_AppId"];

            return View(model);
        }

        protected virtual bool EsUsuarioAutenticado()
        {
            return HttpContext.User.Identity.IsAuthenticated;
        }

        protected virtual bool EsDispositivoMovil()
        {
            return Request.Browser.IsMobileDevice;
        }

        protected virtual IEnumerable<PaisModel> ObtenerPaises()
        {
            List<BEPais> paises;

            try
            {
                using (var sv = new ZonificacionServiceClient())
                {
                    paises = sv.SelectPaises().ToList();
                }

                paises.RemoveAll(p => p.CodigoISO == Constantes.CodigosISOPais.Argentina);
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, "ObtenerPaises", "ObtenerPaises");
                paises = new List<BEPais>
                {
                    new BEPais
                    {
                        PaisID = -1,
                        Nombre = ex.Message + " - StackTrace => " + ex.StackTrace + " - InnerException => " +
                                 ex.InnerException
                    }
                };
            }

            var paisesModel = Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(paises);
            return paisesModel;
        }

        protected List<EventoFestivoModel> ObtenerEventoFestivo(int paisId, string alcance, int campania)
        {
            List<BEEventoFestivo> lst;
            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    lst = sv.GetEventoFestivo(paisId, alcance, campania).ToList();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, campania.ToString() + " - " + alcance, paisId.ToString(), "");
                lst = new List<BEEventoFestivo>();
            }

            return Mapper.Map<IList<BEEventoFestivo>, List<EventoFestivoModel>>(lst);
        }

        protected virtual bool EstaActivoBuscarIsoPorIp()
        {
            var buscarIsoPorIp = ConfigurationManager.AppSettings.Get("BuscarISOPorIP") ?? string.Empty;
            return buscarIsoPorIp == "1";
        }

        protected virtual string GetIpCliente()
        {
            var ip = string.Empty;

            try
            {
                var request = new HttpRequestWrapper(System.Web.HttpContext.Current.Request);
                ip = request.ClientIPFromRequest(skipPrivate: true);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty, "LoginController.GetIpCliente");
            }

            return ip;
        }

        private void AsignarViewBagPorIso(string iso)
        {
            if (string.IsNullOrWhiteSpace(iso)) return;

            ViewBag.IsoPais = iso;

            if (iso == "BR") iso = "00";
            ViewBag.TituloPagina = " ÉSIKA ";
            ViewBag.IconoPagina = "/Content/Images/Esika/favicon.ico";
            ViewBag.EsPaisEsika = true;
            ViewBag.EsPaisLbel = false;
            ViewBag.AvisoASP = 1;
            ViewBag.BanderaOk = true;

            if (GetPaisesLbelFromConfig().Contains(iso))
            {
                ViewBag.TituloPagina = " L'BEL ";
                ViewBag.IconoPagina = "/Content/Images/Lbel/favicon.ico";
                ViewBag.EsPaisEsika = false;
                ViewBag.EsPaisLbel = true;
                if (iso == "MX") ViewBag.AvisoASP = 2;
            }
            else
            {
                ViewBag.BanderaOk = GetPaisesEsikaFromConfig().Contains(iso);
            }
        }

        protected string GetPaisesEsikaFromConfig()
        {

            var result = string.Empty;

            try
            {
                result = ConfigurationManager.AppSettings.Get("PaisesEsika") ?? string.Empty;
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.GetPaisesEsikaFromConfig");
            }

            return result;
        }

        protected string GetPaisesLbelFromConfig()
        {
            var result = string.Empty;

            try
            {
                result = ConfigurationManager.AppSettings.Get("paisesLBel") ?? string.Empty;
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.GetPaisesLbelFromConfig");
            }

            return result;

        }

        protected virtual void AsignarUrlRetorno(string returnUrl)
        {
            if (string.IsNullOrEmpty(returnUrl) && Request.UrlReferrer != null)
                returnUrl = Server.UrlEncode(Request.UrlReferrer.PathAndQuery);

            if (Url.IsLocalUrl(returnUrl) && !string.IsNullOrEmpty(returnUrl))
            {
                ViewBag.ReturnURL = returnUrl;
            }
        }

        private List<LoginAnalyticsModel> GetLoginAnalyticsModel()
        {
            return new List<LoginAnalyticsModel>
            {
                new LoginAnalyticsModel
                {
                    CodigoISO = "CL",
                    GndId = 958175395,
                    PixelId = "702802606578920",
                    SearchId = 989089161,
                    YoutubeId = 956468365
                },
                new LoginAnalyticsModel
                {
                    CodigoISO = "CO",
                    GndId = 971131996,
                    PixelId = "145027672730911",
                    SearchId = 995835500,
                    YoutubeId = 957866857
                },
                new LoginAnalyticsModel
                {
                    CodigoISO = "PE",
                    GndId = 956111599,
                    PixelId = "1004828506227914",
                    SearchId = 986595497,
                    YoutubeId = 954887628
                }
            };
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(LoginModel model, string returnUrl = null)
        {
            pasoLog = "Login.POST.Index";
            try
            {
                TempData["serverPaisId"] = model.PaisID;
                TempData["serverPaisISO"] = model.CodigoISO;
                TempData["serverCodigoUsuario"] = model.CodigoUsuario;

                if (model.PaisID == 0)
                    model.PaisID = Util.GetPaisID(model.CodigoISO);

                var resultadoInicioSesion = ObtenerResultadoInicioSesion(model);

                if (resultadoInicioSesion != null && resultadoInicioSesion.Result == USUARIO_VALIDO)
                {
                    TempData["usuarioValidado"] = "1";
                    if (model.UsuarioExterno == null)
                        return Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl);

                    if (resultadoInicioSesion.TipoUsuario == Constantes.TipoUsuario.Postulante)
                    {
                        if (Request.IsAjaxRequest())
                        {
                            return Json(new
                            {
                                success = false,
                                message = "Por ahora no podemos asociar tu cuenta con Facebook."
                            });
                        }
                    }

                    var usuarioExterno = model.UsuarioExterno;
                    if (string.IsNullOrEmpty(usuarioExterno.IdAplicacion))
                    {
                        if (Request.IsAjaxRequest())
                        {
                            return Json(new
                            {
                                success = false,
                                message = "Error al procesar la solicitud"
                            });
                        }
                    }
                    else
                    {
                        using (var svc = new UsuarioServiceClient())
                        {
                            var userExt = svc.GetUsuarioExternoByCodigoUsuario(model.PaisID, model.CodigoUsuario);
                            if (userExt == null)
                            {
                                var beUserExtPais = new BEUsuarioExternoPais
                                {
                                    Proveedor = usuarioExterno.Proveedor,
                                    IdAplicacion = usuarioExterno.IdAplicacion,
                                    PaisID = model.PaisID,
                                    CodigoISO = Util.GetPaisISO(model.PaisID)
                                };
                                svc.InsUsuarioExternoPais(11, beUserExtPais);

                                var beUsuarioExterno = new BEUsuarioExterno
                                {
                                    CodigoUsuario = resultadoInicioSesion.CodigoUsuario,
                                    Proveedor = usuarioExterno.Proveedor,
                                    IdAplicacion = usuarioExterno.IdAplicacion,
                                    Login = usuarioExterno.Login,
                                    Nombres = usuarioExterno.Nombres,
                                    Apellidos = usuarioExterno.Apellidos,
                                    FechaNacimiento = usuarioExterno.FechaNacimiento,
                                    Correo = usuarioExterno.Correo,
                                    Genero = usuarioExterno.Genero,
                                    Ubicacion = usuarioExterno.Ubicacion,
                                    LinkPerfil = usuarioExterno.LinkPerfil,
                                    FotoPerfil = usuarioExterno.FotoPerfil
                                };
                                svc.InsertUsuarioExterno(model.PaisID, beUsuarioExterno);

                                return usuarioExterno.Redireccionar
                                    ? Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl, true)
                                    : Json(new
                                    {
                                        success = true,
                                        message = "El codigo de consultora se asoció con su cuenta de Facebook"
                                    });
                            }
                        }
                    }

                    return Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl);
                }

                var mensaje = resultadoInicioSesion != null
                    ? resultadoInicioSesion.Mensaje
                    : "Error al procesar la solicitud";

                if (Request.IsAjaxRequest())
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    });
                }

                TempData["errorLogin"] = mensaje;

                return RedirectToAction("Index", "Login");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, model.CodigoUsuario, model.CodigoISO);

                if (Request.IsAjaxRequest())
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    });
                }

                TempData["errorLogin"] = "Error al procesar la solicitud";
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, model.CodigoUsuario, model.CodigoISO, pasoLog);

                if (Request.IsAjaxRequest())
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    });
                }

                TempData["errorLogin"] = "Error al procesar la solicitud";
            }

            return RedirectToAction("Index", "Login");
        }

        [HttpPost]
        public JsonResult SaveLogErrorLogin(string paisISO, string codigoUsuario, string mensaje)
        {
            try
            {
                logManager.LogErrorWebServicesBusWrap(new Exception(mensaje), codigoUsuario, paisISO,
                    "Login.SaveLogErrorLogin");

                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private BEValidaLoginSB2 ObtenerResultadoInicioSesion(LoginModel model)
        {
            BEValidaLoginSB2 resultadoInicioSesion;
            using (var svc = new UsuarioServiceClient())
            {
                resultadoInicioSesion = svc.GetValidarLoginSB2(model.PaisID, model.CodigoUsuario, model.ClaveSecreta);
            }

            return resultadoInicioSesion;
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult LoginAdmin(UsuarioModel model)
        {
            var resultado = Util.ValidarUsuarioADFS(model.CodigoUsuario, model.ClaveSecreta);

            var codigoResultado = resultado.Split('|')[0];
            var mensajeResultado = resultado.Split('|')[1];
            var paisIso = resultado.Split('|')[2];

            if (codigoResultado == "000")
            {
                var paisId = Util.GetPaisID(paisIso);
                return Redireccionar(paisId, model.CodigoUsuario);
            }

            TempData["errorLoginAdmin"] = mensajeResultado;
            return RedirectToAction("Admin", "Login");
        }

        public ActionResult Redireccionar(int paisId, string codigoUsuario, string returnUrl = null,
            bool hizoLoginExterno = false)
        {
            pasoLog = "Login.Redireccionar";
            var usuario = GetUserData(paisId, codigoUsuario);

            if (usuario == null)
            {
                if (Request.IsAjaxRequest())
                    return Json(new
                    {
                        success = false,
                        redirectTo = "Error al procesar la solicitud"
                    });

                else
                {
                    var url = GetUrlUsuarioDesconocido();
                    return Redirect(url);
                }
            }

            pasoLog = "Login.Redireccionar.SetAuthCookie";
            FormsAuthentication.SetAuthCookie(usuario.CodigoUsuario, false);

            if (hizoLoginExterno)
            {
                usuario.HizoLoginExterno = true;
                sessionManager.SetUserData(usuario);
            }

            var decodedUrl = string.Empty;
            if (!string.IsNullOrEmpty(returnUrl))
                decodedUrl = Server.UrlDecode(returnUrl);

            if (usuario.RolID == Constantes.Rol.Consultora)
            {
                if (EsDispositivoMovil())
                {
                    if (Request.IsAjaxRequest())
                    {
                        var urlx = (Url.IsLocalUrl(decodedUrl))
                            ? decodedUrl
                            : Url.Action("Index", "Bienvenida", new {area = "Mobile"});
                        return Json(new
                        {
                            success = true,
                            redirectTo = urlx
                        });
                    }

                    SetTempDataAnalyticsLogin(usuario, hizoLoginExterno);
                    if (Url.IsLocalUrl(decodedUrl))
                    {
                        return Redirect(decodedUrl);
                    }

                    return RedirectToAction("Index", "Bienvenida", new {area = "Mobile"});
                }

                if (string.IsNullOrEmpty(usuario.EMail) || !usuario.EMailActivo)
                {
                    Session["PrimeraVezSession"] = 0;
                }

                if (Request.IsAjaxRequest())
                {
                    var urlx = (Url.IsLocalUrl(decodedUrl)) ? decodedUrl : Url.Action("Index", "Bienvenida");
                    return Json(new
                    {
                        success = true,
                        redirectTo = urlx
                    });
                }

                SetTempDataAnalyticsLogin(usuario, hizoLoginExterno);
                if (Url.IsLocalUrl(decodedUrl))
                {
                    return Redirect(decodedUrl);
                }

                return RedirectToAction("Index", "Bienvenida");
            }

            if (Request.IsAjaxRequest())
            {
                return Json(new
                {
                    success = true,
                    redirectTo = Url.Action("Index", "Bienvenida")
                });
            }

            if (Url.IsLocalUrl(decodedUrl))
            {
                return Redirect(decodedUrl);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        private void SetTempDataAnalyticsLogin(UsuarioModel usuario, bool hizoLoginExterno)
        {
            var listAnalytics = GetLoginAnalyticsModel();
            var analyticsCurrentPais = listAnalytics.FirstOrDefault(a => a.CodigoISO == usuario.CodigoISO);

            if (analyticsCurrentPais != null)
            {
                TempData["PixelCodigoIso"] = usuario.CodigoISO;
                TempData["PixelMarcacion"] = hizoLoginExterno ? "LoginFacebook" : "LoginNormal";
                TempData["PixelId"] = analyticsCurrentPais.PixelId;
            }
        }

        private string GetUrlUsuarioDesconocido()
        {
            if (Request.Url != null)
                return Request.Url.Scheme + "://" + Request.Url.Authority +
                       (Request.ApplicationPath != null && Request.ApplicationPath.Equals("/") ? "/" : (Request.ApplicationPath + "/")) +
                       "WebPages/UserUnknown.aspx";
            return "";
        }

        [AllowAnonymous]
        public ActionResult LogOut()
        {
            return CerrarSesion();
        }

        private ActionResult CerrarSesion()
        {
            var tipoUsuario = 0;
            var userData = sessionManager.GetUserData();

            if (userData != null)
            {
                tipoUsuario = userData.TipoUsuario;

                if (userData.EsUsuarioComunidad)
                {
                    try
                    {
                        ServiceComunidad.BEUsuarioComunidad usuario;
                        using (var sv = new ServiceComunidad.ComunidadServiceClient())
                        {
                            usuario = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                            {
                                UsuarioId = 0,
                                CodigoUsuario = userData.CodigoUsuario,
                                Tipo = 3,
                                PaisId = userData.PaisID,
                            });
                        }

                        if (usuario != null)
                        {
                            var uniqueId = LithiumSSOClient.SSOClient.ANONYMOUS_UNIQUE_ID;
                            LithiumSSOClient.SSOClient.writeLithiumCookie(uniqueId, usuario.CodigoUsuario,
                                usuario.Correo, System.Web.HttpContext.Current.Request,
                                System.Web.HttpContext.Current.Response);
                        }
                    }
                    catch (Exception ex)
                    {
                        logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.CodigoISO,
                            string.Empty);
                    }
                }
            }

            sessionManager.SetUserData(null);
            Session.Clear();
            Session.Abandon();

            FormsAuthentication.SignOut();

            var urlSignOut = tipoUsuario == Constantes.TipoUsuario.Admin ? "/Login/Admin" : "/Login";

            return Redirect(urlSignOut);
        }

        [AllowAnonymous]
        public ActionResult LoginCargarConfiguracion(int paisID, string codigoUsuario)
        {
            GetUserData(paisID, codigoUsuario, 1);
            if (EsDispositivoMovil())
                return RedirectToAction("Index", "Bienvenida", new {area = "Mobile"});
            return RedirectToAction("Index", "Bienvenida");
        }

        public UsuarioModel GetUserData(int paisId, string codigoUsuario, int refrescarDatos = 0)
        {
            pasoLog = "Login.GetUserData";
            sessionManager.SetIsContrato(1);
            sessionManager.SetIsOfertaPack(1);

            var usuarioModel = (UsuarioModel) null;

            try
            {
                if (paisId == 0)
                    throw new ArgumentException("Parámetro paisId no puede ser cero.");

                if (string.IsNullOrEmpty(codigoUsuario))
                    throw new ArgumentException("Parámetro codigoUsuario no puede ser vacío.");

                var usuario = GetUsuarioAndLogsIngresoPortal(paisId, codigoUsuario, refrescarDatos);

                if (usuario != null)
                {
                    #region

                    usuarioModel = new UsuarioModel();
                    usuarioModel.EstadoPedido = usuario.EstadoPedido;
                    usuarioModel.NombrePais = usuario.NombrePais;
                    usuarioModel.PaisID = usuario.PaisID;
                    usuarioModel.CodigoISO = usuario.CodigoISO;
                    usuarioModel.CodigoFuente = usuario.CodigoFuente;
                    usuarioModel.RegionID = usuario.RegionID;
                    usuarioModel.CodigorRegion = usuario.CodigorRegion;
                    usuarioModel.ZonaID = usuario.ZonaID;
                    usuarioModel.CodigoZona = usuario.CodigoZona;
                    usuarioModel.ConsultoraID = usuario.ConsultoraID;
                    usuarioModel.CodigoUsuario = usuario.CodigoUsuario;
                    usuarioModel.CodigoConsultora = usuario.CodigoConsultora;
                    usuarioModel.NombreConsultora = usuario.Nombre;
                    usuarioModel.RolID = usuario.RolID;
                    usuarioModel.CampaniaID = usuario.CampaniaID;
                    usuarioModel.BanderaImagen = usuario.BanderaImagen;
                    usuarioModel.CambioClave = Convert.ToInt32(usuario.CambioClave);
                    usuarioModel.ConsultoraNueva = usuario.ConsultoraNueva;
                    usuarioModel.EsConsultoraNueva = usuario.EsConsultoraNueva;
                    usuarioModel.Telefono = usuario.Telefono;
                    usuarioModel.TelefonoTrabajo = usuario.TelefonoTrabajo;
                    usuarioModel.Celular = usuario.Celular;
                    usuarioModel.IndicadorDupla = usuario.IndicadorDupla;
                    usuarioModel.UsuarioPrueba = usuario.UsuarioPrueba;
                    usuarioModel.PasePedidoWeb = usuario.PasePedidoWeb;
                    usuarioModel.TipoOferta2 = usuario.TipoOferta2;
                    usuarioModel.CompraKitDupla = usuario.CompraKitDupla;
                    usuarioModel.CompraOfertaDupla = usuario.CompraOfertaDupla;
                    usuarioModel.CompraOfertaEspecial = usuario.CompraOfertaEspecial;
                    usuarioModel.IndicadorMeta = usuario.IndicadorMeta;
                    usuarioModel.ProgramaReconocimiento = usuario.ProgramaReconocimiento;
                    usuarioModel.NivelEducacion = usuario.NivelEducacion;
                    usuarioModel.SegmentoID = usuario.SegmentoID;
                    usuarioModel.FechaNacimiento = usuario.FechaNacimiento;
                    usuarioModel.Nivel = usuario.Nivel;
                    usuarioModel.FechaInicioCampania = usuario.FechaInicioFacturacion;
                    usuarioModel.VioVideoModelo = usuario.VioVideo;
                    usuarioModel.VioTutorialModelo = usuario.VioTutorial;
                    usuarioModel.VioTutorialDesktop = usuario.VioTutorialDesktop;
                    usuarioModel.HabilitarRestriccionHoraria = usuario.HabilitarRestriccionHoraria;
                    usuarioModel.IndicadorPermisoFIC = usuario.IndicadorPermisoFIC;
                    usuarioModel.PedidoFICActivo = usuario.PedidoFICActivo;
                    usuarioModel.HorasDuracionRestriccion = usuario.HorasDuracionRestriccion;
                    usuarioModel.EsJoven = usuario.EsJoven;
                    usuarioModel.PROLSinStock = usuario.PROLSinStock;
                    usuarioModel.HoraCierreZonaDemAntiCierre = usuario.HoraCierreZonaDemAntiCierre;
                    usuarioModel.ConsultoraAsociadaID = usuario.ConsultoraAsociadaID;
                    usuarioModel.ValidacionAbierta = usuario.ValidacionAbierta;
                    usuarioModel.AceptacionConsultoraDA = usuario.AceptacionConsultoraDA;
                    usuarioModel.DiaPROLMensajeCierreCampania =
                        DateTime.Now.AddHours(usuario.ZonaHoraria) >= usuario.FechaInicioFacturacion;

                    if (DateTime.Now.AddHours(usuario.ZonaHoraria) <
                        usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes))
                    {
                        usuarioModel.DiaPROL = false;
                        usuarioModel.FechaFacturacion = usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes);
                        usuarioModel.HoraFacturacion =
                            usuario.DiasAntes == 0 ? usuario.HoraInicio : usuario.HoraInicioNoFacturable;
                    }
                    else
                    {
                        usuarioModel.DiaPROL = true;
                        usuarioModel.FechaFacturacion = usuario.FechaFinFacturacion;
                        usuarioModel.HoraFacturacion = usuario.HoraFin;
                    }

                    usuarioModel.HoraInicioReserva = usuario.HoraInicio;
                    usuarioModel.HoraFinReserva = usuario.HoraFin;
                    usuarioModel.HoraInicioPreReserva = usuario.HoraInicioNoFacturable;
                    usuarioModel.HoraFinPreReserva = usuario.HoraCierreNoFacturable;
                    usuarioModel.DiasCampania = usuario.DiasAntes;
                    usuarioModel.HoraFinFacturacion = usuario.HoraFin;
                    usuarioModel.NombreCorto = usuario.CampaniaDescripcion;
                    usuarioModel.CampanaInvitada = usuario.CampanaInvitada;
                    usuarioModel.InscritaFlexipago = usuario.InscritaFlexipago;
                    usuarioModel.InvitacionRechazada = usuario.InvitacionRechazada;

                    usuarioModel.DiasAntes = usuario.DiasAntes;
                    usuarioModel.DiasDuracionCronograma = usuario.DiasDuracionCronograma;

                    switch (usuario.RolID)
                    {
                        case Constantes.Rol.Administrador:
                            usuarioModel.FechaFinCampania = usuario.FechaFinFacturacion;
                            break;
                        case Constantes.Rol.Consultora:
                            usuarioModel.FechaFinCampania = usuario.FechaFinFacturacion;
                            break;

                    }

                    usuarioModel.ZonaValida = usuario.ZonaValida;
                    usuarioModel.Simbolo = usuario.Simbolo;
                    usuarioModel.CodigoTerritorio = usuario.CodigoTerritorio;
                    usuarioModel.HoraCierreZonaDemAnti = usuario.HoraCierreZonaDemAnti;
                    usuarioModel.HoraCierreZonaNormal = usuario.HoraCierreZonaNormal;
                    usuarioModel.ZonaHoraria = usuario.ZonaHoraria;
                    usuarioModel.TipoUsuario = usuario.TipoUsuario;
                    usuarioModel.EsZonaDemAnti = usuario.EsZonaDemAnti;
                    usuarioModel.Segmento = usuario.Segmento;
                    usuarioModel.SegmentoAbreviatura = usuario.SegmentoAbreviatura;
                    usuarioModel.Sobrenombre = usuario.Sobrenombre;
                    usuarioModel.SobrenombreOriginal = usuario.Sobrenombre;
                    usuarioModel.Direccion = usuario.Direccion;
                    usuarioModel.IPUsuario = GetIpCliente();
                    usuarioModel.AnoCampaniaIngreso = usuario.AnoCampaniaIngreso;
                    usuarioModel.PrimerNombre = usuario.PrimerNombre;
                    usuarioModel.PrimerApellido = usuario.PrimerApellido;

                    if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                    {
                        usuarioModel.IndicadorPermisoFlexipago = GetPermisoFlexipago(usuarioModel.PaisID,
                            usuarioModel.CodigoISO, usuarioModel.CodigoConsultora, usuarioModel.CampaniaID);
                    }

                    if (usuario.TipoUsuario == Constantes.TipoUsuario.Postulante)
                    {
                        usuarioModel.MensajePedidoDesktop = usuario.MensajePedidoDesktop;
                        usuarioModel.MensajePedidoMobile = usuario.MensajePedidoMobile;
                    }

                    usuarioModel.MostrarAyudaWebTraking = usuario.MostrarAyudaWebTraking;
                    usuarioModel.NroCampanias = usuario.NroCampanias;
                    usuarioModel.RolDescripcion = usuario.RolDescripcion;
                    usuarioModel.IndicadorOfertaFIC = usuario.IndicadorOfertaFIC;
                    usuarioModel.ImagenURLOfertaFIC = usuario.ImagenURLOfertaFIC;
                    usuarioModel.Lider = usuario.Lider;
                    usuarioModel.ConsultoraAsociada = usuario.ConsultoraAsociada;
                    usuarioModel.CampaniaInicioLider = usuario.CampaniaInicioLider;
                    usuarioModel.SeccionGestionLider = usuario.SeccionGestionLider;
                    usuarioModel.NivelLider = usuario.NivelLider;
                    usuarioModel.PortalLideres = usuario.PortalLideres;
                    usuarioModel.LogoLideres = usuario.LogoLideres;
                    usuarioModel.IndicadorContrato = usuario.IndicadorContrato;
                    usuarioModel.FechaFinFIC = usuario.FechaFinFIC;
                    usuarioModel.MenuNotificaciones = 1;

                    if (usuarioModel.MenuNotificaciones == 1 &&
                        usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        usuarioModel.TieneNotificaciones = TieneNotificaciones(usuario);

                    usuarioModel.NuevoPROL = usuario.NuevoPROL;
                    usuarioModel.ZonaNuevoPROL = usuario.ZonaNuevoPROL;

                    if (usuario.CampaniaID != 0 && usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                    {
                        var valores = GetFechaPromesaEntrega(usuario.PaisID, usuario.CampaniaID, usuario.CodigoConsultora,
                            usuario.FechaInicioFacturacion);
                        var arrValores = valores.Split('|');
                        usuarioModel.TipoCasoPromesa = arrValores[2];
                        usuarioModel.DiasCasoPromesa = Convert.ToInt16(arrValores[1]);
                        usuarioModel.FechaPromesaEntrega = Convert.ToDateTime(arrValores[0]);
                    }

                    var lista = GetLinksPorPais(usuarioModel.PaisID);
                    if (lista.Count > 0)
                    {
                        usuarioModel.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                        usuarioModel.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                        usuarioModel.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                    }

                    if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                    {
                        usuarioModel.EsUsuarioComunidad = EsUsuarioComunidad(usuario.PaisID, usuario.CodigoUsuario);
                    }

                    usuarioModel.SegmentoConstancia = usuario.SegmentoConstancia ?? "";
                    usuarioModel.SeccionAnalytics = usuario.SeccionAnalytics;
                    usuarioModel.DescripcionNivel = usuario.DescripcionNivel;
                    usuarioModel.esConsultoraLider = usuario.esConsultoraLider;
                    usuarioModel.EMailActivo = usuario.EMailActivo;
                    usuarioModel.EMail = usuario.EMail;
                    usuarioModel.SegmentoInternoID = usuario.SegmentoInternoID;
                    usuarioModel.EstadoSimplificacionCUV = usuario.EstadoSimplificacionCUV;
                    usuarioModel.EsquemaDAConsultora = usuario.EsquemaDAConsultora;
                    usuarioModel.ValidacionInteractiva = usuario.ValidacionInteractiva;
                    usuarioModel.MensajeValidacionInteractiva = usuario.MensajeValidacionInteractiva;

                    usuarioModel.IndicadorPagoOnline =
                        usuarioModel.PaisID == 4 || usuarioModel.PaisID == 3 || usuarioModel.PaisID == 12 ? 1 : 0;
                    usuarioModel.UrlPagoOnline = usuarioModel.PaisID == 4
                        ? "https://www.zonapagos.com/pagosn2/LoginCliente"
                        : usuarioModel.PaisID == 3
                            ? "https://www.belcorpchile.cl/BotonesPagoRedireccion/PagoConsultora.aspx"
                            : usuarioModel.PaisID == 12 ? "https://www.somosbelcorp.com/Paypal"
                                : "";

                    usuarioModel.OfertaFinal = usuario.OfertaFinal;
                    usuarioModel.EsOfertaFinalZonaValida = usuario.EsOfertaFinalZonaValida;

                    usuarioModel.OfertaFinalGanaMas = usuario.OfertaFinalGanaMas;
                    usuarioModel.EsOFGanaMasZonaValida = usuario.EsOFGanaMasZonaValida;

                    usuarioModel.CatalogoPersonalizado = usuario.CatalogoPersonalizado;
                    usuarioModel.EsCatalogoPersonalizadoZonaValida = usuario.EsCatalogoPersonalizadoZonaValida;
                    usuarioModel.VioTutorialSalvavidas = usuario.VioTutorialSalvavidas;
                    usuarioModel.TieneHana = usuario.TieneHana;
                    usuarioModel.NombreGerenteZonal = usuario.NombreGerenteZona;
                    usuarioModel.FechaActualPais = usuario.FechaActualPais;
                    usuarioModel.IndicadorBloqueoCDR = usuario.IndicadorBloqueoCDR;
                    usuarioModel.EsCDRWebZonaValida = usuario.EsCDRWebZonaValida;
                    usuarioModel.TieneCDR = usuario.TieneCDR;
                    usuarioModel.TieneCupon = usuario.TieneCupon;
                    usuarioModel.TieneMasVendidos = usuario.TieneMasVendidos;
                    usuarioModel.TieneAsesoraOnline = usuario.TieneAsesoraOnline;

                    usuarioModel.TieneCDRExpress = usuario.TieneCDRExpress;
                    usuarioModel.EsConsecutivoNueva = usuario.EsConsecutivoNueva;

                    usuarioModel.CodigoPrograma = usuario.CodigoPrograma;
                    usuarioModel.ConsecutivoNueva = usuario.ConsecutivoNueva;

                    #endregion

                    if (usuarioModel.RolID == Constantes.Rol.Consultora)
                    {
                        #region Hana

                        if (usuarioModel.TieneHana == 1)
                        {
                            if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                            {
                                ActualizarDatosHana(ref usuarioModel);
                            }
                        }
                        else
                        {
                            usuarioModel.MontoMinimo = usuario.MontoMinimoPedido;
                            usuarioModel.MontoMaximo = usuario.MontoMaximoPedido;
                            usuarioModel.FechaLimPago = usuario.FechaLimPago;

                            if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                            {
                                usuarioModel.MontoDeuda = GetMontoDeuda(usuarioModel);
                            }

                            usuarioModel.IndicadorFlexiPago = usuario.IndicadorFlexiPago;
                            usuarioModel.MontoMinimoFlexipago = "0.00";

                            if (usuarioModel.IndicadorFlexiPago > 0 &&
                                usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                            {
                                var ofertaFlexipago = GetLineaCreditoFlexipago(usuarioModel);
                                usuarioModel.MontoMinimoFlexipago = string.Format("{0:#,##0.00}",
                                    (ofertaFlexipago.MontoMinimoFlexipago < 0
                                        ? 0M
                                        : ofertaFlexipago.MontoMinimoFlexipago));
                            }
                        }

                        #endregion

                        #region GPR

                        usuarioModel.IndicadorGPRSB = usuario.IndicadorGPRSB;
                        if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            var gprBanner = GetMotivoRechazo(usuario, usuarioModel.MontoDeuda);
                            if (gprBanner != null)
                            {
                                usuarioModel.GPRBannerUrl = gprBanner.BannerUrl;
                                usuarioModel.GPRBannerTitulo = gprBanner.BannerTitulo;
                                usuarioModel.GPRBannerMensaje = gprBanner.BannerMensaje;
                                usuarioModel.RechazadoXdeuda = gprBanner.RechazadoXdeuda;
                                usuarioModel.MostrarBannerRechazo = gprBanner.MostrarBannerRechazo;
                            }
                        }

                        #endregion

                        #region ODD

                        if (usuario.OfertaDelDia && usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            usuarioModel.OfertasDelDia = GetOfertaDelDiaModel(usuarioModel);
                            usuarioModel.TieneOfertaDelDia = usuarioModel.OfertasDelDia.Any();
                        }

                        #endregion

                        #region RegaloPN

                        if (GetRegaloProgramaNuevasFlag() == "1")
                        {
                            var fechaHoy = DateTime.Now.AddHours(usuarioModel.ZonaHoraria).Date;
                            var esDiasFacturacion = fechaHoy >= usuarioModel.FechaInicioCampania.Date &&
                                                    fechaHoy <= usuarioModel.FechaFinCampania.Date;

                            if (esDiasFacturacion)
                            {
                                usuarioModel.ConsultoraRegaloProgramaNuevas =
                                    GetConsultoraRegaloProgramaNuevas(usuarioModel);
                            }
                        }

                        #endregion

                        #region LoginFB

                        if (usuario.TieneLoginExterno)
                        {
                            usuarioModel.TieneLoginExterno = usuario.TieneLoginExterno;
                            List<BEUsuarioExterno> lstLoginExterno;
                            using (var usuarioServiceClient = new UsuarioServiceClient())
                            {
                                lstLoginExterno = usuarioServiceClient
                                    .GetListaLoginExterno(usuario.PaisID, usuario.CodigoUsuario).ToList();
                            }

                            if (lstLoginExterno.Any())
                            {
                                usuarioModel.ListaLoginExterno =
                                    Mapper.Map<List<BEUsuarioExterno>, List<UsuarioExternoModel>>(lstLoginExterno);
                            }
                        }

                        #endregion

                        #region ConfiguracionPais

                        try
                        {
                            if (usuarioModel.TipoUsuario == Constantes.TipoUsuario.Postulante)
                                throw new ArgumentException("No se asigna configuracion pais para los Postulantes.");

                            var guiaNegocio = new GuiaNegocioModel();
                            var revistaDigitalModel = new RevistaDigitalModel {NoVolverMostrar = true};
                            var ofertaFinalModel = new OfertaFinalModel();

                            var configuracionesPaisModels = GetConfiguracionPais(usuarioModel);
                            if (configuracionesPaisModels.Any())
                            {
                                var listaPaisDatos = ConfiguracionPaisDatos(usuarioModel);

                                foreach (var c in configuracionesPaisModels)
                                {
                                    switch (c.Codigo)
                                    {
                                        case Constantes.ConfiguracionPais.RevistaDigital:
                                            revistaDigitalModel = ConfiguracionPaisDatosRevistaDigital(revistaDigitalModel, 
                                                listaPaisDatos
                                                    .Where(d => d.ConfiguracionPaisID == c.ConfiguracionPaisID)
                                                    .ToList(), usuarioModel.CodigoISO);

                                            ConfiguracionPaisRevistaDigital(ref revistaDigitalModel, usuarioModel);
                                            FormatTextConfiguracionPaisDatosModel(ref revistaDigitalModel, usuarioModel.Sobrenombre);
                                            revistaDigitalModel.BloqueoRevistaImpresa = c.BloqueoRevistaImpresa;
                                            break;

                                        case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                                            if (revistaDigitalModel.TieneRDC)
                                                break;

                                            revistaDigitalModel = ConfiguracionPaisDatosRevistaDigitalReducida(revistaDigitalModel,
                                                listaPaisDatos
                                                    .Where(d => d.ConfiguracionPaisID == c.ConfiguracionPaisID)
                                                    .ToList(), usuarioModel.CodigoISO);

                                            FormatTextConfiguracionPaisDatosModel(ref revistaDigitalModel, usuarioModel.Sobrenombre);
                                            revistaDigitalModel.TieneRDR = true;
                                            break;

                                        case Constantes.ConfiguracionPais.ValidacionMontoMaximo:
                                            usuarioModel.TieneValidacionMontoMaximo = c.Estado;
                                            break;

                                        case Constantes.ConfiguracionPais.OfertaFinalTradicional:
                                        case Constantes.ConfiguracionPais.OfertaFinalCrossSelling:
                                        case Constantes.ConfiguracionPais.OfertaFinalRegaloSorpresa:
                                            ofertaFinalModel.Algoritmo = c.Codigo;
                                            ofertaFinalModel.Estado = c.Estado;
                                            if (c.Estado)
                                            {
                                                usuarioModel.OfertaFinal = 1;
                                                usuarioModel.EsOfertaFinalZonaValida = true;
                                            }

                                            break;

                                        case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                                            guiaNegocio = ConfiguracionPaisDatosGuiaNegocio(listaPaisDatos
                                                    .Where(d => d.ConfiguracionPaisID == c.ConfiguracionPaisID)
                                                    .ToList());
                                            guiaNegocio.TieneGND = true;
                                            usuarioModel.TieneGND = true;
                                            break;

                                        case Constantes.ConfiguracionPais.OfertaDelDia:
                                            usuarioModel.OfertaDelDia = ConfiguracionPaisDatosOfertaDelDia(usuarioModel.OfertaDelDia, listaPaisDatos
                                                .Where(d => d.ConfiguracionPaisID == c.ConfiguracionPaisID)
                                                .ToList());
                                            break;
                                            
                                        case Constantes.ConfiguracionPais.OfertasParaTi:
                                            usuarioModel = ConfiguracionPaisDatosUsuario(usuarioModel, listaPaisDatos
                                                .Where(d => d.ConfiguracionPaisID == c.ConfiguracionPaisID)
                                                .ToList());
                                            break;
                                    }

                                    if (c.Codigo.EndsWith("GM") && c.Codigo.StartsWith("OF") && c.Estado)
                                        usuarioModel.OfertaFinalGanaMas = 1;
                                }

                                revistaDigitalModel.TieneRDR = !revistaDigitalModel.TieneRDC && revistaDigitalModel.TieneRDR;
                                revistaDigitalModel.Campania = usuarioModel.CampaniaID % 100;
                                revistaDigitalModel.CampaniaMasUno =
                                    Util.AddCampaniaAndNumero(Convert.ToInt32(usuarioModel.CampaniaID), 1,usuarioModel.NroCampanias) % 100;
                                revistaDigitalModel.NombreConsultora = usuarioModel.Sobrenombre;
                                sessionManager.SetGuiaNegocio(guiaNegocio);
                                sessionManager.SetRevistaDigital(revistaDigitalModel);
                                sessionManager.SetConfiguracionesPaisModel(configuracionesPaisModels);
                                sessionManager.SetOfertaFinalModel(ofertaFinalModel);
                            }

                            usuarioModel.CodigosRevistaImpresa = ObtenerCodigoRevistaFisica(usuarioModel.PaisID);
                        }
                        catch (Exception ex)
                        {
                            logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora,
                                usuarioModel.PaisID.ToString(), string.Empty);
                            pasoLog = "Ocurrió un error al cargar ConfiguracionPais";
                            sessionManager.SetGuiaNegocio(new GuiaNegocioModel());
                            sessionManager.SetRevistaDigital(new RevistaDigitalModel());
                            sessionManager.SetConfiguracionesPaisModel(new List<ConfiguracionPaisModel>());
                            sessionManager.SetOfertaFinalModel(new OfertaFinalModel());
                        }

                        #endregion

                        #region EventoFestivo

                        try
                        {
                            var eventoFestivoDataModel = new EventoFestivoDataModel
                            {
                                ListaEventoFestivo = ObtenerEventoFestivo(usuarioModel.PaisID,
                                    Constantes.EventoFestivoAlcance.SOMOS_BELCORP, usuarioModel.CampaniaID)
                            };

                            if (eventoFestivoDataModel.ListaEventoFestivo.Any())
                            {
                                foreach (var item in eventoFestivoDataModel.ListaEventoFestivo)
                                {
                                    switch (item.Nombre)
                                    {
                                        case Constantes.EventoFestivoNombre.SALUDO:
                                            eventoFestivoDataModel.EfSaludo = Convert.ToString(item.Personalizacion);
                                            break;

                                        case Constantes.EventoFestivoNombre.FONDO_INGPED:
                                            eventoFestivoDataModel.EfRutaPedido =
                                                Convert.ToString(item.Personalizacion);
                                            break;
                                    }
                                }
                            }

                            eventoFestivoDataModel.ListaGifMenuContenedorOfertas = ObtenerEventoFestivo(
                                usuarioModel.PaisID, Constantes.EventoFestivoAlcance.MENU_SOMOS_BELCORP,
                                usuarioModel.CampaniaID);

                            sessionManager.SetEventoFestivoDataModel(eventoFestivoDataModel);
                        }
                        catch (Exception ex)
                        {
                            logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora,
                                usuarioModel.PaisID.ToString(), string.Empty);
                            pasoLog = "Ocurrió un error al cargar Eventofestivo";
                            sessionManager.SetEventoFestivoDataModel(new EventoFestivoDataModel());
                        }

                        #endregion

                        #region IncentivosConcursos

                        usuarioModel.CodigosConcursos = string.Empty;
                        usuarioModel.CodigosProgramaNuevas = string.Empty;

                        try
                        {
                            var arrCalculoPuntos = Constantes.Incentivo.CalculoPuntos.Split(';');
                            var arrCalculoProgramaNuevas = Constantes.Incentivo.CalculoProgramaNuevas.Split(';');

                            using (var sv = new PedidoServiceClient())
                            {
                                var result = sv.ObtenerConcursosXConsultora(usuarioModel.PaisID, usuarioModel.CampaniaID.ToString(), usuarioModel.CodigoConsultora, usuarioModel.CodigorRegion, usuarioModel.CodigoZona);

                                var Concursos = result.Where(x => arrCalculoPuntos.Contains(x.TipoConcurso));
                                if (Concursos.Any()) usuarioModel.CodigosConcursos = string.Join("|", Concursos.Select(c => c.CodigoConcurso));

                                var ProgramaNuevas = result.Where(x => arrCalculoProgramaNuevas.Contains(x.TipoConcurso));
                                if (ProgramaNuevas.Any()) usuarioModel.CodigosProgramaNuevas = string.Join("|", ProgramaNuevas.Select(c => c.CodigoConcurso));
                            }
                        }
                        catch (Exception ex)
                        {
                            logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora,
                                usuarioModel.CodigoISO, string.Empty);
                        }

                        #endregion
                    }

                    if (usuarioModel.CatalogoPersonalizado != 0)
                    {
                        var lstFiltersFav = new List<BETablaLogicaDatos>();
                        using (var svc = new SACServiceClient())
                        {
                            for (var i = 94; i <= 97; i++)
                            {
                                var lstItems = svc.GetTablaLogicaDatos(usuarioModel.PaisID, (short) i);
                                if (!lstItems.Any()) continue;
                                lstFiltersFav.AddRange(lstItems);
                            }
                        }

                        if (lstFiltersFav.Any())
                        {
                            Session["ListFiltersFAV"] = lstFiltersFav;
                        }
                    }

                    if (GetPaisesLbelFromConfig().Contains(usuarioModel.CodigoISO))
                    {
                        usuarioModel.EsLebel = true;
                    }

                    sessionManager.SetTieneLan(true);
                    sessionManager.SetTieneLanX1(true);
                    sessionManager.SetTieneOpt(true);
                    sessionManager.SetTieneOpm(true);
                    sessionManager.SetTieneOpmX1(true);
                    sessionManager.SetTieneRdr(true);

                    usuarioModel.FotoPerfil = usuario.FotoPerfil;
                }

                sessionManager.SetUserData(usuarioModel);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, codigoUsuario, paisId.ToString(), string.Empty);
                pasoLog = "Error: " + ex.Message;
                throw;
            }

            return usuarioModel;
        }

        protected virtual List<ConfiguracionPaisModel> GetConfiguracionPais(UsuarioModel usuarioModel)
        {
            IList<ServiceUsuario.BEConfiguracionPais> listaConfigPais;

            try
            {
                var config = new ServiceUsuario.BEConfiguracionPais
                {
                    DesdeCampania = usuarioModel.CampaniaID,
                    Detalle = new ServiceUsuario.BEConfiguracionPaisDetalle
                    {
                        PaisID = usuarioModel.PaisID,
                        CodigoConsultora = usuarioModel.CodigoConsultora,
                        CodigoRegion = usuarioModel.CodigorRegion,
                        CodigoZona = usuarioModel.CodigoZona,
                        CodigoSeccion = usuarioModel.SeccionAnalytics
                    }
                };
                using (var sv = new UsuarioServiceClient())
                {
                    listaConfigPais = sv.GetConfiguracionPais(config);
                }
            }
            catch (Exception ex)
            {
                listaConfigPais = new List<ServiceUsuario.BEConfiguracionPais>();
                logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoUsuario, usuarioModel.PaisID.ToString(),
                    "LoginController.GetConfiguracionPais");
            }


            return Mapper.Map<IList<ServiceUsuario.BEConfiguracionPais>, List<ConfiguracionPaisModel>>(listaConfigPais);
        }

        protected virtual List<BEConfiguracionPaisDatos> ConfiguracionPaisDatos(UsuarioModel usuarioModel)
        {
            List<BEConfiguracionPaisDatos> listaEntidad;

            try
            {
                var entidad = new BEConfiguracionPaisDatos
                {
                    PaisID = usuarioModel.PaisID,
                    CampaniaID = usuarioModel.CampaniaID,
                    ConfiguracionPais = new ServiceUsuario.BEConfiguracionPais
                    {
                        Detalle = new ServiceUsuario.BEConfiguracionPaisDetalle
                        {
                            CodigoConsultora = usuarioModel.CodigoConsultora,
                            CodigoRegion = usuarioModel.CodigorRegion,
                            CodigoZona = usuarioModel.CodigoZona,
                            CodigoSeccion = usuarioModel.SeccionAnalytics
                        }
                    }
                };
                using (var sv = new UsuarioServiceClient())
                {
                    listaEntidad = sv.GetConfiguracionPaisDatos(entidad).ToList();
                }
            }
            catch (Exception ex)
            {
                listaEntidad = new List<BEConfiguracionPaisDatos>();
                logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoUsuario, usuarioModel.PaisID.ToString(),
                    "LoginController.ConfiguracionPaisDatos");
            }

            return listaEntidad;
        }

        #region ConfiguracioRevistaDigital

        public RevistaDigitalModel ConfiguracionPaisDatosRevistaDigital( RevistaDigitalModel revistaDigitalModel, List<BEConfiguracionPaisDatos> listaDatos, string paisIso)
        {
            try
            {
                if (revistaDigitalModel == null)
                    throw new ArgumentNullException("revistaDigitalModel", "no puede ser nulo");

                if (listaDatos == null)
                    throw new ArgumentNullException("listaDatos", "no puede ser nulo");

                if (paisIso == null)
                    throw new ArgumentNullException("paisIso", "no puede ser nulo");

                if (!listaDatos.Any())
                    return revistaDigitalModel;

                var value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.BloquearDiasAntesFacturar);
                if (value1 != null) revistaDigitalModel.BloquearDiasAntesFacturar = Convert.ToInt32(value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.CantidadCampaniaEfectiva);
                if (value1 != null) revistaDigitalModel.CantidadCampaniaEfectiva = Convert.ToInt32(value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.NombreComercialActiva);
                if (value1 != null) revistaDigitalModel.NombreComercialActiva = value1.Valor1;

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.NombreComercialNoActiva);
                if (value1 != null) revistaDigitalModel.NombreComercialNoActiva = value1.Valor1;

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoComercialActiva);
                if (value1 != null)
                {
                    revistaDigitalModel.DLogoComercialActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);
                    revistaDigitalModel.MLogoComercialActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor2);
                }

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoComercialNoActiva);
                if (value1 != null)
                {
                    revistaDigitalModel.DLogoComercialNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);
                    revistaDigitalModel.MLogoComercialNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor2);
                }

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoActiva);
                if (value1 != null)
                {
                    revistaDigitalModel.DLogoComercialFondoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);
                    revistaDigitalModel.MLogoComercialFondoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor2);
                }

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoNoActiva);
                if (value1 != null)
                {
                    revistaDigitalModel.DLogoComercialFondoNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);
                    revistaDigitalModel.MLogoComercialFondoNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor2);
                }

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasActiva);
                if (value1 != null)
                    revistaDigitalModel.LogoMenuOfertasActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasNoActiva);
                if (value1 != null)
                    revistaDigitalModel.LogoMenuOfertasNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.BloquearPedidoRevistaImp);
                if (value1 != null) revistaDigitalModel.BloquearRevistaImpresaGeneral = Convert.ToInt32(value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.BloquearSugerenciaProducto);
                if (value1 != null) revistaDigitalModel.BloquearProductosSugeridos = Convert.ToInt32(value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RD.SubscripcionAutomaticaAVirtualCoach);
                if (value1 != null) revistaDigitalModel.SubscripcionAutomaticaAVirtualCoach = value1.Valor1 == "1";

                value1 = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                if (value1 != null) revistaDigitalModel.BloqueoProductoDigital = value1.Valor1 == "1";

                listaDatos.RemoveAll(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RD.BloquearDiasAntesFacturar
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.CantidadCampaniaEfectiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.NombreComercialActiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.NombreComercialNoActiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoComercialActiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoComercialNoActiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasActiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasNoActiva
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.BloquearPedidoRevistaImp
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.BloquearSugerenciaProducto
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RD.SubscripcionAutomaticaAVirtualCoach
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital
                );

                revistaDigitalModel.ConfiguracionPaisDatos =
                    Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ??
                    new List<ConfiguracionPaisDatosModel>();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosRevistaDigital");
            }

            return revistaDigitalModel;
        }

        public RevistaDigitalModel ConfiguracionPaisDatosRevistaDigitalReducida(RevistaDigitalModel revistaDigitalModel, List<BEConfiguracionPaisDatos> listaDatos, string paisIso)
        {
            try
            {
                revistaDigitalModel.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();

                if (listaDatos == null || !listaDatos.Any())
                    return revistaDigitalModel;

                var value1 =
                    listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.LogoComercial);
                if (value1 != null)
                {
                    revistaDigitalModel.DLogoComercialNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);
                    revistaDigitalModel.MLogoComercialNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor2);
                }

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.LogoComercialFondo);
                if (value1 != null)
                {
                    revistaDigitalModel.DLogoComercialFondoNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);
                    revistaDigitalModel.MLogoComercialFondoNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor2);
                }

                value1 = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.LogoMenuOfertas);
                if (value1 != null)
                    revistaDigitalModel.LogoMenuOfertasNoActiva = ConfigS3.GetUrlFileRDS3(paisIso, value1.Valor1);

                value1 = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                if (value1 != null) revistaDigitalModel.BloqueoProductoDigital = value1.Valor1 == "1";

                listaDatos.RemoveAll(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.LogoComercial
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.LogoComercialFondo
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.LogoMenuOfertas
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital
                );

                revistaDigitalModel.ConfiguracionPaisDatos =
                    Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ??
                    new List<ConfiguracionPaisDatosModel>();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosRevistaDigital");
            }

            return revistaDigitalModel;
        }

        private void ConfiguracionPaisRevistaDigital(ref RevistaDigitalModel revistaDigitalModel,
            UsuarioModel usuarioModel)
        {
            revistaDigitalModel.TieneRDC = true;
            revistaDigitalModel.TieneRDS = true;
            revistaDigitalModel.TieneRDR = false;

            var rds = new BERevistaDigitalSuscripcion
            {
                PaisID = usuarioModel.PaisID,
                CodigoConsultora = usuarioModel.CodigoConsultora
            };

            using (var sv1 = new PedidoServiceClient())
            {
                revistaDigitalModel.SuscripcionModel =
                    Mapper.Map<RevistaDigitalSuscripcionModel>(sv1.RDGetSuscripcion(rds));

                rds.CampaniaID = usuarioModel.CampaniaID;
                revistaDigitalModel.SuscripcionEfectiva =
                    Mapper.Map<RevistaDigitalSuscripcionModel>(sv1.RDGetSuscripcionActiva(rds));
            }

            #region Campanias y Estados Es Activas - Es Suscrita

            revistaDigitalModel.EstadoSuscripcion = revistaDigitalModel.SuscripcionModel.EstadoRegistro;
            revistaDigitalModel.CampaniaActual = Util.SubStr(usuarioModel.CampaniaID.ToString(), 4, 2);
            revistaDigitalModel.CampaniaFuturoActiva = Util.SubStr(
                Util.AddCampaniaAndNumero(usuarioModel.CampaniaID, revistaDigitalModel.CantidadCampaniaEfectiva,
                    usuarioModel.NroCampanias).ToString(), 4, 2);

            revistaDigitalModel.CampaniaSuscripcion =
                Util.SubStr(revistaDigitalModel.SuscripcionModel.CampaniaID.ToString(), 4, 2);

            if (revistaDigitalModel.SuscripcionEfectiva.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                var ca = Util.AddCampaniaAndNumero(revistaDigitalModel.SuscripcionEfectiva.CampaniaID,
                    revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);

                if (ca >= revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva)
                    ca = revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva;

                revistaDigitalModel.CampaniaActiva = Util.SubStr(ca.ToString(), 4, 2);
                revistaDigitalModel.EsActiva = ca <= usuarioModel.CampaniaID;

            }
            else if (revistaDigitalModel.SuscripcionEfectiva.EstadoRegistro ==
                     Constantes.EstadoRDSuscripcion.SinRegistroDB)
            {
                if (revistaDigitalModel.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    var ca = Util.AddCampaniaAndNumero(revistaDigitalModel.SuscripcionModel.CampaniaID,
                        revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);
                    if (ca >= revistaDigitalModel.SuscripcionModel.CampaniaEfectiva)
                        ca = revistaDigitalModel.SuscripcionModel.CampaniaEfectiva;

                    revistaDigitalModel.CampaniaActiva = Util.SubStr(ca.ToString(), 4, 2);
                    revistaDigitalModel.EsActiva = ca <= usuarioModel.CampaniaID;
                }
                else
                {
                    revistaDigitalModel.CampaniaActiva = "";
                    revistaDigitalModel.EsActiva = false;
                }

            }
            else
            {
                var ca = Util.AddCampaniaAndNumero(revistaDigitalModel.SuscripcionEfectiva.CampaniaID,
                    revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);

                if (ca < revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva)
                    ca = revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva;

                revistaDigitalModel.CampaniaActiva = Util.SubStr(ca.ToString(), 4, 2);

                revistaDigitalModel.EsActiva = ca > usuarioModel.CampaniaID;
            }

            revistaDigitalModel.EsSuscrita = revistaDigitalModel.SuscripcionModel.EstadoRegistro ==
                                             Constantes.EstadoRDSuscripcion.Activo;

            #endregion

            revistaDigitalModel.EstadoRdcAnalytics = GetEstadoRdAnalytics(revistaDigitalModel);

            #region DiasAntesFacturaHoy - NoVolverMostrar

            if (DateTime.Now.AddHours(usuarioModel.ZonaHoraria).Date >=
                usuarioModel.FechaInicioCampania.Date.AddDays(-1 * revistaDigitalModel.BloquearDiasAntesFacturar)
                && revistaDigitalModel.BloquearDiasAntesFacturar > 0)
                return;

            switch (revistaDigitalModel.SuscripcionModel.EstadoRegistro)
            {
                case Constantes.EstadoRDSuscripcion.Activo:
                    revistaDigitalModel.NoVolverMostrar = true;
                    break;
                case Constantes.EstadoRDSuscripcion.SinRegistroDB:
                case Constantes.EstadoRDSuscripcion.Desactivo:
                    revistaDigitalModel.NoVolverMostrar = false;
                    break;
                case Constantes.EstadoRDSuscripcion.NoPopUp:
                    revistaDigitalModel.NoVolverMostrar =
                        revistaDigitalModel.SuscripcionModel.CampaniaID == usuarioModel.CampaniaID;
                    break;
            }

            #endregion
        }

        private static string GetEstadoRdAnalytics(RevistaDigitalModel revistaDigital)
        {
            if (revistaDigital == null || !revistaDigital.TieneRDC) return "(not available)";
            if (revistaDigital.EsSuscrita)
                return revistaDigital.EsActiva ? "Inscrita Activa" : "Inscrita No Activa";

            return revistaDigital.EsActiva ? "No Inscrita Activa" : "No Inscrita No Activa";
        }

        #endregion

        private GuiaNegocioModel ConfiguracionPaisDatosGuiaNegocio(List<BEConfiguracionPaisDatos> listaDatos)
        {
            var modelo = new GuiaNegocioModel();
            try
            {
                if (listaDatos == null || !listaDatos.Any())
                    return modelo;

                var value1 = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                if (value1 != null) modelo.BloqueoProductoDigital = value1.Valor1 == "1";

                listaDatos.RemoveAll(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);

                modelo.ConfiguracionPaisDatos =
                    Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ??
                    new List<ConfiguracionPaisDatosModel>();

            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosGuiaNegocio");
            }

            return modelo;
        }

        private OfertaDelDiaModel ConfiguracionPaisDatosOfertaDelDia(OfertaDelDiaModel modelo, List<BEConfiguracionPaisDatos> listaDatos)
        {
            try
            {
                modelo = modelo ?? new OfertaDelDiaModel();
                if (listaDatos == null || !listaDatos.Any())
                    return modelo;

                var value1 = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                if (value1 != null) modelo.BloqueoProductoDigital = value1.Valor1 == "1";

                listaDatos.RemoveAll(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);

                modelo.ConfiguracionPaisDatos =
                    Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ??
                    new List<ConfiguracionPaisDatosModel>();

            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosOfertaDelDia");
            }

            return modelo;

        }

        private UsuarioModel ConfiguracionPaisDatosUsuario(UsuarioModel modelo, List<BEConfiguracionPaisDatos> listaDatos)
        {
            try
            {
                if (listaDatos == null || !listaDatos.Any())
                    return modelo;

                var value1 = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                if (value1 != null) modelo.OptBloqueoProductoDigital = value1.Valor1 == "1";
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosUsuario");
            }

            return modelo;

        }

        private string GetRegaloProgramaNuevasFlag()
        {
            var result = string.Empty;

            try
            {
                result = ConfigurationManager.AppSettings.Get("RegaloProgramaNuevasFlag");
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.GetRegaloProgramaNuevasFlag");
            }

            return result;
        }

        private ServicePedidoRechazado.BEGPRBanner GetMotivoRechazo(ServiceUsuario.BEUsuario usuario,
            decimal montoDeuda)
        {
            ServicePedidoRechazado.BEGPRBanner gprBanner = null;

            try
            {
                using (var sv = new ServicePedidoRechazado.PedidoRechazadoServiceClient())
                {
                    var gprUsuario = new ServicePedidoRechazado.BEGPRUsuario()
                    {
                        IndicadorGPRSB = usuario.IndicadorGPRSB,
                        CampaniaID = usuario.CampaniaID,
                        PaisID = usuario.PaisID,
                        ConsultoraID = usuario.ConsultoraID,
                        MontoDeuda = montoDeuda,
                        Simbolo = usuario.Simbolo,
                        CodigoISO = usuario.CodigoISO,
                        MontoMinimoPedido = usuario.MontoMinimoPedido,
                        MontoMaximoPedido = usuario.MontoMaximoPedido,
                        ValidacionAbierta = usuario.ValidacionAbierta,
                        EstadoPedido = usuario.EstadoPedido
                    };

                    gprBanner = sv.GetMotivoRechazo(gprUsuario);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.PaisID.ToString(),
                    "LoginController.GetMotivoRechazo");
            }


            return gprBanner;
        }

        private static BEOfertaFlexipago GetLineaCreditoFlexipago(UsuarioModel usuarioModel)
        {
            BEOfertaFlexipago ofertaFlexipago;
            using (var svc = new PedidoServiceClient())
            {
                ofertaFlexipago = svc.GetLineaCreditoFlexipago(usuarioModel.PaisID, usuarioModel.CodigoConsultora,
                    usuarioModel.CampaniaID);
            }

            return ofertaFlexipago;
        }

        private decimal GetMontoDeuda(UsuarioModel usuarioModel)
        {
            var montoDeuda = 0.0M;

            try
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    montoDeuda = contenidoServiceClient.GetMontoDeuda(usuarioModel.PaisID, usuarioModel.CampaniaID,
                        usuarioModel.ConsultoraID, usuarioModel.CodigoUsuario, false);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora, usuarioModel.PaisID.ToString(),
                    "LoginController.GetMontoDeuda");
            }

            return montoDeuda;
        }

        protected virtual ServiceUsuario.BEUsuario GetUsuarioAndLogsIngresoPortal(int paisId, string codigoUsuario,
            int refrescarDatos)
        {
            ServiceUsuario.BEUsuario usuario;
            using (var usuarioServiceClient = new UsuarioServiceClient())
            {
                usuario = usuarioServiceClient.GetSesionUsuario(paisId, codigoUsuario);

                if (usuario != null && refrescarDatos == 0)
                {
                    try
                    {
                        usuarioServiceClient.InsLogIngresoPortal(paisId, usuario.CodigoConsultora, GetIpCliente(), 1,
                            usuario.CampaniaID.ToString(),
                            EsDispositivoMovil() ? Constantes.Canal.Mobile : Constantes.Canal.Desktop);
                    }
                    catch (Exception ex)
                    {
                        logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, paisId.ToString(),
                            string.Empty);
                        pasoLog = "Ocurrió un error al registrar log de ingreso al portal";
                    }
                }
            }

            return usuario;
        }

        protected virtual List<TipoLinkModel> GetLinksPorPais(int paisId)
        {
            List<BETipoLink> listModel;

            try
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    listModel = contenidoServiceClient.GetLinksPorPais(paisId).ToList();
                }
            }
            catch (Exception ex)
            {
                listModel = new List<BETipoLink>();
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, paisId.ToString(),
                    "LoginController.GetLinksPorPais");
            }


            return Mapper.Map<IList<BETipoLink>, List<TipoLinkModel>>(listModel);
        }

        private bool GetPermisoFlexipago(int paisId, string paisIso, string codigoConsultora, int campaniaId)
        {
            var result = false;
            var hasFlexipago = ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;
            if (hasFlexipago.Contains(paisIso))
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetPermisoFlexipago(paisId, codigoConsultora, campaniaId);
                }
            }

            return result;
        }

        private int TieneNotificaciones(ServiceUsuario.BEUsuario obeUsuario)
        {
            int tiene;
            using (var sv = new UsuarioServiceClient())
            {
                tiene = sv.GetNotificacionesSinLeer(obeUsuario.PaisID, obeUsuario.ConsultoraID,
                    obeUsuario.IndicadorBloqueoCDR);
            }

            return tiene;
        }

        private string GetFechaPromesaEntrega(int paisId, int campaniaId, string codigoConsultora, DateTime fechaFact)
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
                logManager.LogErrorWebServicesBusWrap(ex, codigoConsultora, paisId.ToString(), string.Empty);
            }

            return sFecha;
        }

        private bool EsUsuarioComunidad(int paisId, string codigoUsuario)
        {
            ServiceComunidad.BEUsuarioComunidad result = null;
            try
            {
                using (var sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        PaisId = paisId,
                        UsuarioId = 0,
                        CodigoUsuario = codigoUsuario,
                        Tipo = 3
                    });
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, codigoUsuario, paisId.ToString(), string.Empty);
            }

            return result != null;
        }

        private void ActualizarDatosHana(ref UsuarioModel model)
        {
            using (var us = new UsuarioServiceClient())
            {
                var datosConsultoraHana =
                    us.GetDatosConsultoraHana(model.PaisID, model.CodigoUsuario, model.CampaniaID);

                if (datosConsultoraHana != null)
                {
                    model.FechaLimPago = datosConsultoraHana.FechaLimPago;
                    model.MontoMinimo = datosConsultoraHana.MontoMinimoPedido;
                    model.MontoMaximo = datosConsultoraHana.MontoMaximoPedido;
                    model.MontoDeuda = datosConsultoraHana.MontoDeuda;
                    model.IndicadorFlexiPago = datosConsultoraHana.IndicadorFlexiPago;
                    model.MontoMinimoFlexipago = string.Format("{0:#,##0.00}",
                        (datosConsultoraHana.MontoMinimoFlexipago < 0 ? 0M : datosConsultoraHana.MontoMinimoFlexipago));
                }
            }
        }

        private TimeSpan CountdownODD(UsuarioModel model)
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

        private List<OfertaDelDiaModel> GetOfertaDelDiaModel(UsuarioModel model)
        {
            var ofertasDelDiaModel = new List<OfertaDelDiaModel>();

            try
            {

                var ofertasDelDia = ObtenerOfertasDelDia(model);
                if (!ofertasDelDia.Any())
                    return ofertasDelDiaModel;

                var personalizacionesOfertaDelDia = ObtenerPersonalizacionesOfertaDelDia(model);
                if (!personalizacionesOfertaDelDia.Any())
                    return ofertasDelDiaModel;

                ofertasDelDia = ofertasDelDia.OrderBy(odd => odd.Orden).ToList();
                var countdown = CountdownODD(model);

                var tablaLogica9301 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9301) ?? new BETablaLogicaDatos();
                var tablaLogica9302 = personalizacionesOfertaDelDia.FirstOrDefault(x => x.TablaLogicaDatosID == 9302) ?? new BETablaLogicaDatos();

                var contOdd = 0;
                foreach (var oferta in ofertasDelDia)
                {
                    var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;
                    oferta.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, oferta.ImagenURL, carpetaPais);

                    var oddModel = new OfertaDelDiaModel
                    {
                        CodigoIso = model.CodigoISO,
                        TipoEstrategiaID = oferta.TipoEstrategiaID,
                        EstrategiaID = oferta.EstrategiaID,
                        MarcaID = oferta.MarcaID,
                        CUV2 = oferta.CUV2,
                        LimiteVenta = oferta.LimiteVenta,
                        IndicadorMontoMinimo = oferta.IndicadorMontoMinimo,
                        TipoEstrategiaImagenMostrar = oferta.TipoEstrategiaImagenMostrar,
                        TeQuedan = countdown,
                        ImagenFondo1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"),
                            model.CodigoISO),
                        ColorFondo1 = tablaLogica9301.Codigo ?? string.Empty,
                        ImagenBanner = oferta.FotoProducto01,
                        ImagenSoloHoy = ObtenerUrlImagenOfertaDelDia(model.CodigoISO, ofertasDelDia.Count),
                //se usará mas adelante small y medium
                //oddModel.ImagenBannerSmall = Util.GenerarRutaImagenResize(oferta.FotoProducto01, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall);
                //oddModel.ImagenBannerMedium = Util.GenerarRutaImagenResize(oferta.FotoProducto01, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium);
                        ImagenFondo2 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"),
                            model.CodigoISO),
                        ColorFondo2 = tablaLogica9302.Codigo ?? string.Empty,
                        ImagenDisplay = oferta.FotoProducto01,
                        ID = contOdd++,
                        NombreOferta = ObtenerNombreOfertaDelDia(oferta.DescripcionCUV2),
                        DescripcionOferta = ObtenerDescripcionOfertaDelDia(oferta.DescripcionCUV2),
                        PrecioOferta = oferta.Precio2,
                        PrecioCatalogo = oferta.Precio,
                        TieneOfertaDelDia = true,
                        Orden = oferta.Orden
                    };

                    ofertasDelDiaModel.Add(oddModel);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, model.CodigoUsuario, model.PaisID.ToString(),
                    "LoginController.GetOfertaDelDiaModel");
            }

            return ofertasDelDiaModel;
        }

        private List<BEEstrategia> ObtenerOfertasDelDia(UsuarioModel model)
        {
            List<BEEstrategia> ofertasDelDia;

            using (var svc = new PedidoServiceClient())
            {
                ofertasDelDia = svc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora,
                    model.FechaInicioCampania.Date).ToList();
            }

            return ofertasDelDia;
        }

        private List<BETablaLogicaDatos> ObtenerPersonalizacionesOfertaDelDia(UsuarioModel model)
        {
            List<BETablaLogicaDatos> personalizacionesOfertaDelDia;
            using (var svc = new SACServiceClient())
            {
                personalizacionesOfertaDelDia =
                    svc.GetTablaLogicaDatos(model.PaisID, Constantes.TablaLogica.PersonalizacionODD).ToList();
            }

            return personalizacionesOfertaDelDia;
        }

        private string ObtenerNombreOfertaDelDia(string descripcionCuv2)
        {
            var nombreOferta = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                nombreOferta = descripcionCuv2.Split('|').First();
            }

            return nombreOferta;
        }

        private string ObtenerDescripcionOfertaDelDia(string descripcionCuv2)
        {
            var descripcionOdd = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                var temp = descripcionCuv2.Split('|').ToList();
                temp = temp.Skip(1).ToList();

                var txtBuil = new StringBuilder();
                foreach (var item in temp)
                {
                    if (!string.IsNullOrEmpty(item))
                        txtBuil.Append(item.Trim() + "|");
                }

                descripcionOdd = txtBuil.ToString();
                descripcionOdd = descripcionOdd == string.Empty
                    ? string.Empty
                    : descripcionOdd.Substring(0, descripcionOdd.Length - 1);
                descripcionOdd = descripcionOdd.Replace("|", " +<br />");
                descripcionOdd = descripcionOdd.Replace("\\", "");
                descripcionOdd = descripcionOdd.Replace("(GRATIS)", "<b>GRATIS</b>");
            }

            return descripcionOdd;
        }

        private string ObtenerUrlImagenOfertaDelDia(string codigoIso, int cantidadOfertas)
        {
            var imgSh = string.Format(ConfigurationManager.AppSettings.Get("UrlImgSoloHoyODD"), codigoIso);
            var exte = imgSh.Split('.')[imgSh.Split('.').Length - 1];
            imgSh = imgSh.Substring(0, imgSh.Length - exte.Length - 1) + (cantidadOfertas > 1 ? "s" : "") + "." + exte;
            return imgSh;
        }

        private string ObtenerCodigoRevistaFisica(int paisId)
        {
            var codigoRevista = "";
            BETablaLogicaDatos tablaLogicaDatos;
            using (var svc = new SACServiceClient())
            {
                tablaLogicaDatos = svc.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.CodigoRevistaFisica)
                    .FirstOrDefault();
            }

            if (tablaLogicaDatos != null)
            {
                codigoRevista = tablaLogicaDatos.Codigo;
            }

            return codigoRevista;
        }

        [AllowAnonymous]
        public ActionResult SesionExpirada(string returnUrl)
        {
            AsignarUrlRetorno(returnUrl);
            return View();
        }

        [AllowAnonymous]
        public JsonResult CheckUserSession()
        {
            var res = 0;

            if (HttpContext.Session != null)
            {
                res = SessionExists(res);
            }

            return Json(new
            {
                Exists = res
            }, JsonRequestBehavior.AllowGet);
        }

        private int SessionExists(int res)
        {
            var sessionCookie = HttpContext.Request.Headers["Cookie"];
            if (!(sessionCookie != null && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0)))
            {
                return res;
            }

            if (sessionManager.GetUserData() != null)
            {
                res = 1;
            }

            return res;
        }

        [AllowAnonymous]
        public ActionResult UserUnknown()
        {
            return View();
        }

        [AllowAnonymous]
        public ActionResult Admin()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult RecuperarContrasenia(int paisId, string correo)
        {
            try
            {
                string respuesta;

                using (var sv = new UsuarioServiceClient())
                {
                    respuesta = sv.RecuperarContrasenia(paisId, correo);
                }

                respuesta = Util.Trim(respuesta);
                if (respuesta == "")
                    return Json(new
                    {
                        success = false,
                        message = "Error en la respuesta del servicio de Recuperar Contraseña."
                    }, JsonRequestBehavior.AllowGet);

                var obj = respuesta.Split('|');
                var exito = obj.Length > 0 ? obj[0] : "";
                var tipomsj = obj.Length > 1 ? obj[1] : "";

                exito = exito == null ? "" : exito.Trim();
                tipomsj = tipomsj == null ? "" : tipomsj.Trim();

                if (exito == "1")
                {
                    return Json(new
                    {
                        success = true,
                        message = exito,
                        correo = correo
                    }, JsonRequestBehavior.AllowGet);
                }

                var msj = MensajesOlvideContrasena(tipomsj);
                return Json(new
                {
                    success = false,
                    message = msj
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, correo, Util.GetPaisISO(paisId));

                return Json(new
                {
                    success = false,
                    message = "Error en la respuesta del servicio de Recuperar Contraseña."
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, correo, Util.GetPaisISO(paisId), string.Empty);

                return Json(new
                {
                    success = false,
                    message = "Error en la respuesta del servicio de Recuperar Contraseña."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private string MensajesOlvideContrasena(string tipoMensaje)
        {
            var rpta = "";
            tipoMensaje = tipoMensaje ?? "";
            tipoMensaje = tipoMensaje.Trim();
            if (tipoMensaje == "1")
            {
                return ("El Número de Cédula ingresado no existe.");
            }

            if (tipoMensaje == "2")
            {
                return (
                    "No tienes un correo registrado para el envío de tu clave.<br />Por favor comunícate con el Servicio de Atención al Cliente."
                );
            }

            if (tipoMensaje == "3")
            {
                return ("Correo electrónico no identificado.");
            }

            if (tipoMensaje == "4")
            {
                return ("Te hemos enviado una nueva clave a tu correo.");
            }

            if (tipoMensaje == "5")
            {
                return ("Ocurrió un problema al recuperar tu contraseña.");
            }

            if (tipoMensaje == "6")
            {
                return ("Error al realizar proceso, inténtelo mas tarde.");
            }

            return rpta;
        }

        [HttpPost]
        public ActionResult checkExternalUser(string codigoISO, string proveedor, string appid)
        {
            pasoLog = "Login.POST.checkExternalUser";
            try
            {
                BEUsuarioExterno beUsuarioExt;

                using (var svc = new UsuarioServiceClient())
                {
                    beUsuarioExt = svc.GetUsuarioExternoByProveedorAndIdApp(proveedor, appid, null);
                }

                pasoLog = "Login.POST.checkExternalUser => UsuarioServiceClient.GetUsuarioExternoByProveedorAndIdApp";

                return Json(new
                {
                    success = true,
                    exists = beUsuarioExt != null,
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, "", codigoISO);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, "", codigoISO, pasoLog);
            }

            return Json(new
            {
                success = false,
                message = "Error al procesar la solicitud"
            });
        }

        [HttpPost]
        public ActionResult validExternalUser(string codigoISO, string proveedor, string appid, string returnUrl,
            string foto)
        {
            pasoLog = "Login.POST.ValidExternalUser";

            try
            {
                BEUsuarioExterno beUsuarioExt;
                using (var svc = new UsuarioServiceClient())
                {
                    beUsuarioExt = svc.GetUsuarioExternoByProveedorAndIdApp(proveedor, appid, foto);
                }

                if (beUsuarioExt != null)
                {
                    BEValidaLoginSB2 validaLogin;
                    using (var svc = new UsuarioServiceClient())
                    {
                        validaLogin =
                            svc.GetValidarAutoLogin(beUsuarioExt.PaisID, beUsuarioExt.CodigoUsuario, proveedor);
                    }

                    validaLogin = validaLogin ?? new BEValidaLoginSB2();
                    if (validaLogin.Result == 3)
                        return Redireccionar(beUsuarioExt.PaisID, beUsuarioExt.CodigoUsuario, returnUrl, true);

                    return Json(new
                    {
                        success = false,
                        message = validaLogin.Mensaje
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, "", codigoISO);

                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud"
                });
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, "", codigoISO, pasoLog);

                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud"
                });
            }

            return Json(new
            {
                success = false,
                message = ""
            });
        }

        [AllowAnonymous]
        [HttpGet]
        public ActionResult IngresoExterno(string token)
        {
            this.SetUniqueKeyAvoiding(Guid.NewGuid());

            IngresoExternoModel model = null;
            try
            {
                var secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";
                model = JWT.JsonWebToken.DecodeToObject<IngresoExternoModel>(token, secretKey);
                if (model == null) return RedirectToAction("UserUnknown", "Login", new {area = ""});

                var userData = sessionManager.GetUserData();
                if (userData == null || string.Compare(userData.CodigoUsuario, model.CodigoUsuario,
                        StringComparison.OrdinalIgnoreCase) != 0)
                {
                    Session.Clear();
                    userData = GetUserData(Util.GetPaisID(model.Pais), model.CodigoUsuario);
                }

                var guid = Session.TryGetUniqueIdenfier("MobileAppConfiguracion");
                this.SetUniqueKeyAvoiding(guid == Guid.Empty ? Guid.NewGuid() : guid);

                if (userData == null) return RedirectToAction("UserUnknown", "Login", new {area = ""});

                FormsAuthentication.SetAuthCookie(model.CodigoUsuario, false);

                this.SetUniqueSession("MobileAppConfiguracion", new MobileAppConfiguracionModel
                {
                    MostrarBotonAtras = !model.EsAppMobile,
                    ClienteID = model.ClienteID,
                    MostrarHipervinculo = !model.EsAppMobile,
                    EsAppMobile = model.EsAppMobile,
                    TimeOutSession = (int) FormsAuthentication.Timeout.TotalMinutes
                });

                this.SetUniqueSession("IngresoExterno", model.Version ?? "");

                if (!string.IsNullOrEmpty(model.Identifier))
                    Session.Add("TokenPedidoAutentico", AESAlgorithm.Encrypt(model.Identifier));

                Session["StartSession"] = DateTime.Now;

                switch (model.Pagina.ToUpper())
                {
                    case Constantes.IngresoExternoPagina.EstadoCuenta:
                        return RedirectToUniqueRoute("EstadoCuenta", "Index", null);
                    case Constantes.IngresoExternoPagina.SeguimientoPedido:
                        return RedirectToUniqueRoute("SeguimientoPedido", "Index",
                            new {campania = model.Campania, numeroPedido = model.NumeroPedido});
                    case Constantes.IngresoExternoPagina.PedidoDetalle:
                        var listTrue = new List<string> {"1", bool.TrueString};
                        var autoReservar = listTrue.Any(s =>
                            s.Equals(model.AutoReservar, StringComparison.OrdinalIgnoreCase));
                        return RedirectToUniqueRoute("Pedido", "Detalle", new {autoReservar = autoReservar});
                    case Constantes.IngresoExternoPagina.NotificacionesValidacionAuto:
                        return RedirectToUniqueRoute("Notificaciones", "ListarObservaciones",
                            new {ProcesoId = model.ProcesoId, TipoOrigen = 1});
                    case Constantes.IngresoExternoPagina.Pedido:
                        return RedirectToUniqueRoute("Pedido", "Index",
                            new
                            {
                                ProcesoId = model.ProcesoId,
                                TipoOrigen = 1
                            });
                    case Constantes.IngresoExternoPagina.CompartirCatalogo:
                        return RedirectToUniqueRoute("Compartir", "CompartirEnChatBot",
                            new
                            {
                                campania = model.Campania,
                                tipoCatalogo = model.TipoCatalogo,
                                url = model.UrlCatalogo
                            });
                    case Constantes.IngresoExternoPagina.MisPedidos:
                        return RedirectToUniqueRoute("MisPedidos", "Index", null);
                    case Constantes.IngresoExternoPagina.ShowRoom:
                        return RedirectToUniqueRoute("ShowRoom", "Procesar", null);
                    case Constantes.IngresoExternoPagina.ProductosAgotados:
                        return RedirectToUniqueRoute("ProductosAgotados", "Index", null);
                    case Constantes.IngresoExternoPagina.Ofertas:
                        return RedirectToUniqueRoute("Ofertas", "Index", null);
                }
            }
            catch (Exception ex)
            {
                if (model != null)
                {
                    logManager.LogErrorWebServicesBusWrap(ex, model.CodigoUsuario, model.Pais, token);
                }
                else
                {
                    logManager.LogErrorWebServicesBusWrap(ex, token, "", string.Empty);
                }

                return HttpNotFound("Error: " + ex.Message);
            }

            return RedirectToAction("UserUnknown", "Login", new {area = ""});
        }

        private ConsultoraRegaloProgramaNuevasModel GetConsultoraRegaloProgramaNuevas(UsuarioModel model)
        {
            ConsultoraRegaloProgramaNuevasModel result = null;
            pasoLog = "GetConsultoraRegaloProgramaNuevas";

            try
            {
                BEConsultoraRegaloProgramaNuevas entidad;
                using (var svc = new PedidoServiceClient())
                {
                    entidad = svc.GetConsultoraRegaloProgramaNuevas(model.PaisID, model.CampaniaID,
                        model.CodigoConsultora, model.CodigorRegion, model.CodigoZona);
                }

                if (entidad != null)
                {
                    var listaProdCatalogo = new List<Producto>();
                    if (!string.IsNullOrEmpty(entidad.CodigoSap))
                    {
                        using (var svc = new ProductoServiceClient())
                        {
                            listaProdCatalogo =
                                svc.ObtenerProductosPorCampaniasBySap(model.CodigoISO, model.CampaniaID,
                                    entidad.CodigoSap, 3).ToList();
                        }
                    }

                    if (listaProdCatalogo.Any())
                    {
                        var prodCatalogo = listaProdCatalogo.FirstOrDefault();
                        if (prodCatalogo != null)
                        {
                            var dd = (!string.IsNullOrEmpty(prodCatalogo.NombreComercial)
                                ? prodCatalogo.NombreComercial
                                : prodCatalogo.DescripcionComercial);
                            if (!string.IsNullOrEmpty(dd)) entidad.DescripcionPremio = dd;

                            if (prodCatalogo.PrecioCatalogo > 0) entidad.PrecioCatalogo = prodCatalogo.PrecioCatalogo;
                            if (prodCatalogo.PrecioValorizado > 0)
                                entidad.PrecioValorizado = prodCatalogo.PrecioValorizado;
                            entidad.UrlImagenRegalo = prodCatalogo.Imagen;
                        }
                    }

                    result = Mapper.Map<BEConsultoraRegaloProgramaNuevas, ConsultoraRegaloProgramaNuevasModel>(entidad);
                    result.CodigoIso = model.CodigoISO;
                    result.DescripcionPremio = result.DescripcionPremio.ToUpper();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, model.CodigoConsultora, model.CodigoISO, pasoLog);
            }

            return result;
        }


        private RedirectToRouteResult RedirectToUniqueRoute(string controller, string action, object routeData)
        {
            var route = new RouteValueDictionary(new
            {
                Controller = controller,
                Action = action,
                guid = this.GetUniqueKey()
            });

            if (routeData != null)
            {
                var routeDataAditional = new RouteValueDictionary(routeData);
                routeDataAditional.ForEach(item => { route.Add(item.Key, item.Value); });
            }

            return RedirectToRoute("UniqueRoute", route);
        }

        private void FormatTextConfiguracionPaisDatosModel(ref RevistaDigitalModel revistaDigital,
            string nombreConsultora)
        {
            if (revistaDigital == null) return;
            if (revistaDigital.ConfiguracionPaisDatos == null) return;

            foreach (var configuracionPaisDato in revistaDigital.ConfiguracionPaisDatos)
            {
                configuracionPaisDato.Valor1 = RemplazaTagNombre(configuracionPaisDato.Valor1, nombreConsultora);
                configuracionPaisDato.Valor2 = RemplazaTagNombre(configuracionPaisDato.Valor2, nombreConsultora);
            }
        }

        private string RemplazaTagNombre(string cadena, string nombre)
        {
            cadena = Util.Trim(cadena);
            nombre = Util.Trim(nombre);
            return cadena.Replace(Constantes.TagCadenaRd.Nombre, nombre)
                .Replace(Constantes.TagCadenaRd.Nombre1, nombre)
                .Replace(Constantes.TagCadenaRd.Nombre2, nombre);
        }
    }
}