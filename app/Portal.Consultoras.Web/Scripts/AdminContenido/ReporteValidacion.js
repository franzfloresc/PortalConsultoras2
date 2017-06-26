var ReporteValidacion = function (config) {

    var _config = {
        urlObtenterCampanias: config.urlObtenterCampanias,
        urlExportarExcel: config.urlExportarExcel
    }

    var _obtenerCampanias = function () {
        $("#hdTipoConsulta").attr("value", "0");
        $("#list").jqGrid("clearGridData", true).trigger("reloadGrid");
        var Id = $(this).val();
        waitingDialog({});
        $.ajaxSetup({ cache: false });
        $.ajax({
            type: 'GET',
            url: _config.urlObtenterCampanias,
            data: "PaisID=" + (Id == "" ? 0 : Id),
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

                        if (Id != "") {
                            for (var item in data.lista) {
                                ddlCampania.append($('<option/>', {
                                    value: data.lista[item].CampaniaID,
                                    text: data.lista[item].Codigo
                                }));
                            }
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

        waitingDialog({});
        $.ajaxSetup({ cache: false });
        $.ajax({
            type: 'GET',
            url: _config.urlExportarExcel,
            data: ({
                CampaniaID: $("#ddlCampania").val(),
                TipoEstrategiaID: $('#ddlTipoEstrategia').find(':selected').data('id')
            }),
            cache: false,
            dataType: 'Json',
            success: function (data) {
                if (checkTimeout(data)) {
                  
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

    var _initialize = function () {
        jQuery(document).ready(function () {
            $('#ddlPais').change(_obtenerCampanias);
            $("#btnExportarExcel").click(_exportarExcel);
        });
    }

    return {
        init : _initialize
    }
};