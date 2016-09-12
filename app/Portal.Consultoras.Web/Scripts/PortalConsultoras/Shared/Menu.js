
function RedirectMenu(ActionName, ControllerName, Flag, Descripcion) {
    var estado = true;
    // se valida si la URL es externa (no tiene Controladora)
    var URL = '';
    if (ControllerName == '') {
        URL = ActionName;
    }
    else // la url es interna
    {
        if (ActionName == "Index")
            URL = location.protocol + "//" + location.host + "/" + ControllerName;
        else
            URL = location.protocol + "//" + location.host + "/" + ControllerName + "/" + ActionName;
    } 

    if (Descripcion != "Pedidos") {
        if ($("#hdFlagOfertaWeb").val() == "1") {
            MostrarMensajeConsultora();
            return false;
        }
        else if ($("#hdFlagOfertaLiquidacion").val() == "1") {
            MostrarMensajeConsultora();
            return false;
        }
    }

    if ($("#hdFlagValidacion").val() == "1") {
        if ($('#hdFlagValidacionReserva').val() == "1") {
            MostrarMensajeConsultoraValidacion();
        }
        return false;
    }

    if (Flag == "1") {
        window.open(URL, '_blank');
        estado = false;
    }
    else {
        location.href = URL;
    }

    return estado;
}

function MostrarMensajeConsultora() {
    showDialog("DialogMensajeProducto");
    $("#DialogMensajeProducto").siblings(".ui-dialog-titlebar").hide();
}

function MostrarMensajeConsultoraValidacion() {
    showDialog("DialogMensajeValidacion");
    $("#DialogMensajeValidacion").siblings(".ui-dialog-titlebar").hide();
}
