using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BuscadorController : BaseController
    {
        // GET: Buscador
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult BusquedaProdcutos(string busqueda)
        {
            try
            {
                // Método para motor con los siguientes parametros: CodigoPais, CodigoCampaña, CodigoConsultora, TextoBusqueda, CantidadProductos

                var resultBuscador = new List<BuscadorYFiltrosModel>();
                var buscador = new BuscadorYFiltrosModel();

                buscador.CUV = "";
                resultBuscador.Add(buscador);



                return Json(new { Success = true, Productos = resultBuscador, Message = ""});
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { Error = true, Message = "Hubo un error al obtener los productos."});
            }
        }

        private List<BuscadorYFiltrosModel> Data()
        {
            return new List<BuscadorYFiltrosModel>();
        }
    }
}