using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        protected ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        public UsuarioModel UsuarioDatos
        {
            get { return sessionManager.GetUserData(); }
        }

        public BENivelCaminoBrillante ObtenerNivelActualConsultora()
        {
            try
            {
                var oConsultora = ResumenConsultoraCaminoBrillante();  
                if (oConsultora == null || oConsultora.NivelConsultora.Count() == 0 || oConsultora.Niveles.Count() == 0) return null;                
                var codNivel = oConsultora.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                return oConsultora.Niveles.Where(x => x.CodigoNivel == codNivel).FirstOrDefault();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UsuarioDatos.CodigoConsultora, UsuarioDatos.CodigoISO);
                return null;
            }
        }

        public BEConsultoraCaminoBrillante ResumenConsultoraCaminoBrillante()
        {
            var resumen = sessionManager.GetConsultoraCaminoBrillante();
            if (resumen == null)
            {
                var usuarioDatos = new BEUsuario();
                usuarioDatos.CodigoConsultora = UsuarioDatos.CodigoConsultora;
                usuarioDatos.CampaniaID = UsuarioDatos.CampaniaID;
                usuarioDatos.Region = UsuarioDatos.CodigorRegion;
                usuarioDatos.Zona = UsuarioDatos.CodigoZona;
                usuarioDatos.PaisID = UsuarioDatos.PaisID;
                usuarioDatos.ConsultoraNueva = UsuarioDatos.ConsultoraNueva; //ConsultoraNueva Validar con Victor
                usuarioDatos.ConsecutivoNueva = UsuarioDatos.ConsecutivoNueva;

                using (var svc = new UsuarioServiceClient())
                return svc.GetConsultoraNivelCaminoBrillante(usuarioDatos);
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
                    var user = new BEUsuario()
                    {
                        CampaniaID = UsuarioDatos.CampaniaID
                    };

                    var oConsultora = sessionManager.GetConsultoraCaminoBrillante();
                    using (var svc = new UsuarioServiceClient())
                        ofertas = svc.GetKitCaminoBrillante(user, 201903, 0).ToList();
                    if (ofertas != null)
                        sessionManager.SetKitCaminoBrillante(ofertas);
                }

                return ofertas;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UsuarioDatos.CodigoConsultora, UsuarioDatos.CodigoISO);
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
                        ofertas = svc.GetDemostradoresCaminoBrillante(UsuarioDatos.PaisID, "201904").ToList();
                    if (ofertas != null)
                        sessionManager.SetDemostradoresCaminoBrillante(ofertas);
                }

                return ofertas;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UsuarioDatos.CodigoConsultora, UsuarioDatos.CodigoISO);
                return null;
            }
        }
    }
}