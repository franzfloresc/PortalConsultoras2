$(document).ready(function () {
    "use strict"

    var objInitializerCampania = {
        urlListarCampanias: urlListarCampanias
    };

    campaniaModule.ini(objInitializerCampania);

    var objInitializerCupon = {
        urlListarCampanias: urlListarCampanias,
        urlCrearCupon: urlCrearCupon,
        urlActualizarCupon: urlActualizarCupon,
        urlListarCuponesPorCampania: urlListarCuponesPorCampania,
        urlListarCuponConsultorasPorCupon: urlListarCuponConsultorasPorCupon,
        urlImagenEdit: urlImagenEdit
    };
    
    cuponAdmModule.ini(objInitializerCupon);
});