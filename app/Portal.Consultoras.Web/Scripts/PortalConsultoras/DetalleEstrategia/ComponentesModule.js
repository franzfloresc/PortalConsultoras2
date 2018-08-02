/// <reference path="ResumenOpcionesModule.js" />
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

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onEstrategiaLoaded");
registerEvent.call(opcionesEvents, "onComponentSelected");

var ComponentesModule = (function () {
    var _estrategia = {};

    var _cargarComponentesEstrategia = function (estrategia) {
        if (typeof estrategia === "undefined" ||
            estrategia === null) throw "param estrategia is not defined or null";

        _estrategia = estrategia;
        SetHandlebars("#componentes-template", _estrategia, "#componentes");
    };

    var _seleccionarComponente = function (cuv) {
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param cuv is not defined or null";

        $.each(_estrategia.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                var componente = {};
                componente = jQuery.extend(true, {}, _estrategia.Hermanos[index]);
                opcionesEvents.applyChanges("onComponentSelected", componente);
                if (isMobile()) {
                    $("#elegir-opciones-modal").modal("show");
                } else {
                    $('body').addClass("modal_activado");
                    $('.modal-fondo').css('opacity', '.7');
                    $('.modal-fondo').show();
                    $('.contenedor_seleccion').show();
                    $('.contenedor_seleccion').css('margin-right', '0');
                    $('.contenedor_seleccion').css('opacity', '1');
                }
                return false;
            }
        });
    }

    return {
        CargarComponentesEstrategia: _cargarComponentesEstrategia,
        SeleccionarComponente: _seleccionarComponente
    };
}());

opcionesEvents.subscribe("onEstrategiaLoaded", function (estrategia) {
    ComponentesModule.CargarComponentesEstrategia(estrategia);
});