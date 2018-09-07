using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CampaniaController : BaseController
    {
        [HttpGet]
        public JsonResult ListarCampanias()
        {
            var paisId = userData.PaisID;
            IEnumerable<CampaniaModel> listaCampanias = ObtenerCampaniasDesdeServicio(paisId);

            return Json(new { listaCampanias = listaCampanias }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> ObtenerCampaniasDesdeServicio(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }
    }
}