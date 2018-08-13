/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
/// <reference path="../../../Scripts/PortalConsultoras/DetalleEstrategia/ListaOpcionesModule.js" />
/// <reference path="../../../Scripts/slick.js" />

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onOptionSelected");

var OpcionesSeleccionadasModule = (function () {
    "use strict";

    var _componente = {};

    var _elements = {
        divContenedorOpcionesSeleccionadas : {
            id: "#contenedor-opciones-seleccionadas",
            templateId: "#opciones-seleccionadas-template"
        },
        divOpcionesSeleccionadas : {
            id: "#opciones-seleccionadas",
            templateId: "#opciones-seleccionadas-template"
        }
    };

    var CargarOpcionesSeleccionadas = function (componente) {
        if (typeof componente === "undefined" ||
            componente === null) throw "param componente is not defined or null";
        
        _componente = componente || {};
        if (_componente.HermanosSeleccionados.length > 0) {
            $(_elements.divContenedorOpcionesSeleccionadas.id).show();
            $(_elements.divOpcionesSeleccionadas.id).slick("unslick");
            SetHandlebars(_elements.divOpcionesSeleccionadas.templateId, _componente, _elements.divOpcionesSeleccionadas.id);
            $(_elements.divOpcionesSeleccionadas.id).fadeTo("fast", 0.6).fadeTo("fast", 1);
            var slickSettings = {
                slidesToShow: 5,
                slidesToScroll: 1,
                autoplaySpeed: 2000,
                fade: false,
                arrows: false
            };
            if (!isMobile()) {
                slickSettings.arrows = true;
                slickSettings.prevArrow = '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' +
                    baseUrl +
                    'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>';
                slickSettings.nextArrow =
                    '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' +
                    baseUrl +
                    'Content/Images/Esika/next.png")" alt="" /></a>';

            }
            $(_elements.divOpcionesSeleccionadas.id).slick(slickSettings);
        } else {
            $(_elements.divContenedorOpcionesSeleccionadas.id).hide();
            $(_elements.divOpcionesSeleccionadas.id).html("");
        }

        return false;
    }

    var GetCantidadOpcionesSeleccionadas = function () {
        if (typeof _componente.Hermanos === "undefined" ||
            typeof _componente.Hermanos.length === "undefined") return 0;

        return _componente.Hermanos.length;
    };

    return {
        CargarOpcionesSeleccionadas: CargarOpcionesSeleccionadas
    };
}());

opcionesEvents.subscribe("onOptionSelected", function (componente) {
    OpcionesSeleccionadasModule.CargarOpcionesSeleccionadas(componente);
});