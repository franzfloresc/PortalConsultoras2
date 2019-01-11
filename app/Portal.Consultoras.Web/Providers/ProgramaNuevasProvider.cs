using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ProgramaNuevas;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
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
            string nivel = userData.ConfigPremioProgNuevas.CodigoNivel;
            try
            {
                BEActivarPremioNuevas beActive;
                BEEstrategia estrategia = null;

                using (var sv = new PedidoServiceClient())
                {
                    beActive = sv.GetActivarPremioNuevas(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                    if (beActive == null) return new BarraTippingPoint();
                    
                    if (beActive.ActivePremioAuto) beActive.ActivePremioAuto = userData.ConfigPremioProgNuevas.PremioAuto != null;
                    if (beActive.ActivePremioAuto && beActive.ActiveTooltip)
                    {
                        estrategia = sv.GetEstrategiaPremiosTippingPoint(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
                    }
                }
                if (beActive.ActivePremioElectivo)
                {
                    var listPremioElectivo = GetListPremioElectivo();
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
                if (tippingPoint.ActivePremioElectivo) tippingPoint.HasListEstrategiaElectivo = GetListPremioElectivo().Any();

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

            if (barra.TippingPointBarra.InMinimo) barra.TippingPoint = barra.MontoMinimo;
            else barra.TippingPoint = configProgNuevas.MontoVentaExigido;

            barra.TippingPointStr = Util.DecimalToStringFormat(barra.TippingPoint, userData.CodigoISO);
        }

        public ConsultoraRegaloProgramaNuevasOFModel GetConsultoraRegaloProgNuevasOF(PremioProgNuevasModel premio)
        {
            var configProgNuevas = GetConfiguracion();
            var model = new ConsultoraRegaloProgramaNuevasOFModel
            {
                CodigoNivel = userData.ConfigPremioProgNuevas.CodigoNivel,
                TippingPoint = GetTippingPointOF(configProgNuevas)
            };

            var premioOF = GetPremioProgNuevasOF(premio);
            model.DescripcionPremio = premioOF.DescripcionPremio;
            model.UrlImagenRegalo = premioOF.UrlImagenRegalo;
            model.PrecioValorizado = premioOF.PrecioValorizado;
            model.PrecioValorizadoFormat = Util.DecimalToStringFormat(model.PrecioValorizado, userData.CodigoISO);

            return model;
        }
        private PremioProgNuevasOFModel GetPremioProgNuevasOF(PremioProgNuevasModel premio)
        {
            var dictPremioOF = sessionManager.GetDictPremioProgNuevasOF() ?? new Dictionary<string, PremioProgNuevasOFModel>();
            if(dictPremioOF.ContainsKey(premio.Cuv)) return dictPremioOF[premio.Cuv];

            var premioOF = GetPremioProgNuevasOFFromCatalogoSap(premio);
            dictPremioOF.Add(premio.Cuv, premioOF);
            sessionManager.SetDictPremioProgNuevasOF(dictPremioOF);
            return premioOF;
        }
        private PremioProgNuevasOFModel GetPremioProgNuevasOFFromCatalogoSap(PremioProgNuevasModel premio)
        {
            var premioOF = new PremioProgNuevasOFModel {
                Cuv = premio.Cuv,
                DescripcionPremio = premio.DescripcionPremio,
                PrecioValorizado = premio.PrecioValorizado
            };

            try
            {
                Producto producto = null;
                if (!string.IsNullOrEmpty(premio.CodigoSap))
                {
                    using (var svc = new ProductoServiceClient())
                    {
                        var lst = svc.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, userData.CampaniaID, premio.CodigoSap, 3).ToList();
                        producto = lst.FirstOrDefault();
                    }
                }
                
                if (producto != null)
                {
                    var dd = (!string.IsNullOrEmpty(producto.NombreComercial)
                        ? producto.NombreComercial
                        : producto.DescripcionComercial);
                    if (!string.IsNullOrEmpty(dd)) premioOF.DescripcionPremio = dd;

                    if (producto.PrecioValorizado > 0) premioOF.PrecioValorizado = producto.PrecioValorizado;
                    premioOF.UrlImagenRegalo = producto.Imagen;
                }
                premioOF.DescripcionPremio = premioOF.DescripcionPremio.ToUpper();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return premioOF;
        }
        private decimal GetTippingPointOF(BEConfiguracionProgramaNuevas configProgNuevas)
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
            string nivel = userData.ConfigPremioProgNuevas.CodigoNivel;

            try
            {
                BEEstrategia[] estrategias;
                using (var sv = new PedidoServiceClient())
                {
                    estrategias = sv.GetEstrategiaPremiosElectivos(userData.PaisID, codigoPrograma, userData.CampaniaID, nivel);
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