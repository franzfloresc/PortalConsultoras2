using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasMasVendidosController : BaseEstrategiaController
    {
               
        [HttpGet]
        public JsonResult ObtenerOfertas(string cuv) 
        {
            var model =  new EstrategiaOutModel();

            var listModel = ConsultarMasVendidosModel();
           
            model.Lista = listModel;

            return Json(model, JsonRequestBehavior.AllowGet);
        }
    }
}