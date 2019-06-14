﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.OrigenPedidoWeb;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ElasticSearch;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    public class EstrategiaController : BaseController
    {
        protected OfertaBaseProvider _ofertaBaseProvider;
        protected ConfiguracionOfertasHomeProvider _configuracionOfertasHomeProvider;
        protected CarruselUpSellingProvider _carruselUpSellingProvider;
        private readonly ConfiguracionPaisDatosProvider _configuracionPaisDatosProvider;
       

        public EstrategiaController()
        {
            _ofertaBaseProvider = new OfertaBaseProvider();
            _configuracionPaisDatosProvider = new ConfiguracionPaisDatosProvider();
            _configuracionOfertasHomeProvider = new ConfiguracionOfertasHomeProvider();
            _carruselUpSellingProvider = new CarruselUpSellingProvider();
        }

        public EstrategiaController(ISessionManager sesionManager, ILogManager logManager, TablaLogicaProvider tablaLogicaProvider)
            : base(sesionManager, logManager)
        {
           
        }

        #region Metodos Por Palanca

        [HttpPost]
        public JsonResult RDObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos);
        }

        [HttpPost]
        public JsonResult RDObtenerProductosNuevas(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.NuevasObtenerProductos);
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
        public JsonResult LANObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.LANObtenerProductos);
        }

        [HttpPost]
        public JsonResult OPTObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos);
        }

        [HttpPost]
        public JsonResult SRObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.SRObtenerProductos);
        }

        [HttpPost]
        public JsonResult MGObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.MGObtenerProductos);
        }

        [HttpPost]
        public JsonResult ATPObtenerProductos(BusquedaProductoModel model)
        {
            return PreparListaModel(model, Constantes.TipoConsultaOfertaPersonalizadas.ATPObtenerProductos);
        }

        [HttpGet]
        public JsonResult HomePedidoObtenerProductos(string tipoOrigenEstrategia = "")
        {
            var model = new EstrategiaOutModel();
            try
            {
                var isMobile = IsMobile();
                var listModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasHomePedido(isMobile, userData);
                model.CodigoEstrategia = _revistaDigitalProvider.GetCodigoEstrategia();
                model.Consultora = userData.Sobrenombre;
                model.Titulo = userData.Sobrenombre + " LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
                model.TituloDescripcion = tipoOrigenEstrategia == "1" ? "ENCUENTRA MÁS OFERTAS, MÁS BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS Y AUMENTA TUS GANANCIAS" :
                    (tipoOrigenEstrategia == "2" ? "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS"
                    : "ENCUENTRA LOS PRODUCTOS QUE TUS CLIENTES BUSCAN HASTA 65% DE DSCTO.");

                model.OrigenPedidoWeb = HomePedidoObtenerProductos_OrigenPedidoWeb(model, tipoOrigenEstrategia, isMobile);
                var listaPedido = _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado();

                var bloquearBannerNuevas = (tipoOrigenEstrategia == "11" || tipoOrigenEstrategia == "21") && revistaDigital.TieneRDC && !revistaDigital.EsSuscrita;
                var listEstrategias = _ofertaPersonalizadaProvider.ValidBannerNuevas(isMobile, userData, listModel.Where(l => l.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList(), bloquearBannerNuevas);
                model.ListaLan = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listModel.Where(l => l.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList(), listaPedido, userData.CodigoISO, userData.CampaniaID, 0, userData.esConsultoraLider, userData.Simbolo);
                model.ListaModelo = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listEstrategias, listaPedido, userData.CodigoISO, userData.CampaniaID, 0, userData.esConsultoraLider, userData.Simbolo);


            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        private int HomePedidoObtenerProductos_OrigenPedidoWeb(EstrategiaOutModel model, string tipoOrigenEstrategia, bool isMobile)
        {
            var modeloOrigen = new OrigenPedidoWebModel
            {
                Palanca = ConsOrigenPedidoWeb.Palanca.OfertasParaTi,
                Seccion = ConsOrigenPedidoWeb.Seccion.Carrusel
            };

            switch (tipoOrigenEstrategia)
            {
                case "1":
                    modeloOrigen.Dispositivo = ConsOrigenPedidoWeb.Dispositivo.Desktop;
                    modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Home;
                   
                    break;
                case "11":
                    modeloOrigen.Dispositivo = ConsOrigenPedidoWeb.Dispositivo.Desktop;
                    modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Pedido;
                   
                    break;
                case "2":
                    modeloOrigen.Dispositivo = ConsOrigenPedidoWeb.Dispositivo.Mobile;
                    modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Home;
                   
                    break;
                case "21":
                    modeloOrigen.Dispositivo = ConsOrigenPedidoWeb.Dispositivo.Mobile;
                    modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Pedido;
                   
                    break;
                default:
                    if (Request.UrlReferrer != null && isMobile)
                    {
                        modeloOrigen.Dispositivo = ConsOrigenPedidoWeb.Dispositivo.Mobile;
                        modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Home;
                    }
                   
                    break;
            }

            model.OrigenPedidoWeb = UtilOrigenPedidoWeb.ToInt(modeloOrigen);
            return model.OrigenPedidoWeb;
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
        /// Obtener oferta de ficha
        /// </summary>
        /// <param name="cuv"></param>
        /// <param name="campania"></param>
        /// <param name="codigoISO"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult ObtenerOfertaFicha(string cuv, string campania, string tipoEstrategia)
        {
            string message;
            try
            {
                DetalleEstrategiaFichaModel model = _ofertaPersonalizadaProvider.GetEstrategiaFicha(cuv, campania, tipoEstrategia, out message);

                return Json(new { success = true, data = model, message }, JsonRequestBehavior.AllowGet);
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

                var esMobile = IsMobile();

                var palanca = _ofertaPersonalizadaProvider.ConsultarOfertasTipoPalanca(model, tipoConsulta);

                List<EstrategiaPersonalizadaProductoModel> listModel;
                List<EstrategiaPersonalizadaProductoModel> listPerdio;

                var listaSubCampania = new List<EstrategiaPersonalizadaProductoModel>();
                int cantidadTotal0 = 0;
                if (tipoConsulta == Constantes.TipoConsultaOfertaPersonalizadas.SRObtenerProductos)
                {
                    if (_ofertaBaseProvider.UsarSession(Constantes.TipoEstrategiaCodigo.ShowRoom))
                    {
                        listModel = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                        cantidadTotal0 = listModel.Count;
                        listModel = _ofertaPersonalizadaProvider.ConsultarOfertasFiltrarSR(model, listModel, tipoConsulta);
                        listPerdio = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 3);
                        listaSubCampania = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 2);
                    }
                    else
                    {
                        List<ServiceOferta.BEEstrategia> listaProducto = _ofertaPersonalizadaProvider.GetShowRoomOfertasConsultora(userData);


                        List<EstrategiaPedidoModel> listaProductoModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasFormatoEstrategiaToModel1(listaProducto, userData.CodigoISO, userData.CampaniaID);

                        List<EstrategiaPedidoModel> listaEstrategiaOfertas;
                        List<EstrategiaPedidoModel> listaEstrategiaSubCampania;
                        var listaEstrategiaOfertasPerdio = new List<EstrategiaPedidoModel>();

                        if (revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
                        {
                            listaEstrategiaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                            listaEstrategiaOfertasPerdio = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0).ToList();
                            listaEstrategiaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                        }
                        else
                        {
                            listaEstrategiaOfertas = listaProductoModel.Where(x => !x.EsSubCampania).ToList();
                            listaEstrategiaSubCampania = listaProductoModel.Where(x => x.EsSubCampania).ToList();
                        }

                        listaEstrategiaSubCampania = _ofertaPersonalizadaProvider.ObtenerListaHermanos(listaEstrategiaSubCampania);

                        //boton "ELIGE TU OPCION"
                        listaEstrategiaSubCampania.ForEach(item =>
                        {
                            if (item.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
                                item.CodigoEstrategia = Constantes.TipoEstrategiaSet.CompuestaFija;
                        });

                       
                        var listaPedido = ObtenerPedidoWebSetDetalleAgrupado();

                        listModel = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaEstrategiaOfertas, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo).OrderBy(x => x.TieneStock, false).ToList();
                        cantidadTotal0 = listModel.Count;
                        listModel = _ofertaPersonalizadaProvider.ConsultarOfertasFiltrarSR(model, listModel, tipoConsulta);
                        listPerdio = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaEstrategiaOfertasPerdio, listaPedido, userData.CodigoISO, userData.CampaniaID, 1, userData.esConsultoraLider, userData.Simbolo).Where(x => x.TieneStock).OrderBy(x => x.TieneStock, false).ToList();
                        listaSubCampania = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaEstrategiaSubCampania, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo).OrderBy(x => x.TieneStock, false).ToList();
                        SessionManager.ShowRoom.CargoOfertas = "0";
                    }
                }
                else
                {
                    var campania = _ofertaPersonalizadaProvider.ConsultarOfertasCampania(model, tipoConsulta);

                    var listaFinal1 = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(esMobile, userData.CodigoISO, userData.CampaniaID, campania, palanca);

                    listPerdio = ConsultarOfertasListaPerdio(model, listaFinal1, tipoConsulta);

                    listaFinal1 = _ofertaPersonalizadaProvider.ConsultarOfertasFiltrar(model, listaFinal1, tipoConsulta);

                    var tipo = _ofertaPersonalizadaProvider.ConsultarOfertasTipoPerdio(model, tipoConsulta);

                    var listaPedido = _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado();

                    listModel = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaFinal1, listaPedido, userData.CodigoISO, userData.CampaniaID, tipo, userData.esConsultoraLider, userData.Simbolo);
                }

                listModel = _ofertaPersonalizadaProvider.SetCodigoPalancaMostrar(listModel, palanca);

                var cantidadTotal = listModel.Count + listPerdio.Count;

                bool guardaEnLS = _ofertaBaseProvider.UsarLocalStorage(palanca);

                var objBannerCajaProducto = _configuracionPaisDatosProvider.GetBannerCajaProducto(tipoConsulta, esMobile);

                ActualizarSession(tipoConsulta, (tipoConsulta == Constantes.TipoConsultaOfertaPersonalizadas.SRObtenerProductos ? cantidadTotal0 : cantidadTotal));

                var estaEnPedido = VerificarEnPedido(tipoConsulta);

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    listaPerdio = listPerdio,
                    listaSubCampania,
                    campaniaId = model.CampaniaID,
                    cantidadTotal,
                    cantidad = cantidadTotal,
                    cantidadTotal0,
                    codigo = palanca,
                    codigoOrigen = model.Codigo,
                    guardaEnLocalStorage = guardaEnLS,
                    objBannerCajaProducto,
                    estaEnPedido
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, tipoConsulta.ToString());
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los productos",
                    data = "",
                    ex = Common.LogManager.GetMensajeError(ex)
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
            listaRetorno = listaRetorno.Where(x => x.TieneStock).ToList();
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

        private void ActualizarSession(int tipoConsulta, int cantidadTotal)
        {
            try
            {
                switch (tipoConsulta)
                {
                    case Constantes.TipoConsultaOfertaPersonalizadas.MGObtenerProductos:
                        {
                            var session = SessionManager.MasGanadoras.GetModel();
                            var tieneLanding = ActualizarSession_TieneLanding(session.TieneLanding, cantidadTotal);
                            if (!tieneLanding)
                            {
                                session.TieneLanding = tieneLanding;
                                SessionManager.MasGanadoras.SetModel(session);
                            }

                            break;
                        }

                    case Constantes.TipoConsultaOfertaPersonalizadas.SRObtenerProductos:
                        {
                            var session = SessionManager.ShowRoom;
                            session.TieneLanding = ActualizarSession_TieneLanding(session.TieneLanding, cantidadTotal);
                            break;
                        }

                    case Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos:
                        {
                            var session = SessionManager.GetRevistaDigital();
                            session.TieneLanding = ActualizarSession_TieneLanding(session.TieneLanding, cantidadTotal);
                            break;
                        }

                    case Constantes.TipoConsultaOfertaPersonalizadas.ATPObtenerProductos:
                        {
                            var session = SessionManager.GetArmaTuPack();
                            session.TieneLanding = cantidadTotal > 0;
                            SessionManager.SetArmaTuPack(session);

                            if (!session.TieneLanding)
                            {
                                SessionManager.SetMenuContenedor(null);
                            }

                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, tipoConsulta.ToString());
            }
        }

        private bool ActualizarSession_TieneLanding(bool tieneLanding, int cantidadTotal)
        {
            if (tieneLanding)
            {
                var seccionesContenedor = _configuracionOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, IsMobile());
                var entConf = seccionesContenedor.FirstOrDefault(s => s.Codigo == Constantes.ConfiguracionPais.RevistaDigital) ?? new ConfiguracionSeccionHomeModel();
                var cantidad = entConf.CantidadMostrar;
                if (cantidadTotal <= cantidad)
                {
                    tieneLanding = false;
                }
            }
            return tieneLanding;
        }

        private bool VerificarEnPedido(int tipoConsulta)
        {
            var respuesta = false;
            if (tipoConsulta == Constantes.TipoConsultaOfertaPersonalizadas.ATPObtenerProductos)
            {
                var listaPedido = _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado();
                respuesta = listaPedido.Any(p => p.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack);
            }
            return respuesta;
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

            var ofertaFinal = SessionManager.GetOfertaFinalModel();
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
                        imagenUrl = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, imagenUrl);
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
                    var codigoSap = SugeridosObtenerProductos_Sap(listaProduto);
                    listaTieneStock = SugeridosObtenerProductos_ConsultaStock(codigoSap);
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

        private string SugeridosObtenerProductos_Sap(List<ServiceODS.BEProducto> listaProduto)
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

            return codigoSap;
        }

        private List<Lista> SugeridosObtenerProductos_ConsultaStock(string codigoSap)
        {
            var listaTieneStock = new List<Lista>();
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
            return listaTieneStock;
        }

        #endregion

        [HttpPost]
        public JsonResult GuardarProductoTemporal(EstrategiaPersonalizadaProductoModel modelo)
        {
            if (modelo != null)
            {
                modelo.ClaseBloqueada = Util.Trim(modelo.ClaseBloqueada);
                modelo.ClaseEstrategia = Util.Trim(modelo.ClaseEstrategia);
                modelo.CodigoEstrategia = Util.Trim(modelo.CodigoEstrategia);
                modelo.DescripcionResumen = Util.Trim(modelo.DescripcionResumen);
                modelo.DescripcionDetalle = Util.Trim(modelo.DescripcionDetalle);
                modelo.DescripcionCompleta = Util.Trim(modelo.DescripcionCompleta);
                modelo.PrecioTachado = Util.Trim(modelo.PrecioTachado);
                modelo.CodigoVariante = Util.Trim(modelo.CodigoVariante);
                modelo.TextoLibre = Util.Trim(modelo.TextoLibre);
                modelo.FotoProducto01 = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, modelo.FotoProducto01);
            }

            SessionManager.SetProductoTemporal(modelo);

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
                    listaOfertasModel = _ofertaPersonalizadaProvider.ObtenerListaProductoODD(userData);
                }
                else if (palanca == Constantes.NombrePalanca.PackNuevas)
                {
                    var varSession = Constantes.ConstSession.ListaEstrategia + Constantes.TipoEstrategiaCodigo.PackNuevas;
                    var listaEstrategia = SessionManager.GetBEEstrategia(varSession);
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
                    result = listaOfertasModel == null ? new List<EstrategiaPersonalizadaProductoModel>() : listaOfertasModel.Where(x => x.CUV2 != cuvExcluido).ToList()
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

        [HttpPost]
        public async Task<JsonResult> FichaObtenerProductosUpSellingCarrusel(string cuvExcluido, string palanca, string[] codigosProductos, double precioProducto)
        {
            try
            {
                if (cuvExcluido.IsNullOrEmptyTrim() ||
                    palanca.IsNullOrEmptyTrim() ||
                    precioProducto <= 0) return Json(new { success = false });

                var mostrarFuncionalidadUpSelling = _tablaLogicaProvider.GetTablaLogicaDatoValorInt(userData.PaisID,
                    ConsTablaLogica.ConfiguracionesFicha.TablaLogicaId,
                    ConsTablaLogica.ConfiguracionesFicha.FuncionalidadUpSelling, true);

                if (mostrarFuncionalidadUpSelling == 0 || palanca == Constantes.NombrePalanca.OfertaDelDia)
                {
                    return FichaObtenerProductosCarrusel(cuvExcluido, palanca);
                }

                var dataProductosCarruselUpSelling = await _carruselUpSellingProvider.ObtenerProductosCarruselUpSelling(cuvExcluido, codigosProductos, precioProducto);

                if (!dataProductosCarruselUpSelling.success)
                {
                    return Json(new OutputProductosUpSelling()
                    {
                        result = new List<EstrategiaPersonalizadaProductoModel>()
                    });
                }

                var listaProductosValidados = ValidacionResultadosProductos(dataProductosCarruselUpSelling.result).ToList();
                var listaOfertasModel = _ofertaPersonalizadaProvider.RevisarCamposParaMostrar(listaProductosValidados, true);
                return Json(new
                {
                    success = true,
                    result = listaOfertasModel
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

        private IList<EstrategiaPersonalizadaProductoModel> ValidacionResultadosProductos(IList<EstrategiaPersonalizadaProductoModel> estrategiaPersonalizadaProductoModels)
        {
            if (!estrategiaPersonalizadaProductoModels.Any()) return new List<EstrategiaPersonalizadaProductoModel>();
            var pedidos = SessionManager.GetDetallesPedido();

            foreach (var item in estrategiaPersonalizadaProductoModels)
            {
                var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV2).ToList();
                item.IsAgregado = pedidoAgregado.Any();

                item.CampaniaID = userData.CampaniaID;
                item.PrecioVenta = Util.DecimalToStringFormat(item.Precio2.ToDecimal(), userData.CodigoISO);
                item.PrecioTachado = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO);
                item.ClaseBloqueada = "";
                item.ClaseEstrategia = "revistadigital-landing";
                item.TipoAccionAgregar = _ofertaPersonalizadaProvider.TipoAccionAgregar(
                    item.CodigoVariante == "2003" ? 1 : 0,
                    item.CodigoEstrategia,
                    userData.esConsultoraLider,
                    false,
                    item.CodigoVariante);
               
            }

            return estrategiaPersonalizadaProductoModels;
        }
        #endregion
    }
}