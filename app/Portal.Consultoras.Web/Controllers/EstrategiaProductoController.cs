using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Globalization;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaProductoController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult ObtenerDetalleProducto(EstrategiaPedidoModel item)
        {
            try
            {
                if (item.UltimoComentario == null)
                {
                    using (PedidoServiceClient svc = new PedidoServiceClient())
                    {
                        var comentario = svc.GetUltimoProductoComentarioByCodigoSap(userData.PaisID, item.CodigoProducto);
                        if (comentario != null)
                        {
                            item.UltimoComentario = Mapper.Map<BEProductoComentarioDetalle, EstrategiaProductoComentarioModel>(comentario);
                            item.UltimoComentario.NombreConsultora = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(item.UltimoComentario.NombreConsultora.ToLower());
                        }

                        if (item.UltimoComentario == null)
                        {
                            item.UltimoComentario = new EstrategiaProductoComentarioModel
                            {
                                Comentario = string.Empty,
                                NombreConsultora = string.Empty
                            };
                        }
                    }
                }
                EstrategiaOutModel model = new EstrategiaOutModel { Item = item };
                return Json(new { success = true, data = model });
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        public ActionResult DetalleProducto()
        {
            return View();
        }
    }
}