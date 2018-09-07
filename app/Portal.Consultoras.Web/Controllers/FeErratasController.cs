using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FeErratasController : BaseController
    {
        public JsonResult Index()
        {
            List<BEFeErratas> lst;
            int paisId = userData.PaisID;
            int campaniaId = userData.CampaniaID;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.SelectFeErratas(paisId, campaniaId).ToList();
            }

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
