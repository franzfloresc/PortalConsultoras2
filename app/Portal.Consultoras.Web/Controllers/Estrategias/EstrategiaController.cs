using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    public class EstrategiaController : BaseController // BaseEstrategiaController
    {
        protected OfertaBaseProvider _ofertaBaseProvider;
        public EstrategiaController()
        {
            _ofertaBaseProvider = new OfertaBaseProvider();
        }

        #region Metodos Por Palanca

        [HttpPost]
        public JsonResult RDObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos);
        }

        [HttpPost]
        public JsonResult GNDObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos);
        }

        [HttpPost]
        public JsonResult HVObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos);
        }

        [HttpPost]
        public JsonResult RDObtenerProductosLan(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan);
        }

        [HttpPost]
        public JsonResult ConsultarEstrategiasOPT(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos);
        }

        [HttpGet]
        public JsonResult JsonConsultarEstrategias(string tipoOrigenEstrategia = "")
        {
            var model = new EstrategiaOutModel();
            try
            {
                var codAgrupa = (revistaDigital.TieneRDC && revistaDigital.EsActiva)
                    || (revistaDigital.TieneRDC && revistaDigital.ActivoMdo) ?
                    Constantes.TipoEstrategiaCodigo.RevistaDigital : Constantes.TipoEstrategiaCodigo.OfertaParaTi;

                var listModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasHomePedido(IsMobile(), userData.CodigoISO, userData.CampaniaID, codAgrupa);

                model.CodigoEstrategia = _revistaDigitalProvider.GetCodigoEstrategia();
                model.Consultora = userData.Sobrenombre;
                model.Titulo = userData.Sobrenombre + " LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
                model.TituloDescripcion = tipoOrigenEstrategia == "1" ? "ENCUENTRA MÁS OFERTAS, MÁS BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS Y AUMENTA TUS GANANCIAS" :
                    (tipoOrigenEstrategia == "2" ? "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS"
                    : "ENCUENTRA LOS PRODUCTOS QUE TUS CLIENTES BUSCAN HASTA 65% DE DSCTO.");

                if (model.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.RevistaDigital)
                {
                    model.OrigenPedidoWeb = tipoOrigenEstrategia == "1" ? Constantes.OrigenPedidoWeb.RevistaDigitalDesktopHomeSeccion
                        : tipoOrigenEstrategia == "11" ? Constantes.OrigenPedidoWeb.RevistaDigitalDesktopPedidoSeccion
                        : tipoOrigenEstrategia == "2" ? Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion
                        : tipoOrigenEstrategia == "22" ? Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion
                        : (Request.UrlReferrer != null && IsMobile()) ? Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido : 0;
                }
                else
                {
                    model.OrigenPedidoWeb = tipoOrigenEstrategia == "1" ? Constantes.OrigenPedidoWeb.OfertasParaTiDesktopHome
                        : tipoOrigenEstrategia == "11" ? Constantes.OrigenPedidoWeb.OfertasParaTiDesktopPedido
                        : tipoOrigenEstrategia == "2" ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileHome
                        : tipoOrigenEstrategia == "22" ? Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido
                        : (Request.UrlReferrer != null && IsMobile()) ? Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido : 0;
                }


                var listaPedido = _pedidoWebProvider.ObtenerPedidoWebDetalle(0);

                model.ListaLan = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listModel.Where(l => l.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList(), listaPedido, userData.CodigoISO, userData.CampaniaID, 0, userData.esConsultoraLider, userData.Simbolo);
                model.ListaModelo = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listModel.Where(l => l.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList(), listaPedido, userData.CodigoISO, userData.CampaniaID, 0, userData.esConsultoraLider, userData.Simbolo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult BSObtenerOfertas()
        {
            try
            {
                var model = new EstrategiaOutModel();

                var listModel = _ofertaPersonalizadaProvider.ConsultarMasVendidosModel(IsMobile(), userData.CodigoISO, userData.CampaniaID);

                model.Lista = listModel;

                model = _ofertaPersonalizadaProvider.BSActualizarPosicion(model);
                model = _ofertaPersonalizadaProvider.BSActualizarPrecioFormateado(model);

                return Json(new { success = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message });
            }
        }

        /// <summary>
        /// Función unificada
        /// </summary>
        private JsonResult PreparListaModel(BusquedaProductoModel model, int tipoConsulta)
        {
            try
            {
                //var tipoConsulta = Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos;

                var jSon = _ofertaPersonalizadaProvider.ConsultarOfertasValidarPermiso(model, tipoConsulta);
                if (!jSon)
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        data = "",
                        lista = new List<ShowRoomOfertaModel>(),
                        cantidadTotal = 0,
                        cantidad = 0
                    });
                }

                var palanca = _ofertaPersonalizadaProvider.ConsultarOfertasTipoPalanca(model, tipoConsulta);

                var campania = _ofertaPersonalizadaProvider.ConsultarOfertasCampania(model, tipoConsulta);

                var listaFinal1 = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(IsMobile(), userData.CodigoISO, userData.CampaniaID, campania, palanca);

                var listPerdio = ConsultarOfertasListaPerdio(model, listaFinal1, tipoConsulta);

                listaFinal1 = _ofertaPersonalizadaProvider.ConsultarOfertasFiltrar(model, listaFinal1, tipoConsulta);

                var tipo = _ofertaPersonalizadaProvider.ConsultarOfertasTipoPerdio(model, tipoConsulta);

                var listaPedido = _pedidoWebProvider.ObtenerPedidoWebDetalle(0);
                var listModel = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaFinal1, listaPedido, userData.CodigoISO, userData.CampaniaID, tipo, userData.esConsultoraLider, userData.Simbolo);

                var cantidadTotal = listModel.Count;

                bool guarda = true;
                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, palanca))
                {
                    guarda = false;
                }

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    listaPerdio = listPerdio,
                    campaniaId = model.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    codigo = palanca,
                    codigoOrigen = model.Codigo,
                    guardaEnLocalStorage = guarda
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, ((int)tipoConsulta).ToString());
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los productos",
                    data = ""
                });
            }
        }

        private List<EstrategiaPersonalizadaProductoModel> ConsultarOfertasListaPerdio(BusquedaProductoModel model, List<EstrategiaPedidoModel> listModelCompleta, int tipo)
        {
            var listaRetorno = new List<EstrategiaPersonalizadaProductoModel>();
            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                listaRetorno = ConsultarOfertasListaPerdioRD(model.CampaniaID, listModelCompleta);
            }
            return listaRetorno;
        }

        private List<EstrategiaPersonalizadaProductoModel> ConsultarOfertasListaPerdioRD(int campaniaId, List<EstrategiaPedidoModel> listModelCompleta)
        {
            var listPerdioFormato = new List<EstrategiaPersonalizadaProductoModel>();
            try
            {
                List<EstrategiaPedidoModel> listPerdio;
                if (_ofertaPersonalizadaProvider.TieneProductosPerdio(campaniaId))
                {
                    var mdo0 = revistaDigital.ActivoMdo && !revistaDigital.EsActiva;
                    if (mdo0)
                    {
                        listPerdio = listModelCompleta.Where(e =>
                            (e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                            || e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso)
                            && (e.FlagRevista == Constantes.FlagRevista.Valor1 ||
                                e.FlagRevista == Constantes.FlagRevista.Valor2)
                            ).ToList();
                    }
                    else
                    {
                        var listPerdio1 = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(IsMobile(), userData.CodigoISO, userData.CampaniaID, campaniaId, Constantes.TipoEstrategiaCodigo.RevistaDigital);
                        listPerdio = listPerdio1.Where(p => p.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.PackNuevas && p.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                    }

                    var listaPedido = _pedidoWebProvider.ObtenerPedidoWebDetalle(0);

                    listPerdioFormato = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listPerdio, listaPedido, userData.CodigoISO, userData.CampaniaID, 1, userData.esConsultoraLider, userData.Simbolo);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listPerdioFormato = new List<EstrategiaPersonalizadaProductoModel>();

            }
            return listPerdioFormato;
        }

        #region Oferta Final

        public JsonResult ObtenerProductosOfertaFinal(int tipoOfertaFinal)
        {
            try
            {
                var listaProductoModel = ObtenerListadoProductosOfertaFinal(tipoOfertaFinal);

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaProductoModel
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = "",
                    limiteJetlore = 0
                });
            }
        }

        private List<ProductoModel> ObtenerListadoProductosOfertaFinal(int tipoOfertaFinal)
        {
            var paisesConPcm = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesConPcm);

            var tipoProductoMostrar = userData.CodigoISO != null && paisesConPcm.Contains(userData.CodigoISO) ? 2 : 1;

            var limiteJetlore = int.Parse(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreOfertaFinal));

            var listPedido = ObtenerPedidoWebDetalle();

            decimal descuentoprol = 0;

            if (listPedido.Any())
            {
                descuentoprol = listPedido[0].DescuentoProl;
            }

            var ofertaFinal = sessionManager.GetOfertaFinalModel();
            var objOfertaFinal = new ListaParametroOfertaFinal
            {
                ZonaID = userData.ZonaID,
                CampaniaID = userData.CampaniaID,
                CodigoConsultora = userData.CodigoConsultora,
                CodigoISO = userData.CodigoISO,
                CodigoRegion = userData.CodigorRegion,
                CodigoZona = userData.CodigoZona,
                Limite = limiteJetlore,
                MontoEscala = GetDataBarra().MontoEscala,
                MontoMinimo = userData.MontoMinimo,
                MontoTotal = listPedido.Sum(p => p.ImporteTotal) - descuentoprol,
                TipoOfertaFinal = tipoOfertaFinal,
                TipoProductoMostrar = tipoProductoMostrar,
                Algoritmo = ofertaFinal.Algoritmo,
                Estado = ofertaFinal.Estado,
                TieneMDO = revistaDigital.ActivoMdo
            };

            List<Producto> lista;
            using (var ps = new ProductoServiceClient())
            {
                lista = ps.ObtenerProductosOfertaFinal(objOfertaFinal).ToList();
            }

            var listaProductoModel = Mapper.Map<List<Producto>, List<ProductoModel>>(lista);
            if (listaProductoModel.Count(x => x.ID == 0) == listaProductoModel.Count)
            {
                for (var i = 0; i <= listaProductoModel.Count - 1; i++) { listaProductoModel[i].ID = i; }
            }

            if (lista.Count != 0)
            {
                var tipoCross = lista[0].TipoCross;
                listaProductoModel.Update(p =>
                {
                    p.PrecioCatalogoString = Util.DecimalToStringFormat(p.PrecioCatalogo, userData.CodigoISO);
                    p.PrecioValorizadoString = Util.DecimalToStringFormat(p.PrecioValorizado, userData.CodigoISO);
                    p.MetaMontoStr = Util.DecimalToStringFormat(p.MontoMeta, userData.CodigoISO);
                    p.Simbolo = userData.Simbolo;
                    p.NombreComercialCorto = Util.SubStrCortarNombre(p.NombreComercial, 40, "...");
                    var imagenUrl = Util.SubStr(p.Imagen, 0);

                    if (!tipoCross && userData.OfertaFinal == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                    {
                        var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                        imagenUrl = ConfigCdn.GetUrlFileCdn(carpetapais, imagenUrl);
                    }
                    p.ImagenProductoSugerido = imagenUrl;
                    p.ImagenProductoSugeridoSmall = _baseProvider.ObtenerRutaImagenResize(p.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall, userData.CodigoISO);
                    p.ImagenProductoSugeridoMedium = _baseProvider.ObtenerRutaImagenResize(p.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium, userData.CodigoISO);
                    p.TipoCross = tipoCross;
                });
            }

            return listaProductoModel;
        }

        #endregion

        public ActionResult ObtenerProductosSugeridos(string CUV)
        {
            var listaProductoModel = new List<ProductoModel>();

            try
            {
                List<ServiceODS.BEProducto> listaProduto;
                using (var sv = new ODSServiceClient())
                {
                    listaProduto = sv.GetProductoSugeridoByCUV(userData.PaisID, userData.CampaniaID, Convert.ToInt32(userData.ConsultoraID), CUV, userData.RegionID,
                        userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
                }

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                var esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaTieneStock = new List<Lista>();

                if (esFacturacion)
                {
                    var txtBuil = new StringBuilder();

                    foreach (var beProducto in listaProduto)
                    {
                        if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                        {
                            txtBuil.Append(beProducto.CodigoProducto + "|");
                        }
                    }

                    var codigoSap = txtBuil.ToString();
                    codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                    try
                    {
                        if (!string.IsNullOrEmpty(codigoSap))
                        {
                            using (var sv = new wsConsulta())
                            {
                                sv.Url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
                                listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                        listaTieneStock = new List<Lista>();
                    }
                }

                foreach (var beProducto in listaProduto)
                {
                    var tieneStockProl = true;
                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beProducto.CodigoProducto);
                        if (itemStockProl != null) tieneStockProl = itemStockProl.estado == 1;
                    }

                    if (beProducto.TieneStock && tieneStockProl)
                    {
                        listaProductoModel.Add(new ProductoModel()
                        {
                            CUV = beProducto.CUV.Trim(),
                            Descripcion = beProducto.Descripcion.Trim(),
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
                            ImagenProductoSugerido = beProducto.ImagenProductoSugerido ?? "",
                            ImagenProductoSugeridoSmall = _baseProvider.ObtenerRutaImagenResize(beProducto.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall, userData.CodigoISO),
                            ImagenProductoSugeridoMedium = _baseProvider.ObtenerRutaImagenResize(beProducto.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium, userData.CodigoISO),
                            CodigoProducto = beProducto.CodigoProducto,
                            TieneStockPROL = true
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaProductoModel = new List<ProductoModel>();
            }

            return Json(listaProductoModel, JsonRequestBehavior.AllowGet);
        }

        #endregion

        //[HttpGet]
        //public JsonResult ConsultarEstrategiaCuv(string cuv)
        //{
        //    var modelo = EstrategiaGetDetalle(0, cuv) ?? new EstrategiaPersonalizadaProductoModel();
        //    return Json(modelo.Hermanos, JsonRequestBehavior.AllowGet);
        //}

        [HttpPost]
        public JsonResult GuardarProductoTemporal(EstrategiaPersonalizadaProductoModel modelo)
        {
            if (modelo != null)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                modelo.ClaseBloqueada = Util.Trim(modelo.ClaseBloqueada);
                modelo.ClaseEstrategia = Util.Trim(modelo.ClaseEstrategia);
                modelo.CodigoEstrategia = Util.Trim(modelo.CodigoEstrategia);
                modelo.DescripcionResumen = Util.Trim(modelo.DescripcionResumen);
                modelo.DescripcionDetalle = Util.Trim(modelo.DescripcionDetalle);
                modelo.DescripcionCompleta = Util.Trim(modelo.DescripcionCompleta);
                modelo.PrecioTachado = Util.Trim(modelo.PrecioTachado);
                modelo.CodigoVariante = Util.Trim(modelo.CodigoVariante);
                modelo.TextoLibre = Util.Trim(modelo.TextoLibre);
                modelo.FotoProducto01 = ConfigCdn.GetUrlFileCdn(carpetaPais, modelo.FotoProducto01);
            }

            sessionManager.SetProductoTemporal(modelo);

            return Json(new
            {
                success = true
            }, JsonRequestBehavior.AllowGet);
        }
        
        #region Carrusel Ficha
        
        [HttpPost]
        public JsonResult FichaObtenerProductosCarrusel(string cuvExcluido, string palanca)
        {
            try
            {
                var listaOfertasModel = new List<EstrategiaPersonalizadaProductoModel>();

                if (palanca == Constantes.NombrePalanca.ShowRoom)
                {
                    listaOfertasModel = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                }
                else if (palanca == Constantes.NombrePalanca.OfertaDelDia)
                {
                    var oddSession = sessionManager.OfertaDelDia.Estrategia;
                    listaOfertasModel = oddSession.ListaOferta;
                }
                else if (palanca == Constantes.NombrePalanca.PackNuevas)
                {
                    var varSession = Constantes.ConstSession.ListaEstrategia + Constantes.TipoEstrategiaCodigo.PackNuevas;
                    var listaEstrategia = sessionManager.GetBEEstrategia(varSession);
                    if (listaEstrategia.Any())
                    {
                        listaOfertasModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasModelFormato(listaEstrategia, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
                    }
                }

                listaOfertasModel = _ofertaPersonalizadaProvider.RevisarCamposParaMostrar(listaOfertasModel, true);

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    data = listaOfertasModel==null?new List<EstrategiaPersonalizadaProductoModel>(): listaOfertasModel.Where(x => x.CUV2 != cuvExcluido).ToList()
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

     

        #endregion

    }
}