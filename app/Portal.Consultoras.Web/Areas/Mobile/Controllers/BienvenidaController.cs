﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BienvenidaController : BaseMobileController
    {
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult Index(int verSeccion = 0)
        {
            var model = new BienvenidaModel();
            try
            {
                model.RevistaDigital = revistaDigital;
                model.RevistaDigitalPopUpMostrar = revistaDigital.NoVolverMostrar;

                var pedidoWeb = base.ObtenerPedidoWeb();
                if (pedidoWeb != null)
                {
                    model.MontoAhorroCatalogo = pedidoWeb.MontoAhorroCatalogo;
                    model.MontoAhorroRevista = pedidoWeb.MontoAhorroRevista;
                }

                var pedidoWebDetalle = base.ObtenerPedidoWebDetalle();
                if (pedidoWebDetalle != null)
                {
                    model.MontoPedido = pedidoWebDetalle.Sum(p => p.ImporteTotal);
                }

                model.Saludo = ObtenerSaludo();
                model.codigoConsultora = userData.CodigoConsultora;
                model.Simbolo = userData.Simbolo;
                model.NombreConsultora = ObtenerNombreConsultora();
                model.PaisID = userData.PaisID;
                model.CodigoISO = userData.CodigoISO;
                model.NombrePais = userData.NombrePais;
                model.CodigoZona = userData.CodigoZona;
                model.NumeroCampania = userData.CampaniaID == 0 ? "" : userData.CampaniaID.ToString().Substring(4);
                model.DiasParaCierre = ViewBag.Dias;
                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.IndicadorPermisoFIC = ViewBag.IndicadorPermisoFIC;
                model.InscritaFlexipago = userData.InscritaFlexipago;
                model.InvitacionRechazada = userData.InvitacionRechazada;
                model.Lider = userData.Lider;
                model.PortalLideres = userData.PortalLideres;
                model.DiaPROL = userData.DiaPROL;
                model.VioTutorial = userData.VioTutorialModelo;
                model.UrlEnterateMas = ConfigS3.GetUrlFileS3("Mobile/AppCatalogo/" + userData.CodigoISO, "enteratemas.png", String.Empty);
                model.CampaniaActual = userData.CampaniaID;
                model.CatalogoPersonalizadoMobile = userData.CatalogoPersonalizado;
                model.RutaChile = ObtenerRutaChile();
                model.UrlChileEncriptada = ObtenerUrlChileEncriptada();
                model.PROL1 = (ObtenerConfiguracionCampania().ZonaValida && !userData.PROLSinStock && !(userData.NuevoPROL && userData.ZonaNuevoPROL));
                model.FechaVencimiento = ObtenerFechaVencimiento();

                model.MontoDeuda = userData.MontoDeuda;
                model.IsConsultoraOnline = ObtenerIsConsultoraOnline();

                model.UrlImagenAppCatalogo = ConfigS3.GetUrlFileS3("Mobile/AppCatalogo/" + userData.CodigoISO, "app.png", String.Empty);
                model.UrlImagenMiAcademia = ConfigS3.GetUrlFileS3("Mobile/MiAcademia/" + userData.CodigoISO, "miacademia.png", String.Empty);
                model.UrlImagenLiquidaciones = ConfigS3.GetUrlFileS3("Mobile/Liquidaciones/" + userData.CodigoISO, "liquidaciones.png", String.Empty);
                model.UrlImagenCatalogoPersonalizado = ConfigS3.GetUrlFileS3("Mobile/CatalogoPersonalizado/" + userData.CodigoISO, "catalogo.png", String.Empty);
                model.EsCatalogoPersonalizadoZonaValida = userData.EsCatalogoPersonalizadoZonaValida;
                model.CodigoUsuario = userData.CodigoUsuario; //EPD-1180
                model.EMail = userData.EMail;
                model.Celular = userData.Celular;

                model.EmailActivo = userData.EMailActivo;
                model.TieneCupon = userData.TieneCupon;
                model.TieneMasVendidos = userData.TieneMasVendidos;
                model.TieneAsesoraOnline = userData.TieneAsesoraOnline;
                model.ActivacionAppCatalogoWhastUp = ObtenerActivacionAppCatalogoWhastUp();
                model.CampaniaMasDos = AddCampaniaAndNumero(Convert.ToInt32(model.NumeroCampania), 2);
                model.ShowRoomMostrarLista = ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado) ? 0 : 1;

                ViewBag.paisISO = userData.CodigoISO;
                ViewBag.Ambiente = ConfigurationManager.AppSettings.Get("BUCKET_NAME") ?? string.Empty;
                ViewBag.NombreConsultora = model.NombreConsultora;                

                ViewBag.NombreConsultoraFAV = ObtenerNombreConsultoraFav();
                ViewBag.UrlImagenFAVMobile = string.Format(ConfigurationManager.AppSettings.Get("UrlImagenFAVMobile"), userData.CodigoISO);

                if (Session[Constantes.ConstSession.IngresoPortalConsultoras] == null)
                {
                    RegistrarLogDynamoDB(Constantes.LogDynamoDB.AplicacionPortalConsultoras, Constantes.LogDynamoDB.RolConsultora, "HOME", "INGRESAR");
                    Session[Constantes.ConstSession.IngresoPortalConsultoras] = true;
                }

                model.PrimeraVezSession = 0;
                if (Session["PrimeraVezSessionMobile"] == null)
                {
                    model.PrimeraVezSession = 1;
                    Session["PrimeraVezSessionMobile"] = 1;
                }

                ViewBag.VerSeccion = verSeccion;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        private string ObtenerSaludo()
        {
            var saludo = string.Empty;
            if (!string.IsNullOrEmpty(ViewBag.MensajeCumpleanos))
            {
                saludo = ViewBag.MensajeCumpleanos;
            }
            else if (!string.IsNullOrEmpty(ViewBag.MensajeAniversario))
            {
                saludo = ViewBag.MensajeAniversario;
            }
            else
            {
                saludo = ViewBag.Usuario;
            }

            return saludo;
        }

        private string ObtenerNombreConsultora()
        {
            var nombreConsultora = string.Empty;
            nombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            int j = nombreConsultora.Trim().IndexOf(' ');
            if (j >= 0)
                nombreConsultora = nombreConsultora.Substring(0, j).Trim();
            return nombreConsultora;
        }

        private string ObtenerRutaChile()
        {
            var rutaChile = string.Empty;
            if (userData.CodigoISO == Constantes.CodigosISOPais.Chile ||
                userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
            {
                var tabla = new List<BETablaLogicaDatos>();
                using (SACServiceClient sac = new SACServiceClient())
                {
                    tabla = sac.GetTablaLogicaDatos(userData.PaisID, 60).ToList();

                    if (userData.CodigoISO == Constantes.CodigosISOPais.Chile)
                    {
                        rutaChile = ConfigurationManager.AppSettings.Get("UrlPagoLineaChile");
                    }
                    else
                    {
                        rutaChile = string.Empty;
                    }
                }
            }
            else
            {
                rutaChile = string.Empty;
            }

            return rutaChile;
        }

        private string ObtenerUrlChileEncriptada()
        {
            var parametro = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;
            var urlChile = Util.EncriptarQueryString(parametro);
            return urlChile;
        }

        private BEConfiguracionCampania ObtenerConfiguracionCampania()
        {
            BEConfiguracionCampania configuracionCampania;

            using (var sv = new PedidoServiceClient())
            {
                configuracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            return configuracionCampania;
        }

        private string ObtenerFechaVencimiento()
        {
            return userData.FechaLimPago.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : userData.FechaLimPago.ToString("dd/MM/yyyy");
        }

        private int ObtenerIsConsultoraOnline()
        {
            int isConsultoraOnline;
            using (var sv = new UsuarioServiceClient())
            {
                isConsultoraOnline = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
            }

            return isConsultoraOnline;
        }

        private int ObtenerActivacionAppCatalogoWhastUp()
        {
            string PaisesCatalogoWhatsUp = ConfigurationManager.AppSettings.Get("PaisesCatalogoWhatsUp") ?? string.Empty;

            int activacionAppCatalogoWhastUp;
            if (PaisesCatalogoWhatsUp.Contains(userData.CodigoISO))
            {
                activacionAppCatalogoWhastUp = 1;
            }
            else
            {
                activacionAppCatalogoWhastUp = 0;
            }

            return activacionAppCatalogoWhastUp;
        }

        private string ObtenerNombreConsultoraFav()
        {
            var nombreConsultoraFAV = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            nombreConsultoraFAV = nombreConsultoraFAV.First().ToString().ToUpper() + nombreConsultoraFAV.ToLower().Substring(1);
            return nombreConsultoraFAV;
        }

        [HttpPost]
        public JsonResult ValidacionConsultoraDA()
        {
            bool validar = false;
            string mensajeFechaDA = null;
            UsuarioModel userData = this.UserData();

            if (userData.EsquemaDAConsultora == true)
            {
                if (userData.EsZonaDemAnti == 1)
                {
                    int consultoraDA = 0;
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        BEConfiguracionConsultoraDA configuracionConsultoraDA = new BEConfiguracionConsultoraDA();
                        configuracionConsultoraDA.CampaniaID = Convert.ToString(userData.CampaniaID);
                        configuracionConsultoraDA.ConsultoraID = Convert.ToInt32(userData.ConsultoraID);
                        configuracionConsultoraDA.ZonaID = userData.ZonaID;

                        consultoraDA = sv.GetConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDA);
                        if (consultoraDA == 0)
                        {
                            BECronograma cronograma = sv.GetCronogramaByCampaniaAnticipado(userData.PaisID, userData.CampaniaID, userData.ZonaID, 2).FirstOrDefault();
                            DateTime fechaDA = ((DateTime)cronograma.FechaInicioWeb) + userData.HoraCierreZonaDemAntiCierre;
                            mensajeFechaDA = fechaDA.ToString(@"dddd dd \de MMMM (hh:mm tt)");

                            validar = true;
                        }
                    }
                }
            }

            return Json(new { success = validar, mensajeFechaDA = mensajeFechaDA });
        }

        /// <summary>
        /// Obtiene la URL para el chat que se mostrara dependiendo del pais.
        /// </summary>
        /// <returns>URL: chat relacionado al pais</returns>
        public ActionResult ChatBelcorp()
        {
            string url = "";
            string fechaInicioChat = ConfigurationManager.AppSettings["FechaChat_" + userData.CodigoISO].ToString();

            if (ConfigurationManager.AppSettings["PaisesBelcorpChatEMTELCO"].Contains(userData.CodigoISO) &&
                !String.IsNullOrEmpty(fechaInicioChat))
            {
                DateTime fechaInicioChatPais = DateTime.ParseExact(fechaInicioChat,
                    "dd/MM/yyyy",
                    CultureInfo.InvariantCulture);
                if (DateTime.Now >= fechaInicioChatPais)
                {
                    url = String.Format(ConfigurationManager.AppSettings["UrlBelcorpChat"],
                        userData.SegmentoAbreviatura.Trim(),
                        userData.CodigoUsuario.Trim(),
                        userData.PrimerNombre.Split(' ').First().Trim(),
                        userData.EMail.Trim(), userData.CodigoISO.Trim());
                }
            }
            else
            {
                if (userData.CodigoISO.Equals("PA"))
                {
                    url = ConfigurationManager.AppSettings["UrlChatPA"];
                }
                else if (userData.CodigoISO.Equals("QR"))
                {
                    url = ConfigurationManager.AppSettings["UrlChatQR"];
                }
                else if (userData.CodigoISO.Equals("SV"))
                {
                    url = ConfigurationManager.AppSettings["UrlChatSV"];
                }
                else if (userData.CodigoISO.Equals("GT"))
                {
                    url = ConfigurationManager.AppSettings["UrlChatGT"];
                }
                else
                {
                    url = ConfigurationManager.AppSettings["UrlChatDefault"] +
                        ConfigurationManager.AppSettings["TokenAtento_" + userData.CodigoISO];
                }
            }
            ViewBag.UrlBelcorpChatPais = url;
            return Redirect(url);
        }

        [HttpGet]
        public JsonResult JSONSetUsuarioTutorial()
        {
            int retorno;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                retorno = sv.setUsuarioVerTutorial(userData.PaisID, userData.CodigoUsuario);
                userData.VioTutorialModelo = retorno;
            }
            SetUserData(userData);
            return Json(new
            {
                result = retorno
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult ObtenerComunicadosPopUps()
        {
            BEComunicado oComunicados = null;

            try
            {
                using (SACServiceClient sac = new SACServiceClient())
                {
                    var lstComunicados = sac.ObtenerComunicadoPorConsultora(userData.PaisID, userData.CodigoConsultora, Constantes.ComunicadoTipoDispositivo.Mobile).ToList();
                    if (lstComunicados != null) oComunicados = lstComunicados.FirstOrDefault();
                }

                return Json(new
                {
                    success = true,
                    message = string.Empty,
                    extra = oComunicados
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
