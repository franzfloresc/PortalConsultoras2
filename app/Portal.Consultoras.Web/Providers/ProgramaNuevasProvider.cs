using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Configuration;

namespace Portal.Consultoras.Web.Providers
{
    public class ProgramaNuevasProvider
    {
        public virtual ISessionManager SessionManager { get; private set; }
        private ConfiguracionManagerProvider _configuracionManager;

        private UsuarioModel userData
        {
            get
            {
                return SessionManager.GetUserData() ?? new UsuarioModel();
            }
        }

        public ProgramaNuevasProvider()
        {
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas()
        {
            if (SessionManager.GetConfiguracionProgramaNuevas() != null) return SessionManager.GetConfiguracionProgramaNuevas();
            try
            {
                var consultoraNuevas = Mapper.Map<BEConsultoraProgramaNuevas>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    SessionManager.SetConfiguracionProgramaNuevas(sv.GetConfiguracionProgramaNuevas(consultoraNuevas) ?? new BEConfiguracionProgramaNuevas());
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                SessionManager.SetConfiguracionProgramaNuevas(new BEConfiguracionProgramaNuevas());
            }
            return SessionManager.GetConfiguracionProgramaNuevas();
        }

        public string GetCuvKitNuevas()
        {
            if (SessionManager.GetCuvKitNuevas() != null) return SessionManager.GetCuvKitNuevas();
            try
            {
                var consultoraNuevas = Mapper.Map<BEConsultoraProgramaNuevas>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    SessionManager.SetCuvKitNuevas(sv.GetCuvKitNuevas(consultoraNuevas, GetConfiguracionProgramaNuevas()) ?? "");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                SessionManager.SetCuvKitNuevas("");
            }
            return SessionManager.GetCuvKitNuevas();
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
            string urlExtension = string.Format("{0}/{1}", _configuracionManager.GetConfiguracionManager(ConfigurationManager.AppSettings["Matriz"] ?? ""), userData.CodigoISO ?? "");
            string url = ConfigCdn.GetUrlFileCdn(urlExtension, noImagen ?? "");
            return url;
        }
    }
}