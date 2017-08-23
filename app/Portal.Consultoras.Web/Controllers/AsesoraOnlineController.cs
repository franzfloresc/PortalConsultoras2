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
        private static string IsoPais;
        private static string CodigoConsultora;
        private static string Origen;
        // GET: AsesoraOnline
        public ActionResult Index(string isoPais, string codigoConsultora, string origen)
        {
            IsoPais = isoPais == null ? String.Empty : isoPais;
            CodigoConsultora = codigoConsultora == null ? String.Empty : codigoConsultora;
            Origen = origen == null ? String.Empty : origen;
            return View();
        }

        [HttpPost]
        public JsonResult EnviarFormulario(AsesoraOnlineModel model)
        {
            int resultado = 0;
            BEUsuario usuario = new BEUsuario();
            try
            {
                BEAsesoraOnline entidad = new BEAsesoraOnline();
                entidad.CodigoConsultora = CodigoConsultora;
                entidad.Origen = Origen;
                entidad.Respuesta1 = Convert.ToInt32(model.Respuesta1);
                entidad.Respuesta2 = Convert.ToInt32(model.Respuesta2);
                entidad.Respuesta3 = Convert.ToInt32(model.Respuesta3);
                entidad.Respuesta4 = Convert.ToInt32(model.Respuesta4);
                entidad.ConfirmacionInscripcion = 1;

                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    resultado = sv.EnviarFormulario(IsoPais, entidad);
                }

                if (resultado.Equals(-1))
                    return Json(new { success = false, message = "Ya existe la Consultora.", extra = "" });

                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    usuario = sv.GetUsuarioByCodigoConsultora(IsoPais, CodigoConsultora);
                }

                return Json(new { success = true, message = "Se grabó con éxito el formulario.", extra = "", usuario = usuario });
                   
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, CodigoConsultora, IsoPais);
                return Json(new { success = false, message = ex.Message, extra = "" });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, CodigoConsultora, IsoPais);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}