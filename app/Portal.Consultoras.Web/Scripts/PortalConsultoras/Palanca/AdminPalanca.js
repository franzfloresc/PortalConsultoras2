jQuery(document).ready(function () {
    UpdateGrillaOfertas();
    UpdateGrillaPalanca();
    IniDialogs();

    $("#btnBuscar").click(function () {
        UpdateGrillaOfertas();
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
        url: baseUrl + 'AdministrarPalanca/GetPalanca',
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
        url: baseUrl + 'AdministrarPalanca/GetOfertasHome',
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
                    ConfiguracionPaisID: $("#ConfiguracionPaisID").val(),
                    Codigo : $("#ddlConfiguracionPais").val(),
                    Excluyente : $("input[name='Excluyente']:checked").val(),
                    Descripcion : $("#Descripcion").val(),
                    Estado: $("#Estado").is(':checked'),
                    Logo : $("#nombre-icono").val(),
                    Orden : $("#Orden").val(),
                    DesdeCampania : $("#ddlCampania").val(),
                    DesktopTituloMenu : $("#DesktopTituloMenu").val(),
                    MobileTituloMenu : $("#MobileTituloMenu").val(),
                    DesktopTituloBanner : $("#DesktopTituloBanner").val(),
                    DesktopSubTituloBanner : $("#DesktopSubTituloBanner").val(),
                    MobileTituloBanner : $("#MobileTituloBanner").val(),
                    MobileSubTituloBanner : $("#MobileSubTituloBanner").val(),
                    DesktopFondoBanner : $("#nombre-desktop-fondo-banner").val(),
                    DesktopLogoBanner : $("#nombre-desktop-logo-banner").val(),
                    MobileFondoBanner : $("#nombre-mobile-fondo-banner").val(),
                    MobileLogoBanner: $("#nombre-mobile-logo-banner").val(),
                    UrlMenu: $("#UrlMenu").val()
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
                    ConfiguracionOfertasHomeID: $("#ConfiguracionOfertasHomeID").val(),
                    ConfiguracionPaisID: $("#ddlConfiguracionIdOfertas").val(),
                    CampaniaID: $("#ddlCampaniaOfertas").val(),
                    DesktopOrden: $("#DesktopOrden").val(),
                    //MobileOrden: $("#").val(),
                    DesktopImagenFondo: $("#nombre-fondo-desktop").val(),
                    MobileImagenFondo: $("#nombre-fondo-mobile").val(),
                    DesktopTitulo: $("#DesktopTitulo").val(),
                    MobileTitulo: $("#MobileTitulo").val(),
                    DesktopSubTitulo: $("#DesktopSubTitulo").val(),
                    MobileSubTitulo: $("#MobileSubTitulo").val(),
                    DesktopTipoPresentacion: $("#ddlDesktopTipoPresentacionOfertas").val(),
                    MobileTipoPresentacion: $("#ddlMobileTipoPresentacionOfertas").val(),
                    DesktopTipoEstrategia: GetStringEstrategia("desktop-tipo-estrategia"),
                    MobileTipoEstrategia: GetStringEstrategia("mobile-tipo-estrategia"),
                    DesktopCantidadProductos: $("#DesktopCantidadProductos").val(),
                    MobileCantidadProductos: $("#MobileCantidadProductos").val(),
                    DesktopActivo: $("#DesktopActivo").is(':checked'),
                    MobileActivo: $("#MobileActivo").is(':checked'),
                    UrlSeccion: $('#UrlSeccion').val()
                };
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'AdministrarPalanca/UpdateOfertasHome',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        if (data.success) {
                            HideDialog("DialogMantenimientoOfertasHome");
                            UpdateGrillaOfertas();
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


function UpdateGrillaPalanca() {
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

function UpdateGrillaOfertas() {
    // seccion ofertas home
    $("#listOfertas").jqGrid("GridUnload");

    jQuery("#listOfertas").jqGrid({
        url: baseUrl + "AdministrarPalanca/ListOfertasHome",
        hidegrid: false,
        datatype: 'json',
        postData: ({
            campaniaID: $("#CampaniaBuscar").val()
        }),
        mtype: 'GET',
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ['ConfiguracionOfertasHomeID', 'Orden', 'Campania', 'ConfiguracionPais', 'Titulo', 'Accion'],
        colModel: [
            {
                name: 'ConfiguracionOfertasHomeID',
                index: 'ConfiguracionOfertasHomeID',
                width: 20,
                editable: true,
                resizable: false,
                hidden: true
            },
            { name: 'DesktopOrden', index: 'Orden', width: 20, editable: true, hidden: false, sortable: false },
            {
                name: 'CampaniaID',
                index: 'Campania',
                width: 30,
                editable: true,
                resizable: false,
                hidden: false,
                sortable: false
            },
            { name: 'ConfiguracionPaisID', index: 'ConfiguracionPais', width: 80, editable: true, hidden: false, sortable: false },
            { name: 'DesktopTitulo', index: 'Titulo', width: 200, editable: true, hidden: false, sortable: false },
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
        jsonReader:
        {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: true,
            cell: "cell",
            id: "id"
        },
        pager: jQuery('#pager'),
        loadtext: 'Cargando datos...',
        recordtext: "{0} - {1} de {2} Registros",
        emptyrecords: 'No hay resultadost',
        rowNum: 10,
        scrollOffset: 0,
        rowList: [10, 20, 30, 40, 50],
        sortname: 'Orden',
        sortorder: 'asc',
        viewrecords: true,
        height: 'auto',
        width: 930,
        pgtext: 'Pág: {0} de {1}',
        altRows: true,
        altclass: 'jQGridAltRowClass',
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
        $("#src-" + tag).attr('src', urlS3 + $("#nombre-" + tag).val());
    }

    return false;
}

function GetStringEstrategia(nameCheckBox) {
    var estrategias = "";
    $("input[name='" + nameCheckBox + "']:checked").each(function () {
        estrategias += $(this).attr("value");
        estrategias += ",";
    });
    return estrategias.slice(0, -1);
}