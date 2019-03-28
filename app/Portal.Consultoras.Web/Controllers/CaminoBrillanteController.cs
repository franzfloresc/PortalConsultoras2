using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteController : BaseController
    {
        #region CaminoBrillante
        // GET: CaminoBrillante
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetNiveles()
        {
            var informacion = SessionManager.GetConsultoraCaminoBrillante();
            var _NivealActual = Convert.ToInt32(informacion.NivelConsultora[0].NivelActual) - 1;
            for (int i = 0; i <= informacion.Niveles.Count() - 1; i++)
            {
                informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{DIMEN}", "MDPI");

                if (i <= _NivealActual)
                    informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{STATE}", "A");
                else
                    informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{STATE}", "I");
            }
            //return Json(new { list = informacion.Niveles, informacion.NivelConsultora[0].NivelActual }, JsonRequestBehavior.AllowGet);
            return Json(new { list = informacion, informacion.NivelConsultora[0].NivelActual }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult MisLogros()
        {
            var oLogros = new List<MisLogrosCaminoBrillanteModel>();
            var oIndicadoresCre = new List<Indicador>();
            var oIndicadoresCom = new List<Indicador>();

            oIndicadoresCre.Add(new Indicador()
            {
                Titulo = "Ganancia",
                Valor = "25",
                UrlImagen = "/CAMINOBRILLANTE/DESKTOP/NIVELES/NIVEL_{0}.svg"
            });

            oIndicadoresCre.Add(new Indicador()
            {
                Titulo = "Ganancia",
                Valor = "8",
                UrlImagen = "/CAMINOBRILLANTE/DESKTOP/NIVELES/NIVEL_{0}.svg"
            });

            oIndicadoresCre.Add(new Indicador()
            {
                Titulo = "Ganancia",
                Valor = "5",
                UrlImagen = "/CAMINOBRILLANTE/DESKTOP/NIVELES/NIVEL_{0}.svg"
            });

            oLogros.Add(new MisLogrosCaminoBrillanteModel()
            {
                Titulo = "Crecimiento",
                Descripcion = "Tu progreso tiene recompensas",
                Indicador = oIndicadoresCre
            });

            for (int i = 1; i < 3; i++)
            {
                oIndicadoresCom.Add(new Indicador()
                {
                    Titulo = "",
                    Valor = "",
                    UrlImagen = ""
                });
            }

            oLogros.Add(new MisLogrosCaminoBrillanteModel()
            {
                Titulo = "Compromiso",
                Descripcion = "Tu compromiso tiene recompensas",
                Indicador = oIndicadoresCom
            });
            return Json(new { list = oLogros }, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}