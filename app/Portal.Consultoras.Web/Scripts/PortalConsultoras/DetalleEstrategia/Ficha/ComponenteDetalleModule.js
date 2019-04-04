var ComponenteDetalleModule = (function (config) {

    "use strict";

    if (config === null || typeof config === "undefined")
        throw "config is null or undefined";

    if (config.localStorageModule === null || typeof config.localStorageModule === "undefined")
        throw "config.localStorageModule is null or undefined";

    if (config.analyticsPortalModule === null || typeof config.analyticsPortalModule === "undefined")
        throw "config.analyticsPortalModule is null or undefined";

    if (config.generalModule === null || typeof config.generalModule === "undefined")
        throw "config.generalModule is null or undefined";

    var _urlComponenteDetalle = ConstantesModule.UrlDetalleEstrategia;
    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _tipoEstrategiaTexto = ConstantesModule.TipoEstrategiaTexto;
    var _constantePalanca = ConstantesModule.ConstantesPalanca;

    var _config = {
        ComponenteDetalleProvider: ComponenteDetalleProvider,
        localStorageModule: config.localStorageModule,
        analyticsPortalModule: config.analyticsPortalModule,
        generalModule: config.generalModule,
        palanca: config.palanca,
        campania: config.campania,
        cuv: config.cuv,
        origen: config.origen
    };

    var _template = {
        getTagDataHtml: function (templateId) {
            return "[data-ficha-contenido=" + templateId + "]";
        },
        componenteDetalle: "componenteDetalle-template",
        componenteDetalleIndividual: "componenteDetalleIndividual-template",
        ContenidoProducto: "#ContenidoProducto",
        BotonVerDetalle: "div[id='btnVerDetalle']",
        MenuDetalleComponente: "#mnuDetalleComponente li a",
        CarruselVideo: '#carouselVideo',
        CarruselIndividualVideo: '#carouselIndividualVideo',
        ModalProductoDetalle: "#modal_producto_detalle"
    };

    var _validator = {
        mostrarBotoneraVerDetalle: function (valor) {
            if (valor) {
                $(_template.BotonVerDetalle).each(function () { $(this).show(); });
            } else {
                $(_template.BotonVerDetalle).each(function () { $(this).hide(); });
            }
        },
        mostrarContenidoProducto: function (valor) {
            if (valor) {
                $(_template.ContenidoProducto).show();
            } else {
                $(_template.ContenidoProducto).hide();
            }
        }
    };

    var _util = {
        mostrarDetalleModal: function (data) {
            _util.setHandlebars(_template.componenteDetalle, data);

            this.setAcordionDetalleComponente();//eventos de acordio

            if (!_config.generalModule.isMobile()) {
                $(_template.ModalProductoDetalle).show();
            } else {
                $(_template.ModalProductoDetalle).modal();
            }

            this.setCarrusel(_template.CarruselVideo);
            this.setYoutubeApi();
        },
        mostrarDetalleIndividual: function (estrategia) {
            //Este método asigna los datos del componente individual a _template.componenteDetalleIndividual

            //estrategia.Hermanos por default es solo 1
            if (estrategia.Hermanos.length > 0) {
                _util.setHandlebars(_template.componenteDetalleIndividual, estrategia.Hermanos[0]);
                this.setCarrusel(_template.CarruselIndividualVideo);
                this.setYoutubeApi();
            } else {
                console.log('estrategia.Hermanos no tiene items');
            }
        },
        setCarrusel: function (id) {
            $(id).slick({
                infinite: false,
                speed: 300,
                slidesToShow: 1,
                centerMode: false,
                variableWidth: true
            });
        },
        setAcordionDetalleComponente: function () {
            $(_template.MenuDetalleComponente).click(function () {
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
        },
        setHandlebars: function (idTemplate, modelo) {
            SetHandlebars("#" + idTemplate, modelo, _template.getTagDataHtml(idTemplate));
        },
        setYoutubeApi: function () {
            if (youtubeModule) {
                youtubeModule.Inicializar();
            }
        }
    };

    var _VerDetalle = function (componente) {
         
        console.log('componente', componente);         
        _util.mostrarDetalleModal(componente);
         
    };

    var _VerDetalleIndividual = function (estrategia) {
  
        console.log('estrategia', estrategia);
        _util.mostrarDetalleIndividual(estrategia);

    };

    var _OcultarControles = function () {

        if (_tipoEstrategiaTexto.Ganadoras === _config.palanca ||
            _tipoEstrategiaTexto.ShowRoom === _config.palanca || /*Especiales*/
            _tipoEstrategiaTexto.Lanzamiento === _config.palanca || /*Lo nuevo nuevo*/
            _tipoEstrategiaTexto.OfertasParaMi === _config.palanca ||
            _tipoEstrategiaTexto.OfertaParaTi === _config.palanca ||

            _tipoEstrategiaTexto.GuiaNegocio === _config.palanca ||
            _tipoEstrategiaTexto.GuiaDeNegocioDigitalizada === _config.palanca) {

            _validator.mostrarContenidoProducto(true);

            if ($(_template.BotonVerDetalle).length > 1) {

                _validator.mostrarBotoneraVerDetalle(true);
                _validator.mostrarContenidoProducto(false);

            } else {
                _validator.mostrarBotoneraVerDetalle(false);
            }
        }
        else {
            _validator.mostrarContenidoProducto(false);
            _validator.mostrarBotoneraVerDetalle(false);
        }

    };

    return {
        VerDetalle: _VerDetalle,
        VerDetalleIndividual: _VerDetalleIndividual,
        OcultarControles: _OcultarControles
    };
});