var cuponAdmModule = (function () {
    "use strict"

    var elements = {
        btnCrear: '#btnCrear',
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        contenedorCrearCupon: '#contenedor-crear-cupon'
    };

    var setting = {
        contenedorCrearCupon: 'contenedor-crear-cupon'
    };

    var _bindEvents = function () {
        $(document).on("click", elements.btnCrear, function () {
            if (_esValidoCrearCupon()) {
                showDialog(setting.contenedorCrearCupon);
            }
        });

        $(document).on("change", elements.ddlPais, function () {
            if ($(elements.ddlPais).val() != "") {
                _cargarCampanias();
            }
        });
    }

    var _cargarCampanias = function () {
        $(elements.ddlCampania).empty();
    };

    var _esValidoCrearCupon = function () {
        if ($(elements.ddlPais).val() == "") {
            alert("Debe seleccionar el País, verifique");
            return false;
        }

        if ($(elements.ddlCampania).val() == "") {
            alert("Debe seleccionar la Campaña, verifique");
            return false;
        }

        return true;
    }

    var _setDefaultValues = function () { };

    var _iniDialogCrearCupon = function () {
        $(elements.contenedorCrearCupon).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 500,
            draggable: true,
            title: "Crear Nuevo Cupón",
            buttons:
            {
                "Guardar": function () {
                    //validaciones, llamadas ajax, etc
                },
                "Cancelar": function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var initializer = function (parameters) {
        _bindEvents();
        _iniDialogCrearCupon();
    }

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();