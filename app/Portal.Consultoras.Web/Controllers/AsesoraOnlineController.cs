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
        private static string _isoPais;
        private static string _codigoConsultora;
        private static string _origen;

        public ActionResult Index(string param)
        {
            try
            {
                if (param.Length > 10)
                {
                    _isoPais = param.Substring(0, 2);
                    _codigoConsultora = param.Substring(2, 7);
                    _origen = param.Substring(9);
                }
            }
            catch (Exception ex)
            {
                _isoPais = String.Empty;
                _codigoConsultora = String.Empty;
                _origen = String.Empty;
                LogManager.LogManager.LogErrorWebServicesBus(ex, _codigoConsultora, _isoPais);
            }

            return View();
        }

        [HttpPost]
        public JsonResult EnviarFormulario(AsesoraOnlineModel model)
        {
            try
            {
                BEAsesoraOnline entidad = new BEAsesoraOnline
                {
                    CodigoConsultora = _codigoConsultora,
                    Origen = _origen,
                    Respuesta1 = Convert.ToInt32(model.Respuesta1),
                    Respuesta2 = Convert.ToInt32(model.Respuesta2),
                    Respuesta3 = Convert.ToInt32(model.Respuesta3),
                    Respuesta4 = Convert.ToInt32(model.Respuesta4),
                    Respuesta5 = Convert.ToInt32(model.Respuesta5),
                    ConfirmacionInscripcion = 1
                };

                int resultado;
                BEUsuario usuario;
                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    resultado = sv.EnviarFormulario(_isoPais, entidad);
                    usuario = sv.GetUsuarioByCodigoConsultora(_isoPais, _codigoConsultora);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, _codigoConsultora, _isoPais);
                return Json(new { success = false, message = ex.Message, extra = "" });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, _codigoConsultora, _isoPais);
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
            try
            {
                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    sv.ActualizarEstadoConfiguracionPaisDetalle(isoPais, codigoConsultora, 0);
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

        public ActionResult CancelarSuscripcion(string pais = "", string codconsultora = "")
        {
            ViewBag.Pais = pais;
            ViewBag.CodConsultora = codconsultora;
            ViewBag.Resultado = CancelaSuscripcion(pais, codconsultora);
            return View();
        }

        public string CancelaSuscripcion(string pais = "", string codconsultora = "")
        {
            var resul = "";
            try
            {
                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    resul = sv.CancelarSuscripcion(pais, codconsultora);
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, codconsultora, pais);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codconsultora, pais);
            }
            return resul;
        }

        public ActionResult VolverSuscripcion(string pais = "", string codconsultora = "")
        {
            ViewBag.Pais = pais;
            ViewBag.CodConsultora = codconsultora;
            ViewBag.Resultado = VuelveASuscripcion(pais, codconsultora);
            return View();
        }


        public int VuelveASuscripcion(string pais = "", string codconsultora = "")
        {
            var resul = 0;
            try
            {
                using (AsesoraOnlineServiceClient sv = new AsesoraOnlineServiceClient())
                {
                    resul = sv.VuelveASuscripcion(pais, codconsultora);
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, codconsultora, pais);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, codconsultora, pais);
            }
            return resul;
        }
    }
}