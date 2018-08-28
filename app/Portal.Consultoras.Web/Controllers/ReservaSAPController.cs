using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReservaSAPController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GenerarReserva(DateTime FechaGeneracion)
        {
            try
            {
                ServicePROLArchivoReserva.Respuesta[] respuesta;

                using (ServicePROLArchivoReserva.ReservaPedidos reserva = new ServicePROLArchivoReserva.ReservaPedidos())
                {
                    respuesta = reserva.GeneraReserva(userData.CodigoISO, FechaGeneracion.ToString("yyyy/MM/dd"), userData.CodigoUsuario);
                }

                if (respuesta.Length != 0)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "Respuesta Servicio PROL: " + respuesta[0].Descripcion,
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = true,
                    mensaje = "El servicio de PROL no envió una respuesta válida. Por favor, volver a intentar."
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = "Ocurrio un Error inesperado: " + ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
