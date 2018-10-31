﻿var pasarelaModule = (function($) {
    var me = {};

    me.Funciones = (function() {

        function showPanel() {
            var div = $(this).closest('div.mensaje_validacion');
            div.show();
        }

        function hidePanel() {
            var div = $(this).closest('div.mensaje_validacion');
            div.hide();
        }

        function onlyNumbers() {
            this.value = this.value.replace(/\D/g,'');
        }

        function registerEvents() {
            $('#NumberCard').on('input', onlyNumbers);
            $('#Cvv').on('input', onlyNumbers);
            $('#Titular').on('keydown', FuncionesGenerales.ValidarSoloLetras);
            $('#Phone').on('input', onlyNumbers);
            $(".field-validation-valid").bind("DOMNodeInserted", showPanel);
            $(".field-validation-error").bind("DOMNodeInserted", showPanel);
            $(".field-validation-valid").bind("DOMNodeRemoved", hidePanel);
            $(".field-validation-error").bind("DOMNodeRemoved", hidePanel);
        }

        function configureValidator() {
            $("form#frmPay :input").each(function () {
                var input = $(this);
                var value = input.attr('data-val-length-max');
                if (value) {
                    input.prop('maxlength', value);
                }
            });
            $.validator.addMethod('date',
                function (value, element) {
                    if (this.optional(element)) {
                        return true;
                    }
                    var valid = true;
                    try {
                        var date = $.datepicker.parseDate('dd/mm/yy', value);

                        valid = new Date() > date;
                    }
                    catch (err) {
                        valid = false;
                    }
                    return valid;
                });

            jQuery.extend(jQuery.validator.messages, {
                email: "Por favor ingresa un email válido",
                date: "Por favor ingresa un fecha válida",
                required: "Este campo es obligatorio"
            });
        }

        function initWidgets() {
            $("#Birthdate").datepicker({
                dateFormat: 'dd/mm/yy',
                //maxDate: '0',
                changeMonth: true,
                changeYear: true,
                monthNamesShort: [ "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" ],
                yearRange: "c-120:c"
            });
        }

        function init() {
            initWidgets();
            configureValidator();
            registerEvents();
            $('div.mensaje_validacion').has('span.field-validation-error').show();
        }

        return {
            init: init 
        };
    })();

    return me;
})(jQuery);

$(document).ready(function () {
    pasarelaModule.Funciones.init();
});