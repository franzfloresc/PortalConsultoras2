using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasMasVendidosController : BaseController
    {
        [HttpPost]
        public JsonResult ActualizarModel(EstrategiaOutModel model)
        {
            try
            {
                var listaPedido = ObtenerPedidoWebDetalle();
                if (model != null)
                {
                    if (model.Lista != null)
                    {
                        for (int i = 0; i <= model.Lista.Count - 1; i++)
                        {
                            model.Lista[i].IsAgregado = listaPedido.Any(p => p.CUV == model.Lista[i].CUV2.Trim());
                            model.Lista[i].PrecioTachado = Util.DecimalToStringFormat(model.Lista[i].Precio, userData.CodigoISO);
                            model.Lista[i].GananciaString = Util.DecimalToStringFormat(model.Lista[i].Ganancia, userData.CodigoISO);
                        }
                    }
                    if (model.Item != null)
                    {
                        model.Item.IsAgregado = listaPedido.Any(p => p.CUV == model.Item.CUV2.Trim());
                        model.Item.PrecioTachado = Util.DecimalToStringFormat(model.Item.Precio, userData.CodigoISO);
                        model.Item.GananciaString = Util.DecimalToStringFormat(model.Item.Ganancia, userData.CodigoISO);
                    }
                }
                return Json(new { success = true, data = model });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message });
            }
        }

    }
}