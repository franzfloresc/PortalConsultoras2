using AutoMapper;
using ClosedXML.Excel;
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
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using BEConfiguracionPaisDatos = Portal.Consultoras.Web.ServiceUsuario.BEConfiguracionPaisDatos;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginController : Controller
    {
        private string pasoLog;
        private int misCursos = 0;
        private int flagMiAcademiaVideo = 0;  //  PPC
        private readonly string IP_DEFECTO = "190.187.154.154";
        private readonly string ISO_DEFECTO = Constantes.CodigosISOPais.Peru;
        private readonly int USUARIO_VALIDO = 3;

        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        protected ILogManager logManager = LogManager.LogManager.Instance;

        #region Constructor

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

        #endregion

        #region ActionResult

        [AllowAnonymous]
        public async Task<ActionResult> Index(string returnUrl = null)
        {
            MisCursos();

            if (EsUsuarioAutenticado())
            {
                if (misCursos > 0)
                {
                    sessionManager.SetMiAcademia(misCursos);
                    sessionManager.SetMiAcademiaVideo(flagMiAcademiaVideo);  //PPC
                    return RedirectToAction("Index", "MiAcademia");
                }

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
                model.ListaEventos = await ObtenerEventoFestivo(0, Constantes.EventoFestivoAlcance.LOGIN, 0);

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
        [AllowAnonymous]
        [HttpGet]
        [Route("Login/Login/{param?}")]
        public ActionResult Login(string param)
        {
            return RedirectToAction("Index", "Login");
        }

        private void MisCursos()
        {
            TempData["MiAcademia"] = 0;
            TempData["FlagAcademiaVideo"] = 0;
            var url = (Request.Url.OriginalString).Split('?');
            if (url.Length > 1)
            {
                var MiCurso = url[1].Split('=');
                var MiId = MiCurso[1].Split('&');
                TempData["FlagAcademiaVideo"] = 1;
                // if (Util.IsNumeric(MiCurso[1]))
                if (Util.IsNumeric(MiId[0]))
                   {
                    misCursos = Convert.ToInt32(MiId[0]);
                    TempData["MiAcademia"] = misCursos;
                    // PPC
                    if (MiCurso[0].ToUpper() == "MIACADEMIAVIDEO")
                    {
                        flagMiAcademiaVideo = 1;
                    }
                    // PPC
                    else
                    {
                        TempData["FlagAcademiaVideo"] = 0;
                        flagMiAcademiaVideo = 0;
                    }
                    

                }
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> Login(LoginModel model, string returnUrl = null)
        {
            pasoLog = "Login.POST.Index";
            try
            {
                TempData["serverPaisId"] = model.PaisID;
                TempData["serverPaisISO"] = model.CodigoISO;
                TempData["serverCodigoUsuario"] = model.CodigoUsuario;

                if (model.PaisID == 0)
                    model.PaisID = Util.GetPaisID(model.CodigoISO);

                var resultadoInicioSesion = await ObtenerResultadoInicioSesion(model);


                if (resultadoInicioSesion != null && resultadoInicioSesion.Result == USUARIO_VALIDO)
                {
                    TempData["usuarioValidado"] = "1";
                    if (model.UsuarioExterno == null)
                        return await Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl);

                    if (resultadoInicioSesion.TipoUsuario == Constantes.TipoUsuario.Postulante &&
                        Request.IsAjaxRequest())
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Por ahora no podemos asociar tu cuenta con Facebook."
                        });
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
                                    ? await Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl, true)
                                    : Json(new
                                    {
                                        success = true,
                                        message = "El codigo de consultora se asoció con su cuenta de Facebook"
                                    });
                            }
                        }
                    }

                    return await Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl);
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
                return RedirectToAction("Index", "Login");
            }

            if (Request.IsAjaxRequest())
            {
                return Json(new
                {
                    success = true,
                    redirectTo = Url.Action("Index", "Login")
                });
            }
            return RedirectToAction("Index", "Login");
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> LoginAdmin(UsuarioModel model)
        {
            var resultado = Util.ValidarUsuarioADFS(model.CodigoUsuario, model.ClaveSecreta);

            var codigoResultado = resultado.Split('|')[0];
            var mensajeResultado = resultado.Split('|')[1];
            var paisIso = resultado.Split('|')[2];

            if (codigoResultado == "000")
            {
                var paisId = Util.GetPaisID(paisIso);
                return await Redireccionar(paisId, model.CodigoUsuario);
            }

            TempData["errorLoginAdmin"] = mensajeResultado;
            return RedirectToAction("Admin", "Login");
        }

        public async Task<ActionResult> Redireccionar(int paisId, string codigoUsuario, string returnUrl = null,
            bool hizoLoginExterno = false)
        {
            if (!Convert.ToBoolean(TempData["FlagPin"]) && TieneVerificacionAutenticidad(paisId, codigoUsuario))
            {
                if (Request.IsAjaxRequest())
                {
                    return Json(new
                    {
                        success = true,
                        redirectTo = Url.Action("VerificaAutenticidad", "Login")
                    });
                }
                return RedirectToAction("VerificaAutenticidad", "Login");
            }

            Session["DatosUsuario"] = null;

            pasoLog = "Login.Redireccionar";
            var usuario = await GetUserData(paisId, codigoUsuario);

            misCursos = Convert.ToInt32(TempData["MiAcademia"]);
            sessionManager.SetMiAcademia(misCursos);

            if (misCursos > 0)
            {
                flagMiAcademiaVideo = Convert.ToInt32(TempData["FlagAcademiaVideo"]);  //PPC
                sessionManager.SetMiAcademiaVideo(flagMiAcademiaVideo);  //PPC
                
                returnUrl = Url.Action("Index", "MiAcademia");

                if (usuario.RolID != Constantes.Rol.Consultora)
                {
                    returnUrl = "";
                }
            }

            if (usuario == null)
            {
                if (Request.IsAjaxRequest())
                {
                    return Json(new
                    {
                        success = false,
                        redirectTo = "Error al procesar la solicitud"
                    });
                }
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
                    string urlx = string.Empty;

                    if (Url.IsLocalUrl(decodedUrl))
                    {
                        urlx = decodedUrl;
                    }
                    else
                    {
                        if (EsAndroid())
                            urlx = Url.Action("Index", "DescargarApp", new { area = "Mobile" });
                        else
                            urlx = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    }

                    if (Request.IsAjaxRequest())
                    {
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
                    if (EsAndroid())
                        return RedirectToAction("Index", "DescargarApp", new { area = "Mobile" });
                    else
                        return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
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
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            return RedirectToAction("Index", "Bienvenida");
        }

        [AllowAnonymous]
        public ActionResult SesionExpirada(string returnUrl)
        {
            AsignarUrlRetorno(returnUrl);
            return View();
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
        public ActionResult VerificaAutenticidad()
        {
            if (Session["DatosUsuario"] == null) return RedirectToAction("Index", "Login");
            var obj = (BEUsuarioDatos)Session["DatosUsuario"];
            var model = new BEUsuarioDatos();
            model.PrimerNombre = obj.PrimerNombre;
            model.MensajeSaludo = obj.MensajeSaludo;
            model.CorreoEnmascarado = obj.CorreoEnmascarado;
            model.CelularEnmascarado = obj.CelularEnmascarado;
            model.OpcionCorreoDesabilitado = obj.OpcionCorreoDesabilitado;
            model.OpcionSmsDesabilitado = obj.OpcionSmsDesabilitado;
            model.HoraRestanteCorreo = obj.HoraRestanteCorreo;
            model.HoraRestanteSms = obj.HoraRestanteSms;
            model.IdEstadoActividad = obj.IdEstadoActividad;
            model.CodigoIso = obj.CodigoIso;
            model.PrimerNombre = obj.PrimerNombre;
            model.CodigoUsuario = obj.CodigoUsuario;
            model.Correo = obj.Correo;
            model.MostrarOpcion = obj.MostrarOpcion;
            model.OpcionChat = obj.OpcionChat;
            model.EsMobile = EsDispositivoMovil();
            return View(model);
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
        public async Task<ActionResult> validExternalUser(string codigoISO, string proveedor, string appid, string returnUrl,
            string foto)
        {
            pasoLog = "Login.POST.ValidExternalUser";

            try
            {
                BEUsuarioExterno beUsuarioExt;
                using (var svc = new UsuarioServiceClient())
                {
                    beUsuarioExt = await svc.GetUsuarioExternoByProveedorAndIdAppAsync(proveedor, appid, foto);
                }

                if (beUsuarioExt != null)
                {
                    BEValidaLoginSB2 validaLogin;
                    using (var svc = new UsuarioServiceClient())
                    {
                        validaLogin = await svc.GetValidarAutoLoginAsync(beUsuarioExt.PaisID, beUsuarioExt.CodigoUsuario, proveedor);
                    }

                    validaLogin = validaLogin ?? new BEValidaLoginSB2();
                    if (validaLogin.Result == 3)
                        return await Redireccionar(beUsuarioExt.PaisID, beUsuarioExt.CodigoUsuario, returnUrl, true);

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
        public async Task<ActionResult> IngresoExterno(string token)
        {
            this.SetUniqueKeyAvoiding(Guid.NewGuid());

            IngresoExternoModel model = null;
            try
            {
                var secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";
                model = JWT.JsonWebToken.DecodeToObject<IngresoExternoModel>(token, secretKey);
                if (model == null) return RedirectToAction("UserUnknown", "Login", new { area = "" });

                var userData = sessionManager.GetUserData();
                if (userData == null || string.Compare(userData.CodigoUsuario, model.CodigoUsuario, StringComparison.OrdinalIgnoreCase) != 0)
                {
                    TempData["LimpiarLocalStorage"] = true;
                    Session.Clear();
                    userData = await GetUserData(Util.GetPaisID(model.Pais), model.CodigoUsuario, 0, true);
                }

                var guid = Session.TryGetUniqueIdenfier("MobileAppConfiguracion");
                this.SetUniqueKeyAvoiding(guid == Guid.Empty ? Guid.NewGuid() : guid);

                if (userData == null) return RedirectToAction("UserUnknown", "Login", new { area = "" });

                FormsAuthentication.SetAuthCookie(model.CodigoUsuario, false);

                this.SetUniqueSession("MobileAppConfiguracion", new MobileAppConfiguracionModel
                {
                    MostrarBotonAtras = !model.EsAppMobile,
                    ClienteID = model.ClienteID,
                    MostrarHipervinculo = !model.EsAppMobile,
                    EsAppMobile = model.EsAppMobile,
                    TimeOutSession = (int)FormsAuthentication.Timeout.TotalMinutes,
                    Campania = Convert.ToInt32(model.Campania)
                });

                this.SetUniqueSession("IngresoExterno", model.Version ?? "");

                if (!string.IsNullOrEmpty(model.Identifier))
                    Session.Add("TokenPedidoAutentico", AESAlgorithm.Encrypt(model.Identifier));

                sessionManager.SetStartSession(DateTime.Now);
                model.Pagina = model.Pagina ?? "";
                switch (model.Pagina.ToUpper())
                {
                    case Constantes.IngresoExternoPagina.EstadoCuenta:
                        return RedirectToUniqueRoute("EstadoCuenta", "Index", null);
                    case Constantes.IngresoExternoPagina.SeguimientoPedido:
                        return RedirectToUniqueRoute("SeguimientoPedido", "Index",
                            new { campania = model.Campania, numeroPedido = model.NumeroPedido });
                    case Constantes.IngresoExternoPagina.PedidoDetalle:
                        var listTrue = new List<string> { "1", bool.TrueString };
                        var autoReservar = listTrue.Any(s =>
                            s.Equals(model.AutoReservar, StringComparison.OrdinalIgnoreCase));
                        return RedirectToUniqueRoute("Pedido", "Detalle", new { autoReservar = autoReservar });
                    case Constantes.IngresoExternoPagina.NotificacionesValidacionAuto:
                        return RedirectToUniqueRoute("Notificaciones", "ListarObservaciones",
                            new { ProcesoId = model.ProcesoId, TipoOrigen = 1 });
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
                    case Constantes.IngresoExternoPagina.GuiaNegocio:
                        return RedirectToUniqueRoute("GuiaNegocio", "Index", null);
                    case Constantes.IngresoExternoPagina.RevistaDigitalInformacion:
                        return RedirectToUniqueRoute("RevistaDigital", "Informacion", null);
                    case Constantes.IngresoExternoPagina.LiquidacionWeb:
                        return RedirectToUniqueRoute("OfertaLiquidacion", "Index", null);
                    case Constantes.IngresoExternoPagina.CambiosDevoluciones:
                        return RedirectToUniqueRoute("MisReclamos", "Index", null);
                    case Constantes.IngresoExternoPagina.PedidosFIC:
                        return RedirectToUniqueRoute("PedidoFIC", "Index", null);
                    case Constantes.IngresoExternoPagina.DetalleEstrategia:
                        return RedirectToUniqueRoute("DetalleEstrategia", "Ficha", new
                        {
                            palanca = model.NombrePalanca,
                            campaniaId = model.Campania,
                            cuv = model.CUV,
                            origen = Constantes.IngresoExternoOrigen.App
                        });
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

            return RedirectToAction("UserUnknown", "Login", new { area = "" });
        }

        /// <summary>
        /// Obtiene la URL para el chat que se mostrara dependiendo del pais.
        /// </summary>
        /// <returns>URL: chat relacionado al pais</returns>
        public ActionResult ChatBelcorp(int paisId, string codigoUsuario)
        {
            string url = "";
            string paisISO = Util.GetPaisISO(paisId);
            try
            {
                if ((ConfigurationManager.AppSettings["PaisesBelcorpChatEMTELCO"] ?? "").Contains(paisISO))
                {
                    BEUsuarioChatEmtelco usuarioChatEmtelco = null;
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        usuarioChatEmtelco = sv.GetUsuarioChatEmtelco(paisId, codigoUsuario);
                    }

                    url = String.Format(
                        ConfigurationManager.AppSettings["UrlBelcorpChat"] ?? "",
                        usuarioChatEmtelco.SegmentoAbreviatura.Trim(),
                        codigoUsuario.Trim(),
                        usuarioChatEmtelco.PrimerNombre.Split(' ').First().Trim(),
                        usuarioChatEmtelco.Email.Trim(),
                        paisISO
                    );
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, codigoUsuario, paisISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoUsuario, paisISO);
            }

            ViewBag.UrlBelcorpChatPais = url;
            return View();
        }

        #endregion

        #region JsonResult

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
        
        private JsonResult SuccessJson(string message, bool allowGet = false)
        {
            return Json(new { success = allowGet, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }

        #endregion

        private async Task<BEValidaLoginSB2> ObtenerResultadoInicioSesion(LoginModel model)
        {
            BEValidaLoginSB2 resultadoInicioSesion;

            using (var svc = new UsuarioServiceClient())
            {
                resultadoInicioSesion = await svc.GetValidarLoginSB2Async(model.PaisID, model.CodigoUsuario, model.ClaveSecreta);
            }

            return resultadoInicioSesion;
        }

        public async Task<UsuarioModel> GetUserData(int paisId, string codigoUsuario, int refrescarDatos = 0, bool esAppMobile = false)
        {
            pasoLog = "Login.GetUserData";
            sessionManager.SetIsContrato(1);
            sessionManager.SetIsOfertaPack(1);

            var usuarioModel = (UsuarioModel)null;

            try
            {
                if (paisId == 0)
                    throw new ArgumentException("Parámetro paisId no puede ser cero.");

                if (string.IsNullOrEmpty(codigoUsuario))
                    throw new ArgumentException("Parámetro codigoUsuario no puede ser vacío.");

                var usuario = await GetUsuarioAndLogsIngresoPortal(paisId, codigoUsuario, refrescarDatos);

                if (usuario != null)
                {
                    #region
                    usuarioModel = new UsuarioModel();
                    usuarioModel.CompraVDirectaCer = usuario.CompraVDirecta;
                    usuarioModel.IVACompraVDirectaCer = usuario.IVACompraVDirecta;
                    usuarioModel.RetailCer = usuario.Retail;
                    usuarioModel.IVARetailCer = usuario.IVARetail;
                    usuarioModel.TotalCompraCer = usuario.TotalCompra;
                    usuarioModel.IvaTotalCer = usuario.IvaTotal;
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
                    usuarioModel.CodigoUsuarioHost = string.Format("{0}({1})", usuario.CodigoUsuario, GetLogonUserIdentityName());
                    usuarioModel.CodigoConsultora = usuario.CodigoConsultora;
                    usuarioModel.NombreConsultora = usuario.Nombre;
                    usuarioModel.RolID = usuario.RolID;
                    usuarioModel.CampaniaID = usuario.CampaniaID;
                    usuarioModel.BanderaImagen = usuario.BanderaImagen;
                    usuarioModel.CambioClave = Convert.ToInt32(usuario.CambioClave);
                    usuarioModel.ConsultoraNueva = usuario.ConsultoraNueva;
                    usuarioModel.EsConsultoraNueva = usuario.EsConsultoraNueva;
                    usuarioModel.EsConsultoraOficina = usuario.EsConsultoraOficina;
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

                    usuarioModel.DocumentoIdentidad = usuario.DocumentoIdentidad;
                    usuarioModel.PromedioVenta = usuario.PromedioVenta;
                    #endregion

                    if (usuarioModel.RolID == Constantes.Rol.Consultora)
                    {
                        #region Hana

                        if (usuarioModel.TieneHana == 1)
                        {
                            if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                            {
                                var usuarioHana = await ActualizarDatosHana(usuarioModel);
                                if (usuarioHana != null)
                                {
                                    usuarioModel.FechaLimPago = usuarioHana.FechaLimPago;
                                    usuarioModel.MontoMinimo = usuarioHana.MontoMinimoPedido;
                                    usuarioModel.MontoMaximo = usuarioHana.MontoMaximoPedido;
                                    usuarioModel.MontoDeuda = usuarioHana.MontoDeuda;
                                    usuarioModel.IndicadorFlexiPago = usuarioHana.IndicadorFlexiPago;
                                    usuarioModel.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", (usuarioHana.MontoMinimoFlexipago < 0 ? 0M : usuarioHana.MontoMinimoFlexipago));
                                }
                            }
                        }
                        else
                        {
                            usuarioModel.MontoMinimo = usuario.MontoMinimoPedido;
                            usuarioModel.MontoMaximo = usuario.MontoMaximoPedido;
                            usuarioModel.FechaLimPago = usuario.FechaLimPago;
                            usuarioModel.IndicadorFlexiPago = usuario.IndicadorFlexiPago;

                            var montoDeudaTask = Task.Run(() => GetMontoDeuda(usuarioModel));
                            var ofertaFlexipagoTask = Task.Run(() => GetLineaCreditoFlexipago(usuarioModel));
                            Task.WaitAll(montoDeudaTask, ofertaFlexipagoTask);

                            usuarioModel.MontoDeuda = montoDeudaTask.Result;

                            var ofertaFlexipago = ofertaFlexipagoTask.Result;

                            if (ofertaFlexipago == null)
                                usuarioModel.MontoMinimoFlexipago = "0.00";
                            else
                            {
                                var montoMinimoFlexipago = ofertaFlexipago.MontoMinimoFlexipago < 0 ? 0M : ofertaFlexipago.MontoMinimoFlexipago;
                                usuarioModel.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", montoMinimoFlexipago);
                            }
                        }

                        #endregion

                        #region llamadas asincronas para GPR, ODD, RegaloPN, LoginFB, EventoFestivo, IncentivosConcursos

                        var motivoRechazoTask = Task.Run(() => GetMotivoRechazo(usuario, usuarioModel.MontoDeuda, esAppMobile));
                        var regaloProgramaNuevas = Task.Run(() => GetConsultoraRegaloProgramaNuevas(usuarioModel));
                        var loginExternoTask = Task.Run(() => GetListaLoginExterno(usuario));
                        var eventoFestivoTask = Task.Run(() => ConfigurarEventoFestivo(usuarioModel));
                        var incentivoConcursoTask = Task.Run(() => ConfigurarIncentivosConcursos(usuarioModel));

                        Task.WaitAll(motivoRechazoTask, regaloProgramaNuevas, loginExternoTask, eventoFestivoTask, incentivoConcursoTask);

                        #region GPR

                        usuarioModel.IndicadorGPRSB = usuario.IndicadorGPRSB;

                        var gprBanner = motivoRechazoTask.Result;
                        if (gprBanner != null)
                        {
                            usuarioModel.GPRBannerUrl = gprBanner.BannerUrl;
                            usuarioModel.GPRBannerTitulo = gprBanner.BannerTitulo;
                            usuarioModel.GPRBannerMensaje = gprBanner.BannerMensaje;
                            usuarioModel.RechazadoXdeuda = gprBanner.RechazadoXdeuda;
                            usuarioModel.MostrarBannerRechazo = gprBanner.MostrarBannerRechazo;
                        }

                        #endregion

                        #region RegaloPN

                        usuarioModel.ConsultoraRegaloProgramaNuevas = regaloProgramaNuevas.Result;

                        #endregion

                        #region LoginFB

                        usuarioModel.TieneLoginExterno = usuario.TieneLoginExterno;
                        usuarioModel.ListaLoginExterno = loginExternoTask.Result;

                        #endregion

                        #region EventoFestivo

                        sessionManager.SetEventoFestivoDataModel(eventoFestivoTask.Result);

                        #endregion

                        #region IncentivosConcursos

                        usuarioModel.CodigosConcursos = string.Empty;
                        usuarioModel.CodigosProgramaNuevas = string.Empty;

                        var arrCalculoPuntos = Constantes.Incentivo.CalculoPuntos.Split(';');
                        var arrCalculoProgramaNuevas = Constantes.Incentivo.CalculoProgramaNuevas.Split(';');

                        var Concursos = incentivoConcursoTask.Result.Where(x => arrCalculoPuntos.Contains(x.TipoConcurso));
                        if (Concursos.Any()) usuarioModel.CodigosConcursos = string.Join("|", Concursos.Select(c => c.CodigoConcurso));

                        var ProgramaNuevas = incentivoConcursoTask.Result.Where(x => arrCalculoProgramaNuevas.Contains(x.TipoConcurso));
                        if (ProgramaNuevas.Any()) usuarioModel.CodigosProgramaNuevas = string.Join("|", ProgramaNuevas.Select(c => c.CodigoConcurso));

                        #endregion

                        #endregion

                        #region ConfiguracionPais

                        usuarioModel = await ConfiguracionPaisUsuario(usuarioModel);

                        #endregion

                        #region LLamadas asincronas 

                        var flexiPagoTask = Task.Run(() => GetPermisoFlexipago(usuario));
                        var notificacionTask = Task.Run(() => TieneNotificaciones(usuario, usuarioModel.TienePagoEnLinea));
                        var fechaPromesaTask = Task.Run(() => GetFechaPromesaEntrega(usuario));
                        var linkPaisTask = Task.Run(() => GetLinksPorPais(usuario.PaisID));
                        var usuarioComunidadTask = Task.Run(() => EsUsuarioComunidad(usuario));

                        Task.WaitAll(flexiPagoTask, notificacionTask, fechaPromesaTask, linkPaisTask, usuarioComunidadTask);

                        usuarioModel.IndicadorPermisoFlexipago = flexiPagoTask.Result;
                        usuarioModel.TieneNotificaciones = notificacionTask.Result;

                        var fechaPromesa = fechaPromesaTask.Result;
                        if (!string.IsNullOrEmpty(fechaPromesa))
                        {
                            var arrValores = fechaPromesa.Split('|');
                            usuarioModel.TipoCasoPromesa = arrValores[2].ToString();
                            usuarioModel.DiasCasoPromesa = Convert.ToInt16(arrValores[1].ToString());
                            usuarioModel.FechaPromesaEntrega = Convert.ToDateTime(arrValores[0].ToString());
                        }

                        var lista = linkPaisTask.Result;
                        if (lista.Count > 0)
                        {
                            usuarioModel.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                            usuarioModel.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                            usuarioModel.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                        }

                        usuarioModel.EsUsuarioComunidad = usuarioComunidadTask.Result;

                        #endregion
                    }

                    if (usuarioModel.CatalogoPersonalizado != 0)
                    {
                        var lstFiltersFAV = await CargarFiltersFAV(usuarioModel);
                        if (lstFiltersFAV.Any()) sessionManager.SetListFiltersFAV(lstFiltersFAV);
                    }

                    usuarioModel.EsLebel = GetPaisesLbelFromConfig().Contains(usuarioModel.CodigoISO);
                    usuarioModel.MensajeChat = await GetMessageChat(usuarioModel.PaisID);

                    usuarioModel.PuedeActualizar = usuario.PuedeActualizar;
                    usuarioModel.PuedeEnviarSMS = usuario.PuedeEnviarSMS;
                    usuarioModel.FotoPerfilAncha = usuario.FotoPerfilAncha;

                    sessionManager.SetFlagLogCargaOfertas(HabilitarLogCargaOfertas(usuarioModel.PaisID));
                    sessionManager.SetTieneLan(true);
                    sessionManager.SetTieneLanX1(true);
                    sessionManager.SetTieneOpt(true);
                    sessionManager.SetTieneOpm(true);
                    sessionManager.SetTieneOpmX1(true);
                    sessionManager.SetTieneHv(true);
                    sessionManager.SetTieneHvX1(true);

                    usuarioModel.FotoPerfil = usuario.FotoPerfil;
                    usuarioModel.FotoOriginalSinModificar = usuario.FotoOriginalSinModificar;
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

        #region metodos asincronos

        private async Task<string> GetMessageChat(int paisId)
        {
            IEnumerable<BETablaLogicaDatos> datos;
            using (var service = new SACServiceClient())
            {
                datos = await service.GetTablaLogicaDatosAsync(paisId, 142);
            }

            if (datos == null)
            {
                return string.Empty;
            }

            var result = datos.FirstOrDefault(r => r.TablaLogicaDatosID == 14201);
            return result == null ? string.Empty : result.Valor;
        }

        private async Task<bool> GetPermisoFlexipago(ServiceUsuario.BEUsuario usuario)
        {
            if (usuario.TipoUsuario != Constantes.TipoUsuario.Consultora) return false;

            bool result = false;
            var hasFlexipago = ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;
            if (hasFlexipago.Contains(usuario.CodigoISO))
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = await sv.GetPermisoFlexipagoAsync(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID);
                }
            }

            return result;
        }

        private async Task<int> TieneNotificaciones(ServiceUsuario.BEUsuario usuario, bool tienePagoEnLinea)
        {
            if (usuario.TipoUsuario != Constantes.TipoUsuario.Consultora) return 0;

            int tiene;
            using (var sv = new UsuarioServiceClient())
            {
                tiene = await sv.GetNotificacionesSinLeerAsync(usuario.PaisID, usuario.ConsultoraID, usuario.IndicadorBloqueoCDR, tienePagoEnLinea);
            }

            return tiene;
        }

        private async Task<string> GetFechaPromesaEntrega(ServiceUsuario.BEUsuario usuario)
        {
            if (!(usuario.CampaniaID != 0 && usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)) return string.Empty;

            var sFecha = Convert.ToDateTime("2000-01-01").ToString();

            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    sFecha = await sv.GetFechaPromesaCronogramaByCampaniaAsync(usuario.PaisID, usuario.CampaniaID, usuario.CodigoConsultora, usuario.FechaInicioFacturacion);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.PaisID.ToString(), "LoginController.GetFechaPromesaEntrega");
            }
            return sFecha;
        }

        private async Task<List<TipoLinkModel>> GetLinksPorPais(int paisId)
        {
            List<BETipoLink> listModel;
            try
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    var lst = await contenidoServiceClient.GetLinksPorPaisAsync(paisId);
                    listModel = lst.ToList();
                }
            }
            catch (Exception ex)
            {
                listModel = new List<BETipoLink>();
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, paisId.ToString(), "LoginController.GetLinksPorPaisAsync");
            }

            return Mapper.Map<IList<BETipoLink>, List<TipoLinkModel>>(listModel);
        }


        private async Task<bool> EsUsuarioComunidad(ServiceUsuario.BEUsuario usuario)
        {
            if (usuario.TipoUsuario != Constantes.TipoUsuario.Consultora) return false;

            ServiceComunidad.BEUsuarioComunidad result = null;
            try
            {
                using (var sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = await sv.GetUsuarioInformacionAsync(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        PaisId = usuario.PaisID,
                        UsuarioId = 0,
                        CodigoUsuario = usuario.CodigoUsuario,
                        Tipo = 3
                    });
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoUsuario, usuario.PaisID.ToString(), "LoginController.EsUsuarioComunidad");
            }

            return result != null;
        }

        private async Task<ServiceUsuario.BEUsuario> ActualizarDatosHana(UsuarioModel model)
        {
            using (var us = new UsuarioServiceClient())
            {
                return await us.GetDatosConsultoraHanaAsync(model.PaisID, model.CodigoUsuario, model.CampaniaID);
            }
        }

        private async Task<decimal> GetMontoDeuda(UsuarioModel usuarioModel)
        {
            var montoDeuda = 0.0M;
            try
            {
                if (usuarioModel.TipoUsuario != Constantes.TipoUsuario.Consultora) return montoDeuda;

                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    montoDeuda = await contenidoServiceClient.GetMontoDeudaAsync(usuarioModel.PaisID, usuarioModel.CampaniaID, usuarioModel.ConsultoraID, usuarioModel.CodigoUsuario, false);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora, usuarioModel.PaisID.ToString(), "LoginController.GetMontoDeuda");
            }

            return montoDeuda;
        }

        private async Task<BEOfertaFlexipago> GetLineaCreditoFlexipago(UsuarioModel usuarioModel)
        {
            if (!(usuarioModel.IndicadorFlexiPago > 0 && usuarioModel.EsConsultora())) return null;

            BEOfertaFlexipago ofertaFlexipago;

            using (var svc = new PedidoServiceClient())
            {
                ofertaFlexipago = await svc.GetLineaCreditoFlexipagoAsync(usuarioModel.PaisID, usuarioModel.CodigoConsultora, usuarioModel.CampaniaID);
            }

            return ofertaFlexipago;
        }

        private async Task<ServicePedidoRechazado.BEGPRBanner> GetMotivoRechazo(ServiceUsuario.BEUsuario usuario, decimal montoDeuda, bool esAppMobile)
        {
            ServicePedidoRechazado.BEGPRBanner gprBanner = null;
            if (usuario.TipoUsuario != Constantes.TipoUsuario.Consultora) return gprBanner;
            if (esAppMobile) return gprBanner;

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
                    gprBanner = await sv.GetMotivoRechazoAsync(gprUsuario);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.PaisID.ToString(), "LoginController.GetMotivoRechazo");
            }

            return gprBanner;
        }

        private async Task<ConsultoraRegaloProgramaNuevasModel> GetConsultoraRegaloProgramaNuevas(UsuarioModel model)
        {
            ConsultoraRegaloProgramaNuevasModel result = null;
            pasoLog = "GetConsultoraRegaloProgramaNuevas";

            try
            {
                if ((GetRegaloProgramaNuevasFlag() != "1")) return result;

                var fechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
                var esDiasFacturacion = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date;
                if (!esDiasFacturacion) return result;

                BEConsultoraRegaloProgramaNuevas entidad;
                using (var svc = new PedidoServiceClient())
                {
                    entidad = await svc.GetConsultoraRegaloProgramaNuevasAsync(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.ConsecutivoNueva);
                }

                if (entidad != null)
                {
                    var listaProdCatalogo = new List<Producto>();
                    if (!string.IsNullOrEmpty(entidad.CodigoSap))
                    {
                        using (var svc = new ProductoServiceClient())
                        {
                            var lst = await svc.ObtenerProductosPorCampaniasBySapAsync(model.CodigoISO, model.CampaniaID, entidad.CodigoSap, 3);
                            listaProdCatalogo = lst.ToList();
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

        private async Task<List<UsuarioExternoModel>> GetListaLoginExterno(ServiceUsuario.BEUsuario usuario)
        {
            if (!usuario.TieneLoginExterno) return new List<UsuarioExternoModel>();

            using (var usuarioServiceClient = new UsuarioServiceClient())
            {
                var result = await usuarioServiceClient.GetListaLoginExternoAsync(usuario.PaisID, usuario.CodigoUsuario);
                return Mapper.Map<List<BEUsuarioExterno>, List<UsuarioExternoModel>>(result.ToList());
            }
        }

        protected virtual async Task<List<ConfiguracionPaisModel>> GetConfiguracionPais(UsuarioModel usuarioModel)
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
                    var lst = await sv.GetConfiguracionPaisAsync(config);
                    listaConfigPais = lst.ToList();
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

        protected virtual async Task<List<BEConfiguracionPaisDatos>> GetConfiguracionPaisDatos(UsuarioModel usuarioModel)
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
                    var lst = await sv.GetConfiguracionPaisDatosAsync(entidad);
                    listaEntidad = lst.ToList();
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

        private async Task<string> ObtenerCodigoRevistaFisica(int paisId)
        {
            var codigoRevista = "";
            BETablaLogicaDatos tablaLogicaDatos;
            using (var svc = new SACServiceClient())
            {
                var lst = await svc.GetTablaLogicaDatosAsync(paisId, Constantes.TablaLogica.CodigoRevistaFisica);

                tablaLogicaDatos = lst.FirstOrDefault();
            }

            if (tablaLogicaDatos != null)
            {
                codigoRevista = Util.Trim(tablaLogicaDatos.Codigo);
            }

            return codigoRevista;
        }

        private async Task<EventoFestivoDataModel> ConfigurarEventoFestivo(UsuarioModel usuarioModel)
        {
            var eventoFestivoDataModel = new EventoFestivoDataModel();
            try
            {
                eventoFestivoDataModel.ListaEventoFestivo = await ObtenerEventoFestivo(usuarioModel.PaisID, Constantes.EventoFestivoAlcance.SOMOS_BELCORP, usuarioModel.CampaniaID);
                if (eventoFestivoDataModel.ListaEventoFestivo.Any())
                {
                    foreach (var item in eventoFestivoDataModel.ListaEventoFestivo)
                    {
                        switch (item.Nombre)
                        {
                            case Constantes.EventoFestivoNombre.SALUDO:
                                eventoFestivoDataModel.EfSaludo = item.Personalizacion;
                                break;
                            case Constantes.EventoFestivoNombre.FONDO_INGPED:
                                eventoFestivoDataModel.EfRutaPedido = item.Personalizacion;
                                break;
                        }
                    }
                }
                eventoFestivoDataModel.ListaGifMenuContenedorOfertas = await ObtenerEventoFestivo(usuarioModel.PaisID, Constantes.EventoFestivoAlcance.MENU_SOMOS_BELCORP, usuarioModel.CampaniaID);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora, usuarioModel.PaisID.ToString(), string.Empty);
                pasoLog = "Ocurrió un error al cargar Eventofestivo";
                sessionManager.SetEventoFestivoDataModel(new EventoFestivoDataModel());
            }
            return eventoFestivoDataModel;
        }

        private async Task<List<EventoFestivoModel>> ObtenerEventoFestivo(int paisID, string Alcance, int Campania)
        {
            var lst = new List<BEEventoFestivo>();
            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    var result = await sv.GetEventoFestivoAsync(paisID, Alcance, Campania);
                    lst = result.ToList();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, Campania.ToString() + " - " + Alcance, paisID.ToString(), string.Empty);
            }
            return Mapper.Map<IList<BEEventoFestivo>, List<EventoFestivoModel>>(lst);
        }

        private async Task<List<BEIncentivoConcurso>> ConfigurarIncentivosConcursos(UsuarioModel usuarioModel)
        {
            var lst = new List<BEIncentivoConcurso>();
            try
            {
                var usuario = Mapper.Map<ServicePedido.BEUsuario>(usuarioModel);
                using (var sv = new PedidoServiceClient())
                {
                    var result = await sv.ObtenerConcursosXConsultoraAsync(usuario);
                    lst = result.ToList();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO, string.Empty);
            }
            return lst;
        }

        private async Task<List<BETablaLogicaDatos>> CargarFiltersFAV(UsuarioModel usuarioModel)
        {
            var lstFiltersFAV = new List<BETablaLogicaDatos>();
            using (var svc = new SACServiceClient())
            {
                for (var i = 94; i <= 97; i++)
                {
                    var lstItems = await svc.GetTablaLogicaDatosAsync(usuarioModel.PaisID, (short)i);
                    if (!lstItems.Any()) continue;
                    lstFiltersFAV.AddRange(lstItems);
                }
            }
            return lstFiltersFAV;
        }

        /// <summary>
        /// Actualiza la informacion de usuario segun la informacion de ConfiguracionPais
        /// </summary>
        /// <param name="usuarioModel">informacion de usuario</param>
        /// <returns>informacion de usuario actualizada</returns>
        public async Task<UsuarioModel> ConfiguracionPaisUsuario(UsuarioModel usuarioModel)
        {
            try
            {
                if (usuarioModel == null)
                    throw new ArgumentNullException("usuarioModel", "No puede ser nulo");


                if (usuarioModel.TipoUsuario == Constantes.TipoUsuario.Postulante)
                    throw new ArgumentException("No se asigna configuracion pais para los Postulantes.");

                var guiaNegocio = new GuiaNegocioModel();
                var revistaDigitalModel = new RevistaDigitalModel();
                var ofertaFinalModel = new OfertaFinalModel();
                var herramientasVentaModel = new HerramientasVentaModel();
                var configuracionesPaisModels = await GetConfiguracionPais(usuarioModel);
                var listaConfiPaisModel = new List<ConfiguracionPaisModel>();
                var buscadorYFiltrosModel = new BuscadorYFiltrosModel();

                if (configuracionesPaisModels.Any())
                {
                    var configuracionPaisDatosAll = await GetConfiguracionPaisDatos(usuarioModel);

                    foreach (var c in configuracionesPaisModels)
                    {
                        var configuracionPaisDatos = configuracionPaisDatosAll.Where(d => d.ConfiguracionPaisID == c.ConfiguracionPaisID).ToList();
                        switch (c.Codigo)
                        {
                            case Constantes.ConfiguracionPais.RevistaDigital:
                                revistaDigitalModel = ConfiguracionPaisDatosRevistaDigital(revistaDigitalModel, configuracionPaisDatos, usuarioModel.CodigoISO);
                                revistaDigitalModel = ConfiguracionPaisRevistaDigital(revistaDigitalModel, usuarioModel);
                                revistaDigitalModel = FormatTextConfiguracionPaisDatosModel(revistaDigitalModel, usuarioModel.Sobrenombre);
                                revistaDigitalModel.BloqueoRevistaImpresa = revistaDigitalModel.BloqueoRevistaImpresa || c.BloqueoRevistaImpresa;
                                break;
                            case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                                revistaDigitalModel.TieneRDCR = true;
                                revistaDigitalModel.BloqueoRevistaImpresa = revistaDigitalModel.BloqueoRevistaImpresa || c.BloqueoRevistaImpresa;
                                continue;
                            case Constantes.ConfiguracionPais.RevistaDigitalIntriga:
                                if (revistaDigitalModel.TieneRDC)
                                {
                                    logManager.LogErrorWebServicesBusWrap(
                                        new Exception("No puede estar activo configuracion pais RD y RDI a la vez."),
                                        usuarioModel.CodigoConsultora,
                                        usuarioModel.CodigoISO,
                                        "LoginController.ConfiguracionPaisUsuario");
                                    break;
                                }
                                revistaDigitalModel = ConfiguracionPaisDatosRevistaDigitalIntriga(revistaDigitalModel, configuracionPaisDatos, usuarioModel.CodigoISO);
                                revistaDigitalModel = FormatTextConfiguracionPaisDatosModel(revistaDigitalModel, usuarioModel.Sobrenombre);
                                revistaDigitalModel.TieneRDI = true;
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
                                guiaNegocio = ConfiguracionPaisDatosGuiaNegocio(configuracionPaisDatos);
                                guiaNegocio.TieneGND = true;
                                usuarioModel.TieneGND = true;
                                break;
                            case Constantes.ConfiguracionPais.OfertasParaTi:
                                usuarioModel = ConfiguracionPaisDatosUsuario(usuarioModel, configuracionPaisDatos);
                                break;
                            case Constantes.ConfiguracionPais.OfertaFinalCrossSellingGanaMas:
                                if (c.Estado)
                                    usuarioModel.OfertaFinalGanaMas = 1;
                                break;
                            case Constantes.ConfiguracionPais.PagoEnLinea:
                                if (c.Estado)
                                    usuarioModel.TienePagoEnLinea = true;
                                break;
                            case Constantes.ConfiguracionPais.HerramientasVenta:
                                herramientasVentaModel.TieneHV = true;
                                herramientasVentaModel = ConfiguracionPaisHerramientasVenta(herramientasVentaModel, configuracionPaisDatos);
                                break;
                            case Constantes.ConfiguracionPais.BuscadorYFiltros:
                                buscadorYFiltrosModel = ConfiguracionPaisBuscadorYFiltro(buscadorYFiltrosModel, configuracionPaisDatos);
                                break;
                        }

                        listaConfiPaisModel.Add(c);
                    }

                    revistaDigitalModel.Campania = usuarioModel.CampaniaID % 100;
                    revistaDigitalModel.CampaniaMasUno = Util.AddCampaniaAndNumero(Convert.ToInt32(usuarioModel.CampaniaID), 1, usuarioModel.NroCampanias) % 100;
                    revistaDigitalModel.NombreConsultora = usuarioModel.Sobrenombre;

                    guiaNegocio.BloqueoProductoDigital = guiaNegocio.BloqueoProductoDigital || (revistaDigitalModel.EsSuscritaActiva() && revistaDigitalModel.SociaEmpresariaExperienciaGanaMas);

                    sessionManager.SetGuiaNegocio(guiaNegocio);
                    sessionManager.SetRevistaDigital(revistaDigitalModel);
                    sessionManager.SetConfiguracionesPaisModel(listaConfiPaisModel);
                    sessionManager.SetOfertaFinalModel(ofertaFinalModel);
                    sessionManager.SetHerramientasVenta(herramientasVentaModel);
                    sessionManager.SetBuscadorYFiltros(buscadorYFiltrosModel);
                }

                usuarioModel.CodigosRevistaImpresa = await ObtenerCodigoRevistaFisica(usuarioModel.PaisID);
            }
            catch (Exception ex)
            {
                pasoLog = "Ocurrió un error al cargar ConfiguracionPais";
                var codigoConsultora = string.Empty;
                var pais = string.Empty;
                if (usuarioModel != null)
                {
                    codigoConsultora = usuarioModel.CodigoConsultora;
                    pais = usuarioModel.PaisID.ToString();
                }
                logManager.LogErrorWebServicesBusWrap(ex, codigoConsultora, pais, "LoginController.ConfiguracionPaisUsuario");
                sessionManager.SetGuiaNegocio(new GuiaNegocioModel());
                sessionManager.SetRevistaDigital(new RevistaDigitalModel());
                sessionManager.SetConfiguracionesPaisModel(new List<ConfiguracionPaisModel>());
                sessionManager.SetOfertaFinalModel(new OfertaFinalModel());
            }

            return usuarioModel;
        }

        protected virtual async Task<ServiceUsuario.BEUsuario> GetUsuarioAndLogsIngresoPortal(int paisId, string codigoUsuario, int refrescarDatos)
        {
            using (var usuarioServiceClient = new UsuarioServiceClient())
            {
                var usuario = await usuarioServiceClient.GetSesionUsuarioAsync(paisId, codigoUsuario);
                if (usuario != null && refrescarDatos == 0)
                {
                    try
                    {
                        await usuarioServiceClient.InsLogIngresoPortalAsync(paisId, usuario.CodigoConsultora, GetIpCliente(), 1, usuario.CampaniaID.ToString(), EsDispositivoMovil() ? Constantes.Canal.Mobile : Constantes.Canal.Desktop);
                    }
                    catch (Exception ex)
                    {
                        logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, paisId.ToString(), string.Empty);
                        pasoLog = "Ocurrió un error al registrar log de ingreso al portal";
                    }
                }
                return usuario;
            }
        }

        #endregion

        #region metodos normales

        #region ConfiguracioRevistaDigital

        public virtual RevistaDigitalModel ConfiguracionPaisDatosRevistaDigital(RevistaDigitalModel revistaDigitalModel,
            List<BEConfiguracionPaisDatos> configuracionesPaisDatos,
            string codigoIso)
        {
            try
            {
                if (revistaDigitalModel == null)
                    throw new ArgumentNullException("revistaDigitalModel", "no puede ser nulo");

                if (configuracionesPaisDatos == null || !configuracionesPaisDatos.Any() || string.IsNullOrEmpty(codigoIso))
                    return revistaDigitalModel;

                revistaDigitalModel.BloquearDiasAntesFacturar = GetValor1ToIntAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BloquearDiasAntesFacturar);
                revistaDigitalModel.CantidadCampaniaEfectiva = GetValor1ToIntAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.CantidadCampaniaEfectiva);
                revistaDigitalModel.NombreComercialActiva = GetValor1AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.NombreComercialActiva);
                revistaDigitalModel.NombreComercialNoActiva = GetValor1AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.NombreComercialNoActiva);

                revistaDigitalModel.DLogoComercialActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialActiva, codigoIso);
                revistaDigitalModel.MLogoComercialActiva = GetValor2WithS3AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialActiva, codigoIso);

                revistaDigitalModel.DLogoComercialNoActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialNoActiva, codigoIso);
                revistaDigitalModel.MLogoComercialNoActiva = GetValor2WithS3AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialNoActiva, codigoIso);

                revistaDigitalModel.DLogoMenuInicioActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoMenuInicioActiva, codigoIso);
                revistaDigitalModel.MLogoMenuInicioActiva = GetValor2WithS3AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoMenuInicioActiva, codigoIso);

                revistaDigitalModel.DLogoMenuInicioNoActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoMenuInicioNoActiva, codigoIso);
                revistaDigitalModel.MLogoMenuInicioNoActiva = GetValor2WithS3AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoMenuInicioNoActiva, codigoIso);

                revistaDigitalModel.DLogoComercialFondoActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoActiva, codigoIso);
                revistaDigitalModel.MLogoComercialFondoActiva = GetValor2WithS3AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoActiva, codigoIso);

                revistaDigitalModel.DLogoComercialFondoNoActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoNoActiva, codigoIso);
                revistaDigitalModel.MLogoComercialFondoNoActiva = GetValor2WithS3AndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoNoActiva, codigoIso);

                revistaDigitalModel.LogoMenuOfertasActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasActiva, codigoIso);
                revistaDigitalModel.LogoMenuOfertasNoActiva = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasNoActiva, codigoIso);
                revistaDigitalModel.BloquearRevistaImpresaGeneral = GetValor1ToIntAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BloquearPedidoRevistaImp);
                revistaDigitalModel.BloquearProductosSugeridos = GetValor1ToInt(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BloquearSugerenciaProducto);
                revistaDigitalModel.SubscripcionAutomaticaAVirtualCoach = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.SubscripcionAutomaticaAVirtualCoach);
                revistaDigitalModel.BloqueoProductoDigital = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                revistaDigitalModel.ActivoMdo = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.ActivoMdo);
                revistaDigitalModel.BannerOfertasNoActivaNoSuscrita = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BannerOfertasNoActivaNoSuscrita, codigoIso);
                revistaDigitalModel.BannerOfertasNoActivaSuscrita = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BannerOfertasNoActivaSuscrita, codigoIso);
                revistaDigitalModel.BannerOfertasActivaNoSuscrita = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BannerOfertasActivaNoSuscrita, codigoIso);
                revistaDigitalModel.BannerOfertasActivaSuscrita = GetValor1WithS3(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BannerOfertasActivaSuscrita, codigoIso);

                #region SociaEmpresaria
                revistaDigitalModel.SociaEmpresariaExperienciaGanaMas = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.SociaEEmpresariaExperienciaClub);
                revistaDigitalModel.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion);
                revistaDigitalModel.SociaEmpresariaSuscritaActivaCancelarSuscripcion = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.SociaEmpresariaSuscritaActivaCancelarSuscripcion);
                #endregion
                revistaDigitalModel.ConfiguracionPaisDatos = Mapper.Map<List<ConfiguracionPaisDatosModel>>(configuracionesPaisDatos) ?? new List<ConfiguracionPaisDatosModel>();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosRevistaDigital");
            }

            return revistaDigitalModel;
        }

        public virtual HerramientasVentaModel ConfiguracionPaisHerramientasVenta(HerramientasVentaModel herramientasVentaModel, List<BEConfiguracionPaisDatos> listaDatos)
        {
            herramientasVentaModel.ConfiguracionPaisDatos =
                    Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ??
                    new List<ConfiguracionPaisDatosModel>();

            return herramientasVentaModel;
        }

        public virtual BuscadorYFiltrosModel ConfiguracionPaisBuscadorYFiltro(BuscadorYFiltrosModel buscadorYFiltrosModel, List<BEConfiguracionPaisDatos> listaDatos)
        {
            buscadorYFiltrosModel.ConfiguracionPaisDatos = Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ?? new List<ConfiguracionPaisDatosModel>();
            return buscadorYFiltrosModel;
        }

        public virtual RevistaDigitalModel ConfiguracionPaisDatosRevistaDigitalIntriga(RevistaDigitalModel revistaDigital, List<BEConfiguracionPaisDatos> listaDatos, string paisIso)
        {
            try
            {
                if (revistaDigital == null)
                    throw new ArgumentNullException("revistaDigital", "no puede ser nulo");

                if (listaDatos == null)
                    throw new ArgumentNullException("listaDatos", "no puede ser nulo");

                if (paisIso == null)
                    throw new ArgumentNullException("paisIso", "no puede ser nulo");

                revistaDigital.ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();

                if (!listaDatos.Any())
                    return revistaDigital;

                var confPaisDatoTmp = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.LogoMenuOfertas);
                if (confPaisDatoTmp != null)
                    revistaDigital.LogoMenuOfertasNoActiva = ConfigCdn.GetUrlFileRDCdn(paisIso, confPaisDatoTmp.Valor1);

                confPaisDatoTmp =
                    listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.LogoComercial);
                if (confPaisDatoTmp != null)
                {
                    revistaDigital.DLogoComercialNoActiva = ConfigCdn.GetUrlFileRDCdn(paisIso, confPaisDatoTmp.Valor1);
                    revistaDigital.MLogoComercialNoActiva = ConfigCdn.GetUrlFileRDCdn(paisIso, confPaisDatoTmp.Valor2);
                }

                confPaisDatoTmp = listaDatos.FirstOrDefault(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.LogoComercialFondo);
                if (confPaisDatoTmp != null)
                {
                    revistaDigital.DLogoComercialFondoNoActiva = ConfigCdn.GetUrlFileRDCdn(paisIso, confPaisDatoTmp.Valor1);
                    revistaDigital.MLogoComercialFondoNoActiva = ConfigCdn.GetUrlFileRDCdn(paisIso, confPaisDatoTmp.Valor2);
                }

                confPaisDatoTmp =
                    listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.NombreComercial);
                if (confPaisDatoTmp != null)
                {
                    revistaDigital.NombreComercialNoActiva = confPaisDatoTmp.Valor1;
                }

                confPaisDatoTmp = listaDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital);
                if (confPaisDatoTmp != null) revistaDigital.BloqueoProductoDigital = confPaisDatoTmp.Valor1 == "1";

                listaDatos.RemoveAll(d =>
                    d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.LogoComercial
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.LogoComercialFondo
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.LogoMenuOfertas
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.RDI.NombreComercial
                    || d.Codigo == Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital

                );

                revistaDigital.ConfiguracionPaisDatos =
                    Mapper.Map<List<ConfiguracionPaisDatosModel>>(listaDatos) ??
                    new List<ConfiguracionPaisDatosModel>();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                    "LoginController.ConfiguracionPaisDatosRevistaDigitalIntriga");
            }

            return revistaDigital;
        }

        public virtual RevistaDigitalModel ConfiguracionPaisRevistaDigital(RevistaDigitalModel revistaDigitalModel, UsuarioModel usuarioModel)
        {
            revistaDigitalModel.TieneRDC = true;
            revistaDigitalModel.TieneRDS = true;
            ActualizarSubscripciones(revistaDigitalModel, usuarioModel);

            #region Campanias y Estados Es Activas - Es Suscrita

            revistaDigitalModel.EstadoSuscripcion = revistaDigitalModel.SuscripcionModel.EstadoRegistro;
            revistaDigitalModel.CampaniaActual = Util.SubStr(usuarioModel.CampaniaID.ToString(), 4, 2);

            int campaniaFuturoActiva =
                revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva == 0
                ? revistaDigitalModel.SuscripcionModel.CampaniaEfectiva == 0
                    ? Util.AddCampaniaAndNumero(usuarioModel.CampaniaID, revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias)
                    : revistaDigitalModel.SuscripcionModel.CampaniaEfectiva > usuarioModel.CampaniaID
                        ? revistaDigitalModel.SuscripcionModel.CampaniaEfectiva
                        : Util.AddCampaniaAndNumero(usuarioModel.CampaniaID, revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias)
                : revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva > usuarioModel.CampaniaID
                    ? revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva
                    : Util.AddCampaniaAndNumero(usuarioModel.CampaniaID, revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);

            revistaDigitalModel.CampaniaFuturoActiva = Util.SubStr(campaniaFuturoActiva.ToString(), 4, 2);

            revistaDigitalModel.CampaniaSuscripcion = Util.SubStr(revistaDigitalModel.SuscripcionModel.CampaniaID.ToString(), 4, 2);
            revistaDigitalModel.EsActiva = revistaDigitalModel.SuscripcionEfectiva.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
            
            revistaDigitalModel.EsSuscrita = revistaDigitalModel.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;

            #endregion

            revistaDigitalModel.BloqueoProductoDigital = revistaDigitalModel.BloqueoProductoDigital || !revistaDigitalModel.EsActiva;

            revistaDigitalModel.EstadoRdcAnalytics = GetEstadoRdAnalytics(revistaDigitalModel);

            #region DiasAntesFacturaHoy - NoVolverMostrar

            if (DateTime.Now.AddHours(usuarioModel.ZonaHoraria).Date >=
                usuarioModel.FechaInicioCampania.Date.AddDays(-1 * revistaDigitalModel.BloquearDiasAntesFacturar)
                && revistaDigitalModel.BloquearDiasAntesFacturar > 0)
                return revistaDigitalModel;

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
                    revistaDigitalModel.NoVolverMostrar = revistaDigitalModel.SuscripcionModel.CampaniaID == usuarioModel.CampaniaID;
                    break;
            }

            #endregion

            return revistaDigitalModel;
        }

        protected virtual void ActualizarSubscripciones(RevistaDigitalModel revistaDigitalModel, UsuarioModel usuarioModel)
        {
            var rds = new ServicePedido.BERevistaDigitalSuscripcion
            {
                PaisID = usuarioModel.PaisID,
                CodigoConsultora = usuarioModel.CodigoConsultora
            };

            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                revistaDigitalModel.SuscripcionModel =
                    Mapper.Map<RevistaDigitalSuscripcionModel>(pedidoServiceClient.RDGetSuscripcion(rds));

                rds.CampaniaID = usuarioModel.CampaniaID;
                revistaDigitalModel.SuscripcionEfectiva =
                    Mapper.Map<RevistaDigitalSuscripcionModel>(pedidoServiceClient.RDGetSuscripcionActiva(rds));
            }
        }

        private static string GetEstadoRdAnalytics(RevistaDigitalModel revistaDigital)
        {
            if (revistaDigital == null || !revistaDigital.TieneRDC) return "(not available)";
            if (revistaDigital.EsSuscrita)
                return revistaDigital.EsActiva ? "Inscrita Activa" : "Inscrita No Activa";

            return revistaDigital.EsActiva ? "No Inscrita Activa" : "No Inscrita No Activa";
        }

        #region
        private bool GetValor1ToBoolAndDelete(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo)
        {
            var result = false;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = dato.Valor1 == "1";
                configuracionesPaisDatos.RemoveAll(d => d.Codigo == codigo);
            }

            return result;
        }

        private int GetValor1ToInt(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo)
        {
            var result = 0;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = Convert.ToInt32(dato.Valor1);
            }

            return result;
        }
        private int GetValor1ToIntAndDelete(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo)
        {
            var result = 0;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = Convert.ToInt32(dato.Valor1);
                configuracionesPaisDatos.RemoveAll(d => d.Codigo == codigo);
            }

            return result;
        }

        private string GetValor1AndDelete(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo)
        {
            var result = (string)null;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = dato.Valor1;
                configuracionesPaisDatos.RemoveAll(d => d.Codigo == codigo);
            }

            return result;
        }

        private string GetValor1WithS3(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo, string codigoIso)
        {
            var result = (string)null;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = ConfigCdn.GetUrlFileRDCdn(codigoIso, dato.Valor1);
            }

            return result;
        }
        private string GetValor2WithS3AndDelete(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo, string codigoIso)
        {
            var result = (string)null;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = ConfigCdn.GetUrlFileRDCdn(codigoIso, dato.Valor2);
                configuracionesPaisDatos.RemoveAll(d => d.Codigo == codigo);
            }

            return result;
        }
        #endregion

        #endregion

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

                paises.RemoveAll(p => p.CodigoISO == Constantes.CodigosISOPais.Argentina || p.CodigoISO == Constantes.CodigosISOPais.Venezuela);
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
                if (iso == Constantes.CodigosISOPais.Mexico) ViewBag.AvisoASP = 2;
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
                    CodigoISO = Constantes.CodigosISOPais.Chile,
                    GndId = 958175395,
                    PixelId = "702802606578920",
                    SearchId = 989089161,
                    YoutubeId = 956468365
                },
                new LoginAnalyticsModel
                {
                    CodigoISO = Constantes.CodigosISOPais.Colombia,
                    GndId = 971131996,
                    PixelId = "145027672730911",
                    SearchId = 995835500,
                    YoutubeId = 957866857
                },
                new LoginAnalyticsModel
                {
                    CodigoISO = Constantes.CodigosISOPais.Peru,
                    GndId = 956111599,
                    PixelId = "1004828506227914",
                    SearchId = 986595497,
                    YoutubeId = 954887628
                }
            };
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

        public RevistaDigitalModel FormatTextConfiguracionPaisDatosModel(RevistaDigitalModel revistaDigital,
            string nombreConsultora)
        {
            if (revistaDigital == null)
                throw new ArgumentNullException("revistaDigital", "No puede ser nulo.");

            if (string.IsNullOrWhiteSpace(nombreConsultora))
                throw new ArgumentNullException("nombreConsultora", "No puede ser nulo o vacío.");

            if (revistaDigital.ConfiguracionPaisDatos == null) return revistaDigital;

            foreach (var configuracionPaisDato in revistaDigital.ConfiguracionPaisDatos)
            {
                configuracionPaisDato.Valor1 = RemplazaTagNombre(configuracionPaisDato.Valor1, nombreConsultora);
                configuracionPaisDato.Valor2 = RemplazaTagNombre(configuracionPaisDato.Valor2, nombreConsultora);
            }

            return revistaDigital;
        }

        private string RemplazaTagNombre(string cadena, string nombre)
        {
            cadena = Util.Trim(cadena);
            nombre = Util.Trim(nombre);
            return cadena.Replace(Constantes.TagCadenaRd.Nombre, nombre)
                .Replace(Constantes.TagCadenaRd.Nombre1, nombre)
                .Replace(Constantes.TagCadenaRd.Nombre2, nombre);
        }

        private bool HabilitarLogCargaOfertas(int paisId)
        {
            var result = false;
            try
            {
                BETablaLogicaDatos[] listDatos;
                using (var svc = new SACServiceClient())
                {
                    listDatos = svc.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.Palanca);

                }
                if (!listDatos.Any()) return false;
                var first = listDatos.FirstOrDefault();
                result = first != null && first.Codigo.Equals("1");
            }
            catch (Exception ex)
            {

                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                   "LoginController.HabilitarLogCargaOfertas");
            }
            return result;
        }

        private bool EsAndroid()
        {
            string uAg = Request.ServerVariables["HTTP_USER_AGENT"];
            var regEx = new Regex(@"android", RegexOptions.IgnoreCase);
            return regEx.IsMatch(uAg);
        }

        public virtual string GetLogonUserIdentityName()
        {
            var name = string.Empty;
            try
            {
                var logonUserIdentity = ((System.Web.HttpRequestWrapper)Request).LogonUserIdentity;
                if (logonUserIdentity != null)
                    name = logonUserIdentity.Name;
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty,
                   "LoginController.GetLogonUserIdentityName");
            }
            return name;
        }

        #endregion

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

        #region OLVIDE CONTRASEÑA
        [AllowAnonymous]
        [HttpPost]
        public JsonResult GetRestaurarClaveByValor(int paisID, string valorRestaurar, int prioridad)
        {
            try
            {
                BEUsuarioDatos oDatos = null;
                TempData["PaisID"] = paisID;
                using (var sv = new UsuarioServiceClient())
                {
                    oDatos = sv.GetRestaurarClaveByValor(paisID, valorRestaurar, prioridad);
                }
                if (oDatos != null)
                {
                    Session["DatosUsuario"] = oDatos;
                }

                var habilitarChatEmtelco = HabilitarChatEmtelco(paisID);
                return Json(new
                {
                    success = true,
                    data = oDatos,
                    habilitarChatEmtelco,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, valorRestaurar, Util.GetPaisISO(paisID));
                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud"
                });
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, valorRestaurar, Util.GetPaisISO(paisID), string.Empty);
                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud"
                });
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult ProcesaEnvioCorreo(int CantidadEnvios)
        {
            var oUsu = (BEUsuarioDatos)Session["DatosUsuario"];
            if (oUsu == null) return SuccessJson(Constantes.EnviarSMS.Mensaje.NoEnviaSMS, false);
            int paisID = Convert.ToInt32(TempData["PaisID"]);
            try
            {
                TempData["PaisID"] = paisID;
                bool EstadoEnvio = false;
                oUsu.EsMobile = EsDispositivoMovil();

                using (var svc = new UsuarioServiceClient())
                {
                    EstadoEnvio = svc.ProcesaEnvioEmail(paisID, oUsu, CantidadEnvios);
                }
                return Json(new
                {
                    success = EstadoEnvio,
                    menssage = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, oUsu.CodigoUsuario, Util.GetPaisISO(paisID));
                return Json(new
                {
                    success = false,
                    menssage = "Sucedio un Error al enviar el SMS. Intentelo mas tarde"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult ProcesaEnvioSms(int cantidadEnvios)
        {
            var oUsu = (BEUsuarioDatos)Session["DatosUsuario"];
            if (oUsu == null) return SuccessJson(Constantes.EnviarSMS.Mensaje.NoEnviaSMS, false);
            int paisID = Convert.ToInt32(TempData["PaisID"]);
            try
            {
                TempData["PaisID"] = paisID;
                oUsu.EsMobile = EsDispositivoMovil();

                using (var svc = new UsuarioServiceClient())
                {
                    BERespuestaSMS EstadoEnvio = svc.ProcesaEnvioSms(paisID, oUsu, cantidadEnvios);
                    return Json(new
                    {
                        success = EstadoEnvio.resultado,
                        menssage = EstadoEnvio.mensaje
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, oUsu.CodigoUsuario, Util.GetPaisISO(paisID));
                return Json(new
                {
                    success = false,
                    menssage = "Sucedio un Error al enviar el SMS. Intentelo mas tarde"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> VerificarCodigoGenerado(string Codigoingresado)
        {
            var oUsu = (BEUsuarioDatos)Session["DatosUsuario"];
            int paisID = Convert.ToInt32(TempData["PaisID"]);

            try
            {
                bool iguales = false;
                string newUri = "";
                TempData["PaisID"] = paisID;

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    iguales = sv.VerificarIgualdadCodigoIngresado(paisID, oUsu, Codigoingresado);
                }

                if (iguales)
                {
                    switch (oUsu.OrigenID)
                    {
                        case Constantes.OpcionesDeVerificacion.OrigenOlvideContrasenia:
                            {
                                string urlportal = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                                DateTime diasolicitud = DateTime.Now;
                                string fechasolicitud = diasolicitud.ToString("d/M/yyyy HH:mm:ss");
                                string CodigoIso = oUsu.CodigoIso;
                                string codigousuario = oUsu.CodigoUsuario;
                                string nombre = oUsu.PrimerNombre;
                                newUri = Convert.ToString(Portal.Consultoras.Common.Util.GetUrlRecuperarContrasenia(urlportal, paisID, oUsu.Correo, CodigoIso, codigousuario, fechasolicitud, nombre));
                            }
                            break;

                        case Constantes.OpcionesDeVerificacion.OrigenVericacionAutenticidad:
                            {
                                TempData["FlagPin"] = true;
                                break;
                            }
                    }
                }

                return Json(new
                {
                    success = iguales,
                    redirectTo = newUri,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, Codigoingresado, Util.GetPaisISO(paisID));
                return Json(new
                {
                    success = false,
                    message = "Error al verificar el codigo ingresado."
                });
            }
        }

        #endregion

        public bool TieneVerificacionAutenticidad(int paisID, string codigoUsuario)
        {
            try
            {
                BEUsuarioDatos oVerificacion;
                using (var sv = new UsuarioServiceClient())
                {
                    oVerificacion = sv.GetVerificacionAutenticidad(paisID, codigoUsuario);
                }

                if (oVerificacion == null) return false;

                Session["DatosUsuario"] = oVerificacion;
                TempData["PaisID"] = paisID;
                return true;
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, string.Empty, string.Empty, "LoginController.PinAutenticacion");
                return false;
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> ContinuarLogin()
        {
            var oUsu = (BEUsuarioDatos)Session["DatosUsuario"];
            int paisID = Convert.ToInt32(TempData["PaisID"]);
            return await Redireccionar(paisID, oUsu.CodigoUsuario);
        }

        public bool HabilitarChatEmtelco(int paisId)
        {
            bool Mostrar = false;
            BETablaLogicaDatos[] DataLogica;

            using (var svc = new SACServiceClient())
            {
                DataLogica = svc.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.HabilitarChatEmtelco);

            }
            if (DataLogica.Any())
            {
                if (EsDispositivoMovil())
                {
                    if (DataLogica.FirstOrDefault(x => x.Codigo.Equals("02")).Valor == "1")
                        Mostrar = true;
                }
                else
                {
                    if (DataLogica.FirstOrDefault(x => x.Codigo.Equals("01")).Valor == "1")
                        Mostrar = true;
                }
            }
            return Mostrar;
        }
    }
}