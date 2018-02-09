var contador = 0;

$(document).ready(function () {
    $('#tituloGuiaNegocioFloteante').html('REVISTA C-' + campaniaId.toString().substring(4,6));

    $('.cerrar-vineta .sbcont span').click(function () {
        if (contador == 1) {
            $('.cont-vineta').animate({
                right: '0'
            });
            $('.cerrar-vineta').animate({
                right: '150px'
            });
            contador = 0;
        } else {
            contador = 1;
            $('.cont-vineta').animate({
                right: '-100%'
            });
            $('.cerrar-vineta').animate({
                right: '0%'
            });
        }
    });

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