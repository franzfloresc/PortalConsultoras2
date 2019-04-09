using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;
using AutoMapper;

namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        private UsuarioModel usuarioModel { get { return sessionManager.GetUserData(); }}
        private BEUsuario _userData { get { return Mapper.Map<BEUsuario>(usuarioModel); }}
        private string codigoNivel;

        public BENivelCaminoBrillante ObtenerNivelActualConsultora()
        {
            try
            {
                var oConsultora = ResumenConsultoraCaminoBrillante();  
                if (oConsultora == null || oConsultora.NivelConsultora.Count() == 0 || oConsultora.Niveles.Count() == 0) return null;
                codigoNivel = oConsultora.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                return oConsultora.Niveles.Where(x => x.CodigoNivel == codigoNivel).FirstOrDefault();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, _userData.CodigoConsultora, _userData.CodigoISO);
                return null;
            }
        }

        public BEConsultoraCaminoBrillante ResumenConsultoraCaminoBrillante()
        {
            var resumen = sessionManager.GetConsultoraCaminoBrillante();
            if (resumen == null)
            {
                using (var svc = new UsuarioServiceClient())
                    resumen = svc.GetConsultoraNivelCaminoBrillante(_userData);
            }

            if (resumen != null) sessionManager.SetConsultoraCaminoBrillante(resumen);
            return resumen;
        }

        public List<BEKitCaminoBrillante> GetKitCaminoBrillante()
        {
            try
            {
                var ofertas = sessionManager.GetKitCaminoBrillante();
                if (ofertas == null || ofertas.Count == 0)
                {
                    var oConsultora = sessionManager.GetConsultoraCaminoBrillante();
                    using (var svc = new UsuarioServiceClient())
                        ofertas = svc.GetKitsCaminoBrillante(_userData, 201903, Convert.ToInt32(codigoNivel)).ToList();
                    if (ofertas != null)
                        sessionManager.SetKitCaminoBrillante(ofertas);
                }

                return ofertas;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, _userData.CodigoConsultora, _userData.CodigoISO);
                return null;
            }
        }

        public List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante()
        {
            try
            {
                var ofertas = sessionManager.GetDemostradoresCaminoBrillante();
                if (ofertas == null || ofertas.Count == 0)
                {
                    using (var svc = new UsuarioServiceClient())
                        ofertas = svc.GetDemostradoresCaminoBrillante(_userData.PaisID, "201904").ToList();
                    if (ofertas != null)
                        sessionManager.SetDemostradoresCaminoBrillante(ofertas);
                }

                return ofertas;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, _userData.CodigoConsultora, _userData.CodigoISO);
                return null;
            }
        }
    }
}