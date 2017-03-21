

$(document).ready(function () {

    $('.opcion_rechazo').on('click', function () {
        $('.opcion_rechazo').removeClass('opcion_rechazo_select');
        $(this).addClass('opcion_rechazo_select');
    });

});

function RechazarPedido(id) {

    var optr = $('.opcion_rechazo_select').data('id');
    if (typeof optr == 'undefined') {
        optr = 11;
    }

    var solval = $('#solped_' + id).val();
    var solarr = solval.split('|');

    var obj = {
        SolicitudId: solarr[0],
        NumIteracion: solarr[9],
        CodigoUbigeo: solarr[10],
        Campania: solarr[2],
        MarcaId: solarr[1],
        OpcionRechazo: optr,
        RazonMotivoRechazo: $("#txtOtrosRechazo").val()
    };

    ShowLoading();

    $.ajax({
        type: "POST",
        url: baseUrl + "ConsultoraOnline/RechazarPedido",
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(obj),
        success: function (data) {
            if (checkTimeout(data)) {
                CloseLoading();
                if (data.success == true) {
                    
                    $('#PedidoRechazado').hide();
                    $('#PedidoRechazadoDetalle').hide();
                    $('#MensajePedidoRechazado').show();
                }
                else {
                    AbrirMensaje(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                AbrirMensaje("Ocurrió un error inesperado al momento de desafiliarte. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });

};

function AceptarPedido(id, tipo) {

    var isOk = true;
    var detalle = [];
    var totIng = 0;

    $('div.detalle_pedido_reservado').each(function () {
        var detid = $(this).find("input[id*='soldet_']").val();
        var qty = $(this).find('#soldet_qty_' + detid).text();
        var tipoate = $(this).find('#soldet_tipoate_' + detid).val();
        var opt = 0;

        if (typeof tipoate !== 'undefined') {
            if (tipoate == "") {
                $('#MensajeComoAtendera').show();
                isOk = false;
                return false;
            }
            else {
                opt = tipoate;
                if (tipoate == 'ingrped') {
                    totIng += parseInt(qty);
                }
            }
        }

        var d = {
            PedidoDetalleId: detid,
            OpcionAcepta: opt
        }

        detalle.push(d);
    });

    if (isOk) {
        var pedido = {
            id: pedidoId,
            ListaDetalleModel: detalle,
        }

        ShowLoading();

        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/AceptarPedido',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pedido),
            async: true,
            success: function (response) {
                CloseLoading();
                if (checkTimeout(response)) {
                    if (response.success) {
                    
                        if (tipo == 1) {
                            $('#detallePedidoAceptado').text('Has agregado ' + totIng + ' productos a tu pedido');
                        }
                        else {
                            $('#detallePedidoAceptado').text('No te olvides de ingresar en tu pedido los productos de este cliente.');
                        }

                        $('#PedidoAceptado').show();
                    }
                    else {
                    AbrirMensaje(response.message);
                    }
                }
            },
            error: function (data, error) {
                CloseLoading();
                
                if (checkTimeout(data)) {
                    AbrirMensaje("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
                }
            }
        });
    }
}

function CerrarMensajeRechazado() {
    document.location.href = urlPendientes;
}

function CerrarMensajeAceptado() {
    document.location.href = urlPendientes;
}

