var urlDetallePedidoPendiente = "/ConsultoraOnline/DetallePedidoPendiente"
var urlDetallePedidoPendienteClientes = "/ConsultoraOnline/DetallePedidoPendienteClientes";

$(document).ready(function () {
    //  debugger;
    // CargarPaso2();            
    // debugger;
    //  SetHandlebars("#template-paso-2", null, "#contenedor-paso-2");
});

function CargarPaso2() {
    //ShowLoading({});
    $.ajax({
        type: 'POST',
        url: '/ConsultoraOnline/PendientesMedioDeCompra',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            // CloseLoading();
            if (checkTimeout(response)) {
                if (response.success) {
                    debugger;
                    SetHandlebars("#template-paso-2", response.result, "#contenedor-paso-2");
                    cargarGaleria()
                    bindElments();
                    return false;
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
}

function bindElments() {

    $('.btnAccion').click(function (e) {
        debugger;

        if (!$(e.target).hasClass('active')) {
            $(e.target).addClass('active');
            $(e.target).html('Elegir');
        }
        else {
            $('.btnAccion').find('span').addClass('active');
            $(e.target).removeClass('active');
            $(e.target).html('Elegido');
        }

        if ($('.btnAccion span.active').length == $('.btnAccion span').length) {
            $('#btnAceptarPedido a').removeClass('active');
            $('#btnAceptarPedido a').html('Elegido');
        }
        else {
            $('#btnAceptarPedido a').addClass('active');
            $('#btnAceptarPedido a').html('Elegir');
        }

        e.preventDefault();
        return false;
    });


    //$(".btn_verMiPedido").on("click", function () {
    //    window.location.href = baseUrl + "Mobile/Pedido/Detalle";
    //});

    //$('#btnIrPedidoAprobar').click(function () {
    //    document.location.href = urlPendientes;
    //});
    //$('#btnIrPedido').click(function () {
    //    document.location.href = urlPedido;
    //});
}

function cargarGaleria() {
    $('.conGanaMas').slick({
        arrows: true,
        mobileFirst: true,
        infinite: false,
        centerPadding: '40px',
        slidesToShow: 2,
        prevArrow: '<a class="btn btn-circle left white-color" href="#"><</a>',
        nextArrow: '<a class="btn btn-circle right white-color" href="#">></a>'
        // slidesToShow: 2.3
    });

    $('.conCatalogo').slick({
        arrows: true,
        mobileFirst: true,
        infinite: false,
        centerPadding: '40px',
        // slidesToShow: 2
        slidesToShow: 2.3,
        prevArrow: '<a class="btn btn-circle left white-color" href="#"><</a>',
        nextArrow: '<a class="btn btn-circle right white-color" href="#">></a>'
    });
}

function DetallePedidoPendienteClientes(cuv) {
    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickBotonTabVistaProducto('In Tab Vista Producto - Click Botón', 'Confirmar Clientes');
    }
    DetallePedidoPendienteClientesService(cuv);
}

function DetallePedidoPendienteClientesVerMas(cuv) {
    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickBotonTabVistaProducto('In Tab Vista Producto - Click Botón', 'Ver más');
    }
    DetallePedidoPendienteClientesService(cuv);
}

function DetallePedidoPendienteClientesService(Cuv) {
    var obj = {
        cuv: cuv
    }
    $.ajax({
        type: 'POST',
        url: urlDetallePedidoPendienteClientes,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {

            console.log(response);
            if (response.success) {
                debugger;
                console.log(response);
                SetHandlebars("#template-paso-1-Clientes", response.data, "#Paso1-Clientes");
                $('#Paso1-Clientes').show();
            }
        },
        error: function (error) {
            //CloseLoading();
            //messageInfo("Ocurrió un Error pedido pendiente cliente");
            console.log(error);
        }
    });
}

function DetallePedidoPendiente(ids) {
    debugger;
    console.log(JSON.stringify(ids));
    //console.log(JSON.stringify(cuv));
    var obj = {
        ids: ids
    }
    $.ajax({
        type: 'POST',
        url: urlDetallePedidoPendiente,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (response.success) {
                debugger;
                console.log(response);
                SetHandlebars("#template-paso-1-Producto", response.data, "#Paso1-Productos");
                $('#Paso1-Productos').show();
            }
        },
        error: function (error) {
            //CloseLoading();
            //messageInfo("Ocurrió un Error pedido pendiente cliente");
            console.log(error);
        }
    });
}

function MostrarMensajedeRechazoPedido(cuv) {
    var mensaje = '#' + cuv;
    $(mensaje).show();
    //document.location.href = urlPedido;
}

function OcultarMensajedeRechazoPedido(cuv) {
    var mensaje = '#' + cuv;
    $(mensaje).hide();
    //document.location.href = urlPedido;
}

function AceptarPedidoProducto(id) {
    debugger;
    //var texto = '#texto_' + id;
    var aceptado = '#aceptar_' + id;
    if ($(aceptado).hasClass("ghost")) {
        //$(texto).removeClass('text-white');
        //$(texto).addClass('ghost');
        $(aceptado).removeClass('ghost');
        $(aceptado).text('Aceptar');
    }
    else {
        //$(texto).removeClass('text-black');
        //$(texto).addClass('text-white');
        $(aceptado).addClass('ghost');
        $(aceptado).text('Aceptado');
        //document.location.href = urlPedido;
    }

}

function RechazarSolicitudCliente(pedidoId) {
    var obj = {
        pedidoId: pedidoId,
    };

    //ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/RechazarSolicitudCliente",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        success: function (response) {
            //CloseLoading();

            if (response.success) {
                //document.location.href = '/ConsultoraOnline/Pendientes';
            }
            else {
                alert(response.message);
            }
        },
        error: function (err) {
            //CloseLoading();
            console.log(err);
        }
    });
}

function RechazarSolicitudClientePorCuv(cuv) {
    var obj = {
        cuv: cuv,
    };

    //ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/RechazarSolicitudClientePorCuv",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        success: function (response) {
                    /*CloseLoading*/
            if (response.success) {
                //document.location.href = '/ConsultoraOnline/Pendientes';
            }
            else {
                alert(response.message);
            }
        },
        error: function (err) {
            //CloseLoading();
            console.log(err);
        }
    });

}

function ContinuarPedido() {
    var lstDetalle = [];
    //ShowLoading();

    $('.pedidos').each(function () {

        if ($(this).find('a[id*="aceptar_"]').hasClass('active') == false) {
            //$(aceptado).addClass('active');
            var pedidoId = $(this).find(".pedidoId").val();
            var cuv = $(this).find(".cuv").val();
            //var cantidad = $(this).find(".cantidad").val();
            var cantNew = $(this).find('[data-cantNew]').val();

            var detalle = {
                PedidoId: pedidoId,
                CUV: cuv,
                Cantidad: cantNew
            }
            lstDetalle.push(detalle);
        }
    });

    if (lstDetalle.length > 0) {
        $.ajax({
            type: "POST",
            url: "/ConsultoraOnline/ContinuarPedidos",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(lstDetalle),
            success: function (response) {
                CloseLoading();
                if (response.success) {
                    //document.location.href = '/ConsultoraOnline/PendientesMedioDeCompra';
                }
                else {
                    alert(response.message);
                }
            },
            error: function (err) {
                CloseLoading();
                console.log(err);
            }
        });
    }
    else {
        //CloseLoading();
        $('#mensajepedido').show();
    }
}

function EliminarSolicitudDetalle(pedidoId, cuv, origen) {
    var obj = {
        pedidoId: pedidoId,
        cuv: cuv
    }

    //ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/EliminarSolicitudDetalle",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        success: function (response) {
            //CloseLoading();
            if (response.success) {
                // ocultar div
                if (origen == 'C') {
                    var id = '#vc_pedido_' + cuv;
                    $(id).hide();
                } else if (origen == 'P') {
                    var id = '#vp_pedido_' + pedidoId;
                    $(id).hide();
                }
            }
            else {
                alert(response.message);
            }
        },
        error: function (err) {
            //CloseLoading();
            console.log(err);
        }
    });

}

function PedidosPendientesVistaCliente() {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.clickTabPedidosPendientes('Click Tab', 'Vista por Cliente');
    }
}

function PedidosPendientesVistaProducto() {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.clickTabPedidosPendientes('Click Tab', 'Vista por Producto');
    }
}
