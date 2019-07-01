//INI HD-4294
var Pedido_ActualizarCorreo = function (_config) {
    var config = {
        UrlActualizarEnviarCorreo: _config.UrlActualizarEnviarCorreo,
        UrlPedidoValidado: _config.UrlPedidoValidado,
        MensajeError: _config.MensajeError,
        MensajeReenvioExitoso: _config.MensajeReenvioExitoso,
        CorreoActual: _config.CorreoActual,
        VistaActual: "#Paso1-RegistroCorreo"
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

        
        if (config.VistaActual == "#Paso2-ConfirmacionCorreo" && error != "") { $("#spnReenviarInstruccionesError .textError").text(error); $("#spnReenviarInstruccionesError").show() }
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

        showLoading();
        $.post(config.UrlActualizarEnviarCorreo, { correoNuevo: getCorreoNuevo() })
            .done(function (response) {
                if (!response.success) {
                    showError(response.message);
                    $(config.VistaActual).show(); 
                    return;
                }

                if ($.isFunction(fnSuccess)) fnSuccess();
            })
            .fail(function () { showError(config.MensajeError); $(config.VistaActual).show(); })
            .always(hideLoading);
    }


    var irVistaCorreoEnviado = function () {

        $("#txtCorreoElectronicoPorConfirmar").val(getCorreoNuevo());
        $("#PopupReservaPedido .vistaPopup").hide();
        config.VistaActual = "#Paso2-ConfirmacionCorreo";
        $(config.VistaActual).show();

        
    }

    var irVistaInicioValidacionCorreo = function () {
        var txtEmail = $("#txtCorreoElectronicoBoletaElectronica");
        if (config.CorreoActual != "") {
            txtEmail.val(config.CorreoActual);
            txtEmail.addClass('text__field__sb--withContent')
            txtEmail.attr("readonly", true);
            $("#iconActivaEditar").show();
        } else {

            txtEmail.val("");
            txtEmail.attr("readonly", false);
            activaGuardar();
            $("#iconActivaEditar").hide();
        }
        
        $("#PopupReservaPedido .vistaPopup").hide();
        config.VistaActual = "#Paso1-RegistroCorreo";
        $(config.VistaActual).show();
        $("#PopupReservaPedido").show();
    }
    var showLoading = function () {
        $("#PopupReservaPedido .vistaPopup").hide();
        $("#VistaPrecarga").show();
       
    };

    var hideLoading = function () {
        $("#VistaPrecarga").hide();
    };
    var campoActivo = function (obj) {
        var campo = $(obj).val();
        if (campo) {
            $(obj).addClass('text__field__sb--withContent');
        } else {
            $(obj).removeClass('text__field__sb--withContent');
        }
    }
    var asignarEventos = function () {

        var inputEmail = document.getElementById("txtCorreoElectronicoBoletaElectronica");
        FuncionesGenerales.AutoCompletarEmailAPartirDeArroba(inputEmail);

        $("body").on("close", "#PopupReservaPedido", function () {
            AbrirLoad();
            document.location = config.UrlPedidoValidado;
        });

        $('#btnReenviameInstruciones').on('click', function () {
            $("#spnReenviarInstrucciones").hide();
            $("#spnReenviarInstruccionesError").hide();
            var MsjSuccess = function () { $("#spnReenviarInstrucciones").show(); irVistaCorreoEnviado(); };
                actualizarEnviarCorreo(MsjSuccess);
        });

        $('#btnActualizarCorreo').on('click', function () {
            var CorreoEnviado = function () { irVistaCorreoEnviado();};
            actualizarEnviarCorreo(CorreoEnviado);
        });
        $('#iconActivaEditar').on('click', function () {
            $("#txtCorreoElectronicoBoletaElectronica").attr("readonly", false);
            $("#txtCorreoElectronicoBoletaElectronica").focus();
        });
        $('#txtCorreoElectronicoBoletaElectronica').on('blur', function () { campoActivo(this); });
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




