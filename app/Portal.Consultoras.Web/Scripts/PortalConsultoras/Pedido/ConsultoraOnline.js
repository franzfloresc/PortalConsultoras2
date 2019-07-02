
//var flagHuboPedidosPend = false;
//var _pedido = null;

$(document).ready(function () {

    //$('#pedmostreo').addClass('bordespacive');
    //$('.fondo_lateral').removeClass("fondo_lateral");
    //$('#penmostreo').addClass('tab_pendiente_es');

    //$('#pedmostreo').on('click', function () {
    //    $('.content_T_T').removeClass("fondo_lateral");
    //    $(".fondo_pendiente").fadeOut();
    //    $(".bloque_left").fadeOut();
    //    $('#pedmostreo').addClass('bordespacive');
    //    $('#penmostreo').removeClass('bordespacive');
    //    $('#penmostreo').addClass('tab_pendiente_es');
    //    $('#infoPedido').show();
    //    $('#infoPendientes').hide();
    //    $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').show();
    //    $("#paginadorCab").show();
    //    $("#paginadorCabPend").hide();
    //    $('.caja_guardar_pedido').show();
    //    $('.contenedor_eliminacion_pedido').show();
    //    $('.contenedor_banners').show();
    //    $('.info_tiempo_oportunidad.inicial').show();
    //    $('.caja_carousel_productos::after').removeClass('aparece_bloqueo');
    //    $('#pedmostreo').removeClass('cambio_bk_pendientes');
    //    $('.datos_para_movil').show();

    //    $('#penmostreo').attr("data-tab-activo", '0');
    //    $('#pedmostreo').attr("data-tab-activo", '1');
    //});

    //$('#penmostreo').on('click', function () {
    //    $('.content_T_T').addClass("fondo_lateral");
    //    $(".fondo_pendiente").fadeIn();
    //    $(".bloque_left").fadeIn();
    //    $('#pedmostreo').removeClass('bordespacive');
    //    $('#penmostreo').addClass('bordespacive');
    //    $('#penmostreo').removeClass('tab_pendiente_es');
    //    $('#infoPedido').hide();
    //    $('#infoPendientes').show();
    //    $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').hide();
    //    $("#paginadorCab").hide();
    //    $("#paginadorCabPend").show();
    //    $('.caja_guardar_pedido').hide();
    //    $('.contenedor_eliminacion_pedido').hide();
    //    $('.contenedor_banners').hide();
    //    $('.info_tiempo_oportunidad.inicial').hide();
    //    $('#pedmostreo').addClass('cambio_bk_pendientes');
    //    $('.datos_para_movil').hide();
    //    $('#penmostreo').attr("data-tab-activo", '1');
    //    $('#pedmostreo').attr("data-tab-activo", '0');
    //});

    //$('.optionsRechazo').on('click', function () {
    //    $('.optionsRechazo').removeClass('optionsRechazoSelect');
    //    $(this).addClass('optionsRechazoSelect');
    //    if ($(this).data('id') == 11) {
    //        $('#txtOtrosRechazo').prop('readonly', false);
    //    }
    //    else {
    //        $('#txtOtrosRechazo').prop('readonly', true);
    //    }
    //});

    //$('.regresaPendientes').on('click', function () {
    //    $('#popup_pendientes').hide();
    //});

    //$('.btn_revisalo_pendientes2').on('click', function () {
    //    $('.popupPendientesPORTAL').show();
    //});

    //$('.cerrarPendientesPORTAL').on('click', function () {
    //    $('.popupPendientesPORTAL').hide();
    //});

    //CargarPedidosPend();
});

//function CargarPedidosPend(page, rows) {

//    $('#divPedidosPend').html('<div style="text-align: center;">Cargando Pedidos Pendientes<br><img src="' + urlLoad + '" /></div>');

//    var obj = {
//        sidx: "",
//        sord: "",
//        page: page || 1,
//        rows: rows || $($('#paginadorCabPend [data-paginacion="rows"]')[0]).val() || 10,
//    };

//    $.ajax({
//        type: 'POST',
//        url: baseUrl + 'ConsultoraOnline/CargarMisPedidos',
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(obj),
//        async: true,
//        success: function (response) {
//            if (checkTimeout(response)) {
//                if (response.success) {
//                    var data = response.data;
//                    if (data.RegistrosTotal > 0) {

//                        $('#cont1PedidosPend').text(data.RegistrosTotal);
//                        $('#cont2PedidosPend').text(data.RegistrosTotal);
//                        $('#fecPedidoPendRec').text(data.FechaPedidoReciente);

//                        var html = SetHandlebars("#pedidopend-template", data.ListaPedidos);
//                        $('#divPedidosPend').html(html);

//                        flagHuboPedidosPend = true;

//                        data.footer = true;
//                        var htmlPaginadorPendH = ArmarDetallePedidoPaginador(data);

//                        data.footer = false;
//                        var htmlPaginadorPendF = ArmarDetallePedidoPaginador(data);

//                        $("#paginadorCabPend").html(htmlPaginadorPendH);
//                        $("#paginadorPiePend").html(htmlPaginadorPendF);

//                        $("#paginadorCabPend [data-paginacion='rows']").val(data.Registros || 10);
//                        $("#paginadorPiePend [data-paginacion='rows']").val(data.Registros || 10);

//                        $('#penmostreo').show();

//                        //if (lanzarTabConsultoraOnline == '1') {
//                        //    $('.content_T_T').addClass("fondo_lateral");
//                        //    $(".fondo_pendiente").fadeIn();
//                        //    $(".bloque_left").fadeIn();
//                        //    $('#pedmostreo').removeClass('bordespacive');
//                        //    $('#penmostreo').addClass('bordespacive');
//                        //    $('#penmostreo').removeClass('tab_pendiente_es');
//                        //    $('#infoPedido').hide();
//                        //    $('#infoPendientes').show();
//                        //    $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').hide();
//                        //    $('ul.paginador_notificaciones').hide();
//                        //    $('.caja_guardar_pedido').hide();
//                        //    $('.contenedor_eliminacion_pedido').hide();
//                        //    $('.contenedor_banners').hide();
//                        //    $('.info_tiempo_oportunidad.inicial').hide();
//                        //    $('#pedmostreo').addClass('cambio_bk_pendientes');
//                        //    $('.datos_para_movil').hide();

//                        //    $('#penmostreo').attr("data-tab-activo", '1');
//                        //    $('#pedmostreo').attr("data-tab-activo", '0');
//                        //}
//                    }
//                    else {

//                        $('#divPedidosPend').empty();

//                        if (flagHuboPedidosPend) {
//                            $('#penmostreo').hide();
//                            $('.content_T_T').removeClass("fondo_lateral");
//                            $(".fondo_pendiente").fadeOut();
//                            $(".bloque_left").fadeOut();
//                            $('#infoPedido').show();
//                            $('#infoPendientes').hide();
//                            $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').show();
//                            $('ul.paginador_notificaciones').show();
//                            $('.caja_guardar_pedido').show();
//                            $('.contenedor_eliminacion_pedido').show();
//                            $('.contenedor_banners').show();
//                            $('.info_tiempo_oportunidad.inicial').show();
//                            $('.caja_carousel_productos::after').removeClass('aparece_bloqueo');
//                            $('#pedmostreo').removeClass('cambio_bk_pendientes');
//                            $('.datos_para_movil').show();

//                            $('#pedmostreo').val('MIS <b>PRODUCTOS</b>');

//                            $('#penmostreo').attr("data-tab-activo", '0');
//                            $('#pedmostreo').attr("data-tab-activo", '1');

//                            CargarDetallePedido();
//                        }
//                    }
//                }
//                else {
//                    $('#divPedidosPend').empty();
//                    alert_msg("No se pudieron obtener los datos");
//                }
//            }
//        },
//        error: function (data, error) {
//            if (checkTimeout(data)) {
//                alert_msg("Ocurrió un error inesperado al buscar los pedidos. Consulte con su administrador del sistema para obtener mayor información");
//            }
//        }
//    });
//}

//function CargarPopupPedidoPend(page, rows, pedidoId, estado) {

//    var obj = {
//        sidx: "",
//        sord: "",
//        page: page || 1,
//        rows: rows || $($('#paginadorCabPendPoput [data-paginacion="rows"]')[0]).val() || 10,
//        pedidoId: pedidoId
//    };

//    waitingDialog({});
//    if (estado == 0) {

//        lstDetallePedidoPoput = [];

//        $.ajax({
//            type: 'POST',
//            url: baseUrl + 'ConsultoraOnline/CargarMisPedidosDetalle',
//            dataType: 'json',
//            contentType: 'application/json; charset=utf-8',
//            data: JSON.stringify(obj),
//            async: true,
//            success: function (response) {
//                closeWaitingDialog();
//                if (checkTimeout(response)) {
//                    if (response.success) {
//                        var data = response.data;
//                        if (data.RegistrosTotal > 0) {

//                            lstDetallePedidoPoput.push(data);
//                            var row = $('#pedidopend_' + pedidoId).val();
//                            var arr = row.split('|');
//                            var t = 1;
//                            if (arr[1] > 0) {
//                                t = 2;
//                            }

//                            var pnombre = '';
//                            if (arr[3].indexOf(' ') > 0) {
//                                pnombre = arr[3].substring(0, arr[3].indexOf(' '));
//                            } else {
//                                pnombre = arr[3];
//                            }

//                            var d1 = {
//                                PedidoId: pedidoId,
//                                Contacto: pnombre,
//                                Nombre: arr[3],
//                                Telefono: arr[4],
//                                Direccion: arr[5],
//                                Email: arr[6],
//                                Comentario: arr[7],
//                                PrecioTotal: arr[13],
//                                SaldoHoras: arr[14],
//                                FlagConsultora: (arr[15] == 'true') ? 1 : 0,
//                            }

//                            var htmlPaginadorPendH = '';
//                            var jsonDetallePedido = PaginacionDetallePedido(data.ListaDetalle, data.Pagina, data.Registros);
//                            if (t == 1) {
//                                var html = SetHandlebars("#popup-pedidopend-template", d1);
//                                $('#divPopupPedidoPend').html(html);

//                                var html2 = SetHandlebars("#detalle-pedidopend-template", jsonDetallePedido);
//                                $('#divDetPedidoPend').html(html2);

//                                data.footer = true;
//                                htmlPaginadorPendH = ArmarDetallePedidoPaginador(data);
//                                $("#paginadorCabPendPoput").html(htmlPaginadorPendH);
//                                $("#paginadorCabPendPoput [data-paginacion='rows']").val(data.Registros || 10);
//                                $("#hdPedidoPendPoputPedidoId2").val(0);

//                                $('#popup_pendientes').show();
//                            }
//                            else {
//                                var html = SetHandlebars("#popup2-pedidopend-template", d1);
//                                $('#divPopup2PedidoPend').html(html);
//                                $(".cubre2").css({ 'height': '245px' });

//                                var html2 = SetHandlebars("#detalle2-pedidopend-template", jsonDetallePedido);
//                                $('#divDet2PedidoPend').html(html2);

//                                data.footer = true;
//                                htmlPaginadorPendH = ArmarDetallePedidoPaginador(data);
//                                $("#paginadorCabPendPoput2").html(htmlPaginadorPendH);
//                                $("#paginadorCabPendPoput2 [data-paginacion='rows']").val(data.Registros || 10);
//                                $("#hdPedidoPendPoputPedidoId").val(0);

//                                $('#popup2_pendientes').show();
//                            }
//                        }
//                        else {
//                            alert_msg("No se encontraron resultados");
//                        }
//                    }
//                    else {
//                        alert_msg("No se pudieron obtener los datos");
//                    }
//                }
//            },
//            error: function (data, error) {
//                closeWaitingDialog();
//                if (checkTimeout(data)) {
//                    alert_msg("Ocurrió un error inesperado al buscar los detalles del pedido. Consulte con su administrador del sistema para obtener mayor información");
//                }
//            }
//        });
//    }
//    else {

//        if (lstDetallePedidoPoput.length > 0) {

//            var data = lstDetallePedidoPoput[0];
//            data.Pagina = obj.page;
//            data.PaginaDe = parseInt((((data.ListaDetalle.length - 1) / obj.rows) + 1), 10);
//            var row = $('#pedidopend_' + pedidoId).val();
//            var arr = row.split('|');
//            var t = 1;
//            if (arr[1] > 0) {
//                t = 2;
//            }

//            var htmlPaginadorPendH = '';
//            var jsonDetallePedido = PaginacionDetallePedido(data.ListaDetalle, obj.page, obj.rows);
//            if (t == 1) {
//                var html2 = SetHandlebars("#detalle-pedidopend-template", jsonDetallePedido);
//                $('#divDetPedidoPend').html(html2);

//                data.footer = true;
//                htmlPaginadorPendH = ArmarDetallePedidoPaginador(data);
//                $("#paginadorCabPendPoput").html(htmlPaginadorPendH);
//                $("#paginadorCabPendPoput [data-paginacion='rows']").val(obj.rows || 10);
//                $("#hdPedidoPendPoputPedidoId2").val(0);

//                CargarCombosPedidoDetallePoput(jsonDetallePedido, obj.page, obj.rows);
//            }
//            else {
//                var html2 = SetHandlebars("#detalle2-pedidopend-template", jsonDetallePedido);
//                $('#divDet2PedidoPend').html(html2);

//                data.footer = true;
//                htmlPaginadorPendH = ArmarDetallePedidoPaginador(data);
//                $("#paginadorCabPendPoput2").html(htmlPaginadorPendH);
//                $("#paginadorCabPendPoput2 [data-paginacion='rows']").val(obj.rows || 10);
//                $("#hdPedidoPendPoputPedidoId").val(0);

//                CargarCombosPedidoDetallePoput(jsonDetallePedido, obj.page, obj.rows);
//            }
//        }
//        else {
//            alert_msg("No se encontraron resultados");
//        }
//        closeWaitingDialog();
//    }
//}

//function CargarCombosPedidoDetallePoput(data, page, per_page) {
//    var index = (page - 1) * per_page;
//    var namecombo = '#ddlAtender_';
//    for (var i = 0; i < data.length; i++) {
//        var combo = data[i].OptAtender === null ? '' : '#' + data[i].OptAtender.split('|')[0];
//        var value = data[i].OptAtender === null ? '' : data[i].OptAtender.split('|')[1];
//        var id = index + i;
//        if (combo.length > 0)
//            $(combo).val(value);
//        else
//            $(namecombo + '_' + id).val(value);
//    }
//}

//var lstDetallePedidoPoput = [];

//function PaginacionDetallePedido(jsonObj, page, per_page) {
//    var table_current = [];

//    for (var i = (page - 1) * per_page; i < (page * per_page); i++) {
//        if (typeof jsonObj[i] !== 'undefined') {
//            jsonObj[i].Index = i;
//            table_current.push(jsonObj[i]);
//        }
//    }

//    return table_current;
//}

//function ShowPopupRechazoPedido(pedidoId, tipo) {
//    $('#dialog_confirmacionRechazo').show();
//    $('#hdePedidoIdRechazo').val(pedidoId);
//}

//function ShowPopupMotivoRechazo() {
//    var id = $('#hdePedidoIdRechazo').val();
//    var row = $('#pedidopend_' + id).val();
//    var arr = row.split('|');

//    $('#SolicitudId').val(arr[0]);
//    $('#MarcaID').val(arr[1]);
//    $('#Campania').val(arr[2]);
//    $('#NumIteracion').val(arr[9]);
//    $('#CodigoUbigeo').val(arr[10]);

//    $('#dialog_confirmacionRechazo').hide();
//    $('#dialog_motivoRechazo').show();

//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¿Vas a Rechazar el Pedido? - Click Botón', 'Sí, Rechazo el Pedido');
//}

//function RechazarPedido(origenBoton) {
//    var opcionRechazo = ($('.optionsRechazoSelect').text()) ? $('.optionsRechazoSelect').text() : "";
//    if (origenBoton) {
//        switch (origenBoton) {
//            case 1: /*boton enviar*/
//                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¡Cuéntanos porqué lo Rechazaste! - Click Botón Enviar', opcionRechazo);
//                break;
//            case 2:/*boton cerrar*/
//                DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¡Cuéntanos porqué lo Rechazaste!', 'cerrar');
//                break;
//            default:
//                break;
//        }
//    }


//    $('#btnRechazarPedido').prop('disabled', true);

//    var opt = $('.optionsRechazoSelect').data('id');
//    if (typeof opt == 'undefined') {
//        opt = 11;
//    }

//    var obj = {
//        SolicitudId: $("#SolicitudId").val(),
//        NumIteracion: $("#NumIteracion").val(),
//        CodigoUbigeo: $("#CodigoUbigeo").val(),
//        Campania: $("#Campania").val(),
//        MarcaId: $("#MarcaID").val(),
//        OpcionRechazo: opt,
//        RazonMotivoRechazo: $("#txtOtrosRechazo").val(),
//        typeAction: '1'
//    };

//    waitingDialog({});

//    $.ajax({
//        type: "POST",
//        url: baseUrl + "ConsultoraOnline/RechazarPedido",
//        dataType: 'json',
//        contentType: 'application/json',
//        data: JSON.stringify(obj),
//        success: function (data) {
//            closeWaitingDialog();
//            if (checkTimeout(data)) {
//                if (data.success == true) {
//                    $('#btnRechazarPedido').prop('disabled', false);
//                    $('#dialog_motivoRechazo').hide();
//                    $('#dialog_mensajeRechazado').show();
//                    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Rechazado', opcionRechazo);
//                }
//                else {
//                    alert_msg(data.message);
//                }
//            }
//        },
//        error: function (data, error) {
//            closeWaitingDialog();
//            if (checkTimeout(data)) {
//                alert_msg("Ocurrió un error inesperado al momento de desafiliarte. Consulte con su administrador del sistema para obtener mayor información");
//            }
//        }
//    });


//};

//function CerrarMensajeRechazado() {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Rechazado - Click Botón', 'Ok');
//    $('#dialog_mensajeRechazado').hide();
//    $('#popup_pendientes').hide();
//    $('#popup2_pendientes').hide();
//    CargarPedidosPend();
//}

//function SelectOptAtender(event) {
//    var id = event.id;
//    var value = $(event).val();
//    var descripcion = event.options[event.selectedIndex].text;
//    var divpadre = $(event).parent().parent();
//    var pedidoDetalleId = $(divpadre).find(":nth-child(1)").val();

//    for (var i = 0; i < lstDetallePedidoPoput[0].ListaDetalle.length; i++) {
//        if (lstDetallePedidoPoput[0].ListaDetalle[i].PedidoDetalleId == pedidoDetalleId)
//            lstDetallePedidoPoput[0].ListaDetalle[i].OptAtender = id + '|' + value + '|' + descripcion;
//    }
//}

//function AceptarPedido(pedidoId, tipo) {

//    var popup = (tipo == 1) ? $('#divPopupPedidoPend') : $('#divPopup2PedidoPend');
//    var container = (tipo == 1) ? $('#divDetPedidoPend') : $('#divDet2PedidoPend');

//    if (typeof popup !== 'undefined' && typeof container !== 'undefined') {
//        var detalle = [];
//        var isOk = true;
//        var ing = 0;
//        var opciones = "";

//        var nodes = $(container).find('> div');
//        $(nodes).each(function () {
//            var id = $(this).find(":nth-child(1)").val();
//            var opt = $(this).find(":nth-child(7) select").val();
//            var cant = $(this).find("#pedpend-deta2-cantidad").text();
//            var cuv = $(this).find("#pedpend-deta2-cuv").text();
//            var nombre = $(this).find("#pedpend-deta2-nombre").text();
//            var precio = $(this).find("#pedpend-deta2-precio").val();
//            var marca = $(this).find("#pedpend-deta2-marca").val();
//            var opcion = $(this).find(":nth-child(7) select option[value='" + opt + "']").text();
//            var k = 0;

//            opciones = (opciones.length) ? (opciones + ", ") : opciones;
//            opciones = opciones + opcion;

//            if (typeof opt !== 'undefined') {
//                if (opt == "") {
//                    $('#dialog_mensajeComoAtender').show();
//                    isOk = false;
//                    return false;
//                }
//                else {
//                    k = opt;
//                    if (opt == 'ingrped') {
//                        ing += parseInt(cant);
//                    }
//                }
//            }

//            if (typeof id !== 'undefined' && id !== "") {
//                var d = {
//                    PedidoDetalleId: id,
//                    OpcionAcepta: k,
//                    Accion: 1,
//                    Nombre: nombre,
//                    Precio: precio,
//                    Marca: marca,
//                    CUV: cuv,
//                    Categoria: 'No disponible',
//                    Variante: 'Estándar',
//                    Cantidad: cant,
//                    OpcionCod: opt,
//                    OpcionString: opcion
//                }
//                detalle.push(d);
//            }

//        });
//        DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - PopUp Pedidos Pendientes', 'Click Botón', 'Acepto Todo el Pedido - ' + opciones);

//        if (isOk && detalle.length > 0) {
//            var key = (tipo == 1) ? '#sc-d1' : '#sc-d2';
//            var name = $(popup).find(key + '-nombre').text();
//            var email = $(popup).find(key + '-correo').text();
//            var telefono = $(popup).find(key + '-telefono').text();

//            var cliente = {
//                ConsultoraId: 0,
//                NombreCliente: name,
//                Nombre: name,
//                Celular: telefono,
//                eMail: email
//            };

//            $.ajax({
//                type: 'POST',
//                url: '/ConsultoraOnline/GetExisteClienteConsultora',
//                dataType: 'json',
//                contentType: 'application/json; charset=utf-8',
//                data: JSON.stringify(cliente),
//                async: true,
//                success: function (response) {
//                    if (response.success) {
//                        var pedido = {
//                            PedidoId: pedidoId,
//                            ClienteId: 0,
//                            ListaDetalleModel: detalle,
//                            Accion: 1,
//                            Tipo: tipo,
//                            Ingresos: ing,
//                            Dispositivo: 1
//                        }

//                        if (response.codigo == 0) {
//                            $('#popup_pendientes').hide();
//                            _pedido = pedido;

//                            showClienteDetalle(cliente, AceptarPedidoRegistraClienteOK, AceptarPedidoRegistraClienteCancel);
//                        }
//                        else {
//                            pedido.ClienteId = response.codigo;
//                            ProcesarAceptarPedido(pedido);
//                        }
//                    }
//                },
//                error: function (response) { }
//            });
//        }
//    }
//}

//function AceptarPedidoRegistraClienteOK(obj) {

//    if (obj != null && _pedido !== null) {
//        _pedido.ClienteId = obj.ClienteID;
//        ProcesarAceptarPedido(_pedido);
//        _pedido = null;
//    }
//}

//function AceptarPedidoRegistraClienteCancel(obj) {
//}

//function ProcesarAceptarPedido(pedido) {
//    waitingDialog({});
//    $.ajax({
//        type: 'POST',
//        url: '/ConsultoraOnline/AceptarPedido',
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(pedido),
//        async: true,
//        success: function (response) {
//            closeWaitingDialog();
//            if (checkTimeout(response)) {
//                if (response.success) {
//                    if (pedido.Tipo == 1) {
//                        $('#popup_pendientes').hide();
//                        $('#msgPedidoAceptado1').text('Se han agregado ' + pedido.Ingresos.toString() + ' productos a tu pedido')
//                        $('#dialog_aceptasPendientes').show();
//                    }
//                    else {
//                        $('#popup2_pendientes').hide();
//                        $('#dialog2_aceptasPendientes').show();
//                    }

//                    var opciones = "";
//                    $.each(pedido.ListaDetalleModel, function (i, item) {
//                        opciones = (opciones.length) ? (opciones + ", ") : opciones;
//                        opciones += item.OpcionString;
//                    });
//                    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Pedido Aceptado', opciones);

//                    var PedidosIngresarAMiPedido = $.grep(pedido.ListaDetalleModel, function (n, i) {
//                        return n.OpcionCod === 'ingrped';
//                    });


//                    if (PedidosIngresarAMiPedido.length) {
//                        var productos = [];

//                        $.each(PedidosIngresarAMiPedido, function (i, item) {
//                            var producto = {}
//                            producto["name"] = item.Nombre;
//                            producto["price"] = item.Precio;
//                            producto["brand"] = item.Marca;
//                            producto["id"] = item.CUV;
//                            producto["category"] = item.Categoria;
//                            producto["variant"] = item.Variante;
//                            producto["quantity"] = item.Cantidad;

//                            productos.push(producto);
//                        });

//                        dataLayer.push({
//                            'event': 'addToCart',
//                            'ecommerce': {
//                                'currencyCode': AnalyticsPortalModule.GetCurrencyCode(),
//                                'add': {
//                                    'actionField': { 'list': 'Pedidos Pendientes - Pedidos Aceptados' },
//                                    'products': productos
//                                }
//                            }
//                        });

//                    }

//                }
//                else {
//                    alert_msg(response.message);


//                }
//            }
//        },
//        error: function (data, error) {
//            closeWaitingDialog();
//            if (checkTimeout(data)) {
//                alert_msg("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
//            }
//        }
//    });
//}

//function CerrarMensajeAceptado(tipo) {
//    if (tipo == 1) {
//        $('#dialog_aceptasPendientes').hide();
//        $('#popup_pendientes').hide();
//    } else {
//        $('#dialog2_aceptasPendientes').hide();
//        $('#popup2_pendientes').hide();
//    }

//    CargarDetallePedido();
//    CargarPedidosPend();
//}

//function MostrarMisPedidosConsultoraOnline() {
//    var frmConsultoraOnline = $('#frmConsultoraOnline');
//    frmConsultoraOnline.attr("action", urlMisPedidosClienteOnline);
//    frmConsultoraOnline.submit();
//}

//function HorarioRestringido(mostrarAlerta) {
//    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
//    var horarioRestringido = false;
//    $.ajaxSetup({
//        cache: false
//    });
//    jQuery.ajax({
//        type: 'GET',
//        url: baseUrl + 'Pedido/EnHorarioRestringido',
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        async: false,
//        success: function (data) {
//            if (checkTimeout(data)) {

//                if (data.success == true) {
//                    if (mostrarAlerta == true) {
//                        closeWaitingDialog();
//                        alert_msg(data.message);
//                    }
//                    horarioRestringido = true;
//                }
//            }
//        },
//        error: function (data, error) {
//            if (checkTimeout(data)) {
//                closeWaitingDialog();
//                alert_msg(data.message);
//            }
//        }
//    });
//    return horarioRestringido;
//}

//function CerrarAlertaPedidoReservado() {
//    $('#dialog_alertaPedidoReservado').hide();
//    document.location.href = urlPedido;
//}

//function PendientesCampana() {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Out Tab Pedidos Pendientes', 'Click Botón', 'Campana');
//}

//function PendientesRevisalo(categoria, accion) {
//    DataLayerPedidosPendientes('virtualEvent', categoria, accion, 'Revísalo');
//}

//function PendientesRegresar() {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - PopUp Pedidos Pendientes', 'Click Botón', 'Regresar');
//}

//function RechazoPedidosPendientes() {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - PopUp Pedidos Pendientes', 'Click Botón', 'Rechazo el Pedido');
//}

//function DialogComoAtenderPedidoPend(etiqueta) {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up Alerta: No escogió tipo de Atención', etiqueta);
//}

//function NoRechazoPedidoDejameVerlo(etiqueta) {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¿Vas a Rechazar el Pedido? - Click Botón', etiqueta);
//}

//function PorqueLoRechazasteCerrar() {
//    DataLayerPedidosPendientes('virtualEvent', 'Carrito de Compras - Pedidos Pendientes', 'Pop up ¡Cuéntanos porqué lo Rechazaste! - Click Botón', 'cerrar');
//}