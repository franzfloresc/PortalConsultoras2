using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class LanzamientosController : BaseLanzamientosController
    {
        public override ActionResult Detalle(string cuv, int campaniaId)
        {
            try
            {
                return base.Detalle(cuv, campaniaId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Ofertas");
        }

        [HttpPost]
        public JsonResult RDObtenerProductosLan(BusquedaProductoModel model)
        {
            try
            {
                if (!(revistaDigital.TieneRevistaDigital()) || EsCampaniaFalsa(model.CampaniaID))
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        lista = new List<ShowRoomOfertaModel>(),
                        cantidadTotal = 0,
                        cantidad = 0
                    });
                }

                var listaFinal1 = ConsultarEstrategiasModel("", model.CampaniaID, Constantes.TipoEstrategiaCodigo.Lanzamiento);

                var perdio = TieneProductosPerdio(model.CampaniaID) ? 1 : 0;

                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, perdio);

                var cantidadTotal = listModel.Count;

                return Json(new
                {
                    success = true,
                    listaLan = listModel,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    campaniaId = model.CampaniaID,
                    codigo = Constantes.ConfiguracionPais.Lanzamiento
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