using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EjecucionPROLAutoController : BaseController
    {
        public ActionResult Index()
        {
            ValidacionAutomaticaModel model = new ValidacionAutomaticaModel();
            List<BEValidacionAutomatica> listaValidacion = GetEstadoProcesoPROLAutoDetalle();
            model.ListaValidacionAutomatica = listaValidacion;

            return View(model);
        }

        public PartialViewResult ListarProcesoParcial()
        {
            ValidacionAutomaticaModel model = new ValidacionAutomaticaModel();
            List<BEValidacionAutomatica> listaValidacion = GetEstadoProcesoPROLAutoDetalle();
            model.ListaValidacionAutomatica = listaValidacion;

            return PartialView("ListaProcesoPROL", model);
        }

        public ActionResult ListarProceso()
        {
            ValidacionAutomaticaModel model = new ValidacionAutomaticaModel();
            List<BEValidacionAutomatica> listaValidacion = GetEstadoProcesoPROLAutoDetalle();
            model.ListaValidacionAutomatica = listaValidacion;

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
                    case -1:
                        mensajeRespuesta = "El proceso de PROL Automático ha iniciado. (COD. 001)";
                        break;
                    case 0:
                        mensajeRespuesta = "El proceso de PROL Automático esta en proceso. (COD. 000)";
                        break;
                    case 1:
                        mensajeRespuesta = "El proceso de PROL Automático esta en proceso (COD. 001)";
                        break;
                    case 2:
                        mensajeRespuesta = "El proceso de PROL Automático ha iniciado. (COD. 002)";
                        break;
                    case 3:
                        mensajeRespuesta = "El proceso de PROL Automático esta en proceso (COD. 003)";
                        break;
                    case 99:
                        mensajeRespuesta = "El proceso de PROL Automático ha iniciado. (COD. 099)";
                        break;
                }


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

        public List<BEValidacionAutomatica> GetEstadoProcesoPROLAutoDetalle()
        {
            List<BEValidacionAutomatica> listaValidacion;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaValidacion = sv.GetEstadoProcesoPROLAutoDetalle(UserData().PaisID).ToList();
            }
            return listaValidacion;
        }

    }
}
