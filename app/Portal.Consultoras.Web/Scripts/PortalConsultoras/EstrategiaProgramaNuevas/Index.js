jQuery(document).ready(function () {
    fnGrilla();
    fnClick();
    fnDialog();

    if ($("#hdnTipoEstrategiaID").val() == "0") alert("Debe configurar el tipo de estrategia con codigo '021'");
});

function fnGrilla() {
    $("#list").jqGrid("GridUnload");

    jQuery("#list").jqGrid({
        url: baseUrl + "AdministrarEstrategia/ProgramaNuevasConsultar",
        hidegrid: false,
        datatype: 'json',
        postData: ({
            CampaniaID: $("#ddlCampania").val(),
            CUV: $("#txtCUV").val(),
            Imagen: $("#ddlTieneImagen").val(),
            Activo: $("#ddlOfertaActiva").val(),
            CodigoPrograma: $("#txtCodPrograma").val(),
            TipoEstrategiaID: $("#hdnTipoEstrategiaID").val()
        }),
        mtype: 'GET',
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ["", "#", "Cod. Programa", "Campaña Inicio", "Campaña Fin", "CUV", "Descripción", "Precio", "Código SAP", "Imagen", "Activo", "", "", "", "", "", "", ""],
        colModel: [
            { name: 'EstrategiaID', index: 'EstrategiaID', hidden: true },
            { name: 'ID', index: 'ID', width: 50, sortable: false, align: 'center' },
            { name: 'CodigoPrograma', index: 'CodigoPrograma', width: 80, sortable: false, align: 'center' },
            { name: 'CampaniaID', index: 'CampaniaID', width: 80, sortable: false, align: 'center' },
            { name: 'CampaniaIDFin', index: 'CampaniaIDFin', width: 80, sortable: false, align: 'center' },
            { name: 'CUV2', index: 'CUV2', width: 100, sortable: false, align: 'center' },
            { name: 'DescripcionCUV2', index: 'DescripcionCUV2', width: 150, hidden: false, sortable: false },
            { name: 'Precio2', index: 'Precio2', width: 80, sortable: false, align: 'right' },
            { name: 'CodigoProducto', index: 'CodigoProducto', align: 'center', width: 100, sortable: false },
            { name: 'Imagen', index: 'Imagen', width: 100, align: 'center', sortable: false, formatter: ShowImage },
            { name: 'Activo', index: 'Activo', hidden: true },
            { name: 'Editar', index: 'Editar', width: 30, align: 'center', sortable: false, formatter: ShowActionsEdit },
            { name: 'Eliminar', index: 'Eliminar', width: 30, align: 'center', sortable: false, formatter: ShowActionsDelete },
            { name: 'Precio', index: 'Precio', hidden: true },
            { name: 'Ganancia', index: 'Ganancia', hidden: true },
            { name: 'TextoLibre', index: 'TextoLibre', hidden: true },
            { name: 'Orden', index: 'Orden', hidden: true },
            { name: 'ImagenURL', index: 'ImagenURL', hidden: true },
        ],
        jsonReader:
        {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: false,
            id: "EstrategiaID"
        },
        pager: jQuery('#pager'),
        loadtext: 'Cargando datos...',
        recordtext: "{0} - {1} de {2} Registros",
        emptyrecords: 'No hay resultados',
        rowNum: 10,
        scrollOffset: 0,
        rowList: [10, 20, 30, 40, 50],
        sortname: 'ID',
        sortorder: 'asc',
        viewrecords: true,
        height: 'auto',
        width: 930,
        pgtext: 'Pág: {0} de {1}',
        altRows: false,
        onCellSelect: function (rowId, iCol, content, event) {
            if (iCol == 11) fnMantenedor(rowId);
            else if (iCol == 12) fnDeshabilitar(rowId)
        }
    });
    jQuery("#list").jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
}

function ShowActionsEdit(cellvalue, options, rowObject) {
    var Des = "<img src='" + rutaImagenEdit + "' alt='Editar Estrategia' title='Editar Estrategia' border='0' style='cursor:pointer' /></a>";
    return Des;
}

function ShowActionsDelete(cellvalue, options, rowObject) {
    var Des = "<img src='" + rutaImagenDelete + "' alt='Deshabilitar Estrategia' title='Deshabilitar Estrategia' border='0' style='cursor:pointer' /></a>";
    if (rowObject.Activo == 0) Des = "";
    return Des;
}

function ShowImage(cellvalue, options, rowObject) {
    var image = $.trim(rowObject.ImagenURL);
    var filename = image.replace(/^.*[\\\/]/, '');
    image = '<img src="' + (filename != "" ? image : rutaImagenVacia) + '" alt="" width="70px" height="60px" title="" border="0" />';
    return image;
}

function fnClick() {
    $("#btnBuscar").click(function (e) {
        e.preventDefault();

        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }
        fnGrilla();
    });

    $("#btnNuevo").click(function (e) {
        e.preventDefault();

        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        fnMantenedor(0);
    });

    $("#btnConfigMensajes").click(function (e) {
        e.preventDefault();

        var url = baseUrl + "AdministrarEstrategia/ProgramaNuevasMensaje";

        waitingDialog({});

        $.ajax({
            type: 'GET',
            dataType: 'html',
            cache: false,
            url: url,
            success: function (data) {
                closeWaitingDialog();

                $("#divConfigMensaje").html(data);
                showDialog("divConfigMensaje");

                $("#CodigoPrograma").focus();
            },
            error: function (xhr, ajaxOptions, error) {
                closeWaitingDialog();
            }
        });
    });

    $("#btnConfigBanners").click(function (e) {
        e.preventDefault();

        var url = baseUrl + "AdministrarEstrategia/ProgramaNuevasBanner";

        waitingDialog({});

        $.ajax({
            type: 'GET',
            dataType: 'html',
            cache: false,
            url: url,
            success: function (data) {
                closeWaitingDialog();

                $("#divConfigBanner").html(data);
                showDialog("divConfigBanner");

                $("#CodigoPrograma").focus();
            },
            error: function (xhr, ajaxOptions, error) {
                closeWaitingDialog();
            }
        });
    });
}

function fnDialog() {
    $('#divAgregar').dialog({
        position: ['center', 20],
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 800,
        draggable: false,
        title: "CONFIGURACIÓN <b>PROGRAMA DE NUEVAS</b>",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        close: function () {
        },
    });

    $('#divConfigMensaje').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 700,
        draggable: false,
        title: "CONFIGURACIÓN MENSAJES <b>PROGRAMA DE NUEVAS</b>",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        close: function () {
        },
    });

    $('#divConfigBanner').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 700,
        draggable: false,
        title: "CONFIGURACIÓN BANNERS <b>PROGRAMA DE NUEVAS</b>",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        close: function () {
        },
    });
}

function fnDeshabilitar(rowId) {
    var elimina = confirm('¿ Esta seguro que desea deshabilitar la estrategia seleccionada?');
    if (!elimina) return;

    var rowData = $("#list").jqGrid('getRowData', rowId);
    var params = {
        EstrategiaID: rowData.EstrategiaID,
        tipoEstrategiaCodigo: 'NoMongo'
    };

    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'AdministrarEstrategia/DeshabilitarEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (data) {
            alert(data.message);
            fnGrilla();
            closeWaitingDialog();
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function fnMantenedor(rowId) {
    var url = baseUrl + "AdministrarEstrategia/ProgramaNuevasDetalle";

    waitingDialog({});

    var Estrategia = {};

    if (rowId == 0) {
        Estrategia.CampaniaInicio = $("#ddlCampania").val();
        Estrategia.ImageUrl = rutaImagenVacia;
    }
    else {
        var rowData = $("#list").jqGrid('getRowData', rowId);

        Estrategia.EstrategiaID = rowData.EstrategiaID;
        Estrategia.CampaniaInicio = rowData.CampaniaID;
        Estrategia.CampaniaFin = rowData.CampaniaIDFin;
        Estrategia.CUV = rowData.CUV2;
        Estrategia.DescripcionCUV = rowData.DescripcionCUV2;
        Estrategia.Precio = rowData.Precio2;
        Estrategia.Valorizado = rowData.Precio;
        Estrategia.Ganancia = rowData.Ganancia;
        Estrategia.Mensaje = rowData.TextoLibre;
        Estrategia.Orden = rowData.Orden;
        Estrategia.Activo = rowData.Activo == 1 ? true : false;
        Estrategia.ImageUrl = rowData.ImagenURL == "" ? rutaImagenVacia : rowData.ImagenURL;
        Estrategia.CodigoSAP = rowData.CodigoProducto;
        Estrategia.CodigoPrograma = rowData.CodigoPrograma;
    }

    $.ajax({
        type: 'GET',
        dataType: 'html',
        cache: false,
        url: url,
        data: Estrategia,
        success: function (data) {
            closeWaitingDialog();

            $("#divAgregar").html(data);
            showDialog("divAgregar");

            $("#CampaniaFin").focus();
        },
        error: function (xhr, ajaxOptions, error) {
            closeWaitingDialog();
        }
    });
}