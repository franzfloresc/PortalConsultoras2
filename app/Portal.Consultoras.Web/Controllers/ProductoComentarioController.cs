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
using static Portal.Consultoras.Common.Enumeradores;

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return View(model);
            }
        }

        private IEnumerable<PaisModel> ListarPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<EstadoProductoComentarioModel> ListarEstadosComentario()
        {
            var estadosComentarios = new List<EstadoProductoComentarioModel>();

            estadosComentarios.Add(new EstadoProductoComentarioModel(Enumeradores.EstadoProductoComentario.Ingresado));
            estadosComentarios.Add(new EstadoProductoComentarioModel(Enumeradores.EstadoProductoComentario.Aprobado));
            estadosComentarios.Add(new EstadoProductoComentarioModel(Enumeradores.EstadoProductoComentario.Rechazado));

            return estadosComentarios;
        }

        private IEnumerable<TipoProductoComentarioModel> ListarTiposComentario()
        {
            var tiposComentario = new List<TipoProductoComentarioModel>();

            tiposComentario.Add(new TipoProductoComentarioModel(Enumeradores.TipoProductoComentario.SAP));
            tiposComentario.Add(new TipoProductoComentarioModel(Enumeradores.TipoProductoComentario.CUV));

            return tiposComentario;
        }

        [HttpGet]
        public JsonResult ListarProductoComentario(string sidx, string sord, int page, int rows,
            int paisID, int estadoComentarioID, int tipoComentarioID, string SAP, int campaniaID, string CUV)
        {
            try
            {
                var productoComentarioFilter = ObtenerProductoComentarioFilter(page, rows, estadoComentarioID, tipoComentarioID, SAP, CUV);
                var listaProductoComentario = ListarProductoComentario(paisID, productoComentarioFilter);

                var totalRows = listaProductoComentario.Count() == 0 ? 0 : listaProductoComentario.FirstOrDefault().RowsCount;
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

        private BEProductoComentarioFilter ObtenerProductoComentarioFilter(int page, int rows, int estadoComentarioID, int tipoComentarioID, string SAP, string CUV)
        {
            var productoComentarioFilter = new BEProductoComentarioFilter();

            productoComentarioFilter.Cantidad = rows;
            productoComentarioFilter.Limite = (page - 1) * rows;
            productoComentarioFilter.Ordenar = 0;

            productoComentarioFilter.Estado = (short)estadoComentarioID;
            productoComentarioFilter.Tipo = (short)tipoComentarioID;
            productoComentarioFilter.Valor = (Enumeradores.TipoProductoComentario)tipoComentarioID == Enumeradores.TipoProductoComentario.SAP ? SAP : CUV;

            return productoComentarioFilter;
        }

        private IEnumerable<BEProductoComentarioDetalle> ListarProductoComentario(int paisID, BEProductoComentarioFilter productoComentarioFilter)
        {
            IEnumerable<BEProductoComentarioDetalle> ListaProductoComentario;
            using (PedidoServiceClient client = new PedidoServiceClient())
            {
                ListaProductoComentario = client.GetListaProductoComentarioDetalleAprobar(paisID, productoComentarioFilter);
            }
            return ListaProductoComentario;
        }

        [HttpPost]
        public JsonResult ActualizarEstadoProductoComentario(short paisId, int productoComentarioId, long productoComentarioDetalleId, short estadoProductoComentarioId)
        {
            try
            {
                var productoComentarioDetalle = new BEProductoComentarioDetalle();
                productoComentarioDetalle.ProdComentarioId = productoComentarioId;
                productoComentarioDetalle.ProdComentarioDetalleId = productoComentarioDetalleId;
                productoComentarioDetalle.Estado = estadoProductoComentarioId;

                int result = 0;
                using (PedidoServiceClient client = new PedidoServiceClient())
                {
                    result = client.AprobarProductoComentarioDetalle(paisId, productoComentarioDetalle);
                }

                if (result>0)
                {
                    var message = "Se {0} el comentario con éxito.";
                    message = (EstadoProductoComentario)estadoProductoComentarioId == EstadoProductoComentario.Aprobado ?
                        string.Format(message, "APROBÓ") : 
                        string.Format(message, "RECHAZÓ");

                    return Json(new { success = true, message = message }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var message = "NO se pudo {0} el comentario.";
                    message = (EstadoProductoComentario)estadoProductoComentarioId == EstadoProductoComentario.Aprobado ?
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