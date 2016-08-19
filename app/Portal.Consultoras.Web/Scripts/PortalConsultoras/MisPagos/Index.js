$(document).ready(function () {
    $('ul[data-tab="tab"] li a[data-tag]').click(function (e) {
        // mostrar el tab correcto
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        var obj = $("[data-tag-html='" + tag + "']");
        $.each(obj, function (ind, objTag) {
            $(objTag).fadeIn(300).show();
        });

        //mantener seleccionado
        $('ul[data-tab="tab"] li a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    });

    $('ul[data-tab="tab"]').mouseover(function () {
        $("#barCursor").css("opacity", "1");
    }).mouseout(function () {
        $("#barCursor").css("opacity", "0");
    });
    $('ul[data-tab="tab"] li a')[0].click();

    $("#spanDeuda").html('@Model.Simbolo' + " " + "<span>" + $("#hdn_MontoPagar").val() + "</span>");
    $("#der_fechaVencimiento").html('');
    if ($("#hdn_FechaVencimiento").val() != "") {
        $("#der_fechaVencimiento").html('Vencimiento: ' + $("#hdn_FechaVencimiento").val().substring(0, 5));
    }

    $("#lblCorreoEnviar").click(function () {
        fnEnviarCorreo();
    });

    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    fnGrilla();

    getLugarPago();

    setTimeout(function () {
        var a = document.createElement("script");
        var b = document.getElementsByTagName("script")[0];
        a.src = document.location.protocol + "//dnn506yrbagrg.cloudfront.net/pages/scripts/0017/4400.js?" + Math.floor(new Date().getTime() / 3600000);
        a.async = true; a.type = "text/javascript"; b.parentNode.insertBefore(a, b)
    }, 1);
});

function RedirectPagaEnLineaAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'Paga-en-linea']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/Paga-en-linea'
    });

    if (ViewBagRutaChile != "") {
        window.open(ViewBagRutaChile + viewBagUrlChileEncriptada, "_blank");
    }
    else {
        window.open('https://www.belcorpchile.cl/BP_Servipag/PagoConsultora.aspx?c=' + viewBagUrlChileEncriptada, "_blank");
    }
};

function EventoAnalytics(NombreBanco, nro) {
    _gaq.push(['_trackEvent', 'Lugares de Pago', 'Link-' + nro, NombreBanco.replace(/\s+/g, '-')]);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Lugares de Pago/Link-' + nro + '/' + NombreBanco.replace(/\s+/g, '-')
    });
}

function Percepcion() {
    $(".popup_Percepcion").slideDown(300);
    $(".fondo_f9f9f9").animate({ "margin-top": "-141px" }, 500);

    $(".btn_cerrar_popupPercepcion").click(function () {

        $(".popup_Percepcion").slideUp(300);
        $(".fondo_f9f9f9").animate({ "margin-top": "0px" }, 500);

    });

}

/** Estado Cuenta **/

function fnGrilla() {
    waitingDialog({});
    var obj = {
        sidx: "", sord: "", page: 1, rows: 20, vCampania: ""
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + "MisPagos/ConsultarEstadoCuenta",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        cache: false,
        success: function (data) {
            RenderGrilla(data);
            closeWaitingDialog();
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert_msg(data.message);
            }
        }
    });
}

function RenderGrilla(data) {
    if (data == null || data == undefined) {
        return false;
    }
    data.Rows = data.Rows || new Array();
    if (data.Rows.length == 0) {
        return false;
    }

    var source = $("#js-EstadoCuenta").html();
    var template = Handlebars.compile(source);
    var htmlDiv = template(data);
    $("#dellateContenido").html(htmlDiv);

    //var detalle = $("#dellateContenido");
    //var htmlRowI = '<div class="content_datos_mispagos">'
    //    + '<div class="fecha_pagos">{0}</div>'
    //    + '<div class="movimientos_pagos">{1}</div>'
    //    + '<div class="pedidos_pagos">{2}</div>'
    //    + '<div class="abonos_pagos">{3}</div>'
    //    + '</div>';
    //$.each(data.rows, function (ind, row) {
    //    row.cell = row.cell || new Array();
    //    if (row.cell.length > 0) {
    //        var htmlRow = htmlRowI;
    //        $.each(row.cell, function (indc, rowC) {
    //            htmlRow = htmlRow.replace("{" + indc + "}", rowC);
    //        });
    //        detalle.append(htmlRow);
    //    }
    //});
}

function fnEnviarCorreo() {
    waitingDialog({});
    if (jQuery.trim($("#hdn_Correo").val()) == "") {
        alert("No tiene una cuenta de correo registrada");
        closeWaitingDialog();
        return false;
    }
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisPagos/EnviarCorreo',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ correo: jQuery.trim($("#hdn_Correo").val()) }),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                _gaq.push(['_trackEvent', 'Estado-Cuenta', 'Enviar-informacion']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Estado-Cuenta/Enviar-informacion'
                });
                closeWaitingDialog();
                alert(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("ERROR");
            }
        }
    });
    return false
}

function alert_msg(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}

function validarExportar() {
    var montoPagarEstadoCuenta = $("#hdn_MontoPagar").val();
    if (montoPagarEstadoCuenta == "0") {
        alert_msg("No hay datos para poder generar el archivo.");
        return false;
    }

    ExportExcelEC();
}

function ExportExcelEC() {
    waitingDialog({});
    _gaq.push(['_trackEvent', 'Estado-Cuenta', 'Excel']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Estado-Cuenta/Excel'
    });
    setTimeout(function () { DownloadAttachExcelEC() }, 0);
}

function DownloadAttachExcelEC() {
    if (!checkTimeout()) {
        return false;
    }

    var content = baseUrl + "MisPagos/ExportarExcel";
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

/** FIN Estado Cuenta **/

/** Lugar Pago **/
function getLugarPago() {
    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + "MisPagos/Pagos",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({}),
        async: true,
        cache: false,
        success: function (data) {
            var source = $("#js-LugaresPago").html();
            var template = Handlebars.compile(source);
            var htmlDiv = template(data);
            $("#divContenidoLugarPago").html(htmlDiv);

            closeWaitingDialog();
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert_msg(data.message);
            }
        }
    });
}
/** FIN Lugar Pago **/