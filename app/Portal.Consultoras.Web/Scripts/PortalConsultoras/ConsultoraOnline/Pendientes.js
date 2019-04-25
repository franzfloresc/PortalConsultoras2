var urlDetallePedidoPendiente = "/ConsultoraOnline/DetallePedidoPendiente"
var urlDetallePedidoPendienteClientes = "/ConsultoraOnline/DetallePedidoPendienteClientes";
var listaGana = [];

$(document).ready(function () {
 
});

 

function bindElments() {

    $('.btnAccion').click(function (e) {
        

        if (!$(e.target).hasClass('ghost')) {
            $('.btnAccion').find('a').removeClass('ghost');
            $('.btnAccion').find('a').html('Elegir');
            $(e.target).addClass('ghost');
            $(e.target).html('Elegido');

        }
        else {
           // $('.btnAccion').find('a').addClass('ghost');
            $(e.target).removeClass('ghost');
            $(e.target).html('Elegir');
       
        }

        if ($('.btnAccion a.ghost').length == $('.ghost a').length) {
            $('#btnAceptarPedido span').removeClass('second-color');
            $('#btnAceptarPedido span').addClass('disabled');
            $('#btnAceptarPedido span').html('Aceptar Pedido');
        }
        else {
            $('#btnAceptarPedido span').addClass('second-color');
            $('#btnAceptarPedido span').removeClass('disabled');
            $('#btnAceptarPedido span').html('Aceptar Pedido');
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


function AceptarPedidoPendiente() {

    

    var btn = $('.btnAccion a.ghost')[0];

    if (btn) {
        var pedido = {
            Accion: 2,
            Dispositivo: glbDispositivo,
            AccionTipo: $(btn).parent().data('accion'),
            ListaGana: $(btn).parent().data('accion') == 'ingrgana' ? listaGana : []
        }

        waitingDialog();
        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/AceptarPedidoPendiente',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pedido),
            async: true,
            success: function (response) {
                closeWaitingDialog();
                if (checkTimeout(response)) {
                    if (response.success) {

                        
                      
                        if ($('#modal-confirmacion')[0]) {
                            $('#modal-confirmacion').addClass('on');
                        }
                        else {
                            $('#popuplink').click();
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
                closeWaitingDialog();
                if (checkTimeout(data)) {
                    AbrirMensaje("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
                }
            }
        });

    }


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
    console.log(JSON.stringify(cuv));
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
                $('#rechazarTodop').addClass('hide');
                $('#Paso1-Productos').hide();
                //document.location.href = '/ConsultoraOnline/Pendientes';

                //var Pendientes = response.Pendientes || [];

                //$.each(Pendientes, function (index, value) {
                //    if (value.ListaClientes.length > 2) {
                //        value.MasDeDosClientes = true;
                //        value.ListaClientes = value.ListaClientes.slice(0, 1);
                //    }                    
                //});

                //SetHandlebars("#template-vpcpContent", Pendientes, "#vpcpContent");

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
                $('#rechazarTodo').addClass('hide');
                $('#Paso1-Clientes').hide();
                //document.location.href = '/ConsultoraOnline/Pendientes';

                //var Pendientes = response.Pendientes || [];

                //$.each(Pendientes, function (index, value) {
                //    if (value.ListaClientes.length > 2) {
                //        value.MasDeDosClientes = true;
                //        value.ListaClientes = value.ListaClientes.slice(0, 1);
                //    }
                //});

                //SetHandlebars("#template-vpcpContent", Pendientes, "#vpcpContent");
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

        if ($(this).find('a[id*="aceptar_"]').hasClass('ghost')) {
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
                //CloseLoading();
                if (response.success) {
                    
                    
                    SetHandlebars("#template-paso-2", response.result, "#contenedor-paso-2");
                    if (response.result.ListaGana.length == 0 || response.result.GananciaGana<= 0 )
                    {
                        $('.porGanaMas').parent().remove();
                    }
                    cargarGaleria()
                    bindElments();
                    return false;
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

                var Pendientes = response.Pendientes || [];

                $.each(Pendientes, function (index, value) {
                    if (value.ListaClientes.length > 2) {
                        value.MasDeDosClientes = true;
                        value.ListaClientes = value.ListaClientes.slice(0, 1);
                    }
                });

                SetHandlebars("#template-vpcpContent", Pendientes, "#vpcpContent");
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