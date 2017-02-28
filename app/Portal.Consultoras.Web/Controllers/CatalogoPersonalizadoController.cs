using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

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

            //PL20-1270
            var listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
            if (listaProductoModel.Any())
            {
                ViewBag.PrecioMin = listaProductoModel.OrderBy(x => x.PrecioCatalogo).FirstOrDefault().PrecioCatalogoString;
                ViewBag.PrecioMax = listaProductoModel.OrderByDescending(x => x.PrecioCatalogo).FirstOrDefault().PrecioCatalogoString;

                //PL20-1283
                var sobrenombre = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                ViewBag.NombreConsultoraFAV = sobrenombre.First().ToString().ToUpper() + sobrenombre.ToLower().Substring(1);
                ViewBag.UrlImagenFAVLanding = string.Format(ConfigurationManager.AppSettings.Get("UrlImagenFAVLanding"), userData.CodigoISO);
            }

            return View(model);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizadoHome()
        {
            int CantProFav = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings.Get("LimiteJetloreCatalogoPersonalizadoHome"));
            return ObtenerProductos(CantProFav);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizado(int cantidad, int offset, List<FiltroResultadoModel> lstFilters = null, int tipoOrigen = 0)
        {
            int limiteJetloreCatalogoPersonalizado = int.Parse(ConfigurationManager.AppSettings.Get("LimiteJetloreCatalogoPersonalizado"));
            cantidad = (offset + cantidad > limiteJetloreCatalogoPersonalizado) ? (limiteJetloreCatalogoPersonalizado - offset) : cantidad;
            return ObtenerProductos(cantidad, offset, lstFilters, tipoOrigen);
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

        private JsonResult ObtenerProductos(int cantidad, int offset = 0, List<FiltroResultadoModel> lstFilters = null, int tipoOrigen = 0)
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
            int flt = 0;
   
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

                        string codigosCuv = string.Join(",", lista.Select(p => p.Cuv));
                        List<BEProducto> lstProducto = new List<BEProducto>();

                        using (ODSServiceClient sv = new ODSServiceClient())
                        {
                            lstProducto = sv.GetProductoComercialByListaCuv(userData.PaisID, userData.CampaniaID, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, codigosCuv).ToList();
                        }

                        foreach (var producto in lista)
                        {
                            BEProducto beProducto = lstProducto.FirstOrDefault(p => p.CUV == producto.Cuv);

                            if (beProducto == null) continue;

                            string descripcion = producto.NombreComercial;
                            string imagenUrl = producto.Imagen;
                            bool add = true;

                            if (userData.CatalogoPersonalizado == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                            {
                                add = false;
                                string infoEstrategia;

                                using (PedidoServiceClient sv = new PedidoServiceClient())
                                {
                                    infoEstrategia = sv.GetImagenOfertaPersonalizadaOF(userData.PaisID, userData.CampaniaID, beProducto.CUV.Trim());
                                }

                                if (!string.IsNullOrEmpty(infoEstrategia))
                                {
                                    var listSplit = infoEstrategia.Split('|');
                                    descripcion = listSplit.Count() > 0 ? listSplit[0] : "";
                                    string imagen = listSplit.Count() > 1 ? listSplit[1] : "";

                                    if (!string.IsNullOrEmpty(beProducto.ImagenProductoSugerido))
                                    {
                                        string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                                        imagenUrl = ConfigS3.GetUrlFileS3(carpetapais, beProducto.ImagenProductoSugerido, carpetapais);
                                        add = true;
                                    }
                                }
                            }

                            if (add)
                            {
                                decimal preciotachado = userData.CatalogoPersonalizado == 2 && tipoProductoMostrar == 1 
                                    ? producto.PrecioValorizado : beProducto.PrecioValorizado;

                                listaProductoModel.Add(new ProductoModel()
                                {
                                    CUV = beProducto.CUV.Trim(),
                                    Descripcion = descripcion,
                                    PrecioCatalogoString = Util.DecimalToStringFormat(beProducto.PrecioCatalogo, userData.CodigoISO),
                                    PrecioCatalogo = beProducto.PrecioCatalogo,
                                    MarcaID = beProducto.MarcaID,
                                    EstaEnRevista = beProducto.EstaEnRevista,
                                    TieneStock = true,
                                    EsExpoOferta = beProducto.EsExpoOferta,
                                    CUVRevista = beProducto.CUVRevista.Trim(),
                                    CUVComplemento = beProducto.CUVComplemento.Trim(),
                                    IndicadorMontoMinimo = beProducto.IndicadorMontoMinimo.ToString().Trim(),
                                    TipoOfertaSisID = beProducto.TipoOfertaSisID,
                                    ConfiguracionOfertaID = beProducto.ConfiguracionOfertaID,
                                    MensajeCUV = "",
                                    DesactivaRevistaGana = -1,
                                    DescripcionMarca = beProducto.DescripcionMarca,
                                    DescripcionEstrategia = beProducto.DescripcionEstrategia,
                                    DescripcionCategoria = beProducto.DescripcionCategoria,
                                    FlagNueva = beProducto.FlagNueva,
                                    TipoEstrategiaID = beProducto.TipoEstrategiaID,
                                    ImagenProductoSugerido = imagenUrl,
                                    CodigoProducto = beProducto.CodigoProducto,
                                    TieneStockPROL = true,
                                    PrecioValorizado = preciotachado,
                                    PrecioValorizadoString = Util.DecimalToStringFormat(preciotachado, userData.CodigoISO),
                                    Simbolo = userData.Simbolo,
                                    Sello = producto.Sello,
                                    IsAgregado = false,
                                    TieneOfertaEnRevista = beProducto.TieneOfertaRevista,
                                    TieneLanzamientoCatalogoPersonalizado = beProducto.TieneLanzamientoCatalogoPersonalizado,
                                    TipoOfertaRevista = beProducto.TipoOfertaRevista,
                                    Volumen = producto.Volumen,
                                    EsMaquillaje = producto.EsMaquillaje,
                                    //DescripcionComercial = producto.DescripcionComercial,
                                    DescripcionComercial = producto.Descripcion,
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

                // PL20-1270
                if (lstFilters == null && tipoOrigen == 1)
                {
                    if (Session["UserFiltersFAV"] != null)
                    {
                        lstFilters = (List<FiltroResultadoModel>)Session["UserFiltersFAV"] ?? new List<FiltroResultadoModel>();
                    }
                }

                //Contador de Filtros
                if (lstFilters != null)
                {
                    string v1 = "";
                    for (int i = 0; i < lstFilters.Count(); i++)
                    {
                        v1 = lstFilters[i].Valor1 == null ? "" : lstFilters[i].Valor1;
                        if (Convert.ToInt32(lstFilters[i].Id) > 1 && v1.Length > 0)
                        {
                            if (lstFilters[i].Id == "4" && Convert.ToDouble(lstFilters[i].Valor1) == Convert.ToDouble(precioMinimo) && Convert.ToDouble(lstFilters[i].Valor2) == Convert.ToDouble(precioMaximo))
                            {
                            }
                            else
                            {
                                flt += v1.Split(',').Count();
                            }
                        }                            
                    }
                }

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
                        }// for
                    }
                    else
                    {
                        changedFilters = true;
                    }

                    if (changedFilters)
                    {
                        lstProductoModelFilter = listaProductoModel;

                        //item.Id = [1=sorting, 2=category, 3=brand, 4=price, 5=published]
                        foreach (var item in lstFilters)
                        {
                            if (item.Id == "1")
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
                            }
                            else if (item.Id == "2")
                            {
                                if (!string.IsNullOrEmpty(item.Valor1))
                                {
                                    string[] arrIds = item.Valor1.Split(',');
                                    lstProductoModelFilter = lstProductoModelFilter.Where(x => arrIds.Contains(x.CodigoCategoria)).ToList();
                                }
                                
                            }
                            else if (item.Id == "3")
                            {
                                if (!string.IsNullOrEmpty(item.Valor1))
                                {
                                    string[] arrIds = item.Valor1.Split(',');
                                    lstProductoModelFilter = lstProductoModelFilter.Where(x => arrIds.Contains(x.CodigoMarca)).ToList();
                                }
                            }
                            else if (item.Id == "4")
                            {
                                lstProductoModelFilter = lstProductoModelFilter.Where(x => Convert.ToDecimal(x.PrecioCatalogoString) >= Convert.ToDecimal(item.Valor1) 
                                    && Convert.ToDecimal(x.PrecioCatalogoString) <= Convert.ToDecimal(item.Valor2)).ToList();
                            }
                            else if (item.Id == "5")
                            {
                                if (!string.IsNullOrEmpty(item.Valor1))
                                {
                                    int ind = (item.Valor1.Contains(",")) ? -1 : 0;
                                    if (ind == 0)
                                    {
                                        bool er = (item.Valor1 == "SC") ? false : true;
                                        lstProductoModelFilter = lstProductoModelFilter.Where(x => x.TieneOfertaEnRevista == er).ToList();
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

                listaProductoModel = listaProductoModel.Skip(offset).Take(cantidad).ToList();

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaProductoModel,
                    totalRegistros = totalRegistros,
                    precioMinimo = precioMinimo,
                    precioMaximo = precioMaximo,
                    totalRegistrosFilter = totalRegistrosFilter,
                    totalFiltros = flt
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
                                        objGrati.volumen = itemSap.Volumen;
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
                                        objItemPack.volumen = itemSap.Volumen;
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

                if (productoModel == null || !productoModel.EsMaquillaje || productoModel.Hermanos != null)
                {
                    productoModel = productoModel ?? new ProductoModel();
                    productoModel.UrlCompartirFB = GetUrlCompartirFB();
                    return Json(new
                    {
                        success = true,
                        data = productoModel
                    });
                }

                productoModel.UrlCompartirFB = GetUrlCompartirFB();
                
                //if (productoModel != null)
                //{
                //    if (productoModel.EsMaquillaje)
                //    {
                //        if (productoModel.Hermanos == null)
                //        {

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
                                DescripcionComercial = item.Descripcion,
                                ImagenProductoSugerido = item.Imagen,
                                NombreBulk = item.NombreBulk,
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

                //        }
                //    }// EsMaquillaje
                //}

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

        public JsonResult CargarFiltros()
        {
            try
            {
                var lstProductoModelFilter = new List<FiltroResultadoModel>();
                if (Session["UserFiltersFAV"] != null)
                {                  
                    lstProductoModelFilter = (List<FiltroResultadoModel>)Session["UserFiltersFAV"] ?? new List<FiltroResultadoModel>();                    
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = lstProductoModelFilter
                });
            }
            catch (Exception)
            {                
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los filtros"
                });
            }
        }
    }
}