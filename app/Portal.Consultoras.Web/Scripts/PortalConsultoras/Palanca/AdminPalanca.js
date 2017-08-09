jQuery(document).ready(function () {
    fnGrilla();
    IniDialogs();

    $("#btnModificar").click(function () {
        //validacion de los campos 
        $.ajax({
            url: 'AdministrarPalanca/GetPalanca',
            type: 'GET',
            dataType: 'html',
            data: { idConfiguracionPais: $("#ddlConfiguracionPais").val()}, //cambiar por el id correcto
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                $("#dialog-content-palanca").empty();
                $("#dialog-content-palanca").html(result);
                showDialog("DialogMantenimientoPalanca");
            },
            error: function (request, status, error) {
                alert(request);
            }
        });
    });

  
    $("#ddlTipoEstrategia").change(function () {
      
    });
});


function IniDialogs() {
    $('#DialogMantenimientoPalanca').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 830,
        close: function () {},
        draggable: false,
        title: "Modificar Palanca",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        buttons:
        {
            "Guardar": function () {
                //valores para el carrusel de la estrategia de lanzamiento
                var configuracionPaisID = $("#ddlConfiguracionPais").val();
                var codigo = $("#ddlConfiguracionPais").val();
                var excluyente = $("input[name='Excluyente']:checked").val();
                //var descripcion = $("#").val();
                var estado = $("#Estado").val();
                //var tienePerfil = $("#").val();
                var desdeCampania = $("#ddlCampania").val();
                var tipoEstrategia = $("#ddlEstrategia").val().join(',');;
                var mostrarCampaniaSiguiente = $("#MostrarCampaniaSiguiente").val();
                var mostrarPagInformativa = $("#MostrarPagInformativa").val();
                var hImagenFondo = $("#HImagenFondo").val();
                var hTipoPresentacion = $("#ddlPresentacion").val();
                var hMaxProductos = $("#HMaxProductos").val();
                var hTipoEstrategia = $("#ddlHEstrategia").val().join(',');

                var params = {
                    ConfiguracionPaisID: configuracionPaisID,
                    Codigo: codigo,
                    Excluyente: excluyente,
                    //Descripcion: descripcion,
                    Estado: estado,
                    //TienePerfil: tienePerfil,
                    DesdeCampania: desdeCampania,
                    TipoEstrategia: tipoEstrategia,
                    MostrarCampaniaSiguiente: mostrarCampaniaSiguiente,
                    MostrarPagInformativa: mostrarPagInformativa,
                    HImagenFondo: hImagenFondo,
                    HTipoPresentacion: hTipoPresentacion,
                    HMaxProductos: hMaxProductos,
                    HTipoEstrategia: hTipoEstrategia
                };
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'AdministrarPalanca/Update',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        if (data.success) {
                            HideDialog("DialogMantenimientoPalanca");
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function (data, error) {
                        alert(data.message);
                    }
                });

            },
            "Salir": function () {
                $("#ddlTipoEstrategia").val($("#hdEstrategiaIDConsulta").val());
                $(this).dialog('close');
            }
        }
    });
}


function fnGrilla() {
    $("#list").jqGrid("GridUnload");

    jQuery("#list").jqGrid({
        url: baseUrl + "AdministrarPalanca/ListPalanca",
        hidegrid: false,
        datatype: 'json',
        //postData: ({}),
        mtype: 'GET',
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ['ConfiguracionPaisID', 'Orden', 'Codigo', 'Descripcion', 'Accion'],
        colModel: [
            {
                name: 'ConfiguracionPaisID',
                index: 'ConfiguracionPaisID',
                width: 20,
                editable: true,
                resizable: false,
                hidden: true
            },
            {
                name: 'Orden',
                index: 'Orden',
                width: 40,
                ConfiguracionPaisID: true,
                resizable: false,
                hidden: false,
                sortable: false
            },
            { name: 'Codigo', index: 'Codigo', width: 40, editable: true, hidden: false, sortable: false },
            { name: 'Descripcion', index: 'Descripcion', width: 280, editable: true, hidden: false, sortable: false },
            {
                name: 'Activo',
                index: 'Activo',
                width: 30,
                align: 'center',
                editable: true,
                resizable: false,
                sortable: false,
                formatter: ShowActions
            }
        ],
        //jsonReader:
        //{
        //    root: "rows",
        //    page: "page",
        //    total: "total",
        //    records: "records",
        //    repeatitems: true,
        //    cell: "cell",
        //    id: "id"
        //},
        pager: false,
        loadtext: 'Cargando datos...',
        recordtext: "{0} - {1} de {2} Registros",
        emptyrecords: 'No hay resultadost',
        rowNum: 100,
        scrollOffset: 0,
        //rowList: [10, 20, 30, 40, 50],
        sortname: 'Orden',
        sortorder: 'asc',
        height: 'auto',
        width: 930,
        //pgtext: 'Pág: {0} de {1}',
        altRows: true,
        altclass: 'jQGridAltRowClass',
        pgbuttons: false,
        viewrecords: false,
        pgtext: "",
        pginput: false
    });
    jQuery("#list").jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });

}

function ShowActions(cellvalue, options, rowObject) {

    var des = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Editar('" + rowObject[0] + "',event);\" >" + "<img src='" + rutaImagenEdit + "' alt='Editar Palanca' title='Editar Estrategia' border='0' /></a>";
    if (rowObject[10] === "1") {
        des += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" + rowObject[0] + "',event);\" >" + "<img src='" + rutaImagenDelete + "' alt='Deshabilitar Palanca' title='Deshabilitar Estrategia' border='0' /></a>";
    }
    return des;
}   