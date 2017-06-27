/// <reference path="../../jquery-1.11.2.js" />

var productoComentarioAdmModule = (function () {
    "use strict"

    var TIPO_PRODUCTO_COMENTARIO =  {
        SAP: 1,
        CUV: 2
    };

    var ESTADO_PRODUCTO_COMENTARIO = {
        INGRESADO : 1,
        APROBADO : 2,
        RECHAZADO : 3
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
        tablaProductoComentario: '#tabla-producto-comentario',
    }

    var listaCampanias = [];

    var setting = {
        listarCampaniasUrl: '',
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
            alert(elements.btnBuscarComentarios);
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
        var codigoSAP= $.trim($(elements.txtSAP).val());
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

    var _listarComentarios = function () {
        jQuery(elements.tablaProductoComentario).jqGrid({
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
                var cantidadRegistros = jQuery(elements.tablaCupones).jqGrid('getGridParam', 'reccount');
                closeWaitingDialog();
            }
        });
        jQuery(elements.tablaCupones).jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery(elements.tablaCupones).setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
        _atacharEventosDeExtensionCupon();
    };

    var initializer = function (parameters) {
        setting.listarCampaniasUrl = parameters.listarCampaniasUrl;
        _bindEvents();
        //_inicializarDialogs();
        //_loadAjaxForms();
        //_iniDialogMantenimientoCupon();
        //_listarCuponesPorCampania();
    };

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();