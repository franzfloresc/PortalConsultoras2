using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.MiAcademia;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceLMS;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.Web.Providers
{
    public class MiAcademiaProvider
    {
        private static readonly List<string> ListCodErrorGetUser = new List<string> { "003", "004", "005" };
        private static readonly List<string> ListCodErrorCreateUser = new List<string> { "002", "003", "004" };

        private readonly ConfiguracionManagerProvider _configuracionManager;

        public MiAcademiaProvider(ConfiguracionManagerProvider configuracionManagerProvider)
        {
            this._configuracionManager = configuracionManagerProvider;
        }

        public ParamUrlMiAcademiaModel NewParametroUrl(UsuarioModel userData, string isoUsuario, string token, int idCurso)
        {
            return new ParamUrlMiAcademiaModel
            {
                IsoUsuario = isoUsuario,
                Token = token,
                CodigoClasificacion = userData.CodigoClasificacion,
                CodigoSubClasificacion = userData.CodigoSubClasificacion,
                DescripcionSubClasificacion = userData.DescripcionSubclasificacion,
                IdCurso = idCurso
            };
        }

        public string GetUrl(Enumeradores.MiAcademiaUrl tipoUrl, ParamUrlMiAcademiaModel parametroUrl)
        {
            string keyUrl = GetKeyUrl(parametroUrl.IdCurso, tipoUrl);
            string url = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlMiAcademia) +
                _configuracionManager.GetConfiguracionManager(keyUrl);

            return string.Format(
                url,
                parametroUrl.IsoUsuario,
                parametroUrl.Token,
                parametroUrl.CodigoClasificacion,
                parametroUrl.CodigoSubClasificacion,
                parametroUrl.DescripcionSubClasificacion,
                parametroUrl.IdCurso
            );
        }
        private string GetKeyUrl(int idCurso, Enumeradores.MiAcademiaUrl tipoUrl)
        {
            if (idCurso == 0) return Constantes.ConfiguracionManager.ParamAcadListCurso;
            switch (tipoUrl)
            {
                case Enumeradores.MiAcademiaUrl.Cursos: return Constantes.ConfiguracionManager.ParamAcadCurso;
                case Enumeradores.MiAcademiaUrl.Video: return Constantes.ConfiguracionManager.ParamAcadVideo;
                case Enumeradores.MiAcademiaUrl.Pdf: return Constantes.ConfiguracionManager.ParamAcadPdf;
                default: return "";
            }
        }

        private string GetEmailUsuario(UsuarioModel userData)
        {
            if (userData.EMail.Trim() != string.Empty) return userData.EMail.Trim();
            return userData.CodigoConsultora + "@notengocorreo.com";
        }
        private string GetNivelProyectado(UsuarioModel userData)
        {            
            DataSet parametros;
            using (ContenidoServiceClient csv = new ContenidoServiceClient())
            {
                parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
            }
            if (parametros == null || parametros.Tables.Count == 0) return "";
            return parametros.Tables[0].Rows[0][1].ToString();
        }
        
        public ResultModel<string> GetToken(UsuarioModel userData, string isoUsuario)
        {
            var token = "";
            result getUser, createUser = new result();

            using (ws_server svcLms = new ws_server())
            {
                string key = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.secret_key);
                getUser = svcLms.ws_serverget_user(isoUsuario, userData.CampaniaID.ToString(), key);
                token = getUser.token;

                if (getUser.codigo == "002")
                {
                    string email = GetEmailUsuario(userData);
                    string nivelProyectado = GetNivelProyectado(userData);

                    createUser = svcLms.ws_servercreate_user(
                        isoUsuario,
                        userData.NombreConsultora,
                        email,
                        userData.CampaniaID.ToString(),
                        userData.CodigorRegion,
                        userData.CodigoZona,
                        userData.SegmentoConstancia,
                        userData.SeccionAnalytics,
                        userData.Lider.ToString(),
                        userData.NivelLider.ToString(),
                        userData.CampaniaInicioLider,
                        userData.SeccionGestionLider,
                        nivelProyectado,
                        key);
                    token = createUser.token;
                }
            }

            var success = !ListCodErrorGetUser.Contains(getUser.codigo) && !ListCodErrorCreateUser.Contains(createUser.codigo);
            return ResultModel<string>.Build(success, null, token);
        }
    }
}
