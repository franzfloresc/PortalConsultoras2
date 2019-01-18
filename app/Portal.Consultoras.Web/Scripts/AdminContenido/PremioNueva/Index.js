jQuery(document).ready(function () {
   
    LoadGrilla();
    RegistrarConstrains();
    RegistrarEventos();
    fnDialog();

});
function getParams() {
    var input = $("#ddlEstado").val();
    var active = input !== "" ? (input == "1" ? true : false) : "";
    var data = {
        AnoCampanaIni: $("#ddlCampania").val(),
        Nivel: $("#ddlNivel").val(),
        CodigoPrograma: $('#txtPrograma').val(),
        Active: active
    };
    return data;
}
function LoadGrilla() {
    $("#list").jqGrid("GridUnload");

    jQuery("#list").jqGrid({
        url: UrlGrid,
        hidegrid: false,
        datatype: 'local',
        postData: getParams(),
        mtype: 'GET',
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ["", "#", "Cod. Programa", "Campaña Inicio", "Campaña Fin", "Nivel", "Premio Activo", "Activar Monto", "Premio Electivo", "Activar Tooltip", "", "", "", "","",""],
        colModel: [
            { name: 'IdActivarPremioNuevas', index: 'IdActivarPremioNuevas', hidden: true },
            { name: 'ID', index: 'ID', width: 50, sortable: false, align: 'center' },
            { name: 'CodigoPrograma', index: 'CodigoPrograma', width: 80, sortable: true, align: 'center' },
            { name: 'AnoCampanaIni', index: 'AnoCampanaIni', width: 80, sortable: true, align: 'center' },
            { name: 'AnoCampanaFin', index: 'AnoCampanaFin', width: 80, sortable: true, align: 'center' },
            { name: 'Nivel', index: 'Nivel', width: 100, sortable: true, align: 'center' },
            { name: 'ActiveDesc', index: 'ActiveDesc', width: 80, hidden: false, sortable: false ,align: 'center' },
            { name: 'ActiveTooltipMontoDesc', index: 'ActiveTooltipMontoDesc', width: 80, sortable: false, align: 'center'  },
            { name: 'Ind_Cup_ElecDesc', index: 'Ind_Cup_ElecDesc', align: 'center', width: 80, sortable: false, align: 'center' },
            { name: 'ActiveTooltipDesc', index: 'ActiveTooltipDesc', align: 'center', width: 80, sortable: false, align: 'center' },
            { name: 'Editar', index: 'Editar', width: 30, align: 'center', sortable: false, formatter: ShowActionsEdit },
            { name: 'Eliminar', index: 'Eliminar', width: 30, align: 'center', sortable: false, formatter: ShowActionsDelete },
            { name: 'ActiveTooltip', index: 'Precio', hidden: true },
            { name: 'ActiveMonto', index: 'ActiveMonto', hidden: true },
            { name: 'ActivePremioAuto', index: 'ActivePremioAuto', hidden: true },
            { name: 'ActivePremioElectivo', index: 'ActivePremioElectivo', hidden: true },
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
           
            if (iCol == 10) LoadMantenedor(rowId);
            else if (iCol == 11) DesactivarPremio(rowId)
        }
    });
    jQuery("#list").jqGrid('navGrid', "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
}
function ShowActionsEdit(cellvalue, options, rowObject) {
   
    var Des = "<img src='" + rutaImagenEdit + "' alt='Editar Premio' title='Editar Premio' border='0' style='cursor:pointer' /></a>";
    return Des;
}

function ShowActionsDelete(cellvalue, options, rowObject) {
    var Des = "<img src='" + rutaImagenDelete + "' alt='Deshabilitar Premio' title='Deshabilitar Premio' border='0' style='cursor:pointer' /></a>";
    if (rowObject.ActivePremioAuto == false) Des = "";
    return Des;
}
function RegistrarConstrains() {

    $("#txtPrograma").on('keypress', function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        var inputVal = $(this).val();
        var keyChar = String.fromCharCode(charCode);
        var re = /[0-9]/;
        return re.test(keyChar);
    });

    $("#txtPrograma").on('dragover drop', function (e) {
        e.preventDefault();
        return false;
    });


}
function ReloadGrid() {
    $('#list').jqGrid('clearGridData');
    $("#list").jqGrid('setGridParam',
    {
     datatype: 'json',
     postData: getParams()
    })
    $("#list").trigger('reloadGrid'); 
}
function RegistrarEventos() {



    $("#btnBuscar").click(function (e) {
        e.preventDefault();

        if ($("#ddlCampania").val() == "") {
           
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        ReloadGrid();
    });

    $("#btnNuevo").click(function (e) {
        e.preventDefault();

        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        LoadMantenedor(0);
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
        title: "CONFIGURACIÓN <b>PREMIO NUEVAS</b>",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        close: function () {
        },
    });
}
function DesactivarPremio(rowId) {
    var premio = {};
    var elimina = confirm('¿ Esta seguro que desea deshabilitar el Premio seleccionado?');
    if (!elimina) return;

    var rowData = $("#list").jqGrid('getRowData', rowId);
    Premio = rowData;
    Premio.ActivePremioAuto = 0;
    Premio['Operacion'] = 1;

    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: UrlOperacionPremio,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(Premio),
        async: true,
        success: function (data) {
            alert(data.message);
            ReloadGrid();
            closeWaitingDialog();
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
   

}
function LoadMantenedor(rowId) {
    var url =UrlCRUD;

    waitingDialog({});

    var Premio = {};

    if (rowId == 0) {
       
        Premio.AnoCampanaIni = $("#ddlCampania").val();
        Premio.Operacion = 0;
    }
    else {
       
        var rowData = $("#list").jqGrid('getRowData', rowId);
        Premio = rowData;
        Premio['Operacion'] = 1;

    }

    $.ajax({
        type: 'GET',
        dataType: 'html',
        cache: false,
        url: url,
        data: Premio,
        success: function (data) {
            closeWaitingDialog();

            $("#divAgregar").html(data);
            showDialog("divAgregar");

            //$("#CampaniaFin").focus();
        },
        error: function (xhr, ajaxOptions, error) {
            closeWaitingDialog();
        }
    });
}
