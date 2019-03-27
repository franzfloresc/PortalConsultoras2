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

        public CaminoBrillanteProvider()
        {}
        
        public BENivelCaminoBrillante ObtenerNivelActualConsultora()
        {
            try
            {
                var oResumen = ResumenConsultoraCaminoBrillante();
                if (oResumen == null || oResumen.NivelConsultora.Count() == 0 || oResumen.Niveles.Count() == 0) return null;
       

                var codNivel = oResumen.NivelConsultora.Where(x => x.Campania == UsuarioDatos.CampaniaID.ToString()).Select(z => z.NivelActual).FirstOrDefault();
                if (string.IsNullOrEmpty(codNivel)) codNivel = oResumen.NivelConsultora[0].NivelActual;
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

            using (var svc = new UsuarioServiceClient())
                return svc.GetConsultoraNivelCaminoBrillante(UsuarioDatos.PaisID, usuarioDatos);
        }
    }
}