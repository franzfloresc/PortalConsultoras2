$(document).ready(function () {
    var contadorbottomgnd = 1;
    $('.revistagnd').click(function () {
        // $('nav').toggle();

        if (contadorbottomgnd == 1) {
            $('.revistagnd').animate({
                bottom: '0'
            });
            contadorbottomgnd = 0;
        } else {
            contadorbottomgnd = 1;
            $('.revistagnd').animate({
                bottom: '-132px'
            });
        }

    });

    mostrarImagenPortadaRevista(campaniaId);
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