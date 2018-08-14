var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var ResumenOpcionesModule = (function () {
    "use strict";

    var _componente = {};
    var template = "";
    var _elements = {
        resumenOpciones: {
            id: "#resumen-opciones",
            template: "#resumen-opciones-template"
        },
        tonosSelectOpt: ".tono_select_opt",
        dataTonoDiv: "[data-tono-div]",
        dataTonoCuv: "[data-tono-cuv]",
        bordeSeleccionTono: "borde_seleccion_tono"
    };

    var _actualizarCantidadAplicada = function () {
        $.each(_componente.Hermanos, function (index, hermano) {
            hermano.cantidadAplicada = 0;
            $.each(_componente.resumenAplicados, function (index2, item) {
                if (hermano.Cuv === item.Cuv) {
                    hermano.cantidadAplicada++;
                }
            });
        });
        return false;
    };

    var AplicarOpciones = function () {

        _componente = ListaOpcionesModule.GetComponente() || _componente;
        if (!(_componente.FactorCuadre === _componente.HermanosSeleccionados.length)) {
            return false;
        }

        _componente.resumenAplicados = _componente.HermanosSeleccionados;
        _componente.HermanosSeleccionados = [];

        if (typeof _componente.Cuv === "undefined" ||
            typeof _componente.Hermanos.length === "undefined") return false;

        _actualizarCantidadAplicada(_componente);

        var resumenOpcionesContenedor = _elements.resumenOpciones.id +"-"+_componente.Cuv;

        var templatesiblings = $(resumenOpcionesContenedor).siblings(_elements.tonosSelectOpt).hide();
        
        $(resumenOpcionesContenedor).show();

        ListaOpcionesModule.CloseElegirOpcionesModal();

        SetHandlebars(_elements.resumenOpciones.template, _componente, resumenOpcionesContenedor);

        $(resumenOpcionesContenedor).parents("[data-opciones-seleccionadas]").attr("data-opciones-seleccionadas", _componente.FactorCuadre);

        var codigoVariante = $("#componentes").data("codigovariante");
        if (codigoVariante === 2001) {
            var OpcionPaleta = "[data-tono-cuv='[CUV]']";
            $.each(_componente.Hermanos, function (index, opcion) {
                if (opcion.cantidadSeleccionada > 0) {
                    OpcionPaleta = OpcionPaleta.replace('[CUV]', opcion.Cuv);
                }
            });

            $(_elements.dataTonoDiv).find(_elements.dataTonoCuv).removeClass(_elements.bordeSeleccionTono);
            $(_elements.dataTonoDiv).find(OpcionPaleta).addClass(_elements.bordeSeleccionTono);
        }

        return false;
    };

    return {
        AplicarOpciones: AplicarOpciones
    };
}());

opcionesEvents.subscribe("onComponentSelected", function(componente) {
    //ResumenOpcionesModule.Inicializar();
});