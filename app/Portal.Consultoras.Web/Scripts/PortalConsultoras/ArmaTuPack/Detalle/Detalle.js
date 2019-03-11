/// <reference path="../../../general.js" />
/// <reference path="../armatupackprovider.js" />

/// <reference path="armatupackdetalleevents.js" />
/// <reference path="detallepresenter.js" />

/// <reference path="cabecera/cabeceraview.js" />
/// <reference path="cabecera/cabecerapresenter.js" />

/// <reference path="grupos/gruposdesktopview.js" />
/// <reference path="grupos/gruposmobileview.js" />
/// <reference path="grupos/grupospresenter.js" />

/// <reference path="seleccionados/seleccionadosview.js" />
/// <reference path="seleccionados/seleccionadospresenter.js" />

/// <reference path="../../estrategiaagregar/estrategiaagregar.js" />
/// <reference path="../../estrategiaagregar/estrategiaagregarprovider.js" />

var armaTuPackDetalleEvents = ArmaTuPackDetalleEvents();

var armaTuPackProvider = ArmaTuPackProvider();
var generalModule = GeneralModule;

var detallePresenter = DetallePresenter({
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});

var gruposDesktopView = GruposDesktopView();
var gruposDesktopPresenter = GruposPresenter({
    gruposView: gruposDesktopView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});
gruposDesktopView.setPresenter(gruposDesktopPresenter);
//
var gruposMobileView = GruposMobileView();
var gruposMobilePresenter = GruposPresenter({
    gruposView: gruposMobileView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});

var seleccionadosView = SeleccionadosView();
var seleccionadosPresenter = SeleccionadosPresenter({
    seleccionadosView: seleccionadosView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});
seleccionadosView.setPresenter(seleccionadosPresenter);

$(document).ready(function () {
    detallePresenter.init();
});


armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onGruposLoaded, function (packComponents) {
    gruposDesktopPresenter.onGruposLoaded(packComponents);
    //grupoMobilePresenter.renderGrupos(packComponents);
    //TODO :
});

armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, function (packComponents) {
    seleccionadosPresenter._onSelectedComponentsChanged(packComponents);
});