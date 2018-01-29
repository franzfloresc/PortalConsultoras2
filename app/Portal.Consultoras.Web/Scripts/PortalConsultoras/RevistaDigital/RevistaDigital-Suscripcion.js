
$(document).ready(function () {

    var clickabrir = 1

    if (isMobile()) {

        var saber_mas = 1;
        $("a.btn-suscribete-video-baja").click(function () {
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
            var alto = $("#new-header").height();

            var link = $(this);
            var anchor = link.attr("href");
            page.stop().animate({ scrollTop: ScrollUser(anchor, alto) }, 1000);

        });
        var offS = $(".como-funciona").offset();
        var anchor_offset = 0;
        if (offS != undefined) {
            var anchor_offset = offS.top;
        }

        $(window).on("scroll", function () {
            if ($(window).scrollTop() > anchor_offset) {
                $("a.btn-suscribete-video-baja").css("display", "none");
            }
            else {
                $("a.btn-suscribete-video-baja").css("display", "block");
            }
        });

        $(".preguntas-frecuentes-cont-sus ul.preg-frecuentes li a.abrir-preg-frecuente").click(function () {
            $(".preguntas-frecuentes-cont-sus ul.preg-frecuentes ul").slideToggle();

            if (clickabrir == 1) {
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.despliegue").css("display", "none");
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.nodespliegue").css("display", "block");
                clickabrir = 0;
            }
            else {
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.nodespliegue").css("display", "none");
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.despliegue").css("display", "block");
                clickabrir = 1;
            }
        });
    }
    else {

        $(".preguntas-frecuentes-cont-sus ul.preg-frecuentes li:has(ul)").click(function () {
            $(this).find("ul").slideToggle();
            if (clickabrir == 1) {
                $(this).find("span.despliegue").css("display", "none");
                $(this).find("span.nodespliegue").css("display", "block");
                clickabrir = 0;
            }
            else {
                $(this).find("span.despliegue").css("display", "block");
                $(this).find("span.nodespliegue").css("display", "none");
                clickabrir = 1;
            }
        });
    }
    
   

});
 window.onYouTubePlayerAPIReady = function () {
    player = new YT.Player("player", {
        width: "640",
        height: "390",
        enablejsapi: 1,
        fs: 0,
        showinfo: 0,
        modestbranding: 1,
        loop:1,
        videoId: videoKey,
        playerVars: {
            autoplay: 1,
            rel: 0
        },
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
        $("a.btn-suscribete-video").animate({
            bottom: "0%"
        });
        $("a.btn-suscribete-video-baja").animate({
            bottom: "-100%"
        });
        $("#div-suscribite").hide();
    }
    if (event.data == YT.PlayerState.PLAYING && !done) {
        rdAnalyticsModule.CompartirProducto("YTI", player.getVideoUrl(), "");
        done = true;
    }
}

function ScrollUser(anchor, alto) {

    if ($("#seccion-fixed-menu").position.top > 0)
        alto = alto + $("#seccion-fixed-menu").height() + 10;

    return jQuery(anchor).offset().top - alto;
}

function RDPopupCerrar() {
    
    AbrirLoad();
    rdAnalyticsModule.CerrarPopUp("Enterate");
    $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/PopupCerrar",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            CerrarLoad();
            //window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDPopupMobileCerrar() {

    AbrirLoad();

    rdAnalyticsModule.CerrarPopUp("ConfirmarDatos");

    $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/PopupCerrar",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            CerrarLoad();
            window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDSuscripcion() {

    AbrirLoad();
    rdAnalyticsModule.Inscripcion();

    var rdSuscriocionPromise = RDSuscripcionPromise();
    rdSuscriocionPromise.then(
        function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (!data.success) {
                AbrirMensaje(data.message);
                return false;
            }
            rdAnalyticsModule.SuscripcionExistosa();

            //
            $("#PopRDSuscripcion").css("display", "block");

            $(".popup_confirmacion_datos .form-datos input").keyup(); //to update button style

            return false;
        },
        function (xhr, status, error) {
            CerrarLoad();
            console.log(xhr.responseText);
        }
    );
}

function RDSuscripcionPromise() {
    var d = $.Deferred();

    var promise = $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/Suscripcion",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: true
    });

    promise.done(function (response) {
        d.resolve(response);
    })

    promise.fail(d.reject);

    return d.promise();
}

function RDDesuscripcion() {
    AbrirLoad();
    rdAnalyticsModule.CancelarSuscripcion();
    $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/Desuscripcion",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
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

function RDRedireccionarInformacion(seccion) {
    RDPopupCerrar();
    seccion = seccion || 0;
    rdAnalyticsModule.IrEnterate();
    
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
    var win = window.open(urlTerminosCondicionesRD, "_blank");
    if (win) {
        //Browser has allowed it to be opened
        win.focus();
    } else {
        //Browser has blocked it
        console.log("Habilitar mostrar popup");
    }
}

function RedireccionarContenedorComprar(origenWeb, codigo) {
    origenWeb = $.trim(origenWeb);
    if (origenWeb !== "")
        rdAnalyticsModule.Access(origenWeb);

    codigo = $.trim(codigo);
    window.location = (isMobile() ? "/Mobile" : "") + "/Ofertas" + (codigo !== "" ? "#" + codigo : "");
}