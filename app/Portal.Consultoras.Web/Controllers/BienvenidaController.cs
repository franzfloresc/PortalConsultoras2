using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BienvenidaController : BaseController
    {
        public BienvenidaController()
        {

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

                model.PartialSectionBpt = GetPartialSectionBptModel(revistaDigital);
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

                if (sessionManager.GetPrimeraVezSession() != null && (int)sessionManager.GetPrimeraVezSession() == 0)
                {
                    model.PrimeraVezSession = 0;
                    sessionManager.SetPrimeraVezSession(null);
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

                model.TipoPopUpMostrar = ObtenerTipoPopUpMostrar(model);

                #endregion

                if (sessionManager.GetActualizarDatosConsultora() == null)
                {
                    RegistrarLogDynamoDB(Constantes.LogDynamoDB.AplicacionPortalConsultoras, Constantes.LogDynamoDB.RolConsultora, "HOME", "INGRESAR");
                    sessionManager.SetActualizarDatosConsultora(true);
                }

                model.ShowRoomMostrarLista = ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado) ? 0 : 1;
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
                if (sessionManager.GetTipoPopUpMostrar() != null)
                {
                    var tipoPopup = Convert.ToInt32(sessionManager.GetTipoPopUpMostrar());
                    if (tipoPopup == Constantes.TipoPopUp.AsesoraOnline)
                    {
                        sessionManager.SetTipoPopUpMostrar(Constantes.TipoPopUp.Ninguno);
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
                sessionManager.SetUserData(userData);
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

        private List<BEPopupPais> ObtenerListaPopupsDesdeServicio()
        {
            var listaPopUps = new List<BEPopupPais>();
            try
            {
                using (var sac = new SACServiceClient())
                {
                    listaPopUps = sac.ObtenerOrdenPopUpMostrar(userData.PaisID).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return listaPopUps;
        }

        private int ObtenerTipoPopUpMostrar(BienvenidaHomeModel model)
        {
            var resultPopupEmail = ObtenerActualizacionEmail();
            var resultPopupEmailSplited = resultPopupEmail.Split('|')[0];

            if (model.ShowPopupMisDatos)
                return Constantes.TipoPopUp.Ninguno;

            if (TempData["MostrarPopupCuponGanaste"] != null)
            {
                TempData["MostrarPopupCuponGanaste"] = null;
                return Convert.ToInt32(TempData["TipoPopup"]);
            }

            var tipoPopUpMostrar = 0;
            if (sessionManager.GetTipoPopUpMostrar() != null)
            {
                tipoPopUpMostrar = Convert.ToInt32(sessionManager.GetTipoPopUpMostrar());

                if (tipoPopUpMostrar == Constantes.TipoPopUp.RevistaDigitalSuscripcion && revistaDigital.NoVolverMostrar)
                    tipoPopUpMostrar = 0;

                if (resultPopupEmailSplited == "0" && tipoPopUpMostrar == Constantes.TipoPopUp.ActualizarCorreo) tipoPopUpMostrar = 0;

                if (tipoPopUpMostrar == Constantes.TipoPopUp.ActualizarCorreo) tipoPopUpMostrar = 0;

                return tipoPopUpMostrar;
            }

            var listaPopUps = ObtenerListaPopupsDesdeServicio();
            if (listaPopUps.Any())
            {
                tipoPopUpMostrar = BuscarTipoPopupEnLista(model, listaPopUps);
                sessionManager.SetTipoPopUpMostrar(tipoPopUpMostrar);
            }
            return tipoPopUpMostrar;
        }

        private bool MostrarPopupVideoIntroductorio(BienvenidaHomeModel model)
        {
            var mostrarPopUp = false;
            try
            {
                if (userData.VioVideoModelo == 0)
                {
                    model.VioVideoBienvenidaModel = 0;
                    UpdateUsuarioTutorial(Constantes.TipoTutorial.Video);
                    mostrarPopUp = true;
                }

                if (userData.VioTutorialDesktop == 0)
                {
                    if (userData.VioTutorialSalvavidas == 0)
                    {
                        UpdateUsuarioTutorial(Constantes.TipoTutorial.Salvavidas);
                        ViewBag.MostrarUbicacionTutorial = 0;
                    }
                    else
                    {
                        UpdateUsuarioTutorial(Constantes.TipoTutorial.Desktop);
                    }

                    mostrarPopUp = true;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                mostrarPopUp = false;
            }

            return mostrarPopUp;
        }

        private int BuscarTipoPopupEnLista(BienvenidaHomeModel model, List<BEPopupPais> listaPopUps)
        {
            var tipoPopUpMostrar = 0;

            foreach (var popup in listaPopUps)
            {
                switch (popup.CodigoPopup)
                {
                    case Constantes.TipoPopUp.VideoIntroductorio:
                        if (MostrarPopupVideoIntroductorio(model))
                            tipoPopUpMostrar = Constantes.TipoPopUp.VideoIntroductorio;
                        break;

                    case Constantes.TipoPopUp.DemandaAnticipada:
                        if (userData.EsConsultora()
                            && ValidarConsultoraDemandaAnticipada(model))
                        {
                            tipoPopUpMostrar = Constantes.TipoPopUp.DemandaAnticipada;
                        }
                        break;

                    case Constantes.TipoPopUp.AceptacionContrato:
                        if (userData.EsConsultora()
                            && userData.CambioClave == 0 && userData.IndicadorContrato == 0
                            && userData.CodigoISO.Equals(Constantes.CodigosISOPais.Colombia)
                            && sessionManager.GetIsContrato() == 1)
                        {
                            tipoPopUpMostrar = Constantes.TipoPopUp.AceptacionContrato;
                        }
                        break;
                    case Constantes.TipoPopUp.Showroom:
                        if (ValidarMostrarShowroomPopUp())
                            tipoPopUpMostrar = Constantes.TipoPopUp.Showroom;
                        break;

                    case Constantes.TipoPopUp.ActualizarDatos:
                        if (userData.EsConsultora())
                        {
                            if (userData.CodigoISO == Constantes.CodigosISOPais.Mexico
                                && model.ValidaDatosActualizados == 1
                                && model.ValidaTiempoVentana == 1
                                && model.ValidaSegmento == 1)
                            {
                                model.MostrarPopupActualizarDatosXPais = Constantes.PaisID.Mexico;
                                tipoPopUpMostrar = Constantes.TipoPopUp.ActualizarDatos;
                            }
                            else
                            {
                                if (model.PrimeraVez == 0 || model.PrimeraVezSession == 0)
                                {
                                    model.MostrarPopupActualizarDatosXPais = userData.CodigoISO == Constantes.CodigosISOPais.Peru ? Constantes.PaisID.Peru : 0;
                                    tipoPopUpMostrar = Constantes.TipoPopUp.ActualizarDatos;
                                }
                            }
                        }
                        break;

                    case Constantes.TipoPopUp.Flexipago:
                        if (userData.EsConsultora()
                            && (userData.InvitacionRechazada == "False" || userData.InvitacionRechazada == "0" || userData.InvitacionRechazada == "")
                            && model.InscritaFlexipago == "0"
                            && model.IndicadorFlexipago == 1
                            && model.CampanaInvitada != "0"
                            && (model.CampaniaActual - Convert.ToInt32(model.CampanaInvitada)) >= Convert.ToInt32(model.NroCampana)
                        )
                        {
                            tipoPopUpMostrar = Constantes.TipoPopUp.Flexipago;
                        }
                        break;

                    case Constantes.TipoPopUp.Comunicado:
                        var comunicados = ValidarComunicadoPopup();
                        if (comunicados.Any())
                            tipoPopUpMostrar = Constantes.TipoPopUp.Comunicado;

                        break;

                    case Constantes.TipoPopUp.RevistaDigitalSuscripcion:
                        if (!revistaDigital.TieneRDS
                            || revistaDigital.NoVolverMostrar
                            || revistaDigital.EsSuscrita)
                            continue;

                        tipoPopUpMostrar = Constantes.TipoPopUp.RevistaDigitalSuscripcion;
                        break;

                    case Constantes.TipoPopUp.Cupon:

                        if (userData.TieneCupon == 1)
                        {
                            var cupon = ObtenerCuponDesdeServicio();
                            if (cupon != null)
                            {
                                if (userData.CodigoISO == Constantes.CodigosISOPais.Peru)
                                {
                                    tipoPopUpMostrar = Constantes.TipoPopUp.CuponForzado;
                                }
                                else
                                {
                                    if (cupon.EstadoCupon == Constantes.EstadoCupon.Reservado)
                                        tipoPopUpMostrar = Constantes.TipoPopUp.Cupon;
                                }
                            }
                        }
                        break;

                    case Constantes.TipoPopUp.AsesoraOnline:
                        if (userData.TieneAsesoraOnline == 1)
                        {
                            var existeAsesoraOnlineResult = ExisteConsultoraEnAsesoraOnline(userData.CodigoISO, userData.CodigoConsultora);

                            if (existeAsesoraOnlineResult != 1)
                            {
                                var habilitadoConfiguracionPaisResult = ValidarAsesoraOnlineConfiguracionPais(userData.CodigoISO, userData.CodigoConsultora);
                                if (habilitadoConfiguracionPaisResult == 1)
                                    tipoPopUpMostrar = Constantes.TipoPopUp.AsesoraOnline;
                            }
                        }
                        break;
                    case Constantes.TipoPopUp.ActualizarCorreo:
                        var result = ObtenerActualizacionEmail();
                        if (result.Split('|')[0] == "1")
                        {
                            tipoPopUpMostrar = Constantes.TipoPopUp.ActualizarCorreo;
                        }
                        break;
                }

                if (tipoPopUpMostrar > 0)
                    break;
            }

            return tipoPopUpMostrar;
        }

        private List<BEComunicado> ValidarComunicadoPopup()
        {
            var tempComunicados = new List<BEComunicado>();

            try
            {
                if (userData.EsConsultora())
                {
                    var comunicados = ObtenerComunicadoPorConsultora();

                    if (comunicados != null && comunicados.Count > 0)
                    {
                        tempComunicados = comunicados.Where(c =>
                            string.IsNullOrEmpty(c.CodigoCampania) ||
                            Convert.ToInt32(c.CodigoCampania) == userData.CampaniaID).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return tempComunicados;
        }

        private int ValidarAsesoraOnlineConfiguracionPais(string isoPais, string codigoConsultora)
        {
            var resultado = 0;
            try
            {
                using (var sv = new AsesoraOnlineServiceClient())
                {
                    resultado = sv.ValidarAsesoraOnlineConfiguracionPais(isoPais, codigoConsultora);
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, codigoConsultora, isoPais);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, isoPais);
            }

            return resultado;
        }

        private bool ValidarMostrarShowroomPopUp()
        {
            var mostrarShowRoomProductos = false;

            try
            {
                if (_showRoomProvider.PaisTieneShowRoom(userData.CodigoISO))
                {
                    if (!configEstrategiaSR.CargoEntidadesShowRoom) return false;
                    var beShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora;
                    var beShowRoom = configEstrategiaSR.BeShowRoom;

                    if (beShowRoomConsultora == null) beShowRoomConsultora = new ShowRoomEventoConsultoraModel();
                    if (beShowRoom == null) beShowRoom = new ShowRoomEventoModel();

                    if (beShowRoom.Estado == 1)
                    {
                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                        var diasAntes = beShowRoom.DiasAntes;
                        var diasDespues = beShowRoom.DiasDespues;

                        mostrarShowRoomProductos = true;
                        var esCompra = fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date &&
                                       fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date;

                        if (fechaHoy > userData.FechaInicioCampania.AddDays(diasDespues).Date)
                            mostrarShowRoomProductos = false;

                        if (beShowRoomConsultora.EventoConsultoraID == 0)
                        {
                            mostrarShowRoomProductos = false;
                        }
                        else
                        {
                            if (!esCompra)
                            {
                                if (!beShowRoomConsultora.MostrarPopup)
                                    mostrarShowRoomProductos = false;

                            }
                            else
                            {
                                if (!beShowRoomConsultora.MostrarPopupVenta)
                                    mostrarShowRoomProductos = false;

                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                mostrarShowRoomProductos = false;
            }

            return mostrarShowRoomProductos;
        }

        private bool ValidarConsultoraDemandaAnticipada(BienvenidaHomeModel model)
        {
            try
            {

                if (!userData.EsquemaDAConsultora) return false;
                if (userData.EsZonaDemAnti != 1) return false;

                BECronograma cronograma;

                var configuracionConsultoraDa = new BEConfiguracionConsultoraDA
                {
                    CampaniaID = Convert.ToString(userData.CampaniaID),
                    ConsultoraID = Convert.ToInt32(userData.ConsultoraID),
                    ZonaID = userData.ZonaID
                };

                using (var sv = new SACServiceClient())
                {
                    var consultoraDa = sv.GetConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDa);

                    if (consultoraDa != 0)
                        return false;

                    cronograma =
                        sv.GetCronogramaByCampaniaAnticipado(userData.PaisID, userData.CampaniaID, userData.ZonaID, 2)
                            .FirstOrDefault();
                }

                if (cronograma == null) return false;
                if (cronograma.FechaInicioWeb == null) return false;

                var fechaDa = (DateTime)cronograma.FechaInicioWeb;

                var diasemana = "";

                #region Nombre Dia

                var dia = fechaDa.DayOfWeek.ToString();
                switch (dia)
                {
                    case "Monday":
                        diasemana = "Lunes";
                        break;
                    case "Tuesday":
                        diasemana = "Martes";
                        break;
                    case "Wednesday":
                        diasemana = "Miércoles";
                        break;
                    case "Thursday":
                        diasemana = "Jueves";
                        break;
                    case "Friday":
                        diasemana = "Viernes";
                        break;
                    case "Saturday":
                        diasemana = "Sábado";
                        break;
                    case "Sunday":
                        diasemana = "Domingo";
                        break;
                }

                #endregion

                var sp = userData.HoraCierreZonaDemAntiCierre;
                var cierrezonademanti = new DateTime(sp.Ticks).ToString("HH:mm") + " hrs";

                model.MensajeFechaDA = diasemana + " " + fechaDa.Day.ToString() + " de " + Util.NombreMes(fechaDa.Month) +
                                       " (" + cierrezonademanti + ")";

                return true;

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        private void UpdateUsuarioTutorial(int tipo)
        {
            int retorno;
            using (var sv = new UsuarioServiceClient())
            {
                retorno = sv.UpdateUsuarioTutoriales(userData.PaisID, userData.CodigoUsuario, tipo);
            }

            switch (tipo)
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

            sessionManager.SetUserData(userData);
        }

        public JsonResult AceptarContrato(bool checkAceptar , string origenAceptacion, string AppVersion)
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
                  svr.AceptarContratoAceptacion(userData.PaisID, userData.ConsultoraID, userData.CodigoConsultora , origenAceptacion, ip, AppVersion);
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

                BEZona[] bezona;
                using (var sv = new ZonificacionServiceClient())
                {
                    bezona = sv.SelectZonaById(userData.PaisID, userData.ZonaID);
                }
                model.NombreGerenteZonal = bezona.ToList().Count == 0 ? "" : bezona[0].NombreGerenteZona;

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

                    sessionManager.SetUserData(userData);
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

        [HttpPost]
        public JsonResult ValidarCorreoComunidad(string correo)
        {
            try
            {
                bool result;
                using (var sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    result = sv.GetUsuarioByCorreo(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        Correo = correo,
                    });
                }
                if (result)
                {
                    ServiceComunidad.BEUsuarioComunidad obeUsuarioComunidad;
                    using (var sv = new ServiceComunidad.ComunidadServiceClient())
                    {
                        obeUsuarioComunidad = sv.GetUsuarioInformacion(new ServiceComunidad.BEUsuarioComunidad()
                        {
                            UsuarioId = 0,
                            CodigoUsuario = correo,
                            Tipo = 4,
                            PaisId = userData.PaisID
                        });
                    }

                    if (obeUsuarioComunidad != null)
                    {
                        var parametros = new string[] { obeUsuarioComunidad.UsuarioId.ToString(), "1", userData.PaisID.ToString(), userData.CodigoUsuario, userData.CodigoConsultora };
                        var paramQuerystring = Util.EncriptarQueryString(parametros);
                        var request = this.HttpContext.Request;
                        var paginaConfirmacion = Util.GetUrlHost(request) + "WebPages/ConfirmacionRegistroComunidad.aspx?data=" + paramQuerystring;

                        var sb = new System.Text.StringBuilder();
                        sb.Append("<html><head><title>Verificar Correo</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");
                        sb.Append("<script type='text/javascript'>function MM_swapImgRestore() { var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;}");
                        sb.Append("function MM_preloadImages() { var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array(); var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++) if (a[i].indexOf('#')!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}}");
                        sb.Append("function MM_findObj(n, d) { var p,i,x;  if(!d) d=document; if((p=n.indexOf('?'))>0&&parent.frames.length) { d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);} if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n]; for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); if(!x && d.getElementById) x=d.getElementById(n); return x;}");
                        sb.Append("function MM_swapImage() { var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3) if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];} } </script></head>");
                        sb.Append("<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' onLoad=\"MM_preloadImages('" + Globals.RutaCdn + "/Comunidad/hazclick_on.png')\">");
                        sb.Append("<table width='800' height='521' border='0' align='center' cellpadding='0' cellspacing='0' id='Table_01'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='17px' bgcolor='#F6F6F6'></td>");
                        sb.Append("<td width='766px'><table id='Table_' width='766' height='521' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='766' height='22' bgcolor='#F6F6F6'></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='766' height='419'><table id='Table_2' width='766' height='419' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198'><table id='Table_4' width='198' height='419' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198' height='119'><img src='" + Globals.RutaCdn + "/Comunidad/mail_menulat_01.gif' width='198' height='119' alt=''></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198' height='73'><img src='" + Globals.RutaCdn + "/Comunidad/mail_menulat_02.gif' width='198' height='73' alt=''></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198' height='139'><table id='Table_5' width='198' height='139' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='18'></td>");
                        sb.Append("<td width='180'><table id='Table_6' width='180' height='139' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='" + Globals.RutaCdn + "/Comunidad/ico_com.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#b03695'><span style='text-decoration:none;text-underline:none'>Bienvenida a tu comunidad</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='" + Globals.RutaCdn + "/Comunidad/ico_logra.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#569898'><span style='text-decoration:none;text-underline:none'>Logra con tu belleza</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='" + Globals.RutaCdn + "/Comunidad/ico_neg.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#a8cb30'><span style='text-decoration:none;text-underline:none'>Tu negocio</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='28'><img src='" + Globals.RutaCdn + "/Comunidad/ico_tusmarcas.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#570064'><span style='text-decoration:none;text-underline:none'>Tus marcas y tus productos</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td><table width='180' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='20' height='27'><img src='" + Globals.RutaCdn + "/Comunidad/ico_cosas.gif' width='20' height='20'></td>");
                        sb.Append("<td width='5'></td>");
                        sb.Append("<td width='155' height='27'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 9.5px; text-transform: uppercase;'><a href='#'><font color='#666696'><span style='text-decoration:none;text-underline:none'>Cosas de mujeres</span></font></a></font></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='198'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("<td width='568'><table id='Table_3' width='568' height='419' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append(string.Format("<td width='568' height='197'><a href='{0}'><img src='" + Globals.RutaCdn + "/Comunidad/mail_derecho_01.jpg' width='568' height='197'></a></td>", paginaConfirmacion));
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='568' height='222' background='" + Globals.RutaCdn + "/Comunidad/bgmail01.jpg'><table width='568' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td height='106'><table width='568' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='31' height='106'>&nbsp;</td>");
                        sb.Append("<td width='466'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color:#425363; line-height:1.2;'>¡Felicidades! ¡Ya eres Consultora Belcorp! De ahora en adelante, para llegar a tu comunidad tendrás que ingresar siempre a través de tu cuenta de Somos Belcorp(*).</font></td>");
                        sb.Append("<td>&nbsp;</td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td height='90'><table width='568' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='31' height='90'>&nbsp;</td>");
                        sb.Append("<td width='412'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color:#660066;line-height:1.2;'>Aprovecha al máximo tu comunidad</font><br>");
                        sb.Append("<font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color:#425363; line-height:1.2;'>En la sección Mi negocio encontrarás todos los tips que <br>");
                        sb.Append("necesitas para hacer crecer tu negocio.</font></td>");
                        sb.Append("<td width='125'>&nbsp;</td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td height='26'>&nbsp;</td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td width='766' height='29' bgcolor='#768591'><table id='Table_7' width='766' height='29' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='581' height='29'></td>");
                        sb.Append("<td width='91'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 11px; color:#FFF; text-transform: uppercase;'>Siguenos en:</font></td>");
                        sb.Append("<td width='24'><a href='https://www.facebook.com/SomosBelcorpOficial?fref=ts' target='_blank'><img src='" + Globals.RutaCdn + "/Comunidad/socialbar_03.gif' width='24' height='29' alt=''></a></td>");
                        sb.Append("<td width='3'></td>");
                        sb.Append("<td width='23'><a href='https://www.youtube.com/user/somosbelcorp' target='_blank'><img src='" + Globals.RutaCdn + "/Comunidad/socialbar_05.gif' width='23' height='29' alt=''></a></td>");
                        sb.Append("<td width='44'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("<tr>");
                        sb.Append("<td height='51' bgcolor='#F6F6F6'><table width='766' border='0' cellspacing='0' cellpadding='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td height='51'><table id='Table_8' width='766' height='51' border='0' cellpadding='0' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td width='18'></td>");
                        sb.Append("<td width='373'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 11px; color:#768591;'>¿No deseas recibir correos electrónicos de la Comunidad Somos Belcorp?</font></td>");
                        sb.Append("<td width='8'></td>");
                        sb.Append("<td width='101'><a href='#' onMouseOut='MM_swapImgRestore()' onMouseOver=\"MM_swapImage('Haz click','','" + Globals.RutaCdn + "/Comunidad/hazclick_on.png',1)\"><img src='" + Globals.RutaCdn + "/Comunidad/hazclick_off.png' width='101' height='21' id='Haz click'></a></td>");
                        sb.Append("<td width='266'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></td>");
                        sb.Append("<td width='17' bgcolor='#F6F6F6'></td>");
                        sb.Append("</tr>");
                        sb.Append("</table></body></html>");

                        Util.EnviarMail("comunidadsomosbelcorp@somosbelcorp.com", obeUsuarioComunidad.Correo, "Bienvenida a la Comunidad SomosBelcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                        using (var sv = new ServiceComunidad.ComunidadServiceClient())
                        {
                            sv.UpdUsuarioCorreoEnviado(new ServiceComunidad.BEUsuarioComunidad()
                            {
                                UsuarioId = obeUsuarioComunidad.UsuarioId,
                                Tipo = 1
                            });
                        }
                        userData.EsUsuarioComunidad = true;

                        return Json(new
                        {
                            success = true,
                            message = "¡Tu correo ha sido validado con éxito! Por favor revisa tu correo y sigue los pasos indicados.",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Hubo un problema con el servicio, intente nuevamente",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "El correo electrónico que ingresaste no existe. Por favor, revisa e inténtalo de nuevo, o regístrate como nuevo miembro de la comunidad.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
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
        public JsonResult RegistrarUsuarioComunidad(string usuario, string correo)
        {
            try
            {
                bool validaUsuario;
                var validaCorreo = false;

                using (var sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    validaUsuario = sv.GetUsuarioByCodigo(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        CodigoUsuario = usuario,
                    });

                    if (!validaUsuario)
                    {
                        validaCorreo = sv.GetUsuarioByCorreo(new ServiceComunidad.BEUsuarioComunidad()
                        {
                            Correo = correo,
                        });
                    }
                }

                if (validaUsuario)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El usuario ingresado ya está siendo usado.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                if (validaCorreo)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El correo ingresado ya está siendo usado.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                long uniqueId;
                using (var sv = new ServiceComunidad.ComunidadServiceClient())
                {
                    uniqueId = sv.InsUsuarioRegistro(new ServiceComunidad.BEUsuarioComunidad()
                    {
                        CodigoUsuario = usuario,
                        Nombre = userData.PrimerNombre,
                        Apellido = userData.PrimerApellido,
                        Contrasenia = usuario,
                        Correo = correo,
                        PaisId = userData.PaisID
                    });
                }

                if (uniqueId > 0)
                {
                    var parametros = new string[] { uniqueId.ToString(), "1", userData.PaisID.ToString(), userData.CodigoUsuario, userData.CodigoConsultora };
                    var paramQuerystring = Util.EncriptarQueryString(parametros);
                    var request = this.HttpContext.Request;
                    var paginaConfirmacion = Util.GetUrlHost(request) + "WebPages/ConfirmacionRegistroComunidad.aspx?data=" + paramQuerystring;

                    var sb = new System.Text.StringBuilder();
                    sb.Append("<html><head><title>mail_inscripcion</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head>");
                    sb.Append("<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>");
                    sb.Append("<table width='766' height='665' border='0' align='center' cellpadding='0' cellspacing='0' id='Table_01'>");
                    sb.Append("<tr><td><img src='" + Globals.RutaCdn + "/Comunidad/mail_verificacion_01.jpg' width='766' height='240' alt=''></td></tr>");
                    sb.Append("<tr><td><img src='" + Globals.RutaCdn + "/Comunidad/mail_verificacion_02.gif' width='766' height='142' alt=''></td></tr>");
                    sb.Append("<tr><td><img src='" + Globals.RutaCdn + "/Comunidad/mail_verificacion_03.jpg' width='766' height='153' alt=''></td></tr>");
                    sb.Append("<tr><td width='766' height='28'>&nbsp;</td></tr>");
                    sb.Append("<tr><td><table id='Table_' width='766' height='46' border='0' cellpadding='0' cellspacing='0'><tr><td width='259'>&nbsp;</td>");
                    sb.Append(string.Format("<td width='249'><a href='{0}'><img src='" + Globals.RutaCdn + "/Comunidad/bot_verifica.gif' width='249' height='46' alt=''></a></td>", paginaConfirmacion));
                    sb.Append("<td width='258'>&nbsp;</td></tr></table></td></tr>");
                    sb.Append("<tr><td width='766' height='56'>&nbsp;</td></tr></table></body></html>");

                    Util.EnviarMail("comunidadsomosbelcorp@somosbelcorp.com", correo, "Bienvenida a la Comunidad SomosBelcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                    using (var sv = new ServiceComunidad.ComunidadServiceClient())
                    {
                        sv.UpdUsuarioCorreoEnviado(new ServiceComunidad.BEUsuarioComunidad()
                        {
                            UsuarioId = uniqueId,
                            Tipo = 1
                        });
                    }

                    userData.EsUsuarioComunidad = true;

                    return Json(new
                    {
                        success = true,
                        message = "¡Gracias por querer ser parte de nuestra comunidad! Para continuar con el proceso, sigue los pasos del correo que te hemos enviado.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "Hubo un problema con el servicio, intente nuevamente",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
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
        public JsonResult ValidarUsuarioIngresado(string usuario)
        {
            bool result;
            using (var sv = new ServiceComunidad.ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCodigo(new ServiceComunidad.BEUsuarioComunidad()
                {
                    CodigoUsuario = usuario,
                });
            }

            return Json(new
            {
                success = result,
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ValidarCorreoIngresado(string correo)
        {
            bool result;
            using (var sv = new ServiceComunidad.ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCorreo(new ServiceComunidad.BEUsuarioComunidad()
                {
                    Correo = correo,
                });
            }

            return Json(new
            {
                success = result,
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
                listaPaises = DropDowListPaises()
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

            Util.ExportToExcel("SueniosDeNavidad", lst, dic);
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2 ? sv.SelectPaises().ToList() : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
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
            if (sessionManager.GetSuenioNavidad() == null)
            {
                using (var svc = new PedidoServiceClient())
                {
                    validacion = svc.ValidarSuenioNavidad(entidad);
                }
                sessionManager.SetSuenioNavidad(validacion);
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

        [HttpPost]
        public JsonResult NoMostrarShowRoomPopup(string TipoShowRoom)
        {
            try
            {
                var entidad = new BEShowRoomEventoConsultora
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    CampaniaID = userData.CampaniaID,
                    EventoID = configEstrategiaSR.BeShowRoom.EventoID,
                    EventoConsultoraID = configEstrategiaSR.BeShowRoomConsultora.EventoConsultoraID,
                };

                using (var sac = new PedidoServiceClient())
                {
                    sac.UpdEventoConsultoraPopup(userData.PaisID, entidad, TipoShowRoom);
                }

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

                if (!configEstrategiaSR.CargoEntidadesShowRoom)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = ""
                    });
                }

                var showRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

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

                var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

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
            sessionManager.SetUserData(userData);
            return Json(userData.CerrarRechazado);
        }

        [HttpPost]
        public JsonResult CerrarMensajePostulante()
        {
            try
            {
                userData.CerrarBannerPostulante = 1;
                sessionManager.SetUserData(userData);
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

            var tempComunicados = ObtenerComunicadoPorConsultora();

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
                    sessionManager.SetUserData(userData);
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

        private List<BEComunicado> ObtenerComunicadoPorConsultora()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = sac.ObtenerComunicadoPorConsultora(UserData().PaisID, UserData().CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Desktop, UserData().CodigorRegion, UserData().CodigoZona, UserData().ConsultoraNueva);

                return lstComunicados.ToList();
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
            var cuponResult = ObtenerCuponDesdeServicio();

            if (cuponResult != null)
                cuponModel = MapearBECuponACuponModel(cuponResult);
            else
                throw new Exception();

            return cuponModel;
        }

        private BECuponConsultora ObtenerCuponDesdeServicio()
        {
            BECuponConsultora cuponResult;
            try
            {
                var cuponBe = new BECuponConsultora
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    CampaniaId = userData.CampaniaID
                };

                using (var svClient = new PedidoServiceClient())
                {
                    cuponResult = svClient.GetCuponConsultoraByCodigoConsultoraCampaniaId(userData.PaisID, cuponBe);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                cuponResult = new BECuponConsultora();
            }

            return cuponResult;
        }

        private int ExisteConsultoraEnAsesoraOnline(string paisIso, string codigoConsultora)
        {
            try
            {

                using (var svClient = new AsesoraOnlineServiceClient())
                {
                    var result = svClient.ExisteConsultoraEnAsesoraOnline(paisIso, codigoConsultora);
                    return result;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return 0;
            }
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

        public virtual PartialSectionBpt GetPartialSectionBptModel(RevistaDigitalModel revistaDigital)
        {
            var partial = new PartialSectionBpt();

            try
            {
                if (revistaDigital == null)
                    return partial;

                partial.RevistaDigital = revistaDigital;

                if (revistaDigital.TieneRDC && revistaDigital.EsActiva && revistaDigital.EsSuscrita)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaActiva);
                }
                else if (revistaDigital.TieneRDC && revistaDigital.EsActiva && !revistaDigital.EsSuscrita)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaActiva);
                }
                else if (revistaDigital.TieneRDC && !revistaDigital.EsActiva && revistaDigital.EsSuscrita)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaNoActiva);
                }
                else if (revistaDigital.TieneRDC && !revistaDigital.EsActiva && !revistaDigital.EsSuscrita)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaNoActiva);
                }
                else if (revistaDigital.TieneRDI)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RDI.DBienvenidaIntriga);
                }

            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO, "LoginController.GetPartialSectionBptModel");
            }

            partial.ConfiguracionPaisDatos = partial.ConfiguracionPaisDatos ?? new ConfiguracionPaisDatosModel();
            return partial;
        }

        public string ObtenerActualizacionEmail()
        {
            try
            {

                using (var svClient = new UsuarioServiceClient())
                {
                    var result = svClient.GetActualizacionEmail(userData.PaisID, userData.CodigoUsuario);
                    return  result;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "";
            }
        }


    }
}