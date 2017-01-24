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
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginController : Controller
    {
        private string pasoLog;

        [AllowAnonymous]
        public ActionResult Index()
        {
            string IP = string.Empty;
            string ISO = string.Empty;
            var model = new UsuarioModel();

            try
            {
                var buscarISOPorIP = ConfigurationManager.AppSettings.Get("BuscarISOPorIP");

                if (buscarISOPorIP == "1")
                {
                    IP = GetIPCliente();
                    ISO = Util.GetISObyIPAddress(IP);
                }
                else
                {
                    IP = "190.187.154.154";
                    ISO = "PE";
                }

                if (IP.IndexOf(":") > 0)
                {
                    IP = IP.Substring(0, IP.IndexOf(":") - 1);
                }

                if (ISO != "")
                {
                    AsignarHojaEstilos(ISO);
                }
                
                model.listaPaises = DropDowListPaises();                
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "Ingreso al portal - Index()");
            }

            return View(model);
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(UsuarioModel model)
        {
            pasoLog = "Ingreso al portal";
            try
            {
                BEValidaLoginSB2 validaLogin = null;
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    validaLogin = svc.GetValidarLoginSB2(model.HdePaisID, model.CodigoUsuario, model.ClaveSecreta);
                }

                if (validaLogin.Result == 3)
                {
                    //if (string.IsNullOrEmpty(model.CodigoConsultora))
                    //    model.CodigoConsultora = model.CodigoUsuario;
                    return Redireccionar(model.HdePaisID, model.CodigoUsuario);                    
                }
                else
                {
                    TempData["errorLogin"] = validaLogin.Mensaje;
                    return RedirectToAction("Index", "Login");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, model.CodigoUsuario, model.CodigoISO, pasoLog);

                TempData["errorLogin"] = "Error al procesar la solicitud";
                return RedirectToAction("Index", "Login");
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult LoginAdmin(UsuarioModel model)
        {
            string resultado = Util.ValidarUsuarioADFS(model.CodigoUsuario, model.ClaveSecreta);

            string codigoResultado = resultado.Split('|')[0];
            string mensajeResultado = resultado.Split('|')[1];
            string paisIso= resultado.Split('|')[2];            

            if (codigoResultado == "000")
            {                
                int paisId = Util.GetPaisID(paisIso);
                return Redireccionar(paisId, model.CodigoUsuario);
            }

            TempData["errorLoginAdmin"] = mensajeResultado;
            return RedirectToAction("Admin", "Login");
            //return RedirectToAction("Index");
        }

        public ActionResult Redireccionar(int paisId, string codigoUsuario)
        {
            UsuarioModel usuario = GetUserData(paisId, codigoUsuario, 1);
            if (usuario != null)
            {
                FormsAuthentication.SetAuthCookie(usuario.CodigoUsuario, false);

                if (usuario.RolID == Constantes.Rol.Consultora)
                {
                    bool esMovil = Request.Browser.IsMobileDevice;

                    if (esMovil)
                    {
                        return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(usuario.EMail) || usuario.EMailActivo == false)
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            IList<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises();
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CodigoISO, f => f.MapFrom(c => c.CodigoISO))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

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
            if (Tipo == 2)
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
                    model.EstaRechazado = oBEUsuario.IndicadorRechazado == 2 ? 2 : 0;
                    if (oBEUsuario.IndicadorEnviado == 1 && oBEUsuario.IndicadorRechazado == 1)
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
                            model.EstaRechazado = 2;
                            var listaRechazo = procesoRechazado.olstBEPedidoRechazado != null ? procesoRechazado.olstBEPedidoRechazado.ToList() : new List<BEPedidoRechazado>();
                            if (listaRechazo.Any())
                            {
                                model.EstaRechazado = 0;
                                listaRechazo = listaRechazo.Where(r => r.Rechazado).ToList();
                                //listaRechazo = listaRechazo.Where(r => r.RequiereGestion).ToList();
                                //var d = listaRechazo.Where(r => r.Procesado).ToList();
                                if (listaRechazo.Any())
                                {
                                    model.EstaRechazado = 1;
                                    model.MotivoRechazo = "";
                                    string valor = oBEUsuario.Simbolo + " ";
                                    string valorx = "";

                                    // deuda, monto mínimo/máximo/MinStock

                                    listaRechazo.Update(p => p.MotivoRechazo = Util.SubStr(p.MotivoRechazo, 0).ToLower());
                                    listaRechazo = listaRechazo.Where(p => p.MotivoRechazo != "").ToList();

                                    var listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == "deuda").ToList();
                                    if (listaMotivox.Any())
                                    {
                                        valorx = valor + listaMotivox[0].Valor;
                                        model.MotivoRechazo = "Tienes una deuda de " + valorx + " que debes regularizar. <a href='javascript:;' onclick=RedirectMenu('Index','MisPagos',0,'') >MIRA LOS LUGARES DE PAGO</a>";
                                    }

                                    listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == "minimo").ToList();
                                    if (listaMotivox.Any())
                                    {
                                        if (model.MotivoRechazo != "")
                                        {
                                            model.MotivoRechazo = "Tienes una deuda pendiente de " + valorx;
                                            valorx = valor + listaMotivox[0].Valor;
                                            model.MotivoRechazo += ". Además, para pasar pedido debes alcanzar el monto mínimo de " + valorx + ". <a href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido') >MODIFICA TU PEDIDO</a>";
                                        }
                                        else
                                        {
                                            valorx = valor + listaMotivox[0].Valor;
                                            model.MotivoRechazo = "No llegaste al mínimo de " + valorx + ". <a href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido') >MODIFICA TU PEDIDO</a>";
                                        }
                                    }
                                    else
                                    {
                                        listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == "maximo").ToList();
                                        if (listaMotivox.Any())
                                        {
                                            if (model.MotivoRechazo != "")
                                            {
                                                model.MotivoRechazo = "Tienes una deuda pendiente de " + valorx;
                                                valorx = valor + listaMotivox[0].Valor;
                                                model.MotivoRechazo += ". Además, superaste tu línea de crédito de " + valorx + ". <a href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido') >MODIFICA TU PEDIDO</a>";
                                            }
                                            else
                                            {
                                                valorx = valor + listaMotivox[0].Valor;
                                                model.MotivoRechazo = "Superaste tu línea de crédito de " + valorx + ". <a href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido') >MODIFICA TU PEDIDO</a>";
                                            }
                                        }
                                    }


                                    listaMotivox = listaRechazo.Where(p => p.MotivoRechazo == "minstock").ToList();
                                    if (listaMotivox.Any())
                                    {
                                        valorx = valor + listaMotivox[0].Valor;
                                        model.MotivoRechazo = "No llegaste al mínimo de " + valorx + ". <a href='javascript:;' onclick=RedirectMenu('Index','Pedido',0,'Pedido') >MODIFICA TU PEDIDO</a>";
                                    }
                                }

                                // llamar al maestro de mensajes
                            }
                        }
                    }
                    #endregion

                    model.MotivoRechazo = model.MotivoRechazo.Trim();
                    model.IndicadorEnviado = oBEUsuario.IndicadorEnviado;
                    model.IndicadorRechazado = oBEUsuario.IndicadorRechazado;
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

        private List<BEProductoFaltante> GetModelPedidoAgotado(int PaisID, int CampaniaID, int ZonaID)
        {
            List<BEProductoFaltante> olstProductoFaltante = new List<BEProductoFaltante>();
            using (SACServiceClient sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(PaisID, CampaniaID, ZonaID).ToList();
            }
            return olstProductoFaltante;
        }

        private List<TipoLinkModel> GetLinksPorPais(int PaisID)
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

        private int MenuNotificaciones(BEUsuario oBEUsuario)
        {
            if (oBEUsuario.NuevoPROL && oBEUsuario.ZonaNuevoPROL)
                return 1;
            else
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

        private int TieneNotificaciones(BEUsuario oBEUsuario)
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
        public JsonResult RecuperarContrasenia(int paisId, string correo)
        {
            var respuesta = OlvideContrasena(paisId, correo);

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

        private string OlvideContrasena(int paisId, string correo)
        {
            var resultado = "";
            var paso = "1";
            var esEsika = false;

            try
            {
                var mailBody = "";
                // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                if (paisId == 11 || paisId == 2 || paisId == 3 || paisId == 8 || paisId == 7 || paisId == 4)
                    esEsika = true;

                using (ServiceUsuario.UsuarioServiceClient sv = new ServiceUsuario.UsuarioServiceClient())
                {
                    List<BEUsuarioCorreo> lst = sv.SelectByEmail(correo, paisId).ToList();
                    paso = "2";

                    if (paisId.ToString().Trim() == "4")
                    {
                        if (lst.Count == 0)
                        {
                            resultado = "0" + "|" + "1";
                            return resultado;
                        }
                        else
                        {
                            correo = lst[0].Descripcion;// contiene el correo del destinatario
                            if (correo.Trim() == "")
                            {
                                resultado = "0" + "|" + "2";
                                return resultado;
                            }
                        }
                    }

                    if (lst[0].Cantidad == 0)
                    {
                        resultado = "0" + "|" + "3";
                        return resultado;
                    }
                    else
                    {
                        string urlportal = ConfigurationManager.AppSettings["UrlSiteSE"];

                        DateTime diasolicitud = DateTime.Now.AddHours(DateTime.Now.Hour + 24);

                        string paisid = HttpUtility.UrlEncode(Encrypt(paisId.ToString().Trim()));
                        string email_ = HttpUtility.UrlEncode(Encrypt(correo.Trim()));
                        string paisiso = HttpUtility.UrlEncode(Encrypt(lst[0].CodigoISO.Trim()));
                        string codigousuario = HttpUtility.UrlEncode(Encrypt(lst[0].CodigoUsuario.Trim()));
                        string fechasolicitud = HttpUtility.UrlEncode(Encrypt(diasolicitud.ToString("d/M/yyyy HH:mm:ss").Trim()));
                        string nombre = HttpUtility.UrlEncode(Encrypt(lst[0].Nombre.Trim().Split(' ').First()));

                        var uri = new Uri(urlportal + "/WebPages/RestablecerContrasena.aspx?xyzab=param1&abxyz=param2&yzabx=param3&bxyza=param4&zabxy=param5");
                        var qs = HttpUtility.ParseQueryString(uri.Query);
                        qs.Set("xyzab", paisid);
                        qs.Set("abxyz", email_);
                        qs.Set("yzabx", paisiso);
                        qs.Set("bxyza", codigousuario);
                        qs.Set("zabxy", fechasolicitud);
                        qs.Set("xbaby", nombre);

                        var uriBuilder = new UriBuilder(uri)
                        {
                            Query = qs.ToString()
                        };
                        var newUri = uriBuilder.Uri;

                        paso = "3";

                        #region Mensaje
                        mailBody += "<html>";
                        mailBody += "<body style=\"margin:0px; padding:0px; background:#FFF;\">";
                        mailBody += "<table width=\"100%\" cellspacing=\"0\" align=\"center\" style=\"background:#FFF;\">";
                        mailBody += "<thead>";
                        mailBody += "<tr>";
                        mailBody += "<th style=\"width:28%; height:50px; border-bottom:1px solid #000;\"></th>";
                        mailBody += "<th style=\"width:44%; height:50px; border-bottom:1px solid #000; padding:12px 0px; text-align:center;\"><img src=\"" + (esEsika ? "https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo_esika.png" : "https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo_lbel.png") + "\" alt=\"Logo Esika\" /></th>";
                        mailBody += "<th style=\"width:28%; height:50px; border-bottom:1px solid #000;\"></th>";
                        mailBody += "</tr>";
                        mailBody += "</thead>";
                        mailBody += "<tbody>";
                        mailBody += "<tr>";
                        mailBody += "<td colspan=\"3\" style=\"height:30px;\"></td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td colspan=\"3\">";
                        mailBody += "<table align=\"center\" style=\"width:100%; text-align:center;\">";
                        mailBody += "<tbody>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"font-family:'Calibri'; font-size:17px; text-align:center; font-weight:500; color:#000; padding:0 0 26px 0;\">Hola <span>" + lst[0].Nombre.Trim().Split(' ').First() + "</span></td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"text-align:center; font-family:'Calibri'; font-size:22px; font-weight:700; color:#000; padding-bottom:15px;\">¿OLVIDASTE TU CONTRASE&Ntilde;A?</td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"text-align:center; font-family:'Calibri'; color:#000; font-weight:500; font-size:14px; padding-bottom:30px;\">No te preocupes, ingresa aquí para recuperarla:</td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"text-align:center;\">";
                        mailBody += "<a href=\"" + newUri + "\" title=\"Recuperar Contrase&ntilde;a\" style=\"text-decoration:none; display:inline-block; margin:0 auto; padding:0; font-family:'Calibri'; background:#" + (esEsika ? "e81c36" : "642f80") + "; font-size:16px; font-weight:700; color:#FFF; text-align:center; line-height:45px; width:271px; height:45px;\">RECUPERAR CONTRASE&Ntilde;A</a>";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "</tbody>";
                        mailBody += "</table>";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td colspan=\"3\" style=\"text-align:center; font-family:'Calibri'; color:#000; font-size:12px; font-weight:400;padding-top:45px; padding-bottom:27px;\"></td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td colspan=\"3\" style=\"background:#000; height:62px;\">";
                        mailBody += "<table align=\"center\" style=\"text-align:center; padding:0 13px; width:100%; max-width:524px; \">";
                        mailBody += "<tbody>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"width:13%; text-align:left;\">";
                        mailBody += "<img src=\"https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo-belcorp.png\" alt=\"Logo Belcorp\" />";
                        mailBody += "</td>";
                        mailBody += "<td style=\"width:9%; text-align:left; padding-top:3px;\">";
                        mailBody += "<a target='_blank' href='http://www.esika.com/'><img src=\"https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo-esika.png\" alt=\"Logo Esika\" /></a>";
                        mailBody += "</td>";
                        mailBody += "<td style=\"width:9%; text-align:left; padding-bottom:3px;\">";
                        mailBody += "<a target='_blank' href='http://www.lbel.com/pe/'><img src=\"https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo-lbel.png\" alt=\"Logo L'bel\" /></a>";
                        mailBody += "</td>";
                        mailBody += "<td style=\"width:14%; text-align:left;border-right:1px solid #FFF; padding-top:5px;\">";
                        mailBody += "<a target='_blank' href='http://www.cyzone.com/'><img src=\"https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo-cyzone.png\" alt=\"Logo Cyzone\" /></a>";
                        mailBody += "</td>";
                        mailBody += "<td style=\"width:18%; font-family:'Calibri'; font-weight:400; font-size:13px; color:#FFF; text-align:right; vertical-align:middle;\">";
                        mailBody += "<span style=\"text-align: left; display: inline-block; vertical-align: middle; width: 69%;\">SÍGUENOS EN</span>";
                        mailBody += "<span style=\"position: relative; top: 2px; left: 10px; display: inline-block; vertical-align: top;\"><a target='_blank' href='https://es-la.facebook.com/SomosBelcorpOficial'><img src=\"https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo-facebook.png\" alt=\"Logo Facebook\" /></span></a>";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "</tbody>";
                        mailBody += "</table>";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td colspan=\"3\">";
                        mailBody += "<table align=\"center\" style=\"text-align:center;\">";
                        mailBody += "<tbody>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"height:6px;\"></td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"font-family:'Calibri'; font-size:12px; color:#000; border-right:1px solid #000; padding:0 12px;\"><a target='_blank' href='http://comunidad.somosbelcorp.com/'>¿Tienes dudas?</td></a>";
                        mailBody += "<td style=\"font-family:'Calibri'; font-size:12px; color:#000; padding:0 12px;\"><a target='_blank' href='http://www.belcorpresponde.com/'>Contáctanos</td></a>";
                        mailBody += "</tr>";
                        mailBody += "</tbody>";
                        mailBody += "</table>";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "</tbody>";
                        mailBody += "</table>";
                        mailBody += "</body>";
                        mailBody += "</html>";
                        #endregion

                        Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + lst[0].CodigoISO + ") Cambio de contraseña de Somosbelcorp", mailBody, true, "Somos Belcorp");
                        resultado = "1" + "|" + "4" + "|" + correo;
                        return resultado;
                    }
                }
            }
            catch (Exception ex)
            {
                resultado = "0" + "|" + "6" + "|" + ex.Message + "|" + paso;
                return resultado;
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
    }
}
