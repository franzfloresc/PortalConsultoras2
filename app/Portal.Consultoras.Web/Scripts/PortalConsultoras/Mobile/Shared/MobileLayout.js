$(function () {

    LayoutHeader();
    if (typeof menuModule !== "undefined") {
        menuModule.Resize();
    }


    OcultarChatEmtelco();

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

    console.log('MobileLayout.js -  - ante CargarCantidadProductosPedidos');
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
        if ($.trim($(this).data("bloqueada")) !== "") return false;

        var signo = $(this).attr("data-cantidad-agregar");
        var objPadre = $(this).parents("[data-cantidad-contenedor]");
        var objInput = objPadre.find("[data-cantidad-input]");

        var agregar = signo == "-" ? -1 : signo == "+" ? 1 : 0
        var actual = objInput.val() || "0";
        actual = isNaN(actual) ? 0 : parseInt(actual, 10);

        actual = actual + agregar;
        actual = actual < 1 ? 1 : actual > 99 ? 99 : actual;

        objInput.val(actual);
    });

    $("body").on("click", "[data-popup-main]", function (e) {
        if (!$(e.target).closest('[data-popup-body]').length) {
            if ($(e.target).is(':visible')) {
                var functionHide = $.trim($(this).attr("data-popup-function-hide"));
                FuncionEjecutar(functionHide);
                $(e.target).hide();
                $('body').css({ 'overflow-y': 'scroll' });
            }
        }
    });

    $("body").on("click", "[data-popup-close]", function (e) {
        var popupClose = $("#" + $(this).attr("data-popup-close"));
        popupClose = popupClose.length > 0 ? popupClose : $(this).parents("[data-popup-main]");

        var functionHide = $.trim($(popupClose).attr("data-popup-function-hide"));
        FuncionEjecutar(functionHide);
        $(popupClose).hide();
        $('body').css({ 'overflow-y': 'scroll' });
    });

    $("#belcorpChat a_").click(function () {
        if (this.href.indexOf('#') != -1) {
            messageInfoError("Por el momento el chat no se encuentra disponible. Volver a intentarlo más tarde");
        }
    });

    $("body").on('click', '.belcorpChat, .indicador_ayuda', function (e) {
        e.preventDefault();

        var connected = localStorage.getItem('connected');
        var idBtn = connected ? '#btn_open' : '#btn_init';
        $(idBtn).trigger("click");

        return false;
    });

    $("body").on('click', '#btn_init', function () {
        var data = {
            'event': 'virtualEvent',
            'category': controllerName,
            'action': 'Clic en Chat',
            'label': '¿Quieres ayuda?'
        };
        dataLayer.push(data);
    });

    $("#btn_cerrar_oferta_mobile").click(function () {
        var curSlide = $("#flexslidertop").find(".flex-active-slide").html();
        if (curSlide.indexOf("BloqueOfertaDiaHeader") > -1) {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Banners',
                'action': 'Cerrar Banner',
                'label': 'Oferta del dia'
            });
        }
        else if (curSlide.indexOf("bannerShowRoomTop") > -1) {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Banners',
                'action': 'Cerrar Banner',
                'label': 'Showroom'
            });
        }

        $('.header_slider').css("display", "none");
        $('.wrapper_resumen_mobile').css("margin-top", "0px");
        $('.content_320').css("margin-top", "75px");

        OcultarBannerTop();
    });

    if (MostrarBannerPL20) {
        loadBannerLP20();
    }

    var urlactual = window.location.href;
    var urlIntriga = urlactual.indexOf("Intriga");

    if (urlIntriga > 0) {
        $("#OfertaDelDia").css('display', 'none');
    }

    if (ocultarBannerTop) {
        $('.header_slider').css("display", "none");
        $('.wrapper_resumen_mobile').css("margin-top", "0px");
        $('.content_320').css("margin-top", "75px");
        LayoutHeader();
    }

    $(".bannersi").on("click", function () {

        var eventId = $("#hdEventoIDShowRoom").val();
        var nombre = $("#hdNombreEventoShowRoom").val();
        var tema = $("#hdTemaEventoShowRoom").val();
        var eventName = nombre + ' ' + tema + ' - Entérate';

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventId,
                            'name': eventName,
                            'position': 'Home Slider - 1',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    $(".bannersc").on("click", function () {

        var eventId = $("#hdEventoIDShowRoom").val();
        var nombre = $("#hdNombreEventoShowRoom").val();
        var tema = $("#hdTemaEventoShowRoom").val();
        var eventName = nombre + ' ' + tema + ' - Compra Ya'

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventId,
                            'name': eventName,
                            'position': 'Home Slider - 1',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    $(".wsventa").on("click", function () {

        var eventId = $("#hdEventoIDShowRoom").val();
        var nombre = $("#hdNombreEventoShowRoom").val();
        var tema = $("#hdTemaEventoShowRoom").val();
        var eventName = nombre + ' ' + tema + ' - Compra Ya'

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventId,
                            'name': eventName,
                            'position': 'Mobile Menu',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    $(".wsintriga").on("click", function () {

        var eventId = $("#hdEventoIDShowRoom").val();
        var nombre = $("#hdNombreEventoShowRoom").val();
        var tema = $("#hdTemaEventoShowRoom").val();
        var eventName = nombre + ' ' + tema + ' - Entérate'

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                        {
                            'id': eventId,
                            'name': eventName,
                            'position': 'Mobile Menu',
                            'creative': 'Banner'
                        }
                    ]
                }
            }
        });

    });

    $("#bannerShowRoomTop").click(function () {
        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                        {
                            'id': '001',
                            'name': 'Showroom',
                            'position': controllerName + ' - Banner superior',
                            'creative': 'Banner'
                        }]
                }
            }
        });

        document.location.href = urlShowRoom;
    });

    BannerApp();
});

function loadBannerLP20() {
    if (typeof CargarShowRoom !== 'undefined' && $.isFunction(CargarShowRoom)) CargarShowRoom();
    if (typeof CargarEventosODD !== 'undefined' && $.isFunction(CargarEventosODD)) CargarEventosODD();

    if ($('#flexslider ul.slides li').length > 0) {
        $('#content_slider_banner').show();

        if ($('#BloqueMobileOfertaDia').length > 0) {
            $('#content_slider_banner').css('background-color', $('#BloqueMobileOfertaDia').css('background-color'));
        }

        if ($('#flexslider ul.slides li').length > 0) {
            $('#flexslider').flexslider({
                animation: "slide",
                pauseOnAction: false,
                animationSpeed: 1600
            });
        }

    }

    if ($('#flexslidertop ul.slides li').length > 0) {
        $('#flexslidertop').flexslider({
            animation: "fade",
            pauseOnAction: false,
            animationSpeed: 1600
        });
    }
}

function OcultarChatEmtelco() {
    var url = window.location.href.toLowerCase().split('/');
    var urlPedido = url[url.length - 1];

    if ((urlPedido !== 'pedido' &&
        urlPedido !== 'pagoenlinea' &&
        !(window.location.href.toLowerCase().indexOf('pedido/detalle') > 0))) {
        $(".CMXD-help").show();
    }

    var urlMobile = url[url.length - 2];
    if (urlPedido == 'pedidofic') {
        $(".CMXD-help").hide();
    }
    if (urlMobile == 'pedidofic' && urlPedido == 'detalle') {
        $(".CMXD-help").hide();
    }

    if (habilitarChatEmtelco == 'False') {
        // Ocultando todo el panel de chat y container de boton
        var $CMXDhelp = $(".CMXD-help")
            , $parent = $CMXDhelp.parents(".CMXD-btn-help")
        ;

        // ocultando hijo y padre
        $CMXDhelp.hide();
        $parent.hide();
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
                    AbrirMensaje(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) {
                AbrirMensaje(data.message);
            }
        },
        error: function (error) {
            AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });

    return restringido;
}

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


            jQuery.ajax({
                type: 'POST',
                url: urlValidarCorreoComunidad,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    correo: $("#txtCorreoComunidad").val()
                }),
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
    var expr = /^([a-zA-Z0-9_\.\-])+\@@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
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
    $("#loading-spin").css('visibility', 'visible').fadeIn();
}

function CloseLoading() {
    $("#loading-spin").fadeOut("fast", function () {
        if ($.isFunction(LayoutHeader)) LayoutHeader();
    });
}

function messageInfo(message, fnAceptar) {
    message = $.trim(message);
    if (message == "") {
        return false;
    }

    $('#mensajeInformacion').html(message);
    $('#popupInformacion').show();

    $('#popupInformacion .btn-aceptar').off('click');
    $('#popupInformacion .cerrar_popMobile').off('click');

    $('#popupInformacion .btn-aceptar').on('click', function () {
        $('#popupInformacion').hide();
        if ($.isFunction(fnAceptar)) fnAceptar();
    });
    $('#popupInformacion .cerrar_popMobile').on('click', function () {
        $('#popupInformacion').hide();
        if ($.isFunction(fnAceptar)) fnAceptar();
    });
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
    message = $.trim(message);
    if (message == "") {
        return false;
    }
    $('#mensajeInformacionSB2_Error').html(message);
    $('#popupInformacionSB2Error').show();

    $('#popupInformacionSB2Error .cerrar_popMobile').off('click');
    $('#popupInformacionSB2Error .btn_ok_mobile').off('click');

    $('#popupInformacionSB2Error .cerrar_popMobile').on('click', function () {
        $('#popupInformacionSB2Error').hide();
    });

    $('#popupInformacionSB2Error .btn_ok_mobile').on('click', function () {
        $('#popupInformacionSB2Error').hide();
    });
    if ((typeof titulo != "undefined") && (titulo != "") && (titulo != null)) {
        $(".titulo_compartir").html("<b>" + titulo + "</b>")
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

function messageConfirmacion(message, fnAceptar) {
    $('#mensajeInformacionConfirmacion').html(message);
    $('#popupInformacionConfirmacion').show();
    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionConfirmacion .aceptar-mobile').off('click');
        $('#popupInformacionConfirmacion .aceptar-mobile').on('click', fnAceptar);
    }
}

function CargarCantidadProductosPedidos(noMostrarEfecto) {
    noMostrarEfecto = noMostrarEfecto || false;
    var montoWebAcumulado = "";

    console.log('MobileLayout.js - ajax ante num-menu-shop', urlGetCantidadProductos, { soloCantidad: true });

    jQuery.ajax({
        type: 'POST',
        url: urlGetCantidadProductos,
        dataType: 'json',
        data: JSON.stringify({ soloCantidad: true }),
        cache: false,
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

                console.log('MobileLayout.js - CargarCantidadProductosPedidos', data);
                $(".num-menu-shop").html(data.cantidadProductos);
                $(".js-span-pedidoingresado").html(montoWebAcumulado);
                if (!noMostrarEfecto) {
                    $('.num-menu-shop').removeClass('microefecto_color');
                    setTimeout(function () { $('.num-menu-shop').addClass('microefecto_color') }, 250);
                }

            }
        },
        error: function (data, error) { }
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

            }
        },
        error: function (data, error) { }
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
            }
        },
        error: function (data, error) { }
    });
}

function SeparadorMiles(pnumero) {

    var resultado = "";
    var numero = pnumero.replace(/\,/g, '');
    var nuevoNumero = "";
    if (numero[0] == "-") nuevoNumero = numero.replace(/\./g, '').substring(1);
    else nuevoNumero = numero.replace(/\./g, '');

    if (numero.indexOf(",") >= 0) nuevoNumero = nuevoNumero.substring(0, nuevoNumero.indexOf(","));

    for (var i = nuevoNumero.length - 1, j = 0; i >= 0; i-- , j++)
        resultado = nuevoNumero.charAt(i) + ((j > 0) && (j % 3 == 0) ? "." : "") + resultado;

    if (numero.indexOf(",") >= 0) resultado += numero.substring(numero.indexOf(","));

    if (numero[0] == "-") return "-" + resultado;
    else return resultado;
}

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
                LayoutHeader();
            }
        },
        error: function (err) { }
    });
}

function odd_mobile_google_analytics_promotion_impresion(list, event, index) {
    var impressions = [];
    var position = 0;
    var elements = list.length;
    var item = null;
    var impresion = null;
    if (event === 'page_load') {//Ok

        position = 1;
        for (var i = 0; i <= elements - 1; i++) {
            item = list[i];
            item.Posicion = position;
            if (position <= 3) {
                impresion = odd_get_item_impresion(item);
                if (impresion != null)
                    impressions.push(impresion);
            }
            else
                break;
            position++;
        }
    }
    if (event === 'arrow_click') {

        item = list[index];
        item.Posicion = index + 1;
        impresion = odd_get_item_impresion(item);
        if (impresion != null)
            impressions.push(impresion);
    }
    if (impressions.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': impressions
            }
        });
    }
}

function odd_get_item_impresion(item) {
    var impresion = null;
    if (item != null) {
        impresion = {
            'name': item.NombreOferta,
            'id': item.CUV2,
            'price': item.PrecioOferta,
            'brand': item.DescripcionMarca,
            'category': 'No disponible',
            'variant': 'Lanzamiento',
            'list': 'Oferta del día',
            'position': item.Posicion
        }
    }
    return impresion;
}

var comunicadoBannerApp;
function BannerApp() {
    if (oBannerApp == null || getMobileOperatingSystem() != "Android" || !VerificarVistaBannerApp()) {
        $('.banner_app').hide();
        return;
    }
    $(".banner_app div").click(function (e) {
        e.preventDefault();
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Banners',
            'action': 'Cerrar Banner',
            'label': 'Descargar app consultora'
        });
        $(".banner_app").hide();
        OcultarBannerApp();
        return false;
    });
    $(".banner_app").click(function (e) {
        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                        {
                            'id': '003',
                            'name': 'Descargar app consultora',
                            'position': controllerName + ' - Banner superior',
                            'creative': 'Banner'
                        }]
                }
            }
        });
        window.open(oBannerApp.DescripcionAccion);
    });
    $(".banner_app").css("background-image", "url(" + oBannerApp.UrlImagen + ")");
}

function VerificarVistaBannerApp() {
    for (var row = 0; row < oBannerApp.Vistas.length; row++) {
        var oVista = oBannerApp.Vistas[row];

        var nombreControlador = "";
        if (oVista.NombreControlador != undefined && oVista.NombreControlador != null) {
            nombreControlador = oVista.NombreControlador.toLowerCase();
        }
        var nombreVista = "";
        if (oVista.NombreVista != undefined && oVista.NombreVista != null) {
            nombreVista = oVista.NombreVista.toLowerCase();
        }

        if (nombreControlador != controllerName) continue;
        if (nombreVista == "" || nombreVista == actionName) return true;
    }
    return false;
}

function OcultarBannerApp() {
    $.ajax({
        type: 'GET',
        url: urlOcultarBannerApp,
        cache: false,
        success: function (response) {
            if (response.success) LayoutHeader();
        },
        error: function (err) { }
    });
}
function getMobileOperatingSystem() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;
    if (/windows phone/i.test(userAgent)) {
        return "Windows Phone";
    }
    if (/android/i.test(userAgent)) {
        return "Android";
    }
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return "iOS";
    }

    return "unknown";
}