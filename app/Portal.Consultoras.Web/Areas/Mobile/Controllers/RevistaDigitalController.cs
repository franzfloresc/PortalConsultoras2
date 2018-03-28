using AutoMapper;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using System;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            try
            {
                return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public ActionResult Detalle(string cuv, int campaniaId)
        {
            try
            {

                return DetalleModel(cuv, campaniaId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
        }

        public ActionResult Informacion(string tipo)
        {
            try
            {
                ViewBag.TipoLayout = tipo;
                return IndexModel();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Comprar()
        {
            try
            {
                return ViewLanding(1);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                return ViewLanding(2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }
        
        public ActionResult MensajeBloqueado()
        {
            try
            {
                return PartialView("template-mensaje-bloqueado", MensajeProductoBloqueado());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PartialView("template-mensaje-bloqueado", new MensajeProductoBloqueadoModel());
        }

        [HttpPost]
        public JsonResult ActualizarDatos(MisDatosModel model)
        {
            try
            {
                var usuario = Mapper.Map<MisDatosModel, ServiceUsuario.BEUsuario>(model);

                string resultado = ActualizarMisDatos(usuario, model.CorreoAnterior);
                bool seActualizoMisDatos = resultado.Split('|')[0] != "0";
                string message = resultado.Split('|')[2];
                int cantidad = int.Parse(resultado.Split('|')[3]);

                if (!seActualizoMisDatos)
                {
                    return Json(new
                    {
                        success = false,
                        message,
                        Cantidad = cantidad,
                        extra = string.Empty
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message,
                        Cantidad = 0,
                        extra = string.Empty
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

    }
}