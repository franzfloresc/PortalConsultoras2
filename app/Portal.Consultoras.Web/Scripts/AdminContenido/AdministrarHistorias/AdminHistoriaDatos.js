var admHistoriaDatos = (function () {
    'use strict';
    var _elemento = {
        TablaId: '#tblHistoriaDet',
        TablaPagina: '#pagerHistoriaDet',
        DialogRegistro: 'DialogMantenimientoHistoriaDatos',
        DialogRegistroHtml: '#dialog-content-historia-datos',
        DialogRegistroDatosHtml: '#dialog-content-palanca-datos #contenido-palanca-datos',
        BtnNuevo: '#btnCrearRegistro',
        DdlPalanca: '#ddlPalanca',
        DdlComponente: '#ddlComponente',
        DdlCampania: '#ddlCampania',
        DivFormulario: '#divMantDatos',
        ChbxEstado: '#Estado',
        PopupTitulo: '#divPalancaDatos_Titulo'
    }

    var _texto = {
        Cargando: 'Cargando datos...',
        RegistroPaginar: '{0} - {1} de {2} Registros',
        SinResultados: 'No hay resultados',
        TituloDialogRegistro: 'Editar',
        ProcesoError: 'Error al procesar la solicitud.',
        ProcesoConforme: 'Se procesó con éxito su solicitud.',
        PopupTituloNuevo: 'Nuevo Registro',
        PopupTituloEditar: 'Actualizar Registro'
    };

    var _url = {
        UrlGrilla: baseUrl + 'AdministrarHistorias/ComponenteListar?IdContenido=' + $('#IdContenido').val(),
        UrlGrillaEditar: baseUrl + 'AdministrarHistorias/ComponenteObtenerViewDatos',
        UrlComponenteDatosGuardar: baseUrl + 'AdministrarHistorias/ComponenteDatosGuardar'
    };

    var _accion = {
        Nuevo: 1,
        Editar: 2,
        NuevoDatos: 3,
        Deshabilitar: 4
    };

    var _tipoDato = {
        txt: 'txt',
        Img: 'img',
        checkbox: 'checkbox'
    }

    var _evento = function () {

        CargarGrilla();
        
    };

    var _GrillaAcciones = function (cellvalue, options, rowObject) {
        var act = "&nbsp;<a href='javascript:;' onclick=\'return admHistoriaDatos.Editar(event);\' >"
            + "<img src='" + rutaImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
        return act;
    };

    var _GrillaImagen = function (cellvalue, options, rowObject) {
        var act = "";
        if (cellvalue == "") {
            act = "<img src='" + rutaImagenVacia + "' border='0' style='max-width: 40px; max-height: 40px;' />";
        } else {
            act = "<img src='" + urlDetalleS3 + cellvalue + "' border='0' style='max-width: 40px; max-height: 40px;' />";
        }
       return act;
    };

    var CargarGrilla = function () {
        $(_elemento.TablaId).jqGrid('GridUnload');

        jQuery(_elemento.TablaId).jqGrid({
            url: _url.UrlGrilla,
            hidegrid: false,
            datatype: 'json',
            mtype: 'GET',
            contentType: 'application/json; charset=utf-8',
            multiselect: false,
            colNames: ['ID', 'Url', 'Orden', 'Imagen', 'IdContenido', 'Acción'],
            colModel: [
                {
                    name: 'IdContenidoDeta',
                    index: 'IdContenidoDeta',
                    width: 20,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'CodigoDetalle',
                    index: 'CodigoDetalle',
                    width: 100,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'Orden',
                    index: 'Orden',
                    width: 40,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'RutaContenido',
                    index: 'RutaContenido',
                    width: 40,
                    resizable: false,
                    sortable: false,
                    align: 'center',
                    formatter: _GrillaImagen
                },
                {
                    name: 'IdContenido',
                    index: 'IdContenido',
                    width: 40,
                    align: 'center',
                    resizable: false,
                    sortable: false,
                    hidden: true
                },
                {
                    name: 'Accion',
                    index: 'Accion',
                    width: 20,
                    align: 'center',
                    resizable: false,
                    sortable: false,
                    formatter: _GrillaAcciones
                },
               
            ],
            pager: jQuery(_elemento.TablaPagina),
            loadtext: _texto.Cargando,
            recordtext: _texto.RegistroPaginar,
            emptyrecords: _texto.SinResultados,
            rowNum: 20,
            scrollOffset: 0,
            rowList: [15, 20, 30, 40, 50],
            viewrecords: true,
            pgtext: 'Pág: {0} de {1}',
            sortname: 'Orden',
            sortorder: 'asc',
            height: 'auto',
            width: 930,
            altRows: true,
            altclass: 'jQGridAltRowClass'
        });
        jQuery(_elemento.TablaId).jqGrid('navGrid', _elemento.TablaPagina, { edit: false, add: false, refresh: false, del: false, search: false });
    };

    var GrillaEditar = function (event) {
       
        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaId).getRowData(rowId);
        //console.log("rowId",rowId);
        //console.log("row",row);
        //return;
        var entidad = {
            IdContenidoDeta: row['IdContenidoDeta'],
            IdContenido: row['IdContenido'],
            Accion: _accion.Editar
        };
        _RegistroObterner(entidad);
    }


    var _RegistroObterner = function (modelo) {

        //console.log(modelo);
        //return;
        waitingDialog();
        $.ajax({
            url: _url.UrlGrillaEditar,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                closeWaitingDialog();

                if (modelo.Accion === _accion.Deshabilitar) {
                    _toastHelper.success(_texto.ProcesoConforme);
                }
                else if (modelo.Accion === _accion.NuevoDatos) {
                    $(_elemento.DialogRegistroDatosHtml).empty();
                    $(_elemento.DialogRegistroDatosHtml).
                        html(result)
                        .ready(_RegistroObternerImagen());

                    $(_elemento.ChbxEstado).prop("checked", $(_elemento.DivFormulario).attr('data-estado') === "True");

                }
                else if (modelo.Accion === _accion.Editar) {
                    $(_elemento.DialogRegistroHtml).empty();
                    $(_elemento.DialogRegistroHtml)
                        .html(result)
                        .ready(_RegistroObternerImagen());

                    showDialog(_elemento.DialogRegistro);
                    $('body').css({ 'overflow-x': 'hidden' });
                    $('body').css({ 'overflow-y': 'hidden' });

                    $(_elemento.PopupTitulo).html(_texto.PopupTituloEditar);
                    $(_elemento.DdlPalanca).attr("disabled", "disabled");
                    $(_elemento.DdlComponente).attr("disabled", "disabled");
                    $(_elemento.DdlCampania).attr("disabled", "disabled");    
                }
                else {
                    $(_elemento.DialogRegistroHtml).empty();
                    $(_elemento.DialogRegistroHtml).html(result);
                    showDialog(_elemento.DialogRegistro);
                    $('body').css({ 'overflow-x': 'hidden' });
                    $('body').css({ 'overflow-y': 'hidden' });

                    $(_elemento.PopupTitulo).html(_texto.PopupTituloNuevo);
                    $(_elemento.ChbxEstado).prop("checked", true);
                }
            },
            error: function (request, status, error) {
                if (modelo.Accion === _accion.Deshabilitar) {
                    _toastHelper.error(_texto.ProcesoError);
                }
            }
        });
    };

     
    var _DialogCrear = function () {
        $('#' + _elemento.DialogRegistro).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 400,
            height: 200,
            close: function () {
                HideDialog(_elemento.DialogRegistro);
            },
            draggable: false,
            title: _texto.TituloDialogRegistro,
            open: function (event, ui) { },
            buttons:
            {
                'Guardar': function () {
                    _GuardarDatos(this);
                },
                'Salir': function () {
                    HideDialog(_elemento.DialogRegistro);
                }
            }
        });
    };

    var _GuardarDatos = function (dialog) {
        console.log("Guardar");
        var IdContenidoDeta = $('#IdContenidoDeta').val();
        var IdContenido = $('#IdContenido').val();
        var listaDatos = {
            IdContenidoDeta: IdContenidoDeta,
            IdContenido: IdContenido
        };

        jQuery.ajax({
            type: 'POST',
            url: _url.UrlComponenteDatosGuardar,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(listaDatos),
            async: true,
            success: function (data) {
                console.log(data);
                if (data.success) {
                    console.log("exito");
                    HideDialog(_elemento.DialogRegistro);
                    _toastHelper.success(_texto.ProcesoConforme);
                    $('#tblHistoriaDet').trigger('reloadGrid');
                    //CargarGrilla();
                }
                else {
                    _toastHelper.error(_texto.ProcesoError);
                }
            },
            error: function (data, error) {
                _toastHelper.error(_texto.ProcesoError);
            }
        });
    };

    var _initializar = function (param) {
        _evento();
        _DialogCrear();
    };

    return {
        ini: function (param) {
            _initializar(param);
        },
        Editar: GrillaEditar,
    };

})();
