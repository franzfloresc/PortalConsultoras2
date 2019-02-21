using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaGrupoController :   BaseController
    {
        // tomar referencia de AdministrarEstrategiaMasivoController

        // GET: EstrategiaGrupo
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Guardar(List<EstrategiaGrupoModel> datos)
        {

            if (ModelState.IsValid)
            {
                //código servicio
                var dd = 123;
            }

                return Json(new { mensaje="ok", data= datos }, JsonRequestBehavior.AllowGet);
        }
    }
}