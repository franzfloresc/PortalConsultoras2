﻿var vpromotions = [];
var vpromotionsTagged = [];
var arrayOfertasParaTi = [];
var arrayLiquidaciones = [];
var numImagen = 1;
var fnMovimientoTutorial;
/* SB20-834 - INICIO */
var origenPedidoWebEstrategia = 0;
var showViewVideo = viewBagVioVideo;
var closeComunicadosPopup = false;
/* SB20-834 - FIN */
var fotoCroppie;
var tipoOrigen = '3';

$(document).ready(function () {

    $('.contenedor_img_perfil').on('click', CargarCamara);
    $('#imgFotoUsuario').error(function() {
        $('#imgFotoUsuario').hide();
        $('#imgFotoUsuarioDefault').show();
    })

    $('#salvavidaTutorial').show();

    $(".abrir_tutorial").click(function () {
        abrir_popup_tutorial(true);
    });
    $(".cerrar_tutorial").click(function () {
        cerrar_popup_tutorial();
    });

    // Evento para visualizar video introductorio al hacer click
    $(".ver_video_introductorio").click(function () {
        $('#fondoComunPopUp').show();
        contadorFondoPopUp++;
        $('#videoIntroductorio').fadeIn(function () {
            $("#videoIntroductorio").delay(200);
            $("#videoIntroductorio").fadeIn(function () {
                playVideo();
            });
        });
    });

    document.onkeydown = function (evt) {
        evt = evt || window.event;
        if (evt.keyCode == 27) {
            if ($('#popup_tutorial_home').is(':visible')) {
                cerrar_popup_tutorial();
            }
            if ($('#videoIntroductorio').is(':visible')) {
                if (primeraVezVideo) {
                    abrir_popup_tutorial();
                }
                stopVideo();
                $('#videoIntroductorio').hide();
                if (contadorFondoPopUp == 1) {
                    $("#fondoComunPopUp").hide();
                }
                contadorFondoPopUp--;
                return false;
            }
            /* SB20-834 - INICIO */
            if ($('#popupComunicados').is(':visible')) {
                $('#popupComunicados').hide();
                closeComunicadosPopup = true;
            }
            /* SB20-834 - FIN */
        }
    };

    // Intervalo Microefecto Flecha Scroll
    setInterval(animacionFlechaScroll, 1000);

    // Funcion para cambiar background según posicion de scroll
    $(window).scroll(function () {

        if ($(window).scrollTop() + $(window).height() == $(document).height()) {

            $(".flecha_scroll").animate({
                opacity: 0
            }, 100, 'swing', function () {
                $(".flecha_scroll a").addClass("flecha_scroll_arriba");
                $(".flecha_scroll").delay(100);
                $(".flecha_scroll").animate({
                    opacity: 1
                }, 100, 'swing');
            });


        } else {

            $(".flecha_scroll a").removeClass("flecha_scroll_arriba");

        }

    });

    // Evento click que ocurre en la flecha scroll
    $(".flecha_scroll").on('click', function (e) {

        e.preventDefault();
        var posicion = $(window).scrollTop();
        if (posicion + $(window).height() == $(document).height()) {

            $('html, body').animate({
                scrollTop: $('html, body').offset().top
            }, 1000, 'swing');

        } else {

            $('html, body').animate({
                scrollTop: posicion + 700
            }, 1000, 'swing');

        }

    });

    /* SB20-834 - INICIO */
    ObtenerComunicadosPopup();    

    $('body').bind('resize', '.popup_comunicados', function (e) {
        //centrarComunicadoPopup($(this).attr('id'));

        //if ($.trim($('#popupComunicados').html()) != "") {
        //    $('#popupComunicados').show();
        //}
    });
    /* SB20-834 - FIN */
       
    mostrarVideoIntroductorio();
    CrearDialogs();
    CargarCarouselEstrategias("");
    CargarCarouselLiquidaciones();
    CargarPopupsConsultora();
    CargarMisCursos();
    CargarBanners();
    CargarCatalogoPersonalizado();

    $("#btnCambiarContrasenaMD").click(function () { CambiarContrasenia(); });
    $("#btnActualizarMD").click(function () { ActualizarMD(); });
    $("#btnActualizarDatos").click(function () {
        ActualizarDatos();
        return false;
    });

    $("#btnCerrarActualizarDatos").click(function () {
        CerrarPopupActualizacionDatos();
        return false;
    });
    $("#btnActualizarDatosMexico").click(function () {
        ActualizarDatosMexico();
        return false;
    });
    $("#btnCerrarActualizarDatosMexico").click(function () {
        CerrarPopupActualizacionDatosMexico();
        return false;
    });
    
    $("#cerrarVideoIntroductorio").click(function () {
        if (primeraVezVideo) {
            abrir_popup_tutorial();
            //setInterval(AnimacionTutorial, 800);
            //setTimeout(ocultarAnimacionTutorial, 9000);
        }
        stopVideo();
        $('#videoIntroductorio').hide();
        if (contadorFondoPopUp == 1) {
            $("#fondoComunPopUp").hide();
        }
        contadorFondoPopUp--;
        viewBagVioVideo = 1;
        mostrarComunicadosPopup();
        return false;
    });

    $("#cerrarAceptacionContrato").click(function () {
        $('#popupAceptacionContrato').hide();
        if (contadorFondoPopUp == 1) {
            $("#fondoComunPopUp").hide();
        }
        contadorFondoPopUp--;
        return false;
    });

    $("#cerrarInvitacionFlexipago").click(function () {
        $('#popupInvitaionFlexipago').hide();
        if (contadorFondoPopUp == 1) {
            $("#fondoComunPopUp").hide();
        }
        contadorFondoPopUp--;
        return false;
    });
    $("#abrirPopupMisDatos").click(function () {
        if (contadorFondoPopUp == 0) {
            $("#fondoComunPopUp").show();
        }
        waitingDialog({});
        CargarMisDatos();
        contadorFondoPopUp++;
        return false;
    });
    $("#cerrarPopupMisDatos").click(function () {
        $('#popupMisDatos').hide();
        if (contadorFondoPopUp == 1) {
            $("#fondoComunPopUp").hide();
        }
        contadorFondoPopUp--;
        return false;
    });
    $('#hrefTerminos').click(function () {
        waitingDialog({});
        DownloadAttachPDFTerminos();
    });
    $('#hrefTerminosMD').click(function () {
        waitingDialog({});
        DownloadAttachContratoActualizarDatos();
    });
    $('#hrefContratoMD').click(function () {
        waitingDialog({});
        DownloadAttachContratoCO();
    });
    $("#btnCancelarMD").click(function () {
        $(".campos_cambiarContrasenia").fadeOut(200);
        $(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
        $(".campos_actualizarDatos").delay(200);
        $(".campos_actualizarDatos").fadeIn(200);
    });

    $("#lnkCambiarContrasena").click(function () {
        if ($("#divCambiarContrasena").is(":visible")) {
            $(".grupo_input_password").slideUp(200);
            $(".popup_actualizarMisDatos").removeClass("incremento_altura");

        } else {
            $(".popup_actualizarMisDatos").addClass("incremento_altura");
            $(".grupo_input_password").slideDown(200);

        }
    });
    $(".misDatosContraseniaEnlace").click(function () {
        if ($(".campos_cambiarContrasenia").is(":visible")) {
            $(".campos_cambiarContrasenia").fadeOut(200);
            $(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
            $(".campos_actualizarDatos").delay(200);
            $(".campos_actualizarDatos").fadeIn(200);

        } else {
            $(".campos_actualizarDatos").fadeOut(200);
            $(".popup_actualizarMisDatos").addClass("incremento_altura_misDatos");
            $(".campos_cambiarContrasenia").delay(200);
            $(".campos_cambiarContrasenia").fadeIn(200);
        }
    });
    $("#txtTelefono, #txtTelefonoMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });
    $("#txtCelular, #txtCelularMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });
    $("#txtEMailMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
            return re.test(keyChar);
        }
    });
    $("#txtSobrenombreMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ _.-]/;
            return re.test(keyChar);
        }
    });

    $(document).on('click', '.js-agregar-liquidacion', function (e) {
        if (ReservadoOEnHorarioRestringido())
            return false;

        if (!$(this).hasClass("no_accionar")) {
            agregarProductoAlCarrito(this);
        }

        var contenedor = $(this).parents(".content_item_carrusel");
        AgregarProductoLiquidacion(contenedor);
    });
    $(document).on('click', '.js-agregar-liquidacion-tallacolor', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

        var contenedor = $(this).parents(".content_item_carrusel");

        var objProducto = {
            imagenProducto: $(contenedor).find(".producto_img_home img").attr("src"),
            tituloMarca: $(contenedor).find('#DescripcionMarca').val(),
            descripcion: $(contenedor).find('#DescripcionProd').val(),
            precio: $(contenedor).find('#PrecioOferta').val(),
            tonosTallas: $(this).attr('data-array-tonostallas'),
            tipoTonoTalla: $(this).attr('tipo-tonotalla')
        };
        var objHidden = {
            MarcaID: $(contenedor).find('#MarcaID').val(),
            PrecioOferta: $(contenedor).find('#PrecioOferta').val(),
            CUV: $(contenedor).find('#CUV').val(),
            ConfiguracionOfertaID: $(contenedor).find('#ConfiguracionOfertaID').val(),
            DescripcionProd: $(contenedor).find('#DescripcionProd').val(),
            DescripcionMarca: $(contenedor).find('#DescripcionMarca').val(),
            DescripcionCategoria: $(contenedor).find('#DescripcionCategoria').val(),
            DescripcionEstrategia: $(contenedor).find('#DescripcionEstrategia').val(),
            ImagenProducto: $(contenedor).find(".producto_img_home img").attr("src"),
            Posicion: $(contenedor).find("#Posicion").val()
        };

        CargarProductoLiquidacionPopup(objProducto, objHidden);
    });
    $(document).on('click', '.js-agregar-popup-liquidacion', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

        var contenedor = $(this).parents('#divTonosTallas');
        AgregarProductoLiquidacion(contenedor);
    });
    $(document).on('click', '.btn_cerrar_escogerTono', function () {
        HidePopupTonosTallas();
    });
    $(document).on('change', '#ddlTallaColorLiq', function () {
        CambiarTonoTalla($(this));
    });

    //$(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
    //    if (ReservadoOEnHorarioRestringido())
    //        return false;

    //    var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
    //    AgregarProductoCatalogoPersonalizado(contenedor);
    //});

    $(document).on('click', '.miCurso', function () {
        var id = $(this)[0].id;
        GetCursoMarquesina(id)
    });
    //$(document).on('click', '.pop-ofertarevista', function () {
    //    waitingDialog({});
    //    var contenedor = $(this).parents('.contiene-productos');
    //    ObtenerOfertaRevista(contenedor);
    //});
    //$(document).on('click', '.agregar-ofertarevista', function () {
    //    if (ReservadoOEnHorarioRestringido())
    //        return false;

    //    var contenedor = $(this).parents(".cuerpo-mod");
    //    var cantidad = $(this).siblings('.liquidacion_rango_home, .ofertarevista_rango_home').find('#txtCantidad').val();
    //    var tipoCUV = $(this).attr('data-cuv');

    //    AgregarProductoOfertaRevista(contenedor, cantidad, tipoCUV, this);
    //});
            
    //ShowRoom
    CrearPopShow();
    MostrarShowRoom();
    //Fin ShowRoom
});

function CargarCamara() {
    //https://github.com/jhuckaby/webcamjs
    Webcam.set({
        // live preview size
        width: 300,
        height: 300,
        // device capture size
        //dest_width: 600,
        //dest_height: 600,
        // final cropped size
        crop_width: 300,
        crop_height: 300,
        // format and quality
        image_format: 'jpeg',
        jpeg_quality: 90,
        //force_flash: true,
        flip_horiz: true
    });
    Webcam.attach('#my_camera');

    $("#fondoComunPopUp").show();
    contadorFondoPopUp++;
    $("#CamaraIntroductoria").show();
}

function CerrarCamara() {
    Webcam.reset();
    $('#imgFotoTomada').attr('src', '');
    $('#demo').removeClass('croppie-container').html('');

    $("#CamaraIntroductoria").hide();
    contadorFondoPopUp--;
    if(contadorFondoPopUp == 0) $("#fondoComunPopUp").hide();
}

function CortarFoto() {
    $('#demo').croppie('result', {
        type: 'canvas',
        format: 'png'
    }).then(function (resp) {
        waitingDialog();
        $.ajax({
            type: 'POST',
            url: baseUrl + 'Bienvenida/SubirImagen',
            data: JSON.stringify({ data: resp }),
            dataType: 'Json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                alert_msg(data.message);
                if (data.success) {
                    $('#imgFotoUsuario').show();
                    $('#imgFotoUsuarioDefault').hide();
                    $('#imgFotoUsuario').attr('src', data.imagen + '?' + Math.random());
                }
            },
            error: function(data, error) {
                //console.log(error);
            },
            complete: closeWaitingDialog
        });
    });
}

function TomarFoto() {
    Webcam.snap(function (data_uri) {
        $('#imgFotoTomada').attr('src', data_uri);
        $('#demo').croppie({
            viewport: {
                width: 150,
                height: 150,
                type: 'circle'
            },
            url: data_uri
        });
    });
}
function SubirFoto() {
    waitingDialog();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/SubirImagen',
        data: JSON.stringify({ data: $('#imgFotoTomada').attr('src') }),
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            alert_msg(data.message);
            if (data.success)
            {
                $('#imgFotoUsuario').show();
                $('#imgFotoUsuarioDefault').hide();
                $('#imgFotoUsuario').attr('src', data.imagen + '?' + Math.random());
            }
        },
        error: function(data, error) {
            //console.log(error);
        },
        complete: closeWaitingDialog
    });
}

// MICROEFECTO FLECHA HOME
function animacionFlechaScroll() {

    $(".flecha_scroll").animate({
        'top': '87%'
    }, 400, 'swing', function () {
        $(this).animate({
            'top': '90%'
        }, 400, 'swing');
    });

}
function agregarProductoAlCarrito(o) {
    var btnClickeado = $(o);
    var contenedorItem = btnClickeado.parent().parent();
    var imagenProducto = $('.imagen_producto', contenedorItem);

    if (imagenProducto.length > 0) {
        var carrito = $('.campana');

        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

        $(".transicion").css({
            'height': imagenProducto.css("height"),
            'width': imagenProducto.css("width"),
            'top': imagenProducto.offset().top,
            'left': imagenProducto.offset().left,
        }).animate({
            'top': carrito.offset().top - 60,
            'left': carrito.offset().left + 100,
            'height': carrito.css("height"),
            'width': carrito.css("width"),
            'opacity': 0.5
        }, 450, 'swing', function () {
            $(this).animate({
                'top': carrito.offset().top,
                'opacity': 0,
                //}, 100, 'swing', function () {
                //    $(".campana .info_cam").fadeIn(200);
                //    $(".campana .info_cam").delay(2500);
                //    $(".campana .info_cam").fadeOut(200);
            }, 150, 'swing', function () {
                $(this).remove();
            });
        });
    }    
}

//MICROEFECTO RESALTAR ICONO TUTORIAL
function mostrarUbicacionTutorial() {
    $(".fondo_oscuro").fadeIn(300, function () {
        $(".mensaje_header").addClass("opcionTutorial");
        $(".tooltip_tutorial").fadeIn();
        mostrarIconoTutorial();
    });

    setTimeout(function () {
        $(".tooltip_tutorial").fadeOut();
        $(".tooltip_tutorial").stop();
        $(".fondo_oscuro").delay(500);
        $(".fondo_oscuro").fadeOut(300, function () {
            $(".mensaje_header").removeClass("opcionTutorial");
        });
    }, 9000);
}
function mostrarIconoTutorial() {

    $(".tooltip_tutorial").animate({
        'opacity': 1,
        'top': 47
    }, 500, 'swing').animate({
        'top': 41
    }, 400, 'swing', mostrarIconoTutorial);

}
// FIN MICROEFECTO RESALTAR ICONO TUTORIAL

function mostrarVideoIntroductorio() {
    try {
         if (viewBagVioVideo == "0") {
 
             //closeWaitingDialog();   // SB20-834
 
             if (contadorFondoPopUp == 0) {
                 $("#fondoComunPopUp").show();
             }
             $("#videoIntroductorio").show();
             setTimeout(function () { playVideo(); }, 1000);
             UpdateUsuarioVideo();
             contadorFondoPopUp++;
         } else {
             if (viewBagVioTutorial == 0) {
                 abrir_popup_tutorial();
                 primeraVezVideo = false;
             }
             else {
                 if (viewBagVerComunicado == '-1') {
                    //console.log(viewBagVerComunicado);
                     waitingDialog();
                 }
                 else {
                     mostrarComunicadosPopup();
 
                     if (viewBagVerComunicado != '1') {
                         //CargarPopupsConsultora();
                     }
                 }
             }
         }
     } catch (e) {
 
     }
}

function UpdateUsuarioTutorial() {
    //viewBagVioTutorial = 1;
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Bienvenida/JSONSetUsuarioTutorialDesktop',
        data: '',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            //viewBagVioTutorial = data.result;
        },
        error: function (data) {}
    });
}

function UpdateUsuarioVideo() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Bienvenida/JSONSetUsuarioVideo',
        data: '',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            //viewBagVioVideo = data.result;
        },
        error: function (data) {
        }
    });
};

function CrearDialogs() {
    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    //$('#idSueniosNavidad').dialog({
    //    autoOpen: false,
    //    resizable: false,
    //    modal: true,
    //    closeOnEscape: true,
    //    width: 710,
    //    draggable: true,
    //    title: "",
    //    close: function (event, ui) {
    //        $(this).dialog('close');
    //    }
    //});
    //$("#idSueniosNavidad").siblings('div.ui-dialog-titlebar').remove();

    //$('#divSuenioConfirmacion').dialog({
    //    autoOpen: false,
    //    resizable: false,
    //    modal: true,
    //    closeOnEscape: true,
    //    width: 590,
    //    minHeight: 83,
    //    draggable: true,
    //    title: "",
    //    close: function (event, ui) {
    //        $(this).dialog('close');
    //    }
    //});
    //$("#divSuenioConfirmacion").siblings('div.ui-dialog-titlebar').remove();

    //CrearPopShowRoom();
    //CrearPopupComunicado();
    //CrearPopupComunicadoVisualizacion();
};

function CargarPopupsConsultora() {
    if (viewBagPrimeraVez == "0" && viewBagPaisID == 4) { //Colombia
        AbrirAceptacionContrato();
    }
    else {
        if (viewBagPaisID == 9 && viewBagValidaDatosActualizados == '1' && viewBagValidaTiempoVentana == '1' && viewBagValidaSegmento == '1') { //Mexico
            if (contadorFondoPopUp == 0) {
                $("#fondoComunPopUp").show();
            }
            $("#popupActualizarMisDatosMexico").show();
            contadorFondoPopUp++;
        } else {
            if (viewBagPrimeraVez == "0" || viewBagPrimeraVezSession == "0") {
                if (viewBagPaisID == 11) { //Peru
                    $('#tituloActualizarDatos').html('<b>ACTUALIZACIÓN Y AUTORIZACIÓN</b> DE USO DE DATOS PERSONALES');
                } else {
                    $('#tituloActualizarDatos').html('<b>ACTUALIZAR</b> DATOS');
                }
                if (contadorFondoPopUp == 0) {
                    $("#fondoComunPopUp").show();
                }
                $("#popupActualizarMisDatos").show();
                contadorFondoPopUp++;
            }
            else {
                if (viewBagPrimeraVez == "1" && viewBagPaisID == 4) { //Colombia
                    AbrirAceptacionContrato();
                }
            }
        }
    }

    AbrirPopupFlexipago();
    //AbrirComunicado();

    //if (viewBagPrefijoPais == "EC") {
    //    AbrirComunicadoVisualizacion();
    //};

    MostrarDemandaAnticipada();

    //MostrarShowRoom();

    //if (viewBagValidaSuenioNavidad == 0) {
    //    showDialog('idSueniosNavidad');
    //}
};

//Metodos para carousel Ofertas para Tí
function CargarCarouselEstrategias(cuv) {
    $('.js-slick-prev').remove();
    $('.js-slick-next').remove();
    $('#divCarruselHorizontal.slick-initialized').slick('unslick');    

    if (isEsika) {
        $('#divCarruselHorizontal').html(
            '<div class="precarga"><svg class="circular" viewBox="25 25 50 50"><circle class="path-esika" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"/></svg></div><span class="texto_precarga">Dános unos segundos </br>Las mejores ofertas <b>PARA TI</b> están por aparecer</span>'
        );
    } else {
        $('#divCarruselHorizontal').html('<div class="precarga"><svg class="circular" viewBox="25 25 50 50"><circle class="path-lbel" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"/></svg></div><span class="texto_precarga">Dános unos segundos </br>Las mejores ofertas <b>PARA TI</b> están por aparecer</span>');
    }
    
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/JsonConsultarEstrategias?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $('#divCarruselHorizontal').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
};
function ArmarCarouselEstrategias(data) {
    
    data = EstructurarDataCarousel(data);
    arrayOfertasParaTi = data;

    SetHandlebars("#estrategia-template", data, '#divCarruselHorizontal');

    var data1 = $('#divCarruselHorizontal').find('.nombre_producto');
    nbData = data1.length;
    var found;
    for (var iData = 0; iData < nbData; iData++) {
        if (data1[iData].children[0].innerHTML.length > 40) {
            data1[iData].children[0].innerHTML = data1[iData].children[0].innerHTML.substring(0, 40) + "...";
        }
    }

    if ($.trim($('#divCarruselHorizontal').html()).length == 0) {
        $('.fondo_gris').hide();
    } else {
        $('#divCarruselHorizontal').not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
            responsive: [
                {
                    breakpoint: 1025,
                    settings: {
                        slidesToShow: 3
                    }
                }
            ]
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            var accion;
            if (nextSlide == 0 && currentSlide + 1 == arrayOfertasParaTi.length) {
                accion = 'next';
            } else if (currentSlide == 0 && nextSlide + 1 == arrayOfertasParaTi.length) {
                accion = 'prev';
            } else if (nextSlide > currentSlide) {
                accion = 'next';
            } else {
                accion = 'prev';
            };

            if (accion == 'prev') {
                //TagManager
                var posicionPrimerActivo = $($('#divCarruselHorizontal').find(".slick-active")[0]).find('.PosicionEstrategia').val();
                var posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length - 1 : posicionPrimerActivo - 2;
                var recomendado = arrayOfertasParaTi[posicionEstrategia];
                var arrayEstrategia = new Array();
                
                var impresionRecomendado = {
                    'name': recomendado.DescripcionCompleta,
                    'id': recomendado.CUV2,
                    'price': recomendado.Precio2.toString(),
                    'brand': recomendado.DescripcionMarca,
                    'category': 'NO DISPONIBLE',
                    'variant': recomendado.DescripcionEstrategia,
                    'list': 'Ofertas para ti – Home',
                    'position': recomendado.Posicion
                };

                arrayEstrategia.push(impresionRecomendado);

                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Ofertas para ti',
                    'label': 'Ver anterior'
                });
            } else if (accion == 'next') {
                //TagManager
                var posicionUltimoActivo = $($('#divCarruselHorizontal').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
                var posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
                var recomendado = arrayOfertasParaTi[posicionEstrategia];
                var arrayEstrategia = new Array();

                var impresionRecomendado = {
                    'name': recomendado.DescripcionCompleta,
                    'id': recomendado.CUV2,
                    'price': recomendado.Precio2.toString(),
                    'brand': recomendado.DescripcionMarca,
                    'category': 'NO DISPONIBLE',
                    'variant': recomendado.DescripcionEstrategia,
                    'list': 'Ofertas para ti – Home',
                    'position': recomendado.Posicion
                };

                arrayEstrategia.push(impresionRecomendado);

                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Ofertas para ti',
                    'label': 'Ver siguiente'
                });
            }
        });
        TagManagerCarruselInicio(data);
    }
};
function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        item.DescripcionCompleta = item.DescripcionCUV2;
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
            item.ArrayContenidoSet = item.DescripcionCUV2.split('|').slice(1);
        } else {
            //item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 0 ? item.DescripcionCUV2 : "");
        };

        item.Posicion = i+1;
        item.MostrarTextoLibre = item.TextoLibre.length > 0;
    });
    return array;
};
function CargarProductoDestacado(objParameter, objInput, popup, limite) {
    if (ReservadoOEnHorarioRestringido())
        return false;

    agregarProductoAlCarrito(objInput);

    waitingDialog({});

    if (objParameter.FlagNueva == "1")
        $('#OfertaTipoNuevo').val(objParameter.FlagNueva);
    else
        $('#OfertaTipoNuevo').val("");

    popup = popup || false;
    limite = limite || 0;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;

    var cantidadIngresada = (limite > 0) ? limite : $(objInput).parent().find("input.liquidacion_rango_cantidad_pedido").val();
    origenPedidoWebEstrategia = $(objInput).parents("[data-item]").find("input.OrigenPedidoWeb").val();
    var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'AdministrarEstrategia/FiltrarEstrategiaPedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {
            var flagEstrella = (datos.data.FlagEstrella == 0) ? "hidden" : "visible";
            $("#imgTipoOfertaEdit").attr("src", datos.data.ImagenURL);
            $("#imgEstrellaEdit").css({ "visibility": flagEstrella });
            $("#imgZonaEstrategiaEdit").attr("src", datos.data.FotoProducto01);

            if (datos.data.Precio != "0") {
                $(".zona2Edit").html(datos.data.EtiquetaDescripcion + ' ' + datos.data.Simbolo + '' + datos.precio);
            } else {
                $(".zona2Edit").html("");
            }

            if (datos.data.Precio2 != "0") {
                $(".zona3Edit_1").html(datos.data.EtiquetaDescripcion2);
                $(".zona3Edit_2").html('<span>' + datos.data.Simbolo + '' + datos.precio2 + '</span>');
            } else {
                $(".zona3Edit_1").html("");
                $(".zona3Edit_2").html("");
            }

            if (datos.data.TextoLibre != "") {
                $(".zona4Edit").html(datos.data.TextoLibre);
            } else {
                $(".zona4Edit").html("");
            }

            if (datos.data.ColorFondo != "") {
                $("#divVistaPrevia").css({ "background-color": datos.data.ColorFondo });
            } else {
                $("#divVistaPrevia").css({ "background-color": "#FFF" });
            }

            $("#txtCantidadZE").val(cantidadIngresada);
            $("#txtCantidadZE").attr("est-cantidad", datos.data.LimiteVenta);
            $("#txtCantidadZE").attr("est-cuv2", datos.data.CUV2);
            $("#txtCantidadZE").attr("est-marcaID", datos.data.MarcaID);
            $("#txtCantidadZE").attr("est-precio2", datos.data.Precio2);
            $("#txtCantidadZE").attr("est-montominimo", datos.data.IndicadorMontoMinimo);
            $("#txtCantidadZE").attr("est-tipooferta", datos.data.TipoOferta);
            $("#txtCantidadZE").attr("est-descripcionMarca", datos.data.DescripcionMarca);
            $("#txtCantidadZE").attr("est-descripcionEstrategia", datos.data.DescripcionEstrategia);
            $("#txtCantidadZE").attr("est-descripcionCategoria", datos.data.DescripcionCategoria);
            $("#txtCantidadZE").attr("est-posicion", posicionItem);

            $("#ddlTallaColor").empty();
            $(".zona0Edit").html(datos.data.DescripcionMarca);

            /*Validar Programa Ofertas Nuevas*/
            $("#hdnProgramaOfertaNuevo").val(false);
            $("#OfertasResultados li").hide();

            if (datos.data.FlagNueva == 1) {
                $(".zona4Edit").hide();
                $(".zonaCantidad").hide();
                $("#hdnProgramaOfertaNuevo").val(true);
                var nroPedidos = false;
                var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

                pedidosData.each(function (indice, valor) {
                    if (valor.value == 1) {
                        nroPedidos = true;
                        var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                            $('#hdnPagina').val(), ";",
                            $('#hdnClienteID2_').val());

                        $("#OfertaTipoNuevo").val(OfertaTipoNuevo);
                        return;
                    }
                });

                if (nroPedidos) {
                    $(".zona4Edit").text(datos.data.TextoLibre);
                    $(".zona4Edit").show();
                }

                var ofertas = datos.data.DescripcionCUV2.split('|');
                $(".zona1Edit").html(ofertas[0]);
                $("#txtCantidadZE").attr("est-descripcion", ofertas[0]);
                $("#OfertasResultados li").remove(); // Limpiar la lista.

                $.each(ofertas, function (i) {
                    if (i != 0 && $.trim(ofertas[i]) != "") {
                        $("#OfertasResultados").append("<li>" + ofertas[i] + "</li>");
                    }
                });

                AgregarProductoDestacado(popup, tipoEstrategiaImagen);
            } else {
                $(".zona4Edit").show();
                $(".zonaCantidad").show();
                $(".zona1Edit").html(datos.data.DescripcionCUV2);
                $("#txtCantidadZE").attr("est-descripcion", datos.data.DescripcionCUV2);
                var option = "";
                $(".tallaColor").hide();
                if (datos.data.TallaColor != "") {
                    var arrOption = datos.data.TallaColor.split('</>');
                    if (arrOption.length > 2) {
                        for (var i = 0; i < arrOption.length; i++) {
                            if (arrOption[i] != "") {
                                option = "<option ";
                                var strOption = arrOption[i].split('|');
                                var strCuv = strOption[0];
                                var strDescCuv = strOption[1];
                                var strDescTalla = strOption[2];
                                option += " value='" + strCuv + "' desc-talla='" + strDescCuv + "' >" + strDescTalla + "</option>";
                                $("#ddlTallaColor").append(option);
                            }
                        }

                        $(".tallaColor").show();
                    }
                }
                if (option == "") {
                    AgregarProductoDestacado(popup, tipoEstrategiaImagen);
                } else {
                    closeWaitingDialog();
                }
            }

            //closeWaitingDialog();
            //showDialog('divVistaPrevia');
        },
        error: function (data, error) {
            alert(datos.data.message);
            closeWaitingDialog();
        }
    });
};
function AgregarProductoDestacado(popup, tipoEstrategiaImagen) {
    waitingDialog({});

    var cantidad = $("#txtCantidadZE").val();
    var cantidadLimite = $("#txtCantidadZE").attr("est-cantidad");
    var cuv = $("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $("#txtCantidadZE").attr("est-marcaID");
    var precio = $("#txtCantidadZE").attr("est-precio2");
    var descripcion = $("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $("#txtCantidadZE").attr("est-montominimo");
    var tipoOferta = $("#txtCantidadZE").attr("est-tipooferta");
    var categoria = $("#txtCantidadZE").attr("est-descripcionCategoria");
    var variant = $("#txtCantidadZE").attr("est-descripcionEstrategia");
    var marca = $("#txtCantidadZE").attr("est-descripcionMarca");
    var posicion = $("#txtCantidadZE").attr("est-posicion");
    var urlImagen = $("#imgZonaEstrategiaEdit").attr("src");
    var OrigenPedidoWeb = origenPedidoWebEstrategia;

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            alert_msg_pedido("Por favor, seleccione la Talla/Color del producto.");
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        alert_msg_pedido("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        alert_msg_pedido("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        alert_msg_pedido("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        $("#loadingScreen").dialog('close');
        return false;
    }

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ClienteID_: '-1',
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0,
        OrigenPedidoWeb: OrigenPedidoWeb
    });

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                alert_msg_pedido(datos.message);
                closeWaitingDialog();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'Pedido/AgregarProductoZE',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            closeWaitingDialog();
                            return false;
                        }

                        if (data.success != true) {
                            alert_msg_pedido(data.message);
                            closeWaitingDialog();
                            return false;
                        }

                        waitingDialog({});
                        ActualizarGanancia(data.DataBarra);
                        CargarCarouselEstrategias(cuv);
                        CargarResumenCampaniaHeader(true);
                        TagManagerClickAgregarProducto();
                        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                        closeWaitingDialog();
                        if (popup) {
                            HidePopupEstrategiasEspeciales();
                        }
                        
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            closeWaitingDialog();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
};
function ShowPopupTonosTallas() {
    $('.js-contenedor-popup-tonotalla').show();
};
function HidePopupTonosTallas() {
    $('.js-contenedor-popup-tonotalla').hide();
};
function CambiarTonoTalla(ddlTonoTalla) {
    $(ddlTonoTalla).parents('#divTonosTallas').find('#CUV').attr("value", $("option:selected", ddlTonoTalla).attr("value"));
    $(ddlTonoTalla).parents('#divTonosTallas').find("#PrecioOferta").attr("value", $("option:selected", ddlTonoTalla).attr("precio-real")); //2024
    $(ddlTonoTalla).parents('#divTonosTallas').find("#DescripcionProd").attr("value", $("option:selected", ddlTonoTalla).attr("desc-talla")); //2024

    $(ddlTonoTalla).parents('#divTonosTallas').find('.nombre_producto').html('<b>' + $("option:selected", ddlTonoTalla).attr("desc-talla") + '</b>');
    $(ddlTonoTalla).parents('#divTonosTallas').find('.producto_precio_oferta').html('<b>' + viewBagSimbolo + " " + $("option:selected", ddlTonoTalla).attr("desc-precio") + '</b>'); //2024
};
function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        dataType: 'json',
        async: false,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    waitingDialog({});
                    location.href = location.href = baseUrl + 'Pedido/PedidoValidado'
                }
                if (mostrarAlerta == true) {
                    closeWaitingDialog();
                    alert_msg_pedido(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true)
                alert_msg_pedido(data.message);
        },
        error: function (error) {
            //console.log(error);
            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}
function CargarEstrategiasEspeciales(objInput, e) {
    if ($(e.target).attr('class') === undefined || $(e.target).attr('class').indexOf('js-no-popup') == -1) {
        var estrategia = JSON.parse($(objInput).attr("data-estrategia"));

        if (estrategia.TipoEstrategiaImagenMostrar == '2') {
            var html = ArmarPopupPackNuevas(estrategia);
            $('#popupDetalleCarousel_packNuevas').html(html);
            $('#popupDetalleCarousel_packNuevas').show();
            TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
        } else if (estrategia.TipoEstrategiaImagenMostrar == '5' || estrategia.TipoEstrategiaImagenMostrar == '3') {
            var html = ArmarPopupLanzamiento(estrategia);
            $('#popupDetalleCarousel_lanzamiento').html(html);

            if ($('#popupDetalleCarousel_lanzamiento').find('.nombre_producto').children()[0].innerHTML.length > 40) {
                $('#popupDetalleCarousel_lanzamiento').find('.nombre_producto').addClass('nombre_producto22');
                $('#popupDetalleCarousel_lanzamiento').find('.nombre_producto22').removeClass('nombre_producto');
                //$('#popupDetalleCarousel_lanzamiento').find('.nombre_producto22').children()[0].innerHTML = "LBel Mithyka Eau Parfum 50ml+Cyzone Love Bomb Eau de Parfum 30ml+Esika Labial Color HD Tono Pimienta Caliente+Esika Agu Shampoo Manzanilla 1L";
            }
            
            $('#popupDetalleCarousel_lanzamiento').show();
            TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
        };
        dataLayer.push({
            'event': 'productClick',
            'ecommerce': {
                'click': {
                    'actionField': { 'list': 'Ofertas para ti – Home' },
                    'products': [{
                        'id': estrategia.CUV2,
                        'name': (estrategia.DescripcionCUVSplit == undefined || estrategia.DescripcionCUVSplit == '') ? estrategia.DescripcionCompleta : estrategia.DescripcionCUVSplit,
                        'price': estrategia.Precio2.toString(),
                        'brand': estrategia.DescripcionMarca,
                        'category': 'NO DISPONIBLE',
                        'variant': estrategia.DescripcionEstrategia,
                        'position': estrategia.Posicion
                    }]
                }
            }
        });

    } else {
        return false;
    }

};
function ArmarPopupPackNuevas(obj) {
    return SetHandlebars("#packnuevas-template", obj);
};
function ArmarPopupLanzamiento(obj) {
    return SetHandlebars("#lanzamiento-template", obj);
};
function HidePopupEstrategiasEspeciales() {
    $('#popupDetalleCarousel_lanzamiento').hide();
    $('#popupDetalleCarousel_packNuevas').hide();
};
function alert_msg_pedido(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
};
function alert_unidadesAgregadas(message, exito) {
    if (exito == 1) {
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .titulo_agregarUnidades').html("<b>¡FELICIDADES!</b>");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .mensaje_agregarUnidades').html(message);
    } else {
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp #apro_o_excla').removeClass("icono_aprobacion");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp #apro_o_excla').addClass("icono_exclamacion");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .titulo_agregarUnidades').html("LO <b>SENTIMOS</b>");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .mensaje_agregarUnidades').html(message);
    }
    $('#dialog_AgregasteUnidades').show();
}

//Metodos para carousel Liquidaciones
function CargarCarouselLiquidaciones() {
    $('.js-slick-prev-liq').remove();
    $('.js-slick-next-liq').remove();
    $('#divCarruselLiquidaciones.slick-initialized').slick('unslick');
    
    $('#divCarruselLiquidaciones').html('<div style="text-align: center;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertaLiquidacion/JsonGetOfertasLiquidacion',
        data: { offset: 0, cantidadregistros: cantProdCarouselLiquidaciones, origen: 'Home' },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselLiquidaciones(data);
        },
        error: function (error) {
            $('#divCarruselLiquidaciones').html('');
        }
    });
};
function ArmarCarouselLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data.lista);
    arrayLiquidaciones = data;

    var htmlDiv = SetHandlebars("#liquidacion-template", data);

    //Se agrega item VER MAS
    if ($.trim(htmlDiv).length > 0) {
        htmlDiv += [
            '<div>',
                '<div class="content_item_carrusel background_vermas">',
                    '<input type="hidden" id="Posicion" value="' + (data.length + 1) + '"/>',
                    '<div class="producto_img_home">',
                    '</div>',
                    '<div class="producto_nombre_descripcion">',
                        '<p class="nombre_producto">',
                        '</p>',
                        '<div class="producto_precio" style="margin-bottom: -8px;">',
                            '<span class="producto_precio_oferta"></span>',
                        '</div>',
                        '<a href="' + baseUrl + 'OfertaLiquidacion/OfertasLiquidacion" class="boton_Agregalo_home no_accionar" style="width:100%;">',
                            'VER MÁS',
                        '</a>',
                    '</div>',
                '</div>',
            '</div>'
        ].join("\n");
    };

    $('#divCarruselLiquidaciones').empty().html(htmlDiv);

    $('#divCarruselLiquidaciones').slick({
        infinite: false,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        speed: 260,
        prevArrow: '<a class="previous_ofertas js-slick-prev-liq"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
        nextArrow: '<a class="previous_ofertas js-slick-next-liq" style="right: 0;display: block;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
    }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        var accion = nextSlide > currentSlide ? 'next' : 'prev';
        var itemsLength = $('#divCarruselLiquidaciones').find('.slick-slide').length;
        var indexActive = $($('#divCarruselLiquidaciones').find('.slick-active')).attr('data-slick-index');

        if (accion == 'prev') {
            //Esconder/mostrar flechas
            if (Number(indexActive) - 1 == 0) {
                $('.js-slick-prev-liq').hide();
                $('.js-slick-next-liq').show();
            } else {
                $('.js-slick-next-liq').show();
            }
            //TagManager
            var posicionEstrategia = $($('#divCarruselLiquidaciones').find(".slick-active")).find('#Posicion').val() - 2;
            var recomendado = arrayLiquidaciones[posicionEstrategia];
            var arrayEstrategia = new Array();

            var impresionRecomendado = {
                'name': recomendado.DescripcionCompleta,
                'id': recomendado.CUV,
                'price': recomendado.PrecioOferta.toString(),
                'brand': recomendado.DescripcionMarca,
                'category': 'NO DISPONIBLE',
                'variant': recomendado.DescripcionEstrategia,
                'list': 'Liquidación Web - Home',
                'position': recomendado.Posicion
            };
            arrayEstrategia.push(impresionRecomendado);
            dataLayer.push({
                'event': 'productImpression',
                'ecommerce': {
                    'impressions': arrayEstrategia
                }
            });
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home',
                'action': 'Liquidacion Web',
                'label': 'Ver anterior'
            });

        } else if (accion == 'next') {
            //Esconder/mostrar flechas
            if (Number(indexActive) + 1 == Number(itemsLength) - 1) {
                $('.js-slick-next-liq').hide();
                $('.js-slick-prev-liq').show();
            } else {
                $('.js-slick-prev-liq').show();
            }
            //TagManager
            var posicionEstrategia = $($('#divCarruselLiquidaciones').find(".slick-active")).find('#Posicion').val();

            if (posicionEstrategia != arrayLiquidaciones.length) {
                var recomendado = arrayLiquidaciones[posicionEstrategia];
                var arrayEstrategia = new Array();

                var impresionRecomendado = {
                    'name': recomendado.DescripcionCompleta,
                    'id': recomendado.CUV,
                    'price': recomendado.PrecioOferta.toString(),
                    'brand': recomendado.DescripcionMarca,
                    'category': 'NO DISPONIBLE',
                    'variant': recomendado.DescripcionEstrategia,
                    'list': 'Liquidación Web - Home',
                    'position': recomendado.Posicion
                };

                arrayEstrategia.push(impresionRecomendado);

                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Liquidacion Web',
                    'label': 'Ver siguiente'
                });
            } else {
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Liquidacion Web',
                    'label': 'Ver más'
                });
            }
        }
    });
    TagManagerCarruselLiquidacionesInicio(data);

    $(".js-slick-prev-liq").insertBefore('#divCarruselLiquidaciones').hide();
    $(".js-slick-next-liq").insertAfter('#divCarruselLiquidaciones');
};
function EstructurarDataCarouselLiquidaciones(array) {
    $.each(array, function (i, item) {
        item.DescripcionCompleta = item.Descripcion;
        item.Descripcion = (item.Descripcion.length > 40 ? item.Descripcion.substring(0, 40) + "..." : item.Descripcion);
        //item.PrecioOferta = (viewBagPaisID == '4' ? Number(item.PrecioOferta.toString().replace(',', '.')).toFixed(2) : Number(item.PrecioOferta).toFixed(2));
        item.Simbolo = viewBagSimbolo;
        item.Posicion = i+1;

        if (item.TallaColor.length > 1 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TallaColor = "";
            item.TieneTallaColor = false;
        };
    });

    return array;
};
function AgregarProductoLiquidacion(contenedor) {

    var inputCantidad = $(contenedor).find("#txtCantidad").val();
    if (!$.isNumeric(inputCantidad)) {
        alert_msg_pedido("Ingrese un valor numérico.");
        $(contenedor).find("#txtCantidad").val(1);
        return false;
    }
    if (parseInt(inputCantidad) <= 0) {
        alert_msg_pedido("La cantidad debe ser mayor a cero.");
        $(contenedor).find("#txtCantidad").val(1);
        return false;
    }

    waitingDialog({});

    var item = {
        Cantidad: $(contenedor).find("#txtCantidad").val(),
        MarcaID: $(contenedor).find("#MarcaID").val(),
        PrecioUnidad: $(contenedor).find("#PrecioOferta").val(),
        CUV: $(contenedor).find("#CUV").val(),
        ConfiguracionOfertaID: $(contenedor).find("#ConfiguracionOfertaID").val(),
        descripcionProd: $(contenedor).find("#DescripcionProd").val(),
        descripcionCategoria: $(contenedor).find("#DescripcionCategoria").val(),
        descripcionMarca: $(contenedor).find("#DescripcionMarca").val(),
        descripcionEstrategia: $(contenedor).find("#DescripcionEstrategia").val(),
        imagenProducto: $(contenedor).find("#ImagenProducto").val(),
        Posicion: $(contenedor).find("#Posicion").val(),
        OrigenPedidoWeb: DesktopHomeLiquidacion,
    };
    $.ajaxSetup({
        cache: false
    });

    $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: item.CUV }, function (data) {
        if (parseInt(data.Saldo) < parseInt(item.Cantidad)) {
            var Saldo = data.Saldo;
            var UnidadesPermitidas = data.UnidadesPermitidas;
            $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: item.CUV }, function (data) {
                if (Saldo == UnidadesPermitidas)
                    alert_msg_pedido("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                else {
                    if (Saldo == "0")
                        alert_msg_pedido("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                    else
                        alert_msg_pedido("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                }
                HidePopupTonosTallas();
                closeWaitingDialog();
                return false;
            });
        } else {
            $.ajaxSetup({
                cache: false
            });
            $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: item.CUV }, function (data) {
                if (parseInt(data.Stock) < parseInt(item.Cantidad)) {
                    alert_msg_pedido("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.");
                    HidePopupTonosTallas();
                    closeWaitingDialog();
                    return false;
                }
                else {
                    jQuery.ajax({
                        type: 'POST',
                        url: baseUrl + 'OfertaLiquidacion/InsertOfertaWebPortal',
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify(item),
                        async: true,
                        success: function (data) {

                            if (!checkTimeout(data)) {
                                closeWaitingDialog();
                                return false;
                            }

                            if (data.success != true) {
                                alert_msg_pedido(data.message);
                                closeWaitingDialog();
                                return false;
                            }

                            ActualizarGanancia(data.DataBarra);
                            CargarResumenCampaniaHeader(true);
                            TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);
                            TagManagerClickAgregarProductoLiquidacion(item);
                           
                            closeWaitingDialog();
                            HidePopupTonosTallas();
                        },
                        error: function (data, error) {
                            if (checkTimeout(data)) {
                                alert_msg_pedido(data.message);
                                closeWaitingDialog();
                                HidePopupTonosTallas();
                            }
                        }
                    });
                }
            });
        }
    });
};
function CargarProductoLiquidacionPopup(objProducto, objHidden) {
    waitingDialog({});

    var divTonosTallas = $('#divTonosTallas');
    var arrayTonosTallas = objProducto.tonosTallas.split("@");
    var option = '';

    for (var i = 0; i < arrayTonosTallas.length - 1; i++) {
        var strOption = arrayTonosTallas[i].split("|");
        var strCuv = strOption[0];
        var strDescCuv = strOption[1];
        var strDescTalla = strOption[2];
        var strDescPrecio = Number(strOption[3]).toFixed(2);
        var strPrecioReal = strOption[3];

        option += '<option value="' + strCuv + '"' +
                  'desc-talla="' + strDescCuv + '"' +
                  'desc-precio="' + strDescPrecio + '"' +
                  'precio-real="' + strPrecioReal + '"' +
                  '>' + strDescTalla + '</option>';
    };

    $(divTonosTallas).find('#ddlTallaColorLiq').html(option);

    $(divTonosTallas).find('#imgPopupTonoTalla').attr('src', objProducto.imagenProducto);
    $(divTonosTallas).find('#marcaPopupTonoTalla').html(objProducto.tituloMarca);
    $(divTonosTallas).find('.nombre_producto').html('<b>' + objProducto.descripcion + '</b>');
    $(divTonosTallas).find('.producto_precio_oferta').html('<b>' + objProducto.precio + '</b>');

    //Seteo valores de inputs hidden
    $(divTonosTallas).find('#MarcaID').val(objHidden.MarcaID);
    $(divTonosTallas).find('#PrecioOferta').val(objHidden.PrecioOferta);
    $(divTonosTallas).find('#CUV').val(objHidden.CUV);
    $(divTonosTallas).find('#ConfiguracionOfertaID').val(objHidden.ConfiguracionOfertaID);
    $(divTonosTallas).find('#DescripcionProd').val(objHidden.DescripcionProd);
    $(divTonosTallas).find('#DescripcionMarca').val(objHidden.DescripcionMarca);
    $(divTonosTallas).find('#DescripcionCategoria').val(objHidden.DescripcionCategoria);
    $(divTonosTallas).find('#DescripcionEstrategia').val(objHidden.DescripcionEstrategia);
    $(divTonosTallas).find('#ImagenProducto').val(objHidden.ImagenProducto);
    $(divTonosTallas).find('#Posicion').val(objHidden.Posicion);

    $(divTonosTallas).find('#txtCantidad').val(1);

    closeWaitingDialog();
    ShowPopupTonosTallas();
};

// Métodos Banners
function CargarBanners() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Banner/ObtenerBannerPaginaPrincipal',
        data: '',
        dataType: 'Json',
        success: function (dataResult) {
            if (checkTimeout(dataResult)) {
                if (dataResult.success) {
                    var delayPrincipal = 0, delaySBaja1 = 0;
                    var count = 0;
                    var Titulo = "";
                    var Posicion = "";
                    var Id = 0;
                    var TipoAccion = 0;
                    var Creative = "";
                    var fileName = "";
                    var countBajos = 1;
                    var promotionsBajos = [];

                    $('#bannerBajos').empty();
                    $('#sliderHomeLoading').empty();

                    while (dataResult.data.length > count) {
                        Titulo = dataResult.data[count].Titulo;
                        Id = dataResult.data[count].BannerID.toString();
                        fileName = dataResult.data[count].Archivo;
                        TipoAccion = dataResult.data[count].TipoAccion;

                        if (dataResult.data[count].GrupoBannerID.toString() == '150') {
                            Posicion = 'Home Slider – ' + dataResult.data[count].Orden;
                        }

                        switch (dataResult.data[count].GrupoBannerID) {
                            case 150: // Seccion Principal SB2.0
                                var iniHtmlLink = ((dataResult.data[count].URL.length > 0 && dataResult.data[count].TipoAccion == 0) || dataResult.data[count].TipoAccion == 1 || dataResult.data[count].TipoAccion == 2) ? "<a id='bannerMicroefecto" + dataResult.data[count].BannerID + "' href='javascript:void();' onclick=\"return EnlaceBanner('" + dataResult.data[count].URL + "','" + dataResult.data[count].Titulo + "','" + dataResult.data[count].TipoAccion + "','" + dataResult.data[count].CuvPedido + "','" + dataResult.data[count].CantCuvPedido + "','" + dataResult.data[count].BannerID + "','" + Posicion + "','" + dataResult.data[count].Titulo + "', this);\" rel='marquesina' >" : "";
                                var finHtmlLink = ((dataResult.data[count].URL.length > 0 && dataResult.data[count].TipoAccion == 0) || dataResult.data[count].TipoAccion == 1 || dataResult.data[count].TipoAccion == 2) ? '</a>' : '';

                                $('.flexslider ul.slides').append('<li><div><div>' + iniHtmlLink + '<img class="imagen_producto" src="' + fileName + '"data-object-fit="none">' + finHtmlLink + '</div></div></li>');
                                delayPrincipal = dataResult.data[count].TiempoRotacion;
                                break;
                            case -5: case -6: case -7: // Seccion Baja 1 SB2.0 
                                var trackingText = dataResult.data[count].TituloComentario;
                                var trackingDesc = dataResult.data[count].TextoComentario;
                                var htmlLink = dataResult.data[count].URL.length > 0 ? "onclick=\"return SetGoogleAnalyticsBannerInferiores('" + dataResult.data[count].URL + "','" + trackingText + "','0','" + dataResult.data[count].BannerID + "','" + countBajos + "','" + dataResult.data[count].Titulo + "');\" target='_blank' rel='banner-inferior' " : "";

                                $('#bannerBajos').append("<a class='enlaces_home' href='javascript:void();' " + htmlLink + "><div class='div-img hidden'><img class='banner-img' src='" + fileName + "' /></div><div class='btn_enlaces'>" + trackingText + "</div></a>");
                                delaySBaja1 = dataResult.data[count].TiempoRotacion;
                                promotionsBajos.push({
                                    id: dataResult.data[count].BannerID,
                                    name: dataResult.data[count].Titulo,
                                    position: 'home-inferior-' +  countBajos
                                });
                                countBajos++;                                
                                break;
                        }
                        count++;

                        if (TipoAccion == 0) {
                            Creative = "Banner";
                        }
                        else if (TipoAccion == 1) {
                            Creative = "Producto";
                        }

                        vpromotions.push({
                            'name': Titulo,
                            'id': Id,
                            'position': Posicion,
                            'creative': Creative
                        });
                    }
                    if (promotionsBajos.length > 0) {
                        dataLayer.push({
                            'event': 'promotionView',
                            'ecommerce': {
                                'promoView': {
                                    'promotions': promotionsBajos
                                }
                            }
                        });

                    }

                    $('#bannerBajos').find("a.enlaces_home:last-child").addClass("no_margin_right");

                    /* Slides para la seccion principal */
                    if (count > 0) {
                        $('.flexslider').flexslider({
                            animation: "fade",
                            slideshowSpeed: (delayPrincipal * 1000),
                            after: function (slider) {
                                if (FuncionesGenerales.containsObject(vpromotions[slider.currentSlide], vpromotionsTagged) == false) {
                                    dataLayer.push({
                                        'event': 'promotionView',
                                        'ecommerce': {
                                            'promoView': {
                                                'promotions': vpromotions[slider.currentSlide]
                                            }
                                        }
                                    });
                                    vpromotionsTagged.push(vpromotions[slider.currentSlide]);
                                }
                            },
                            start: function (slider) {
                                $('body').removeClass('loading');
                                dataLayer.push({
                                    'event': 'promotionView',
                                    'ecommerce': {
                                        'promoView': {
                                            'promotions': vpromotions[slider.currentSlide]
                                        }
                                    }
                                });
                                vpromotionsTagged.push(vpromotions[slider.currentSlide]);
                            }
                        });
                    }
                }
                else {
                    alert('Error al cargar el Banner.');
                }
            }
        }
    });
};
function EnlaceBanner(URL, TrackText, TipoAccion, CUVpedido, CantCUVpedido, Id, Posicion, Titulo, link) {
    if (TipoAccion == 0 || TipoAccion == 2) {
        SetGoogleAnalyticsBannerPrincipal(URL, TrackText, Id, Posicion, Titulo);
    }

    if (TipoAccion == 1) {
        if (ReservadoOEnHorarioRestringido())
            return false;
        else
            var objBannerCarrito = $("#" + $(link).attr("id"));
            agregarProductoAlCarrito(objBannerCarrito);
            InsertarPedidoCuvBanner(CUVpedido, CantCUVpedido);

        SetGoogleAnalyticsPromotionClick(Id, Posicion, Titulo);

        return false;
    }
};
function InsertarPedidoCuvBanner(CUVpedido, CantCUVpedido) {
    var item = {
        CUV: CUVpedido,
        CantCUVpedido: CantCUVpedido,
        origenPedidoWeb: DesktopHomeBanners
    };
    var categoriacad = "";
    var variantcad = "";
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarPedidoCuvBanner',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (result) {
            if (!checkTimeout(result)) {
                closeWaitingDialog();
                return false;
            }

            if (result.success != true) {
                if (result.message == "")
                    result.message = 'Error al realizar proceso, intentelo mas tarde.';
                alert_unidadesAgregadas('Error al realizar proceso, inténtelo más tarde.', 2);
                closeWaitingDialog();
                return false;
            }

            ActualizarGanancia(result.DataBarra);

            CargarResumenCampaniaHeader(true);

            //alert_unidadesAgregadas(result.message, 1);

            if (result.oPedidoDetalle.DescripcionEstrategia == null || result.oPedidoDetalle.DescripcionEstrategia == "") {
                variantcad = "Estándar";
            } else {
                variantcad = result.oPedidoDetalle.DescripcionEstrategia;
            }
            if (result.oPedidoDetalle.Categoria == null || result.oPedidoDetalle.Categoria == "") {
                categoriacad = "Sin Categoría";
            } else {
                categoriacad = result.oPedidoDetalle.Categoria;
            }

            TrackingJetloreAdd(CantCUVpedido, $("#hdCampaniaCodigo").val(), CUVpedido);

            dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                    'add': {
                        'actionField': { 'list': 'Banner marquesina' },
                        'products': [
                            {
                                'name': result.oPedidoDetalle.DescripcionProd,
                                'price': result.oPedidoDetalle.PrecioUnidad.toString(),
                                'brand': result.oPedidoDetalle.DescripcionLarga,
                                'id': CUVpedido,
                                'category': categoriacad,
                                'variant': variantcad,
                                'quantity': parseInt(CantCUVpedido),
                                'position': 1
                            }
                        ]
                    }
                }
            });

            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
};
function SetGoogleAnalyticsBannerIntermedios(URL, TrackText, PaginaNueva, Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion
                 }]
            }
        }
    });
    if (PaginaNueva == "1") {
        var id = URL;

        if (URL > 0) {
            var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
            window.open(url, '_blank');
        } else {
            window.open(URL, '_blank');
        }
    } else {
        window.location.href = URL;
    }
    return false;
};
function SetGoogleAnalyticsBannerPrincipal(URL, TrackText, Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion,
                     'creative': 'Banner'
                 }]
            }
        }
    });

    if (URL > 0) {
        var id = URL;
        var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
        window.open(url, '_blank');
    } else {
        window.open(URL, '_blank');
    }
    return false;
};
function SetGoogleAnalyticsBannerInferiores(URL, TrackText, Tipo, Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': 'home-inferior-'+Posicion
                 }]
            }
        }
    });
    if (Tipo == "1")
        window.location.href = URL;
    else
        var id = URL;
    if (URL > 0) {
        var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
        window.open(url, '_blank');
    } else {
        window.open(URL, '_blank');
    }
    return false;
};
function SetGoogleAnalyticsPromotionClick(Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion,
                     'creative': 'Producto'
                 }]
            }
        }
    });

    return false;
};

/* Métodos Mis Datos */
function CargarMisDatos() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Bienvenida/JSONGetMisDatos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            var temp = data.lista;
            $('#hdn_NombreArchivoContratoMD').val(temp.NombreArchivoContrato);
            $('#hdn_CodigoUsuarioMD').val(temp.CodigoUsuario);
            $('#hdn_CorreoMD').val(temp.EMail);
            $('#hdn_NombreCompletoMD').val(temp.NombreCompleto);
            $('#codigoUsurioMD').html(temp.CodigoUsuario);
            $('#nombresUsuarioMD').html(temp.NombreCompleto);
            $('#txtSobrenombreMD').val(temp.Sobrenombre);
            $('#txtEMailMD').val(temp.EMail);
            $('#txtTelefonoMD').val(temp.Telefono);
            $('#txtCelularMD').val(temp.Celular);
            $('#popupMisDatos').show();
            closeWaitingDialog();
        },
        error: function (error) {
            //console.log(error);
        }
    });
};
function CambiarContrasenia() {
    var oldPassword = $("#txtContraseniaAnterior").val();
    var newPassword01 = $("#txtNuevaContrasenia01").val();
    var newPassword02 = $("#txtNuevaContrasenia02").val();
    var vMessage = "";

    if (oldPassword == "")
        vMessage += "- Debe ingresar la Contraseña Anterior.\n";

    if (newPassword01 == "")
        vMessage += "- Debe ingresar la Nueva Contraseña.\n";

    if (newPassword02 == "")
        vMessage += "- Debe repetir la Nueva Contraseña.\n";

    if (newPassword01.length <= 3)
        vMessage += "- La Nueva Contraseña debe de tener mas de 6 caracteres.\n";

    if (newPassword01 != "" && newPassword02 != "") {
        if (newPassword01 != newPassword02)
            vMessage += "- Los campos de la nueva contraseña deben ser iguales, verifique.\n";
    }

    if (vMessage != "") {
        alert(vMessage);
        return false;
    } else {

        var item = {
            OldPassword: oldPassword,
            NewPassword: newPassword01
        };

        waitingDialog({});
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'MisDatos/CambiarContrasenia',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        if (data.message == "0") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("La contraseña anterior ingresada es inválida");
                        } else if (data.message == "1") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente.");
                        } else if (data.message == "2") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            $(".campos_cambiarContrasenia").fadeOut(200);
                            $(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
                            $(".campos_actualizarDatos").delay(200);
                            $(".campos_actualizarDatos").fadeIn(200);
                            alert("Se cambió satisfactoriamente la contraseña.");
                        }
                        return false;
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("Error en el Cambio de Contraseña");
                }
            }
        });
    }
}
function ActualizarMD() {
    if (jQuery.trim($('#txtEMailMD').val()) == "") {
        $('#txtEMailMD').focus();
        alert("Debe ingresar EMail.\n");
        return false;
    }
    if (!validateEmail(jQuery.trim($('#txtEMailMD').val()))) {
        $('#txtEMailMD').focus();
        alert("El formato del correo electrónico ingresado no es correcto.\n");
        return false;
    }
    if (($('#txtTelefonoMD').val() == null || $.trim($('#txtTelefonoMD').val()) == "") &&
        ($('#txtCelularMD').val() == null || $.trim($('#txtCelularMD').val()) == "")) {
        $('#txtTelefonoMD').focus();
        alert('Debe ingresar al menos un número de contacto: celular o teléfono.');
        return false;
    }

    if (!$('#chkAceptoContratoMD').is(':checked')) {
        alert('Debe aceptar los terminos y condiciones para poder actualizar sus datos.');
        return false;
    }

    waitingDialog({});
    var item = {
        CodigoUsuario: jQuery('#hdn_CodigoUsuarioMD').val(),
        EMail: $.trim(jQuery('#txtEMailMD').val()),
        Telefono: jQuery('#txtTelefonoMD').val(),
        Celular: jQuery('#txtCelularMD').val(),
        Sobrenombre: jQuery('#txtSobrenombreMD').val(),
        CorreoAnterior: $.trim(jQuery('#hdn_CorreoMD').val()),
        NombreCompleto: jQuery('#hdn_NombreCompletoMD').val(),
        CompartirDatos: false,
        AceptoContrato: $('#chkAceptoContratoMD').is(':checked')
    };
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisDatos/ActualizarDatos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    $('#popupMisDatos').hide();
                    if (contadorFondoPopUp == 1) {
                        $("#fondoComunPopUp").hide();
                    }
                    contadorFondoPopUp--;
                    alert(data.message);
                } else {
                    $('#popupMisDatos').hide();
                    if (contadorFondoPopUp == 1) {
                        $("#fondoComunPopUp").hide();
                    }
                    contadorFondoPopUp--;
                    alert(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (contadorFondoPopUp == 1) {
                    $("#fondoComunPopUp").hide();
                }
                contadorFondoPopUp--;
                alert("ERROR");
            }
        }
    });
}
function ValidateOnlyNums(id) {
    return $("#" + id).val($("#" + id).val().replace(/[^\d]/g, ""));
}
function DownloadAttachPDFMD(requestedFile) {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    iframe_.setAttribute("src", baseUrl + 'WebPages/DownloadPDF.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer

        iframe_.onreadystatechange = function () {

            switch (this.readyState) {
                case "loading":
                    waitingDialog({});
                    break;
                case "complete":
                case "interactive":
                case "uninitialized":
                    closeWaitingDialog();
                    break;
                default:
                    closeWaitingDialog();
                    break;
            }
        };
    }
    else {
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
}
function DownloadAttachContratoActualizarDatos() {
    var archivoMD = $('#hdn_NombreArchivoContratoMD').val();
    var requestedFile = "/Content/FAQ/" + archivoMD + ".pdf";
    DownloadAttachPDFMD(requestedFile);
}

/* Métodos Mis Cursos */
function CargarMisCursos() {

    $(window).scroll(function () {
        if ($("#seccionMiAcademiaLiquidacion").offset().top - $(window).scrollTop() < $("#seccionMiAcademiaLiquidacion").height()) {
            porcentajesCursos();
        }
    });

    if (UrlImgMiAcademia != null) {
        $('.item_video_left').find('.item_video').css('background', 'url(' + UrlImgMiAcademia + ' ) no-repeat center center');
    }
    $('#divSinTutoriales').hide();
    $('#divTutorialesV').hide();

    $('#divMisCursos').html('<div style="text-align: center;">Cargando Mis Cursos ...<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: baseUrl + 'MiAcademia/GetMisCursos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                if (paisISO == 'VE') {
                    SetHandlebars("#miscursosv-template", response.data, "#divMisCursosV");
                    $('#divTutoriales').hide();
                    $('#divTutorialesV').show();
                }
                else {
                    SetHandlebars("#miscursos-template", response.data, "#divMisCursos");
                    $('#divTutoriales').show();
                }
            }
            else {
                //$('#divMisCursos').html('<div style="text-align: center;">En este momento los talleres no se encuentran disponibles. Vuelve a revisar tus talleres más tarde.</div>');
                $('#divTutoriales').hide();
                $('#divSinTutoriales').show();
            }
        },
        error: function (error) {
            //$('#divMisCursos').html('<div style="text-align: center;">Ocurrio un error al cargar los cursos.</div>');
            $('#divTutoriales').hide();
            $('#divSinTutoriales').show();
        }
    });
};
function porcentajesCursos() {
    // Función para animación y características de carga circular de Cursos Academia
    $(".porcentaje_curso").addClass("mostrarPorcentajes");

    $('.porcentaje_cursosAcademia').easyPieChart({
        barColor: isEsika == true ? '#e81c36' : '#642f80',
        trackColor: '#f0f0f0',
        scaleColor: 'transparent',
        animate: 1000,
        size: 55,
        lineWidth: 3,
        onStep: function (value) {
            this.$el.find('span').text(Math.round(value));
        },
        onStop: function (value, to) {
            this.$el.find('span').text(Math.round(to));
        }
    });
};
function GetCursoMarquesina(id) {
    var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
    window.open(url, '_blank');
}

// Métodos ActualizarDatos
function ActualizarDatos() {
    var Result = false;
    var ClaveSecreta = $('#txtActualizarClaveSecreta').val();
    var ConfirmarClaveSecreta = $('#txtConfirmarClaveSecreta').val();
    var telefono = $('#txtTelefono').val();
    var celular = $('#txtCelular').val();
    var correoElectronico = $('#txtEMail').val();
    var confirmacionCorreoElectronico = $('#txtConfirmarEMail').val();

    if ((telefono == '' || telefono == null) &&
        celular == '' || celular == null) {
        alert('Debe ingresar al menos un número de contacto: celular o teléfono.');
        return false;
    }
    if (correoElectronico == '') {
        alert('Debe ingresar el Correo Electrónico');
        return false;
    }

    if (confirmacionCorreoElectronico == '') {
        alert('Debe ingresar la Confirmación Correo Electrónico');
        return false;
    }

    if (correoElectronico != confirmacionCorreoElectronico) {
        alert('Los correos electrónicos ingresados no coinciden');
        return false;
    }

    if (!validateEmail(jQuery.trim($('#txtEMail').val()))) {
        $('#txtEMail').focus();
        alert('El formato del correo electrónico ingresado no es correcto.');
        return false;
    }

    if (ClaveSecreta.length > 0 && ClaveSecreta.length <= 6) {
        alert('Las clave debe tener mas de 6 caracteres.');
        return false;
    }
    if (ClaveSecreta != ConfirmarClaveSecreta) {
        alert('Las claves ingresadas no coinciden');
        return false;
    }

    if ($('#chkAceptoContrato').is(':checked') == false) {
        alert('Debe aceptar los términos y condiciones');
        return false;
    }

    var item = {
        Telefono: jQuery('#txtTelefono').val(),
        Celular: jQuery('#txtCelular').val(),
        Email: $.trim(jQuery('#txtEMail').val()),
        ActualizarClave: ClaveSecreta,
        ConfirmarClave: ConfirmarClaveSecreta,
        CorreoAnterior: jQuery('#hdn_Correo').val(),
        AceptoContrato: $('#chkAceptoContrato').is(':checked')
    };
    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/Registrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                Result = data.success;

                if (data.message && data.message != "" && data.message != null) {
                    var mensajeHtml = "";
                    $.each(data.message.split("-"), function (i, v) {
                        mensajeHtml += v + "<br/>"
                    });

                    $('#popupActualizarMisDatos').hide();
                    if (contadorFondoPopUp == 1) {
                        $("#fondoComunPopUp").hide();
                    }
                    contadorFondoPopUp--;
                    alert_unidadesAgregadas(mensajeHtml, 1);
                }
                if (data.success) {
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Formulario',
                        'action': 'Actualizar datos',
                        'label': data.message
                    });
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                Result = false;
                closeWaitingDialog();
                if (data.message && data.message != "" && data.message != null) {
                    var aMensaje = data.message.split("-");
                    var mensajeHtml = "";
                    $.each(aMensaje, function (i, v) {
                        mensajeHtml += v + "<br/>"
                    });
                    alert(mensajeHtml);
                }
                $('#popupActualizarMisDatos').hide();
            }
        }
    });

    return Result;
};
function DownloadAttachPDFTerminos() {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    var requestedFile = '/Content/FAQ/' + viewBagContratoActualizarDatos + '.pdf';
    iframe_.setAttribute("src", baseUrl + 'WebPages/DownloadPDF.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
        iframe_.onreadystatechange = function () {
            switch (this.readyState) {
                case "loading":
                    waitingDialog({});
                    break;
                case "complete":
                case "interactive":
                case "uninitialized":
                    closeWaitingDialog();
                    break;
                default:
                    closeWaitingDialog();
                    break;
            }
        };
    }
    else {
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
};
function CerrarPopupActualizacionDatos() {
    var ClaveSecreta = $('#txtActualizarClaveSecreta').val();
    var ConfirmarClaveSecreta = $('#txtConfirmarClaveSecreta').val();

    if (ClaveSecreta != ConfirmarClaveSecreta) {
        alert('Las claves ingresadas no coinciden');
        return false;
    }
    var item = {
        Telefono: jQuery('#txtTelefono').val(),
        Celular: jQuery('#txtCelular').val(),
        Email: jQuery('#txtEMail').val(),
        ActualizarClave: ClaveSecreta,
        ConfirmarClave: ConfirmarClaveSecreta,
        CorreoAnterior: jQuery('#hdn_Correo').val(),
    };
    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/Cancelar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                $('#popupActualizarMisDatos').hide();
                if (contadorFondoPopUp == 1) {
                    $("#fondoComunPopUp").hide();
                }
                contadorFondoPopUp--;
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                $('#popupActualizarMisDatos').hide();
                alert(data.message);
            }
        }
    });
};
function ValidateOnlyNums(id) {
    return $("#" + id).val($("#" + id).val().replace(/[^\d]/g, ""));
};

// Métodos ActualizarDatos México
function ActualizarDatosMexico() {
    var Result = false;
    var m_nombre = $('#m_txtNombre').val();
    var m_apellidos = $('#m_txtApellidos').val();
    var m_telefonoCasa = '';
    var m_telefonoCelular = '';
    if ($('#m_txtTelefonoCasa').val() != '' && $('#m_txtTelefonoCasa').val() != $('#m_txtTelefonoCasa').attr('placeholder')) {
        m_telefonoCasa = $('#m_txtTelefonoCasa').val();
    }
    if ($('#m_txtTelefonoCelular').val() != '' && $('#m_txtTelefonoCelular').val() != $('#m_txtTelefonoCelular').attr('placeholder')) {
        m_telefonoCelular = $('#m_txtTelefonoCelular').val();
    }

    var m_email = $('#m_txtEMail').val();
    if (typeof (m_email) == "undefined")
        m_email = ''
    var m_error = 0;
    var m_mensaje = "<font color=red>";

    $('.requerido').each(function (i, elem) {
        if ($(elem).val() == '' || typeof ($(elem).val()) == 'undefined') {
            $(elem).css({ 'border': '1px solid red' });
            m_error++;
            if (elem.id == 'm_txtNombre') {
                m_mensaje += '* Debe ingresar su nombre<br />';
            }
            if (elem.id == 'm_txtApellidos') {
                m_mensaje += '* Debe ingresar su apellido<br />';
            }
            if (elem.id == 'm_txtTelefonoCasa') {
                m_mensaje += '* Debe ingresar teléfono de casa<br />';
            }
            if (elem.id == 'm_txtTelefonoCelular') {
                m_mensaje += '* Debe ingresar teléfono celular<br />';
            }
            if (elem.id == 'm_txtEMail') {
                m_mensaje += '* Debe ingresar correo electrónico<br />';
            }

        } else {
            if (elem.id == 'm_txtTelefonoCasa') {
                $(elem).css({ 'border': '1px solid red' });
                if (m_telefonoCasa == '') {
                    m_error++;
                    m_mensaje += '* Debe ingresar teléfono de casa<br />';
                } else
                    if ($(elem).val().length < 10) {

                        m_error++;
                        m_mensaje += '* Debe digitar 10 dígitos en el campo teléfono de casa<br />';
                    }
                    else {
                        $(elem).css({ 'border': '' });
                    }
            } else {
                if (elem.id == 'm_txtTelefonoCelular') {
                    $(elem).css({ 'border': '1px solid red' });
                    if (m_telefonoCelular == '') {
                        m_mensaje += '* Debe ingresar teléfono celular<br />';
                        m_error++;
                    }
                    else
                        if ($(elem).val().length < 10) {
                            m_error++;
                            m_mensaje += '* Debe digitar 10 dígitos en el campo teléfono celular<br />';
                        }
                        else {
                            $(elem).css({ 'border': '' });
                        }
                } else {
                    $(elem).css({ 'border': '' });
                }
            }
        }
    });

    if (m_error > 0) {
        m_mensaje += '</font><br />';
    }

    if (m_email != '') {
        var emailReg = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
        if (emailReg.test(m_email) == false) {
            $('#m_txtEMail').css({ 'border': '1px solid red' });
            m_mensaje += '<font color=red>* Formato  de correo electrónico No Válido</font><br />';
            m_error++;
        }
        else {
            $('#m_txtEMail').css({ 'border': '' });
        }
    }

    if (m_error > 0) {
        $('#aviso').html(m_mensaje);
    }
    else {
        $('#aviso').html('');

        var item = {
            m_Nombre: m_nombre, m_Apellidos: m_apellidos, Telefono: m_telefonoCasa, Celular: m_telefonoCelular, Email: m_email
        };

        waitingDialog({});

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'ActualizarDatos/RegistrarMexico',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    Result = data.success;
                    if (data.success) {
                        alert_msg_pedido(data.message)
                        CerrarPopupActualizacionDatosMexico();
                        dataLayer.push({
                            'event': 'virtualEvent',
                            'category': 'Formulario',
                            'action': 'Actualizar datos',
                            'label': data.message
                        });
                    }
                    else {
                        $('#aviso').html(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    Result = false;
                    closeWaitingDialog();
                    $('#aviso').html(data.message);
                }
            }
        });
    }

    return Result;
}
function CerrarPopupActualizacionDatosMexico() {
    $('#popupActualizarMisDatosMexico').hide();
    if (contadorFondoPopUp == 1) {
        $("#fondoComunPopUp").hide();
    }
    contadorFondoPopUp--;
}

// Métodos Contrato
function AbrirAceptacionContrato() {
    if (viewBagPaisID == 4) { // Colombia
        if (viewBagIndicadorContrato == 0) {
            var AlreadyViewContrato = sessionIsContrato;
            if (AlreadyViewContrato == 1) {
                if (contadorFondoPopUp == 0) {
                    $("#fondoComunPopUp").show();
                }
                $("#popupAceptacionContrato").show();
                contadorFondoPopUp++;
            }
        }
    }
}
function AceptarContrato() {
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarContrato",
        data: JSON.stringify({ checkAceptar: 1 }),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (!data.success) {
                    alert(data.message);
                    if (data.extra != "nocorreo") return;
                }

                $('#popupAceptacionContrato').hide();
                contadorFondoPopUp--;
                if (viewBagCambioClave == 0) {
                    $("#popupActualizarMisDatos").show();
                    contadorFondoPopUp++;
                }
                if (contadorFondoPopUp == 0) $("#fondoComunPopUp").hide();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error inesperado al momento de registrar los datos. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
};
function DownloadAttachPDF() {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    var requestedFile = urlContratoCOpdf;
    iframe_.setAttribute("src", baseUrl + 'WebPages/DownloadPDF.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
        iframe_.onreadystatechange = function () {
            switch (this.readyState) {
                case "loading":
                    waitingDialog({});
                    break;
                case "complete":
                case "interactive":
                case "uninitialized":
                    closeWaitingDialog();
                    break;
                default:
                    closeWaitingDialog();
                    break;
            }
        };
    }
    else {
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
};

// Métodos DemandaAnticipada
function MostrarDemandaAnticipada() {
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/ValidacionConsultoraDA",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $('#fechaHasta').text(data.mensajeFechaDA);
                    $('#fechaLuego').text(data.mensajeFechaDA);
                    if (contadorFondoPopUp == 0) {
                        $("#fondoComunPopUp").show();
                    }
                    $("#popupDemandaAnticipada").show();
                    contadorFondoPopUp++;
                }
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (tipo == 1) {
                    alert("Ocurrió un error al validar demanda anticipada.");
                } else {
                    alert("Ocurrió un error al validar la demanda anticipada.");
                }
            }
        }
    });
};
function AceptarDemandaAnticipada() {
    InsertarDemandaAnticipada(1);
};
function CancelarDemandaAnticipada() {
    InsertarDemandaAnticipada(0);
};
function InsertarDemandaAnticipada(tipo) {
    waitingDialog({});

    var params = { tipoConfiguracion: tipo };
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/InsConfiguracionConsultoraDA",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $("#popupDemandaAnticipada").hide();
                    if (contadorFondoPopUp == 1) {
                        $("#fondoComunPopUp").hide();
                    }
                    contadorFondoPopUp--;
                    location.href = baseUrl + 'Login/LoginCargarConfiguracion?paisID=' + data.paisID + '&codigoUsuario=' + data.codigoUsuario;
                }
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (tipo == 1) {
                    alert("Ocurrió un error al aceptar la demanda anticipada.");
                } else {
                    alert("Ocurrió un error al cancelar la demanda anticipada.");
                }
            }
        }
    });
};

// Métodos Comunicado
function CrearPopupComunicado() {
    $('#divComunicado').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 650,
        height: 600,
        draggable: true,

        buttons: {
            "Aceptar": function () {
                AceptarComunicado();
            }
        },
        close: function (event, ui) {
            $('#divComunicado').dialog('close');
        }
    });
};
function AbrirComunicado() {
    if (viewBagVisualizoComunicado == "0") {
        showDialog("divComunicado");
        $("#divComunicado").siblings(".ui-dialog-titlebar").hide();
    }
};
function AceptarComunicado() {
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarComunicado",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                $('#divComunicado').dialog('close');
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error al aceptar el comunicado.");
            }
        }
    });
};

// Métodos Flexipago
function AbrirPopupFlexipago() {
    if (viewBagPaisID == 4 || viewBagPaisID == 3) { // Colombia || Chile
        if (viewBagInvitacionRechazada == "False" || viewBagInvitacionRechazada == "0" || viewBagInvitacionRechazada == "") {
            if (viewBagInscritaFlexipago == "0") {
                if (viewBagIndicadorFlexiPago == "1" && viewBagCampanaInvitada != "0") {
                    if ((parseInt(viewBagCampaniaActual) - parseInt(viewBagCampanaInvitada)) >= parseInt(viewBagNroCampana)) {
                        if (contadorFondoPopUp == 0) {
                            $("#fondoComunPopUp").show();
                        }
                        $('#popupInvitaionFlexipago').show();
                        contadorFondoPopUp++;
                    }
                }
            }
        }
    }
};
function RechazarInvitacionFlex() {
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/RechazarInvitacionFlexipago',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: null,
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                $('#popupInvitaionFlexipago').hide();
                if (contadorFondoPopUp == 1) {
                    $("#fondoComunPopUp").hide();
                }
                contadorFondoPopUp--;
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $('#popupInvitaionFlexipago').hide();
                if (contadorFondoPopUp == 1) {
                    $("#fondoComunPopUp").hide();
                }
                contadorFondoPopUp--;
                closeWaitingDialog();
                alert(data.message);
            }
        }
    });
    return false;
};
function InscribeteFlex() {
    var cc = (viewBagCodigoConsultora);
    var ca = (viewBagCampaniaActual);
    var pp = (viewBagPrefijoPais);
    var url = (viewBagUrlFlexipagoCL);
    if (pp.toString() == 'CL') {
        window.open(url + "/inscripcion.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    else {
        window.open("http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/inscripcion.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    return false;
};
function ConoceFlex() {
    var cc = (viewBagCodigoConsultora);
    var ca = (viewBagCampaniaActual);
    var pp = (viewBagPrefijoPais);
    var url = (viewBagUrlFlexipagoCL);
    if (pp.toString() == 'CL') {
        window.open(url + "/index.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    else {
        window.open("http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/index.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    return false;
};

// Métodos Comunicado Visualización
function CrearPopupComunicadoVisualizacion() {
    $('#divComunicadoVisualizacion').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 650,
        position: ['center', 22],
        draggable: true,
        close: function (event, ui) {
            $('#divComunicadoVisualizacion').dialog('close');
        }
    });
};
function AbrirComunicadoVisualizacion() {
    if (viewBagVisualizoComunicadoConfigurable == "0") {
        showDialog("divComunicadoVisualizacion");
        $("#divComunicadoVisualizacion").siblings(".ui-dialog-titlebar").hide();
    }
};
function AceptarComunicadoVisualizacion() {
    if ($('#chkMostrarComunicado').is(':checked')) {
        waitingDialog({});
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/AceptarComunicadoVisualizacion",
            contentType: 'application/json',
            success: function (data) {
                if (checkTimeout(data)) {
                    $('#divComunicadoVisualizacion').dialog('close');
                    closeWaitingDialog();
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("Ocurrió un error al aceptar el comunicado.");
                }
            }
        });
    }

    $("#divComunicadoVisualizacion").dialog('close');
};

// Métodos de marcaciones
function RedirectPagaEnLineaAnalytics() {
    if (ViewBagRutaChile != "") {
        window.open(ViewBagRutaChile + viewBagUrlChileEncriptada, "_blank");
    }
    else {
        window.open('https://www.belcorpchile.cl/BP_Servipag/PagoConsultora.aspx?c=' + viewBagUrlChileEncriptada, "_blank");
    }
};

// Métodos Suenios Navidad
function MostrarCajaSuenioNavidad() {
    $("#txtSuenioNavidad").focus();
    $("#imgSuenioNavidad").fadeOut("fast", function () {
        $("#imgSuenioNavidad2").fadeIn("fast");
    });
    $("#registroSuenioNavidad").show();
    scrollWin();
}
function scrollWin() {
    $('html,body').animate({
        scrollTop: $("#registroSuenioNavidad").offset().top - 500
    }, 500);
}
function cerrarSueniosNavidad() {
    $('#idSueniosNavidad').dialog('close');
}
function cerrarSuenioConfirmacion() {
    $('#divSuenioConfirmacion').dialog('close');
}
function AgregarSuenio() {
    var descSuenio = $("#txtSuenioNavidad").val();

    if ($.trim(descSuenio) == "") {
        alert_msgPedidoBanner("Ingrese una descripción");
        return false;
    }

    var params = { descripcion: descSuenio };
    $('#idSueniosNavidad').dialog('close');
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/RegistrarSuenioNavidad",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    //alert_msgPedidoBanner(data.message);
                    showDialog("divSuenioConfirmacion");
                    closeWaitingDialog();
                } else {
                    alert_msgPedidoBanner(data.message);
                    closeWaitingDialog();
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert_msgPedidoBanner("Ocurrió un error inesperado al momento de registrar los datos. Consulte con su administrador del sistema para obtener mayor información");
                async: false,
                        closeWaitingDialog();
            }
        }
    });
}

// Catalogo Personalizado
//function ObtenerOfertaRevista(item) {
//    var $contenedor = item;
//    var cuv = $contenedor.find('.hdItemCuv').val();
//    var tipoOfertaRevista = $contenedor.find('.hdItemTipoOfertaRevista').val().trim();

//    var obj = {
//        UrlImagen: $contenedor.find('.producto_img_home>img').attr('src'),
//        CUV: $contenedor.find('.hdItemCuv').val(),
//        TipoOfertaSisID: $contenedor.find('.hdItemTipoOfertaSisID').val(),
//        ConfiguracionOfertaID: $contenedor.find('.hdItemConfiguracionOfertaID').val(),
//        IndicadorMontoMinimo: $contenedor.find('.hdItemIndicadorMontoMinimo').val(),
//        MarcaID: $contenedor.find('.hdItemMarcaID').val(),
//        PrecioCatalogo: $contenedor.find('.hdItemPrecioUnidad').val(),
//        Descripcion: $contenedor.find('.hdItemDescripcionProd').val(),
//        DescripcionCategoria: $contenedor.find('.hdItemDescripcionCategoria').val(),
//        DescripcionMarca: $contenedor.find('.hdItemDescripcionMarca').val(),
//        DescripcionEstrategia: $contenedor.find('.hdItemDescripcionEstrategia').val()
//    };
//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'CatalogoPersonalizado/ObtenerOfertaRevista',
//        dataType: 'json',
//        data: JSON.stringify({ cuv: cuv, tipoOfertaRevista: tipoOfertaRevista }),
//        contentType: 'application/json; charset=utf-8',
//        success: function (response) {
//            if (response.success) {
//                response.data.dataPROL.Simbolo = viewBagSimbolo;
//                var settings = $.extend({}, response.data.dataPROL, obj);
//                settings.productoRevista = response.data.producto;
//                TrackingJetloreView(cuv, $("#hdCampaniaCodigo").val())
//                if (response.data.dataPROL != undefined && response.data.dataPROL != null) {
//                    switch (settings.tipo_oferta) {
//                        case '003':
//                            settings.precio_catalogo = DecimalToStringFormat(settings.precio_catalogo);
//                            settings.precio_revista = DecimalToStringFormat(settings.precio_revista);
//                            settings.ganancia = DecimalToStringFormat(settings.ganancia);
//                            var html = SetHandlebars("#template-mod-ofer1", settings);
//                            $('.mod-ofer1').html(html).show();
//                            break;
//                        case '048':
//                            if (settings.lista_ObjNivel.length > 0) {
//                                settings.lista_ObjNivel = RemoverRepetidos(settings.lista_ObjNivel);
//                                var html = SetHandlebars("#template-mod-ofer2", settings);
//                                $('.mod-ofer2').html(html).show();
//                            }
//                            else if (settings.lista_oObjPack.length > 0) {
//                                settings.lista_oObjPack = RemoverRepetidos(settings.lista_oObjPack);
//                                var html = SetHandlebars("#template-mod-ofer3", settings);
//                                $('.mod-ofer3').html(html).show();
//                            }
//                            break;
//                    }
//                } else {
//                    console.log(response.message);
//                }
//                closeWaitingDialog();
//            }
//        },
//        error: function (response, error) {
//            console.log(error);
//            closeWaitingDialog();
//        }
//    });
//}
//function CargarCatalogoPersonalizado() {
//    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
//    if (cataPer != "1" && cataPer != "2") {
//        $("#divMainCatalogoPersonalizado").remove();
//        return false;
//    }

//    var esCatalogoPersonalizadoZonaValida = $("#hdEsCatalogoPersonalizadoZonaValida").val();
//    if (esCatalogoPersonalizadoZonaValida != "True") {
//        $("#divMainCatalogoPersonalizado").remove();
//        return false;
//    }

//    $('#divCatalogoPersonalizado').html('<div style="text-align: center; min-height:150px;"><br><br><br><br>Cargando Catalogo Personalizado<br><img src="' + urlLoad + '" /></div>');
//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'CatalogoPersonalizado/ObtenerProductosCatalogoPersonalizadoHome',
//        dataType: 'json',
//        data: null,
//        contentType: 'application/json; charset=utf-8',
//        success: function (data) {
//            data.data = data.data || new Array();
//            if (data.success) {
//                $("#divCatalogoPersonalizado").html("");
//                $("#linea_separadoraCP").show();
//                if (data.data.length > 0) {
//                    SetHandlebars("#template-catalogopersonalizado", data.data, "#divCatalogoPersonalizado");
//                }
//            }
//            else {
//                data.data = new Array();
//            }

//            if (data.data.length == 0) {
//                $("#divMainCatalogoPersonalizado").remove();
//                $("#linea_separadoraCP").hide();
//            }
//        },
//        error: function (data, error) {
//            closeWaitingDialog();
//        }
//    });
//}
//function AgregarProductoCatalogoPersonalizado(item) {
//    waitingDialog();

//    var divPadre = item;
//    var attItem = $(item).attr("data-item") || "";
//    if (attItem == "") {
//        divPadre = $(item).parents("[data-item]").eq(0);
//    }
    
//    var cuv = $(divPadre).find(".hdItemCuv").val();
//    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
//    var tipoOfertaSisID = $(divPadre).find(".hdItemTipoOfertaSisID").val();
//    var configuracionOfertaID = $(divPadre).find(".hdItemConfiguracionOfertaID").val();
//    var indicadorMontoMinimo = $(divPadre).find(".hdItemIndicadorMontoMinimo").val();
//    var tipo = $(divPadre).find(".hdItemTipo").val();
//    var marcaID = $(divPadre).find(".hdItemMarcaID").val();
//    var precioUnidad = $(divPadre).find(".hdItemPrecioUnidad").val();
//    var descripcionProd = $(divPadre).find(".hdItemDescripcionProd").val();
//    var pagina = $(divPadre).find(".hdItemPagina").val();
//    var descripcionCategoria = $(divPadre).find(".hdItemDescripcionCategoria").val();
//    var descripcionMarca = $(divPadre).find(".hdItemDescripcionMarca").val();
//    var descripcionEstrategia = $(divPadre).find(".hdItemDescripcionEstrategia").val();
//    var OrigenPedidoWeb = $(divPadre).find(".OrigenPedidoWeb").val();

//    if (!isInt(cantidad)) {
//        alert_msg_pedido("La cantidad ingresada debe ser un número mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    if (cantidad <= 0) {
//        alert_msg_pedido("La cantidad ingresada debe ser mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    var model = {
//        TipoOfertaSisID: tipoOfertaSisID,
//        ConfiguracionOfertaID: configuracionOfertaID,
//        IndicadorMontoMinimo: indicadorMontoMinimo,
//        MarcaID: marcaID,
//        Cantidad: cantidad,
//        PrecioUnidad: precioUnidad,
//        CUV: cuv,
//        Tipo: tipo,
//        DescripcionProd: descripcionProd,
//        Pagina: pagina,
//        DescripcionCategoria: descripcionCategoria,
//        DescripcionMarca: descripcionMarca,
//        DescripcionEstrategia: descripcionEstrategia,
//        EsSugerido: false,
//        OrigenPedidoWeb: OrigenPedidoWeb
//    };

//    var imagenProducto = $('#imagenAnimacion>img', item);

//    if (imagenProducto.length > 0) {
//        var carrito = $('.campana');

//        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

//        $(".transicion").css({
//            'height': imagenProducto.css("height"),
//            'width': imagenProducto.css("width"),
//            'top': imagenProducto.offset().top,
//            'left': imagenProducto.offset().left,
//        }).animate({
//            'top': carrito.offset().top - 60,
//            'left': carrito.offset().left + 100,
//            'height': carrito.css("height"),
//            'width': carrito.css("width"),
//            'opacity': 0.5
//        }, 450, 'swing', function () {
//            $(this).animate({
//                'top': carrito.offset().top,
//                'opacity': 0,
//            }, 150, 'swing', function () {
//                $(this).remove();
//            });
//        });
//    }

//    AgregarProducto('Insert', model, function () { $(divPadre).find(".product-add").show(); });
//    TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
//}
//function AgregarProducto(url, item, otraFunct) {
//    waitingDialog();

//    tieneMicroefecto = true;

//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'Pedido/' + url,
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(item),
//        async: true,
//        success: function (data) {
//            if (data.success == true) {
//                ActualizarGanancia(data.DataBarra);                
//                CargarResumenCampaniaHeader(true);

//                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);

//                if (typeof (otraFunct) == 'function') {
//                    setTimeout(otraFunct, 50);
//                }
//                else if (typeof (otraFunct) == 'string') {
//                    setTimeout(otraFunct, 50);
//                }
//            }
//            else {
//                alert_msg_pedido(data.message);
//            }
//            closeWaitingDialog();
//        },
//        error: function (data, error) {
//            tieneMicroefecto = false;
//            AjaxError(data, error);
//        }
//    });
//}
// Fin Catalogo Personalizado

//Google Analytics
function TagManagerCarruselInicio(arrayItems) {
    var cantidadRecomendados = $('#divCarruselHorizontal').find(".slick-active").length;

    var arrayEstrategia = [];
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = arrayItems[i];
        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – Home',
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}
function TagManagerClickAgregarProducto() {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Ofertas para ti – Home' },
                'products': [
                    {
                        'name': $("#txtCantidadZE").attr("est-descripcion"),
                        'price': $("#txtCantidadZE").attr("est-precio2"),
                        'brand': $("#txtCantidadZE").attr("est-descripcionMarca"),
                        'id': $("#txtCantidadZE").attr("est-cuv2"),
                        'category': 'NO DISPONIBLE',
                        'variant': $("#txtCantidadZE").attr("est-descripcionEstrategia"),
                        'quantity': parseInt($("#txtCantidadZE").val()),
                        'position': parseInt($("#txtCantidadZE").attr("est-posicion"))
                    }
                ]
            }
        }
    });
}
function TagManagerCarruselPrevia() {
    var posicionPrimerActivo = $($('#divCarruselHorizontal').find(".slick-active")[0]).find('.PosicionEstrategia').val();
    var posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length -1 : posicionPrimerActivo - 2;
    var recomendado = arrayOfertasParaTi[posicionEstrategia];
    var arrayEstrategia = new Array();


    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Ofertas para ti – Home',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': 'Ofertas para ti',
        'label': 'Ver anterior'
    });

}
function TagManagerCarruselSiguiente() {
    var posicionUltimoActivo = $($('#divCarruselHorizontal').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
    var posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
    var recomendado = arrayOfertasParaTi[posicionEstrategia];
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Ofertas para ti – Home',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': 'Ofertas para ti',
        'label': 'Ver siguiente'
    });

}

function TagManagerCarruselLiquidacionesInicio(arrayItems) {
    var cantidadRecomendados = $('#divCarruselLiquidaciones').find(".slick-active").length;

    var arrayEstrategia = [];
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = arrayItems[i];
        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV,
            'price': recomendado.PrecioOferta.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Liquidación Web – Home',
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}
function TagManagerClickAgregarProductoLiquidacion(item) {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Liquidación Web – Home' },
                'products': [
                    {
                        'name': item.descripcionProd,
                        'price': item.PrecioUnidad,
                        'brand': item.descripcionMarca,
                        'id': item.CUV,
                        'category': 'NO DISPONIBLE',
                        'variant': item.descripcionEstrategia,
                        'quantity': parseInt(item.Cantidad),
                        'position': parseInt(item.Posicion)
                    }
                ]
            }
        }
    });
}
function TagManagerCarruselLiquidacionesPrevia() {
    var posicionEstrategia = $($('#divCarruselLiquidaciones').find(".slick-active")).find('#Posicion').val() - 2;
    var recomendado = arrayLiquidaciones[posicionEstrategia];
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV,
        'price': recomendado.PrecioOferta.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Liquidacion Web – Home',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': 'Liquidacion Web',
        'label': 'Ver anterior'
    });

}
function TagManagerCarruselLiquidacionesSiguiente() {
    var posicionEstrategia = $($('#divCarruselLiquidaciones').find(".slick-active")).find('#Posicion').val();

    if (posicionEstrategia != arrayLiquidaciones.length) {
        var recomendado = arrayLiquidaciones[posicionEstrategia];
        var arrayEstrategia = new Array();

        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV,
            'price': recomendado.PrecioOferta.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Liquidacion Web – Home',
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);

        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Home',
            'action': 'Liquidacion Web',
            'label': 'Ver siguiente'
        });
    } else {
        dataLayer.push({
            'event': 'virtualEvent', 
            'category': 'Home', 
            'action': 'Liquidacion Web',
            'label': 'Ver más' 
        });
    }
}

function EsconderFlechasCarouseLiquidaciones(accion) {
    var itemsLength = $('#divCarruselLiquidaciones').find('.slick-slide').length;
    var indexActive = $($('#divCarruselLiquidaciones').find('.slick-active')).attr('data-slick-index');

    if (accion == 'prev') {
        if (Number(indexActive) - 1 == 0) {
            $('.js-slick-prev-liq').hide();
        } else {
            $('.js-slick-next-liq').show();
        }
        
    } else if (accion == 'next') {
        if (Number(indexActive) + 1 == Number(itemsLength) - 1) {
            $('.js-slick-next-liq').hide();
        } else {
            $('.js-slick-prev-liq').show();
        }
    }
}

//Video youtube
function stopVideo() {
    try {
        if (player) {
            if (player.stopVideo) {
                player.stopVideo();
            }
            else {
                //document.getElementById("divPlayer").contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}','*');
                var urlVideo = $("#divPlayer").attr("src");
                $("#divPlayer").attr("src", "");
                $("#divPlayer").attr("src", urlVideo);
            }
        }
    } catch (e) { }
};
function playVideo() {
    try {
        if (player) {
            if (player.playVideo) {
                player.playVideo();
            }
            else {
                document.getElementById("divPlayer").contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
            }
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Home',
            'action': 'Video de Bienvenida: Iniciar video',
            'label': 'SomosBelcorp.com ¡se renueva para ti!'
        });
        }
    } catch (e) { }
};

//function AgregarProductoOfertaRevista(item, cantidad, tipoCUV) {
//    waitingDialog();
//    var hidden = "";

//    if (tipoCUV == 'revista') {
//        hidden = $(item).find('#hiddenRevista');
//    } else if (tipoCUV == 'catalogo') {
//        hidden = $(item).find('#hiddenCatalogo');
//    }

//    if (hidden.length == 0) {
//        return false;
//    }

//    if (!isInt(cantidad)) {
//        alert_msg_pedido("La cantidad ingresada debe ser un número mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    if (cantidad <= 0) {
//        alert_msg_pedido("La cantidad ingresada debe ser mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    var model = {
//        TipoOfertaSisID: $(hidden).find(".hdItemTipoOfertaSisID").val(),
//        ConfiguracionOfertaID: $(hidden).find(".hdItemConfiguracionOfertaID").val(),
//        IndicadorMontoMinimo: $(hidden).find(".hdItemIndicadorMontoMinimo").val(),
//        MarcaID: $(hidden).find(".hdItemMarcaID").val(),
//        Cantidad: cantidad,
//        PrecioUnidad: $(hidden).find(".hdItemPrecioUnidad").val(),
//        CUV: $(hidden).find(".hdItemCuv").val(),
//        Tipo: $(hidden).find(".hdItemTipo").val(),
//        DescripcionProd: $(hidden).find(".hdItemDescripcionProd").val(),
//        Pagina: $(hidden).find(".hdItemPagina").val(),
//        DescripcionCategoria: $(hidden).find(".hdItemDescripcionCategoria").val(),
//        DescripcionMarca: $(hidden).find(".hdItemDescripcionMarca").val(),
//        DescripcionEstrategia: $(hidden).find(".hdItemDescripcionEstrategia").val(),
//        EsSugerido: false,
//        OrigenPedidoWeb: $(hidden).find(".OrigenPedidoWeb").val()
//    };

//    var imagenProducto = $('#imagenAnimacion>img', item);

//    if (imagenProducto.length > 0) {
//        var carrito = $('.campana');

//        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

//        $(".transicion").css({
//            'height': imagenProducto.css("height"),
//            'width': imagenProducto.css("width"),
//            'top': imagenProducto.offset().top,
//            'left': imagenProducto.offset().left,
//        }).animate({
//            'top': carrito.offset().top - 60,
//            'left': carrito.offset().left + 100,
//            'height': carrito.css("height"),
//            'width': carrito.css("width"),
//            'opacity': 0.5
//        }, 450, 'swing', function () {
//            $(this).animate({
//                'top': carrito.offset().top,
//                'opacity': 0,
//            }, 150, 'swing', function () {
//                $(this).remove();
//            });
//        });
//    }

//    AgregarProducto('Insert', model, function () { $(".contiene-productos:has(.hdItemCuv[value='" + $(item).find('#hiddenCatalogo').find(".hdItemCuv").val() + "'])").find(".product-add").show(); $('[class^=mod-ofer]').hide(); });
//    TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
//}
  
//ShowRoom
function CrearPopShow() {
    $("body").on("click", "div.check_01 label.checkpop input", function (event) {
        event.preventDefault();
        if ($(this).parent().hasClass("c_on")) {
            $(this).parent().removeClass("c_on");
        } else {
            $(this).parent().addClass("c_on");
        }
    });

    $("body").on("click", "div.check_hoy label.checkpop input", function (event) {
        event.preventDefault();
        if ($(this).parent().hasClass("c_on")) {
            $(this).parent().removeClass("c_on");
        } else {
            $(this).parent().addClass("c_on");
        }
    });

    var noMostrarShowRoom = true;

    $("#btnCerrarPopShowroom").click(function () {
        $("#DialogoMensajeBannerShowRoom").hide();
    });

    $("#btnCerrarPopShowroomHoy").click(function () {
        $("#DialogoMensajeBannerShowRoomHoy").hide();
    });

    $("#cbNoMostrarPopupShowRoom, #cbNoMostrarPopupShowRoomHoy").click(function () {
        var noMostrarPopup = noMostrarShowRoom;

        var item = {
            noMostrarPopup: noMostrarPopup
        };

        $.ajax({
            type: 'POST',
            url: baseUrl + 'ShowRoom/UpdatePopupShowRoom',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: false,
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        if (noMostrarShowRoom)
                            AgregarTagManagerShowRoomCheckBox();
                        noMostrarShowRoom = noMostrarShowRoom == true ? false : true;
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                    //console.log("Ocurrió un error en ShowRoom");
                    //alert("Ocurrió un error en ShowRoom");
                }
            }
        });
    });

    $("#lnkConoceMasShowRoomPopup").click(function () {
        AgregarTagManagerShowRoomPopupConocesMas(1);
    });

    $("#lnkConoceMasShowRoomPopupHoy").click(function () {
        AgregarTagManagerShowRoomPopupConocesMas(2);
    });
}
function MostrarShowRoom() {
    if (viewBagRol == 1) {
        if (sesionEsShowRoom == '0') {
            return;
        }
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/MostrarShowRoomPopup",
            contentType: 'application/json',
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        var showroomConsultora = response.data;
                        var evento = response.evento;

                        if (showroomConsultora.EventoConsultoraID != 0) {
                            if (showroomConsultora.MostrarPopup) {
                                $("#hdEventoIDShowRoom").val(evento.EventoID);

                                if (response.mostrarShowRoomProductos) {
                                    $("#spnShowRoomEventoHoy").html(evento.Tema);

                                    $("#lnkConoceMasShowRoomPopupHoy").attr("href", response.rutaShowRoomPopup);

                                    //Carga de Imagenes del Popup
                                    $("#imgPestaniaShowRoomHoy").attr("src", evento.ImagenPestaniaShowRoom);
                                    $("#imgIntrigaHoy").attr("src", evento.Imagen2);
                                    $("#imgPreventaDigitalHoy").attr("src", evento.ImagenPreventaDigital);
                                    $("#imgVentaSetPopupHoy").attr("src", evento.ImagenVentaSetPopup);

                                    $("#DialogoMensajeBannerShowRoomHoy").show();
                                    
                                    AgregarTagManagerShowRoomPopup(evento.Tema, true);
                                } else {
                                    $("#spnShowRoomEvento").html(evento.Tema);
                                    $("#spnShowRoomNombreConsultora").html(response.nombre);
                                    $("#spnShowRoomDiaInicio").html(response.diaInicio);
                                    $("#spnShowRoomDiaFin").html(response.diaFin);
                                    $("#spnShowRoomMes").html(response.mesFin);
                                    if (response.mesFin.length > 6) {
                                        $(".fecha_promocion_s").css("font-size", "11.5pt");
                                    }
                                    
                                    $("#lnkConoceMasShowRoomPopup").attr("href", response.rutaShowRoomPopup);

                                    //Carga de Imagenes del Popup
                                    $("#imgPestaniaShowRoom").attr("src", evento.ImagenPestaniaShowRoom);
                                    $("#imgIntriga").attr("src", evento.Imagen2);
                                    $("#imgPreventaDigital").attr("src", evento.ImagenPreventaDigital);
                                    $("#imgShowRoomGif").attr("src", evento.Imagen1);

                                    $("#DialogoMensajeBannerShowRoom").show();
                                    
                                    AgregarTagManagerShowRoomPopup(evento.Tema, false);
                                }

                                //$("#imgShowRoomGif").attr("src", evento.Imagen1);
                            }
                        }
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                    //console.log("Ocurrió un error en ShowRoom");
                    //alert("Ocurrió un error en ShowRoom");
                }
            }
        });
    }
}
function AgregarTagManagerShowRoomPopup(nombreEvento, esHoy) {
    var name = 'showroom digital ' + nombreEvento;

    if (esHoy)
        name += " - fase 2";

    dataLayer.push({
        'event': 'promotionView',
        'ecommerce': {
            'promoView': {
                'promotions': [
                {
                    'id': $("#hdEventoIDShowRoom").val(),
                    'name': name,
                    'position': 'Home pop-up - 1',
                    'creative': 'Banner'
                }]
            }
        }
    });
}
function AgregarTagManagerShowRoomPopupConocesMas(opcion) {
    var nombre = opcion == 1 ? $("#spnShowRoomEvento").html() : $("#spnShowRoomEventoHoy").html();

    if (opcion != 1)
        nombre += " - fase 2";

    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                    {
                        'id': $("#hdEventoIDShowRoom").val(),
                        'name': 'showroom digital ' + nombre,
                        'position': 'Home pop-up - 1',
                        'creative': 'Banner'
                    }]
            }
        }
    });
}

function AgregarTagManagerShowRoomCheckBox() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom',
        'action': 'checkbox',
        'label': '(not available)'
    });
}
//Fin ShowRoom

function abrir_popup_tutorial(obligado) {
    obligado = obligado == undefined ? false : obligado;
    if (!obligado) {
        if (viewBagVioTutorial == 1) {
            return false;
        }
        UpdateUsuarioTutorial();
    }
    
    $('#popup_tutorial_home').fadeIn();
    $('html').css({ 'overflow-y': 'hidden' });
    var paisCP = false;
    var CatalogoPersonalizado_ZonaValida = $("#hdEsCatalogoPersonalizadoZonaValida").val() == "False" ? 0 : 1;
    if ((viewBagPaisID == "11" || viewBagPaisID == "3") && CatalogoPersonalizado_ZonaValida) {
        paisCP = true;
    }
    fnMovimientoTutorial = setInterval(function () {
        $(".img_slide" + numImagen).animate({ 'opacity': '0' });
        numImagen++;
        if (!paisCP && numImagen == 8) {
            $(".img_slide" + numImagen).hide();
            numImagen++;
        }

        if (numImagen > 9) {
            numImagen = 1;
            $(".imagen_tutorial").animate({ 'opacity': '1' });
        }
    }, 3000);
}

function cerrar_popup_tutorial() {
    $('#popup_tutorial_home').fadeOut();
    $('html').css({ 'overflow-y': 'auto' });
    $(".imagen_tutorial").animate({ 'opacity': '1' });
    window.clearInterval(fnMovimientoTutorial);
    numImagen = 1;
    viewBagVioTutorial = 1;

    mostrarComunicadosPopup();
}

/* SB20-834 - INICIO */
function ObtenerComunicadosPopup() {
    waitingDialog();

    $.ajax({
        type: "GET",
        url: baseUrl + 'Bienvenida/ObtenerComunicadosPopUps',
        contentType: 'application/json',
        success: function (response) {

            armarComunicadosPopup(response);
            var images = $("#popupComunicados img.img-comunicado");
            var loadedImgNum = 0;

            if (images.length == 0) {
                closeWaitingDialog();
            } else {
                images.on('load', function () {
                    loadedImgNum += 1;
                    if (loadedImgNum == images.length) {
                        closeWaitingDialog();

                        mostrarComunicadosPopup();
                    }
                });
            }
        },
        error: function (data, error) {
            //console.log(data);
            closeWaitingDialog();
        }
    });
}

function armarComunicadosPopup(response) {
    //console.log('armarComunicadosPopup');
    viewBagVerComunicado = response.comunicadoVisualizado;
    //$('#totalComuSinMostrar').val(response.data.length);

    $.each(response.data, function (id, item) {
        dialogComunicadoID = item.CodigoConsultora + '_' + item.ComunicadoId;
        var nombreEvento = encodeURI(item.Descripcion);
        //console.log(item);

        if (item.Accion == "CUV") {
            //displayTerminos = 'float:right;display:none;';
            //urlAccion = 'javascript:InsertarPedidoCuvBanner(' + item.DescripcionAccion + ',1);';
        }
        else if (item.Accion == "URL") {
            urlAccion = item.DescripcionAccion;
            if (urlAccion > 0) {
                //var id = urlAccion;
                urlAccion = baseUrl + "MiAcademia/Cursos/idcurso/" + urlAccion;
                //urlAccion = urlAccion.replace("idcurso_", id);
            }
            displayTerminos = 'float:right;display:none;';
            target = '_blank';
        }
        //else if (item.Accion == "DON") {
        //    displayTerminos = '';
        //    urlAccion = 'javascript:RealizarDonacion(' + dialogComunicadoID + ',' + item.ComunicadoId + ',"' + response.codigoISO + '",' + response.codigoConsultora + ',' + response.codigoCampania + ',"' + nombreEvento + '");';
        //}

        var comunicado = {
            id: dialogComunicadoID,
            hrefUrl: urlAccion,
            target: target,
            urlImg: item.UrlImagen,
            idComunicado: item.ComunicadoId,
            display: displayTerminos,
            comunicadoDescripcion: nombreEvento
        };

        //console.log(comunicado);
        var content = SetHandlebars("#template-comunicado", comunicado, "");
        $('#popupComunicados').append(content);

        //$("#" + dialogComunicadoID + "").siblings(".ui-dialog-titlebar").hide();
        //$("#" + dialogComunicadoID + " img").load(function () { comunicado.dialog('option', 'position', 'center'); });
        //comunicado.dialog('open');

        //// Push a promotionView cuando carga el comunicado.
        //dataLayer.push({
        //    'event': 'promotionView',
        //    'ecommerce': {
        //        'promoView': {
        //            'promotions': [
        //             {
        //                 'id': item.ComunicadoId,
        //                 'name': nombreEvento,
        //                 'position': 'Home pop-up – 1',
        //                 'creative': 'Banner'
        //             }]
        //        }
        //    }
        //});
    });
}

function mostrarComunicadosPopup() {
    if (viewBagVerComunicado != '1' || viewBagVioTutorial == 0 || viewBagVioVideo == 0) {
        $('#popupComunicados').hide();
        return true;
    }

    var lista = $('#popupComunicados').find('div.popup_comunicados[data-cerrado="0"]');
    if (lista.length == 0) {
        $('#popupComunicados').hide();
        return true;
    }

    $('#popupComunicados').show();
    var j = 0;

    lista.each(function(index, element) {
        var id = $(element).attr('id');
        $('#' + id).show();
        centrarComunicadoPopup(id);
        j++;
        return false;
    });

    return (j > 0) ? false : true;
}

function centrarComunicadoPopup(ID) {
    var altoPopup = ($(window).height() - $("#" + ID).outerHeight()) / 2;
    var imagenPopup = $('#' + ID).find(".img-comunicado");
    var estadoPopup = $("#popupComunicados").css("display");

    if (estadoPopup == "block") {
        $("#" + ID).css({ "width": imagenPopup.width() });
        $("#" + ID).css({ "top": altoPopup });
    }
}

function clickCerrarComunicado(obj) {
    var comunicadoID = $(obj).attr('data-comunicado');
    var dialogComunicadoID = $(obj).attr('data-id');

    AceptarComunicadoVisualizacion(comunicadoID, dialogComunicadoID);

    $('#' + dialogComunicadoID).hide();
    $('#' + dialogComunicadoID).attr('data-cerrado', 1);
    var vclose = mostrarComunicadosPopup();

    if (vclose) {
        closeComunicadosPopup = true;
        $('#popupComunicados').hide();
    }
}

function clickImagenComunicado(obj) {
    var comunicadoID = $(obj).attr('data-comunicadoid');
    var comunicadoDescripcion = $(obj).attr('data-comunicadodescripcion');
    var dialogComunicadoID = $(obj).attr('data-id');

    //dataLayer.push({
    //    'event': 'promotionClick',
    //    'ecommerce': {
    //        'promoClick': {
    //            'promotions': [
    //                {
    //                    'id': comunicadoID,
    //                    'name': comunicadoDescripcion,
    //                    'position': 'Home pop-up - 1',
    //                    'creative': 'Banner'
    //                }]
    //        }
    //    }
    //});

    //$('#popupComunicados').hide();
    $('#' + dialogComunicadoID).hide();
    $('#' + dialogComunicadoID).attr('data-cerrado', 1);
    var vclose = mostrarComunicadosPopup();

    if (vclose) {
        //$('#totalComuSinMostrar').val('0');
        closeComunicadosPopup = true;
        $('#popupComunicados').hide();
        //CargarPopupsConsultora();
    }
}

function AceptarComunicadoVisualizacion(ID, dialogComunicadoID) {
    if ($('#chkMostrarComunicado_' + ID + '').is(':checked')) {
        var params = { ComunicadoID: ID };

        waitingDialog({});
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/AceptarComunicadoVisualizacion",
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function (data) {
                if (checkTimeout(data)) {
                    $('#' + dialogComunicadoID).hide();
                    closeWaitingDialog();
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("Ocurrió un error al aceptar el comunicado.");
                }
            }
        });
    }

    $('#' + dialogComunicadoID).hide();
}
/* SB20-834 - FIN */