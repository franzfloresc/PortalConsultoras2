var cuponAdmModule = (function () {
    "use strict"

    var CONTANSTES_CUPON = {
        CODIGO_TIPO_MONTO: 1,
        CODIGO_TIPO_PORCENTAJE: 2,
        NOMBRE_TIPO_MONTO: 'MONTO',
        NOMBRE_TIPO_PORCENTAJE: 'PORCENTAJE',
        ESTADO_CUPON_REGISTRADO: 1,
        ESTADO_CUPON_ACTIVADO: 2,
        ESTADO_CUPON_UTILIZADO: 3,
        NOMBRE_CUPON_REGISTRADO: 'REGISTRADO',
        NOMBRE_CUPON_ACTIVADO: 'ACTIVADO',
        NOMBRE_CUPON_UTILIZADO: 'UTILIZADO'
    };

    var elements = {
        btnMostrarPopupMantCupon: '#btnMostrarPopupMantCupon',
        btnRegresar: '#btnRegresar',
        btnCargarConsultoras: '#btnCargarConsultoras',
        btnMostrarPopupMantCuponConsultora: '#btnMostrarPopupMantCuponConsultora',
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        ddlTipoCupon: '#ddlTipoCupon',
        popupMantenimientoCupon: '#popup-mantenimiento-cupon',
        popupMantenimientoCuponConsultora: '#popup-mantenimiento-cupon-consultora',
        popupMantenimientoCargaCuponConsultora: '#popup-mantenimiento-carga-cupon-consultora',
        txtDescripcion: '#txtDescripcion',
        txtConsultora: '#txtConsultora',
        hdCuponId: '#hdCuponId',
        txtValorAsociado: '#txtValorAsociado',
        txtEstadoCuponConsultora: '#txtEstadoCuponConsultora',
        hdCuponConsultoraId: '#hdCuponConsultoraId',
        hdTipoIdCupon: '#hdTipoId-Cupon',
        hdCuponIdCuponConsultora: '#hdCuponId-cupon-consultora',
        hdCampaniaIdFrmCargaMasiva: '#hdCampaniaIdFrmCargaMasiva',
        hdCuponIdFrmCargaMasiva: '#hdCuponIdFrmCargaMasiva',
        contenedorGrillaCupones: '#contenedor-grilla-cupones',
        contenedorGrillaCuponConsultoras: '#contenedor-grilla-cupon-consultoras',
        tablaCupones: '#tabla-cupones',
        tablaCuponConsultoras: '#tabla-cupon-consultoras',
        chckActivo: '#chckActivo',
        contenedorCheckActivo: '#contenedor-check-activo',
        contenedorEstadoCuponConsultora: '#contenedor-estado-cupon-consultora',
        contenedorCuponConsultora: '#contenedor-cupon-consultora',
        contenedorCupon: '#contenedor-cupon',
        contenedorBotonCrearCupon: '#contenedor-boton-crear-cupon',
        spnCampania: '#spnCampania',
        spnTipo: '#spnTipo',
        spnDescripcion: '#spnDescripcion',
        frmCargarConsultora: '#frmCargarConsultora',
        flCuponConsultora: '#flCuponConsultora'
    };

    var setting = {
        UrlListarCampanias: '',
        UrlCrearCupon: '',
        UrlActualizarCupon: '',
        UrlCrearCuponConsultora: '',
        UrlActualizarCuponConsultora: '',
        UrlListarCuponesPorCampania: '',
        UrlListarCuponConsultorasPorCupon: '',
        contenedorMantenimientoCupon: 'contenedor-mantenimiento-Cupon',
        UrlCuponConsultoraCargaMasiva: '',
        UrlImagenEdit: '',
        UrlImagenDelete: '',
        UrlImagenDetail: '',
        UrlImagenEnable: '',
        UrlImagenDisable: '',
        popupMantenimientoCupon: 'popup-mantenimiento-cupon',
        popupMantenimientoCuponConsultora: 'popup-mantenimiento-cupon-consultora',
        popupMantenimientoCargaCuponConsultora: 'popup-mantenimiento-carga-cupon-consultora',
    };

    var listaCampanias = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnMostrarPopupMantCupon, function () {
            if (_esValidoCrearCupon()) {
                _resetearValoresPopupMantenimientoCupon();
                showDialog(setting.popupMantenimientoCupon);
            }
        });

        $(document).on("click", elements.btnMostrarPopupMantCuponConsultora, function () {
            _resetearValoresPopupMantenimientoCuponConsultora();
            showDialog(setting.popupMantenimientoCuponConsultora);
        });

        $(document).on("click", elements.btnRegresar, function () {
            _mostrarContenedorCupon();
            $(elements.hdCuponIdCuponConsultora).val("");
            $(elements.hdTipoIdCupon).val("");
            $(elements.hdCampaniaIdFrmCargaMasiva).val("");
            $(elements.hdCuponIdFrmCargaMasiva).val("");
            _listarCuponesPorCampania();
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

            _validarMostrarContenedorBotonCrearCupon();
            _listarCuponesPorCampania();
        });

        $(document).on("change", elements.ddlCampania, function () {
            waitingDialog({});

            _validarMostrarContenedorBotonCrearCupon();
            _listarCuponesPorCampania();
        });

        $(document).on("click", elements.btnCargarConsultoras, function () {
            $(elements.flCuponConsultora).val('');
            showDialog(setting.popupMantenimientoCargaCuponConsultora);
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

    var _inicializarDialogs = function () {
        _iniDialogMantenimientoCupon();
        _iniDialogMantenimientoCuponConsultora();
        _iniDialogMantenimientoCargaCuponConsultora();
    };

    var _iniDialogMantenimientoCupon = function () {
        var mantCuponDialog = $(elements.popupMantenimientoCupon).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 500,
            draggable: true,
            title: "Cupón",
            buttons:
            {
                "Grabar": function () {
                    if ($(elements.hdCuponId).val() == "") {
                        _guardarCupon(mantCuponDialog);
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

    var _iniDialogMantenimientoCuponConsultora = function () {
        var mantCuponConsultoraDialog = $(elements.popupMantenimientoCuponConsultora).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 500,
            draggable: true,
            title: "Consultora",
            buttons:
            {
                "Grabar": function () {
                    if ($(elements.hdCuponConsultoraId).val() == "") {
                        _guardarCuponConsultora(mantCuponConsultoraDialog);
                    } else {
                        _actualizarCuponConsultora(mantCuponConsultoraDialog);
                    }
                },
                "Cancelar": function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var _iniDialogMantenimientoCargaCuponConsultora = function () {
        $(elements.popupMantenimientoCargaCuponConsultora).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 500,
            draggable: true,
            title: "Carga",
            buttons:
            {
                "Grabar": function () {
                    _procesarCargaMasivaCuponConsultora();
                },
                "Cancelar": function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var _procesarCargaMasivaCuponConsultora = function () {
        if ($(elements.flCuponConsultora).val() == '') {
            alert('Debe seleccionar un archivo');
            return false;
        }

        $(elements.frmCargarConsultora).submit();
    };

    var _guardarCupon = function (mantCuponDialog) {
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

    var _guardarCuponConsultora = function (mantCuponConsultoraDialog) {
        if (!_esValidoGuardarCuponConsultora()) {
            return;
        }

        waitingDialog({});

        var cuponConsultoraModel = {
            campaniaId: $(elements.ddlCampania + " option:selected").val(),
            cuponId: $(elements.hdCuponIdCuponConsultora).val().trim(),
            codigoConsultora: $(elements.txtConsultora).val().trim(),
            valorAsociado: $(elements.txtValorAsociado).val().trim()
        };
        var crearCuponConsultoraPromise = _crearCuponConsultoraPromise(cuponConsultoraModel);

        $.when(crearCuponConsultoraPromise).then(function (crearCuponConsultoraResponse) {
            if (checkTimeout(crearCuponConsultoraResponse)) {
                if (crearCuponConsultoraResponse.success) {
                    alert(crearCuponConsultoraResponse.message);
                    _listarCuponConsultoras(cuponConsultoraModel.cuponId);
                    $(mantCuponConsultoraDialog).dialog('close');
                } else {
                    alert(crearCuponConsultoraResponse.message);
                }
            }

            closeWaitingDialog();
        });
    };

    var _actualizarCuponConsultora = function (mantCuponConsultoraDialog) {
        if (!_esValidoGuardarCuponConsultora()) {
            return;
        }

        waitingDialog({});

        var cuponConsultoraModel = {
            cuponConsultoraId: $(elements.hdCuponConsultoraId).val().trim(),
            campaniaId: $(elements.ddlCampania + " option:selected").val(),
            cuponId: $(elements.hdCuponIdCuponConsultora).val().trim(),
            codigoConsultora: $(elements.txtConsultora).val().trim(),
            valorAsociado: $(elements.txtValorAsociado).val().trim()
        };
        var actualizarCuponConsultoraPromise = _actualizarCuponConsultoraPromise(cuponConsultoraModel);

        $.when(actualizarCuponConsultoraPromise).then(function (actualizarCuponConsultoraResponse) {
            if (checkTimeout(actualizarCuponConsultoraResponse)) {
                if (actualizarCuponConsultoraResponse.success) {
                    alert(actualizarCuponConsultoraResponse.message);
                    _listarCuponConsultoras(cuponConsultoraModel.cuponId);
                    $(mantCuponConsultoraDialog).dialog('close');
                } else {
                    alert(actualizarCuponConsultoraResponse.message);
                }
            }

            closeWaitingDialog();
        });
    };

    var _resetearValoresPopupMantenimientoCupon = function () {
        $(elements.hdCuponId).val("");
        $(elements.txtDescripcion).val("");
        $(elements.ddlTipoCupon + " option:first").attr('selected', 'selected');
        $(elements.contenedorCheckActivo).hide();
    };

    var _resetearValoresPopupMantenimientoCuponConsultora = function () {
        $(elements.hdCuponConsultoraId).val("");
        $(elements.txtConsultora).val("");
        $(elements.txtValorAsociado).val("");
        $(elements.contenedorEstadoCuponConsultora).hide();
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

    var _esValidoGuardarCuponConsultora = function () {
        if ($(elements.ddlCampania).val().trim() == "") {
            alert('Debe seleccionar una campaña');
            return false;
        }

        if ($(elements.hdCuponIdCuponConsultora).val().trim() == "") {
            alert('Debe seleccionar un cupón');
            return false;
        }

        if ($(elements.txtConsultora).val().trim() == "") {
            alert('Debe ingresar la consultora');
            return false;
        }

        if ($(elements.txtValorAsociado).val().trim() == "") {
            alert('Debe ingresar el valor asociado');
            return false;
        }

        if (isNaN($(elements.txtValorAsociado).val())) {
            alert('El valor asociado debe ser numérico');
            return false;
        }

        if ($(elements.txtValorAsociado).val().trim() <= 0) {
            alert('El valor asociado sebe ser mayor a cero(0)');
            return false;
        }

        if ($(elements.hdTipoIdCupon).val().trim() == CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE && $(elements.txtValorAsociado).val().trim() > 100) {
            alert('El valor asociado no deber ser mayor a 100 para el tipo porcentaje');
            return false;
        }

        return true;
    };    

    var _showActionsEventoCupon = function (cellvalue, options, rowObject) {

        var activar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').Activar(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenEnable + "' alt='Activar Cupón' title='Activar Cupón' border='0' /></a>";
        var desactivar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').Desactivar(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenDisable + "' alt='Desactivar Cupón' title='Desactivar Cupón' border='0' /></a>";
        var editar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').Editar(" + options.rowId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Editar Cupón' title='Editar Cupón' border='0' /></a>";
        var verDetalle = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCupones + "').VerDetalle(" + options.rowId + ", " + rowObject.TipoId + ", '" + rowObject.Tipo + "', '" + rowObject.Descripcion + "');\" >" + "<img src='" + setting.UrlImagenDetail + "' alt='Ver Detalle del Cupón' title='Ver Detalle del Cupón' border='0' style=\"width: 18px; height: 18px;\"/></a>";
        var resultado = "";

        if (rowObject.Estado) {
            resultado += editar + ' ';
            resultado += desactivar + ' ';
            resultado += verDetalle;
        } else {
            resultado += activar;
        }

        return resultado;
    }

    var _showActionsEventoCuponConsultora = function (cellvalue, options, rowObject) {
        var editar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCuponConsultoras + "').Editar(" + options.rowId + ", " + rowObject.CampaniaId + ", " + rowObject.CuponId + ", '" + rowObject.Consultora + "', '" + rowObject.ValorAsociado + "', '" + rowObject.Estado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
        var resultado = "";

        resultado += editar;

        return resultado;
    }

    var _listarCuponesPorCampania = function () {
        jQuery(elements.tablaCupones).jqGrid({
            url: setting.UrlListarCuponesPorCampania,
            hidegrid: false,
            datatype: 'json',
            postData: ({
                PaisID: function () { return ($(elements.ddlPais).val() == '' ? '0' : $(elements.ddlPais).val()); },
                CampaniaID: function () { return ($(elements.ddlCampania).val() == '' ? "0" : $(elements.ddlCampania).val()); }
            }),
            mtype: 'GET',
            contentType: "application/json; charset=utf-8",
            colNames: ['Tipo', 'Descripción', 'Creación', 'Acción'],
            colModel: [
                { name: 'Tipo', width: 50, editable: true, resizable: false },
                { name: 'Descripcion', width: 80, editable: true, resizable: false },
                { name: 'FechaCreacion', width: 80, editable: true, resizable: false },
                { name: 'Options', width: 60, editable: true, sortable: false, align: 'center', resizable: false, formatter: _showActionsEventoCupon }
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
                closeWaitingDialog();
            }
        });
        jQuery(elements.tablaCupones).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery(elements.tablaCupones).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        _atacharEventosDeExtensionCupon();
    };

    var _listarCuponConsultoras = function (cuponId) {

        var existeJGridTablaCuponConsultoras = jQuery(elements.tablaCuponConsultoras).jqGrid("getGridParam", "postData") != undefined;
        if (existeJGridTablaCuponConsultoras) {
            var parametros = jQuery(elements.tablaCuponConsultoras).jqGrid("getGridParam", "postData");
            parametros.PaisID = function () { return $(elements.ddlPais).val() },
            parametros.CuponID = function () { return cuponId; }
        }

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
            colNames: ['Consultora', 'Valor Asociado', 'Estado', 'Acción'],
            colModel: [
                { name: 'Consultora', width: 50, editable: true, resizable: false },
                { name: 'ValorAsociado', width: 80, editable: true, resizable: false },
                { name: 'Estado', width: 80, editable: true, resizable: false },
                { name: 'Options', width: 60, editable: true, sortable: false, align: 'center', resizable: false, formatter: _showActionsEventoCuponConsultora }
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
                $(elements.contenedorGrillaCuponConsultoras).show();
                closeWaitingDialog();
            }
        });
        jQuery(elements.tablaCuponConsultoras).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery(elements.tablaCuponConsultoras).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        _atacharEventosDeExtensionCuponConsultora();
    };

    var _atacharEventosDeExtensionCupon = function () {
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
            VerDetalle: function (cuponId, tipoId, tipo, descripcion) {
                waitingDialog({});

                $(elements.contenedorGrillaCuponConsultoras).hide();
                _setearValoresDelContenedorCuponConsultora(cuponId, tipoId, tipo, descripcion);
                _listarCuponConsultoras(cuponId);
                _mostrarContenedorCuponConsultora();
                return false;
            }
        });
    };

    var _atacharEventosDeExtensionCuponConsultora = function () {
        $.jgrid.extend({
            Editar: function (cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado, estado) {
                _resetearValoresPopupMantenimientoCuponConsultora();
                _setearValoresEditarCuponConsultora(cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado, estado);
                showDialog(setting.popupMantenimientoCuponConsultora);
                return false;
            },
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

    var _validarMostrarContenedorBotonCrearCupon = function () {
        if ($(elements.ddlPais).val() != '' && $(elements.ddlCampania).val() != '') {
            $(elements.contenedorBotonCrearCupon).show();
        } else {
            $(elements.contenedorBotonCrearCupon).hide();
        }
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

    var _setearValoresEditarCuponConsultora = function (cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado, estado) {
        $(elements.hdCuponConsultoraId).val(cuponConsultoraId);
        $(elements.txtConsultora).val(consultora);
        $(elements.txtValorAsociado).val(valorAsociado);
        $(elements.txtEstadoCuponConsultora).val(estado);
        $(elements.contenedorEstadoCuponConsultora).show();
    };

    var _setearValoresDelContenedorCuponConsultora = function (cuponId, tipoId, tipo, descripcion) {
        var anioCampania = $(elements.ddlCampania + " option:selected").val();

        $(elements.spnCampania).html(anioCampania);
        $(elements.spnTipo).html(tipo);
        $(elements.spnDescripcion).html(descripcion);
        $(elements.hdCuponIdCuponConsultora).val(cuponId);
        $(elements.hdTipoIdCupon).val(tipoId);
        $(elements.hdCampaniaIdFrmCargaMasiva).val(anioCampania);
        $(elements.hdCuponIdFrmCargaMasiva).val(cuponId);
    };

    var _loadAjaxForms = function () {
        $(elements.frmCargarConsultora).ajaxForm({
            beforeSubmit: function () {
                waitingDialog({});

                var fileValue = $(elements.flCuponConsultora).val();
                var extensiones = ['csv'];
                var get_ext;
                var message = '';

                get_ext = fileValue.split('.');
                get_ext = get_ext.reverse();

                if ($.inArray(get_ext[0].toLowerCase(), extensiones) == -1 && fileValue.length > 0)
                    message = message + '- El tipo de archivo es inválido, asegúrese de seleccionar con extensión (csv).';

                if (message.length > 0) {
                    closeWaitingDialog();
                    alert(message);
                    return false;
                }
            },
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        _listarCuponConsultoras($(elements.hdCuponIdFrmCargaMasiva).val());
                        alert(response.message);
                        $(elements.popupMantenimientoCargaCuponConsultora).dialog('close');
                    } else {
                        alert(response.message);
                    }
                }

                closeWaitingDialog();
            }
        });
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

    var _listarCampaniasPromise = function (paisId) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'GET',
            url: (setting.UrlListarCampanias),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
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

    var _crearCuponConsultoraPromise = function (cuponConsultoraModel) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: (setting.UrlCrearCuponConsultora),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(cuponConsultoraModel),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    var _actualizarCuponConsultoraPromise = function (cuponConsultoraModel) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: (setting.UrlActualizarCuponConsultora),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(cuponConsultoraModel),
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
        setting.UrlCrearCuponConsultora = parameters.urlCrearCuponConsultora;
        setting.UrlActualizarCuponConsultora = parameters.urlActualizarCuponConsultora;
        setting.UrlListarCuponesPorCampania = parameters.urlListarCuponesPorCampania;
        setting.UrlListarCuponConsultorasPorCupon = parameters.urlListarCuponConsultorasPorCupon;
        setting.UrlCuponConsultoraCargaMasiva = parameters.urlCuponConsultoraCargaMasiva;
        setting.UrlImagenEdit = parameters.urlImagenEdit;
        setting.UrlImagenDelete = parameters.urlImagenDelete;
        setting.UrlImagenDetail = parameters.urlImagenDetail;
        setting.UrlImagenEnable = parameters.urlImagenEnable;
        setting.UrlImagenDisable = parameters.urlImagenDisable;

        _bindEvents();
        _inicializarDialogs();
        _loadAjaxForms();
        _iniDialogMantenimientoCupon();
    };

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();