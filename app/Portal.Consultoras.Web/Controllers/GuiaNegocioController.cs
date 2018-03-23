using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class GuiaNegocioController : BaseGuiaNegocioController
    {
        public ActionResult Index()
        {
            try
            {
                if (GNDValidarAcceso(revistaDigital))
                {
                    return ViewLanding();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult GNDObtenerProductos(BusquedaProductoModel model)
        {
            try
            {
                if (!GNDValidarAcceso(revistaDigital))
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        data = ""
                    });
                }

                var listaFinal1 = ConsultarEstrategiasModel("", 0, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, 2);

                int cantidadTotal = listModel.Count;

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    campaniaId = model.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal
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