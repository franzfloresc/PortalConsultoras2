﻿/// <reference path="../../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../../Scripts/General.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
/// <reference path="../../../../Scripts/PortalConsultoras/DetalleEstrategia/Ficha/ListaOpcionesModule.js" />
/// <reference path="../../../../Scripts/slick.js" />

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onOptionSelected");

var OpcionesSeleccionadasModule = (function () {
    "use strict";

    var _componente = {};

    var _elements = {
        divContenedorOpcionesSeleccionadas: {
            id: "#contenedor-opciones-seleccionadas",
            templateId: "#opciones-seleccionadas-template"
        },
        divOpcionesSeleccionadas: {
            id: "#opciones-seleccionadas",
            templateId: "#opciones-seleccionadas-template"
        }
    };

    var CargarOpcionesSeleccionadas = function (componente) {
        if (typeof componente === "undefined" ||
            componente === null) throw "param componente is not defined or null";

        _componente = componente || {};
        var cantidadSeleccionados = _componente.HermanosSeleccionados.length;
        if (cantidadSeleccionados > 0) {
            $(_elements.divContenedorOpcionesSeleccionadas.id).show();
            $(_elements.divOpcionesSeleccionadas.id).slick("unslick");
            SetHandlebars(_elements.divOpcionesSeleccionadas.templateId, _componente, _elements.divOpcionesSeleccionadas.id);
            $(_elements.divOpcionesSeleccionadas.id).fadeTo("fast", 0.6).fadeTo("fast", 1);
            var slickSettings = {
                slidesToShow: 4,
                slidesToScroll: 1,
                autoplaySpeed: 2000,
                fade: false,
                arrows: false,
                infinite: false
            };

            if (!isMobile()) {
                slickSettings.arrows = true;
                slickSettings.prevArrow = '<a id="opciones-seleccionadas-prev" class="flecha_ofertas-tipo prev" style="left:-5%; text-align:left;display:none;"><img src="' +
                    baseUrl +
                    'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>';
                slickSettings.nextArrow =
                    '<a id="opciones-seleccionadas-next" class="flecha_ofertas-tipo" style="display: block; right:-5%; text-align:right;display:none;"><img src="' +
                    baseUrl +
                    'Content/Images/Esika/next.png")" alt="" /></a>';
            } else {
                slickSettings.slidesToShow = 5;
            }
            var lastSlideIndex = cantidadSeleccionados - slickSettings.slidesToShow;
            $(_elements.divOpcionesSeleccionadas.id).slick(slickSettings);
            if (cantidadSeleccionados > slickSettings.slidesToShow) {
                $(_elements.divOpcionesSeleccionadas.id)
                    .slick("slickGoTo", lastSlideIndex);
            }
            $(_elements.divOpcionesSeleccionadas.id).on('afterChange', function (event, slick, currentSlide, nextSlide) {
                if (currentSlide === 0) {
                    $("#opciones-seleccionadas-prev").hide();
                    $("#opciones-seleccionadas-next").show();
                } else if (currentSlide === lastSlideIndex) {
                    $("#opciones-seleccionadas-prev").show();
                    $("#opciones-seleccionadas-next").hide();
                } else {
                    $("#opciones-seleccionadas-prev").show();
                    $("#opciones-seleccionadas-next").show();
                }
            });
        } else {
            $(_elements.divContenedorOpcionesSeleccionadas.id).hide();
            $(_elements.divOpcionesSeleccionadas.id).html("");
        }

        return false;
    }

    return {
        CargarOpcionesSeleccionadas: CargarOpcionesSeleccionadas
    };
}());

opcionesEvents.subscribe("onOptionSelected", function (componente) {
    OpcionesSeleccionadasModule.CargarOpcionesSeleccionadas(componente);
});