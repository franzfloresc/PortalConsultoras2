
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
    if (msj.length > 0) {
        $("#desc_obs_alerta").html("<ul></ul>");
        for (i = 0; i < msj.length; i++) {
            $("#desc_obs_alerta ul").append("<li>" + msj[i] + "</li>");
        }
    } else {
        $("#desc_obs_alerta").html("<ul><li>" + Mensaje + "</li></ul>");
    }
    $("#observaciones_alerta").dialog("open");
}

function btnSalirTlpObservaciones() {
    if (isMobile()) {
        $("#observacionPedido").modal("close");
    }

    $("#tlpObservaciones").dialog("close");
}