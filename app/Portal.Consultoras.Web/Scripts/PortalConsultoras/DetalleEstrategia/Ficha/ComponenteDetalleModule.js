﻿var ComponenteDetalleModule = (function (config) {
    "use strict";

    if (config === null || typeof config === "undefined")
        throw "config is null or undefined";

    if (config.localStorageModule === null || typeof config.localStorageModule === "undefined")
        throw "config.localStorageModule is null or undefined";

    if (config.analyticsPortalModule === null || typeof config.analyticsPortalModule === "undefined")
        throw "config.analyticsPortalModule is null or undefined";

    if (config.generalModule === null || typeof config.generalModule === "undefined")
        throw "config.generalModule is null or undefined";

    //var _urlComponenteDetalle = ConstantesModule.UrlDetalleEstrategia;
    //var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _tipoEstrategiaTexto = ConstantesModule.TipoEstrategiaTexto;
    //var _constantePalanca = ConstantesModule.ConstantesPalanca;

    var _config = {
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
        //ContenidoProducto: "#ContenidoProducto",
        //BotonVerDetalle: "[id='btnVerDetalle']",
        MenuDetalleComponente: "#mnuDetalleComponente li a",
        CarruselVideo: '#carouselVideo',
        CarruselIndividualVideo: '#carouselIndividualVideo',
        ModalProductoDetalle: "#modal_producto_detalle"
    };

    //var _validator = {
    //    mostrarBotoneraVerDetalle: function (valor) {
    //        if (valor) {
    //            $(_template.BotonVerDetalle).each(function () { $(this).show(); });
    //        } else {
    //            $(_template.BotonVerDetalle).each(function () { $(this).hide(); });
    //        }
    //    },
    //    mostrarContenidoProducto: function (valor) {
    //        if (valor) {
    //            $(_template.ContenidoProducto).show();
    //        } else {
    //            $(_template.ContenidoProducto).hide();
    //        }
    //    }
    //};

    var _util = {
        mostrarDetalleModal: function (data) {
            _util.setHandlebars(_template.componenteDetalle, data);

            this.setYoutubeId();
            if (!_config.generalModule.isMobile()) {
                _events.bindClosePopup();
                this.setTabDetalleComponente();
                $("body").css("overflow", "hidden");
                $(_template.ModalProductoDetalle).show();
            } else {
                this.setAcordionDetalleComponente();//eventos de acordio
                $(_template.ModalProductoDetalle).modal();
            }

            this.setYoutubeApi();
            this.setCarrusel(_template.CarruselVideo);
        },
        mostrarDetalleIndividual: function (estrategia) {
            //Este método asigna los datos del componente individual a _template.componenteDetalleIndividual

            //estrategia.Hermanos por default es solo 1
            console.log(estrategia);

            if (estrategia.Hermanos.length == 1) {
                if (estrategia.MostrarFichaEnriquecida) {

                    _util.setHandlebars(_template.componenteDetalleIndividual, estrategia.Hermanos[0]);

                    this.setYoutubeId();
                    if (!_config.generalModule.isMobile()) {
                        this.setTabDetalleComponente();
                    }
                    else {
                        this.setAcordionDetalleComponente();
                    }
                    this.setCarrusel(_template.CarruselIndividualVideo);
                    this.setYoutubeApi();
                }
            }
        },
        setCarrusel: function (id) {
            $(id).slick({
                infinite: false,
                speed: 300,
                slidesToShow: 3,
                centerMode: false,
                variableWidth: true,
                responsive: [
                    {
                        breakpoint: 1024,
                        settings: {
                            slidesToShow: 3,
                        }
                    },
                    {
                        breakpoint: 700,
                        settings: {
                            slidesToShow: 1,
                        }
                    },
                ],
                prevArrow:
                    "<a id=\"opciones-seleccionadas-prev\" class=\"flecha_ofertas-tipo prev\" style=\"left:-5%; text-align:left;display:none;\">" +
                    "<img src=\"" + baseUrl + "Content/Images/Esika/previous_ofertas_home.png\")\" alt=\"\" />" +
                    "</a>",
                nextArrow:
                    "<a id=\"opciones-seleccionadas-next\" class=\"flecha_ofertas-tipo\" style=\"display: block; right:-5%; text-align:right;display:none;\">" +
                    "<img src=\"" + baseUrl + "Content/Images/Esika/next.png\")\" alt=\"\" />" +
                    "</a>"
            });
        },
        setTabDetalleComponente: function () {
            $("body").off("click", "[data-tab-header]");
            $("body").on("click", "[data-tab-header]", function (e) {
                console.log('click setTabDetalleComponente');
                e.preventDefault();
                var numTab = $(e.target).data("num-tab");
                $("[data-tab-header]").removeClass("active");
                if ($("[data-tab-header][data-num-tab]").length > 1) {
                    $("[data-tab-header][data-num-tab=" + numTab + "]").addClass("active");
                }
                $("[data-tab-body]").hide();
                $("[data-tab-body][data-num-tab=" + numTab + "]").show();
            });
        },
        setAcordionDetalleComponente: function () {
            $(_template.MenuDetalleComponente).click(function () {
                console.log('click setAcordionDetalleComponente');
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
        setYoutubeId: function () {
            $.each($("[data-youtube-key]"), function (i, ytEle) {
                var idyt = $(ytEle).attr('id') + "-" + i;
                $(ytEle).attr('id', idyt);
            });
        },
        setYoutubeApi: function () {
            try {
                if (youtubeModule) {
                    youtubeModule.Inicializar();
                    window.onYouTubeIframeAPIReady();
                }
            } catch (e) {
                console.log('setYoutubeApi => ', e);
            }
        }
    };

    var _VerDetalle = function (event) {
        var componente = $(event.target).parents("[data-componente-grupo]").find("[data-componente]").data("componente");
        _util.mostrarDetalleModal(componente);
    };

    var _VerDetalleIndividual = function (estrategia) {
        _util.mostrarDetalleIndividual(estrategia);
    };

    //var _OcultarControles = function (variante) {
    //    console.log(variante);
    //    if (_tipoEstrategiaTexto.Ganadoras === _config.palanca ||
    //        _tipoEstrategiaTexto.ShowRoom === _config.palanca || /*Especiales*/
    //        _tipoEstrategiaTexto.Lanzamiento === _config.palanca || /*Lo nuevo nuevo*/
    //        _tipoEstrategiaTexto.OfertasParaMi === _config.palanca ||
    //        _tipoEstrategiaTexto.OfertaParaTi === _config.palanca ||
    //        _tipoEstrategiaTexto.GuiaNegocio === _config.palanca ||
    //        _tipoEstrategiaTexto.GuiaDeNegocioDigitalizada === _config.palanca) {

    //        _validator.mostrarContenidoProducto(true);

    //        if (variante != ConstantesModule.CodigoVariedad.IndividualVariable) {
    //            _validator.mostrarBotoneraVerDetalle(true);
    //            _validator.mostrarContenidoProducto(false);
    //        } else {
    //            _validator.mostrarBotoneraVerDetalle(false);
    //        }
    //    }
    //    else {
    //        _validator.mostrarContenidoProducto(false);
    //        _validator.mostrarBotoneraVerDetalle(false);
    //    }
    //};

    var _events = {
        bindClosePopup: function () {
            $("body").off("click", "[data-close-product-detail-popup]");
            $("body").on("click", "[data-close-product-detail-popup]", function (e) {
                e.preventDefault();
                $("[data-product-detail-popup]").hide();
                $("body").css("overflow", "auto");
            });
        }
    };

    return {
        VerDetalle: _VerDetalle,
        VerDetalleIndividual: _VerDetalleIndividual
        //OcultarControles: _OcultarControles
    };
});