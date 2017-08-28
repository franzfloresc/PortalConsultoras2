﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Portal.Consultoras.PublicService.Cryptography;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginController : Controller
    {
        private string pasoLog;
        private readonly string IP_DEFECTO = "190.187.154.154";
        private readonly string ISO_DEFECTO = "PE";
        private readonly int USUARIO_VALIDO = 3;

        [AllowAnonymous]
        public ActionResult Index(string returnUrl = null)
        {
            if (EsUsuarioAutenticado() && EsDispositivoMovil())
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            if (EsUsuarioAutenticado() && !EsDispositivoMovil())
                return RedirectToAction("Index", "Bienvenida");


            var ip = string.Empty;
            var iso = string.Empty;
            var model = new LoginModel();

            try
            {
                model.ListaPaises = ObtenerPaises();

                if (EstaActivoBuscarIsoPorIp())
                {
                    ip = GetIpCliente();
                    if (!string.IsNullOrWhiteSpace(ip))
                        iso = Util.GetISObyIPAddress(ip);
                }

                if (string.IsNullOrEmpty(iso))
                {
                    ip = IP_DEFECTO;
                    iso = ISO_DEFECTO;
                }

                AsignarViewBagPorIso(iso);
                AsignarUrlRetorno(returnUrl);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, ip, iso);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, ip, iso, "Login.GET.Index");
            }

            ViewBag.FBAppId = ConfigurationManager.AppSettings.Get("FB_AppId");

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
            List<BEPais> lst;

            try
            {
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    lst = sv.SelectPaises().ToList();
                }

                lst.RemoveAll(p => p.CodigoISO == Constantes.CodigosISOPais.Argentina);

                Mapper.CreateMap<BEPais, PaisModel>()
                        .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                        .ForMember(t => t.CodigoISO, f => f.MapFrom(c => c.CodigoISO))
                        .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                        .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));
            }
            catch (Exception ex)
            {
                lst = new List<BEPais>();
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        protected virtual bool EstaActivoBuscarIsoPorIp()
        {
            var buscarIsoPorIp = ConfigurationManager.AppSettings.Get("BuscarISOPorIP") ?? string.Empty;
            return buscarIsoPorIp == "1";
        }

       	protected virtual string GetIpCliente()
        {
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

        private void AsignarViewBagPorIso(string iso)
        {
            if (string.IsNullOrWhiteSpace(iso)) return;

            ViewBag.IsoPais = iso;

            if (iso == "BR") iso = "00";
            ViewBag.TituloPagina = " ÉSIKA ";
            ViewBag.IconoPagina = "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico";
            ViewBag.EsPaisEsika = true;
            ViewBag.EsPaisLbel = false;
            ViewBag.AvisoASP = 1;

            if (GetPaisesEsikaFromConfig().Contains(iso))
            {
                ViewBag.BanderaOk = true;
            }
            else if (GetPaisesLbelFromConfig().Contains(iso))
            {
                ViewBag.TituloPagina = " L'BEL ";
                ViewBag.IconoPagina = "http://cdn.lbel.com/wp-content/themes/lbel2/images/icons/favicon.ico";
                ViewBag.EsPaisEsika = false;
                ViewBag.EsPaisLbel = true;
                if (iso == "MX") ViewBag.AvisoASP = 2;
                ViewBag.BanderaOk = true;
            }
            else
            {
                ViewBag.BanderaOk = false;
            }
        }

        protected string GetPaisesEsikaFromConfig()
        {
            return ConfigurationManager.AppSettings.Get("PaisesEsika") ?? string.Empty;
        }

        protected string GetPaisesLbelFromConfig()
        {
            return ConfigurationManager.AppSettings.Get("paisesLBel") ?? string.Empty;
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
                                    : Json(new { success = true, message = "El codigo de consultora se asoció con su cuenta de Facebook" });
                            }
                        }
                    }

                    return Redireccionar(model.PaisID, resultadoInicioSesion.CodigoUsuario, returnUrl);
                }

                var mensaje = resultadoInicioSesion != null ? resultadoInicioSesion.Mensaje : "Error al procesar la solicitud";

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
                LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoUsuario, model.CodigoISO, pasoLog);

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
                LogManager.LogManager.LogErrorWebServicesBus(new Exception(mensaje), codigoUsuario, paisISO, "Login.SaveLogErrorLogin");

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
            string resultado = Util.ValidarUsuarioADFS(model.CodigoUsuario, model.ClaveSecreta);

            string codigoResultado = resultado.Split('|')[0];
            string mensajeResultado = resultado.Split('|')[1];
            string paisIso = resultado.Split('|')[2];

            if (codigoResultado == "000")
            {
                int paisId = Util.GetPaisID(paisIso);
                return Redireccionar(paisId, model.CodigoUsuario);
            }

            TempData["errorLoginAdmin"] = mensajeResultado;
            return RedirectToAction("Admin", "Login");
        }

        public ActionResult Redireccionar(int paisId, string codigoUsuario, string returnUrl = null, bool hizoLoginExterno = false)
        {
            pasoLog = "Login.Redireccionar";
            var usuario = GetUserData(paisId, codigoUsuario);

            if (usuario == null && Request.IsAjaxRequest())
                return Json(new
                {
                    success = false,
                    redirectTo = "Error al procesar la solicitud"
                });

            if (usuario == null && !Request.IsAjaxRequest())
            {
                var url = GetUrlUsuarioDesconocido();
                return Redirect(url);
            }

            pasoLog = "Login.Redireccionar.SetAuthCookie";
            FormsAuthentication.SetAuthCookie(usuario.CodigoUsuario, false);

            if (hizoLoginExterno)
            {
                usuario.HizoLoginExterno = true;
                Session["UserData"] = usuario;
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
                            : Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                        return Json(new
                        {
                            success = true,
                            redirectTo = urlx
                        });
                    }
                    if (Url.IsLocalUrl(decodedUrl))
                    {
                        return Redirect(decodedUrl);
                    }
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }
                if (string.IsNullOrEmpty(usuario.EMail) || usuario.EMailActivo == false)
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

        private string GetUrlUsuarioDesconocido()
        {
            return Request.Url.Scheme + "://" + Request.Url.Authority +
                   (Request.ApplicationPath.Equals("/") ? "/" : (Request.ApplicationPath + "/")) +
                   "WebPages/UserUnknown.aspx";
        }

        [AllowAnonymous]
        public ActionResult LogOut()
        {
            return CerrarSesion();
        }

        private ActionResult CerrarSesion()
        {
            int tipoUsuario = 0;
            var userData = ((UsuarioModel)Session["UserData"]);

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
                            String uniqueId = LithiumSSOClient.SSOClient.ANONYMOUS_UNIQUE_ID;
                            LithiumSSOClient.SSOClient.writeLithiumCookie(uniqueId, usuario.CodigoUsuario, usuario.Correo, System.Web.HttpContext.Current.Request, System.Web.HttpContext.Current.Response);
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
                    }
                }
            }

            Session["UserData"] = null;
            Session.Clear();
            Session.Abandon();

            FormsAuthentication.SignOut();

            string urlSignOut = "/Login";

            if (tipoUsuario == Constantes.TipoUsuario.Admin)
                urlSignOut = "/Login/Admin";

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

        private UsuarioModel GetUserData(int PaisID, string CodigoUsuario, int refrescarDatos = 0)
        {
            pasoLog = "Login.GetUserData";
            Session["IsContrato"] = 1;
            Session["IsOfertaPack"] = 1;

            UsuarioModel model = null;
            ServiceUsuario.BEUsuario oBEUsuario = null;
            string valores = "";
            string[] arrValores;

            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    oBEUsuario = sv.GetSesionUsuario(PaisID, CodigoUsuario);

                    if (oBEUsuario != null && refrescarDatos == 0)
                    {
                        try
                        {
                            //El campo DetalleError, se reutiliza para enviar la campania de la consultora.
                            sv.InsLogIngresoPortal(PaisID, oBEUsuario.CodigoConsultora, GetIpCliente(), 1, oBEUsuario.CampaniaID.ToString());
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, oBEUsuario.CodigoConsultora, PaisID.ToString());
                            pasoLog = "Ocurrió un error al registrar log de ingreso al portal";
                        }
                    }
                }

                if (oBEUsuario != null)
                {
                    #region 
                    model = new UsuarioModel();
                    model.EstadoPedido = oBEUsuario.EstadoPedido;
                    model.NombrePais = oBEUsuario.NombrePais;
                    model.PaisID = oBEUsuario.PaisID;
                    model.CodigoISO = oBEUsuario.CodigoISO;
                    model.CodigoFuente = oBEUsuario.CodigoFuente;
                    model.RegionID = oBEUsuario.RegionID;
                    model.CodigorRegion = oBEUsuario.CodigorRegion;
                    model.ZonaID = oBEUsuario.ZonaID;
                    model.CodigoZona = oBEUsuario.CodigoZona;
                    model.ConsultoraID = oBEUsuario.ConsultoraID;
                    model.CodigoUsuario = oBEUsuario.CodigoUsuario;
                    model.CodigoConsultora = oBEUsuario.CodigoConsultora;
                    model.NombreConsultora = oBEUsuario.Nombre;
                    model.RolID = oBEUsuario.RolID;
                    model.CampaniaID = oBEUsuario.CampaniaID;
                    model.BanderaImagen = oBEUsuario.BanderaImagen;
                    model.CambioClave = Convert.ToInt32(oBEUsuario.CambioClave);
                    model.ConsultoraNueva = oBEUsuario.ConsultoraNueva;
                    model.Telefono = oBEUsuario.Telefono;
                    model.TelefonoTrabajo = oBEUsuario.TelefonoTrabajo;
                    model.Celular = oBEUsuario.Celular;
                    model.IndicadorDupla = oBEUsuario.IndicadorDupla;
                    model.UsuarioPrueba = oBEUsuario.UsuarioPrueba;
                    model.PasePedidoWeb = oBEUsuario.PasePedidoWeb;
                    model.TipoOferta2 = oBEUsuario.TipoOferta2;
                    model.CompraKitDupla = oBEUsuario.CompraKitDupla;
                    model.CompraOfertaDupla = oBEUsuario.CompraOfertaDupla;
                    model.CompraOfertaEspecial = oBEUsuario.CompraOfertaEspecial;
                    model.IndicadorMeta = oBEUsuario.IndicadorMeta;
                    model.ProgramaReconocimiento = oBEUsuario.ProgramaReconocimiento;
                    model.NivelEducacion = oBEUsuario.NivelEducacion;
                    model.SegmentoID = oBEUsuario.SegmentoID;
                    model.FechaNacimiento = oBEUsuario.FechaNacimiento;
                    model.Nivel = oBEUsuario.Nivel;
                    model.FechaInicioCampania = oBEUsuario.FechaInicioFacturacion;
                    model.VioVideoModelo = oBEUsuario.VioVideo;
                    model.VioTutorialModelo = oBEUsuario.VioTutorial;
                    model.VioTutorialDesktop = oBEUsuario.VioTutorialDesktop;
                    model.HabilitarRestriccionHoraria = oBEUsuario.HabilitarRestriccionHoraria;
                    model.IndicadorPermisoFIC = oBEUsuario.IndicadorPermisoFIC;
                    model.HorasDuracionRestriccion = oBEUsuario.HorasDuracionRestriccion;
                    model.EsJoven = oBEUsuario.EsJoven;
                    model.PROLSinStock = oBEUsuario.PROLSinStock;
                    model.HoraCierreZonaDemAntiCierre = oBEUsuario.HoraCierreZonaDemAntiCierre;
                    model.ConsultoraAsociadaID = oBEUsuario.ConsultoraAsociadaID;
                    model.ValidacionAbierta = oBEUsuario.ValidacionAbierta;
                    model.AceptacionConsultoraDA = oBEUsuario.AceptacionConsultoraDA;
                    if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion)
                        model.DiaPROLMensajeCierreCampania = false;
                    else
                        model.DiaPROLMensajeCierreCampania = true;

                    if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes))
                    {
                        model.DiaPROL = false;
                        model.FechaFacturacion = oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes);
                        model.HoraFacturacion = oBEUsuario.DiasAntes == 0 ? oBEUsuario.HoraInicio : oBEUsuario.HoraInicioNoFacturable;
                    }
                    else
                    {
                        model.DiaPROL = true;
                        model.FechaFacturacion = oBEUsuario.FechaFinFacturacion;
                        model.HoraFacturacion = oBEUsuario.HoraFin;
                    }

                    model.HoraInicioReserva = oBEUsuario.HoraInicio;
                    model.HoraFinReserva = oBEUsuario.HoraFin;
                    model.HoraInicioPreReserva = oBEUsuario.HoraInicioNoFacturable;
                    model.HoraFinPreReserva = oBEUsuario.HoraCierreNoFacturable;
                    model.DiasCampania = oBEUsuario.DiasAntes;
                    model.HoraFinFacturacion = oBEUsuario.HoraFin;
                    model.NombreCorto = oBEUsuario.CampaniaDescripcion;
                    model.CampanaInvitada = oBEUsuario.CampanaInvitada;
                    model.InscritaFlexipago = oBEUsuario.InscritaFlexipago;
                    model.InvitacionRechazada = oBEUsuario.InvitacionRechazada;

                    // OGA: agregado el campo para determinar el inicio del rango
                    model.DiasAntes = oBEUsuario.DiasAntes;
                    model.DiasDuracionCronograma = oBEUsuario.DiasDuracionCronograma;

                    // OGA: se calcula el fin de campañia sumando el nº de dias que dura el cronograma
                    switch (oBEUsuario.RolID)
                    {
                        case Portal.Consultoras.Common.Constantes.Rol.Administrador:
                            model.FechaFinCampania = oBEUsuario.FechaFinFacturacion;
                            break;
                        case Portal.Consultoras.Common.Constantes.Rol.Consultora:
                            model.FechaFinCampania = oBEUsuario.FechaFinFacturacion;
                            break;

                    }

                    model.ZonaValida = oBEUsuario.ZonaValida;
                    model.Simbolo = oBEUsuario.Simbolo;
                    model.CodigoTerritorio = oBEUsuario.CodigoTerritorio;
                    model.HoraCierreZonaDemAnti = oBEUsuario.HoraCierreZonaDemAnti;
                    model.HoraCierreZonaNormal = oBEUsuario.HoraCierreZonaNormal;
                    model.ZonaHoraria = oBEUsuario.ZonaHoraria;
                    model.TipoUsuario = oBEUsuario.TipoUsuario;
                    model.EsZonaDemAnti = oBEUsuario.EsZonaDemAnti;
                    model.Segmento = oBEUsuario.Segmento;
                    model.SegmentoAbreviatura = oBEUsuario.SegmentoAbreviatura;
                    model.Sobrenombre = oBEUsuario.Sobrenombre;
                    model.SobrenombreOriginal = oBEUsuario.Sobrenombre;
                    model.Direccion = oBEUsuario.Direccion;
                    model.IPUsuario = GetIpCliente();
                    model.AnoCampaniaIngreso = oBEUsuario.AnoCampaniaIngreso;
                    model.PrimerNombre = oBEUsuario.PrimerNombre;
                    model.PrimerApellido = oBEUsuario.PrimerApellido;

                    if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                    {
                        model.IndicadorPermisoFlexipago = GetPermisoFlexipago(model.PaisID, model.CodigoISO, model.CodigoConsultora, model.CampaniaID);
                    }
                    //EPD-2311 (Mostrar mensaje al ingresar al pase de pedido)
                    if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Postulante)
                    {
                        model.MensajePedidoDesktop = oBEUsuario.MensajePedidoDesktop;
                        model.MensajePedidoMobile = oBEUsuario.MensajePedidoMobile;
                    }
                    model.MostrarAyudaWebTraking = oBEUsuario.MostrarAyudaWebTraking;
                    model.NroCampanias = oBEUsuario.NroCampanias;
                    model.RolDescripcion = oBEUsuario.RolDescripcion;
                    model.IndicadorOfertaFIC = oBEUsuario.IndicadorOfertaFIC;
                    model.ImagenURLOfertaFIC = oBEUsuario.ImagenURLOfertaFIC;
                    model.Lider = oBEUsuario.Lider;
                    model.ConsultoraAsociada = oBEUsuario.ConsultoraAsociada;
                    model.CampaniaInicioLider = oBEUsuario.CampaniaInicioLider;
                    model.SeccionGestionLider = oBEUsuario.SeccionGestionLider;
                    model.NivelLider = oBEUsuario.NivelLider;
                    model.PortalLideres = oBEUsuario.PortalLideres;
                    model.LogoLideres = oBEUsuario.LogoLideres;
                    model.IndicadorContrato = oBEUsuario.IndicadorContrato;
                    model.FechaFinFIC = oBEUsuario.FechaFinFIC;
                    model.MenuNotificaciones = 1;

                    if (model.MenuNotificaciones == 1)
                    {
                        if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            model.TieneNotificaciones = TieneNotificaciones(oBEUsuario);
                        }
                    }

                    model.NuevoPROL = oBEUsuario.NuevoPROL;
                    model.ZonaNuevoPROL = oBEUsuario.ZonaNuevoPROL;

                    if (oBEUsuario.CampaniaID != 0)
                    {
                        if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            valores = GetFechaPromesaEntrega(oBEUsuario.PaisID, oBEUsuario.CampaniaID, oBEUsuario.CodigoConsultora, oBEUsuario.FechaInicioFacturacion);
                            arrValores = valores.Split('|');
                            model.TipoCasoPromesa = arrValores[2].ToString();
                            model.DiasCasoPromesa = Convert.ToInt16(arrValores[1].ToString());
                            model.FechaPromesaEntrega = Convert.ToDateTime(arrValores[0].ToString());
                        }
                    }

                    List<TipoLinkModel> lista = GetLinksPorPais(model.PaisID);
                    if (lista.Count > 0)
                    {
                        model.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                        model.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                        model.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                    }

                    if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                    {
                        model.EsUsuarioComunidad = EsUsuarioComunidad(oBEUsuario.PaisID, oBEUsuario.CodigoUsuario);
                    }

                    model.SegmentoConstancia = oBEUsuario.SegmentoConstancia;
                    model.SeccionAnalytics = oBEUsuario.SeccionAnalytics;
                    model.DescripcionNivel = oBEUsuario.DescripcionNivel;
                    model.esConsultoraLider = oBEUsuario.esConsultoraLider;
                    model.EMailActivo = oBEUsuario.EMailActivo;
                    model.EMail = oBEUsuario.EMail;
                    model.SegmentoInternoID = oBEUsuario.SegmentoInternoID;
                    model.EstadoSimplificacionCUV = oBEUsuario.EstadoSimplificacionCUV;
                    model.EsquemaDAConsultora = oBEUsuario.EsquemaDAConsultora;
                    model.ValidacionInteractiva = oBEUsuario.ValidacionInteractiva;
                    model.MensajeValidacionInteractiva = oBEUsuario.MensajeValidacionInteractiva;

                    // Pago Online CO - CL - PR
                    model.IndicadorPagoOnline = model.PaisID == 4 || model.PaisID == 3 || model.PaisID == 12 ? 1 : 0;
                    model.UrlPagoOnline = model.PaisID == 4 ? "https://www.zonapagos.com/pagosn2/LoginCliente"
                        : model.PaisID == 3 ? "https://www.belcorpchile.cl/BotonesPagoRedireccion/PagoConsultora.aspx"
                        : model.PaisID == 12 ? "https://www.somosbelcorp.com/Paypal"
                        : "";

                    model.OfertaFinal = oBEUsuario.OfertaFinal;
                    model.EsOfertaFinalZonaValida = oBEUsuario.EsOfertaFinalZonaValida;

                    model.OfertaFinalGanaMas = oBEUsuario.OfertaFinalGanaMas;
                    model.EsOFGanaMasZonaValida = oBEUsuario.EsOFGanaMasZonaValida;

                    model.CatalogoPersonalizado = oBEUsuario.CatalogoPersonalizado;
                    model.EsCatalogoPersonalizadoZonaValida = oBEUsuario.EsCatalogoPersonalizadoZonaValida;
                    model.VioTutorialSalvavidas = oBEUsuario.VioTutorialSalvavidas;
                    model.TieneHana = oBEUsuario.TieneHana;
                    model.NombreGerenteZonal = oBEUsuario.NombreGerenteZona;
                    model.FechaActualPais = oBEUsuario.FechaActualPais;
                    model.IndicadorBloqueoCDR = oBEUsuario.IndicadorBloqueoCDR;
                    model.EsCDRWebZonaValida = oBEUsuario.EsCDRWebZonaValida;
                    model.TieneCDR = oBEUsuario.TieneCDR;
                    model.TieneCupon = oBEUsuario.TieneCupon;
                    model.TieneMasVendidos = oBEUsuario.TieneMasVendidos;
                    //model.TieneOfertaLog = oBEUsuario.TieneOfertaLog;

                    model.TieneCDRExpress = oBEUsuario.TieneCDRExpress; //EPD-1919 
                    model.EsConsecutivoNueva = oBEUsuario.EsConsecutivoNueva; //EPD-1919

                    #endregion

                    if (model.RolID == Constantes.Rol.Consultora)
                    {
                        #region Hana
                        if (model.TieneHana == 1)
                        {
                            if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                            {
                                ActualizarDatosHana(ref model);
                            }
                        }
                        else
                        {
                            model.MontoMinimo = oBEUsuario.MontoMinimoPedido;
                            model.MontoMaximo = oBEUsuario.MontoMaximoPedido;
                            model.FechaLimPago = oBEUsuario.FechaLimPago;

                            if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                            {
                                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                                {
                                    model.MontoDeuda = sv.GetMontoDeuda(model.PaisID, model.CampaniaID, model.ConsultoraID, model.CodigoUsuario, false);
                                }
                            }

                            model.IndicadorFlexiPago = oBEUsuario.IndicadorFlexiPago;
                            model.MontoMinimoFlexipago = "0.00";

                            if (model.IndicadorFlexiPago > 0)
                            {
                                if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                                {
                                    using (PedidoServiceClient svc = new PedidoServiceClient())
                                    {
                                        BEOfertaFlexipago beOfertaFlexipago = svc.GetLineaCreditoFlexipago(model.PaisID, model.CodigoConsultora, model.CampaniaID);
                                        model.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", (beOfertaFlexipago.MontoMinimoFlexipago < 0 ? 0M : beOfertaFlexipago.MontoMinimoFlexipago));
                                    }
                                }
                            }
                        }
                        #endregion

                        #region GPR
                        model.IndicadorGPRSB = oBEUsuario.IndicadorGPRSB;
                        if (oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            CalcularMotivoRechazo(model);
                            if (!string.IsNullOrEmpty(model.GPRBannerMensaje))
                            {
                                model.MostrarBannerRechazo = true;

                                if (model.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Rechazado && ((oBEUsuario.ValidacionAbierta == false && oBEUsuario.EstadoPedido == 201) || oBEUsuario.ValidacionAbierta == true && oBEUsuario.EstadoPedido == 202))
                                {
                                    model.MostrarBannerRechazo = true;
                                }
                                else if (model.RechazadoXdeuda == true)
                                {
                                    model.MostrarBannerRechazo = true;
                                }
                                else
                                {
                                    model.MostrarBannerRechazo = model.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Descargado ? true : false;
                                }
                            }
                        }
                        #endregion

                        #region ODD
                        if (oBEUsuario.OfertaDelDia && oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            model.OfertasDelDia = GetOfertaDelDiaModel(model);
                            model.TieneOfertaDelDia = model.OfertasDelDia.Any();
                        }
                        #endregion

                        #region RegaloPN
                        var regaloProgramaNuevasFlag = ConfigurationManager.AppSettings.Get("RegaloProgramaNuevasFlag");
                        if (regaloProgramaNuevasFlag == "1")
                        {
                            DateTime fechaHoy = DateTime.Now.AddHours(model.ZonaHoraria).Date;
                            var esDiasFacturacion = fechaHoy >= model.FechaInicioCampania.Date && fechaHoy <= model.FechaFinCampania.Date;

                            if (esDiasFacturacion)
                            {
                                model.ConsultoraRegaloProgramaNuevas = GetConsultoraRegaloProgramaNuevas(model);
                            }
                        }
                        #endregion

                        #region LoginFB
                        if (oBEUsuario.TieneLoginExterno)
                        {
                            model.TieneLoginExterno = true;
                            using (ServiceUsuario.UsuarioServiceClient svc = new UsuarioServiceClient())
                            {
                                List<BEUsuarioExterno> lstLoginExterno = svc.GetListaLoginExterno(oBEUsuario.PaisID, oBEUsuario.CodigoUsuario).ToList();
                                if (lstLoginExterno.Any())
                                {
                                    model.ListaLoginExterno = Mapper.Map<List<BEUsuarioExterno>, List<UsuarioExternoModel>>(lstLoginExterno);
                                }
                            }
                        }
                        #endregion

                        #region ConfiguracionPais

                        try
                        {
                            model.RevistaDigital.NoVolverMostrar = true;
                            if (model.TipoUsuario == Constantes.TipoUsuario.Postulante) throw new Exception("No se asigna configuracion pais para los Postulantes.");

                            var config = new ServiceUsuario.BEConfiguracionPais
                            {
                                Detalle = new ServiceUsuario.BEConfiguracionPaisDetalle
                                {
                                    PaisID = model.PaisID,
                                    CodigoConsultora = model.CodigoConsultora,
                                    CodigoRegion = model.CodigorRegion,
                                    CodigoZona = model.CodigoZona,
                                    CodigoSeccion = model.SeccionAnalytics
                                }
                            };

                            using (UsuarioServiceClient sv = new UsuarioServiceClient())
                            {
                                //verificar si se tiene registrado RD o RDS en la tabla ConfiguracionPais
                                var listaConfigPais = sv.GetConfiguracionPais(config);
                                model.ConfiguracionPais = Mapper.Map<IList<ServiceUsuario.BEConfiguracionPais>, List<ConfiguracionPaisModel>>(listaConfigPais);
                            }

                            if (model.ConfiguracionPais.Any())
                            {
                                model.RevistaDigital.EstadoSuscripcion = 0;

                                foreach (var c in model.ConfiguracionPais)
                                {
                                    if (c.Codigo == Constantes.ConfiguracionPais.RevistaDigital)
                                    {
                                        model.RevistaDigital.TieneRDC = true;

                                        var rds = new BERevistaDigitalSuscripcion
                                        {
                                            PaisID = model.PaisID,
                                            CodigoConsultora = model.CodigoConsultora
                                        };
                                        using (PedidoServiceClient sv1 = new PedidoServiceClient())
                                        {
                                            model.RevistaDigital.SuscripcionModel = Mapper.Map<RevistaDigitalSuscripcionModel>(sv1.RDGetSuscripcion(rds));
                                            rds.CampaniaID = AddCampaniaAndNumero(Convert.ToInt32(model.CampaniaID), -1, model.NroCampanias);
                                            model.RevistaDigital.SuscripcionAnterior1Model = Mapper.Map<RevistaDigitalSuscripcionModel>(sv1.RDGetSuscripcion(rds));
                                            rds.CampaniaID = AddCampaniaAndNumero(Convert.ToInt32(model.CampaniaID), -2, model.NroCampanias);
                                            model.RevistaDigital.SuscripcionAnterior2Model = Mapper.Map<RevistaDigitalSuscripcionModel>(sv1.RDGetSuscripcion(rds));
                                        }

                                        continue;
                                    }

                                    // model.FechaFinCampania; fecha de fin de  la campaña
                                    // model.ConsultoraNueva; referencia de la columna idestadoactividad 
                                    // Validacion de la fecha de cierre de campaña y  del idestadoactividad
                                    // metodo GetDiasFaltantesFacturacion => model.FechaActualPais.Date >= model.FechaInicioCampania.Date
                                    //&& model.ConsultoraNueva == Constantes.EstadoActividadConsultora.Constante_Normal
                                    if (c.Codigo == Constantes.ConfiguracionPais.RevistaDigitalSuscripcion)
                                    {
                                        if (DateTime.Now.AddHours(model.ZonaHoraria).Date >= model.FechaInicioCampania.Date.AddDays(model.RevistaDigital.DiasAntesFacturaHoy))
                                            continue;

                                        model.RevistaDigital.TieneRDS = true;
                                        //obtiene datos de Revista digital suscripcion.
                                        var rds = new BERevistaDigitalSuscripcion
                                        {
                                            PaisID = model.PaisID,
                                            CodigoConsultora = model.CodigoConsultora
                                        };
                                        using (PedidoServiceClient sv1 = new PedidoServiceClient())
                                        {
                                            model.RevistaDigital.SuscripcionModel = Mapper.Map<RevistaDigitalSuscripcionModel>(sv1.RDGetSuscripcion(rds));
                                        }

                                        model.RevistaDigital.NoVolverMostrar = model.RevistaDigital.SuscripcionModel.RevistaDigitalSuscripcionID > 0;

                                        //se verifica que el usuario tiene una suscripcion activa
                                        if (model.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                                        {
                                            model.RevistaDigital.NoVolverMostrar = true;
                                        }
                                        else if (model.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Desactivo)
                                        {
                                            model.RevistaDigital.NoVolverMostrar = false;
                                        }
                                        else if (model.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.NoPopUp)
                                        {
                                            model.RevistaDigital.NoVolverMostrar = model.RevistaDigital.SuscripcionModel.CampaniaID == model.CampaniaID;
                                        }

                                        continue;
                                    }

                                    if (c.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida)
                                    {
                                        model.RevistaDigital.TieneRDR = true;
                                        continue;
                                    }

                                    if (c.Codigo == Constantes.ConfiguracionPais.OfertaFinalTradicional ||
                                        c.Codigo == Constantes.ConfiguracionPais.OfertaFinalCrossSelling ||
                                        c.Codigo == Constantes.ConfiguracionPais.OfertaFinalRegaloSorpresa)
                                    {
                                        model.OfertaFinalModel.Algoritmo = c.Codigo;
                                        model.OfertaFinalModel.Estado = c.Estado;
                                        if (c.Estado)
                                        {
                                            model.OfertaFinal = 1;
                                            model.EsOfertaFinalZonaValida = true;
                                        }
                                        continue;
                                    }

                                    if (c.Codigo.EndsWith("GM") && c.Codigo.StartsWith("OF"))
                                    {
                                        if (c.Estado)
                                            model.OfertaFinalGanaMas = 1;
                                        continue;
                                    }
                                }

                            }
                        }

                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoConsultora, model.PaisID.ToString());
                            pasoLog = "Ocurrió un error al cargar ConfiguracionPais";
                            model.ConfiguracionPais = new List<ConfiguracionPaisModel>();
                        }


                        #endregion

                        #region Concursos

                        List<BEConsultoraConcurso> Concursos = new List<BEConsultoraConcurso>();

                        try
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                Concursos = sv.ObtenerConcursosXConsultora(model.PaisID, model.CampaniaID.ToString(), model.CodigoConsultora, model.CodigorRegion, model.CodigoZona).ToList();
                            }
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoConsultora, model.CodigoISO);
                            Concursos = new List<BEConsultoraConcurso>();
                        }

                        if (Concursos.Any())
                        {
                            model.CodigosConcursos = string.Join("|", Concursos.Select(c => c.CodigoConcurso).ToArray());
                        }

                        #endregion
                    }

                    if (model.CatalogoPersonalizado != 0)
                    {
                        var lstFiltersFAV = new List<BETablaLogicaDatos>();
                        using (SACServiceClient svc = new SACServiceClient())
                        {
                            for (int i = 94; i <= 97; i++)
                            {
                                var lstItems = svc.GetTablaLogicaDatos(model.PaisID, (short)i);
                                if (lstItems.Any())
                                {
                                    foreach (var item in lstItems)
                                    {
                                        lstFiltersFAV.Add(item);
                                    }
                                }
                            }
                        }
                        if (lstFiltersFAV.Any())
                        {
                            Session["ListFiltersFAV"] = lstFiltersFAV;
                        }
                    }

                    //Para paises lebelizados.
                    if (ConfigurationManager.AppSettings.Get("paisesLBel").Contains(model.CodigoISO))
                    {
                        model.EsLebel = true;
                    }
                }

                Session["UserData"] = model;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, CodigoUsuario, PaisID.ToString());
                pasoLog = "Error: " + ex.Message;
                throw;
            }
            return model;
        }

        private void CalcularMotivoRechazo(UsuarioModel model)
        {
            model.GPRBannerUrl = Enumeradores.RechazoBannerUrl.Ninguna;

            if (model.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.SinAccion) return;
            if (model.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Descargado)
            {
                model.GPRBannerTitulo = "ESTAMOS FACTURANDO TU PEDIDO DE C" + model.CampaniaNro;
                model.GPRBannerMensaje = "Te notificaremos en caso tu pedido tenga observaciones.";
                return;
            }
            model.GPRBannerTitulo = "TU PEDIDO HA SIDO RECHAZADO";

            var procesoRechazado = new BEProcesoPedidoRechazado();
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    procesoRechazado = sv.ObtenerProcesoPedidoRechazadoGPR(model.PaisID, model.CampaniaID, model.ConsultoraID);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoUsuario, model.CodigoISO);
            }

            if (procesoRechazado.IdProcesoPedidoRechazado == 0) return;

            List<BEPedidoRechazado> listaRechazo = procesoRechazado.olstBEPedidoRechazado != null ? procesoRechazado.olstBEPedidoRechazado.ToList() : new List<BEPedidoRechazado>();
            if (listaRechazo.Count > 0) listaRechazo = listaRechazo.Where(r => r.Rechazado && !string.IsNullOrEmpty(r.MotivoRechazo)).ToList();
            if (listaRechazo.Count == 0) return;

            BEPedidoRechazado pedidoRechazado = listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.ActualizacionDeuda);
            if (pedidoRechazado != null && model.MontoDeuda > 0)
            {
                string montoDeuda = model.Simbolo + " " + Util.DecimalToStringFormat(pedidoRechazado.Valor, model.CodigoISO);
                model.GPRBannerMensaje = "Tienes una deuda de " + montoDeuda;
                model.GPRBannerUrl = Enumeradores.RechazoBannerUrl.Deuda;
                model.RechazadoXdeuda = true;
            }

            string mensajeParcial = null;
            if (listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.MontoMinino) != null)
            {
                mensajeParcial = "No llegaste al monto mínimo de " + model.Simbolo + " " + Util.DecimalToStringFormat(model.MontoMinimo, model.CodigoISO);
            }
            else if (listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.MontoMaximo) != null)
            {
                mensajeParcial = "Superaste tu línea de crédito de " + model.Simbolo + " " + Util.DecimalToStringFormat(model.MontoMaximo, model.CodigoISO);
            }
            else if (listaRechazo.FirstOrDefault(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock) != null)
            {
                mensajeParcial = "No llegaste al monto mínimo";
            }

            if (!string.IsNullOrEmpty(mensajeParcial))
            {
                model.GPRBannerUrl = Enumeradores.RechazoBannerUrl.ModificaPedido;
                if (string.IsNullOrEmpty(model.GPRBannerMensaje)) model.GPRBannerMensaje = mensajeParcial;
                else model.GPRBannerMensaje += " y " + mensajeParcial.ToLower(1);
            }
            if (!string.IsNullOrEmpty(model.GPRBannerMensaje)) model.GPRBannerMensaje += ".";
        }

        public List<TipoLinkModel> GetLinksPorPais(int PaisID)
        {
            List<BETipoLink> listModel = new List<BETipoLink>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                listModel = sv.GetLinksPorPais(PaisID).ToList();
            }

            Mapper.CreateMap<BETipoLink, TipoLinkModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.TipoLinkID, f => f.MapFrom(c => c.TipoLinkID))
                  .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            return Mapper.Map<IList<BETipoLink>, List<TipoLinkModel>>(listModel);
        }

        private bool GetPermisoFlexipago(int PaisID, string PaisISO, string CodigoConsultora, int CampaniaID)
        {
            bool Result = false;
            string hasFlexipago = ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;
            if (hasFlexipago.Contains(PaisISO))
            {
                using (ServicePedido.PedidoServiceClient sv = new ServicePedido.PedidoServiceClient())
                {
                    Result = sv.GetPermisoFlexipago(PaisID, CodigoConsultora, CampaniaID);
                }
            }

            return Result;
        }

        private int TieneNotificaciones(ServiceUsuario.BEUsuario oBEUsuario)
        {
            int Tiene = 0;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                Tiene = sv.GetNotificacionesSinLeer(oBEUsuario.PaisID, oBEUsuario.ConsultoraID, oBEUsuario.IndicadorBloqueoCDR);
            }
            return Tiene;
        }

        private string GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
        {
            string sFecha = Convert.ToDateTime("2000-01-01").ToString();
            //DateTime Fecha = Convert.ToDateTime("2000-01-01");
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    sFecha = sv.GetFechaPromesaCronogramaByCampania(PaisId, CampaniaId, CodigoConsultora, FechaFact);
                }
            }
            catch(Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, CodigoConsultora, PaisId.ToString());
            }
            return sFecha;
        }

        private bool EsUsuarioComunidad(int PaisId, string CodigoUsuario)
        {
            ServiceComunidad.BEUsuarioComunidad result = null;
            try
            {
                using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        PaisId = PaisId,
                        UsuarioId = 0,
                        CodigoUsuario = CodigoUsuario,
                        Tipo = 3
                    });
                }
            }
            catch(Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, CodigoUsuario, PaisId.ToString());
            }

            return result == null ? false : true;
        }

        private void ActualizarDatosHana(ref UsuarioModel model)
        {
            using (UsuarioServiceClient us = new UsuarioServiceClient())
            {
                var datosConsultoraHana = us.GetDatosConsultoraHana(model.PaisID, model.CodigoUsuario, model.CampaniaID);

                if (datosConsultoraHana != null)
                {
                    model.FechaLimPago = datosConsultoraHana.FechaLimPago;
                    model.MontoMinimo = datosConsultoraHana.MontoMinimoPedido;
                    model.MontoMaximo = datosConsultoraHana.MontoMaximoPedido;
                    model.MontoDeuda = datosConsultoraHana.MontoDeuda;
                    model.IndicadorFlexiPago = datosConsultoraHana.IndicadorFlexiPago;
                    model.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", (datosConsultoraHana.MontoMinimoFlexipago < 0 ? 0M : datosConsultoraHana.MontoMinimoFlexipago));
                }
            }
        }

        private TimeSpan CountdownODD(UsuarioModel model)
        {
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

        private List<OfertaDelDiaModel> GetOfertaDelDiaModel(UsuarioModel model)
        {
            var listaOdd = new List<OfertaDelDiaModel>();
            var lstOfertaDelDia = new List<BEEstrategia>();
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                lstOfertaDelDia = svc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.FechaInicioCampania.Date).ToList();
            }

            if (!lstOfertaDelDia.Any())
                return listaOdd;

            var configOfertaDelDia = new List<BETablaLogicaDatos>();
            using (SACServiceClient svc = new SACServiceClient())
            {
                configOfertaDelDia = svc.GetTablaLogicaDatos(model.PaisID, 93).ToList();
            }

            if (!configOfertaDelDia.Any())
                return listaOdd;

            var contOdd = 0;
            foreach (var odd in lstOfertaDelDia)
            {
                var arr1 = odd.DescripcionCUV2.Split('|');
                var nombreODD = arr1[0].Trim();
                var descripcionODD = string.Empty;

                for (int i = 1; i < arr1.Length; i++)
                {
                    if (!string.IsNullOrEmpty(arr1[i]))
                        descripcionODD += arr1[i].Trim() + "|";
                }
                
                descripcionODD = descripcionODD == "" ? "" : descripcionODD.Substring(0, descripcionODD.Length - 1);

                var countdown = CountdownODD(model);

                descripcionODD = descripcionODD.Replace("|", " +<br />");
                descripcionODD = descripcionODD.Replace("\\", "");
                descripcionODD = descripcionODD.Replace("(GRATIS)", "<b>GRATIS</b>");

                var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;

                odd.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, odd.ImagenURL, carpetaPais);

                var oddModel = new OfertaDelDiaModel();
                oddModel.CodigoIso = model.CodigoISO;
                oddModel.TipoEstrategiaID = odd.TipoEstrategiaID;
                oddModel.EstrategiaID = odd.EstrategiaID;
                oddModel.MarcaID = odd.MarcaID;
                oddModel.CUV2 = odd.CUV2;
                oddModel.LimiteVenta = odd.LimiteVenta;
                oddModel.IndicadorMontoMinimo = odd.IndicadorMontoMinimo;
                oddModel.TipoEstrategiaImagenMostrar = odd.TipoEstrategiaImagenMostrar;
                oddModel.TeQuedan = countdown;

                var imgBanner = odd.FotoProducto01;
                var imgDisplay = odd.FotoProducto01;

                var imgF1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"), model.CodigoISO);
                var imgF2 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"), model.CodigoISO);
                var imgSh = string.Format(ConfigurationManager.AppSettings.Get("UrlImgSoloHoyODD"), model.CodigoISO);
                var exte = imgSh.Split('.')[imgSh.Split('.').Length - 1];
                imgSh = imgSh.Substring(0, imgSh.Length - exte.Length - 1) + (lstOfertaDelDia.Count > 1 ? "s" : "") + "." + exte;
                var colorF1 = configOfertaDelDia.Where(x => x.TablaLogicaDatosID == 9301).First().Codigo ?? string.Empty;
                var colorF2 = configOfertaDelDia.Where(x => x.TablaLogicaDatosID == 9302).First().Codigo ?? string.Empty;

                oddModel.ImagenFondo1 = imgF1;
                oddModel.ColorFondo1 = colorF1;
                oddModel.ImagenBanner = imgBanner;
                oddModel.ImagenSoloHoy = imgSh;
                oddModel.ImagenFondo2 = imgF2;
                oddModel.ColorFondo2 = colorF2;
                oddModel.ImagenDisplay = imgDisplay;

                oddModel.ID = contOdd++;
                oddModel.NombreOferta = nombreODD;
                oddModel.DescripcionOferta = descripcionODD;
                oddModel.PrecioOferta = odd.Precio2;
                oddModel.PrecioCatalogo = odd.Precio;
                oddModel.TieneOfertaDelDia = true;
                oddModel.Orden = odd.Orden;

                /*PL20-1226*/
                listaOdd.Add(oddModel);
            }

            listaOdd = listaOdd.OrderBy(odd => odd.Orden).ToList();

            return listaOdd;
        }

        [AllowAnonymous]
        public ActionResult SesionExpirada()
        {
            return View();
        }

        [AllowAnonymous]
        public JsonResult CheckUserSession()
        {
            int res = 0;

            // If session exists
            if (HttpContext.Session != null)
            {
                //if cookie exists and sessionid index is greater than zero
                var sessionCookie = HttpContext.Request.Headers["Cookie"];
                if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
                {
                    // if exists UserData in Session
                    if (HttpContext.Session["UserData"] != null)
                    {
                        res = 1;
                    }
                }
            }

            return Json(new
            {
                Exists = res
            }, JsonRequestBehavior.AllowGet);
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
        public JsonResult RecuperarContrasenia(int paisId, string textoRecuperacion)
        {
            try
            {
                var respuesta = string.Empty;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    respuesta = sv.RecuperarContrasenia(paisId, textoRecuperacion);                    
                }
                respuesta = respuesta == null ? "" : respuesta.Trim();
                if (respuesta == "") return ErrorJson(Constantes.MensajesError.RecuperarContrasenia, true);
                
                string[] obj = respuesta.Split('|');
                string exito = Util.Trim(obj.Length > 0 ? obj[0] : "");
                string tipomsj = Util.Trim(obj.Length > 1 ? obj[1] : "");
                if (exito != "1") return ErrorJson(MensajesOlvideContrasena(tipomsj), true);

                string correo = Util.Trim(obj.Length > 2 ? obj[2] : "");
                string nombreusuario = Util.Trim(obj.Length > 3 ? obj[3] : "");
                string claveusuario = Util.Trim(obj.Length > 4 ? obj[4] : "");
                string codigo = Util.Trim(obj.Length > 5 ? obj[5] : "");
                string contextoBase = Util.Trim(obj.Length > 6 ? obj[6] : "");
                bool mostrarChat = false;
                string descripcionHorarioChat = "";
                bool habilitarChat = false;

                BEHorario horario;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    horario = sv.GetHorarioByCodigo(paisId, Constantes.CodigoHorario.ChatEmtelco, true);
                }
                if(horario != null)
                {
                    string paisISO = Util.GetPaisISO(paisId);
                    mostrarChat = (ConfigurationManager.AppSettings["PaisesBelcorpChatEMTELCO"] ?? "").Contains(paisISO);
                    descripcionHorarioChat = horario.Resumen;
                    habilitarChat = horario.EstaDisponible;
                }

                return Json(new
                {
                    success = true,
                    message = exito,
                    correo = correo,
                    nombre = nombreusuario,
                    clave = claveusuario,
                    pais = paisId,
                    codigo = codigo,
                    CONTEXTO_BASE = contextoBase,
                    mostrarChat = mostrarChat,
                    descripcionHorarioChat = descripcionHorarioChat,
                    habilitarChat = habilitarChat
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, textoRecuperacion, Util.GetPaisISO(paisId));
                return ErrorJson(Constantes.MensajesError.RecuperarContrasenia, true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, textoRecuperacion, Util.GetPaisISO(paisId));
                return ErrorJson(Constantes.MensajesError.RecuperarContrasenia, true);
            }
        }
    
        [AllowAnonymous]
        [HttpPost]
        public JsonResult EnviaClaveAEmail(int paisId, string filtro, int EsMobile)
        {
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    sv.EnviaClaveAEmail(paisId, filtro, Convert.ToBoolean(EsMobile));
                }
                return SuccessJson(MensajesOlvideContrasena("4"), true);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, filtro, Util.GetPaisISO(paisId));
                return ErrorJson(Constantes.MensajesError.RecuperarContrasenia, true);
            }
        }

        private string MensajesOlvideContrasena(string tipoMensaje)
        {
            tipoMensaje = Util.Trim(tipoMensaje);
            switch (tipoMensaje)
            {
                case "1": return "El Número de Cédula ingresado no existe.";
                case "2": return "No tienes un correo registrado para el envío de tu clave.<br />Por favor comunícate con el Servicio de Atención al Cliente.";
                case "3": return "Correo electrónico no identificado.";
                case "4": return "Te hemos enviado una nueva clave a tu correo.";
                case "5": return "Ocurrió un problema al recuperar tu contraseña.";
                case "6": return "Error al realizar proceso, inténtelo mas tarde.";
                default: return "";
            }
        }

        [HttpPost]
        public ActionResult checkExternalUser(string codigoISO, string proveedor, string appid)
        {
            pasoLog = "Login.POST.checkExternalUser";

            try
            {
                var f = false;

                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    var beUsuarioExt = svc.GetUsuarioExternoByProveedorAndIdApp(proveedor, appid);
                    if (beUsuarioExt != null)
                    {
                        f = true;
                    }
                }

                return Json(new
                {
                    success = true,
                    exists = f,
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, "", codigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", codigoISO, pasoLog);
            }

            return Json(new
            {
                success = false,
                message = "Error al procesar la solicitud"
            });
        }

        [HttpPost]
        public ActionResult validExternalUser(string codigoISO, string proveedor, string appid, string returnUrl)
        {
            pasoLog = "Login.POST.ValidExternalUser";

            try
            {
                BEUsuarioExterno beUsuarioExt = null;
                using (ServiceUsuario.UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    beUsuarioExt = svc.GetUsuarioExternoByProveedorAndIdApp(proveedor, appid);
                }

                if (beUsuarioExt != null)
                {
                    BEValidaLoginSB2 validaLogin = null;
                    using (UsuarioServiceClient svc = new UsuarioServiceClient())
                    {
                        validaLogin = svc.GetValidarAutoLogin(beUsuarioExt.PaisID, beUsuarioExt.CodigoUsuario, proveedor);
                    }

                    if (validaLogin != null && validaLogin.Result == 3)
                    {
                        return Redireccionar(beUsuarioExt.PaisID, beUsuarioExt.CodigoUsuario, returnUrl, true);
                    }
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", codigoISO, pasoLog);

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
        public ActionResult IngresoExterno(string token)
        {
            IngresoExternoModel model = null;
            try
            {
                string secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";
                model = JWT.JsonWebToken.DecodeToObject<IngresoExternoModel>(token, secretKey);
                if (model == null) return RedirectToAction("UserUnknown");

                var userData = (UsuarioModel)Session["UserData"];
                if (userData == null || userData.CodigoUsuario.CompareTo(model.CodigoUsuario) != 0)
                {
                    userData = GetUserData(Util.GetPaisID(model.Pais), model.CodigoUsuario);
                }
                if (userData == null) return RedirectToAction("UserUnknown");

                FormsAuthentication.SetAuthCookie(model.CodigoUsuario, false);

                Session["MobileAppConfiguracion"] = new MobileAppConfiguracionModel()
                {
                    MostrarBotonAtras = !model.EsAppMobile,
                    ClienteID = model.ClienteID,
                    MostrarHipervinculo = !model.EsAppMobile
                };

                Session.Add("IngresoExterno", model.Version ?? "");

                if (!string.IsNullOrEmpty(model.Identifier))
                {
                    Session.Add("TokenPedidoAutentico", AESAlgorithm.Encrypt(model.Identifier));
                }

                switch (model.Pagina.ToUpper())
                {
                    case Constantes.IngresoExternoPagina.EstadoCuenta:
                        return RedirectToAction("Index", "EstadoCuenta", new { Area = "Mobile" });
                    case Constantes.IngresoExternoPagina.SeguimientoPedido:
                        return RedirectToAction("Index", "SeguimientoPedido", new { Area = "Mobile", campania = model.Campania, numeroPedido = model.NumeroPedido });
                    case Constantes.IngresoExternoPagina.PedidoDetalle:
                        var listTrue = new List<string> { "1", bool.TrueString };
                        bool autoReservar = listTrue.Any(s => s.Equals(model.AutoReservar, StringComparison.OrdinalIgnoreCase));
                        return RedirectToAction("Detalle", "Pedido", new { Area = "Mobile", autoReservar = autoReservar });
                    case Constantes.IngresoExternoPagina.NotificacionesValidacionAuto:
                        return RedirectToAction("ListarObservaciones", "Notificaciones", new { Area = "Mobile", ProcesoId = model.ProcesoId, TipoOrigen = 1 });
                    case Constantes.IngresoExternoPagina.Pedido:
                        return RedirectToAction("Index", "Pedido", new { Area = "Mobile" });
                    case Constantes.IngresoExternoPagina.CompartirCatalogo:
                        return RedirectToAction("CompartirEnChatBot", "Compartir",
                            new
                            {
                                Area = "Mobile",
                                campania = model.Campania,
                                tipoCatalogo = model.TipoCatalogo,
                                url = model.UrlCatalogo
                            });
                    case Constantes.IngresoExternoPagina.MisPedidos:
                        return RedirectToAction("Index", "MisPedidos", new { Area = "Mobile" });
                    case Constantes.IngresoExternoPagina.ShowRoom:
                        return RedirectToAction("Procesar", "ShowRoom", new { Area = "Mobile" });
                }
            }
            catch (Exception ex)
            {
                if (model != null)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoUsuario, model.Pais, token);
                }
                else
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, token, "");
                }

                return HttpNotFound("Error: " + ex.Message);
            }

            return RedirectToAction("UserUnknown");
        }

        private ConsultoraRegaloProgramaNuevasModel GetConsultoraRegaloProgramaNuevas(UsuarioModel model)
        {
            ConsultoraRegaloProgramaNuevasModel result = null;
            pasoLog = "GetConsultoraRegaloProgramaNuevas";

            try
            {
                BEConsultoraRegaloProgramaNuevas entidad;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    entidad = svc.GetConsultoraRegaloProgramaNuevas(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.CodigorRegion, model.CodigoZona);
                }

                if (entidad != null)
                {
                    var listaProdCatalogo = new List<Producto>();
                    if (!string.IsNullOrEmpty(entidad.CodigoSap))
                    {
                        using (ProductoServiceClient svc = new ProductoServiceClient())
                        {
                            listaProdCatalogo = svc.ObtenerProductosPorCampaniasBySap(model.CodigoISO, model.CampaniaID, entidad.CodigoSap, 3).ToList();
                        }
                    }

                    if (listaProdCatalogo.Any())
                    {
                        var prodCatalogo = listaProdCatalogo.FirstOrDefault();
                        if (prodCatalogo != null)
                        {
                            var dd = (!string.IsNullOrEmpty(prodCatalogo.NombreComercial) ? prodCatalogo.NombreComercial : prodCatalogo.DescripcionComercial);
                            if (!string.IsNullOrEmpty(dd)) entidad.DescripcionPremio = dd;

                            if (prodCatalogo.PrecioCatalogo > 0) entidad.PrecioCatalogo = prodCatalogo.PrecioCatalogo;
                            if (prodCatalogo.PrecioValorizado > 0) entidad.PrecioValorizado = prodCatalogo.PrecioValorizado;
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoConsultora, model.CodigoISO, pasoLog);
            }

            return result;
        }
                                
        private JsonResult ErrorJson(string message, bool allowGet = false)
        {
            return Json(new { success = false, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }
        private JsonResult SuccessJson(string message, bool allowGet = false)
        {
            return Json(new { success = true, message = message }, allowGet ? JsonRequestBehavior.AllowGet : JsonRequestBehavior.DenyGet);
        }

        protected int AddCampaniaAndNumero(int campania, int numero, int nroCampanias)
        {
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
    }
}