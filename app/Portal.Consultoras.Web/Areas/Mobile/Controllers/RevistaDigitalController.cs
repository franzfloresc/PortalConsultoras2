using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
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

        public ActionResult RDMensajeBloqueadoDetalle()
        {
            MensajeProductoBloqueadoModel modelo;
            try
            {
                modelo = RDMensajeProductoBloqueadoLan();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                modelo = new MensajeProductoBloqueadoModel();
            }
            return PartialView("template-mensaje-bloqueado-Lan-Detalle", modelo);
        }

        public virtual MensajeProductoBloqueadoModel RDMensajeProductoBloqueadoLan()
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();
            string codigo;

            if (revistaDigital.EsSuscrita)
            {
                model.MensajeIconoSuperior = true;
                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaSuscrita;
                model.BtnInscribirse = false;
            }
            else
            {
                model.MensajeIconoSuperior = false;
                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaNoSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaNoSuscrita;
                model.BtnInscribirse = true;
            }

            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            model.MensajeTitulo = dato == null ? "" : Util.Trim(dato.Valor1);

            return model;
        }

        [HttpPost]
        public JsonResult ActualizarDatos(MisDatosModel model)
        {
            try
            {
                var usuario = Mapper.Map<MisDatosModel, ServiceUsuario.BEUsuario>(model);

                string resultado = ActualizarMisDatos(usuario, model.CorreoAnterior);
                var lstRes = resultado.Split('|');

                bool seActualizoMisDatos = lstRes[0] != "0";
                string message = lstRes.Length >= 3 ? lstRes[2] : "";

                if (seActualizoMisDatos)
                {
                    return Json(new
                    {
                        success = true,
                        message,
                        Cantidad = 0,
                        extra = string.Empty
                    });
                }

                int cantidad = lstRes.Length >= 4 ? int.Parse(lstRes[3]) : 0;
                return Json(new
                {
                    success = false,
                    message,
                    Cantidad = cantidad,
                    extra = string.Empty
                });
                
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

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