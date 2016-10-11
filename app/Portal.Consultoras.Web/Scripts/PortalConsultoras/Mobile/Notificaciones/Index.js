function VisualizarPopup(ProcesoId, Observaciones, Estado, FacturaHoy, DiaFact, MesFact, Visualizado, Asunto, Proceso) {
    ShowLoading();

    var TipoOrigen;
    switch (Proceso) {
        case "VALAUTO": TipoOrigen = 1; break;
        case "VALMOVIL": TipoOrigen = 2; break;
        case "BUSCACONS": TipoOrigen = 4; break;
        case "CATALOGO": TipoOrigen = 5; break;
        default: TipoOrigen = 3; break;
    }

    if (Visualizado == "False") {
        $.post('@Url.Action("ActualizarLeidoSolicitud", "Notificaciones", new { area = "Mobile" })' + "?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen, function (data) {

            data.mensaje = data.mensaje || "";
            if (data.mensaje != '') {
                console.log(data.mensaje);
            }
        });
    }

    if (TipoOrigen == 5) {
        location.href = '@Url.Action("DetalleSolicitudClienteCatalogo", "Notificaciones", new { area = "Mobile" })' + "?SolicitudId=" + ProcesoId;
    }
    else if (TipoOrigen == 4) {
        location.href = Estado == 0 ? urlConsultoraOnlinePendientes : urlConsultoraOnlineHistorial;
    } else if (TipoOrigen != 3) {
        location.href = '@Url.Action("ListarObservaciones", "Notificaciones", new { area = "Mobile" })' + "?ProcesoId=" + ProcesoId + "&TipoOrigen=" + TipoOrigen;
    } else {
        location.href = '@Url.Action("ListarObservacionesStock", "Notificaciones", new { area = "Mobile" })' + "?ValStockId=" + Observaciones;
    }
}