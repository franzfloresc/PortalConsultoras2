using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ProductosAgotadosController : BaseMobileController
    {
        private const int numeroFilas = 10;

        protected ProductoFaltanteProvider _productoFaltanteProvider;

        public ProductosAgotadosController()
        {
            _productoFaltanteProvider = new ProductoFaltanteProvider();
        }

        public ActionResult Index()
        {

            var model = new PedidoDetalleModel();
            try
            {
                var lstProductoFaltante = _productoFaltanteProvider.GetProductosFaltantes(userData);
                SessionManager.SetListaProductoFaltantes(lstProductoFaltante);
                model.ListaProductoFaltante = lstProductoFaltante.Take(numeroFilas).ToList();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        [HttpPost]
        public JsonResult MostrarMas(int Cantidad)
        {
            try
            {
                var lstProductoFaltante = SessionManager.GetListaProductoFaltantes() as List<BEProductoFaltante>;

                if (lstProductoFaltante != null)
                    return Json(new
                    {
                        success = true,
                        lista = lstProductoFaltante.Skip(Cantidad).Take(numeroFilas).ToList(),
                        total = lstProductoFaltante.Count
                    });

                return Json(new
                {
                    success = false,
                    lista = "",
                    total = 0
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    lista = "",
                    total = 0
                });
            }
        }
    }
}