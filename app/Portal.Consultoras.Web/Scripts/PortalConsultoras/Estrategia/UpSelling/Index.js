﻿belcorp = belcorp || {};
belcorp.estrategias = belcorp.estrategias || {}
belcorp.estrategias.upselling = belcorp.estrategias.upselling || {}

belcorp.estrategias.upselling.initialize = function (config) {
    var settings = config;
    var self = this;

    self.init = function () {
        fnGrilla();
        fnDialog();

        $("#" + settings.buttonBuscarId).on("Click", document.body, function () {
            e.preventDefault();
            buscar();
        });

        $("#" + settings.buttonNuevoId).on("Click", document.body, function () {
            e.preventDefault();
            nuevo();
        });
    }

    self.init();

    function fnGrilla() {
        $("#" + settings.idGrilla).jqGrid("GridUnload");

        jQuery("#" + settings.idGrilla).jqGrid({
            url: settings.urlUpSellingObtener,
            hidegrid: false,
            datatype: 'json',
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                CUV: $("#txtCUV").val(),
                Imagen: $("#ddlTieneImagen").val(),
                Activo: $("#ddlOfertaActiva").val(),
                CodigoConcurso: $("#txtCodConcurso").val(),
                TipoEstrategiaID: $("#hdnTipoEstrategiaID").val()
            }),
            mtype: 'GET',
            contentType: "application/json; charset=utf-8",
            multiselect: false,
            colNames: ["", "#", "Pais", "Campaña", "Meta", "Activo", "Opciones"],
            colModel: [
                { name: 'EstrategiaID', index: 'EstrategiaID', hidden: true },
                { name: 'ID', index: 'ID', width: 50, sortable: false, align: 'center' },
                { name: 'Pais', index: 'Pais', width: 80, sortable: false, align: 'center' },
                { name: 'Campania', index: 'CodigoCampana', width: 80, sortable: false, align: 'center' },
                { name: 'Meta', index: 'Meta', width: 80, sortable: false, align: 'center' },
                { name: 'Activo', index: 'Activo', width: 100, sortable: false, align: 'center'},
                { name: 'Opciones', index: 'Opciones', hidden: true }
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
                else if (iCol == 12) fnDeshabilitar(rowId);
            }
        });
        jQuery("#" + settings.idGrilla).jqGrid('navGrid', "#" + settings.idPager, { edit: false, add: false, refresh: false, del: false, search: false });
    }

    function ShowDescripcionTipoConcurso(cellvalue, options, rowObject) {
        var descripcion = "";
        if (rowObject.TipoConcurso == "X") descripcion = "RxP";
        else if (rowObject.TipoConcurso == "K") descripcion = "Constancia";
        return descripcion;
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

    function buscar() {
        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        fnGrilla();
    }

    function nuevo() {
        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        fnMantenedor(0);
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
            title: "CONFIGURACIÓN <b>INCENTIVOS</b>",
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
            EstrategiaID: rowData.EstrategiaID
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
                alert(data.message);
                closeWaitingDialog();
            }
        });
    }

    function fnMantenedor(rowId) {
        var url = baseUrl + "AdministrarEstrategia/IncentivosDetalle";

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
            Estrategia.Activo = rowData.Activo == 1 ? true : false;
            Estrategia.ImageUrl = rowData.ImagenURL == "" ? rutaImagenVacia : rowData.ImagenURL;
            Estrategia.CodigoSAP = rowData.CodigoProducto;
            Estrategia.CodigoConcurso = rowData.CodigoConcurso;
            Estrategia.TipoConcurso = rowData.TipoConcurso;
            Estrategia.Orden = rowData.Orden;
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
                alert('Error: ' + xhr.status + " - " + xhr.responseText);
            }
        });
    }
}
