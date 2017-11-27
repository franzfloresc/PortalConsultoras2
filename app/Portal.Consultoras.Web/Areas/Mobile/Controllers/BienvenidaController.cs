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
                if (base.ObtenerPedidoWeb() != null)
                {
                    model.MontoAhorroCatalogo = base.ObtenerPedidoWeb().MontoAhorroCatalogo;
                    model.MontoAhorroRevista = base.ObtenerPedidoWeb().MontoAhorroRevista;
                }

                if (base.ObtenerPedidoWebDetalle() != null)
                {
                    model.MontoPedido = base.ObtenerPedidoWebDetalle().Sum(p => p.ImporteTotal);
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
                model.TieneFechaPromesa = ViewBag.TieneFechaPromesa;
                model.DiaFechaPromesa = (ViewBag.DiaFechaPromesa == null ? 0 : ViewBag.DiaFechaPromesa);
                model.MensajeFechaPromesa = ViewBag.MensajeFechaPromesa;
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
                model.CodigoUsuario = userData.CodigoUsuario;
                model.EMail = userData.EMail;
                model.Celular = userData.Celular;

                model.EmailActivo = userData.EMailActivo;
                model.TieneCupon = userData.TieneCupon;
                model.TieneMasVendidos = userData.TieneMasVendidos;
                model.TieneAsesoraOnline = userData.TieneAsesoraOnline;
                model.ActivacionAppCatalogoWhastUp = ObtenerActivacionAppCatalogoWhastUp();
                model.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;
                model.ShowRoomMostrarLista = ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado) ? 0 : 1;

                ViewBag.paisISO = userData.CodigoISO;
                ViewBag.Ambiente = GetBucketNameFromConfig();
                ViewBag.NombreConsultora = model.NombreConsultora;

                model.RevistaDigital = revistaDigital;

                ViewBag.NombreConsultoraFAV = ObtenerNombreConsultoraFav();
                ViewBag.UrlImagenFAVMobile = string.Format(GetConfiguracionManager(Constantes.ConfiguracionManager.UrlImagenFAVMobile), userData.CodigoISO);

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

                model.TipoPopUpMostrar = ObtenerTipoPopUpMostrar();
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
                        rutaChile = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPagoLineaChile);
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

            return configuracionCampania ?? new BEConfiguracionCampania();
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
            string PaisesCatalogoWhatsUp = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesCatalogoWhatsUp);

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
            nombreConsultoraFAV = Util.SubStr(nombreConsultoraFAV, 0, 1).ToUpper() + Util.SubStr(nombreConsultoraFAV.ToLower(), 1);
            return nombreConsultoraFAV;
        }

        private int ObtenerTipoPopUpMostrar()
        {
            var TipoPopUpMostrar = 0;
            if (Session[Constantes.ConstSession.TipoPopUpMostrar] != null)
            {
                TipoPopUpMostrar = Convert.ToInt32(Session[Constantes.ConstSession.TipoPopUpMostrar]);

                if (TipoPopUpMostrar == Constantes.TipoPopUp.RevistaDigitalSuscripcion && revistaDigital.NoVolverMostrar)
                    TipoPopUpMostrar = 0;

                return TipoPopUpMostrar;
            }

            // debe tener la misma logica que desktop

            #region Revista Digital
            if (!revistaDigital.TieneRDS)
                return TipoPopUpMostrar;

            if (revistaDigital.NoVolverMostrar)
                return TipoPopUpMostrar;

            if (revistaDigital.EsSuscrita)
                return TipoPopUpMostrar;

            if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.NoPopUp)
                return TipoPopUpMostrar;

            TipoPopUpMostrar = Constantes.TipoPopUp.RevistaDigitalSuscripcion;
            #endregion

            Session[Constantes.ConstSession.TipoPopUpMostrar] = TipoPopUpMostrar;

            return TipoPopUpMostrar;
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
            string fechaInicioChat = GetConfiguracionManager(Constantes.ConfiguracionManager.FechaChat + userData.CodigoISO);

            if (GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesBelcorpChatEMTELCO).Contains(userData.CodigoISO) &&
                !String.IsNullOrEmpty(fechaInicioChat))
            {
                DateTime fechaInicioChatPais = DateTime.ParseExact(fechaInicioChat,
                    "dd/MM/yyyy",
                    CultureInfo.InvariantCulture);
                if (DateTime.Now >= fechaInicioChatPais)
                {
                    url = String.Format(GetConfiguracionManager(Constantes.ConfiguracionManager.UrlBelcorpChat),
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
                    url = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlChatPA);
                }
                else if (userData.CodigoISO.Equals("QR"))
                {
                    url = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlChatQR);
                }
                else if (userData.CodigoISO.Equals("SV"))
                {
                    url = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlChatSV);
                }
                else if (userData.CodigoISO.Equals("GT"))
                {
                    url = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlChatGT);
                }
                else
                {
                    url = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlChatDefault) +
                        GetConfiguracionManager(Constantes.ConfiguracionManager.TokenAtento + userData.CodigoISO);
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
