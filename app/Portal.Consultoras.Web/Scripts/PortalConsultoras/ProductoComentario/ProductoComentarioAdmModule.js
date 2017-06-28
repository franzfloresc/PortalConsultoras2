﻿/// <reference path="../../jquery-1.11.2.js" />

var productoComentarioAdmModule = (function () {
    "use strict"

    var TIPO_PRODUCTO_COMENTARIO = {
        SAP: 1,
        CUV: 2
    };

    var ESTADO_PRODUCTO_COMENTARIO = {
        INGRESADO: 1,
        APROBADO: 2,
        RECHAZADO: 3
    };

    var elements = {
        ddlPais: '#ddlPais',
        ddlEstadoComentario: '#ddlEstadoComentario',
        ddlTipoComentario: '#ddlTipoComentario',
        divSAP: '#divSAP',
        txtSAP: '#txtSAP',
        divCUV: '#divCUV',
        ddlCampania: '#ddlCampania',
        txtCUV: '#txtCUV',
        divBuscarComentarios: '#divBuscarComentarios',
        btnBuscarComentarios: '#BuscarComentarios',
        divContenedorProductoComentario: '#contenedor-grilla-producto-comentario',
        tablaProductoComentario: '#tabla-producto-comentario',
        pagerProductoComentario: '#pager-producto-comentario'
    }

    var listaCampanias = [];

    var setting = {
        listarCampaniasUrl: '',
        listarProductoComentarioUrl: '',
        imagenEnableUrl: '',
        imagenDisableUrl: ''
    };

    var _bindEvents = function () {
        $(document).on('change', elements.ddlPais, function () {
            waitingDialog({});

            var paisId = $(elements.ddlPais).val();

            if (paisId == '') {
                $(elements.ddlCampania).empty();
                $(elements.ddlCampania).append($('<option/>', { value: "", text: "-- Seleccionar --" }));
                closeWaitingDialog();
                return;
            }

            if (listaCampanias.length == 0)
                _cargarCampaniasDesdeServicio(paisId);
            else
                _cargarCampanias();

            _validarMostrarContenedorBotonBuscarComentarios();

            closeWaitingDialog();
        });

        $(document).on('change', elements.ddlTipoComentario, function () {
            waitingDialog({});

            var tipoComentarioId = $(elements.ddlTipoComentario).val();

            if (TIPO_PRODUCTO_COMENTARIO.SAP == tipoComentarioId) {
                $(elements.divSAP).show();
                $(elements.divCUV).hide();
                $(elements.txtSAP).val('');
            }

            if (TIPO_PRODUCTO_COMENTARIO.CUV == tipoComentarioId) {
                $(elements.divSAP).hide();
                $(elements.divCUV).show();
                $(elements.txtCUV).val('');
            }

            _validarMostrarContenedorBotonBuscarComentarios();

            closeWaitingDialog();
        });

        $(document).on('keyup focus blur', elements.txtSAP, function () {
            _validarMostrarContenedorBotonBuscarComentarios();
        });

        $(document).on('keyup focus blur', elements.txtCUV, function () {
            _validarMostrarContenedorBotonBuscarComentarios();
        });

        $(document).on('click', elements.btnBuscarComentarios, function () {
            waitingDialog({});
            
            _listarProductoComentarios();
        });
    }

    var _cargarCampaniasDesdeServicio = function (paisId) {
        var listarCampaniasPromise = _listarCampaniasPromise(paisId);
        $.when(listarCampaniasPromise).then(function (campaniasResponse) {
            if (checkTimeout(campaniasResponse)) {
                listaCampanias = campaniasResponse.listaCampanias;
                _cargarCampanias();
            }
        });
    };

    var _listarCampaniasPromise = function (paisId) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'GET',
            url: (setting.listarCampaniasUrl),
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

    var _validarMostrarContenedorBotonBuscarComentarios = function () {
        var paisId = $(elements.ddlPais).val();
        var tipoComentarioId = $(elements.ddlTipoComentario).val();
        var codigoSAP = $.trim($(elements.txtSAP).val());
        var codigoCUV = $.trim($(elements.txtCUV).val());

        if (paisId != '' &&
            ((tipoComentarioId == TIPO_PRODUCTO_COMENTARIO.SAP && codigoSAP != '') ||
            (tipoComentarioId == TIPO_PRODUCTO_COMENTARIO.CUV && codigoCUV != ''))
            ) {
            $(elements.divBuscarComentarios).show();
        } else {
            $(elements.divBuscarComentarios).hide();
        }
    };

    var _listarProductoComentarios = function () {
        $(elements.tablaProductoComentario).jqGrid({
            url: setting.listarProductoComentarioUrl,
            hidegrid: false,
            datatype: 'json',
            postData: ({
                paisID: function () { return ($(elements.ddlPais).val() == '' ? '0' : $(elements.ddlPais).val()); },
                estadoComentarioID: function () { return ($(elements.ddlEstadoComentario).val() == '' ? '0' : $(elements.ddlEstadoComentario).val()); },
                tipoComentarioID: function () { return ($(elements.ddlTipoComentario).val() == '' ? "0" : $(elements.ddlTipoComentario).val()); },
                SAP: function () { return ($(elements.txtSAP).val() == '' ? '' : $(elements.txtSAP).val()); },
                campaniaID: function () { return ($(elements.ddlCampania).val() == '' ? "0" : $(elements.ddlCampania).val()); },
                CUV: function () { return ($(elements.txtCUV).val() == '' ? '' : $(elements.txtCUV).val()); }
            }),
            mtype: 'GET',
            contentType: "application/json; charset=utf-8",
            colNames: ['Nro', 'Consultora', 'Fecha', 'Valorización', 'Texto', 'Estado', 'Acciones'],
            colModel: [
                { name: 'Nro', width: 15, editable: false, resizable: false, align: 'center', sortable: false, label:"N°" },
                { name: 'Consultora', width: 35, editable: true, resizable: false, align: 'center', sortable: false },
                { name: 'Fecha', width: 35, editable: true, resizable: false, align: 'center', sortable: false },
                { name: 'Valorizacion', width: 35, editable: true, resizable: false, align: 'center', sortable: false, label: "Valorización" },
                { name: 'Texto',  editable: true, resizable: false, sortable: false },
                { name: 'Estado', width: 35, editable: true, resizable: false, sortable: false },
                { name: 'Acciones', width: 35, editable: true, resizable: false, sortable: false, align: 'center', formatter: _showActionsProductoComentario }
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
            pager: $(elements.pagerProductoComentario),
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
                var cantidadRegistros = $(elements.tablaProductoComentario).jqGrid('getGridParam', 'reccount');
                $(elements.divContenedorProductoComentario).show();
                closeWaitingDialog();
            }
        });
        $(elements.tablaProductoComentario).jqGrid('navGrid', elements.pagerProductoComentario, { edit: false, add: false, refresh: false, del: false, search: false });
        $(elements.tablaProductoComentario).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        _atacharEventosDeProductoComentario();
    };

    var _showActionsProductoComentario = function (cellvalue, options, rowObject) {

        var aprobarComentario = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaProductoComentario + "').AprobarComentario(" + options.rowId + ");\" >" + "<img src='" + setting.imagenEnableUrl + "' alt='Aprobar Comentario' title='Aprobar Comentario' border='0' /></a>";
        var rechazarComentario = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('" + elements.tablaProductoComentario + "').RechazarComentario(" + options.rowId + ");\" >" + "<img src='" + setting.imagenDisableUrl + "' alt='Rechazar Comentario' title='Rechazar Comentario' border='0' /></a>";
        var resultado = "";

        if (rowObject.IdEstado == ESTADO_PRODUCTO_COMENTARIO.INGRESADO) {
            resultado += aprobarComentario + ' ';
            resultado += rechazarComentario + ' ';
        }

        if (rowObject.IdEstado == ESTADO_PRODUCTO_COMENTARIO.APROBADO) {
            resultado += rechazarComentario + ' ';
        }

        if (rowObject.IdEstado == ESTADO_PRODUCTO_COMENTARIO.RECHAZADO) {
            resultado += aprobarComentario + ' ';
        }

        return resultado;
    }

    var _atacharEventosDeProductoComentario = function () {
        $.jgrid.extend({
            AprobarComentario: function ( comentarioId) {
                alert('AprobarComentario');
                return false;
            },
            RechazarComentario: function (comentarioId) {
                alert('RechazarComentario');
                return false;
            }
        });
    }

    var initializer = function (parameters) {
        setting.listarCampaniasUrl = parameters.listarCampaniasUrl;
        setting.listarProductoComentarioUrl = parameters.listarProductoComentarioUrl;
        setting.imagenEnableUrl = parameters.imagenEnableUrl;
        setting.imagenDisableUrl = parameters.imagenDisableUrl;
        //
        _bindEvents();
    };

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();