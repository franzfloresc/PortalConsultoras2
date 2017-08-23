using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AsesoraOnlineController : Controller
    {
        // GET: AsesoraOnline
        public ActionResult Index(string isoPais, string codigoConsultora, string origen)
        {
            TempData["IsoPais"] = isoPais == null ? String.Empty : isoPais;
            TempData["CodigoConsultora"] = codigoConsultora == null ? String.Empty : codigoConsultora;
            TempData["Origen"] = origen == null ? String.Empty : origen;
            return View();
        }

        [HttpPost]
        public JsonResult EnviarFormulario(AsesoraOnlineModel model)
        {
            int resultado = 0;
            string isoPais = TempData["IsoPais"].ToString();
            try
            {
                BEAsesoraOnline entidad = new BEAsesoraOnline();
                entidad.CodigoConsultora = TempData["CodigoConsultora"].ToString();
                entidad.Origen = TempData["Origen"].ToString();
                entidad.Respuesta1 = Convert.ToInt32(model.Respuesta1);
                entidad.Respuesta2 = Convert.ToInt32(model.Respuesta2);
                entidad.Respuesta3 = Convert.ToInt32(model.Respuesta3);
                entidad.Respuesta4 = Convert.ToInt32(model.Respuesta4);
                entidad.ConfirmacionInscripcion = 1;

                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    resultado = sv.EnviarFormulario(isoPais, entidad);
                }
                if(!resultado.Equals(0))
                    return Json(new{success = true,message = "Se grabó con éxito el formulario.", extra = ""});
                else
                    return Json(new { success = false, message = "Ya existe la Consultora.", extra = "" });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, TempData["CodigoConsultora"].ToString(), isoPais);
                return Json(new{success = false, message = ex.Message,extra = ""});
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, TempData["CodigoConsultora"].ToString(), isoPais);
                return Json(new { success = false, message = ex.Message, extra = "" });
            }
        }
    }
}