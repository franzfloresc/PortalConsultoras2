/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />
/// <reference path="../../shared/analyticsportal.js" />

var detalleEstrategia = DetalleEstrategiaProvider;
var fichaResponsiveEvents = FichaResponsiveEvents();
var analyticsPortal = AnalyticsPortalModule;

var estrategiaView = EstrategiaView();
var estrategiaPresenter = EstrategiaPresenter({
    estrategiaView: estrategiaView,
    generalModule: GeneralModule,
    fichaResponsiveEvents: fichaResponsiveEvents
});

var componentesView = ComponentesView();
var componentesPresenter = ComponentesPresenter({
    componentesView: componentesView,
    analyticsPortal : analyticsPortal
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
    estrategiaView.clearContainer();
    componentesView.clearContainer();
    
    var estrategia = detalleEstrategia.getEstrategia(params);

    $("#data-estrategia").data("estrategia", estrategia);

    estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
    componentesPresenter.onEstrategiaModelLoaded(estrategia);
    fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(estrategia);
});