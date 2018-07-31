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
registerEvent.call(opcionesEvents, "onComponentSelected");
var ListaOpcionesModule = (function () {
    var _componente = {};
    var _cargarOpciones = function (componente) {
        _componente = componente || _componente;
        SetHandlebars("#lista-opciones-template", _componente, "#lista-opciones");
    }

    var _seleccionarOpcion = function (cuv) {
        var opcion;
        $.each(_componente.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                opcion = _componente.Hermanos[index];
                return false;
            }
        });
        //
        opcionesEvents.applyChanges("onOptionSelected", opcion);
        //
        $("#elegir-opciones-modal").modal("show");
    }
    return {
        CargarOpciones: _cargarOpciones,
        SeleccionarOpcion : _seleccionarOpcion
    };
}());
opcionesEvents.subscribe("onComponentSelected", function (componente) {
    console.log(componente);
    ListaOpcionesModule.CargarOpciones(componente);
});