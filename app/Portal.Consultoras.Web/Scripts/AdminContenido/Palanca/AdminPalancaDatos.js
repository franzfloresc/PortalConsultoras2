var admPalancaDatos = (function () {
    'use strict'

    var _elemento = {
        TablaId: '#tblPalanca',
        TablaPagina: '#pagerPalanca',
        DialogRegistro: 'DialogMantenimientoPalancaDatos',
        DialogRegistroHtml: '#dialog-content-palanca-datos',
        DialogRegistroDatosHtml: '#dialog-content-palanca-datos #contenido-palanca-datos',
        BtnNuevo: '#btnCrearRegistro',
        DdlPalanca: '#ddlPalanca',
        DdlComponente: '#ddlComponente',
        DdlCampania: '#ddlCampania',
        DivFormulario: '#divMantDatos'
    }

    var _texto = {
        Cargando: 'Cargando datos...',
        RegistroPaginar: '{0} - {1} de {2} Registros',
        SinResultados: 'No hay resultados',
        TituloDialogRegistro: 'Configuración de Palanca',
        ProcesoError: 'Error al procesar la Solicitud.',
        ProcesoConforme: 'se proceso con exito su solicitud.'
    };

    var _url = {
        UrlGrilla: baseUrl + 'AdministrarPalanca/ComponenteListar',
        UrlGrillaEditar: baseUrl + 'AdministrarPalanca/ComponenteObtenerViewDatos',
        UrlComponentePorPalanca: baseUrl + 'AdministrarPalanca/ComponentePorPalanca',
        UrlComponenteDatosPorPalancaCampania: baseUrl + 'AdministrarPalanca/ComponenteDatosPorPalancaCampania',
        UrlComponenteDatosGuardar: baseUrl + 'AdministrarPalanca/ComponenteDatosGuardar'
    };

    var _accion = {
        Nuevo: 1,
        Editar: 2,
        NuevoDatos: 3,
        Deshabilitar: 4
    };

    var _tipoDato = {
        txt: 'txt',
        Img: 'img'
    }

    var _evento = function () {

        CargarGrilla();

        $('body').on('click', _elemento.BtnNuevo, function () {
            CrearRegistro();
        });

        $('body').on('change', _elemento.DdlPalanca, function () {
            _CargarComponente();
        });

        $('body').on('change', _elemento.DdlComponente, function () {
            _CargarDatos();
        });

        $('body').on('change', _elemento.DdlCampania, function () {
            _CargarDatos();
        });

    };

    var _GrillaAcciones = function (cellvalue, options, rowObject) {
        var act = "&nbsp;<a href='javascript:;' onclick=\'return admPalancaDatos.Editar(event);\' >"
            + "<img src='" + rutaImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
        var elim = "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return admPalancaDatos.Deshabilitar(event);\" >"
            + "<img src='" + rutaImagenDelete + "' alt='Deshabilitar' title='Deshabilitar' border='0' /></a>";
        return act + elim;
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
            colNames: ['ID', 'Campaña', 'Código', 'Nombre de Palanca', 'ComponenteCodigo', 'Componente', 'Acción'],
            colModel: [
                {
                    name: 'ConfiguracionPaisID',
                    index: 'ConfiguracionPaisID',
                    hidden: true
                },
                {
                    name: 'CampaniaID',
                    index: 'CampaniaID',
                    width: 40,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'PalancaCodigo',
                    index: 'PalancaCodigo',
                    width: 40,
                    align: 'center',
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'Descripcion',
                    index: 'Descripcion',
                    width: 280,
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'Componente',
                    index: 'Componente',
                    hidden: true
                },
                {
                    name: 'Nombre',
                    index: 'Nombre',
                    width: 280,
                    resizable: false,
                    sortable: false
                },
                {
                    name: 'Activo',
                    index: 'Activo',
                    width: 30,
                    align: 'center',
                    resizable: false,
                    sortable: false,
                    formatter: _GrillaAcciones
                }
            ],
            pager: false,
            loadtext: _texto.Cargando,
            recordtext: _texto.RegistroPaginar,
            emptyrecords: _texto.SinResultados,
            rowNum: 15,
            scrollOffset: 0,
            sortname: 'Orden',
            sortorder: 'asc',
            height: 'auto',
            width: 930,
            altRows: true,
            altclass: 'jQGridAltRowClass',
            pgbuttons: false,
            viewrecords: false,
            pgtext: '',
            pginput: false
        });
        jQuery(_elemento.TablaId).jqGrid('navGrid', _elemento.TablaPagina, { edit: false, add: false, refresh: false, del: false, search: false });
    };

    var GrillaEditar = function (event) {
        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaId).getRowData(rowId);

        var entidad = {
            ConfiguracionPaisID: row['ConfiguracionPaisID'],
            PalancaCodigo: row['PalancaCodigo'],
            Codigo: row['Componente'],
            CampaniaID: row['CampaniaID'],
            Accion: _accion.Editar
        };

        _RegistroObterner(entidad);
    }

    var GrillaDeshabilitar = function () {
        var rowId = $(event.path[1]).parents('tr').attr('id');
        var row = jQuery(_elemento.TablaId).getRowData(rowId);

        var entidad = {
            ConfiguracionPaisID: row['ConfiguracionPaisID'],
            PalancaCodigo: row['PalancaCodigo'],
            Codigo: row['Componente'],
            CampaniaID: row['CampaniaID'],
            Accion: _accion.Deshabilitar
        };

        _RegistroObterner(entidad);
    }

    var CrearRegistro = function () {
        var entidad = {
            PalancaCodigo: '',
            Accion: _accion.Nuevo
        };
        _RegistroObterner(entidad);
    };

    var _RegistroObterner = function (modelo) {
        modelo = modelo || {};
        $.ajax({
            url: _url.UrlGrillaEditar,
            type: 'GET',
            dataType: 'html',
            data: modelo,
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                if (modelo.Accion === _accion.Deshabilitar) {
                    _toastHelper.success(_texto.ProcesoConforme);
                }
                else if (modelo.Accion === _accion.NuevoDatos) {
                    $(_elemento.DialogRegistroDatosHtml).empty();
                    $(_elemento.DialogRegistroDatosHtml).
                        html(result)
                        .ready(_RegistroObternerImagen(this));
                }
                else if (modelo.Accion === _accion.Editar) {
                    $(_elemento.DialogRegistroHtml).empty();
                    $(_elemento.DialogRegistroHtml)
                        .html(result)
                        .ready(_RegistroObternerImagen(this));
                    showDialog(_elemento.DialogRegistro);
                }
                else {
                    $(_elemento.DialogRegistroHtml).empty();
                    $(_elemento.DialogRegistroHtml).html(result)
                    showDialog(_elemento.DialogRegistro);
                }
            },
            error: function (request, status, error) {
                if (modelo.Accion === _accion.Deshabilitar) {
                    _toastHelper.error(_texto.ProcesoError);
                }
            }
        });
    };

    var _RegistroObternerImagen = function () {
        var frmDatos = $(_elemento.DivFormulario);
        if (frmDatos.length == 0) {
            return false;
        }
        var listaFrmDatos = frmDatos.find("div[data-tipodato='img']");
        if (listaFrmDatos.length == 0) {
            return false;
        }

        $.each(listaFrmDatos, function (ind, datox) {
            var idConca = $.trim($(datox).attr('id')).split('-');
            if (idConca.length != 4) {
                return false;
            }
            var codigoDato = $.trim(idConca[3]);
            if (codigoDato != "") {
                UploadFilePalanca(codigoDato);
            }
        });
    };

    var _CargarComponente = function () {

        var params = {
            Codigo: $(_elemento.DdlPalanca).val()
        };

        jQuery.ajax({
            type: 'POST',
            url: _url.UrlComponentePorPalanca,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                if (data.success) {
                    if (data.ListaComponente) {
                        $(_elemento.DdlComponente + ' option').remove();
                        $(_elemento.DdlComponente).html("<option value=''>-- Seleccionar --</option>");
                        $.each(data.ListaComponente, function (ind, comp) {
                            var opt = document.createElement('option');
                            opt.value = comp.Codigo;
                            opt.innerHTML = comp.Nombre;
                            $(_elemento.DdlComponente).append(opt);
                        });
                    }
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

    var _CargarDatos = function () {

        var params = {
            PalancaCodigo: $(_elemento.DdlPalanca).val(),
            Codigo: $(_elemento.DdlComponente).val(),
            CampaniaID: $(_elemento.DdlCampania).val(),
            Accion: _accion.NuevoDatos
        };

        _RegistroObterner(params);
    };

    var _DialogCrear = function () {
        $('#' + _elemento.DialogRegistro).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 830,
            height: 500,
            close: function () { },
            draggable: false,
            title: _texto.TituloDialogRegistro,
            open: function (event, ui) { },
            buttons:
            {
                'Guardar': function () {
                    _GuardarDatos(this);
                },
                'Salir': function () {
                    $(this).dialog('close');
                }
            }
        });
    };

    var _GuardarDatos = function (dialog) {
        var frmDatos = $(dialog).find(_elemento.DivFormulario);
        if (frmDatos.length == 0) {
            return false;
        }
        var listaFrmDatos = frmDatos.find('div[data-tipodato]');
        var listaDatos = [];
        $.each(listaFrmDatos, function (ind, datox) {
            var idConca = $.trim($(datox).attr('id')).split('-');
            if (idConca.length != 4) {
                return false;
            }
            var valor1 = $(datox).find('input').val();
            var tipoDato = $(datox).attr('data-tipodato');
            if (tipoDato === _tipoDato.Img) {
                valor1 = $("#nombre-" + idConca[3]).val();
            }

            var dato = {
                TipoDato: tipoDato,
                Dato: {
                    ConfiguracionPaisID: idConca[0],
                    CampaniaID: idConca[1],
                    Componente: idConca[2],
                    Codigo: idConca[3],
                    Valor1: valor1
                }
            };
            listaDatos.push(dato);
        });

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
        Deshabilitar: GrillaDeshabilitar
    };

})();
