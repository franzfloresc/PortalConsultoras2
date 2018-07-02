
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DetalleEstrategiaController : BaseEstrategiaController
    {

        public ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            var modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(sessionManager.GetProductoTemporal());

            var EstrategiaDetalle = EstrategiaGetDetalle(modelo.EstrategiaID);
            if (EstrategiaDetalle.Hermanos != null)
            {
                modelo.Hermanos = EstrategiaDetalle.Hermanos;
            }

            return View("Ficha", modelo); 
            
            //return View(modelo);
        }

    }
}