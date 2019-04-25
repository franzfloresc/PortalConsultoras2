var admHistoriaDatos = (function () {
    'use strict';
    var _elemento = {
        TablaId: '#tblHistoriaDet',
        TablaPagina: '#pagerHistoriaDet',
        DialogRegistro: 'DialogMantenimientoHistoriaDatos',
        DialogRegistroHtml: '#dialog-content-historia-datos',
        BtnNuevo: '#btnCrearRegistro',
        DdlComponente: '#ddlComponente',
        DdlCampania: '#ddlCampania',
        DivFormulario: '#divMantDatos',
        ChbxEstado: '#Estado',
        PopupTitulo: '#divPalancaDatos_Titulo',
        DialogImagen: 'DialogImagen',
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
        UrlGrillaVerImagen: baseUrl + 'AdministrarHistorias/ComponenteObtenerVerImagen',
        UrlComponenteDatosGuardar: baseUrl + 'AdministrarHistorias/ComponenteDatosGuardar'
    };

    var _accion = {
        Nuevo: 1,
        Editar: 2,
        NuevoDatos: 3,
        Deshabilitar: 4
    };

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
            //act = "<img src='" + urlDetalleS3 + cellvalue + "' border='0' style='max-width: 40px; max-height: 40px;' />";
            act = "<a href='javascript:;' onclick=\'return admHistoriaDatos.VerImagen(event, \"" + cellvalue + "\");\' >" + "<img src='" + urlDetalleS3 + cellvalue + "' border='0' style='max-width: 40px; max-height: 40px;' /></a>";
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
            colNames: ['ID', 'Tipo', 'Orden', 'Contenido', 'IdContenido', 'Acción'],
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
                    name: 'Tipo',
                    index: 'Tipo',
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

    var GrillaVerImagen = function (event, img) {
        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaId).getRowData(rowId);
        var entidad = {
            IdContenidoDeta: row['IdContenidoDeta'],
            IdContenido: row['IdContenido'],
            RutaImagen: img
        };
        _RegistroObtenerPopupImagen(entidad);
    }

    var _RegistroObtenerPopupImagen = function (modelo) {
        //console.log(modelo);
        //return;
        waitingDialog();
        $.ajax({
            url: _url.UrlGrillaVerImagen,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                closeWaitingDialog();
                console.log(result);
                //return;

                $("#dialog-content-imagen").empty();
                $("#dialog-content-imagen").html(result);

                showDialog(_elemento.DialogImagen);

            },
            error: function (request, status, error) {
                    _toastHelper.error(_texto.ProcesoError);
            }
        });
    };

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

                $(_elemento.DialogRegistroHtml).empty();
                $(_elemento.DialogRegistroHtml)
                    .html(result);

                showDialog(_elemento.DialogRegistro);
                
            },
            error: function (request, status, error) {
                    _toastHelper.error(_texto.ProcesoError);
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

    var _DialogImagen = function () {
        $('#DialogImagen').dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 'auto',
            height: 'auto',
            close: function () {
                HideDialog("DialogImagen");
            },
            draggable: false,
            title: "Imagen",
            open: function (event, ui) { },
            buttons:
            {
                //'Guardar': function () {
                //    // _GuardarDatos(this);
                //},
                'Salir': function () {
                    HideDialog("DialogImagen");
                }
            }
        });
    };

 
    var _initializar = function (param) {
        _evento();
        _DialogCrear();
        _DialogImagen();
    };

   
    return {
        ini: function (param) {
            _initializar(param);
        },
        Editar: GrillaEditar,
        VerImagen: GrillaVerImagen,
    };

})();
