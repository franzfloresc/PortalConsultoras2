﻿/// <reference path="../../../Scripts/jquery-1.11.2.js" />
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
registerEvent.call(opcionesEvents, "onOptionSelected");
var TituloOpcionesSeleccionadasModule = (function () {
    var _estrategia = {};
    var __cargarTituloOpcionesSeleccionadas = function (componente) {
        _estrategia = componente || _estrategia;
        //_estrategia = OpcionesSeleccionadasModule.GetOpcionesSeleccionadas() || {};
        SetHandlebars("#titulo-opciones-seleccionadas-template", _estrategia, "#titulo-opciones-seleccionadas");
    };
    return {
        CargarTituloOpcionesSeleccionadas: __cargarTituloOpcionesSeleccionadas
    };
}());
//opcionesEvents.subscribe("onComponentSelected", function (componente) {
//    var _componente = jQuery.extend(true, {}, componente);
//    _componente.Hermanos = [];
//    TituloOpcionesSeleccionadasModule.CargarTituloOpcionesSeleccionadas(_componente);
//});
opcionesEvents.subscribe("onOptionSelected", function (componente) {
    TituloOpcionesSeleccionadasModule.CargarTituloOpcionesSeleccionadas(componente);
});