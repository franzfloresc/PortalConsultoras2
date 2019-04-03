$(document).ready(function () {

    alert('carge');
});


function AceptarPedidoPendiente(id, tipo) {
    var isOk = true;
    var detalle = [];
    var ing = 0;

    //d = {
    //            PedidoDetalleId: id,
    //            OpcionAcepta: k
    //        }
    //        detalle.push(d);
        

    if ( detalle.length > 0) {
        var name = ""; //$('#sc-nombre').text();
        var email = ""; //$('#sc-correo').text();

        var cliente = {
            ConsultoraId: 0,
            NombreCliente: name,
            Nombre: name,
            eMail: email
        };

        ShowLoading();

        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/GetExisteClienteConsultora',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(cliente),
            async: true,
            success: function (response) {
                CloseLoading();
                if (checkTimeout(response)) {
                    if (response.success) {
                        var pedido = {
                            PedidoId: id,
                            ClienteId: 0,
                            ListaDetalleModel: detalle,
                            Accion: 2,
                            Tipo: tipo,
                            Ingresos: ing,
                            Dispositivo: glbDispositivo
                        }

                        if (response.codigo == 0) {
                            _pedido = pedido;

                            showClienteDetalle(cliente, AceptarPedidoRegistraClienteOK);

                        }
                        else {
                            pedido.ClienteId = response.codigo;
                            ProcesarAceptarPedido(pedido);
                        }
                    }
                }
            },
            error: function (response) { }
        });
    }
}

function AceptarPedidoRegistraClienteOK(obj) {


    if (obj != null && _pedido !== null) {
        _pedido.ClienteId = obj.ClienteID;
        ProcesarAceptarPedido(_pedido);
        _pedido = null;
    }
}

function AceptarPedidoRegistraClienteCancel(obj) {
}

function ProcesarAceptarPedido(pedido) {
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
                    if (pedido.Tipo == 1) {
                        $('#detallePedidoAceptado').text('Has agregado ' + pedido.Ingresos.toString() + ' producto(s) a tu pedido');
                    }
                    else {
                        $('#detallePedidoAceptado').text('No te olvides de ingresar en tu pedido los productos de este cliente.');
                    }

                    ActualizarGanancia(response.DataBarra);
                    $('#PedidoAceptado').show();
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
}

var ClienteDetalleOK = null;
function showClienteDetalle(pcliente, pClienteDetalleOK) {
    var url = urlClienteDetalle;

    var cliente = pcliente || {};

    ShowLoading();

    $.ajax({
        type: 'GET',
        dataType: 'html',
        cache: false,
        url: url,
        data: cliente,
        success: function (data) {
            CloseLoading();

            $("#divDetalleCliente").html(data);
            $("#divAgregarCliente").modal("show");

            if ($.isFunction(pClienteDetalleOK)) ClienteDetalleOK = pClienteDetalleOK;
        },
        error: function (xhr, ajaxOptions, error) {
            CloseLoading();
        }
    });
}