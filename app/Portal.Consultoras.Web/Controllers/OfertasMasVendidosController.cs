using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasMasVendidosController : BaseEstrategiaController
    {
        [HttpGet]
        public JsonResult ObtenerOfertas()
        {
            try
            {
                var model = new EstrategiaOutModel();

                var listModel = ConsultarMasVendidosModel();

                model.Lista = listModel;

                model = ActualizarPosicion(model);
                model = ActualizarPrecioFormateado(model);

                return Json(new { success = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message });
            }
        }

        private EstrategiaOutModel ActualizarPosicion(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                }
            }
            return model;
        }

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
                            model.Lista[i].IsAgregado = listaPedido.Any(p => p.CUV == model.Lista[i].CUV2.Trim() && (p.TipoEstrategiaID == model.Lista[i].TipoEstrategiaID || p.TipoEstrategiaID == 0));
                            model.Lista[i].PrecioTachado = Util.DecimalToStringFormat(model.Lista[i].Precio, userData.CodigoISO);
                            model.Lista[i].GananciaString = Util.DecimalToStringFormat(model.Lista[i].Ganancia, userData.CodigoISO);
                        }
                    }
                    if (model.Item != null)
                    {
                        model.Item.IsAgregado = listaPedido.Any(p => p.CUV == model.Item.CUV2.Trim() && (p.TipoEstrategiaID == model.Item.TipoEstrategiaID || p.TipoEstrategiaID == 0));
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

        private EstrategiaOutModel ActualizarPrecioFormateado(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                    model.Lista[i].PrecioTachado = Util.DecimalToStringFormat(model.Lista[i].Precio, userData.CodigoISO);
                    model.Lista[i].GananciaString = Util.DecimalToStringFormat(model.Lista[i].Ganancia, userData.CodigoISO);
                }
            }
            return model;
        }
    }
}