﻿
$(document).ready(function () {

    var clickabrir = 1

    if (isMobile()) {

        var saber_mas = 1;
        $('a.btn-suscribete-video-baja').click(function () {
            if (saber_mas == 1) {
                $("a.btn-suscribete-video-baja").attr("href", "#saber-mas-uno");
                saber_mas = 2;
            }
            else if (saber_mas == 2) {
                $("a.btn-suscribete-video-baja").attr("href", "#saber-mas-dos");
                saber_mas = 3;
            }
            else if (saber_mas == 3) {
                $("a.btn-suscribete-video-baja").attr("href", "#saber-mas-tres");
                saber_mas = 1;
            }

            var page = $("html, body");
            var alto = $('#new-header').height();

            var link = $(this);
            var anchor = link.attr('href');
            page.stop().animate({ scrollTop: ScrollUser(anchor, alto) }, 1000);

        });
        var offS = $('.como-funciona').offset();
        var anchor_offset = 0;
        if (offS != undefined) {
            var anchor_offset = offS.top;
        }

        $(window).on('scroll', function () {
            if ($(window).scrollTop() > anchor_offset) {
                $("a.btn-suscribete-video-baja").css("display", "none");
            }
            else {
                $("a.btn-suscribete-video-baja").css("display", "block");
            }
        });

        $('.preguntas-frecuentes-cont-sus ul.preg-frecuentes li a.abrir-preg-frecuente').click(function () {
            $('.preguntas-frecuentes-cont-sus ul.preg-frecuentes ul').slideToggle();

            if (clickabrir == 1) {
                $('.preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.despliegue').css("display", "none");
                $('.preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.nodespliegue').css("display", "block");
                clickabrir = 0;
            }
            else {
                $('.preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.nodespliegue').css("display", "none");
                $('.preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.despliegue').css("display", "block");
                clickabrir = 1;
            }
        });
    }
    else {

        $('.preguntas-frecuentes-cont-sus ul.preg-frecuentes li:has(ul)').click(function () {
            $(this).find('ul').slideToggle();
            if (clickabrir == 1) {
                $(this).find('span.despliegue').css("display", "none");
                $(this).find('span.nodespliegue').css("display", "block");
                clickabrir = 0;
            }
            else {
                $(this).find('span.despliegue').css("display", "block");
                $(this).find('span.nodespliegue').css("display", "none");
                clickabrir = 1;
            }
        });
    }

});

function onYouTubePlayerAPIReady() {
    player = new YT.Player('player', {
        width: '640',
        height: '390',
        rel: 0,
        fs: 0,
        videoId: videoKey,
        events: {
            onReady: onScrollDown,
            onStateChange: onPlayerStateChange
        }
    });
}

function onScrollDown(event) {
    $(window).scroll(function () {
        var windowHeight = $(window).scrollTop();
        var contenido2 = $("#saber-mas-uno").offset();
        contenido2 = contenido2.top;

        if (windowHeight >= contenido2) {
            event.target.pauseVideo();
        }
    });
}

// when video ends
function onPlayerStateChange(event) {
    if (event.data === 0 && estaSuscrita === "False") {
        $('a.btn-suscribete-video').animate({
            bottom: '0%'
        });
        $('a.btn-suscribete-video-baja').animate({
            bottom: '-100%'
        });
        $("#div-suscribite").hide();
    }
}

function ScrollUser(anchor, alto) {

    if ($('#seccion-fixed-menu').position.top > 0)
        alto = alto + $('#seccion-fixed-menu').height() + 10;

    return jQuery(anchor).offset().top - alto;
}

function RDPopupCerrar() {
    AbrirLoad();

    rdAnalyticsModule.CerrarPopUp('Banner Inscribirme a Ésika para mí');

    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/PopupCerrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDSuscripcion() {

    AbrirLoad();
    rdAnalyticsModule.Inscripcion();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Suscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            rdAnalyticsModule.SuscripcionExistosa();
            window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDDesuscripcion() {
    AbrirLoad();
    rdAnalyticsModule.CancelarSuscripcion();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Desuscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDPopupNoVolverMostrar() {
    rdAnalyticsModule.CerrarPopUp('Banner Inscribirme a Ésika para mí');
    CerrarPopup("#PopRDSuscripcion");
    AbrirLoad();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/PopupNoVolverMostrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDRedireccionarInformacion(seccion) {
    seccion = seccion || 0;
    rdAnalyticsModule.IrCancelarSuscripcion();
    var url = (isMobile() ? "/Mobile" : "") + "/RevistaDigital/Informacion";

    if (seccion == 2) url += "?tipo=" + seccion;

    var urlLocal = $.trim(window.location).toLowerCase() + "/";
    window.location = url;
    if (urlLocal.indexOf("/revistadigital//Informacion/") >= 0) {
        window.location.reload();
    }
}

function RDRedireccionarDetalle(event) {
    var obj = EstrategiaObtenerObj(event);
    EstrategiaGuardarTemporal(obj);
    var url = ((isMobile() ? "/Mobile" : "") + "/RevistaDigital/Detalle");
    window.location = url + "?cuv=" + obj.CUV2 + "&campaniaId=" + obj.CampaniaID;
}

function MostrarTerminos() {
    var win = window.open(urlTerminosCondicionesRD, '_blank');
    if (win) {
        //Browser has allowed it to be opened
        win.focus();
    } else {
        //Browser has blocked it
        console.log("Habilitar mostrar popup");
    }
}

function RedireccionarContenedorComprar(origenWeb, codigo) {
    if ($.trim(origenWeb) != "")
        rdAnalyticsModule.Access(origenWeb);

    codigo = $.trim(codigo);
    window.location = (isMobile() ? "/Mobile" : "") + "/Ofertas" + (codigo != "" ? "#" + codigo : "");
}