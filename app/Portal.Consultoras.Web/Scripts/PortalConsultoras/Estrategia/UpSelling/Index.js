"use strict";

var belcorp = belcorp || {};
belcorp.estrategias = belcorp.estrategias || {};
belcorp.estrategias.upselling = belcorp.estrategias.upselling || {};

belcorp.estrategias.upselling.initialize = function (config) {
    var settings = {
        rutaImagenDesactivar: config.rutaImagenDesactivar,
        rutaImagenEdit: config.rutaImagenEdit,
        rutaImagenDelete: config.rutaImagenDelete,
        idGrilla: config.idGrilla,
        idPager: config.idPager,
        idGrillaRegalos: config.idGrillaRegalos,
        idPagerRegalos: config.idPagerRegalos,
        urlUpSellingObtener: config.urlUpSellingObtener,
        urlUpSellingObtenerRegalos: config.urlUpSellingObtenerRegalos,
        buttonBuscarId: config.buttonBuscarId,
        buttonNuevoId: config.buttonNuevoId,
        cmbCampanas: config.cmbCampanas,
        idTabs: config.idTabs,
        idTargetDiv: config.idTargetDiv,
        campanasPais: config.campanasPais,
        idDivPopUpRegalo: config.idDivPopUpRegalo
    };

    registerEvent.call(this, "onUpSellingEdit");
    registerEvent.call(this, "onUpSellingDelete");
    registerEvent.call(this, "onUpSellingDesactivar");

    registerEvent.call(this, "onUpSellingRegaloEdit");
    registerEvent.call(this, "onUpSellingRegaloDelete");
    registerEvent.call(this, "onUpSellingRegaloDesactivar");

    var self = this;
    function initBindings() {
        $("#" + settings.buttonBuscarId).on("click", document.body, buscar);
        $("#" + settings.buttonNuevoId).on("click", document.body, self.upSellingViewModel.nuevo);


        self.subscribe("onUpSellingEdit", editar);
        self.subscribe("onUpSellingDelete", eliminar);
        self.subscribe("onUpSellingDesactivar", desactivar);

        self.subscribe("onUpSellingRegaloEdit", self.upSellingViewModel.regaloEditar);
        self.subscribe("onUpSellingRegaloDelete", self.upSellingViewModel.regaloDelete);
        self.subscribe("onUpSellingRegaloDesactivar", self.upSellingViewModel.regaloDesactivar);

        cargarGrilla();
    }

    function cargarGrilla() {
        $("#" + settings.idGrilla).jqGrid("GridUnload");

        jQuery("#" + settings.idGrilla).jqGrid({
            url: settings.urlUpSellingObtener,
            hidegrid: false,
            datatype: "json",
            postData: ({
                codigoCampana: settings.cmbCampanas.val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            multiselect: false,
            colNames: ["#", "Pais", "Campaña", "Meta", "Activo", "Opciones"],
            colModel: [
                { name: "UpSellingId", index: "UpSellingId", width: 50, sortable: false, align: "center" },
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

    function cargarGrillaRegalos(data) {
        var grilla = $("#" + settings.idGrillaRegalos);
        grilla.jqGrid("GridUnload");

        grilla.jqGrid({
            hidegrid: false,
            datatype: "local",
            postData: ({
                codigoCampana: settings.cmbCampanas.val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            multiselect: false,
            colNames: ["#", "Nombre", "CUV", "Stock", "StockActual", "Orden", "Activo", "Opciones"],
            colModel: [
                { name: "UpSellingRegaloId", index: "UpSellingRegaloId", width: 50, sortable: false, align: "center" },
                { name: "Nombre", index: "Nombre", width: 80, sortable: false, align: "center" },
                { name: "CUV", index: "CUV", width: 80, sortable: false, align: "center" },
                { name: "Stock", index: "Stock", width: 80, sortable: false, align: "center" },
                { name: "StockActual", index: "StockActual", width: 100, sortable: false, align: "center" },
                { name: "Orden", index: "Orden", width: 100, sortable: false, align: "center" },
                { name: "Activo", index: "Activo", width: 100, sortable: false, align: "center" },
                { name: "Options", width: 60, editable: true, sortable: false, align: "center", resizable: false, formatter: optionButtonsRegalos },
            ],
            //jsonReader:
            //{
            //    root: "Data",
            //    repeatitems: false,
            //    id: "UpSellingId"
            //},
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

        grilla.jqGrid("navGrid", "#" + settings.idPager, { edit: false, add: false, refresh: false, del: false, search: false });

        for (var i = 0; i <= data.length; i++)
            grilla.jqGrid('addRowData', i + 1, data[i]);
    }

    function buscar(e, s) {
        e.preventDefault();
        cargarGrilla();
    }

    function optionButtons(cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"belcorp.estrategias.upselling.applyChanges('onUpSellingEdit', " + options.rowId + "); return false;\">" + "<img src='" + settings.rutaImagenEdit + "' alt='Editar UpSelling' title='Editar UpSelling' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.onUpSellingDelete.emit(" + options.rowId + "); return false;\"><img src='" + settings.rutaImagenDesactivar + "' alt='Deshabilitar UpSelling' title='Deshabilitar UpSelling' border='0' /></a>";
        var desactivar = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDesactivar', " + options.rowId + "); return false;\" > " + "<img src='" + settings.rutaImagenDelete + "' alt='Eliminar UpSelling' title='Eliminar UpSelling' border='0' /></a>";

        var resultado = edit;
        resultado += del;

        if (rowObject.Activo !== true)
            resultado += desactivar;

        return resultado;
    }

    function optionButtonsRegalos(cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"belcorp.estrategias.upselling.applyChanges('onUpSellingRegaloEdit', " + options.rowId + "); return false;\">" + "<img src='" + settings.rutaImagenEdit + "' alt='Editar Regalo' title='Editar Regalo' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingRegaloDesactivar'," + options.rowId + "); return false;\"><img src='" + settings.rutaImagenDesactivar + "' alt='Deshabilitar Regalo' title='Deshabilitar Regalo' border='0' /></a>";
        var desactivar = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingRegaloDelete', " + options.rowId + "); return false;\" > " + "<img src='" + settings.rutaImagenDelete + "' alt='Eliminar Regalo' title='Eliminar Regalo' border='0' /></a>";

        var resultado = edit;
        resultado += del;

        if (rowObject.Activo !== true)
            resultado += desactivar;

        return resultado;
    }

    function enableTabs(tabId) {
        $("#" + tabId).tabs();
    }

    function editar(upSellingId) {
        var rowData = getRowData(settings.idGrilla, upSellingId);
        self.upSellingViewModel.edit(rowData);
    }

    function eliminar(upSellingId) {
        //confirmar eliminacion
        //mostrar pantalla de cargando, validar eliminacion
        //mostrar mensaje de eliminado correctamente, limpiar la pantalla

        var upSellingModel = getRowData(settings.idGrilla, upSellingId);
        if (confirm("Confirme eliminar UpSelling para campaña " + upSellingModel.CodigoCampana)) {
            waitingDialog({});
            upSellingEliminarPromise(upSellingModel.UpSellingId)
                .then(function (result) {
                    if (!result.Success) {
                        fail(err);
                        return;
                    }

                    alert("Eliminado correctamente");
                    //todo: volver a cargar la grilla
                }, function (err) {
                    fail(err);
                })
                .done(function () {
                    closeWaitingDialog();
                });
        }
    }

    function desactivar(upSellingId) {
        //confirmar desactivacion
        //llamar a la funcion de editra con el flac desactivado
        //todo: en los servicios agregar un actualizar solo cabecera
        var upSellingModel = getRowData(settings.idGrilla, upSellingId);
        var textoActivar = upSellingModel.Activar ? "Activar" : "Desactivar";
        textoActivar += " para la campaña " + upSellingModel.CodigoCampana;

        if (confirm("Confirma " + textoActivar)) {
            upSellingActualizarCabeceraPromise(upSellingModel)
                .then(function (result) {

                }, function (err) {
                    fail(err);
                })
                .done(function () {
                    closeWaitingDialog();
                });
        }

    }

    function fail(err) {
        console.error(err);
    }

    function showDialog(divId) {
        var opt = {
            autoOpen: false,
            modal: true,
            width: 910,
            height: 450,
            title: 'Details'
        };


        $("#" + divId).dialog(opt).dialog("open");
        $("#ui-datepicker-div").css("z-index", "9999");
        return false;
    }

    function upSellingRegalosObtenerPromise(upsellingId) {
        return jQuery.ajax({
            type: "GET",
            url: settings.urlUpSellingObtenerRegalos,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                upsellingId: upsellingId
            },
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

    function upSellingActualizarCabeceraPromise(upSellingModel) {
        return jQuery.ajax({
            type: "POST",
            url: settings.urlUpSellingActualizarCabecera,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(upSellingModel),
            async: true
        });
    }

    function getRowData(idGrid, idRow) {
        return $("#" + idGrid).jqGrid('getRowData', idRow);
    }

    function UpSellingModel(data) {
        this.UpSellingId = ko.observable(data.UpSellingId);
        this.CodigoCampana = ko.observable(data.CodigoCampana);
        this.MontoMeta = ko.observable(data.MontoMeta);
        this.TextoMeta = ko.observable(data.TextoMeta);
        this.TextoMetaSecundario = ko.observable(data.TextoMetaSecundario);
        this.TextoGanaste = ko.observable(data.TextoGanaste);
        this.TextoGanasteSecundario = ko.observable(data.TextoGanasteSecundario);
        this.Activo = ko.observable(data.Activo);

        this.Regalos = ko.observableArray(data.Regalos.map(function (regalo) {
            return new UpSellingRegaloModel(regalo);
        }));
    }

    function UpSellingRegaloModel(data) {
        this.UpSellingRegaloId = ko.observable(data.UpSellingRegaloId);
        this.CUV = ko.observable(data.CUV);
        this.Nombre = ko.observable(data.Nombre);
        this.Descripcion = ko.observable(data.Descripcion);
        this.Imagen = ko.observable(data.Imagen);
        this.Stock = ko.observable(data.Stock);
        this.StockActual = ko.observable(data.StockActual);
        this.Orden = ko.observable(data.Orden);
        this.Activo = ko.observable(data.Activo);
    }

    function UpSellingViewModel() {
        var selfvm = this;

        selfvm.upSelling = ko.observable({});
        selfvm.campanasPais = settings.campanasPais.map(function (campana) {
            return { Id: campana.CampaniaID, Codigo: campana.Codigo };
        });

        selfvm.mostrarFormulario = ko.observable(false);

        selfvm.nuevo = function () {
            //todo:
        }

        selfvm.edit = function (upSellingRow) {
            //todo, mostrar campos bindeados
            //cargar tab de regalos, categorias apoyadas y ganadoras
            //cargar tab de regalos con data, los demas no
            waitingDialog({});
            upSellingRegalosObtenerPromise(upSellingRow.UpSellingId)
                .then(function (result) {
                    if (!result.Success)
                        fail(result.Message);

                    upSellingRow.Regalos = result.Data;
                    selfvm.upSelling = new UpSellingModel(upSellingRow);
                    selfvm.mostrarFormulario(true);
                    enableTabs(settings.idTabs);
                    //todo: eval length
                    cargarGrillaRegalos(ko.toJS(selfvm.upSelling.Regalos));
                }, fail)
                .done(function () {
                    closeWaitingDialog();
                });
        }

        selfvm.save = function () {
            alert("guardar todo");
        }

        selfvm.cancel = function() {
            alert("perdera cambios");
        }

        selfvm.regaloSeleccionado = ko.observable();
        selfvm.mostrarFormularioRegalo = ko.observable(false);
        selfvm.regaloEsNuevo = ko.observable(true);


        selfvm.regaloNuevo = function () {
            selfvm.regaloSeleccionado(null);
            showDialog(settings.idDivPopUpRegalo);
            selfvm.mostrarFormularioRegalo(true);
            selfvm.regaloEsNuevo(true);
        }

        selfvm.regaloEditar = function (regaloId) {
            showDialog(settings.idDivPopUpRegalo);
            var regalos = selfvm.upSelling.Regalos().filter(function (regalo) {
                return regalo.UpSellingRegaloId() === regaloId;
            });
            if (!!regalos && regalos.length > 0) {
                selfvm.regaloSeleccionado = regalos[0];
                selfvm.mostrarFormularioRegalo(true);
                selfvm.regaloEsNuevo(false);
            }
        }

        selfvm.regaloAgregar = function () {
            selfvm.upSelling.Regalos.push(selfvm.regaloSeleccionado);
        }

        selfvm.regaloActualizar = function () {
            
                selfvm.upSelling.Regalos.push(selfvm.regaloSeleccionado);
        }

        selfvm.regaloDelete = function (regaloId) { }
        selfvm.regaloDesactivar = function (regaloId) { }
        selfvm.regaloCerrar = function () { }

    }

    self.upSellingViewModel = new UpSellingViewModel();
    ko.applyBindings(self.upSellingViewModel, document.getElementById(settings.idTargetDiv));
    initBindings();
}
