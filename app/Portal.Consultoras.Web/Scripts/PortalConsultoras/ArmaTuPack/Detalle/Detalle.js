﻿/// <reference path="../../../general.js" />
/// <reference path="../armatupackprovider.js" />

/// <reference path="armatupackdetalleevents.js" />
/// <reference path="detallepresenter.js" />

/// <reference path="cabecera/cabeceraview.js" />
/// <reference path="cabecera/cabecerapresenter.js" />

/// <reference path="grupos/GruposView.js" />
/// <reference path="grupos/grupospresenter.js" />

/// <reference path="seleccionados/seleccionadosview.js" />
/// <reference path="seleccionados/seleccionadospresenter.js" />

/// <reference path="../../estrategiaagregar/estrategiaagregar.js" />
/// <reference path="../../estrategiaagregar/estrategiaagregarprovider.js" />

var armaTuPackDetalleEvents = ArmaTuPackDetalleEvents();

var armaTuPackProvider = ArmaTuPackProvider();
var generalModule = GeneralModule;
var analyticsPortalModule = AnalyticsPortalModule;

var detallePresenter = DetallePresenter({
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});

var cabeceraView = CabeceraView({});
var cabeceraPresenter = CabeceraPresenter({
    cabeceraView: cabeceraView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents
});
//cabeceraView.setPresenter(cabeceraPresenter);

var gruposView = GruposView({
    generalModule: generalModule,
    gruposContainerId: "#grupos"
});
var gruposPresenter = GruposPresenter({
    gruposView: gruposView,
    armaTuPackProvider: armaTuPackProvider,
    generalModule: generalModule,
    armaTuPackDetalleEvents: armaTuPackDetalleEvents,
    analyticsPortalModule: analyticsPortalModule
});
gruposView.setPresenter(gruposPresenter);

var seleccionadosView = SeleccionadosView({
    seleccionadosContainerId: "#seleccionados"
});
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
    cabeceraPresenter.onGruposLoaded(packComponents);
    gruposPresenter.onGruposLoaded(packComponents);
    seleccionadosPresenter.onGruposLoaded(packComponents);
});

armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, function (packComponents) {
    gruposPresenter.onSelectedComponentsChanged(packComponents);
    seleccionadosPresenter.onSelectedComponentsChanged(packComponents);
});

armaTuPackDetalleEvents.subscribe(armaTuPackDetalleEvents.eventName.onShowWarnings, function (packComponents) {
    gruposPresenter.onShowWarnings(packComponents);
});