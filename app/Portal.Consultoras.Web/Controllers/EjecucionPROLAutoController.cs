using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;

//R2073 - Toda la clase
namespace Portal.Consultoras.Web.Controllers
{
    public class EjecucionPROLAutoController : BaseController
    {
        //
        // GET: /EjecucionPROLAuto/

        public ActionResult Index()
        {
            ValidacionAutomaticaModel model = new ValidacionAutomaticaModel();
            List<BEValidacionAutomatica> ListaValidacion = GetEstadoProcesoPROLAutoDetalle();
            model.ListaValidacionAutomatica = ListaValidacion;

            return View(model);
        }

        public PartialViewResult ListarProcesoParcial()
        {
            ValidacionAutomaticaModel model = new ValidacionAutomaticaModel();
            List<BEValidacionAutomatica> ListaValidacion = GetEstadoProcesoPROLAutoDetalle();
            model.ListaValidacionAutomatica = ListaValidacion;

            return PartialView("ListaProcesoPROL", model);
        }

        public ActionResult ListarProceso()
        {
            ValidacionAutomaticaModel model = new ValidacionAutomaticaModel();
            List<BEValidacionAutomatica> ListaValidacion = GetEstadoProcesoPROLAutoDetalle();
            model.ListaValidacionAutomatica = ListaValidacion;

            return PartialView("ListaProcesoPROL", model);
        }

        [HttpPost]
        public JsonResult EjecutarValidacionPROLAuto(string FechaFacturacion)
        {
            try
            {
                int Respuesta = -1000;
                DateTime FechaHoraFacturacion = Convert.ToDateTime(FechaFacturacion);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    Respuesta = sv.GetEstadoProcesoPROLAuto(UserData().PaisID, FechaHoraFacturacion);
                }

                string MensajeRespuesta = string.Empty;

                switch(Respuesta)
                {
                    case -1:
                        MensajeRespuesta = "El proceso de PROL Automático ha iniciado. (COD. 001)";
                        break;
                    case 0:
                        MensajeRespuesta = "El proceso de PROL Automático esta en proceso. (COD. 000)";
                        break;
                    case 1:
                        MensajeRespuesta = "El proceso de PROL Automático esta en proceso (COD. 001)";
                        break;
                    case 2:
                        MensajeRespuesta = "El proceso de PROL Automático ha iniciado. (COD. 002)";
                        break;
                    case 3:
                        MensajeRespuesta = "El proceso de PROL Automático esta en proceso (COD. 003)";
                        break;
                    case 99:
                        MensajeRespuesta = "El proceso de PROL Automático ha iniciado. (COD. 099)";
                        break;
                }


                if (Respuesta != -1000)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = MensajeRespuesta,
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
            List<BEValidacionAutomatica> ListaValidacion = new List<BEValidacionAutomatica>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                ListaValidacion = sv.GetEstadoProcesoPROLAutoDetalle(UserData().PaisID).ToList();
            }
            return ListaValidacion;
        }

    }
}
