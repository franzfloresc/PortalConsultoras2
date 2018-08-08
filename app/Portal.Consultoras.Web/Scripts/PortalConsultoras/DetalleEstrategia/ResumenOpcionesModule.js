﻿var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var ResumenOpcionesModule = (function () {
    "use strict";

    var _componente = {};
    var template = "";

    var _actualizarCantidadSeleccionada = function (_componente) {
        $.each(_componente.Hermanos, function (index, hermano) {
            hermano.cantidadSeleccionada = 0;
            $.each(_componente.ResumenSeleccionados, function (index2, item) {
                if (hermano.Cuv === item.Cuv) {
                    hermano.cantidadSeleccionada++;
                }
            });
        });
        return false;
    };

    var _cargarOpcionesElegidas = function() {
        _componente = ListaOpcionesModule.GetComponente() || _componente;
        _componente.ResumenSeleccionados = _componente.HermanosSeleccionados;
        _componente.HermanosSeleccionados = [];

        if (typeof _componente.Cuv === "undefined" ||
            typeof _componente.Hermanos.length === "undefined") return false;

        _actualizarCantidadSeleccionada(_componente);

        var template = "#resumen-opciones-" + _componente.Cuv;
        var templateSiblings = $(template).siblings(".tono_select_opt").hide();
        $(template).show();

        $("#elegir-opciones-modal").modal("hide");
        SetHandlebars("#resumen-opciones-template", _componente, template);

        var OpcionPaleta = "[data-tono-cuv='[CUV]']";
        $.each(_componente.Hermanos, function (index, opcion) {
            if (opcion.cantidadSeleccionada > 0) {
                OpcionPaleta = OpcionPaleta.replace('[CUV]', opcion.Cuv);
            }
        });

        $("[data-tono-div]").find("[data-tono-cuv]").removeClass("borde_seleccion_tono");
        $("[data-tono-div]").find(OpcionPaleta).addClass("borde_seleccion_tono");

        return false;
    };

    return {
        CargarOpcionesElegidas: _cargarOpcionesElegidas
    };
}());

opcionesEvents.subscribe("onComponentSelected", function(componente) {
    //ResumenOpcionesModule.Inicializar();
});