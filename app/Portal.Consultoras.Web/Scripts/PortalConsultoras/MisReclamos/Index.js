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
    $("#btnFinalizar").on("click", function () {
        var pedidoId = $("#hdPedidoIdActual").val();
        var id = $("#hdCDRWebID").val();
        var lista = [];
        var $tagsElements = $("#divDetallePedidoCdrDetalle .txtCantidad");
        $.each($tagsElements, function () {
            var $element = $(this);
            var $data = $element.data("itemValues");
            var tipo = $data.item_type;
            var Id = $data.pedido_detalle_id;
            var Cuv = $data.codigo_cuv;
            var Cantidad = $element.val();
            var Reemplazo = [];
            var objGrupal = {}
            if (tipo == "grupal") {
                objGrupal = {
                    cuv: Cuv,
                    cantidad: Cantidad
                }
                Reemplazo.push(objGrupal);
            }
            arr = $.grep(lista, function (val, i) {
                if (typeof (val.CDRWebDetalleID) !== "undefined") {
                    return (val.CDRWebDetalleID == Id);
                } else {
                    return [];
                }
            });
            if (arr.length == 0) {
                var det = tipo == "grupal" ? Reemplazo : [];
                var a = {
                    CDRWebDetalleID: Id,
                    Cantidad: tipo == "grupal" ? 0 : Cantidad,
                    Reemplazo : det
                };                
                lista.push(a);
            } else {
                var arr = $.grep(lista, function (value, index) {
                    return (value.CDRWebDetalleID == Id);
                });

                if (arr.length > 0) {
                    arr[0].Reemplazo.push(objGrupal);
                }
            }
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
    $("#divDetallePedidoCdrDetalle").html("");
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
            if (!data.success) {
                messageInfoError(data.message);
                return false;
            }
            CalcularMontoTotalTrueque(data);
            if (item.Estado == 3) {
                SetHandlebars("#template-detalle", data, "#divDetallePedidoCDR");
            }
            if (item.Estado == 4) {
                SetHandlebars("#template-detalle", data, "#divDetallePedidoCdrDetalle");
            } else {
                SetHandlebars("#template-detalle-1", data, "#divDetallePedidoCDR");
            }

        },
        complete: closeWaitingDialog
    });
}

function CalcularMontoTotalTrueque(data) {
    try {
        if (data.detalle.length === 0) {
            return false;
        }
        $.each(data.detalle, function (i, el) {
            var total = 0;
            if (el.DetalleReemplazo === null) {
                data.detalle[i].Total = 0;
                return;
            }

            $.each(el.DetalleReemplazo, function (j, det) {
                total = total + det.Precio * det.Cantidad;
            });
            data.detalle[i].Total = total;
        });
    } catch (e) {
        console.log(e.message);
    }
}

function EliminarDetalle(el) {

    var pedidodetalleid = $.trim($(el).attr("data-pedidodetalleid"));
    var grupoid = $.trim($(el).attr("data-detalle-grupoid"));
    var cuv = $.trim($(el).attr("data-cuv"));

    var item = {
        CDRWebDetalleID: pedidodetalleid,
        GrupoID: grupoid,
        CUV: cuv
    };

    var functionEliminar = function () {
        DetalleEliminar(item);
    };

    var msg = "";
    if (grupoid.length > 0) {
        msg = "Se eliminaran todos los registros relacionados al producto(Sets o Packs). ¿Deseas continuar?";
    } else {
        msg = "Se eliminará el registro seleccionado. ¿Deseas continuar ?";
    }
    messageConfirmacion("", msg, functionEliminar);
}

function DetalleEliminar(item) {
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

            if (data.success) {
                resultado = true;
                var item = {
                    CDRWebID: $("#hdCDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoIdActual").val() || 0,
                    Estado: 4
                };
                ObtenerDetalleCdr(item);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

    return resultado;
}

function ActualizarCantidad(event) {
    var $el = $(event.target).parent().parent().find(me.Constantes.INPUT_NAME_CANTIDAD);
    $el.attr("data-cantidad", $el.val());
    me.Funciones.CalcularTotal();
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

function AgregarODisminuirCantidad(event, opcion) {

    if (opcion === 1) {
        EstrategiaAgregarModule.AdicionarCantidad(event);
    }
    if (opcion === 2) {
        EstrategiaAgregarModule.DisminuirCantidad(event);
    }
    var $this = $(event.target);
    var $parent = $this.parents(".producto_solicitud_row")

    var $el_input = $parent.children(".acciones_solicitud").find("input[name=cantidad]");
    var $el_span = $parent.children(".producto_solicitud").find("span[name=cantidad]");
    $el_span.text($el_input.val());
    $el_input.attr("data-cantidad", $el_input.val());
    CalcularTotalPerItem($parent);
}

function ActualizarCantidad(event) {
    var $this = $(event.target);
    var $parent = $this.parents(".producto_solicitud_row");
    var $val = $this.val();
    var $el_span = $parent.children(".producto_solicitud").find("span[name=cantidad]");
    $el_span.text($val);
    $this.attr("data-cantidad", $val);
    CalcularTotalPerItem($parent);
}

function CalcularTotalPerItem($parent) {
    var $tagItem = $parent.parent(".pop_solicitud_solucion");
    var $elementsCantPrice = $tagItem.find(".producto_solicitud");
    var total = 0;
    $.each($elementsCantPrice, function () {
        var $this = $(this);
        var cant = $this.find("span[name=cantidad]").text();
        var price = $this.find("span[name=precio]").attr("data-precio");
        total += parseInt(cant) * parseFloat(price);
    });
    $tagItem.find("span[name=total]").text(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(total));
}
