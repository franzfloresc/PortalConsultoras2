/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselPresenter.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselModel.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselView.js" />

var detalleEstrategia = DetalleEstrategiaProvider;
var fichaResponsiveEvents = FichaResponsiveEvents();

var estrategiaView = EstrategiaView();
var estrategiaPresenter = EstrategiaPresenter({
    estrategiaView: estrategiaView,
    generalModule: GeneralModule,
    fichaResponsiveEvents: fichaResponsiveEvents
});

var componentesView = ComponentesView();
var componentesPresenter = ComponentesPresenter({
    componentesView: componentesView
});
componentesView.setPresenter(componentesPresenter);

var fichaEnriquecidaView = FichaEnriquecidaView();
var fichaEnriquecidaPresenter = FichaEnriquecidaPresenter({
    fichaEnriquecidaView: fichaEnriquecidaView
});

$(document).ready(function () {
    $("#data-estrategia").data("estrategia", detalleEstrategia.getEstrategia(params));
    var estrategia = $("#data-estrategia").data("estrategia");

    estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
    componentesPresenter.onEstrategiaModelLoaded(estrategia);

    fichaEnriquecidaPresenter.onFichaResponsiveModelLoaded(estrategia);
    let carruselModel = new CarruselModel(
        params.palanca,
        params.campania,
        params.cuv,
       "/Estrategia/FichaObtenerProductosUpSellingCarrusel",
        params.origen,
        "Ficha",
        estrategia.DescripcionCompleta,
        estrategia.Hermanos.length,
        estrategia.CodigoProducto,
        estrategia.Precio2,
        estrategia.Hermanos);
    let carruselPresenter = new CarruselPresenter();

    let carruselView = new CarruselView(carruselPresenter);

    carruselPresenter.initialize(carruselModel, carruselView);
});