using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.MiAcademia;
using Portal.Consultoras.Web.ServiceContenido;
using System.Data;

namespace Portal.Consultoras.Web.Providers
{
    public class MiAcademiaProvider
    {
        private readonly ConfiguracionManagerProvider _configuracionManager;

        public MiAcademiaProvider(ConfiguracionManagerProvider configuracionManagerProvider)
        {
            this._configuracionManager = configuracionManagerProvider;
        }

        public string GetUrl(Enumeradores.MiAcademiaUrl tipoUrl, ParamUrlMiAcademiaModel parametroUrl)
        {
            string keyUrl = GetKeyUrl(parametroUrl.IdCurso, tipoUrl);
            string url = _configuracionManager.GetConfiguracionManager(keyUrl);

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
            if (idCurso == 0) return Constantes.ConfiguracionManager.UrlLMS;
            switch (tipoUrl)
            {
                case Enumeradores.MiAcademiaUrl.Cursos: return Constantes.ConfiguracionManager.CursosMarquesina;
                case Enumeradores.MiAcademiaUrl.Video: return Constantes.ConfiguracionManager.UrlCursoMiAcademiaVideo;
                default: return "";
            }
        }

        public string GetEmailUsuario(UsuarioModel userData)
        {
            if (userData.EMail.Trim() != string.Empty) return userData.EMail.Trim();
            return userData.CodigoConsultora + "@notengocorreo.com";
        }

        public string GetNivelProyectado(UsuarioModel userData)
        {            
            DataSet parametros;
            using (ContenidoServiceClient csv = new ContenidoServiceClient())
            {
                parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
            }
            if (parametros == null || parametros.Tables.Count == 0) return "";
            return parametros.Tables[0].Rows[0][1].ToString();
        }
    }
}
