using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class MiPerfilProvider
    {
        protected ISessionManager sessionManager;

        public MiPerfilProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        public List<ParametroUneteBE> ObtenerUbigeoPrincipal(string CodigoISO)
        {
            var datos = sesion ? sessionManager.GetUsuarioOpciones() : null;
            if (datos == null)
            {
                datos = ObtenerUsuarioOpciones(paisId, codigoUsuario);
                if (sesion)
                {
                    sessionManager.SetUsuarioOpciones(datos);
                }
            }
            return datos;
        }

        public virtual List<UsuarioOpcionesModel> ObtenerUsuarioOpciones(int paisId, string codigoUsuario)
        {
            using (var usuario = new UsuarioServiceClient())
            {
                var datos = usuario.GetUsuarioOpciones(paisId, codigoUsuario);
                return Mapper.Map<IEnumerable<BEUsuarioOpciones>, List<UsuarioOpcionesModel>>(datos);
            }
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