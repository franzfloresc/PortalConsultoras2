/// <reference path="../../../general.js" />
/// <reference path="../armatupackprovider.js" />

/// <reference path="armatupackdetalleevents.js" />
/// <reference path="detallepresenter.js" />

/// <reference path="cabecera/cabeceraview.js" />
/// <reference path="cabecera/cabecerapresenter.js" />

/// <reference path="grupo/grupodesktopview.js" />
/// <reference path="grupo/grupomobileview.js" />
/// <reference path="grupo/grupopresenter.js" />

/// <reference path="seleccionados/seleccionadosview.js" />
/// <reference path="seleccionados/seleccionadospresenter.js" />

/// <reference path="../../estrategiaagregar/estrategiaagregar.js" />
/// <reference path="../../estrategiaagregar/estrategiaagregarprovider.js" />

var armaTuPackDetalleEvents = ArmaTuPackDetalleEvents();

var armaTuPackProvider = ArmaTuPackProvider();
var generalModule = GeneralModule;

var detallePresenter = DetallePresenter({
    grupoView: grupoDesktopView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});

var grupoDesktopView = GrupoDesktopView();
var grupoDesktopPresenter = GrupoPresenter({
    grupoView: grupoDesktopView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});
//
var grupoMobileView = GrupoMobileView();
var grupoMobilePresenter = GrupoPresenter({
    grupoView: grupoMobileView,
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

$(document).ready(function () {
    //detallePresenter.init();
});


armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onGruposLoaded, function (PackComponents) {
    grupoDesktopPresenter.renderGrupos(PackComponents);
    //TODO :
});

armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onGruposViewLoaded, function (PackComponents) {
    grupoDesktopView.renderGrupos(PackComponents);
    //grupoMobileView.renderGrupos(PackComponents);
    //TODO :
});

armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onSelectedProductsChanged, function (grupos) {
    //TODO :
});