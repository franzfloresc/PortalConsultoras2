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

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onOptionSelected");
var OpcionesSeleccionadasModule = (function () {
    var _componente = {};

    var _inicializar = function () {
        _componente = {};
        $("#contenedor-opciones-seleccionadas").hide();
        $("#opciones-seleccionadas").html("");
    };

    var _cargarOpcionesSeleccionadas = function (componente) {
        if (typeof componente === "undefined" ||
            componente === null) throw "param opcion is not defined or null";

        _componente = componente || {};
        if (_componente.Hermanos.length > 0) $("#contenedor-opciones-seleccionadas").show();

        $("#opciones-seleccionadas").slick("unslick");
        SetHandlebars("#opciones-seleccionadas-template", _componente, "#opciones-seleccionadas");
        $("#opciones-seleccionadas").slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false
        });
        $("#opciones-seleccionadas").fadeTo("fast", 0.6).fadeTo("fast", 1);

        return false;
    }

    var _getCantidadOpcionesSeleccionadas = function() {
        if (typeof _componente.Hermanos === "undefined" ||
            typeof _componente.Hermanos.length === "undefined") return 0;

        return _componente.Hermanos.length;
    };

    var _getOpcionesSeleccionadas = function () {
        var componente = ListaOpcionesModule.GetComponente();
        componente.Hermanos = _componente.Hermanos || [];
        return componente;
    }

    return {
        Inicializar : _inicializar,
        CargarOpcionesSeleccionadas: _cargarOpcionesSeleccionadas,
        GetCantidadOpcionesSeleccionadas: _getCantidadOpcionesSeleccionadas,
        GetOpcionesSeleccionadas : _getOpcionesSeleccionadas
    };
}());
opcionesEvents.subscribe("onComponentSelected", function (componente) {
    OpcionesSeleccionadasModule.Inicializar();
});
opcionesEvents.subscribe("onOptionSelected", function (componente) {
    OpcionesSeleccionadasModule.CargarOpcionesSeleccionadas(componente);
});