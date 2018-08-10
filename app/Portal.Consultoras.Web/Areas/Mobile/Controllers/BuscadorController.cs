using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        BuscadorProvider buscadorProvider = new BuscadorProvider();
        // GET: Mobile/Buscador
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<JsonResult> BusquedaProductos(BuscadorModel buscadorModel)
        {
            var ListaProductosModel = new List<BuscadorYFiltrosModel>();
            try
            {                
                var urlClient = buscadorProvider.urlClient(userData, buscadorModel);
                ListaProductosModel = await RestClient.GetTAsync<List<BuscadorYFiltrosModel>>(urlClient);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ListaProductosModel = new List<BuscadorYFiltrosModel>();
            }
            return Json(ListaProductosModel, JsonRequestBehavior.AllowGet);
        }

        private List<BuscadorYFiltrosModel> Data()
        {
            return new List<BuscadorYFiltrosModel>();
        }
    }
}