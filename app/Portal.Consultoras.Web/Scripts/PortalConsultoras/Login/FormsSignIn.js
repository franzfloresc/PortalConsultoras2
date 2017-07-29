var imgISO = "";
var _kiq = _kiq || [];
var activarHover = true;
var val_comboLogin = "";
var temp = "";
var openloginPopup = false;

var CodigoISO;
var PaisID;
var CodigoUsuario;

$(document).ready(function () {
    $(window).resize(function () {
        //resize just happened, pixels changed
        resizeNameUserExt();
    });

    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            
            if ($('#popupAsociarUsuarioExt').is(':visible')) {
                $('#popupAsociarUsuarioExt').hide();
            }
        }
    });

    $('#btnLoginFB').addClass('center_facebook');

    $("#ErrorTextLabel").css("padding-left", "0");
    $('#ddlPais').val(isoPais);

    if ($('#ddlPais').val() == null) isoPais = "00";
    $('#ddlPais').val(isoPais);
    $('#ddlPais2').val(isoPais);
    ayudaLogin2();
    
    //$('#cboPaisCambioClave').val(isoPais);

    if (avisoASP == 1) {
        $('#AvisoASP').hide();
    }
    else {
        $('#AvisoASP').css({
            'display': 'block',
            'color': '#959595',
            'font-family': 'lato',
            'font-size': '12px',
            'font-weight': 700,
            'text-alig': 'right',
            'text-decoration': 'none'
        });
    }
    
    if (banderaOk == 'True') {
        $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + isoPais + ".png') top 10px left 2px no-repeat");
        $("#cargarBandera2").css("background", "url('/Content/Images/Login2/Banderas/" + isoPais + ".png') top 10px left 2px no-repeat");
        $('#cargarBandera3').css("background", "url('/Content/Images/Login2/Banderas/" + isoPais + ".png') top 10px left 2px no-repeat");
    }
    else {
        $('#cargarBandera').css('background', "url('/Content/Images/Login2/Banderas/00.png') top -7px left -10px no-repeat");
        //$('#cargarBandera2').css('background', "url('/Content/Images/Login2/Banderas/00.png') top -7px left -10px no-repeat");
    }    

    _gaq.push(['_trackPageview', '/Somosbelcorp/Login']);

    $("#ddlPais").change(function () {
        imgISO = $("#ddlPais").val();

        if ($("#ddlPais").val() == "MX") {
            $("#AvisoASP").show();
        }
        else {
            $("#AvisoASP").hide();
        }       
        EsconderLogoEsikaPanama(imgISO);
        AsignarHojaEstilos();

        $('#ddlPais2').val(imgISO);
        ayudaLogin2();

        if ($("#ddlPais").val() == "CO") $("#VinculoTarjetaHelm").show();
        else $("#VinculoTarjetaHelm").hide();
    });

    $("#ddlPais2").change(function () {
        imgISO = $("#ddlPais2").val();
        
        if (paisesEsika.indexOf(imgISO) != -1) {
            $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
        }
        else {
            if (paisesLBel.indexOf(imgISO) != -1) {
                $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
            }
            else {
                $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top -7px left -10px no-repeat");
            }
        }

        ayudaLogin2();
        //AsignarHojaEstilos();
    });

    $("#box-pop-up").hide();

    $("#AvisoASP").click(function () {
        $("#box-pop-up").show();
        $("#pop-up-body").customScrollbar();
    });

    $("#box-pop-up-cerrar").click(function () {
        $("#box-pop-up").hide();
    });

    $("a.helper").mouseover(function () {
        if ($(window).width() > 1093) {
            if (activarHover == true) {
                if ($(this).hasClass("huno")) {
                    AbrirMensajeLogin(1);
                } else {
                    AbrirMensajeLogin(2);
                }
            }
        }
    });

    $("a.helper").mouseout(function () {
        if ($(window).width() > 1093) {
            if ($(this).hasClass("huno")) {
                $(".content-alerta-red-user > div").removeClass("alerta_red_block");
            } else {
                $(".content-alerta-red-clave > div").removeClass("alerta_red_block");
            }
        }
    });

    $(".cboPaisCambioClave").change(function () {
        var valorComboCC = $(this).val();
        var ISOPais = getISOPaisbyCodigo(valorComboCC);
        if (ISOPais != "00") $("#cargarBandera2").css("background", "url('/Content/Images/Login2/Banderas/" + ISOPais + ".png') top 10px left 2px no-repeat");
        else $("#cargarBandera2").css("background", "url('/Content/Images/Login2/Banderas/" + ISOPais + ".png') top -7px left -10px no-repeat");

        if (valorComboCC == "4") { //Colombia
            $('#txtCorreoElectronico').attr("placeholder", "Número de Cédula");
            $('#txtCorreoElectronico').parent().css("background-image", "url('')");
        }
        else {
            $("#txtCorreoElectronico").attr("placeholder", "Correo electrónico");
            $('#txtCorreoElectronico').parent().css("background-image", "");
        }

        $("#txtCorreoElectronico").val("");
        $("#txtCorreoElectronico").focus();
    });

    Inicializar();

    $('#frmLogin').on('submit', function (e) {
        // validation code here
        var valid = true;
        CodigoISO = $('#ddlPais').val();
        PaisID = $('#ddlPais :selected').data('id');
        CodigoUsuario = jQuery.trim($("#txtUsuario").val());
        var Contrasenia = jQuery.trim($("#txtContrasenia").val());
        $('#hdeCodigoISO').val(CodigoISO);
        var mensaje = "";

        if (PaisID == "")
            mensaje += "- Debe seleccionar el País del Usuario.\n";
        if (CodigoUsuario == "")
            mensaje += "- Debe ingresar el Usuario.\n";
        if (Contrasenia == "")
            mensaje += "- Debe ingresar la Clave Secreta.\n";

        if (mensaje != "") {
            valid = false;
            alert(mensaje);
            $('#ddlPais').focus();
        }

        if (!valid) {
            e.preventDefault();
            return false;
        }

        waitingDialog();

        $('#HdePaisID').val(PaisID);

        preventClick(1, true);
        $('#btnLoginFB').prop('disabled', true);
    });

    $("#txtUsuario").keypress(
        function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                //ValidarAutenticacion();
                $('#txtContrasenia').focus();
            }
            else {
                var keyChar = String.fromCharCode(charCode);
                var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
                return re.test(keyChar);
            }
        });

    $("#txtUsuario2").keypress(
        function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            //ValidarAutenticacion();
            $('#txtContrasenia2').focus();
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
            return re.test(keyChar);
        }
        });

    $("#txtContrasenia").keypress(
        function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                //ValidarAutenticacion();
                $('#btnLogin').focus();
            }
        });

    $("#txtContrasenia2").keypress(
        function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                //ValidarAutenticacion();
                $('#btnLogin2').focus();
                login2();
                return false;
            }
        });

    if (typeof errorLogin !== 'undefined') {
        var errorMessage = "Mensaje: " + errorLogin + " \n|PaisID: " + serverPaisId + " \n|CodigoUsuario: " + serverCodigoUsuario + " \n|Stack Browser: " + navigator.appVersion;

        $('#ErrorTextLabel').html(errorMessage);
        $("#ErrorTextLabel").css("padding-left", "20px");

        saveLog(errorMessage, serverCodigoUsuario, serverPaisId);

        //TODO:Call al service de Log usando: errorMessage
    }

    $("#btnRecuperarClave").click(function() {
        var paisId = $("#cboPaisCambioClave").val();
        var correo = $("#txtCorreoElectronico").val();

        if (paisId == '0') {
            alert("Debe seleccionar un pais.");
            return false;
        }

        if (correo == '') {
            var mensaje = paisId == '4' ? 'Debe ingresar un número de cédula.' : 'Debe ingresar un correo electrónico.';
            alert(mensaje);
        }

        var validarCorreo = validateEmail(correo);

        if (!validarCorreo && paisId != "4") {   //paisId != "4"
            alert('El formato del correo electrónico ingresado no es correcto.');
            return false;
        }

        var parametros = {
            paisId: paisId,
            correo: correo
        };

        jQuery.ajax({
            type: 'POST',
            url: urlRecuperarContrasenia,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(parametros),
            async: true,
            success: function (response) {
                if (response.success) {
                    $("#popup1").hide();

                    $("#correoDestino strong").html(correo);
                    $("#popup2").show();
                } else {
                    alert(response.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                }
            }
        });
    });

    localStorage.setItem('PopUpChatOpened', 'false');
});

function Inicializar()
{
    $(".cboPaisCambioClave").trigger('change');
    $("#ddlPais").trigger('change');
}

$(document).keypress(function (e) {
    if (e.which == 13) {
        ValidarFormulario();
        e.preventDefault();
    }
});

$(window).resize(function () {
    // posicionamiento
    setTimeout(function hh() {
        LugarMensaje();
    }, 100);

    $('div.content-alerta-red-user > div').removeClass("left");
    $('div.content-alerta-red-user > div').removeClass("right");
    $('div.content-alerta-red-clave > div').removeClass("left");
    $('div.content-alerta-red-clave > div').removeClass("right");
    if ($(window).width() < 1093) {
        $('div.content-alerta-red-user > div').addClass("right");
        $('div.content-alerta-red-clave > div').addClass("right");
        activarHover = false;
    } else {
        $('div.content-alerta-red-user > div').addClass("left");
        $('div.content-alerta-red-clave > div').addClass("left");
        activarHover = true;
    }
});

function getVALbyISO(ISO) {
    if ($('#ddlPais').val() == "00") {
        return "0";
    }
    if ($('#ddlPais').val() == "BO") {
        return "2";
    }
    if ($('#ddlPais').val() == "CL") {
        return "3";
    }
    if ($('#ddlPais').val() == "CO") {
        return "4";
    }
    if ($('#ddlPais').val() == "CR") {
        return "5";
    }
    if ($('#ddlPais').val() == "EC") {
        return "6";
    }
    if ($('#ddlPais').val() == "SV") {
        return "7";
    }
    if ($('#ddlPais').val() == "GT") {
        return "8";
    }
    if ($('#ddlPais').val() == "MX") {
        return "9";
    }
    if ($('#ddlPais').val() == "PA") {
        return "10";
    }
    if ($('#ddlPais').val() == "PE") {
        return "11";
    }
    if ($('#ddlPais').val() == "PR") {
        return "12";
    }
    if ($('#ddlPais').val() == "DO") {
        return "13";
    }
    if ($('#ddlPais').val() == "VE") {
        return "14";
    }
    if ($('#ddlPais').val() == "BR") {
        return "15";
    }
}

function LugarMensaje() {
    var ht = $('#txtUsuario') == null ? "0" : $('#txtUsuario').offset().top;
    var htp = $('#txtContrasenia') == null ? "0" : $('#txtContrasenia').offset().top;
    var hu = parseInt(ht, 10) - 6;
    var hp = parseInt(htp, 10) - 6;
    if (hu > 0) {
        $(".content-alerta-red-user").css("top", hu + "px");
        $(".content-alerta-red-clave").css("top", hp + "px");
    }

    var wiu = $("a.helper.huno") == null ? 0 : parseInt($("a.helper.huno").offset().left);
    if (wiu > 0) {
        wiu = wiu + ($("a.helper.huno").parent().outerWidth())
    }
    if ($(window).width() < 1093) {
        $(".content-alerta-red-user").css("left", 75 + "px");
        $(".content-alerta-red-clave").css("left", 75 + "px");
    }
    else {
        $(".content-alerta-red-user").css("left", wiu + "px");
        $(".content-alerta-red-clave").css("left", wiu + "px");
    }
}

function CloseDialog(pop) {
    pop = pop || "box-pop-up";
    $("#" + pop).hide();
}

function ayudaLogin2() {
    var aa = $('div.content-alerta-red-user');
    var bb = $('div.content-alerta-red-clave');
    var m1 = null;
    var m2 = null;
    var iso = $('#ddlPais2').val();
    if (iso == "00") {
        return;
    }

    switch (iso) {
        case "PE":
            m1 = $(aa).find('.alerta_red_peru_user').html();
            m2 = $(bb).find('.alerta_red_peru_clave').html();
            break;
        case "BO":
            m1 = $(aa).find('div.alerta_red_bolivia_user').html();
            m2 = $(bb).find('div.alerta_red_bolivia_clave').html();
            break;
        case "CL":
            m1 = $(aa).find('div.alerta_red_chile_user').html();
            m2 = $(bb).find('div.alerta_red_chile_clave').html();
            break;
        case "PA":
            m1 = $(aa).find('div.alerta_red_cam_user9').html();
            m2 = $(bb).find('div.alerta_red_cam_clave').html();
            break;
        case "GT":
            m1 = $(aa).find('div.alerta_red_cam_user7').html();
            m2 = $(bb).find('div.alerta_red_cam_clave').html();
            break;
        case "CR":
            m1 = $(aa).find('div.alerta_red_cam_user7').html();
            m2 = $(bb).find('div.alerta_red_cam_clave').html();
            break;
        case "SV":
            m1 = $(aa).find('div.alerta_red_cam_user7').html();
            m2 = $(bb).find('div.alerta_red_cam_clave').html();
            break;
        case "PR":
            m1 = $(aa).find('div.alerta_red_pr_user').html();
            m2 = $(bb).find('div.alerta_red_pr_clave').html();
            break;
        case "DO":
            m1 = $(aa).find('div.alerta_red_do_user').html();
            m2 = $(bb).find('div.alerta_red_do_clave').html();
            break;
        case "MX":
            m1 = $(aa).find('div.alerta_red_mx_user').html();
            m2 = $(bb).find('div.alerta_red_mx_clave').html();
            break;
        case "EC":
            m1 = $(aa).find('div.alerta_red_ec_user').html();
            m2 = $(bb).find('div.alerta_red_ec_clave').html();
            break;
        case "VE":
            m1 = $(aa).find('div.alerta_red_ve_user').html();
            m2 = $(bb).find('div.alerta_red_ve_clave').html();
            break;
        case "CO":
            m1 = $(aa).find('div.alerta_red_co_user').html();
            m2 = $(bb).find('div.alerta_red_co_clave').html();
            break;
    }

    $('#ayuda-msg-user').html(m1.trim());
    $('#ayuda-msg-clave').html(m2.trim());
}

function AbrirMensajeLogin(tipo, close) {
    close = close || false;
    $(".content-alerta-red-user > div").removeClass("alerta_red_block");
    $(".content-alerta-red-clave > div").removeClass("alerta_red_block");
    if (close) {
        return;
    }
    if ($(".DropDown").val() == "00") return;
    if (tipo == 1) {
        val_Usuario = !val_Usuario;
        switch ($(".DropDown").val()) {
            case "PE": $('.alerta_red_peru_user').toggleClass("alerta_red_block"); break;
            case "BO": $('.alerta_red_bolivia_user').toggleClass("alerta_red_block"); break;
            case "CL": $('.alerta_red_chile_user').toggleClass("alerta_red_block"); break;
            case "PA": $('.alerta_red_cam_user9').toggleClass("alerta_red_block"); break;
            case "GT": $('.alerta_red_cam_user7').toggleClass("alerta_red_block"); break;
            case "CR": $('.alerta_red_cam_user7').toggleClass("alerta_red_block"); break;
            case "SV": $('.alerta_red_cam_user7').toggleClass("alerta_red_block"); break;
            case "PR": $('.alerta_red_pr_user').toggleClass("alerta_red_block"); break;
            case "DO": $('.alerta_red_do_user').toggleClass("alerta_red_block"); break;
            case "MX": $('.alerta_red_mx_user').toggleClass("alerta_red_block"); break;
            case "EC": $('.alerta_red_ec_user').toggleClass("alerta_red_block"); break;
            case "VE": $('.alerta_red_ve_user').toggleClass("alerta_red_block"); break;
            case "CO": $('.alerta_red_co_user').toggleClass("alerta_red_block"); break;
        }
    }
    else {
        val_Password = !val_Password;
        switch ($(".DropDown").val()) {
            case "PE": $('.alerta_red_peru_clave').toggleClass("alerta_red_block"); break;
            case "BO": $('.alerta_red_bolivia_clave').toggleClass("alerta_red_block"); break;
            case "CL": $('.alerta_red_chile_clave').toggleClass("alerta_red_block"); break;
            case "PA": $('.alerta_red_cam_clave').toggleClass("alerta_red_block"); break;
            case "GT": $('.alerta_red_cam_clave').toggleClass("alerta_red_block"); break;
            case "CR": $('.alerta_red_cam_clave').toggleClass("alerta_red_block"); break;
            case "SV": $('.alerta_red_cam_clave').toggleClass("alerta_red_block"); break;
            case "PR": $('.alerta_red_pr_clave').toggleClass("alerta_red_block"); break;
            case "DO": $('.alerta_red_do_clave').toggleClass("alerta_red_block"); break;
            case "MX": $('.alerta_red_mx_clave').toggleClass("alerta_red_block"); break;
            case "EC": $('.alerta_red_ec_clave').toggleClass("alerta_red_block"); break;
            case "VE": $('.alerta_red_ve_clave').toggleClass("alerta_red_block"); break;
            case "CO": $('.alerta_red_co_clave').toggleClass("alerta_red_block"); break;
        }
    }

    LugarMensaje();
}

function ValidarFormulario() {
    $('#hdfContrasenia').val($('#txtContrasenia').val());
    $('#SubmitButton').click();
}

function AsignarHojaEstilos() {
    if (paisesEsika.indexOf(imgISO) != -1) {
        if ($("link[data-id='cssStyle']").prop('disabled') !== undefined) {
            $("body").css("visibility", "hidden");
            document.title = ' ÉSIKA ';
            $("link[data-id='iconPagina']").attr("href", "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico");
            $("link[data-id='cssStyle']").prop('disabled', false);
            $("link[data-id='cssStyleLbel']").prop('disabled', true);
            window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
        }
        $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
        $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
    }
    else {
        if (paisesLBel.indexOf(imgISO) != -1) {
            if ($("link[data-id='cssStyleLbel']").prop('disabled') !== undefined) {
                $("body").css("visibility", "hidden");
                document.title = " L'BEL ";
                $("link[data-id='iconPagina']").attr("href", "http://cdn.lbel.com/wp-content/themes/lbel2/images/icons/favicon.ico");
                $("link[data-id='cssStyle']").prop('disabled', true);
                $("link[data-id='cssStyleLbel']").prop('disabled', false);
                window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
            }
            $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
            $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
        } else {
            if ($("link[data-id='cssStyle']").attr('disabled') !== undefined) {
                $("body").css("visibility", "hidden");
                document.title = ' ÉSIKA ';
                $("link[data-id='iconPagina']").attr("href", "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico");
                $("link[data-id='cssStyle']").prop('disabled', false);
                $("link[data-id='cssStyleLbel']").prop('disabled', true);
                window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
            }
            $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top -7px left -10px no-repeat");
            $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top -7px left -10px no-repeat");
        }
    }
}

function olvidasteContrasenia() {
    _gaq.push(['_trackEvent', 'Link', 'Olvide-contrasenia']);
    val_comboLogin = $("#ddlPais").val();
    temp = getVALbyISO(val_comboLogin);
    $("#cboPaisCambioClave").val(temp);
    $(".cboPaisCambioClave").trigger('change');
    $("#popup1").css("display", "block");
    $("#mensajesOC").html("");
}

function getISOPaisbyCodigo(codPais) {
    if ($('.cboPaisCambioClave').val() == "0") {
        return "00";
    }
    if ($('.cboPaisCambioClave').val() == "2") {
        return "BO";
    }
    if ($('.cboPaisCambioClave').val() == "3") {
        return "CL";
    }
    if ($('.cboPaisCambioClave').val() == "4") {
        return "CO";
    }
    if ($('.cboPaisCambioClave').val() == "5") {
        return "CR";
    }
    if ($('.cboPaisCambioClave').val() == "6") {
        return "EC";
    }
    if ($('.cboPaisCambioClave').val() == "7") {
        return "SV";
    }
    if ($('.cboPaisCambioClave').val() == "8") {
        return "GT";
    }
    if ($('.cboPaisCambioClave').val() == "9") {
        return "MX";
    }
    if ($('.cboPaisCambioClave').val() == "10") {
        return "PA";
    }
    if ($('.cboPaisCambioClave').val() == "11") {
        return "PE";
    }
    if ($('.cboPaisCambioClave').val() == "12") {
        return "PR";
    }
    if ($('.cboPaisCambioClave').val() == "13") {
        return "DO";
    }
    if ($('.cboPaisCambioClave').val() == "14") {
        return "VE";
    }
    if ($('.cboPaisCambioClave').val() == "15") {
        return "BR";
    }
}

function EsconderLogoEsikaPanama(imgISO) {
    if (imgISO == "PA") {
        $("#footer_esika").hide();
    } else {
        $("#footer_esika").show();
    };
}

function login2() {
    var valid = true;
    var CodigoISO = $('#ddlPais2').val();
    var PaisID = $('#ddlPais2 :selected').data('id');
    var CodigoUsuario = jQuery.trim($('#txtUsuario2').val());
    var Contrasenia = jQuery.trim($('#txtContrasenia2').val());
    $('#hdeCodigoISO').val(CodigoISO);
    var mensaje = "";

    if (typeof CodigoISO == 'undefined' || PaisID == "")
        mensaje += "- Debe seleccionar el País del Usuario.\n";
    if (CodigoUsuario == "")
        mensaje += "- Debe ingresar el Usuario.\n";
    if (Contrasenia == "")
        mensaje += "- Debe ingresar la Clave Secreta.\n";

    if (mensaje != "") {
        valid = false;
        alert(mensaje);
        $('#txtUsuario2').focus();
    }

    if (!valid) {
        //e.preventDefault();
        return false;
    }

    $('#ddlPais').val(CodigoISO);
    $('#txtUsuario').val(CodigoUsuario);
    $('#txtContrasenia').val(Contrasenia);

    $('#HdePaisID').val(PaisID);
    //preventClick(2, true);

    //$('.content_pop_login').hide();
    //$('#btnLoginFB').prop('disabled', true);

    waitingDialog();

    //$('#frmLogin').submit();
    var form = $('#frmLogin');
    //var token = $('input[name="__RequestVerificationToken"]', form).val();
    var postData = form.serialize() + "&returlUrl=" + $('#returnUrl').val();

    $.ajax({
        type: 'POST',
        url: '/Login/Login',
        data: postData,
        dataType: 'json',
        //contentType: 'application/json; charset=utf-8',
        success: function (response) {
            //console.log(response);

            if (response.success) {
                if (response.redirectTo !== "") {
                    document.location.href = response.redirectTo;
                }
            }
            else {
                //console.log(response);
                closeWaitingDialog();
                var errorMessage = "Mensaje, login2: " + response.message + " |CodigoISO: " + CodigoISO + " |PaisID: " + serverPaisId + " |CodigoUsuario: " + serverCodigoUsuario + " |Stack Browser: " + navigator.appVersion;
                $('#ErrorTextLabel2').html(errorMessage);
                $("#ErrorTextLabel2").css("padding-left", "20px");
                $('#divMensajeError2').show();

                saveLog(errorMessage, serverCodigoUsuario, CodigoISO);

                $('#txtUsuario').val('');
                $('#txtContrasenia').val('');
                //preventClick(2, false);
            }
        },
        error: function (response) {
            //console.log(response);
            closeWaitingDialog();

            var errorMessage = "login2, |CodigoISO: " + CodigoISO + " |PaisID: " + serverPaisId + " |CodigoUsuario: " + serverCodigoUsuario + " |Stack Browser: " + navigator.appVersion;
            alert("Error al procesar la solicitud" + errorMessage);

            saveLog(errorMessage, serverCodigoUsuario, CodigoISO);
           
            $('#txtUsuario').val('');
            $('#txtContrasenia').val('');
            //preventClick(2, false);

        }
    });
}

function closePopupAsociarLoginExt() {
    preventClick(1, false);

    //$('.content_pop_login').hide();
    $('#popupAsociarUsuarioExt').hide();
}

function preventClick(opt, value) {
    if (opt == 1) {
        $('#ddlPais option:not(:selected)').prop('disabled', value);
        $('#txtUsuario').attr('readonly', value);
        $('#txtContrasenia').attr('readonly', value);
        $('#btnLogin').prop('disabled', value);
    }
    else if (opt == 2) {
        $('#ddlPais2 option:not(:selected)').prop('disabled', value);
        $('#txtUsuario2').attr('readonly', value);
        $('#txtContrasenia2').attr('readonly', value);
        $('#btnLogin2').prop('disabled', value);
    }
}

function resizeNameUserExt() {
    var w = $(window).width();  //1366,1093
    var ml = 8;
    if (w <= 1093) ml = 16;
    var fname = $('#hdeNameUserExt').val();

    if (typeof fname !== 'undefined' && fname != "") {
        if (fname.length > ml) {
            fname = fname.substring(0, ml).trim() + '.';
        }
        $('#btnLoginFB2').text('Continuar como ' + fname);
    }
}

function saveLog(message, usuario, iso) {
    var obj = {
        message: message,
        usuario: usuario,
        iso: iso
    };

    jQuery.ajax({
        type: 'POST',
        url: "/Login/SaveLogErrorLogin",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            console.log(response);
        },
        error: function (response) {
            console.log(response);
        }
    });
}
