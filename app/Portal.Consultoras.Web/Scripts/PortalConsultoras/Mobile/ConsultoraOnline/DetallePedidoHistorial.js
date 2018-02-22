$(document).ready(function () {
    CargarEventosDetalleClienteOnline();
});

function CargarEventosDetalleClienteOnline() {
    $('#dialog_motivoCancelado .opcion_rechazo').on('click', function () {
        $('#dialog_motivoCancelado .opcion_rechazo.opcion_rechazo-select').removeClass('opcion_rechazo-select');
        $(this).addClass('opcion_rechazo-select');
    });
}

function AbrirConfirmacionCancelado() { $('#dialog_confirmacionCancelado').show(); }
function NoAceptarConfirmacionCancelado() { $('#dialog_confirmacionCancelado').hide(); }
function AceptarConfirmacionCancelado() {
    $('#dialog_confirmacionCancelado').hide();
    $('#dialog_motivoCancelado').show();
}
function CancelarSolicitud(solicitudClienteIdActual, marcaIdActual) {
    ShowLoading();
    ReservadoOEnHorarioRestringidoAsync(
        true,
        MensajeErrorCancelado,
        function () {
            jQuery.ajax({
                type: 'POST',
                url: urlClienteOnlineCancelarSolicitud,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    solicitudClienteId: solicitudClienteIdActual,
                    motivoSolicitudId: $('#dialog_motivoCancelado .opcion_rechazo.opcion_rechazo-select').first().attr('data-id'),
                    razonMotivoSolicitud: $('#txtOtrosCancelado').val()
                }),
                success: function (data) {
                    if (!checkTimeout(data)) return false;
                    if (!data.success) {
                        MensajeErrorCancelado(data.message);
                        return false;
                    }

                    $('#dialog_motivoCancelado').hide();
                    if (marcaIdActual == 0) $('#dialog_mensajeCancelado .spnMensajeSolicitudCancelada').html(mensajeCanceladoPortal);
                    else $('#dialog_mensajeCancelado .spnMensajeSolicitudCancelada').html(mensajeCanceladoMarcas);
                    $('#dialog_mensajeCancelado').show();
                },
                error: function (data, error) {
                    if (checkTimeout(data)) {
                        MensajeErrorCancelado('Hubieron problemas de conexion al intentar cancelar su solicitud, inténtelo más tarde.');
                    }
                },
                complete: CloseLoading
            });
        }
    )
}
function MensajeErrorCancelado(message) {
    $('#dialog_motivoCancelado').hide();
    $('#dialog_confirmacionCancelado').show();
    if (message != null && message != '') alert_msg(message);
}
function CerrarMensajeCancelado() {
    $('#dialog_mensajeCancelado').hide();
    ShowLoading();
    location.href = urlClienteOnlineHistorial;
}

function ReservadoOEnHorarioRestringidoAsync(mostrarAlerta, fnRestringido, fnNoRestringido) {
    if (!$.isFunction(fnRestringido)) return false;
    if (!$.isFunction(fnNoRestringido)) return false;
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        dataType: 'json',
        async: true,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (!data.success) {
                fnNoRestringido();
                return false;
            }

            if (data.pedidoReservado && !mostrarAlerta) {
                waitingDialog();
                location.href = urlPedidoValidado;
                return false;
            }

            if (mostrarAlerta) {
                CloseLoading();
                alert_msg(data.message);
            }
            fnRestringido();
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
                fnRestringido();
            }
        }
    });
}
function alert_msg(message, fnClose) {
    messageInfo('<h3 class="text-primary">' + message + '</h3>', fnClose);
}