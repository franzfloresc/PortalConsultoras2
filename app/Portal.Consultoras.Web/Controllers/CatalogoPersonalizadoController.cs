using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CatalogoPersonalizadoController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult ObtenerProductosCatalogoPersonalizadoHome()
        {
            return ObtenerProductos(8);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizado(int cantidad, int offset)
        {
            int limiteJetloreCatalogoPersonalizado = int.Parse(ConfigurationManager.AppSettings.Get("LimiteJetloreCatalogoPersonalizado"));
            cantidad = (offset + cantidad > limiteJetloreCatalogoPersonalizado) ? (limiteJetloreCatalogoPersonalizado - offset) : cantidad;
            return ObtenerProductos(cantidad, offset);
        }

        private JsonResult ObtenerProductos(int cantidad, int offset = 0)
        {            
            if (userData.CatalogoPersonalizado != Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp
                && userData.CatalogoPersonalizado != Constantes.TipoOfertaFinalCatalogoPersonalizado.Jetlore)
            {
                return Json(new
                {
                    success = false,
                    message = "",
                    data = ""
                });
            }

            //tipoOfertaFinal: 1 -> ARP; 2 -> Jetlore
            var lista = new List<Producto>();
            var listaProductoModel = new List<ProductoModel>();            
            try
            {
                if (Session["ProductosCatalogoPersonalizado"] == null)
                {
                    string paisesConPcm = ConfigurationManager.AppSettings.Get("PaisesConPcm");
                    int tipoProductoMostrar = paisesConPcm.Contains(userData.CodigoISO) ? 2 : 1;

                    using (ProductoServiceClient ps = new ProductoServiceClient())
                    {
                        lista = ps.ObtenerTodosProductos(userData.CatalogoPersonalizado, userData.CodigoISO,
                                userData.CampaniaID, userData.CodigoConsultora,
                                userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, tipoProductoMostrar,
                                cantidad).ToList();
                    }
                                        
                    foreach (var producto in lista)
                    {
                        List<BEProducto> olstProducto = new List<BEProducto>();
                        using (ODSServiceClient sv = new ODSServiceClient())
                        {
                            olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, producto.Cuv,
                                    userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1).ToList();
                        }
                        if (olstProducto.Count == 0) continue;

                        string descripcion = "", imagenUrl = "";
                        bool add = false;
                        if (userData.CatalogoPersonalizado == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                        {
                            string infoEstrategia;
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                infoEstrategia = sv.GetImagenOfertaPersonalizadaOF(userData.PaisID, userData.CampaniaID, olstProducto[0].CUV.Trim());
                            }

                            if (!string.IsNullOrEmpty(infoEstrategia))
                            {
                                var listSplit  = infoEstrategia.Split('|');
                                descripcion = listSplit.Count() > 0 ? listSplit[0] : "";
                                string imagen = listSplit.Count() > 1 ? listSplit[1] : "";

                                if (!string.IsNullOrEmpty(imagen))
                                {
                                    string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                                    imagenUrl = ConfigS3.GetUrlFileS3(carpetapais, imagen, carpetapais);
                                    add = true;
                                }
                            }
                            
                        }
                        else
                        {
                            descripcion = producto.NombreComercial;
                            imagenUrl = producto.Imagen;
                            if (olstProducto[0].TieneStock)
                            {
                                add = true;
                            }
                            //add = true;
                        }

                        if (add)
                        {
                            listaProductoModel.Add(new ProductoModel()
                            {
                                CUV = olstProducto[0].CUV.Trim(),
                                Descripcion = descripcion,
                                PrecioCatalogoString = Util.DecimalToStringFormat(olstProducto[0].PrecioCatalogo, userData.CodigoISO),
                                PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                                MarcaID = olstProducto[0].MarcaID,
                                EstaEnRevista = olstProducto[0].EstaEnRevista,
                                TieneStock = true,
                                EsExpoOferta = olstProducto[0].EsExpoOferta,
                                CUVRevista = olstProducto[0].CUVRevista.Trim(),
                                CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                                IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                                TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                                ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                                MensajeCUV = "",
                                DesactivaRevistaGana = -1,
                                DescripcionMarca = olstProducto[0].DescripcionMarca,
                                DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                                DescripcionCategoria = olstProducto[0].DescripcionCategoria,
                                FlagNueva = olstProducto[0].FlagNueva,
                                TipoEstrategiaID = olstProducto[0].TipoEstrategiaID,
                                ImagenProductoSugerido = imagenUrl,
                                CodigoProducto = olstProducto[0].CodigoProducto,
                                TieneStockPROL = true,
                                PrecioValorizado = olstProducto[0].PrecioValorizado,
                                PrecioValorizadoString = Util.DecimalToStringFormat(olstProducto[0].PrecioValorizado, userData.CodigoISO),
                                Simbolo = userData.Simbolo,
                                Sello = producto.Sello,
                                IsAgregado = false,
                                TieneOfertaEnRevista = olstProducto[0].TieneOfertaRevista,
                                TieneLanzamientoCatalogoPersonalizado = olstProducto[0].TieneLanzamientoCatalogoPersonalizado,
                                TipoOfertaRevista = olstProducto[0].TipoOfertaRevista
                            });

                        }
                    }
                    Session["ProductosCatalogoPersonalizado"] = listaProductoModel;
                }
                else
                    listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
                
                var listaPedido = ObtenerPedidoWebDetalle();
                listaProductoModel.Update(c => c.IsAgregado = listaPedido.Where(p => p.CUV == c.CUV).Count() > 0);

                listaProductoModel = listaProductoModel.Skip(offset).Take(cantidad).ToList();
                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaProductoModel,
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        public JsonResult ObtenerOfertaRevista(string cuv)
        {
            try
            {
                BEProducto producto = new BEProducto();

                ObjOfertaCatalogos dataPROL;
                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    dataPROL = sv.Ofertas_catalogo(userData.CodigoISO, userData.CampaniaID.ToString(), cuv, userData.CodigoConsultora, userData.ZonaID.ToString());
                }
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    producto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, dataPROL.cuv_revista,
                            userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1).FirstOrDefault();
                }

                return Json(new
                {
                    success = true,
                    message = "",
                    data = new { dataPROL = dataPROL,
                                 producto = producto }
                });
            }
            catch(Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrrio un problema con la operacion.",
                    data = ""
                });
            }
            
        }
    }
}