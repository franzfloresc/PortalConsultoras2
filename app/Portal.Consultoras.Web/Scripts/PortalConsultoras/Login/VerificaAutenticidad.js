var nroIntentosCo = 0;
var nroIntentosSms = 0;
var t; 

$(document).ready(function () {
    $(".RecuperarPorCorreo").click(function () {
        nroIntentosCo = nroIntentosCo + 1;
        ProcesaEnvioEmail();
    });

    $(".RecuperarPorSms").click(function () {
        nroIntentosSms = nroIntentosSms + 1;
        ProcesaEnvioSMS();
    });

    $(".escogeOtraOpcion").click(function () {
        $("#divPaso2sms").hide();
        $("#divPaso1").show();

        if (nroIntentosCo >= 2) {
            BloqueaOpcionCorreo(24);
            setTimeout(function () { alert("Ya utilizó sus 2 intentos de envío de correo. Intente con otra opción.") }, 1000);
        }

        if (nroIntentosSms >= 2) {
           BloqueaOpcionSms(24)
           setTimeout(function () { alert("Ya utilizó sus 2 intentos de envío de SMS. Intente con otra opción.") }, 1000);
        }
    }); 

    $(".aContinuarLogin").click(function () {
        ContinuarLogin();
    });

    $(".campo_ingreso_codigo_sms").keypress(
        function (evt) {
            if (evt.charCode >= 48 && evt.charCode <= 57) {
                var oID = $(this).attr("id");
                //var indicadorID = oID.substring(1, 2);
                var nextfocus = parseInt(oID.substring(0, 1)) + 1;
                $("#" + nextfocus + "Digito").focus();
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
                if ($("#" + oID).val() == ""){
                    var backfocus = parseInt(oID.substring(0, 1)) - 1
                    $("#" + backfocus + "Digito").focus();
                    return false;
                }
                else return true;
            }
        });

    $(".campo_ingreso_codigo_sms").keyup(
        function (e) {
            //$(".codigoInvalido").hide();
            var verificar = true;
            var oID = $(this).attr("id");

            if ($("#1" + "Digito").val() == "")
                verificar = false;
            if ($("#2" + "Digito").val() == "")
                verificar = false;
            if ($("#3" + "Digito").val() == "")
                verificar = false;
            if ($("#4" + "Digito").val() == "")
                verificar = false;
            if ($("#5" + "Digito").val() == "")
                verificar = false;
            if ($("#6" + "Digito").val() == "")
                verificar = false;

            if (verificar) {
                var CodigosmsIngresado = $("#1" + "Digito").val() + $("#2" + "Digito").val() + $("#3" + "Digito").val() + $("#4" + "Digito").val() + $("#5" + "Digito").val() + $("#6" + "Digito").val();
                VerificarCodigo(CodigosmsIngresado);
            }
        });
});

function ProcesaEnvioEmail() {
    if (nroIntentosCo > 2)
        return false;
    var parametros = {
        CantidadEnvios: nroIntentosCo
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
                if (nroIntentosCo == 1) {
                    $("#divPaso2Email").show();
                    //$("#1Digito").focus();
                    $("#divPaso1").hide();
                }
                if (nroIntentosCo == 2) {
                    $(".campo_ingreso_codigo_sms").val("");
                    $("#linkRenviarSms").hide();
                    $(".escogeOtraOpcion").show();
                }
                nroIntentosCo = nroIntentosSms++;

            } else {
                nroIntentosCo = nroIntentosCo - 1;
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
    //clearTimeout(t);
    if (nroIntentosSms > 2)
        return false;

    if (nroIntentosSms == 1) {
        $("#divPaso2sms").show();
        $("#1Digito").focus();
        $("#divPaso1").hide();
    }
    if (nroIntentosSms == 2) {
        $(".campo_ingreso_codigo_sms").val("");
        $("#linkRenviarSms").hide();
        $(".escogeOtraOpcion").show();
    }
    nroIntentosSms = nroIntentosSms++;
    TiempoSMS(59);

    //$(".codigoSms").val("");

    //var parametros = {
    //    cantidadEnvios: nroIntentosSms,
    //    origenID: 2
    //};

    //waitingDialog();
    //$.ajax({
    //    type: 'POST',
    //    url: urlProcesaEnvioSms,
    //    dataType: 'json',
    //    contentType: 'application/json; charset=utf-8',
    //    data: JSON.stringify(parametros),
    //    async: true,
    //    success: function (response) {
    //        if (response.success) {
    //            if (nroIntentosSms == 1) {
    //                $("#divPaso2sms").show();
    //                $("#1Digito").focus();
    //                $("#divPaso1").hide();
    //            }
    //            if (nroIntentosSms == 2) {
    //                $(".campo_ingreso_codigo_sms").val("");
    //                $("#linkRenviarSms").hide();
    //                $(".escogeOtraOpcion").show();
    //            }   
    //            nroIntentosSms = nroIntentosSms++;
    //        }
    //        else {
    //            nroIntentosSms = nroIntentosSms - 1;
    //            alert(response.message);
    //        }
    //        closeWaitingDialog();
    //    },
    //    error: function (data, error) {
    //        if (checkTimeout(data)) {
    //            closeWaitingDialog();
    //            setTimeout(function () { alert("Ocurrio un error al enviar el SMS. Intentelo mas tarde.") }, 1000);
    //        }
    //    }
    //});
}

function VerificarCodigo(CodIngresado) {
    $("#divPaso2sms").hide();
    $("#divPaso3sms").show();
    //var parametros = {
    //    Codigoingresado: CodIngresado
    //};

    //waitingDialog();
    //$.ajax({
    //    type: 'POST',
    //    url: urlVerificarCodigoGenerado,
    //    dataType: 'json',
    //    contentType: 'application/json; charset=utf-8',
    //    data: JSON.stringify(parametros),
    //    async: true,
    //    success: function (response) {
    //        if (response.success) {
    //            $("#divPaso2sms").hide();
    //            $("#divPaso3sms").show();

    //        } else {
    //            //$(".codigoInvalido").show();                
    //        }

    //        closeWaitingDialog();
    //    },
    //    error: function (data, error) {
    //        if (checkTimeout(data)) {
    //            closeWaitingDialog();
    //        }
    //    }
    //});
}

function ContinuarLogin()
{
    waitingDialog();
    var o = 1;

    $.ajax({
        type: 'POST',
        url: urlContinuarLogin,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            document.location.href = response.redirectTo 
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
    $(".divTiempoRestanteSms").html("Opción disponible dentro de " + hrSms + "hr.");
    $(".divTiempoRestanteSms").show();
}

function BloqueaOpcionCorreo(hrCo) {
    $(".RecuperarPorCorreo").addClass("deshabilitar_opciones");
    $(".RecuperarPorCorreo").css("pointer-events", "none");
    $(".divTiempoRestanteCorreo").html("Opción disponible dentro de " + hrSms + "hr.");
    $(".divTiempoRestanteCorreo").show();
}

function TiempoSMS(tempo) {
    var cantMinutos = 2;
    var segundos = 0;

    t = setInterval(function () {

        if (tempo == -1) {
            tempo = 59;
            cantMinutos--;
            $("#spnMin").html("0" + cantMinutos);
        }

        if (tempo != -1 && cantMinutos != -1) {
            segundos = tempo < 10 ? "0" + tempo : tempo;
            $("#spnMin").html("0" + cantMinutos);
            $("#spnSeg").html(segundos);
            tempo--;
        }
        else {
            clearTimeout(t);
            if (nroIntentosSms >= 2 || nroIntentosCo >= 2) {
                $(".escogeOtraOpcion").trigger("click");
            } else {
                //if (procesoSms) {
                    nroIntentosSms = nroIntentosSms + 1
                    ProcesaEnvioSMS();
                //}
                //else if (procesoEmail) {
                //    nroIntentosCo = nroIntentosCo + 1
                //    //ProcesaEnvioEmail();
                //}
            }
        }
    }, 1000, "JavaScript");
}