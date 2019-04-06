using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;
using System.Web;

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
                var oResumen = sessionManager.GetConsultoraCaminoBrillante();
                if (oResumen == null)
                {
                    oResumen = ResumenConsultoraCaminoBrillante();
                    if (oResumen != null)  sessionManager.SetConsultoraCaminoBrillante(oResumen);
                } 
                if (oResumen == null || oResumen.NivelConsultora.Count() == 0 || oResumen.Niveles.Count() == 0) return null;                
                var codNivel = oResumen.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();
                return oResumen.Niveles.Where(x => x.CodigoNivel == codNivel).FirstOrDefault();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UsuarioDatos.CodigoConsultora, UsuarioDatos.CodigoISO);
                return null;
            }
        }

        public BEConsultoraCaminoBrillante ResumenConsultoraCaminoBrillante()
        {
            var usuarioDatos = new ServiceUsuario.BEUsuario();
            usuarioDatos.CodigoConsultora = UsuarioDatos.CodigoConsultora;
            usuarioDatos.CampaniaID = UsuarioDatos.CampaniaID;
            usuarioDatos.Region = UsuarioDatos.CodigorRegion;
            usuarioDatos.Zona = UsuarioDatos.CodigoZona;
            usuarioDatos.PaisID = UsuarioDatos.PaisID;

            usuarioDatos.ConsultoraNueva = UsuarioDatos.ConsultoraNueva; //ConsultoraNueva Validar con viector
            usuarioDatos.ConsecutivoNueva = UsuarioDatos.ConsecutivoNueva;

            using (var svc = new UsuarioServiceClient())
                return svc.GetConsultoraNivelCaminoBrillante(UsuarioDatos.PaisID, usuarioDatos, true);
        }
    }
}