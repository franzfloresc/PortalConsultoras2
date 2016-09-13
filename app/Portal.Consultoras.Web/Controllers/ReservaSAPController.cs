using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReservaSAPController : BaseController
    {
        //
        // GET: /ReservaSAP/

        public ActionResult Index()
        {
            return View();
        }

        //R2293
        [HttpPost]
        public JsonResult GenerarReserva(DateTime FechaGeneracion)
        {

            string mensaje = string.Empty;
            try
            {

                if (FechaGeneracion.ToShortDateString() == "01/01/0001")
                    mensaje += "La Fecha de Generación no tiene el formato correcto, verifique yyyy/MM/dd. \n";

                ServicePROLArchivoReserva.Respuesta[] respuesta = null;

                using (ServicePROLArchivoReserva.ReservaPedidos reserva = new ServicePROLArchivoReserva.ReservaPedidos())
                {
                    respuesta = reserva.GeneraReserva(UserData().CodigoISO, FechaGeneracion.ToString("yyyy/MM/dd"), UserData().CodigoUsuario);
                }

                if (respuesta.Length != 0)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "Respuesta Servicio PROL: " + respuesta[0].Descripcion,
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El servicio de PROL no envió una respuesta válida. Por favor, volver a intentar."
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoUsuario, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = "Ocurrio un Error inesperado: " + ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
