$(document).ready(function () {

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

    $("#belcorpChat").click(function () {
        var url = UrlChat.replace('amp;', '').replace('amp;', '').replace('amp;', '').replace('amp;', '').replace('&#250;', 'ú').replace('&#233;', 'é').replace('&#225;','á');
        var res = encodeURI(url);
        open(res, '', 'top=0,left=0,width=400,height=500');
    });

    Scrolling();
    MostrarShowRoomBannerLateral();
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

    $("#ctras").hover(function () {
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

    $("#ctrasHoy").hover(function () {
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
                                } else {
                                    $("#lnkConoceMasShowRoomBannerLateral").attr("href", response.rutaShowRoomBannerLateral);
                                    AgregarTimerShowRoom(response.diasFaltantes, response.mesFaltante, response.anioFaltante);

                                    //Carga de Imagenes
                                    $("#imgPestaniaShowRoomLateral").attr("src", evento.ImagenPestaniaShowRoom);

                                    //$("#ctrasHoy").hide();
                                    $("#ctras").show();
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