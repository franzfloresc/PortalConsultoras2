using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisBeneficiosController : BaseController
    {
        public ActionResult Index()
        {
            ViewBag.CodigoISO_MB = userData.CodigoISO;
            return View();
        }

        [HttpGet]
        public JsonResult GetJsonProgramasBelcorp()
        {
            if (SessionManager.GetUserData() != null)
            {
                IList<BEServicioCampania> lstTemp1;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lstTemp1 = sv.GetServicioByCampaniaPais(userData.PaisID, userData.CampaniaID).ToList();
                }

                int segmentoId;
                if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    segmentoId = userData.SegmentoID;
                }
                else
                {
                    segmentoId = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
                }
                int segmentoServicio = userData.EsJoven == 1 ? 99 : segmentoId;

                IList<BEServicioCampania> lstTemp2 = lstTemp1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString())).ToList();
                IList<BEServicioCampania> lst = lstTemp2.Where(p => p.Segmento == "-1" || p.Segmento == segmentoServicio.ToString()).ToList();

                return Json(new
                {
                    lista = Mapper.Map<IList<BEServicioCampania>, List<ServicioCampaniaModel>>(lst),
                    exito = true,
                    codigoISO = userData.CodigoISO
                }, JsonRequestBehavior.AllowGet);
            }
            return Json(new
            {
                lista = new List<ServicioCampaniaModel>(),
                exito = false
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
