$(document).ready(function () {
    CargarEventosClienteOnline();
});

function CargarEventosClienteOnline() {
    $('#div-tabs a').on('click', function (e) {
        if (!$(this).hasClass('active')) {
            $('#div-tabs a').removeClass('active');
            $(this).addClass('active');

            var campaniaId = $(this).attr('data-campania-id');
            LoadPedidosClienteOnlineByCampaniaId(campaniaId);
        }
    });
    $('#div-tabs a[data-campania-id="' + campaniaActual + '"]').trigger('click');
}
function LoadPedidosClienteOnlineByCampaniaId(campaniaId) {
    console.log(campaniaId);

    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: urlClienteOnline,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ campania: campaniaId }),
        success: function (data) {
            if (!checkTimeout(data)) return false;

            console.log(data);

            //if (data.success && data.listaPedidosClienteOnline.length > 0) {
            //    var tablaClientesOnline = SetHandlebars("#html-clientes-online", data.listaPedidosClienteOnline);
            //    $('#divTablaClientesOnline').html(tablaClientesOnline);
            //}
            //else $('#divTablaClientesOnline').html(data.message);
        },
        error: function (data) {
            $('#divTablaClientesOnline').html('Hubieron problemas de conexion al intentar cargar los pedidos de Consultora Online, inténtelo más tarde.');
            console.log(data);
        },
        complete: closeWaitingDialog
    });
}