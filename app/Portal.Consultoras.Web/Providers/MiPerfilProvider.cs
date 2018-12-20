using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
        public async Task<List<ParametroUneteBE>> ObtenerUbigeoDependiente(string CodigoISO , int Nivel , int IdPadre)
        {
            List<ParametroUneteBE> result;
            using (var sv = new PortalServiceClient())
            {
                EnumsTipoParametro NivelEnumerado = (EnumsTipoParametro)Nivel;
                result = await sv.ObtenerParametrosUneteAsync(CodigoISO, NivelEnumerado, IdPadre);
            }

            return result;
        }
        public DireccionEntregaModel ObtenerDireccionPorConsultora(DireccionEntregaModel Direccion)
        {

            BEDireccionEntrega BlEntidad;
            DireccionEntregaModel response;
            var request = Mapper.Map<BEDireccionEntrega>(Direccion);
            using (var sv = new UsuarioServiceClient())
            {
                BlEntidad =sv.ObtenerDireccionPorConsultora(request);
            }
            response = Mapper.Map<DireccionEntregaModel>(BlEntidad);
            response.Operacion = response.DireccionEntregaID == 0 ? 0 : 1;
            return response;

        }

    }
}