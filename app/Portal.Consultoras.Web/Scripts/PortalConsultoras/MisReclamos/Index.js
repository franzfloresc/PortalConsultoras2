$(document).ready(function () {
    $(".verDetalle").on("click", function () {
        var elemento = $(this);

        var parent = $(elemento).parents(".content_listado_reclamo");

        var id = $(parent).find(".cdrweb_id").val();


        var pedidoId = $(parent).find(".cdrweb_pedidoid").val();
        var estado = $(parent).find(".cdrweb_estado").val();
        var formatoFechaCulminado = $(parent).find(".cdrweb_formatoFechaCulminado").val();
        var formatoCampania = $(parent).find(".cdrweb_formatocampania").val();
        var resumenResolucion = $(parent).find(".cdrweb_resumenresolucion").val();
        var consultoraSaldo = $(parent).find(".cdrweb_consultorasaldo").val();
        var mensajeDespacho = IfNull($(parent).find(".cdrweb_mensajedespacho").val(), '');

        console.log(estado);

        $("#hdPedidoIdActual").val(pedidoId);
        $("#hdCDRWebID").val(id);
        var item = {
            CDRWebID: id || 0,
            PedidoID: pedidoId || 0,
            Estado: estado || 0
        };

        switch (estado) {
            case "1": //Pendiente
                window.location.href = urlReclamo + "?p=" + pedidoId + "&c=" + id;
                break;
            case "2": //Enviado
                ObtenerDetalleCdr(item);

                $("#spnFechaCulminado").html(formatoFechaCulminado);
                $("#spnNumeroSolicitud").html(id);
                $("#spnFormatoCampania").html(formatoCampania);
                $("#spnResumenResolucion").html(resumenResolucion);

                if (mensajeDespacho == '') $('#divMensajeDespacho').hide();
                else $('#divMensajeDespacho').html(mensajeDespacho).show();

                $('#divConsultoraSaldo').hide();

                $("#PopSolicitud").show();
                break;
            case "3": //Aceptado
                ObtenerDetalleCdr(item);

                $("#spnFechaCulminado").html(formatoFechaCulminado);
                $("#spnNumeroSolicitud").html(id);
                $("#spnFormatoCampania").html(formatoCampania);
                $("#spnResumenResolucion").html(resumenResolucion);

                if (mensajeDespacho == '') $('#divMensajeDespacho').hide();
                else $('#divMensajeDespacho').html(mensajeDespacho).show();

                $('#spnConsultoraSaldo').html(consultoraSaldo);
                $('#divConsultoraSaldo').show();

                $("#PopSolicitud").show();
                break;
            case "4": //Observado
                ObtenerDetalleCdr(item);

                $("#spnFechaCulminado2").html(formatoFechaCulminado);
                $("#spnNumeroSolicitud2").html(id);
                $("#spnFormatoCampania2").html(formatoCampania);
                $("#spnResumenResolucion2").html(resumenResolucion);
                $('#spnConsultoraSaldo2').html(consultoraSaldo);

                if (mensajeDespacho == '') $('#divMensajeDespacho2').hide();
                else $('#divMensajeDespacho2').html(mensajeDespacho).show();

                $("#PopSolicitud2").show();
                break;
            default:
                break;
        }
    });

    //$(document).on('click', '[data-accion]', function () {
    //    DetalleAccion(this);
    //});

    $("#btnFinalizar").on("click", function () {
        var pedidoId = $("#hdPedidoIdActual").val();
        var id = $("#hdCDRWebID").val();
        var lista = new Array();

        $.each($("#divDetallePedidoCdrObservado .txtCantidad"), function (index, value) {
            var elemento = $(value);
            var parent = $(elemento).parents(".content_listado_reclamo").eq(0);
            var pedidoDetalleId = $(parent).attr("data-pedidodetalleid");
            var cantidad = $(elemento).val();

            var item = {
                CDRWebDetalleID: pedidoDetalleId,
                Cantidad: cantidad
            };
            lista.push(item);
        });

        var actualizado = ActualizarDetalleObservado(lista);
        if (actualizado) window.location.href = urlReclamo + "?p=" + pedidoId + "&c=" + id;
    });

    $("#IrPaso1").on("click", function () {
        if (mensajeGestionCdrInhabilitada != '') {
            alert_msg(mensajeGestionCdrInhabilitada);
            return false;
        }
        window.location.href = urlReclamo;
    });
});

function ObtenerDetalleCdr(item) {
    $("#divDetallePedidoCdrObservado").html("");
    $("#divDetallePedidoCdrAprobado").html("");
    $("#divDetallePedidoCDR").html("");

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleCargar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }
            if (item.Estado == 4) {
                if (data.cantobservado > 0) SetHandlebars("#template-detalle-2-observado", data, "#divDetallePedidoCdrObservado");
                if (data.cantaprobado > 0) SetHandlebars("#template-detalle-2-aprobado", data, "#divDetallePedidoCdrAprobado");
            }
            else SetHandlebars("#template-detalle-1", data, "#divDetallePedidoCDR");
        },
        complete: closeWaitingDialog
    });
}

function DetalleEliminar(objItem) {
    var item = {
        CDRWebDetalleID: objItem.CDRWebDetalleID
    };

    var resultado = false;

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleEliminar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == true) {
                resultado = true;
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

    return resultado;
}

function ActualizarDetalleObservado(lista) {
    var resultado = false;

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleActualizarObservado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(lista),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == true) {
                resultado = true;
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

    return resultado;
};