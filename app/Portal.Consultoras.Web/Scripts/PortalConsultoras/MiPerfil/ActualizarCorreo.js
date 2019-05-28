﻿'use strict';

var MiPerfil_ActualizarCorreo = function (_config) {
    var config = {
        UrlPaginaPrevia: _config.UrlPaginaPrevia || '',
        UrlActualizarEnviarCorreo: _config.UrlActualizarEnviarCorreo || '',
        MensajeError: _config.MensajeError || '',
        MensajeReenvioExitoso: _config.MensajeReenvioExitoso || '',
        VistaActual: 1,
        CorreoActual: _config.CorreoActual,
        IsConfirmar: _config.IsConfirmar
    };
    //INI HD-3897
    var activaGuardar = function () {
        var btn = $("#btnActualizarCorreo");
        btn.removeClass('btn_deshabilitado')
        if (getDataArrayError(getData()).length > 0 || !$('#chkAceptoContratoMD').prop('checked')) btn.addClass('btn_deshabilitado');

    };
    var mensajeError = function () {
        var obj = getData().correoNuevo;
        var band;
        showError("");
        
        if (obj == "") band = null;
        else if (obj != "" && !validateEmail(obj)) {
            showError(getDataArrayError(getData()).join('<br>'));
            band = false;
        } else band = true;
        

        activaCheck(band);
    };
    var activaCheck = function (band) {
        var obj = $("div[vista-id=1] .grupo_form_cambio_datos");
        obj.removeClass("grupo_form_cambio_datos--validacionExitosa");
        obj.removeClass("grupo_form_cambio_datos--validacionErronea");
        if (band == null) return;

        if (band) obj.addClass("grupo_form_cambio_datos--validacionExitosa");
        else obj.addClass("grupo_form_cambio_datos--validacionErronea");
        
    }
    //FIN HD-3897

    var showSuccess = function (message) { AbrirMensaje(message, 'Mensaje', '', 2); };
    var showError = function (error) { $("#ValidateCorreo").html(error); };
    var showArrayError = function (arrayError) {
        var mensaje = '';
        for (var i = 0; i <= arrayError.length - 2; i++) {
            mensaje += arrayError[i] + '<br/>';
        }
        mensaje += arrayError[arrayError.length - 1];

        showError(mensaje);
    };

    var getData = function () {
        return {
            correoNuevo: $.trim(IfNull($('#NuevoCorreo').val(), ''))
        };
    };
    var getDataArrayError = function (data) {
        var arrayError = [];

        if (data.correoNuevo === '') arrayError.push('Debe ingresar un email.');
        else if (!validateEmail(data.correoNuevo)) arrayError.push('El formato del email ingresado no es correcto.');

        return arrayError;
    };
    var postActualizarEnviarCorreo = function (data, fnSuccess) {
        AbrirLoad();
        $.post(config.UrlActualizarEnviarCorreo, data)
            .done(function (response) {
                if (!response.success) {
                    showError(response.message);
                    activaCheck(false);
                    return;
                }

                if ($.isFunction(fnSuccess)) fnSuccess(data);
            })
            .fail(function () { showError(config.MensajeError); activaCheck(false);})
            .always(CerrarLoad);
    };
    var actualizarEnviarCorreo = function (fnSuccess) {
        var data = getData();
        //INI HD-3897
        var arrayError = getDataArrayError(data);
        if (arrayError.length > 0) {
            showArrayError(arrayError);
            return;
        }
        //FIN HD-3897
        if (document.getElementById('chkAceptoContratoMD').checked == false) {
            alert('Debe aceptar los términos y condiciones para poder actualizar sus datos');
            return false;
        }

        postActualizarEnviarCorreo(data, fnSuccess);
    };
    var enlaceTerminosCondiciones = function () {
        var enlace = $('#hdn_enlaceTerminosCondiciones').val();
        $('#hrefTerminosMD').attr('href', enlace);
    }
    var irPaginaPrevia = function () { window.location.href = config.UrlPaginaPrevia; }
    var irVista = function (vistaId) {
        $('#tabVistas div[vista-id]').hide();
        $('#tabVistas div[vista-id=' + vistaId + ']').show();
        config.VistaActual = vistaId;
    }
    var irVista2 = function (email) {
        irVista(2);
        $('#txtCorreoEnviado').html(email);
    }

    var asignarEventos = function () {
   

        $('#btnVolver').on('click', function () {
            if (config.VistaActual == 1 || config.IsConfirmar==1) irPaginaPrevia();
            else if (config.VistaActual == 2) irVista(1);
        });
        $('#btnCancelar').on('click', irPaginaPrevia);
        $('#btnReescribirCorreo').on('click', function () {
            if (config.IsConfirmar == 1) {
                $('#NuevoCorreo').val(config.CorreoActual);
                $('#NuevoCorreo').addClass('campo_con_datos');
            }irVista(1);
        });

        $('#btnReenviameInstruciones').on('click', function () {
            var MsjSuccess = function () { $("#spnReenviarInstrucciones").show(); };
            if (config.IsConfirmar == 1) {
                postActualizarEnviarCorreo({ correoNuevo: config.CorreoActual }, MsjSuccess);
            } else {
                actualizarEnviarCorreo(MsjSuccess);
            }
        });
        $('#btnActualizarCorreo').on('click', function () { actualizarEnviarCorreo(function (data) { irVista2(data.correoNuevo); }); });
        $('#hrefTerminosMD').on('click', function () { enlaceTerminosCondiciones(); });

        //INI HD-3897
        $('#tabVistas div[vista-id=1] input').on('keyup change', function () { activaGuardar(); return $(this).val() });
        $('#NuevoCorreo').on('focusout', function () { mensajeError(); });
        //FIN HD-3897

        FuncionesGenerales.AvoidingCopyingAndPasting('NuevoCorreo');
    };

    return {
        Inicializar: function () {
            asignarEventos();
                //INI HD-3897
            if (config.IsConfirmar == 1) {
                postActualizarEnviarCorreo({ correoNuevo: config.CorreoActual }, irVista2(config.CorreoActual));
            } else{
                irVista(config.VistaActual);

            }
              //FIN HD-3897
        }
    }
}