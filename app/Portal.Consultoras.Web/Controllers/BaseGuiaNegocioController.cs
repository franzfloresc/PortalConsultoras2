//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Web.Providers;
//using System.Web.Mvc;

//namespace Portal.Consultoras.Web.Controllers
//{
//    public class BaseGuiaNegocioController : BaseEstrategiaController
//    {
//        private readonly IssuuProvider _issuuProvider;

//        public BaseGuiaNegocioController()
//        {
//            _issuuProvider = new IssuuProvider();
//        }

//        public virtual ActionResult ViewLanding()
//        {
//            ViewBag.CodigoRevistaActual = _issuuProvider.GetRevistaCodigoIssuu(userData.CampaniaID.ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
//            ViewBag.CodigoRevistaAnterior = _issuuProvider.GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, -1, userData.NroCampanias).ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
//            ViewBag.CodigoRevistaSiguiente = _issuuProvider.GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);

//            var model = new RevistaDigitalLandingModel
//            {
//                CampaniaID = userData.CampaniaID,
//                IsMobile = IsMobile(),
//                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
//                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
//                Success = true,
//                MensajeProductoBloqueado = new MensajeProductoBloqueadoModel(),
//                CantidadFilas = 10
//            };

//            return PartialView("Index", model);
//        }
//    }
//}