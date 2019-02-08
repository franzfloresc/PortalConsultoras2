/// <reference path="../../../Scripts/jquery-1.11.2.js" />
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
var panel = ClientePanelModule({
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
    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        if (codigoPalanca === ConstantesModule.TipoEstrategia.MG) {
            AnalyticsPortalModule.ClickOnBreadcrumb(url, codigoPalanca, titulo);
            return;
        }
    }

    document.location = url;
}

var PageModule = (function () {
    var _redirectTo = function (url) {
        if (typeof url === 'undefined') return false;

        if (url === '') return false;

        baseUrl = baseUrl || '';

        window.location = baseUrl + (isMobile() ? "Mobile/" : "") + url;
    };

    return {
        redirectTo: _redirectTo
    };
}());

var DetalleEstrategiaProvider = function () {
    var _urlDetalleEstrategia = ConstantesModule.UrlDetalleEstrategia;

    var _promiseObternerComponentes = function (params) {
        var dfd = $.Deferred();

        $.ajax({
            type: "POST",
            url: _urlDetalleEstrategia.obtenerComponentes,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: false,
            cache: false,
            success: function (data) {
                if (data.success) {
                    dfd.resolve(data);
                }
                else {
                    //console.log(data);
                    dfd.reject(data);
                }
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _promiseObternerDetallePedido = function (params) {
        var dfd = $.Deferred();

        $.ajax({
            type: 'post',
            url: _urlDetalleEstrategia.obtenerPedidoWebSetDetalle,
            datatype: 'json',
            contenttype: 'application/json; charset=utf-8',
            data: params,
            success: function (data) {
                if (data.success) {
                    dfd.resolve(data);
                }
                else {
                    dfd.reject(data);
                }
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _promiseObternerModelo = function (params) {
        var dfd = $.Deferred();

        $.ajax({
            type: "POST",
            url: _urlDetalleEstrategia.obtenerModelo,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: false,
            cache: false,
            success: function (data) {
                if (data.success) {
                    dfd.resolve(data);
                }
                else {
                    //console.log(data);
                    dfd.reject(data);
                }
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    return {
        promiseObternerComponentes: _promiseObternerComponentes,
        promiseObternerDetallePedido: _promiseObternerDetallePedido,
        promiseObternerModelo: _promiseObternerModelo
    };
}();

var FichaModule = (function (config) {
    "use strict";

    if (config === null || typeof config === "undefined")
        throw "config is null or undefined";

    if (config.localStorageModule === null || typeof config.localStorageModule === "undefined")
        throw "config.localStorageModule is null or undefined";

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
        detalleEstrategiaProvider: DetalleEstrategiaProvider
    };

    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _codigoPalanca = ConstantesModule.CodigosPalanca;
    var _constantePalanca = ConstantesModule.ConstantesPalanca;
    var _tipoAccionNavegar = ConstantesModule.TipoAccionNavegar;

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
    }

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

        var estrategia = _config.localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);

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
        if (_codigoPalanca.ShowRoom === _config.palanca ||
            ConstantesModule.ConstantesPalanca.Lanzamiento === _config.palanca) {
            showTabContainer = true;
        }

        if (_codigoPalanca.Lanzamiento === _config.palanca) {
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

        if (_codigoPalanca.HerramientasVenta === _config.palanca
            || _codigoPalanca.OfertasParaMi === _config.palanca
            || _codigoPalanca.OfertaParaTi === _config.palanca
            || _codigoPalanca.GuiaDeNegocioDigitalizada === _config.palanca
            || _codigoPalanca.OfertaDelDia === _config.palanca
            || _codigoPalanca.ShowRoom === _config.palanca
            || _codigoPalanca.PackNuevas === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).hide();
        }
        else if (_codigoPalanca.Lanzamiento === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).show();
        }
    };

    var _construirSeccionDetalleFichas = function () {
        var pEstrategia = _estrategia;
        if (pEstrategia === null || typeof (pEstrategia) === "undefined") {
            _redireccionar();
            return false;
        }

        if (!_modeloFicha.MostrarAdicional) {
            return false;
        }

        if (pEstrategia.CodigoEstrategia === _constantePalanca.Lanzamiento) {
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
    }

    var _asignarCantidad = function (cantidad) {
        $('input.txtCantidad').val(cantidad);
    }

    var _asignaDetallePedido = function (data, estrategia) {
        if (!data.length) {
            _redireccionar();
            return false;
            //throw 'Componente: No existe detalle de pedido';
        }

        estrategia.Cantidad = data[0].Cantidad;
        _asignarCantidad(estrategia.Cantidad);

        $.each(data, function (i, o) {
            var filterComponente = estrategia
                .Hermanos
                .filter(function (objeto) {
                    return objeto.Hermanos != null
                        && objeto.Hermanos.length > 0
                        && objeto.Hermanos.filter(function (nx) { return nx.Cuv == o.CuvProducto }).length > 0
                });

            if (filterComponente.length) {
                ComponentesModule.SeleccionarComponente(filterComponente[0].Cuv);
                ListaOpcionesModule.SeleccionarOpcion(o.CuvProducto);
                ResumenOpcionesModule.AplicarOpciones();
            }
        });

        $(_elementos.btnAgregalo).addClass("btn_desactivado_general");
    }

    var _setPedidoSetDetalle = function (pEstrategia) {
        if (_config.esEditable) {
            if (!IsNullOrEmpty(_config.setId)) {
                _config.detalleEstrategiaProvider
                    .promiseObternerDetallePedido({
                        campaniaId: _config.campania,
                        set: _config.setId
                    }).done(function (data) {
                        if (data.success) {
                            _asignaDetallePedido(data.componentes, pEstrategia);
                        }
                    }).fail(function (data, error) {
                        console.log(data);
                        console.log(error);
                    });
            }
        }
        else {
            _asignarCantidad(1);
        }
    }

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
            _config.detalleEstrategiaProvider
                .promiseObternerComponentes(param)
                .done(function (data) {
                    estrategia.Hermanos = data.componentes;
                    estrategia.EsMultimarca = data.esMultimarca;
                    _esMultimarca = data.esMultimarca;

                }).fail(function (data, error) {
                    estrategia.Hermanos = [];
                    estrategia.EsMultimarca = false;
                });
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

    var _getEstrategia = function () {
        var estrategia;

        if (_config.tieneSession) {
            if (_config.esEditable) {
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
            //console.log("_getEstrategia", _config);
            estrategia = _config.localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);
            if ((typeof estrategia === "undefined" || estrategia === null) && _config.palanca === _codigoPalanca.OfertasParaMi) {
                estrategia = _config.localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _codigoPalanca.Ganadoras);
            }
        }

        if (typeof estrategia === "undefined" || estrategia == null) return estrategia;

        _getComponentesAndUpdateEsMultimarca(estrategia);
        _actualizarCodigoVariante(estrategia);

        estrategia.ClaseBloqueada = "btn_desactivado_general";
        estrategia.ClaseBloqueadaRangos = "contenedor_rangos_desactivado";
        estrategia.RangoInputEnabled = "disabled";
        estrategia.esEditable = _config.esEditable;
        estrategia.setId = _config.setId || 0;

        return estrategia;
    };

    ////// Fin - Obtener Estrategia

    ////// Ini - Construir Seccion Estrategia
    var _construirSeccionEstrategia = function () {

        _estrategia = _getEstrategia();
        var estrategia = _estrategia;

        if (estrategia == null) {
            _redireccionar();
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
            pEstrategia.esCampaniaSiguiente) {
            _validarDesactivadoGeneral(pEstrategia);
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
        $.each(pEstrategia.Hermanos, function (index, hermano) {
            if (hermano.Hermanos && hermano.Hermanos.length > 0) {
                EstrategiaAgregarModule.DeshabilitarBoton();
            }
        });
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
            styleImg += "max-height:" + proObjH + "px !important;"
        }
        else {
            styleImg += "max-height:" + proM + "px !important;"
        }

        // medida segun ancho
        proObj = $(_seccionesFichaProducto.SeccionIzquierdo);
        var proObjW = proObj.innerWidth();
        if (proObjW == 0) {
            proObjW = 490;
        }
        proM = proImg.innerWidth();
        if (proM > proObjW || proM == 0) {
            styleImg += "max-width:" + proObjW + "px !important;"
        }
        else {
            styleImg += "max-width:" + proM + "px !important;"
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
                dvDetalle.height(diferenciaHeight);
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
    var _construirSeccionFicha = function () {
        _config.esMobile = isMobile();
        _getModelo();

        _config.tieneSession = _modeloFicha.TieneSession;
        _config.palanca = _modeloFicha.Palanca || _config.palanca;
        _config.origen = _modeloFicha.OrigenUrl || _config.origen;
        _config.mostrarCliente = _modeloFicha.MostrarCliente || _config.mostrarCliente;


        if (!ValidaOfertaDelDia(true)) {
            _redireccionar();
            return false;
        }
        FichaEditarModule.ShowDivFichaResumida(true);

        _modeloFicha.BreadCrumbs = _modeloFicha.BreadCrumbs || {};
        _modeloFicha.BreadCrumbs.TipoAccionNavegar = _modeloFicha.TipoAccionNavegar;
        _setHandlebars(_template.navegar, _modeloFicha.BreadCrumbs);

        if (_modeloFicha.TieneCarrusel) {
            _setHandlebars(_template.carrusel, _modeloFicha);
        }

        _setHandlebars(_template.compartir, _modeloFicha);

    };

    function _getModelo() {

        var modelo = {};
        modelo.palanca = _config.palanca;
        modelo.campaniaId = _config.campania;
        modelo.cuv = _config.cuv;
        modelo.origen = _config.origen;
        modelo.esEditable = _config.esEditable;

        var modeloFicha = {};

        _config.detalleEstrategiaProvider
            .promiseObternerModelo(modelo).done(function (data) {
                modeloFicha = data.data || {};
                modeloFicha.Error = data.success === false;
            }).fail(function (data, error) {
                modeloFicha = {};
                modeloFicha.Error = true;
            });

        if (modeloFicha.Error === true) {
            _redireccionar();
            return false;
        }

        _modeloFicha = modeloFicha;
        _modeloFicha.ConfiguracionContenedor = _modeloFicha.ConfiguracionContenedor || new Object();
        _modeloFicha.BreadCrumbs = _modeloFicha.BreadCrumbs || new Object();
    }

    ////// Fin - Construir Estructura Ficha

    var _setHandlebars = function (idTemplate, modelo) {
        SetHandlebars("#" + idTemplate, modelo, _template.getTagDataHtml(idTemplate));
    }

    var _redireccionar = function () {
        if (!_config.esEditable)
            window.location = baseUrl + (_config.esMobile ? "Mobile/" : "") + "Ofertas";
        else {
            FichaEditarModule.ShowDivFichaResumida(false);
            //alert('Ha ocurrido una excepción al obtener los datos para este CUV.');

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
    }

    var _initCliente = function () {
        if (!_modeloFicha.MostrarCliente) {
            return false;
        }

        //INIT PANEL CLIENTE
        panel.init();
        panel.AceptaClick(function (obj) {
            //PaisID, ClienteID, CodigoCliente, NombreCliente, Nombre
            //console.log('tu código:', obj);
            $(_seccionesPanelCliente.hfClienteId).val(obj.ClienteID);
            $(_seccionesPanelCliente.hfClienteNombre).val(obj.Nombre);
            $(_seccionesPanelCliente.spClienteNombre).html(obj.Nombre);
            EstrategiaAgregarModule.HabilitarBoton(); //EstrategiaAgregarModule.DeshabilitarBoton();
        });

        $(_seccionesPanelCliente.btnShowCliente).click(function () {
            panel.Abrir();
        });
        //END PANEL CLIENTE
    }

    var _analytics = function () {

        if (typeof AnalyticsPortalModule === 'undefined')
            return;

        AnalyticsPortalModule.MarcaVisualizarDetalleProducto(_estrategia);

    }

    function getEstrategia() {
        return _estrategia || _getEstrategia();
    }

    function getModeloFicha() {
        return _modeloFicha;
    }

    function ValidaOfertaDelDia(muestra) {
        var estrategia = _getEstrategia();

        if (ConstantesModule.CodigosPalanca.OfertaDelDia == _config.palanca &&
            (estrategia == null || estrategia.EstrategiaID == undefined)) {
            if (muestra)
                AbrirMensajeEstrategia('¡Ups! Esta oferta fue por tiempo limitado y ya no puedes modificarla.');

            return false;
        }

        return true;
    }

    function Inicializar() {
        _construirSeccionFicha();
        _construirSeccionEstrategia();
        _construirSeccionDetalleFichas();
        _fijarFooterCampaniaSiguiente();
        _initCliente();
        _initCarrusel();
        _analytics();
    }


    return {
        Inicializar: Inicializar,
        GetEstrategia: getEstrategia,
        GetModeloFicha: getModeloFicha
    };
});

var FichaEditarModule = (function () {

    var EditarProducto = function (event, tipoAccion) {
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
            palanca: palanca,
            campania: campania,
            cuv: cuv,
            origen: OrigenPedidoWeb,
            esEditable: true,
            setId: setId
        };

        if (!_validarData(objFicha)) {
            CerrarLoad();
            return false;
        }

        window.setTimeout(function () {
            fichaModule = FichaModule(objFicha);
            CerrarLoad();

            fichaModule.Inicializar();


        }, 10);
    };

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
    }

    return {
        EditarProducto: EditarProducto,
        ShowDivFichaResumida: _showDivFichaResumida
    };
})();

//Funcion temporal hasta estandarizar RevistaDigital.js

function RDPageInformativa() {
    window.location = baseUrl + (isMobile() ? "Mobile/" : "") + "RevistaDigital/Informacion";
}