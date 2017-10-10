using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using System;
using System.Configuration;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AsesoraOnlineController : Controller
    {
        private static string IsoPais;
        private static string CodigoConsultora;
        private static string Origen;
        // GET: AsesoraOnline        
        public ActionResult Index(string param)
        {
            try
            {
                if (param.Length > 10)
                {
                    IsoPais = param.Substring(0, 2);
                    CodigoConsultora = param.Substring(2, 7);
                    Origen = param.Substring(9);
                }
            }
            catch (Exception ex)
            {
                IsoPais = String.Empty;
                CodigoConsultora = String.Empty;
                Origen = String.Empty;
                LogManager.LogManager.LogErrorWebServicesBus(ex, CodigoConsultora, IsoPais);
            }

            return View();
        }

        [HttpPost]
        public JsonResult EnviarFormulario(AsesoraOnlineModel model)
        {
            int resultado = 0;
            ServiceAsesoraOnline.BEUsuario usuario = new ServiceAsesoraOnline.BEUsuario();
            try
            {
                BEAsesoraOnline entidad = new BEAsesoraOnline();
                entidad.CodigoConsultora = CodigoConsultora;
                entidad.Origen = Origen;
                entidad.Respuesta1 = Convert.ToInt32(model.Respuesta1);
                entidad.Respuesta2 = Convert.ToInt32(model.Respuesta2);
                entidad.Respuesta3 = Convert.ToInt32(model.Respuesta3);
                entidad.Respuesta4 = Convert.ToInt32(model.Respuesta4);
                entidad.Respuesta5 = Convert.ToInt32(model.Respuesta5);
                entidad.ConfirmacionInscripcion = 1;

                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    resultado = sv.EnviarFormulario(IsoPais, entidad);
                    usuario = sv.GetUsuarioByCodigoConsultora(IsoPais, CodigoConsultora);
                    //no-responder@somosbelcorp.com
                    //esikateasesora@belcorp.biz
                    if (resultado.Equals(1))
                    {
                        var from = ConfigurationManager.AppSettings[Constantes.ConstSession.EmailAsesoraOnline] ?? "";
                        var titulo = string.Format("{0}, BIENVENIDA A ÉSIKA MI GUÍA DIGITAL", usuario.Sobrenombre).ToUpper();
                        sv.EnviarMailBienvenidaAsesoraOnline(from, usuario.EMail, titulo, "SomosBelcorp", usuario.Nombre);
                    }
                }

                return Json(new { success = true, message = "Se proceso correctamente.", extra = "", usuario = usuario, resultado = resultado });
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

        [HttpPost]
        public JsonResult ActualizarEstadoConfiguracionPaisDetalle(string isoPais, string codigoConsultora)
        {
            int resultado = 0;
            try
            {
                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    int desactivado = 0;
                    resultado = sv.ActualizarEstadoConfiguracionPaisDetalle(isoPais, codigoConsultora, desactivado);
                }

                return Json(new { success = true, message = "Se actualizó con éxito." });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, codigoConsultora, isoPais);
                return Json(new { success = false, message = ex.Message });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codigoConsultora, isoPais);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente."
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}