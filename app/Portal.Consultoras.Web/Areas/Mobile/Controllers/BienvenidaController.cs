﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BienvenidaController : BaseMobileController
    {
        private readonly ConfiguracionPaisDatosProvider _configuracionPaisDatosProvider;
        private readonly BienvenidaProvider _bienvenidaProvider;
        protected TablaLogicaProvider _tablaLogica;
        public BienvenidaController()
        {
            _configuracionPaisDatosProvider = new ConfiguracionPaisDatosProvider();
            _tablaLogica = new TablaLogicaProvider();
            _bienvenidaProvider = new BienvenidaProvider();
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult Index(int verSeccion = 0)
        {
            var model = new BienvenidaModel();
            try
            {
                if (userData.RolID != Constantes.Rol.Consultora)
                    if (userData.RolID == 0)
                        return RedirectToAction("LogOut", "Login");
                    else
                        return RedirectToAction("Index", "Bienvenida", new { area = "" });

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
                model.UrlEnterateMas = ConfigCdn.GetUrlFileCdn("Mobile/AppCatalogo/" + userData.CodigoISO, "enteratemas.png");
                model.CampaniaActual = userData.CampaniaID;
                model.CatalogoPersonalizadoMobile = userData.CatalogoPersonalizado;
                model.RutaChile = ObtenerRutaChile();
                model.UrlChileEncriptada = ObtenerUrlChileEncriptada();
                model.FechaVencimiento = ObtenerFechaVencimiento();

                model.MontoDeuda = userData.MontoDeuda;
                model.IsConsultoraOnline = ObtenerIsConsultoraOnline();

                model.UrlImagenAppCatalogo = ConfigCdn.GetUrlFileCdn("Mobile/AppCatalogo/" + userData.CodigoISO, "app.png");
                model.UrlImagenMiAcademia = ConfigCdn.GetUrlFileCdn("Mobile/MiAcademia/" + userData.CodigoISO, "miacademia.png");
                model.UrlImagenLiquidaciones = ConfigCdn.GetUrlFileCdn("Mobile/Liquidaciones/" + userData.CodigoISO, "liquidaciones.png");
                model.UrlImagenCatalogoPersonalizado = ConfigCdn.GetUrlFileCdn("Mobile/CatalogoPersonalizado/" + userData.CodigoISO, "catalogo.png");
                model.EsCatalogoPersonalizadoZonaValida = userData.EsCatalogoPersonalizadoZonaValida;
                model.CodigoUsuario = userData.CodigoUsuario;
                model.EMail = userData.EMail;
                model.Celular = userData.Celular;

                model.EmailActivo = userData.EMailActivo;
                model.TieneCupon = userData.TieneCupon;
                model.TieneMasVendidos = userData.TieneMasVendidos;
                model.TieneAsesoraOnline = userData.TieneAsesoraOnline;
                model.ActivacionAppCatalogoWhastUp = ObtenerActivacionAppCatalogoWhastUp();
                model.ShowRoomMostrarLista = (!ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado)).ToInt();

                ViewBag.paisISO = userData.CodigoISO;
                ViewBag.Ambiente = _configuracionManagerProvider.GetBucketNameFromConfig();
                ViewBag.NombreConsultora = model.NombreConsultora;

                model.PartialSectionBpt = _configuracionPaisDatosProvider.GetPartialSectionBptModel(Constantes.OrigenPedidoWeb.SectionBptMobileHome);
                ViewBag.NombreConsultoraFAV = ObtenerNombreConsultoraFav();
                ViewBag.UrlImagenFAVMobile = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlImagenFAVMobile), userData.CodigoISO);

                model.CambioClave = userData.CambioClave;

                if (SessionManager.GetIngresoPortalConsultoras() == null)
                {
                    RegistrarLogDynamoDB(Constantes.LogDynamoDB.AplicacionPortalConsultoras, Constantes.LogDynamoDB.RolConsultora, "HOME", "INGRESAR");
                    SessionManager.SetIngresoPortalConsultoras(true);
                }

                model.PrimeraVezSession = 0;
                if (SessionManager.GetPrimeraVezSessionMobile() == null)
                {
                    model.PrimeraVezSession = 1;
                    SessionManager.SetPrimeraVezSessionMobile(1);
                }

                ViewBag.VerSeccion = verSeccion;
                
                model.TipoPopUpMostrar = _bienvenidaProvider.ObtenerTipoPopUpMostrar(EsDispositivoMovil());

                model.TienePagoEnLinea = userData.TienePagoEnLinea;
                model.ConsultoraNuevaBannerAppMostrar = SessionManager.GetConsultoraNuevaBannerAppMostrar();
                model.MostrarPagoEnLinea = (userData.MontoDeuda > 0);


                #region Camino al Exito

                var LogicaCaminoExisto = _tablaLogica.GetTablaLogicaDatos(userData.PaisID, Constantes.TablaLogica.EscalaDescuentoMobile);
                if (LogicaCaminoExisto.Any())
                {
                    var CaminoExistoFirst = LogicaCaminoExisto.FirstOrDefault(x => x.TablaLogicaDatosID == Constantes.TablaLogicaDato.ActualizaEscalaDescuentoMobile) ?? new TablaLogicaDatosModel();
                    bool caminiExitoActive = (CaminoExistoFirst.Valor != null) && CaminoExistoFirst.Valor.Equals("1");
                    if (caminiExitoActive)
                    {
                        var accesoCaminoExito = this.ObjectCaminoExito();
                        model.TieneCaminoExito = accesoCaminoExito.Item1;
                        model.urlCaminoExito = accesoCaminoExito.Item2 ?? "";
                    }
                }

                #endregion

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
            string saludo;
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
            var nombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            int j = nombreConsultora.Trim().IndexOf(' ');
            if (j >= 0)
                nombreConsultora = nombreConsultora.Substring(0, j).Trim();
            return nombreConsultora;
        }

        private string ObtenerRutaChile()
        {
            var rutaChile = string.Empty;
            if (userData.CodigoISO == Constantes.CodigosISOPais.Chile)
            {
                rutaChile = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPagoLineaChile);
            }

            return rutaChile;
        }

        private string ObtenerUrlChileEncriptada()
        {
            var parametro = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;
            var urlChile = Util.EncriptarQueryString(parametro);
            return urlChile;
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
            bool paisesCatalogoWhatsUp = _configuracionManagerProvider.GetConfiguracionManagerContains(Constantes.ConfiguracionManager.PaisesCatalogoWhatsUp, userData.CodigoISO);
            
            return paisesCatalogoWhatsUp.ToInt();
        }

        private string ObtenerNombreConsultoraFav()
        {
            var nombreConsultoraFav = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            nombreConsultoraFav = Util.SubStr(nombreConsultoraFav, 0, 1).ToUpper() + Util.SubStr(nombreConsultoraFav.ToLower(), 1);
            return nombreConsultoraFav;
        }
        
        [HttpPost]
        public JsonResult ValidacionConsultoraDA()
        {
            bool validar = false;
            string mensajeFechaDa = null;

            if (userData.EsquemaDAConsultora && userData.EsZonaDemAnti == 1)
            {
                BEConfiguracionConsultoraDA configuracionConsultoraDa = new BEConfiguracionConsultoraDA
                {
                    CampaniaID = Convert.ToString(userData.CampaniaID),
                    ConsultoraID = Convert.ToInt32(userData.ConsultoraID),
                    ZonaID = userData.ZonaID
                };

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var consultoraDa = sv.GetConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDa);
                    if (consultoraDa == 0)
                    {
                        BECronograma cronograma = sv.GetCronogramaByCampaniaAnticipado(userData.PaisID, userData.CampaniaID, userData.ZonaID, 2).FirstOrDefault();
                        if (cronograma != null && cronograma.FechaInicioWeb != null)
                        {
                            DateTime fechaDa = ((DateTime)cronograma.FechaInicioWeb) + userData.HoraCierreZonaDemAntiCierre;
                            mensajeFechaDa = fechaDa.ToString(@"dddd dd \de MMMM (hh:mm tt)");
                        }

                        validar = true;
                    }
                }

            }

            return Json(new { success = validar, mensajeFechaDA = mensajeFechaDa });
        }

        public ActionResult ActualizarContrasenia()
        {
            ViewBag.NombreConsultora = ObtenerNombreConsultora();
            return View();
        }

        /// <summary>
        /// Obtiene la URL para el chat que se mostrara dependiendo del pais.
        /// </summary>
        /// <returns>URL: chat relacionado al pais</returns>
        public ActionResult ChatBelcorp()
        {
            string url = "";
            if (_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesBelcorpChatEMTELCO).Contains(userData.CodigoISO))
            {
                url = String.Format(
                    _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlBelcorpChat),
                    userData.SegmentoAbreviatura.Trim(),
                    userData.CodigoUsuario.Trim(),
                    userData.PrimerNombre.Split(' ').First().Trim(),
                    userData.EMail.Trim(), userData.CodigoISO.Trim()
                );
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
            SessionManager.SetUserData(userData);
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
                var lstComunicados = _comunicadoProvider.ObtenerComunicadoPorConsultora(userData, EsDispositivoMovil());
                lstComunicados = lstComunicados.Where(x => Constantes.Comunicado.Extraordinarios.IndexOf(x.Descripcion) == -1).ToList();
                if (lstComunicados != null) oComunicados = lstComunicados.FirstOrDefault();

                return Json(new
                {
                    success = true,
                    message = string.Empty,
                    data = oComunicados
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

        public JsonResult AceptarContrato(bool checkAceptar, string origenAceptacion)
        {
            try
            {
                if (!checkAceptar)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Debe marcar la aceptación del contrato.",
                        extra = ""
                    });
                }

                using (var svr = new UsuarioServiceClient())
                {
                    svr.AceptarContratoAceptacion(userData.PaisID, userData.ConsultoraID, userData.CodigoConsultora, origenAceptacion, null, null, null, null);
                }

                userData.IndicadorContrato = 1;

                var cadena = "<br /><br /> Por la presente se le comunica que usted ha indicado estar de acuerdo con el contrato. Se adjunta una copia del contrato firmado.";

                var correoDestino = string.Empty;
                if (userData.EMail.Length > 0)
                {
                    correoDestino = userData.EMail;
                }

                var filePath = Server.MapPath("~/Content/FAQ/Contrato_CO.pdf");
                var indicadorEnvio = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.indicadorContrato);
                if (indicadorEnvio == "1")
                {
                    try
                    {
                        Util.EnviarMail3("no-responder@somosbelcorp.com", correoDestino, "Usted ha firmado el contrato con SomosBelcorp", cadena, true, string.Empty, filePath, userData.NombreConsultora);
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                        return Json(new
                        {
                            success = false,
                            message = "Se acepto el contrato pero no se pudo enviar correo electrónico.",
                            extra = "nocorreo"
                        });
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se Acepto la contrata",
                    extra = ""
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public string ObtenerActualizacionEmail()
        {
            return _bienvenidaProvider.ObtenerActualizacionEmail();
        }

        [HttpGet]
        public JsonResult OcultarBannerApp()
        {
            try
            {
                SessionManager.SetOcultarBannerApp(true);

                return Json(new
                {
                    success = true,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }
        
    }
}