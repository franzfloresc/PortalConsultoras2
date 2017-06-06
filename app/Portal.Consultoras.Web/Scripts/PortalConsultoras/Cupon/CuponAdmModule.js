var cuponAdmModule = (function () {
    "use strict"

    var elements = {
        btnCrear: '#btnCrear',
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        ddlTipoCupon: '#ddlTipoCupon',
        contenedorCrearCupon: '#contenedor-crear-cupon',
        txtDescripcion: '#txtDescripcion',
        contenedorGrillaCupones: '#contenedor-grilla-cupones',
        tablaCupones: '#tabla-cupones'
    };

    var setting = {
        UrlListarCampanias: '',
        UrlCrearCupon: '',
        UrlActualizarCupon: '',
        UrlListarCuponesPorCampania: '',
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


            }
            else {
                $(elements.ddlCampania).empty();
                $(elements.ddlCampania).append($('<option/>', { value: "", text: "-- Seleccionar --" }));
            }

            _listarCuponesPorCampania();
        });

        $(document).on("change", elements.ddlCampania, function () {
            waitingDialog({});

            _listarCuponesPorCampania();
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
        var crearCuponDialog = $(elements.contenedorCrearCupon).dialog({
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
                    _guardarCuponNuevo(crearCuponDialog);
                },
                "Cancelar": function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var _guardarCuponNuevo = function (crearCuponDialog) {
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
                    $(crearCuponDialog).dialog('close');
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

    var _esValidoListar = function (paisId, campaniaId) {
        var messsage = '';

        if (paisId == '') {
            messsage += 'Debe seleccionar un país \n';
        }
        if (campaniaId == '') {
            messsage += 'Debe seleccionar una campañia \n';
        }

        return (messsage.length <= 0);
    }

    function _showActionsEvento(cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"return jQuery(" + elements.tablaCupones + ").EditarEvento('" + options.rowId + "','" + rowObject.CampaniaID + "','" + rowObject.Estado + "','" + rowObject.TieneCategoria + "','" + rowObject.TieneCompraXcompra + "','" + rowObject.TieneSubCampania + "', " + rowObject.TienePersonalizacion + ");\" >" + "<img src='' alt='Editar Evento ShowRoom' title='Editar Evento Show Room' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return jQuery(" + elements.tablaCupones + ").DeshabilitarEvento('" + options.rowId + "','" + rowObject.CampaniaID + "');\" >" + "<img src='' alt='Deshabilitar Evento ShowRoom' title='Deshabilitar Evento ShowRoom' border='0' /></a>";
        var remove = "&nbsp;<a href='javascript:;' onclick=\"return jQuery(" + elements.tablaCupones + ").EliminarEvento('" + options.rowId + "','" + rowObject.CampaniaID + "');\" >" + "<img src='' alt='Eliminar Evento ShowRoom' title='Eliminar Evento ShowRoom' border='0' /></a>";

        var resultado = edit;

        if (rowObject.Estado == "1")
            resultado += del;

        if (rowObject.Estado == "1")
            resultado += remove;

        return resultado;
    }

    var _listarCuponesPorCampania = function () {
        var paisId = $(elements.ddlPais + " option:selected").val();
        var campaniaId = $(elements.ddlCampania + " option:selected").val();

        paisId = (typeof paisId == 'undefined' ? '' : paisId);
        campaniaId = (typeof campaniaId == 'undefined' ? '' : campaniaId);

        if (_esValidoListar(paisId, campaniaId)) {
            jQuery(elements.tablaCupones).jqGrid({
                url: setting.UrlListarCuponesPorCampania,
                hidegrid: false,
                datatype: 'json',
                postData: ({
                    PaisID: function () { return $(elements.ddlPais).val() },
                    CampaniaID: function () { return ($(elements.ddlCampania).val() == "" ? "0" : $(elements.ddlCampania).val()); }
                }),
                mtype: 'GET',
                contentType: "application/json; charset=utf-8",
                colNames: ['Tipo', 'Descripción', 'Creación', ''],
                colModel: [
                    { name: 'Tipo', width: 50, editable: true, resizable: false },
                    { name: 'Descripcion', width: 80, editable: true, resizable: false },
                    { name: 'FechaCreacion', width: 80, editable: true, resizable: false },
                    { name: 'Options', width: 60, editable: true, sortable: false, align: 'center', resizable: false, formatter: _showActionsEvento }
                ],
                jsonReader:
                {
                    root: "rows",
                    page: "page",
                    total: "total",
                    records: "records",
                    repeatitems: false,
                    cell: "",
                    id: "id"
                },
                pager: jQuery('#pagerEvento'),
                loadtext: 'Cargando datos...',
                recordtext: "{0} - {1} de {2} Registros",
                emptyrecords: 'No hay resultados',
                rowNum: 10,
                scrollOffset: 0,
                rowList: [10, 20, 30, 40, 50],
                sortname: '',
                sortorder: 'asc',
                viewrecords: true,
                multiselect: false,
                height: 'auto',
                width: 930,
                pgtext: 'Pág: {0} de {1}',
                altRows: true,
                altclass: 'jQGridAltRowClass',
                loadComplete: function () { },
                gridComplete: function () {
                    var cantidadRegistros = jQuery(elements.tablaCupones).jqGrid('getGridParam', 'reccount');
                    if (cantidadRegistros > 0) {
                        $(elements.contenedorGrillaCupones).show();
                    } else {
                        $(elements.contenedorGrillaCupones).hide();
                    }

                    closeWaitingDialog();
                }
            });
            jQuery(elements.tablaCupones).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
            jQuery(elements.tablaCupones).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        } else {
            closeWaitingDialog();
            $(elements.contenedorGrillaCupones).hide();
        }
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

    var initializer = function (parameters) {
        setting.BaseUrl = parameters.baseUrl;
        setting.UrlListarCampanias = parameters.urlListarCampanias;
        setting.UrlCrearCupon = parameters.urlCrearCupon;
        setting.UrlActualizarCupon = parameters.urlActualizarCupon;
        setting.UrlListarCuponesPorCampania = parameters.urlListarCuponesPorCampania;

        _bindEvents();
        _iniDialogCrearCupon();
    }

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();