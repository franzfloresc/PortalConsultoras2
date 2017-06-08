var cuponAdmModule = (function () {
    "use strict"

    var CONTANSTES_CUPON = {
        CODIGO_TIPO_MONTO: 1,
        CODIGO_TIPO_PORCENTAJE: 2,
        NOMBRE_TIPO_MONTO: 'MONTO',
        NOMBRE_TIPO_PORCENTAJE: 'PORCENTAJE'
    };

    var elements = {
        btnCrear: '#btnCrear',
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        ddlTipoCupon: '#ddlTipoCupon',
        popupMantenimientoCupon: '#popup-mantenimiento-Cupon',
        txtDescripcion: '#txtDescripcion',
        hdCuponId: '#hdCuponId',
        contenedorGrillaCupones: '#contenedor-grilla-cupones',
        contenedorGrillaCuponConsultoras: '#contenedor-grilla-cupon-consultoras',
        tablaCupones: '#tabla-cupones',
        tablaCuponConsultoras: '#tabla-cupon-consultoras',
        chckActivo: '#chckActivo',
        contenedorCheckActivo: '#contenedor-check-activo',
        contenedorCuponConsultora: '#contenedor-cupon-consultora',
        contenedorCupon: '#contenedor-cupon',
        btnRegresar: '#btnRegresar',
        spnCampania: '#spnCampania',
        spnTipo: '#spnTipo',
        spnDescripcion: '#spnDescripcion'
    };

    var setting = {
        UrlListarCampanias: '',
        UrlCrearCupon: '',
        UrlActualizarCupon: '',
        UrlListarCuponesPorCampania: '',
        UrlListarCuponConsultorasPorCupon: '',
        popupMantenimientoCupon: 'popup-mantenimiento-Cupon',
    };

    var listaCampanias = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnCrear, function () {
            if (_esValidoCrearCupon()) {
                _resetearValoresPopupMantenimientoCupon();
                showDialog(setting.popupMantenimientoCupon);
            }
        });

        $(document).on("click", elements.btnRegresar, function () {
            _mostrarContenedorCupon();
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
        var campaniasPromise = _listarCampaniasPromise(paisId);
        $.when(campaniasPromise).then(function (campaniasResponse) {
            if (checkTimeout(campaniasResponse)) {
                $(elements.ddlCampania).empty();
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

    var _inicializarDialogs = function () {
        _iniDialogMantenimientoCupon();
    };

    var _iniDialogMantenimientoCupon = function () {
        var mantCuponDialog = $(elements.popupMantenimientoCupon).dialog({
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
                    if ($(elements.hdCuponId).val() == "") {
                        _guardarCuponNuevo(mantCuponDialog);
                    } else {
                        _actualizarCupon(mantCuponDialog);
                    }
                },
                "Cancelar": function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var _guardarCuponNuevo = function (mantCuponDialog) {
        if (!_esValidoGuardarCupon()) {
            return;
        }

        waitingDialog({});

        var cuponModel = {
            tipo: $(elements.ddlTipoCupon + " option:selected").val().trim(),
            descripcion: $(elements.txtDescripcion).val().trim(),
            campaniaId: $(elements.ddlCampania + " option:selected").val()
        };
        var crearCuponPromise = _crearCuponPromise(cuponModel);

        $.when(crearCuponPromise).then(function (crearCuponResponse) {
            if (checkTimeout(crearCuponResponse)) {
                if (crearCuponResponse.success) {
                    alert(crearCuponResponse.message);
                    _listarCuponesPorCampania();
                    $(mantCuponDialog).dialog('close');
                } else {
                    alert(crearCuponResponse.message);
                }
            }
        });

        closeWaitingDialog();

    };

    var _actualizarCupon = function (mantCuponDialog) {
        if (!_esValidoGuardarCupon()) {
            return;
        }

        waitingDialog({});

        var cuponModel = {
            cuponId: $(elements.hdCuponId).val(),
            tipo: $(elements.ddlTipoCupon + " option:selected").val(),
            descripcion: $(elements.txtDescripcion).val().trim(),
            campaniaId: $(elements.ddlCampania + " option:selected").val(),
            estado: $(elements.chckActivo).is(":checked")
        };
        var actualizarCuponPromise = _actualizarCuponPromise(cuponModel);

        $.when(actualizarCuponPromise).then(function (actualizarCuponResponse) {
            if (checkTimeout(actualizarCuponResponse)) {
                if (actualizarCuponResponse.success) {
                    alert(actualizarCuponResponse.message);
                    _listarCuponesPorCampania();
                    $(mantCuponDialog).dialog('close');
                } else {
                    alert(actualizarCuponResponse.message);
                }
            }
        });

        closeWaitingDialog();

    };

    var _resetearValoresPopupMantenimientoCupon = function () {
        $(elements.hdCuponId).val("");
        $(elements.txtDescripcion).val("");
        $(elements.ddlTipoCupon + " option:first").attr('selected', 'selected');
        $(elements.contenedorCheckActivo).hide();
    };

    var _esValidoGuardarCupon = function () {
        if ($(elements.ddlTipoCupon).val().trim() == "") {
            alert('Debe seleccionar el tipo de cupón');
            return false;
        }

        if ($(elements.ddlCampania).val().trim() == "") {
            alert('Debe seleccionar una campaña');
            return false;
        }

        if ($(elements.txtDescripcion).val().trim() == "") {
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
            messsage += 'Debe seleccionar una campaña \n';
        }

        return (messsage.length <= 0);
    }

    var _showActionsEvento = function (cellvalue, options, rowObject) {

        var activar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').Activar(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Activar Cupón' title='Activar Cupón' border='0' /></a>";
        var desactivar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').Desactivar(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Desactivar Cupón' title='Desactivar Cupón' border='0' /></a>";
        var editar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').Editar(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Editar Cupón' title='Editar Cupón' border='0' /></a>";
        var verDetalle = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').VerDetalle(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Ver Detalle del Cupón' title='Ver Detalle del Cupón' border='0' /></a>";
        var resultado = "";

        if (rowObject.Estado) {
            resultado += editar;
            resultado += desactivar;
            resultado += verDetalle;
        } else {
            resultado += activar;
        }

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
            _atacharEventosDeExtension();
        } else {
            closeWaitingDialog();
            $(elements.contenedorGrillaCupones).hide();
        }
    };

    var _atacharEventosDeExtension = function () {
        $.jgrid.extend({
            Activar: function (cuponId, tipo, descripcion, estado) {
                waitingDialog({});

                var idTipo = (tipo.toUpperCase() == CONTANSTES_CUPON.NOMBRE_TIPO_MONTO ? CONTANSTES_CUPON.CODIGO_TIPO_MONTO : CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE);
                var cuponModel = {
                    cuponId: cuponId,
                    tipo: idTipo,
                    descripcion: descripcion,
                    campaniaId: $(elements.ddlCampania + " option:selected").val(),
                    estado: true
                };
                var actualizarCuponPromise = _actualizarCuponPromise(cuponModel);

                $.when(actualizarCuponPromise).then(function (actualizarCuponResponse) {
                    if (checkTimeout(actualizarCuponResponse)) {
                        if (actualizarCuponResponse.success) {
                            alert('El cupón fue activado.');
                            _listarCuponesPorCampania();
                        } else {
                            alert(actualizarCuponResponse.message);
                        }

                        closeWaitingDialog();
                    }
                });

                return false;
            },
            Desactivar: function (cuponId, tipo, descripcion, estado) {
                waitingDialog({});

                var idTipo = (tipo.toUpperCase() == CONTANSTES_CUPON.NOMBRE_TIPO_MONTO ? CONTANSTES_CUPON.CODIGO_TIPO_MONTO : CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE);
                var cuponModel = {
                    cuponId: cuponId,
                    tipo: idTipo,
                    descripcion: descripcion,
                    campaniaId: $(elements.ddlCampania + " option:selected").val(),
                    estado: false
                };
                var actualizarCuponPromise = _actualizarCuponPromise(cuponModel);

                $.when(actualizarCuponPromise).then(function (actualizarCuponResponse) {
                    if (checkTimeout(actualizarCuponResponse)) {
                        if (actualizarCuponResponse.success) {
                            alert('El cupón fue desactivado.');
                            _listarCuponesPorCampania();
                        } else {
                            alert(actualizarCuponResponse.message);
                        }

                        closeWaitingDialog();
                    }
                });

                return false;
            },
            Editar: function (cuponId, tipo, descripcion, estado) {
                _resetearValoresPopupMantenimientoCupon();
                _setearValoresEditarCupon(cuponId, tipo, descripcion, estado);
                showDialog(setting.popupMantenimientoCupon);
                return false;
            },
            VerDetalle: function (cuponId, tipo, descripcion) {
                waitingDialog({});
                var anioCampania = $(elements.ddlCampania + " option:selected").val();

                $(elements.spnCampania).html(anioCampania);
                $(elements.spnTipo).html(tipo);
                $(elements.spnDescripcion).html(descripcion);
                _listarCuponConsultoras(cuponId);
                _mostrarContenedorCuponConsultora();
                return false;
            }
        });
    };

    var _mostrarContenedorCuponConsultora = function () {
        $(elements.contenedorCupon).hide();
        $(elements.contenedorCuponConsultora).show();
    };

    var _mostrarContenedorCupon = function () {
        $(elements.contenedorCupon).show();
        $(elements.contenedorCuponConsultora).hide();
    };

    var _setearValoresEditarCupon = function (cuponId, tipo, descripcion, estado) {
        var activo = (estado.toLowerCase() == 'true');
        var idTipo = (tipo.toUpperCase() == CONTANSTES_CUPON.NOMBRE_TIPO_MONTO ? CONTANSTES_CUPON.CODIGO_TIPO_MONTO : CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE);

        $(elements.hdCuponId).val(cuponId);
        $(elements.ddlTipoCupon + ' option[value=' + idTipo + ']').prop('selected', true);
        $(elements.txtDescripcion).val(descripcion);
        $(elements.chckActivo).prop("checked", activo);
        $(elements.contenedorCheckActivo).show();
    };

    var _listarCuponConsultoras = function (cuponId) {
        jQuery(elements.tablaCuponConsultoras).jqGrid({
            url: setting.UrlListarCuponConsultorasPorCupon,
            hidegrid: false,
            datatype: 'json',
            postData: ({
                PaisID: function () { return $(elements.ddlPais).val() },
                CuponID: function () { return cuponId; }
            }),
            mtype: 'GET',
            contentType: "application/json; charset=utf-8",
            colNames: ['Tipo', 'Descripción', 'Creación', ''],
            colModel: [
                { name: 'Consultora', width: 50, editable: true, resizable: false },
                { name: 'Valor Asociado', width: 80, editable: true, resizable: false },
                { name: 'Estado', width: 80, editable: true, resizable: false },
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
                var cantidadRegistros = jQuery(elements.tablaCuponConsultoras).jqGrid('getGridParam', 'reccount');
                if (cantidadRegistros > 0) {
                    $(elements.contenedorGrillaCuponConsultoras).show();
                } else {
                    $(elements.contenedorGrillaCuponConsultoras).hide();
                }

                closeWaitingDialog();
            }
        });
        jQuery(elements.tablaCuponConsultoras).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery(elements.tablaCuponConsultoras).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        // _atacharEventosDeExtension();
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
    };

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
        setting.UrlListarCuponConsultorasPorCupon = parameters.urlListarCuponConsultorasPorCupon;
        setting.UrlImagenEdit = parameters.urlImagenEdit;

        _bindEvents();
        _inicializarDialogs();
    };

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();