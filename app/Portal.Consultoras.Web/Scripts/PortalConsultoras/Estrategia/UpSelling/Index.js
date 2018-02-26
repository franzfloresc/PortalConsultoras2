"use strict";

var belcorp = belcorp || {};
belcorp.estrategias = belcorp.estrategias || {};
belcorp.estrategias.upselling = belcorp.estrategias.upselling || {};

belcorp.estrategias.upselling.initialize = function (config) {
    var settings = {
        urlImagenDesactivar: config.urlImagenDesactivar,
        urlImagenEdit: config.urlImagenEdit,
        urlImagengenDelete: config.urlImagengenDelete,
        idGrilla: config.idGrilla,
        idPager: config.idPager,
        idGrillaRegalos: config.idGrillaRegalos,
        idPagerRegalos: config.idPagerRegalos,
        urlUpSellingObtener: config.urlUpSellingObtener,
        buttonBuscarId: config.buttonBuscarId,
        buttonNuevoId: config.buttonNuevoId,
        cmbCampanas: config.cmbCampanas,
        idTabs: config.idTabs,
        idTargetDiv: config.idTargetDiv,
        campanasPais: config.campanasPais,
        paisNombre: config.paisNombre,
        idDivPopUpRegalo: config.idDivPopUpRegalo,
        urlFileUpload: config.urlFileUpload,
        urlTemporal: config.urlTemporal,
        urlS3: config.urlS3
    };

    var api = belcorp.estrategias.upselling.api;
    api.initialize(config);

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

        window.onbeforeunload = self.upSellingViewModel.preventLeave

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
                { name: "Pais", index: "Pais", width: 80, sortable: false, align: "center", formatter: function () { return settings.paisNombre } },
                { name: "CodigoCampana", index: "CodigoCampana", width: 80, sortable: false, align: "center" },
                { name: "MontoMeta", index: "MontoMeta", width: 80, sortable: false, align: "center" },
                { name: "Activo", index: "Activo", width: 100, sortable: false, align: "center", template: "booleanCheckbox" },
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
        self.upSellingViewModel.esconderEditor();
        self.upSellingViewModel.mostrarFormularioUpSelling(false);
    }

    function optionButtons(cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"belcorp.estrategias.upselling.applyChanges('onUpSellingEdit', " + options.rowId + "); return false;\">" + "<img src='" + settings.urlImagenEdit + "' alt='Editar UpSelling' title='Editar UpSelling' border='0' /></a>";
        var enable = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDesactivar'," + options.rowId + "); return false;\"><img src='" + settings.urlImagenDesactivar + "' alt='Habilitar UpSelling' title='Habilitar UpSelling' border='0' /></a>";
        var disable = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDesactivar'," + options.rowId + "); return false;\"><img src='" + settings.urlImagenDesactivar + "' alt='Deshabilitar UpSelling' title='Deshabilitar UpSelling' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return belcorp.estrategias.upselling.applyChanges('onUpSellingDelete', " + options.rowId + "); return false;\" > " + "<img src='" + settings.urlImagengenDelete + "' alt='Eliminar UpSelling' title='Eliminar UpSelling' border='0' /></a>";

        var resultado = edit + del;

        if (rowObject.Activo === true)
            resultado += disable;
        else
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
            api.upSellingEliminarPromise(upSellingModel.UpSellingId)
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                        return;
                    }

                    alert("Eliminado correctamente");
                    cargarGrilla();
                    self.upSellingViewModel.esconderEditor();
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
        var upSellingModel = getRowData(settings.idGrilla, upSellingId);
        upSellingModel.Activo = !upSellingModel.Activo;

        var textoActivar = upSellingModel.Activo ? "Activar" : "Desactivar";
        textoActivar += " para la campaña " + upSellingModel.CodigoCampana;

        if (confirm("Confirma " + textoActivar)) {
            api.upSellingActualizarCabeceraPromise(upSellingModel)
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                    }

                    alert("Actualizado correctamente");
                    cargarGrilla();
                    //todo: en caso este editando?
                    self.upSellingViewModel.esconderEditor();
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

    function getRowData(idGrid, idRow) {
        var rowData = $("#" + idGrid).jqGrid('getRowData', idRow);

        if (!!rowData.Activo)
            rowData.Activo = rowData.Activo === "true" ? true : false;

        return rowData;
    }

    /**
     * Region ViewModel
     * @param {} data : UpSelling JS Object
     * @returns {} 
     */
    function UpSellingModel(data) {
        var selfm = this;
        selfm.UpSellingId = ko.observable(data.UpSellingId).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.CodigoCampana = ko.observable(data.CodigoCampana).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.MontoMeta = ko.observable(data.MontoMeta).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.TextoMeta = ko.observable(data.TextoMeta).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.TextoMetaSecundario = ko.observable(data.TextoMetaSecundario).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.TextoGanaste = ko.observable(data.TextoGanaste).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.TextoGanasteSecundario = ko.observable(data.TextoGanasteSecundario).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.Activo = ko.observable(data.Activo).extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty } });
        selfm.Regalos = ko.observableArray().extend({ trackChange: { track: true, cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty, isArray: true } });

        if (!!data.Regalos && data.Regalos.length > 0) {
            selfm.Regalos(data.Regalos.map(function (regalo) {
                return new UpSellingRegaloModel(regalo);
            }));
        }
    }

    function UpSellingRegaloModel(data) {
        var selfm = this;
        selfm.UpSellingRegaloId = ko.observable(data.UpSellingRegaloId);
        selfm.CUV = ko.observable(data.CUV).extend({ trackChange: { track: true } });
        selfm.Nombre = ko.observable(data.Nombre).extend({ trackChange: { track: true } });
        selfm.Descripcion = ko.observable(data.Descripcion).extend({ trackChange: { track: true } });
        selfm.Imagen = ko.observable(data.Imagen).extend({ trackChange: { track: true, cb: self.upSellingViewModel.actualizarRutaPrefixRegalo } });
        selfm.Stock = ko.observable(data.Stock).extend({ trackChange: { track: true } });
        selfm.StockActual = ko.observable(data.StockActual);
        selfm.Orden = ko.observable(data.Orden).extend({ trackChange: { track: true } });
        selfm.Activo = ko.observable(data.Activo).extend({ trackChange: { track: true } });

        //behaviors
        selfm.ImagenPrefix = ko.observable(data.ImagenPrefix);
        selfm.ImagenRuta = ko.computed(function () {
            var baseRoute = selfm.ImagenPrefix()
            if (!baseRoute) {
                baseRoute = settings.urlS3;
                selfm.ImagenPrefix(baseRoute)
            }

            return baseRoute + selfm.Imagen();
        });

        selfm.UndoChanges = function () {
            selfm.CUV.undoChanges();
            selfm.Nombre.undoChanges();
            selfm.Descripcion.undoChanges();
            selfm.Imagen.undoChanges();
            selfm.Stock.undoChanges();
            selfm.Orden.undoChanges();
            selfm.Activo.undoChanges();
        }
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
        selfvm.settings = ko.observable(settings);
        selfvm.upSellingSeleccionadoIsDirty = ko.observable(false);
        selfvm.upSellingSeleccionado = ko.observable().extend({ trackChange: { track: true, cb: selfvm.upSellingSeleccionadoIsDirty } });
        selfvm.mostrarFormularioUpSelling = ko.observable(false);
        selfvm.regaloSeleccionado = ko.observable();
        selfvm.regaloEsNuevo = ko.observable(true);
        selfvm.campanasPais = settings.campanasPais.map(function (campana) {
            return { Id: campana.CampaniaID, Codigo: campana.Codigo };
        });

        selfvm.nuevo = function () {
            selfvm.upSellingSeleccionado(upSellingDefault());
            enableTabs(settings.idTabs);
            selfvm.mostrarFormularioUpSelling(true);
            selfvm.upSellingSeleccionadoIsDirty(false);
        }

        selfvm.edit = function (upSellingRow) {
            waitingDialog({});
            selfvm.upSellingSeleccionado(null);
            selfvm.regaloSeleccionado(null);
            api.upSellingRegalosObtenerPromise(upSellingRow.UpSellingId)
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                        return;
                    }

                    upSellingRow.Regalos = result.Data;
                    var upSellingData = new UpSellingModel(upSellingRow);
                    selfvm.upSellingSeleccionado(upSellingData);
                    selfvm.upSellingSeleccionado.setOriginalValue(upSellingData); //for tracking change
                    selfvm.upSellingSeleccionadoIsDirty(false);
                    selfvm.mostrarFormularioUpSelling(true);
                    enableTabs(settings.idTabs);
                }, fail)
                .always(function () {
                    closeWaitingDialog();
                });
        }

        selfvm.save = function () {
            waitingDialog({});
            api.upSellingGuardarPromise(ko.toJS(selfvm.upSellingSeleccionado))
                .then(function (result) {
                    if (!result.Success) {
                        fail(result.Message);
                        return;
                    }

                    selfvm.upSellingSeleccionado(result.Data);
                    enableTabs(settings.idTabs);
                    alert("guardado");
                    selfvm.mostrarFormularioUpSelling(false);
                }, fail)
                .always(function () {
                    closeWaitingDialog();
                });
        }

        selfvm.cancel = function () {
            if (!selfvm.upSellingSeleccionadoIsDirty()) {
                selfvm.esconderEditor();
                return false;
            }

            if (confirm("¿Podria perder sus cambios, guardelos antes de salir?")) {
                selfvm.esconderEditor();
            }
        }

        selfvm.regaloNuevo = function () {
            selfvm.regaloSeleccionado(regaloDefault());
            selfvm.regaloSeleccionado().Imagen.setOriginalValue(regalo().Imagen)
            showDialog(settings.idDivPopUpRegalo);
            selfvm.regaloEsNuevo(true);
        }

        selfvm.regaloEditar = function (regalo) {
            showDialog(settings.idDivPopUpRegalo);
            selfvm.regaloSeleccionado(regalo);
            selfvm.regaloSeleccionado().Imagen.setOriginalValue(regalo.Imagen())

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
            selfvm.regaloSeleccionado().UndoChanges();
            selfvm.regaloSeleccionado(null);
            HideDialog(settings.idDivPopUpRegalo);
        }

        selfvm.actualizarRutaPrefixRegalo = function () {
            selfvm.regaloSeleccionado().ImagenPrefix(settings.urlTemporal);
        }

        selfvm.esconderEditor = function () {
            selfvm.upSellingSeleccionado(null);
            selfvm.regaloSeleccionado(null);
            selfvm.mostrarFormularioUpSelling(false);
        }

        selfvm.preventLeave = function (e, s) {
            if (selfvm.upSellingSeleccionadoIsDirty()) {
                var dialogText = "Desea salir del editor? podria perder sus cambios";
                e.returnValue = dialogText;
                return dialogText;
            }
        }
    }

    self.upSellingViewModel = new UpSellingViewModel();
    ko.applyBindings(self.upSellingViewModel, document.getElementById(settings.idTargetDiv));
    initBindings();
}
