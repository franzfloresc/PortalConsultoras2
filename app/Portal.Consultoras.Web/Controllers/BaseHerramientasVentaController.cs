//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.Models;
//using System.Web.Mvc;

//namespace Portal.Consultoras.Web.Controllers
//{
//    public class BaseHerramientasVentaController : BaseEstrategiaController
//    {
//        public ActionResult ViewLanding(int tipo)
//        {
//            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

//            var model = new RevistaDigitalLandingModel
//            {
//                CampaniaID = id,
//                IsMobile = IsMobile(),
//                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
//                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
//                Success = true,
//                MensajeProductoBloqueado = HVMensajeProductoBloqueado(),
//                CantidadFilas = 10
//            };

//            return PartialView("template-landing", model);
//        }

//    }
//}