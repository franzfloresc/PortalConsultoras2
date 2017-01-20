using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class CatalogoPersonalizadoController : BaseController
    {
        public ActionResult Index()
        {
            var model = new CatalogoPersonalizadoModel();
 
            if (!userData.EsCatalogoPersonalizadoZonaValida)
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = ConfigurationManager.AppSettings.Get("rutaImagenNotFoundAppCatalogo");

            //PL20-1234
            if (Session["ListFiltersFAV"] != null)
            {
                var lst = (List<BETablaLogicaDatos>)Session["ListFiltersFAV"] ?? new List<BETablaLogicaDatos>();
                model.FiltersBySorting = lst.Where(x => x.TablaLogicaID == 94).ToList();
                model.FiltersByCategory = lst.Where(x => x.TablaLogicaID == 95).ToList();
                model.FiltersByBrand = lst.Where(x => x.TablaLogicaID == 96).ToList();
                model.FiltersByPublished = lst.Where(x => x.TablaLogicaID == 97).ToList();
            }
            //PL20-1234
            return View(model);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizadoHome()
        {
            return ObtenerProductos(8);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizado(int cantidad, int offset, List<FiltroResultadoModel> lstFilters = null)
        {
            int limiteJetloreCatalogoPersonalizado = int.Parse(ConfigurationManager.AppSettings.Get("LimiteJetloreCatalogoPersonalizado"));
            cantidad = (offset + cantidad > limiteJetloreCatalogoPersonalizado) ? (limiteJetloreCatalogoPersonalizado - offset) : cantidad;
            return ObtenerProductos(cantidad, offset, lstFilters);
        }

        public JsonResult BorrarFiltros()
        {
            try
            {
                if (Session["UserFiltersFAV"] != null)
                    Session["UserFiltersFAV"] = null;

                if (Session["ProductosCatalogoPersonalizadoFilter"] != null)
                    Session["ProductosCatalogoPersonalizadoFilter"] = null;

                return Json(new
                {
                    success = true,
                    message = "OK"
                });
            }
            catch(Exception ex) 
            {
                return Json(new
                {
                    success = false,
                    message = "Error a borrar los filtros"
                });
            }
        }

        private JsonResult ObtenerProductos(int cantidad, int offset = 0, List<FiltroResultadoModel> lstFilters = null)
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
                        //((BasicHttpBinding)ps.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;

                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                        bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                        lista = ps.ObtenerTodosProductos(userData.CatalogoPersonalizado, userData.CodigoISO,
                                userData.CampaniaID, userData.CodigoConsultora, userData.ZonaID, 
                                userData.CodigorRegion, userData.CodigoZona, tipoProductoMostrar,
                                cantidad, esFacturacion).ToList();
                    }

                    if (lista.Any())
                    {
                        int limiteJetlore = int.Parse(ConfigurationManager.AppSettings.Get("LimiteJetloreCatalogoPersonalizado"));
                        lista = lista.Take(limiteJetlore).ToList();

                        string joinCuv = string.Empty;
                        foreach (var producto in lista)
                        {
                            joinCuv += producto.Cuv + ",";
                        }

                        joinCuv = joinCuv.Substring(0, joinCuv.Length - 1);

                        List<BEProducto> olstProducto = new List<BEProducto>();
                        using (ODSServiceClient sv = new ODSServiceClient())
                        {
                            olstProducto = sv.SelectProductoByListaCuvSearchRegionZona(userData.PaisID, userData.CampaniaID, joinCuv,
                                    userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, false).ToList();
                        }

                        //if (olstProducto.Count == 0) continue;

                        foreach (var producto in lista)
                        {
                            //List<BEProducto> olstProducto = new List<BEProducto>();
                            //using (ODSServiceClient sv = new ODSServiceClient())
                            //{
                            //    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, producto.Cuv,
                            //            userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).ToList();
                            //}
                            //if (olstProducto.Count == 0) continue;
                            var xproducto = olstProducto.Where(x => x.CUV == producto.Cuv).FirstOrDefault();

                            string descripcion = producto.NombreComercial, imagenUrl = producto.Imagen;
                            bool add = true;

                            if (userData.CatalogoPersonalizado == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                            {
                                add = false;
                                string infoEstrategia;

                                using (PedidoServiceClient sv = new PedidoServiceClient())
                                {
                                    //infoEstrategia = sv.GetImagenOfertaPersonalizadaOF(userData.PaisID, userData.CampaniaID, olstProducto[0].CUV.Trim());
                                    infoEstrategia = sv.GetImagenOfertaPersonalizadaOF(userData.PaisID, userData.CampaniaID, xproducto.CUV.Trim());
                                }

                                if (!string.IsNullOrEmpty(infoEstrategia))
                                {
                                    var listSplit = infoEstrategia.Split('|');
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

                            if (add)
                            {
                                //decimal preciotachado = userData.CatalogoPersonalizado == 2 && tipoProductoMostrar == 1
                                //    ? producto.PrecioValorizado : olstProducto[0].PrecioValorizado;

                                decimal preciotachado = userData.CatalogoPersonalizado == 2 && tipoProductoMostrar == 1
                                    ? producto.PrecioValorizado : xproducto.PrecioValorizado;

                                listaProductoModel.Add(new ProductoModel()
                                {
                                    //CUV = olstProducto[0].CUV.Trim(),
                                    CUV = xproducto.CUV.Trim(),
                                    Descripcion = descripcion,
                                    //PrecioCatalogoString = Util.DecimalToStringFormat(olstProducto[0].PrecioCatalogo, userData.CodigoISO),
                                    //PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                                    //MarcaID = olstProducto[0].MarcaID,
                                    //EstaEnRevista = olstProducto[0].EstaEnRevista,
                                    PrecioCatalogoString = Util.DecimalToStringFormat(xproducto.PrecioCatalogo, userData.CodigoISO),
                                    PrecioCatalogo = xproducto.PrecioCatalogo,
                                    MarcaID = xproducto.MarcaID,
                                    EstaEnRevista = xproducto.EstaEnRevista,
                                    TieneStock = true,
                                    //EsExpoOferta = olstProducto[0].EsExpoOferta,
                                    //CUVRevista = olstProducto[0].CUVRevista.Trim(),
                                    //CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                                    //IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                                    //TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                                    //ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                                    EsExpoOferta = xproducto.EsExpoOferta,
                                    CUVRevista = xproducto.CUVRevista.Trim(),
                                    CUVComplemento = xproducto.CUVComplemento.Trim(),
                                    IndicadorMontoMinimo = xproducto.IndicadorMontoMinimo.ToString().Trim(),
                                    TipoOfertaSisID = xproducto.TipoOfertaSisID,
                                    ConfiguracionOfertaID = xproducto.ConfiguracionOfertaID,
                                    MensajeCUV = "",
                                    DesactivaRevistaGana = -1,
                                    //DescripcionMarca = olstProducto[0].DescripcionMarca,
                                    //DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                                    //DescripcionCategoria = olstProducto[0].DescripcionCategoria,
                                    //FlagNueva = olstProducto[0].FlagNueva,
                                    //TipoEstrategiaID = olstProducto[0].TipoEstrategiaID,
                                    DescripcionMarca = xproducto.DescripcionMarca,
                                    DescripcionEstrategia = xproducto.DescripcionEstrategia,
                                    DescripcionCategoria = xproducto.DescripcionCategoria,
                                    FlagNueva = xproducto.FlagNueva,
                                    TipoEstrategiaID = xproducto.TipoEstrategiaID,
                                    ImagenProductoSugerido = imagenUrl,
                                    //CodigoProducto = olstProducto[0].CodigoProducto,
                                    CodigoProducto = xproducto.CodigoProducto,
                                    TieneStockPROL = true,
                                    PrecioValorizado = preciotachado,
                                    PrecioValorizadoString = Util.DecimalToStringFormat(preciotachado, userData.CodigoISO),
                                    Simbolo = userData.Simbolo,
                                    Sello = producto.Sello,
                                    IsAgregado = false,
                                    //TieneOfertaEnRevista = olstProducto[0].TieneOfertaRevista,
                                    //TieneLanzamientoCatalogoPersonalizado = olstProducto[0].TieneLanzamientoCatalogoPersonalizado,
                                    //TipoOfertaRevista = olstProducto[0].TipoOfertaRevista,
                                    TieneOfertaEnRevista = xproducto.TieneOfertaRevista,
                                    TieneLanzamientoCatalogoPersonalizado = xproducto.TieneLanzamientoCatalogoPersonalizado,
                                    TipoOfertaRevista = xproducto.TipoOfertaRevista,
                                    Volumen = producto.Volumen,
                                    EsMaquillaje = producto.EsMaquillaje,
                                    DescripcionComercial = producto.DescripcionComercial,
                                    CodigoIso = userData.CodigoISO,
                                    Relevancia = producto.Relevancia,
                                    CodigoCategoria = producto.CodigoCategoria,
                                    CodigoMarca = producto.CodigoMarca
                                });

                            }
                        }// for

                        Session["ProductosCatalogoPersonalizado"] = listaProductoModel;

                    }// lista

                }
                else
                {
                    listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
                }
                    
                var listaPedido = ObtenerPedidoWebDetalle();
                listaProductoModel.Update(c => c.IsAgregado = listaPedido.Where(p => p.CUV == c.CUV).Count() > 0);

                //SB20-1197
                //var totalRegistros = listaProductoModel.Count;
                var totalRegistros = int.Parse(ConfigurationManager.AppSettings.Get("LimiteJetloreCatalogoPersonalizado"));
                var precioMinimo = listaProductoModel.OrderBy(x => x.PrecioCatalogo).FirstOrDefault().PrecioCatalogoString;
                var precioMaximo = listaProductoModel.OrderByDescending(x => x.PrecioCatalogo).FirstOrDefault().PrecioCatalogoString;
                var totalRegistrosFilter = totalRegistros;

                if (lstFilters != null)
                {
                    var lstProductoModelFilter = new List<ProductoModel>();
                    var changedFilters = false;

                    if (Session["UserFiltersFAV"] != null)
                    {
                        var userFilters = (List<FiltroResultadoModel>)Session["UserFiltersFAV"] ?? new List<FiltroResultadoModel>();
                        foreach (var filter in lstFilters)
                        {
                            var userFilter = userFilters.Where(x => x.Id == filter.Id).FirstOrDefault();
                            if (userFilter != null)
                            {
                                if (filter.Valor1 != userFilter.Valor1 || filter.Valor2 != userFilter.Valor2 || filter.Orden != userFilter.Orden)
                                {
                                    changedFilters = true;
                                    break;
                                }
                            }
                            else
                            {
                                changedFilters = true;
                                break;
                            }
                        }
                    }
                    else
                    {
                        changedFilters = true;
                    }

                    if (changedFilters)
                    {
                        lstProductoModelFilter = listaProductoModel;

                        foreach (var item in lstFilters)
                        {
                            if (item.Id == "1")// sorting
                            {
                                if (item.Orden == "01")
                                {
                                    lstProductoModelFilter = lstProductoModelFilter.OrderBy(x => x.PrecioCatalogo).ToList();
                                }
                                else if(item.Orden == "02")
                                {
                                    lstProductoModelFilter = lstProductoModelFilter.OrderByDescending(x => x.PrecioCatalogo).ToList();
                                }
                                else
                                {
                                    lstProductoModelFilter = lstProductoModelFilter.OrderBy(x => x.Relevancia).ToList();
                                }
                            }// category
                            else if (item.Id == "2")
                            {
                                if (!string.IsNullOrEmpty(item.Valor1))
                                {
                                    string[] arrIds = item.Valor1.Split(',');
                                    lstProductoModelFilter = lstProductoModelFilter.Where(x => arrIds.Contains(x.CodigoCategoria)).ToList();
                                }
                                
                            }// brand
                            else if (item.Id == "3")
                            {
                                if (!string.IsNullOrEmpty(item.Valor1))
                                {
                                    string[] arrIds = item.Valor1.Split(',');
                                    lstProductoModelFilter = lstProductoModelFilter.Where(x => arrIds.Contains(x.CodigoMarca)).ToList();
                                }
                            }// price
                            else if (item.Id == "4")
                            {
                                lstProductoModelFilter = lstProductoModelFilter.Where(x => Convert.ToDecimal(x.PrecioCatalogoString) >= Convert.ToDecimal(item.Valor1) 
                                    && Convert.ToDecimal(x.PrecioCatalogoString) <= Convert.ToDecimal(item.Valor2)).ToList();
                            }// published
                            else if (item.Id == "5")
                            {
                                if (!string.IsNullOrEmpty(item.Valor1))
                                {
                                    int ind = (item.Valor1.Contains(",")) ? -1 : 0;
                                    if (ind == 0)
                                    {
                                        bool er = (item.Valor1 == "SC") ? false : true;
                                        lstProductoModelFilter = lstProductoModelFilter.Where(x => x.EstaEnRevista == er).ToList();
                                    }
                                }
                            }
                        }// for

                        Session["UserFiltersFAV"] = lstFilters;
                        Session["ProductosCatalogoPersonalizadoFilter"] = lstProductoModelFilter;
                    }
                    else
                    {
                        lstProductoModelFilter = (List<ProductoModel>)Session["ProductosCatalogoPersonalizadoFilter"] ?? new List<ProductoModel>();
                    }

                    listaProductoModel = lstProductoModelFilter;
                    totalRegistrosFilter = lstProductoModelFilter.Count;
                }

                //SB20-1197

                listaProductoModel = listaProductoModel.Skip(offset).Take(cantidad).ToList();

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaProductoModel,
                    totalRegistros = totalRegistros,
                    precioMinimo = precioMinimo,
                    precioMaximo = precioMaximo,
                    totalRegistrosFilter = totalRegistrosFilter
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

        public JsonResult ObtenerOfertaRevista(string cuv, string tipoOfertaRevista)
        {
            try
            {
                BEProducto producto = new BEProducto();
                BEProducto productPack = new BEProducto();
                BEProducto productNivel = new BEProducto();

                var ambiente = ConfigurationManager.AppSettings["Ambiente"] ?? "";
                var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

                ObjOfertaCatalogos dataPROL;
                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    sv.Url = ConfigurationManager.AppSettings[keyWeb];
                    dataPROL = sv.Ofertas_catalogo(userData.CodigoISO, userData.CampaniaID.ToString(), cuv, userData.CodigoConsultora, userData.ZonaID.ToString(), tipoOfertaRevista);
                }
                dataPROL = dataPROL ?? new ObjOfertaCatalogos();

                #region nombre de los pack

                //dataPROL.lista_ObjNivel = dataPROL.lista_ObjNivel ?? new ObjNivel[0];
                dataPROL.lista_oObjPack = dataPROL.lista_oObjPack ?? new ObjPack[0];

                if (dataPROL.lista_oObjPack.Length > 0)
                {
                    foreach (var item in dataPROL.lista_oObjPack)
                    {
                        using (ODSServiceClient sv = new ODSServiceClient())
                        {
                            string nombreProductoNivel = sv.GetNombreProducto048ByCuv(userData.PaisID, userData.CampaniaID, item.cuv_pack);

                            item.nombre_pack = nombreProductoNivel ?? "";
                        }
                    }
                }

                #endregion

                #region para la imagen

                string listaSap = "|"; // "0000000|00000000|000003"
                string caracterSepara = "|";

                dataPROL.lista_oObjGratis = dataPROL.lista_oObjGratis ?? new ObjGratis[0];
                dataPROL.lista_oObjItemPack = dataPROL.lista_oObjItemPack ?? new ObjItemPack[0];                

                if (dataPROL.lista_oObjGratis.Length > 0)
                {
                    foreach (var objGrati in dataPROL.lista_oObjGratis)
                    {
                        objGrati.codsap_nivel_gratis = Util.SubStr(objGrati.codsap_nivel_gratis, 0);
                        if (objGrati.codsap_nivel_gratis == "")
                            continue;

                        var add = listaSap.Contains(caracterSepara + objGrati.codsap_nivel_gratis + caracterSepara);
                        listaSap += !add ? objGrati.codsap_nivel_gratis + caracterSepara : "";
                    }
                }

                if (dataPROL.lista_oObjItemPack.Length > 0)
                {
                    foreach (var objItemPack in dataPROL.lista_oObjItemPack)
                    {
                        objItemPack.codsap_item_pack = Util.SubStr(objItemPack.codsap_item_pack, 0);
                        if (objItemPack.codsap_item_pack == "")
                            continue;

                        var add = listaSap.Contains(caracterSepara + objItemPack.codsap_item_pack + caracterSepara);
                        listaSap += !add ? objItemPack.codsap_item_pack + caracterSepara : "";
                    }
                }

                if (listaSap.Length > 2)
                {
                    listaSap = Util.SubStr(listaSap, 1, listaSap.Length - 2);

                    var listaProductoBySap = new List<Producto>();
                    using (ProductoServiceClient ps = new ProductoServiceClient())
                    {
                        listaProductoBySap = ps.ObtenerProductosByCodigoSap(userData.CodigoISO, userData.CampaniaID, listaSap).ToList();
                    }
                    listaProductoBySap = listaProductoBySap ?? new List<Producto>();

                    /* SB20-1198 - INICIO */
                    //List<string> lstCodSap = new List<string>();
                    //foreach (var itemSap in listaProductoBySap)
                    //{
                    //    if (string.IsNullOrEmpty(itemSap.NombreComercial))
                    //    {
                    //        lstCodSap.Add(itemSap.CodigoSap);
                    //    }
                    //}

                    //if (lstCodSap.Count > 0)
                    //{
                    //    List<string> lstCuvSap = new List<string>();

                    //    if (dataPROL.lista_oObjGratis.Length > 0)
                    //    {
                    //        foreach (var codsap in lstCodSap)
                    //        {
                    //            foreach (var objGrati in dataPROL.lista_oObjGratis)
                    //            {
                    //                if (codsap == objGrati.codsap_nivel_gratis)
                    //                {
                    //                    //lstCuvSap.Add("");
                    //                }
                    //            }
                    //        }
                    //    }

                    //    string lstFindCuv = String.Join("|", lstCuvSap);

                    //    using (ODSServiceClient svc = new ODSServiceClient())
                    //    {
                    //        var lstNombresProductos048 = svc.GetNombreProducto048ByListaCUV(userData.PaisID, userData.CampaniaID, lstFindCuv);

                    //        if (lstNombresProductos048.Length > 0)
                    //        {
                    //            foreach (var itemProd in lstNombresProductos048)
                    //            {
                    //                var itemSap = listaProductoBySap.Where(x => x.Cuv == itemProd.Cuv).First();
                    //                if (itemSap != null)
                    //                {
                    //                    itemSap.NombreComercial = itemProd.NombreComercial;
                    //                }
                    //            }
                    //        }
                    //    }
                    //}

                    /* SB20-1198 - FIN */

                    foreach (var itemSap in listaProductoBySap)
                    {
                        if (dataPROL.lista_oObjGratis.Length > 0)
                        {
                            foreach (var objGrati in dataPROL.lista_oObjGratis)
                            {
                                objGrati.codsap_nivel_gratis = Util.SubStr(objGrati.codsap_nivel_gratis, 0);
                                if (objGrati.codsap_nivel_gratis == "")
                                    continue;

                                if (objGrati.codsap_nivel_gratis == itemSap.CodigoSap)
                                {
                                    objGrati.imagen_gratis = itemSap.Imagen;

                                    if (!string.IsNullOrEmpty(itemSap.NombreComercial))
                                    {
                                        objGrati.descripcion_gratis = itemSap.NombreComercial;
                                    }
                                }
                            }
                        }

                        if (dataPROL.lista_oObjItemPack.Length > 0)
                        {
                            foreach (var objItemPack in dataPROL.lista_oObjItemPack)
                            {
                                objItemPack.codsap_item_pack = Util.SubStr(objItemPack.codsap_item_pack, 0);
                                if (objItemPack.codsap_item_pack == "")
                                    continue;

                                if (objItemPack.codsap_item_pack == itemSap.CodigoSap)
                                {
                                    objItemPack.imagen_item_pack = itemSap.Imagen;

                                    if (!string.IsNullOrEmpty(itemSap.NombreComercial))
                                    {
                                        objItemPack.descripcion_item_pack = itemSap.NombreComercial;
                                    }
                                }
                            }
                        }
                    }
                }

                #endregion
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    producto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, dataPROL.cuv_revista,
                            userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).FirstOrDefault();
                }

                var txtGanancia = userData.CodigoISO == Constantes.CodigosISOPais.Peru ? "Gana" :
                    userData.CodigoISO == Constantes.CodigosISOPais.Chile ? "Gana" :
                    "Ganancia";
                var txtRecibeGratis = userData.CodigoISO == Constantes.CodigosISOPais.Peru ? "BONIFICACIÓN" :
                    userData.CodigoISO == Constantes.CodigosISOPais.Chile ? "INCLUYE" :
                    "RECIBE GRATIS";

                return Json(new
                {
                    success = true,
                    message = "",
                    data = new
                    {
                        dataPROL = dataPROL,
                        producto = producto,
                        txtGanancia,
                        txtRecibeGratis
                    }
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
        //PL20-1237
        public JsonResult InsertarProductoCompartido(ProductoCompartidoModel ProCompModel)
        {
            try 
	        {
                int id;
                AutoMapper.Mapper.CreateMap<ProductoCompartidoModel, BEProductoCompartido>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.mPaisID))
                    .ForMember(t => t.PcCampaniaID, f => f.MapFrom(c => c.mCampaniaID))
                    .ForMember(t => t.PcCuv, f => f.MapFrom(c => c.mCUV))
                    .ForMember(t => t.PcPalanca, f => f.MapFrom(c => c.mPalanca))
                    .ForMember(t => t.PcDetalle, f => f.MapFrom(c => c.mDetalle))
                    .ForMember(t => t.PcApp, f => f.MapFrom(c => c.mApplicacion));

                BEProductoCompartido entidad = AutoMapper.Mapper.Map<ProductoCompartidoModel, BEProductoCompartido>(ProCompModel);
                using (ODSServiceClient svc = new ODSServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.PcCampaniaID = userData.CampaniaID;

                    id = svc.InsProductoCompartido(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = new
                    {
                        id = id
                    }
                });
	        }
	        catch (Exception ex)
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

        //PL20-1268
        public JsonResult GetInfoFichaProductoFAV(string cuv)
        {
            try
            {
                var productoModel = new ProductoModel(); 
                var listaProductoModel = new List<ProductoModel>();
                listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();

                productoModel = listaProductoModel.Where(x => x.CUV == cuv).FirstOrDefault();
                if (productoModel != null)
                {
                    if (productoModel.EsMaquillaje)
                    {
                        if (productoModel.Hermanos == null)
                        {
                            var listaHermanos = new List<BEProducto>();
                            using (ODSServiceClient svc = new ODSServiceClient())
                            {
                                listaHermanos = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, cuv).ToList();
                            }

                            if (listaHermanos.Any())
                            {
                                string joinCuv = string.Empty;
                                foreach (var item in listaHermanos)
                                {
                                    joinCuv += item.CUV + ",";
                                }

                                joinCuv = joinCuv.Substring(0, joinCuv.Length - 1);

                                var listaAppCatalogo = new List<Producto>();
                                using (ProductoServiceClient svc = new ProductoServiceClient())
                                {
                                    listaAppCatalogo = svc.ObtenerProductosAppCatalogoByListaCUV(userData.CodigoISO, userData.CampaniaID, joinCuv).ToList();
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

                                Session["ProductosCatalogoPersonalizadoFilter"] = listaProductoModel;
                            }
                            else
                            {
                                productoModel.EsMaquillaje = false;
                            }
                        }
                        
                    }// EsMaquillaje
                }

                return Json(new
                {
                    success = true,
                    data = productoModel
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrrio un problema con la operacion.",
                });
            }
        }

    }
}