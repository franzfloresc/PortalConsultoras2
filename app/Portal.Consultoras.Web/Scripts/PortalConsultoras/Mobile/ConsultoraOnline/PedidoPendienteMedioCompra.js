$(document).ready(function () {

    $('.btnAccion').click(function (e) {

        if (!$(e.target).hasClass('active')) {
            $(e.target).addClass('active');
            $(e.target).html('Elegir');
        }
        else {
            $('.btnAccion').find('span').addClass('active');
            $('.btnAccion').find('span').html('Elegir');

            $(e.target).removeClass('active');
            $(e.target).html('Elegido');
        }

        if ($('.btnAccion span.active').length == $('.btnAccion span').length) {
            $('#btnAceptarPedido a').removeClass('active');
            // $('#btnAceptarPedido a').html('Elegido');
        }
        else {
            $('#btnAceptarPedido a').addClass('active');
            //   $('#btnAceptarPedido a').html('Elegir');
        }

        e.preventDefault();
        return false;
    });

    $(".btn_verMiPedido").on("click", function () {
        window.location.href = baseUrl + "Mobile/Pedido/Detalle";
    });

    $('#btnIrPedidoAprobar').click(function () {
        document.location.href = urlPendientes;
    });
    $('#btnIrPedido').click(function () {
        document.location.href = urlPedido;
    });

});

function AceptarPedidoPendiente(id, tipo) {

    var btn = $('.btnAccion span').not('.active')[0];

    if (btn) {
        var pedido = {
            Accion: 2,
            Dispositivo: glbDispositivo,
            AccionTipo: $(btn).parent().data('accion'),
            ListaGana: $(btn).parent().data('accion') == 'ingrgana' ? $('.conGanaMas').data('listagana') : [],
            OrigenTipoVista: gTipoVista
        }

        ShowLoading({});
        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/AceptarPedidoPendiente',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pedido),
            async: true,
            success: function (response) {
                CloseLoading();
                if (checkTimeout(response)) {
                    if (response.success) {
                        $('#popuplink').click();
                        if (!response.continuarExpPendientes) {
                            $("#btnIrPEdidoAprobar").hide();
                            $("#btnIrPedido").removeClass("action-btn_refuse");
                            $("#btnIrPedido").addClass("action-btn_continue");
                            $("#btnIrPedido").addClass("active");
                        } else {
                            $("#btnIrPEdidoAprobar").show();
                            $("#btnIrPedido").removeClass("action-btn_continue");
                            $("#btnIrPedido").removeClass("active");
                            $("#btnIrPedido").addClass("action-btn_refuse");
                        }
                        return false;
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
                }
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data)) {
                    AbrirMensaje("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
                }
            }
        });

    } else {
        var $MensajeTolTip = $("[data-tooltip=\"mensajepedidopaso2\"]");
        $MensajeTolTip.show();
        setTimeout(function () { $MensajeTolTip.hide(); }, 2000);
    }
}