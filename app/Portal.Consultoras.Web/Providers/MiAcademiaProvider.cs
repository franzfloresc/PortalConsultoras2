using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.MiAcademia;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class MiAcademiaProvider
    {
        private static readonly string CodCreateUser = "002";
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

        public string GetUrl(string relUrl)
        {
            return _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlBaseMiAcademia) +
                _configuracionManager.GetConfiguracionManager(relUrl);
        }

        public string GetUrlMiAcademia(ParamUrlMiAcademiaModel parametroUrl)
        {
            string keyParamUrl = GetKeyParamMiAcademia(parametroUrl);
            var listParam = new List<string> { Constantes.MiAcademia.ParamUrl.Usuario, Constantes.MiAcademia.ParamUrl.Token };
            listParam.AddRange(_configuracionManager.GetConfiguracionManager(keyParamUrl).Split(','));
            var dicParam = listParam.Distinct().ToDictionary(p => p, p => GetValueParam(p, parametroUrl));

            string url = GetUrl(Constantes.ConfiguracionManager.RelUrlMiAcademia);
            return Util.Http.AddParamsToUrl(url, dicParam);
        }
        private string GetKeyParamMiAcademia(ParamUrlMiAcademiaModel parametroUrl)
        {
            if (parametroUrl.IdCurso == 0) return Constantes.ConfiguracionManager.ParamAcadListCurso;
            if(parametroUrl.FlagPdf) return Constantes.ConfiguracionManager.ParamAcadPdf;
            if (parametroUrl.FlagVideo) return Constantes.ConfiguracionManager.ParamAcadVideo;
            return Constantes.ConfiguracionManager.ParamAcadCurso;
        }
        private string GetValueParam(string param, ParamUrlMiAcademiaModel parametroUrl)
        {
            switch (param)
            {
                case Constantes.MiAcademia.ParamUrl.Usuario: return parametroUrl.IsoUsuario;
                case Constantes.MiAcademia.ParamUrl.Token: return parametroUrl.Token;
                case Constantes.MiAcademia.ParamUrl.CodClasif: return parametroUrl.CodigoClasificacion;
                case Constantes.MiAcademia.ParamUrl.CodSubClasif: return parametroUrl.CodigoSubClasificacion;
                case Constantes.MiAcademia.ParamUrl.DescSubClasif: return parametroUrl.DescripcionSubClasificacion;
                case Constantes.MiAcademia.ParamUrl.Curso:
                case Constantes.MiAcademia.ParamUrl.Video:
                case Constantes.MiAcademia.ParamUrl.Pdf: return parametroUrl.IdCurso.ToString();
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
            ServRespMiAcademiaModel resp;
            string key = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.secret_key);

            using (IMiAcademiaServ svc = NewMiAcademiaServ())
            {
                resp = svc.GetUser(isoUsuario, userData.CampaniaID.ToString(), key);
                if (resp.GetUserCod == CodCreateUser)
                {
                    string email = GetEmailUsuario(userData);
                    string nivelProyectado = GetNivelProyectado(userData);

                    var createUser = svc.CreateUser(userData, isoUsuario, email, nivelProyectado, key);
                    resp.CreateUserCod = createUser.CreateUserCod;
                    resp.Token = createUser.Token;
                }
            }

            var success = !ListCodErrorGetUser.Contains(resp.GetUserCod) && !ListCodErrorCreateUser.Contains(resp.CreateUserCod);
            return ResultModel<string>.Build(success, null, resp.Token);
        }
        private IMiAcademiaServ NewMiAcademiaServ()
        {
            string ambiente = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.Ambiente);
            if (ambiente == "PR") return new MiAcademiaServPrd();
            return new MiAcademiaServQa();
        }
    }

    interface IMiAcademiaServ : IDisposable
    {
        ServRespMiAcademiaModel GetUser(string isoUsuario, string campaniaID, string key);
        ServRespMiAcademiaModel CreateUser(UsuarioModel userData, string isoUsuario, string email, string nivelProyectado, string key);
    }

    class MiAcademiaServQa : IMiAcademiaServ
    {
        private readonly ServiceLMS_QA.ws_server svc;

        public MiAcademiaServQa() { svc = new ServiceLMS_QA.ws_server(); }

        public ServRespMiAcademiaModel GetUser(string isoUsuario, string campaniaID, string key)
        {
            var result = svc.ws_serverget_user(isoUsuario, campaniaID, key);
            return new ServRespMiAcademiaModel { GetUserCod = result.codigo, Token = result.token };
        }
        public ServRespMiAcademiaModel CreateUser(UsuarioModel userData, string isoUsuario, string email, string nivelProyectado, string key)
        {
            var result = svc.ws_servercreate_user(
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
                key
            );
            return new ServRespMiAcademiaModel { CreateUserCod = result.codigo, Token = result.token };
        }

        public void Dispose() {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        public void Dispose(bool disposing) { svc.Dispose(); }
    }

    class MiAcademiaServPrd : IMiAcademiaServ
    {
        private readonly ServiceLMS.ws_server svc;

        public MiAcademiaServPrd() { svc = new ServiceLMS.ws_server(); }

        public ServRespMiAcademiaModel GetUser(string isoUsuario, string campaniaID, string key)
        {
            var result = svc.ws_serverget_user(isoUsuario, campaniaID, key);
            return new ServRespMiAcademiaModel { GetUserCod = result.codigo, Token = result.token };
        }
        public ServRespMiAcademiaModel CreateUser(UsuarioModel userData, string isoUsuario, string email, string nivelProyectado, string key)
        {
            var result = svc.ws_servercreate_user(
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
                key
            );
            return new ServRespMiAcademiaModel { CreateUserCod = result.codigo, Token = result.token };
        }
        
        public void Dispose() {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        public void Dispose(bool disposing) { svc.Dispose(); }
    }
}
