using Portal.Consultoras.Web.ServiceUnete;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class MiPerfilProvider
    {
        protected ISessionManager sessionManager;
        public MiPerfilProvider(ISessionManager sessionManager)
        {
            this.sessionManager = sessionManager;
        }

        public List<ParametroUneteBE> ObtenerUbigeoPrincipal(string CodigoISO)
        {
            List<ParametroUneteBE> result;
            Int32 param = 0;
            using (var sv = new PortalServiceClient())
            {
                result = sv.ObtenerParametrosUnete(CodigoISO, EnumsTipoParametro.LugarNivel1, param);
            }

            return result;
        }
        public ParametroUneteCollection ObtenerUbigeoDependiente(string CodigoISO , int Nivel , int IdPadre)
        {
            ParametroUneteCollection result;
            using (var sv = new PortalServiceClient())
            {
                EnumsTipoParametro NivelEnumerado = (EnumsTipoParametro)Nivel;
                result = sv.ObtenerParametrosUnete(CodigoISO, NivelEnumerado, IdPadre);
            }

            return result;
        }

    }
}