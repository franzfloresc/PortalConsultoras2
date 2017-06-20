using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceLMS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginController : Controller
    {
        private string pasoLog;

        [AllowAnonymous]
        public ActionResult Index(string returnUrl = null)
        {
            if (HttpContext.User.Identity.IsAuthenticated)
            {
                bool esMovil = Request.Browser.IsMobileDevice;
                if (esMovil)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }
                else
                {
                    return RedirectToAction("Index", "Bienvenida");
                }
            }
            else
            {
                var IP = string.Empty;
                var ISO = string.Empty;
                var model = new LoginModel();

                try
                {
                    model.ListaPaises = DropDowListPaises();
                    var buscarISOPorIP = ConfigurationManager.AppSettings.Get("BuscarISOPorIP");

                    if (buscarISOPorIP == "1")
                    {
                        try
                        {
                            IP = GetIPCliente();
                            ISO = Util.GetISObyIPAddress(IP);
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, IP, ISO, "Login.GET.Index: GetIPCliente,GetISObyIPAddress");
                        }
                    }

                    if (string.IsNullOrEmpty(ISO))
                    {
                        IP = "190.187.154.154";
                        ISO = "PE";
                    }

                    AsignarHojaEstilos(ISO);

                    if (string.IsNullOrEmpty(returnUrl) && Request.UrlReferrer != null)
                        returnUrl = Server.UrlEncode(Request.UrlReferrer.PathAndQuery);

                    if (Url.IsLocalUrl(returnUrl) && !string.IsNullOrEmpty(returnUrl))
                    {
                        ViewBag.ReturnURL = returnUrl;
                    }
                }
                catch (FaultException ex)
                {
                    LogManager.LogManager.LogErrorWebServicesPortal(ex, IP, ISO);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, IP, ISO, "Login.GET.Index");
                }

                ViewBag.FBAppId = ConfigurationManager.AppSettings.Get("FB_AppId");

                return View(model);
            }
        }

        [AllowAnonymous]
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model, string returnUrl = null)
        {
            pasoLog = "Login.POST.Index";
            try
            {
                BEValidaLoginSB2 validaLogin = null;
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    validaLogin = svc.GetValidarLoginSB2(model.PaisID, model.CodigoUsuario, model.ClaveSecreta);
                }

                if (validaLogin != null && validaLogin.Result == 3)
                {
                    if (model.UsuarioExterno != null)
                    {
                        if (validaLogin.TipoUsuario == Constantes.TipoUsuario.Postulante)
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

                        var userExtModel = model.UsuarioExterno;
                        if (!string.IsNullOrEmpty(userExtModel.IdAplicacion))
                        {
                            using (ServiceUsuario.UsuarioServiceClient svc = new UsuarioServiceClient())
                            {
                                var userExt = svc.GetUsuarioExternoByCodigoUsuario(model.PaisID, model.CodigoUsuario);
                                if (userExt == null)
                                {
                                    BEUsuarioExternoPais beUserExtPais = new BEUsuarioExternoPais();
                                    beUserExtPais.Proveedor = userExtModel.Proveedor;
                                    beUserExtPais.IdAplicacion = userExtModel.IdAplicacion;
                                    beUserExtPais.PaisID = model.PaisID;
                                    beUserExtPais.CodigoISO = Util.GetPaisISO(model.PaisID);
                                    svc.InsUsuarioExternoPais(11, beUserExtPais);

                                    BEUsuarioExterno beUsuarioExterno = new BEUsuarioExterno();
                                    beUsuarioExterno.CodigoUsuario = validaLogin.CodigoUsuario;
                                    beUsuarioExterno.Proveedor = userExtModel.Proveedor;
                                    beUsuarioExterno.IdAplicacion = userExtModel.IdAplicacion;
                                    beUsuarioExterno.Login = userExtModel.Login;
                                    beUsuarioExterno.Nombres = userExtModel.Nombres;
                                    beUsuarioExterno.Apellidos = userExtModel.Apellidos;
                                    beUsuarioExterno.FechaNacimiento = userExtModel.FechaNacimiento;
                                    beUsuarioExterno.Correo = userExtModel.Correo;
                                    beUsuarioExterno.Genero = userExtModel.Genero;
                                    beUsuarioExterno.Ubicacion = userExtModel.Ubicacion;
                                    beUsuarioExterno.LinkPerfil = userExtModel.LinkPerfil;
                                    beUsuarioExterno.FotoPerfil = userExtModel.FotoPerfil;

                                    svc.InsertUsuarioExterno(model.PaisID, beUsuarioExterno);
                                    
                                    if(userExtModel.Redireccionar) return Redireccionar(model.PaisID, validaLogin.CodigoUsuario, returnUrl, true);
                                    return SuccessJson("El codigo de consultora se asoció con su cuenta de Facebook");
                                }
                                else
                                {
                                    if (Request.IsAjaxRequest())
                                    {
                                        return Json(new
                                        {
                                            success = false,
                                            message = "El codigo de consultora ya tiene una cuenta de Facebook asociada."
                                        });
                                    }
                                }
                            }
                        }
                        else
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
                    }

                    return Redireccionar(model.PaisID, validaLogin.CodigoUsuario, returnUrl);
                }
                else
                {
                    if (Request.IsAjaxRequest())
                    {
                        return Json(new
                        {
                            success = false,
                            message = validaLogin.Mensaje
                        });
                    }

                    TempData["errorLogin"] = validaLogin.Mensaje;

                    return RedirectToAction("Index", "Login");
                }
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
            //return RedirectToAction("Index");
        }

        public ActionResult Redireccionar(int paisId, string codigoUsuario, string returnUrl = null, bool hizoLoginExterno = false)
        {
            pasoLog = "Login.Redireccionar";
            UsuarioModel usuario = GetUserData(paisId, codigoUsuario, 1);

            if (usuario != null)
            {
                pasoLog = "Login.Redireccionar.SetAuthCookie";
                FormsAuthentication.SetAuthCookie(usuario.CodigoUsuario, false);

                if (hizoLoginExterno)
                {
                    usuario.HizoLoginExterno = true;
                    Session["UserData"] = usuario;
                }

                string decodedUrl = "";
                if (!string.IsNullOrEmpty(returnUrl))
                    decodedUrl = Server.UrlDecode(returnUrl);

                if (usuario.RolID == Constantes.Rol.Consultora)
                {
                    bool esMovil = Request.Browser.IsMobileDevice;

                    if (esMovil)
                    {
                        if (Request.IsAjaxRequest())
                        {
                            string urlx = (Url.IsLocalUrl(decodedUrl)) ? decodedUrl : Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                            return Json(new
                            {
                                success = true,
                                redirectTo = urlx
                            });
                        }
                        else
                        {
                            if (Url.IsLocalUrl(decodedUrl))
                            {
                                return Redirect(decodedUrl);
                            }
                            else
                            {
                                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                            }
                        }
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(usuario.EMail) || usuario.EMailActivo == false)
                        {
                            Session["PrimeraVezSession"] = 0;
                        }

                        if (Request.IsAjaxRequest())
                        {
                            string urlx = (Url.IsLocalUrl(decodedUrl)) ? decodedUrl : Url.Action("Index", "Bienvenida");
                            return Json(new
                            {
                                success = true,
                                redirectTo = urlx
                            });
                        }
                        else
                        {
                            if (Url.IsLocalUrl(decodedUrl))
                            {
                                return Redirect(decodedUrl);
                            }
                            else
                            {
                                return RedirectToAction("Index", "Bienvenida");
                            }
                        }
                    }
                }
                else
                {
                    if (Request.IsAjaxRequest())
                    {
                        return Json(new
                        {
                            success = true,
                            redirectTo = Url.Action("Index", "Bienvenida")
                        });
                    }
                    else
                    {
                        if (Url.IsLocalUrl(decodedUrl))
                        {
                            return Redirect(decodedUrl);
                        }
                        else
                        {
                            return RedirectToAction("Index", "Bienvenida");
                        }
                    }
                }
            }
            else
            {
                if (Request.IsAjaxRequest())
                {
                    return Json(new
                    {
                        success = false,
                        redirectTo = "Error al procesar la solicitud"
                    });
                }

                string Url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/UserUnknown.aspx";
                return Redirect(Url);
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
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

        [AllowAnonymous]
        public ActionResult LogOut()
        {
            return CerrarSesion();
        }

        private ActionResult CerrarSesion()
        {
            if (Session["UserData"] != null)
            {
                if (((UsuarioModel)Session["UserData"]).EsUsuarioComunidad)
                {
                    try
                    {
                        ServiceComunidad.BEUsuarioComunidad usuario = null;
                        using (ServiceComunidad.ComunidadServiceClient sv = new ServiceComunidad.ComunidadServiceClient())
                        {
                            usuario = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                            {
                                UsuarioId = 0,
                                CodigoUsuario = ((UsuarioModel)Session["UserData"]).CodigoUsuario,
                                Tipo = 3,
                                PaisId = ((UsuarioModel)Session["UserData"]).PaisID,
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

                    }
                }
            }

            int Tipo = 0;
            if (Session["UserData"] != null)
            {
                Tipo = ((UsuarioModel)Session["UserData"]).TipoUsuario;
            }

            Session["UserData"] = null;
            Session.Clear();
            Session.Abandon();

            FormsAuthentication.SignOut();

            string URLSignOut = "/Login";
            //EPD-2058
            if (Tipo == Constantes.TipoUsuario.Admin)
                URLSignOut = "/Login/Admin";

            return Redirect(URLSignOut);
        }

        [AllowAnonymous]
        public JsonResult ValidateResult()
        {
            var url = string.Empty;
            if (Session["UserData"] == null)
                url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "Login/Index";

            return Json(new
            {
                Url = url
            }, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public ActionResult LoginCargarConfiguracion(int paisID, string codigoUsuario)
        {
            GetUserData(paisID, codigoUsuario, 1, 1);
            if (Request.Browser.IsMobileDevice)
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            return RedirectToAction("Index", "Bienvenida");
        }

        private UsuarioModel GetUserData(int PaisID, string CodigoUsuario, int Tipo, int refrescarDatos = 0)
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
                            sv.InsLogIngresoPortal(PaisID, oBEUsuario.CodigoConsultora, GetIPCliente(), 1, oBEUsuario.CampaniaID.ToString());
                        }
                        catch
                        {
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
                    //model.TipoUsuario = Tipo;
                    model.TipoUsuario = oBEUsuario.TipoUsuario; //EPD-2058
                    model.EsZonaDemAnti = oBEUsuario.EsZonaDemAnti;
                    model.Segmento = oBEUsuario.Segmento;
                    model.SegmentoAbreviatura = oBEUsuario.SegmentoAbreviatura;
                    model.Sobrenombre = oBEUsuario.Sobrenombre;
                    model.SobrenombreOriginal = oBEUsuario.Sobrenombre;
                    model.Direccion = oBEUsuario.Direccion;
                    model.IPUsuario = GetIPCliente();
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

                    #endregion

                    if (model.RolID == Constantes.Rol.Consultora)
                    {
                        #region TieneHana
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
                        #region OfertaDelDia
                        {
                            CalcularMotivoRechazo(model);

                            if (!string.IsNullOrEmpty(model.GPRBannerMensaje))
                            {
                                model.MostrarBannerRechazo = true;
                                if (model.IndicadorGPRSB == (int)Enumeradores.IndicadorGPR.Rechazado && !oBEUsuario.ValidacionAbierta && oBEUsuario.EstadoPedido == 202) model.MostrarBannerRechazo = false;
                            }
                            //if (!string.IsNullOrEmpty(model.GPRBannerMensaje)) model.MostrarBannerRechazo =  oBEUsuario.EstadoPedido == 201 || oBEUsuario.ValidacionAbierta;   
                        }

                        #endregion

                        #region ODD
                        if (oBEUsuario.OfertaDelDia && oBEUsuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            model.OfertasDelDia = GetOfertaDelDiaModel(model);
                            model.TieneOfertaDelDia = model.OfertasDelDia.Any();
                            //model.OfertaDelDia = model.OfertasDelDia[0];
                        }
                        #endregion

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

                            var config = new BEConfiguracionPais
                            {
                                Detalle = new BEConfiguracionPaisDetalle {
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
                                model.ConfiguracionPais = Mapper.Map<IList<BEConfiguracionPais>, List<ConfiguracionPaisModel>>(listaConfigPais);
                            }

                            if (model.ConfiguracionPais.Any())
                            {
                                foreach (var c in model.ConfiguracionPais)
                                {
                                    model.RevistaDigital.EstadoSuscripcion = 0;

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
                                        if (model.FechaActualPais.Date < model.FechaInicioCampania.Date)
                                        {
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
                                        }

                                        continue;
                                    }

                                    if (c.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida)
                                    {
                                        model.RevistaDigital.TieneRDR = true;
                                        continue;
                                    }
                                }

                            }
                        }
                        
                        catch (Exception)
                        {
                            pasoLog = "Ocurrió un error al cargar ConfiguracionPais";
                            model.ConfiguracionPais = new List<ConfiguracionPaisModel>();
                        }


                        #endregion
                    }
                }

                //PL20-1234
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
                //Para paises lebelizados.
                if (ConfigurationManager.AppSettings.Get("paisesLBel").Contains(model.CodigoISO))
                {
                    model.EsLebel = true;
                }

                Session["UserData"] = model;
            }
            catch (Exception ex)
            {
                pasoLog = "Error: " + ex.Message;
                throw;
            }
            return model;
        }

        private string GetHostname()
        {
            string Hostname = string.Empty;
            try
            {
                if (System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_HOST"] != null)
                {
                    Hostname = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_HOST"];
                }
                else
                {
                    if (System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] != null)
                    {
                        Hostname = System.Net.Dns.GetHostEntry(System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]).HostName;
                        if (Hostname.Split('.').Count() > 1) Hostname = Hostname.Split('.')[0];
                    }
                    else if (System.Web.HttpContext.Current.Request.UserHostAddress.Length != 0)
                    {
                        Hostname = System.Web.HttpContext.Current.Request.UserHostName;
                    }
                }
                return Hostname;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message.ToString());
                return "Unknown host";

            }
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
            catch (Exception) { }
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

        private string GetIPCliente()
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

        private void AsignarHojaEstilos(string iso)
        {
            if (string.IsNullOrEmpty(iso)) return;

            ViewBag.IsoPais = iso;

            if (iso == "BR") iso = "00";

            if (ConfigurationManager.AppSettings.Get("paisesEsika").Contains(iso))
            {
                ViewBag.TituloPagina = " ÉSIKA ";
                ViewBag.IconoPagina = "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico";
                ViewBag.EsPaisEsika = true;
                ViewBag.EsPaisLbel = false;
                ViewBag.AvisoASP = 1;
                ViewBag.BanderaOk = true;
            }
            else
            {
                if (ConfigurationManager.AppSettings.Get("paisesLBel").Contains(iso))
                {
                    ViewBag.TituloPagina = " L'BEL ";
                    ViewBag.IconoPagina = "http://cdn.lbel.com/wp-content/themes/lbel2/images/icons/favicon.ico";
                    ViewBag.EsPaisEsika = false;
                    ViewBag.EsPaisLbel = true;
                    //ViewBag.AvisoASP = 1;
                    ViewBag.BanderaOk = true;

                    if (iso == "MX")
                        ViewBag.AvisoASP = 2;
                    else
                        ViewBag.AvisoASP = 1;
                }
                else
                {
                    ViewBag.TituloPagina = " ÉSIKA ";
                    ViewBag.IconoPagina = "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico";
                    ViewBag.EsPaisEsika = true;
                    ViewBag.EsPaisLbel = false;
                    ViewBag.AvisoASP = 1;
                    ViewBag.BanderaOk = false;
                }
            }
        }

        private int MenuNotificaciones(ServiceUsuario.BEUsuario oBEUsuario)
        {
            if (oBEUsuario.NuevoPROL && oBEUsuario.ZonaNuevoPROL) return 1;
            return 0;
        }

        private bool RegionPROL(string ISOPais, string CodRegion)
        {
            bool Result = false;
            string[] paises = ConfigurationManager.AppSettings["RegionesPROLv2"].Split(';');
            if (paises != null)
            {
                if (paises.Length != 0)
                {
                    foreach (string item in paises)
                    {
                        if (item.Contains(ISOPais))
                        {
                            if (item.Contains("ALL"))
                                Result = true;
                            else
                                Result = item.Contains(CodRegion);
                        }
                    }
                }
            }

            return Result;
        }

        private int TieneNotificaciones(ServiceUsuario.BEUsuario oBEUsuario)
        {
            int Tiene = 0;
            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstNotificaciones = sv.GetNotificacionesConsultora(oBEUsuario.PaisID, oBEUsuario.ConsultoraID, oBEUsuario.IndicadorBloqueoCDR).ToList();
            }
            if (olstNotificaciones.Count != 0)
            {
                int Cantidad = olstNotificaciones.Count(p => p.Visualizado == false);
                if (Cantidad > 0)
                    Tiene = 1;
            }
            return Tiene;
        }

        private string GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
        {
            String sFecha = Convert.ToDateTime("2000-01-01").ToString();
            DateTime Fecha = Convert.ToDateTime("2000-01-01");
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    sFecha = sv.GetFechaPromesaCronogramaByCampania(PaisId, CampaniaId, CodigoConsultora, FechaFact);
                }
            }
            catch
            {

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
            catch
            {

            }

            return result == null ? false : true;
        }

        private void CrearUsuarioMiAcademia(UsuarioModel model)
        {
            try
            {
                string key = ConfigurationManager.AppSettings["secret_key"];
                string isoUsuario = model.CodigoISO + '-' + model.CodigoConsultora;
                ws_server svcLMS = new ws_server();

                result getUser = svcLMS.ws_serverget_user(isoUsuario, model.CampaniaID.ToString(), key);
                if (getUser.codigo == "002")
                {
                    string nivelProyectado = "";
                    using (ContenidoServiceClient csv = new ContenidoServiceClient())
                    {
                        DataSet parametros = csv.ObtenerParametrosSuperateLider(model.PaisID, model.ConsultoraID, model.CampaniaID);
                        if (parametros != null && parametros.Tables.Count > 0) nivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                    }
                    string eMail = model.EMail.Trim() != string.Empty ? model.EMail : (model.CodigoConsultora + "@notengocorreo.com");

                    svcLMS.ws_servercreate_user(isoUsuario, model.NombreConsultora, eMail, model.CampaniaID.ToString(), model.CodigorRegion, model.CodigoZona, model.SegmentoConstancia, model.SeccionAnalytics, model.Lider.ToString(), model.NivelLider.ToString(), model.CampaniaInicioLider.ToString(), model.SeccionGestionLider, nivelProyectado, key);
                }
            }
            catch { }
        }

        private string CalcularNroCampaniaSiguiente(string CampaniaActual, int nroCampanias)
        {
            CampaniaActual = CampaniaActual ?? "";
            CampaniaActual = CampaniaActual.Trim();
            if (CampaniaActual.Length < 6)
                return "";

            var campAct = CampaniaActual.Substring(4, 2);
            if (campAct == nroCampanias.ToString()) return "01";
            return (Convert.ToInt32(campAct) + 1).ToString().PadLeft(2, '0');
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

                //descripcionODD = descripcionODD.Substring(0, descripcionODD.Length - 1);
                descripcionODD = descripcionODD == "" ? "" : descripcionODD.Substring(0, descripcionODD.Length - 1);

                var countdown = CountdownODD(model);

                descripcionODD = descripcionODD.Replace("|", " +<br />");
                descripcionODD = descripcionODD.Replace("\\", "");
                descripcionODD = descripcionODD.Replace("(GRATIS)", "<b>GRATIS</b>");

                var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;

                //odd.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, odd.FotoProducto01, carpetaPais); este campo ya se calcula en el servicio
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

                //if (contOdd == 0)
                //{
                var imgBanner = odd.FotoProducto01;
                var imgDisplay = odd.FotoProducto01;

                var imgF1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"), model.CodigoISO);
                var imgF2 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"), model.CodigoISO);
                var imgSh = string.Format(ConfigurationManager.AppSettings.Get("UrlImgSoloHoyODD"), model.CodigoISO);
                var exte = imgSh.Split('.')[imgSh.Split('.').Length - 1];
                imgSh = imgSh.Substring(0, imgSh.Length - exte.Length - 1) + (lstOfertaDelDia.Count > 1 ? "s" : "") + "." + exte;
                //var imgBanner = string.Format(ConfigurationManager.AppSettings.Get("UrlImgBannerODD"), model.CodigoISO, odd.ImagenURL);
                //var imgDisplay = string.Format(ConfigurationManager.AppSettings.Get("UrlImgDisplayODD"), model.CodigoISO, odd.ImagenURL);
                var colorF1 = configOfertaDelDia.Where(x => x.TablaLogicaDatosID == 9301).First().Codigo ?? string.Empty;
                var colorF2 = configOfertaDelDia.Where(x => x.TablaLogicaDatosID == 9302).First().Codigo ?? string.Empty;

                oddModel.ImagenFondo1 = imgF1;
                oddModel.ColorFondo1 = colorF1;
                oddModel.ImagenBanner = imgBanner;
                oddModel.ImagenSoloHoy = imgSh;
                oddModel.ImagenFondo2 = imgF2;
                oddModel.ColorFondo2 = colorF2;
                oddModel.ImagenDisplay = imgDisplay;
                //}
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
            //if (!HttpContext.User.Identity.IsAuthenticated && Session["UserData"] != null)
            //{
            //    return View();
            //}
            //else
            //{
            //    return RedirectToAction("Index");
            //}            
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
        public JsonResult RecuperarContrasenia(int paisId, string correo)
        {
            try
            {
                var respuesta = string.Empty;

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    respuesta = sv.RecuperarContrasenia(paisId, correo);
                }

                respuesta = respuesta == null ? "" : respuesta.Trim();
                if (respuesta == "")
                    return Json(new
                    {
                        success = false,
                        message = "Error en la respuesta del servicio de Recuperar Contraseña."
                    }, JsonRequestBehavior.AllowGet);

                string[] obj = respuesta.Split('|');
                string exito = obj.Length > 0 ? obj[0] : "";
                string tipomsj = obj.Length > 1 ? obj[1] : "";

                exito = exito == null ? "" : exito.Trim();
                tipomsj = tipomsj == null ? "" : tipomsj.Trim();

                if (exito == "1")
                {
                    //mostrar popup2
                    return Json(new
                    {
                        success = true,
                        message = exito,
                        correo = correo
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    string msj = MensajesOlvideContrasena(tipomsj);
                    return Json(new
                    {
                        success = false,
                        message = msj
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, string.Empty, Util.GetPaisISO(paisId));

                return Json(new
                {
                    success = false,
                    message = "Error en la respuesta del servicio de Recuperar Contraseña."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private string MensajesOlvideContrasena(string tipoMensaje)
        {
            string rpta = "";
            tipoMensaje = tipoMensaje ?? "";
            tipoMensaje = tipoMensaje.Trim();
            if (tipoMensaje == "1")
            {
                return ("El Número de Cédula ingresado no existe.");
            }
            if (tipoMensaje == "2")
            {
                return ("No tienes un correo registrado para el envío de tu clave.<br />Por favor comunícate con el Servicio de Atención al Cliente.");
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

        private string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        //MC-EPD1837
        private int GetPaisIdByISO(string codigoISO)
        {
            var lstPaises = DropDowListPaises();
            var r = 0;

            foreach (var item in lstPaises)
            {
                if (item.CodigoISO == codigoISO)
                {
                    r = item.PaisID;
                    break;
                }
            }

            return r;
        }

        [HttpPost]
        public ActionResult checkExternalUser(string codigoISO, string proveedor, string appid)
        {
            pasoLog = "Login.POST.checkExternalUser";

            try
            {
                var f = false;
                //if (!string.IsNullOrEmpty(codigoISO))
                //{
                //    var paisId = GetPaisIdByISO(codigoISO);
                //    if (paisId > 0)
                //    {
                using (ServiceUsuario.UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    var beUsuarioExt = svc.GetUsuarioExternoByProveedorAndIdApp(proveedor, appid);
                    if (beUsuarioExt != null)
                    {
                        f = true;
                    }
                }
                //}
                //}

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
                //if (!string.IsNullOrEmpty(codigoISO))
                //{
                //    var paisId = GetPaisIdByISO(codigoISO);
                //    if (paisId > 0)
                //    {
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
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = validaLogin.Mensaje
                        });
                    }
                }
                //}
                //}
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
            string secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";
            try
            {
                var model = JWT.JsonWebToken.DecodeToObject<IngresoExternoModel>(token, secretKey);
                if (model == null) return RedirectToAction("UserUnknown");

                var userData = (UsuarioModel)Session["UserData"];
                if (userData == null || userData.CodigoUsuario.CompareTo(model.CodigoUsuario) != 0)
                {
                    userData = GetUserData(Util.GetPaisID(model.Pais), model.CodigoUsuario, 1);
                }
                if (userData == null) return RedirectToAction("UserUnknown");

                FormsAuthentication.SetAuthCookie(model.CodigoUsuario, false);
                
                Session.Add("IngresoExterno", model.Version ?? "");

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
                    case Constantes.IngresoExternoPagina.CompartirCatalogo:
                        return RedirectToAction("CompartirEnChatBot", "Compartir",
                            new
                            {
                                Area = "Mobile",
                                campania = model.Campania,
                                tipoCatalogo = model.TipoCatalogo,
                                url = model.UrlCatalogo
                            });
                }
            }
            catch (Exception ex)
            {
                return HttpNotFound("Error: " + ex.Message);
            }

            return RedirectToAction("UserUnknown");
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
    }
}