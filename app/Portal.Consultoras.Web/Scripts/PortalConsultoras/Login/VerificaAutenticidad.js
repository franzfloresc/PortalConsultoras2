var nroIntentosCo = 0;
var nroIntentosSms = 0;
var t; 
var tipo = 0;

$(document).ready(function () {
    $(".RecuperarPorCorreo").click(function () {
        tipo = 1;
        nroIntentosCo = nroIntentosCo + 1;
        ProcesaEnvioEmail();
    });

    $(".RecuperarPorSms").click(function () {
        tipo = 2;
        nroIntentosSms = nroIntentosSms + 1;
        ProcesaEnvioSMS();
    });
    
    if (EmailDesabilitado == "1" || CorreoEnmascarado == ""){
        BloqueaOpcionCorreo(HoraRestanteCorreo)
    }
    
    if (SmsDesabilitado == "1" || CelularEnmascarado == "") {
        BloqueaOpcionSms(HoraRestanteSms);
    }

    $(".escogeOtraOpcion").click(function () {       

        if (nroIntentosCo >= 2) {
            $("#divPaso2Email").hide();
            $("#divPaso1").show();
            BloqueaOpcionCorreo(24);
        }

        if (nroIntentosSms >= 2) {
            $("#divPaso2sms").hide();
            $("#divPaso1").show();
            BloqueaOpcionSms(24)
        }
        clearTimeout(t);
    }); 

    $(".ContinuarBienvenida").click(function () {
        ContinuarLogin(0);
    });

    $(".VerCambioClave").click(function () {
        ContinuarLogin(1);
    });

    $(".campo_ingreso_codigo_sms").keypress(
        function (evt) {
            if (evt.charCode >= 48 && evt.charCode <= 57) {                
                var oID = $(this).attr("id");
                var indicadorID = oID.substring(1, 2);
                var nextfocus = parseInt(oID.substring(0, 1)) + 1;
                $("#" + nextfocus + indicadorID + "Digito").focus();
                return true;
            } else {
                alert("Ingrese solo números.")
                return false;
            }
        });

    $(".campo_ingreso_codigo_sms").keydown(
        function (e) {
            tecla = (document.all) ? e.keyCode : e.which; 
            if (tecla == 8) {
                var oID = $(this).attr("id");
                var a = oID.substring(1, 2);
                if ($("#" + oID).val() == ""){
                    var backfocus = parseInt(oID.substring(0, 1)) - 1
                    $("#" + backfocus +  a + "Digito").focus();
                    return false;
                }
                else return true;
            }
        });

    $(".campo_ingreso_codigo_sms").keyup(
        function (e) {  
                $(".IconoError").hide();
                var oID = $(this).attr("id");
                var a = oID.substring(1, 2);

                if ($("#1" + a + "Digito").val() == "")
                    return false;
                if ($("#2" + a + "Digito").val() == "")
                    return false;
                if ($("#3" + a + "Digito").val() == "")
                    return false;
                if ($("#4" + a + "Digito").val() == "")
                    return false;
                if ($("#5" + a + "Digito").val() == "")
                    return false;
                if ($("#6" + a + "Digito").val() == "")
                    return false;                
                var CodigosmsIngresado = $("#1" + a + "Digito").val() + $("#2" + a + "Digito").val() + $("#3" + a + "Digito").val() + $("#4" + a + "Digito").val() + $("#5" + a + "Digito").val() + $("#6" + a + "Digito").val();
                VerificarCodigo(CodigosmsIngresado);
        });

    $("#aChatearConNosotros").click(function () {
        $('#marca').css('display', 'block');

        var connected = localStorage.getItem('connected');
        var idBtn = connected ? '#btn_open' : '#btn_init';
        $(idBtn).trigger("click");
    });

    $("#divVolver").click(function () {
        if (($("#divPaso1").is(":visible")) || ($("#divPaso3Email").is(":visible")) || ($("#divPaso3sms").is(":visible"))) {
            document.location.href = UrlLogin;
        }
        else {
            Limpiar();
            $("#divPaso2sms").hide();
            $("#divPaso2Email").hide();
            $("#divPaso1").show();
            if (nroIntentosCo >= 2) BloqueaOpcionCorreo(24);
            if (nroIntentosSms >= 2) BloqueaOpcionSms(24);
        }
    });
});

function ProcesaEnvioSMS() {
    Limpiar();
    var parametros = {
        cantidadEnvios: nroIntentosSms,
    };

    waitingDialog();
    $.ajax({
        type: 'POST',
        url: urlProcesaEnvioSms,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (response) {
            if (response.success) {
                    $("#divPaso2sms").show();
                    $("#divPaso1").hide();
                    if (nroIntentosSms == 2) {
                    $(".reenvios").show();
                    $(".campo_ingreso_codigo_sms").val("");
                    $("#linkRenviarSms").hide();
                    $(".escogeOtraOpcion").show();
                }
                $("#1sDigito").focus();
                TiempoSMS(59);
            }
            else {
                nroIntentosSms = nroIntentosSms - 1;
                alert("Ocurrio un error al enviar el SMS. Intentelo mas tarde.");
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrio un error al enviar el SMS. Intentelo mas tarde.");
            }
        }
    });
}

function Limpiar() {
    clearTimeout(t);
    $(".IconoError").hide();
    $(".escogeOtraOpcion").hide();
    $(".reenvios").hide();
    $(".codigoSms").val("");    
}

function ProcesaEnvioEmail() {
    Limpiar();
    var parametros = {
        cantidadEnvios: nroIntentosCo,
    };

    waitingDialog();
    $.ajax({
        type: 'POST',
        url: urlProcesaEnvioCorreo,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (response) {
            if (response.success) {
                    $("#divPaso2Email").show();
                    $("#divPaso1").hide();
                    if (nroIntentosCo == 2) {
                    $(".reenvios").show();
                    $(".campo_ingreso_codigo_sms").val("");
                    $("#linkRenviarCorreo").hide();
                    $(".escogeOtraOpcion").show();
                }
                $("#1cDigito").focus();
                TiempoSMS(59);
            } else {
                nroIntentosCo = nroIntentosCo - 1;
                alert("Ocurrio un error al enviar el Email. Intentelo mas tarde");
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrio un error al enviar el Email.Intentelo mas tarde");
            }
        }
    });
}

function VerificarCodigo(CodIngresado) {
    var parametros = {
        Codigoingresado: CodIngresado
    };

    waitingDialog();
    $.ajax({
        type: 'POST',
        url: urlVerificarCodigoGenerado,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (response) {
            if (response.success) {
                if (tipo == 1)
                {
                    $("#divPaso2Email").hide();
                    $("#divPaso3Email").show();
                }
                if (tipo == 2)
                {
                    $("#divPaso2sms").hide();
                    $("#divPaso3sms").show();
                }
                Limpiar();
            } else {
                if (tipo == 1) $("#6cDigito").focus();
                if (tipo == 2) $("#6sDigito").focus();                    
                $(".IconoError").show();
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

function ContinuarLogin(CambioClave)
{    
    console.log('EM>>' + EsMobile);

    var param = "";
    if (CambioClave == 1) //Para Desktop
        param = "?verCambioClave=1" 

    waitingDialog();
    var o = 1;
    $.ajax({
        type: 'POST',
        url: urlContinuarLogin,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            if (EsMobile == "True" && CambioClave == 1) {
                console.log('**A');
                document.location.href = VerCambioClaveMobile;
            }
            else {
                console.log('**B');
                document.location.href = response.redirectTo + param;
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
}

function BloqueaOpcionSms(hrSms) {
    $(".RecuperarPorSms").addClass("deshabilitar_opciones");
    $(".RecuperarPorSms").css("pointer-events", "none");
    if (CelularEnmascarado == "") $(".divTiempoRestanteSms").html("CELULAR NO REGISTRADO");
    else $(".divTiempoRestanteSms").html("Volverá a estar disponible en " + hrSms + "hr.");
    $(".divTiempoRestanteSms").show();
}

function BloqueaOpcionCorreo(hrCo) {
    $(".RecuperarPorCorreo").addClass("deshabilitar_opciones");
    $(".RecuperarPorCorreo").css("pointer-events", "none");
    if (CorreoEnmascarado == "") $(".divTiempoRestanteCorreo").html("CORREO NO REGISTRADO");
    else $(".divTiempoRestanteCorreo").html("Volverá a estar disponible en " + hrCo + "hr.");    
    $(".divTiempoRestanteCorreo").show();
}

function TiempoSMS(tempo) {
    clearTimeout(t);
    var cantMinutos = 2;
    var segundos = 0;
    t = setInterval(function () {

        if (tempo == -1) {
            tempo = 59;
            cantMinutos--;
            $(".spnMin").html("0" + cantMinutos);
        }

        if (tempo != -1 && cantMinutos != -1) {
            segundos = tempo < 10 ? "0" + tempo : tempo;
            $(".spnMin").html("0" + cantMinutos);
            $(".spnSeg").html(segundos);
            tempo--;
        }
        else {
            clearTimeout(t);
            if (nroIntentosSms >= 2 || nroIntentosCo >= 2) {
                $(".escogeOtraOpcion").trigger("click");
            } else {
                if (tipo == 1) {
                    nroIntentosCo = nroIntentosCo + 1
                    ProcesaEnvioEmail();
                }
                if (tipo == 2){
                    nroIntentosSms = nroIntentosSms + 1
                    ProcesaEnvioSMS();
                }
            }
        }
    }, 1000, "JavaScript");
}