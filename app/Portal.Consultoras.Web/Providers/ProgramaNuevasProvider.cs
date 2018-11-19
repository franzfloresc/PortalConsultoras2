using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Configuration;

namespace Portal.Consultoras.Web.Providers
{
    public class ProgramaNuevasProvider
    {
        private readonly ISessionManager sessionManager;
        private readonly ConfiguracionManagerProvider configuracionManager;
        private readonly UsuarioModel userData;

        public ProgramaNuevasProvider(ISessionManager _sessionManager)
        {
            sessionManager = _sessionManager;
            configuracionManager = new ConfiguracionManagerProvider();
            userData = sessionManager.GetUserData() ?? new UsuarioModel();
        }

        public BEConfiguracionProgramaNuevas GetConfiguracion()
        {
            return Util.GetOrCalcValue(sessionManager.GetConfiguracionProgNuevas, sessionManager.SetConfiguracionProgramaNuevas, (s) => s == null, CalcConfiguracion);
        }
        public string GetCuvKit()
        {
            return Util.GetOrCalcValue(sessionManager.GetCuvKitNuevas, sessionManager.SetCuvKitNuevas, (s) => s == null, CalcCuvKit);
        }
        public string GetMensajeKit()
        {
            return Util.GetOrCalcValue(sessionManager.GetMensajeKitNuevas, sessionManager.SetMensajeKitNuevas, (s) => s == null, CalcMensajeKit);
        }
        public int GetLimElectivos()
        {
            return Util.GetOrCalcValue(sessionManager.GetLimElectivosProgNuevas, sessionManager.SetLimElectivosProgNuevas, (i) => i == 0, CalcLimElectivos);
        }

        private BEConfiguracionProgramaNuevas CalcConfiguracion()
        {
            try
            {
                var consultoraNuevas = Mapper.Map<BEConsultoraProgramaNuevas>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    return sv.GetConfiguracionProgramaNuevas(consultoraNuevas) ?? new BEConfiguracionProgramaNuevas();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new BEConfiguracionProgramaNuevas();
            }
        }
        private string CalcCuvKit()
        {
            try
            {
                var consultoraNuevas = Mapper.Map<BEConsultoraProgramaNuevas>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    return sv.GetCuvKitNuevas(consultoraNuevas, GetConfiguracion()) ?? "";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "";
            }
        }
        private string CalcMensajeKit()
        {
            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    return sv.GetMensajeKitNuevas(userData.CodigoISO, userData.EsConsultoraNueva, userData.ConsecutivoNueva);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "";
            }
        }
        private int CalcLimElectivos()
        {
            try
            {
                var consultoraNuevas = Mapper.Map<BEConsultoraProgramaNuevas>(userData);
                using (var sv = new ODSServiceClient())
                {
                    return sv.GetLimElectivosProgNuevas(userData.PaisID, userData.CampaniaID, userData.ConsecutivoNueva, userData.CodigoPrograma);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return 1;
            }
        }

        public BarraTippingPoint GetTippingPoint(string TippingPointStr, string codigoPrograma)
        {
            string nivel = Convert.ToString(userData.ConsecutivoNueva + 1).PadLeft(2, '0');
            try
            {
                BEActivarPremioNuevas beActive;
                BEEstrategia estrategia = null;

                using (var sv = new PedidoServiceClient())
                {
                    beActive = sv.GetActivarPremioNuevas(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                    if (beActive == null || !beActive.Active) return new BarraTippingPoint();

                    if (beActive.ActiveTooltip) estrategia = sv.GetEstrategiaPremiosTippingPoint(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                }

                var tippingPoint = Mapper.Map<BarraTippingPoint>(beActive);
                tippingPoint.TippingPointMontoStr = TippingPointStr;
                if (tippingPoint.ActiveTooltip)
                {
                    if (estrategia != null)
                    {
                        tippingPoint = Mapper.Map(estrategia, tippingPoint);
                        tippingPoint.LinkURL = GetUrlTippingPoint(estrategia.ImagenURL);
                    }
                    else tippingPoint.ActiveTooltip = false;
                }

                return tippingPoint;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new BarraTippingPoint();
            }
        }

        private string GetUrlTippingPoint(string noImagen)
        {
            string urlExtension = string.Format("{0}/{1}", configuracionManager.GetConfiguracionManager(ConfigurationManager.AppSettings["Matriz"] ?? ""), userData.CodigoISO ?? "");
            string url = ConfigCdn.GetUrlFileCdn(urlExtension, noImagen ?? "");
            return url;
        }
    }
}