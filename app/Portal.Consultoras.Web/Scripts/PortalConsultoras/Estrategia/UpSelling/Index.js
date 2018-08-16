"use strict";

var belcorp = belcorp || {};
belcorp.estrategias = belcorp.estrategias || {};
belcorp.estrategias.upselling = belcorp.estrategias.upselling || {};

belcorp.estrategias.upselling.initialize = function (config) {
    var settings = {
        idCampaniaHidden: config.idCampaniaHidden,
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
        idDivPopUpRegalo: config.idDivPopUpRegalo,
        idTabs: config.idTabs,
        idTargetDiv: config.idTargetDiv,
        campanasPais: config.campanasPais,
        idListaGanadorasHidden: config.idListaGanadorasHidden,
        idFormReporteListaGanadoras: config.idFormReporteListaGanadoras,
        urlListaGanadorasObtener: config.urlListaGanadorasObtener,
        paisNombre: config.paisNombre,
        urlFileUpload: config.urlFileUpload,
        urlTemporal: config.urlTemporal,
        divPreviewPopUp: config.divPreviewPopUp,
        divPreviewThumbnail: config.divPreviewThumbnail
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
            colNames: ["#", "Pais", "Campaña", "TextoMetaPrincipal", "Activo", "Opciones", "TextoInferior", "TextoGanastePrincipal", "TextoGanasteBoton", "TextoGanastePremio", "ImagenFondoPrincipalDesktop", "ImagenFondoPrincipalMobile", "ImagenFondoGanasteMobile"],
            colModel: [{ name: "UpSellingId", index: "UpSellingId", width: 50, sortable: false, align: "center" },
                { name: "Pais", index: "Pais", width: 80, sortable: false, align: "center", formatter: function () { return settings.paisNombre } },
                { name: "CodigoCampana", index: "CodigoCampana", width: 80, sortable: false, align: "center" },
                { name: "TextoMetaPrincipal", index: "TextoMetaPrincipal", width: 80, sortable: false, align: "center" },
                { name: "Activo", index: "Activo", width: 100, sortable: false, align: "center", template: "booleanCheckbox" },
                { name: "Options", width: 60, editable: true, sortable: false, align: 'center', resizable: false, formatter: optionButtons },
                { name: "TextoInferior", index: "TextoInferior", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "TextoGanastePrincipal", index: "TextoGanastePrincipal", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "TextoGanasteBoton", index: "TextoGanasteBoton", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "TextoGanastePremio", index: "TextoGanastePremio", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "ImagenFondoPrincipalDesktop", index: "ImagenFondoPrincipalDesktop", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "ImagenFondoPrincipalMobile", index: "ImagenFondoPrincipalMobile", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
                { name: "ImagenFondoGanasteMobile", index: "ImagenFondoGanasteMobile", editable: true, sortable: false, hidden: true, editrules: { edithidden: true } },
            ],
            jsonReader: {
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
        jQuery("#" + settings.idGrilla).jqGrid("navGrid", "#" + settings.idPager, {
            edit: false,
            add: false,
            refresh: false,
            del: false,
            search: false
        });
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
                        fail(result);
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
                        fail(result);
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
        var defaultMessage = "No hemos podido procesar esta solicitud, verifica que la data enviada sea correcta \n y/o contacta con el administrador";
        if (err.Message) {
            defaultMessage = "Error en: " + err.Message;
        }

        alert(defaultMessage);
        console.error(err);
        checkTimeout(err);
    }

    function showDialog(divId) {
        var opt = {
            autoOpen: false,
            modal: true,
            width: 910,
            height: "auto",
            title: "Details",
            closeOnScape: false,
            draggable: true,
            position: 'top'
        };

        $("#" + divId)
            .dialog(opt)
            .on("dialogbeforeclose", function (event, ui) {
                if ($(this).dialog("isOpen") && self.upSellingViewModel.regaloSeleccionado()) {
                    self.upSellingViewModel.regaloCerrar();
                }
            })
            .dialog("open");

        $("#ui-datepicker-div").css("z-index", "9999");
        return false;
    }

    ko.bindingHandlers.preview = {
        init: function (element, valueAccessor) {
            var className = valueAccessor();
            var optionsPreview = {
                autoOpen: false,
                width: "auto",
                height: "auto",
                title: null,
                resizable: false,
                dialogText: null,
                draggable: false,
                buttons: null,
                closeOnScape: true,
                dialogClass: "no-close"
            };

            $(element).hover(function handleIn() {
                $(settings.divPreviewThumbnail)
                    .removeAttr("class")
                    .addClass(className);

                $(settings.divPreviewPopUp).dialog(optionsPreview).dialog("open");
            },
            function handlOut() {
                $(settings.divPreviewPopUp).dialog("close");
            });
        }
    };

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
        selfm.UpSellingId = ko.observable(data.UpSellingId).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            }
        });
        selfm.CodigoCampana = ko.observable(data.CodigoCampana).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            }
        });

        selfm.TextoMetaPrincipal = ko.observable(data.TextoMetaPrincipal).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Texto requerido"
        });
        selfm.TextoInferior = ko.observable(data.TextoInferior).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Texto requerido"
        });
        selfm.TextoGanastePrincipal = ko.observable(data.TextoGanastePrincipal).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Texto requerido"
        });
        selfm.TextoGanasteBoton = ko.observable(data.TextoGanasteBoton).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Texto requerido"
        });
        selfm.TextoGanastePremio = ko.observable(data.TextoGanastePremio).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Texto requerido"
        });
        selfm.ImagenFondoPrincipalDesktop = ko.observable(data.ImagenFondoPrincipalDesktop).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Requerido"
        });
        selfm.ImagenFondoPrincipalMobile = ko.observable(data.ImagenFondoPrincipalMobile).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Requerido"
        });
        selfm.ImagenFondoGanasteMobile = ko.observable(data.ImagenFondoGanasteMobile).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            },
            required: "Requerido"
        });


        selfm.Activo = ko.observable(data.Activo).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty
            }
        });
        selfm.Regalos = ko.observableArray().extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.upSellingSeleccionadoIsDirty,
                isArray: true
            }
        });

        if (!!data.Regalos && data.Regalos.length > 0) {
            selfm.Regalos(data.Regalos.map(function (regalo) {
                return new UpSellingRegaloModel(regalo);
            }));
        }

        //behavior
        selfm.ImagenFondoPrincipalDesktopUrl = ko.computed(function () {
            if (selfm.ImagenFondoPrincipalDesktop.isDirty()) {
                return settings.urlTemporal + selfm.ImagenFondoPrincipalDesktop();
            }

            return selfm.ImagenFondoPrincipalDesktop();

        }); //default
        selfm.ImagenFondoPrincipalMobileUrl = ko.computed(function () {
            if (selfm.ImagenFondoPrincipalMobile.isDirty()) {
                return settings.urlTemporal + selfm.ImagenFondoPrincipalMobile();
            }

            return selfm.ImagenFondoPrincipalMobile();

        }); //default
        selfm.ImagenFondoGanasteMobileUrl = ko.computed(function () {
            if (selfm.ImagenFondoGanasteMobile.isDirty()) {
                return settings.urlTemporal + selfm.ImagenFondoGanasteMobile();
            }

            return selfm.ImagenFondoGanasteMobile();

        }); //default

        //behavior
        selfm.isValid = function () {
            var keys = Object.keys(selfm);
            if (!keys || !(keys.length > 0))
                return false;

            var invalidProperties = keys.filter(function (key) {
                return (selfm.hasOwnProperty(key) && ko.isObservable(selfm[key]) && typeof selfm[key].hasError === 'function' && selfm[key].hasError());
            });

            return invalidProperties.length == 0;
        }
    }

    function UpSellingRegaloModel(data) {
        var selfm = this;
        selfm.UpSellingRegaloId = ko.observable(data.UpSellingRegaloId);
        selfm.CUV = ko.observable(data.CUV).extend({
            trackChange: {
                track: true
            },
            required: "CUV requerido"
        });
        selfm.Nombre = ko.observable(data.Nombre).extend({
            trackChange: {
                track: true
            },
            required: "Nombre requerido"
        });
        selfm.Descripcion = ko.observable(data.Descripcion).extend({
            trackChange: {
                track: true
            }
        });
        selfm.Imagen = ko.observable(data.Imagen).extend({
            trackChange: {
                track: true,
                cb: self.upSellingViewModel.actualizarRutaPrefixRegalo
            },
            required: "Imagen Requerida"
        });
        selfm.Stock = ko.observable(data.Stock).extend({
            trackChange: {
                track: true
            },
            required: "Stock requerido"
        });
        selfm.StockActual = ko.observable(data.StockActual);
        selfm.Orden = ko.observable(data.Orden).extend({
            trackChange: {
                track: true
            },
            required: "Orden Requerido"
        });
        selfm.Activo = ko.observable(data.Activo).extend({
            trackChange: {
                track: true
            }
        });

        //behaviors
        selfm.ImagenRuta = ko.observable(data.Imagen); //start value

        selfm.UndoChanges = function () {
            selfm.CUV.undoChanges();
            selfm.Nombre.undoChanges();
            selfm.Descripcion.undoChanges();
            selfm.Imagen.undoChanges();
            selfm.Stock.undoChanges();
            selfm.Orden.undoChanges();
            selfm.Activo.undoChanges();
        }
        selfm.isValid = function () {
            return !(selfm.CUV.hasError() ||
                selfm.Nombre.hasError() ||
                selfm.Stock.hasError() ||
                selfm.Orden.hasError() ||
                selfm.Imagen.hasError());
        }
    }

    function upSellingDefault() {
        return new UpSellingModel({
            UpSellingId: null,
            CodigoCampana: null,
            TextoMetaPrincipal: null,
            TextoInferior: null,
            TextoGanastePrincipal: null,
            TextoGanasteBoton: null,
            TextoGanastePremio: null,
            ImagenFondoPrincipalDesktop: null,
            ImagenFondoPrincipalMobile: null,
            ImagenFondoGanasteMobile: null,
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
        selfvm.upSellingSeleccionado = ko.observable().extend({
            trackChange: {
                track: true,
                cb: selfvm.upSellingSeleccionadoIsDirty
            }
        });
        selfvm.mostrarFormularioUpSelling = ko.observable(false);
        selfvm.regaloSeleccionado = ko.observable();
        selfvm.regaloEsNuevo = ko.observable(true);
        selfvm.campanasPais = settings.campanasPais.map(function (campana) {
            return {
                Id: campana.CampaniaID,
                Codigo: campana.Codigo
            };
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
                        fail(result);
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
            selfvm.recargarGanadoras = ko.observable(true);
            if (!selfvm.upSellingSeleccionado().isValid()) {
                alert("Los campos marcados son necesarios");
                return;
            }

            waitingDialog({});
            api.upSellingGuardarPromise(ko.toJS(selfvm.upSellingSeleccionado))
                .then(function (result) {
                    if (!result.Success) {
                        fail(result);
                        return;
                    }

                    var upSellingData = new UpSellingModel(result.Data);
                    selfvm.upSellingSeleccionado(upSellingData); //should be default
                    enableTabs(settings.idTabs);
                    alert("Guardado correctamente");
                    selfvm.mostrarFormularioUpSelling(false);
                    selfvm.upSellingSeleccionadoIsDirty(false);
                    cargarGrilla();
                }, fail)
                .always(function () {
                    closeWaitingDialog();
                });
        }

        selfvm.cancel = function () {

            if (!selfvm.upSellingSeleccionadoIsDirty()) {
                selfvm.recargarGanadoras = ko.observable(true);
                selfvm.esconderEditor();
                return false;
            }

            if (confirm("Podrías perder tus cambios, ¿Seguro que quieres salir?")) {
                selfvm.esconderEditor();
            }
        }

        selfvm.regaloNuevo = function () {
            selfvm.regaloSeleccionado(regaloDefault());
            selfvm.regaloSeleccionado().Imagen.setOriginalValue(selfvm.regaloSeleccionado().Imagen())
            showDialog(settings.idDivPopUpRegalo);
            selfvm.regaloEsNuevo(true);
        }

        selfvm.regaloEditar = function (regalo) {
            
            showDialog(settings.idDivPopUpRegalo);
            selfvm.regaloSeleccionado(regalo);
            selfvm.regaloSeleccionado().CUV.setCurrentValueAsOriginal();
            selfvm.regaloSeleccionado().Nombre.setCurrentValueAsOriginal();
            selfvm.regaloSeleccionado().Descripcion.setCurrentValueAsOriginal();
            selfvm.regaloSeleccionado().Imagen.setCurrentValueAsOriginal();
            selfvm.regaloSeleccionado().Stock.setCurrentValueAsOriginal();
            selfvm.regaloSeleccionado().Orden.setCurrentValueAsOriginal();
            selfvm.regaloSeleccionado().Activo.setCurrentValueAsOriginal();

            selfvm.regaloEsNuevo(false);
        }

        selfvm.regaloAgregar = function () {
            if (!selfvm.regaloSeleccionado().isValid()) {
                alert("Los campos marcados son necesarios");
                return;
            }

            selfvm.upSellingSeleccionado().Regalos.push(selfvm.regaloSeleccionado());
            selfvm.ordernarRegalos();
            selfvm.regaloSeleccionado(null);
            HideDialog(settings.idDivPopUpRegalo);
        }

        selfvm.regaloActualizar = function () {
            if (!selfvm.regaloSeleccionado().isValid()) {
                alert("Los campos marcados son necesarios");
                return;
            }

            selfvm.ordernarRegalos();
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

        selfvm.ordernarRegalos = function () {
            selfvm.upSellingSeleccionado().Regalos(selfvm.upSellingSeleccionado().Regalos.sort(function (left, rigth) {
                return Number(left.Orden()) - Number(rigth.Orden())
            }));
        }

        selfvm.actualizarRutaPrefixRegalo = function () {
            var ruta = settings.urlTemporal + selfvm.regaloSeleccionado().Imagen();
            selfvm.regaloSeleccionado().ImagenRuta(ruta);
        }

        selfvm.esconderEditor = function () {
            selfvm.upSellingSeleccionado(null);
            selfvm.regaloSeleccionado(null);
            selfvm.mostrarFormularioUpSelling(false);
        }

        selfvm.preventLeave = function (e, s) {
            if (selfvm.upSellingSeleccionadoIsDirty()) {
                var dialogText = "Podrías perder tus cambios, ¿Seguro que quieres salir?";
                e.returnValue = dialogText;
                return dialogText;
            }
        }

        selfvm.recargarGanadoras = ko.observable(true);

        selfvm.TraerListaGanadoras = function () {

            if (selfvm.recargarGanadoras()) {
                cargarGrillaListaGanadoras(selfvm.upSellingSeleccionado().UpSellingId());
                selfvm.recargarGanadoras(false);
            }
        }

        selfvm.exportarListaGanadoras = function () {

            $("[name='" + settings.idListaGanadorasHidden + "']").val(selfvm.upSellingSeleccionado().UpSellingId());
            $("[name='" + settings.idCampaniaHidden + "']").val(selfvm.upSellingSeleccionado().CodigoCampana());
            $("#" + settings.idFormReporteListaGanadoras + "").submit();
        }

    }

    self.upSellingViewModel = new UpSellingViewModel();
    ko.applyBindings(self.upSellingViewModel, document.getElementById(settings.idTargetDiv));
    initBindings();




    function cargarGrillaListaGanadoras(upSellingId) {

        jQuery.ajax({
            type: 'GET',
            url: baseUrl + 'UpSelling/ObtenerListadoGanadoras',
            dataType: 'json',
            data: {
                upSellingId: upSellingId
            },
            contentType: 'application/json; charset=utf-8',
            async: true,
            success: function (response) {

                configureGridListaGanadoras(response);
            },
        });


    }

    function configureGridListaGanadoras(response) {

        var data = response.Data;


        var grilla = $("#listOfertaFinalMontoMeta");

        grilla.jqGrid("GridUnload");

        grilla.jqGrid({
            hidegrid: false,
            datatype: "local",
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            multiselect: false,
            colNames: ["Campaña", "Cod Consultora", "Nombre de Consultora", "CUV Regalo", "Nombre Regalo", "Monto Inicial", "Rango Inicial", "Rango Final", "Monto a Agregar", "Monto Meta", "Monto Ganador", "Monto Real", "Fecha Registro"],
            colModel: [
                 { name: "Campania", index: "Campania", width: 40, sortable: false, align: "center" },
                 { name: "Codigo", index: "Codigo", width: 40, sortable: false, align: "center" },
                 { name: "Nombre", index: "Nombre", width: 120, sortable: false, align: "left" },
                 { name: "CuvRegalo", index: "CuvRegalo", width: 40, sortable: false, align: "center" },
                 { name: "NombreRegalo", index: "NombreRegalo", width: 110, sortable: false, align: "left" },
                 { name: "MontoInicial", index: "MontoInicial", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                 { name: "RangoInicial", index: "RangoInicial", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                 { name: "RangoFinal", index: "RangoFinal", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                 { name: "MontoAgregar", index: "MontoAgregar", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                 { name: "MontoMeta", index: "MontoMeta", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                 { name: "MontoGanador", index: "MontoGanador", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                   { name: "ImporteReal", index: "ImporteReal", width: 40, sortable: false, align: "right", formatter: 'number', formatoptions: { decimalPlaces: 2 } },
                 { name: "FechaRegistro", index: "FechaRegistro", width: 130, sortable: false, align: "center" },                  
            ],
            pager: jQuery("#pagerListaRegalos"),
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
            width: 900,
            pgtext: "Pág: {0} de {1}",
            altRows: false
        });
        grilla.jqGrid('navGrid', '#pagerListaRegalos', { add: false, edit: false, del: false, search: false, refresh: true });

        for (var i = 0; i <= data.length - 1; i++) {
            convertirStringDate(data[i], 'FechaRegistro');
            grilla.jqGrid('addRowData', i + 1, data[i]);
        }

        $('#refresh_listOfertaFinalMontoMeta').click();

    }

    function convertirStringDate(row, field) {

        JSON.parse('{ "' + field + '":"' + row[field] + '"}', function (key, value) {
            if (typeof value === 'string') {
                var d = /\/Date\((\d*)\)\//.exec(value);
                return (d) ? new Date(+d[1]) : value;
            }
            row[field] = value[field].toLocaleString();
        });


    }
}


