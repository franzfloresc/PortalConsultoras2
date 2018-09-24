using System;
using System.Threading.Tasks;
using System.Linq;
using System.Collections.Generic;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Common;
using AutoMapper;

namespace Portal.Consultoras.Web.Providers
{
    public class RevistaDigitalProvider : OfertaBaseProvider
    {
        protected ISessionManager sessionManager;
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
        protected ConfiguracionManagerProvider _configuracionManager;
        private readonly ILogManager logManager = LogManager.LogManager.Instance;

        public RevistaDigitalProvider() : this(SessionManager.SessionManager.Instance, new ConfiguracionManagerProvider())
        {
        }

        public RevistaDigitalProvider(ISessionManager sessionManager, ConfiguracionManagerProvider configuracionManager)
        {
            this.sessionManager = SessionManager.SessionManager.Instance;
            this._configuracionManager = configuracionManager;
        }


        public RevistaDigitalInformativoModel InformativoModel(bool esMobile)
        {
            int limiteMinimoTelef, limiteMaximoTelef;
            Util.GetLimitNumberPhone(userData.PaisID, out limiteMinimoTelef, out limiteMaximoTelef);
            var modelo = new RevistaDigitalInformativoModel();
            modelo.EsSuscrita = revistaDigital.EsSuscrita;
            modelo.EstadoSuscripcion = revistaDigital.EstadoSuscripcion;
            modelo.Video = GetVideoInformativo(esMobile);
            modelo.UrlTerminosCondiciones = GetValorDato(Constantes.ConfiguracionManager.RDUrlTerminosCondiciones, esMobile);
            modelo.UrlPreguntasFrecuentes = (revistaDigital.SuscripcionEfectiva.Origen == Constantes.RevistaDigitalOrigen.Unete || revistaDigital.SuscripcionEfectiva.Origen == Constantes.RevistaDigitalOrigen.Nueva) ?
                                            GetValorDato(Constantes.ConfiguracionManager.RDUrlPreguntasFrecuentes, esMobile, 2) :
                                            GetValorDato(Constantes.ConfiguracionManager.RDUrlPreguntasFrecuentes, esMobile);
            modelo.Origen = revistaDigital.SuscripcionEfectiva.Origen;
            modelo.NombreConsultora = userData.Sobrenombre.ToUpper();
            modelo.Email = userData.EMail;
            modelo.Celular = userData.Celular;
            modelo.LimiteMax = limiteMaximoTelef;
            modelo.LimiteMin = limiteMinimoTelef;
            modelo.UrlTerminosCondicionesDatosUsuario = GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);
            modelo.CampaniaX1 = Util.AddCampaniaAndNumero(userData.CampaniaID, revistaDigital.CantidadCampaniaEfectiva, userData.NroCampanias).ToString().Substring(4);
            modelo.MostrarCancelarSuscripcion = !(userData.esConsultoraLider && revistaDigital.SociaEmpresariaExperienciaGanaMas &&
                ((!revistaDigital.EsSuscrita && (!revistaDigital.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion || !revistaDigital.SociaEmpresariaSuscritaActivaCancelarSuscripcion)) ||
                (revistaDigital.EsSuscrita && !revistaDigital.EsActiva && !revistaDigital.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion) ||
                (revistaDigital.EsSuscrita && revistaDigital.EsActiva && !revistaDigital.SociaEmpresariaSuscritaActivaCancelarSuscripcion)));
            modelo.CancelarSuscripcion = CancelarSuscripcion(revistaDigital.SuscripcionEfectiva.Origen, userData.CodigoISO);
            modelo.EsSuscripcionInmediata = EsSuscripcionInmediata();
            return modelo;
        }

        public string GetVideoInformativo(bool esMobile)
        {
            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RD.InformativoVideo) ?? new ConfiguracionPaisDatosModel();
            return Util.Trim(esMobile ? dato.Valor2 : dato.Valor1);
        }

        public string GetValorDato(string codigo, bool esMobile, int valor = 1)
        {
            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            var valorDato = "";
            switch (valor)
            {
                case 0: valorDato = esMobile ? dato.Valor2 : dato.Valor1; break;
                case 1: valorDato = dato.Valor1; break;
                case 2: valorDato = dato.Valor2; break;
                case 3: valorDato = dato.Valor3; break;
                default: valorDato = dato.Valor1; break;
            }
            return Util.Trim(valorDato);
        }

        public bool CancelarSuscripcion(string origen, string pais)
        {
            if (origen.IsNullOrEmptyTrim())
                return false;

            if (origen.Equals(Constantes.RevistaDigitalOrigen.Unete))
            {
                return _configuracionManager.GetConfiguracionManagerContains(Constantes.ConfiguracionManager.PaisesCancelarSuscripcionRDUnete, pais);
            }
            else if (origen.Equals(Constantes.RevistaDigitalOrigen.Nueva))
            {
                return _configuracionManager.GetConfiguracionManagerContains(Constantes.ConfiguracionManager.PaisesCancelarSuscripcionRDNuevas, pais);
            }

            return false;
        }

        public bool EsSuscripcionInmediata()
        {
            if (revistaDigital.TieneRDC && revistaDigital.SuscripcionModel != null)
            {
                return
                    (
                        revistaDigital.SuscripcionEfectiva.CampaniaEfectiva == revistaDigital.SuscripcionModel.CampaniaID
                        && revistaDigital.SuscripcionModel.CampaniaID > 0
                    ) || (
                        revistaDigital.SuscripcionModel.CampaniaID == 0
                        && revistaDigital.CantidadCampaniaEfectiva == 0
                    ) || (
                        revistaDigital.SuscripcionEfectiva.CampaniaEfectiva < userData.CampaniaID
                        && revistaDigital.CantidadCampaniaEfectiva == 0
                    );
            }

            return false;
        }

        public string GetUrlTerminosCondicionesDatosUsuario(string codigoIso)
        {
            var nombreCarpetaTc = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.NombreCarpetaTC);
            var nombreArchivoTc = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.NombreArchivoTC) + ".pdf";
            return ConfigCdn.GetUrlFileCdn(nombreCarpetaTc, codigoIso + "/" + nombreArchivoTc);
        }

        public List<ConfiguracionPaisDatosModel> GetConfiguracionPaisDatosPorComponente(int campaniaid, string componente)
        {
            List<ConfiguracionPaisDatosModel> listaEntidad;
            try
            {
                var beEntidad = new ServiceUsuario.BEConfiguracionPaisDatos
                {
                    PaisID = userData.PaisID,
                    CampaniaID = campaniaid,
                    Componente = componente,
                    ConfiguracionPais = new ServiceUsuario.BEConfiguracionPais
                    {
                        Codigo = Constantes.ConfiguracionPais.RevistaDigital
                    }
                };

                using (var sv = new UsuarioServiceClient())
                {
                    var beEntidades = sv.GetConfiguracionPaisComponenteDatos(beEntidad).ToList();

                    listaEntidad = Mapper.Map<IList<ServiceUsuario.BEConfiguracionPaisDatos>, List<ConfiguracionPaisDatosModel>>(beEntidades);
                }
            }
            catch (Exception ex)
            {
                listaEntidad = new List<ConfiguracionPaisDatosModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.PaisID.ToString());
            }
            return listaEntidad;
        }

        public string RegistroSuscripcionValidar(int tipo)
        {
            var diasFaltanFactura = Util.GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            switch (tipo)
            {
                case Constantes.EstadoRDSuscripcion.Activo:
                    if (!revistaDigital.TieneRDC)
                        return "Por el momento no está habilitada la suscripción a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (revistaDigital.EsSuscrita)
                        return "Usted ya está suscrito a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
                    {
                        return "Lo sentimos no puede suscribirse a " + revistaDigital.NombreComercialActiva + ", porque "
                            + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                            + " es cierre de campaña.";
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.Desactivo:
                    if (!revistaDigital.TieneRDC)
                        return "Por el momento no está habilitada la desuscripción a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (!revistaDigital.EsSuscrita)
                        return "Lo sentimos no se puede desuscribirse a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
                    {
                        return "Lo sentimos no puede desuscribirse a " + revistaDigital.NombreComercialActiva + ", porque "
                            + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                            + " es cierre de campaña.";
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.NoPopUp:
                    if (!revistaDigital.TieneRDC)
                        return "Por el momento no está habilitada esta acción, gracias.";

                    if (revistaDigital.EsSuscrita)
                        return "Lo sentimos no se puede ejecutar esta acción, gracias.";

                    if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
                    {
                        return "Lo sentimos no puede ejecutar esta acción, porque "
                            + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                            + " es cierre de campaña.";
                    }
                    break;
                default:
                    return "Lo sentimos no se puede ejecutar esta acción, gracias.";
            }

            return "";
        }

        public void RegistroSuscripcionVirtualCoach()
        {
            if (revistaDigital.SubscripcionAutomaticaAVirtualCoach)
            {
                var asesoraOnLine = new BEAsesoraOnline
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    ConfirmacionInscripcion = 1,
                    Origen = Constantes.RevistaDigitalOrigen.RD
                };
                using (var sv = new AsesoraOnlineServiceClient())
                {
                    sv.EnviarFormulario(userData.CodigoISO, asesoraOnLine);
                }
            }
        }

        public string GetCodigoEstrategia()
        {
            var codigo = Constantes.TipoEstrategiaCodigo.OfertaParaTi;
            if (revistaDigital.TieneRevistaDigital())
            {
                codigo = Constantes.TipoEstrategiaCodigo.RevistaDigital;
            }
            return codigo;
        }
    }
}