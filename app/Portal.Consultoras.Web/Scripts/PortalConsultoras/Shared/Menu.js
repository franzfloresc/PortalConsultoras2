
function SetAnalyticsMenu(ActionName, ControllerName, Flag, Descripcion) {
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

    _gaq.push(['_trackEvent', 'Menu-Superior', Descripcion.replace(/\s+/g, '-')]);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Superior/' + Descripcion.replace(/\s+/g, '-')
    });

    if (Descripcion != "Pedidos") {
        if ($("#hdFlagOfertaWeb").val() == "1") {
            _gaq.push(['_trackEvent', 'Oferta-Web', 'Observacion-OfertaWeb']);
            dataLayer.push({
                'event': 'pageview',
                'virtualUrl': '/Oferta-Web/Observacion-OfertaWeb'
            });
            MostrarMensajeConsultora();
            return false;
        }
        else if ($("#hdFlagOfertaLiquidacion").val() == "1") {
            _gaq.push(['_trackEvent', 'Liquidacion-Web', 'Observacion-Liquidacion']);
            dataLayer.push({
                'event': 'pageview',
                'virtualUrl': '/Liquidacion-Web/Observacion-Liquidacion'
            });
            MostrarMensajeConsultora();
            return false;
        }
    }

    if ($("#hdFlagValidacion").val() == "1") {
        if ($('#hdFlagValidacionReserva').val() == "1") {
            _gaq.push(['_trackEvent', 'Pedido-Web', 'Observacion-Validacion']);
            dataLayer.push({
                'event': 'pageview',
                'virtualUrl': '/Pedido-Web/Observacion-Validacion'
            });
            MostrarMensajeConsultoraValidacion();
        }
        return false;
    }

    if (Flag == "1") {
        window.open(URL, '_blank');
        estado = false;
    }
    else
        location.href = URL;

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
