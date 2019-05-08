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
            ObtenerDetalleReemplazo(data);
            if (item.Estado == 4) {
                if (data.cantobservado > 0) SetHandlebars("#template-detalle-2-observado", data, "#divDetallePedidoCdrObservado");
                if (data.cantaprobado > 0) SetHandlebars("#template-detalle-2-aprobado", data, "#divDetallePedidoCdrAprobado");
            }
            else SetHandlebars("#template-detalle-1", data, "#divDetallePedidoCDR");
        },
        complete: closeWaitingDialog
    });
}


function ObtenerDetalleReemplazo(data) {
    try {
        if (data.detalle.length > 0) {
            $.each(data.detalle, function (index, v) {
                if (v.XMLReemplazo.length > 0) {

                    var xml;
                    if (window.DOMParser) {
                        parser = new DOMParser();
                        xml = parser.parseFromString(v.XMLReemplazo, "text/xml");
                    }
                    else //IE
                    {
                        xml = new ActiveXObject("Microsoft.XMLDOM");
                        xml.async = false;
                        xml.loadXML(v.XMLReemplazo);
                    }
                    var arrReemplazo = [];
                    var rows = xml.getElementsByTagName("reemplazo");
                    var total = 0;
                    for (var i = 0; i < rows.length; i++) {
                        var precio = rows[i].getElementsByTagName("precio")[0].textContent;

                        var obj = {
                            CUV: rows[i].getElementsByTagName("cuv")[0].textContent,
                            Cantidad: rows[i].getElementsByTagName("cantidad")[0].textContent,
                            Descripcion: rows[i].getElementsByTagName("descripcion")[0].textContent,
                            Precio: precio,
                            Simbolo: rows[i].getElementsByTagName("simbolo")[0].textContent,
                            Estado: rows[i].getElementsByTagName("estado")[0].textContent
                        };
                        total = total + parseFloat(precio);

                        arrReemplazo.push(obj);
                    }
                    data.detalle[index].DetalleReemplazo = arrReemplazo;
                    data.detalle[index].Total = total;

                }
                else {
                    data.detalle[index].DetalleReemplazo = [];
                    data.detalle[index].Total = 0;
                }
            });
        }
    } catch (e) {
        console.log(e.message);
    }

}


//function DetalleAccion(obj) {
//    var accion = $.trim($(obj).attr("data-accion"));
//    if (accion == "") {
//        return false;
//    }

//    if (accion == "x") {
//        var pedidodetalleid = $.trim($(obj).attr("data-pedidodetalleid"));

//        var item = {
//            CDRWebDetalleID: pedidodetalleid
//        };

//        var functionEliminar = function () {
//            var eliminado = DetalleEliminar(item);

//            if (eliminado) {
//                var parent = $(obj).parents(".content_listado_reclamo").eq(0);
//                $(parent).remove();
//            }
//        };
//        messageConfirmacion("", "Se eliminará el registro seleccionado. <br/>¿Deseas continuar?", functionEliminar);
//    }
//}

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