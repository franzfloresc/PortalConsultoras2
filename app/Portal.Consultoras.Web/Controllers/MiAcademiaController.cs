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
                    var tipoUrl = flagVideo == 0 && flagPdf == 0 ? Enumeradores.MiAcademiaUrl.Cursos : flagPdf == 0 ? Enumeradores.MiAcademiaUrl.Video : Enumeradores.MiAcademiaUrl.Pdf;
                    var parametroUrl = _miAcademiaProvider.NewParametroUrl(userData, isoUsuario, resultToken.Data, idCurso);
                    string url = _miAcademiaProvider.GetUrl(tipoUrl, parametroUrl);                    
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
                    return Redirect(_miAcademiaProvider.GetUrl(Enumeradores.MiAcademiaUrl.Cursos, parametroUrl));
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
                string urlMc = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlMisCursos);
                string token = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.TokenMisCursos);
                string urlCurso = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlCursoMiAcademia);
                string isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                int max = 4;
                if (ViewBag.CodigoISODL == Constantes.CodigosISOPais.Venezuela) max = 3;
                urlMc = String.Format(urlMc, isoUsuario);

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

                        lstCursos.Update(x => x.url = String.Format(urlCurso, x.id));

                        return lstCursos.ToList();

                    }
                    else
                    {
                        return new List<MiCurso>();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new List<MiCurso>();
            }
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
