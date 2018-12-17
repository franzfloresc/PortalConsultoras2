using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Models.Common;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ComunController : BaseController
    {
        [ValidateAjaxModel]
        [HttpPost]
        public ActionResult InsertarLogDymnamo(InLogUsabilidadModel Log)
        {
            RegistrarLogDynamoDB(Log);
            return Json(new 
            {
                success = true,
                message = "Ok."
            });
        }
    }
}