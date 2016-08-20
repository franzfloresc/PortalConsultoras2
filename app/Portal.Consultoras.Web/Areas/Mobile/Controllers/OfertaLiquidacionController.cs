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
        #region Acciones

        public ActionResult Index()
        {
            SessionKeys.ClearSessionCantidadProductos();

            var userData = UserData();
            var model = new OfertaProductoPrincipalMobileModel();
            try
            {
                var listaOfertasLiquidacion = GetListadoOfertasLiquidacion();
                if (listaOfertasLiquidacion != null && listaOfertasLiquidacion.Count > 0)
                    listaOfertasLiquidacion.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

                model.ISOPais = userData.CodigoISO;
                model.Simbolo = userData.Simbolo;
                model.listaProductosEnLiquidacion = new List<OfertaProductoMobilModel>();
                foreach (var item in listaOfertasLiquidacion)
                {
                    model.listaProductosEnLiquidacion.Add(
                        new OfertaProductoMobilModel
                        {
                            PaisID = item.PaisID,
                            CampaniaID = item.CampaniaID,
                            Descripcion = item.Descripcion,
                            PrecioOferta = item.PrecioOferta,
                            Stock = item.Stock,
                            ImagenProducto = item.ImagenProducto,
                            Orden = item.Orden,
                            UnidadesPermitidas = item.UnidadesPermitidas,
                            CodigoCampania = item.CodigoCampania,
                            ConfiguracionOfertaID = item.ConfiguracionOfertaID,
                            TipoOfertaSisID = item.TipoOfertaSisID,
                            MarcaID = item.MarcaID,
                            OfertaProductoID = item.OfertaProductoID,
                            DescripcionLegal = item.DescripcionLegal,
                            TallaColor = item.TallaColor,
                            DescripcionMarca = item.DescripcionMarca,
                            DescripcionCategoria = item.DescripcionCategoria,
                            DescripcionEstrategia = item.DescripcionEstrategia,
                            CUV = item.CUV
                        });
                }

                var lstPedidoWebDetalle = ObtenerPedidoWeb();

                model.listaProductosEnLiquidacion.Update(p => p.Agregado = lstPedidoWebDetalle.Any(q => q.CUV == p.CUV));
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        [HttpPost]
        public JsonResult ObtenerResumenPedido()
        {
            var userData = UserData();
            try
            {
                Session["PedidoWeb"] = null;

                var lstPedidoWebDetalle = ObtenerPedidoWeb();

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

        #endregion

        #region Metodos

        private List<OfertaProductoModel> GetListadoOfertasLiquidacion()
        {
            var userData = UserData();

            var lstfertaProducto = new List<BEOfertaProducto>();
            using (var servicio = new PedidoServiceClient())
            {
                int cantidad = servicio.ObtenerMaximoItemsaMostrarLiquidacion(userData.PaisID);
                lstfertaProducto = servicio.GetOfertaProductosPortal(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID).Take(cantidad).ToList();
            }

            if (lstfertaProducto != null && lstfertaProducto.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lstfertaProducto.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
            }

            Mapper.CreateMap<BEOfertaProducto, OfertaProductoModel>()
              .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
              .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
              .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
              .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
              .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
              .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
              .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
              .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
              .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
              .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
              .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
              .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
              .ForMember(t => t.OfertaProductoID, f => f.MapFrom(c => c.OfertaProductoID))
              .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
              .ForMember(t => t.TallaColor, f => f.MapFrom(c => c.TallaColor))
              .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.DescripcionMarca))
              .ForMember(t => t.DescripcionCategoria, f => f.MapFrom(c => c.DescripcionCategoria))
              .ForMember(t => t.DescripcionEstrategia, f => f.MapFrom(c => c.DescripcionEstrategia));

            var lstOfertaProductoModel = Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lstfertaProducto);

            return lstOfertaProductoModel;
        }

        private string GetDescripcionMarca(int MarcaID)
        {
            string result = string.Empty;

            switch (MarcaID)
            {
                case 1: result = "Lbel";
                    break;
                case 2: result = "Esika";
                    break;
                case 3: result = "Cyzone";
                    break;
                case 6: result = "Finart";
                    break;
            }

            return result;
        }

        private List<BEPedidoWebDetalle> ObtenerPedidoWeb()
        {
            var userData = UserData();

            List<BEPedidoWebDetalle> lstPedidoWebDetalle;

            if (Session["PedidoWeb"] == null)
            {
                using (var sv = new PedidoServiceClient())
                {
                    lstPedidoWebDetalle = sv.SelectByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }
            }
            else
            {
                lstPedidoWebDetalle = Session["PedidoWeb"] as List<BEPedidoWebDetalle>;
            }

            Session["PedidoWeb"] = lstPedidoWebDetalle;

            return lstPedidoWebDetalle;
        }

        #endregion
    }
}
