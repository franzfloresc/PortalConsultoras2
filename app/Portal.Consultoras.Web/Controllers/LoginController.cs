using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Security.Claims;
using System.Configuration;
using System.IdentityModel.Services;
using System.Net;
using System.Web.Security;
using Portal.Consultoras.Web.ServiceContenido;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceSAC;
using System.Text.RegularExpressions;
using Portal.Consultoras.Web.ServiceLMS;
using System.Data;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginController : Controller
    {
        private string pasoLog;

        public ActionResult Index()
        {
            return Login();
            //return View(new LoginModel() { listaPaises = DropDowListPaises() });
        }

        private ActionResult Login()
        {
            string usuarioLog = "";
            string paisLog = "";
            try
            {
                ClaimsPrincipal claimsPrincipal = User as ClaimsPrincipal;
                Claim FederationClaimName = claimsPrincipal.FindFirst(ClaimTypes.Name);
                string claimUser = FederationClaimName.Value.ToUpper();
                string DomConsultora = ConfigurationManager.AppSettings.Get("DomConsultora");
                string DomBelcorp = ConfigurationManager.AppSettings.Get("DomBelcorp");

                string UserPortal = string.Empty;
                bool UsuarioSAC = false;
                int Tipo = 0;

                if (claimUser.Contains(DomConsultora))
                {
                    UserPortal = claimUser.Replace(DomConsultora + @"\", "");
                    Tipo = 1;
                }
                else if (claimUser.Contains(DomBelcorp))
                {
                    UserPortal = claimUser.Replace(DomBelcorp + @"\", "");
                    UsuarioSAC = true;
                    Tipo = 2;
                }

                usuarioLog = UserPortal;

                if (!string.IsNullOrEmpty(UserPortal))
                {
                    List<BEPais> lst = new List<BEPais>();

                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        lst = sv.SelectPaises().ToList();
                    }

                    string Pais = string.Empty;
                    string Codigo = string.Empty;

                    if (!UsuarioSAC)
                    {
                        Pais = UserPortal.Substring(0, 2);
                        Codigo = UserPortal.Substring(2, UserPortal.Length - 2);
                    }
                    else
                    {
                        Claim FederationClaimCountry = claimsPrincipal.FindFirst(ClaimTypes.Country);
                        Pais = FederationClaimCountry.Value.ToUpper();
                        Codigo = UserPortal;
                    }

                    paisLog = Pais;
                    usuarioLog = Codigo;

                    BEPais PaisModel = lst.First(p => p.CodigoISO == Pais);
                    if (PaisModel != null)
                    {
                        UsuarioModel usuario = GetUserData(PaisModel.PaisID, Codigo, Tipo);
                        if (usuario != null)
                        {
                            if (usuario.RolID == Portal.Consultoras.Common.Constantes.Rol.Consultora)
                            {
                                bool esMovil = Request.Browser.IsMobileDevice;

                                if (esMovil)
                                {
                                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                                }
                                else
                                {
                                    if (usuario.EMail == null || usuario.EMail == "" || usuario.EMailActivo == false)
                                    {
                                        Session["PrimeraVezSession"] = 0;
                                    }
                                    return RedirectToAction("Index", "Bienvenida");
                                }
                            }
                            else
                            {
                                return RedirectToAction("Index", "Bienvenida");
                            }
                        }
                        else
                        {
                            string Url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/UserUnknown.aspx";
                            return Redirect(Url);
                        }
                    }
                    else
                    {
                        string Url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/UserUnknown.aspx";
                        return Redirect(Url);
                    }
                }
                else
                {
                    string Url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/UserUnknown.aspx";
                    return Redirect(Url);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioLog, paisLog, pasoLog);
                string Url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/UserUnknown.aspx";
                return Redirect(Url);
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            IList<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises();
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ValidarAutenticacion(UsuarioModel model)
        {
            UsuarioModel userData = GetUserData(model.PaisID, model.CodigoConsultora, 1);
            if (userData != null)
            {
                return Json(new { result = true, mensaje = string.Empty }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { result = false, mensaje = "El usuario no pertenece al Portal de Consultoras, verifique." }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult LogOut()
        {
            return CerrarSesion();

            //Session["UserData"] = null;
            //Session.Clear();
            //Session.Abandon();
            //return RedirectToAction("Index", "Login");
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

            FederatedAuthentication.WSFederationAuthenticationModule.SignOut(false);
            FederatedAuthentication.SessionAuthenticationModule.SignOut();
            FederatedAuthentication.SessionAuthenticationModule.CookieHandler.Delete();
            FederatedAuthentication.SessionAuthenticationModule.DeleteSessionTokenCookie();

            FormsAuthentication.SignOut();

            string URLSignOut = string.Empty;
            switch (Tipo)
            {
                case 0:
                    URLSignOut = ConfigurationManager.AppSettings.Get("URLSignOut");
                    break;
                case 1:
                    URLSignOut = ConfigurationManager.AppSettings.Get("URLSignOut");
                    break;
                case 2:
                    URLSignOut = ConfigurationManager.AppSettings.Get("URLSignOutPartner");
                    break;
            }
            return Redirect(URLSignOut);
        }

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

        public ActionResult LoginCargarConfiguracion(int paisID, string codigoUsuario)
        {
            GetUserData(paisID, codigoUsuario, 1, 1);
            if (Request.Browser.IsMobileDevice)
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            return RedirectToAction("Index", "Bienvenida");
        }

        public UsuarioModel GetUserData(int PaisID, string CodigoUsuario, int Tipo, int refrescarDatos = 0)
        {
            Session["IsContrato"] = 1;
            Session["IsOfertaPack"] = 1;

            UsuarioModel model = null;
            BEUsuario oBEUsuario = null;
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
                    model = new UsuarioModel();

                    #region Obtener Respuesta del SSiCC
                    model.MotivoRechazo = "A partir de mañana podrás ingresar tu pedido de C" + CalcularNroCampaniaSiguiente(oBEUsuario.CampaniaID.ToString(), oBEUsuario.NroCampanias);
                    model.IndicadorGPRSB = oBEUsuario.IndicadorGPRSB;
                    bool MostrarBannerPedidoRechazado = false;

                    if (oBEUsuario.IndicadorGPRSB == 2)
                    {
                        MostrarBannerPedidoRechazado = true;
                        if (!oBEUsuario.ValidacionAbierta && oBEUsuario.EstadoPedido == 202) { MostrarBannerPedidoRechazado = false; }
                    }

                    if (MostrarBannerPedidoRechazado)
                    {
                        var procesoRechazado = new BEProcesoPedidoRechazado();
                        try
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                procesoRechazado = sv.ObtenerProcesoPedidoRechazadoGPR(oBEUsuario.PaisID, oBEUsuario.CampaniaID, oBEUsuario.ConsultoraID);
                            }
                        }
                        catch (Exception) { procesoRechazado = new BEProcesoPedidoRechazado(); }

                        if (procesoRechazado.IdProcesoPedidoRechazado > 0)
                        {
                            List<BEPedidoRechazado> listaRechazo = procesoRechazado.olstBEPedidoRechazado != null ? procesoRechazado.olstBEPedidoRechazado.ToList() : new List<BEPedidoRechazado>();
                            if (listaRechazo.Any())
                            {
                                listaRechazo = listaRechazo.Where(r => r.Rechazado).ToList();

                                if (listaRechazo.Any())
                                {
                                    model.MotivoRechazo = "";
                                    string valor = oBEUsuario.Simbolo + " ";
                                    string valorx = "";

                                    //listaRechazo.Update(p => p.MotivoRechazo = Util.SubStr(p.MotivoRechazo, 0).ToLower());
                                    listaRechazo = listaRechazo.Where(p => p.MotivoRechazo != "").ToList();

                                    var listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.ActualizacionDeuda).ToList(); //deuda
                                    if (listaMotivox.Any())
                                    {
                                        bool esMovil = Request.Browser.IsMobileDevice;

                                        valorx = valor + listaMotivox[0].Valor;
                                        model.MotivoRechazo = "Tienes una deuda de " + valorx + " que debes regularizar. <a class='CerrarBanner' href='javascript:;' onclick=RedirectMenu('Index','MisPagos',0,'');cerrarMensajeEstadoPedido() >MIRA LOS LUGARES DE PAGO</a>";

                                        if (esMovil)
                                            model.MotivoRechazo = "Tienes una deuda de " + valorx + " que debes regularizar.";
                                    }

                                    listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.MontoMinino).ToList(); // minimo
                                    if (listaMotivox.Any())
                                    {
                                        if (model.MotivoRechazo != "")
                                        {
                                            model.MotivoRechazo = "Tienes una deuda pendiente de " + valorx;
                                            valorx = valor + listaMotivox[0].Valor;
                                            model.MotivoRechazo += ". Además, para pasar pedido debes alcanzar el monto mínimo de " + oBEUsuario.Simbolo + ". " + oBEUsuario.MontoMinimoPedido + ". <a class='CerrarBanner' href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido');cerrarMensajeEstadoPedido() >MODIFICA TU PEDIDO</a>";
                                        }
                                        else
                                        {
                                            valorx = valor + listaMotivox[0].Valor;
                                            model.MotivoRechazo = "No llegaste al monto mínimo de " + oBEUsuario.Simbolo + ". " + oBEUsuario.MontoMinimoPedido + " <a class='CerrarBanner' href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido');cerrarMensajeEstadoPedido() >MODIFICA TU PEDIDO</a>";
                                        }
                                    }
                                    else
                                    {
                                        listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.MontoMaximo).ToList(); //maximo
                                        if (listaMotivox.Any())
                                        {
                                            if (model.MotivoRechazo != "")
                                            {
                                                model.MotivoRechazo = "Tienes una deuda pendiente de " + valorx;
                                                valorx = valor + listaMotivox[0].Valor;
                                                model.MotivoRechazo += ". Además, superaste tu línea de crédito de " + oBEUsuario.Simbolo + ". " + oBEUsuario.MontoMaximoPedido + ". <a class='CerrarBanner' href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido');cerrarMensajeEstadoPedido() >MODIFICA TU PEDIDO</a>";
                                            }
                                            else
                                            {
                                                valorx = valor + listaMotivox[0].Valor;
                                                model.MotivoRechazo = "Superaste tu línea de crédito de " + oBEUsuario.Simbolo + ". " + oBEUsuario.MontoMaximoPedido + ". <a class='CerrarBanner' href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido');cerrarMensajeEstadoPedido() >MODIFICA TU PEDIDO</a>";
                                            }
                                        }
                                    }

                                    listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock).ToList(); //minstock
                                    if (listaMotivox.Any())
                                    {
                                        valorx = valor + listaMotivox[0].Valor;
                                        model.MotivoRechazo = "No llegaste al mínimo de " + valorx + ". <a class='CerrarBanner' href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido');cerrarMensajeEstadoPedido() >MODIFICA TU PEDIDO</a>";
                                    }
                                }
                                // llamar al maestro de mensajes
                            }
                        }
                    }
                    #endregion
                    model.MotivoRechazo = model.MotivoRechazo.Trim();
                    model.IndicadorGPRSB = oBEUsuario.IndicadorGPRSB;
                    model.EstadoPedido = oBEUsuario.EstadoPedido;
                    model.MostrarBannerRechazo = MostrarBannerPedidoRechazado;
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
                    model.ListaProductoFaltante = GetModelPedidoAgotado(model.PaisID, model.CampaniaID, model.ZonaID);
                    model.HoraCierreZonaDemAnti = oBEUsuario.HoraCierreZonaDemAnti;
                    model.HoraCierreZonaNormal = oBEUsuario.HoraCierreZonaNormal;
                    model.ZonaHoraria = oBEUsuario.ZonaHoraria;
                    model.TipoUsuario = Tipo;
                    model.EsZonaDemAnti = oBEUsuario.EsZonaDemAnti;
                    model.Segmento = oBEUsuario.Segmento;
                    model.Sobrenombre = oBEUsuario.Sobrenombre;
                    model.SobrenombreOriginal = oBEUsuario.Sobrenombre;
                    model.Direccion = oBEUsuario.Direccion;
                    model.IPUsuario = GetIPCliente();
                    model.AnoCampaniaIngreso = oBEUsuario.AnoCampaniaIngreso;
                    model.PrimerNombre = oBEUsuario.PrimerNombre;
                    model.PrimerApellido = oBEUsuario.PrimerApellido;
                    model.IndicadorPermisoFlexipago = GetPermisoFlexipago(model.PaisID, model.CodigoISO, model.CodigoConsultora, model.CampaniaID);
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
                        model.TieneNotificaciones = TieneNotificaciones(oBEUsuario);
                    model.NuevoPROL = oBEUsuario.NuevoPROL;
                    model.ZonaNuevoPROL = oBEUsuario.ZonaNuevoPROL;

                    if (oBEUsuario.CampaniaID != 0)
                    {
                        valores = GetFechaPromesaEntrega(oBEUsuario.PaisID, oBEUsuario.CampaniaID, oBEUsuario.CodigoConsultora, oBEUsuario.FechaInicioFacturacion);
                        arrValores = valores.Split('|');
                        model.TipoCasoPromesa = arrValores[2].ToString();
                        model.DiasCasoPromesa = Convert.ToInt16(arrValores[1].ToString());
                        model.FechaPromesaEntrega = Convert.ToDateTime(arrValores[0].ToString());
                    }

                    List<TipoLinkModel> lista = GetLinksPorPais(model.PaisID);
                    if (lista.Count > 0)
                    {
                        model.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                        model.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                        model.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                    }

                    model.EsUsuarioComunidad = EsUsuarioComunidad(oBEUsuario.PaisID, oBEUsuario.CodigoUsuario);
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
                    model.NombreGerenteZonal = oBEUsuario.NombreGerenteZona;  // SB20-907
                    model.FechaActualPais = oBEUsuario.FechaActualPais;
                    model.IndicadorBloqueoCDR = oBEUsuario.IndicadorBloqueoCDR;
                    model.EsCDRWebZonaValida = oBEUsuario.EsCDRWebZonaValida;
                    model.TieneCDR = oBEUsuario.TieneCDR;

                    if (model.RolID == Constantes.Rol.Consultora)
                    {
                        if (model.TieneHana == 1)
                        {
                            ActualizarDatosHana(ref model);
                        }
                        else
                        {
                            model.MontoMinimo = oBEUsuario.MontoMinimoPedido;
                            model.MontoMaximo = oBEUsuario.MontoMaximoPedido;
                            model.FechaLimPago = oBEUsuario.FechaLimPago;

                            BEResumenCampania[] infoDeuda = null;
                            using (ContenidoServiceClient sv = new ContenidoServiceClient())
                            {
                                if (model.CodigoISO == Constantes.CodigosISOPais.Colombia || model.CodigoISO == Constantes.CodigosISOPais.Peru)
                                {
                                    infoDeuda = sv.GetDeudaTotal(model.PaisID, Convert.ToInt32(model.ConsultoraID));
                                }
                                else
                                {
                                    infoDeuda = sv.GetSaldoPendiente(model.PaisID, model.CampaniaID, Convert.ToInt32(model.ConsultoraID));
                                }
                            }

                            if (infoDeuda != null && infoDeuda.Length > 0)
                            {
                                model.MontoDeuda = infoDeuda[0].SaldoPendiente;
                            }

                            model.IndicadorFlexiPago = oBEUsuario.IndicadorFlexiPago;
                            model.MontoMinimoFlexipago = "0.00";

                            if (model.IndicadorFlexiPago > 0)
                            {
                                using (PedidoServiceClient svc = new PedidoServiceClient())
                                {
                                    BEOfertaFlexipago beOfertaFlexipago = svc.GetLineaCreditoFlexipago(model.PaisID, model.CodigoConsultora, model.CampaniaID);
                                    model.MontoMinimoFlexipago = string.Format("{0:#,##0.00}", (beOfertaFlexipago.MontoMinimoFlexipago < 0 ? 0M : beOfertaFlexipago.MontoMinimoFlexipago));
                                }
                            }
                        }

                        /*PL20-1226*/
                        //model.EsOfertaDelDia = oBEUsuario.EsOfertaDelDia;
                        //if (model.EsOfertaDelDia > 0)
                        //{

                        if (oBEUsuario.OfertaDelDia)
                        {
                            var lstOfertaDelDia = new List<BEEstrategia>();
                            using (PedidoServiceClient svc = new PedidoServiceClient())
                            {
                                lstOfertaDelDia = svc.GetEstrategiaODD(model.PaisID, model.CampaniaID, model.CodigoConsultora, model.FechaInicioCampania.Date).ToList();
                            }

                            if (lstOfertaDelDia.Any())
                            {
                                var configOfertaDelDia = new List<BETablaLogicaDatos>();
                                using (SACServiceClient svc = new SACServiceClient())
                                {
                                    configOfertaDelDia = svc.GetTablaLogicaDatos(model.PaisID, 93).ToList();
                                }

                                if (configOfertaDelDia.Any())
                                {
                                    var ofertaDelDia = lstOfertaDelDia[0];
                                    var arr1 = ofertaDelDia.DescripcionCUV2.Split('|');
                                    var nombreODD = arr1[0].Trim();
                                    var descripcionODD = string.Empty;

                                    for (int i = 1; i < arr1.Length; i++)
                                    {
                                        if (!string.IsNullOrEmpty(arr1[i]))
                                            descripcionODD += arr1[i].Trim() + "|";
                                    }

                                    descripcionODD = descripcionODD.Substring(0, descripcionODD.Length - 1);

                                    var countdown = CountdownODD(model);
                                    var imgF1 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo1ODD"), model.CodigoISO);
                                    var imgF2 = string.Format(ConfigurationManager.AppSettings.Get("UrlImgFondo2ODD"), model.CodigoISO);
                                    var imgSh = string.Format(ConfigurationManager.AppSettings.Get("UrlImgSoloHoyODD"), model.CodigoISO);
                                    //var imgBanner = string.Format(ConfigurationManager.AppSettings.Get("UrlImgBannerODD"), model.CodigoISO, ofertaDelDia.ImagenURL);
                                    //var imgDisplay = string.Format(ConfigurationManager.AppSettings.Get("UrlImgDisplayODD"), model.CodigoISO, ofertaDelDia.ImagenURL);
                                    var colorF1 = configOfertaDelDia.Where(x => x.TablaLogicaDatosID == 9301).First().Codigo ?? string.Empty;
                                    var colorF2 = configOfertaDelDia.Where(x => x.TablaLogicaDatosID == 9302).First().Codigo ?? string.Empty;
                                    descripcionODD = descripcionODD.Replace("|", " +<br />");
                                    descripcionODD = descripcionODD.Replace("\\", "");
                                    descripcionODD = descripcionODD.Replace("(GRATIS)", "<b>GRATIS</b>");

                                    var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;

                                    ofertaDelDia.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, ofertaDelDia.FotoProducto01, carpetaPais);
                                    ofertaDelDia.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, ofertaDelDia.ImagenURL, carpetaPais);
                                    var imgBanner = ofertaDelDia.FotoProducto01;
                                    var imgDisplay = ofertaDelDia.FotoProducto01;

                                    var oddModel = new OfertaDelDiaModel();
                                    oddModel.CodigoIso = model.CodigoISO;
                                    oddModel.TipoEstrategiaID = ofertaDelDia.TipoEstrategiaID;
                                    oddModel.EstrategiaID = ofertaDelDia.EstrategiaID;
                                    oddModel.MarcaID = ofertaDelDia.MarcaID;
                                    oddModel.CUV2 = ofertaDelDia.CUV2;
                                    oddModel.LimiteVenta = ofertaDelDia.LimiteVenta;
                                    oddModel.IndicadorMontoMinimo = ofertaDelDia.IndicadorMontoMinimo;
                                    oddModel.TipoEstrategiaImagenMostrar = ofertaDelDia.TipoEstrategiaImagenMostrar;
                                    oddModel.TeQuedan = countdown;
                                    oddModel.ImagenFondo1 = imgF1;
                                    oddModel.ColorFondo1 = colorF1;
                                    oddModel.ImagenBanner = imgBanner;
                                    oddModel.ImagenSoloHoy = imgSh;
                                    oddModel.ImagenFondo2 = imgF2;
                                    oddModel.ColorFondo2 = colorF2;
                                    oddModel.ImagenDisplay = imgDisplay;
                                    oddModel.NombreOferta = nombreODD;
                                    oddModel.DescripcionOferta = descripcionODD;
                                    oddModel.PrecioOferta = ofertaDelDia.Precio2;
                                    oddModel.PrecioCatalogo = ofertaDelDia.Precio;

                                    model.TieneOfertaDelDia = true;
                                    //Session["OfertaDelDia"] = oddModel;
                                    //Session["CloseODD"] = false;
                                    model.OfertaDelDia = oddModel;
                                    //model.IdTipoEstrategiaODD = ofertaDelDia.TipoEstrategiaID;
                                    //model.LimiteVentaOfertaDelDia = oddModel.LimiteVenta;

                                }// config ODD
                            }// list ODD
                            
                            /*PL20-1226*/
                        }
                    }
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

        public List<ServiceSAC.BEProductoFaltante> GetModelPedidoAgotado(int PaisID, int CampaniaID, int ZonaID)
        {
            List<ServiceSAC.BEProductoFaltante> olstProductoFaltante = new List<ServiceSAC.BEProductoFaltante>();
            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(PaisID, CampaniaID, ZonaID).ToList();
            }
            return olstProductoFaltante;
        }

        public List<TipoLinkModel> GetLinksPorPais(int PaisID)
        {
            List<ServiceContenido.BETipoLink> listModel = new List<ServiceContenido.BETipoLink>();
            using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
            {
                listModel = sv.GetLinksPorPais(PaisID).ToList();
            }

            Mapper.CreateMap<BETipoLink, TipoLinkModel>()
                  .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                  .ForMember(t => t.TipoLinkID, f => f.MapFrom(c => c.TipoLinkID))
                  .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            return Mapper.Map<IList<BETipoLink>, List<TipoLinkModel>>(listModel);
        }

        public bool GetPermisoFlexipago(int PaisID, string PaisISO, string CodigoConsultora, int CampaniaID)
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

        public ActionResult Timeout()
        {
            return View();
        }

        public string GetIPCliente()
        {
            string IP = string.Empty;
            try
            {
                IP = HttpContext.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                IP = (new Regex(@"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")).Matches(IP)[0].ToString();
            }
            catch { }
            return IP;
        }

        public int MenuNotificaciones(BEUsuario oBEUsuario)
        {
            if (oBEUsuario.NuevoPROL && oBEUsuario.ZonaNuevoPROL)
                return 1;
            else
                return 0;
        }

        public bool RegionPROL(string ISOPais, string CodRegion)
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

        public int TieneNotificaciones(BEUsuario oBEUsuario)
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

        public String GetFechaPromesaEntrega(int PaisId, int CampaniaId, string CodigoConsultora, DateTime FechaFact)
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

        public bool EsUsuarioComunidad(int PaisId, string CodigoUsuario)
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

        /*PL20-1226*/
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
        /*PL20-1226*/
    }
}