using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;

using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoPersonalizadoController : BaseMobileController
    {
        public ActionResult Index()
        {
            if (!userData.EsCatalogoPersonalizadoZonaValida)
            {
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }

            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = ConfigurationManager.AppSettings.Get("rutaImagenNotFoundAppCatalogo");

            return View();
        }

        public ActionResult Producto(FichaProductoFAVModel model)
        {
            if (string.IsNullOrEmpty(model.CUVFP))
            {
                return RedirectToAction("Index");
            }

            ProductoModel model2 = new ProductoModel();
            if (Session["ProductosCatalogoPersonalizado"] != null)
            {
                var listaProductoModel = new List<ProductoModel>();
                listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
                if (listaProductoModel.Any())
                {
                    var xitem = listaProductoModel.Where(x => x.CUV.ToLower() == model.CUVFP).FirstOrDefault();
                    if (xitem != null)
                    {
                        model2 = xitem;
                    }
                }
            }

            if (string.IsNullOrEmpty(model2.CUV))
            {
                return RedirectToAction("Index");
            }

            return View(model2);
        }
    }
}
