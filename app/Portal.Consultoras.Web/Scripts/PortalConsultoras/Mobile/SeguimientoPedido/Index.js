var pedidoActual = "";
var pedidosCargados = new Array();

$(document).ready(function () {
    $(".mytab").click(function () {
        $('.mytab.active').removeClass("active");
        $(this).addClass("active");

        var campaniaSeleccionada = $(this).attr("data-campania");
        var nroPedidoSeleccionado = $(this).attr("data-nroPedido");
        pedidoSeleccionado = campaniaSeleccionada + '_' + nroPedidoSeleccionado;

        if (pedidoActual != pedidoSeleccionado) {
            $('#divListaPedidoDetalle_' + pedidoActual).hide();
            $('#divListaPedidoDetalle_' + pedidoSeleccionado).show();

            if (pedidosCargados.indexOf(pedidoSeleccionado) > -1) pedidoActual = pedidoSeleccionado;
            else cargarDetallePedido(campaniaSeleccionada, nroPedidoSeleccionado);
        }
    });
    $('.mytab.active').trigger("click");
});

function cargarDetallePedido(campaniaID, nroPedido) {
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlDetalle,
        dataType: 'html',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ campania: campaniaID, numeroPedido: nroPedido }),
        async: true,
        success: function (html) {
            if (!checkTimeout(html)) return false;

            pedidoActual = campaniaID + '_' + nroPedido;
            $("#divListaPedidoDetalle_" + pedidoActual).html(html);
            pedidosCargados.push(pedidoActual);
        },
        error: function (data, error) { },
        complete: CloseLoading
    });
}

function recargarPedidoActual() {
    var partes = pedidoActual.split('_');
    cargarDetallePedido(partes[0], partes[1]);
}