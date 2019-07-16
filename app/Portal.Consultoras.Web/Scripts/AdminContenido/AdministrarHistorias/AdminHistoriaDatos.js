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
        TablaVideoId: '#tblVideoDet',
        TablaVideoPagina: '#pagerVideoDet',
        DialogVideoEliminar: 'DialogMantenimientoVideoEliminar',
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
        UrlGrilla: baseUrl + 'AdministrarHistorias/ComponenteListar',
        UrlGrillaEditar: baseUrl + 'AdministrarHistorias/ComponenteObtenerViewDatos',
        UrlGrillaVerImagen: baseUrl + 'AdministrarHistorias/ComponenteObtenerVerImagen',
        UrlComponenteDatosGuardar: baseUrl + 'AdministrarHistorias/ComponenteDatosGuardar',
        UrlGrillaEditarContenedor: baseUrl + 'AdministrarHistorias/ComponenteDetalleEditarViewDatos',
        UrlVideoGrilla: baseUrl + 'AdministrarHistorias/ComponenteVideoListar',
        UrlContenidoApp: baseUrl + 'AdministrarHistorias/GetContenidoApp',
        UrlGrillaEditarVideo: baseUrl + 'AdministrarHistorias/GetViewEditarVideo',
        UrlComponenteVideoEliminar: baseUrl + 'AdministrarHistorias/ComponenteVideoEliminar',
        UrlComponenteVideoEliminarProceso: baseUrl + 'AdministrarHistorias/ComponenteVideoEliminarProceso',
    };

    var _accion = {
        Nuevo: 1,
        Editar: 2,
        NuevoDatos: 3,
        Deshabilitar: 4
    };
    var _variables= {
        VerMas: 'VER_MAS',
        AgrCar: 'AGR_CAR',
    };

    var _evento = function () {
        CargarGrilla();
        CargarGrillaVideo();
        OcultarTab();
        
    
    };

    
    var _GrillaAcciones = function (cellvalue, options, rowObject) {
        var act = "&nbsp;<a href='javascript:;' onclick=\'return admHistoriaDatos.EditarContenedor(event);\' >"
            + "<img src='" + rutaImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
       
        act  += "&nbsp;<a href='javascript:;' onclick=\'return admHistoriaDatos.Editar(event);\' >"
            + "<img src='" + rutaImagenDelete + "' alt='Eliminar' title='Eliminar' border='0' /></a>";
        return act;
    };

    var _GrillaImagen = function (cellvalue, options, rowObject) {
        var act = "";

        if (cellvalue == "") {
            act = "<img src='" + rutaImagenVacia + "' border='0' style='max-width: 40px; max-height: 40px;' />";
        } else {
            act = "<a href='javascript:;' onclick=\'return admHistoriaDatos.VerImagen(event, \"" + cellvalue + "\");\' >" + "<img src='" + urlDetalleS3 + cellvalue + "' border='0' style='max-width: 40px; max-height: 40px;' /></a>";
        }
        return act;
    };
    var _GrillaUrlVideo = function (cellvalue, options, rowObject) {
        var act = "";
        //alert(cellvalue)
        if (cellvalue == null) {
            act = "";
        } else {
            act = '<a href="' + UrlVideoS3 + cellvalue +'" target = "_blank">' + cellvalue + '</a>';
        }
        return act;
    };

    var _GrillaDetaCodigo = function (cellvalue, options, rowObject) {      
        var act = "";
        if (cellvalue != null) {
            if (cellvalue == _variables.VerMas) {
                act = "<strong>" + rowObject[10] +"</strong>";
                if (rowObject[11] != null) {
                   act += " - " + rowObject[11];
                }
            } else if (cellvalue == _variables.AgrCar) {
                act = "<strong>" + rowObject[10] + "</strong>";
                if (rowObject[8] != null) {
                   act += " - " + rowObject[8];
                }
            }
        }
        return act;
    };

    $("#ddlCampania").change(function () {
        $(_elemento.TablaId).trigger('reloadGrid');
    })

    var CargarGrilla = function () {
        $(_elemento.TablaId).jqGrid('GridUnload');

        jQuery(_elemento.TablaId).jqGrid({
            autowidth: true,
            url: _url.UrlGrilla,
            hidegrid: false,
            datatype: 'json',
            postData: ({
                IdContenido: function () { return jQuery.trim($("#IdContenido").val()); },
                Campania: function () { return jQuery.trim($("#ddlCampania").val()); },
                Codigo: function () { return jQuery.trim($("#Codigo").val()); }
            }),           
            mtype: 'GET',
            contentType: 'application/json; charset=utf-8',
            multiselect: false,
            colNames: ['ID', 'Tipo', 'Orden', 'IdContenido', 'Campaña', 'Zona', 'Seccion', 'AccionHidden', 'CodigoDetalle', 'Acción', 'DetaAccionDescripcion', 'DetaCodigoDetalleDescripcion', 'Contenido',  'Opciones'],
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
                    width: 20,
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
                { name: 'IdContenido', index: 'IdContenido', hidden: true },
                { name: 'Campania', index: 'Campania', width: 40, align: 'center', resizable: false, sortable: false},
                { name: 'Zona', index: 'Zona', hidden: true },
                { name: 'Seccion', index: 'Seccion', hidden: true },
                { name: 'Accion', index: 'Accion', hidden: true },
                { name: 'CodigoDetalle', index: 'CodigoDetalle', hidden: true },
                { name: 'DetaCodigo', index: 'DetaCodigo', resizable: false, sortable: false, formatter: _GrillaDetaCodigo },
                { name: 'DetaAccionDescripcion', index: 'DetaAccionDescripcion', hidden: true },
                { name: 'DetaCodigoDetalleDescripcion', index: 'DetaCodigoDetalleDescripcion', hidden: true },
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
                    name: 'Opciones',
                    index: 'Opciones',
                    width: 30,
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
            rowNum: 15,
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

        waitingDialog();
        $.ajax({
            url: _url.UrlGrillaVerImagen,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                closeWaitingDialog();

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
            title: "Eliminar",
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

        $('#' + _elemento.DialogVideoEliminar).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 400,
            height: 200,
            close: function () {
                HideDialog(_elemento.DialogVideoEliminar);
            },
            draggable: false,
            title: "Eliminar",
            open: function (event, ui) { },
            buttons:
            {
                'Guardar': function () {
                    var IdContenidoDeta = $('#IdContenidoDetaVideoElim').val();
                    var IdContenido = $('#IdContenidoVideoElim').val();
                    var param = {
                        IdContenidoDeta: IdContenidoDeta,
                        IdContenido: IdContenido
                    };

                    jQuery.ajax({
                        type: 'POST',
                        url: _url.UrlComponenteVideoEliminarProceso,
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify(param),
                        async: true,
                        success: function (data) {
                            if (data.success) {
                                if (data.message == 1) {
                                    HideDialog("DialogMantenimientoVideoEliminar");
                                    _toastHelper.success(_texto.ProcesoConforme);
                                    $('#tblVideoDet').trigger('reloadGrid');
                                }                               

                            } else {
                                _toastHelper.error(_texto.ProcesoError);
                            }

                        },
                        error: function (data, error) {
                            _toastHelper.error(_texto.ProcesoError);
                        }
                    });
                },
                'Salir': function () {
                    HideDialog(_elemento.DialogVideoEliminar);
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
 
                if (data.success) {
   
                    HideDialog(_elemento.DialogRegistro);
                    _toastHelper.success(_texto.ProcesoConforme);
                    $(_elemento.TablaId).trigger('reloadGrid');
    
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
            width: 800,
            height: 570,
            close: function () {
                HideDialog("DialogImagen");
            },
            draggable: false,
            title: "Imagen",
            open: function (event, ui) { },
            buttons:
            {
                'Salir': function () {
                    HideDialog("DialogImagen");
                }
            }
        });
    };
   
    var GrillaEditarContenedor = function (event) {

        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaId).getRowData(rowId);

        var entidad = {
            Proc: 2,
            IdContenidoDeta: row['IdContenidoDeta'],
            IdContenido: row['IdContenido'],
            Campania: row['Campania'],
            Zona: row['Zona'],
            Seccion: row['Seccion'],
            Accion: row['Accion'],
            CodigoDetalle: row['CodigoDetalle'],
        };
        _RegistroObternerDetalle(entidad);
    }
    var _RegistroObternerDetalle = function (modelo) {
 
        waitingDialog();
        $.ajax({
            url: _url.UrlGrillaEditarContenedor,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {

                closeWaitingDialog();

                $("#dialog-content-detalle").empty();
                $("#dialog-content-detalle").html(result).ready(function () {
                   // UploadFileDetalle("desktop-detalle");
                });
                $('#DialogMantenimientoDetalle').dialog('option', 'title', "Editar");
                showDialog("DialogMantenimientoDetalle");

            },
            error: function (request, status, error) { closeWaitingDialog(); _toastHelper.error("Error al cargar la ventana."); }
        });
    };

    var CargarGrillaVideo = function () {

        $(_elemento.TablaVideoId).jqGrid('GridUnload');

        jQuery(_elemento.TablaVideoId).jqGrid({
            autowidth: true,
            url: _url.UrlVideoGrilla,
            hidegrid: false,
            datatype: 'json',
            mtype: 'GET',
            contentType: 'application/json; charset=utf-8',
            multiselect: false,
            colNames: ['ID', 'Tipo', 'Orden', 'IdContenido', 'Campaña', 'ContenidoHidden', 'Contenido', 'Opciones'],
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
                    width: 20,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'Orden',
                    index: 'Orden',
                    width: 10,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                { name: 'IdContenido', index: 'IdContenido', hidden: true },
                { name: 'Campania', index: 'Campania', width: 40, align: 'center', resizable: false, sortable: false },
                {
                    name: 'RutaContenido',
                    index: 'RutaContenido',
                    width: 50,
                    resizable: false,
                    sortable: false,
                    align: 'center',
                    hidden: true
                },
                {
                    name: 'RutaContenidoUrl',
                    index: 'RutaContenidoUrl',
                    width: 50,
                    resizable: false,
                    sortable: false,
                    align: 'center',
                    formatter: _GrillaUrlVideo
                    
                },
                {
                    name: 'Opciones',
                    index: 'Opciones',
                    width: 30,
                    align: 'center',
                    resizable: false,
                    sortable: false,
                    formatter: _GrillaAccionesVideo
                },
            ],
            pager: jQuery(_elemento.TablaVideoPagina),
            loadtext: _texto.Cargando,
            recordtext: _texto.RegistroPaginar,
            emptyrecords: _texto.SinResultados,
            rowNum: 15,
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
        jQuery(_elemento.TablaVideoId).jqGrid('navGrid', _elemento.TablaVideoPagina, { edit: false, add: false, refresh: false, del: false, search: false });
    };

    var OcultarTab = function () {
        $(".contenido_tab").hide();
        $("ul.tabs li:first").addClass("activa").show();
        $(".contenido_tab:first").show();

        $("ul.tabs li").click(function () {
            $("ul.tabs li").removeClass("activa"); 
            $(this).addClass("activa"); 
            $(".contenido_tab").hide();
            var activatab = $(this).find("a").attr("href"); 
            $(activatab).fadeIn();
            return false;
        });
    }

    var _GrillaAccionesVideo = function (cellvalue, options, rowObject) {
        var act = "&nbsp;<a href='javascript:;' onclick=\'return admHistoriaDatos.EditarContenedorVideo(event);\' >"
            + "<img src='" + rutaImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";

        act += "&nbsp;<a href='javascript:;' onclick=\'return admHistoriaDatos.EliminarContenedorVideo(event);\' >"
            + "<img src='" + rutaImagenDelete + "' alt='Eliminar' title='Eliminar' border='0' /></a>";
        return act;
    };

    var GrillaEditarContenedorVideo = function (event) {

        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaVideoId).getRowData(rowId);

        var entidad = {
            IdContenidoDeta: row['IdContenidoDeta'],
            IdContenido: row['IdContenido'],
            Campania: row['Campania'],
            RutaContenido: row['RutaContenido']
        };
        _RegistroObternerVideo(entidad);
    }

    var _RegistroObternerVideo = function (modelo) {

        waitingDialog();
        $.ajax({
            url: _url.UrlGrillaEditarVideo,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {

                closeWaitingDialog();

                $("#dialog-content-video").empty();
                $("#dialog-content-video").html(result).ready(function () {
                });
                $('#DialogMantenimientoVideo').dialog('option', 'title', "Editar");
                showDialog("DialogMantenimientoVideo");

            },
            error: function (request, status, error) { closeWaitingDialog(); _toastHelper.error("Error al cargar la ventana."); }
        });
    };

    var GrillaEliminarContenedorVideo = function (event) {

        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaVideoId).getRowData(rowId);
 
        var modelo = {
            IdContenidoDeta: row['IdContenidoDeta'],
            IdContenido: row['IdContenido'],
        };

        waitingDialog();
        $.ajax({
            url: _url.UrlComponenteVideoEliminar,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                closeWaitingDialog();
                $("#dialog-content-video-eliminar").empty();
                $("#dialog-content-video-eliminar").html(result).ready(function () {
                });

              showDialog(_elemento.DialogVideoEliminar);

            },
            error: function (request, status, error) {
                _toastHelper.error(_texto.ProcesoError);
            }
        });
    }

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
        EditarContenedor: GrillaEditarContenedor,
        EditarContenedorVideo: GrillaEditarContenedorVideo,
        EliminarContenedorVideo: GrillaEliminarContenedorVideo
    };

})();
