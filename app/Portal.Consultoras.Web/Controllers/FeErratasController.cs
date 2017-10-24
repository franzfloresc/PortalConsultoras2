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
            // TODO: comentado temporalmente
            //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "FeErratas/Index"))
            //    return RedirectToAction("Index", "Bienvenida");

            List<BEFeErratas> lst;
            int paisID = UserData().PaisID;
            int campaniaID = UserData().CampaniaID;
            string iso = UserData().CodigoISO;

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
