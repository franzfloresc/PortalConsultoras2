﻿

$(document).ready(function () {

    $('.opcion_rechazo').on('click', function () {
        $('.opcion_rechazo').removeClass('opcion_rechazo_select');
        $(this).addClass('opcion_rechazo_select');
        if ($(this).data('id') == 11) {
            $('#txtOtrosRechazo').prop('readonly', false);
        }
        else {
            $('#txtOtrosRechazo').prop('readonly', true);
        }
    });

});

function RechazarPedido(id) {

    var optr = $('.opcion_rechazo_select').data('id');
    if (typeof optr == 'undefined') {
        optr = 11;
    }

    var solval = $('#solped_' + id).val();
    var solarr = solval.split('|');
    var obsr = $("#txtOtrosRechazo").val();
    if (optr != 11) {
        obsr = '';
    }

    var obj = {
        SolicitudId: solarr[0],
        NumIteracion: solarr[9],
        CodigoUbigeo: solarr[10],
        Campania: solarr[2],
        MarcaId: solarr[1],
        OpcionRechazo: optr,
        RazonMotivoRechazo: obsr,
        typeAction: '2'
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
                    $('#PedidoRechazado').hide();
                    $('#PedidoRechazadoDetalle').hide();
                    AbrirMensaje(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                $('#PedidoRechazado').hide();
                $('#PedidoRechazadoDetalle').hide();
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
                $('#ComoloAtenderas').show();
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
            pedidoId: id,
            ListaDetalleModel: detalle,
            typeAction: '2'
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
                if (response.success) {
                    
                    if (tipo == 1) {
                        $('#detallePedidoAceptado').text('Has agregado ' + totIng + ' producto(s) a tu pedido');
                    }
                    else {
                        $('#detallePedidoAceptado').text('No te olvides de ingresar en tu pedido los productos de este cliente.');
                    }

                    ActualizarGanancia(response.DataBarra);
                    $('#PedidoAceptado').show();
                }
                else {
                    if (response.code == 1) {
                        AbrirMensaje(response.message);
                    }
                    else if (response.code == 2) {
                        $('#MensajePedidoReservado').text(response.message);
                        $('#AlertaPedidoReservado').show();
                    }
                }
            },
            error: function (error) {
                CloseLoading();
                AbrirMensaje("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
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

function MostrarMisPedidosConsultoraOnline() {
    var frmConsultoraOnline = $('#frmConsultoraOnline');
    frmConsultoraOnline.attr("action", urlMisPedidosClienteOnline);
    frmConsultoraOnline.submit();
}

function HorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var horarioRestringido = false;
    $.ajaxSetup({
        cache: false
    });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/EnHorarioRestringido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (mostrarAlerta == true) {
                        CloseLoading();
                        AbrirMensaje(data.message);
                    }
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                AbrirMensaje(data.message);
            }
        }
    });
    return horarioRestringido;
}

function CerrarAlertaPedidoReservado() {
    $('#AlertaPedidoReservado').hide();
    document.location.href = urlPedido;
}