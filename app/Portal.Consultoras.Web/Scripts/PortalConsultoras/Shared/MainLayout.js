
var showDisplayODD = 0;
var ventanaChat = null;

$(document).ready(function () {
    LayoutHeader();
    LayoutMenu();

    window.onresize = function (event) {
        LayoutMenu();
    };

    if (mostrarBannerPostulante == 'True') {
        $('#bloquemensajesPostulante').show();
    }
    else {
        MensajeEstadoPedido();
    }

    if (!esContenedorOfertas) {
        if (tieneOfertaDelDia == "True") {
            window.OfertaDelDia.CargarODD();
        }
    } else {
        if (mostrarOfertaDelDiaContenedor == "True") {
            window.OfertaDelDia.CargarODD();
        }
    }

    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            if ($('#PopFichaProductoNueva').is(':visible')) {
                CerrarPopup('#PopFichaProductoNueva');
            }

            if ($('#popupDetalleCarousel_lanzamiento').is(':visible')) {

                if ($(".content_ficha_producto_nueva").is(':visible')) {
                    if (document.getElementById('infusionsoft') != null) {
                        document.getElementsByTagName('head')[0].removeChild(document.getElementById('infusionsoft'));
                        dataLayerFichaProducto();
                    }
                }
                CerrarPopup('#popupDetalleCarousel_lanzamiento');
            }

            if ($('[data-popup-main]').is(':visible')) {
                var functionHide = $.trim($('[data-popup-main]').attr("data-popup-function-hide"));
                FuncionEjecutar(functionHide);

                if ($('#Cupon3').is(':visible')) {
                    CuponPopupCerrar();
                    return;
                }

                CerrarPopup('[data-popup-main]');
            }

            if ($('#dialog_PedidoReservado').is(':visible')) {
                $('#dialog_PedidoReservado').hide();
                window.location.href = "Login";
            }
            
            $('#alertDialogMensajes').dialog('close');
        }
    });

    $('.contenedor_popup_agregarUnidades').click(function (e) {
        if (!$(e.target).closest('.popup_agregarUnidades').length) {
            if ($('#dialog_SesionMainLayout').is(':visible')) {
                $('#dialog_SesionMainLayout').hide();
                window.location.href = "Login";
            }
        }
    });

    $('body').click(function (e) {
        if (!$(e.target).closest('#OfertaDelDia').length) {
            if ($('#PopOfertaDia').is(':visible')) {
                if (showDisplayODD == 1) {
                    $('#PopOfertaDia').slideUp();
                    $('.circulo_hoy span').html('+');
                    showDisplayODD = 0;
                }
            }
        }
    });

    $('.contenedor_popup_detalleCarousel, .Content_general_pop_up').click(function (e) {

        if (!$(e.target).closest('[data-popup-body]').length) {
            if ($(e.target).parent().attr("id") == "contentmain") {
                if ($(e.target).is(':visible')) {
                    var functionHide = $.trim($(this).attr("data-popup-function-hide"));
                    FuncionEjecutar(functionHide);
                    if ($(e.target).parents().find(".content_ficha_producto_nueva").length > 0) {
                        if (document.getElementById('infusionsoft') != null) {
                            document.getElementsByTagName('head')[0].removeChild(document.getElementById('infusionsoft'));
                            dataLayerFichaProducto();
                        }
                    }
                    CerrarPopup(e.target);
                }
            }
        }
    });

    $("body").on("click", "[data-popup-main]", function (e) {
        if (!$(e.target).closest('[data-popup-body]').length) {

            if ($(e.target).is(':visible')) {

                var functionHide = $.trim($(this).attr("data-popup-function-hide"));
                FuncionEjecutar(functionHide);

                CerrarPopup(e.target);
            }
        }
    });

    $("body").on("click", "[data-popup-close]", function (e) {
        var popupClose = $("#" + $(this).attr("data-popup-close"));// || $(this).parent("[data-popup-main]");
        popupClose = popupClose.length > 0 ? popupClose : $(this).parents("[data-popup-main]");
        popupClose = popupClose.length > 0 ? popupClose : $(this).parents("[data-popup-body]").parent();

        var functionHide = $.trim($(popupClose).attr("data-popup-function-hide"));
        FuncionEjecutar(functionHide);

        if (popupClose.find(".content_ficha_producto_nueva").length > 0) {

            if (document.getElementById('infusionsoft') != null) {
                document.getElementsByTagName('head')[0].removeChild(document.getElementById('infusionsoft'));
                dataLayerFichaProducto();
            }
        }
        CerrarPopup(popupClose);
    });

    $('[data-oferta]').click(function (e) {
        if (!$(e.target).closest('.cuerpo-mod').length) {
            if ($('[data-oferta]').is(':visible')) {
                $('[data-oferta]').hide();
            }
        }
    });

    if (mostrarBannerPostulante == 'True') {
        $('#bloquemensajesPostulante').show();
    }
    else {
        MensajeEstadoPedido();
    }

    $(document).ajaxStop(function () {
        $(this).unbind("ajaxStop");
        closeWaitingDialog();
    });

    HandlebarsRegisterHelper();
    SetFormatDecimalPais(formatDecimalPaisMain);
    CargarResumenCampaniaHeader();
    CargarCantidadNotificacionesSinLeer();

    $('#alertDialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons: { "Aceptar": function () { $(this).dialog('close'); } }
    });

    $('#ModalFeDeErratas').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 650,
        heigth: 500,
        draggable: true,
        title: "Fe de Erratas"
    });

    $('#divRegistroComunidad').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 760,
        heigth: 500,
        draggable: true,
        title: "Comunidad Somos Belcorp"
    });

    $('#DialogMensajesCom').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        title: "Comunidad SomosBelcorp",
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    $('#divMensajeConfirmacion').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
        title: "",
        close: function (event, ui) {
            $(this).dialog('close');
        }
    });

    $(".ValidaAlfanumericoCom").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return true;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9_-]/;
            return re.test(keyChar);
        }
    });

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

    $("body").on('paste',
        ".ValidaPasteNumeral",
        function(e) {
            var $input = $(this);
            var previousVal = $input.val();
            var pastedValue = e.originalEvent.clipboardData.getData('text/plain').trim();
            if (isNaN(pastedValue) === false && isInt(Number(pastedValue))) {
                $input.val(pastedValue);
                e.preventDefault();
            } else {
                $input.val(previousVal);
                e.preventDefault();
            }
        });

    $("body").on("click",
        ".menos",
        function() {
            if ($.trim($(this).data("bloqueada")) !== "") return false;

            var cantidad = parseInt($(this).parent().prev().val());
            cantidad = isNaN(cantidad) ? 0 : cantidad;
            cantidad = cantidad > 1 ? (cantidad - 1) : 1;
            $(this).parent().prev().val(cantidad);
        });

    $("body").on("click", ".mas", function () {
        if ($.trim($(this).data("bloqueada")) !== "") return false;

        var cantidad = parseInt($(this).parent().prev().val());
        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad < 99 ? (cantidad + 1) : 99;
        $(this).parent().prev().val(cantidad);
    });

    $("body").on("click", ".cantidad_menos_home", function (e) {
        if ($.trim($(this).data("bloqueada")) !== "") return false;
        var $txtcantidad = $(this).siblings('input');
        var cantidad = parseInt($txtcantidad.val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad > 1 ? (cantidad - 1) : 1;

        $txtcantidad.val(cantidad);
        e.stopPropagation();
    });

    $("body").on("click", ".cantidad_mas_home", function (e) {
        if ($.trim($(this).data("bloqueada")) !== "") return false;
        var $txtcantidad = $(this).siblings('input');
        var cantidad = parseInt($txtcantidad.val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad < 99 ? (cantidad + 1) : 99;

        $txtcantidad.val(cantidad);
        e.stopPropagation();
    });

    $("#belcorpChatEcuador").click(function () {
        var url = 'http://200.32.70.19/Belcorp/';
        window.open(url, '_blank');
    });
    $("#belcorpChat a_").click(function () {
        if (this.href.indexOf('#') != -1) {
            alert_unidadesAgregadas("Por el momento el chat no se encuentra disponible. Volver a intentarlo más tarde", 2);
        }
    });

    $("body").on('click', '.belcorpChat', function (e) {
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

    setInterval(animacionFlechaScroll, 1000);

});


function AbrirVentanaBelcorpChat(url) {
    var res = encodeURI(url);
    ventanaChat = open(res, 'ventanaChat', 'top=0,left=0,width=400,height=500');
    ventanaChat.focus();
}

function messageInfoError(message, titulo, fnAceptar) {
    message = $.trim(message);
    if (message != "") {
        $('#dialog_ErrorMainLayout #mensajeInformacionSB2_Error').html(message);
        $('#dialog_ErrorMainLayout').show();

        $('#dialog_ErrorMainLayout .btn_ok').off('click');
        $('#dialog_ErrorMainLayout .btn_cerrar_agregarUnidades a').off('click');

        $('#dialog_ErrorMainLayout .btn_ok').on('click', function () {
            $('#dialog_ErrorMainLayout').hide();
            if ($.isFunction(fnAceptar)) fnAceptar();
        });

        $('#dialog_ErrorMainLayout .btn_cerrar_agregarUnidades a').on('click', function () {
            $('#dialog_ErrorMainLayout').hide();
            if ($.isFunction(fnAceptar)) fnAceptar();
        });
    }
}



function CargarResumenCampaniaHeader(showPopup) {
    
    showPopup = showPopup || false;

    var soloCantidad = true;
    if (typeof controllerName == "undefined") {
        soloCantidad = false;
    }
    else {
        soloCantidad = controllerName == 'pedido';
    }

    $.ajax({
        type: 'POST',
        url: baseUrl + 'GestionContenido/GetResumenCampaniaAgrupado',
        data: JSON.stringify({ soloCantidad: soloCantidad }),
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.result) {

                    data.montoWebAcumulado = DecimalToStringFormat(data.montoWebAcumulado);

                    $("#pCantidadProductosPedido").html(data.cantidadProductos > 0 ? data.cantidadProductos : 0);

                    $('#spanPedidoIngresado').text(data.Simbolo + " " + data.montoWebConDescuentoStr);

                    $.each(data.ultimosTresPedidos, function (index, item) {
                        item.ImporteTotal = DecimalToStringFormat(item.ImporteTotal);
                    });

                    if (data.ultimosTresPedidos.length == 0) {
                        $('#carrito_items').hide();
                        $('#SinProductos').show();
                    } else {
                        $('#carrito_items').show();
                        $('#SinProductos').hide();

                        SetHandlebars("#resumenCampania-template", data, "#carrito_items");
                    }

                    if (showPopup == true) {
                        microefectoPedidoGuardado();

                    }
                }
            }
        },
        error: function (data, error) { }
    });
}

function microefectoPedidoGuardado() {
    $(".contenedor_circulos").fadeIn();
    setTimeout(function () {
        $(".contenedor_circulos").fadeOut();
    }, 2700);
}

function CargarCantidadNotificacionesSinLeer() {
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + "Notificaciones/GetNotificacionesSinLeer",
        data: '',
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.cantidadNotificaciones > 0) {
                    $(document).find(".js-notificaciones2").html(data.cantidadNotificaciones);
                    $(document).find(".js-notificaciones").html(data.cantidadNotificaciones);
                    $(document).find(".js-notificaciones").addClass("notificaciones_activas");
                    $(document).find(".js-cantidad_notificaciones").html(data.cantidadNotificaciones);
                } else {
                    $(document).find(".aviso_mensajes").html('NO <b>TIENES MENSAJES SIN LEER</b>');
                    $(document).find(".js-notificaciones").html(0);
                    $(document).find(".js-notificaciones").removeClass("notificaciones_activas");
                    $(document).find("#mensajeNotificaciones").html("No tienes notificaciones. ");
                }

                data.mensaje = data.mensaje || "";
            }
        },
        error: function (data, error) { }
    });
}

function AbrirModalFeErratas() {
    waitingDialog({});

    $.ajax({
        type: 'GET',
        url: baseUrl + 'FeErratas/Index',
        data: '',
        cache: false,
        dataType: 'Json',
        success: function (data) {
            var arrayFeErratas = $.map(data.lista, function (obj, index) {
                return {
                    Titulo: obj.Titulo,
                    Campania: obj.NombreCorto,
                    Pagina: obj.Pagina,
                    Dice: obj.Dice,
                    DebeDecir: obj.DebeDecir
                };
            });

            var result = '';
            for (var i = 0; i < arrayFeErratas.length; i++) {
                result += '<li>';
                result += '<span class="tit_fede">' + arrayFeErratas[i].Titulo + ' - <label>' + arrayFeErratas[i].Campania + '</label></span>';
                result += '<span class="tit_fede"><label>Página:</label>' + arrayFeErratas[i].Pagina + '</span>';
                result += '<span class="tit_fede"><label>Dice:</label>' + arrayFeErratas[i].Dice + '</span>';
                result += '<span class="tit_fede"><label>Debe decir:</label>' + arrayFeErratas[i].DebeDecir + '</span>';
                result += '</li>';
            }
            $('#ListadoFeErratas').html(result);
        }
    });

    setTimeout(function () { showDialog("ModalFeDeErratas") }, 1500);
    closeWaitingDialog();
    return false;
}
function SeparadorMiles(pnumero) {
    var resultado = "";
    var numero = pnumero.replace(/\,/g, '');
    var nuevoNumero = "";
    if (numero[0] == "-") nuevoNumero = numero.replace(/\./g, '').substring(1);
    else nuevoNumero = numero.replace(/\./g, '');

    if (numero.indexOf(",") >= 0) nuevoNumero = nuevoNumero.substring(0, nuevoNumero.indexOf(","));

    for (var  i = nuevoNumero.length - 1, j = 0; i >= 0; i--, j++)
        resultado = nuevoNumero.charAt(i) + ((j > 0) && (j % 3 == 0) ? "." : "") + resultado;

    if (numero.indexOf(",") >= 0) resultado += numero.substring(numero.indexOf(","));

    if (numero[0] == "-") return "-" + resultado;
    else return resultado;
}

function ValidarCorreoComunidad(tipo) {
    $.ajaxSetup({
        cache: false
    });
    var result = true;
    if (tipo == 2) {

        if ($('#txtUsuarioComunidad').val() == 'Tu apodo en la comunidad') {
            $('#ErrorUsuario').css({ "display": "block" });
            $('#ES_Usuario').css({ "display": "block" });
            $('#ErrorUsuario').html("Debe ingresar un apodo.");
            result = false;
        }


        if ($('#txtNuevoCorreoComunidad').val() == 'Correo electrónico') {
            $('#ErrorCorreo').css({ "display": "block" });
            $('#ES_Correo').css({ "display": "block" });
            $('#ErrorCorreo').html("Debe ingresar su correo.");
            result = false;
        }
        else {
            if (!ValidarCorreo($('#txtNuevoCorreoComunidad').val())) {
                $('#ErrorCorreo').css({ "display": "block" });
                $('#ES_Correo').css({ "display": "block" });
                $('#ErrorCorreo').html("El formato del correo es incorrecto.");
                $('#ErrorCorreo').css({ "color": "red" });
                result = false;
            }
     
        }

        if (result) {
            if ($('#ErrorUsuario').html() != 'Apodo Disponible.' || $('#ErrorCorreo').html() != 'Correo Disponible.')
                return;
            var params = {
                usuario: $("#txtUsuarioComunidad").val(),
                correo: $("#txtNuevoCorreoComunidad").val()
            };

            waitingDialog({});
            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'Bienvenida/RegistrarUsuarioComunidad',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(params),
                async: true,
                success: function (data) {
                    if (checkTimeout(data)) {
                        closeWaitingDialog();
                        if (data.success == true) {
                            $('#divRegistroComunidad').dialog('option', 'width', 540);
                            $("#divRegistroComunidad").dialog("option", "position", "center");
                            $("#divRegCom_Form").css({ "display": "none" });
                            $("#divMenCom_Form").css({ "display": "block" });

                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Formulario',
                                'action': 'Crear cuenta',
                                'label': 'Mi comunidad'
                            });

                        } else {
                            alert_msg_com(data.message);
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
    } else {

        if ($('#txtCorreoComunidad').val() == 'Correo electrónico') {
            $('#ErrorCorreoC').css({ "display": "block" });
            $('#ES_CorreoC').css({ "display": "block" });
            $('#ErrorCorreoC').html("Debe ingresar su correo.");
            result = false;
        }
        else {
            if (!ValidarCorreo($('#txtCorreoComunidad').val())) {
                $('#ErrorCorreoC').css({ "display": "block" });
                $('#ES_CorreoC').css({ "display": "block" });
                $('#ErrorCorreoC').html("El formato del correo es incorrecto.");
                $('#ErrorCorreoC').css({ "color": "red" });
                result = false;
            }
        }

        if (result) {
            if ($('#ErrorCorreo').html() != '')
                return;

     

            waitingDialog({});
            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'Bienvenida/ValidarCorreoComunidad',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    correo: $("#txtCorreoComunidad").val()
                }),
                async: true,
                success: function (data) {

                    if (checkTimeout(data)) {
                        closeWaitingDialog();
                        if (data.success == true) {

                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Formulario',
                                'action': 'Ingresar',
                                'label': 'Mi comunidad'
                            });

                            $('#divRegistroComunidad').dialog('option', 'width', 540);
                            $("#divRegistroComunidad").dialog("option", "position", "center");
                            $("#divRegCom_Form").css({ "display": "none" });
                            $("#divMenCom_Form").css({ "display": "block" });
                        } else {
                            alert_msg_com(data.message);
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
    }
}

function alert_msg(message, titulo, funcion) {
    titulo = titulo || "MENSAJE";
    $('#alertDialogMensajes .terminos_title_2').html(titulo);
    $('#alertDialogMensajes .pop_pedido_mensaje').html(message);
    if (typeof funcion == "function") {
        $("#alertDialogMensajes").dialog("option", "buttons", {
            "Ver Ofertas": function () { funcion(); }
        });
    }
    $('#alertDialogMensajes').dialog('open');
}
function alert_msg_com(message) {
    $('#DialogMensajesCom .message_text').html(message);
    $('#DialogMensajesCom').dialog('open');
}
function AbrirModalRegistroComunidad() {

    if (gTipoUsuario == '2') {
        URL = 'http://comunidad.somosbelcorp.com/';
        window.open(URL, '_blank');
        return false;
    }
    $.ajaxSetup({
        cache: false
    });
    $('#divRegistroComunidad').dialog('option', 'width', 760);
    $("#divRegistroComunidad").dialog("option", "position", "center");
    $("#divRegCom_Form").css({ "display": "block" });
    $("#divMenCom_Form").css({ "display": "none" });
    showDialog("divRegistroComunidad");
    SendPushMiComunidad();

    return false;
}
function SendPushMiComunidad() {
    dataLayer.push({ 'event': 'virtualPage', 'pageUrl': '/mi-comunidad/formulario-de-registro', 'pageTitle': 'Mi comunidad – Formulario de registro' });
}
function ValidarUsuarioIngresado(usuario) {
    $.ajaxSetup({
        cache: false
    });
    $('#ValUsuario').css({ "display": "block" });
    $('#ErrorUsuario').css({ "display": "none" });
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/ValidarUsuarioIngresado",
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
            } else {
                $('#ErrorUsuario').html("Apodo Disponible.");
                $('#ErrorUsuario').css({ "color": "green" });
            }
        },
        error: function (result) {
            alert('Ocurrió un error al intentar validar el usuario. Por favor, volver a intentar.');
        }
    });
}
function ValidarCorreoIngresado(correo) {
    $.ajaxSetup({
        cache: false
    });
    $('#ValCorreo').css({ "display": "block" });
    $('#ErrorCorreo').css({ "display": "none" });
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/ValidarCorreoIngresado",
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
            } else {
                $('#ErrorCorreo').html("Correo Disponible.");
                $('#ErrorCorreo').css({ "color": "green" });
            }
        },
        error: function (result) {
            alert('Ocurrió un error al intentar validar el correo. Por favor, volver a intentar.');
        }
    });
}
function ValidarCorreo(correo) {
    var expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$/;
    return expr.test(correo);
}

function MostrarShowRoomBannerLateral() {


    $("#lnkConoceMasShowRoomBannerLateral").click(function () {
        AgregarTagManagerShowRoomBannerLateralConocesMas(false);
    });

    $("#lnkConoceMasShowRoomBannerLateralHoy").click(function () {
        AgregarTagManagerShowRoomBannerLateralConocesMas(true);
    });

    var togglediv = 0;

    $("#ctras").click(function () {
        if (togglediv == 0) {
            $('.caja-traslado').animate({
                'right': '0'
            }, 800);
            togglediv = 1;
            AgregarTagManagerShowRoomBannerLateral(false);
        }
        else if (togglediv == 1) {
            $('.caja-traslado').animate({
                'right': '-181px'
            }, 800);
            togglediv = 0;
        }
    });

    $("#ctrasHoy").click(function () {
        if (togglediv == 0) {
            $('.caja-traslado').animate({
                'right': '0'
            }, 800);
            togglediv = 1;
            AgregarTagManagerShowRoomBannerLateral(true);
        }
        else if (togglediv == 1) {
            $('.caja-traslado').animate({
                'right': '-181px'
            }, 800);
            togglediv = 0;
        }
    });

    if (viewBagRol == 1) {
        if (!sesionEsShowRoom) {
            return;
        }
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/MostrarShowRoomBannerLateral",
            contentType: 'application/json',
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        var showroomConsultora = response.data;
                        var evento = response.evento;

                        if (showroomConsultora.EventoConsultoraID != 0) {
                            if (response.estaActivoLateral) {
                                $("#hdTemaEventoShowRoom").val(evento.Tema);
                                $("#hdEventoIDShowRoom").val(evento.EventoID);

                                if (response.mostrarShowRoomProductos) {
                                    $("#lnkConoceMasShowRoomBannerLateralHoy").attr("href", response.rutaShowRoomBannerLateral);

                                    $("#imgVentaTagLateralHoy").attr("src", evento.ImagenVentaTagLateral);
                                    $("#imgPestaniaShowRoomLateralHoy").attr("src", evento.ImagenPestaniaShowRoom);

                                    $("#ctrasHoy").show();

                                    $('.caja-traslado').animate({
                                        'right': '0'
                                    }, 800);

                                    setTimeout(function () {
                                        $('.caja-traslado').animate({
                                            'right': '-181px'
                                        }, 800);
                                    }, 5000);

                                } else {
                                    $("#lnkConoceMasShowRoomBannerLateral").attr("href", response.rutaShowRoomBannerLateral);
                                    AgregarTimerShowRoom(response.diasFaltantes, response.mesFaltante, response.anioFaltante);

                                    $("#imgPestaniaShowRoomLateral").attr("src", evento.ImagenPestaniaShowRoom);

                                    $("#ctras").show();

                                    $('.caja-traslado').animate({
                                        'right': '0'
                                    }, 800);

                                    setTimeout(function () {
                                        $('.caja-traslado').animate({
                                            'right': '-181px'
                                        }, 800);
                                    }, 5000);
                                }
                            }
                        }
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                }
            }
        });
    }

}

function AgregarTimerShowRoom(dia, mes, anio) {
    var calcNewYear = setInterval(function () {
        date_future = new Date(anio, mes - 1, dia);
        date_now = new Date();

        seconds = Math.floor((date_future - (date_now)) / 1000);
        minutes = Math.floor(seconds / 60);
        hours = Math.floor(minutes / 60);
        days = Math.floor(hours / 24);

        hours = hours - (days * 24);
        minutes = minutes - (days * 24 * 60) - (hours * 60);
        seconds = seconds - (days * 24 * 60 * 60) - (hours * 60 * 60) - (minutes * 60);

        $("#spnDiasFaltantes").html(days);
        $("#spnHorasFaltantes").html(hours);
        $("#spnMinutosFaltantes").html(minutes);
        $("#spnSegundosFaltantes").html(seconds);

        if (days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
            clearInterval(calcNewYear);

            $("#lnkConoceMasShowRoomBannerLateralHoy").attr("href", baseUrl + "ShowRoom/Index");
            $("#ctras").hide();
            $("#ctrasHoy").show();
        }
        if (days < 0) {
            $("#spnDiasFaltantes").html(0);
            $("#spnHorasFaltantes").html(0);
            $("#spnMinutosFaltantes").html(0);
            $("#spnSegundosFaltantes").html(0);
            clearInterval(calcNewYear);

            $("#lnkConoceMasShowRoomBannerLateralHoy").attr("href", baseUrl + "ShowRoom/Index");
            $("#ctras").hide();
            $("#ctrasHoy").show();
        }
    }, 1000);
}

function AgregarTagManagerShowRoomBannerLateral(esHoy) {
    var name = 'showroom digital ' + $("#hdTemaEventoShowRoom").val();

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
                        'position': 'Home lateral - 1',
                        'creative': 'Banner'
                    }]
            }
        }
    });
}

function AgregarTagManagerShowRoomBannerLateralConocesMas(esHoy) {
    var name = 'showroom digital ' + $("#hdTemaEventoShowRoom").val();

    if (esHoy)
        name += " - fase 2";

    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                    {
                        'id': $("#hdEventoIDShowRoom").val(),
                        'name': name,
                        'position': 'Home lateral - 1',
                        'creative': 'Banner'
                    }]
            }
        }
    });
}

function RedirectIngresaTuPedido() {
    location.href = baseUrl + 'Pedido/Index';
}
function CerrarSesion() {
    if (typeof (Storage) !== 'undefined') {
        var itemSBTokenPais = localStorage.getItem('SBTokenPais');
        var itemSBTokenPedido = localStorage.getItem('SBTokenPedido');

        localStorage.clear();

        if (typeof (itemSBTokenPais) !== 'undefined' && itemSBTokenPais !== null) {
            localStorage.setItem('SBTokenPais', itemSBTokenPais);
        }

        if (typeof (itemSBTokenPedido) !== 'undefined' && itemSBTokenPedido !== null) {
            localStorage.setItem('SBTokenPedido', itemSBTokenPedido);
        }
    }

    location.href = baseUrl + 'Login/LogOut';
}
function Notificaciones() {
    location.href = baseUrl + 'Notificaciones/Index';
}
function SetMarcaGoogleAnalyticsTermino() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom',
        'action': 'Click enlace',
        'label': 'Términos y Condiciones'
    });
}

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
                    location.href = baseUrl + 'Pedido/PedidoValidado'
                }
                if (mostrarAlerta == true) {
                    closeWaitingDialog();
                    AbrirMensaje(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true)
                AbrirMensaje(data.message);
        },
        error: function (data, error) {
            AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}

function alert_msg_pedido(message) {
    $('#alertDialogMensajes .pop_pedido_mensaje').html(message);
    $('#alertDialogMensajes').dialog('open');
}

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
    if (imagenProducto.length == 0) {
        imagenProducto = $('.imagen_producto', $(o).parents("[data-item]"));
    }
    if (imagenProducto.length > 0) {
        var carrito = $('.campana.cart_compras');

        $.each(carrito, function (indC, car) {
            if ($(car).offset().left > 0) {
                carrito = $(car);
            }
        });

        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

        $(".transicion").css({
            'height': imagenProducto.css("height"),
            'width': imagenProducto.css("width"),
            'top': imagenProducto.offset().top,
            'left': imagenProducto.offset().left
        }).animate({
            'top': carrito.offset().top,
            'left': carrito.offset().left,
            'height': carrito.css("height"),
            'width': carrito.css("width"),
            'opacity': 0.5
        }, 450, 'swing', function () {
            $(this).animate({
                'top': carrito.offset().top,
                'opacity': 0
            }, 150, 'swing', function () {
                $(this).remove();
            });
        });
    }
}

function checkCountdownODD() {
    var ok = true;
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetOfertaDelDia',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                var _data = response.data;
                var tq = _data.TeQuedan;

                if (tq.TotalSeconds <= 0)
                    ok = false;
            }
        },
        error: function (err) { }
    });

    return ok;
}

function getQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID) {
    var qty = 0;
    var obj = { cuv: cuv2, tipoEstrategiaID: tipoEstrategiaID };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetQtyPedidoDetalleByCuvODD',
        data: JSON.stringify(obj),
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                qty = parseInt(response.cantidad);
            }
        },
        error: function (err) { }
    });

    return qty;
}

function messageConfirmacion(title, message, fnAceptar) {
    title = $.trim(title);
    if (title == "")
        title = "MENSAJE";

    message = $.trim(message);
    if (message == "") {
        return false;
    }

    $('#divMensajeConfirmacion .divTitle').html(title);
    $('#divMensajeConfirmacion .divTexto p').html(message);
    $('#divMensajeConfirmacion').dialog('open');
    if ($.isFunction(fnAceptar)) {
        $('#divMensajeConfirmacion .btnMensajeAceptar').off('click');
        $('#divMensajeConfirmacion .btnMensajeAceptar').on('click', fnAceptar);
    }
}

function closeOfertaDelDia(sender) {
    var nombreProducto = $(sender)
        .parent()
        .find("[data-item-campos]")
        .find('.nombre-odd').val();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/CloseOfertaDelDia',
        //async: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                $('#OfertaDelDia').hide();
                LayoutHeader();
                odd_desktop_google_analytics_cerrar_banner(nombreProducto);
            }
        },
        error: function (err) { }
    });
}

function odd_desktop_google_analytics_cerrar_banner(nombreProducto) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Oferta del día',
        'action': 'Cerrar Banner',
        'label': nombreProducto
    });
}

function dataLayerFichaProducto() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Coach Virtual – Ficha de producto',
        'action': 'Banner Ficha Producto',
        'label': 'Cerrar,popup'
    });
}
