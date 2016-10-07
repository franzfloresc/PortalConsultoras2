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
                pasoLog = "Se empezará a leer los Claims";
                ClaimsPrincipal claimsPrincipal = User as ClaimsPrincipal;
                pasoLog = "Se obtuvo claimsPrincipal";
                Claim FederationClaimName = claimsPrincipal.FindFirst(ClaimTypes.Name);
                if (FederationClaimName == null)
                {
                    pasoLog = "FederationClaimName es null";
                }
                string claimUser = FederationClaimName.Value.ToUpper();
                pasoLog = "FederationClaimName.Value: " + FederationClaimName.Value;
                string DomConsultora = ConfigurationManager.AppSettings.Get("DomConsultora");
                pasoLog = "DomConsultora: " + DomConsultora;
                string DomBelcorp = ConfigurationManager.AppSettings.Get("DomBelcorp");
                pasoLog = "DomBelcorp: " + DomBelcorp;

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

                pasoLog = "Se obtuvo el usuario";
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

                    pasoLog = "Se obtuvo el país";
                    paisLog = Pais;
                    usuarioLog = Codigo;

                    BEPais PaisModel = lst.First(p => p.CodigoISO == Pais);
                    if (PaisModel != null)
                    {
                        UsuarioModel usuario = GetUserData(PaisModel.PaisID, Codigo, Tipo);
                        if (usuario != null)
                        {
                            pasoLog = "Se obtuvo datos de sesión";

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
                    pasoLog = "Se obtuvo usuario de BD";

                    if (oBEUsuario != null && refrescarDatos == 0)
                    {
                        try
                        {
                            //El campo DetalleError, se reutiliza para enviar la campania de la consultora.
                            sv.InsLogIngresoPortal(PaisID, oBEUsuario.CodigoConsultora, GetIPCliente(), 1, oBEUsuario.CampaniaID.ToString());
                            pasoLog = "Se registro el log de ingreso al portal";
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
                    model.EMail = oBEUsuario.EMail;
                    model.CampaniaID = oBEUsuario.CampaniaID;
                    model.BanderaImagen = oBEUsuario.BanderaImagen;
                    model.CambioClave = Convert.ToInt32(oBEUsuario.CambioClave);
                    model.ConsultoraNueva = oBEUsuario.ConsultoraNueva;
                    model.Telefono = oBEUsuario.Telefono;
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
                    model.FechaLimPago = oBEUsuario.FechaLimPago;
                    model.VioVideoModelo = oBEUsuario.VioVideo;
                    model.VioTutorialModelo = oBEUsuario.VioTutorial;
                    model.VioTutorialDesktop = oBEUsuario.VioTutorialDesktop;
                    model.HabilitarRestriccionHoraria = oBEUsuario.HabilitarRestriccionHoraria;
                    model.IndicadorPermisoFIC = oBEUsuario.IndicadorPermisoFIC;
                    model.HorasDuracionRestriccion = oBEUsuario.HorasDuracionRestriccion;
                    model.EsJoven = oBEUsuario.EsJoven;
                    model.PROLSinStock = oBEUsuario.PROLSinStock;
                    model.HoraCierreZonaDemAntiCierre = oBEUsuario.HoraCierreZonaDemAntiCierre;

                    if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion)
                        model.DiaPROLMensajeCierreCampania = false;
                    else
                        model.DiaPROLMensajeCierreCampania = true;

                    if (DateTime.Now.AddHours(oBEUsuario.ZonaHoraria) < oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes))
                    {
                        model.DiaPROL = false;
                        model.FechaFacturacion = oBEUsuario.FechaInicioFacturacion.AddDays(-oBEUsuario.DiasAntes);
                        if (oBEUsuario.DiasAntes == 0)
                            model.HoraFacturacion = oBEUsuario.HoraInicio;
                        else
                            model.HoraFacturacion = oBEUsuario.HoraInicioNoFacturable;
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
                    model.MontoMinimo = oBEUsuario.MontoMinimoPedido;
                    model.MontoMaximo = oBEUsuario.MontoMaximoPedido;
                    model.Simbolo = oBEUsuario.Simbolo;
                    model.CodigoTerritorio = oBEUsuario.CodigoTerritorio;
                    pasoLog = "Obtener listado de productos faltantes";
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
                    pasoLog = "Obtener IP de Cliente";
                    model.IPUsuario = GetIPCliente();
                    model.AnoCampaniaIngreso = oBEUsuario.AnoCampaniaIngreso;
                    model.PrimerNombre = oBEUsuario.PrimerNombre;
                    model.PrimerApellido = oBEUsuario.PrimerApellido;
                    model.IndicadorFlexiPago = oBEUsuario.IndicadorFlexiPago;
                    pasoLog = "Obtener Permisos de flexipago";
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
                    {
                        pasoLog = "Obtener si tiene notificaciones";
                        model.TieneNotificaciones = TieneNotificaciones(oBEUsuario);
                    }
                    model.NuevoPROL = oBEUsuario.NuevoPROL;
                    model.ZonaNuevoPROL = oBEUsuario.ZonaNuevoPROL;

                    if (oBEUsuario.CampaniaID != 0)
                    {
                        pasoLog = "Obtener fecha promesa";
                        valores = GetFechaPromesaEntrega(oBEUsuario.PaisID, oBEUsuario.CampaniaID, oBEUsuario.CodigoConsultora, oBEUsuario.FechaInicioFacturacion);
                        arrValores = valores.Split('|');
                        model.TipoCasoPromesa = arrValores[2].ToString();
                        model.DiasCasoPromesa = Convert.ToInt16(arrValores[1].ToString());
                        model.FechaPromesaEntrega = Convert.ToDateTime(arrValores[0].ToString());
                    }
                    pasoLog = "Obtener links por pais";
                    List<TipoLinkModel> lista = GetLinksPorPais(model.PaisID);
                    if (lista.Count > 0)
                    {
                        model.UrlAyuda = lista.Find(x => x.TipoLinkID == 301).Url;
                        model.UrlCapedevi = lista.Find(x => x.TipoLinkID == 302).Url;
                        model.UrlTerminos = lista.Find(x => x.TipoLinkID == 303).Url;
                    }

                    pasoLog = "Obtener si es usuario comunidad";
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
                    model.OfertaFinal = oBEUsuario.OfertaFinal;
                    model.EsOfertaFinalZonaValida = oBEUsuario.EsOfertaFinalZonaValida;
                    model.CatalogoPersonalizado = oBEUsuario.CatalogoPersonalizado;
                    model.EsCatalogoPersonalizadoZonaValida = oBEUsuario.EsCatalogoPersonalizadoZonaValida;

                    //if (model.RolID == 1) this.CrearUsuarioMiAcademia(model);
                }

                pasoLog = "Agregar usuario en session";
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

        //CCSS_JZ_PROL
        //RQ_NP - R2133
        public int MenuNotificaciones(BEUsuario oBEUsuario)
        {
            if (oBEUsuario.NuevoPROL && oBEUsuario.ZonaNuevoPROL)
                return 1;
            else
                return 0;
        }

        //CCSS_JZ_PROL
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
                olstNotificaciones = sv.GetNotificacionesConsultora(oBEUsuario.PaisID, oBEUsuario.ConsultoraID).ToList();
            }
            if (olstNotificaciones.Count != 0)
            {
                int Cantidad = olstNotificaciones.Count(p => p.Visualizado == false);
                if (Cantidad > 0)
                    Tiene = 1;
            }
            return Tiene;
        }

        //RQ_FP - R2161
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

        /*Inicio Cambios_Landing_Comunidad*/
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
        /*Fin Cambios_Landing_Comunidad*/

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
    }
}