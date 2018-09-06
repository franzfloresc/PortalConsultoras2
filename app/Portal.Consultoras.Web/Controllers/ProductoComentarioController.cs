using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProductoComentarioController : BaseController
    {
        [HttpGet]
        public ActionResult Index(ProductoComentarioModel model)
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ProductoComentario/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                model.Paises = ListarPaises();
                model.EstadosComentario = ListarEstadosComentario();
                model.TiposComentario = ListarTiposComentario();
                model.Campanias = new List<CampaniaModel>();

                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return View(model);
            }
        }

        private IEnumerable<PaisModel> ListarPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<EstadoProductoComentarioModel> ListarEstadosComentario()
        {
            var estadosComentarios = new List<EstadoProductoComentarioModel>
            {
                new EstadoProductoComentarioModel(Enumeradores.EstadoProductoComentario.Ingresado),
                new EstadoProductoComentarioModel(Enumeradores.EstadoProductoComentario.Aprobado),
                new EstadoProductoComentarioModel(Enumeradores.EstadoProductoComentario.Rechazado)
            };


            return estadosComentarios;
        }

        private IEnumerable<TipoProductoComentarioModel> ListarTiposComentario()
        {
            var tiposComentario = new List<TipoProductoComentarioModel>
            {
                new TipoProductoComentarioModel(Enumeradores.TipoProductoComentario.SAP),
                new TipoProductoComentarioModel(Enumeradores.TipoProductoComentario.CUV)
            };


            return tiposComentario;
        }

        [HttpGet]
        public JsonResult ListarProductoComentario(string sidx, string sord, int page, int rows,
            int paisID, int estadoComentarioID, int tipoComentarioID, string SAP, int campaniaID, string CUV)
        {
            try
            {
                var productoComentarioFilter = ObtenerProductoComentarioFilter(page, rows, estadoComentarioID, tipoComentarioID, SAP, CUV, campaniaID);
                var listaProductoComentario = ListarProductoComentario(paisID, productoComentarioFilter).ToList();

                var totalRows = !listaProductoComentario.Any() ? 0 : listaProductoComentario.FirstOrDefault().RowsCount;
                var nro = (page - 1) * rows + 1;
                var data = new
                {
                    total = Math.Ceiling((decimal)totalRows / rows),
                    page = page,
                    records = totalRows,
                    rows = from row in listaProductoComentario
                           select new
                           {
                               Nro = nro++,
                               ProductoComentarioId = row.ProdComentarioId,
                               ProductoComentarioDetalleId = row.ProdComentarioDetalleId,
                               Consultora = row.CodigoConsultora,
                               Fecha = row.FechaRegistro.ToShortDateString(),
                               Valorizacion = row.Valorizado,
                               Texto = row.Comentario,
                               Estado = ((Enumeradores.EstadoProductoComentario)row.Estado).ToString(),
                               IdEstado = row.Estado,
                               Acciones = ""
                           }
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(
                    new
                    {
                        success = false,
                        message = "Ocurrió un error al ejecutar la operación. " + ex.Message
                    },
                    JsonRequestBehavior.AllowGet
                    );
            }
        }

        private BEProductoComentarioFilter ObtenerProductoComentarioFilter(int page, int rows, int estadoComentarioId, int tipoComentarioId, string sap, string cuv, int campaniaId)
        {
            var productoComentarioFilter = new BEProductoComentarioFilter
            {
                Cantidad = rows,
                Limite = (page - 1) * rows,
                Ordenar = 0,
                Estado = (short)estadoComentarioId,
                Tipo = (short)tipoComentarioId,
                Valor = (Enumeradores.TipoProductoComentario)tipoComentarioId ==
                        Enumeradores.TipoProductoComentario.SAP
                    ? sap
                    : cuv,
                CampaniaID = campaniaId
            };



            return productoComentarioFilter;
        }

        private IEnumerable<BEProductoComentarioDetalle> ListarProductoComentario(int paisId, BEProductoComentarioFilter productoComentarioFilter)
        {
            IEnumerable<BEProductoComentarioDetalle> listaProductoComentario;
            using (PedidoServiceClient client = new PedidoServiceClient())
            {
                listaProductoComentario = client.GetListaProductoComentarioDetalleAprobar(paisId, productoComentarioFilter);
            }
            return listaProductoComentario;
        }

        [HttpPost]
        public JsonResult ActualizarEstadoProductoComentario(short paisId, int productoComentarioId, long productoComentarioDetalleId, short estadoProductoComentarioId)
        {
            try
            {
                var productoComentarioDetalle =
                    new BEProductoComentarioDetalle
                    {
                        ProdComentarioId = productoComentarioId,
                        ProdComentarioDetalleId = productoComentarioDetalleId,
                        Estado = estadoProductoComentarioId
                    };

                int result;
                using (PedidoServiceClient client = new PedidoServiceClient())
                {
                    result = client.AprobarProductoComentarioDetalle(paisId, productoComentarioDetalle);
                }

                if (result > 0)
                {
                    var message = "Se {0} el comentario con éxito.";
                    message = (Enumeradores.EstadoProductoComentario)estadoProductoComentarioId == Enumeradores.EstadoProductoComentario.Aprobado ?
                        string.Format(message, "APROBÓ") :
                        string.Format(message, "RECHAZÓ");

                    return Json(new { success = true, message = message }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var message = "NO se pudo {0} el comentario.";
                    message = (Enumeradores.EstadoProductoComentario)estadoProductoComentarioId == Enumeradores.EstadoProductoComentario.Aprobado ?
                        string.Format(message, "APROBAR") :
                        string.Format(message, "RECHAZAR");

                    return Json(new { success = false, message = message }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException fe)
            {
                return Json(
                    new
                    {
                        success = false,
                        message = "Ocurrió un error al ejecutar la operación. " + fe.Message
                    },
                    JsonRequestBehavior.AllowGet
                    );
            }
        }
    }
}