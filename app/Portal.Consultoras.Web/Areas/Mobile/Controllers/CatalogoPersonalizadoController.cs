using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoPersonalizadoController : BaseMobileController
    {
        public ActionResult Index()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado))
            {
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }

            var model = new CatalogoPersonalizadoModel();

            if (!userData.EsCatalogoPersonalizadoZonaValida)
            {
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }
            
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.rutaImagenNotFoundAppCatalogo);

            if (Session["ListFiltersFAV"] != null)
            {
                var lst = (List<BETablaLogicaDatos>)Session["ListFiltersFAV"] ?? new List<BETablaLogicaDatos>();
                model.FiltersBySorting = lst.Where(x => x.TablaLogicaID == 94).ToList();
                model.FiltersByCategory = lst.Where(x => x.TablaLogicaID == 95).ToList();
                model.FiltersByBrand = lst.Where(x => x.TablaLogicaID == 96).ToList();
                model.FiltersByPublished = lst.Where(x => x.TablaLogicaID == 97).ToList();
            }

            ViewBag.UrlImagenFAVMobile = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlImagenFAVMobile), userData.CodigoISO);
            ViewBag.EsLebel = userData.EsLebel;
            return View(model);
        }

        public ActionResult Producto(FichaProductoFAVModel model)
        {
            if (string.IsNullOrEmpty(model.CUVFP))
                return RedirectToAction("Index");

            var listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"];
            if (listaProductoModel == null)
                return RedirectToAction("Index");
            if (!listaProductoModel.Any((x => x.CUV == model.CUVFP)))
                return RedirectToAction("Index");

            var productoModel = listaProductoModel.FirstOrDefault(x => x.CUV == model.CUVFP) ?? new ProductoModel();

            if (productoModel.EsMaquillaje && productoModel.Hermanos == null)
            {
                var listaHermanos = GetListBrothersByCUV(userData, model);

                if (listaHermanos != null && listaHermanos.Any())
                {
                    var cuvs = string.Join(",", listaHermanos.Select(x => x.CUV));
                    var productosAppCatalogo = ObtenerProductosAppCatalogoByListaCUV(userData, cuvs);

                    if (productosAppCatalogo != null && productosAppCatalogo.Any())
                    {
                        productoModel.Hermanos = Mapper.Map<List<Producto>, List<ProductoModel>>(productosAppCatalogo);
                        productoModel.Tonos = productoModel.Hermanos.OrderBy(e => e.NombreBulk).ToList();
                    }
                    else
                    {
                        productoModel.EsMaquillaje = false;
                    }

                    Session["ProductosCatalogoPersonalizadoFilter"] = listaProductoModel;
                }
            }
            
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.rutaImagenNotFoundAppCatalogo);
            ViewBag.EsLebel = userData.EsLebel;

            return View(productoModel);
        }

        private List<Producto> ObtenerProductosAppCatalogoByListaCUV(UsuarioModel userData, string cuvs)
        {
            List<Producto> productosAppCatalogo;

            using (var productoServiceClient = new ProductoServiceClient())
            {
                productosAppCatalogo = productoServiceClient.ObtenerProductosAppCatalogoByListaCUV(userData.CodigoISO, userData.CampaniaID, cuvs).ToList();
            }

            return productosAppCatalogo;
        }

        private List<BEProducto> GetListBrothersByCUV(UsuarioModel userData, FichaProductoFAVModel model)
        {
            List<BEProducto> listaHermanos;

            using (var odsServiceClient = new ODSServiceClient())
            {
                listaHermanos = odsServiceClient.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, model.CUVFP).ToList();
            }

            return listaHermanos;
        }
    }
}
