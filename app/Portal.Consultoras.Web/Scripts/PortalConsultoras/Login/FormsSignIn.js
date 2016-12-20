var imgISO = "";
var _kiq = _kiq || [];
var activarHover = true;
var val_comboLogin = "";
var temp = "";

$(document).ready(function () {

    $('#ddlPais').val(isoPais);
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
    }
    else {
        $('#cargarBandera').css('background', "url('/Content/Images/Login2/Banderas/00.png') top -7px left -10px no-repeat");
        //$('#cargarBandera2').css('background', "url('/Content/Images/Login2/Banderas/00.png') top -7px left -10px no-repeat");
    }

    EsconderLogoEsikaPanama($("#ddlPais").val());

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

    /*EPD-1012*/

    $('#frmLogin').on('submit', function (e) {
        // validation code here
        var valid = true;
        var CodigoISO = $('#ddlPais').val();
        var PaisID = $('#ddlPais :selected').data('id');
        var CodigoUsuario = jQuery.trim($("#txtUsuario").val());
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

        $('hdePaisID').val(PaisID);
        $('#ddlPais option:not(:selected)').prop('disabled', true);
        $('#txtUsuario').attr('readonly', true);
        $('#txtContrasenia').attr('readonly', true);
        $('#btnLogin').prop('disabled', true);
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

    $("#txtContrasenia").keypress(
        function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                //ValidarAutenticacion();
                $('#btnLogin').focus();
            }
            else {
                var keyChar = String.fromCharCode(charCode);
                var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
                return re.test(keyChar);
            }
        });

    if (typeof errorLogin !== 'undefined') {
        $('#ErrorTextLabel').html(errorLogin);
    }
    /*EPD-1012*/
});

function Inicializar()
{
    $(".cboPaisCambioClave").trigger('change');
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
        if ($("link[data-id='cssStyle']").attr('disabled') !== undefined) {
            $("body").css("visibility", "hidden");
            document.title = ' ÉSIKA ';
            $("link[data-id='iconPagina']").attr("href", "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico");
            $("link[data-id='cssStyle']").removeAttr('disabled');
            $("link[data-id='cssStyleLbel']").attr('disabled', 'disabled');
            window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
        }
        $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
    }
    else {
        if (paisesLBel.indexOf(imgISO) != -1) {
            if ($("link[data-id='cssStyleLbel']").attr('disabled') !== undefined) {
                $("body").css("visibility", "hidden");
                document.title = " L'BEL ";
                $("link[data-id='iconPagina']").attr("href", "http://cdn.lbel.com/wp-content/themes/lbel2/images/icons/favicon.ico");
                $("link[data-id='cssStyle']").attr('disabled', 'disabled');
                $("link[data-id='cssStyleLbel']").removeAttr('disabled');
                window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
            }
            $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top 10px left 2px no-repeat");
        } else {
            if ($("link[data-id='cssStyle']").attr('disabled') !== undefined) {
                $("body").css("visibility", "hidden");
                document.title = ' ÉSIKA ';
                $("link[data-id='iconPagina']").attr("href", "http://www.esika.com/wp-content/themes/nuevaesika/favicon.ico");
                $("link[data-id='cssStyle']").removeAttr('disabled');
                $("link[data-id='cssStyleLbel']").attr('disabled', 'disabled');
                window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
            }
            $("#cargarBandera").css("background", "url('/Content/Images/Login2/Banderas/" + imgISO + ".png') top -7px left -10px no-repeat");
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

