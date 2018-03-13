var primeraVezClienteOnline = true;
var solicitudClienteIdActual = 0;
var marcaIdActual = 0;

$(document).ready(function () {
    CargarEventosClienteOnline();
});

function CargarEventosClienteOnline() {
    $('ul[data-tab="tab"]>li>a[data-tag="PedidosClientesOnline"]').on('click', function (e) {
        if (primeraVezClienteOnline) {
            primeraVezClienteOnline = false;
            $('#ddlCampania').trigger('change');
        }
    });
    $('#ddlCampania').on('change', function () {
        var campanias = [$('#ddlCampania').val()];
        var campaniaAnterior = $('#ddlCampania option:selected').first().next().val();
        if (campaniaAnterior != null && campaniaAnterior != '') campanias.push(campaniaAnterior);

        waitingDialog();
        jQuery.ajax({
            type: 'POST',
            url: urlClienteOnline,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ campanias: campanias }),
            success: function (data) {
                if (!checkTimeout(data)) return false;

                if (data.success) $('#ddlCampania').val(data.campaniaResultado);
                if (data.success && data.listaPedidosClienteOnline.length > 0) {
                    var tablaClientesOnline = SetHandlebars("#html-clientes-online", data.listaPedidosClienteOnline);
                    $('#divTablaClientesOnline').html(tablaClientesOnline);
                }
                else $('#divTablaClientesOnline').html(data.message);
            },
            error: function (data, error) {
                $('#divTablaClientesOnline').html('Hubieron problemas de conexion al intentar cargar los pedidos de Consultora Online, inténtelo más tarde.');
            },
            complete: closeWaitingDialog
        });
    });
    $('#dialog_motivoCancelado .optionsRechazo').on('click', function () {
        $('#dialog_motivoCancelado .optionsRechazo').removeClass('optionsRechazoSelect');
        $(this).addClass('optionsRechazoSelect');
    });

    if (lanzarTabClienteOnline) $('ul[data-tab="tab"]>li>a[data-tag="PedidosClientesOnline"]').trigger('click');
}
function CargarDetallleClienteOnline(solicitudClienteId, marcaId, nombre, direccion, telefono, email, estado, estadoDesc, mensaje, total) {
    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: urlClienteOnlineDetalle,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ solicitudClienteId: solicitudClienteId }),
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (!data.success) {
                alert_msg(data.message);
                return false;
            }

            $('#txtOtrosCancelado').val('');
            $('#dialog_motivoCancelado .optionsRechazo').removeClass('optionsRechazoSelect');

            var titulo = "pedido " + estadoDesc + " de " + nombre;
            $('#popup_cliente_online_detalle .spnClienteOnlineTitulo').html(titulo.toUpperCase());
            $('#popup_cliente_online_detalle .spnClienteOnlineTotal').html(total);
            if (campaniaActual == $('#ddlCampania').val() && estado == 'A') {
                $('#popup_cliente_online_detalle .popup_Pendientes').css('padding-bottom', '');
                $('#popup_cliente_online_detalle .solo-cliente-online-aceptado').show();
            }
            else {
                $('#popup_cliente_online_detalle .popup_Pendientes').css('padding-bottom', '14px');
                $('#popup_cliente_online_detalle .solo-cliente-online-aceptado').hide();
            }

            $('#popup_cliente_online_detalle .spnClienteOnlineNombre').html(nombre);
            $('#popup_cliente_online_detalle .spnClienteOnlineTelefono').html(telefono);
            $('#popup_cliente_online_detalle .spnClienteOnlineEmail').html(email);
            $('#popup_cliente_online_detalle .spnClienteOnlineDireccion').html(direccion);
            $('#popup_cliente_online_detalle .spnClienteOnlineEstado').html(estadoDesc);
            $('#popup_cliente_online_detalle .spnClienteOnlineMensaje').html(mensaje);

            $('#popup_cliente_online_detalle .divClienteOnlineMensaje').css('display', marcaId == 0 ? 'none' : 'block');
            $('#popup_cliente_online_detalle .cubre').css('height', marcaId == 0 ? '160px' : '');
            var template = marcaId == 0 ? '#html-clientes-online-detalle-catalogos' : '#html-clientes-online-detalle-marcas';
            var tablaClientesOnlineDetalle = SetHandlebars(template, data.listaDetallesClienteOnline);
            $('#divTablaClienteOnlineDetalles').html(tablaClientesOnlineDetalle);

            $('#popup_cliente_online_detalle').show();
            solicitudClienteIdActual = solicitudClienteId;
            marcaIdActual = marcaId;
        },
        error: function (data, error) {
            alert_msg('Hubieron problemas de conexion al intentar cargar los datos del pedido de Consultora Online, inténtelo más tarde.');
        },
        complete: closeWaitingDialog
    });
}
function AbrirConfirmacionCancelado() {
    $('#popup_cliente_online_detalle').hide();
    $('#dialog_confirmacionCancelado').show();
}
function NoAceptarConfirmacionCancelado() {
    $('#dialog_confirmacionCancelado').hide();
    $('#popup_cliente_online_detalle').show();
}
function AceptarConfirmacionCancelado() {
    $('#dialog_confirmacionCancelado').hide();
    $('#dialog_motivoCancelado').show();
}
function CancelarSolicitud() {
    waitingDialog();
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
                    motivoSolicitudId: $('#dialog_motivoCancelado .optionsRechazo.optionsRechazoSelect').first().attr('data-id'),
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

                    solicitudClienteIdActual = 0;
                    marcaIdActual = 0;
                    ActualizarGanancia(data.dataBarra);
                },
                error: function (data, error) {
                    MensajeErrorCancelado('Hubieron problemas de conexion al intentar cancelar su solicitud, inténtelo más tarde.');
                },
                complete: closeWaitingDialog
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
    $('#ddlCampania').trigger('change');
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
                location.href = baseUrl + 'Pedido/PedidoValidado';
                return false;
            }

            if (mostrarAlerta) {
                closeWaitingDialog();
                alert_msg(data.message);
            }
            fnRestringido();
        },
        error: function (error) {
            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
            closeWaitingDialog();
            fnRestringido();
        }
    });
}