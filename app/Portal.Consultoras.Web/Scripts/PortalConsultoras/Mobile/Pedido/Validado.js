function ConfirmarModificarPedido() {
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlDeshacerReservaPedidoReservado + '?Tipo=PV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    //dataLayer.push({
                    //    'event': 'virtualEvent',
                    //    'category': 'Ecommerce',
                    //    'action': 'Modificar pedido',
                    //    'label': '(not available)'
                    //});
                    location.href = urlIngresarPedido;
                } else {
                    CloseLoading();
                    messageInfo(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                messageInfo("Ocurrió un problema de conectividad. Por favor inténtelo mas tarde.");
            }
        }
    });
}

$(document).ready(function () {
    $('#btn_editar_pedido').on('click', function () {
        if (modificacionPedidoProl == "0") ConfirmarModificarPedido();
        else $("#divConfirmModificarPedido").modal("show");
    })

    $('.btn_ver_pedido_reservado').on('click', function () {
        $('.btn_ver_pedido_reservado').hide();
        $('.tooltip_validado').hide();
    })
});


function MostrarDetalleGanancia() {

    //$('#tituloGanancia').text($('#hdeCabezaEscala').val());
    //$('#lbl1DetaGanancia').text($('#hdeLbl1DetaGanancia').val());
    //$('#lbl2DetaGanancia').text($('#hdeLbl2DetaGanancia').val());
    //$('#pieGanancia').text($('#hdePieEscala').val());

    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').show();
}