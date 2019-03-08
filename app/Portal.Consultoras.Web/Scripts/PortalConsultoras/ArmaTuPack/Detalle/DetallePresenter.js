var ArmaTuPackDetalleEvents = ArmaTuPackDetalleEvents || {};

registerEvent.call(ArmaTuPackDetalleEvents, "onGruposLoaded");
registerEvent.call(ArmaTuPackDetalleEvents, "onSelectedProductsChanged");

var DetallePresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";

    var _packComponents = {};

    var _config = {
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        cuv: config.cuv
    };

    var _getModelo = function () {
        _config.armaTuPackProvider
            .getPackComponentsPromise()
            .done(function (data) {
                if (typeof data === "undefined" || data === null ||
                    !Array.isArray(data.Grupos) || data.Grupos.length === 0)
                    _config.generalModule.redirectTo("/ofertas");

                _packComponents = data;
                opcionesEvents.applyChanges("onGruposLoaded", _packComponents);
            })
            .fail(function (data, error) {
                _packComponents = {};
                _config.generalModule.redirectTo("/ofertas");
            });
    };

    var _init = function () {
        _getModelo();
    };

    return {
        init: _init,
        packComponents: _packComponents
    };
};

ArmaTuPackDetalleEvents.subscribe("onGruposLoaded", function (grupos) {
    //TODO :
});

ArmaTuPackDetalleEvents.subscribe("onSelectedProductsChanged", function (grupos) {
    //TODO :
});