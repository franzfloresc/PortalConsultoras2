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

var TituloOpcionesSeleccionadasModule = (function () {
    "use strict";

    var _componente = {};

    var _elements = {
        divTituloOpcionesSeleccionadas: {
            templateId: "#titulo-opciones-seleccionadas-template",
            id: "#titulo-opciones-seleccionadas"
        }
    };

    var _obtenerTitulo = function () {
        var titulo = "";
        //
        if (_componente.HermanosSeleccionados.length === 0 && _componente.FactorCuadre === 1)
            titulo = "Elige 1 opción";
        if (_componente.HermanosSeleccionados.length === 0 && _componente.FactorCuadre > 1)
            titulo = "Elige " + _componente.FactorCuadre + " opciones";
        //
        if (_componente.HermanosSeleccionados.length > 0 && _componente.cantidadFaltantes === 1)
            titulo = "Te Falta 1 opción";
        if (_componente.HermanosSeleccionados.length > 0 && _componente.cantidadFaltantes > 1)
            titulo = "Te Faltan " + _componente.cantidadFaltantes + " opciones";
        //
        if (_componente.cantidadFaltantes === 0
            && _componente.resumenAplicados.length === 0
            && _componente.HermanosSeleccionados.length === 1)
            titulo = "¡Listo! <span>ya tienes tu</span> opción";
        if (_componente.cantidadFaltantes === 0
            && _componente.resumenAplicados.length === 0
            && _componente.HermanosSeleccionados.length > 1)
            titulo = "¡Listo! <span>ya tienes tus</span> " + _componente.HermanosSeleccionados.length + " opciones";
        //
        if (_componente.cantidadFaltantes === 0
            && _componente.resumenAplicados.length > 0
            && (typeof _componente.mostrarListo === "undefined" || !_componente.mostrarListo)
            && _componente.HermanosSeleccionados.length === 1)
            titulo = "Cambia tu opción";
        if (_componente.cantidadFaltantes === 0
            && _componente.resumenAplicados.length > 0
            && (typeof _componente.mostrarListo === "undefined" || !_componente.mostrarListo)
            && _componente.HermanosSeleccionados.length > 1)
            titulo = "Cambia tus " + _componente.HermanosSeleccionados.length + " opciones";
        //
        if (_componente.cantidadFaltantes === 0
            && _componente.resumenAplicados.length > 0
            && (_componente.mostrarListo)
            && _componente.HermanosSeleccionados.length === 1)
            titulo = "¡Listo! <span>ya tienes tu</span> opción";
        if (_componente.cantidadFaltantes === 0
            && _componente.resumenAplicados.length > 0
            && (_componente.mostrarListo)
            && _componente.HermanosSeleccionados.length > 1)
            titulo = "¡Listo! <span>ya tienes tus</span> " + _componente.HermanosSeleccionados.length + " opciones";
        //
        return titulo;
    };

    var _obtenerSubTitulo = function () {
        var subtitulo = "";
        //
        if (_componente.HermanosSeleccionados.length === 1)
            subtitulo = "1 seleccionado";
        if (_componente.HermanosSeleccionados.length > 1 || _componente.HermanosSeleccionados.length === 0)
            subtitulo = _componente.HermanosSeleccionados.length + " seleccionados";
        //
        return subtitulo;
    };

    var CargarTituloOpcionesSeleccionadas = function(componente) {
        _componente = componente || _componente;
        //
        var model = {
            titulo: _obtenerTitulo(),
            subtitulo: _obtenerSubTitulo()
        };
        //
        SetHandlebars(_elements.divTituloOpcionesSeleccionadas.templateId, model, _elements.divTituloOpcionesSeleccionadas.id);
    };

    return {
        CargarTituloOpcionesSeleccionadas: CargarTituloOpcionesSeleccionadas
    };
}());

opcionesEvents.subscribe("onOptionSelected", function (componente) {
    TituloOpcionesSeleccionadasModule.CargarTituloOpcionesSeleccionadas(componente);
});