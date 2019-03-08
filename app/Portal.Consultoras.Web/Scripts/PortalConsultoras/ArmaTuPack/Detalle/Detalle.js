/// <reference path="../../../general.js" />
/// <reference path="../armatupackprovider.js" />

/// <reference path="cabecera/cabeceraview.js" />
/// <reference path="cabecera/cabecerapresenter.js" />

/// <reference path="grupo/grupodesktopview.js" />
/// <reference path="grupo/grupomobileview.js" />
/// <reference path="grupo/grupopresenter.js" />

/// <reference path="seleccionados/seleccionadosview.js" />
/// <reference path="seleccionados/seleccionadospresenter.js" />

/// <reference path="../../estrategiaagregar/estrategiaagregar.js" />
/// <reference path="../../estrategiaagregar/estrategiaagregarprovider.js" />

var armaTuPackDetalleEvents = armaTuPackDetalleEvents || {
    eventName: {
        onGruposLoaded: "onGruposLoaded",
        onSelectedProductsChanged: "onSelectedProductsChanged",
    }
};

registerEvent.call(ArmaTuPackDetalleEvents, ArmaTuPackDetalleEvents.eventName.onGruposLoaded);
registerEvent.call(ArmaTuPackDetalleEvents, ArmaTuPackDetalleEvents.eventName.onSelectedProductsChanged);

var armaTuPackProvider = ArmaTuPackProvider();
var generalModule = GeneralModule;

var grupoDesktopView = GrupoDesktopView();
var grupoDesktopPresenter = GrupoPresenter({
    grupoView: grupoDesktopView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
});
//
var grupoMobileView = GrupoMobileView();
var grupoMobilePresenter = GrupoPresenter({
    grupoView: grupoMobileView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
});

var seleccionadosView = SeleccionadosView();
var seleccionadosPresenter = SeleccionadosPresenter({
    seleccionadosView: seleccionadosView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
});

$(document).ready(function () {
    armaTuPackProvider
        .getPackComponentsPromise()
        .done(function (data) {
            if (typeof data === "undefined" || data === null ||
                !Array.isArray(data.Grupos) || data.Grupos.length === 0) {
                generalModule.redirectTo("/ofertas");
            }
            armaTuPackDetalleEvents.applyChanges("onGruposLoaded", data);
        })
        .fail(function (data, error) {
            generalModule.redirectTo("/ofertas");
        });
});


armaTuPackDetalleEvents.subscribe(ArmaTuPackDetalleEvents.eventName.onGruposLoaded, function (grupos) {
    //TODO :
});

armaTuPackDetalleEvents.subscribe(ArmaTuPackDetalleEvents.eventName.onSelectedProductsChanged, function (grupos) {
    //TODO :
});