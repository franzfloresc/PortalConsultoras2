var pasarelaModule = (function($) {
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

        function registerEvents() {
            $('#NumberCard').on('keydown', FuncionesGenerales.ValidarSoloNumeros);
            $('#Cvv').on('keydown', FuncionesGenerales.ValidarSoloNumeros);
            $('#Titular').on('keydown', FuncionesGenerales.ValidarSoloLetras);
            $('#Phone').on('keydown', FuncionesGenerales.ValidarSoloNumeros);
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
                        $.datepicker.parseDate('dd/mm/yy', value);
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
            $("#CampoFechaNacimiento").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        }

        function init() {
            initWidgets();
            configureValidator();
            registerEvents();
            $('div.mensaje_validacion').not(':has(span.field-validation-error)').hide();
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