var intrigaAceptoTerminos = false;

$(document).ready(function () {

    emailActivo = (emailActivo || "").toLowerCase();

    $("#divIntrigaProgramarAvisoDatos").hide();
    $("#divIntrigaEmailRespuestaOk").hide();
    $("#divIntrigaEmailRespuestaConfirmar").hide();

    if (suscrito == "True") {
        if (emailActivo == "false") {
            $("#divIntrigaEmailRespuestaOk").show();
        }
        else {
            $("#divIntrigaEmailRespuestaConfirmar").show();
        }
    }
    else {
        $("#divIntrigaProgramarAvisoDatos").show();
    }

    $("#divIntrigaProgramarAviso").show();

    $(".termino_condiciones_intriga").click(function () {
        $(this).toggleClass('check_intriga');
        intrigaAceptoTerminos = !intrigaAceptoTerminos;
    });

    $("#btnIntrigaConfirmarCorreo").click(function (e) {
        IntrigaConfirmarCorreo();
    });

    $("[data-email-cambiar]").click(function (e) {
        $("#divIntrigaEmailRespuestaOk").hide();
        $("#divIntrigaEmailRespuestaConfirmar").hide();
        $("#divIntrigaProgramarAvisoDatos").show();
    });

    $("[data-email-reenviar]").click(function (e) {
        if (!intrigaAceptoTerminos) {
            $(this).toggleClass('check_intriga');
        }
        intrigaAceptoTerminos = true;
        IntrigaConfirmarCorreo();
    });
});

function IntrigaConfirmarCorreo() {
    var emailNuevo = $.trim($("#txtIntrigaEmail").val()).toLowerCase();
    if (emailNuevo == "") {
        $('#txtIntrigaEmail').focus();
        AbrirMensaje("Debe ingresar EMail.\n");
        return false;
    }
    if (!validateEmail(emailNuevo)) {
        $('#txtIntrigaEmail').focus();
        AbrirMensaje("El formato del correo electrónico ingresado no es correcto.\n");
        return false;
    }

    if ($.trim($("#txtIntrigaCelular").val()) == "") {
        $('#txtIntrigaCelular').focus();
        AbrirMensaje("Debe ingresar celular.\n");
        return false;
    }

    if (!intrigaAceptoTerminos) {
        AbrirMensaje('Debe aceptar los terminos y condiciones para poder actualizar sus datos.');
        return false;
    }

    IntrigaActualizarDatos();
}

function IntrigaActualizarDatos() {
    var emailNuevo = $.trim($("#txtIntrigaEmail").val()).toLowerCase();

    AbrirLoad();
    var item = {
        EMail: emailNuevo,
        Celular: $.trim($("#txtIntrigaCelular").val()),
        AceptoContrato: intrigaAceptoTerminos
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ShowRoom/ProgramarAviso',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CerrarLoad();
            if (checkTimeout(data)) {

                if (data.success != true) {
                    AbrirMensaje(data.message);
                    $("#divIntrigaProgramarAvisoDatos").show();
                    return false;
                }

                emailActivo = $.trim(data.emailValidado).toLowerCase();
                $("[data-email-registrado]").html(emailNuevo);

                $("#divIntrigaProgramarAvisoDatos").hide();
                $("#divIntrigaEmailRespuestaOk").hide();
                $("#divIntrigaEmailRespuestaConfirmar").hide();
                if (emailOriginal == emailNuevo) {
                    if (emailActivo == "false") {
                        $("#divIntrigaEmailRespuestaOk").show();
                        $("[data-email-reenviar]").hide();
                        return true;
                    }
                }

                $("[data-email-reenviar]").show();
                $("#divIntrigaEmailRespuestaConfirmar").show();
            }
        },
        error: function (data, error) {
            CerrarLoad();
            if (checkTimeout(data)) {
                $("#divIntrigaProgramarAvisoDatos").show();
                AbrirMensaje("Ocurrió un error, intente nuevamente.");
                //alert("ERROR");
            }
        }
    });


   
}
