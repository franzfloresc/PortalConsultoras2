using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FichaProductoController : BaseController
    {
        [HttpGet]
        public JsonResult ObtenerFichaProducto(string cuv = "", int campanaId = 0)
        {
            try
            {
                if (userData.CampaniaID == campanaId)
                {
                    var lst = ConsultarFichaProductoPorCuv(cuv, campanaId);
                    var producto = FichaProductoFormatearModelo(lst).SingleOrDefault();
                    producto = FichaProductoHermanos(producto);
                    sessionManager.SetFichaProductoTemporal(producto);
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