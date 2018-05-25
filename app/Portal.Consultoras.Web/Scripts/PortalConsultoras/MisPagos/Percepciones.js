$(document).ready(function () {
    CargarEscalaPercepciones();

    $("body").on("click", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "back" || accion === "next") {
            CambioPagina(obj);
        }
    });

    $("body").on("change", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "page" || accion === "rows") {
            CambioPagina(obj);
        }
    });
});

function CargarEscalaPercepciones(page, rows) {
    var obj = {
        sidx: "FechaEmision",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 10
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'MisPagos/ListarPercepciones',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                var htmlGrillaEscala = ArmarEscalaPercepciones(data.rows);
                $('.js-grilla-percepciones').html(htmlGrillaEscala);

                var htmlPaginador = ArmarPaginador(data);
                $('.js-paginador-percepciones').html(htmlPaginador);

                $(".js-paginador-percepciones [data-paginacion='rows']").val(data.pageSize || 10);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $('.js-grilla-percepciones').html("");
            }
        }
    });
}
function ArmarEscalaPercepciones(array) {
    return SetHandlebars("#producto-template", array);
}
function ArmarPaginador(data) {
    return SetHandlebars("#paginador-percepciones-template", data);
}
function ArmarDetallePercepcion(data) {
    return SetHandlebars("#popup-percepcion-template", data);
}
function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    CargarEscalaPercepciones(rpt.page, Number(rpt.rows));
    return true;
}
function CargarDetallePercepcion(obj) {
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + 'MisPagos/ObtenerDetallePercepcion',
        data: { ImportePercepcion: obj.ImportePercepcion },
        dataType: "json",
        success: function (response) {
            if (checkTimeout(response)) {
                $.ajax({
                    type: "POST",
                    url: baseUrl + "MisPagos/ListarDetallePercepcion",
                    data: { sidx: "FechaEmision", sord: "", page: 1, rows: 10, IdComprobantePercepcion: obj.IdComprobantePercepcion },
                    dataType: "json",
                    success: function (dataDetalle) {
                        if (checkTimeout(dataDetalle)) {
                            var data = $.extend({}, obj, response);
                            data.ListaDetalle = dataDetalle.rows;

                            var htmlDetallePercepcion = ArmarDetallePercepcion(data);
                            $(".popup_Percepcion").html(htmlDetallePercepcion);
                            MostrarDetallePercepcion();
                            closeWaitingDialog();
                        }
                    },
                    error: function (dataDetalle) {
                        closeWaitingDialog();
                    }
                });
            }
        }
    });
}
function MostrarDetallePercepcion() {
    $("html").css({ "overflow": "hidden" });
    $(".contenedor_popup_percepciones").fadeIn(300);

    $(".btn_cerrar_popupPercepcion").click(function () {
        $(".contenedor_popup_percepciones").fadeOut(300);
        $("html").css({ "overflow": "auto" });
    });
}
function ImprimirDetalle(RUCAgentePerceptor, NombreAgentePerceptor, NumeroComprobante, FechaEmision, ImportePercepcion) {
    waitingDialog({});
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Percepciones/Imprimir'
    });
    DownloadAttachPDF(RUCAgentePerceptor, NombreAgentePerceptor, NumeroComprobante, FechaEmision, ImportePercepcion);
}
function DownloadAttachPDF(RUCAgentePerceptor, NombreAgentePerceptor, NumeroComprobante, FechaEmision, ImportePercepcion) {
    var content = baseUrl + "MisPagos/ExportarPDFPercepcion?" +
            "vIdComprobantePercepcion=" + $('#hdIdComprobantePercepcion').val() +
            "&vRUCAgentePerceptor=" + RUCAgentePerceptor +
            "&vNombreAgentePerceptor=" + NombreAgentePerceptor +
            "&vNumeroComprobanteSerie=" + NumeroComprobante +
            "&vFechaEmision=" + FechaEmision +
            "&vImportePercepcion=" + ImportePercepcion +
            "&vSimbolo=" + variablesPortal.SimboloMoneda;

    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    iframe_.setAttribute("src", content);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
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
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
}