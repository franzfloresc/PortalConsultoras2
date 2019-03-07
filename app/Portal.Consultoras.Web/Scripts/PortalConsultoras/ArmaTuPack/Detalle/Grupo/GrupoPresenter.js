var GrupoPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null";
    if (typeof config.grupoView === "undefined" || config.grupoView === null) throw "config is null";
    if (typeof config.detalleEstrategiaProvider === "undefined" || config.detalleEstrategiaProvider === null) throw "config is null";

    var _config = {
        grupoView: config.grupoView,
        detalleEstrategiaProvider: config.detalleEstrategiaProvider,
    };

    var _init = function () {

    };

    return {
        init : _init
    };
};