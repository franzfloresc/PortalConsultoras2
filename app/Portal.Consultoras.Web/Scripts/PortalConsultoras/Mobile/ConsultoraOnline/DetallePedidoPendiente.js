

$(document).ready(function () {

    $('.opcion_rechazo').on('click', function () {
        $('.opcion_rechazo').removeClass('opcion_rechazo_select');
        $(this).addClass('opcion_rechazo_select');
    });

});

function RechazarPedido(id) {

    //$('#PedidoRechazadoDetalle').hide();
    //$('#btnRechazarPedido').prop('disabled', true);

    //var opc = $('input[name=checkbox]:checked', '#frmRechazoPedido').val();
    //var objHtmlPanelPedidoRechazado = $("#DivPanelPedidoRechazado").val();
    var optr = $('.opcion_rechazo_select').data('id');
    if (typeof optr == 'undefined') {
        optr = 11;   // otros
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
        RazonMotivoRechazo: $("#txtOtrosRechazo").val(),
        typeAction: '2'     // mobile
    };

    console.log(obj);
    //return;

    //$('#PedidoRechazado').hide();
    //$('#PedidoRechazadoDetalle').hide();
    //$('#MensajePedidoRechazado').show();
    //return;

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
                    //$('#modal_rechazar_pedido').fuzemodal('close');
                    //$('#modal_rechazar_pedido').fuzemodal('close');
                    //var htmlRechazado = '<div class="text_gris_azul">RECHAZADO</div><p class="font_size_11">' + data.message + '</p>';
                    //$('#DivPanel' + objHtmlPanelPedidoRechazado).html(htmlRechazado);
                    //var imgRechazado = '<img class="margin_right_10 vertical_align_top" src="/Content/Images/ConsultoraOnline/ic_cerrar.png" width="19" height="19" alt="" />';
                    //$('#alertImage' + objHtmlPanelPedidoRechazado).html(imgRechazado);
                    //$('#telefonoDisplay' + objHtmlPanelPedidoRechazado).css('display', 'none');
                    //$('#datosDisplay' + objHtmlPanelPedidoRechazado).css('display', 'none');
                    //$('#MensajeConsultora' + objHtmlPanelPedidoRechazado).css('display', 'none');
                    //updateCantidadPedidos();

                    //$('#btnRechazarPedido').prop('disabled', false);
                    //$('#dialog_motivoRechazo').hide();
                    //$('#dialog_mensajeRechazado').show();

                    $('#PedidoRechazado').hide();
                    $('#PedidoRechazadoDetalle').hide();
                    $('#MensajePedidoRechazado').show();
                }
                else {
                    alert_msg(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                alert_msg("Ocurrió un error inesperado al momento de desafiliarte. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });

    //$('#modal_cancelar_pedido').fuzemodal('close');
    //$('#dialog_confirmacionRechazo').hide();
};

function AceptarPedido(id, tipo) {

    var isOk = true;
    var detalle = [];
    //var divId = (tipo == 1) ? "divDetPedidoPend" : "divDet2PedidoPend";
    var totIng = 0;

    //$('div#' + divId + ' > div').each(function () {
    $('div.detalle_pedido_reservado').each(function () {
        var detid = $(this).find("input[id*='soldet_']").val();
        var qty = $(this).find('#soldet_qty_' + detid).text();
        var tipoate = $(this).find('#soldet_tipoate_' + detid).val();
        var opt = 0;

        if (typeof tipoate !== 'undefined') {
            if (tipoate == "") {
                //$('#dialog_mensajeComoAtender').show();
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

    console.log(detalle);
    //return;

    if (isOk) {
        var pedido = {
            pedidoId: id,
            ListaDetalleModel: detalle,
            typeAction: '2'     // mobile
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
                    //alert(response.message);

                    if (tipo == 1) {
                        //$('#popup_pendientes').hide();
                        $('#detallePedidoAceptado').text('Has agregado ' + totIng + ' productos a tu pedido');
                        //$('#dialog_aceptasPendientes').show();
                    }
                    else {
                        //$('#popup2_pendientes').hide();
                        $('#detallePedidoAceptado').text('No te olvides de ingresar en tu pedido los productos de este cliente.');
                        //$('#dialog2_aceptasPendientes').show();
                    }

                    ActualizarGanancia(response.DataBarra);
                    $('#PedidoAceptado').show();
                }
                else {
                    alert_msg(response.message);
                }
            },
            error: function (error) {
                CloseLoading();
                //alert(error);
                alert_msg("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
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
