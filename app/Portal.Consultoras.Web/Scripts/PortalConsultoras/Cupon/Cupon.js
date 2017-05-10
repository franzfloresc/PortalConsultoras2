$(document).ready(function () {
    "use strict"

    var cupon = cuponModule;
    cupon.ini({ tieneCupon: tieneCupon, paginaOrigenCupon: paginaOrigenCupon, esEmailActivo: esEmailActivo, baseUrl: baseUrl, simboloMoneda: viewBagSimbolo });
    cupon.obtenerCupon();
});