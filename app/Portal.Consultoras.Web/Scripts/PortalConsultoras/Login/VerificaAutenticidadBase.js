﻿'use strict';

var VerificaAutenticidad_Base = function () {
    var validarCamposConDatos = function () {
        var camposFormulario = $('.grupo_form_cambio_datos input, .grupo_form_cambio_datos select');
        $.each(camposFormulario, function (campoFormulario, key) {
            if (!IsNullOrEmpty(campoFormulario)) $(campoFormulario).addClass('campo_con_datos');
        });
    };

    var validarLabelActivo = function () {
        var valor = $(this).val();
        if (IsNullOrEmpty(valor)) $(this).removeClass('campo_con_datos');
        else $(this).addClass('campo_con_datos');
    };

    var asignarEventos = function () {
        $('body').on('blur', '.grupo_form_cambio_datos input, .grupo_form_cambio_datos select', validarLabelActivo);
    };

    return {
        Inicializar: function () {
            validarCamposConDatos();
            asignarEventos();
        }
    }
}

$(document).ready(function () { new VerificaAutenticidad_Base().Inicializar(); });