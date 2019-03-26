﻿
var _pedido = null;
var ClienteDetalleOK = null;

$(document).ready(function () {

    $('.opcion_rechazo').on('click', function () {
        $('.opcion_rechazo').removeClass('opcion_rechazo_select');
        $(this).addClass('opcion_rechazo_select');
        if ($(this).data('id') == 11) {
            $('#txtOtrosRechazo').prop('readonly', false);
        }
        else {
            $('#txtOtrosRechazo').prop('readonly', true);
        }
    });

});

function RechazarPedido(id, origenBoton) {
    var opcionRechazo = ($('.opcion_rechazo_select').text()) ? $('.opcion_rechazo_select').text() : "";
    if (origenBoton) {
        switch (origenBoton) {
            case 1: /*boton enviar*/
                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¡Cuéntanos porqué lo Rechazaste! - Click Botón Enviar', opcionRechazo);
                break;
            case 2:/*boton cerrar*/
                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¡Cuéntanos porqué lo Rechazaste!', 'cerrar');
                break;
            default:
                break;
        }
    }


    var optr = $('.opcion_rechazo_select').data('id');
    if (typeof optr == 'undefined') {
        optr = 11;
    }

    var solval = $('#solped_' + id).val();
    var solarr = solval.split('|');
    var obsr = $("#txtOtrosRechazo").val();
    if (optr != 11) {
        obsr = '';
    }

    var obj = {
        SolicitudId: solarr[0],
        NumIteracion: solarr[9],
        CodigoUbigeo: solarr[10],
        Campania: solarr[2],
        MarcaId: solarr[1],
        OpcionRechazo: optr,
        RazonMotivoRechazo: obsr,
        typeAction: '2'
    };

    ShowLoading();

    $.ajax({
        type: "POST",
        url: baseUrl + "ConsultoraOnline/RechazarPedido",
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(obj),
        success: function (data) {
            if (checkTimeout(data)) {
                CloseLoading();
                if (data.success == true) {

                    $('#PedidoRechazado').hide();
                    $('#PedidoRechazadoDetalle').hide();
                    $('#MensajePedidoRechazado').show();
                    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Rechazado', opcionRechazo);
                }
                else {
                    $('#PedidoRechazado').hide();
                    $('#PedidoRechazadoDetalle').hide();
                    AbrirMensaje(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                $('#PedidoRechazado').hide();
                $('#PedidoRechazadoDetalle').hide();
                AbrirMensaje("Ocurrió un error inesperado al momento de desafiliarte. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });

};

function AceptarPedido(id, tipo) {
    var isOk = true;
    var detalle = [];
    var ing = 0;
    var opciones = "";

    $('div.detalle_pedido_reservado').each(function () {        
        var id = $(this).find("input[id*='soldet_']").val();
        var cant = $(this).find('#soldet_qty_' + id).text();
        var opt = $(this).find('#soldet_tipoate_' + id).val();
        var cuv = $(this).find("input[id*='soldet_cuv_']").val();
        var nombre = $(this).find("input[id*='soldet_nom_']").val();
        var precio = $(this).find("input[id*='soldet_precio_']").val();
        var marca = $(this).find("input[id*='soldet_mrc_']").val();
        var opcion = $(this).find("#soldet_tipoate_" + id + " option[value='" + opt + "']").text();
        var k = 0;



        opciones = (opciones.length) ? (opciones + ", ") : opciones;
        opciones = opciones + opcion;

        if (typeof opt !== 'undefined') {
            if (opt == "") {
                $('#ComoloAtenderas').show();
                isOk = false;
                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - PopUp Pedidos Pendientes', 'Click Botón', 'Acepto Todo el Pedido - ' + opciones);
                return false;
            }
            else {
                k = opt;
                if (opt == 'ingrped') {
                    ing += parseInt(cant);
                }
            }
        }

        if (typeof id !== 'undefined' && id !== "") {
            var d = {
                PedidoDetalleId: id,
                OpcionAcepta: k,
                Nombre: nombre,
                Precio: precio,
                Marca: marca,
                CUV: cuv,
                Categoria: 'No Disponible',
                Variante: 'Estándar',
                Cantidad: cant,
                OpcionCod: opt,
                OpcionString: opcion
            }
            detalle.push(d);
        }
    });
    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - PopUp Pedidos Pendientes', 'Click Botón', 'Acepto Todo el Pedido - ' + opciones);

    if (isOk && detalle.length > 0) {
        var name = $('#sc-nombre').text();
        var email = $('#sc-correo').text();

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
        url: '/ConsultoraOnline/AceptarPedido',
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
                   
                    var opciones = "";
                    $.each(pedido.ListaDetalleModel, function (i, item) {
                        opciones = (opciones.length) ? (opciones + ", ") : opciones;
                        opciones += item.OpcionString;
                    });
                    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Aceptado', opciones);

                    var PedidosIngresarAMiPedido = $.grep(pedido.ListaDetalleModel, function (n, i) {
                        return n.OpcionCod === 'ingrped';
                    });


                    if (PedidosIngresarAMiPedido.length) {
                        var productos = [];

                        $.each(PedidosIngresarAMiPedido, function (i, item) {
                            var producto = {}
                            producto["name"] = item.Nombre;
                            producto["price"] = item.Precio;
                            producto["brand"] = item.Marca;
                            producto["id"] = item.CUV;
                            producto["category"] = item.Categoria;
                            producto["variant"] = item.Variante;
                            producto["quantity"] = item.Cantidad;

                            productos.push(producto);
                        });

                        dataLayer.push({
                            'event': 'virtualPage',
                            'ecommerce': {
                                'currencyCode': AnalyticsPortalModule.GetCurrencyCode(),
                                'add': {
                                    'actionField': { 'list': 'Pedidos Pendientes - Pedidos Aceptados' },
                                    'products': productos
                                }
                            }
                        });

                    }

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

function CerrarMensajeRechazado(origenBoton) {
    if (origenBoton) {
        switch (origenBoton) {
            case 1: /*boton ok*/
                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Rechazado - Click Botón', 'Ok');
                break;
            case 2:/*boton cerrar*/
                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Rechazado', 'cerrar');
                break;
            default:
                break;
        }
    }
    document.location.href = urlPendientes;
}

function CerrarMensajeAceptado() {
    document.location.href = urlPendientes;
}

function MostrarMisPedidosConsultoraOnline() {
    var frmConsultoraOnline = $('#frmConsultoraOnline');
    frmConsultoraOnline.attr("action", urlMisPedidosClienteOnline);
    frmConsultoraOnline.submit();
}

function HorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var horarioRestringido = false;
    $.ajaxSetup({
        cache: false
    });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/EnHorarioRestringido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (mostrarAlerta == true) {
                        CloseLoading();
                        AbrirMensaje(data.message);
                    }
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
            }
        }
    });
    return horarioRestringido;
}

function CerrarAlertaPedidoReservado() {
    $('#AlertaPedidoReservado').hide();
    document.location.href = urlPedido;
}

function RechazoPedidosPendientes() {
    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Detalle Pedidos Pendientes', 'Click Botón', 'Rechazo el Pedido');
}

function AceptoTodoElPedidoTipoAtencion() {
    var tipoAtencion = ""

    if ($('.ddlAtenderPedidosPend').prop('selectedIndex') > 0) {
        tipoAtencion = $('.ddlAtenderPedidosPend').text();
    }

    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Click Botón', 'Acepto Todo el Pedido - ' + tipoAtencion);
}

function DialogComoAtenderPedidoPend(etiqueta) {
    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Alerta: No escogió tipo de Atención', etiqueta);
}

function VasARechazarelPedido(etiqueta) {
    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¿Vas a Rechazar el Pedido? - Click Botón', etiqueta);
}

function PedidoAceptado() {

}