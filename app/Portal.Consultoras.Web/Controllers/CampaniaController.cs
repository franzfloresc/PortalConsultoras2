using Portal.Consultoras.Web.Models;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CampaniaController : BaseAdmController
    {
        [HttpGet]
        public JsonResult ListarCampanias()
        {
            IEnumerable<CampaniaModel> listaCampanias = _zonificacionProvider.GetCampanias(userData.PaisID);

            return Json(new { listaCampanias = listaCampanias }, JsonRequestBehavior.AllowGet);
        }
    }
}