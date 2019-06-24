/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="componentes/componentesanalyticspresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />
/// <reference path="../../shared/analyticsportal.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselPresenter.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselModel.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselView.js" />

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

const carruselView = new CarruselView();
const carruselPresenter = new CarruselPresenter();

var estrategia = null;

$(document).ready(function () {
    fichaResponsiveEvents.applyChanges(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded);

    analyticsPortal.MarcaVisualizarDetalleProducto(estrategia);

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

    carruselPresenter.initialize(carruselModel, carruselView);
});

fichaResponsiveEvents.subscribe(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded, function () {
    try {
        estrategiaPresenter.cleanContainer();
        componentesPresenter.cleanContainer();

        estrategia = detalleEstrategia.promiseGetEstrategia(params);

        if (estrategia.Error !== false) {
            GeneralModule.consoleLog(estrategia);
            GeneralModule.redirectTo("ofertas");
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