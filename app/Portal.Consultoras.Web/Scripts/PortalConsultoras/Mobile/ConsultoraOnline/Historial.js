$(document).ready(function () {
    CargarEventosClienteOnline();
});

function CargarEventosClienteOnline() {
    $('#div-tabs a').on('click', function (e) {
        if (!$(this).hasClass('active')) {
            SeleccionarTab($(this));

            var campanias = [$(this).attr('data-campania-id')];
            var campaniaAnterior = $(this).next().attr('data-campania-id');
            if (campaniaAnterior != null && campaniaAnterior != '') campanias.push(campaniaAnterior);
            LoadPedidosClienteOnlineByCampaniaId(campanias);
        }
    });
    $('#div-tabs a[data-campania-id="' + campaniaActual + '"]').trigger('click');
}
function SeleccionarTab(objTab) {
    $('#div-tabs a.active').removeClass('active');
    objTab.addClass('active');
}
function LoadPedidosClienteOnlineByCampaniaId(campanias) {

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlClienteOnline,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ campanias: campanias }),
        success: function (data) {
            if (!checkTimeout(data)) return false;

            if (data.success) SeleccionarTab($('#div-tabs a[data-campania-id="' + data.campaniaResultado + '"]'));
            if (data.success && data.listaPedidosClienteOnline.length > 0) {
                var tablaClientesOnline = SetHandlebars("#html-clientes-online", data.listaPedidosClienteOnline);
                $('#divTablaClientesOnline').html(tablaClientesOnline);
            }
            else $('#divTablaClientesOnline').html(data.message);
        },
        error: function (data) {
            if (checkTimeout(data)) {
                $('#divTablaClientesOnline').html('Hubieron problemas de conexion al intentar cargar los pedidos de Consultora Online, inténtelo más tarde.');
            }
        },
        complete: CloseLoading
    });
}
function CargarDetalleHistorial(solicitudClienteId) {
    ShowLoading();
    location.href = urlClienteOnlineDetalleHistorial + '?solicitudClienteID=' + solicitudClienteId;
}