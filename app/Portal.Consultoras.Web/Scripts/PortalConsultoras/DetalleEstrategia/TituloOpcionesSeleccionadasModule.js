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

var TituloOpcionesSeleccionadasModule = (function () {
    "use strict";

    var _componente = {};

    var _elements = {
        divTituloOpcionesSeleccionadas: {
            templateId: "#titulo-opciones-seleccionadas-template",
            id: "#titulo-opciones-seleccionadas"
        }
    };

    var CargarTituloOpcionesSeleccionadas = function (componente) {
        _componente = componente || _componente;
        console.log(_componente);
        SetHandlebars(_elements.divTituloOpcionesSeleccionadas.templateId, _componente, _elements.divTituloOpcionesSeleccionadas.id);
    };

    return {
        CargarTituloOpcionesSeleccionadas: CargarTituloOpcionesSeleccionadas
    };
}());

opcionesEvents.subscribe("onOptionSelected", function (componente) {
    TituloOpcionesSeleccionadasModule.CargarTituloOpcionesSeleccionadas(componente);
});