jQuery(document).ready(function () {
    fnGrilla();
    IniDialogs();

    $("#btnModificar").click(function () {
       
    });

  
    $("#ddlTipoEstrategia").change(function () {
      
    });

    $.jgrid.extend({
        Editar: Modificar,
        EditarOfertas: ModificarOfertas,
        //Eliminar: estrategiaObj.eliminar
    });
});

function Modificar(idConfiguracionPais, event) {
    $.ajax({
        url: 'AdministrarPalanca/GetPalanca',
        type: 'GET',
        dataType: 'html',
        data: { idConfiguracionPais: idConfiguracionPais }, //cambiar por el id correcto
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $("#dialog-content-palanca").empty();
            $("#dialog-content-palanca").html(result).ready(
                UploadFilePalanca("icono"), UploadFilePalanca("desktop-fondo-banner"), UploadFilePalanca("desktop-logo-banner"),
                UploadFilePalanca("mobile-fondo-banner"), UploadFilePalanca("mobile-logo-banner")
            );
            showDialog("DialogMantenimientoPalanca");
        },
        error: function (request, status, error) {
            alert(request);
        }
    });
}

function NuevoOfertaHome() {
    ModificarOfertas(0, null);
}
function ModificarOfertas(idOfertasHome) {
    $.ajax({
        url: 'AdministrarPalanca/GetOfertasHome',
        type: 'GET',
        dataType: 'html',
        data: { idOfertasHome: idOfertasHome }, //cambiar por el id correcto
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $("#dialog-content-ofertas-home").empty();
            $("#dialog-content-ofertas-home").html(result).ready(
                UploadFilePalanca("fondo-mobile"), UploadFilePalanca("fondo-desktop")
            );
            showDialog("DialogMantenimientoOfertasHome");
        },
        error: function (request, status, error) {
            alert(request);
        }
    });
}
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
                //valores para enviar al actualizar la palanca
                var params = {
                    ConfiguracionPaisID: $("#ddlConfiguracionPais").val(),
                    Codigo : $("#ddlConfiguracionPais").val(),
                    Excluyente : $("input[name:'Excluyente']:checked").val(),
                    Descripcion : $("#Descripcion").val(),
                    Estado : $("#Estado").val(),
                    Logo : $("#nombre-icono").val(),
                    Orden : $("#Orden").val(),
                    DesdeCampania : $("#ddlCampania").val(),
                    DesktopTituloMenu : $("#DesktopTituloMenu").val(),
                    MobileTituloMenu : $("#MobileTituloMenu").val(),
                    DesktopTituloBanner : $("#DesktopTituloBanner").val(),
                    DesktopSubTituloBanner : $("#DesktopSubTituloBanner").val(),
                    MobileTituloBanner : $("#MobileTituloBanner").val(),
                    MobileSubTituloBanner : $("#MobileSubTituloBanner").val(),
                    CesktopFondoBanner : $("#nombre-desktop-fondo-banner").val(),
                    DesktopLogoBanner : $("#nombre-desktop-logo-banner").val(),
                    MobileFondoBanner : $("#nombre-mobile-fondo-banner").val(),
                    MobileLogoBanner : $("#nombre-mobile-logo-banner").val()
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

    $('#DialogMantenimientoOfertasHome').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 830,
        close: function () { },
        draggable: false,
        title: "Modificar Palanca",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        buttons:
        {
            "Guardar": function () {
                //valores para seccion de home del contenedor de ofertas
                var params = {
                    ConfiguracionOfertasHomeID: $("#").val(),
                    ConfiguracionPaisID: $("#").val(),
                    CampaniaID: $("#").val(),
                    DesktopOrden: $("#").val(),
                    MobileOrden: $("#").val(),
                    DesktopImagenFondo: $("#").val(),
                    MobileImagenFondo: $("#").val(),
                    DesktopTitulo: $("#").val(),
                    MobileTitulo: $("#").val(),
                    DesktopSubTitulo: $("#").val(),
                    MobileSubTitulo: $("#").val(),
                    DesktopTipoPresentacion: $("#").val(),
                    MobileTipoPresentacion: $("#").val(),
                    DesktopTipoEstrategia: $("#").val(),
                    MobileTipoEstrategia: $("#").val(),
                    DesktopCantidadProductos: $("#").val(),
                    MobileCantidadProductos: $("#").val(),
                    DesktopActivo: $("#").val(),
                    MobileActivo: $("#").val()
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

    // seccion ofertas home

    $("#listOfertas").jqGrid("GridUnload");

    jQuery("#listOfertas").jqGrid({
        url: baseUrl + "AdministrarPalanca/ListOfertasHome",
        hidegrid: false,
        datatype: 'json',
        //postData: ({}),
        mtype: 'GET',
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ['ConfiguracionOfertasHomeID', 'Campania', 'ConfiguracionPais', 'Orden', 'Titulo', 'Accion'],
        colModel: [
            {
                name: 'ConfiguracionOfertasHomeID',
                index: 'ConfiguracionOfertasHomeID',
                width: 20,
                editable: true,
                resizable: false,
                hidden: true
            },
            {
                name: 'CampaniaID',
                index: 'Campania',
                width: 40,
                editable: true,
                resizable: false,
                hidden: false,
                sortable: false
            },
            { name: 'ConfiguracionPaisID', index: 'ConfiguracionPais', width: 40, editable: true, hidden: false, sortable: false },
            { name: 'DesktopOrden', index: 'Orden', width: 40, editable: true, hidden: false, sortable: false },
            { name: 'DesktopTitulo', index: 'Titulo', width: 250, editable: true, hidden: false, sortable: false },
            {
                name: 'Activo',
                index: 'Activo',
                width: 30,
                align: 'center',
                editable: true,
                resizable: false,
                sortable: false,
                formatter: ShowActionsOfertas
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
    jQuery("#listOfertas").jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
}

function ShowActions(cellvalue, options, rowObject) {

    var des = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Editar('" + rowObject[0] + "',event);\" >" + "<img src='" + rutaImagenEdit + "' alt='Editar Palanca' title='Editar Estrategia' border='0' /></a>";
    if (rowObject[10] === "1") {
        des += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" + rowObject[0] + "',event);\" >" + "<img src='" + rutaImagenDelete + "' alt='Deshabilitar Palanca' title='Deshabilitar Estrategia' border='0' /></a>";
    }
    return des;
}   

function ShowActionsOfertas(cellvalue, options, rowObject) {

    var des = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listOfertas').EditarOfertas('" + rowObject[0] + "');\" >" + "<img src='" + rutaImagenEdit + "' alt='Editar Palanca' title='Editar Estrategia' border='0' /></a>";
    if (rowObject[10] === "1") {
        des += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" + rowObject[0] + "');\" >" + "<img src='" + rutaImagenDelete + "' alt='Deshabilitar Palanca' title='Deshabilitar Estrategia' border='0' /></a>";
    }
    return des;
}  
function UploadFilePalanca(tag) {

    var uploader = new qq.FileUploader({
        allowedExtensions: ['jpg', 'png', 'jpeg'],
        element: document.getElementById("img-" + tag),
        action: rutaFileUpload,
        onComplete: function (id, fileName, responseJSON) {
            if (checkTimeout(responseJSON)) {
                if (responseJSON.success) {
                    $("#nombre-" + tag).val(responseJSON.name);
                    $("#src-" + tag).attr('src', rutaTemporal + responseJSON.name);
                } else alert(responseJSON.message);
            }
            return false;
        },
        onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
        onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
        onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
    });
    if ($("#nombre-" + tag).val() !== "") {
        $("#src-" + tag).attr('src', urlS3 + $("#nombre-icono").val());
    }

    return false;
}