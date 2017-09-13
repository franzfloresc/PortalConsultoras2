using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstrategiaProductoComentarioController : BaseMobileController
    {
        Web.Controllers.EstrategiaProductoComentarioController controllerDesktop = 
            new Web.Controllers.EstrategiaProductoComentarioController();

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult RegistrarComentario(EstrategiaProductoComentarioModel model)
        {
            var userData = UserData();
            model.CodigoConsultora = userData.CodigoConsultora;
            model.CampaniaID = userData.CampaniaID;
            return controllerDesktop.RegistrarComentario(model);
        }

        [HttpGet]
        public JsonResult ListarComentarios(string codigoSAP, int cantidadMostrar, int orden)
        {
            return controllerDesktop.ListarComentarios(codigoSAP, cantidadMostrar, orden);
        }
    }
}