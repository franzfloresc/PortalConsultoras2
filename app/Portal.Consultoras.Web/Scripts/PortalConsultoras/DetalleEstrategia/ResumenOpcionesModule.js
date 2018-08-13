var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var ResumenOpcionesModule = (function () {
    "use strict";

    var _componente = {};
    var template = "";

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

        var template = "#resumen-opciones-" + _componente.Cuv;

        if (isMobile()) {
            var templatesiblings = $(template).siblings(".tono_select_opt").hide();
        } else {
            var templatesiblings = $(template).siblings('[data-tono-change="1"]').hide();
        }
        
        $(template).show();

        ListaOpcionesModule.CloseElegirOpcionesModal();

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
        AplicarOpciones: AplicarOpciones
    };
}());

opcionesEvents.subscribe("onComponentSelected", function(componente) {
    //ResumenOpcionesModule.Inicializar();
});