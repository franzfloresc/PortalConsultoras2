        $(document).ready(function () {
            $("#CampoFechaNacimiento").datepicker({
                dateFormat: 'dd/mm/yy'
            });
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
                email: "Por favor ingresa un email válido.",
                date: "Por favor ingresa un fecha válida.",
                required: "Este campo es requrerido."
        });
            $('div.mensaje_validacion').not(':has(span.field-validation-error)').hide();

            $(".field-validation-valid").bind("DOMNodeInserted", function () {
                var div = $(this).closest('div.mensaje_validacion');
                div.show();
            });
            $(".field-validation-error").bind("DOMNodeInserted", function () {
                var div = $(this).closest('div.mensaje_validacion');
                div.show();
            });
            $(".field-validation-valid").bind("DOMNodeRemoved", function () {
                var div = $(this).closest('div.mensaje_validacion');
                div.hide();
            });
            $(".field-validation-error").bind("DOMNodeRemoved", function () {
                var div = $(this).closest('div.mensaje_validacion');
                div.hide();
            });

            $('#NumberCard').on('keydown', FuncionesGenerales.ValidarSoloNumeros);
            $('#Cvv').on('keydown', FuncionesGenerales.ValidarSoloNumeros);
            $('#Titular').on('keydown', FuncionesGenerales.ValidarSoloLetras);
            $('#Phone').on('keydown', FuncionesGenerales.ValidarSoloNumeros);
        });