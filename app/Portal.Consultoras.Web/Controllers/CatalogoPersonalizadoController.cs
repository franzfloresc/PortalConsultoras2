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
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CatalogoPersonalizadoController : BaseController
    {
        public ActionResult Index()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado))
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var model = new CatalogoPersonalizadoModel();

            if (!userData.EsCatalogoPersonalizadoZonaValida)
            {
                return RedirectToAction("Index", "Bienvenida");
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

            var listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
            if (listaProductoModel.Any())
            {
                var entProd = listaProductoModel.OrderBy(x => x.PrecioCatalogo).FirstOrDefault() ?? new ProductoModel();
                ViewBag.PrecioMin = entProd.PrecioCatalogoString;
                entProd = listaProductoModel.OrderByDescending(x => x.PrecioCatalogo).FirstOrDefault() ?? new ProductoModel();
                ViewBag.PrecioMax = entProd.PrecioCatalogoString;

                var sobrenombre = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                ViewBag.NombreConsultoraFAV = sobrenombre.First().ToString().ToUpper() + sobrenombre.ToLower().Substring(1);
                ViewBag.UrlImagenFAVLanding = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlImagenFAVLanding), userData.CodigoISO);
            }

            return View(model);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizadoHome()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.CatalogoPersonalizado))
            {
                return Json(new
                {
                    success = false,
                    message = "",
                    data = ""
                });
            }

            int cantProFav = Convert.ToInt32(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreCatalogoPersonalizadoHome));
            return ObtenerProductos(cantProFav);
        }

        public JsonResult ObtenerProductosCatalogoPersonalizado(int cantidad, int offset, List<FiltroResultadoModel> lstFilters = null, int tipoOrigen = 0)
        {
            int limiteJetloreCatalogoPersonalizado = int.Parse(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreCatalogoPersonalizado));
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
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error a borrar los filtros"
                });
            }
        }

        [Obsolete("Migrado PL50-50")]
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
            var listaProductoModel = new List<ProductoModel>();
            int flt = 0;

            try
            {
                #region obtener catalogo personalizado
                if (Session["ProductosCatalogoPersonalizado"] == null)
                {
                    string paisesConPcm = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesConPcm);
                    int tipoProductoMostrar = paisesConPcm.Contains(userData.CodigoISO) ? 2 : 1;

                    List<Producto> lista;
                    using (ProductoServiceClient ps = new ProductoServiceClient())
                    {
                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                        bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                        lista = ps.ObtenerTodosProductos(userData.CatalogoPersonalizado, userData.CodigoISO,
                                userData.CampaniaID, userData.CodigoConsultora, userData.ZonaID,
                                userData.CodigorRegion, userData.CodigoZona, tipoProductoMostrar,
                                cantidad, esFacturacion).ToList();
                    }

                    if (lista.Any())
                    {
                        int limiteJetlore = int.Parse(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreCatalogoPersonalizado));
                        lista = lista.Take(limiteJetlore).ToList();

                        string codigosCuv = string.Join(",", lista.Select(p => p.Cuv));
                        List<ServiceODS.BEProducto> lstProducto;

                        using (ODSServiceClient sv = new ODSServiceClient())
                        {
                            lstProducto = sv.GetProductoComercialByListaCuv(userData.PaisID, userData.CampaniaID, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, codigosCuv).ToList();
                        }

                        foreach (var producto in lista)
                        {
                            ServiceODS.BEProducto beProducto = lstProducto.FirstOrDefault(p => p.CUV == producto.Cuv);

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
                                    descripcion = listSplit.Any() ? listSplit[0] : "";

                                    if (!string.IsNullOrEmpty(beProducto.ImagenProductoSugerido))
                                    {
                                        string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                                        imagenUrl = ConfigCdn.GetUrlFileCdn(carpetapais, beProducto.ImagenProductoSugerido);
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
                                    DescripcionComercial = producto.Descripcion,
                                    CodigoIso = userData.CodigoISO,
                                    Relevancia = producto.Relevancia,
                                    CodigoCategoria = producto.CodigoCategoria,
                                    CodigoMarca = producto.CodigoMarca
                                });
                            }
                        }

                        Session["ProductosCatalogoPersonalizado"] = listaProductoModel;

                    }
                }
                else
                {
                    listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
                }
                #endregion

                var listaPedido = ObtenerPedidoWebDetalle();
                listaProductoModel.Update(c => c.IsAgregado = listaPedido.Any(p => p.CUV == c.CUV));

                #region filtros
                var totalRegistros = int.Parse(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreCatalogoPersonalizado));
                var prodModel = listaProductoModel.OrderBy(x => x.PrecioCatalogo).FirstOrDefault() ?? new ProductoModel();
                var precioMinimo = prodModel.PrecioCatalogoString;
                prodModel = listaProductoModel.OrderByDescending(x => x.PrecioCatalogo).FirstOrDefault() ?? new ProductoModel();
                var precioMaximo = prodModel.PrecioCatalogoString;
                var totalRegistrosFilter = totalRegistros;

                if (lstFilters == null && tipoOrigen == 1 && Session["UserFiltersFAV"] != null)
                {
                    lstFilters = (List<FiltroResultadoModel>)Session["UserFiltersFAV"] ?? new List<FiltroResultadoModel>();
                }

                if (lstFilters != null)
                {
                    for (int i = 0; i < lstFilters.Count; i++)
                    {
                        var v1 = lstFilters[i].Valor1 == null ? "" : lstFilters[i].Valor1;
                        if (Convert.ToInt32(lstFilters[i].Id) <= 1 || v1.Length <= 0) continue;

                        if (lstFilters[i].Id == "4"
                            && Convert.ToDouble(lstFilters[i].Valor1).Equals(Convert.ToDouble(precioMinimo))
                            && Convert.ToDouble(lstFilters[i].Valor2).Equals(Convert.ToDouble(precioMaximo))) continue;

                        flt += v1.Split(',').Length;
                    }
                }

                if (lstFilters != null)
                {
                    List<ProductoModel> lstProductoModelFilter;
                    var changedFilters = false;

                    if (Session["UserFiltersFAV"] != null)
                    {
                        var userFilters = (List<FiltroResultadoModel>)Session["UserFiltersFAV"] ?? new List<FiltroResultadoModel>();
                        foreach (var filter in lstFilters)
                        {
                            var userFilter = userFilters.FirstOrDefault(x => x.Id == filter.Id);
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

                        //item.Id = [1=sorting, 2=category, 3=brand, 4=price, 5=published]
                        foreach (var item in lstFilters)
                        {
                            if (item.Id == "1")
                            {
                                if (item.Orden == "01")
                                {
                                    lstProductoModelFilter = lstProductoModelFilter.OrderBy(x => x.PrecioCatalogo).ToList();
                                }
                                else if (item.Orden == "02")
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
                            else if (item.Id == "5" && !string.IsNullOrEmpty(item.Valor1))
                            {
                                int ind = (item.Valor1.Contains(",")) ? -1 : 0;
                                if (ind == 0)
                                {
                                    bool er = item.Valor1 != "SC";
                                    lstProductoModelFilter = lstProductoModelFilter.Where(x => x.TieneOfertaEnRevista == er).ToList();
                                }
                            }
                        }

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

                #endregion

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
                var ambiente = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.Ambiente);
                var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

                ObjOfertaCatalogos dataProl;
                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    sv.Url = ConfigurationManager.AppSettings[keyWeb];
                    dataProl = sv.Ofertas_catalogo(userData.CodigoISO, userData.CampaniaID.ToString(), cuv, userData.CodigoConsultora, userData.ZonaID.ToString(), tipoOfertaRevista);
                }
                dataProl = dataProl ?? new ObjOfertaCatalogos();

                #region nombre de los pack

                dataProl.lista_oObjPack = dataProl.lista_oObjPack ?? new ObjPack[0];

                if (dataProl.lista_oObjPack.Length > 0)
                {
                    foreach (var item in dataProl.lista_oObjPack)
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


                string caracterSepara = "|";

                var txtBuil = new StringBuilder();
                txtBuil.Append(caracterSepara);

                dataProl.lista_oObjGratis = dataProl.lista_oObjGratis ?? new ObjGratis[0];
                dataProl.lista_oObjItemPack = dataProl.lista_oObjItemPack ?? new ObjItemPack[0];

                if (dataProl.lista_oObjGratis.Length > 0)
                {
                    foreach (var objGrati in dataProl.lista_oObjGratis)
                    {
                        objGrati.codsap_nivel_gratis = Util.SubStr(objGrati.codsap_nivel_gratis, 0);
                        if (objGrati.codsap_nivel_gratis == "")
                            continue;

                        var add = txtBuil.ToString().Contains(caracterSepara + objGrati.codsap_nivel_gratis + caracterSepara);
                        txtBuil.Append(!add ? objGrati.codsap_nivel_gratis + caracterSepara : "");
                    }
                }

                if (dataProl.lista_oObjItemPack.Length > 0)
                {
                    foreach (var objItemPack in dataProl.lista_oObjItemPack)
                    {
                        objItemPack.codsap_item_pack = Util.SubStr(objItemPack.codsap_item_pack, 0);
                        if (objItemPack.codsap_item_pack == "")
                            continue;

                        var add = txtBuil.ToString().Contains(caracterSepara + objItemPack.codsap_item_pack + caracterSepara);
                        txtBuil.Append(!add ? objItemPack.codsap_item_pack + caracterSepara : "");
                    }
                }
                string listaSap = txtBuil.ToString();

                if (listaSap.Length > 2)
                {
                    listaSap = Util.SubStr(listaSap, 1, listaSap.Length - 2);

                    List<Producto> listaProductoBySap;
                    using (ProductoServiceClient ps = new ProductoServiceClient())
                    {
                        listaProductoBySap = ps.ObtenerProductosByCodigoSap(userData.CodigoISO, userData.CampaniaID, listaSap).ToList();
                    }

                    foreach (var itemSap in listaProductoBySap)
                    {
                        if (dataProl.lista_oObjGratis.Length > 0)
                        {
                            foreach (var objGrati in dataProl.lista_oObjGratis)
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

                        if (dataProl.lista_oObjItemPack.Length > 0)
                        {
                            foreach (var objItemPack in dataProl.lista_oObjItemPack)
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
                ServiceODS.BEProducto producto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    producto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, dataProl.cuv_revista,
                        userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).FirstOrDefault() ?? new ServiceODS.BEProducto();
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
                        dataPROL = dataProl,
                        producto = producto,
                        txtGanancia,
                        txtRecibeGratis
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

        public JsonResult InsertarProductoCompartido(ProductoCompartidoModel ProCompModel)
        {
            try
            {
                int id;

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

        public JsonResult GetInfoFichaProductoFAV(string cuv)
        {
            try
            {
                var listaProductoModel = (List<ProductoModel>)Session["ProductosCatalogoPersonalizado"] ?? new List<ProductoModel>();
                var productoModel = listaProductoModel.FirstOrDefault(x => x.CUV == cuv);

                if (productoModel == null || !productoModel.EsMaquillaje || productoModel.Hermanos != null)
                {
                    productoModel = productoModel ?? new ProductoModel();
                    return Json(new
                    {
                        success = true,
                        data = productoModel
                    });
                }
                
                List<ServiceODS.BEProducto> listaHermanos;
                using (ODSServiceClient svc = new ODSServiceClient())
                {
                    listaHermanos = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, cuv).ToList();
                }

                if (listaHermanos.Any())
                {

                    var txtBuil = new StringBuilder();
                    foreach (var item in listaHermanos)
                    {
                        txtBuil.Append(item.CUV + ",");
                    }
                    string joinCuv = txtBuil.ToString();

                    joinCuv = joinCuv.Substring(0, joinCuv.Length - 1);

                    List<Producto> listaAppCatalogo;
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

                        var listaTonos = productoModel.Hermanos.OrderBy(e => e.NombreBulk).ToList();
                        productoModel.Tonos = listaTonos;
                    }

                    Session["ProductosCatalogoPersonalizadoFilter"] = listaProductoModel;
                }
                else
                {
                    productoModel.EsMaquillaje = false;
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
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los filtros"
                });
            }
        }
    }
}