var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var OpcionesElegidasModule = (function () {
    var _componente;
    var template;
    var _inicializar = function () {
        _componente = {};
        template = "";
    }

    var _cargarOpcionesElegidas = function () {
        _componente = OpcionesSeleccionadasModule.GetOpcionesSeleccionadas() || _componente;
        if (typeof _componente.Cuv === "undefined" ||
            typeof _componente.Hermanos.length === "undefined") return false;

        var template = "#opciones-elegidas" + _componente.Cuv;

        SetHandlebars("#opciones-elegidas-template", _componente, template);
        return false;
    }


    return {
        CargarOpcionesElegidas: _cargarOpcionesElegidas,
        Inicializar: _inicializar
    };

});

opcionesEvents.subscribe("onComponentSelected", function (componente) {
    OpcionesElegidasModule.Inicializar();
});