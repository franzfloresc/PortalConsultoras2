var SeleccionadosPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.seleccionadosView === "undefined" || config.seleccionadosView === null) throw "config.seleccionadosView is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";

    var _config = {
        seleccionadosView: config.seleccionadosView,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };

    return {

    };
};