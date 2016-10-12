function VisualizarPopup(ProcesoId, Observaciones, Estado, FacturaHoy, DiaFact, MesFact, Visualizado, Asunto, Proceso) {
    ShowLoading();

    var TipoOrigen;
    switch (Proceso) {
        case "VALAUTO": TipoOrigen = 1; break;
        case "VALMOVIL": TipoOrigen = 2; break;
        case "BUSCACONS": TipoOrigen = 4; break;
        case "CATALOGO": TipoOrigen = 5; break;
        case "PEDREC": TipoOrigen = 6; break;
        default: TipoOrigen = 3; break;
    }
    if (Visualizado == "False") $.post(urlActualizarEstadoNotificacion + "?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen)
    
    if (TipoOrigen == 6) location.href = urlDetallePedidoRechazado + "?ProcesoId=" + ProcesoId;
    else if (TipoOrigen == 5) location.href = urlDetalleSolicitudClienteCatalogo + "?SolicitudId=" + ProcesoId;
    else if (TipoOrigen == 4) location.href = Estado == 0 ? urlConsultoraOnlinePendientes : urlConsultoraOnlineHistorial;
    else if (TipoOrigen == 3) location.href = urlListarObservacionesStock + "?ValStockId=" + Observaciones;
    else location.href = urlListarObservaciones + "?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen;
}