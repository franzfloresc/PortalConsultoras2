using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.MiAcademia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceLMS;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MiAcademiaController : BaseController
    {
        private readonly MiAcademiaProvider _miAcademiaProvider;

        public MiAcademiaController()
        {
            _miAcademiaProvider = new MiAcademiaProvider(_configuracionManagerProvider);
        }
        public MiAcademiaController(MiAcademiaProvider miAcademiaProvider)
        {
            _miAcademiaProvider = miAcademiaProvider;
        }

        public ActionResult Index()
        {
            try
            {
                var idCurso = SessionManager.GetMiAcademia();
                var flagVideo = SessionManager.GetMiAcademiaVideo();
                var flagPdf = SessionManager.GetMiAcademiaPdf();
                var parametrosSap = SessionManager.GetMiAcademiaParametro();
                SessionManager.SetMiAcademia(0);
                SessionManager.SetMiAcademiaVideo(0);
                SessionManager.SetMiAcademiaPdf(0);

                var isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                var resultToken = _miAcademiaProvider.GetToken(userData, isoUsuario);

                if (resultToken.Success)
                {
                    var parametroUrl = _miAcademiaProvider.NewParametroUrl(userData, isoUsuario, resultToken.Data, idCurso);
                    parametroUrl.FlagVideo = flagVideo != 0;
                    parametroUrl.FlagPdf = flagPdf != 0;

                    string url = _miAcademiaProvider.GetUrlMiAcademia(parametroUrl);                    
                    if (parametrosSap.Length > 1 && parametrosSap.Contains("SAP")) url = url + "&" + parametrosSap;
                    return Redirect(url);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return View("Index");
        }

        public ActionResult Cursos(int idcurso)
        {
            try
            {
                var isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                var resultToken = _miAcademiaProvider.GetToken(userData, isoUsuario);

                if (resultToken.Success)
                {
                    var parametroUrl = _miAcademiaProvider.NewParametroUrl(userData, isoUsuario, resultToken.Data, idcurso);
                    return Redirect(_miAcademiaProvider.GetUrlMiAcademia(parametroUrl));
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return View("Index");
        }

        private List<MiCurso> ValidadCursosMA()
        {
            try
            {
                string urlMc = _miAcademiaProvider.GetUrl(Constantes.ConfiguracionManager.RelUrlMisCursos);
                string isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                urlMc = String.Format(urlMc, isoUsuario);

                string urlCurso = _miAcademiaProvider.GetUrl(Constantes.ConfiguracionManager.RelUrlCursoMiAcademia);
                string token = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.TokenMisCursos);
                int max = 4;

                using (WebClient client = new WebClient())
                {
                    client.Proxy = null;
                    client.Headers.Add("Content-Type", "application/json");
                    client.Headers.Add("token", token);
                    string json = client.DownloadString(urlMc);

                    if (!string.IsNullOrEmpty(json) && !json.Contains("Token not Valid"))
                    {
                        var model = JsonConvert.DeserializeObject<RootMiCurso>(json);
                        model.Cursos = model.Cursos ?? new List<MiCurso>();

                        var lstCursos = model.Cursos.OrderBy(x => x.estado).Take(max).ToList();
                        lstCursos.Update(x => x.url = string.Format(urlCurso, x.id));
                        return lstCursos.ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return new List<MiCurso>();
        }

        public JsonResult GetMisCursos()
        {
            try
            {
                List<MiCurso> misCursosMa = ValidadCursosMA();
                if (misCursosMa.Any())
                {
                    return Json(new
                    {
                        success = true,
                        data = misCursosMa,
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = false,
                    message = "Token not Valid",
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
