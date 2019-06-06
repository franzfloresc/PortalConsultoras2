//INI HD-4294
var Pedido_ActualizarCorreo = function (_config) {
    var config = {
        UrlActualizarEnviarCorreo: _config.UrlActualizarEnviarCorreo,
        MensajeError: _config.MensajeError,
        MensajeReenvioExitoso: _config.MensajeReenvioExitoso,
        CorreoActual: _config.CorreoActual
    }

    var getCorreoNuevo = function () {
        return $.trim(IfNull($('#txtCorreoElectronicoBoletaElectronica').val(), ''));
    }
    var activaGuardar = function () {
        var btn = $("#btnActualizarCorreo");
        btn.removeClass('btn__sb--disabled')
        if (getError()!="") btn.addClass('btn__sb--disabled');

    }

    var showError = function (error) {
        error = error || getError();

 
        if ($("#Paso1-RegistroCorreo").css("display") == "none"  && error!="") { $("#spnReenviarInstruccionesError .textError").text(error); $("#spnReenviarInstruccionesError").show() }
        else $("#ValidateCorreo").html(error);
    };

    var getError = function () {
        var data = getCorreoNuevo();
        var arrayError = [];
        var Error = "";

        if (data=== '') arrayError.push('Debes ingresar tu email.');
        else if (!validateEmail(data)) arrayError.push('El formato del email ingresado no es correcto.');

        Error = arrayError.join('<br>');
        return Error;
    }

    var actualizarEnviarCorreo = function (fnSuccess) {
        showError();
        if ($("#ValidateCorreo").html() != "") return;

        AbrirLoad();
        $.post(config.UrlActualizarEnviarCorreo, { correoNuevo: getCorreoNuevo() })
            .done(function (response) {
                if (!response.success) {
                    showError(response.message);
                    return;
                }

                if ($.isFunction(fnSuccess)) fnSuccess();
            })
            .fail(function () { showError(config.MensajeError); })
            .always(CerrarLoad);
    }


    var irVistaCorreoEnviado = function () {

        $("#txtCorreoElectronicoPorConfirmar").val(getCorreoNuevo());

        $("#Paso2-ConfirmacionCorreo").show();
        $("#Paso1-RegistroCorreo").hide();
        $("#PopupReservaPedido").show();
    }

    var irVistaInicioValidacionCorreo = function () {
        var txtEmail = $("#txtCorreoElectronicoBoletaElectronica");
        if (config.CorreoActual != "") {
            txtEmail.val(config.CorreoActual);
            txtEmail.attr("readonly", true);
            $("#iconActivaEditar").show();
        } else {

            txtEmail.val("");
            txtEmail.attr("readonly", false);
            activaGuardar();
            $("#iconActivaEditar").hide();
        }

        $("#Paso2-ConfirmacionCorreo").hide();
        $("#Paso1-RegistroCorreo").show();
        $("#PopupReservaPedido").show();
    }
    var asignarEventos = function () {

        var inputEmail = document.getElementById("txtCorreoElectronicoBoletaElectronica");
        FuncionesGenerales.AutoCompletarEmailAPartirDeArroba(inputEmail);

        $('#btnReenviameInstruciones').on('click', function () {
            $("#spnReenviarInstrucciones").hide();
            $("#spnReenviarInstruccionesError").hide();
            var MsjSuccess = function () { $("#spnReenviarInstrucciones").show(); };
                actualizarEnviarCorreo(MsjSuccess);
        });

        $('#btnActualizarCorreo').on('click', function () {
            var CorreoEnviado = function () { irVistaCorreoEnviado();};
            actualizarEnviarCorreo(CorreoEnviado);
        });
        $('#iconActivaEditar').on('click', function () {
            $("#txtCorreoElectronicoBoletaElectronica").attr("readonly", false);
        });
        $('#txtCorreoElectronicoBoletaElectronica').on('keyup change', function () { activaGuardar(); return $(this).val() });
        $('#txtCorreoElectronicoBoletaElectronica').on('focusout', function () { showError(); });

        FuncionesGenerales.AvoidingCopyingAndPasting('txtCorreoElectronicoBoletaElectronica');
    }


    return {
        Inicializar: function () {
            asignarEventos();
            irVistaInicioValidacionCorreo();
        }
    }
}
//FIN HD-4294




