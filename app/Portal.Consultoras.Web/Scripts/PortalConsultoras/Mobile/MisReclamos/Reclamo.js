$(document).ready(function () {

    $(".mi_solicitud_cdr").click(function (e) {

        e.stopPropagation();

        $(".num_solicitudes").fadeOut(150);

        $(".pestania_ver_mi_solicitud").addClass("crece");

        $(".mi_solicitud_cdr").animate({

            "width": "222px"

        }, 120, function () {

            $(".mi_solicitud_cdr").animate({

                "height": "291px"

            }, 220);

        });

        setTimeout(function () {

            $(".datos_solicitud_opened").fadeIn(200);

        }, 220);

    });

    $("body, .ocultar_mi_solicitud").click(function (e) {

        e.stopPropagation();

        $(".datos_solicitud_opened").fadeOut(200);

        $(".mi_solicitud_cdr").animate({

            "height": "35px"

        }, 220, function () {

            $(".pestania_ver_mi_solicitud").removeClass("crece");

            $(".mi_solicitud_cdr").animate({

                "width": "35px"

            }, 120);

        });

        setTimeout(function () {

            $(".num_solicitudes").fadeIn(200);

        }, 450);

    });

    var alturaListaMiSolicitud = $(document).height();

    $(".enlace_ir_al_final a").click(function (e) {

        e.preventDefault();
        $(".listado_productos_agregados").animate({
            scrollTop: alturaListaMiSolicitud + "px"
        }, 500);

    });

});