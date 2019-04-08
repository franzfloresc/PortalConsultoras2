var ReporteRevisionIncidencias = function (config) {

    var _config = {
        urlObtenterCampanias: config.urlObtenterCampanias,
        urlExportarExcel: config.urlExportarExcel
    }

    var _obtenerCampanias = function () {
        $("#list").jqGrid("clearGridData", true).trigger("reloadGrid");
        waitingDialog({});
        $.ajaxSetup({ cache: false });
        $.ajax({
            type: 'GET',
            url: _config.urlObtenterCampanias,
            cache: false,
            dataType: 'Json',
            success: function (data) {
                if (checkTimeout(data)) {
                    var ddlCampania = $('#ddlCampania');
                    ddlCampania.empty();
                    if (data.lista.length > 0) {
                        ddlCampania.append($('<option/>', {
                            value: "",
                            text: "-- Seleccionar --"
                        }));

                        for (var item in data.lista) {
                            ddlCampania.append($('<option/>', {
                                value: data.lista[item].CampaniaID,
                                text: data.lista[item].Codigo
                            }));
                        }
                    }
                    closeWaitingDialog();
                }
            },
            error: function (x, xh, xhr) {
                if (checkTimeout(x)) {
                    closeWaitingDialog();
                }
            }
        });
    }

    var _exportarExcel = function () {
        if ($("#ddlPais").val() == "") {
            alert("Debe seleccionar el País, verifique.");
            return false;
        }
        if ($("#ddlCampania").val() == "") {
            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }
        if ($("#ddlTipoEstrategia").val() == "") {
            alert("Debe seleccionar el tipo de estrategia, verifique.");
            return false;
        }

        setTimeout(function () {
            _downloadAttachExcel();
        }, 0);
    }

    var _downloadAttachExcel = function () {
        var content = _config.urlExportarExcel +
            "?CampaniaID=" +
            $("#ddlCampania").val() +
            "&TipoEstrategiaID=" +
            $('#ddlTipoEstrategia').find(':selected').data('id');

        var iframe_ = document.createElement("iframe");
        iframe_.style.display = "none";
        iframe_.setAttribute("src", content);

        iframe_.onload = function () {
            closeWaitingDialog();
        };

        if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {
            // Si es Internet Explorer
            iframe_.onreadystatechange = function () {
                switch (this.readyState) {
                    case "loading":
                        waitingDialog({});
                        break;
                    case "complete":
                    case "interactive":
                    case "uninitialized":
                        closeWaitingDialog();
                        break;
                    default:
                        closeWaitingDialog();
                        break;
                }
            };
        }
        else {
            $(iframe_).ready(function () {
            });
        }

        document.body.appendChild(iframe_);
    }

    var _paginador = Paginador({
        elementId: "matriz-" +
            "imagen" +
            "es-paginacion"
    });

    var _basicFieldsValidation = function () {
        if ($("#ddlTipo").val() == "") {
            _toastHelper.error("Debe seleccionar el tipo de revisión, verifique.");
            return false;
        }

        var tipoConsulta = $("#ddlTipo").val();

        if ($("#ddlCampania").val() === "") {
            _toastHelper.error("Debe seleccionar la Campaña, verifique.");
            return false;
        }

        if (tipoConsulta == "1" || tipoConsulta == "2") {
            if ($("#CUV").val() === "") {
                _toastHelper.error("Debe digitar un cuv correcto, verifique.");
                return false;
            }
        }

        if (tipoConsulta == "3") {
            if ($("#txtConsultora").val() === "") {
                _toastHelper.error("Debe digitar un código de consultora, verifique.");
                return false;
            }

            if ($("#ddlTipoEstrategia").val() === "") {
                _toastHelper.error("Debe seleccionar un tipo de estrategia, verifique.");
                return false;
            }

            if ($("#txtFechaConsulta").val() === "") {
                _toastHelper.error("Debe elegir una fecha de consulta.");
                return false;
            }
        }

        if (tipoConsulta == "4") {
            if ($("#txtConsultora").val() === "") {
                _toastHelper.error("Debe digitar un código de consultora, verifique.");
                return false;
            }
        }

        return true;
    }

    var _eventos = {
        clickBuscar: function () {
            if (!_basicFieldsValidation()) return false;
            $("#list").html("");

            _fnGrilla();

            return true;
        },
        changeTipo: function () {
            var tipoConsulta = $("#ddlTipo").val();

            $("#ddlTipoEstrategia").removeAttr("disabled");
            $("#txtFechaConsulta").removeAttr("disabled");
            $("#txtConsultora").removeAttr("disabled");
            $("#CUV").removeAttr("disabled");
            $(".ui-datepicker-trigger").show();

            if (tipoConsulta == "1" || tipoConsulta == "2") {
                $("#txtFechaConsulta").val("");
                $("#txtConsultora").val("");
                $("#ddlTipoEstrategia").val("")

                $("#ddlTipoEstrategia").attr("disabled", "disabled");
                $("#txtFechaConsulta").attr("disabled", "disabled");
                $("#txtConsultora").attr("disabled", "disabled");
                $(".ui-datepicker-trigger").hide();
            }

            if (tipoConsulta == "3") {
                $("#CUV").attr("disabled", "disabled");

                $("#CUV").val("");
            }

            if (tipoConsulta == "4") {
                $("#CUV").val("");
                $("#txtFechaConsulta").val("");
                $("#ddlTipoEstrategia").val("")

                $("#CUV").attr("disabled", "disabled");
                $("#ddlTipoEstrategia").attr("disabled", "disabled");
                $("#txtFechaConsulta").attr("disabled", "disabled");
                $(".ui-datepicker-trigger").hide();
            }
        },
    }

    var _bindingEvents = function () {
        $("body").on("click", "#btnBuscar", _eventos.clickBuscar);
        $("body").on("change", "#ddlTipo", _eventos.changeTipo);
    }

    var _initialize = function () {
        jQuery(document).ready(function () {
            _obtenerCampanias();
            _bindingEvents();
            _fnGrilla();

            // $("#btnExportarExcel").click(_exportarExcel);
        });
    }

    var _fnCuvResumido = function () {

        jQuery("#list").jqGrid({
            url: baseUrl + "AdministrarReporteRevisionIncidencias/ConsultarReporteCuvResumido",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                CUV: $("#CUV").val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: [
                "Cuv", "SAP", "Descripcion", "Palanca", "Imagen", "Palanca Activa", "Digitable", "Precio"
            ],
            colModel: [
                {
                    name: "Cuv",
                    index: "Cuv",
                    width: 50,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "SAP",
                    index: "SAP",
                    width: 80,
                    editable: true,
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "DescripcionProd",
                    index: "DescripcionProd",
                    width: 300,
                    editable: true,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "Palanca",
                    index: "Palanca",
                    width: 100,
                    editable: true,
                    align: "center",
                    resizable: false,
                    sortable: false
                },
                {
                    name: "imagenURL",
                    index: "imagenURL",
                    width: 250,
                    editable: true,
                    resizable: false,
                    sortable: true,
                    align: "center",
                    formatter: _showImagenCuv
                },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 100,
                    align: "center",
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "PuedeDigitarse",
                    index: "PuedeDigitarse",
                    width: 50,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: false
                },
                {
                    name: "PrecioSet",
                    index: "PrecioSet",
                    width: 50,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: true
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
            pager: jQuery("#pager"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            height: "auto",
            shrinkToFit: false,
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function (data) {

                if (data.rows.length > 0) {
                    for (var i = 0; i < data.rows.length; i++) {
                        if (data.rows[i].cell[10] == "1") {
                            $("#list").jqGrid("setSelection", data.rows[i].id, true);
                        }
                    }
                }
            },
            loadError: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR, textStatus, errorThrown);
            }
        });
    }

    var _showImagenCuv = function (cellvalue, options, rowObject) {
        var nombreImagen = rowObject[4];
        var rutaImagen = variablesPortal.ImgUrlBase + nombreImagen;
        var edit = "&nbsp;<a href='" + rutaImagen + "' target='_blank'>" + nombreImagen + "</a>";
        return edit;
    }

    var _fnCuvDetallado = function () {
        jQuery("#list").jqGrid({
            url: baseUrl + "AdministrarReporteRevisionIncidencias/ConsultarReporteCuvDetallado",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                CUV: $("#CUV").val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: [
                "Estrategia", "Padre", "Hijo", "Tipo", "Grupo", "SAP", "Marca Est.", "Marca Mtz.", "F.C",
                "Pre. Uni.", "Pre. Pub.", "Digitable", "Nombre", "Img Tipos", "Img Tonos", "N. Bulk", "F.Repet.",
                "RutaImagenTipos", "RutaImagenTonos"
            ],
            colModel: [
                {
                    name: "DescripcionEstrategia",
                    index: "DescripcionEstrategia",
                    width: 100,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "CuvPadre",
                    index: "CuvPadre",
                    width: 40,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "CuvHijo",
                    index: "CuvHijo",
                    width: 40,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "CodigoEstrategia",
                    index: "CodigoEstrategia",
                    width: 40,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "Grupo",
                    index: "Grupo",
                    width: 40,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "SAP",
                    index: "SAP",
                    width: 80,
                    editable: true,
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "MarcaEstrategia",
                    index: "MarcaEstrategia",
                    width: 70,
                    editable: true,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "MarcaMatriz",
                    index: "MarcaMatriz",
                    width: 70,
                    editable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "FactorCuadre",
                    index: "FactorCuadre",
                    width: 40,
                    editable: true,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "PrecioUnitario",
                    index: "PrecioUnitario",
                    width: 80,
                    align: "center",
                    editable: false,
                    resizable: false,
                    sortable: false
                },
                {
                    name: "PrecioPublico",
                    index: "PrecioPublico",
                    width: 80,
                    align: "center",
                    editable: false,
                    resizable: false,
                    sortable: false
                },
                {
                    name: "Digitable",
                    index: "Digitable",
                    width: 60,
                    editable: false,
                    align: "center",
                    resizable: false,
                    sortable: false
                },
                {
                    name: "NombreProducto",
                    index: "NombreProducto",
                    width: 300,
                    editable: false,
                    align: "center",
                    resizable: false,
                    sortable: false
                },
                {
                    name: "ImagenTipos",
                    index: "ImagenTipos",
                    width: 350,
                    editable: false,
                    resizable: false,
                    sortable: false,
                    align: "center",
                    formatter: _showImagenTipos
                },
                {
                    name: "ImagenTonos",
                    index: "ImagenTonos",
                    width: 350,
                    editable: false,
                    resizable: false,
                    sortable: false,
                    align: "center",
                    formatter: _showImagenTonos
                },
                {
                    name: "NombreBulk",
                    index: "NombreBulk",
                    width: 100,
                    align: "center",
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "FactorRepeticion",
                    index: "FactorRepeticion",
                    width: 70,
                    align: "center",
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "RutaImagenTipos",
                    index: "RutaImagenTipos",
                    width: 70,
                    align: "center",
                    resizable: false,
                    hidden: true,
                    sortable: false
                }
                ,
                {
                    name: "RutaImagenTonos",
                    index: "RutaImagenTonos",
                    width: 70,
                    align: "center",
                    resizable: false,
                    hidden: true,
                    sortable: false
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
            pager: jQuery("#pager"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            height: "auto",
            shrinkToFit: false,
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function (data) {

            },
            loadError: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR, textStatus, errorThrown);
            }

        });
    }

    var _showImagenTipos = function (cellvalue, options, rowObject) {
        var nombreImagen = rowObject[13];
        var rutaImagen = rowObject[17];
        var edit = "&nbsp;<a href='" + rutaImagen + "' target='_blank'>" + nombreImagen + "</a>";
        return edit;
    }

    var _showImagenTonos = function (cellvalue, options, rowObject) {
        var nombreImagen = rowObject[14];
        var rutaImagen = rowObject[18];
        var edit = "&nbsp;<a href='" + rutaImagen + "' target='_blank'>" + nombreImagen + "</a>";
        return edit;
    }

    var _fnEstrategiasConsultora = function () {

        var fechaConsulta = $("#txtFechaConsulta").val();
        var tipoEstrategia = $("#ddlTipoEstrategia").val();

        if (fechaConsulta == "") fechaConsulta = "01/01/1990";
        if (tipoEstrategia == "") tipoEstrategia = 0;

        jQuery("#list").jqGrid({
            url: baseUrl + "AdministrarReporteRevisionIncidencias/ConsultarReporteEstrategiasConsultora",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                TipoEstrategiaID: $("#ddlTipoEstrategia option:selected").data("id"),
                CodigoConsultora: $("#txtConsultora").val(),
                FechaConsulta: fechaConsulta
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: [
                "Cuv", "Descripcion"
            ],
            colModel: [
                {
                    name: "Cuv",
                    index: "Cuv",
                    width: 20,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "Descripcion",
                    index: "Descripcion",
                    width: 100,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
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
            pager: jQuery("#pager"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            height: "auto",
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function (data) {

                if (data.rows.length > 0) {
                    for (var i = 0; i < data.rows.length; i++) {
                        if (data.rows[i].cell[10] == "1") {
                            $("#list").jqGrid("setSelection", data.rows[i].id, true);
                        }
                    }
                }
            },
            loadError: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR, textStatus, errorThrown);
            }
        });
    }

    var _fnMovimientosPedido = function () {
        jQuery("#list").jqGrid({
            url: baseUrl + "AdministrarReporteRevisionIncidencias/ConsultarEliminacionCuvsPedido",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                CodigoConsultora: $("#txtConsultora").val(),
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: [
                "Cuv", "Descripción", "Fecha", "Origen", "Mensaje"
            ],
            colModel: [
                {
                    name: "Cuv",
                    index: "Cuv",
                    width: 20,
                    editable: false,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "Descripcion",
                    index: "Descripcion",
                    width: 100,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "FechaAccion",
                    index: "FechaAccion",
                    width: 30,
                    editable: false,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "Origen",
                    index: "Origen",
                    width: 30,
                    editable: false,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "Mensaje",
                    index: "Mensaje",
                    width: 100,
                    editable: false,
                    resizable: false,
                    hidden: false
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
            pager: jQuery("#pager"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            height: "auto",
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function (data) {

                if (data.rows.length > 0) {
                    for (var i = 0; i < data.rows.length; i++) {
                        if (data.rows[i].cell[10] == "1") {
                            $("#list").jqGrid("setSelection", data.rows[i].id, true);
                        }
                    }
                }
            },
            loadError: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR, textStatus, errorThrown);
            }
        });
    }

    var _fnGrilla = function () {
        $("#divSeccionProductos").show();
        $("#list").jqGrid("GridUnload");
        var tipoConsulta = $("#ddlTipo").val();

        if (tipoConsulta == "0") return;

        if (tipoConsulta == "1") {
            _fnCuvResumido();
        } else if (tipoConsulta == "2") {
            _fnCuvDetallado();
        } else if (tipoConsulta == "3") {
            _fnEstrategiasConsultora();
        } else if (tipoConsulta == "4") {
            _fnMovimientosPedido();
        }

        jQuery("#list").jqGrid("navGrid",
            "#pager",
            { edit: false, add: false, refresh: false, del: false, search: false });

        $("<span style=\"position: absolute;margin-top: 10px;\">(*)</span>").prependTo("#jqgh_list_cb");
    }

    return {
        init: _initialize
    }
};