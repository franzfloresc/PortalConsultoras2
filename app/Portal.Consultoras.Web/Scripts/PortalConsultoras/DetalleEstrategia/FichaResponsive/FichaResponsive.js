﻿/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="componentes/componentesanalyticspresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />
/// <reference path="../../shared/analyticsportal.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselPresenter.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselModel.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselView.js" />

console.log(1);
var detalleEstrategia = DetalleEstrategiaProvider;
var fichaResponsiveEvents = FichaResponsiveEvents();
var analyticsPortal = AnalyticsPortalModule;

var estrategiaView = EstrategiaView();
var estrategiaPresenter = EstrategiaPresenter({
    estrategiaView: estrategiaView,
    generalModule: GeneralModule,
    fichaResponsiveEvents: fichaResponsiveEvents
});

var componentesAnalyticsPresenter = ComponentesAnalyticsPresenter({
    analyticsPortal: analyticsPortal
});

var componentesView = ComponentesView();
var componentesPresenter = ComponentesPresenter({
    componentesView: componentesView,
    componentesAnalyticsPresenter: componentesAnalyticsPresenter
});
componentesView.setPresenter(componentesPresenter);

var fichaEnriquecidaView = FichaEnriquecidaView();
var fichaEnriquecidaPresenter = FichaEnriquecidaPresenter({
    fichaEnriquecidaView: fichaEnriquecidaView
});

$(document).ready(function () {
    fichaResponsiveEvents.applyChanges(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded);
});

fichaResponsiveEvents.subscribe(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded, function(){
    estrategiaPresenter.cleanContainer();
    componentesPresenter.cleanContainer();
    
    var estrategia = detalleEstrategia.promiseGetEstrategia(params);

    $("#data-estrategia").data("estrategia", estrategia);

    estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
    componentesPresenter.onEstrategiaModelLoaded(estrategia);

    fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(estrategia);

    const carruselModel = new CarruselModel(
        params.palanca,
        params.campania,
        params.cuv,
        "/Estrategia/FichaObtenerProductosUpSellingCarrusel",
        params.origen,
        estrategia.OrigenAgregarCarrusel,
        "Ficha",
        estrategia.DescripcionCompleta,
        estrategia.Hermanos.length,
        estrategia.CodigoProducto,
        estrategia.Precio2,
        estrategia.Hermanos,
        estrategia.TieneStock);

    const carruselPresenter = new CarruselPresenter();

    const carruselView = new CarruselView(carruselPresenter);

    carruselPresenter.initialize(carruselModel, carruselView);
});