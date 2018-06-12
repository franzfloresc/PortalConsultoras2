using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
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

        public ActionResult Detalle(string param)
        {
            try
            {
                var cuv = param.Substring(0, 5);
                var campanaId = Convert.ToInt32(param.Substring(5, 6));
                var producto = (FichaProductoDetalleModel)null;
                if (userData.CampaniaID == campanaId)
                {
                    var lst = ConsultarFichaProductoPorCuv(cuv, campanaId);
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    producto = FichaProductoFormatearModelo(lst).SingleOrDefault();
                    producto = FichaProductoHermanos(producto);
                    producto.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, producto.FotoProducto01);
                    Session[Constantes.SessionNames.FichaProductoTemporal] = producto;
                }
                if (producto == null)
                {
                    return View("ProductoNotFound");
                }
                ViewBag.OrigenUrl = Url.Action("Index", "Pedido", new { area = "Mobile" });

                ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
                ViewBag.VirtualCoachCuv = cuv;
                ViewBag.VirtualCoachCampana = campanaId;
                return View(producto);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

    }
}