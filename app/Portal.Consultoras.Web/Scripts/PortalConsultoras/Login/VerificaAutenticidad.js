﻿var nroIntentosCo = 0;
var nroIntentosSms = 0;
var t;
var tipo = 0;
var numeroNuevo = "";

$(document).ready(function () {
    debugger;

    $('.grupo_form_cambio_datos input').on('blur', LabelActivo);

    $(".RecuperarPorCorreo").click(function () {
        tipo = 1;
        nroIntentosCo = nroIntentosCo + 1;
        ProcesaEnvioEmail();
    });

    $(".RecuperarPorSms").click(function () {
        debugger;
        tipo = 2;
        nroIntentosSms = nroIntentosSms + 1;
        ProcesaEnvioSMS();
    });

    if (EmailDesabilitado == "1" || CorreoEnmascarado == "") {
        /*BloqueaOpcionCorreo(HoraRestanteCorreo)*/
        BloquearConfirmarCorreo();
    }

    if (SmsDesabilitado == "1" || CelularEnmascarado == "") {
        /* BloqueaOpcionSms(HoraRestanteSms);*/
        BloquearConfirmarSms();
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
                if ($("#" + oID).val() == "") {
                    var backfocus = parseInt(oID.substring(0, 1)) - 1
                    $("#" + backfocus + a + "Digito").focus();
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



    $("#chkAceptoContratoCambioCel").change(function () {
        var botonGuardarNumero = $('#btnGuardarNumero');
        if (this.checked) {
            botonGuardarNumero.removeClass("btn_deshabilitado");
        } else {
            botonGuardarNumero.addClass("btn_deshabilitado");
        }
    });

    $(".input-number").keypress(function (e) {

        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((e.which < 48 || e.which > 57)) e.preventDefault();
    });

    $("#btnGuardarNumero").click(function () {
        GuardarNumero();
    });
});

(function CamposFormularioConDatos() {
    var camposFormulario = $('.grupo_form_cambio_datos input');
    $.map(camposFormulario, function (campoFormulario, key) {
        if ($(campoFormulario).val()) {
            $(campoFormulario).addClass('campo_con_datos');
        }
    });
})();

function LabelActivo() {
    var campoDatos = $(this).val();
    if (campoDatos) {
        $(this).addClass('campo_con_datos');
    } else {
        $(this).removeClass('campo_con_datos');
    }
}

function ProcesaEnvioSMS() {
    Limpiar();
    var parametros = {
        cantidadEnvios: nroIntentosSms,
        numero: numeroNuevo
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
                CargarValidarNumero();
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
                if (response.menssage)
                    alert(response.menssage);
                else
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
            debugger;
            if (response.success) {
                if (tipo == 1) {
                    $("#divPaso2Email").hide();
                    $("#divPaso3Email").show();
                }
                if (tipo == 2) {
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

function ContinuarLogin(CambioClave) {
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

                document.location.href = VerCambioClaveMobile;
            }
            else {

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

function BloquearConfirmarSms() {
    $("#btn_confirmar_dato_sms").css("display", "none");
    $("#textoConfSms").text('Aún falta agregar tu número.');
}

function BloquearConfirmarCorreo() {
    $("#btn_confirmar_dato_email").css("display", "none");
    $("#textoConfEmail").text('Aún falta agregar tu correo.');
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
                if (tipo == 2) {
                    nroIntentosSms = nroIntentosSms + 1
                    ProcesaEnvioSMS();
                }
            }
        }
    }, 1000, "JavaScript");
}

/*------------------ HD-3916 ---------------------*/
/*---------PE- Actualizacion de datos de forma obligatoria para PEG y que sea bloqueante-----------------*/

function EditarSms() {
    tipo = 2;
    nroIntentosSms = nroIntentosSms + 1;
    $('#divPaso1').hide();
    CargarEditarNumero()
}

function CargarEditarNumero() {
    $("#ActualizarCelular").show();
}

function GuardarNumero() {
    var divPadre = $('#ActualizarCelular')
    var celular = jQuery.trim($(divPadre).find('#NuevoCelular').val());
    numeroNuevo = celular;

    divPadre.hide();

    //CargarValidarNumero();
    ProcesaEnvioSMS();
}


function CargarValidarNumero() {
    //$('#divPaso2sms').show();

    var divPadrevalidar = $('#divPaso2sms')
    var celularValidar = $(divPadrevalidar).find('#txtNumeroParaValidar');
    $(celularValidar).text(numeroNuevo);
}





/*------------------ FIN HD-3916 ---------------------*/