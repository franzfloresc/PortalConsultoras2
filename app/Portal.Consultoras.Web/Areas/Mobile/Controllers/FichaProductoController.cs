using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class FichaProductoController : BaseMobileController
    {
        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detalle(string cuv = "", int campanaId = 0)
        {
            try
            {
                var producto = (FichaProductoDetalleModel)null;
                if (userData.CampaniaID == campanaId)
                {
                    var lst = ConsultarFichaProductoPorCuv(cuv, campanaId);
                    producto = FichaProductoFormatearModelo(lst).SingleOrDefault();
                    producto = FichaProductoHermanos(producto);
                    Session[Constantes.SessionNames.FichaProductoTemporal] = producto;
                }
                if (producto == null)
                {
                    return View("ProductoNotFound");
                }
                ViewBag.OrigenUrl = Url.Action("Index", "Pedido", new { area = "Mobile" });

                ViewBag.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
                ViewBag.VirtualCoachCuv = cuv;
                ViewBag.VirtualCoachCampana = campanaId;
                return View(producto);
            }
            catch (System.Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

    }
}