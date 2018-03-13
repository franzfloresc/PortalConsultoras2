var ReporteValidacion = function (config) {

    var _config = {
        urlObtenterCampanias: config.urlObtenterCampanias,
        urlExportarExcel: config.urlExportarExcel
    }

    var _obtenerCampanias = function () {
        $("#hdTipoConsulta").attr("value", "0");
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


    var _initialize = function () {
        jQuery(document).ready(function () {
            _obtenerCampanias();
            $("#btnExportarExcel").click(_exportarExcel);
        });
    }

    return {
        init: _initialize
    }
};