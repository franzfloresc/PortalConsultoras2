$(document).ready(function () {

    $('.btnAccion').click(function (e) {

        if (!$(e.target).hasClass('active')) {
            $(e.target).addClass('active');
            $(e.target).removeClass('btn--estadoAceptado');
            $(e.target).html('Elegir');
        }
        else {
            $('.btnAccion').find('span').addClass('active');
            $('.btnAccion').find('span').html('Elegir');

            $(e.target).removeClass('active');
            $(e.target).addClass('btn--estadoAceptado');
            $(e.target).html('Elegido');
        }

        if ($('.btnAccion span.active').length == $('.btnAccion span').length) {
            $('#btnAceptarPedido a').removeClass('active');
        }
        else {
            $('#btnAceptarPedido a').addClass('active');
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
    var accionTipo = $(btn).parent().data('accion');

    if (btn) {
        var pedido = {
            Accion: 2,
            Dispositivo: glbDispositivo,
            AccionTipo: accionTipo,
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

                        var mensajeConfirmacion = (accionTipo == "ingrgana") ? "Has atendido el pedido por Gana+." : "Has atendido el pedido por Catálogo.";
                        $("#mensajeConfirmacion").html(mensajeConfirmacion);

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

                        /**  Si fue exitos debe enviar los siguiente eventos Analytics **/

                        var lstproduct = [];
                        var listProductos = [];
                        var pedidoSessionJson = JSON.parse(response.PedidosSesion);

                        if (response.ListaGana !== null) {
                            listProductos = response.ListaGana || [];
                        } else {
                            listProductos = pedidoSessionJson[0].DetallePedido || [];
                        }
                        if (listProductos.length > 0) {
                            listProductos.forEach(function (product) {
                                var itemProduct = {};
                                if ($(btn).parent().data('accion') == "ingrgana") {  //por Gana+
                                    itemProduct = {
                                        "id": product.CUV2,
                                        "name": product.DescripcionCUV2,
                                        "price": product.PrecioString,
                                        "brand": product.DescripcionMarca,
                                        "category": "(not available)",
                                        "variant": "Estándar",
                                        "quantity": product.Cantidad
                                    };
                                } else {        //Por Catálogo
                                    itemProduct = {
                                        "id": product.CUV,
                                        "name": product.Producto,
                                        "price": product.PrecioTotal.toFixed(2),
                                        "brand": product.Marca,
                                        "category": "(not available)",
                                        "variant": "Estándar",
                                        "quantity": product.Cantidad
                                    };
                                }
                                lstproduct.push(itemProduct);

                            });

                            AnalyticsMarcacionPopupConfirmacion($(btn).parent().data('accion') === "ingrgana" ? "Por Gana+" : "Por catálogo", lstproduct);
                        }
                        return false;
                    }
                    else {
                        if (response.code == 1) {
                            AbrirMensaje(response.message);
                        }
                        else if (response.code == 2) {
                            AbrirMensaje(response.message);
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
            MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 2", "Alerta: Debes elegir como atender el pedido para aprobarlo");
        else if (option === "C") //Cliente
            MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 2", "Alerta: Debes elegir como atender el pedido para aprobarlo");
    }

}
