var ArmaTuPackDetalleEvents = ArmaTuPackDetalleEvents || {};

registerEvent.call(ArmaTuPackDetalleEvents, "onGruposLoaded");
registerEvent.call(ArmaTuPackDetalleEvents, "onSelectedProductsChanged");

var SeleccionadosPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null";

    var _config = {

    };

    return {

    };
};

ArmaTuPackDetalleEvents.subscribe("onGruposLoaded", function (grupos) {
    //TODO :
});

ArmaTuPackDetalleEvents.subscribe("onSelectedProductsChanged", function (grupos) {
    //TODO :
});