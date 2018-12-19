using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;
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
        public List<UsuarioOpcionesModel> GetUsuarioOpciones(int paisId, string codigoUsuario, bool sesion = false)
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