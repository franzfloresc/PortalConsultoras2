using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BienvenidaController : BaseController
    {
        private readonly ConfiguracionPaisDatosProvider _configuracionPaisDatosProvider;
        private readonly BienvenidaProvider _bienvenidaProvider;
        protected TablaLogicaProvider _tablaLogica;
        private readonly ZonificacionProvider _zonificacionProvider;
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;

        public BienvenidaController()
        {
            _configuracionPaisDatosProvider = new ConfiguracionPaisDatosProvider();
            _tablaLogica = new TablaLogicaProvider();
            _bienvenidaProvider = new BienvenidaProvider();
            _zonificacionProvider = new ZonificacionProvider();
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
        }

        public BienvenidaController(ILogManager logManager)
        {
            this.logManager = logManager;
        }

        public ActionResult Index(bool showPopupMisDatos = false, string verSeccion = "", string verCambioClave = "")
        {
            var model = new BienvenidaHomeModel { ShowPopupMisDatos = showPopupMisDatos, OpcionCambiaClave = verCambioClave };

            if (userData.RolID != Constantes.Rol.Consultora)
                if (userData.RolID == 0)
                    return RedirectToAction("LogOut", "Login");
                else
                    return View("IndexSAC", model);

            try
            {

                model.PartialSectionBpt = _configuracionPaisDatosProvider.GetPartialSectionBptModel(Constantes.SectionBpt.SectionBptDesktopHome);
                ViewBag.UrlImgMiAcademia = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlImgMiAcademia) + "/" + userData.CodigoISO + "/academia.png";
                ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.rutaImagenNotFoundAppCatalogo);
                ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);
                ViewBag.UrlImagenFAVHome = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlImagenFAVHome), userData.CodigoISO);

                #region Montos
                var bePedidoWeb = ObtenerPedidoWeb();
                if (bePedidoWeb != null)
                {
                    model.MontoAhorroCatalogo = bePedidoWeb.MontoAhorroCatalogo;
                    model.MontoAhorroRevista = bePedidoWeb.MontoAhorroRevista;
                }

                var bePedidoWebDetalle = ObtenerPedidoWebDetalle();
                if (bePedidoWebDetalle != null)
                {
                    model.MontoPedido = bePedidoWebDetalle.Sum(p => p.ImporteTotal);
                }

                #endregion

                var fechaVencimientoTemp = userData.FechaLimPago;
                model.FechaVencimiento = fechaVencimientoTemp.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : fechaVencimientoTemp.ToString("dd/MM/yyyy");
                model.MontoDeuda = userData.MontoDeuda;

                List<BETablaLogicaDatos> datGaBoton;
                List<BETablaLogicaDatos> configCarouselLiquidacion;

                _showRoomProvider.CargarEventoConsultora(userData);

                using (var sv = new SACServiceClient())
                {
                    datGaBoton = sv.GetTablaLogicaDatos(userData.PaisID, 50).ToList();
                    configCarouselLiquidacion = sv.GetTablaLogicaDatos(userData.PaisID, 87).ToList();
                }

                model.CatalogoPersonalizadoDesktop = userData.CatalogoPersonalizado;

                model.NombreCompleto = userData.NombreConsultora;
                model.EMail = userData.EMail;
                model.Telefono = userData.Telefono;
                model.TelefonoTrabajo = userData.TelefonoTrabajo;
                model.Celular = userData.Celular;
                model.NombreGerenteZonal = userData.NombreGerenteZonal;

                var carpetaPais = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.CarpetaImagenCompartirCatalogo) + userData.CodigoISO;
                var nombreImagenCatalogo = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.NombreImagenCompartirCatalogo);
                model.UrlImagenCompartirCatalogo = ConfigCdn.GetUrlFileCdn(carpetaPais, nombreImagenCatalogo);
                model.PrimeraVez = userData.CambioClave;
                model.Simbolo = userData.Simbolo;
                model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                ViewBag.NombreConsultoraFAV = Util.SubStr(model.NombreConsultora, 0, 1).ToUpper() + Util.SubStr(model.NombreConsultora.ToLower(), 1);
                var j = model.NombreConsultora.Trim().IndexOf(' ');
                if (j >= 0) model.NombreConsultora = model.NombreConsultora.Substring(0, j).Trim();

                model.PaisID = userData.PaisID;
                model.IndicadorContrato = userData.IndicadorContrato;
                model.CambioClave = userData.CambioClave;
                model.SobreNombre = string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre;
                model.SobreNombre = Util.Trim(model.SobreNombre).ToUpper();
                model.CodigoConsultora = userData.CodigoConsultora;
                model.CodigoUsuario = userData.CodigoUsuario;
                model.CampaniaActual = userData.CampaniaID;
                model.PrefijoPais = userData.CodigoISO;
                model.CampanaInvitada = userData.CampanaInvitada;
                model.InscritaFlexipago = userData.InscritaFlexipago;
                model.InvitacionRechazada = userData.InvitacionRechazada;
                model.IndicadorFlexipago = userData.IndicadorFlexiPago;
                model.CantProductosCarouselLiq = configCarouselLiquidacion.Count > 0 ? Convert.ToInt32(configCarouselLiquidacion[0].Codigo) : 1;
                model.BotonAnalytics = datGaBoton.Count > 0 ? datGaBoton[0].Descripcion : "";
                model.UrlFlexipagoCL = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.rutaFlexipagoCL);
                model.PopupInicialCerrado = userData.PopupBienvenidaCerrado;
                if (userData.CodigoISO == Constantes.CodigosISOPais.Chile || userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
                {
                    List<BETablaLogicaDatos> tabla;
                    using (var sac = new SACServiceClient())
                    {
                        tabla = sac.GetTablaLogicaDatos(userData.PaisID, 60).ToList();
                    }

                    model.NroCampana = (tabla.FirstOrDefault(x => x.TablaLogicaDatosID == 6001) ?? new BETablaLogicaDatos()).Codigo;

                    model.rutaChile = userData.CodigoISO == Constantes.CodigosISOPais.Chile ? _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPagoLineaChile) : string.Empty;
                }
                else
                {
                    model.NroCampana = "2";
                    model.rutaChile = string.Empty;
                }

                var nombreArchivoContrato = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.Contrato_ActualizarDatos + userData.CodigoISO);
                model.ContratoActualizarDatos = nombreArchivoContrato;

                var parametro = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;
                var urlChile = Util.EncriptarQueryString(parametro);
                model.UrlChileEncriptada = urlChile;

                if (SessionManager.GetPrimeraVezSession() != null && (int)SessionManager.GetPrimeraVezSession() == 0)
                {
                    model.PrimeraVezSession = 0;
                    SessionManager.SetPrimeraVezSession(null);
                }
                else
                {
                    model.PrimeraVezSession = 1;
                }

                model.ValidaSuenioNavidad = ValidarSuenioNavidad();

                if (userData.CodigoISO == Constantes.CodigosISOPais.Mexico)
                {
                    model.ValidaSegmento = ValidarSegmento();
                    model.ValidaTiempoVentana = ValidarTiempo();
                    model.ValidaDatosActualizados = ValidaDatosActualizados();
                    model.m_Apellidos = userData.PrimerApellido;
                    model.m_Nombre = userData.PrimerNombre;
                }
                else
                {
                    model.ValidaSegmento = 0;
                    model.ValidaTiempoVentana = 0;
                    model.ValidaDatosActualizados = 0;
                }

                model.ImagenUsuario = ConfigCdn.GetUrlFileCdn("ConsultoraImagen", userData.CodigoISO + "-" + userData.CodigoConsultora + ".png");

                model.VisualizoComunicado = 1;
                model.VisualizoComunicadoConfigurable = 1;

                model.EsCatalogoPersonalizadoZonaValida = userData.EsCatalogoPersonalizadoZonaValida;
                model.VioTutorialSalvavidas = userData.VioTutorialSalvavidas;
                model.DataBarra = GetDataBarra();

                model.VioVideoBienvenidaModel = userData.VioVideoModelo;
                model.VioTutorialDesktop = userData.VioTutorialDesktop;

                #region limite Min - Max Telef
                int limiteMinimoTelef, limiteMaximoTelef;
                Util.GetLimitNumberPhone(userData.PaisID, out limiteMinimoTelef, out limiteMaximoTelef);
                model.limiteMinimoTelef = limiteMinimoTelef;
                model.limiteMaximoTelef = limiteMaximoTelef;
                #endregion

                #region Lógica de Popups

                ValidaPopUpPaisModel popUpPaisModel = new ValidaPopUpPaisModel()
                {
                    ShowPopupMisDatos = model.ShowPopupMisDatos,
                    ValidaDatosActualizados = model.ValidaDatosActualizados,
                    ValidaSegmento = model.ValidaSegmento,
                    ValidaTiempoVentana = model.ValidaTiempoVentana
                };

                model.TipoPopUpMostrar = _bienvenidaProvider.ObtenerTipoPopUpMostrar(EsDispositivoMovil(), popUpPaisModel);
                if (model.TipoPopUpMostrar == Constantes.TipoPopUp.VideoIntroductorio
                    && (userData.VioTutorialDesktop == 0) && (userData.VioTutorialSalvavidas == 0))
                {
                    ViewBag.MostrarUbicacionTutorial = 0;
                }

                model.TieneFacturacionElectronica = GetDatosFacturacionElectronica(userData.PaisID, Constantes.FacturacionElectronica.TablaLogicaID, Constantes.FacturacionElectronica.FlagActivacion) == "1";

                #endregion

                model.ShowRoomMostrarLista = (!ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado)).ToInt();
                model.ShowRoomBannerUrl = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.BannerLateralBienvenida, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                model.TieneCupon = userData.TieneCupon;
                model.TieneMasVendidos = userData.TieneMasVendidos;
                model.EMail = userData.EMail;
                model.Celular = userData.Celular;
                model.EmailActivo = userData.EMailActivo;
                ViewBag.Ambiente = _configuracionManagerProvider.GetBucketNameFromConfig();
                TempData.Keep("MostrarPopupCuponGanaste");

                ViewBag.FechaInicioCampania = userData.FechaInicioCampania;
                ViewBag.VerSeccion = verSeccion;

                model.TienePagoEnLinea = userData.TienePagoEnLinea;
                model.MostrarPagoEnLinea = (userData.MontoDeuda > 0);

                #region Camino Brillante
                if (userData.CaminoBrillante) {
                    model.TieneCaminoBrillante = userData.CaminoBrillante;

                    _caminoBrillanteProvider.LoadCaminoBrillante();
                    var nivelConsultoraCaminoBrillante = _caminoBrillanteProvider.GetNivelActual();
                    if (nivelConsultoraCaminoBrillante != null)
                    {
                        model.CaminoBrillanteMsg = userData.CaminoBrillanteMsg.Replace("{0}", "<b>" + nivelConsultoraCaminoBrillante.DescripcionNivel + "</b>");
                        model.UrlLogoCaminoBrillante = nivelConsultoraCaminoBrillante.UrlImagenNivelFull;                        
                    }
                }
                #endregion

                #region Camino al Éxito
                var LogicaCaminoExisto = _tablaLogica.GetTablaLogicaDatos(userData.PaisID, ConsTablaLogica.CaminoAlExitoDesktop.TablaLogicaId);
                if (LogicaCaminoExisto.Any())
                {
                    var CaminoExistoFirst = LogicaCaminoExisto.FirstOrDefault(x => x.TablaLogicaDatosID == ConsTablaLogica.CaminoAlExitoDesktop.ActualizaEscalaDescuentoDesktop) ?? new TablaLogicaDatosModel();
                    bool caminiExitoActive = (CaminoExistoFirst != null && CaminoExistoFirst.Valor != null) && CaminoExistoFirst.Valor.Equals("1");
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            if (userData == null || userData.RolID <= 0)
            {
                LogManager.LogManager.LogErrorWebServicesBus(new Exception(), "", "", "Consultora null");
                return RedirectToAction("LogOut", "Login");
            }

            if (userData.RolID == Constantes.Rol.Consultora)
            {
                return View("Index", model);
            }

            return View("IndexSAC", model);
        }

        public ActionResult IndexVC()
        {
            try
            {
                if (SessionManager.GetTipoPopUpMostrar() != -1)
                {
                    var tipoPopup = Convert.ToInt32(SessionManager.GetTipoPopUpMostrar());
                    if (tipoPopup == Constantes.TipoPopUp.AsesoraOnline)
                    {
                        SessionManager.SetTipoPopUpMostrar(Constantes.TipoPopUp.Ninguno);
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            if (Request.Browser.IsMobileDevice) return RedirectToAction("Index", "MisDatos", new { area = "Mobile", vc = true });
            return RedirectToAction("Index", new { showPopupMisDatos = true });
        }

        public void CerrarPopupInicial()
        {
            try
            {
                userData.PopupBienvenidaCerrado = true;
                SessionManager.SetUserData(userData);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        public JsonResult AceptarContrato(bool checkAceptar, string origenAceptacion, string AppVersion)
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

                string ip = null;
                if (!Request.Browser.IsMobileDevice)
                {
                    ip = GetIPCliente();
                    ip = string.IsNullOrEmpty(ip) ? "" : ip;
                    AppVersion = null;
                }

                using (var svr = new UsuarioServiceClient())
                {
                    svr.AceptarContratoAceptacion(userData.PaisID, userData.ConsultoraID, userData.CodigoConsultora, origenAceptacion, ip, AppVersion, null, null);
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

                SessionManager.SetAceptoContrato(true);

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

        public JsonResult AceptarComunicado()
        {
            try
            {
                using (var sac = new SACServiceClient())
                {
                    sac.UpdComunicadoByConsultora(userData.PaisID, userData.CodigoConsultora);
                }
                return Json(new
                {
                    success = true,
                    message = "",
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

        public ActionResult RedireccionarFlexipago()
        {
            var pp = userData.CodigoISO;
            string urlRedirect;
            if (pp == Constantes.CodigosISOPais.Chile)
            {
                urlRedirect = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.rutaFlexipagoCL) + "/index.html";
            }
            else
            {
                urlRedirect = "http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/index.html";
            }

            urlRedirect = urlRedirect + "?PP=" + pp + "&CC=" + userData.CodigoConsultora + "&CA=" + userData.CampaniaID.ToString();

            return Redirect(urlRedirect);
        }

        public ActionResult RechazarInvitacionFlex()
        {
            var cc = userData.CodigoConsultora;
            var ca = userData.CampaniaID;
            var pp = userData.CodigoISO;
            var urlRedirect = "http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/index.html?PP=" + pp + "&CC=" + cc + "&CA=" + ca.ToString();
            return Redirect(urlRedirect);
        }

        [HttpGet]
        public JsonResult JSONGetMisDatos()
        {
            ServiceUsuario.BEUsuario beusuario;
            var model = new MisDatosModel();

            using (var sv = new UsuarioServiceClient())
            {
                beusuario = sv.Select(userData.PaisID, userData.CodigoUsuario);
            }

            if (beusuario != null)
            {
                model.PaisISO = userData.CodigoISO;

                model.NombreCompleto = beusuario.Nombre;
                model.NombreGerenteZonal = userData.NombreGerenteZonal;
                model.EMail = beusuario.EMail;
                model.NombreGerenteZonal = userData.NombreGerenteZonal;
                model.Telefono = beusuario.Telefono;
                model.TelefonoTrabajo = beusuario.TelefonoTrabajo;
                model.Celular = beusuario.Celular;
                model.Sobrenombre = beusuario.Sobrenombre;
                model.CompartirDatos = beusuario.CompartirDatos;
                model.AceptoContrato = beusuario.AceptoContrato;
                model.UsuarioPrueba = userData.UsuarioPrueba;
                model.NombreArchivoContrato = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.Contrato_ActualizarDatos + userData.CodigoISO);
                model.IndicadorConsultoraDigital = beusuario.IndicadorConsultoraDigital;

                var bezona = _zonificacionProvider.GetZonaById(userData.PaisID, userData.ZonaID);

                model.NombreGerenteZonal = bezona.NombreGerenteZona;

                if (beusuario.EMailActivo) model.CorreoAlerta = "";
                if (!beusuario.EMailActivo && beusuario.EMail != "") model.CorreoAlerta = "Su correo aun no ha sido activado";

                if (model.UsuarioPrueba == 1)
                {
                    using (var sv = new SACServiceClient())
                    {
                        model.NombreConsultoraAsociada = sv.GetNombreConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + " (" + sv.GetCodigoConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + ")";
                    }
                }

                model.DigitoVerificador = string.Empty;
                model.CodigoUsuario = userData.CodigoUsuario;
                model.Zona = userData.CodigoZona;

                var paisesDigitoControl = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesDigitoControl);
                if (paisesDigitoControl.Contains(model.PaisISO)
                    && !String.IsNullOrEmpty(beusuario.DigitoVerificador))
                {
                    model.CodigoUsuario = string.Format("{0} - {1} (Zona:{2})", userData.CodigoUsuario, beusuario.DigitoVerificador, userData.CodigoZona);
                }
                model.CodigoUsuarioReal = userData.CodigoUsuario;
            }
            return Json(new
            {
                lista = model
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult JSONUpdateUsuarioTutoriales(string tipo)
        {
            var retorno = 0;
            try
            {
                if (!string.IsNullOrEmpty(tipo))
                {
                    var tipoTutorial = Convert.ToInt32(tipo);

                    using (var sv = new UsuarioServiceClient())
                    {
                        retorno = sv.UpdateUsuarioTutoriales(userData.PaisID, userData.CodigoUsuario, tipoTutorial);
                    }

                    switch (tipoTutorial)
                    {
                        case Constantes.TipoTutorial.Video:
                            userData.VioVideoModelo = retorno;
                            break;
                        case Constantes.TipoTutorial.Desktop:
                            userData.VioTutorialDesktop = retorno;
                            break;
                        case Constantes.TipoTutorial.Salvavidas:
                            userData.VioTutorialSalvavidas = retorno;
                            break;
                        case Constantes.TipoTutorial.Mobile:
                            userData.VioTutorialModelo = retorno;
                            break;
                    }

                    SessionManager.SetUserData(userData);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return Json(new
            {
                result = retorno
            }, JsonRequestBehavior.AllowGet);
        }        

        private int ValidarTiempo()
        {
            int validacion;

            using (var sv = new UsuarioServiceClient())
            {
                validacion = sv.SelectTiempo(userData.PaisID);
            }
            return validacion;
        }

        private int ValidarSegmento()
        {
            int validacion;

            using (var sv = new UsuarioServiceClient())
            {
                validacion = sv.SelectSegmento(userData.PaisID, userData.SegmentoID);
            }
            return validacion;
        }

        private int ValidaDatosActualizados()
        {
            int validacion;

            using (var sv = new UsuarioServiceClient())
            {
                validacion = sv.SelectDatosActualizados(userData.PaisID, userData.CodigoUsuario);
            }
            return validacion;
        }

        #region Suenios Navidad

        public ActionResult ReporteSueniosNavidad()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Bienvenida/ReporteSueniosNavidad"))
                return RedirectToAction("Index", "Bienvenida");

            var parametrizarCuvModel = new ParametrizarCUVModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaZonas = new List<ZonaModel>(),
                listaPaises = _zonificacionProvider.GetPaises(userData.PaisID, userData.RolID)
            };

            return View(parametrizarCuvModel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID, string Consulta, string CodigoConsultora)
        {
            if (ModelState.IsValid)
            {
                List<BESuenioNavidad> lst;

                if (Consulta == "1")
                {
                    var entidad = new BESuenioNavidad
                    {
                        PaisID = userData.PaisID,
                        CampaniaID = Convert.ToInt32(CampaniaID),
                        CodigoConsultora = CodigoConsultora
                    };

                    using (var sv = new PedidoServiceClient())
                    {
                        lst = sv.ListarSuenioNavidad(entidad).ToList();
                    }
                }
                else
                {
                    lst = new List<BESuenioNavidad>();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BESuenioNavidad> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderBy(x => x.CampaniaID);
                            break;

                        case "Region":
                            items = lst.OrderBy(x => x.Region);
                            break;

                        case "Zona":
                            items = lst.OrderBy(x => x.Zona);
                            break;

                        case "Seccion":
                            items = lst.OrderBy(x => x.Seccion);
                            break;

                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;

                        case "Canal":
                            items = lst.OrderBy(x => x.Canal);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderByDescending(x => x.CampaniaID);
                            break;

                        case "Region":
                            items = lst.OrderByDescending(x => x.Region);
                            break;

                        case "Zona":
                            items = lst.OrderByDescending(x => x.Zona);
                            break;

                        case "Seccion":
                            items = lst.OrderByDescending(x => x.Seccion);
                            break;

                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultora);
                            break;

                        case "Canal":
                            items = lst.OrderByDescending(x => x.Canal);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               a.CampaniaID,
                               cell = new string[]
                               {
                                   a.CampaniaID.ToString(),
                                   a.Region,
                                   a.Zona,
                                   a.Seccion,
                                   a.CodigoConsultora,
                                   a.NombreCompleto,
                                   QuitarSaltos(a.Descripcion).Length > 100 ? QuitarSaltos(a.Descripcion).Substring(0, 100) : QuitarSaltos(a.Descripcion),
                                   QuitarSaltos(a.Descripcion),
                                   a.Canal
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ReporteSueniosNavidad", "Bienvenida");
        }

        public ActionResult ExportarExcelSueniosNavidad(int campaniaID, string codigoConsultora)
        {
            List<BESuenioNavidad> lst;
            var entidad = new BESuenioNavidad
            {
                PaisID = userData.PaisID,
                CampaniaID = campaniaID,
                CodigoConsultora = codigoConsultora
            };

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.ListarSuenioNavidad(entidad).ToList();
            }

            var dic = new Dictionary<string, string>
            {
                {"Campaña", "CampaniaID"},
                {"Región", "Region"},
                {"Zona", "Zona"},
                {"Sección", "Seccion"},
                {"Código de Consultora", "CodigoConsultora"},
                {"Nombre y Apellidos", "NombreCompleto"},
                {"Descripción del sueño", "Descripcion"},
                {"Canal", "Canal"}
            };

            Util.ExportToExcel("SueniosDeNavidad", lst, dic, GetExcelSecureCallback());
            return View();
        }

        public JsonResult RegistrarSuenioNavidad(string descripcion)
        {
            try
            {
                var entidad = new BESuenioNavidad
                {
                    PaisID = userData.PaisID,
                    CampaniaID = userData.CampaniaID,
                    ConsultoraID = Convert.ToInt32(userData.ConsultoraID),
                    Descripcion = descripcion,
                    Canal = "C",
                    UsuarioCreacion = userData.CodigoUsuario
                };

                using (var svc = new PedidoServiceClient())
                {
                    svc.RegistrarSuenioNavidad(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se registró el sueño de manera correcta.",
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

        private int ValidarSuenioNavidad()
        {
            var entidad = new BESuenioNavidad
            {
                PaisID = userData.PaisID,
                ConsultoraID = Convert.ToInt32(userData.ConsultoraID),
                CampaniaID = userData.CampaniaID
            };

            if (entidad.ConsultoraID == 0)
                return 1;

            int validacion;
            if (SessionManager.GetSuenioNavidad() == -1)
            {
                using (var svc = new PedidoServiceClient())
                {
                    validacion = svc.ValidarSuenioNavidad(entidad);
                }
                SessionManager.SetSuenioNavidad(validacion);
            }
            else
            {
                validacion = 1;
            }

            return validacion;
        }

        public string QuitarSaltos(string valor)
        {
            return valor.Replace("\n", string.Empty).Replace("\"", string.Empty);
        }

        #endregion

        #region ShowRoom

        #region Administrador de Actualización de datos HD-3680 : P.S.O
        public ActionResult ReporteValidacionDatos()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Bienvenida/ReporteSueniosNavidad"))
                return RedirectToAction("Index", "Bienvenida");

            var parametrizarCuvModel = new ParametrizarCUVModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaZonas = new List<ZonaModel>(),
                listaPaises = _zonificacionProvider.GetPaises(userData.PaisID, userData.RolID)
            };

            return View(parametrizarCuvModel);
        }

        public ActionResult ConsultarValidacionDatos(string sidx, string sord, int page, int rows, string PaisID, string FechaInicio, string FechaFin, string TipoEnvio, string CodigoConsultora, string Consulta)
        {
            if (ModelState.IsValid)
            {
                List<BEValidacionDatos> lst;

                if (Consulta == "1")
                {
                    var beValidacionDatos = new BEValidacionDatos
                    {
                        PaisID = Convert.ToInt32(PaisID),
                        FechaInicio = FechaInicio,
                        FechaFin = FechaFin,
                        TipoEnvio = TipoEnvio,
                        CodigoUsuario = CodigoConsultora
                    };

                    using (var sv = new UsuarioServiceClient())
                    {
                        lst = sv.ListarValidacionDatos(beValidacionDatos).ToList();
                    }
                }
                else
                {
                    lst = new List<BEValidacionDatos>();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEValidacionDatos> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "TipoEnvio":
                            items = lst.OrderBy(x => x.TipoEnvio);
                            break;

                        case "DatoAntiguo":
                            items = lst.OrderBy(x => x.DatoAntiguo);
                            break;

                        case "DatoNuevo":
                            items = lst.OrderBy(x => x.DatoNuevo);
                            break;

                        case "Estado":
                            items = lst.OrderBy(x => x.Estado);
                            break;

                        case "CodigoUsuario":
                            items = lst.OrderBy(x => x.CodigoUsuario);
                            break;

                        case "FechaCreacion":
                            items = lst.OrderBy(x => x.FechaCreacion);
                            break;

                        case "FechaModificacion":
                            items = lst.OrderBy(x => x.FechaModificacion);
                            break;

                        case "IpDispositivo":
                            items = lst.OrderBy(x => x.IpDispositivo);
                            break;


                        case "DescripcionDispositivo":
                            items = lst.OrderBy(x => x.DescripcionDispositivo);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "TipoEnvio":
                            items = lst.OrderByDescending(x => x.TipoEnvio);
                            break;

                        case "DatoAntiguo":
                            items = lst.OrderByDescending(x => x.DatoAntiguo);
                            break;

                        case "DatoNuevo":
                            items = lst.OrderByDescending(x => x.DatoNuevo);
                            break;

                        case "Estado":
                            items = lst.OrderByDescending(x => x.Estado);
                            break;

                        case "CodigoUsuario":
                            items = lst.OrderByDescending(x => x.CodigoUsuario);
                            break;

                        case "FechaCreacion":
                            items = lst.OrderByDescending(x => x.FechaCreacion);
                            break;

                        case "FechaModificacion":
                            items = lst.OrderByDescending(x => x.FechaModificacion);
                            break;

                        case "IpDispositivo":
                            items = lst.OrderBy(x => x.IpDispositivo);
                            break;


                        case "DescripcionDispositivo":
                            items = lst.OrderBy(x => x.DescripcionDispositivo);
                            break;
                    }
                }
                #endregion


                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               a.ValidacionId,
                               cell = new string[]
                               {
                                   a.TipoEnvio.ToString(),
                                   a.DatoAntiguo,
                                   a.DatoNuevo,
                                   a.Estado,
                                   a.CodigoUsuario,
                                   a.FechaCreacion.ToString(),
                                   a.FechaModificacion.ToString(),
                                   a.IpDispositivo.ToString(),
                                   a.DescripcionDispositivo.ToString(),
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ReporteSueniosNavidad", "Bienvenida");

        }

        public ActionResult ExportarExcelValidacionDatos(string PaisID, string FechaInicio, string FechaFin, string TipoEnvio, string CodigoConsultora)
        {
            List<BEValidacionDatos> lst;
            var beValidacionDatos = new BEValidacionDatos
            {
                PaisID = Convert.ToInt32(PaisID),
                FechaInicio = FechaInicio,
                FechaFin = FechaFin,
                TipoEnvio = TipoEnvio,
                CodigoUsuario = CodigoConsultora
            };

            using (var sv = new UsuarioServiceClient())
            {
                lst = sv.ListarValidacionDatos(beValidacionDatos).ToList();
            }


            var dic = new Dictionary<string, string>
            {
                {"Tipo de Envìo", "TipoEnvio"},
                {"Dato Antiguo", "DatoAntiguo"},
                {"Dato Nuevo", "DatoNuevo"},
                {"Estado", "Estado"},
                {"Codigo de Usuario", "CodigoUsuario"},
                {"Fecha de Creacion", "FechaCreacion"},
                {"Fecha de Modificacion", "FechaModificacion"},
                {"Ip del dispositivo", "IpDispositivo"},
                {"Dispositivo", "DescripcionDispositivo"}
            };

            Util.ExportToExcel("ValidacionDatos", lst, dic, GetExcelSecureCallback());
            return View();
        }
        #endregion

        [HttpPost]
        public JsonResult NoMostrarShowRoomPopup(string TipoShowRoom)
        {
            try
            {
                _showRoomProvider.CargarEventoConsultora(userData);
                _showRoomProvider.CargarEventoPersonalizacion(userData);
                configEstrategiaSR = SessionManager.GetEstrategiaSR();
                var entidad = new BEShowRoomEventoConsultora
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    CampaniaID = userData.CampaniaID,
                    EventoID = configEstrategiaSR.BeShowRoom.EventoID,
                    EventoConsultoraID = configEstrategiaSR.BeShowRoomConsultora.EventoConsultoraID,
                };

                _showRoomProvider.ActualizarEventoConsultora(entidad, TipoShowRoom);

                if (TipoShowRoom == "I")
                {
                    configEstrategiaSR.BeShowRoomConsultora.MostrarPopup = false;
                }

                if (TipoShowRoom == "V")
                {
                    configEstrategiaSR.BeShowRoomConsultora.MostrarPopupVenta = false;
                }

                return Json(new
                {
                    success = true,
                    message = "",
                    extra = "",
                    tipo = TipoShowRoom
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

        [HttpPost]
        public JsonResult MostrarShowRoomPopup()
        {
            try
            {
                const int SHOWROOM_ESTADO_INACTIVO = 0;
                const string TIPO_APLICACION_DESKTOP = "Desktop";

                if (!_showRoomProvider.PaisTieneShowRoom(userData.CodigoISO))
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomConsultora encontrada"
                    });

                }

                ShowRoomEventoModel showRoom = null;

                configEstrategiaSR = SessionManager.GetEstrategiaSR();
                showRoom = configEstrategiaSR.BeShowRoom;

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var showRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
                var mostrarPopupIntriga = showRoomConsultora.MostrarPopup;
                var mostrarPopupVenta = showRoomConsultora.MostrarPopupVenta;

                if (!mostrarPopupIntriga && !mostrarPopupVenta)
                {
                    return Json(new
                    {
                        success = false
                    });
                }

                var mostrarShowRoomProductos = SessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = SessionManager.GetMostrarShowRoomProductosExpiro();

                mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
                mostrarPopupVenta = mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

                var rutaShowRoomPopup = string.Empty;
                if (mostrarShowRoomProductos)
                {
                    rutaShowRoomPopup = Url.Action("Index", "ShowRoom");
                }

                List<ShowRoomPersonalizacionModel> lstPersonalizacion;
                if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
                {
                    lstPersonalizacion = new List<ShowRoomPersonalizacionModel>();
                }
                else
                {
                    lstPersonalizacion = configEstrategiaSR.ListaPersonalizacionConsultora.Where(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP).ToList();
                }


                return Json(new
                {
                    success = true,
                    data = showRoomConsultora,
                    diaInicio = userData.FechaInicioCampania.AddDays(-showRoom.DiasAntes).Day,
                    diaFin = userData.FechaInicioCampania.Day,
                    mesFin = Util.NombreMes(userData.FechaInicioCampania.Month),
                    diasFaltan = (userData.FechaInicioCampania.AddDays(-showRoom.DiasAntes) - DateTime.Now.AddHours(userData.ZonaHoraria).Date).Days,
                    nombre = string.IsNullOrEmpty(userData.Sobrenombre)
                        ? userData.NombreConsultora
                        : userData.Sobrenombre,
                    message = "ShowRoomConsultora encontrada",
                    evento = showRoom,
                    mostrarShowRoomProductos,
                    rutaShowRoomPopup,
                    personalizacion = lstPersonalizacion,
                    mostrarPopupIntriga,
                    mostrarPopupVenta
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
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult MostrarShowRoomBannerLateral()
        {
            try
            {
                var model = _showRoomProvider.GetShowRoomBannerLateral(userData.CodigoISO, userData.ZonaHoraria, userData.FechaInicioCampania);
                if (model.ConsultoraNoEncontrada)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomConsultora no encontrada"
                    });
                }
                if (model.EventoNoEncontrado)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                return Json(new
                {
                    success = true,
                    data = model.BEShowRoomConsultora,
                    message = "ShowRoomConsultora encontrada",
                    diasFaltantes = model.DiasFaltantes,
                    mesFaltante = model.MesFaltante,
                    anioFaltante = model.AnioFaltante,
                    evento = model.BEShowRoom,
                    mostrarShowRoomProductos = model.MostrarShowRoomProductos,
                    rutaShowRoomBannerLateral = "",
                    estaActivoLateral = model.EstaActivoLateral
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
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        [HttpPost]
        public JsonResult CerrarMensajeEstadoPedido()
        {
            userData.CerrarRechazado = 1;
            SessionManager.SetUserData(userData);
            return Json(userData.CerrarRechazado);
        }

        [HttpPost]
        public JsonResult CerrarMensajePostulante()
        {
            try
            {
                userData.CerrarBannerPostulante = 1;
                SessionManager.SetUserData(userData);
                return Json(new
                {
                    success = true
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error al procesar la solicitud"
                });
            }
        }

        public JsonResult ObtenerComunicadosPopUps()
        {
            var comunicadoVisualizado = 0;
            var comunicado = new BEComunicado();

            var tempComunicados = _comunicadoProvider.ObtenerComunicadoPorConsultora(userData, EsDispositivoMovil());

            if (tempComunicados != null && tempComunicados.Count > 0)
            {
                comunicado = tempComunicados.FirstOrDefault(c => String.IsNullOrEmpty(c.CodigoCampania) || Convert.ToInt32(c.CodigoCampania) == userData.CampaniaID);

                if (comunicado != null)
                {
                    comunicadoVisualizado = 1;
                }
            }

            return Json(new
            {
                success = true,
                data = comunicado,
                codigoISO = userData.CodigoISO,
                codigoCampania = userData.CampaniaID,
                codigoConsultora = userData.CodigoConsultora,
                comunicadoVisualizado = comunicadoVisualizado,
                ipUsuario = userData.IPUsuario
            },
            JsonRequestBehavior.AllowGet);
        }

        public JsonResult ActualizarVisualizoComunicado(int ComunicadoId)
        {
            try
            {
                using (var sac = new SACServiceClient())
                {
                    sac.ActualizarVisualizoComunicado(userData.PaisID, userData.CodigoConsultora, ComunicadoId);
                }
                return Json(new
                {
                    success = true,
                    message = "",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema al actualizar que se visualizó el popup, intente nuevamente",
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

        public JsonResult AceptarComunicadoVisualizacion(int ComunicadoID)
        {
            try
            {
                using (var sac = new SACServiceClient())
                {
                    sac.InsertarComunicadoVisualizado(userData.PaisID, userData.CodigoConsultora, ComunicadoID);
                }
                return Json(new
                {
                    success = true,
                    message = "",
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

        public JsonResult RegistrarDonacionConsultora(string CodigoISO, string CodigoConsultora, string Campania, int ComunicadoID)
        {
            try
            {
                using (var sac = new SACServiceClient())
                {
                    sac.InsertarDonacionConsultora(userData.PaisID, CodigoISO, userData.CodigoConsultora, Campania, userData.IPUsuario);
                    sac.InsertarComunicadoVisualizado(userData.PaisID, userData.CodigoConsultora, ComunicadoID);
                }
                var mensaje = string.Format("¡Gracias por ayudar a la familia sika a reconstruir su vida! Tu donación será cargada a tu estado de cuenta de pedido de campaña {0}", Campania.Substring(4));

                return Json(new
                {
                    success = true,
                    message = mensaje
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

        public JsonResult ValidadTelefonoConsultora(string Telefono)
        {
            try
            {
                using (var svr = new UsuarioServiceClient())
                {
                    var cantidad = svr.ValidarTelefonoConsultora(userData.PaisID, Telefono, userData.CodigoUsuario);
                    if (cantidad > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al intentar validar el celular.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ActualizarContrasenia()
        {
            ViewBag.NombreConsultora = userData.PrimerNombre;
            return View();
        }

        /// <summary>
        /// Obtiene la URL para el chat que se mostrara dependiendo del pais.
        /// </summary>
        /// <returns>URL: chat relacionado al pais</returns>
        public ActionResult ChatBelcorp()
        {
            var url = "";
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
            return View();
        }

        public ActionResult MailConfirmacion(string tipo)
        {
            var area = Request.Browser.IsMobileDevice ? "Mobile" : "";
            var accion = "index";
            var controlador = "bienvenida";
            try
            {
                if (tipo == "sr")
                {
                    SessionManager.SetUserData(userData);
                    controlador = "ShowRoom";
                    accion = AccionControlador("sr", true);
                }
                else if (tipo == "cupon")
                {
                    EnviarCorreoActivacionCupon();
                    TempData["MostrarPopupCuponGanaste"] = true;
                    TempData["TipoPopup"] = Constantes.TipoPopUp.CuponForzado;
                }

                userData.EMailActivo = true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction(accion, controlador, new { area = area });
        }

        private string AccionControlador(string tipo, bool onlyAction = false, bool mobile = false)
        {
            string controlador = "", accion = "";
            try
            {
                tipo = Util.Trim(tipo).ToLower();
                switch (tipo)
                {
                    case "sr":
                        controlador = "ShowRoom";
                        var esVenta = (SessionManager.GetMostrarShowRoomProductos());
                        accion = esVenta ? "Index" : "Intriga";
                        break;
                }

                if (onlyAction) return accion;
                return (mobile ? "/Mobile/" : "") + controlador + (controlador == "" ? "" : "/") + accion;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return accion;
            }
        }

        private void EnviarCorreoActivacionCupon()
        {
            var url = Util.GetUrlHost(this.HttpContext.Request).ToString();
            var montoLimite = ObtenerMontoLimiteDelCupon();
            var cuponModel = ObtenerDatosCupon();
            var tipopais = _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO);
            var mailBody = MailUtilities.CuerpoCorreoActivacionCupon(userData.PrimerNombre, userData.CampaniaID.ToString(), userData.Simbolo, cuponModel.ValorAsociado, cuponModel.TipoCupon, url, montoLimite, tipopais);
            var correo = userData.EMail;
            Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", correo, "Activación de Cupón", mailBody, true, userData.NombreConsultora);
        }

        private CuponConsultoraModel ObtenerDatosCupon()
        {
            CuponConsultoraModel cuponModel;
            var cuponResult = _bienvenidaProvider.ObtenerCuponDesdeServicio();

            if (cuponResult != null)
                cuponModel = MapearBECuponACuponModel(cuponResult);
            else
                throw new ClientInformationException();

            return cuponModel;
        }

        private string ObtenerMontoLimiteDelCupon()
        {
            List<BETablaLogicaDatos> listSegmentos;
            using (var sv = new SACServiceClient())
            {
                listSegmentos = sv.GetTablaLogicaDatos(userData.PaisID, 103).ToList();
            }

            var descripcion = (listSegmentos.FirstOrDefault(x => x.Codigo == userData.CampaniaID.ToString()) ?? new BETablaLogicaDatos()).Descripcion;
            var montoLimite = (string.IsNullOrEmpty(descripcion) ? 0 : Convert.ToDecimal(descripcion));
            var montoLimiteFormateado = String.Format("{0:0.00}", montoLimite);

            return montoLimiteFormateado;
        }

        private CuponConsultoraModel MapearBECuponACuponModel(BECuponConsultora cuponBe)
        {
            var codigoIso = userData.CodigoISO;

            return new CuponConsultoraModel(codigoIso)
            {
                CuponConsultoraId = cuponBe.CuponConsultoraId,
                CodigoConsultora = cuponBe.CodigoConsultora,
                CampaniaId = cuponBe.CampaniaId,
                CuponId = cuponBe.CuponId,
                ValorAsociado = cuponBe.ValorAsociado,
                EstadoCupon = cuponBe.EstadoCupon,
                CorreoGanasteEnviado = cuponBe.EnvioCorreo,
                FechaCreacion = cuponBe.FechaCreacion,
                FechaModificacion = cuponBe.FechaModificacion,
                UsuarioCreacion = cuponBe.UsuarioCreacion,
                UsuarioModificacion = cuponBe.UsuarioModificacion,
                TipoCupon = cuponBe.TipoCupon
            };
        }

        #region "HD-3680 --- P.S.O"
        public JsonResult ObtenerActualizacionEmailSms(string pagina = "1")
        {
            string urlMuestraPopup = string.Empty;
            int paginaPopup = 1;
            int resultadoActivoPopup = 0;
            string[] ValidacionDatos = new string[2];
            try
            {
                BEMensajeToolTip obj;
                using (var sv = new UsuarioServiceClient())
                    obj = sv.GetActualizacionEmailySms(userData.PaisID, userData.CodigoUsuario);

                var tempComunicados = _comunicadoProvider.ObtenerSegmentacionInformativaPorConsultora(userData, EsDispositivoMovil());

                if (tempComunicados.Count > 0)
                {
                    using (var sv = new UsuarioServiceClient())
                        resultadoActivoPopup = sv.ValidaEstadoPopup(userData.PaisID);
                    if (Convert.ToInt32(pagina) == paginaPopup)
                    {
                        if (resultadoActivoPopup == 1)
                        {
                            ValidacionDatos = userData.PaisID == Convert.ToInt32(Constantes.PaisID.Peru) ? ValidacionPerfilConsultoraPeru(obj) : ValidacionPerfilConsultorOtrosPaises(obj);
                        }
                        else
                        {
                            ValidacionDatos = userData.PaisID == Convert.ToInt32(Constantes.PaisID.Peru) ? ValidacionPerfilConsultoraToolTip(obj, pagina) : ValidacionPerfilConsultorOtrosPaises(obj);
                        }
                    }
                    else
                        ValidacionDatos = ValidacionPerfilConsultoraToolTip(obj, pagina);

                    urlMuestraPopup = Url.Action("Index", "MiPerfil", EsDispositivoMovil() ? new { area="Mobile" } : new { area="" });

                    return Json(new { valor = ValidacionDatos[0], mensaje = ValidacionDatos[1], tipoMostrador = resultadoActivoPopup, urlDispositivo = urlMuestraPopup }, JsonRequestBehavior.AllowGet);
                }

                ValidacionDatos[0] = "0";
                ValidacionDatos[1] = string.Empty;
                return Json(new { valor = ValidacionDatos[0], mensaje = ValidacionDatos[1], tipoMostrador = resultadoActivoPopup, urlDispositivo = urlMuestraPopup }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ValidacionDatos[0] = "0";
                ValidacionDatos[1] = pagina == "1" ? "" : " | ";
                return Json(new { valor = ValidacionDatos[0], mensaje = ValidacionDatos[1].ToString() }, JsonRequestBehavior.AllowGet);
            }
        }

        public string[] ValidacionPerfilConsultoraToolTip(BEMensajeToolTip obj, string pagina)
        {
            string[] ValidacionDatos = new string[2];

            if (obj == null)
            {
                ValidacionDatos[0] = "0";
                ValidacionDatos[1] = pagina == "1" ? "" : "|";
                return ValidacionDatos;
            }
            if (obj.oDatosPerfil == null)
            {
                ValidacionDatos[0] = "0";
                ValidacionDatos[1] = pagina == "1" ? "" : "|";
                return ValidacionDatos;
            }

            string pendiente = string.Empty;
            string tieneMensajes = string.Empty;

            if (!string.IsNullOrEmpty(obj.MensajeCelular)) tieneMensajes = "1"; //1 => SMS; 2 => Email; 3 => Ambos
            if (!string.IsNullOrEmpty(obj.MensajeEmail)) tieneMensajes = tieneMensajes == "1" ? "3" : "2";

            string nuevoDatoCelular = !string.IsNullOrEmpty(obj.MensajeCelular) ? obj.oDatosPerfil.Where(a => a.TipoEnvio == "SMS" && a.Estado == "P").Select(b => b.DatoNuevo).FirstOrDefault() : "";
            string nuevoDatoEmail = !string.IsNullOrEmpty(obj.MensajeEmail) ? obj.oDatosPerfil.Where(a => a.TipoEnvio == "Email" && a.Estado == "P").Select(b => b.DatoNuevo).FirstOrDefault() : "";
            nuevoDatoCelular = nuevoDatoCelular ?? "";
            nuevoDatoEmail = nuevoDatoEmail ?? "";

            if (nuevoDatoCelular == "" && !obj.oDatosPerfil.Any(a => a.TipoEnvio == "SMS" && a.Estado == "A")) pendiente = "c";
            if (nuevoDatoEmail == "" && !obj.oDatosPerfil.Any(a => a.TipoEnvio == "Email" && a.Estado == "A")) pendiente = "e";

            bool menSms = pendiente == "c";
            if (!menSms) menSms = nuevoDatoCelular != "";
            bool menEmail = pendiente == "e";
            if (!menEmail) menEmail = nuevoDatoEmail != "";

            switch (tieneMensajes)
            {
                case "1":
                    if (obj.oDatosPerfil[0].TipoEnvio == "1")
                    {
                        ValidacionDatos[0] = "0";
                        ValidacionDatos[1] = pagina == "1" ? obj.MensajeCelular : nuevoDatoCelular + "|";
                        return ValidacionDatos;
                    }
                    if (menSms) {
                        ValidacionDatos[0] = "0";
                        ValidacionDatos[1] = pagina == "1" ? obj.MensajeCelular : nuevoDatoCelular + "|";
                        return ValidacionDatos;
                    }

                    ValidacionDatos[0] = "0";
                    ValidacionDatos[1] = pagina == "1" ? "" : "|";
                    return  ValidacionDatos;
                case "2":
                    if (obj.oDatosPerfil[0].TipoEnvio == "1")
                    {
                        ValidacionDatos[0] = "0";
                        ValidacionDatos[1] = pagina == "1" ? obj.MensajeEmail : "|" + nuevoDatoEmail;
                        return ValidacionDatos;
                    }
                    if (menEmail)
                    {
                        ValidacionDatos[0] = "0";
                        ValidacionDatos[1] = pagina == "1" ? obj.MensajeEmail : "|" + nuevoDatoEmail;
                        return ValidacionDatos;
                    }

                    ValidacionDatos[0] = "0";
                    ValidacionDatos[1] = pagina == "1" ? "" : "|";
                    return ValidacionDatos;
                case "3":
                    {
                        if (obj.oDatosPerfil[0].TipoEnvio == "1") { ValidacionDatos[0] = "0"; ValidacionDatos[1] = pagina == "1" ? obj.MensajeAmbos : "|"; return ValidacionDatos; }
                        if (menSms && !menEmail) { ValidacionDatos[0] = "0"; ValidacionDatos[1] = pagina == "1" ? obj.MensajeCelular : nuevoDatoCelular + "|"; return ValidacionDatos; }
                        if (!menSms && menEmail) { ValidacionDatos[0] = "0"; ValidacionDatos[1] = pagina == "1" ? obj.MensajeEmail : "|" + nuevoDatoEmail; return ValidacionDatos; }
                        if (menSms && menEmail) { ValidacionDatos[0] = "0"; ValidacionDatos[1] = pagina == "1" ? obj.MensajeAmbos : nuevoDatoCelular + "|" + nuevoDatoEmail; return ValidacionDatos; }
                        ValidacionDatos[0] = "0";
                        ValidacionDatos[1] = pagina == "1" ? "" : "|";
                        return ValidacionDatos;
                    }
            }
            ValidacionDatos[0] = "0";
            ValidacionDatos[1] = pagina == "1" ? "" : "|";
            return ValidacionDatos;
        }

        private string[] ValidacionPerfilConsultoraPeru(BEMensajeToolTip obj)
        {
            string[] tipoEnvio= new string[2];
            string[] resultadoValidacionPerfil = new string[2];           
            tipoEnvio[0] = Constantes.TipoEnvio.SMS.ToString();
            tipoEnvio[1] = Constantes.TipoEnvio.EMAIL.ToString();

            List<BEValidacionDatos> listBEValidacionDatos;
            using (var sv = new UsuarioServiceClient())
            {
                listBEValidacionDatos = sv.GetTipoEnvioActivos(userData.PaisID, userData.CodigoUsuario).ToList();
            }                

            /*Validamos si existen registros de validaciones para el email y el celular o estos están en estado pendiente*/
            if ((!listBEValidacionDatos.Any()) ||
                (from t in listBEValidacionDatos where tipoEnvio.Contains(t.TipoEnvio) && t.Estado == "P" select t).Count() == tipoEnvio.Length ||
                (!listBEValidacionDatos.Any(X => X.TipoEnvio == Constantes.TipoEnvio.SMS) && listBEValidacionDatos.Any(C => C.TipoEnvio == Constantes.TipoEnvio.EMAIL && C.Estado == "P")) ||
                (!listBEValidacionDatos.Any(X => X.TipoEnvio == Constantes.TipoEnvio.EMAIL) && listBEValidacionDatos.Any(C => C.TipoEnvio == Constantes.TipoEnvio.SMS && C.Estado == "P"))
            )
            {
                resultadoValidacionPerfil[0] = "1"; resultadoValidacionPerfil[1] = obj.MensajeAmbos;
            }
            else /*Validamso si existe registros de validación para el celular/email o está en pendiente*/
            {
                for (int i = 0; i < tipoEnvio.Length; i++)
                {
                    if (!listBEValidacionDatos.Any(x => x.TipoEnvio == tipoEnvio[i]) || listBEValidacionDatos.Any(x => x.TipoEnvio == tipoEnvio[i] && x.Estado == "P"))
                    {
                        resultadoValidacionPerfil[0] = "1";
                        resultadoValidacionPerfil[1] = tipoEnvio[i].ToString() == Constantes.TipoEnvio.SMS.ToString() ? obj.MensajeCelular : obj.MensajeEmail;
                        break;
                    }
                }
            }

            if (string.IsNullOrEmpty(resultadoValidacionPerfil[0]))
            {
                resultadoValidacionPerfil[0] = "0";
                resultadoValidacionPerfil[1] = string.Empty;
            }

            return resultadoValidacionPerfil;
        }

        private string[] ValidacionPerfilConsultorOtrosPaises(BEMensajeToolTip obj)
        {
            string[] tipoEnvio = new string[2];
            string[] resultadoValidacionPerfil = new string[2];
            tipoEnvio[0] = Constantes.TipoEnvio.SMS.ToString();
            tipoEnvio[1] = Constantes.TipoEnvio.EMAIL.ToString();

            List<BEValidacionDatos> listBEValidacionDatos;
            using (var sv = new UsuarioServiceClient())
            {
                listBEValidacionDatos = sv.GetTipoEnvioActivos(userData.PaisID, userData.CodigoUsuario).ToList();
            }                

            /*Validamos si existen registros de validaciones para el email y el celular o estos están en estado pendiente*/
            if (!listBEValidacionDatos.Any() ||
                (listBEValidacionDatos.Any(X => X.TipoEnvio == tipoEnvio[1] && X.Estado == "P") && !listBEValidacionDatos.Any(X => X.TipoEnvio == tipoEnvio[0]))
            )
            {
                resultadoValidacionPerfil[0] = "1"; resultadoValidacionPerfil[1] = obj.MensajeAmbos;
            }
            /*Validamso si existe registros de validación para el celular o está en pendiente*/
            else if (!listBEValidacionDatos.Any(x => x.TipoEnvio == tipoEnvio[0]))
            {
                resultadoValidacionPerfil[0] = "1";
                resultadoValidacionPerfil[1] = obj.MensajeCelular;
            }
            /*Validamso si existe registros de validación para el email o está en pendiente*/
            else if (listBEValidacionDatos.Any(x => x.TipoEnvio == tipoEnvio[1] && x.Estado=="P") ||
                !listBEValidacionDatos.Any(x => x.TipoEnvio == tipoEnvio[1])
            )
            {
                resultadoValidacionPerfil[0] = "1";
                resultadoValidacionPerfil[1] = obj.MensajeEmail;
            }
            else
            {
                resultadoValidacionPerfil[0] = "0";
                resultadoValidacionPerfil[1] = string.Empty;
            }

            return resultadoValidacionPerfil;
        }
        #endregion
        public JsonResult ObtenerEstadoContrato()
        {
            try
            {
                bool estado = _bienvenidaProvider.ValidarContratoPopup();
                return Json(new
                {
                    success = true,
                    estado = estado,
                    message = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al obtener el estado del contrato."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult KeepAlive()
        {
            return Content("OK");
        }
    }
} 