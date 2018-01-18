var intrigaAceptoTerminos = false;

$(document).ready(function () {

    emailActivo = (emailActivo || "").toLowerCase();

    $("#divIntrigaProgramarAvisoDatos").hide();
    $("#divIntrigaEmailRespuestaOk").hide();
    $("#divIntrigaEmailRespuestaConfirmar").hide();

    if (suscrito == "True") {
        if (emailActivo == "true") {
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
        IntrigaConfirmarCorreo(true);
    });

    $("[data-email-cambiar]").click(function (e) {
        $("#divIntrigaEmailRespuestaOk").hide();
        $("#divIntrigaEmailRespuestaConfirmar").hide();
        $("#divIntrigaProgramarAvisoDatos").show();
        $(".termino_condiciones_intriga").removeClass('check_intriga');
        intrigaAceptoTerminos = false;
    });

    $("[data-email-reenviar]").click(function (e) {
        $(".termino_condiciones_intriga").addClass('check_intriga');
        intrigaAceptoTerminos = true;
        IntrigaConfirmarCorreo(false);
    });
});

function IntrigaConfirmarCorreo(sendAnalytics) {
    var emailNuevo = $.trim($("#txtIntrigaEmail").val()).toLowerCase();

    if (emailNuevo == "") {
        AbrirMensaje("Debe ingresar EMail.\n");
        return false;
    }
    if (!validateEmail(emailNuevo)) {
        AbrirMensaje("El formato del correo electrónico ingresado no es correcto.\n");
        return false;
    }

    if (!intrigaAceptoTerminos) {
        AbrirMensaje('Debe aceptar los términos y condiciones para poder actualizar sus datos.');
        return false;
    }

    IntrigaActualizarDatos(sendAnalytics);
}

function IntrigaActualizarDatos(sendAnalytics) {
    var emailNuevo = $.trim($("#txtIntrigaEmail").val()).toLowerCase();

    AbrirLoad();
    var item = {
        EMail: emailNuevo,
        Celular: $.trim($("#txtIntrigaCelular").val()),
        AceptoContrato: intrigaAceptoTerminos,
        EnviarParametrosUTMs: true
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

                if (!data.success) {
                    AbrirMensaje(data.message);
                    $("#divIntrigaProgramarAvisoDatos").show();
                    return false;
                }

                if (sendAnalytics != undefined && sendAnalytics == true)
                    click_completar_registro_form_intriga();

                emailActivo = $.trim(data.emailValidado).toLowerCase();
                $("[data-email-registrado]").html(emailNuevo);

                $("#divIntrigaProgramarAvisoDatos").hide();
                $("#divIntrigaEmailRespuestaOk").hide();
                $("#divIntrigaEmailRespuestaConfirmar").hide();
                if (emailOriginal == emailNuevo) {
                    if (emailActivo == "true") {
                        $("#divIntrigaEmailRespuestaOk").show();
                        return true;
                    }
                }

                $("#divIntrigaEmailRespuestaConfirmar").show();
            }
        },
        error: function (data, error) {
            CerrarLoad();
            if (checkTimeout(data)) {
                $("#divIntrigaProgramarAvisoDatos").show();
                AbrirMensaje("Ocurrió un error, intente nuevamente.");
            }
        }
    });
}

function click_terminos_y_condiciones_form_intriga() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom Formulario',
        'action': 'Click Términos y Condiciones',
        'label': '(not available)'
    });
}

function click_completar_registro_form_intriga() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom Formulario',
        'action': 'Registro Exitoso',
        'label': '(not available)'
    });
}