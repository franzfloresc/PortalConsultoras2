using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class GuiaNegocioController : BaseGuiaNegocioController
    {
        public ActionResult Index()
        {
            try
            {
                return ViewLanding();
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
                var listaFinal1 = ConsultarEstrategiasModel("", 0, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1);
                
                listModel = listModel.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                
                return Json(new
                {
                    success = true,
                    lista = listModel,
                    campaniaId = model.CampaniaID
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