﻿
var flagHuboPedidosPend = false;

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
        //$('.truco_bloqueo').hide();
        $('.caja_carousel_productos::after').removeClass('aparece_bloqueo');
        $('#pedmostreo').removeClass('cambio_bk_pendientes');
        $('.datos_para_movil').show();

        //var idPedido = $("#pedmostreo").attr("data-pedido");
        //if(idPedido == "1"){
        //    $('.content_T_T').removeClass("fondo_lateral");

        //}else{
        //    $('.content_T_T').addClass("fondo_lateral");
        //}

        //if (flagHuboPedidosPend) {
        //    CargarDetallePedido();
        //}
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
        //TRUCOS BLOQUES
        //$('.truco_bloqueo').hide();
        $('#pedmostreo').addClass('cambio_bk_pendientes');
        $('.datos_para_movil').hide();
    });

    $('.optionsRechazo').on('click', function () {
        $('.optionsRechazo').removeClass('optionsRechazoSelect');
        $(this).addClass('optionsRechazoSelect');
    });

    //APP CATALOGO
    //$('a.RevisionPendientes').on('click', function () {
    //    $('#popup_pendientes').show();
    //});

    //$('.btn_revisalo_pendientes1').on('click', function () {
    //    $('#popup_pendientes').show();
    //});

    $('.regresaPendientes').on('click', function () {
        $('#popup_pendientes').hide();
    });

    //$('button.sedetiene').on('click', function () {
    //    $('#dialog_confirmacionRechazo').hide();
    //});

    //$('#rechazarPendientes').on('click', function () {
    //    $('#dialog_confirmacionRechazo').show();
    //});

    //$('#cierreRechazoPendientes').on('click', function () {
    //    $('#dialog_confirmacionRechazo').hide();
    //});

    //$('button.btn_eliminarCliente.venderecha.prosigue').on('click', function () {
    //    $('#dialog_confirmacionRechazo').hide();
    //    $('#dialog_motivoRechazo').show();
    //});

    //$('#cierreMotivoRechazo').on('click', function () {
    //    $('#dialog_motivoRechazo').hide();
    //    $('#popup_pendientes').hide();
    //    $('.popupPendientesPORTAL').hide();
    //});

    //$('button.btn_eliminarCliente.btn-negro').on('click', function () {
    //    $('#dialog_motivoRechazo').hide();
    //    $('#popup_pendientes').hide();
    //    $('.popupPendientesPORTAL').hide();
    //});

    //$('#aceptarPendientes').on('click', function () {
    //    $('#popup_pendientes').hide();
    //    //$('#dialog_aceptasPendientes').show();
    //});

    //$('.ok_aceptaPedido').on('click', function () {
    //    $('#dialog_aceptasPendientes').hide();
    //    $('.popupPendientesPORTAL').hide();
    //});

    //$('#aceptandoPendientes').on('click', function () {
    //    //$('#dialog_aceptasPendientes').hide();
    //    $('.popupPendientesPORTAL').hide();
    //});

    //PORTAL LBEL
    $('.btn_revisalo_pendientes2').on('click', function () {
        $('.popupPendientesPORTAL').show();
    });

    $('.cerrarPendientesPORTAL').on('click', function () {
        $('.popupPendientesPORTAL').hide();
    });

    $('#rechazarPendientesPORTAL').on('click', function () {
        $('#dialog_confirmacionRechazo').show();
    });

    $('#aceptarPendientesPORTAL').on('click', function () {
        $('#dialog_aceptasPendientes').show();
    });

    $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').hide();

    CargarPedidosPend();
});

function CargarPedidosPend(page, rows) {

    //if ($('ul.paginador_notificaciones').is(':visible')) {
        $('ul.paginador_notificaciones').hide();
    //}

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

            if (response.success) {
                var data = response.data;

                if (data.RegistrosTotal > 0) {

                    $('#cont1PedidosPend').text(data.RegistrosTotal);
                    $('#cont2PedidosPend').text(data.RegistrosTotal);
                    $('#fecPedidoPendRec').text(data.FechaPedidoReciente);

                    //var html = ArmarListado(data.ListaPedidos);
                    var html = SetHandlebars("#pedidopend-template", data.ListaPedidos);
                    $('#divPedidosPend').html(html);

                    flagHuboPedidosPend = true;

                    //var htmlPaginador = ArmarListadoPaginador(data);
                    //$('#paginadorCab').html(htmlPaginador);
                    //$('#paginadorPie').html(htmlPaginador);

                    //$("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                    //$("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

                    $('#penmostreo').show();

                    if (lanzarTabConsultoraOnline == '1')
                    {
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
                        //TRUCOS BLOQUES
                        //$('.truco_bloqueo').hide();
                        $('#pedmostreo').addClass('cambio_bk_pendientes');
                        $('.datos_para_movil').hide();
                    }

                    //if ($('ul.paginador_notificaciones').is(':visible')) {
                        $('ul.paginador_notificaciones').hide();
                   //}
                }
                else {

                    $('#divPedidosPend').empty();

                    if (flagHuboPedidosPend) {
                        $('#penmostreo').hide();
                        $('.content_T_T').removeClass("fondo_lateral");
                        $(".fondo_pendiente").fadeOut();
                        $(".bloque_left").fadeOut();
                        //$('#pedmostreo').addClass('bordespacive');
                        //$('#penmostreo').removeClass('bordespacive');
                        //$('#penmostreo').addClass('tab_pendiente_es');
                        $('#infoPedido').show();
                        $('#infoPendientes').hide();
                        $('.paginador_pedidos.mostrarPaginadorPedidos.inferior').show();
                        $('ul.paginador_notificaciones').show();
                        $('.caja_guardar_pedido').show();
                        $('.contenedor_eliminacion_pedido').show();
                        $('.contenedor_banners').show();
                        $('.info_tiempo_oportunidad.inicial').show();
                        //$('.truco_bloqueo').hide();
                        $('.caja_carousel_productos::after').removeClass('aparece_bloqueo');
                        $('#pedmostreo').removeClass('cambio_bk_pendientes');
                        $('.datos_para_movil').show();

                        $('#pedmostreo').val('MIS <b>PRODUCTOS</b>');

                        CargarDetallePedido();
                    }
                }
            }
            else {
                $('#divPedidosPend').empty();
                alert_msg("No se pudieron obtener los datos");
            }
        },
        error: function (error) {
            //alert(error);
            alert_msg("Ocurrió un error inesperado al buscar los pedidos. Consulte con su administrador del sistema para obtener mayor información");
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

    AbrirSplash();

    $.ajax({
        type: 'POST',
        url: baseUrl + 'ConsultoraOnline/CargarMisPedidosDetalle',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {

            CerrarSplash();
            if (response.success) {
                var data = response.data;

                if (data.RegistrosTotal > 0) {

                    var row = $('#pedidopend_' + pedidoId).val();
                    var arr = row.split('|');
                    var t = 1;
                    //console.log(arr);

                    // 0=App de catalogos, >0=Portal Marca
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

                    //console.log(d1);

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
        },
        error: function (error) {
            //alert(error);
            closeWaitingDialog();
            alert_msg("Ocurrió un error inesperado al buscar los detalles del pedido. Consulte con su administrador del sistema para obtener mayor información");
        }
    });
}

function ShowPopupRechazoPedido(pedidoId, tipo) {
    $('#dialog_confirmacionRechazo').show();
    $('#hdePedidoIdRechazo').val(pedidoId);
}

function ShowPopupAceptoPedido(pedidoId, tipo) {
    $('#dialog_aceptasPendientes').show();
    $('#hdePedidoIdAcepto').val(pedidoId);
}

function ShowPopupMotivoRechazo() {
    var id = $('#hdePedidoIdRechazo').val();
    var row = $('#pedidopend_' + id).val();
    var arr = row.split('|');
    //console.log(arr);

    $('#SolicitudId').val(arr[0]);
    $('#MarcaID').val(arr[1]);
    $('#Campania').val(arr[2]);
    $('#NumIteracion').val(arr[9]);
    $('#CodigoUbigeo').val(arr[10]);

    $('#dialog_confirmacionRechazo').hide();
    $('#dialog_motivoRechazo').show();
}

function RechazarPedido() {

    $('#dialog_motivoRechazo').hide();
    $('#btnRechazarPedido').prop('disabled', true);

    //var opc = $('input[name=checkbox]:checked', '#frmRechazoPedido').val();
    //var objHtmlPanelPedidoRechazado = $("#DivPanelPedidoRechazado").val();
    var opt = $('.optionsRechazoSelect').data('id');
    if (typeof opt == 'undefined') {
        opt = 11;   // otros
    }

    var obj = {
        SolicitudId: $("#SolicitudId").val(),
        NumIteracion: $("#NumIteracion").val(),
        CodigoUbigeo: $("#CodigoUbigeo").val(),
        Campania: $("#Campania").val(),
        MarcaId: $("#MarcaID").val(),
        OpcionRechazo: opt,
        RazonMotivoRechazo: $("#txtOtrosRechazo").val()
    };

    //console.log(obj);
    AbrirSplash();

    $.ajax({
        type: "POST",
        url: baseUrl + "ConsultoraOnline/RechazarPedido",
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(obj),
        success: function (data) {

            if (checkTimeout(data)) {
                CerrarSplash();

                if (data.success == true) {
                    //$('#modal_rechazar_pedido').fuzemodal('close');
                    //$('#modal_rechazar_pedido').fuzemodal('close');
                    //var htmlRechazado = '<div class="text_gris_azul">RECHAZADO</div><p class="font_size_11">' + data.message + '</p>';
                    //$('#DivPanel' + objHtmlPanelPedidoRechazado).html(htmlRechazado);
                    //var imgRechazado = '<img class="margin_right_10 vertical_align_top" src="/Content/Images/ConsultoraOnline/ic_cerrar.png" width="19" height="19" alt="" />';
                    //$('#alertImage' + objHtmlPanelPedidoRechazado).html(imgRechazado);
                    //$('#telefonoDisplay' + objHtmlPanelPedidoRechazado).css('display', 'none');
                    //$('#datosDisplay' + objHtmlPanelPedidoRechazado).css('display', 'none');
                    //$('#MensajeConsultora' + objHtmlPanelPedidoRechazado).css('display', 'none');
                    //updateCantidadPedidos();

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
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert_msg("Ocurrió un error inesperado al momento de desafiliarte. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });

    //$('#modal_cancelar_pedido').fuzemodal('close');
    //$('#dialog_confirmacionRechazo').hide();
};

function CerrarMensajeRechazado() {
    $('#dialog_mensajeRechazado').hide();
    CargarPedidosPend();
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    closeWaitingDialog();
}

function AceptarPedido(pedidoId, tipo) {

    var isOk = true;
    var detalle = [];
    var divId = (tipo == 1) ? "divDetPedidoPend" : "divDet2PedidoPend";
    var totalIng = 0;

    $('div#' + divId + ' > div').each(function () {
        var val1 = $(this).find(":nth-child(1)").val();
        var val2 = $(this).find(":nth-child(7) select").val();
        var val3 = $(this).find("#pedpend-deta2-cantidad").text();
        var opt = 0;

        if (typeof val2 !== 'undefined') {
            if (val2 == "") {
                //alert_msg("Importante Seleccione como atenderá el producto");
                $('#dialog_mensajeComoAtender').show();
                isOk = false;
                return false;
            }
            else {
                opt = val2;
                if (val2 == 'ingrped') {
                    totalIng += parseInt(val3);
                }
            }
        }

        var d = {
            PedidoDetalleId: val1,
            OpcionAcepta: opt
        }

        detalle.push(d);
    });

    //console.log(detalle);

    if (isOk) {

        var pedido = {
            id: pedidoId,
            ListaDetalleModel: detalle,
        }

        AbrirSplash();

        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/AceptarPedido',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pedido),
            async: true,
            success: function (response) {

                CerrarSplash();
                if (response.success) {
                    //alert(response.message);

                    if (tipo == 1) {
                        $('#popup_pendientes').hide();
                        $('#msgPedidoAceptado1').text('Se han agregado ' + totalIng + ' productos a tu pedido')
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
            },
            error: function (error) {
                closeWaitingDialog();
                //alert(error);
                alert_msg("Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
            }
        });
    }
}

function CerrarMensajeAceptado(tipo) {
    if (tipo == 1) {
        $('#dialog_aceptasPendientes').hide();
    } else {
        $('#dialog2_aceptasPendientes').hide();
    }

    CargarDetallePedido();
    CargarPedidosPend();
}

function MostrarMisPedidosConsultoraOnline() {
    var frmConsultoraOnline = $('#frmConsultoraOnline');
    frmConsultoraOnline.attr("action", urlMisPedidosClienteOnline);
    frmConsultoraOnline.submit();
}