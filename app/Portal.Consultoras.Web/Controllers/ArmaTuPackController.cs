using System;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    [RoutePrefix("ArmaTuPack")]
    public class ArmaTuPackController : BaseController
    {
        public ActionResult Index()
        {
            throw new NotImplementedException();
        }

        [HttpGet()]
        [Route("Detalle/{cuv:int}")]
        public ActionResult Detalle(string cuv)
        {
            if (string.IsNullOrEmpty(cuv)) throw new ArgumentNullException("cuv", "is null or empty.");

            return View();
        }

        [HttpGet()]
        [Route("GetPackComponents/{cuv:int}")]
        public ActionResult GetPackComponents(string cuv)
        {
            if (string.IsNullOrEmpty(cuv)) throw new ArgumentNullException("cuv", "is null or empty.");

            return View();
        }

        public JsonResult GetComponentes(string Cuv2)
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    CampaniaID = userData.CampaniaID,
                    CUV2 = Cuv2
                };
                bool esMultimarca = false;
                string mensaje = "";
                var componentes = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo,
                    Constantes.TipoEstrategiaCodigo.ArmaTuPack, out esMultimarca, out mensaje);
                return Json(new
                {
                    success = true,
                    esMultimarca,
                    componentes,
                    mensaje
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                } , JsonRequestBehavior.AllowGet);
            }
        }
    }
}