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
            ListaGana: $(btn).parent().data('accion') == 'ingrgana' ? $('.conGanaMas').data('listagana') : [],
            OrigenTipoVista: gTipoVista
        }
	    var AccionTipo = pedido.AccionTipo;

        ShowLoading({});
        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/AceptarPedidoPendiente',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pedido),
            async: true,
            success: function (response) {
	    ShowLoading({});
	    $.ajax({
		    type: 'POST',
		    url: '/ConsultoraOnline/AceptarPedidoPendiente',
		    dataType: 'json',
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(pedido),
		    async: true,
            success: function (response) {
	            
            /** Analytics **/
            var textoAccionTipo = AccionTipo === "ingrgana" ? "Acepto Todo el Pedido - Por Gana +" : "Acepto Todo el Pedido - Por catálogo";
	            var option = location.search.split('option=')[1];
	            if (option === "P") //Producto
                    MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 2", textoAccionTipo);
	            if (option === "C") //Cliente
                    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 2", textoAccionTipo);
				/** Fin Analytics **/

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
        var option = location.search.split('option=')[1];
        if (option === "P") //Producto
	    var option = location.search.split('option=')[1];
	    if (option === "P") //Producto
            MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 2", "Alerta: Debes elegir como atender el pedido para aprobarlo");
        if (option === "C") //Cliente
            MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 2", "Alerta: Debes elegir como atender el pedido para aprobarlo");
    }


}
