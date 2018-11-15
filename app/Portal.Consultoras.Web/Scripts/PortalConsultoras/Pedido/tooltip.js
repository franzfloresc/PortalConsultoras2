
function tooltipDelete(pedidoDetalleID, sedId) {
    var id = "#tlpDelete_" + pedidoDetalleID + "_" + sedId;
    $(id + " [data-mensaje-eliminar]").hide();

    if (ValidarTieneRegalo()) {
        $(id + " [data-mensaje-eliminar='regalo']").show();
    }
    else {
        $(id + " [data-mensaje-eliminar='directo']").show();
    }

    $(id).show();
}

function btnSalirTlpDelete(PedidoDetalleID, sedId) {
    var id = "#tlpDelete_" + PedidoDetalleID + "_" + sedId;
    $(id + " [data-mensaje-eliminar]").hide();
    $(id).hide();
}

function ValidarTieneRegalo() {
    if (typeof esUpselling === "undefined" || !esUpselling)
        return false;

    var regalo = GetUpSellingGanado();
    return regalo != null;
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