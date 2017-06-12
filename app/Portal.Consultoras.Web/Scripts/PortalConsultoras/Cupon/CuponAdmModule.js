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
        btnMostrarPopupMantCuponConsultora: '#btnMostrarPopupMantCuponConsultora',
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        ddlTipoCupon: '#ddlTipoCupon',
        popupMantenimientoCupon: '#popup-mantenimiento-cupon',
        popupMantenimientoCuponConsultora: '#popup-mantenimiento-cupon-consultora',
        txtDescripcion: '#txtDescripcion',
        txtConsultora: '#txtConsultora',
        txtValorAsociado: '#txtValorAsociado',
        hdCuponId: '#hdCuponId',
        hdCuponConsultoraId: '#hdCuponConsultoraId',
        hdCuponIdCuponConsultora: '#hdCuponId-cupon-consultora',
        contenedorGrillaCupones: '#contenedor-grilla-cupones',
        contenedorGrillaCuponConsultoras: '#contenedor-grilla-cupon-consultoras',
        tablaCupones: '#tabla-cupones',
        tablaCuponConsultoras: '#tabla-cupon-consultoras',
        chckActivo: '#chckActivo',
        contenedorCheckActivo: '#contenedor-check-activo',
        contenedorCuponConsultora: '#contenedor-cupon-consultora',
        contenedorCupon: '#contenedor-cupon',
        spnCampania: '#spnCampania',
        spnTipo: '#spnTipo',
        spnDescripcion: '#spnDescripcion'
    };

    var setting = {
        UrlListarCampanias: '',
        UrlCrearCupon: '',
        UrlActualizarCupon: '',
        UrlCrearCuponConsultora: '',
        UrlActualizarCuponConsultora: '',
        UrlListarCuponesPorCampania: '',
        UrlListarCuponConsultorasPorCupon: '',
        popupMantenimientoCupon: 'popup-mantenimiento-cupon',
        popupMantenimientoCuponConsultora: 'popup-mantenimiento-cupon-consultora'
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
        _iniDialogMantenimientoCuponConsultora();
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
                "Guardar": function () {
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
                "Guardar": function () {
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
        });

        closeWaitingDialog();

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
        });

        closeWaitingDialog();

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

    var _showActionsEventoCupon = function (cellvalue, options, rowObject) {

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

    var _showActionsEventoCuponConsultora = function (cellvalue, options, rowObject) {

        var activar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCuponConsultoras + "').Activar(" + options.rowId + ", " + rowObject.CampaniaId + ", " + rowObject.CuponId + ", '" + rowObject.Consultora + "', '" + rowObject.ValorAsociado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Activar' title='Activar' border='0' /></a>";
        var desactivar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCuponConsultoras + "').Desactivar(" + options.rowId + ", " + rowObject.CampaniaId + ", " + rowObject.CuponId + ", '" + rowObject.Consultora + "', '" + rowObject.ValorAsociado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Desactivar' title='Desactivar' border='0' /></a>";
        var editar = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaCuponConsultoras + "').Editar(" + options.rowId + ", " + rowObject.CampaniaId + ", " + rowObject.CuponId + ", '" + rowObject.Consultora + "', '" + rowObject.ValorAsociado + "');\" >" + "<img src='" + setting.UrlImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
        var resultado = "";

        //if (rowObject.Estado) {
        //    resultado += editar;
        //    resultado += desactivar;
        //} else {
        //    resultado += activar;
        //}

        resultado += activar;
        resultado += desactivar;
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
            colNames: ['Tipo', 'Descripción', 'Creación', ''],
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
                var cantidadRegistros = jQuery(elements.tablaCupones).jqGrid('getGridParam', 'reccount');
                closeWaitingDialog();
            }
        });
        jQuery(elements.tablaCupones).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery(elements.tablaCupones).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        _atacharEventosDeExtensionCupon();
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
            VerDetalle: function (cuponId, tipo, descripcion) {
                waitingDialog({});
                var anioCampania = $(elements.ddlCampania + " option:selected").val();
                $(elements.contenedorGrillaCuponConsultoras).hide();
                $(elements.spnCampania).html(anioCampania);
                $(elements.spnTipo).html(tipo);
                $(elements.spnDescripcion).html(descripcion);
                $(elements.hdCuponIdCuponConsultora).val(cuponId);
                _listarCuponConsultoras(cuponId);
                _mostrarContenedorCuponConsultora();
                return false;
            }
        });
    };

    var _atacharEventosDeExtensionCuponConsultora = function () {
        $.jgrid.extend({
            Activar: function (cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado) {
                //waitingDialog({});

                //var idTipo = (tipo.toUpperCase() == CONTANSTES_CUPON.NOMBRE_TIPO_MONTO ? CONTANSTES_CUPON.CODIGO_TIPO_MONTO : CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE);
                //var cuponModel = {
                //    cuponId: cuponId,
                //    tipo: idTipo,
                //    descripcion: descripcion,
                //    campaniaId: $(elements.ddlCampania + " option:selected").val(),
                //    estado: true
                //};
                //var actualizarCuponPromise = _actualizarCuponPromise(cuponModel);

                //$.when(actualizarCuponPromise).then(function (actualizarCuponResponse) {
                //    if (checkTimeout(actualizarCuponResponse)) {
                //        if (actualizarCuponResponse.success) {
                //            alert('El cupón fue activado.');
                //            _listarCuponesPorCampania();
                //        } else {
                //            alert(actualizarCuponResponse.message);
                //        }

                //        closeWaitingDialog();
                //    }
                //});

                return false;
            },
            Desactivar: function (cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado) {
                //waitingDialog({});

                //var idTipo = (tipo.toUpperCase() == CONTANSTES_CUPON.NOMBRE_TIPO_MONTO ? CONTANSTES_CUPON.CODIGO_TIPO_MONTO : CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE);
                //var cuponModel = {
                //    cuponId: cuponId,
                //    tipo: idTipo,
                //    descripcion: descripcion,
                //    campaniaId: $(elements.ddlCampania + " option:selected").val(),
                //    estado: false
                //};
                //var actualizarCuponPromise = _actualizarCuponPromise(cuponModel);

                //$.when(actualizarCuponPromise).then(function (actualizarCuponResponse) {
                //    if (checkTimeout(actualizarCuponResponse)) {
                //        if (actualizarCuponResponse.success) {
                //            alert('El cupón fue desactivado.');
                //            _listarCuponesPorCampania();
                //        } else {
                //            alert(actualizarCuponResponse.message);
                //        }

                //        closeWaitingDialog();
                //    }
                //});

                return false;
            },
            Editar: function (cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado) {
                _resetearValoresPopupMantenimientoCuponConsultora();
                _setearValoresEditarCuponConsultora(cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado);
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

    var _setearValoresEditarCupon = function (cuponId, tipo, descripcion, estado) {
        var activo = (estado.toLowerCase() == 'true');
        var idTipo = (tipo.toUpperCase() == CONTANSTES_CUPON.NOMBRE_TIPO_MONTO ? CONTANSTES_CUPON.CODIGO_TIPO_MONTO : CONTANSTES_CUPON.CODIGO_TIPO_PORCENTAJE);

        $(elements.hdCuponId).val(cuponId);
        $(elements.ddlTipoCupon + ' option[value=' + idTipo + ']').prop('selected', true);
        $(elements.txtDescripcion).val(descripcion);
        $(elements.chckActivo).prop("checked", activo);
        $(elements.contenedorCheckActivo).show();
    };

    var _setearValoresEditarCuponConsultora = function (cuponConsultoraId, campaniaId, cuponId, consultora, valorAsociado) {
        $(elements.hdCuponConsultoraId).val(cuponConsultoraId);
        $(elements.txtConsultora).val(consultora);
        $(elements.txtValorAsociado).val(valorAsociado);
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
            colNames: ['Consultora', 'Valor Asociado', 'Estado', ''],
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
                var cantidadRegistros = jQuery(elements.tablaCuponConsultoras).jqGrid('getGridParam', 'reccount');
                $(elements.contenedorGrillaCuponConsultoras).show();
                closeWaitingDialog();
            }
        });
        jQuery(elements.tablaCuponConsultoras).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery(elements.tablaCuponConsultoras).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        _atacharEventosDeExtensionCuponConsultora();
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
        setting.UrlImagenEdit = parameters.urlImagenEdit;

        _bindEvents();
        _inicializarDialogs();
        _listarCuponesPorCampania();
    };

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();