using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;
using System;
using System.Collections.Generic;
using System.Linq;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceAsesoraOnline;

namespace Portal.Consultoras.Web.Providers
{
    public class BienvenidaProvider
    {
        private readonly ISessionManager sessionManager;
        private readonly ILogManager logManager;
        private readonly ShowRoomProvider showRoomProvider;
        private readonly ComunicadoProvider comunicadoProvider;
      

        public BienvenidaProvider() : this(LogManager.LogManager.Instance,
            SessionManager.SessionManager.Instance)
        {
            showRoomProvider = new ShowRoomProvider();
            comunicadoProvider = new ComunicadoProvider();
        }

        public BienvenidaProvider(ILogManager _logManager, ISessionManager _sessionManager)
        {
            this.logManager = _logManager;
            this.sessionManager = _sessionManager;
        }

        protected UsuarioModel userData
        {
            get
            {
                return sessionManager.GetUserData();
            }
        }

        protected RevistaDigitalModel revistaDigital
        {
            get
            {
                return sessionManager.GetRevistaDigital();
            }
        }

        protected ConfigModel configEstrategiaSR
        {
            get
            {
                return sessionManager.GetEstrategiaSR() ?? new ConfigModel();
            }
        }

        public  int ObtenerTipoPopUpMostrar( bool esMobile, ValidaPopUpPaisModel model = null)
        {

            model = model ?? new ValidaPopUpPaisModel();

            var resultPopupEmail = ObtenerActualizacionEmail();
            var resultPopupEmailSplited = resultPopupEmail.Split('|')[0];

            if (model.ShowPopupMisDatos  && !esMobile)
                return Constantes.TipoPopUp.Ninguno;
                    
            var tipoPopUpMostrar = 0;
            if (sessionManager.GetTipoPopUpMostrar() != -1)
            {
                tipoPopUpMostrar = Convert.ToInt32(sessionManager.GetTipoPopUpMostrar());

                if (tipoPopUpMostrar != Constantes.TipoPopUp.VideoIntroductorio)
                {
                    if (tipoPopUpMostrar == Constantes.TipoPopUp.RevistaDigitalSuscripcion && revistaDigital.NoVolverMostrar)
                        tipoPopUpMostrar = 0;

                    if (resultPopupEmailSplited == "0" && tipoPopUpMostrar == Constantes.TipoPopUp.ActualizarCorreo) tipoPopUpMostrar = 0;

                    if (tipoPopUpMostrar == Constantes.TipoPopUp.ActualizarCorreo) tipoPopUpMostrar = 0;

                    if (tipoPopUpMostrar == Constantes.TipoPopUp.AceptacionContrato && userData.IndicadorContrato == 1) tipoPopUpMostrar = 0;

                    return tipoPopUpMostrar;
                }
            }

            var listaPopUps = ObtenerListaPopupsDesdeServicio();
            if (listaPopUps.Any())
            {
                tipoPopUpMostrar = BuscarTipoPopupEnLista(model, listaPopUps, esMobile);
                sessionManager.SetTipoPopUpMostrar(tipoPopUpMostrar);
            }
            return tipoPopUpMostrar;
        }

        public string ObtenerActualizacionEmail()
        {
            try
            {
                using (var svClient = new UsuarioServiceClient())
                {
                    var result = svClient.GetActualizacionEmail(userData.PaisID, userData.CodigoUsuario);
                    return result;
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ObtenerActualizacionEmail");
                return "";
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ObtenerListaPopupsDesdeServicio");
            }
            return listaPopUps;
        }

        private int BuscarTipoPopupEnLista(ValidaPopUpPaisModel model, List<BEPopupPais> listaPopUps, bool esMobile)
        {
            var tipoPopUpMostrar = 0;

            foreach (var popup in listaPopUps)
            {
                switch (popup.CodigoPopup)
                {
                    case Constantes.TipoPopUp.VideoIntroductorio:
                        if (MostrarPopupVideoIntroductorio())
                            tipoPopUpMostrar = Constantes.TipoPopUp.VideoIntroductorio;
                        break;

                    case Constantes.TipoPopUp.DemandaAnticipada:
                        if (userData.EsConsultora()
                            && ValidarConsultoraDemandaAnticipada())
                        {
                            tipoPopUpMostrar = Constantes.TipoPopUp.DemandaAnticipada;
                        }
                        break;

                    case Constantes.TipoPopUp.AceptacionContrato:
                        if (ValidarContratoPopup())
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
                                tipoPopUpMostrar = Constantes.TipoPopUp.ActualizarDatos;
                            }
                            else
                            {
                                var PrimeraVezSession = 1;
                                if (sessionManager.GetPrimeraVezSession() != null && (int)sessionManager.GetPrimeraVezSession() == 0) PrimeraVezSession = 0;
                                if (userData.CambioClave == 0 || PrimeraVezSession == 0)
                                {
                                    tipoPopUpMostrar = Constantes.TipoPopUp.ActualizarDatos;
                                }
                            }
                        }
                        break;

                    case Constantes.TipoPopUp.Flexipago:
                        
                        if (userData.EsConsultora()
                            && (userData.InvitacionRechazada == "False" || userData.InvitacionRechazada == "0" || userData.InvitacionRechazada == "")
                            && userData.InscritaFlexipago == "0"
                            && userData.IndicadorFlexiPago == 1
                            && userData.CampanaInvitada != "0"
                            && (userData.CampaniaID - Convert.ToInt32(userData.CampanaInvitada)) >=  userData.NroCampanias
                        )
                        {
                            tipoPopUpMostrar = Constantes.TipoPopUp.Flexipago;
                        }
                        break;

                    case Constantes.TipoPopUp.Comunicado:
                        var comunicados = ValidarComunicadoPopup(esMobile);
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

        #region Metodos Popups

        private bool MostrarPopupVideoIntroductorio()
        {
            var mostrarPopUp = false;
            try
            {
                if (userData.VioVideoModelo == 0)
                {
                    UpdateUsuarioTutorial(Constantes.TipoTutorial.Video);
                    mostrarPopUp = true;
                }

                if (userData.VioTutorialDesktop == 0)
                {
                    if (userData.VioTutorialSalvavidas == 0)
                    {
                        UpdateUsuarioTutorial(Constantes.TipoTutorial.Salvavidas);
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.MostrarPopupVideoIntroductorio");
                mostrarPopUp = false;
            }

            return mostrarPopUp;
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

        private bool ValidarConsultoraDemandaAnticipada()
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
                
                return true;

            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ValidarConsultoraDemandaAnticipada");
                return false;
            }
        }

        public bool ValidarContratoPopup()
        {
            return userData.EsConsultora() && userData.CambioClave == 0 && userData.IndicadorContrato == 0 &&
                userData.CodigoISO.Equals(Constantes.CodigosISOPais.Colombia) &&
                sessionManager.GetIsContrato() == 1 && !sessionManager.GetAceptoContrato();
        }

        private bool ValidarMostrarShowroomPopUp()
        {
            var mostrarShowRoomProductos = false;

            try
            {
                if (showRoomProvider.PaisTieneShowRoom(userData.CodigoISO))
                {
                    showRoomProvider.CargarEventoConsultora(userData);
                    if (!configEstrategiaSR.CargoEntidadEventoConsultora) return false;
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ValidarMostrarShowroomPopUp");
                mostrarShowRoomProductos = false;
            }

            return mostrarShowRoomProductos;
        }

        private List<BEComunicado> ValidarComunicadoPopup(bool esMobile)
        {
            var tempComunicados = new List<BEComunicado>();
            
            try
            {
                if (userData.EsConsultora() && !esMobile)
                {
                    var comunicados = comunicadoProvider.ObtenerComunicadoPorConsultora(userData, esMobile);

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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ValidarComunicadoPopup");
            }

            return tempComunicados;
        }

        public BECuponConsultora ObtenerCuponDesdeServicio()
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ObtenerCuponDesdeServicio");
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
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BienvenidaProvider.ExisteConsultoraEnAsesoraOnline");
                return 0;
            }
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
            
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, codigoConsultora, isoPais, "BienvenidaProvider.ValidarAsesoraOnlineConfiguracionPais");
            }

            return resultado;
        }

        #endregion
    }
}