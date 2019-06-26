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

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MiAcademiaController : BaseMobileController
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
                if (idCurso > 0) SessionManager.SetMiAcademia(0);

                var isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                var resultToken = _miAcademiaProvider.GetToken(userData, isoUsuario);

                if (resultToken.Success)
                {
                    var parametroUrl = _miAcademiaProvider.NewParametroUrl(userData, isoUsuario, resultToken.Data, idCurso);
                    return Redirect(_miAcademiaProvider.GetUrlMiAcademia(parametroUrl));
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return View();
        }

        public ActionResult IndexExterno(int IdOrigen = 0)
        {
            try
            {
                var idCurso = SessionManager.GetMiAcademia();
                if (idCurso > 0) SessionManager.SetMiAcademia(0);

                var isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                var resultToken = _miAcademiaProvider.GetToken(userData, isoUsuario);

                if (resultToken.Success)
                {
                    var parametroUrl = _miAcademiaProvider.NewParametroUrl(userData, isoUsuario, resultToken.Data, idCurso);
                    return Redirect(_miAcademiaProvider.GetUrlMiAcademia(parametroUrl));
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            ViewBag.origen = IdOrigen;
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
    }
}