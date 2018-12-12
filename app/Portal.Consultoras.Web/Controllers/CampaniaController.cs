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
            var paisId = userData.PaisID;
            IEnumerable<CampaniaModel> listaCampanias = _zonificacionProvider.GetCampanias(paisId);

            return Json(new { listaCampanias = listaCampanias }, JsonRequestBehavior.AllowGet);
        }
    }
}