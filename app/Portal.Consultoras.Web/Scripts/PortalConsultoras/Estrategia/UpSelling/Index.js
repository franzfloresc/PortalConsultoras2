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
        urlUpSellingGuardar: config.urlUpSellingGuardar,
        urlUpSellingEliminar: config.urlUpSellingEliminar,
        urlUpSellingActualizarCabecera: config.urlUpSellingActualizarCabecera,
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

    var self = this;
    function initBindings() {
        $("#" + settings.buttonBuscarId).on("click", document.body, buscar);
        $("#" + settings.buttonNuevoId).on("click", document.body, self.upSellingViewModel.nuevo);


        self.subscribe("onUpSellingEdit", editar);
        self.subscribe("onUpSellingDelete", eliminar);
        self.subscribe("onUpSellingDesactivar", desactivar);

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
            colNames: ["#", "Pais", "Campaña", "Meta", "Activo", "Opciones", "TextoMeta", "TextoMetaSecundario", "TextoGanaste", "TextoGanasteSecundario"],
            colModel: [
                { name: "UpSellingId", index: "UpSellingId", width: 50, sortable: false, align: "center" },
                { name: "Pais", index: "Pais", width: 80, sortable: false, align: "center" },
                { name: "CodigoCampana", index: "CodigoCampana", width: 80, sortable: false, align: "center" },
                { name: "MontoMeta", index: "MontoMeta", width: 80, sortable: false, align: "center" },
                { name: "Activo", index: "Activo", width: 100, sortable: false, align: "center" },
                { name: "Options", width: 60, editable: true, sortable: false, align: 'center', resizable: false, formatter: optionButtons },
                { name: "TextoMeta", index: "TextoMeta", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "TextoMetaSecundario", index: "TextoMetaSecundario", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "TextoGanaste", index: "TextoGanaste", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "TextoGanasteSecundario", index: "TextoGanasteSecundario", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
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

    function buscar(e, s) {
        e.preventDefault();
        cargarGrilla();
    }

    function optionButtons(cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"belcorp.estrategias.upselling.applyChanges('onUpSellingEdit', " + options.rowId + "); return false;\">" + "<img src='" + settings.rutaImagenEdit + "' alt='Editar UpSelling' title='Editar UpSelling' border='0' /></a>";
        var enable = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDesactivar'," + options.rowId + "); return false;\"><img src='" + settings.rutaImagenDesactivar + "' alt='Deshabilitar UpSelling' title='Deshabilitar UpSelling' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDelete', " + options.rowId + "); return false;\" > " + "<img src='" + settings.rutaImagenDelete + "' alt='Eliminar UpSelling' title='Eliminar UpSelling' border='0' /></a>";

        var resultado = edit + del;

        if (rowObject.Activo !== true)
            resultado += enable;

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
        var upSellingModel = getRowData(settings.idGrilla, upSellingId);
        if (confirm("Confirme eliminar UpSelling para campaña " + upSellingModel.CodigoCampana)) {
            waitingDialog({});
            upSellingEliminarPromise(upSellingModel.UpSellingId)
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                        return;
                    }

                    alert("Eliminado correctamente");
                    cargarGrilla();
                    //todo: en caso este editando?
                }, function (err) {
                    fail(err);
                })
                .always(function () {
                    closeWaitingDialog();
                });
        }
    }

    function desactivar(upSellingId) {
        //confirmar desactivacion
        //llamar a la funcion de editra con el flac desactivado
        //todo: en los servicios agregar un actualizar solo cabecera
        var upSellingModel = getRowData(settings.idGrilla, upSellingId);
        upSellingModel.Activo = !upSellingModel.Activo;

        var textoActivar = upSellingModel.Activo ? "Activar" : "Desactivar";
        textoActivar += " para la campaña " + upSellingModel.CodigoCampana;

        if (confirm("Confirma " + textoActivar)) {
            upSellingActualizarCabeceraPromise(upSellingModel)
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                    }

                    alert("Actualizado correctamente");
                    cargarGrilla();
                    //todo: en caso este editando?
                }, function (err) {
                    fail(err);
                })
                .always(function () {
                    closeWaitingDialog();
                });
        }

    }

    function fail(err) {
        alert("Ups, sucedio un error");
        console.error(err);
    }

    function showDialog(divId) {
        var opt = {
            autoOpen: false,
            modal: true,
            width: 910,
            height: "auto",
            title: "Details"
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
            data: JSON.stringify({ upsellingId: upsellingId }),
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

    function upSellingGuardarPromise(upSellingModel) {
        return jQuery.ajax({
            type: "POST",
            url: settings.urlUpSellingGuardar,
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
        var selfm = this;
        selfm.UpSellingId = ko.observable(data.UpSellingId);
        selfm.CodigoCampana = ko.observable(data.CodigoCampana);
        selfm.MontoMeta = ko.observable(data.MontoMeta);
        selfm.TextoMeta = ko.observable(data.TextoMeta);
        selfm.TextoMetaSecundario = ko.observable(data.TextoMetaSecundario);
        selfm.TextoGanaste = ko.observable(data.TextoGanaste);
        selfm.TextoGanasteSecundario = ko.observable(data.TextoGanasteSecundario);
        selfm.Activo = ko.observable(data.Activo);
        selfm.Regalos = ko.observableArray();

        if (!!data.Regalos && data.Regalos.length > 0) {
            selfm.Regalos(data.Regalos.map(function (regalo) {
                return new UpSellingRegaloModel(regalo);
            }));
        }
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

    function upSellingDefault() {
        return new UpSellingModel({
            UpSellingId: null,
            CodigoCampana: null,
            MontoMeta: null,
            TextoMeta: null,
            TextoMetaSecundario: null,
            TextoGanaste: null,
            TextoGanasteSecundario: null,
            Activo: true,
            Regalos: []
        });
    }

    function regaloDefault() {
        return new UpSellingRegaloModel({
            UpSellingRegaloId: 0,
            CUV: null,
            Nombre: null,
            Descripcion: null,
            Imagen: null,
            Stock: null,
            StockActual: null,
            Orden: null,
            Activo: true
        });
    }

    function UpSellingViewModel() {
        var selfvm = this;

        selfvm.upSellingSeleccionado = ko.observable();
        selfvm.campanasPais = settings.campanasPais.map(function (campana) {
            return { Id: campana.CampaniaID, Codigo: campana.Codigo };
        });

        selfvm.mostrarFormulario = ko.observable(false);

        selfvm.nuevo = function () {
            selfvm.upSellingSeleccionado(upSellingDefault());
        }

        selfvm.edit = function (upSellingRow) {
            waitingDialog({});
            selfvm.upSellingSeleccionado(null);
            selfvm.regaloSeleccionado(null);
            upSellingRegalosObtenerPromise(upSellingRow.UpSellingId)
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                        return;
                    }

                    upSellingRow.Regalos = result.Data;

                    selfvm.upSellingSeleccionado(new UpSellingModel(upSellingRow));
                    selfvm.mostrarFormulario(true);
                    enableTabs(settings.idTabs);
                }, fail)
                .always(function () {
                    closeWaitingDialog();
                });
        }

        selfvm.save = function () {
            waitingDialog({});
            upSellingGuardarPromise(ko.toJS(selfvm.upSellingSeleccionado))
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                        return;
                    }

                    selfvm.upSellingSeleccionado(result.Data);
                    enableTabs(settings.idTabs);
                    alert("guardado");
                }, fail)
                .always(function () {
                    closeWaitingDialog();
                });
        }

        selfvm.cancel = function () {
            alert("perdera cambios");
            selfvm.upSellingSeleccionado(null);
            selfvm.regaloSeleccionado(null);
        }

        selfvm.regaloSeleccionado = ko.observable();
        selfvm.regaloEsNuevo = ko.observable(true);

        selfvm.regaloNuevo = function () {
            selfvm.regaloSeleccionado(regaloDefault());
            showDialog(settings.idDivPopUpRegalo);
            selfvm.regaloEsNuevo(true);
        }

        selfvm.regaloEditar = function (regalo) {
            showDialog(settings.idDivPopUpRegalo);
            selfvm.regaloSeleccionado(regalo);
            selfvm.regaloEsNuevo(false);
        }

        selfvm.regaloAgregar = function () {
            selfvm.upSellingSeleccionado().Regalos.push(selfvm.regaloSeleccionado());
            selfvm.regaloSeleccionado(null);
            HideDialog(settings.idDivPopUpRegalo);
        }

        selfvm.regaloActualizar = function () {
            selfvm.regaloSeleccionado(null);
            HideDialog(settings.idDivPopUpRegalo);
        }

        selfvm.regaloActivarDesactivar = function (regalo) {
            regalo.Activo(!regalo.Activo());
        }

        selfvm.regaloEliminar = function (regalo) {
            selfvm.upSellingSeleccionado().Regalos.remove(regalo);
        }

        selfvm.regaloCerrar = function () {
            selfvm.regaloSeleccionado(null);
            HideDialog(settings.idDivPopUpRegalo);
        }
    }

    self.upSellingViewModel = new UpSellingViewModel();
    ko.applyBindings(self.upSellingViewModel, document.getElementById(settings.idTargetDiv));
    initBindings();
}
