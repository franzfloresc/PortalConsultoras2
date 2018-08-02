﻿var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var ResumenOpcionesModule = (function () {
    "use strict";

    var _componente = {};
    var template = "";

    var _cargarOpcionesElegidas = function() {
        _componente = ListaOpcionesModule.GetComponente() || _componente;
        if (typeof _componente.Cuv === "undefined" ||
            typeof _componente.Hermanos.length === "undefined") return false;

        var template = "#resumen-opciones-" + _componente.Cuv;
        var templateSiblings = $(template).siblings(".tono_select_opt").hide();
        $(template).show();

        $("#elegir-opciones-modal").modal("hide");
        SetHandlebars("#resumen-opciones-template", _componente, template);
        return false;
    };

    return {
        CargarOpcionesElegidas: _cargarOpcionesElegidas
    };
}());

opcionesEvents.subscribe("onComponentSelected", function(componente) {
    //ResumenOpcionesModule.Inicializar();
});