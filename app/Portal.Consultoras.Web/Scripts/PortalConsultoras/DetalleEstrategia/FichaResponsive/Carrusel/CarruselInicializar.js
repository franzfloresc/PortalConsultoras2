"use strict";

class CarruselInicializar {
    constructor() {
    }

    crearCarruseles(params, estrategia) {
        const carruselModelUpselling = new CarruselModel(
            params.palanca,
            params.campania,
            params.cuv,
            params.urlUpSelling,
            params.origen,
            estrategia.OrigenAgregarCarrusel,
            estrategia.DescripcionCompleta,
            estrategia.Hermanos,
            estrategia.TieneStock,
            ConstantesModule.TipoVentaIncremental.UpSelling,
            estrategia.CodigoProducto,
            estrategia.Precio2);
        const carruselPresenterUpselling = new CarruselPresenter();
        const carruselViewUpselling = new CarruselView(carruselPresenterUpselling);
        carruselPresenterUpselling.initialize(carruselModelUpselling, carruselViewUpselling);

        const carruselModelCross = new CarruselModel(
            params.palanca,
            params.campania,
            params.cuv,
            params.urlIncremental,
            params.origen,
            estrategia.OrigenAgregarCarrusel,
            estrategia.DescripcionCompleta,
            estrategia.Hermanos,
            estrategia.TieneStock,
            ConstantesModule.TipoVentaIncremental.CrossSelling,
            estrategia.CodigoProducto,
            estrategia.Precio2);
        const carruselPresenterCross = new CarruselPresenter();
        const carruselViewCross = new CarruselView(carruselPresenterCross);
        carruselPresenterCross.initialize(carruselModelCross, carruselViewCross);

        const carruselModelSugerido = new CarruselModel(
            params.palanca,
            params.campania,
            params.cuv,
            params.urlIncremental,
            params.origen,
            estrategia.OrigenAgregarCarrusel,
            estrategia.DescripcionCompleta,
            estrategia.Hermanos,
            estrategia.TieneStock,
            ConstantesModule.TipoVentaIncremental.Sugerido,
            estrategia.CodigoProducto,
            estrategia.Precio2);
        const carruselPresenterSugerido = new CarruselPresenter();
        const carruselViewSugerido = new CarruselView(carruselPresenterSugerido);
        carruselPresenterSugerido.initialize(carruselModelSugerido, carruselViewSugerido);
    }
}