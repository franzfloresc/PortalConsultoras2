using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceLMS;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MiAcademiaController : BaseController
    {
        public ActionResult Index()
        {
            List<MiCurso> MisCursosMA = ValidadCursosMA();
            if (!MisCursosMA.Any())
            {
                return View("Index");
            }
            string key = ConfigurationManager.AppSettings["secret_key"];
            string urlLMS = ConfigurationManager.AppSettings["UrlLMS"];
            string token;
            string IsoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
            string eMailNoExiste = userData.CodigoConsultora + "@notengocorreo.com";
            string eMail = userData.EMail.ToString().Trim() == string.Empty ? eMailNoExiste : userData.EMail.ToString();
            bool exito = false;
            //Superate
            string CampaniaVenta = GetCampaniaLider(userData.PaisID, userData.ConsultoraID, userData.CodigoISO);
            string NivelProyectado = "";
            string SeccionGestionLider = "";
            DataSet parametros = null;

            using (ContenidoServiceClient csv = new ContenidoServiceClient())
            {
                parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
            }

            if (parametros != null && parametros.Tables.Count > 0)
            {
                SeccionGestionLider = parametros.Tables[0].Rows[0][0].ToString();
                NivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                SeccionGestionLider = SeccionGestionLider.Length == 0 ? "" : SeccionGestionLider.Substring(6);
            }

            ws_server svcLMS = new ws_server();
            result getUser = new result();
            result createUser = new result();

            getUser = svcLMS.ws_serverget_user(IsoUsuario, userData.CampaniaID.ToString(), key);
            token = getUser.token;

            if (getUser.codigo == "002")
            {
                createUser = svcLMS.ws_servercreate_user(IsoUsuario, userData.NombreConsultora, eMail, userData.CampaniaID.ToString(), userData.CodigorRegion, userData.CodigoZona, userData.SegmentoConstancia.ToString(), userData.SeccionAnalytics.ToString(), userData.Lider.ToString(), userData.NivelLider.ToString(), userData.CampaniaInicioLider.ToString(), userData.SeccionGestionLider.ToString(), NivelProyectado, key);
                token = createUser.token;
            }

            exito = true;

            if (getUser.codigo == "003" || getUser.codigo == "004" || getUser.codigo == "005" ||
                createUser.codigo == "002" || createUser.codigo == "003" || createUser.codigo == "004")
            {
                exito = false;
            }

            urlLMS = String.Format(urlLMS, IsoUsuario, token);

            return Redirect(exito ? urlLMS : HttpContext.Request.UrlReferrer.AbsoluteUri);

        }
   
        public ActionResult Cursos(int idcurso)
        {
            string key = ConfigurationManager.AppSettings["secret_key"];
            //string urlLMS = ConfigurationManager.AppSettings["UrlLMS"];
            string urlLMS = ConfigurationManager.AppSettings["CursosMarquesina"];
            string token;
            string IsoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
            string eMailNoExiste = userData.CodigoConsultora + "@notengocorreo.com";
            string eMail = userData.EMail.ToString().Trim() == string.Empty ? eMailNoExiste : userData.EMail.ToString();
            bool exito = false;
            //Superate
            string CampaniaVenta = GetCampaniaLider(userData.PaisID, userData.ConsultoraID, userData.CodigoISO);
            string NivelProyectado = "";
            string SeccionGestionLider = "";
            DataSet parametros = null;

            using (ContenidoServiceClient csv = new ContenidoServiceClient())
            {
                parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
            }

            if (parametros != null && parametros.Tables.Count > 0)
            {
                SeccionGestionLider = parametros.Tables[0].Rows[0][0].ToString(); 
                NivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                SeccionGestionLider = SeccionGestionLider.Length == 0 ? "" : SeccionGestionLider.Substring(6);
            }

            ws_server svcLMS = new ws_server();
            result getUser = new result();
            result createUser = new result();

            getUser = svcLMS.ws_serverget_user(IsoUsuario, userData.CampaniaID.ToString(), key);
            token = getUser.token;

            if (getUser.codigo == "002")
            {
                createUser = svcLMS.ws_servercreate_user(IsoUsuario, userData.NombreConsultora, eMail, userData.CampaniaID.ToString(), userData.CodigorRegion, userData.CodigoZona, userData.SegmentoConstancia.ToString(), userData.SeccionAnalytics.ToString(), userData.Lider.ToString(), userData.NivelLider.ToString(), userData.CampaniaInicioLider.ToString(), userData.SeccionGestionLider.ToString(), NivelProyectado, key);
                token = createUser.token;
            }

            exito = true;

            if (getUser.codigo == "003" || getUser.codigo == "004" || getUser.codigo == "005" ||
                createUser.codigo == "002" || createUser.codigo == "003" || createUser.codigo == "004")
            {
                exito = false;
            }

            urlLMS = String.Format(urlLMS, IsoUsuario, token, idcurso);

            //string html;
            //using (WebClient client = new WebClient())
            //{
            //    html = client.DownloadString(urlLMS);
            //}
            
            return Redirect(exito ? urlLMS : HttpContext.Request.UrlReferrer.AbsoluteUri);

        }

        private string GetCampaniaLider(int paisID, long ConsultoraID, string CodigoPais)
        {
            ContenidoServiceClient sv = new ContenidoServiceClient();
            return sv.GetLiderCampaniaActual(paisID, ConsultoraID, CodigoPais)[0].ToString();
        }

        private List<MiCurso> ValidadCursosMA() 
        {
            try
            {
                string urlMC = ConfigurationManager.AppSettings["UrlMisCursos"];
                string token = ConfigurationManager.AppSettings["TokenMisCursos"];
                string urlCurso = ConfigurationManager.AppSettings["UrlCursoMiAcademia"];
                string IsoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                int max = 4;
                if (ViewBag.CodigoISODL == "VE") max = 3;
                urlMC = String.Format(urlMC, IsoUsuario);

                using (WebClient client = new WebClient())
                {
                    client.Proxy = null;
                    client.Headers.Add("Content-Type", "application/json");
                    client.Headers.Add("token", token);
                    string json = client.DownloadString(urlMC);

                    if (!string.IsNullOrEmpty(json) && !json.Contains("Token not Valid"))
                    {
                        var model = JsonConvert.DeserializeObject<RootMiCurso>(json);

                        var lstCursos = model.Cursos.OrderBy(x => x.estado).Where(x => x.estado == "1").ToList().Take(max);

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
                return new List<MiCurso>();
            }
        }

        /* SB20-255 - INICIO */
        public JsonResult GetMisCursos()
        {
            try
            {
                List<MiCurso> MisCursosMA = ValidadCursosMA();
                if (MisCursosMA.Any())
                {
                    return Json(new
                    {
                        success = true,
                        data = MisCursosMA,
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
        /* SB20-255 - FIN */
    }
}
