$(document).ready(function () {
    $("#tituloGuiaNegocioFloteante").html("REVISTA C-" + campaniaId.toString().substring(4, 6));

    if (origenPedidoWebEstrategia == 2811) {
        $("#marca").css("z-index", "-100");
        $(".CMXD-btn-help").css("z-index", "-100");
    }

    mostrarImagenPortadaRevista(campaniaId);

    $("#btnVerGuiaNegocio").click(function () {
        $("#campaniaRevista").val(campaniaId);
        $("#frmGuiaNegocio").submit();
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
    var contadorgnddesktop = 1;
    $(".desplegablegnd .gndcontenido .nrognd").click(function () {
        $(".contenedorgnd").slideToggle("slow");
        if (contadorgnddesktop === 1) {
            $(".desplegablegnd .gndcontenido .nrognd .flechitagnd img").css("transform", "rotate(0deg)");

            contadorgnddesktop = 0;
        } else {
            contadorgnddesktop = 1;
            $(".desplegablegnd .gndcontenido .nrognd .flechitagnd img").css("transform", "rotate(180deg)");
        }
    });
}

function getUrlImagenPortadaRevistaPromise(codigoCampania) {
    var defered = jQuery.Deferred();
    var data = JSON.stringify({
        codigoRevista: RevistaCodigoIssuu[codigoCampania]
    });
    jQuery.ajax({
        type: "POST",
        url: urlObtenerPortadaRevista,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
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