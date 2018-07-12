var NuevoMasivo = (function (config) {
    //'use strict';
    var _config = {
        habilitarNemotecnico: config.habilitarNemotecnico || false,
        urlConsultarOfertasPersonalizadas: config.urlConsultarOfertasPersonalizadas,
        urlConsultarCuvTipoConfigurado: config.urlConsultarCuvTipoConfigurado,
        urlEstrategiaTemporalInsert: config.urlEstrategiaTemporalInsert,
        urlEstrategiaTemporalConsultar: config.urlEstrategiaTemporalConsultar,
        urlEstrategiaTemporalCancelar: config.urlEstrategiaTemporalCancelar,
        urlConsultarCuvTipoConfiguradoTemporal: config.urlConsultarCuvTipoConfiguradoTemporal,
        urlEstrategiaOfertasPersonalizadasInsert: config.urlEstrategiaOfertasPersonalizadasInsert,
        MensajeErrorGeneral: config.MensajeErrorGeneral || ""
    };

    var _variables = {
        cantidadPrecargar: 0,
        cantidadPrecargar2: 0,
        cantidadTotal: 0,
        NroLote: 0,
        Pagina: 0,
        CantidadCuv: 0
    }

    var _codigoEstrategia = {
        OfertaParaTi: "001",
        PackNuevas: "002",
        OfertaWeb: "003",
        Lanzamiento: "005",
        OfertasParaMi: "007",
        PackAltoDesembolso: "008",
        OfertaDelDia: "009",
        GuiaDeNegocio: "010",
        LosMasVendidos: "020",
        HerramientaVenta: "011",
        ShowRoom: "030"
    }


    var _showActionsVer1 = function (cellvalue, options, rowObject) {

        var cantidad = rowObject[2];
        var tipo = rowObject[3];

        if (tipo == "2")
            _variables.cantidadPrecargar = parseInt(cantidad);

        else if (tipo == "0")
            _variables.cantidadTotal = parseInt(cantidad);

        var text;
        if (cantidad != "0")
            text = rowObject[2] +
                " <a href='javascript:;' onclick=admNuevoMasivoModulo.VerCuvsTipo('" +
                tipo +
                "')>ver</a>";
        else
            text = rowObject[2];

        return text;
    }
    var _showActionsVer2 = function (cellvalue, options, rowObject) {
        
        var cantidad = rowObject[2];
        var tipo = rowObject[3];

        if (tipo == "1") {
            _variables.cantidadPrecargar2 = parseInt(cantidad);
            $("#spnCantidadConfigurar3").html(parseInt(cantidad));
        }
        if (tipo == "2")
            $("#spnCantidadNoConfigurar3").html(parseInt(cantidad));

        var text;
        if (cantidad != "0")
            text = rowObject[2] +
                " <a href='javascript:;' onclick=admNuevoMasivoModulo.VerCuvsTipo2('" +
                tipo +
                "')>ver</a>";
        else
            text = rowObject[2];

        return text;
    }

    var _fnGrillaEstrategias1 = function () {
        console.log('_fnGrillaEstrategias1 Inicio', new Date());
        $("#listCargaMasiva1").jqGrid("GridUnload");
        jQuery("#listCargaMasiva1").jqGrid({
            url: _config.urlConsultarOfertasPersonalizadas,
            hidegrid: false,
            datatype: "json",
            postData: ({
                campaniaId: $("#ddlCampania").val(),
                codigoEstrategia: $("#ddlTipoEstrategia").find(":selected").data("codigo")
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["Id", "Descripción", "Cantidad"],
            colModel: [
                { name: "Id", index: "Id", width: 100, editable: true, resizable: false, hidden: true },
                { name: "Descripcion", index: "Descripcion", width: 100, editable: true, resizable: false },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 30,
                    align: "center",
                    editable: true,
                    resizable: false,
                    formatter: _showActionsVer1
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
            pager: jQuery("#pagerCargaMasiva1"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function (data) {
                $("#precargadosdiv").html(JSON.parse(JSON.stringify(data.rows[2].cell))[4]);
            },
            gridComplete: function (data) {
                console.log('_fnGrillaEstrategias1 gridComplete', new Date());
                if (_variables.cantidadPrecargar == 0) {
                    $("#divMostrarPreCarga").css("display", "none");
                } else {
                    $("#divMostrarPreCarga").css("display", "");
                    $("#spnCantidadConfigurar1").html(_variables.cantidadPrecargar);
                }
            }
        });
        jQuery("#listCargaMasiva1").jqGrid("navGrid",
            "#pagerCargaMasiva1",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listCargaMasiva1").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }
    var _fnGrillaEstrategias2 = function () {
        waitingDialog();
        console.log('ejecutando de _fnGrillaEstrategias2 - inicio', new Date());
        $("#listCargaMasiva2").jqGrid("GridUnload");
        console.log(_config.urlEstrategiaTemporalConsultar);
        jQuery("#listCargaMasiva2").jqGrid({
            url: _config.urlEstrategiaTemporalConsultar,
            hidegrid: false,
            datatype: "json",
            postData: ({
                nroLote: _variables.NroLote,
                campaniaId: $("#ddlCampania").val(),
                codigoEstrategia: $("#ddlTipoEstrategia").find(":selected").data("codigo")
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["Id", "Descripción", "Cantidad"],
            colModel: [
                { name: "Id", index: "Id", width: 100, editable: true, resizable: false, hidden: true },
                { name: "Descripcion", index: "Descripcion", width: 100, editable: true, resizable: false },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 30,
                    align: "center",
                    editable: true,
                    resizable: false,
                    formatter: _showActionsVer2
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
            pager: jQuery("#pagerCargaMasiva2"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function () { },
            gridComplete: function () {
                console.log('ejecutando de _fnGrillaEstrategias2 - gridComplete - inicio', new Date());
                closeWaitingDialog();
                if (_variables.cantidadPrecargar2 == 0) {
                    $("#divMostrarPreCarga2").css("display", "none");
                } else {
                    $("#divMostrarPreCarga2").css("display", "");
                    $("#spnCantidadConfigurar2").html(_variables.cantidadPrecargar2);
                }

                $("#divMasivoPaso1").hide();
                $("#divMasivoPaso2").show();

                $("#divPaso1").removeClass("boton_redondo_admcontenido_on");
                $("#divPaso1").addClass("boton_redondo_admcontenido_off");

                $("#divPaso2").removeClass("boton_redondo_admcontenido_off");
                $("#divPaso2").addClass("boton_redondo_admcontenido_on");
            }
        });
        jQuery("#listCargaMasiva2").jqGrid("navGrid", "#pagerCargaMasiva2",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listCargaMasiva2").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");

        console.log('ejecutando de _fnGrillaEstrategias2 - gridComplete - fin');
    }
    var _fnGrillaCuv1 = function (tipo) {
        $("#listGrillaCuv1").jqGrid("clearGridData");

        var parametros = {
            campaniaId: parseInt($("#ddlCampania").val()),
            tipoConfigurado: parseInt(tipo),
            estrategiaCodigo: $("#ddlTipoEstrategia").find(":selected").data("codigo"),
            estrategiaMIds: $('#precargadosdiv').text()
        };

        $("#listGrillaCuv1").setGridParam({ postData: parametros });

        jQuery("#listGrillaCuv1").jqGrid({
            url: _config.urlConsultarCuvTipoConfigurado,
            hidegrid: false,
            datatype: "json",
            postData: (parametros),
            mtype: "POST",
            contentType: "application/json; charset=utf-8",
            colNames: ["CUV", "Descripción"],
            colModel: [
                { name: "CUV2", index: "CUV", width: 10, editable: true, resizable: false },
                { name: "DescripcionCUV2", index: "DescripcionCUV2", width: 90, editable: true, resizable: false }
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
            pager: jQuery("#pagerGrillaCuv1"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Nombre",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function () {
            },
            gridComplete: function () {
                showDialog("DialogGrillaCuv1");
            }
        });
        jQuery("#listGrillaCuv1").jqGrid("navGrid",
            "#pagerGrillaCuv1",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listGrillaCuv1").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }
    var _fnGrillaCuv2 = function (tipo) {
        $("#listGrillaCuv2").jqGrid("clearGridData");

        var estrategiaId;
        if (tipo == 1) {
            estrategiaId = $('#precargadosdiv').text();
        }
        if (tipo == 2) {
            estrategiaId = $('#cargadoserrordiv').text();
        }

        var parametros = {
            tipoConfigurado: parseInt(tipo),
            nroLote: _variables.NroLote,
            campaniaId: $("#ddlCampania").val(),
            codigoEstrategia: $("#ddlTipoEstrategia").find(":selected").data("codigo"),
            estrategiaMIds: estrategiaId
        };

        $("#listGrillaCuv2").setGridParam({ postData: parametros });

        jQuery("#listGrillaCuv2").jqGrid({
            url: _config.urlConsultarCuvTipoConfiguradoTemporal,
            hidegrid: false,
            datatype: "json",
            postData: (parametros),
            mtype: "POST",
            contentType: "application/json; charset=utf-8",
            colNames: ["CUV", "Descripción"],
            colModel: [
                { name: "CUV2", index: "CUV", width: 10, editable: true, resizable: false },
                { name: "DescripcionCUV2", index: "DescripcionCUV2", width: 90, editable: true, resizable: false }
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
            pager: jQuery("#pagerGrillaCuv2"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Nombre",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function () {
            },
            gridComplete: function () {
                showDialog("DialogGrillaCuv2");
            }
        });
        jQuery("#listGrillaCuv2").jqGrid("navGrid",
            "#pagerGrillaCuv2",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listGrillaCuv2").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }

    var _variablesInicializar = function () {
        _variables.cantidadPrecargar = 0;
        _variables.cantidadPrecargar2 = 0;
        _variables.cantidadTotal = 0;
        _variables.NroLote = 0;
        _variables.Pagina = 0;
        _variables.CantidadCuv = 0;
    }

    var _validarMasivo = function () {
        if ($("#ddlPais").val() === "") {
            _toastHelper.error("Debe seleccionar el País, verifique.");
            return false;
        }
        if ($("#ddlCampania").val() === "") {
            _toastHelper.error("Debe seleccionar la Campaña, verifique.");
            return false;
        }
        if ($("#ddlTipoEstrategia").val() === "") {
            _toastHelper.error("Debe seleccionar un tipo de estrategia, verifique.");
            return false;
        }

        var estrategiaCodigo = $("#ddlTipoEstrategia option:selected").data("codigo") || "";
        if (!estrategiaCodigo.in(_codigoEstrategia.OfertaParaTi,
            _codigoEstrategia.GuiaDeNegocio,
            _codigoEstrategia.LosMasVendidos,
            _codigoEstrategia.Lanzamiento,
            _codigoEstrategia.OfertasParaMi,
            _codigoEstrategia.PackAltoDesembolso,
            _codigoEstrategia.OfertaDelDia,
            _codigoEstrategia.ShowRoom,
            _codigoEstrategia.HerramientaVenta)) {

            _toastHelper.error("Debe seleccionar el tipo de Estrategia que permita esta funcionalidad.");
            return false;
        }

        return true;
    }

    var _iniDialog = function () {

        $("#DialogNuevoMasivo").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de Estrategias"
        });

        $("#DialogGrillaCuv1").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de Estrategias",
            buttons:
            {
                "Salir": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogGrillaCuv2").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de Estrategias",
            buttons:
            {
                "Salir": function () {
                    $(this).dialog("close");
                }
            }
        });

    }

    var _eventos = {
        clickNuevoMasivo: function () {
            console.log('clickNuevoMasivo Inicio', new Date());
            _variablesInicializar();
            if (_validarMasivo()) {
                $("#divMasivoPaso1").show();
                $("#divMasivoPaso2").hide();
                $("#divMasivoPaso3").hide();

                $("#divPaso1").removeClass("boton_redondo_admcontenido_off");
                $("#divPaso1").addClass("boton_redondo_admcontenido_on");

                $("#divPaso2").removeClass("boton_redondo_admcontenido_on");
                $("#divPaso2").addClass("boton_redondo_admcontenido_off");

                $("#divPaso3").removeClass("boton_redondo_admcontenido_on");
                $("#divPaso3").addClass("boton_redondo_admcontenido_off");

                _fnGrillaEstrategias1();
                showDialog("DialogNuevoMasivo");
            }
        },
        clickAceptarMasivo1: function () {
            console.log('clickAceptarMasivo1 Inicio', new Date());
            var params = {
                CampaniaId: parseInt($("#ddlCampania").val()),
                TipoConfigurado: 2,
                EstrategiaCodigo: $("#ddlTipoEstrategia").find(":selected").data("codigo"),
                HabilitarNemotecnico: _config.habilitarNemotecnico,
                CantTotal: _variables.cantidadTotal,
                NroLote: _variables.NroLote,
                Pagina: _variables.Pagina,
                CantidadCuv: _variables.CantidadCuv
            };

            waitingDialog();

            jQuery.ajax({
                type: "POST",
                url: _config.urlEstrategiaTemporalInsert,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function (data) {
                    console.log('Respuesta ' + _config.urlEstrategiaTemporalInsert, new Date());
                    console.log(data);
                    closeWaitingDialog();
                    if (data.success) {
                        if (data.continuaPaso == undefined) {
                            data.messageComplemento = data.messageComplemento || "";
                            if (data.messageComplemento == "") {
                                _variables.Pagina = (data.Pagina || 0) + 1;
                                _variables.NroLote = data.NroLote;
                                _variables.CantidadCuv = _variables.CantidadCuv || data.CantidadCuv;
                                _eventos.clickAceptarMasivo1();
                            }
                            else {
                                _eventos.clickCancelarMasivo1();
                                _toastHelper.error(data.messageComplemento);
                            }
                        }
                        else if (data.continuaPaso === true) {
                            console.log('antes de _fnGrillaEstrategias2', new Date());
                            closeWaitingDialog();
                            _fnGrillaEstrategias2();
                        }
                    } else {
                        _eventos.clickCancelarMasivo1();
                        _toastHelper.error(data.message);
                    }
                },
                error: function (data, error) {
                    console.log(data);
                    closeWaitingDialog();
                    _toastHelper.error(_config.MensajeErrorGeneral);
                }
            });
        },
        clickAceptarMasivo2: function () {

            console.log('inicio de clickAceptarMasivo2', new Date());
            var params = {
                campaniaId: parseInt($("#ddlCampania").val()),
                tipoConfigurado: 1,
                estrategiaId: $("#ddlTipoEstrategia").find(":selected").data("id"),
                nroLote: _variables.NroLote,
                codigoEstrategia:$("#ddlTipoEstrategia").find(":selected").data("codigo"),
                estrategiaMIds: $('#precargadosdiv').text()
            };
            
            waitingDialog();

            jQuery.ajax({
                type: "POST",
                url: _config.urlEstrategiaOfertasPersonalizadasInsert,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function (data) {
                    console.log('respuesta ' + _config.urlEstrategiaOfertasPersonalizadasInsert, new Date());
                    console.log(data); 
                    if (data.success) {
                        $("#precargadosdiv").html(data.mongoIdsOK);
                        $("#cargadoserrordiv").html(data.mongoIdsERROR);

                        closeWaitingDialog();
                        $("#divMasivoPaso1").hide();
                        $("#divMasivoPaso2").hide();
                        $("#divMasivoPaso3").show();

                        $("#divPaso1").removeClass("boton_redondo_admcontenido_on");
                        $("#divPaso1").addClass("boton_redondo_admcontenido_off");

                        $("#divPaso2").removeClass("boton_redondo_admcontenido_on");
                        $("#divPaso2").addClass("boton_redondo_admcontenido_off");

                        $("#divPaso3").removeClass("boton_redondo_admcontenido_off");
                        $("#divPaso3").addClass("boton_redondo_admcontenido_on");
                    } else {
                        _toastHelper.error(data.message);
                        _eventos.clickCancelarMasivo1();
                    }
                },
                error: function (data, error) {
                    _toastHelper.error(_config.MensajeErrorGeneral);
                }
            });

            console.log('ejecutando clickAceptarMasivo2 - fin'); 
        },
        clickCancelarMasivo1: function () {
            _variablesInicializar();
            HideDialog("DialogNuevoMasivo");
            closeWaitingDialog();
        },
        clickCancelarMasivo2: function () {

            console.log('ejecutando clickCancelarMasivo2 - inicio'); 
            var params = {
                nroLote: _variables.NroLote
            };

            jQuery.ajax({
                type: "POST",
                url: _config.urlEstrategiaTemporalCancelar,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function (data) {

                    console.log('ejecutando clickAceptarMasivo2 - ajax - inicio', data); 
                    if (data.success) {
                        _variablesInicializar();
                        HideDialog("DialogNuevoMasivo");
                        _toastHelper.success(data.message);
                    }
                    else {
                        _toastHelper.error(data.message);
                    }
                },
                error: function (data, error) {
                    _toastHelper.error(_config.MensajeErrorGeneral);
                }
            });

            console.log('ejecutando clickCancelarMasivo2 - fin'); 
        },
        clickAceptarMasivo3: function () {
            _variablesInicializar();
            HideDialog("DialogNuevoMasivo");
            closeWaitingDialog();
        },
    }

    var _bindingEvents = function () {
        $("body").on("click", "#btnNuevoMasivo", _eventos.clickNuevoMasivo);
        $("body").on("click", "#btnAceptarMasivo1", _eventos.clickAceptarMasivo1);
        $("body").on("click", "#btnAceptarMasivo2", _eventos.clickAceptarMasivo2);
        $("body").on("click", "#btnCancelarMasivo1", _eventos.clickCancelarMasivo1);
        $("body").on("click", "#btnCancelarMasivo2", _eventos.clickCancelarMasivo2);
        $("body").on("click", "#btnAceptarMasivo3", _eventos.clickAceptarMasivo3);
    }

    // Public functions 
    function VerCuvsTipo(tipo) {
        _fnGrillaCuv1(tipo);
    }
    function VerCuvsTipo2(tipo) {
        _fnGrillaCuv2(tipo);
    }

    function Inicializar() {
        _iniDialog();
        _bindingEvents();
    }

    return {
        Inicializar: Inicializar,
        VerCuvsTipo: VerCuvsTipo,
        VerCuvsTipo2: VerCuvsTipo2
    }
});