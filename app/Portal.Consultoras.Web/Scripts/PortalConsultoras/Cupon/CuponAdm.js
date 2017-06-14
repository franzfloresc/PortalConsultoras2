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
        urlCrearCuponConsultora: urlCrearCuponConsultora,
        urlActualizarCuponConsultora: urlActualizarCuponConsultora,
        urlListarCuponesPorCampania: urlListarCuponesPorCampania,
        urlListarCuponConsultorasPorCupon: urlListarCuponConsultorasPorCupon,
        urlCuponConsultoraCargaMasiva: urlCuponConsultoraCargaMasiva,
        urlImagenEdit: urlImagenEdit,
        urlImagenDelete: urlImagenDelete,
        urlImagenDetail: urlImagenDetail
    };
    
    cuponAdmModule.ini(objInitializerCupon);
});