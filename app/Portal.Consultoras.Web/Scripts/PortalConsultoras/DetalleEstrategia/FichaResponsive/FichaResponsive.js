/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="componentes/componentesanalyticspresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />
/// <reference path="../../shared/analyticsportal.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselInicializar.js" />

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

var estrategia = {};

$(document).ready(function () {
    try {
        fichaResponsiveEvents.applyChanges(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded);
        analyticsPortal.MarcaVisualizarDetalleProducto(estrategia);

        let carruselInicializar = new CarruselInicializar();
        carruselInicializar.crearCarruseles(params, estrategia);
    } catch (e) {
        GeneralModule.redirectTo('/Ofertas', true);
    }
});

fichaResponsiveEvents.subscribe(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded, function () {
    try {
        estrategiaPresenter.cleanContainer();
        componentesPresenter.cleanContainer();

    	estrategia = detalleEstrategia.promiseGetEstrategia(params);
        if (estrategia.Error){  
            GeneralModule.consoleLog(estrategia);
            GeneralModule.redirectTo('/Ofertas', true);
        }

        $("#data-estrategia").data("estrategia", estrategia);

        estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
        componentesPresenter.onEstrategiaModelLoaded(estrategia);

        fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(estrategia);
    }
    catch (error) {
        GeneralModule.consoleLog(error);
        if (typeof error === "string") {
            window.onerror(error);
        }
        else if (typeof error === "object") {
            registrarLogErrorElastic(error);
        }
        GeneralModule.redirectTo("ofertas");
    }

    CerrarLoad();
});