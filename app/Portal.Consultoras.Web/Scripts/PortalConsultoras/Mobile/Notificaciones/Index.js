function VisualizarPopup(ProcesoId, Observaciones, Estado, FacturaHoy, DiaFact, MesFact, Visualizado, Asunto, Proceso, elemento, Campania) {
 
    ShowLoading();
    var TipoOrigen;
    switch (Proceso) {
        case "VALAUTO": TipoOrigen = 1; break;
        case "VALMOVIL": TipoOrigen = 2; break;
        case "BUSCACONS": TipoOrigen = 4; break;
        case "CATALOGO": TipoOrigen = 5; break;
        case "PEDREC": TipoOrigen = 6; break;
        case "CDR": TipoOrigen = 7; break;
        case "CDR-CULM": TipoOrigen = 8; break;
        case "PAYONLINE": TipoOrigen = 9; break;
        default: TipoOrigen = 3; break;
    }
    if (Visualizado == "False") $.post(urlActualizarEstadoNotificacion + "?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen)

    if (TipoOrigen == 6) location.href = urlDetallePedidoRechazado + "?ProcesoId=" + ProcesoId;
    else if (TipoOrigen == 5) location.href = urlDetalleSolicitudClienteCatalogo + "?SolicitudId=" + ProcesoId;
    else if (TipoOrigen == 4) location.href = Estado == 0 ? urlConsultoraOnlinePendientes : urlConsultoraOnlineHistorial;
    else if (TipoOrigen == 3) location.href = urlListarObservacionesStock + "?ProcesoId=" + ProcesoId;
    else if (TipoOrigen == 7) location.href = urlListarDetalleCDRCulminado + "?solicitudId=" + ProcesoId + "&Proceso=" + Proceso;
    else if (TipoOrigen == 8) location.href = urlListarDetalleCDRCulminado + "?solicitudId=" + ProcesoId + "&Proceso=" + Proceso;
    else if (TipoOrigen == 9) location.href = urlListarPayOnline + "?solicitudId=" + ProcesoId;
    else location.href = urlListarObservaciones + "?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen  + "&Campania=" + Campania   ;
}