using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    public class EstrategiaController : BaseEstrategiaController
    {
        [HttpPost]
        public JsonResult RDObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, (int)TipoListaModel.RDObtenerProductos);
        }

        private List<EstrategiaPersonalizadaProductoModel> ListaPerdio(int campaniaId, List<EstrategiaPedidoModel> listModelCompleta)
        {
            var listPerdioFormato = new List<EstrategiaPersonalizadaProductoModel>();
            try
            {
                var listPerdio = new List<EstrategiaPedidoModel>();
                if (TieneProductosPerdio(campaniaId))
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
                        var listPerdio1 = ConsultarEstrategiasModel(campaniaId, Constantes.TipoEstrategiaCodigo.RevistaDigital);
                        listPerdio = listPerdio1.Where(p => p.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.PackNuevas && p.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                    }

                    listPerdioFormato = ConsultarEstrategiasFormatearModelo(listPerdio, 1);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listPerdioFormato = new List<EstrategiaPersonalizadaProductoModel>();

            }
            return listPerdioFormato;
        }

        [HttpPost]
        public JsonResult GNDObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, (int)TipoListaModel.GNDObtenerProductos);
        }

        [HttpPost]
        public JsonResult HVObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, (int)TipoListaModel.HVObtenerProductos);
        }

        [HttpPost]
        public JsonResult RDObtenerProductosLan(BusquedaProductoModel model)
        {
            return PreparListaModel(model, (int)TipoListaModel.RDObtenerProductosLan);
        }

        [HttpPost]
        public JsonResult ConsultarEstrategiasOPT()
        {
            try
            {
                var listModel = ConsultarEstrategiasFormatearModelo(ConsultarEstrategiasModel());
                return Json(new
                {
                    success = true,
                    lista = listModel,
                    codigo = Constantes.ConfiguracionPais.OfertasParaTi
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                success = false
            });
        }

        [HttpGet]
        public JsonResult JsonConsultarEstrategias(string tipoOrigenEstrategia = "")
        {

            var model = new EstrategiaOutModel();
            try
            {
                var codAgrupa = (revistaDigital.TieneRDC && revistaDigital.EsActiva)
                    || (revistaDigital.TieneRDC && revistaDigital.ActivoMdo) ?
                    Constantes.TipoEstrategiaCodigo.RevistaDigital : "";

                var listModel = ConsultarEstrategiasHomePedido(codAgrupa);

                model.CodigoEstrategia = GetCodigoEstrategia();
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

                model.ListaLan = ConsultarEstrategiasFormatearModelo(listModel.Where(l => l.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList());
                model.ListaModelo = ConsultarEstrategiasFormatearModelo(listModel.Where(l => l.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList());
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

                var listModel = ConsultarMasVendidosModel();

                model.Lista = listModel;

                model = BSActualizarPosicion(model);
                model = BSActualizarPrecioFormateado(model);

                return Json(new { success = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message });
            }
        }

        private EstrategiaOutModel BSActualizarPosicion(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                }
            }
            return model;
        }

        private EstrategiaOutModel BSActualizarPrecioFormateado(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                    model.Lista[i].PrecioTachado = Util.DecimalToStringFormat(model.Lista[i].Precio, userData.CodigoISO);
                    model.Lista[i].GananciaString = Util.DecimalToStringFormat(model.Lista[i].Ganancia, userData.CodigoISO);
                }
            }
            return model;
        }

        [HttpGet]
        public JsonResult ConsultarEstrategiaCuv(string cuv)
        {
            var modelo = EstrategiaGetDetalle(0, cuv);
            return Json(modelo.Hermanos, JsonRequestBehavior.AllowGet);
        }

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
                modelo.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, modelo.FotoProducto01);
            }

            sessionManager.SetProductoTemporal(modelo);

            return Json(new
            {
                success = true
            }, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// Función que agrupa la construcción de la lista Model de estrategias para
        /// RDObtenerProductos, RDObtenerProductosLan, GNDObtenerProductos y HVObtenerProductos (JN, JUN-2018)
        /// </summary>
        private JsonResult PreparListaModel(BusquedaProductoModel model, int tipoListaObtenerProductos)
        {
            try
            {
                if (tipoListaObtenerProductos == (int)TipoListaModel.RDObtenerProductos || tipoListaObtenerProductos == (int)TipoListaModel.RDObtenerProductosLan)
                    if (model == null || !(revistaDigital.TieneRevistaDigital()) || EsCampaniaFalsa(model.CampaniaID))
                    {
                        return Json(new
                        {
                            success = false,
                            message = "",
                            lista = new List<ShowRoomOfertaModel>(),
                            cantidadTotal = 0,
                            cantidad = 0
                        });
                    }
                if (tipoListaObtenerProductos == (int)TipoListaModel.GNDObtenerProductos)
                    if (!GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                        return Json(new { success = false, message = "", data = "" });

                //Todas las llamadas a "ConsultarEstrategiasModel" centralizadas
                var palanca = string.Empty;
                if (tipoListaObtenerProductos == (int)TipoListaModel.RDObtenerProductos)
                    if (revistaDigital.ActivoMdo)
                        palanca = Constantes.TipoEstrategiaCodigo.RevistaDigital;
                    else
                        palanca = model.CampaniaID != userData.CampaniaID || (revistaDigital.TieneRDC && revistaDigital.EsActiva) ? Constantes.TipoEstrategiaCodigo.RevistaDigital : string.Empty;

                if (tipoListaObtenerProductos == (int)TipoListaModel.RDObtenerProductosLan)
                    palanca = Constantes.TipoEstrategiaCodigo.Lanzamiento;
                if (tipoListaObtenerProductos == (int)TipoListaModel.GNDObtenerProductos)
                    palanca = Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada;
                if (tipoListaObtenerProductos == (int)TipoListaModel.HVObtenerProductos)
                    palanca = Constantes.TipoEstrategiaCodigo.HerramientasVenta;

                var listaFinal = ConsultarEstrategiasModel(tipoListaObtenerProductos == (int)TipoListaModel.GNDObtenerProductos ? 0 : model.CampaniaID, palanca);

                switch (tipoListaObtenerProductos)
                {
                    case (int)TipoListaModel.RDObtenerProductos:
                    {
                        List<EstrategiaPedidoModel> listModel1;

                        var mdo0 = revistaDigital.ActivoMdo && !revistaDigital.EsActiva;

                        if (mdo0 && model.CampaniaID == userData.CampaniaID)
                        {
                            var listaRd = listaFinal.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi || e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso).ToList();
                            listModel1 = listaFinal.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.OfertasParaMi && e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.PackAltoDesembolso).ToList();
                            listModel1.AddRange(listaRd.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor0));
                        }
                        else
                            listModel1 = listaFinal;
                        
                        var listModel = ConsultarEstrategiasFormatearModelo(listModel1, 2);
                        var cantidadTotal = listModel.Count;
                        var listPerdio = ListaPerdio(model.CampaniaID, listaFinal);
                        return Json(new
                        {
                            success = true, lista = listModel, listaPerdio = listPerdio, cantidadTotal = cantidadTotal, cantidad = cantidadTotal, campaniaId = model.CampaniaID
                        });
                    }
                    case (int)TipoListaModel.RDObtenerProductosLan:
                    {
                        var perdio = TieneProductosPerdio(model.CampaniaID) ? 1 : 0;
                        var listModel = ConsultarEstrategiasFormatearModelo(listaFinal, perdio);
                        var cantidadTotal = listModel.Count;
                        return Json(new
                        {
                            success = true, listaLan = listModel, cantidadTotal = cantidadTotal, cantidad = cantidadTotal, campaniaId = model.CampaniaID, codigo = Constantes.ConfiguracionPais.Lanzamiento
                        });
                    }

                    case (int)TipoListaModel.GNDObtenerProductos:
                    {
                        if (revistaDigital.TieneRDCR)

                            if (GetConfiguracionManagerContains(Constantes.ConfiguracionManager.RevistaPiloto_Zonas_RDR_2 + userData.CodigoISO, userData.CodigoZona))
                                listaFinal = listaFinal.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1 || e.FlagRevista == Constantes.FlagRevista.Valor3).ToList();
                            else
                                listaFinal = listaFinal.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1).ToList();

                        var listModel = ConsultarEstrategiasFormatearModelo(listaFinal, 2);

                        int cantidadTotal = listModel.Count;

                        return Json(new
                        {
                            success = true, lista = listModel, campaniaId = model.CampaniaID, cantidadTotal = cantidadTotal, cantidad = cantidadTotal
                        });
                    }
                    case (int)TipoListaModel.HVObtenerProductos:
                        {
                            var listModel = ConsultarEstrategiasFormatearModelo(listaFinal, 2);
                            listModel = listModel .OrderByDescending(x => x.MarcaID == Constantes.Marca.Esika) .ThenByDescending(x => x.MarcaID == Constantes.Marca.LBel)
                            .ThenByDescending(x => x.MarcaID == Constantes.Marca.Cyzone).ToList();
                            int cantidadTotal = listModel.Count;

                            return Json(new
                            {
                                success = true, lista = listModel, campaniaId = model.CampaniaID, cantidadTotal = cantidadTotal, cantidad = cantidadTotal, codigo = Constantes.ConfiguracionPais.HerramientasVenta
                            });
                        }
                    default: return new JsonResult();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, tipoListaObtenerProductos == (int)TipoListaModel.RDObtenerProductos ? "EstrategiaController.RDObtenerProductos" : "");
                return Json(new
                {
                    success = false, message = "Error al cargar los productos", data = ""
                });
            }
        }
        enum TipoListaModel { RDObtenerProductos, RDObtenerProductosLan, GNDObtenerProductos, HVObtenerProductos };
    }
}