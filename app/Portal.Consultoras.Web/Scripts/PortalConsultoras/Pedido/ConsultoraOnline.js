
var flagHuboPedidosPend = false;
var _pedido = null;

$(document).ready(function () {

    $('#pedmostreo').addClass('bordespacive');
    $('.fondo_lateral').removeClass("fondo_lateral");
    $('#penmostreo').addClass('tab_pendiente_es');

    $('#pedmostreo').on('click', function () {
        $('.content_T_T').removeClass("fondo_lateral");
        $(".fondo_pendiente").fadeOut();
        $(".bloque_left").fadeOut();
        $('#pedmostreo').addClass('bordespacive');
        $('#penmostreo').removeClass('bordespacive');
        $('#penmostreo').addClass('tab_pendiente_es');
        $('#infoPedido').show();
        $('#infoPendientes').hide();
        $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').show();
        $('ul.paginador_notificaciones').show();
        $('.caja_guardar_pedido').show();
        $('.contenedor_eliminacion_pedido').show();
        $('.contenedor_banners').show();
        $('.info_tiempo_oportunidad.inicial').show();
        $('.caja_carousel_productos::after').removeClass('aparece_bloqueo');
        $('#pedmostreo').removeClass('cambio_bk_pendientes');
        $('.datos_para_movil').show();

        $('#penmostreo').attr("data-tab-activo", '0');
        $('#pedmostreo').attr("data-tab-activo", '1');
    });

    $('#penmostreo').on('click', function () {
        $('.content_T_T').addClass("fondo_lateral");
        $(".fondo_pendiente").fadeIn();
        $(".bloque_left").fadeIn();
        $('#pedmostreo').removeClass('bordespacive');
        $('#penmostreo').addClass('bordespacive');
        $('#penmostreo').removeClass('tab_pendiente_es');
        $('#infoPedido').hide();
        $('#infoPendientes').show();
        $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').hide();
        $('ul.paginador_notificaciones').hide();
        $('.caja_guardar_pedido').hide();
        $('.contenedor_eliminacion_pedido').hide();
        $('.contenedor_banners').hide();
        $('.info_tiempo_oportunidad.inicial').hide();
        $('#pedmostreo').addClass('cambio_bk_pendientes');
        $('.datos_para_movil').hide();
        $('#penmostreo').attr("data-tab-activo", '1');
        $('#pedmostreo').attr("data-tab-activo", '0');
    });

    $('.optionsRechazo').on('click', function () {
        $('.optionsRechazo').removeClass('optionsRechazoSelect');
        $(this).addClass('optionsRechazoSelect');
        if ($(this).data('id') == 11) {
            $('#txtOtrosRechazo').prop('readonly', false);
        }
        else {
            $('#txtOtrosRechazo').prop('readonly', true);
        }
    });

    $('.regresaPendientes').on('click', function () {
        $('#popup_pendientes').hide();
    });

    $('.btn_revisalo_pendientes2').on('click', function () {
        $('.popupPendientesPORTAL').show();
    });

    $('.cerrarPendientesPORTAL').on('click', function () {
        $('.popupPendientesPORTAL').hide();
    });

    CargarPedidosPend();
});

function CargarPedidosPend(page, rows) {

    $('#divPedidosPend').html('<div style="text-align: center;">Cargando Pedidos Pendientes<br><img src="' + urlLoad + '" /></div>');

    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 10,
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'ConsultoraOnline/CargarMisPedidos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    var data = response.data;
                    if (data.RegistrosTotal > 0) {

                        $('#cont1PedidosPend').text(data.RegistrosTotal);
                        $('#cont2PedidosPend').text(data.RegistrosTotal);
                        $('#fecPedidoPendRec').text(data.FechaPedidoReciente);

                        var html = SetHandlebars("#pedidopend-template", data.ListaPedidos);
                        $('#divPedidosPend').html(html);

                        flagHuboPedidosPend = true;

                        $('#penmostreo').show();

                        if (lanzarTabConsultoraOnline == '1') {
                            $('.content_T_T').addClass("fondo_lateral");
                            $(".fondo_pendiente").fadeIn();
                            $(".bloque_left").fadeIn();
                            $('#pedmostreo').removeClass('bordespacive');
                            $('#penmostreo').addClass('bordespacive');
                            $('#penmostreo').removeClass('tab_pendiente_es');
                            $('#infoPedido').hide();
                            $('#infoPendientes').show();
                            $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').hide();
                            $('ul.paginador_notificaciones').hide();
                            $('.caja_guardar_pedido').hide();
                            $('.contenedor_eliminacion_pedido').hide();
                            $('.contenedor_banners').hide();
                            $('.info_tiempo_oportunidad.inicial').hide();
                            $('#pedmostreo').addClass('cambio_bk_pendientes');
                            $('.datos_para_movil').hide();

                            $('#penmostreo').attr("data-tab-activo", '1');
                            $('#pedmostreo').attr("data-tab-activo", '0');
                        }
                    }
                    else {

                        $('#divPedidosPend').empty();

                        if (flagHuboPedidosPend) {
                            $('#penmostreo').hide();
                            $('.content_T_T').removeClass("fondo_lateral");
                            $(".fondo_pendiente").fadeOut();
                            $(".bloque_left").fadeOut();
                            $('#infoPedido').show();
                            $('#infoPendientes').hide();
                            $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').show();
                            $('ul.paginador_notificaciones').show();
                            $('.caja_guardar_pedido').show();
                            $('.contenedor_eliminacion_pedido').show();
                            $('.contenedor_banners').show();
                            $('.info_tiempo_oportunidad.inicial').show();
                            $('.caja_carousel_productos::after').removeClass('aparece_bloqueo');
                            $('#pedmostreo').removeClass('cambio_bk_pendientes');
                            $('.datos_para_movil').show();

                            $('#pedmostreo').val('MIS <b>PRODUCTOS</b>');

                            $('#penmostreo').attr("data-tab-activo", '0');
                            $('#pedmostreo').attr("data-tab-activo", '1');

                            CargarDetallePedido();
                        }
                    }
                }
                else {
                    $('#divPedidosPend').empty();
                    alert_msg("No se pudieron obtener los datos");
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert_msg("Ocurrió un error inesperado al buscar los pedidos. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
}

function CargarPopupPedidoPend(pedidoId) {

    var obj = {
        sidx: "",
        sord: "",
        page: 1,
        rows: 10,
        pedidoId: pedidoId
    };

    waitingDialog({});

    $.ajax({
        type: 'POST',
        url: baseUrl + 'ConsultoraOnline/CargarMisPedidosDetalle',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            closeWaitingDialog();
            if (checkTimeout(response)) {
                if (response.success) {
                    var data = response.data;
                    if (data.RegistrosTotal > 0) {

                        var row = $('#pedidopend_' + pedidoId).val();
                        var arr = row.split('|');
                        var t = 1;
                        if (arr[1] > 0) {
                            t = 2;
                        }

                        var pnombre = '';
                        if (arr[3].indexOf(' ') > 0) {
                            pnombre = arr[3].substring(0, arr[3].indexOf(' '));
                        } else {
                            pnombre = arr[3];
                        }

                        var d1 = {
                            PedidoId: pedidoId,
                            Contacto: pnombre,
                            Nombre: arr[3],
                            Telefono: arr[4],
                            Direccion: arr[5],
                            Email: arr[6],
                            Comentario: arr[7],
                            PrecioTotal: arr[13],
                            SaldoHoras: arr[14],
                            FlagConsultora: (arr[15] == 'true') ? 1 : 0,
                        }
                        if (t == 1) {
                            var html = SetHandlebars("#popup-pedidopend-template", d1);
                            $('#divPopupPedidoPend').html(html);

                            var html2 = SetHandlebars("#detalle-pedidopend-template", data.ListaDetalle);
                            $('#divDetPedidoPend').html(html2);

                            $('#popup_pendientes').show();
                        }
                        else {
                            var html = SetHandlebars("#popup2-pedidopend-template", d1);
                            $('#divPopup2PedidoPend').html(html);
                            $(".cubre2").css({ 'height': '245px' });

                            var html2 = SetHandlebars("#detalle2-pedidopend-template", data.ListaDetalle);
                            $('#divDet2PedidoPend').html(html2);

                            $('#popup2_pendientes').show();
                        }
                    }
                    else {
                        alert_msg("No se encontraron resultados");
                    }
                }
                else {
                    alert_msg("No se pudieron obtener los datos");
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert_msg("Ocurrió un error inesperado al buscar los detalles del pedido. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
}

function ShowPopupRechazoPedido(pedidoId, tipo) {
    $('#dialog_confirmacionRechazo').show();
    $('#hdePedidoIdRechazo').val(pedidoId);
}

function ShowPopupMotivoRechazo() {
    var id = $('#hdePedidoIdRechazo').val();
    var row = $('#pedidopend_' + id).val();
    var arr = row.split('|');

    $('#SolicitudId').val(arr[0]);
    $('#MarcaID').val(arr[1]);
    $('#Campania').val(arr[2]);
    $('#NumIteracion').val(arr[9]);
    $('#CodigoUbigeo').val(arr[10]);

    $('#dialog_confirmacionRechazo').hide();
    $('#dialog_motivoRechazo').show();
}

function RechazarPedido() {
    $('#btnRechazarPedido').prop('disabled', true);

    var opt = $('.optionsRechazoSelect').data('id');
    if (typeof opt == 'undefined') {
        opt = 11;
    }

    var obj = {
        SolicitudId: $("#SolicitudId").val(),
        NumIteracion: $("#NumIteracion").val(),
        CodigoUbigeo: $("#CodigoUbigeo").val(),
        Campania: $("#Campania").val(),
        MarcaId: $("#MarcaID").val(),
        OpcionRechazo: opt,
        RazonMotivoRechazo: $("#txtOtrosRechazo").val(),
        typeAction: '1'
    };

    waitingDialog({});

    $.ajax({
        type: "POST",
        url: baseUrl + "ConsultoraOnline/RechazarPedido",
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(obj),
        success: function (data) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $('#btnRechazarPedido').prop('disabled', false);
                    $('#dialog_motivoRechazo').hide();
                    $('#dialog_mensajeRechazado').show();
                }
                else {
                    alert_msg(data.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert_msg("Ocurrió un error inesperado al momento de desafiliarte. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
};

function CerrarMensajeRechazado() {
    $('#dialog_mensajeRechazado').hide();
    $('#popup_pendientes').hide();
    $('#popup2_pendientes').hide();
    CargarPedidosPend();
}

function AceptarPedido(pedidoId, tipo) {
    var popup = (tipo == 1) ? $('#divPopupPedidoPend') : $('#divPopup2PedidoPend');
    var container = (tipo == 1) ? $('#divDetPedidoPend') : $('#divDet2PedidoPend');

    if (typeof popup !== 'undefined' && typeof container !== 'undefined') {
        var detalle = [];
        var isOk = true;
        var ing = 0;

        var nodes = $(container).find('> div');
        $(nodes).each(function () {
            var id = $(this).find(":nth-child(1)").val();
            var opt = $(this).find(":nth-child(7) select").val();
            var cant = $(this).find("#pedpend-deta2-cantidad").text();
            var k = 0;

            if (typeof opt !== 'undefined') {
                if (opt == "") {
                    $('#dialog_mensajeComoAtender').show();
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
                    Accion: 1
                }
                detalle.push(d);
            }
        });

        if (isOk && detalle.length > 0) {
            var key = (tipo == 1) ? '#sc-d1' : '#sc-d2';
            var name = $(popup).find(key + '-nombre').text();
            var email = $(popup).find(key + '-correo').text();

            var cliente = {
                ConsultoraId: 0,
                NombreCliente: name,
                Nombre: name,
                eMail: email
            };

            $.ajax({
                type: 'POST',
                url: '/ConsultoraOnline/GetExisteClienteConsultora',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(cliente),
                async: true,
                success: function (response) {
                    if (response.success) {
                        var pedido = {
                            PedidoId: pedidoId,
                            ClienteId: 0,
                            ListaDetalleModel: detalle,
                            Accion: 1,
                            Tipo: tipo,
                            Ingresos: ing,
                            Dispositivo: 1
                        }

                        if (response.codigo == 0) {
                            $('#popup_pendientes').hide();
                            _pedido = pedido;

                            showClienteDetalle(cliente, AceptarPedidoRegistraClienteOK, AceptarPedidoRegistraClienteCancel);
                        }
                        else {
                            pedido.ClienteId = response.codigo;
                            ProcesarAceptarPedido(pedido);
                        }
                    }
                },
                error: function (response) { }
            });
        }
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

    waitingDialog({});
    $.ajax({
        type: 'POST',
        url: '/ConsultoraOnline/AceptarPedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(pedido),
        async: true,
        success: function (response) {
            closeWaitingDialog();
            if (checkTimeout(response)) {
                if (response.success) {
                    if (pedido.Tipo == 1) {
                        $('#popup_pendientes').hide();
                        $('#msgPedidoAceptado1').text('Se han agregado ' + pedido.Ingresos.toString() + ' productos a tu pedido')
                        $('#dialog_aceptasPendientes').show();
                    }
                    else {
                        $('#popup2_pendientes').hide();
                        $('#dialog2_aceptasPendientes').show();
                    }
                }
                else {
                    alert_msg(response.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert_msg("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
}

function CerrarMensajeAceptado(tipo) {
    if (tipo == 1) {
        $('#dialog_aceptasPendientes').hide();
        $('#popup_pendientes').hide();
    } else {
        $('#dialog2_aceptasPendientes').hide();
        $('#popup2_pendientes').hide();
    }

    CargarDetallePedido();
    CargarPedidosPend();
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
                        closeWaitingDialog();
                        alert_msg(data.message);
                    }
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert_msg(data.message);
            }
        }
    });
    return horarioRestringido;
}

function CerrarAlertaPedidoReservado() {
    $('#dialog_alertaPedidoReservado').hide();
    document.location.href = urlPedido;
}