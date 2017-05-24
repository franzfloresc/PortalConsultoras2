using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasParaTiController : BaseEstrategiaController
    {
        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detalle(int id, int origen)
        {
            var modelo = EstrategiaGetDetalle(id);
            var origenPantalla = Util.Trim(origen.ToString()).Substring(1, 1);
            if (modelo.EstrategiaID <= 0)
            {
                if (origenPantalla == "1") // Home
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }
                if (origenPantalla == "2") // pedido
                {
                    return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
                }
                if (origenPantalla == "7") // RevistaDigital
                {
                    return RedirectToAction("Index", "RevistaDigital", new { area = "Mobile" });
                }
            }

            modelo.Origen = origen;
            modelo.OrigenUrl = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
            if (origenPantalla == "1") // Home
            {
                modelo.OrigenUrl = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
            }
            else if (origenPantalla == "2") // pedido
            {
                modelo.OrigenUrl = Url.Action("Index", "Pedido", new { area = "Mobile" });
            }
            else if (origenPantalla == "7") // RevistaDigital
            {
                modelo.OrigenUrl = Url.Action("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            }
            return View(modelo);
        }

    }
}