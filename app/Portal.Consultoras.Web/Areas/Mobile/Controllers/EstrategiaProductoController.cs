using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using System.Globalization;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstrategiaProductoController : BaseMobileController
    {
        // GET: Mobile/EstrategiaProducto
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
                            item.UltimoComentario = new EstrategiaProductoComentarioModel();
                            item.UltimoComentario.Comentario = string.Empty;
                            item.UltimoComentario.NombreConsultora = string.Empty;
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