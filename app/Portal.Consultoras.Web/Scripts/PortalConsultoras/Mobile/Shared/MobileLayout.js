﻿
$(function () {

    LayoutHeader();

    SetFormatDecimalPais(formatDecimalPaisMain);

    if (mostrarBannerPostulante == 'True') {
        $('#bloquemensajesPostulante').show();
    }
    else {
        MensajeEstadoPedido();
    }

    HandlebarsRegisterHelper();

    $('.menu_footer').on('click', function () {
        var $obj = $(this);
        if ($obj.hasClass('menu_footer')) {
            $obj.addClass('menu_footer_menos').removeClass('menu_footer');
        } else {
            $obj.addClass('menu_footer').removeClass('menu_footer_menos');
        }
    });

    $(".alert-close").click(function (event) {
        $(this).parent(".alert-top").slideUp();
    });

    CargarCantidadProductosPedidos(true);
    CargarCantidadNotificacionesSinLeer();

    $("body").on("keyup", ".ValidaNumeral", function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });

    $("body").on("keypress", ".ValidaNumeral", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $("body").on('paste', ".ValidaPasteNumeral", function (e) {
        var $input = $(this);
        var previousVal = $input.val();
        var pastedValue = e.originalEvent.clipboardData.getData('text/plain').trim();
        if (isNaN(pastedValue) === false && isInt(Number(pastedValue))) {
            $input.val(pastedValue);
            e.preventDefault();
        } else {
            $input.val(previousVal);
            e.preventDefault();
        };
    });

    $("body").on("click", "[data-cantidad-agregar]", function () {
        var signo = $(this).attr("data-cantidad-agregar");
        var objPadre = $(this).parents("[data-cantidad-contenedor]");
        var objInput = objPadre.find("[data-cantidad-input]");

        var agregar = signo == "-" ? -1 : signo == "+" ? 1 : 0
        var actual = objInput.val();
        actual = parseInt(actual, 10) == NaN ? 0 : parseInt(actual, 10);

        actual = actual + agregar;
        actual = actual < 1 ? 1 : actual > 99 ? 99 : actual;

        objInput.val(actual);
    });

    $(document).on("click", ".cantidad_menos_home", function () {
        var $txtcantidad = $(this).siblings('input');
        var cantidad = parseInt($txtcantidad.val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad > 1 ? (cantidad - 1) : 1;

        $txtcantidad.val(cantidad);
    });

    $(document).on("click", ".cantidad_mas_home", function () {
        var $txtcantidad = $(this).siblings('input');
        var cantidad = parseInt($txtcantidad.val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad < 99 ? (cantidad + 1) : 99;

        $txtcantidad.val(cantidad);
    });

    $("body").on("click", "[data-popup-main]", function (e) {
        if (!$(e.target).closest('[data-popup-body]').length) {

            if ($(e.target).is(':visible')) {

                var functionHide = $.trim($('[data-popup-main]').attr("data-popup-function-hide"));
                if (functionHide != "") {
                    setTimeout(functionHide + "()", 100);
                }
                $(e.target).hide();
                $('body').css({ 'overflow-y': 'scroll' });
            }
        }
    });

    $("body").on("click", "[data-popup-close]", function (e) {
        var popupClose = $("#" + $(this).attr("data-popup-close")) || $(this).parent("[data-popup-main]");

        var functionHide = $.trim($(popupClose).attr("data-popup-function-hide"));
        if (functionHide != "") {
            setTimeout(functionHide + "()", 100);
        }
        $(popupClose).hide();
        $('body').css({ 'overflow-y': 'scroll' });
    });

    $("#btn_cerrar_oferta_mobile").click(function () {
        //$('.header_slider').slideUp();
        $('.header_slider').hide();
        //$("#contentmobile").css({ 'margin-top': '63px' });

        OcultarBannerTop();
    });

    if (MostrarBannerPL20) {
        loadBannerLP20();
    }
    if (EstadoActivo === '1') {
        var URLactual = window.location.href;
        var urlBienvenida = URLactual.indexOf("Bienvenida");

        if (urlBienvenida > 0) {
            $("#contentmobile").css({ 'margin-top': '0px' });
        } else {
            $("#contentmobile").css({ 'margin-top': '63px' });
        }
    }
    else {
        var URLactual = window.location.href;
        var urlPagina = URLactual.indexOf("Cliente");
        $("#contentmobile").css({ 'margin-top': '123px' });
    }

    var URLactual = window.location.href;
    var urlIntriga = URLactual.indexOf("Intriga");

    if (urlIntriga > 0) {
        $("#OfertaDelDia").css('display', 'none');
    }

    if (ocultarBannerTop) {
        //$('.header_slider').slideUp();
        $('.header_slider').hide();
        //$("#content").css({ 'margin-top': '63px' });
        LayoutHeader();
    }

    var URLactual = window.location.href;
    var urlBienvenida = URLactual.indexOf("Bienvenida");

    if (urlBienvenida > 0) {
        if (sesionEsShowRoom != null && sesionEsShowRoom == "1") {
            $("#contentmobile").css({ 'margin-top': '0px' });
        } else {
            $("#contentmobile").css({ 'margin-top': '63px' });
        }
    } else {
        if ($('#flexslidertop ul.slides li').length == 0) {
            $("#contentmobile").css({ 'margin-top': '63px' });
        }
    }

    //setTimeout(LayoutHeader, 300);

    $(".bannersi").on("click", function () {

        var eventoIDIdenti = $("#hdEventoIDShowRoom").val();
        var eventoShowRoomNombres = $("#hdNombreEventoShowRoom").val();

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventoIDIdenti,
                            'name': 'Venta Exclusiva Web ' + eventoShowRoomNombres + ' Entérate primero',
                            'position': 'Home pop-up - 1',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    $(".bannersc").on("click", function () {

        var eventoIDIdenti = $("#hdEventoIDShowRoom").val();
        var eventoShowRoomNombres = $("#hdNombreEventoShowRoom").val();

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventoIDIdenti,
                            'name': 'Venta Exclusiva Web ' + eventoShowRoomNombres + ' Compra Ya',
                            'position': 'Home pop-up - 1',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });


    $(".wsventa").on("click", function () {

        var eventoIDIdenti = $("#hdEventoIDShowRoom").val();
        var eventoShowRoomNombres = $("#hdNombreEventoShowRoom").val();

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventoIDIdenti,
                            'name': 'Venta Exclusiva Web ' + eventoShowRoomNombres + ' Compra Ya',
                            'position': 'Mobile Menu',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    $(".wsintriga").on("click", function () {

        var eventoIDIdenti = $("#hdEventoIDShowRoom").val();
        var eventoShowRoomNombres = $("#hdNombreEventoShowRoom").val();

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventoIDIdenti,
                            'name': 'Venta Exclusiva Web ' + eventoShowRoomNombres + ' Entérate primero',
                            'position': 'Mobile Menu',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    LayoutHeader();

});

function loadBannerLP20() {
    if (typeof CargarShowRoom !== 'undefined' && $.isFunction(CargarShowRoom)) CargarShowRoom();
    if (typeof CargarEventosODD !== 'undefined' && $.isFunction(CargarEventosODD)) CargarEventosODD();

    if ($('#flexslider ul.slides li').length > 0) {
        $("#contentmobile").css("margin-top", "0px");
        $('#content_slider_banner').show();

        $('#flexslider').flexslider({
            animation: "slide",
            pauseOnAction: false,
            animationSpeed: 1600
        });

    } else {
        var url = location.href.toLowerCase();
    }

    if ($('#flexslidertop ul.slides li').length > 0) {
        $('#flexslidertop').flexslider({
            animation: "fade",
            pauseOnAction: false,
            animationSpeed: 1600
        });



    }
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoEnHorarioRestringuido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
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
                    ShowLoading();
                    location.href = urlPedidoValidado
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    messageInfo(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) {
                messageInfo(data.message);
            }
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });

    return restringido;
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
};

function ValidarCorreoComunidad(tipo) {
    $.ajaxSetup({
        cache: false
    });
    var result = true;
    ShowLoading();
    var mensaje = "<b>¡Gracias por unirte a Somos Belcorp!</b>, una comunidad de mujeres emprendedoras" +
        "y apasionadas por el negocio de la belleza." +
        "<br />" +
        "<br />" +
        "Revisa tu correo y sigue los pasos para ingresar." +
        "¡Te esperamos!" +
        "<br />";
    if (tipo == 2) {

        if ($('#txtUsuarioComunidad').val() == 'Tu apodo en la comunidad') {
            $('#ErrorUsuario').css({ "display": "block" });
            $('#ES_Usuario').css({ "display": "block" });
            $('#ErrorUsuario').html("Debe ingresar un apodo.");
            CloseLoading();
            result = false;
        } else {
            if ($('#ErrorUsuario').html() != "Este apodo ya existe.") {

            }
        }


        if ($('#txtNuevoCorreoComunidad').val() == 'Correo electrónico') {
            $('#ErrorCorreo').css({ "display": "block" });
            $('#ES_Correo').css({ "display": "block" });
            $('#ErrorCorreo').html("Debe ingresar su correo.");
            result = false;
        } else {
            if (!ValidarCorreo($('#txtNuevoCorreoComunidad').val())) {
                $('#ErrorCorreo').css({ "display": "block" });
                $('#ES_Correo').css({ "display": "block" });
                $('#ErrorCorreo').html("El formato del correo es incorrecto.");
                $('#ErrorCorreo').css({ "color": "red" });
                CloseLoading();
                result = false;
            } else {
                if ($('#ErrorCorreo').html() != "Este correo ya existe.") {

                }
            }
        }

        if (result) {

            if ($('#ErrorUsuario').html() != 'Apodo Disponible.' || $('#ErrorCorreo').html() != 'Correo Disponible.') {
                CloseLoading();
                return;
            }

            var params = {
                usuario: $("#txtUsuarioComunidad").val(),
                correo: $("#txtNuevoCorreoComunidad").val()
            };

            jQuery.ajax({
                type: 'POST',
                url: urlRegistrarUsuarioComunidad,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(params),
                async: true,
                success: function (data) {
                    if (checkTimeout(data)) {
                        CloseLoading();
                        if (data.success == true) {
                            CloseComunidad();
                            messageInfo(mensaje, function () {
                                window.location.reload(true);
                            });

                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Comunidad',
                                'action': 'Crear cuenta',
                                'label': 'Satisfactorio'
                            });

                        } else {
                            CloseComunidad();
                            messageInfo(data.message);

                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Comunidad',
                                'action': 'Crear cuenta',
                                'label': 'Error'
                            });
                        }
                    }
                },
                error: function (data, error) {
                    if (checkTimeout(data)) {
                        CloseLoading();
                        CloseComunidad();
                        messageInfo(data.message);

                        dataLayer.push({
                            'event': 'virtualEvent',
                            'category': 'Comunidad',
                            'action': 'Crear cuenta',
                            'label': 'Error'
                        });
                    }
                }
            });

        } else {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Comunidad',
                'action': 'Crear cuenta',
                'label': 'Error'
            });
        }
    } else {

        if ($('#txtCorreoComunidad').val() == 'Correo electrónico') {
            $('#ErrorCorreoC').css({ "display": "block" });
            $('#ES_CorreoC').css({ "display": "block" });
            $('#ErrorCorreoC').html("Debe ingresar su correo.");
            CloseLoading();
            result = false;
        } else {
            if (!ValidarCorreo($('#txtCorreoComunidad').val())) {
                $('#ErrorCorreoC').css({ "display": "block" });
                $('#ES_CorreoC').css({ "display": "block" });
                $('#ErrorCorreoC').html("El formato del correo es incorrecto.");
                $('#ErrorCorreoC').css({ "color": "red" });
                CloseLoading();
                result = false;
            }
        }

        if (result) {
            if ($('#ErrorCorreo').html() != '')
                return;

            var params = {
                correo: $("#txtCorreoComunidad").val()
            };

            jQuery.ajax({
                type: 'POST',
                url: urlValidarCorreoComunidad,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(params),
                async: true,
                success: function (data) {

                    if (checkTimeout(data)) {
                        CloseLoading();
                        if (data.success == true) {
                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Comunidad',
                                'action': 'Ingresar',
                                'label': 'Satisfactorio'
                            });
                            CloseComunidad();
                            messageInfo(mensaje, function () {
                                window.location.reload(true);
                            });

                        } else {
                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Comunidad',
                                'action': 'Ingresar',
                                'label': 'Error'
                            });

                            CloseComunidad();
                            messageInfo(data.message);
                        }
                    }
                },
                error: function (data, error) {
                    if (checkTimeout(data)) {
                        dataLayer.push({
                            'event': 'virtualEvent',
                            'category': 'Comunidad',
                            'action': 'Ingresar',
                            'label': 'Error'
                        });

                        CloseLoading();
                        CloseComunidad();
                        messageInfo(data.message);
                    }
                }
            });
        } else {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Comunidad',
                'action': 'Ingresar',
                'label': 'Error'
            });
        }
    }
}

function ValidarCorreo(correo) {
    expr = /^([a-zA-Z0-9_\.\-])+\@@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return expr.test(correo);
}

function ValidarCorreoIngresado(correo) {
    $.ajaxSetup({
        cache: false
    });
    ShowLoading();
    $('#ValCorreo').css({ "display": "block" });
    $('#ErrorCorreo').css({ "display": "none" });
    $.ajax({
        type: "POST",
        url: urlValidarCorreoIngresado,
        data: "{'correo': '" + correo + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $('#ValCorreo').css({ "display": "none" });
            $('#ErrorCorreo').css({ "display": "block" });
            $('#ES_Correo').css({ "display": "block" });
            if (data.success == true) {
                $('#ErrorCorreo').html("Este correo ya existe.");
                $('#ErrorCorreo').css({ "color": "red" });
                CloseLoading();
            } else {
                $('#ErrorCorreo').html("Correo Disponible.");
                $('#ErrorCorreo').css({ "color": "green" });
                CloseLoading();
            }
        },
        error: function (result) {
            CloseLoading();
            CloseComunidad();
            messageInfo('Ocurrió un error al intentar validar el correo. Por favor, volver a intentar.');

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Comunidad',
                'action': 'Crear cuenta',
                'label': 'Error'
            });
        }
    });
}

function ValidarUsuarioIngresado(usuario) {
    $.ajaxSetup({
        cache: false
    });
    $('#ValUsuario').css({ "display": "block" });
    $('#ErrorUsuario').css({ "display": "none" });
    ShowLoading();
    $.ajax({
        type: "POST",
        url: urlValidarUsuarioIngresado,
        data: "{'usuario': '" + usuario + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $('#ValUsuario').css({ "display": "none" });
            $('#ErrorUsuario').css({ "display": "block" });
            $('#ES_Usuario').css({ "display": "block" });

            if (data.success == true) {
                $('#ErrorUsuario').html("Este apodo ya existe.");
                $('#ErrorUsuario').css({ "color": "red" });
                CloseLoading();
            } else {
                $('#ErrorUsuario').html("Apodo Disponible.");
                $('#ErrorUsuario').css({ "color": "green" });
                CloseLoading();
            }
        },
        error: function (result) {
            CloseLoading();
            CloseComunidad();
            messageInfo('Ocurrió un error al intentar validar el usuario. Por favor, volver a intentar.');

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Comunidad',
                'action': 'Crear cuenta',
                'label': 'Error'
            });
        }
    });
}

function ShowComunidad() {
    $('.icon-close').click();

    $("#popupComunidad").modal("show");
}

function CloseComunidad() {
    $("#popupComunidad").modal("hide");
}

function ShowLoading() {
    $("#loading-spin").fadeIn();
}

function CloseLoading() {
    $("#loading-spin").fadeOut("fast");
}

function messageInfo(message, fnAceptar) {
    message = $.trim(message);
    if (message == "") {
        return false;
    }

    $('#mensajeInformacion').html(message);
    $('#popupInformacion').show();
    if ($.isFunction(fnAceptar)) {
        $('#popupInformacion .btn-aceptar').off('click');
        $('#popupInformacion .btn-aceptar').on('click', fnAceptar);
    }
}

function messageInfoBueno(message, fnAceptar) {
    $('#mensajeInformacionSB2Bueno').html(message);
    $('#popupInformacionSB2Bueno').show();
    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionSB2Bueno .btn_ok_mobile').off('click');
        $('#popupInformacionSB2Bueno .btn_ok_mobile').on('click', fnAceptar);
    }
}

function messageInfoMalo(message, fnAceptar) {
    $('#mensajeInformacionSB2_Malo').html(message);
    $('#popupInformacionSB2Malo').show();
    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionSB2Malo .btn-aceptar').off('click');
        $('#popupInformacionSB2Malo .btn-aceptar').on('click', fnAceptar);
    }
}

function messageInfoError(message, fnAceptar) {
    $('#mensajeInformacionSB2_Error').html(message);
    $('#popupInformacionSB2Error').show();
    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionSB2Error .btn-aceptar').off('click');
        $('#popupInformacionSB2Error .btn-aceptar').on('click', fnAceptar);
    }
}

function messageInfoValidado(message, fnAceptar) {
    $('#mensajeInformacionvalidado').html(message);
    $('#popupInformacionValidado').show();
    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionValidado .btn_ok_mobile').off('click');
        $('#popupInformacionValidado .btn_ok_mobile').on('click', fnAceptar);
    }
}

function CargarCantidadProductosPedidos(noMostrarEfecto) {
    noMostrarEfecto = noMostrarEfecto || false;

    jQuery.ajax({
        type: 'POST',
        url: urlGetCantidadProductos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {

                if (data.montoWebAcumulado == 0) {
                    if (data.paisID == 4)  //Formato de decimales para Colombia
                        montoWebAcumulado = "0";
                    else
                        montoWebAcumulado = "0.00";
                } else {
                    if (data.paisID == 4)  //Formato de decimales para Colombia
                        montoWebAcumulado = SeparadorMiles(data.montoWebAcumulado.toFixed(0));
                    else
                        montoWebAcumulado = data.montoWebAcumulado.toFixed(2);
                }

                $(".num-menu-shop").html(data.cantidadProductos);
                $(".js-span-pedidoingresado").html(montoWebAcumulado);
                if (!noMostrarEfecto) {
                    $('.num-menu-shop').removeClass('microefecto_color');
                    setTimeout(function () { $('.num-menu-shop').addClass('microefecto_color') }, 250);
                }

                data.mensaje = data.mensaje || "";
                if (data.mensaje != '') {
                    console.log(data.mensaje);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(error);
            }
        }
    });
}

function CargarCantidadNotificacionesSinLeer() {
    jQuery.ajax({
        type: 'POST',
        url: urlGetNotificacionesSinLeer,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.cantidadNotificaciones > 0) {
                    $("#divNotificacionesSinLeer").html(data.cantidadNotificaciones);
                    $('.notificaciones_mobiles').html(data.cantidadNotificaciones);
                    $("#divNotificacionesSinLeer").show();
                }

                data.mensaje = data.mensaje || "";
                if (data.mensaje != '') {
                    console.log(data.mensaje);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(error);
            }
        }
    });
}

function CargarCantidadPedidosConsultoraOnline() {
    jQuery.ajax({
        type: 'POST',
        url: urlGetCantidadPedidos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                var cantidadPedidosOnline = data.cantidadPedidos;

                $("#divPedidosOnlineSinLeer").html(cantidadPedidosOnline);

                if (cantidadPedidosOnline > 0) {
                    $("#divPedidosOnlineSinLeer").show();

                    $("#spanNumeroPedidoOnline1").html(parseInt(cantidadPedidosOnline) > 9 ? "+9" : cantidadPedidosOnline);
                    $("#spanNumeroPedidoOnline2").html(cantidadPedidosOnline);
                    $("#divAlertaPedidosOnline").show();
                }

                data.mensaje = data.mensaje || "";
                if (data.mensaje != '') {
                    console.log(data.mensaje);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(error);
            }
        }
    });
}

function SeparadorMiles(pnumero) {

    var resultado = "";
    var numero = pnumero.replace(/\,/g, '');
    var nuevoNumero = "";
    if (numero[0] == "-") nuevoNumero = numero.replace(/\./g, '').substring(1);
    else nuevoNumero = numero.replace(/\./g, '');

    if (numero.indexOf(",") >= 0) nuevoNumero = nuevoNumero.substring(0, nuevoNumero.indexOf(","));

    for (var j, i = nuevoNumero.length - 1, j = 0; i >= 0; i--, j++)
        resultado = nuevoNumero.charAt(i) + ((j > 0) && (j % 3 == 0) ? "." : "") + resultado;

    if (numero.indexOf(",") >= 0) resultado += numero.substring(numero.indexOf(","));

    if (numero[0] == "-") return "-" + resultado;
    else return resultado;
};

function TrackingJetloreAdd(cantidad, campania, cuv) {
    var esJetlore = esPaisTrackingJetlore == "1";
    if (esJetlore) {
        JL.tracker.addToCart({
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreRemove(cantidad, campania, cuv) {
    var esJetlore = esPaisTrackingJetlore == "1";
    if (esJetlore) {
        JL.tracker.removeFromCart({
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        });
    }
}

function TrackingJetloreRemoveAll(lista) {
    var esJetlore = esPaisTrackingJetlore == "1";
    if (esJetlore) JL.tracker.removeFromCart(lista);
}

function OcultarBannerTop() {
    $.ajax({
        type: 'GET',
        url: urlOcultarBannerTop,
        cache: false,
        success: function (response) {
            if (response.success) {
                //ocultarBannerTop = true;
                LayoutHeader();
            }
        },
        error: function (err) { console.log(err); }
    });
}
