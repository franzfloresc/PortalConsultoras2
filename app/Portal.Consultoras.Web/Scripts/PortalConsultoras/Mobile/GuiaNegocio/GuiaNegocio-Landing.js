$(document).ready(function () {
    $('.nro').html('REVISTA C-' + campaniaId.toString().substring(4, 6));

    var alturacontgnd = $('.revistagnd .contrevistagnd').height();
    var contadorbottomgnd = 1;
    $('.revistagnd').css("bottom", '-' + alturacontgnd + 'px');
    $('.nrorevista').click(function () {
        // $('nav').toggle();

        if (contadorbottomgnd == 1) {
            $('.revistagnd').animate({
                bottom: '0'
            });
            contadorbottomgnd = 0;
        } else {
            contadorbottomgnd = 1;
            $('.revistagnd').animate({
                bottom: '-' + alturacontgnd + 'px'
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