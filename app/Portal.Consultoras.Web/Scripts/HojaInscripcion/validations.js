$(function () {
    var expressionrequiredifFunction = function (value, element, params) {
        //var listaValores = params.listvalues.split(',');
        var listaValores = [];
        var expresion = params.expresion;
        var regexnotmatch = params.regexnotmatch;
        var valueOtherproperty = '';
        var otherproperties = params.otherproperty.split('|');
        var otherValueProperties = params.listvalues.split('|');
        var validateCount = 0;

        $.each(otherproperties, function (i, item) {
            if ($("#" + item).prop("type") === "checkbox") {
                valueOtherproperty = $("#" + item).is(":checked") ? 'True' : 'False';
            } else {
                valueOtherproperty = $("#" + item).val();
            }
            listaValores = otherValueProperties[i].split(',');
            if ($.inArray(valueOtherproperty, listaValores) !== -1) {
                validateCount++;
            }
        });

        if (validateCount === otherproperties.length) {
            var regex = new RegExp(expresion);
            var resultado = regex.test(value);

            if ((!resultado && regexnotmatch == 0) || (resultado && regexnotmatch == 1))
                return false;
        }

        return true;
    };

    jQuery.validator.unobtrusive.adapters.add('requiredif',
        ['otherproperty', 'listvalues'],
        function (options) {
            options.rules["requiredif"] = {
                otherproperty: '#' + options.params.otherproperty,
                listvalues: options.params.listvalues
            };

            options.messages['requiredif'] = options.message;
        });

    jQuery.validator.unobtrusive.adapters.add('expressionrequiredif',
        ['otherproperty', 'listvalues', 'expresion', 'regexnotmatch'],
        function (options) {
            options.rules["expressionrequiredif"] = {
                otherproperty: options.params.otherproperty,
                listvalues: options.params.listvalues,
                expresion: options.params.expresion,
                regexnotmatch: options.params.regexnotmatch
            };

            options.messages['expressionrequiredif'] = options.message;
        });

    jQuery.validator.unobtrusive.adapters.add("expressionrequiredifmultiple",
        ["listvalues", "otherproperty", "expresion", "regexnotmatch"],
        function (options) {
            options.rules['expressionrequiredifmultiple'] = {
                listvalues: options.params.listvalues,
                otherproperty: options.params.otherproperty,
                expresion: options.params.expresion,
                regexnotmatch: options.params.regexnotmatch,
                errorMsgs: options.message
            };
            options.messages['expressionrequiredifmultiple'] = "";
        });

    jQuery.validator.unobtrusive.adapters.add('requiredifpropertiesnotnull',
        ['properties', 'condicion', 'listvalues', 'otherproperty'],
        function (options) {
            var listaPropiedades = options.params.properties.split(',');
            var listaSelectoresPropiedades = new Array();

            $.each(listaPropiedades,
                function (index, item) {
                    listaSelectoresPropiedades.push("#" + item);
                });

            options.rules["requiredifpropertiesnotnull"] = {
                selectores: listaSelectoresPropiedades,
                condicion: options.params.condicion,
                otherproperty: '#' + options.params.otherproperty,
                listvalues: options.params.listvalues
            };
            options.messages['requiredifpropertiesnotnull'] = options.message;
        });

    jQuery.validator.addMethod('requiredif',
        function (value, element, params) {

            var listaValores = params.listvalues.split(',');

            var existeEnArray = $.inArray($(params.otherproperty).val(), listaValores) !== -1;

            if (existeEnArray && isNullOrEmpty(value))
                return false;

            return true;
        },
        '');

    jQuery.validator.addMethod('expressionrequiredif', expressionrequiredifFunction, '');
    jQuery.validator.addMethod("expressionrequiredifmultiple",
        function (value, element, params) {
            var listvalues = params.listvalues.split('!');
            var otherproperty = params.otherproperty.split('!');
            var expresion = params.expresion.split('!');
            var regexnotmatch = params.regexnotmatch.split('!');
            var msgs = params.errorMsgs.split('!');
            var errMsg = "";

            var response;
            $.each(listvalues,
                function (index, val) {
                    var myParams = {
                        "listvalues": val,
                        "otherproperty": otherproperty[index],
                        "expresion": expresion[index],
                        "regexnotmatch": regexnotmatch[index]
                    };

                    response = expressionrequiredifFunction(value, element, myParams);
                    if (response == false) {
                        errMsg = msgs[index];
                        return false;
                    }
                });

            if (response == false) {
                var evalStr = "this.settings.messages." +
                    $(element).attr("name") +
                    ".expressionrequiredifmultiple='" +
                    errMsg +
                    "'";
                eval(evalStr);
            }

            return response;
        });

    jQuery.validator.addMethod('requiredifpropertiesnotnull',
        function (value, element, params) {
            if (params.listvalues &&
                params.listvalues.length > 0 &&
                params.otherproperty &&
                params.otherproperty.length > 0) {
                var listaValores = params.listvalues.split(',');
                var existeEnArray = $.inArray($(params.otherproperty).val(), listaValores) !== -1;

                if (!existeEnArray)
                    return true;
            }

            var listaValoresPropiedadesEvaluar = new Array();
            var condicion = params.condicion;

            $.each(params.selectores,
                function (index, prop) {
                    var valorPropiedad = $(prop).val();
                    listaValoresPropiedadesEvaluar.push(valorPropiedad);
                });

            if ((condicion && listaValoresPropiedadesEvaluar.every(isNullOrEmpty)) ||
            (!condicion && listaValoresPropiedadesEvaluar.some(isNullOrEmpty)))
                return false;

            return true;

        },
        '');

    function isNullOrEmpty(element, index, array) {
        return element == null || element == "";
    }

    function DecimalNumber(e) {
        // Allow: backspace, delete, tab, escape, enter
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return true;
        }

        // Allow: '.' (just once)
        if (e.keyCode == 190 || e.keyCode == 110) {
            if ($(this).val().indexOf('.') == -1) {
                return true;
            }
        }

        // Allow copy, cut and don't allow paste
        var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
        if (ctrlDown && e.altKey) return true;
        else if (ctrlDown && e.keyCode == 67) return true; // c
        else if (ctrlDown && e.keyCode == 86) return false; // v
        else if (ctrlDown && e.keyCode == 88) return true; // x

        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || e.altKey || e.ctrlKey || (e.keyCode < 48 || e.keyCode > 57)) &&
        (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    }

    function IntegerNumber(e) {
        // Allow: backspace, delete, tab, escape, enter
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return true;
        }

        // Allow copy, cut and don't allow paste
        var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
        if (ctrlDown && e.altKey) return true;
        else if (ctrlDown && e.keyCode == 67) return true; // c
        else if (ctrlDown && e.keyCode == 86) return false; // v
        else if (ctrlDown && e.keyCode == 88) return true; // x

        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || e.altKey || e.ctrlKey || (e.keyCode < 48 || e.keyCode > 57)) &&
        (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }

        return true;
    }

    /* For tickets, bills and referral guide codes */
    function BillNumber(e) {
        // Allow: backspace, delete, tab, escape, enter, dash(2)
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 109, 189]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return true;
        }

        // Allow copy, cut and don't allow paste
        var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
        if (ctrlDown && e.altKey) return true;
        else if (ctrlDown && e.keyCode == 67) return true; // c
        else if (ctrlDown && e.keyCode == 86) return false; // v
        else if (ctrlDown && e.keyCode == 88) return true; // x

        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || e.altKey || e.ctrlKey || (e.keyCode < 48 || e.keyCode > 57)) &&
        (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    }

    function Text(e) {
        // Allow: backspace, delete, tab, escape, enter, dash(2)
        if ($.inArray(e.keyCode, [8, 9, 27, 13, 109, 189]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true)) {
            // let it happen, don't do anything
            return true;
        }

        // Allow copy, cut and don't allow paste
        var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
        if (ctrlDown && e.altKey) return true;
        else if (ctrlDown && e.keyCode == 67) return true; // c
        else if (ctrlDown && e.keyCode == 86) return true; // v
        else if (ctrlDown && e.keyCode == 88) return true; // x

        var key = String.fromCharCode(e.which);
        var RegExpression = /^[a-zA-ZñáéíóúÑÁÉÍÓÚäëïöüÄËÏÖÜ\s]*$/;

        return RegExpression.test(key);
    }
}(jQuery));