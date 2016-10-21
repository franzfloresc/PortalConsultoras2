function VisualizarPopup(ProcesoId, Observaciones, Estado, FacturaHoy, DiaFact, MesFact, Visualizado, Asunto, Proceso, EsMontoMinimo, obj) {
    waitingDialog({});

    var TipoOrigen;
    switch (Proceso) {
        case "VALAUTO": TipoOrigen = 1; break;
        case "VALMOVIL": TipoOrigen = 2; break;
        case "BUSCACONS": TipoOrigen = 4; break;
        case "CATALOGO": TipoOrigen = 5; break;
        case "PEDREC": TipoOrigen = 6; break;
        default: TipoOrigen = 3; break;
    }

    if (Visualizado == "False") {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ActualizarEstadoNotificacion?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen)
            .success(function (data){ if (checkTimeout(data) && data.success) $(obj).removeClass("no_leido"); });
    }

    //R2319 - JLCS
    if (TipoOrigen == 6) {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarDetallePedidoRechazado?ProcesoId=" + ProcesoId).success(function (data) {
            if (checkTimeout(data)) {
                $('#divDetalleNotificacionCatalogo').html(data);
                $('#divNotificacionCatalogo').show();
                $('.content_left_pagos').hide();
                CargarCantidadNotificacionesSinLeer();
                closeWaitingDialog();
            }
        }).error(function (jqXHR, textStatus, errorThrown) { closeWaitingDialog(); });
    }
    else if (TipoOrigen == 5) {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarDetalleSolicitudClienteCatalogo?SolicitudId=" + ProcesoId).success(function (data) {
            if (checkTimeout(data)) {
                $('#divDetalleNotificacionCatalogo').html(data);
                $('#divNotificacionCatalogo').show();
                $('.content_left_pagos').hide();
                CargarCantidadNotificacionesSinLeer();
                closeWaitingDialog();
            }
        }).error(function (jqXHR, textStatus, errorThrown) { closeWaitingDialog(); });
    }
    else if (TipoOrigen == 4) {
        var frmConsultoraOnline = $('#frmConsultoraOnline');
        frmConsultoraOnline.attr("action", Estado == 0 ? urlPedidoConsultoraOnline : urlMisPedidosClienteOnline);
        frmConsultoraOnline.submit();
    }
    else if (TipoOrigen == 3) {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarObservacionesStock?ValStockId=" + Observaciones).success(function (data) {
            if (checkTimeout(data)) {
                $('#divListadoObservaciones').html(data);
                $('#divObservaciones').show();
                $('.content_left_pagos').hide();
                CargarCantidadNotificacionesSinLeer()
                closeWaitingDialog();
            }
        }).error(function (jqXHR, textStatus, errorThrown) { closeWaitingDialog(); });
    }
    else {
        $.ajaxSetup({ cache: false });
        $.get(baseUrl + "Notificaciones/ListarObservaciones?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen).success(function (data) {
            if (checkTimeout(data)) {
                $('#divListadoObservaciones').html(data);
                $('#divObservaciones').show();
                $('.content_left_pagos').hide();
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
                CargarCantidadNotificacionesSinLeer()
                closeWaitingDialog();
            }
        })
        .error(function (jqXHR, textStatus, errorThrown) { closeWaitingDialog(); });
    }
}
function DescripcionFacturacion(FacturaHoy, DiaFact, MesFact) {
    Result = "el día de hoy";
    return Result;
}
