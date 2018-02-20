var belcorp = belcorp || {};
belcorp.estrategias = belcorp.estrategias || {};
belcorp.estrategias.upselling = belcorp.estrategias.upselling || {};

belcorp.estrategias.upselling.initialize = function (config) {
    var settings = {
        rutaImagenVacia: config.rutaImagenVacia,
        rutaImagenEdit: config.rutaImagenEdit,
        rutaImagenDelete: config.rutaImagenDelete,
        idGrilla: config.idGrilla,
        idPager: config.idPager,
        urlUpSellingObtener: config.urlUpSellingObtener,
        buttonBuscarId: config.buttonBuscarId,
        buttonNuevoId: config.buttonNuevoId,
        cmbCampanas: config.cmbCampanas
    };

    registerEvent.call(this, "onUpSellingEdit");
    registerEvent.call(this, "onUpSellingDelete");
    registerEvent.call(this, "onUpSellingDesactivar");

    var self = this;

    self.init = function () {
        $("#" + settings.buttonBuscarId).on("click", document.body, buscar);
        $("#" + settings.buttonNuevoId).on("click", document.body, nuevo);

        self.subscribe("onUpSellingEdit", self.editar);
        self.subscribe("onUpSellingDelete", self.eliminar);
        self.subscribe("onUpSellingDesactivar", self.desactivar);

        cargarGrilla();
        fnDialog();
    }

    self.currentUpSelling = {};

    function cargarGrilla() {
        $("#" + settings.idGrilla).jqGrid("GridUnload");

        jQuery("#" + settings.idGrilla).jqGrid({
            url: settings.urlUpSellingObtener,
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: settings.cmbCampanas.val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            multiselect: false,
            colNames: ["#", "Pais", "Campaña", "Meta", "Activo", "Opciones"],
            colModel: [
                { name: "ID", index: "UpSellingId", width: 50, sortable: false, align: "center" },
                { name: "Pais", index: "Pais", width: 80, sortable: false, align: "center" },
                { name: "CodigoCampana", index: "CodigoCampana", width: 80, sortable: false, align: "center" },
                { name: "MontoMeta", index: "MontoMeta", width: 80, sortable: false, align: "center" },
                { name: "Activo", index: "Activo", width: 100, sortable: false, align: "center" },
                { name: "Options", width: 60, editable: true, sortable: false, align: 'center', resizable: false, formatter: optionButtons },
            ],
            jsonReader:
            {
                root: "Data",
                repeatitems: false,
                id: "UpSellingId"
            },
            pager: jQuery("#" + settings.idPager),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "UpSellingId",
            sortorder: "asc",
            viewrecords: true,
            height: "auto",
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: false
        });
        jQuery("#" + settings.idGrilla).jqGrid("navGrid", "#" + settings.idPager, { edit: false, add: false, refresh: false, del: false, search: false });
    }

    function ShowImage(cellvalue, options, rowObject) {
        var image = $.trim(rowObject.ImagenURL);
        var filename = image.replace(/^.*[\\\/]/, "");
        image = "<img src='" + (filename != "" ? image : rutaImagenVacia) + "' alt='' width='70px' height='60px' title='' border='0' />";
        return image;
    }

    function buscar(e, s) {
        if (settings.cmbCampanas.val() === "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return;
        }

        cargarGrilla();
    }

    function nuevo() {
        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        fnMantenedor(0);
    }

    function optionButtons(cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"belcorp.estrategias.upselling.applyChanges('onUpSellingEdit', " + options.rowId + "); return false;\">" + "<img src='" + settings.rutaImagenEdit + "' alt='Editar UpSelling' title='Editar UpSelling' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.onUpSellingDelete.emit(, " + options.rowId + "); return false;\"><img src='" + settings.rutaImagenDesactivar + "' alt='Deshabilitar UpSelling' title='Deshabilitar UpSelling' border='0' /></a>";
        var desactivar = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDesactivar', " + options.rowId + "); return false;\" > " + "<img src='" + settings.rutaImagenDelete + "' alt='Eliminar UpSelling' title='Eliminar UpSelling' border='0' /></a>";

        var resultado = edit;
        resultado += del;

        if (rowObject.Activo !== true)
            resultado += desactivar;

        return resultado;
    }

    self.editar = function (upSellingId) {
        //todo, mostrar campos bindeados
        //cargar tab de regalos, categorias apoyadas y ganadoras
        //cargar tab de regalos con data, los demas no
        waitingDialog({});
        var rowData = getRowData(settings.idGrilla, upSellingId);
        self.currentUpSelling = rowData;

        upSellingRegalosObtenerPromise(rowData.UpSellingId)
            .then(function (result) {
                if (!result.Success) {
                    self.fail(err);
                    return;
                }

                self.currentUpSelling.regalos = result.Data;
                //ko apply observables
            }, function (err) {
                self.fail(err);
            })
            .done(function () {
                closeWaitingDialog();
            });
    }

    self.eliminar = function (upSellingId) {
        //confirmar eliminacion
        //mostrar pantalla de cargando, validar eliminacion
        //mostrar mensaje de eliminado correctamente, limpiar la pantalla

        var upSellingModel = getRowData(settings.idGrilla, upSellingId);
        if (confirm("Confirme eliminar UpSelling para campaña " + upSellingModel.CodigoCampana)) {
            waitingDialog({});
            upSellingEliminarPromise(upSellingModel.UpSellingId)
                .then(function (result) {
                    if (!result.Success) {
                        self.fail(err);
                        return;
                    }

                    alert("Eliminado correctamente");
                    //todo: volver a cargar la grilla
                }, function (err) {
                    self.fail(err);
                })
                .done(function () {
                    closeWaitingDialog();
                });
        }
    }

    self.desactivar = function (upSellingId) {
        debugger;
        var another = this;
        alert(upSellingId);
        //confirmar desactivacion
        //llamar a la funcion de editra con el flac desactivado
        //todo: en los servicios agregar un actualizar solo cabecera
    }

    self.fail = function (err) {
        console.error(err);
    }

    function upSellingRegalosObtenerPromise(upsellingId) {
        return jQuery.ajax({
            type: "GET",
            url: baseUrl + settings.urlUpSellingObtenerRegalos,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(upsellingId),
            async: true
        });
    }

    function upSellingEliminarPromise(upsellingId) {
        return jQuery.ajax({
            type: "POST",
            url: baseUrl + settings.urlUpSellingEliminar,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(upsellingId),
            async: true
        });
    }

    function getRowData(idGrid, idRow) {
        return $("#" + idGrid).jqGrid('getRowData', idRow);
    }

    self.init();
}
