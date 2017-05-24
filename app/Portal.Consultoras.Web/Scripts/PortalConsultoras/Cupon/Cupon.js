$(document).ready(function () {
    "use strict"
    
    var _mostrarPopupCuponGanaste = ((typeof mostrarPopupCuponGanaste != 'undefined') ? mostrarPopupCuponGanaste.toLowerCase() == "true" : false);
    var objInitializer = {
        tieneCupon: tieneCupon,
        paginaOrigenCupon: paginaOrigenCupon,
        esEmailActivo: esEmailActivo,
        baseUrl: baseUrl,
        simboloMoneda: viewBagSimbolo,
        campaniaActual: viewBagCampaniaActual,
        paisISO: paisISO,
        ambiente: viewBagAmbiente
    };

    cuponModule.ini(objInitializer);
    cuponModule.obtenerCupon();
    if (_mostrarPopupCuponGanaste) {
        cuponModule.mostrarPopupGanaste();
    }
});