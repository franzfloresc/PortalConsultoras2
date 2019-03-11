var DetallePresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    //
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";

    var _config = {
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };

    var _getPackComponents = function () {
        _config.armaTuPackProvider
            .getPackComponentsPromise()
            .done(function (data) {
                if (typeof data === "undefined" || data === null ||
                    !Array.isArray(data.componentes) || data.componentes.length === 0) {
                    _config.generalModule.redirectTo("/ofertas");
                }
                _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onGruposLoaded, data);
            })
            .fail(function (data, error) {
                _config.generalModule.redirectTo("/ofertas");
            });
    };

    var _init = function () {
        _getPackComponents();
    };

    return {
        init : _init
    };
};