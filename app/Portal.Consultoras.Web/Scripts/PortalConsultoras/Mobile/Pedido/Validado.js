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
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Ecommerce',
                        'action': 'Modificar pedido',
                        'label': '(not available)'
                    });
                    location.href = urlIngresarPedido;
                } else {
                    CloseLoading();
                    alert_msg(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                alert_msg("Ocurrió un problema de conectividad. Por favor inténtelo mas tarde.");
            }
        }
    });
}

$(document).ready(function () {
    $('#btn_editar_pedido').on('click', function () {
        if (modificacionPedidoProl == "0") ConfirmarModificarPedido();
        else $("#divConfirmModificarPedido").modal("show");
    })
});