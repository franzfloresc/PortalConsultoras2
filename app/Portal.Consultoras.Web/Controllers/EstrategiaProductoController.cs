using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServicePedido;
using AutoMapper;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaProductoController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }
        
        //public ActionResult DetalleProducto(EstrategiaPedidoModel item)
        //{
        //    try
        //    {
        //        return View();
        //    }
        //    catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        //}

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
                        item.UltimoComentario = Mapper.Map<BEProductoComentarioDetalle, EstrategiaProductoComentarioModel>(comentario);
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