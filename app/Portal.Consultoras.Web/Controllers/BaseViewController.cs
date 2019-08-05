using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Common.OrigenPedidoWeb;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.DetalleEstrategia;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseViewController : BaseController
    {
        private readonly IssuuProvider _issuuProvider;
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;
        private readonly PromocionesProvider promocionesProvider;

        public BaseViewController() : base()
        {
            _issuuProvider = new IssuuProvider();
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
            promocionesProvider = new PromocionesProvider();
        }

        public BaseViewController(ISessionManager sesionManager)
            : base(sesionManager)
        {

        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager)
            : base(sesionManager, logManager)
        {

        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider, OfertaViewProvider ofertaViewProvider)
            : base(sesionManager, logManager, ofertaPersonalizadaProvider, ofertaViewProvider)
        {
        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager, EstrategiaComponenteProvider estrategiaComponenteProvider)
            : base(sesionManager, logManager, estrategiaComponenteProvider)
        {
        }

        #region RevistaDigital

        public ActionResult RDIndexModel()
        {


            if (revistaDigital.TieneRDI)
                return View("template-informativa-rdi");

            var esMobile = IsMobile();
            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDS)
                return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });

            var modelo = _revistaDigitalProvider.InformativoModel(IsMobile());
            return View("template-informativa", modelo);
        }

        public ActionResult RDViewLanding(int tipo)
        {
            var model = GetLandingModel(tipo);

            return PartialView("template-landing", model);
        }

        protected RevistaDigitalLandingModel GetLandingModel(int tipo, string TipoPalanca = "")
        {
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile()),
                CantidadFilas = 30
            };

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(model.CampaniaID, IsMobile());
            model.ProductosPerdio = dato.Estado;
            model.PerdioTitulo = dato.Valor1;
            model.PerdioSubTitulo = dato.Valor2;

            model.PerdioLogo = revistaDigital.DLogoComercialActiva;

            switch (TipoPalanca)
            {
                case Constantes.ConfiguracionPais.ProgramaNuevas:
                    model.MostrarFiltros = true;
                    break;
                default:
                    model.MostrarFiltros = !model.ProductosPerdio && !(revistaDigital.TieneRDC && !revistaDigital.EsActiva);
                    break;
            }

            return model;
        }

        #endregion

        #region Guia Negocio

        public virtual ActionResult GNDViewLanding()
        {
            ViewBag.CodigoRevistaActual = _issuuProvider.GetRevistaCodigoIssuu(userData.CampaniaID.ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            ViewBag.CodigoRevistaAnterior = _issuuProvider.GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, -1, userData.NroCampanias).ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            ViewBag.CodigoRevistaSiguiente = _issuuProvider.GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = userData.CampaniaID,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = new MensajeProductoBloqueadoModel(),
                CantidadFilas = 10
            };

            return PartialView("Index", model);
        }

        #endregion

        #region Las mas Ganadoras

        public ActionResult MasGanadorasViewLanding()
        {
            var id = userData.CampaniaID;

            bool esMobile = IsMobile();

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = esMobile,
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(esMobile),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.HVMensajeProductoBloqueado(herramientasVenta, esMobile),
                CantidadFilas = 10
            };

            return PartialView("template-landing", model);
        }

        #endregion

        #region Herramienta Venta

        public ActionResult HVViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            bool esMobile = IsMobile();

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = esMobile,
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.HVMensajeProductoBloqueado(herramientasVenta, esMobile),
                CantidadFilas = 10
            };

            return PartialView("template-landing", model);
        }

        #endregion

        #region ShowRoom

        #endregion

        #region Detalle Estrategia  - Ficha

        public virtual ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            try
            {
                var modelo = new DetalleEstrategiaFichaModel
                {
                    Palanca = palanca,
                    Campania = campaniaId,
                    Cuv = cuv,
                    OrigenUrl = origen
                };
                return View(modelo);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseViewController.Ficha");
            }

            return Redireccionar();
        }

        protected ActionResult Redireccionar()
        {
            string sap = "";
            var url = (Request.Url.Query).Split('?');
            if (url.Length > 1 && url[1].Contains("sap"))
            {
                SessionManager.SetUrlVc(1);
                sap = "&" + url[1].Substring(3);
                if (EsDispositivoMovil())
                {
                    return RedirectToAction("Index", "Ofertas", new { area = "Mobile", sap });
                }
                else
                {
                    return RedirectToAction("Index", "Ofertas", sap);
                }
            }
            return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });

        }

        private DetalleEstrategiaBreadCrumbsModel GetDetalleEstrategiaBreadCrumbs(int campania, string palanca)
        {
            var breadCrumbs = new DetalleEstrategiaBreadCrumbsModel();

            try
            {
                bool tieneRevistaDigital = revistaDigital.TieneRevistaDigital();
                bool productoPerteneceACampaniaActual = userData.CampaniaID == campania;
                var area = Util.EsDispositivoMovil() ? "mobile" : string.Empty;

                breadCrumbs.Inicio.Texto = MobileAppConfiguracion.EsAppMobile ? null : "Inicio";
                breadCrumbs.Ofertas.Texto = tieneRevistaDigital && revistaDigital.EsSuscrita ? "Gana +" : "Ofertas Digitales";
                breadCrumbs.Palanca.Texto = GetNombresPalancas(palanca);

                breadCrumbs.Inicio.Url = Url.Action("Index", new { controller = "Bienvenida", area });

                var actionOfertas = productoPerteneceACampaniaActual ? "Index" : "Revisar";
                breadCrumbs.Ofertas.Url = Url.Action(actionOfertas, new { controller = "Ofertas", area });

                if (palanca == Constantes.NombrePalanca.CaminoBrillanteDemostradores || palanca == Constantes.NombrePalanca.CaminoBrillanteKits)
                {
                    area = "";
                    breadCrumbs.Ofertas.Texto = Constantes.NombrePalanca.CaminoBrillante;
                    breadCrumbs.Palanca.Texto = GetNombresPalancas(palanca);
                    breadCrumbs.Ofertas.Url = Url.Action("Index", new { controller = "CaminoBrillante", area });
                }

                breadCrumbs.Palanca.Url = "#";
                if (!string.IsNullOrWhiteSpace(breadCrumbs.Palanca.Texto))
                {
                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area });
                    switch (palanca)
                    {
                        case Constantes.NombrePalanca.ShowRoom:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "ShowRoom", area });
                            break;
                        case Constantes.NombrePalanca.Lanzamiento:
                            {
                                var actionPalanca = productoPerteneceACampaniaActual ? "Index" : "Revisar";
                                breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.Lanzamiento;
                                break;
                            }
                        case Constantes.NombrePalanca.OfertaParaTi:
                        case Constantes.NombrePalanca.OfertasParaMi:
                        case Constantes.NombrePalanca.RevistaDigital:
                            {
                                if (tieneRevistaDigital)
                                {
                                    var actionPalanca = productoPerteneceACampaniaActual ? "Comprar" : "Revisar";
                                    breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "RevistaDigital", area });
                                }
                                else
                                {
                                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.OfertasParaTi;
                                }

                                break;
                            }
                        case Constantes.NombrePalanca.PackNuevas:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "ProgramaNuevas", area });
                            break;
                        case Constantes.NombrePalanca.OfertaDelDia:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.OfertaDelDia;
                            break;
                        case Constantes.NombrePalanca.GuiaDeNegocioDigitalizada:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "GuiaNegocio", area });
                            break;
                        case Constantes.NombrePalanca.CaminoBrillanteDemostradores:
                            {
                                breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "CaminoBrillante/Ofertas", area ,t=1});
                                break;
                            }
                        case Constantes.NombrePalanca.CaminoBrillanteKits:
                            {
                                breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "CaminoBrillante/Ofertas", area });
                                break;
                            }
                        case Constantes.NombrePalanca.HerramientasVenta:
                            {
                                var actionPalanca = productoPerteneceACampaniaActual ? "Comprar" : "Revisar";
                                breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "HerramientasVenta", area });
                                break;
                            }

                        case Constantes.NombrePalanca.MasGanadoras:
                            breadCrumbs.Palanca.Url =
                                SessionManager.MasGanadoras.GetModel().TieneLanding
                                ? Url.Action("Index", new { controller = "MasGanadoras", area })
                                : (Url.Action("Index", new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.MasGanadoras);

                            break;
                        case Constantes.NombrePalanca.Catalogo:
                            breadCrumbs.Ofertas.Texto = string.Empty;
                            breadCrumbs.Ofertas.Url = "#";
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "BusquedaProductos" });
                            break;
                    }
                }

                breadCrumbs.Producto.Url = "#";
            }
            catch
            {
                // Excepcion
            }

            return breadCrumbs;
        }

        private string GetNombresPalancas(string palanca)
        {
            var nombresPalancas = new Dictionary<string, string>
            {
                { Constantes.NombrePalanca.ShowRoom, "Especiales" },
                { Constantes.NombrePalanca.Lanzamiento, "Lo nuevo ¡Nuevo!" },
                { Constantes.NombrePalanca.OfertaParaTi, "Ofertas para ti" },
                { Constantes.NombrePalanca.OfertasParaMi, "Ofertas Para ti" },
                { Constantes.NombrePalanca.RevistaDigital, "Revista Digital" },
                { Constantes.NombrePalanca.OfertaDelDia, "¡Solo Hoy!" },
                { Constantes.NombrePalanca.GuiaDeNegocioDigitalizada, "Guía De Negocio" },
                { Constantes.NombrePalanca.HerramientasVenta, "Demostradores" },
                { Constantes.NombrePalanca.MasGanadoras, "Las más ganadoras" },
                { Constantes.NombrePalanca.CaminoBrillanteDemostradores, "Demostradores" },
                { Constantes.NombrePalanca.CaminoBrillanteKits, "Kits" },
                { Constantes.NombrePalanca.PackNuevas, _programaNuevasProvider.TieneDuoPerfecto() ? "Dúo Perfecto" : "Programa Nuevas" },
                { Constantes.NombrePalanca.Catalogo, "Búsqueda" }
            };

            return nombresPalancas.ContainsKey(palanca) ? nombresPalancas[palanca] : string.Empty;
        }

        public int GetFichaOrigenPedidoWeb(string origen, string tipo = "", bool tieneCarrusel = false, bool esPromocion = false,bool esCondicionPromocion = false)
        {
            origen = Util.Trim(origen);
            if (origen == "" || origen.Length < 7)
            {
                return 0;
            }

            int intOrigen = Convert.ToInt32(origen);

            if (intOrigen <= 0)
            {
                return 0;
            }

            var modeloOrigen = UtilOrigenPedidoWeb.GetModelo(origen);
            var codigoSeccion = ConsOrigenPedidoWeb.Seccion.Ficha;

            tipo = Util.Trim(tipo);
            if (tieneCarrusel)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.CarruselVerMas;

                if (modeloOrigen.Palanca != ConsOrigenPedidoWeb.Palanca.Lanzamientos)
                {
                    modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
                    codigoSeccion = tipo;
                }
                else
                {
                    if (tipo == ConsOrigenPedidoWeb.Seccion.CarruselCrossSelling || tipo == ConsOrigenPedidoWeb.Seccion.CarruselSugeridos)
                    {
                        modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
                        codigoSeccion = tipo;
                    }
                }
            }
            else if(esPromocion && !esCondicionPromocion)
            {
                modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.PromocionProducto;
            }
            else if (!esPromocion && esCondicionPromocion)
            {
                modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.PromocionCondicional;
            }
            else if (modeloOrigen.Seccion == ConsOrigenPedidoWeb.Seccion.Recomendado)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.RecomendadoFicha;
            }
            else if (modeloOrigen.Seccion == ConsOrigenPedidoWeb.Seccion.CarruselUpselling)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.FichaUpselling;
                modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
            }
            else if (modeloOrigen.Seccion == ConsOrigenPedidoWeb.Seccion.CarruselCrossSelling)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.FichaCrossSelling;
                modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
            }
            else if (modeloOrigen.Seccion == ConsOrigenPedidoWeb.Seccion.CarruselSugeridos)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.FichaSugeridos;
                modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
            }
            modeloOrigen.Seccion = codigoSeccion;
            int result = UtilOrigenPedidoWeb.ToInt(modeloOrigen);
            return result;
        }
        #endregion

        public DetalleEstrategiaFichaModel FichaModelo(string palanca, int campaniaId, string cuv, string origen, bool esEditar = false)
        {
            if (_ofertaPersonalizadaProvider == null)
                throw new ClientInformationException("_ofertaPersonalizadaProvider can not be null");

            if (!_ofertaPersonalizadaProvider.EnviaronParametrosValidos(palanca, campaniaId, cuv))
            {
                return null;
            }

            palanca = IdentificarPalancaRevistaDigital(palanca, campaniaId);

            if (!_ofertaPersonalizadaProvider.TienePermisoPalanca(palanca))
                return null;

            var esMobile = Util.EsDispositivoMovil();
            DetalleEstrategiaFichaModel modelo = GetEstrategiaInicial(palanca, campaniaId, cuv);

            if (modelo == null)
            {
                modelo = new DetalleEstrategiaFichaModel
                {
                    Error = true
                };
            }

            #region Modelo

            modelo.Cantidad = 1;
            modelo.OrigenUrl = origen;
            modelo.OrigenAgregar = GetFichaOrigenPedidoWeb(origen);
            modelo.CodigoUbigeoPortal = esEditar ? CodigoUbigeoPortal.GuionPedidoGuionFichaResumida : "";
            modelo.TipoAccionNavegar = GetTipoAccionNavegar(modelo.OrigenAgregar, esMobile, esEditar);

            modelo.BreadCrumbs = modelo.TipoAccionNavegar == Constantes.TipoAccionNavegar.BreadCrumbs
                ? GetDetalleEstrategiaBreadCrumbs(campaniaId, palanca)
               : new DetalleEstrategiaBreadCrumbsModel();
            modelo.BreadCrumbs.TipoAccionNavegar = modelo.TipoAccionNavegar;
            modelo.Palanca = palanca;
            modelo.TieneSession = _ofertaPersonalizadaProvider.PalancasConSesion(palanca);
            modelo.Campania = campaniaId;
            modelo.Cuv = cuv;
            modelo.TieneCarrusel = GetValidationHasCarrusel(modelo.OrigenAgregar, esEditar);
            modelo.OrigenAgregarCarrusel = modelo.TieneCarrusel ? GetFichaOrigenPedidoWeb(origen, ConsOrigenPedidoWeb.Seccion.CarruselUpselling, modelo.TieneCarrusel) : 0;
            modelo.OrigenAgregarCarruselCroselling = modelo.TieneCarrusel ? GetFichaOrigenPedidoWeb(origen, ConsOrigenPedidoWeb.Seccion.CarruselCrossSelling, modelo.TieneCarrusel) : 0;
            modelo.OrigenAgregarCarruselSugeridos = modelo.TieneCarrusel ? GetFichaOrigenPedidoWeb(origen, ConsOrigenPedidoWeb.Seccion.CarruselSugeridos, modelo.TieneCarrusel) : 0;
            modelo.OrigenAgregarPromocion = modelo.EsPromocion ? GetFichaOrigenPedidoWeb(origen, ConsOrigenPedidoWeb.Seccion.PromocionProducto,false,true,false) : 0;
            modelo.OrigenAgregarCondiciones = modelo.EsPromocion ? GetFichaOrigenPedidoWeb(origen, ConsOrigenPedidoWeb.Seccion.PromocionCondicional, false,false,true) : 0;
            modelo.TieneCompartir = GetTieneCompartir(palanca, esEditar, modelo.OrigenAgregar);
            #endregion
            
            #region ODD
            if (modelo.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
            {
                modelo = GetDatosOdd(modelo);
            }
            #endregion

            modelo.NoEsCampaniaActual = campaniaId != userData.CampaniaID;
            modelo.MostrarFichaEnriquecida = GetInformacionAdicional(esEditar);
            
            if (modelo.Error)
            {
                return modelo;
            }

            modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile);
            modelo.MostrarCliente = GetMostrarCliente(esEditar);

            modelo.MostrarUpselling = _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.ConfiguracionesFicha.TablaLogicaId,
                            ConsTablaLogica.ConfiguracionesFicha.FuncionalidadUpSelling,
                            true
                            );
            return modelo;
        }

        public DetalleEstrategiaFichaModel GetEstrategiaMongo(string palanca, int campaniaId, string cuv)
        {
            string codigoPalanca = string.Empty;

            Constantes.NombrePalanca.PalancasbyCodigo.TryGetValue(palanca, out codigoPalanca);

            var modelo = _ofertaPersonalizadaProvider.GetEstrategiaFicha(cuv, campaniaId.ToString(), codigoPalanca);

            if (modelo == null) return null;

            if (userData.CampaniaID != campaniaId) modelo.ClaseBloqueada = "btn_desactivado_general";
            if (palanca == Constantes.NombrePalanca.PackNuevas)
            {
                modelo.TipoEstrategiaDetalle.Slogan = "Contenido del Set:";
                modelo.ListaDescripcionDetalle = modelo.ArrayContenidoSet;
            }

            // validar stock del CUV padre
            var lstModelo = new List<DetalleEstrategiaFichaModel>();
            lstModelo.Add(modelo);
            lstModelo = _ofertaPersonalizadaProvider.ActualizarEstrategiaStockProl(lstModelo, userData);
            modelo.TieneStock = lstModelo.First(x => x.CUV2 == modelo.CUV2).TieneStock;

            // validar stock de los CUV componentes
            modelo.Hermanos = _estrategiaComponenteProvider.FormatterEstrategiaComponentes(modelo.Hermanos, modelo.CUV2, modelo.CampaniaID, true);
            modelo = _ofertaPersonalizadaProvider.FormatterEstrategiaFicha(modelo, userData.CampaniaID);
            
            modelo.MostrarPromociones = _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.FlagFuncional.TablaLogicaId,
                            ConsTablaLogica.FlagFuncional.Promociones,
                            true
                            );

            #region Promociones
            if(modelo.MostrarPromociones && !string.IsNullOrEmpty(modelo.CuvPromocion))
            {
                var promociones = promocionesProvider.GetPromociones(userData.CodigoISO, userData.CampaniaID.ToString(), modelo.CuvPromocion);

                if (promociones.Success && 
                    promociones.Result != null && 
                    promociones.Result.Any(x => x.Promocion != null && x.Condiciones.Any()))
                {
                    promociones.Result = promociones.Result.Where(x => x.Promocion != null && x.Condiciones.Any()).ToList();
                    var promocion = Mapper.Map<Web.Models.Search.ResponsePromociones.Estructura.Estrategia, EstrategiaPersonalizadaProductoModel>(promociones.Result.First().Promocion);
                    var condiciones = Mapper.Map<List<Web.Models.Search.ResponsePromociones.Estructura.Estrategia>, List<EstrategiaPersonalizadaProductoModel>>(promociones.Result.First().Condiciones);

                    ActualizarInformacionPreciosYAgregado(promocion);
                    foreach (var condicio in condiciones)
                    {
                        ActualizarInformacionPreciosYAgregado(condicio);
                    }
                    condiciones = condiciones.Where(e =>
                    {
                        return e.TipoAccionAgregar == Constantes.TipoAccionAgregar.AgregaloPackNuevas
                        || e.TipoAccionAgregar == Constantes.TipoAccionAgregar.AgregaloNormal
                        || e.TipoAccionAgregar == Constantes.TipoAccionAgregar.EligeOpcion;
                    }).ToList();
                    //
                    modelo.EsPromocion = modelo.CuvPromocion == cuv;
                    modelo.Condiciones = condiciones;
                    modelo.Promocion = promocion;
                    modelo.Promocion.EsPromocion = true;
                    modelo.Promocion.Condiciones = condiciones;
                }
            }
            #endregion

            return modelo;
        }

        private void ActualizarInformacionPreciosYAgregado(EstrategiaPersonalizadaProductoModel item)
        {
            var pedidos = SessionManager.GetDetallesPedido();
            var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV2).ToList();
            item.IsAgregado = pedidoAgregado.Any();

            item.CampaniaID = userData.CampaniaID;
            item.PrecioVenta = Util.DecimalToStringFormat(item.Precio2.ToDecimal(), userData.CodigoISO);
            item.PrecioTachado = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO);
            item.TipoAccionAgregar = _ofertaPersonalizadaProvider.TipoAccionAgregar(
                item.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable ? 1 : 0,
                item.CodigoEstrategia,
                userData.esConsultoraLider,
                false,
                item.CodigoVariante);
        }

        private string IdentificarPalancaRevistaDigital(string palanca, int campaniaId)
        {
            var palancaX = palanca;
            switch (palanca)
            {
                case Constantes.NombrePalanca.OfertaParaTi:
                    if (revistaDigital == null)
                        break;

                    if (revistaDigital.ActivoMdo)
                    {
                        palancaX = Constantes.NombrePalanca.OfertasParaMi;
                        break;
                    }

                    if (revistaDigital.TieneRDC || revistaDigital.TieneRDCR)
                    {
                        if (revistaDigital.EsActiva)
                        {
                            palancaX = Constantes.NombrePalanca.OfertasParaMi;
                            break;
                        }

                        palancaX = campaniaId == userData.CampaniaID
                            ? Constantes.NombrePalanca.OfertaParaTi
                            : Constantes.NombrePalanca.OfertasParaMi;

                        break;
                    }

                    palancaX = Constantes.NombrePalanca.OfertaParaTi;

                    break;
                default:
                    break;
            }
            return palancaX;
        }

        private DetalleEstrategiaFichaModel GetEstrategiaInicial(string palanca, int campaniaId, string cuv)
        {
            string codigoPalanca = string.Empty;
            bool esFichaApi = false;
            bool tieneCodigoPalanca = Constantes.NombrePalanca.PalancasbyCodigo.TryGetValue(palanca, out codigoPalanca);
            if (tieneCodigoPalanca) esFichaApi = new OfertaBaseProvider().UsaFichaMsPersonalizacion(codigoPalanca);

            var modelo = new DetalleEstrategiaFichaModel();
            if (!esFichaApi)
            {
                if (_ofertaPersonalizadaProvider.PalancasConSesion(palanca))
                {
                    var estrategiaPresonalizada = _ofertaPersonalizadaProvider.ObtenerEstrategiaPersonalizada(userData, palanca, cuv, campaniaId);
                    if (estrategiaPresonalizada == null) return null;

                    if (userData.CampaniaID != campaniaId) estrategiaPresonalizada.ClaseBloqueada = "btn_desactivado_general";
                    modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);

                    if (palanca == Constantes.NombrePalanca.PackNuevas)
                    {
                        modelo.TipoEstrategiaDetalle.Slogan = "Contenido del Set:";
                        modelo.ListaDescripcionDetalle = modelo.ArrayContenidoSet;
                    }
                }                
                else if (palanca == Constantes.NombrePalanca.CaminoBrillanteDemostradores || palanca == Constantes.NombrePalanca.CaminoBrillanteKits) {                    
                    modelo = _caminoBrillanteProvider.GetDetalleEstrategiaFichaModel(cuv);
                }                
             }
            else
            {
                modelo = GetEstrategiaMongo(palanca, campaniaId, cuv);
            }
            return modelo;
        }

        private int GetTipoAccionNavegar(int origen, bool esMobile, bool esEditar)
        {
            var tipo = Constantes.TipoAccionNavegar.SinBoton;

            if (!esEditar && esMobile && origen.ToString().StartsWith(Constantes.IngresoExternoOrigen.App))
            {
                return tipo;
            }

            tipo = esEditar ? Constantes.TipoAccionNavegar.Volver : GetAccionNavegarSegunOrigen(origen);

            return tipo;
        }

        private int GetAccionNavegarSegunOrigen(int origen)
        {
            return UtilOrigenPedidoWeb.EsProductoRecomendado(origen) ? Constantes.TipoAccionNavegar.Volver : Constantes.TipoAccionNavegar.BreadCrumbs;
        }
        
        private bool GetValidationHasCarrusel(int origen, bool esEditar)
        {
            if (UtilOrigenPedidoWeb.EsProductoRecomendado(origen))
            {
                return false;
            }

            return !esEditar;
        }

        private bool GetTieneCompartir(string palanca, bool esEditar, int origen)
        {
            if (UtilOrigenPedidoWeb.EsCaminoBrillante(origen)) return false;
            if (UtilOrigenPedidoWeb.EsProductoRecomendado(origen)) return false;
            return !esEditar && !MobileAppConfiguracion.EsAppMobile &&
                !(Constantes.NombrePalanca.HerramientasVenta == palanca
                || Constantes.NombrePalanca.PackNuevas == palanca);
        }

        private DetalleEstrategiaFichaModel GetDatosOdd(DetalleEstrategiaFichaModel modelo)
        {
            modelo.TeQuedan = _ofertaDelDiaProvider.CountdownOdd(userData).TotalSeconds;
            modelo.TieneReloj = true;

            var sessionODD = (DataModel)SessionManager.OfertaDelDia.Estrategia.Clone();
            modelo.ColorFondo1 = sessionODD.ColorFondo1;
            modelo.ConfiguracionContenedor = (ConfiguracionSeccionHomeModel)sessionODD.ConfiguracionContenedor.Clone();
            modelo.ConfiguracionContenedor = modelo.ConfiguracionContenedor ?? new ConfiguracionSeccionHomeModel();
            modelo.ConfiguracionContenedor.ColorFondo = "#fff";
            modelo.ConfiguracionContenedor.ColorTexto = "#000";
            modelo.ColorFondo1 = "";

            return modelo;
        }

        private bool GetMostrarCliente(bool esEditar)
        {
            var mostrar = esEditar && (new ClienteProvider()).ValidarFlagFuncional(userData.PaisID);
            return mostrar;

        }

        /// <summary>
        /// metodo para obtener toda la informacion adiciona en un modelo
        /// por el momento solo es bool para saber si va o no
        /// </summary>
        /// <param name="esEditar"></param>
        /// <returns></returns>
        private bool GetInformacionAdicional(bool esEditar)
        {
            return !esEditar && _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.FlagFuncional.TablaLogicaId,
                            ConsTablaLogica.FlagFuncional.FichaEnriquecida,
                            true
                            );

        }
    }
}