using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class ProgramaNuevasProvider
    {
        private readonly ISessionManager sessionManager;
        private readonly UsuarioModel userData;

        public ProgramaNuevasProvider(ISessionManager _sessionManager)
        {
            sessionManager = _sessionManager;
            userData = sessionManager.GetUserData() ?? new UsuarioModel();
        }
        
        public BarraTippingPoint GetBarraTippingPoint(string codigoPrograma)
        {
            string nivel = Convert.ToString(userData.ConsecutivoNueva + 1).PadLeft(2, '0');
            try
            {
                BEActivarPremioNuevas beActive;
                BEEstrategia estrategia = null;
                List<PremioElectivoModel> listPremioElectivo = null;

                using (var sv = new PedidoServiceClient())
                {
                    beActive = sv.GetActivarPremioNuevas(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                    if (beActive == null) return new BarraTippingPoint();

                    if (beActive.ActivePremioAuto)
                    {
                        estrategia = sv.GetEstrategiaPremiosTippingPoint(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                        beActive.ActivePremioAuto = estrategia != null;
                    }
                }
                if (beActive.ActivePremioElectivo)
                {
                    listPremioElectivo = GetListPremioElectivo();
                    beActive.ActivePremioElectivo = listPremioElectivo != null && listPremioElectivo.Any();
                }

                var tippingPoint = Mapper.Map<BarraTippingPoint>(beActive);
                if (!tippingPoint.Active) return new BarraTippingPoint();

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
        public void SetBarraConsultoraTippingPoint(BarraConsultoraModel barra, BEConfiguracionProgramaNuevas configProgNuevas)
        {
            barra.TippingPointStr = "";
            if (!barra.TippingPointBarra.Active) return;
            
            barra.TippingPointBarra.InMinimo = configProgNuevas.IndExigVent == "0" || configProgNuevas.MontoVentaExigido == 0;
            bool tieneEscala = barra.MontoMaximo == 0;

            if (barra.TippingPointBarra.InMinimo) barra.TippingPoint = barra.MontoMinimo;
            else if (tieneEscala)
            {
                barra.TippingPointBarra.ActivePremioAuto = false;
                barra.TippingPointBarra.ActivePremioElectivo = false;
            }
            else barra.TippingPoint = configProgNuevas.MontoVentaExigido;

            barra.TippingPointStr = Util.DecimalToStringFormat(barra.TippingPoint, userData.CodigoISO);
        }
        public decimal GetTippingPointOF(BEConfiguracionProgramaNuevas configProgNuevas)
        {
            var inMinimo = configProgNuevas.IndExigVent == "0" || configProgNuevas.MontoVentaExigido == 0;

            if (inMinimo) return userData.MontoMinimo;
            return configProgNuevas.MontoVentaExigido;
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
        public List<PremioElectivoModel> GetListPremioElectivo()
        {
            return Util.GetOrCalcValue(sessionManager.GetListPremioElectivo, sessionManager.SetListPremioElectivo, (i) => i == null, CalcListPremioElectivo);
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
        private List<PremioElectivoModel> CalcListPremioElectivo()
        {
            var configuracionProgramaNuevas = GetConfiguracion();
            string codigoPrograma = configuracionProgramaNuevas.CodigoPrograma;

            try
            {
                BEEstrategia[] estrategias;
                using (var sv = new PedidoServiceClient())
                {
                    estrategias = sv.GetEstrategiaPremiosElectivos(userData.PaisID, codigoPrograma, userData.CampaniaID);
                }
                if(estrategias == null) return new List<PremioElectivoModel>();
                
                var list = Mapper.Map<BEEstrategia[], List<PremioElectivoModel>>(estrategias);
                list.ForEach(item => item.ImagenURL = GetUrlTippingPoint(item.ImagenURL));
                return list;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return new List<PremioElectivoModel>();
        }

        private string GetUrlTippingPoint(string noImagen)
        {
            string url = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, noImagen ?? "");
            return url;
        }
    }
}