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
        urlImagenEdit: urlImagenEdit,
        urlListarCuponConsultorasPorCupon: urlListarCuponConsultorasPorCupon,
        urlCuponConsultoraCargaMasiva: urlCuponConsultoraCargaMasiva,
        urlImagenDelete: urlImagenDelete,
        urlImagenDetail: urlImagenDetail,
        urlImagenEnable: urlImagenEnable,
        urlImagenDisable: urlImagenDisable
    };

    cuponAdmModule.ini(objInitializerCupon);
});