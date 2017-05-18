$(document).ready(function () {
    "use strict"

    var cupon = cuponModule;
    var objInitializer = {
        tieneCupon: tieneCupon,
        paginaOrigenCupon: paginaOrigenCupon,
        esEmailActivo: esEmailActivo,
        baseUrl: baseUrl,
        simboloMoneda: viewBagSimbolo,
        campaniaActual: viewBagCampaniaActual
    };

    cupon.ini(objInitializer);
    cupon.obtenerCupon();
});