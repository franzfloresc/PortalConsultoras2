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
        _estrategia = estrategia || _estrategia;
        SetHandlebars("#componentes-template", _estrategia, "#componentes");
    };

    var _seleccionarComponente = function (cuv) {
        var componente;
        $.each(_estrategia.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                componente = _estrategia.Hermanos[index];
                return false;
            }
        });
        //
        opcionesEvents.applyChanges("onComponentSelected", componente);
        //
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

    }

    return {
        CargarComponentesEstrategia: _cargarComponentesEstrategia,
        SeleccionarComponente: _seleccionarComponente
    };
}());
opcionesEvents.subscribe("onEstrategiaLoaded", function (estrategia) {
    ComponentesModule.CargarComponentesEstrategia(estrategia);
});