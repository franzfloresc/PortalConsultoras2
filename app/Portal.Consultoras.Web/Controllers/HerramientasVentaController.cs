using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class HerramientasVentaController : BaseHerramientasVentaController
    {
        public ActionResult Index()
        {
            try
            {
                //if (GNDValidarAcceso())
                //{
                    return ViewLanding();
                //}
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult ObtenerProductos(BusquedaProductoModel model)
        {
            try
            {
                var listaFinal1 = ConsultarEstrategiasModel(string.Empty, model.CampaniaID, Constantes.TipoEstrategiaCodigo.HerramientasVenta);
                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, 2);
                int cantidadTotal = listModel.Count;
                int cantidad = cantidadTotal < model.Limite?cantidadTotal:model.Limite;
                if (model.Limite > 0) listModel = listModel.Take(model.Limite).ToList();

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    campaniaId = model.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidad,
                    codigo = Constantes.ConfiguracionPais.HerramientasVenta
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los productos",
                    data = ""
                });
            }
        }
    }
}