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
registerEvent.call(opcionesEvents, "onOptionSelected");
var OpcionesSeleccionadasModule = (function () {
    var _componente = {};
    var _cargarOpcionesSeleccionadas = function (opcion) {
        if (typeof opcion === "undefined" || opcion === null) return false;
        
        _componente.Hermanos = _componente.Hermanos || [];
        _componente.Hermanos.push(opcion);
        $("#opciones-seleccionadas").slick("unslick");
        SetHandlebars("#opciones-seleccionadas-template", _componente, "#opciones-seleccionadas");
        $("#opciones-seleccionadas").slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false
        });
        $("#opciones-seleccionadas").fadeTo("fast", 0.7).fadeTo("fast", 1);
        return false;
    }
    return {
        CargarOpcionesSeleccionadas: _cargarOpcionesSeleccionadas
    };

}());
opcionesEvents.subscribe("onOptionSelected", function (opcion) {
    OpcionesSeleccionadasModule.CargarOpcionesSeleccionadas(opcion);
});