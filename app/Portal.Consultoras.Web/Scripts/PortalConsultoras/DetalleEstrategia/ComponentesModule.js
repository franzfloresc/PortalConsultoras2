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
    "use strict";

    var _estrategia = {};

    var _elements = {
        body: {
            modalActivadoClass: "modal_activado"
        },
        componentes : {
            id: "#componentes",
            templateId: "#componentes-template"
        },
        divElegirOpciones: {
            id: "#elegir-opciones-modal",
            marginRight :"0",
            opacity: "1",
            modalFondo: {
                id: ".modal-fondo",
                opacity: ".7"
            }
        },
        resumenOpciones: {
            id: "#resumen-opciones",
            template: "#resumen-opciones-template"
        },
        tonosSelectOpt: ".tono_select_opt"
    };

    var ListarComponentes = function (estrategia) {
        if (typeof estrategia === "undefined" ||
            estrategia === null) throw "param estrategia is not defined or null";

        _estrategia = estrategia;
        SetHandlebars(_elements.componentes.templateId, _estrategia, _elements.componentes.id);
    };

    var _mostrarModalElegirOpciones = function() {
        if (isMobile()) {
            $(_elements.divElegirOpciones.id).modal("show");
        } else {
            $("body").addClass(_elements.body.modalActivadoClass);
            $(_elements.divElegirOpciones.modalFondo.id)
                .css("opacity", _elements.divElegirOpciones.modalFondo.opacity)
                .show();
            $(_elements.divElegirOpciones.id)
                .show()
                .css("margin-right", _elements.divElegirOpciones.marginRight)
                .css("opacity", _elements.divElegirOpciones.opacity);
        }
    };

    var SeleccionarComponente = function (cuv) {
        
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param cuv is not defined or null";

        $.each(_estrategia.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                var componente = {};
                componente = _estrategia.Hermanos[index];

                opcionesEvents.applyChanges("onComponentSelected", componente);

                _mostrarModalElegirOpciones();

                return false;
            }
        });
        
        AnalyticsPortalModule.MarcarPopupEligeUnaOpcion(_estrategia);
    }

    var SeleccionarPaletaOpcion = function (event, cuv) {
        
        var $PaletaOpcion = $(event.target);
        var CuvPadre = $PaletaOpcion.length > 0 ? $PaletaOpcion.parents("[data-tono-div]").data("tono-div") : "";

        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param cuv is not defined or null";
        cuv = $.trim(cuv);

        if (typeof CuvPadre === "undefined" ||
            CuvPadre === null ||
            $.trim(CuvPadre) === "") throw "param CuvPadre is not defined or null";
        CuvPadre = $.trim(CuvPadre);

        $.each(_estrategia.Hermanos, function (index, hermano) {
            CuvPadre = $.trim(CuvPadre);
            if (CuvPadre === hermano.Cuv) {
                var componente = {};
                componente = _estrategia.Hermanos[index];

                componente.resumenAplicados = [];

                $.each(componente.Hermanos, function (index, item) {
                    item.cantidadSeleccionada = 0;
                    if (cuv === item.Cuv) {
                        var opcion = item;
                        componente.resumenAplicados.push(opcion);
                        item.cantidadSeleccionada = 1;
                    }
                });

                opcionesEvents.applyChanges("onComponentSelected", componente);

                var callFromSeleccionarPaletaOpcion = true;
                ResumenOpcionesModule.AplicarOpciones(callFromSeleccionarPaletaOpcion);

                //Marcación Analytics (EPM-1442)
                AnalyticsPortalModule.MarcarImagenProducto(_estrategia, componente.resumenAplicados);

                return false;
            }
        });
        
        return false;
    }
    var LimpiarComponentes = function() {
        $.each(_estrategia.Hermanos, function (index, hermano) {
            $.each(hermano.Hermanos, function (index, hijo) {
                hijo.cantidadAplicada = 0;
                hijo.cantidadSeleccionada = 0;
            });
            var resumenOpcionesContenedor = _elements.resumenOpciones.id + "-" + hermano.Cuv;
            $(resumenOpcionesContenedor).siblings(_elements.tonosSelectOpt).show();
            $(resumenOpcionesContenedor).hide();
            
            hermano.resumenAplicados = [];
            hermano.HermanosSeleccionados = [];
        });
    }

    function getEstrategia() {
        return _estrategia;
    }
    return {
        ListarComponentes: ListarComponentes,
        SeleccionarComponente: SeleccionarComponente,
        SeleccionarPaletaOpcion: SeleccionarPaletaOpcion,
        LimpiarComponentes: LimpiarComponentes,
        GetEstrategia: getEstrategia
    };
}());

opcionesEvents.subscribe("onEstrategiaLoaded", function (estrategia) {
    ComponentesModule.ListarComponentes(estrategia);
});