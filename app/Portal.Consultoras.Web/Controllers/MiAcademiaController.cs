using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceLMS;
using System;
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

            string key = ConfigurationManager.AppSettings["secret_key"];
            string urlLMS = ConfigurationManager.AppSettings["UrlLMS"];
            string token;
            string IsoUsuario = UserData().CodigoISO + '-' + UserData().CodigoConsultora;
            string eMailNoExiste = UserData().CodigoConsultora + "@notengocorreo.com";
            string eMail = UserData().EMail.ToString().Trim() == string.Empty ? eMailNoExiste : UserData().EMail.ToString();
            bool exito = false;
            //Superate
            string CampaniaVenta = GetCampaniaLider(UserData().PaisID, UserData().ConsultoraID, UserData().CodigoISO);
            string NivelProyectado = "";
            string SeccionGestionLider = "";
            DataSet parametros = null;

            using (ContenidoServiceClient csv = new ContenidoServiceClient())
            {
                parametros = csv.ObtenerParametrosSuperateLider(UserData().PaisID, UserData().ConsultoraID, UserData().CampaniaID);
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

            getUser = svcLMS.ws_serverget_user(IsoUsuario, UserData().CampaniaID.ToString(), key);
            token = getUser.token;

            if (getUser.codigo == "002")
            {
                createUser = svcLMS.ws_servercreate_user(IsoUsuario, UserData().NombreConsultora, eMail, UserData().CampaniaID.ToString(), UserData().CodigorRegion, UserData().CodigoZona, UserData().SegmentoConstancia.ToString(), UserData().SeccionAnalytics.ToString(), UserData().Lider.ToString(), UserData().NivelLider.ToString(), UserData().CampaniaInicioLider.ToString(), UserData().SeccionGestionLider.ToString(), NivelProyectado, key);
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
            string IsoUsuario = UserData().CodigoISO + '-' + UserData().CodigoConsultora;
            string eMailNoExiste = UserData().CodigoConsultora + "@notengocorreo.com";
            string eMail = UserData().EMail.ToString().Trim() == string.Empty ? eMailNoExiste : UserData().EMail.ToString();
            bool exito = false;
            //Superate
            string CampaniaVenta = GetCampaniaLider(UserData().PaisID, UserData().ConsultoraID, UserData().CodigoISO);
            string NivelProyectado = "";
            string SeccionGestionLider = "";
            DataSet parametros = null;

            using (ContenidoServiceClient csv = new ContenidoServiceClient())
            {
                parametros = csv.ObtenerParametrosSuperateLider(UserData().PaisID, UserData().ConsultoraID, UserData().CampaniaID);
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

            getUser = svcLMS.ws_serverget_user(IsoUsuario, UserData().CampaniaID.ToString(), key);
            token = getUser.token;

            if (getUser.codigo == "002")
            {
                createUser = svcLMS.ws_servercreate_user(IsoUsuario, UserData().NombreConsultora, eMail, UserData().CampaniaID.ToString(), UserData().CodigorRegion, UserData().CodigoZona, UserData().SegmentoConstancia.ToString(), UserData().SeccionAnalytics.ToString(), UserData().Lider.ToString(), UserData().NivelLider.ToString(), UserData().CampaniaInicioLider.ToString(), UserData().SeccionGestionLider.ToString(), NivelProyectado, key);
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

        /* SB20-255 - INICIO */
        public JsonResult GetMisCursos()
        {
            try
            {
                string urlMC = ConfigurationManager.AppSettings["UrlMisCursos"];
                string token = ConfigurationManager.AppSettings["TokenMisCursos"];
                string urlCurso = ConfigurationManager.AppSettings["UrlCursoMiAcademia"];
                string IsoUsuario = UserData().CodigoISO + '-' + UserData().CodigoConsultora;
                int max = 4;
                if (ViewBag.CodigoISODL == "VE") max = 3;
                urlMC = String.Format(urlMC, IsoUsuario);

                using (WebClient client = new WebClient())
                {
                    client.Headers.Add("Content-Type", "application/json");
                    client.Headers.Add("token", token);
                    string json = client.DownloadString(urlMC);

                    if (!string.IsNullOrEmpty(json) && !json.Contains("Token not Valid"))
                    {
                        var model = JsonConvert.DeserializeObject<RootMiCurso>(json);

                        var lstCursos = model.Cursos.OrderBy(x => x.estado).ToList().Take(max);

                        lstCursos.Update(x => x.url = String.Format(urlCurso, x.id));

                        return Json(new
                        {
                            success = true,
                            data = lstCursos,
                        }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Token not Valid",
                        }, JsonRequestBehavior.AllowGet);
                    }
                }
            }
            catch(Exception ex)
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
