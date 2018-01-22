var imgISO = "";
var _kiq = _kiq || [];
var activarHover = true;
var val_comboLogin = "";
var temp = "";
var analytics = Analytics(configAnalytics);
var v_IsMovilDevice = 0;

var CodigoISO;
var PaisID;
var CodigoUsuario;
var ancho = 681;
var correoRecuperar = "";
var nroIntentosCo = 0;
var nroIntentosSms = 0;
var t; //Temporisador sms.

$(document).ready(function () {
    $(window).resize(function () {
        //resize just happened, pixels changed
        resizeNameUserExt();
        var _id = "";
        if (paisesEsika.indexOf(imgISO) != -1) {
            _id = "hddFondoFestivoEsika";
        } else {
            _id = "hddFondoFestivoLebel";
        }
        Fondofestivo(_id);
    });

    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            if ($('#popupAsociarUsuarioExt').is(':visible')) {
                $('#popupAsociarUsuarioExt').hide();
            }
        }
    });

    $(".campo_correoElectronico").focus(function () {
        $(".iconoUsuario").addClass("iconoUsuarioActivo");
        $(this).addClass("campo_correoElectronico_activo");
    });

    $(".campo_correoElectronico").focusout(function () {
        $(".iconoUsuario").removeClass("iconoUsuarioActivo");
        $(this).removeClass("campo_correoElectronico_activo");
    });

    $('#btnLoginFB').addClass('center_facebook');

    $("#ErrorTextLabel").css("padding-left", "0");
    $('#ddlPais').val(isoPais);

    if ($('#ddlPais').val() == null) isoPais = "00";
    $('#ddlPais').val(isoPais);
    $('#ddlPais2').val(isoPais);
    ayudaLogin2();

    //$('#cboPaisCambioClave').val(isoPais);

    if (avisoASP == 1) $('#AvisoASP').hide();
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
        analytics.invocarAnalyticsByCodigoIso(imgISO);

        if ($("#ddlPais").val() == "MX") $("#AvisoASP").show();
        else $("#AvisoASP").hide();
        if (imgISO == "PA") $("#footer_esika").hide();
        else $("#footer_esika").show();
        if ($("#ddlPais").val() == "CO") $("#VinculoTarjetaHelm").show();
        else $("#VinculoTarjetaHelm").hide();

        AsignarHojaEstilos();

        $('#ddlPais2').val(imgISO);
        ayudaLogin2();
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
        var ISOPais = getISOPaisbyCodigo($(this).val());
        if (ISOPais != "00") $("#cargarBandera2").css("background", "url('/Content/Images/Login2/Banderas/" + ISOPais + ".png') top 10px left 2px no-repeat");
        else $("#cargarBandera2").css("background", "url('/Content/Images/Login2/Banderas/" + ISOPais + ".png') top -7px left -10px no-repeat");

        $("#txtCorreoElectronico").prop("placeholder", $(".cboPaisCambioClave option:selected").attr("data-campoclave"));
        $("#txtCorreoElectronico").val("").focus();

        $("#hdfCorreoElectronico").val($(".cboPaisCambioClave option:selected").attr("data-campoclave"));
    });

    Inicializar();

    $('#frmLogin').on('submit', function (e) {
        // validation code here
        var valid = true;
        CodigoISO = $('#ddlPais').val();
        PaisID = getVALbyISO(CodigoISO);
        CodigoUsuario = jQuery.trim($("#txtUsuario").val());
        var Contrasenia = jQuery.trim($("#txtContrasenia").val());

        var mensaje = "";

        if (PaisID == "")
            mensaje += "- Debe seleccionar el País del Usuario.\n";
        if (CodigoUsuario == "")
            mensaje += "- Debe ingresar el Usuario.\n";
        if (Contrasenia == "")
            mensaje += "- Debe ingresar la Clave Secreta.\n";

        $('#hdeCodigoISO').val(CodigoISO);
        $('#HdePaisID').val(PaisID);

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

        preventClick(1, true);
        $('#btnLoginFB').prop('disabled', true);

        limpiar_local_storage();
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
                //login2();
                return false;
            }
        });

    $(".codigoSms").keypress(
        function (evt) {     
            if (evt.charCode >= 48 && evt.charCode <= 57) {                
                var oID = $(this).attr("id");
                var nextfocus = parseInt(oID.substring(0, 1)) + 1;
                $("#" + nextfocus + "Digito").focus();
                return true;
            } else {
                alert("Ingrese solo números.")
                return false;
            }
        });

    $(".codigoSms").keyup(
        function (e) {

            $(".codigoInvalido").hide();
            var verificar = true;

            if ($("#1Digito").val() == "")
                verificar = false;
            if ($("#2Digito").val() == "")
                verificar = false;
            if ($("#3Digito").val() == "")
                verificar = false;
            if ($("#4Digito").val() == "")
                verificar = false;
            if ($("#5Digito").val() == "")
                verificar = false;
            if ($("#6Digito").val() == "")
                verificar = false;

            if (verificar) {
                var CodigosmsIngresado = $("#1Digito").val() + $("#2Digito").val() + $("#3Digito").val() + $("#4Digito").val() + $("#5Digito").val() + $("#6Digito").val();
                ObtenerCodigoSms(CodigosmsIngresado);
            }
        });


    if (typeof errorLogin !== 'undefined') {
        var errorMessage = "Mensaje: " + errorLogin;

        $('#ErrorTextLabel').html(errorMessage);
        $("#ErrorTextLabel").css("padding-left", "20px");

        //TODO:Call al service de Log usando: errorMessage
        if (typeof usuarioValidado !== 'undefined') {
            var errorMessageLog = "Mensaje: " + errorLogin + " \n|PaisISO: " + serverPaisISO + " \n|CodigoUsuario: " + serverCodigoUsuario + " \n|Stack Browser: " + navigator.appVersion;
            saveLog(serverPaisISO, serverCodigoUsuario, errorMessageLog);
        }
    }

    $("#btnRegresar").click(function () {
        Regresar();
    });

    $("#btnRecuperarClave").click(function () {
        RecuperarClave("1");
    });

    $(".aVolverInicio").click(function () {
        $("#popup2").hide();
        RecuperarClave("1");       
    });

    $("#divChatearConNosotros").click(function () {   
        $(".lk_chat").get(0).click();
    });
    
    $(".lk_chat").click(function () {        
        Construir_EnlacexDispositivo(2);
        var DeshabilitarBotonCorreo = $("#divChatearConNosotros").hasClass("deshabilitar_opcion_correo");
        if (DeshabilitarBotonCorreo)
        {
            console.log("Esta fuera de hora");
        }
    });

    $("body").keyup(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;

        if ($('#popup_olvidasteContrasenia').is(':visible') && charCode == 27) {
            $('#popup1').hide();
        }

        if ($('#popup_cambioContrasenia').is(':visible') && charCode == 27) {            
            $('#popup3').hide();
        }
        
        if ($('#popup_contraseniaEnviada').is(':visible') && charCode == 27) {
            $('#popup2').hide();
        }
    });

    $("#txtCorreoElectronico").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;

        if (charCode < 13) {
            return false;
        }
        else if (charCode == 13){            
            RecuperarClave();
            return false;
        }
    });

    $(".RecuperarPorCorreo").click(function () {
        if (correoRecuperar != "") {
            nroIntentosCo = nroIntentosCo + 1;
            ProcesaEnvioEmail();            
        }            
    });

    $(".opcionSms").click(function () {
        ProcesaEnvioSMS();
    });

    $("#vermasopciones1").click(function () {
        waitingDialog();
        var _tipoRecuperar = $.trim($("#vermasopciones1").attr("data-recuperar"));
        //$("#vermasopciones1").attr("data-recuperar", "3");
        RecuperarClave(_tipoRecuperar);
    });
});

////////////
function Construir_EnlacexDispositivo(Modo) {
    var v_urlbase = $("#hd_CONTEXTO_BASE").val();
    var paisId = $("#cboPaisCambioClave").val();
    var codigoUsuario = $("#hdCodigoConsultora").val();
    var v_url = v_urlbase.substring(0, v_urlbase, v_urlbase.length - 1) + urlChatBelCorp + 
        "?paisId=" + paisId + "&codigoUsuario=" + codigoUsuario + "&emt_type=1";

    var DeshabilitarBotonCorreo = $("#divChatearConNosotros").hasClass("deshabilitar_opcion_correo");
    
    if (Modo == 2){
        if (!DeshabilitarBotonCorreo)
        {
            if (v_IsMovilDevice == "0") window.open(v_url, 'ventanaChat', 'top=0,left=0,width=450,height=550');
            if (v_IsMovilDevice == "1") $(".lk_chat").prop("href", v_url);
            $(".lk_chat").css("text-decoration", "none");
            $(".lk_chat").css("color", "black");
        }
    }
}

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
    var result = "98";

    switch (ISO) {
        case "00":
            result = "0";
            break;

        case "BO":
            result = "2";
            break;

        case "CL":
            result = "3";
            break;

        case "CO":
            result = "4";
            break;

        case "CR":
            result = "5";
            break;

        case "EC":
            result = "6";
            break;

        case "SV":
            result = "7";
            break;

        case "GT":
            result = "8";
            break;

        case "MX":
            result = "9";
            break;

        case "PA":
            result = "10";
            break;

        case "PE":
            result = "11";
            break;

        case "PR":
            result = "12";
            break;

        case "DO":
            result = "13";
            break;

        case "VE":
            result = "14";
            break;

        case "BR":
            result = "15";
            break;

        default:
            break;
    }

    return result;

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
        wiu = wiu + ($("a.helper.huno").parent().outerWidth());
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

    $('#ayuda-msg-user').html($.trim(m1));
    $('#ayuda-msg-clave').html($.trim(m2));
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
    var objEstiloEsika = $('#cssStyle>link');
    var objEstiloLbel = $('#cssStyleLbel>link');

    if (paisesEsika.indexOf(imgISO) != -1) {
        if (objEstiloEsika.prop('disabled') !== undefined) {
            $("body").css("visibility", "hidden");
            document.title = ' ÉSIKA ';
            $("link[data-id='iconPagina']").attr("href", "/Content/Images/Esika/favicon.ico");
            objEstiloEsika.prop('disabled', false);
            objEstiloLbel.prop('disabled', true);
            Fondofestivo("hddFondoFestivoEsika");
            window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
        }
        $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
        $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
    }
    else if (paisesLBel.indexOf(imgISO) != -1) {
        if (objEstiloLbel.prop('disabled') !== undefined) {
            $("body").css("visibility", "hidden");
            document.title = " L'BEL ";
            $("link[data-id='iconPagina']").attr("href", "/Content/Images/Lbel/favicon.ico");
            objEstiloEsika.prop('disabled', true);
            objEstiloLbel.prop('disabled', false);
            Fondofestivo("hddFondoFestivoLebel");
            window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
        }
        $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
        $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
    } else {
        if (objEstiloEsika.attr('disabled') !== undefined) {
            $("body").css("visibility", "hidden");
            document.title = ' ÉSIKA ';
            $("link[data-id='iconPagina']").attr("href", "/Content/Images/Esika/favicon.ico");
            objEstiloEsika.prop('disabled', false);
            objEstiloLbel.prop('disabled', true);
            Fondofestivo("hddFondoFestivoEsika");
            window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
        }
        $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top -7px left -10px no-repeat");
        $("#cargarBandera3").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top -7px left -10px no-repeat");
    }
}

function olvidasteContrasenia() {
    _gaq.push(['_trackEvent', 'Link', 'Olvide-contrasenia']);
    analytics.invocarEventoPixel("OlvidasteContraseña");

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

function login2() {
    var valid = true;
    var CodigoISO = $('#ddlPais2').val();
    var PaisID = getVALbyISO(CodigoISO);
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
                    analytics.invocarEventoPixel("FacebookLoginLogin");
                    document.location.href = response.redirectTo;
                }
            }
            else {
                //console.log(response);
                closeWaitingDialog();
                var errorMessage = "Mensaje: " + response.message;
                $('#ErrorTextLabel2').html(errorMessage);
                $("#ErrorTextLabel2").css("padding-left", "20px");
                $('#divMensajeError2').show();

                if (typeof usuarioValidado !== 'undefined') {
                    var errorMessageLog = "Mensaje: " + response.message + " \n|PaisISO: " + CodigoISO + " \n|CodigoUsuario: " + CodigoUsuario + " \n|Stack Browser: " + navigator.appVersion;
                    saveLog(CodigoISO, CodigoUsuario, errorMessageLog);
                }

                $('#txtUsuario').val('');
                $('#txtContrasenia').val('');
                //preventClick(2, false);
            }
        },
        error: function (response) {
            //console.log(response);
            closeWaitingDialog();

            if (typeof usuarioValidado !== 'undefined') {
                var errorMessage = "login2, |CodigoISO: " + CodigoISO + " |PaisID: " + serverPaisId.toString() + " |CodigoUsuario: " + serverCodigoUsuario + " |Stack Browser: " + navigator.appVersion;
                alert("Error al procesar la solicitud" + errorMessage);
                saveLog(errorMessage, serverCodigoUsuario, CodigoISO);
            }

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
function Enmascarar_Correo(p_correo)
{
    var v_literal = "", v_correo = "";
    
    v_literal = p_correo.split("@")[0];

    $.each(v_literal.split(""), function (index, value) {
        v_correo += (index === 0 || index === 1 || index === v_literal.length - 1) ? value : "*";
    });

    v_correo = v_correo + "@" + p_correo.split("@")[1];

    return v_correo;
}

function Enmascarar_Numero(pNumCelular){
    if (pNumCelular.length == 0)
        return "";
    else {
        var _nLongitud = pNumCelular.length;
        var v_literal = pNumCelular.trim().split("");
        var v_numero = "";
        for (var i = 0; i < _nLongitud; i++) {
            v_numero += (i === 0 || i === v_literal.length - 1 || i === v_literal.length - 2) ? v_literal[i] : "*";
        }
        return v_numero;
    }
}

function ProcesaEnvioEmail() {
    var paisId = $("#cboPaisCambioClave").val(); 

    var parametros = {
        paisId: paisId,
        filtro: $("#txtCorreoElectronico").val(),
        EsMobile: parseInt($(".lk_chat").attr("ismovildevice")),
        Intento: nroIntentosCo 
    };

    waitingDialog();
    $.ajax({
        type: 'POST',
        url: urlEnviaClaveAEmail,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros), 
        async: true,
        success: function (response) {
            if (response.success) {
                $("#popupRestaurarClave").hide();
                $("#popup2").show();  
                $("#divPopupIntentosCorreo").show();
                $("#correoDestino").html("<b>" + $("#spcorreo").html() + "</b>");
                if (nroIntentosCo === 1) {
                    $("#divVolverInicio").hide(); 
                    $("#men3Intento").hide(); 
                    $("#men1y2Intento").show();
                    $("#divPrimerInteto").show();
                } else if (nroIntentosCo >= 2) {
                    $("#men1y2Intento").hide();
                    $("#divPrimerInteto").hide();
                    $("#men3Intento").show();
                    $("#divVolverInicio").show();  
                }
            } else {
                alert(response.message);
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
}

function ProcesaEnvioSMS() {
    if ($('#aSeguntoIntentoSms').is(':visible')) {
        $('#aSeguntoIntentoSms').hide();
        $("#divVolverInicioSms").show();
    }
    nroIntentosSms = nroIntentosSms + 1;

    $(".codigoInvalido").hide();
    $("#1Digito").val("");
    $("#2Digito").val("");
    $("#3Digito").val("");
    $("#4Digito").val("");
    $("#5Digito").val("");
    $("#6Digito").val("");

    var paisId = $("#cboPaisCambioClave").val();

    var parametros = {
        paisID: paisId,
        filtro: $("#txtCorreoElectronico").val(),
        Origen: "RestaurarClave",
        nroVeces: nroIntentosSms
    };

    waitingDialog();
    $.ajax({
        type: 'POST',
        url: urlEnviaCodigoSMS,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (response) {

            if (response.success){
                $("#popupRestaurarClave").hide();
                $("#popup2").show();

                if (nroIntentosSms == 1) {
                    $("#MenSegundoIntentoSms").hide();
                    $("#divVolverInicioSms").hide();
                    $("#MenPrimerIntentoSms").show();
                    $("#aSeguntoIntentoSms").show();
                }
                    
                if (nroIntentosSms >= 2) {
                    $("#MenPrimerIntentoSms").hide();
                    $("#aSeguntoIntentoSms").hide();
                    $("#MenSegundoIntentoSms").show();
                    $("#divVolverInicioSms").show();
                }    

                TiempoSMS(59);

                $("#divPopupIntentosSMS").show();
                $("#1Digito").focus();
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
}

function saveLog(ISO, usuario, mensaje) {
    var obj = {
        paisISO: ISO,
        codigoUsuario: usuario,
        mensaje: mensaje
    };

    jQuery.ajax({
        type: 'POST',
        url: "/Login/SaveLogErrorLogin",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (response.success) {

            }
        },
        error: function (response) {
            console.log(response);
        }
    });
}
/*HD-817*/
function Fondofestivo(id) {
    if ($("body").hasClass("fondo_festivo")) {
        var ruta = $("#" + id).val();
        if ($(window).width() <= ancho) {
            $(".fondo_festivo").css("background", "url(" + ruta + ")");

        } else {
            $(".fondo_festivo").css("background", "url(" + ruta + ") center center no-repeat fixed");
            $(".fondo_festivo").css("background-size", "cover");
        }
    }
}

function RecuperarClave(tipoRecuperar) {
    //var v_mensaje = $("#hdfCorreoElectronico").val().trim();
    //var s_correo = "";
    var nombreDato = $(".cboPaisCambioClave option:selected").attr("data-campoclave");

    var paisId = $("#cboPaisCambioClave").val();
    if (paisId == '0') {
        alert("Debe seleccionar un pais.");
        return false;
    }

    var _codConsul = $("#txtCorreoElectronico").val();
    if (_codConsul == "") {

        alert("Debe ingresar " + nombreDato)
        return false;
    }       

    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: urlRecuperarContrasenia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ paisId: paisId, textoRecuperacion: _codConsul, nroOpcion: tipoRecuperar}),
        async: true,
        success: function (response) { 
            if (response.success) {
                
                if (response.resul == "") {
                    alert(nombreDato + " Incorrectas.")
                    return false;
                }   

                OcultarContenidoPopup();
                
                var nroCelular = $.trim(response.data.Celular);
                var email = $.trim(response.data.Correo);
                var primerNombre = $.trim(response.data.PrimerNombre);

                $("#spnNombreConsultora").html(primerNombre + ", no te preocupes.")
                $("#spnNombreConsultora").show();

                var e_correo = "";
                var e_numero = "";
                correoRecuperar = $.trim(response.data.Correo);

                $("#hd_CONTEXTO_BASE").val(response.data.ContextoBase);
                $("#linkvolverInicio").hide();  
                $("#vermasopciones1").hide();

                if (email != "")
                {
                    if (!response.data.FlagBloqueoCorreo) {

                        $("#divRecup_porcorreo").addClass("deshabilitar_opcion_correo");
                        $("#divRecup_porcorreo").css("pointer-events", "none");

                        $("#prioridad1_correo").addClass("deshabilitar_opcion_correo");
                        $('.RecuperarPorCorreo').attr('disabled', 'disabled');
                        
                        $(".mensajeDeBloqueoCorreo").show();
                    } else {

                        $("#divRecup_porcorreo").removeClass("deshabilitar_opcion_correo");
                        $("#divRecup_porcorreo").css("pointer-events", "");

                        $("#prioridad1_correo").removeClass("deshabilitar_opcion_correo");
                        $('.RecuperarPorCorreo').attr('disabled', false);

                        $(".mensajeDeBloqueoCorreo").hide();                
                    }
                }

                if (nroCelular != "")
                {
                    if (!response.data.FlagBloqueoCelular) {

                        $("#divRecup_porsms").addClass("deshabilitar_opcion_correo");
                        $("#divRecup_porsms").css("pointer-events", "none");
                                                
                        $("#prioridad1_sms").addClass("deshabilitar_opcion_correo");
                        $('.opcionSms').attr('disabled', 'disabled');

                        $(".mensajeDeBloqueoSMS").show();
                    } else {

                        $("#divRecup_porsms").removeClass("deshabilitar_opcion_correo");
                        $("#divRecup_porsms").css("pointer-events", "");

                        $("#prioridad1_sms").removeClass("deshabilitar_opcion_correo");
                        $('.opcionSms').attr('disabled', false);

                        $(".mensajeDeBloqueoSMS").hide();
                    }
                }                
                
                switch (response.resul)
                {
                    case "prioridad1":
                        {
                            e_correo = Enmascarar_Correo(email);
                            $(".EmailEmascarado").html(e_correo);
                            $("#spcorreo").html(e_correo);

                            e_numero = Enmascarar_Numero(nroCelular);
                            $(".NumCelularDestino").html(e_numero);

                            $("#vermasopciones1").attr("data-recuperar", "2");

                            if ($("#divRecup_porcorreo").hasClass("deshabilitar_opcion_correo") && $("#divRecup_porsms").hasClass("deshabilitar_opcion_correo"))
                                $("#vermasopciones1").show();

                            $("#menPrioridad1").show();
                            $("#prioridad1").show();

                        } break;

                    case "prioridad1_correo":
                        {
                            e_correo = Enmascarar_Correo(email);
                            $("#spcorreo").html(e_correo);
                            $(".EmailEmascarado").html(e_correo);
                            $("#vermasopciones1").attr("data-recuperar", "2");

                            if ($("#prioridad1_correo").hasClass("deshabilitar_opcion_correo"))
                                $("#vermasopciones1").show();

                            $("#menPrioridad1_correo").show();
                            $("#prioridad1_correo").show();
                        } break;

                    case "prioridad1_sms":
                        {
                            e_numero = Enmascarar_Numero(nroCelular);
                            $(".NumCelularDestino").html(e_numero);
                            $("#vermasopciones1").attr("data-recuperar", "2");

                            if ($("#prioridad1_sms").hasClass("deshabilitar_opcion_correo"))
                                $("#vermasopciones1").show();

                            $("#menPrioridad1_sms").show();
                            $("#prioridad1_sms").show();                           
                        } break;

                    case "prioridad2_chat":
                        {
                            v_IsMovilDevice = $(".lk_chat").attr("ismovildevice");
                            $("#hdCodigoConsultora").val(response.data.CodigoUsuario);
                            $("#divHoraiosAtencion").html(response.data.descripcionHorario);

                            $("#vermasopciones1").attr("data-recuperar", "3");

                            $("#menPrioridad2_chat").show();
                            $("#prioridad2_chat").show();
                        } break;                        

                    case "prioridad2_llamada":
                        {                            
                            $(".clstelefono").remove();
                            var telefonos = response.data.TelefonoCentral.split(',');
                            if (paisId == 11) {
                                $(".nametitlepais").html("Central Telefónica del Perú");
                                $("#contenidotelefono").append("<span class='clstelefono'>Lima: " + telefonos[0] + "</span>");
                                $("#contenidotelefono").append("<span class='clstelefono'>Provincias: " + telefonos[1] + "</span>");
                            } else {
                                var npais = $("#ddlPais option:selected").html();
                                $(".nametitlepais").html("Central Telefónica de " + npais);
                                $.each(telefonos, function (index, value) {
                                    $("#contenidotelefono").append("<span class='clstelefono'>Central " + (index + 1) + ": " + value + "</span>")
                                });
                            }
                            
                            $("#Opcionesllamada").show();
                            $("#menPrioridad2_llamada").show();
                            $("#prioridad2_llamada").show();
                            
                        } break;

                    case "prioridad3":
                        {
                            //if ($("#divRecup_porcorreo").hasClass("deshabilitar_opcion_correo") && $("#divRecup_porsms").hasClass("deshabilitar_opcion_correo"))
                            //    $("#linkvolverInicio").show();
                            $("#menPrioridad3").html(primerNombre + ", discúlpanos, en estos momentos no podemos atenderte");
                            $("#spnNombreConsultora").hide();
                            $(".divHorario").html(response.data.descripcionHorario);
                            $("#menPrioridad3").show();
                            $("#prioridad3").show();
                        } break;                                            
                }

                $("#popup1").hide();
                $("#popupRestaurarClave").show(); 
            }         
            else{
                alert(response.message);
                return false;
            }
        },
        error: function () { alert('Ocurrió un problema de conexión. Inténtelo en unos minutos.'); },
        complete: closeWaitingDialog
    });
}

function OcultarContenidoPopup()
{
    //Correo
    $("#menPrioridad1").hide();
    $("#menPrioridad1_correo").hide();
    $("#menPrioridad1_sms").hide();
    $("#menPrioridad2_chat").hide();
    $("#menPrioridad2_llamada").hide();
    $("#menPrioridad3").hide();

    $("#prioridad1").hide();
    $("#prioridad1_correo").hide();
    $("#prioridad1_sms").hide();
    $("#prioridad2_chat").hide();
    $("#prioridad2_llamada").hide();
    $("#prioridad3").hide();

    $("#divPopupIntentosSMS").hide()
    $("#MenSegundoIntentoSms").hide();
    $("#divVolverInicioSms").hide();
    $("#MenPrimerIntentoSms").hide();
    $("#aSeguntoIntentoSms").hide();
    $("#divPopupIntentosCorreo").hide();

    $("#Opcionesllamada").hide();

    nroIntentosCo = 0;
    nroIntentosSms = 0;
}

function ObtenerCodigoSms(CodIngresado)
{
    var paisId = $("#cboPaisCambioClave").val();

    var parametros = {
        paisID: paisId,
        Origen: "RestaurarClave",
        Codigoingresado: CodIngresado
    };

    waitingDialog();
    $.ajax({
        type: 'POST',
        url: urlObtenerCodigoSms,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (response) {
            if (response.success) {
                //alert('codigo correcto');
                $("#popup2").hide();
                window.open(response.url); 
            } else {
                $(".codigoInvalido").show();
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
}

function Regresar() {
    clearTimeout(t);
    $("#popup2").hide();
    $("#popupRestaurarClave").show();
}


function TiempoSMS(tempo) {
    $("#spnMin").html("01");
    var d = "";
    t = setInterval(function () {
        $("#spnMin").html("00");
        
        if (tempo != -1) {
            d = tempo < 10 ? "0" + tempo : tempo;
            $("#spnSeg").html(d);
            tempo--;
        }
        else {
            clearTimeout(t);            
            if (nroIntentosSms > 1) {
                $("#popup2").hide();
                RecuperarClave("1");  
            } else {
                ProcesaEnvioSMS();
            }    
            clearTimeout(t);
        }
    }, 1000, "JavaScript");
}

function CerrarPopup2() {
    $('#popup2').hide();

    clearTimeout(t);
    $("#spnMin").html("01");
    $("#spnSeg").html("00");
}