using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FichaProductoController : BaseController
    {
        private readonly VCFichaProductoProvider _vcFichaProductoProvider;

        public FichaProductoController()
        {
            _vcFichaProductoProvider = new VCFichaProductoProvider(userData.PaisID, userData.CodigoISO);
        }

        [HttpGet]
        public JsonResult ObtenerFichaProducto(string cuv = "", int campanaId = 0)
        {
            try
            {
                if (userData.CampaniaID == campanaId)
                {
                    var listaPedido = ObtenerPedidoWebDetalle();
                    var lst = _vcFichaProductoProvider.ConsultarFichaProductoPorCuv(listaPedido, cuv, campanaId);
                    var producto = _vcFichaProductoProvider.FichaProductoFormatearModelo(lst, listaPedido).SingleOrDefault();
                    producto = _vcFichaProductoProvider.FichaProductoHermanos(producto, listaPedido, userData.CampaniaID);
                    Session[Constantes.SessionNames.FichaProductoTemporal] = producto;
                    return Json(producto, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return Json(null, JsonRequestBehavior.AllowGet);
        }

    }
}