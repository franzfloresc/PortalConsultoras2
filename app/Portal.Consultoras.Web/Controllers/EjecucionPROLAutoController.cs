using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EjecucionPROLAutoController : BaseController
    {
        public ActionResult Index()
        {
            var model = GetEstadoProcesoPROLAutoDetalle();
            return View(model);
        }

        public PartialViewResult ListarProcesoParcial()
        {
            var model = GetEstadoProcesoPROLAutoDetalle();
            return PartialView("ListaProcesoPROL", model);
        }

        public ActionResult ListarProceso()
        {
            var model = GetEstadoProcesoPROLAutoDetalle();
            return PartialView("ListaProcesoPROL", model);
        }

        [HttpPost]
        public JsonResult EjecutarValidacionPROLAuto(string FechaFacturacion)
        {
            try
            {
                int respuesta;
                DateTime fechaHoraFacturacion = Convert.ToDateTime(FechaFacturacion);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    respuesta = sv.GetEstadoProcesoPROLAuto(UserData().PaisID, fechaHoraFacturacion);
                }

                string mensajeRespuesta = string.Empty;
                switch (respuesta)
                {
                    case Constantes.ValAutoEstado.NoExisteProceso:
                    case Constantes.ValAutoEstado.Finalizado:
                    case Constantes.ValAutoEstado.Error:
                        mensajeRespuesta = Constantes.ValAutoEjecucionResultado.Inicio;
                        break;
                    case Constantes.ValAutoEstado.Programado:
                    case Constantes.ValAutoEstado.EnEjecucion:
                    case Constantes.ValAutoEstado.FaltaEnvioCorreos:
                        mensajeRespuesta = Constantes.ValAutoEjecucionResultado.YaExisteProceso;
                        break;
                }
                mensajeRespuesta += string.Format(" (COD. {0})", respuesta);


                if (respuesta != -1000)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = mensajeRespuesta,
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "Hubo un problema al momento de Iniciar el Proceso. Por favor, volver a intentar."
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoUsuario, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = "Hubo un problema al momento de Iniciar el Proceso. Detalle Error:" + ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ValidacionAutomaticaModel GetEstadoProcesoPROLAutoDetalle()
        {
            var listValidacionAutomatica = new List<BEValidacionAutomatica>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listValidacionAutomatica = sv.GetEstadoProcesoPROLAutoDetalle(UserData().PaisID).ToList();
            }
            if (listValidacionAutomatica == null || listValidacionAutomatica.Count == 0) return null;

            var valAuto = listValidacionAutomatica[0];
            var model = new ValidacionAutomaticaModel { FechaFacturacion = GetFechaString(valAuto.FechaHoraFacturacion, "dd/MM/yyyy") };
            model.ListaValidacionAutomatica = new List<ValidacionAutomaticaDetalleModel>{
                new ValidacionAutomaticaDetalleModel {
                    Proceso = "Reserva de Pedido",
                    FechaHoraInicio = GetFechaString(valAuto.FechaHoraInicio, "dd/MM/yyyy hh:mm:ss"),
                    FechaHoraFin = GetFechaString(valAuto.FechaHoraFin, "dd/MM/yyyy hh:mm:ss"),
                    Estado =
                        valAuto.Estado == Constantes.ValAutoEstado.Error ? Constantes.ValAutoDetalleEstadoDescripcion.Error :
                        valAuto.Estado == Constantes.ValAutoEstado.Programado ? Constantes.ValAutoDetalleEstadoDescripcion.Programado :
                        valAuto.Estado == Constantes.ValAutoEstado.EnEjecucion ? Constantes.ValAutoDetalleEstadoDescripcion.EnEjecucion :
                        Constantes.ValAutoDetalleEstadoDescripcion.Finalizado
                },
                new ValidacionAutomaticaDetalleModel {
                    Proceso = "Envío de Correo",
                    FechaHoraInicio = GetFechaString(valAuto.FechaHoraInicioEnvio, "dd/MM/yyyy hh:mm:ss"),
                    FechaHoraFin = GetFechaString(valAuto.FechaHoraFinEnvio, "dd/MM/yyyy hh:mm:ss"),
                    Estado =
                        valAuto.Estado == Constantes.ValAutoEstado.Error ? Constantes.ValAutoDetalleEstadoDescripcion.Error :
                        valAuto.Estado == Constantes.ValAutoEstado.Finalizado ? Constantes.ValAutoDetalleEstadoDescripcion.Finalizado :
                        valAuto.Estado == Constantes.ValAutoEstado.FaltaEnvioCorreos ? Constantes.ValAutoDetalleEstadoDescripcion.EnEjecucion :
                        Constantes.ValAutoDetalleEstadoDescripcion.Programado
                }
            };
            return model;
        }

        private string GetFechaString(DateTime fechaHora, string format)
        {
            if (fechaHora.Year == 2000) return "";
            return fechaHora.ToString(format, CultureInfo.InvariantCulture);
        }
    }
}
