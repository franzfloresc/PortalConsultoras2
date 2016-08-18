using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertaLiquidacionController : BaseMobileController
    {
        public ActionResult Index()
        {
            var userData = UserData();
            ViewBag.Simbolo = userData.Simbolo;
            //var model = new OfertaProductoPrincipalMobileModel();
            //try
            //{
            //    var listaOfertasLiquidacion = GetListadoOfertasLiquidacion();
            //    if (listaOfertasLiquidacion != null && listaOfertasLiquidacion.Count > 0)
            //        listaOfertasLiquidacion.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

            //    model.ISOPais = userData.CodigoISO;
            //    model.Simbolo = userData.Simbolo;
            //    model.listaProductosEnLiquidacion = new List<OfertaProductoMobilModel>();
            //    foreach (var item in listaOfertasLiquidacion)
            //    {
            //        model.listaProductosEnLiquidacion.Add(
            //            new OfertaProductoMobilModel
            //            {
            //                PaisID = item.PaisID,
            //                CampaniaID = item.CampaniaID,
            //                Descripcion = item.Descripcion,
            //                PrecioOferta = item.PrecioOferta,
            //                Stock = item.Stock,
            //                ImagenProducto = item.ImagenProducto,
            //                Orden = item.Orden,
            //                UnidadesPermitidas = item.UnidadesPermitidas,
            //                CodigoCampania = item.CodigoCampania,
            //                ConfiguracionOfertaID = item.ConfiguracionOfertaID,
            //                TipoOfertaSisID = item.TipoOfertaSisID,
            //                MarcaID = item.MarcaID,
            //                OfertaProductoID = item.OfertaProductoID,
            //                DescripcionLegal = item.DescripcionLegal,
            //                TallaColor = item.TallaColor,
            //                DescripcionMarca = item.DescripcionMarca,
            //                DescripcionCategoria = item.DescripcionCategoria,
            //                DescripcionEstrategia = item.DescripcionEstrategia,
            //                CUV = item.CUV
            //            });
            //    }

            //    var lstPedidoWebDetalle = ObtenerPedidoWeb();

            //    model.listaProductosEnLiquidacion.Update(p => p.Agregado = lstPedidoWebDetalle.Any(q => q.CUV == p.CUV));
            //}
            //catch (FaultException ex)
            //{
            //    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            //}
            return View();
        }

        [HttpPost]
        public JsonResult ObtenerResumenPedido()
        {
            var userData = UserData();
            try
            {
                Session["PedidoWebDetalle"] = null;

                var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                var model = new PedidoMobileModel();
                model.CodigoIso = userData.CodigoISO;
                model.Total = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                model.DescripcionTotal = model.CodigoIso == "CO" ? string.Format("{0:#,##0}", model.Total).Replace(',', '.') : string.Format("{0:#,##0.00}", model.Total);
                model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
                model.DescripcionTotalMinimo = model.CodigoIso == "CO" ? string.Format("{0:#,##0}", model.TotalMinimo).Replace(',', '.') : string.Format("{0:#,##0.00}", model.TotalMinimo);
                model.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);

                return Json(new
                {
                    success = true,
                    message = "",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    data = ""
                });
            }
        }
    }
}
