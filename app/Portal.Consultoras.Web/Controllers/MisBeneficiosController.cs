using AutoMapper;
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
            if (sessionManager.GetUserData() != null)
            {
                IList<ServiceSAC.BEServicioCampania> lstTemp_1 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lstTemp_2 = new List<ServiceSAC.BEServicioCampania>();
                IList<ServiceSAC.BEServicioCampania> lst = new List<ServiceSAC.BEServicioCampania>();

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lstTemp_1 = sv.GetServicioByCampaniaPais(userData.PaisID, userData.CampaniaID).ToList();
                }

                int SegmentoID;
                if (userData.CodigoISO == "VE")
                {
                    SegmentoID = userData.SegmentoID;
                }
                else
                {
                    SegmentoID = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
                }
                int SegmentoServicio = userData.EsJoven == 1 ? 99 : SegmentoID;

                lstTemp_2 = lstTemp_1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString())).ToList();
                lst = lstTemp_2.Where(p => p.Segmento == "-1" || p.Segmento == SegmentoServicio.ToString()).ToList();
                
                return Json(new
                {
                    lista = Mapper.Map<IList<ServiceSAC.BEServicioCampania>, List<ServicioCampaniaModel>>(lst),
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
