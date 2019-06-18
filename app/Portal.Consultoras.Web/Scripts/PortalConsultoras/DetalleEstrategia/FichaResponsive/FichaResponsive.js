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

$(document).ready(function () {
    try {
        fichaResponsiveEvents.applyChanges(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded);
    } catch (e) {
        GeneralModule.redirectTo('/Ofertas', true);
    }
});

fichaResponsiveEvents.subscribe(fichaResponsiveEvents.eventName.onFichaResponsiveLoaded, function () {
    try {
        estrategiaPresenter.cleanContainer();
        componentesPresenter.cleanContainer();

        var estrategia = detalleEstrategia.promiseGetEstrategia(params);
        if (estrategia.Error) GeneralModule.redirectTo('/Ofertas', true);

        $("#data-estrategia").data("estrategia", estrategia);

        estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
        componentesPresenter.onEstrategiaModelLoaded(estrategia);

        fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(estrategia);

        const carruselModelUpselling = new CarruselModel(
            params.palanca,
            params.campania,
            params.cuv,
            "/Estrategia/FichaObtenerProductosUpSellingCarrusel",
            params.origen,
            estrategia.OrigenAgregarCarrusel,
            estrategia.DescripcionCompleta,
            estrategia.CodigoProducto,
            estrategia.Precio2,
            estrategia.Hermanos,
            estrategia.TieneStock,
            ConstantesModule.TipoVentaIncremental.UpSelling);
        const carruselPresenterUpselling = new CarruselPresenter();
        const carruselViewUpselling = new CarruselView(carruselPresenterUpselling);
        carruselPresenterUpselling.initialize(carruselModelUpselling, carruselViewUpselling);

        const carruselModelCross = new CarruselModel(
            params.palanca,
            params.campania,
            params.cuv,
            "/Estrategia/FichaObtenerProductosIncremental",
            params.origen,
            estrategia.OrigenAgregarCarrusel,
            estrategia.DescripcionCompleta,
            estrategia.CodigoProducto,
            estrategia.Precio2,
            estrategia.Hermanos,
            estrategia.TieneStock,
            ConstantesModule.TipoVentaIncremental.CrossSelling);
        const carruselPresenterCross = new CarruselPresenter();
        const carruselViewCross = new CarruselView(carruselPresenterCross);
        carruselPresenterCross.initialize(carruselModelCross, carruselViewCross);

        const carruselModelSugerido = new CarruselModel(
            params.palanca,
            params.campania,
            params.cuv,
            "/Estrategia/FichaObtenerProductosIncremental",
            params.origen,
            estrategia.OrigenAgregarCarrusel,
            estrategia.DescripcionCompleta,
            estrategia.CodigoProducto,
            estrategia.Precio2,
            estrategia.Hermanos,
            estrategia.TieneStock,
            ConstantesModule.TipoVentaIncremental.Sugerido);
        const carruselPresenterSugerido = new CarruselPresenter();
        const carruselViewSugerido = new CarruselView(carruselPresenterSugerido);
        carruselPresenterSugerido.initialize(carruselModelSugerido, carruselViewSugerido);
    }
    catch (error) {
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