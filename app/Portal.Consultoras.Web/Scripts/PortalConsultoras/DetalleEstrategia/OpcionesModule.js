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
var OpcionesModule = (function () {
    var _estrategia = {};

    var _inicializar = function (model) {
        _estrategia = model || _estrategia;
        SetHandlebars("#opciones-template", _estrategia, "#opciones");
    };

    var _mostrarOpciones = function (cuv) {
        $.each(_estrategia.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                _estrategia.Hermanos[index].MostrarOpciones = true;
            }
            return false;
        });
        $("#elegir-opciones-modal").modal("show");
        //
        opcionesEvents.applyChanges("onOptionSelected", _estrategia);
    }

    return {
        Inicializar: _inicializar,
        MostrarOpciones: _mostrarOpciones
    };
}());
opcionesEvents.subscribe("onOptionSelected", function (e) {
    OpcionesModule.Inicializar(e);
});