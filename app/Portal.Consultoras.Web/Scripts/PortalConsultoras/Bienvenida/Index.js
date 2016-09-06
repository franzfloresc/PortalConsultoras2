var vpromotions = [];
var vpromotionsTagged = [];
var arrayOfertasParaTi = [];
var arrayLiquidaciones = [];

$(document).ready(function () {

    //$('#salvavidaTutorial').show();

    //function ocultarAnimacionTutorial() {

    //    $(".circulo-1").fadeOut();
    //    $(".tooltip_tutorial").fadeOut();

    //}

    //function AnimacionTutorial() {

    //    $(".tooltip_tutorial").animate({
    //        'opacity': 1,
    //        'top': 47
    //    }, 500, 'swing', function () {
    //        $(".tooltip_tutorial").animate({
    //            'top': 41
    //        }, 500, 'swing');
    //    });

    //    $(".circulo-1").animate({

    //        'width': 45,
    //        'height': 45,
    //        'opacity': 0,
    //        'top': -8,
    //        'left': -11.5

    //    }, 900, 'swing', function () {

    //        $(".circulo-1").css({
    //            'width': '0px',
    //            'height': '0px',
    //            'opacity': '1',
    //            'top': 14,
    //            'left': 10
    //        });

    //    });

    //}

    $(".abrir_tutorial").click(function () {
        abrir_popup_tutorial();
    });
    $(".cerrar_tutorial").click(function () {
        cerrar_popup_tutorial();
    });
    function abrir_popup_tutorial(){
        $('#popup_tutorial_home').fadeIn();
        $('html').css({ 'overflow-y': 'hidden' });
    }
    function cerrar_popup_tutorial() {
        $('#popup_tutorial_home').fadeOut();
        $('html').css({ 'overflow-y': 'auto' });
    }

    // Evento para visualizar video introductorio al hacer click
    $(".ver_video_introductorio").click(function () {
        $('#fondoComunPopUp').show();
        contadorFondoPopUp++;
        $('#videoIntroductorio').fadeIn(function () {

            $("#videoIntroductorio").delay(200);

            $("#videoIntroductorio").fadeIn(function () {

                $(".popup_video_introductorio").fadeIn();

            });

        });

    });

    //$(".campana.cart_compras").hover(function () {
    //    $(".info_cam").fadeIn(200);
    //}, function () {
    //    $(".info_cam").fadeOut(200);
    //});

    // MICROEFECTO FLECHA HOME

    // Función de animación de la flecha scroll 

    //function animacionFlechaScroll() {

    //    $(".flecha_scroll").animate({
    //        'top': '87%'
    //    }, 450, 'swing', function () {
    //        $(this).animate({
    //            'top': '90%'
    //        }, 150, 'swing', function () {
    //            $(this).animate({
    //                'top': '89.5%'
    //            }, 100, 'swing', function () {
    //                $(this).animate({
    //                    'top': '90.5%'
    //                }, 450, 'swing');
    //            });
    //        });
    //    });

    //}

    function animacionFlechaScroll() {

        $(".flecha_scroll").animate({
            'top': '87%'
        }, 400, 'swing', function () {
            $(this).animate({
                'top': '90%'
            }, 400, 'swing');
        });

    }

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
            //mostrarUbicacionTutorial();
            //setInterval(AnimacionTutorial, 800);
            //setTimeout(ocultarAnimacionTutorial, 9000);
        }
        stop();
        $('#videoIntroductorio').hide();
        if (contadorFondoPopUp == 1) {
            $("#fondoComunPopUp").hide();
        }
        contadorFondoPopUp--;
        //player.stopVideo();
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

    $(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

        var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
        AgregarProductoCatalogoPersonalizado(contenedor);
    });

    //SB20-646
    $(document).on('click', '.miCurso', function () {
        var id = $(this)[0].id;
        GetCursoMarquesina(id)
    });
});

//SB20-646
function GetCursoMarquesina(id) {
    var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
    window.open(url, '_blank');
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
    if (viewBagVioVideo == "0") {
        if (contadorFondoPopUp == 0) {
            $("#fondoComunPopUp").show();
        }
        $("#videoIntroductorio").show();
        UpdateUsuarioVideo();
        contadorFondoPopUp++;
    } else {
        primeraVezVideo = false;
    }
}

function UpdateUsuarioVideo() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Bienvenida/JSONSetUsuarioVideo',
        data: '',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
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
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3
                    }
                }
            ]
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            var accion = nextSlide > currentSlide ? 'next' : 'prev';

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
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
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

            InfoCommerceGoogleDestacadoProductClick(datos.data.DescripcionCUV2, datos.data.CUV2, datos.data.DescripcionCategoria, datos.data.DescripcionEstrategia, posicionItem);

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
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0
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
                        if (checkTimeout(data)) {
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
            console.log(error);
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
        } else if (estrategia.TipoEstrategiaImagenMostrar == '5' || estrategia.TipoEstrategiaImagenMostrar == '3') {
            var html = ArmarPopupLanzamiento(estrategia);
            $('#popupDetalleCarousel_lanzamiento').html(html);
            $('#popupDetalleCarousel_lanzamiento').show();
        };
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
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
};
function InfoCommerceGoogleDestacadoProductClick(name, id, category, variant, position) {
    if (variant == null || variant == "") {
        variant = "Estándar";
    }
    if (category == null || category == "") {
        category = "Sin Categoría";
    }

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': 'Productos destacados', 'action': 'click' },
                'products': [{
                    'name': name,
                    'id': id,
                    'category': category,
                    'variant': variant,
                    'position': position
                }]
            }
        }
    });
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
    if (htmlDiv.length > 0) {
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
                            'VER MAS',
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
        Posicion: $(contenedor).find("#Posicion").val()
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
                            if (data.success == true) {
                                ActualizarGanancia(data.DataBarra);
                                CargarResumenCampaniaHeader(true);
                                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);
                                TagManagerClickAgregarProductoLiquidacion(item);
                            }
                            else {
                                alert_msg_pedido(data.message);
                            }
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
                        Posicion = dataResult.data[count].Nombre;
                        fileName = dataResult.data[count].Archivo;
                        TipoAccion = dataResult.data[count].TipoAccion;

                        if (dataResult.data[count].GrupoBannerID.toString() == '150') {
                            Posicion = dataResult.data[count].Nombre + '-' + dataResult.data[count].Orden;
                        }

                        switch (dataResult.data[count].GrupoBannerID) {
                            case 150: // Seccion Principal SB2.0
                                var iniHtmlLink = ((dataResult.data[count].URL.length > 0 && dataResult.data[count].TipoAccion == 0) || dataResult.data[count].TipoAccion == 1 || dataResult.data[count].TipoAccion == 2) ? "<a id='bannerMicroefecto' href='javascript:void();' onclick=\"return EnlaceBanner('" + dataResult.data[count].URL + "','" + dataResult.data[count].Titulo + "','" + dataResult.data[count].TipoAccion + "','" + dataResult.data[count].CuvPedido + "','" + dataResult.data[count].CantCuvPedido + "','" + dataResult.data[count].BannerID + "','" + Posicion + "','" + dataResult.data[count].Titulo + "');\" rel='marquesina' >" : "";
                                var finHtmlLink = ((dataResult.data[count].URL.length > 0 && dataResult.data[count].TipoAccion == 0) || dataResult.data[count].TipoAccion == 1 || dataResult.data[count].TipoAccion == 2) ? '</a>' : '';

                                $('.flexslider ul.slides').append('<li>' + iniHtmlLink + '<img class="imagen_producto" src="' + fileName + '"data-object-fit="none">' + finHtmlLink + '</li>');
                                delayPrincipal = dataResult.data[count].TiempoRotacion;
                                break;
                            case -5: // Seccion Baja 1 SB2.0 
                                var trackingText = dataResult.data[count].TituloComentario;
                                var trackingDesc = dataResult.data[count].TextoComentario;
                                var htmlLink = dataResult.data[count].URL.length > 0 ? "onclick=\"return SetGoogleAnalyticsBannerInferiores('" + dataResult.data[count].URL + "','" + trackingText + "','0','" + dataResult.data[count].BannerID + "','" + countBajos + "','" + dataResult.data[count].Titulo + "');\" target='_blank' rel='banner-inferior' " : "";

                                $('#bannerBajos').append("<a class='enlaces_home' href='javascript:void();' " + htmlLink + "><div class='div-img hidden'><img class='banner-img' src='" + fileName + "' /></div><div class='btn_enlaces'>" + trackingText + "</div></a>");
                                delaySBaja1 = dataResult.data[count].TiempoRotacion;
                                promotionsBajos.push({
                                    id: dataResult.data[count].BannerID,
                                    name: dataResult.data[count].Titulo,
                                    position: 'pedido-inferior-' +  countBajos
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
function EnlaceBanner(URL, TrackText, TipoAccion, CUVpedido, CantCUVpedido, Id, Posicion, Titulo) {
    if (TipoAccion == 0 || TipoAccion == 2) {
        SetGoogleAnalyticsBannerPrincipal(URL, TrackText, Id, Posicion, Titulo);
    }

    if (TipoAccion == 1) {
        if (ReservadoOEnHorarioRestringido())
            return false;
        else
            var objBannerCarrito = $('#bannerMicroefecto');
            agregarProductoAlCarrito(objBannerCarrito);
            InsertarPedidoCuvBanner(CUVpedido, CantCUVpedido);

        SetGoogleAnalyticsPromotionClick(Id, Posicion, Titulo);

        return false;
    }
};
function InsertarPedidoCuvBanner(CUVpedido, CantCUVpedido) {
    var item = {
        CUV: CUVpedido,
        CantCUVpedido: CantCUVpedido
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
            if (checkTimeout(result)) {
                if (result.success == true) {

                    ActualizarGanancia(result.DataBarra);

                    CargarResumenCampaniaHeader(true);

                    alert_unidadesAgregadas(result.message, 1);

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
                } else {
                    alert_unidadesAgregadas('Error al realizar proceso, inténtelo más tarde.', 2);
                    closeWaitingDialog();
                }
            }
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
            console.log(error);
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
                //debugger;
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

// Métodos ShowRoom
function CrearPopShowRoom() {
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

    $('#DialogoMensajeBannerShowRoom').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 821,
        draggable: true,
    });
    $("#btnCerrarPopShowroom").click(function () {
        $("#DialogoMensajeBannerShowRoom").dialog('close');
    });

    $('#DialogoMensajeBannerShowRoomHoy').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 624,
        draggable: true,
    });
    $("#btnCerrarPopShowroomHoy").click(function () {
        $("#DialogoMensajeBannerShowRoomHoy").dialog('close');
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
                    console.log("Ocurrió un error en ShowRoom");
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
};
function MostrarShowRoom() {
    if (viewBagRolID == 1) { // Rol Consultora
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
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().find(".ui-dialog-titlebar").hide();
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("overflow", "inherit");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("border", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("-webkit-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("-moz-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("-khtml-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("padding", "0");

                                    $('#DialogoMensajeBannerShowRoomHoy').dialog('open'); //llamar al pop up
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("top", "");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("top", "90px");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("height", "450px");

                                    $("#spnShowRoomEventoHoy").html(evento.Nombre);

                                    $("#lnkConoceMasShowRoomPopupHoy").attr("href", response.rutaShowRoomPopup);

                                    showDialog("DialogoMensajeBannerShowRoomHoy");

                                    AgregarTagManagerShowRoomPopup(evento.Nombre, true);
                                } else {
                                    $("#DialogoMensajeBannerShowRoom").parent().find(".ui-dialog-titlebar").hide();
                                    $("#DialogoMensajeBannerShowRoom").parent().css("overflow", "inherit");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("border", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("-webkit-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("-moz-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("-khtml-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("padding", "0");
                                    $('#DialogoMensajeBannerShowRoom').dialog('open'); //llamar al pop up

                                    $("#spnShowRoomEvento").html(evento.Nombre);
                                    $("#spnShowRoomNombreConsultora").html(response.nombre);
                                    $("#spnShowRoomDiaInicio").html(response.diaFin - 2);
                                    $("#spnShowRoomDiaFin").html(response.diaFin);
                                    $("#spnShowRoomMes").html(response.mesFin);

                                    $("#lnkConoceMasShowRoomPopup").attr("href", response.rutaShowRoomPopup);

                                    showDialog("DialogoMensajeBannerShowRoom");

                                    AgregarTagManagerShowRoomPopup(evento.Nombre, false);
                                }
                            }
                        }
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                    console.log("Ocurrió un error en ShowRoom");
                }
            }
        });
    }
};
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
};
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
};
function AgregarTagManagerShowRoomCheckBox() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom',
        'action': 'checkbox',
        'label': '(not available)'
    });
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
function CargarCatalogoPersonalizado() {
    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
    if (cataPer != "1" && cataPer != "2") {
        $("#divMainCatalogoPersonalizado").remove();
        return false;
    }

    $('#divCatalogoPersonalizado').html('<div style="text-align: center; min-height:150px;"><br><br><br><br>Cargando Catalogo Personalizado<br><img src="' + urlLoad + '" /></div>');
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'CatalogoPersonalizado/ObtenerProductosCatalogoPersonalizadoHome',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (data.success) {
                $("#divCatalogoPersonalizado").html("");
                SetHandlebars("#template-catalogopersonalizado", data.data, "#divCatalogoPersonalizado");
            }
            else {
                $("#divMainCatalogoPersonalizado").remove();
            }            
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}
function AgregarProductoCatalogoPersonalizado(item) {
    waitingDialog();

    var divPadre = item;
    var attItem = $(item).attr("data-item") || "";
    if (attItem == "") {
        divPadre = $(item).parents("[data-item]").eq(0);
    }
    
    var cuv = $(divPadre).find(".hdItemCuv").val();
    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
    var tipoOfertaSisID = $(divPadre).find(".hdItemTipoOfertaSisID").val();
    var configuracionOfertaID = $(divPadre).find(".hdItemConfiguracionOfertaID").val();
    var indicadorMontoMinimo = $(divPadre).find(".hdItemIndicadorMontoMinimo").val();
    var tipo = $(divPadre).find(".hdItemTipo").val();
    var marcaID = $(divPadre).find(".hdItemMarcaID").val();
    var precioUnidad = $(divPadre).find(".hdItemPrecioUnidad").val();
    var descripcionProd = $(divPadre).find(".hdItemDescripcionProd").val();
    var pagina = $(divPadre).find(".hdItemPagina").val();
    var descripcionCategoria = $(divPadre).find(".hdItemDescripcionCategoria").val();
    var descripcionMarca = $(divPadre).find(".hdItemDescripcionMarca").val();
    var descripcionEstrategia = $(divPadre).find(".hdItemDescripcionEstrategia").val();

    if (!isInt(cantidad)) {
        alert_msg_com("La cantidad ingresada debe ser un número mayor que cero, verifique");
        closeWaitingDialog();
        return false;
    }

    if (cantidad <= 0) {
        alert_msg_com("La cantidad ingresada debe ser mayor que cero, verifique");
        closeWaitingDialog();
        return false;
    }

    var model = {
        TipoOfertaSisID: tipoOfertaSisID,
        ConfiguracionOfertaID: configuracionOfertaID,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        MarcaID: marcaID,
        Cantidad: cantidad,
        PrecioUnidad: precioUnidad,
        CUV: cuv,
        Tipo: tipo,
        DescripcionProd: descripcionProd,
        Pagina: pagina,
        DescripcionCategoria: descripcionCategoria,
        DescripcionMarca: descripcionMarca,
        DescripcionEstrategia: descripcionEstrategia,
        EsSugerido: false
    };

    AgregarProducto('Insert', model, function () { $(divPadre).find(".product-add").show(); });    
}
function AgregarProducto(url, item, otraFunct) {
    waitingDialog();

    tieneMicroefecto = true;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/' + url,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (data.success == true) {
                ActualizarGanancia(data.DataBarra);
                InfoCommerceGoogle(parseFloat(item.Cantidad * item.PrecioUnidad).toFixed(2), item.CUV, item.descripcionProd, item.descripcionCategoria, item.PrecioUnidad, item.Cantidad, item.descripcionMarca, item.descripcionEstrategia);
                CargarResumenCampaniaHeader(true);
                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);

                if (typeof (otraFunct) == 'function') {
                    setTimeout(otraFunct, 50);
                }
                else if (typeof (otraFunct) == 'string') {
                    setTimeout(otraFunct, 50);
                }
            }
            else {
                alert_msg_pedido(data.message);
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            tieneMicroefecto = false;
            AjaxError(data, error);
        }
    });
}
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
