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

function cerrandoPopupMobileClientePaso2() {
    
    var option = location.search.split('option=')[1];
    if (option === "P") //Producto
        MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 2", "Cerrar Pop up");
    if (option === "C") //Cliente
	    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 2", "Cerrar Pop up");
}
function MarcaAnalyticsClienteProducto(action, label) {
	var textAction = action;
	if (!(typeof AnalyticsPortalModule === 'undefined')) {
		AnalyticsPortalModule.ClickTabPedidosPendientes(textAction, label);
	}
}

function AceptarPedidoPendiente(id, tipo) {

    var btn = $('.btnAccion span').not('.active')[0];

    if (btn) {
	    var pedido = {
		    Accion: 2,
		    Dispositivo: glbDispositivo,
		    AccionTipo: $(btn).parent().data('accion'),
		    ListaGana: $(btn).parent().data('accion') == 'ingrgana' ? $('.conGanaMas').data('listagana') : []
	    }

	    ShowLoading({});
	    $.ajax({
		    type: 'POST',
		    url: '/ConsultoraOnline/AceptarPedidoPendiente',
		    dataType: 'json',
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(pedido),
		    async: true,
		    success: function(response) {
			    CloseLoading();
			    if (checkTimeout(response)) {
				    if (response.success) {

					    $('#popuplink').click();
					    return false;
				    } else {
					    if (response.code == 1) {
						    AbrirMensaje(response.message);
					    } else if (response.code == 2) {
						    $('#MensajePedidoReservado').text(response.message);
						    $('#AlertaPedidoReservado').show();
					    }
				    }
			    }
		    },
		    error: function(data, error) {
			    CloseLoading();
			    if (checkTimeout(data)) {
				    AbrirMensaje(
					    "Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
			    }
		    }
	    });

    } else {
	    var option = location.search.split('option=')[1];
	    if (option === "P") //Producto
            MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 2", "Alerta: Debes elegir como atender el pedido para aprobarlo");
	    if (option === "C") //Cliente
            MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 2", "Alerta: Debes elegir como atender el pedido para aprobarlo");
    }


}
