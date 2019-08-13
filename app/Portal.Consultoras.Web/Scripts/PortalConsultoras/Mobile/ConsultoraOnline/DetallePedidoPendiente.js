
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

    InicializarMotivoRechazo();

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
                            'event': 'addToCart',
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
	var tipoAtencion = "";

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

function MostrarMensajedeRechazoPedido(cuv, option) {
    var mensaje = '#' + cuv;
    $(mensaje).show();
    
    if (option === "P") //Producto
    {
	    MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", "Eliminar");
    }
    if (option === "C") //Cliente
    {
	    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", "Eliminar");
    }
    
}

function OcultarMensajedeRechazoPedido(cuv, option) {
    var mensaje = '#' + cuv;
    $(mensaje).hide();
    if (option === "P") //Producto
    {
	    MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", "¿Quieres eliminar este pedido? - No, gracias");
    }
    if (option === "C") //Cliente
    {
        MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", "¿Quieres eliminar este pedido? - No, gracias");
    }
}

function AceptarPedidoProducto(id, option) {

    var texto = '#texto_' + id;
    var aceptado = '#aceptar_' + id;
    if ($(aceptado).hasClass("active")) {
        $(texto).removeClass('text-white');
        $(texto).addClass('text-black');
        $(aceptado).removeClass('active');
        $(aceptado).addClass('btn--estadoAceptado');
        $(aceptado).text('Está aceptado');

        if (option === "P") //Producto
        {
	        MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", "Aceptado");
        }
        if (option === "C") //Cliente
        {
	        MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", "Aceptado");
        }
    }
    else {
        $(texto).removeClass('text-black');
        $(texto).addClass('text-white');
        $(aceptado).addClass('active');
        $(aceptado).removeClass('btn--estadoAceptado');
        $(aceptado).text('Aceptar');
        
    }

}

function RechazarSolicitudCliente(pedidoId, idMotivoRechazo, razonMotivoRechazo) {
    var obj = {
        pedidoId: pedidoId,
        motivoRechazoId: idMotivoRechazo,
        motivoRechazoTexto: razonMotivoRechazo
    };

    ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/RechazarSolicitudCliente",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        success: function (response) {
            CloseLoading();

            if (response.success) {
                
                SeRechazoConExito();
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

function RechazarSolicitudClientePorCuv(cuv, option) {
	
    var obj = {
        cuv: cuv,
    };
    if (option === "P") //Producto
    {
	    MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", '¿Desea Rechazar todos los pedidos de tus clientes? - Sí, gracias');
    }
    if (option === "C") //Cliente
    {
	    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", '¿Desea Rechazar todos los pedidos de tus clientes? - Sí, gracias');
    }
    ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/RechazarSolicitudClientePorCuv",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        success: function (response) {
            CloseLoading();
            if (response.success) {
                document.location.href = '/Mobile/ConsultoraOnline/Pendientes';
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

function ContinuarPedido(option) {
    var lstDetalle = [];
    ShowLoading();

    $('.pedidos').each(function () {

        if ($(this).find('a[id*="aceptar_"]').hasClass('active') == false) {
            var pedidoId = $(this).find(".pedidoId").val();
            var cuv = $(this).find(".cuv").val();
            var cantNew = $(this).find('[data-cantNew]').val();

            var detalle = {
                PedidoId: pedidoId,
                CUV: cuv,
                Cantidad: cantNew
            }
            lstDetalle.push(detalle);
        }
    });

    var obj = {
        lstDetalle: lstDetalle,
        tipoVista: gTipoVista
    };

    if (lstDetalle.length > 0) {
        $.ajax({
            type: "POST",
            url: "/ConsultoraOnline/ContinuarPedidos",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(obj),
            success: function (response) {
	            //marcacion analytics de Continuar
	            if (option === "P") //Producto
	            {
		            MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", 'Continuar');
	            }
	            if (option === "C") //Cliente
	            {
                    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", 'Continuar');
	            }
                CloseLoading();
                if (response.success) {
                    //HD-4734
                    if (response.result.ListaCatalogo.length == 0 || response.result.ListaGana.length == 0) AceptarPedidoPendienteDirecto(response.result.ListaGana,option);
                    else
                        document.location.href = '/Mobile/ConsultoraOnline/PendientesMedioDeCompra?option=' + option;
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
        
        if (option === "P") //Producto
        {
            MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", 'Alerta: Debes aceptar un pedido mínimo');
        }
        if (option === "C") //Cliente
        {
            MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", 'Alerta: Debes aceptar un pedido mínimo');
        }
	    
        CloseLoading();
        $('#mensajepedido').show();
        setTimeout(function () { $('#mensajepedido').hide(); }, 2000);
    }
}

function AceptarPedidoPendienteDirecto(listaGana, option) {

    var accionTipo = "";
    if (listaGana.length != 0) accionTipo = "ingrgana";
    else accionTipo = "ingrped";

    var pedido = {
        Accion: 2,
        Dispositivo: glbDispositivo,
        AccionTipo: accionTipo,
        ListaGana: accionTipo== 'ingrgana' ? listaGana : [],
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

            /** Analytics **/
            var textoAccionTipo = accionTipo === "ingrgana" ? "Acepto Todo el Pedido - Por Gana +" : "Acepto Todo el Pedido - Por catálogo";
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
                            if (accionTipo == "ingrgana") {  //por Gana+
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

                        AnalyticsMarcacionPopupConfirmacion(accionTipo === "ingrgana" ? "Por Gana+" : "Por catálogo", lstproduct);
                    }
                    $("#aprobarPedido").show();
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



}

function RechazarTodo(option) {
	
	if (option === "P") //Producto
	{
        MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", "Rechazar Todo");
	}
	if (option === "C") //Cliente
	{
        MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", "Rechazar Todo");
	}
}

function RechazarTodoConfirmacion(option) {
	
	if (option === "P") //Producto
	{
        MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", '¿Desea Rechazar todos los pedidos de tus clientes? - No, gracias');
	}
	if (option === "C") //Cliente
	{
        MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", '¿Desea Rechazar todos los pedidos de tus clientes? - No, gracias');
	}
}

function cerrandoPopupMobileProducto() {
    MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", "Cerrar Pop up");
}
function cerrandoPopupMobileCliente() {
    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", "Cerrar Pop up");
}
function MarcaAnalyticsClienteProducto(action, label) {
	var textAction = action;
	if (!(typeof AnalyticsPortalModule === 'undefined')) {
			AnalyticsPortalModule.ClickTabPedidosPendientes(textAction, label);
		}
	
}
function AnalyticsMarcacionPopupConfirmacion(strTipo, prod) {
    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickTabPedidosPendientes("Pop up Pedido Aprobado", strTipo);

        AnalyticsPortalModule.ClickVistaAddToCardPedidoPendiente(strTipo, prod);
    }
}
function EliminarSolicitudDetalle(pedidoId, cuv, origen) {
    var obj = {
        pedidoId: pedidoId,
        cuv: cuv
    };

    var pedidos = [];
    var cuvs = [];

    ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/EliminarSolicitudDetalle",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        success: function (response) {
            CloseLoading();
            if (response.success) {
	            
                //Analytics
                if (origen === "P") //Producto
                {
                    MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", "¿Quieres eliminar este pedido? - Sí, eliminar");
                }
                if (origen === "C") //Cliente
                {
                    MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", "¿Quieres eliminar este pedido? - Sí, eliminar");
                }

                var eliminoPedidoCompleto = true;
                var Pendientes = JSON.parse(response.Pendientes) || [];
                $.each(Pendientes.ListaPedidos, function (index, value) {
                    pedidos.push(value.PedidoId.toString());
                    $.each(value.DetallePedido, function (index, value) {
                        cuvs.push(value.CUV.toString());
                    });
                    if (value.PedidoId.toString() == pedidoId.toString()) {
                        eliminoPedidoCompleto = false
                    }
                });

                if (eliminoPedidoCompleto) {
                    ShowLoading();
                    window.location.href = '/Mobile/ConsultoraOnline/Pendientes';
                    return false;
                }
                // ocultar div
                var id = "";
                if (origen == 'C') {
                    id = '#vc_pedido_' + cuv;
                    $(id).hide();
                    if ($("#contentmobile").find('.pedidos').length == 1) {
                        window.location.href = "/Mobile/ConsultoraOnline/Pendientes";
                    }
                } else if (origen == 'P') {
                    id = '#vp_pedido_' + pedidoId;
                    $(id).hide();
                    if ($("#contentmobile").find('.pedidos').length == 1) {
                        window.location.href = "/Mobile/ConsultoraOnline/Pendientes";
                    }
                }
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

$("body").on('change', ".ValidaValor", function (e) {
    var $input = $(this);
    var previousVal = $input.val();

    if (previousVal == 0) {

        $input.val(1);
    }
});



function MotivoRechazoSolicitudPedidoPend(pedidoId, option) {
    $('#rechazarTodo').hide();
    $('#MotivosRechazo').removeClass('hide');
    $('#MotivosRechazo').css('display', 'block');
    $('#hdPedidoId').val(pedidoId);

    if (option === "P") //Producto
    {
        MarcaAnalyticsClienteProducto("Vista por Producto - Pop up Paso 1", '¿Desea Rechazar todos los pedidos de tus clientes? - Sí, gracias');
    }
    if (option === "C") //Cliente
    {
        MarcaAnalyticsClienteProducto("Vista por Cliente - Pop up Paso 1", '¿Desea Rechazar todos los pedidos de tus clientes? - Sí, gracias');
    }
}

function CerrarMotivoRechazo() {
    $('#MotivosRechazo').fadeOut(100);
    $('#rechazarTodo').show();
}

function SeRechazoConExito() {
    $('#MotivosRechazo-Paso1').css('display', 'none');
    $('#MotivosRechazo-Paso2').css('display', 'flex');
    setTimeout(function () {
        CerrarModalMotivosRechazo();
    }, 6000);
}

function CerrarModalMotivosRechazo() {
    if ($('#MotivosRechazo-Paso2').is(':visible')) {

        document.location.href = '/Mobile/ConsultoraOnline/Pendientes';
        
    } else {
        $('#MotivosRechazo').fadeOut(100);
    }
}


function InicializarMotivoRechazo() {

    var btnContinuar = $('#btnConfirmaMotivo');
    var checkOtroMotivo = $('#OtroMotivo');
    var txtOtroMotivo = $('#txtOtroMotivo');
    var rdoMotivos = $('[name="motivoRechazo"]');
    var hdMotivoRechazoId = $('#hdMotivoRechazoId');


    if (checkOtroMotivo.length) {
        checkOtroMotivo.change(function () {
            if ($('#OtroMotivo:checkbox:checked').length) {
                $('[name="motivoRechazo"]').prop('checked', false);
                txtOtroMotivo.prop('style', 'display:block');
                btnContinuar.removeClass('btn__sb--disabled');
                hdMotivoRechazoId.val(checkOtroMotivo.val());
            } else {
                txtOtroMotivo.prop('style', 'display:none !important');
                btnContinuar.addClass('btn__sb--disabled');
            }
        });

        checkOtroMotivo.trigger("change");
    }


    rdoMotivos.change(function () {
        console.log('change motivo rechazo');
        if (rdoMotivos.is(':checked')) {
            if (checkOtroMotivo.length) {
                checkOtroMotivo.prop('checked', false);
                checkOtroMotivo.trigger("change");
            }

            btnContinuar.removeClass('btn__sb--disabled');
        }
        hdMotivoRechazoId.val($('[name="motivoRechazo"]:checked').val());
    });

    btnContinuar.click(function (e) {
        var idPedido = $('#hdPedidoId').val().trim();
        var idMotivoRechazo = hdMotivoRechazoId.val().trim();
        var razonMotivoRechazo = (idMotivoRechazo == '11') ? txtOtroMotivo.val().trim() : '';

        RechazarSolicitudCliente(idPedido, idMotivoRechazo, razonMotivoRechazo);
    });


}
