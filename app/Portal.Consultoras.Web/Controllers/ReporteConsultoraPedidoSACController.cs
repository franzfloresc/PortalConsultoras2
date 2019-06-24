using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
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
        #region HD-4327
        public async Task<ActionResult> Index()
        {
            var reporteConsultoraPedidoSACModels = new ReporteConsultoraPedidoSACModels();
            var usuario = userData ?? new UsuarioModel();

            try
            {
                reporteConsultoraPedidoSACModels.listaPaises = await DropDowListPaises(usuario.PaisID);
                reporteConsultoraPedidoSACModels.listaCampania = ObtenerListCampaniasPorPaisOUsuario(usuario.PaisID);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return View(reporteConsultoraPedidoSACModels);
        }
        private async Task<IEnumerable<PaisModel>> DropDowListPaises(int paisID)
        {
            using (var sv = new ZonificacionServiceClient())
            {
                var lst = await sv.SelectPaisesAsync();
                return Mapper.Map<IEnumerable<PaisModel>>(lst.Where(x => x.PaisID == paisID));
            }
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerUltimaDescargaPedidoSinMarcar()
        {
            string fechaDefault = "1/01/0001 00:00:00";
            var usuario = userData ?? new UsuarioModel();

            try
            {
                var lst = new List<BEPedidoDescarga>();

                using (var srv = new PedidoServiceClient())
                {
                    var ultimaDescargaPedido = await srv.ObtenerUltimaDescargaPedidoSinMarcarAsync(usuario.PaisID);
                    lst.Add(ultimaDescargaPedido);
                }

                var data = new
                {
                    total = 1,
                    page = 1,
                    records = lst.Count,
                    rows = (from tbl in lst
                            select new
                            {
                                FechaHoraInicio = tbl.FechaHoraInicio.ToString()== fechaDefault?string.Empty: tbl.FechaHoraInicio.ToString(),
                                FechaHoraFin = tbl.FechaHoraFin.ToString()==fechaDefault ?string.Empty : tbl.FechaHoraFin.ToString(),
                                Estado = tbl.Estado,
                                Mensaje = tbl.Mensaje,
                                NumeroPedidos = string.Format(" Web: {0}<br> DD: {1}", tbl.NumeroPedidosWeb, tbl.NumeroPedidosDD),
                                NroLote = tbl.NroLote
                            })
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public async Task<JsonResult> DescargarArchivoClienteSinMarcar(int nroLote, int campaniaid)
        {
            string mensajeFinal = string.Empty;
            string rutaDescargaArchivo = ConfigurationManager.AppSettings["OrderDownloadPath"];
            var usuario = userData ?? new UsuarioModel();

            try
            {
                using (var srv = new PedidoServiceClient())
                {
                    mensajeFinal= await srv.DescargaPedidosClienteSinMarcarAsync(usuario.PaisID, campaniaid, nroLote, usuario.CodigoUsuario);
                }
                
                var data = new
                {
                    success = true,
                    mensaje = mensajeFinal
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);

                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult RealizarDescargaSinMarcar(DescargarPedidoModel model)
        {
            int tipoCronogramaID = Constantes.TipoProceso.Regular; 
            try
            {
                string file=string.Empty;
                using (var pedidoService = new PedidoServiceClient())
                {
                    file = pedidoService.DescargaPedidosWebSinMarcar(model.PaisID, model.CampanaId, tipoCronogramaID, userData.NombreConsultora,model.NroLote, model.FechaFacturacion);
                }

                return Json(new
                {
                    success = file
                   
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(ex.Message);
            }
        }
        #endregion
    }
}