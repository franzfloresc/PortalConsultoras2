
var showDisplayODD = 0;

$(document).ready(function () {

    /*PL20-1226*/
    if (tieneOfertaDelDia == "True") {
        loadOfertaDelDia();
    }

    $(document).keyup(function (e) {
        if (e.keyCode == 27) { // esc keycode
            if ($('#PopOfertaDia').is(':visible')) {
                $('#PopOfertaDia').slideUp();
                $('.circulo_hoy span').html('+');
                showDisplayODD = 0;
            }

            if ($('#PopFichaProductoNueva').is(':visible')) {
                $('#PopFichaProductoNueva').hide();
            }

            if ($('#popupDetalleCarousel_lanzamiento').is(':visible')) {
                $('#popupDetalleCarousel_lanzamiento').hide();
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

    /*PL20-1226*/

    $('.Content_general_pop_up').click(function (e) {
        if (!$(e.target).closest('.content_ficha_producto_nueva').length) {
            if ($('#PopFichaProductoNueva').is(':visible')) {
                $('#PopFichaProductoNueva').hide();
            }
        }
    });

    $('.contenedor_popup_detalleCarousel').click(function (e) {
        if (!$(e.target).closest('.popup_detalleCarousel').length) {
            if ($('#popupDetalleCarousel_lanzamiento').is(':visible')) {
                $('#popupDetalleCarousel_lanzamiento').hide();
            }
        }
    });

    waitingDialog();

    MensajeEstadoPedido();

    closeWaitingDialog();

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
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
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

    $("body").on("click", ".menos", function () {
        var cantidad = parseInt($(this).parent().prev().val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad > 1 ? (cantidad - 1) : 1;

        $(this).parent().prev().val(cantidad);
    });

    $("body").on("click", ".mas", function () {
        var cantidad = parseInt($(this).parent().prev().val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad < 99 ? (cantidad + 1) : 99;

        $(this).parent().prev().val(cantidad);
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
    
    $("#belcorpChat").click(function () {
        var FechaChatPais = BelcorpFechaChat_Pais;
        var PaisISO = IsoPais
        var fechaActual = FechaActual;
        var paisesBelcorpEMTELCO = PaisesChatEMTELCO;

        if (paisesBelcorpEMTELCO.indexOf(PaisISO) > -1) {

            if (fechaActual >= FechaChatPais)
            {
                var url = UrlChat.replace('amp;', '').replace('amp;', '').replace('amp;', '').replace('amp;', '').replace('&#250;', 'ú').replace('&#233;', 'é').replace('&#225;', 'á');
                var res = encodeURI(url);
                open(res, '', 'top=0,left=0,width=400,height=500');
            }
            else {

                if (PaisISO == "PA")
                {
                    var urlPA = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatPanama?token=3CE1BADDC9B55D2ED542C7FE9DCF9FF7';
                    var urlPA_ = encodeURI(urlPA);
                    open(urlPA_, '', 'top=0,left=0,width=400,height=500');
                }
                else if (PaisISO == "CR")
                {
                    var urlCR = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatCostaRica?token=BAF8696BC16A348C115E38D9C8055FC9';
                    var urlCR_ = encodeURI(urlCR);
                    open(urlCR_, '', 'top=0,left=0,width=400,height=500');
                }
                else if (PaisISO == "SV")
                {
                    var urlSV = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatElSalvador?token=556569C007FE003C83FB57EAE6DB2C49';
                    var urlSV_ = encodeURI(urlSV);
                    open(urlSV_, '', 'top=0,left=0,width=400,height=500');
                }
                else if (PaisISO == "GT") {
                    var urlGT = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatGuatemala?token=B7FC02F2A29AFAFBA695971203901170';
                    var urlGT_ = encodeURI(urlGT);
                    open(urlGT_, '', 'top=0,left=0,width=400,height=500');
                }
                else {
                    var res2 = encodeURI(UrlChatAnterior);
                    open(res2, '', 'top=0,left=0,width=400,height=500');
                }
            }
        }
        else {

            if (PaisISO == "PA") {
                var urlPA = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatPanama?token=3CE1BADDC9B55D2ED542C7FE9DCF9FF7';
                var urlPA_ = encodeURI(urlPA);
                open(urlPA_, '', 'top=0,left=0,width=400,height=500');
            }
            else if (PaisISO == "CR") {
                var urlCR = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatCostaRica?token=BAF8696BC16A348C115E38D9C8055FC9';
                var urlCR_ = encodeURI(urlCR);
                open(urlCR_, '', 'top=0,left=0,width=400,height=500');
            }
            else if (PaisISO == "SV") {
                var urlSV = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatElSalvador?token=556569C007FE003C83FB57EAE6DB2C49';
                var urlSV_ = encodeURI(urlSV);
                open(urlSV_, '', 'top=0,left=0,width=400,height=500');
            }
            else if (PaisISO == "GT") {
                var urlGT = 'https://chat1-cls1-cgn-bct.i6.inconcertcc.com/inconcert/apps/webdesigner/BelcorpChatGuatemala?token=B7FC02F2A29AFAFBA695971203901170';
                var urlGT_ = encodeURI(urlGT);
                open(urlGT_, '', 'top=0,left=0,width=400,height=500');
            }
            else {
                var res2 = encodeURI(UrlChatAnterior);
                open(res2, '', 'top=0,left=0,width=400,height=500');
            }
        }
    });

    Scrolling();
    MostrarShowRoomBannerLateral();        

    /*PL20-1226*/
    setInterval(animacionFlechaScroll, 1000);

});

function alert_msg(message, titulo) {
    titulo = titulo || "MENSAJE";
    $('#alertDialogMensajes .terminos_title_2').html(titulo);
    $('#alertDialogMensajes .pop_pedido_mensaje').html(message);
    $('#alertDialogMensajes').dialog('open');
}

function messageInfoError(message, titulo) {
    $('#dialog_ErrorMainLayout #mensajeInformacionSB2_Error').html(message);
    $('#dialog_ErrorMainLayout').show();
}

function microefectoPedidoGuardado() {
    $(".contenedor_circulos").fadeIn();
}

function CargarResumenCampaniaHeader(showPopup) {
    showPopup = showPopup || false;
    $.ajax({
        type: 'GET',
        url: baseUrl + 'GestionContenido/GetResumenCampania',
        data: '',
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

                        //$("#carrito_items").html('');
                        //var source = $("#resumenCampania-template").html();
                        //var template = Handlebars.compile(source);
                        //var context = data;
                        //var html = template(context);
                        //$("#carrito_items").append(html);
                    }

                    if (showPopup == true) {
                        //$('.info_cam').fadeIn(200);
                        //setTimeout(function () {
                        //    $('.info_cam').fadeOut(200);
                        //    setTimeout(function () {
                        //        $('.info_cam').removeAttr("style");
                        //    }, 300);
                        //}, 5000);
                        microefectoPedidoGuardado();
                        setTimeout(function(){
                            $(".contenedor_circulos").fadeOut();
                        }, 2700);
                    }
                }
                else {
                    console.error("Ocurrio un error con el Resumen de Campaña.");
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(error);
            }
        }
    });
};
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
                };

                data.mensaje = data.mensaje || "";
                if (data.mensaje != '') {
                    console.log(data.mensaje);
                }
            };
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(error);
            }
        }
    });
};
function Scrolling() {
    //ToDown & ToUp
    var y = $(window).scrollTop();
    $('#toUp').hide();
    $('#toUp').attr("style", "top: 580px !important");
    $('#toDown').click(function () {
        y = $(window).scrollTop() + $(window).height() - 50;
        $('html, body').animate({ scrollTop: y }, 1000);
    });
    $('#toUp').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1000);
    });

    var altura = $('header').offset().top;

    $(window).on('scroll', function () {
        if ($(window).scrollTop() >= altura + 50) {
            $('.logo_esika_tam').attr('src', baseUrl + 'Content/Images/Esika/logo_menu_esika.png');
        } else {
            $('.logo_esika_tam').attr('src', baseUrl + 'Content/Images/Esika/logo_esika.png');
        }

        //ToDown & ToUp
        if ($(window).scrollTop() + $(window).height() === $(document).height()) {
            $('#toDown').hide("slow");
            $('#toUp').show("slow");
        } else {
            $('#toDown').show("slow");
            $('#toUp').hide("slow");
        }
    });
};
function AbrirModalFeErratas() {
    waitingDialog({});

    // llamada para cargar banners y llenar su template
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
};
function SeparadorMiles(pnumero) {
    // Función que colocará el caracter "." como separador de miles.

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

/*Inicio Cambios_Landing_Comunidad*/
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
        else {
            if ($('#ErrorUsuario').html() != "Este apodo ya existe.") {

            }
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
            else {
                if ($('#ErrorCorreo').html() != "Este correo ya existe.") {

                }
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
                        alert_msg_com(data.message);
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

            var params = {
                correo: $("#txtCorreoComunidad").val()
            };

            waitingDialog({});
            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'Bienvenida/ValidarCorreoComunidad',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(params),
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
                        alert_msg_com(data.message);
                    }
                }
            });
        }
    }
};
function alert_msg_com(message) {
    $('#DialogMensajesCom .message_text').html(message);
    $('#DialogMensajesCom').dialog('open');
};
function AbrirModalRegistroComunidad() {
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
};
function SendPushMiComunidad() {
    dataLayer.push({ 'event': 'virtualPage', 'pageUrl': '/mi-comunidad/formulario-de-registro', 'pageTitle': 'Mi comunidad – Formulario de registro' });
};
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
};
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
};
function ValidarCorreo(correo) {   
    var expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$/;
    return expr.test(correo);
};
/*Fin Cambios_Landing_Comunidad*/

/*Inicio ShowRoom*/
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
        if (sesionEsShowRoom == '0') {
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
                                $("#hdNombreEventoShowRoom").val(evento.Tema);
                                $("#hdEventoIDShowRoom").val(evento.EventoID);

                                if (response.mostrarShowRoomProductos) {
                                    $("#lnkConoceMasShowRoomBannerLateralHoy").attr("href", response.rutaShowRoomBannerLateral);

                                    //Carga de Imagenes
                                    $("#imgVentaTagLateralHoy").attr("src", evento.ImagenVentaTagLateral);
                                    $("#imgPestaniaShowRoomLateralHoy").attr("src", evento.ImagenPestaniaShowRoom);

                                    //$("#ctras").hide();
                                    $("#ctrasHoy").show();

                                    //animacion parea mostrar                                    
                                    $('.caja-traslado').animate({
                                        'right': '0'
                                    }, 800);

                                    setTimeout(function () {
                                        //fanimacion para ocultar

                                        $('.caja-traslado').animate({
                                            'right': '-181px'
                                        }, 800);
                                    }, 5000);

                                } else {
                                    $("#lnkConoceMasShowRoomBannerLateral").attr("href", response.rutaShowRoomBannerLateral);
                                    AgregarTimerShowRoom(response.diasFaltantes, response.mesFaltante, response.anioFaltante);

                                    //Carga de Imagenes
                                    $("#imgPestaniaShowRoomLateral").attr("src", evento.ImagenPestaniaShowRoom);

                                    //$("#ctrasHoy").hide();
                                    $("#ctras").show();

                                    //animacion parea mostrar                                    
                                    $('.caja-traslado').animate({
                                        'right': '0'
                                    }, 800);

                                    setTimeout(function () {
                                        //fanimacion para ocultar

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
                    console.log("Ocurrió un error en ShowRoom");
                    //alert("Ocurrió un error en ShowRoom");
                }
            }
        });
    }

}

function AgregarTimerShowRoom(dia, mes, anio) {
    var calcNewYear = setInterval(function () {
        //date_future = new Date(new Date().getFullYear() + 1, 0, 1);
        date_future = new Date(anio, mes - 1, dia);
        date_now = new Date();

        seconds = Math.floor((date_future - (date_now)) / 1000);
        minutes = Math.floor(seconds / 60);
        hours = Math.floor(minutes / 60);
        days = Math.floor(hours / 24);

        hours = hours - (days * 24);
        minutes = minutes - (days * 24 * 60) - (hours * 60);
        seconds = seconds - (days * 24 * 60 * 60) - (hours * 60 * 60) - (minutes * 60);

        //$("#time").text("Time until new year:\nDays: " + days + " Hours: " + hours + " Minutes: " + minutes + " Seconds: " + seconds);
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
    var name = 'showroom digital ' + $("#hdNombreEventoShowRoom").val();

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
    var name = 'showroom digital ' + $("#hdNombreEventoShowRoom").val();

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
/* Fin ShowRoom */

/* Inicio Marcaciones */
function RedirectIngresaTuPedido() {
    location.href = baseUrl + 'Pedido/Index';
};
function CerrarSesion() {
    location.href = baseUrl + 'Login/LogOut';
};
function Notificaciones() {
    location.href = baseUrl + 'Notificaciones/Index';
};
function SetMarcaGoogleAnalyticsTermino() {
    dataLayer.push({ 'event': 'virtualEvent', 'category': 'Ofertas Showroom', 'action': 'Click enlace', 'label': 'Términos y Condiciones' });
};
/* Fin Marcaciones */

/* Tracking Jetlore */
// Se creo un JS => TrackingJetlore.js
/* Fin Tracking Jetlore */


/*PL20-1226*/
function loadOfertaDelDia() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetOfertaDelDia',
        //data: '{}',
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                var _data = response.data;
                SetHandlebars("#ofertadeldia-template", _data, '#OfertaDelDia');
                var tq = _data.TeQuedan;

                if (tq.TotalSeconds > 0) {
                    // config ODD
                    $('#OfertaDelDia').css('background', 'url("' + _data.ImagenFondo1 + '") repeat-x');
                    $('#banner-odd').css('background-color', _data.ColorFondo1);
                    $('#img-banner-odd').attr('src', _data.ImagenBanner);
                    $('#img-solohoy-odd').attr('src', _data.ImagenSoloHoy);
                    $('#PopOfertaDia').css('background', 'url("' + _data.ImagenFondo2 + '") no-repeat');
                    $('#PopOfertaDia').css('background-color', _data.ColorFondo2);
                    $('#img-display-odd').attr('src', _data.ImagenDisplay);

                    var obj1 = $('#OfertaDelDia').find('.descripcion_set_ofertaDia');
                    obj1.html(obj1.text());

                    $('#OfertaDelDia').show();

                    $('.content_slider_home').css('margin-top', '160px');
                    $('.ubicacion_web ').css('margin-top', '185px');

                    var int1odd = setInterval(function () {
                        if ($('#OfertaDelDia:visible').length > 0) {
                            $('.ubicacion_web ').css('margin-top', '185px');
                            clearInterval(int1odd);
                        }
                    }, 300);

                    var clock = $('.clock').FlipClock(tq.TotalSeconds, {
                        clockFace: 'HourlyCounter',
                        countdown: true
                    });

                    //var cambio = 0;
                    $('.btn_detalle_hoy').on('click', function () {
                        if (showDisplayODD == 0) {
                            $('#PopOfertaDia').slideDown();
                            $('.circulo_hoy span').html('-');
                            //cambio = 1;
                            showDisplayODD = 1;
                        }
                        else {
                            $('#PopOfertaDia').slideUp();
                            $('.circulo_hoy span').html('+');
                            //cambio = 0;
                            showDisplayODD = 0;
                        }
                    });
                }
                else {
                    $('#OfertaDelDia').hide();
                }
            }
        },
        error: function (err) {
            console.log(err);
        }
    });
};

function closeOfertaDelDia() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/CloseOfertaDelDia',
        //data: {},
        cache: false,
        //dataType: 'json',
        //contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                $('#OfertaDelDia').hide();

                $('.content_slider_home ').css('margin-top', '60px');
                $('.ubicacion_web ').css('margin-top', '83px');
            }
        },
        error: function (err) {
            console.log(err);
        }
    });
};

function addOfertaDelDiaPedido(tipo) {
    //debugger;
    var tipoEstrategiaID = $('#tipoestrategia-id-odd').val();
    var estrategiaID = $('#estrategia-id-odd').val();
    var marcaID = $('#marca-id-odd').val();
    var cuv2 = $('#cuv2-odd').val();
    var limiteVenta = parseInt($('#limite-venta-odd').val());
    var flagNueva = $('#flagnueva-odd').val();
    var precio = $('#precio-odd').val();
    var descripcion = $('#nombre-odd').val();
    var indMontoMinimo = $('#indmonto-min-odd').val();
    var teImagenMostrar = $('#teimagenmostrar-odd').val();
    var cantidad = (tipo == 1) ? 1 : parseInt($('#txtcantidad-odd').val());
    var origenPedidoWeb = 0;
    var msg1 = 'Solo puede llevar ' + limiteVenta.toString() + ' unidades de este producto.';

    if (tipo == 2 && cantidad <= 0) {
        alert_msg_pedido("Ingrese la cantidad a solicitar");
        return;
    }

    if (tipo == 1) {    // banner    
        if (typeof origenPagina == 'undefined') origenPedidoWeb = 1991; // general
        else if (origenPagina == 1) origenPedidoWeb = 1191; // home
        else if (origenPagina == 2) origenPedidoWeb = 1291; // pedido
    }
    else {      // display
        if (typeof origenPagina == 'undefined') origenPedidoWeb = 1992; // general
        else if (origenPagina == 1) origenPedidoWeb = 1192; // home
        else if (origenPagina == 2) origenPedidoWeb = 1292; // pedido

        if (cantidad > limiteVenta) {
            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
            $('#dialog_ErrorMainLayout').show();
            return;
        }
    }

    // validar si la oferta aun esta activa
    if (!checkCountdownODD()) {
        alert_msg_pedido('La Oferta del Día se termino');
        return false;
    }

    // validar cantidad a agregar (nuevas unidades o ya existentes)
    var cqty = getQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID);
    if (cqty > 0) {
        var tqty = cqty + cantidad;
        if (tqty > limiteVenta) {
            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
            $('#dialog_ErrorMainLayout').show();
            return;
        }
    }

    // validar horario restringido y pedido reservado
    if (ReservadoOEnHorarioRestringido())
        return false;

    // microefecto
    var objImg = (tipo == 1) ? $('#img-banner-odd') : $('#img-display-odd');
    //agregarProductoAlCarrito(objImg);

    var obj = ({
        MarcaID: marcaID,
        CUV: cuv2,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indMontoMinimo,
        TipoOferta: tipoEstrategiaID,
        ClienteID_: '-1',
        tipoEstrategiaImagen: teImagenMostrar || 0,
        OrigenPedidoWeb: origenPedidoWeb
    });

    waitingDialog({});

    //console.log(obj);

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
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
                    data: JSON.stringify(obj),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            closeWaitingDialog();
                            return false;
                        }

                        if (!data.success) {
                            messageInfoError(data.message);
                            closeWaitingDialog();
                            return false;
                        }

                        waitingDialog({});
                        if (typeof origenPagina !== 'undefined') {
                            MostrarBarra(data, '1');
                            ActualizarGanancia(data.DataBarra);
                            TagManagerClickAgregarProducto();
                        }
                        
                        //CargarCarouselEstrategias(cuv);
                        CargarResumenCampaniaHeader(true);
                        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv2);
                        closeWaitingDialog();
                        //if (popup) {
                        //    HidePopupEstrategiasEspeciales();
                        //}

                        if (tipo == 2) {
                            // ocultar display
                            $('#PopOfertaDia').slideUp();
                            $('.circulo_hoy span').html('+');
                            $('#txtcantidad-odd').val('1');
                        }

                        // si es pagina de pedido, recargar el detalle
                        if (typeof origenPagina !== 'undefined') {
                            if (origenPagina == 2) {    // pedido
                                CargarDetallePedido();
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

function alert_msg_pedido(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
};

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

function checkCountdownODD() {
    var ok = true;
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetOfertaDelDia',
        //data: '{}',
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
        error: function (err) {
            console.log(err);
        }
    });

    return ok;
};

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
        error: function (err) {
            console.log(err);
        }
    });

    return qty;
};
/*PL20-1226*/
