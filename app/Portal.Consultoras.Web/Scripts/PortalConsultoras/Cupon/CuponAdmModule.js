var cuponAdmModule = (function () {
    "use strict"

    var elements = {
        btnCrear: '#btnCrear',
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        ddlTipoCupon: '#ddlTipoCupon',
        contenedorCrearCupon: '#contenedor-crear-cupon',
        txtDescripcion: '#txtDescripcion'
    };

    var setting = {
        UrlListarCampanias: '',
        UrlCrearCupon: '',
        UrlActualizarCupon: '',
        contenedorCrearCupon: 'contenedor-crear-cupon'
    };

    var listaCampanias = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnCrear, function () {
            if (_esValidoCrearCupon()) {
                _resetearValoresPopupCrearCupon();
                showDialog(setting.contenedorCrearCupon);
            }
        });

        $(document).on("change", elements.ddlPais, function () {
            waitingDialog({});

            if ($(elements.ddlPais).val() != "") {
                if (listaCampanias.length <= 0) {
                    _cargarCampaniasDesdeServicio($(elements.ddlPais).val());
                } else {
                    _cargarCampanias();
                }
            } else {
                $(elements.ddlCampania).empty();
                $(elements.ddlCampania).append($('<option/>', { value: "", text: "-- Seleccionar --" }));
            }

            closeWaitingDialog();
        });
    }

    var _cargarCampaniasDesdeServicio = function (paisId) {
        $(elements.ddlCampania).empty();
        var campaniasPromise = _listarCampaniasPromise(paisId);

        $.when(campaniasPromise).then(function (campaniasResponse) {
            if (checkTimeout(campaniasResponse)) {
                listaCampanias = campaniasResponse.listaCampanias;
                $(elements.ddlCampania).append($('<option/>', { value: "", text: "-- Seleccionar --" }));

                if (listaCampanias.length > 0) {
                    $.each(listaCampanias, function (index, item) {
                        $(elements.ddlCampania).append($('<option/>', {
                            value: item.CampaniaID,
                            text: item.Codigo
                        }));
                    });
                }
            }
        });
    };

    var _cargarCampanias = function (paisId) {
        $(elements.ddlCampania).empty();
        $(elements.ddlCampania).append($('<option/>', { value: "", text: "-- Seleccionar --" }));

        if (listaCampanias.length > 0) {
            $.each(listaCampanias, function (index, item) {
                $(elements.ddlCampania).append($('<option/>', {
                    value: item.CampaniaID,
                    text: item.Codigo
                }));
            });
        }
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
            title: "Nuevo Cupón",
            buttons:
            {
                "Guardar": function () {
                    _guardarCuponNuevo();
                },
                "Cancelar": function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var _guardarCuponNuevo = function () {
        if (!_esValidoGuardarCupon()) {
            return;
        }

        waitingDialog({});

        var cuponModel = {
            tipo: $(elements.ddlTipoCupon + " option:selected").val(),
            descripcion: $(elements.txtDescripcion).val(),
            campaniaId: $(elements.ddlCampania + " option:selected").val()
        };
        var crearCuponPromise = _crearCuponPromise(cuponModel);

        $.when(crearCuponPromise).then(function (crearCuponResponse) {
            if (checkTimeout(crearCuponResponse)) {
                if (crearCuponResponse.success) {
                    alert(crearCuponResponse.message);
                    $(setting.contenedorCrearCupon).dialog('close');
                } else {
                    alert(crearCuponResponse.message);
                }
            }
        });

        closeWaitingDialog();

    };

    var _resetearValoresPopupCrearCupon = function () {
        $(elements.txtDescripcion).val("");
        $(elements.ddlTipoCupon + " option:first").attr('selected', 'selected');
    };

    var _listarCampaniasPromise = function (paisId) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'GET',
            url: (setting.UrlListarCampanias),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            //data: { paisId: paisId },
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    var _crearCuponPromise = function (cuponModel) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: (setting.UrlCrearCupon),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(cuponModel),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    var _actualizarCuponPromise = function (cuponModel) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: (setting.UrlActualizarCupon),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(cuponModel),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    var _esValidoGuardarCupon = function () {
        if ($(elements.ddlTipoCupon).val() == "") {
            alert('Debe seleccionar el tipo de cupón');
            return false;
        }

        if ($(elements.ddlCampania).val() == "") {
            alert('Debe seleccionar una campaña');
            return false;
        }

        if ($(elements.txtDescripcion).val() == "") {
            alert('Debe ingresar la descripción del cupón');
            return false;
        }

        return true;
    };

    var initializer = function (parameters) {
        setting.BaseUrl = parameters.baseUrl;
        setting.UrlListarCampanias = parameters.urlListarCampanias;
        setting.UrlCrearCupon = parameters.urlCrearCupon;
        setting.UrlActualizarCupon = parameters.urlActualizarCupon;
        _bindEvents();
        _iniDialogCrearCupon();
    }

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();