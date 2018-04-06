$(document).ready(function () {
    $('#tituloGuiaNegocioFloteante').html('REVISTA C-' + campaniaId.toString().substring(4, 6));

    mostrarImagenPortadaRevista(campaniaId);

    $('#btnVerGuiaNegocio').click(function () {
        $('#campaniaRevista').val(campaniaId);
        $('#frmGuiaNegocio').submit();
    });

});

function mostrarImagenPortadaRevista(codigoCampania) {
    var promise = getUrlImagenPortadaRevistaPromise(codigoCampania);
    $.when(promise).done(function (promiseResult) {
        if (checkTimeout(promiseResult)) {
            var urlImagen = promiseResult || defaultImageRevista;
            $("#imgPortadaRevista").attr("src", urlImagen);
        }

        GNDMostrarIssu();

    });
}

function GNDMostrarIssu() {
    var imgfake = "revista_no_disponible";

    var alturaimggnd = $('.desplegablegnd .gndcontenido .contenedorgnd .portadagnd img').height();
    var alturacontenedorgnd = alturaimggnd + 30;
    var alturanrognd = $('.desplegablegnd .gndcontenido .nrognd').height();

    $('.desplegablegnd .gndcontenido .contenedorgnd').css("height", alturacontenedorgnd);

    $('.desplegablegnd .gndcontenido .contenedorgnd .infognd .continfognd').css("height", alturaimggnd);

    var esconderparaanimaciongnd = alturacontenedorgnd + 1;
    $('.desplegablegnd').css("bottom", -esconderparaanimaciongnd);

    var contadorgnddesktop = 1;

    $('.desplegablegnd .gndcontenido .nrognd').click(function () {
        if (contadorgnddesktop == 1) {
            $('.desplegablegnd').animate({
                bottom: '0'
            });
            $('.desplegablegnd .gndcontenido .nrognd .flechitagnd img').css('transform', 'rotate(0deg)');

            contadorgnddesktop = 0;
        } else {
            contadorgnddesktop = 1;
            $('.desplegablegnd').animate({
                bottom: -esconderparaanimaciongnd
            });
            $('.desplegablegnd .gndcontenido .nrognd .flechitagnd img').css('transform', 'rotate(180deg)');
        }
    });
}

function getUrlImagenPortadaRevistaPromise(codigoCampania) {

    var defered = jQuery.Deferred();

    var data = JSON.stringify({
        codigoRevista: RevistaCodigoIssuu[codigoCampania]
    });
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerPortadaRevista,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: data,
        success: function (response) {
            defered.resolve(response);
        },
        error: function () {
            defered.resolve(defaultImageRevista);
        }
    });

    return defered.promise();
}