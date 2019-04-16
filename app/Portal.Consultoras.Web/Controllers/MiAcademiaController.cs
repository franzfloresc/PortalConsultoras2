﻿using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
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
        public ActionResult Index()
        {
            var IdCurso = 0;
            var FlagVideo = 0;
            var parametrosSap = "";
            
            try
            {
                IdCurso = SessionManager.GetMiAcademia();
                FlagVideo = SessionManager.GetMiAcademiaVideo();
                parametrosSap = SessionManager.GetMiAcademiaParametro();
                SessionManager.SetMiAcademia(0);
                SessionManager.SetMiAcademiaVideo(0);

                string key = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.secret_key);
                string urlLms = _configuracionManagerProvider.GetConfiguracionManager(IdCurso == 0 ? Constantes.ConfiguracionManager.UrlLMS : Constantes.ConfiguracionManager.CursosMarquesina);
                string UrlCursoMiAcademiaVideo = _configuracionManagerProvider.GetConfiguracionManager(IdCurso == 0 ? Constantes.ConfiguracionManager.UrlLMS : Constantes.ConfiguracionManager.UrlCursoMiAcademiaVideo);
                string isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                string eMailNoExiste = userData.CodigoConsultora + "@notengocorreo.com";
                string eMail = userData.EMail.Trim() == string.Empty ? eMailNoExiste : userData.EMail;

                string nivelProyectado = "";
                DataSet parametros;

                /*HD-3777*/
                string codigoClasificacion = userData.CodigoClasificacion;
                string codigoSubClasificacion = userData.CodigoSubClasificacion;
                string descripcionSubClasificacion = userData.DescripcionSubclasificacion;
                /*Fin*/

                using (ContenidoServiceClient csv = new ContenidoServiceClient())
                {
                    parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                }

                if (parametros != null && parametros.Tables.Count > 0)
                {
                    nivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                }

                ws_server svcLms = new ws_server();
                result createUser = new result();

                var getUser = svcLms.ws_serverget_user(isoUsuario, userData.CampaniaID.ToString(), key);
                var token = getUser.token;

                if (getUser.codigo == "002")
                {
                    createUser = svcLms.ws_servercreate_user(
                        isoUsuario,
                        userData.NombreConsultora,
                        eMail,
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

                var exito = !(getUser.codigo == "003" || getUser.codigo == "004" || getUser.codigo == "005" ||
                              createUser.codigo == "002" || createUser.codigo == "003" || createUser.codigo == "004");

                /*HD-3777*/
                if (parametrosSap.Length > 1 && parametrosSap.Contains("SAP"))
                {
                    urlLms = IdCurso == 0 ? String.Format(urlLms, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion) : String.Format(urlLms, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion, IdCurso);
                    urlLms = urlLms + "&" + parametrosSap;
                    UrlCursoMiAcademiaVideo = IdCurso == 0 ? String.Format(urlLms, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion) : String.Format(UrlCursoMiAcademiaVideo, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion, IdCurso);
                    UrlCursoMiAcademiaVideo = UrlCursoMiAcademiaVideo + "&" + parametrosSap;
                }
                else
                {
                    urlLms = IdCurso == 0 ? String.Format(urlLms, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion) : String.Format(urlLms, isoUsuario, token, userData.CodigoClasificacion, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion, IdCurso);
                    UrlCursoMiAcademiaVideo = IdCurso == 0 ? String.Format(urlLms, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion) : String.Format(UrlCursoMiAcademiaVideo, isoUsuario, token, codigoClasificacion, codigoSubClasificacion, descripcionSubClasificacion, IdCurso);
                }
                /*Fin*/

                if (exito)
                {
                    if (FlagVideo == 0)
                    {
                        return Redirect(urlLms);
                    }
                    else
                    {
                        return Redirect(UrlCursoMiAcademiaVideo);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return View();
        }

        public ActionResult Cursos(int idcurso)
        {
            try
            {
                string key = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.secret_key);
                string urlLms = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.CursosMarquesina);
                string isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                string eMailNoExiste = userData.CodigoConsultora + "@notengocorreo.com";
                string eMail = userData.EMail.Trim() == string.Empty ? eMailNoExiste : userData.EMail;

                string nivelProyectado = "";
                DataSet parametros;

                using (ContenidoServiceClient csv = new ContenidoServiceClient())
                {
                    parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                }

                if (parametros != null && parametros.Tables.Count > 0)
                {
                    nivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                }

                ws_server svcLms = new ws_server();
                result createUser = new result();

                var getUser = svcLms.ws_serverget_user(isoUsuario, userData.CampaniaID.ToString(), key);
                var token = getUser.token;

                if (getUser.codigo == "002")
                {
                    createUser = svcLms.ws_servercreate_user(
                        isoUsuario,
                        userData.NombreConsultora,
                        eMail,
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

                var exito = !(getUser.codigo == "003" || getUser.codigo == "004" || getUser.codigo == "005" ||
                              createUser.codigo == "002" || createUser.codigo == "003" || createUser.codigo == "004");

                urlLms = String.Format(urlLms, isoUsuario, token, idcurso);

                if (HttpContext.Request.UrlReferrer != null)
                    return Redirect(exito ? urlLms : HttpContext.Request.UrlReferrer.AbsoluteUri);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return View();
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
