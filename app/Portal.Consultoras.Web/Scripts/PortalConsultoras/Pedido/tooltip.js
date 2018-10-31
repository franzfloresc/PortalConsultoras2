$(document).ready(function () {
    $("#observaciones_alerta").dialog({
        modal: true,
        draggable: false,
        resizable: false,
        width: 620,
        autoOpen: false,
        open: function (event, ui) {
            $("body").addClass("overflow_hidden");
            $(".ui-widget-header").css("display", "none");
        },
        close: function (event, ui) {
            $("body").removeClass("overflow_hidden");
        },

        create: function (event, ui) {
            //$(".ui-dialog").addClass("observaciones_alerta_blocks");
            //$(".ui-dialog").css({ height: "620px !important" });

            $("#observaciones_alerta").parent().addClass("observaciones_alerta_blocks");
            $("#observaciones_alerta").parent().css({ height: "620px !important" });
        },

    });

    $('.close_buttom_alerta').click(function () {
        $('#observaciones_alerta').dialog('close');
        return false;
    });
})

function tooltipDelete(PedidoDetalleID) {
    $("#tlpDelete_" + PedidoDetalleID).show();
}

function btnSalirTlpDelete(PedidoDetalleID) {
    $("#tlpDelete_" + PedidoDetalleID).hide();
}

function tooltipObservaciones(Mensaje) {
    if (isMobile()) {
        $('#observacionPedido').modal();
        msj = Mensaje.split("<br/>");
        msj.pop();
        if (msj.length > 0) {
            $("#desc_obs_alert").html("<ul></ul>");
            for (i = 0; i < msj.length; i++) {
                $("#desc_obs_alert ul").append("<li>" + msj[i] + "</li>");
            }
        } else {
            $("#desc_obs_alert").html("<ul><li>" + Mensaje + "</li></ul>");
        }
    }

    msj = Mensaje.split("<br/>");
    msj.pop();
    $("#observaciones_alerta").dialog("open");
    if (msj.length > 0) {
        $("#desc_obs_alerta").html("<ul></ul>");
        for (i = 0; i < msj.length; i++) {
            $("#desc_obs_alerta ul").append("<li>" + msj[i] + "</li>");
        }
    } else {
        $("#desc_obs_alerta").html("<ul><li>" + Mensaje + "</li></ul>");
    }
}

function btnSalirTlpObservaciones() {
    if (isMobile()) {
        $("#observacionPedido").modal("close");
    }

    $("#tlpObservaciones").dialog("close");
}