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
            int paisID = UserData().PaisID;
            int campaniaID = UserData().CampaniaID;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.SelectFeErratas(paisID, campaniaID).ToList();
            }

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
