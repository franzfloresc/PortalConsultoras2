using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReporteConsultoraPedidoSACController : BaseAdmController
    {
        // GET: ReporteConsultoraPedidoSAC
        public ActionResult Index()
        {
            var reporteConsultoraPedidoSACModels = new ReporteConsultoraPedidoSACModels();
            var usuario = userData ?? new UsuarioModel();

            try
            {
                ////if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ReporteConsultoraPedidoSAC/Index"))
                //    return RedirectToAction("Index", "Bienvenida");

                IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>() {
                                new CampaniaModel() {
                                    CampaniaID = 0,
                                    Codigo = "-- Seleccionar --"
                                }};

                reporteConsultoraPedidoSACModels.listaPaises = DropDowListPaises();
                reporteConsultoraPedidoSACModels.listaCampania = lstCampania;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return View(reporteConsultoraPedidoSACModels);
        }

        [HttpPost]
        public JsonResult RealizarDescargaSinMarcar(DescargarPedidoModel model)
        {
            int tipoCronogramaID = 1; /*Regular*/
            try
            {
                string descProceso = ((Enumeradores.TipoDescargaPedidos)tipoCronogramaID).ToString();

                string[] file;
                using (var pedidoService = new PedidoServiceClient())
                {
                    int contadorCarga = pedidoService.ValidarCargadePedidosSinMarcar(model.PaisID, model.CampanaId, tipoCronogramaID);
                    if (contadorCarga != 0) return ErrorJson("Existe una carga de pedidos en proceso para la fecha y tipo de cronograma seleccionado.");

                    file = pedidoService.DescargaPedidosWebSinMarcar(model.PaisID, model.CampanaId, tipoCronogramaID, userData.NombreConsultora, descProceso);
                }
                if (file.Length != 3) return SuccessJson("El proceso de carga de pedidos ha finalizado satisfactoriamente.");


                return Json(new
                {
                    success = true,
                    message = "El proceso de carga de pedidos ha finalizado satisfactoriamente.",
                    cabecera = System.IO.Path.GetFileName(file[0]),
                    detalle = System.IO.Path.GetFileName(file[1]),
                    detalleAct = System.IO.Path.GetFileName(file[2]),
                    rutac = file[0],
                    rutad = file[1],
                    rutae = file[2],
                    IsFox = true
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(ex.Message);
            }
        }
            


        }
}