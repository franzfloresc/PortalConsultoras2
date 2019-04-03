﻿/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/handlebars.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
/// <reference path="../../../Scripts/implements/youtube.js" />

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onEstrategiaLoaded");
registerEvent.call(opcionesEvents, "onOptionSelected");

var baseUrl = baseUrl || "";

var variablesPortal = variablesPortal || {};
var fichaModule = fichaModule || {};
var carruselModule = carruselModule || {};

//INIT PANEL CLIENTE
var _seccionesPanelCliente = {
    hfClienteId: "#hfClienteId",
    hfClienteNombre: "#hfClienteNombre",
    spClienteNombre: "#spClienteNombre",
    btnShowCliente: "#btnShowCliente"
};

var tusClientesProvider = TusClientesProvider();
var panelListaModule = PanelListaModule({
    tusClientesProvider: tusClientesProvider
});
var panelMantenerModule = PanelMantenerModule({
    tusClientesProvider: tusClientesProvider,
    setNombreClienteCallback: panelListaModule.setNombreCliente,
    mostrarTusClientesCallback: panelListaModule.mostrarTusClientes,
    panelRegistroHideCallback: panelListaModule.panelRegistroHide
});
var panelCliente = ClientePanelModule({
    tusClientesProvider: tusClientesProvider,
    panelListaModule: panelListaModule,
    panelMantenerModule: panelMantenerModule,
    panelId: 'PanelClienteLista',
    panelContenedorId: 'PanelClienteLista_Contenedor'
});
//END PANEL CLIENTE

//Función para breadcumb
function eventBreadCumb(url, titulo) {

    var codigoPalanca = fichaModule.GetEstrategia().CodigoPalanca || "";
    if (typeof AnalyticsPortalModule !== 'undefined') {
        if (codigoPalanca === ConstantesModule.CodigoPalanca.MG) {
            AnalyticsPortalModule.ClickOnBreadcrumb(url, codigoPalanca, titulo);
            return;
        }
    }

    document.location = url;
}

var FichaModule = (function (config) {
    "use strict";

    if (config === null || typeof config === "undefined")
        throw "config is null or undefined";

    if (config.localStorageModule === null || typeof config.localStorageModule === "undefined")
        throw "config.localStorageModule is null or undefined";

    if (config.analyticsPortalModule === null || typeof config.analyticsPortalModule === "undefined")
        throw "config.analyticsPortalModule is null or undefined";

    if (config.generalModule === null || typeof config.generalModule === "undefined")
        throw "config.generalModule is null or undefined";

    var _primeraMarca = "";
    var _ultimaMarca = "";
    var _esMultimarca = false;
    var _estrategia = {};
    var _modeloFicha = {};

    var _config = {
        esMobile: null,
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        origen: config.origen || "",
        tieneSession: config.tieneSession || "",
        esEditable: config.esEditable || false,
        setId: config.setId || 0,
        tieneCliente: config.tieneCliente || false,
        localStorageModule: config.localStorageModule,
        analyticsPortalModule: config.analyticsPortalModule,
        detalleEstrategiaProvider: DetalleEstrategiaProvider
    };

    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _tipoEstrategiaTexto = ConstantesModule.TipoEstrategiaTexto;
    var _tipoEstrategia = ConstantesModule.TipoEstrategia;
    var _tipoAccionNavegar = ConstantesModule.TipoAccionNavegar;
    var _fichaServicioApi = true;

    var _elementos = {
        hdCampaniaCodigo: {
            id: "#hdCampaniaCodigo"
        },
        dataEstrategia: {
            id: "#data-estrategia",
            dataEstrategia: "data-estrategia"
        },
        footerPage: ".footer-page",
        estrategiaBreadcrumb: "#estrategia-breadcrumb",
        marca: "#marca",
        btnAgregalo: "#btnAgregalo"
    };

    var _template = {
        getTagDataHtml: function (templateId) {
            return "[data-ficha-contenido=" + templateId + "]";
        },
        navegar: "ficha_navegar_template",
        producto: "ficha_producto_template",
        carrusel: "ficha_carrusel_template",
        compartir: "ficha_compartir_template",
        styleOdd: "ofertadeldia-template-style"
    };

    var _seccionesFichaProducto = {
        SeccionIzquierdo: "#dvSeccionIzquierdo",
        ImagenDeFondo: "#ImagenDeFondo",
        ContenidoProducto: "#ContenidoProducto",
        ContenedoFichaEtiquetas: "#contenedor_ficha_etiquetas",
        Contenedor_redes_sociales: "#Contenedor_redes_sociales",
        ImagenProducto: "#FichaImagenProducto",
        dvContenedorAgregar: "#dvContenedorAgregar"
    };

    var _tabsFichaProducto = {
        detalleProducto: "#div_ficha_tab1",
        detallePack: "#div_ficha_tab2",
        tipsVenta: "#div_ficha_tab3",
        beneficios: "#div_ficha_tab4",
        video: "#div_ficha_tab5"
    };

    var _seccionesFichaTabProducto = {
        ContenidoProductoDetalleProducto: "#contenido_1",
        ContenidoProductoDetallePack: "#contenido_2",
        ContenidoProductoTipsVenta: "#contenido_3",
        ContenidoProductoBeneficios: "#contenido_4",
        ContenidoProductoVideo: "#contenido_5"
    };

    Handlebars.registerHelper("ifVerificarMarca", function (marca, options) {
        if (_primeraMarca !== marca && _esMultimarca) {
            _primeraMarca = marca;
            return options.fn(this);
        }
    });

    Handlebars.registerHelper("ifVerificarMarcaLast", function (marca, options) {
        if (_esMultimarca) {
            if (_ultimaMarca === "" || _ultimaMarca === marca) {
                _ultimaMarca = marca;
                return options.inverse(this);
            }
            else {
                _ultimaMarca = marca;
                return options.fn(this);
            }
        }
        else {
            if (_ultimaMarca === "") {
                _ultimaMarca = marca;
                return options.inverse(this);
            }
            else return options.fn(this);
        }
    });

    var _fijarFooterCampaniaSiguiente = function () {
        if (_config.esMobile) {
            var $elemento = $(".content_inscribirte");
            if ($elemento.length !== 0) {
                var $redesSociales = $(_seccionesFichaProducto.Contenedor_redes_sociales);
                $redesSociales.find(".share").css("margin-bottom", "200px");
            }
        }
    };

    var _ocultarTabs = function () {

        var estrategia = getEstrategia();

        $(_seccionesFichaProducto.ContenidoProducto).hide();
        $(_tabsFichaProducto.detalleProducto).hide();
        $(_tabsFichaProducto.detallePack).hide();
        $(_tabsFichaProducto.tipsVenta).hide();
        $(_tabsFichaProducto.beneficios).hide();
        $(_tabsFichaProducto.video).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoDetalleProducto).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoDetallePack).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoTipsVenta).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoBeneficios).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoVideo).hide();

        var showTabContainer = false;
        if (_tipoEstrategiaTexto.ShowRoom === _config.palanca ||
            _tipoEstrategia.Lanzamiento === _config.palanca) {
            showTabContainer = true;
        }

        if (_tipoEstrategiaTexto.Lanzamiento === _config.palanca) {
            if (estrategia.TipoEstrategiaDetalle.UrlVideoDesktop && !_config.esMobile) {
                $(_tabsFichaProducto.video).show();
                $(_seccionesFichaTabProducto.ContenidoProductoVideo).show();
                showTabContainer = true;
            }
            if (estrategia.TipoEstrategiaDetalle.UrlVideoMobile && _config.esMobile) {
                $(_tabsFichaProducto.video).show();
                $(_seccionesFichaTabProducto.ContenidoProductoVideo).show();
                showTabContainer = true;
            }
        }

        if (showTabContainer) $(_seccionesFichaProducto.ContenidoProducto).show();

    };

    var _crearTabs = function () {

        for (var i = 1; i <= 5; i++) {

            var FichaTabElement = document.getElementById("ficha_tab_" + i.toString());

            if (FichaTabElement) {

                if (FichaTabElement.checked) {
                    document.getElementById("contenido_" + i.toString()).style.display = "block";
                }

                FichaTabElement.onclick = function (event) {
                    var numID = event.target.getAttribute("data-numTab");

                    for (var j = 1; j <= 5; j++) {
                        document.getElementById("contenido_" + j.toString()).style.display = "none";
                    }

                    document.getElementById("contenido_" + numID.toString()).style.display = "block";
                };

            }
        }

        $("ul.ficha_tabs li a").click(function () {
            var $this = $(this);
            $this.parent().children("ul").slideToggle();
            var clase = $this.attr("class");
            if (clase === "active") {
                $this.attr("class", "tab-link");
            }
            else {
                $this.attr("class", "active");
            }
        });
    };

    var _ocultarSecciones = function () {
        if (_config.esMobile) {
            $(_elementos.footerPage).hide();
            $(_elementos.marca).hide();
        }

        if (_tipoEstrategiaTexto.HerramientasVenta === _config.palanca || 
            _tipoEstrategiaTexto.OfertasParaMi === _config.palanca || 
            _tipoEstrategiaTexto.OfertaParaTi === _config.palanca || 
            _tipoEstrategiaTexto.GuiaDeNegocioDigitalizada === _config.palanca || 
            _tipoEstrategiaTexto.OfertaDelDia === _config.palanca || 
            _tipoEstrategiaTexto.ShowRoom === _config.palanca || 
            _tipoEstrategiaTexto.PackNuevas === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).hide();
        }
        else if (_tipoEstrategiaTexto.Lanzamiento === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).show();
        }
    };

    var _construirSeccionDetalleFichas = function () {
        var pEstrategia = _estrategia;
        if (pEstrategia === null || typeof (pEstrategia) === "undefined") {
            _redireccionar("_construirSeccionDetalleFichas, sin Estrategia");
            return false;
        }

        if (!_modeloFicha.MostrarAdicional) {
            return false;
        }

        if (pEstrategia.CodigoEstrategia === _tipoEstrategia.Lanzamiento) {
            //Construir sección ficha - Video
            if (_config.esMobile) {
                pEstrategia.VideoHeight = 218;
                pEstrategia.TipoEstrategiaDetalle.UrlVideo = pEstrategia.TipoEstrategiaDetalle.UrlVideoMobile;
            }
            else {
                pEstrategia.VideoHeight = 415;
                pEstrategia.TipoEstrategiaDetalle.UrlVideo = pEstrategia.TipoEstrategiaDetalle.UrlVideoDesktop;
            }

            SetHandlebars("#template-fichadetallevideo", pEstrategia, "#contenedor-tab-video");

            if (youtubeModule) {

                youtubeModule.Inicializar();
            }
        }

        _ocultarSecciones();
        _crearTabs();
        _ocultarTabs();

        return true;
    };

    ////// Ini - Obtener Estrategia
    var _obtenerCampaniaActual = function () {
        var campaniaActual = 0;
        var strCampaniaActual = $(_elementos.hdCampaniaCodigo.id).val();
        if (!$(_elementos.hdCampaniaCodigo.id) ||
            $.trim(strCampaniaActual) === "" ||
            isNaN(strCampaniaActual)) return campaniaActual;

        campaniaActual = parseInt(strCampaniaActual);

        return campaniaActual;
    };

    var _asignarCantidad = function (cantidad) {
        $('input#txtCantidad').val(cantidad);
    };

    var _asignaDetallePedido = function (data, estrategia) {

        data = data || {};
        data.Detalles = data.Detalles || [];
        if (data.Detalles.length == 0) {
            _redireccionar('_asignaDetallePedido, sin detalles componentes');
            return false;
            //throw 'Componente: No existe detalle de pedido';
        }
        _selectClient(data.ClienteId, data.ClienteNombre);

        estrategia.Cantidad = data.Cantidad;
        _asignarCantidad(estrategia.Cantidad);

        $.each(data.Detalles, function (i, o) {
            var filterComponente = estrategia
                .Hermanos
                .filter(function (objeto) {
                    return objeto.Hermanos != null
                        && objeto.Hermanos.length > 0
                        && objeto.Hermanos.filter(function (nx) { return nx.Cuv == o.CUV }).length > 0
                });

            if (filterComponente.length) {
                ComponentesModule.SeleccionarComponente(filterComponente[0].Cuv, false);
                var cant = 0;
                for (cant = 0; cant < o.FactorRepeticion; cant++) {
                    ListaOpcionesModule.SeleccionarOpcion(o.CUV);
                }
                ResumenOpcionesModule.AplicarOpciones();
            }
        });

        $(_elementos.btnAgregalo).addClass("btn_desactivado_general");
    };

    var _setPedidoSetDetalle = function (pEstrategia) {
        if (_config.esEditable) {
            if (!IsNullOrEmpty(_config.setId)) {
                var errorRespuesta = false;
                _config.detalleEstrategiaProvider
                    .promiseObternerDetallePedido({
                        campaniaId: _config.campania,
                        set: _config.setId
                    }).done(function (data) {
                        if (data.success) {
                            _asignaDetallePedido(data.pedidoSet, pEstrategia);
                        }
                    }).fail(function (data, error) {
                        console.log(data);
                        console.log(error);
                        errorRespuesta = true;
                    });

                if (errorRespuesta) {
                    _redireccionar("_setPedidoSetDetalle, promiseObternerDetallePedido");
                    return false;
                }
            }
        }
        else {
            _asignarCantidad(1);
        }
    };

    var _getComponentesAndUpdateEsMultimarca = function (estrategia) {
        if (!IsNullOrEmpty(estrategia.CodigoVariante)) {
            var param = {
                estrategiaId: estrategia.EstrategiaID,
                cuv2: estrategia.CUV2,
                campania: _config.campania,
                codigoVariante: estrategia.CodigoVariante,
                codigoEstrategia: estrategia.CodigoEstrategia,
                lstHermanos: estrategia.Hermanos
            };

            var errorRespuesta = false;
            _config.detalleEstrategiaProvider
                .promiseObternerComponentes(param)
                .done(function (data) {
                    estrategia.Hermanos = data.componentes;
                    estrategia.EsMultimarca = data.esMultimarca;
                    _esMultimarca = data.esMultimarca;

                }).fail(function (data, error) {
                    estrategia.Hermanos = [];
                    estrategia.EsMultimarca = false;
                    errorRespuesta = true;
                });

            if (errorRespuesta) {
                _redireccionar("_getComponentesAndUpdateEsMultimarca, promiseObternerComponentes");
                return false;
            }

        }
        else {
            estrategia.Hermanos = [];
            estrategia.EsMultimarca = false;
        }

        estrategia.esCampaniaSiguiente = estrategia.CampaniaID !== _obtenerCampaniaActual();
        $.each(estrategia.Hermanos, function (idx, hermano) {
            hermano = estrategia.Hermanos[idx];
            hermano.esCampaniaSiguiente = estrategia.esCampaniaSiguiente;
        });
    };

    var _actualizarCodigoVariante = function (estrategia) {
        estrategia.Hermanos = estrategia.Hermanos || [];

        if (estrategia.Hermanos.length === 1) {
            if (estrategia.Hermanos[0].Hermanos) {
                if (estrategia.Hermanos[0].Hermanos.length > 0) {
                    if (estrategia.Hermanos[0].FactorCuadre === 1) {
                        estrategia.CodigoVariante = _codigoVariedad.IndividualVariable;
                    }
                }
                else {
                    estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
                }
            }
            else {
                estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
            }

        }
        else if (estrategia.Hermanos.length > 1) {
            if (estrategia.CodigoVariante === _codigoVariedad.IndividualVariable) {
                estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
            }
        }
        else if (estrategia.Hermanos.length === 0) {
            estrategia.CodigoVariante = "";
        }
    };

    var _getEstrategiaFicha = function () {
        var param = {
            cuv: '00798',
            campania: '201906',
            tipoEstrategia: '011'
        };

        var errorRespuesta = false;
        _config.detalleEstrategiaProvider
            .promiseObtenerEstrategiaFicha(param)
            .done(function (data) {
                return data;
            }).fail(function (data, error) {
                errorRespuesta = true;
            });

        if (errorRespuesta) {
            _redireccionar("_getComponentesAndUpdateEsMultimarca, promiseObternerComponentes");
            return false;
        }
    };

    var _getEstrategia = function () {
        var estrategia;

        if (!_fichaServicioApi) {
            if (_config.tieneSession) {
                if (_config.esEditable || _modeloFicha.TipoAccionNavegar === _tipoAccionNavegar.Volver) {
                    estrategia = _modeloFicha;
                }
                else {
                    var valData = $(_elementos.dataEstrategia.id).attr(_elementos.dataEstrategia.dataEstrategia) || "";
                    if (valData != "") {
                        estrategia = JSON.parse(valData);
                    }
                    else {
                        estrategia = _modeloFicha;
                    }
                }
            }
            else {
                estrategia = _config.localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);
                if ((typeof estrategia === "undefined" || estrategia === null) && _config.palanca === _tipoEstrategiaTexto.OfertasParaMi) {
                    estrategia = _config.localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _tipoEstrategiaTexto.Ganadoras);
                }
            }

            if (typeof estrategia === "undefined" || estrategia == null) return estrategia;

            _getComponentesAndUpdateEsMultimarca(estrategia);
        }
        else {
            estrategia = _modeloFicha;
            ////////////////////////var estrategiaFichaxxx = _getEstrategiaFicha();
        }

        _actualizarCodigoVariante(estrategia);

        estrategia.ClaseBloqueada = "btn_desactivado_general";
        estrategia.ClaseBloqueadaRangos = "contenedor_rangos_desactivado";
        estrategia.RangoInputEnabled = "disabled";
        estrategia.esEditable = _config.esEditable;
        estrategia.setId = _config.setId || 0;
        estrategia.TieneStock = _config.esEditable || estrategia.TieneStock;

        estrategia = $.extend(_modeloFicha, estrategia);
        _estrategia = estrategia;
        return estrategia;
    };

    ////// Fin - Obtener Estrategia

    ////// Ini - Construir Seccion Estrategia
    var _construirSeccionEstrategia = function () {

        var estrategia = getEstrategia();

        if (estrategia == null) {
            _redireccionar("_construirSeccionEstrategia, sin estrategia");
            return false;
        }

        $(_elementos.dataEstrategia.id).attr(_elementos.dataEstrategia.dataEstrategia, JSON.stringify(estrategia));
        _setEstrategiaBreadcrumb(estrategia);
        estrategia.MostrarCliente = _modeloFicha.MostrarCliente;
        _setHandlebars(_template.producto, estrategia);

        _setEstrategiaTipoBoton(estrategia);

        opcionesEvents.applyChanges("onEstrategiaLoaded", estrategia);

        _setPedidoSetDetalle(estrategia);

        _setEstrategiaImgFondo(estrategia);

        if (estrategia.TieneReloj) {
            _crearReloj(estrategia);
            _setHandlebars(_template.styleOdd, _modeloFicha);
        }

        if (!_config.esMobile) {
            _validarSiEsAgregado(estrategia);
        }

        _estrategia = estrategia;

        return true;
    };

    var _setEstrategiaBreadcrumb = function (estrategia) {

        if (_modeloFicha.TipoAccionNavegar != _tipoAccionNavegar.BreadCrumbs) {
            return false;
        }

        var estrategiaBreadcrumb = (estrategia || {}).DescripcionCompleta || "";

        if (estrategiaBreadcrumb == "") {
            return false;
        }

        estrategiaBreadcrumb = $.trim(estrategiaBreadcrumb);
        var palabrasEstrategiaDescripcion = estrategiaBreadcrumb.split(" ");
        estrategiaBreadcrumb = palabrasEstrategiaDescripcion[0];
        if (!_config.esMobile) {
            if (palabrasEstrategiaDescripcion.length > 1)
                estrategiaBreadcrumb += " " + palabrasEstrategiaDescripcion[1];
            if (palabrasEstrategiaDescripcion.length > 2)
                estrategiaBreadcrumb += " " + palabrasEstrategiaDescripcion[2];
            if (palabrasEstrategiaDescripcion.length > 3)
                estrategiaBreadcrumb += "...";
        } else {
            if (estrategiaBreadcrumb.length > 7)
                estrategiaBreadcrumb = estrategiaBreadcrumb.substr(0, 7) + "...";
        }

        $(_elementos.estrategiaBreadcrumb).text(estrategiaBreadcrumb);


    };

    var _setEstrategiaTipoBoton = function (pEstrategia) {

        if (pEstrategia.TipoAccionAgregar <= 0) {
            $(_seccionesFichaProducto.dvContenedorAgregar).hide();
        }

        if (pEstrategia.CodigoVariante === _codigoVariedad.IndividualVariable ||
            pEstrategia.CodigoVariante === _codigoVariedad.CompuestaVariable ||
            pEstrategia.CodigoVariante === _codigoVariedad.ComuestaFija ||
            pEstrategia.esCampaniaSiguiente) {
            _validarDesactivadoGeneral(pEstrategia);
        }
        if (pEstrategia.CodigoVariante === _codigoVariedad.IndividualVariable ||
            pEstrategia.CodigoVariante === _codigoVariedad.ComuestaFija) {
            _validarActivadoGeneral(pEstrategia);
        }

        if (_config.esMobile) {
            if (typeof pEstrategia.TieneStock !== undefined) {
                if (pEstrategia.TieneStock) $('#div-boton-agregar').show();
                else $('#div-boton-agotado').show();
            }
        }

        // texto boton
        if (pEstrategia.TieneStock) {
            if (_config.esEditable) {
                $(_elementos.btnAgregalo).html("MODIFICAR");
            }
            else {
                $(_elementos.btnAgregalo).html("AGRÉGALO");
            }
        }
    };

    var _validarDesactivadoGeneral = function (pEstrategia) {
        if (pEstrategia.esEditable) {
            EstrategiaAgregarModule.DeshabilitarBoton();
        } else {
            $.each(pEstrategia.Hermanos, function (index, hermano) {
                if (hermano.Hermanos && hermano.Hermanos.length > 0) {
                    EstrategiaAgregarModule.DeshabilitarBoton();
                }
            });
        }

    };
    var _validarActivadoGeneral = function (pEstrategia) {
        if (!pEstrategia.esEditable) {
            $.each(pEstrategia.Hermanos, function (index, hermano) {
                if (!(hermano.Hermanos && hermano.Hermanos.length > 0)) {
                    EstrategiaAgregarModule.HabilitarBoton();
                }
            });
        }

    };

    var _setEstrategiaImgFondo = function (pEstrategia) {
        var imgFondo = "";
        if (_config.esMobile) {
            imgFondo = pEstrategia.TipoEstrategiaDetalle.ImgFichaFondoMobile || "";
        }
        else {
            imgFondo = pEstrategia.TipoEstrategiaDetalle.ImgFichaFondoDesktop || "";

            if (imgFondo !== "") {
                $(_seccionesFichaProducto.ContenedoFichaEtiquetas).addClass("contenedor_ficha_etiquetas_Confondo");
            }
            setTimeout(_renderImg(), 1000);
        }

        if (imgFondo !== "") {
            $(_seccionesFichaProducto.ImagenDeFondo).css("background-image", "url('" + imgFondo + "')");
            $(_seccionesFichaProducto.ImagenDeFondo).show();
        }
    };

    var _crearReloj = function (estrategia) {
        $("#clock").each(function (index, elem) {
            $(elem).FlipClock(estrategia.TeQuedan,
                {
                    countdown: true,
                    clockFace: "HourlyCounter",
                    language: "es-es"
                });
        });
    };

    var _renderImg = function () {
        _renderImgFin();
        $(document).ajaxStop(function () {
            _renderImgFin();
        });
    };

    var _renderImgFin = function () {

        var proObj = $(_seccionesFichaProducto.ImagenProducto);
        var proImg = proObj.find("img");

        var proM = proImg.innerHeight();
        var proObjH = proObj.innerHeight();
        if (proObjH == 0) {
            proObjH = 300;
        }

        $(proImg).css("max-height", "");
        $(proImg).css("height", "");
        $(proImg).css("max-width", "");
        $(proImg).css("width", "");

        var styleImg = "";

        // medida segun alto
        if (proM > proObjH || proM == 0) {
            styleImg += "max-height:" + proObjH + "px !important;";
        }
        else {
            styleImg += "max-height:" + proM + "px !important;";
        }

        // medida segun ancho
        proObj = $(_seccionesFichaProducto.SeccionIzquierdo);
        var proObjW = proObj.innerWidth();
        if (proObjW == 0) {
            proObjW = 490;
        }
        proM = proImg.innerWidth();
        if (proM > proObjW || proM == 0) {
            styleImg += "max-width:" + proObjW + "px !important;";
        }
        else {
            styleImg += "max-width:" + proM + "px !important;";
        }

        // asignar estilos
        $(proImg).attr("style", styleImg);
        $(proImg).css("height", "auto");
        $(proImg).css("width", "auto");

        setTimeout(_resizeBotonAgregar(), 1000);
    };

    var _resizeBotonAgregar = function () {
        var dvFoto = $("#dvSeccionFoto");
        var dvRedesSociales = $(_seccionesFichaProducto.Contenedor_redes_sociales);
        var dvFichaEtiqueta = $(_seccionesFichaProducto.ContenedoFichaEtiquetas);
        var dvDetalle = $("#dvSeccionDetalle");

        if (dvFoto.length && dvRedesSociales.length) {

            dvDetalle.removeClass("ficha_detalle_cuerpo");
            dvDetalle.css("height", "");
            var dvFotoHeight = dvFoto.innerHeight();
            var dvFichaEtiquetaHeight = dvFichaEtiqueta.innerHeight();
            var dvDetalleHeight = dvDetalle.innerHeight();
            var dvIzquierdoHeight = dvFotoHeight + 45; // 45 es por el padding del padre.
            var dvDerechoHeight = dvDetalleHeight + dvFichaEtiquetaHeight;
            if (dvIzquierdoHeight > dvDerechoHeight) {
                var dvRedesSocialesHeight = dvRedesSociales.innerHeight();
                var diferenciaHeight = dvIzquierdoHeight - dvFichaEtiquetaHeight;
                dvDetalle.removeClass("ficha_detalle_cuerpo");
                //dvDetalle.height(diferenciaHeight);
                dvDetalle.css("min-height", diferenciaHeight);
            }
            else {
                dvDetalle.addClass("ficha_detalle_cuerpo");
            }
        }
    };

    var _validarSiEsAgregado = function (estrategia) {
        if (_config.esEditable) {
            $("#ContenedorAgregado").remove();
        }
        else {
            if (estrategia.IsAgregado) {
                $("#ContenedorAgregado").show();
            }
        }

    };

    ////// Fin - Construir Seccion Estrategia

    ////// Ini - Construir Estructura Ficha
    var _validarAbrirFichaResumida = function () {
        if (_config.origen.slice(-2).in("09", "08")) {
            return true;
        }
        return _config.esEditable;
    }

    var _construirSeccionFicha = function () {
        _config.esMobile = isMobile();
        _getModelo();

        _config.tieneSession = _modeloFicha.TieneSession;
        _config.palanca = _modeloFicha.Palanca || _config.palanca;
        _config.origen = _modeloFicha.OrigenUrl || _config.origen;
        _config.mostrarCliente = _modeloFicha.MostrarCliente || _config.mostrarCliente;

        if (!ValidaOfertaDelDia(true)) {
            _redireccionar("_construirSeccionFicha, ValidaOfertaDelDia");
            return false;
        }

        if (_validarAbrirFichaResumida()) {
            FichaPartialModule.ShowDivFichaResumida(true);
        }

        _modeloFicha.BreadCrumbs = _modeloFicha.BreadCrumbs || {};
        _modeloFicha.BreadCrumbs.TipoAccionNavegar = _modeloFicha.TipoAccionNavegar;
        _setHandlebars(_template.navegar, _modeloFicha.BreadCrumbs);

        if (_modeloFicha.TieneCarrusel) {
            _setHandlebars(_template.carrusel, _modeloFicha);
        }

        _setHandlebars(_template.compartir, _modeloFicha);

    };

   

    var _getModelo = function () {

        var paramsObtenerModelo = {};
        paramsObtenerModelo.palanca = _config.palanca;
        paramsObtenerModelo.campaniaId = _config.campania;
        paramsObtenerModelo.cuv = _config.cuv;
        paramsObtenerModelo.origen = _config.origen;
        paramsObtenerModelo.esEditable = _config.esEditable;

        var modeloFicha = {};

        _config.detalleEstrategiaProvider
            .promiseObternerModelo(paramsObtenerModelo)
            .done(function (data) {
                modeloFicha = data.data || {};
                modeloFicha.Error = data.success === false;
            })
            .fail(function (data, error) {
                modeloFicha = {};
                modeloFicha.Error = true;
            });

        _modeloFicha = modeloFicha;

        if (modeloFicha.Error === true) {
            _redireccionar("_getModelo, promiseObternerModelo");
            return false;
        }

        _modeloFicha.ConfiguracionContenedor = _modeloFicha.ConfiguracionContenedor || {};
        _modeloFicha.BreadCrumbs = _modeloFicha.BreadCrumbs || {};
    };

    ////// Fin - Construir Estructura Ficha

    var _setHandlebars = function (idTemplate, modelo) {
        SetHandlebars("#" + idTemplate, modelo, _template.getTagDataHtml(idTemplate));
    };

    var _redireccionar = function (txtOrigen) {
        console.log(txtOrigen);
        _estrategia = {};
        if (_modeloFicha.TipoAccionNavegar == undefined) {
            _modeloFicha.TipoAccionNavegar = $('#DivPopupFichaResumida').length ? _tipoAccionNavegar.Volver : _tipoAccionNavegar.BreadCrumbs;
        }

        if (_modeloFicha.TipoAccionNavegar != _tipoAccionNavegar.Volver) {
            _modeloFicha = {};
            window.location = baseUrl + (_config.esMobile ? "Mobile/" : "") + "Ofertas";
        }
        else {
            _modeloFicha = {};
            FichaPartialModule.ShowDivFichaResumida(false);
        }
    };

    var _initCarrusel = function () {
        if (!_modeloFicha.TieneCarrusel) {
            return false;
        }

        carruselModule = CarruselModule({
            palanca: _config.palanca,
            campania: _config.campania,
            cuv: _config.cuv,
            idPlantillaProducto: "#producto-landing-template",
            divCarruselContenedor: "#divFichaCarrusel",
            idTituloCarrusel: "#tituloCarrusel",
            divCarruselProducto: "#divFichaCarruselProducto",
            OrigenPedidoWeb: _config.origen
        });

        carruselModule.Inicializar();
    };

    var _selectClient = function (clienteId, clienteNombre) {
        if (typeof clienteId !== "undefined" &&
            typeof clienteNombre !== "undefined" &&
            clienteId >= 0) {
            $(_seccionesPanelCliente.hfClienteId).val(clienteId);
            $(_seccionesPanelCliente.hfClienteNombre).val(clienteNombre);
            $(_seccionesPanelCliente.spClienteNombre).html(clienteNombre);
        }
    };

    var _initCliente = function () {
        if (!_modeloFicha.MostrarCliente) {
            return false;
        }

        //INIT PANEL CLIENTE
        panelCliente.init();
        panelCliente.AceptaClick(function (obj) {
            _selectClient(obj.ClienteID, obj.Nombre);
            EstrategiaAgregarModule.HabilitarBoton();
        });

        $(_seccionesPanelCliente.btnShowCliente).click(function () {
            panelCliente.Abrir();
            console.log('_initCliente - DivPopupFichaResumida overflow hidden');
            $("#DivPopupFichaResumida").css("overflow", "hidden");
        });
        //END PANEL CLIENTE
    };

    var _analytics = function () {

        if (typeof _config.analyticsPortalModule === 'undefined')
            return;

        _config.analyticsPortalModule.MarcaVisualizarDetalleProducto(_estrategia);

    };

    function getEstrategia() {
        if (isInt(_estrategia.EstrategiaID)) {
            return _estrategia;
        }
        return _getEstrategia();
    }

    function getModeloFicha() {
        return _modeloFicha;
    }

    function ValidaOfertaDelDia(muestra) {
        var estrategia = getEstrategia();

        if (_tipoEstrategiaTexto.OfertaDelDia == _config.palanca &&
            (estrategia == null || estrategia.EstrategiaID == undefined)) {
            if (muestra)
                AbrirMensaje('¡Ups! Esta oferta fue por tiempo limitado y ya no puedes modificarla.');

            return false;
        }

        return true;
    }

    function _init() {
        _construirSeccionFicha();
        _construirSeccionEstrategia();
        _construirSeccionDetalleFichas();
        _fijarFooterCampaniaSiguiente();
        _initCliente();
        _initCarrusel();
        _analytics();
    }

    return {
        Inicializar: _init,
        GetEstrategia: getEstrategia,
        GetModeloFicha: getModeloFicha
    };
});

var FichaPartialModule = (function () {

    var _validarData = function (objFicha) {
        objFicha = objFicha || {};
        if (objFicha.palanca == "" || !isInt(objFicha.campania) || !isInt(objFicha.cuv)) {
            return false;
        }
        if (objFicha.esEditable && !isInt(objFicha.setId)) {
            return false;
        }
        return true;
    };

    var _construirFicha = function (event, tipoAccion, esEditar) {
        
        if (tipoAccion != ConstantesModule.EditarItemPedido.Activo) {
            return false;
        }

        AbrirLoad();

        var row = $(event).parents("[data-detalle-item]");
        var palanca = $.trim(row.attr("data-tipoestrategia"));
        var OrigenPedidoWeb = $.trim(row.attr("data-OrigenPedidoWeb"));
        palanca = GetPalanca(palanca, OrigenPedidoWeb, false);
        var campania = $.trim(row.attr("data-campania"));
        var cuv = $.trim(row.attr("data-cuv"));
        var setId = $.trim(row.attr("data-SetID"));

        var objFicha = {
            localStorageModule: LocalStorageModule(),
            analyticsPortalModule: AnalyticsPortalModule,
            generalModule: GeneralModule,
            palanca: palanca,
            campania: campania,
            cuv: cuv,
            origen: OrigenPedidoWeb,
            esEditable: esEditar == undefined || esEditar == null || esEditar,
            setId: setId
        };

        if (!_validarData(objFicha)) {
            CerrarLoad();
            return false;
        }

        window.setTimeout(function () {
            AbrirLoad();

            fichaModule = FichaModule(objFicha);
            fichaModule.Inicializar();

            CerrarLoad({
                overflow: false
            });
        }, 10);
    };

    var _showDivFichaResumida = function (isShow) {

        isShow = isShow == undefined || isShow;
        if (isShow) {
            $('body').css('overflow', 'hidden');
            $('#DivPopupFichaResumida').show();
        }
        else {
            $("[data-ficha-contenido='ofertadeldia-template-style']").html("");
            $('#DivPopupFichaResumida').hide();
            $("body").css("overflow", "scroll");
        }
    };

    var _fichaPreValidar = function (event, tipoAccion, tipoEstrategiaCodigo, campaniaId, setid, cuv) {
        if (tipoEstrategiaCodigo == ConstantesModule.TipoEstrategia.ArmaTuPack) {
            _mostrarPopupAtp(campaniaId, setid, cuv);
        }
        else {
            _construirFicha(event, tipoAccion, true);
        }
    };

    var _mostrarPopupAtp = function (campaniaId, setid, cuv) {
        AbrirLoad();
        var params =
            {
                campaniaId: campaniaId,
                set: setid,
                cuv: cuv
            };

        jQuery.ajax({
            type: "POST",
            url: '/Pedido/ObtenerOfertaByCUVSet',
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    if (data.success) {
                        if (data.pedidoSet) {
                            if (data.pedidoSet.Detalles) {
                                var strComponentes = '<ul>';

                                $(data.pedidoSet.Detalles).each(function (i, v) {
                                    strComponentes = strComponentes + '<li style="list-style:none;text-align:left">- x' + v.FactorRepeticion + ' ' + v.NombreProducto + '</li>';
                                });

                                strComponentes = strComponentes + '</ul>';

                                CerrarLoad();

                                AbrirMensaje(strComponentes, "El pack que armaste contiene:");
                                _bindBlackScreenToCloseButton();
                            }
                        }
                    }
                    else CerrarLoad();
                }
                else {
                    CerrarLoad();
                    messageInfoError(data.message);
                }
            },
            error: function (data, error) {
                CerrarLoad();
                if (checkTimeout(data)) {
                    alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
                }
            }
        });
    };

    var _bindBlackScreenToCloseButton = function () {
        $('.ui-widget-overlay').click(function () {
            $('.ui-dialog-titlebar-close').click();
        });
    };
    
    return {
        ConstruirFicha: _construirFicha,
        ShowDivFichaResumida: _showDivFichaResumida,
        FichaPreValidar: _fichaPreValidar
    };
})();

//Funcion temporal hasta estandarizar RevistaDigital.js

function RDPageInformativa() {
    window.location = baseUrl + (isMobile() ? "Mobile/" : "") + "RevistaDigital/Informacion";
}