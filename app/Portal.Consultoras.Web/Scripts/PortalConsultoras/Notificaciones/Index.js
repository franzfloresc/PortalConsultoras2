$(document).ready(function () {
});

function VisualizarPopup(ProcesoId, Observaciones, Estado, FacturaHoy, DiaFact, MesFact, Visualizado, Asunto, Proceso, EsMontoMinimo, obj) {
    waitingDialog({});

    var TipoOrigen = 1;
    if (Proceso == "VALAUTO")
        TipoOrigen = 1;
    else
        if (Proceso == "VALMOVIL")
            TipoOrigen = 2;
        else
            TipoOrigen = 3;
    //R2319 - JLCS
    if (Proceso == "BUSCACONS")
        TipoOrigen = 4;

    if (Proceso == "CATALOGO")
        TipoOrigen = 5;

    if (Visualizado == "False") {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ActualizarEstadoNotificacion?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen, function (data) {
            if (checkTimeout(data)) {
                if (data.success) {
                    console.log(data.message);
                    $(obj).removeClass("no_leido");
                } else {
                    console.log(data.message);
                }
            }
        });
    }

    //R2319 - JLCS
    if (TipoOrigen == 4) {
        location.href = urlMisPedidos; //GR-723
    }
    else if (TipoOrigen == 5) {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarDetalleSolicitudClienteCatalogo?SolicitudId=" + ProcesoId, function (data) {
            if (checkTimeout(data)) {
                $('#divDetalleNotificacionCatalogo').html(data);
                $('#divNotificacionCatalogo').show();
                closeWaitingDialog();
            }
        });
    }
    else if (TipoOrigen != 3) {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarObservaciones?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen, function (data) {
            if (checkTimeout(data)) {
                $('#divListadoObservaciones').html(data);
                $('#divObservaciones').show();
                switch (Estado) {
                    /*Pedido no reservado por monto mínimo/maximo */
                    case "2":
                        $('#sMensajePedidoPROL').html(Observaciones);
                        /*RE2584 - CS(CGI) - 22/05/2015*/
                        $('#SaltoLinea').html('&nbsp;');
                        if (EsMontoMinimo == "True") {
                            $('#sMensajeFacturacion').html('Añade más productos y no pierdas la oportunidad de hacer crecer tu negocio con Belcorp.');
                        }
                        break;
                    case "3":
                        $('#sMensajePedidoPROL').html(Observaciones);
                        $('#sMensajeFacturacion').html('Añade más productos y no pierdas la oportunidad de hacer crecer tu negocio con Belcorp.');
                        break;
                    case "4":
                        /*RE2584 - CS(CGI) - 22/05/2015*/
                        $('#sFelicitaciones').html('¡Lo lograste!');
                        $('#sMensajePedidoPROL').html(Observaciones);
                        var Mensaje = "Será enviado a Belcorp " + DescripcionFacturacion(FacturaHoy, DiaFact, MesFact) + ", siempre y cuando cumplas con el monto mínimo y no tengas deuda pendiente.";
                        /*RE2584 - CS(CGI) - 22/05/2015*/
                        $('#sMensajeFacturacion').html(Mensaje);
                        break;
                    case "5":
                        /*RE2584 - CS(CGI) - 22/05/2015*/
                        $('#sFelicitaciones').html('¡Lo lograste!');
                        $('#sMensajePedidoPROL').html(Observaciones);
                        /*RE2584 - CS(CGI) - 22/05/2015*/
                        var Mensaje = "Será enviado a Belcorp " + DescripcionFacturacion(FacturaHoy, DiaFact, MesFact) + ", siempre y cuando cumplas con el monto mínimo y no tengas deuda pendiente.";
                        $('#sMensajeFacturacion').html(Mensaje);
                        break;
                }
                closeWaitingDialog();
            }
        });
    }
    else {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarObservacionesStock?ValStockId=" + Observaciones, function (data) {
            if (checkTimeout(data)) {
                $('#divListadoObservaciones').html(data);
                $('#divObservaciones').dialog('option', 'title', Asunto);
                $('#divObservaciones').dialog('open');
                closeWaitingDialog();
            }
        });

    }

}
function DescripcionFacturacion(FacturaHoy, DiaFact, MesFact) {
    Result = "el día de hoy";
    return Result;
}
