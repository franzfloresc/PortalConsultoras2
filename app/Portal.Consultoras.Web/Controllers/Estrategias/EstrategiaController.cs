using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    public class EstrategiaController : BaseEstrategiaController 
    {
        private readonly GuiaNegocioProvider _guiaNegocioProvider;

        public EstrategiaController()
        {
            _guiaNegocioProvider = new GuiaNegocioProvider();
        }

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

                model = _ofertaPersonalizadaProvider.BSActualizarPosicion(model);
                model = _ofertaPersonalizadaProvider.BSActualizarPrecioFormateado(model);

                return Json(new { success = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message });
            }
        }

        [HttpGet]
        public JsonResult ConsultarEstrategiaCuv(string cuv)
        {
            var modelo = EstrategiaGetDetalle(0, cuv) ?? new EstrategiaPersonalizadaProductoModel();
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

                var listaFinal1 = ConsultarEstrategiasModel(campania, palanca);

                var listPerdio = ConsultarOfertasListaPerdio(model, listaFinal1, tipoConsulta);

                listaFinal1 = _ofertaPersonalizadaProvider.ConsultarOfertasFiltrar(model, listaFinal1, tipoConsulta);

                var tipo = _ofertaPersonalizadaProvider.ConsultarOfertasTipoPerdio(model, tipoConsulta);

                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, tipo);

                var cantidadTotal = listModel.Count;

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    listaPerdio = listPerdio,
                    campaniaId = model.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    codigo = palanca
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
                var listPerdio = new List<EstrategiaPedidoModel>();
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

    }
}