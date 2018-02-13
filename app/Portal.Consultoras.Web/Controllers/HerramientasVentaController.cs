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
                return RedirectToAction("Index", "Ofertas");
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Index");
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

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    campaniaId = model.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
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

        public ActionResult Comprar()
        {
            try
            {
                return ViewLanding(1);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Comprar");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                return ViewLanding(2);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Revisar");
            }

            return RedirectToAction("Index", "Bienvenida");
        }
    }
}