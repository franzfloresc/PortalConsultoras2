using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseGuiaNegocioController : BaseEstrategiaController
    {
        public virtual ActionResult ViewLanding()
        {
            ViewBag.CodigoRevistaActual = GetRevistaCodigoIssuu(userData.CampaniaID.ToString());
            ViewBag.CodigoRevistaAnterior = GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, -1, userData.NroCampanias).ToString());
            ViewBag.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).ToString());

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = userData.CampaniaID,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = new MensajeProductoBloqueadoModel(),
                CantidadFilas = 10
            };

            return PartialView("Index", model);
        }
    }
}