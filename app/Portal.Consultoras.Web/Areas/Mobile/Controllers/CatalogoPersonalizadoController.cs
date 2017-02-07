using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;

using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoPersonalizadoController : BaseMobileController
    {
        public ActionResult Index()
        {
            var model = new CatalogoPersonalizadoModel(); //PL20-1273

            if (!userData.EsCatalogoPersonalizadoZonaValida)
            {
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }

            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = ConfigurationManager.AppSettings.Get("rutaImagenNotFoundAppCatalogo");

            //PL20-1273
            if (Session["ListFiltersFAV"] != null)
            {
                var lst = (List<BETablaLogicaDatos>)Session["ListFiltersFAV"] ?? new List<BETablaLogicaDatos>();
                model.FiltersBySorting = lst.Where(x => x.TablaLogicaID == 94).ToList();
                model.FiltersByCategory = lst.Where(x => x.TablaLogicaID == 95).ToList();
                model.FiltersByBrand = lst.Where(x => x.TablaLogicaID == 96).ToList();
                model.FiltersByPublished = lst.Where(x => x.TablaLogicaID == 97).ToList();
            }
            //PL20-1273

            //PL20-1284
            var url1 = ConfigurationManager.AppSettings.Get("UrlImagenFAVMobile");
            ViewBag.UrlImagenFAVMobile = string.Format(url1, userData.CodigoISO);

            return View(model);
        }

        public ActionResult Producto(FichaProductoFAVModel model)
        {
            if (string.IsNullOrEmpty(model.CUVFP))
            {
                return RedirectToAction("Index");
            }

            var productoModel = new ProductoModel();

            if (Session["ProductosCatalogoPersonalizado"] != null)
            {
                var listaProductoModel = new List<ProductoModel>();
                listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();

                if (listaProductoModel.Any())
                {
                    productoModel = listaProductoModel.Where(x => x.CUV == model.CUVFP).FirstOrDefault();

                    if (productoModel != null)
                    {
                        if (productoModel.EsMaquillaje)
                        {
                            if (productoModel.Hermanos == null)
                            {
                                var listaHermanos = new List<BEProducto>();
                                using (ODSServiceClient svc = new ODSServiceClient())
                                {
                                    listaHermanos = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, model.CUVFP).ToList();
                                }

                                if (listaHermanos.Any())
                                {
                                    string codigosCuv = string.Join(",", listaHermanos.Select(x => x.CUV));

                                    var listaAppCatalogo = new List<Producto>();
                                    using (ProductoServiceClient svc = new ProductoServiceClient())
                                    {
                                        listaAppCatalogo = svc.ObtenerProductosAppCatalogoByListaCUV(userData.CodigoISO, userData.CampaniaID, codigosCuv).ToList();
                                    }

                                    if (listaAppCatalogo.Any())
                                    {
                                        productoModel.Hermanos = new List<ProductoModel>();

                                        foreach (var item in listaAppCatalogo)
                                        {
                                            productoModel.Hermanos.Add(new ProductoModel
                                            {
                                                CUV = item.Cuv,
                                                CodigoProducto = item.CodigoSap,
                                                Descripcion = item.NombreComercial,
                                                DescripcionComercial = item.DescripcionComercial,
                                                NombreBulk = item.NombreBulk,
                                                ImagenProductoSugerido = item.Imagen,
                                                ImagenBulk = item.ImagenBulk
                                            });
                                        }
                                    }
                                    else
                                    {
                                        productoModel.EsMaquillaje = false;
                                    }

                                    Session["ProductosCatalogoPersonalizadoFilter"] = listaProductoModel;
                                }
                            }

                        }// EsMaquillaje
                    }
                }
            }

            if (string.IsNullOrEmpty(productoModel.CUV))
            {
                return RedirectToAction("Index");
            }

            ViewBag.RutaImagenNoDisponible = ConfigurationManager.AppSettings.Get("rutaImagenNotFoundAppCatalogo");

            return View(productoModel);
        }
    }
}
