var cuvKeyUp = false, cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';
var listaPedidos = new Array();

var codigoSsic = "";
var tipoDespacho = false;

var reclamo = {
    form: {
        resultadosBusquedaCuv: "#ResultadosBusquedaCUV",
        txtCuv: "#ddlCuv",

    },
    pasos: {
        uno_seleccion_de_producto: "#Paso1",
        dos_seleccion_de_solucion: "#Paso2",
        tres_finalizar_envio_solicitud: "#Paso3"
    },
    progreso: {
        uno_producto: "#Selector1",
        dos_solucion: "#Selector2",
        tres_finalizar: "#Selector3"
    },
    clasesCss: {
        completado: "paso_reclamo_completado",
        activo: "paso_active_reclamo"
    },
    operacion: {
        faltante: "F",
        faltanteAbono: "G",
        devolucion: "D",
        trueque: "T",
        canje: "C"
    },
    datosCuv: []
};
var dataCdrDevolucion = {};
var flagSetsOrPack = false;
$(document).ready(function () {
    $("#ddlCampania").on("change", function () {
        $("#txtCantidad").val("1");
        $("#divMotivo").html("");
        $(reclamo.form.resultadosBusquedaCuv).empty();
        $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
        $(reclamo.form.txtCuv).val("").attr("data-codigo", "");
        if ($(this).val() == "0") {
            $("#ddlnumPedido").html("");
            $("#ddlnumPedido").hide();
            $(reclamo.form.txtCuv).html("");
            $(reclamo.form.txtCuv).addClass("campo_deshabilitado");
            $("#RangoCantidad").addClass("campo_deshabilitado");
            return false;
        } else {
            $(reclamo.form.txtCuv).removeClass("campo_deshabilitado");
            $("#RangoCantidad").removeClass("campo_deshabilitado");
        }
        $("#txtPedidoID").val(0);
        $("#txtNumeroPedido").val(0);
        ListarPedidoID();
    });

    $("#ddlnumPedido").on("change", function () {
        $("#divMotivo").html("");
        $("#txtCantidad").val("1");
        $(reclamo.form.txtCuv).val("");
        $(reclamo.form.resultadosBusquedaCuv).empty();
        $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
        if ($(this).val() == "0") {
            $("#txtPedidoID").val("");
            $("#hdfCUV").val("");
            $("#hdfCUVDescripcion").val("");
            $("#hdImporteTotalPedido").val("0");
            $("#txtPrecioUnidad").val("0");
            $("#txtNumeroPedido").val("0");
            $('#txtPedidoID').val("");
            $('#ddlCuv').addClass("campo_deshabilitado");
            $("#RangoCantidad").addClass("campo_deshabilitado");
            return false;
        } else {
            $("#txtPedidoID").val($.trim($("#ddlnumPedido").val()));
            $('#ddlCuv').removeClass("campo_deshabilitado");
            $("#RangoCantidad").removeClass("campo_deshabilitado");
            BuscarCUV();
        }
    });
    $('#divMotivo').on("click", ".reclamo_motivo_select", function () {
        $(".reclamo_motivo_select").removeClass("reclamo_motivo_select_click");
        $(".reclamo_motivo_select").attr("data-check", "0");
        $(this).addClass("reclamo_motivo_select_click");
        $(this).attr("data-check", "1");
    });

    $("#IrPAso2").on("click", function () {
        $("#txtCUVDescripcion2").val("")
        $("#txtCUV2").val("");
        $("#txtCUVPrecio2").val("");
        $("#MensajeTenerEncuenta").fadeOut(100);
        if (ValidarPasoUno()) {
            ValidarPasoUnoServer(function (d) {
                if (!d.success) {
                    alert_msg(d.message);
                } else {
                    //Seteamos la data de la respuesta del servicio de cdr
                    var ProductoSeleccionado = {
                        CUV: $("#hdfCUV").val(),
                        Descripcion: $("#hdfCUVDescripcion").val()
                    };

                    dataCdrDevolucion.ProductoSeleccionado = ProductoSeleccionado;
                    if (d.data[0].LProductosComplementos != null && d.data[0].LProductosComplementos != "undefined") {
                        dataCdrDevolucion.DataRespuestaServicio = d.data[0].LProductosComplementos;
                        flagSetsOrPack = d.flagSetsOrPack;
                    }

                    CargarOperacion(function (data) {
                        if (data.success == false) {
                            alert_msg(data.message);
                            return false;
                        }

                        if (data.detalle.length === 0) {
                            alert_msg("Lo sentimos, no encontramos opciones para el inconveniente seleccionado.");
                            return false;
                        }
                        CambiarVistaPaso(reclamo.pasos.dos_seleccion_de_solucion);
                        $("#divOperacion input[type=checkbox]").prop('checked', false);
                        SetHandlebars("#template-operacion", data.detalle, "#divOperacion");
                    });
                }
            });
        }
    });

    // Seleccionar opción haciendo click en el área que conforma la opción cdr elegida, no sólo en el checkbox
    $(".lista_opciones_cdr_wrapper").on("click", ".opcion_cdr_enlace", function (e) {
        e.preventDefault();
        // Se dispara el evento change del checkbox que llama a la función EscogerSolucion que se lanza al seleccionar y deseleccionar el checkbox
        $(this).find('input[type="checkbox"]').change();
    });

    $("#RegresarPaso1, #RegresarPaso2, #RegresarCambio1, #RegresarCanje1").on("click", function () {
        CambiarVistaPaso(reclamo.pasos.uno_seleccion_de_producto);
    });
    $(reclamo.form.txtCuv).on("click", function () {
        if ($("#ddlCampania").val() != 0) {
            $(reclamo.form.resultadosBusquedaCuv).fadeIn(100);
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeIn(100);
            $(".resultado_busqueda_por_cuv").fadeIn(100);
            $(".lista_resultados_busqueda_por_cuv_wrapper").focus();
        }
    }).on("keyup", function () {
        if ($(this).val().length === 0) {
            $(this).attr("data-codigo", "");
            $(".resultado_busqueda_por_cuv").fadeIn(100);
        } else {
            $(reclamo.form.resultadosBusquedaCuv).fadeIn(100);
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeIn(100);
            var texto = $(this).val();
            $(reclamo.form.resultadosBusquedaCuv).find("li").filter(function () {
                $(this).toggle($(this).attr("data-value-cuv").indexOf(texto) > -1 || $(this).attr("data-value-producto").indexOf(texto.toUpperCase()) > -1);
            });
        }
    }).on("blur", function () {
        setTimeout(function () {
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
        }, 50);
    });

    $("#IrSolicitudInicial").on("click", function () {
        if (mensajeGestionCdrInhabilitada !== "") {
            alert_msg(mensajeGestionCdrInhabilitada);
            return false;
        }
        $("#hdfCUVDescripcion").val("");
        $("#txtCantidad").val("1");
        $("#divMotivo").html('');
        $("#txtCUV2").val("");
        $("#txtCUVPrecio2").val("");
        $("#spnImporteTotal2").html("");
        $("#hdImporteTotal2").val(0);
        $("#txtCUVDescripcion2").val("");
        $("#txtCantidad2").val("1");
        CambiarVistaPaso(reclamo.pasos.uno_seleccion_de_producto);
        $('#ddlnumPedido').append($('<option></option>').val($("#txtPedidoID").val()).html("N° " + $("#txtNumeroPedido").val()));
        $("#ddlnumPedido").show();
        $("#ddlnumPedido").attr("disabled", "disabled");
        $("#hdfCUV").val("");
        $(reclamo.form.txtCuv).val("");
        BuscarCUV();
        $("#divUltimasSolicitudes").show();
        $("#ddlCampania").attr("disabled", "disabled");
        $("#ddlCuv,#RangoCantidad").removeClass("campo_deshabilitado");
    });

    $("#IrSolicitudEnviada").on("click", function () {

        if (mensajeGestionCdrInhabilitada != '') {
            alert_msg(mensajeGestionCdrInhabilitada);
            return false;
        }

        var cantidadDetalle = $("#divDetallePaso3 .content_listado_reclamo").length || 0;
        if (cantidadDetalle == 0) {
            var functionRegresar = function () { window.location = urlRegresar; };
            messageConfirmacion("", "No se puede finalizar la solicitud porque no cuenta con registros.", functionRegresar);
            return false;
        }
        $("#ddlCampania").removeAttr("disabled");
        if (ValidarSolicitudCDREnvio(false, true)) {
            $("#txtCantidadPedidoConfig").text(CantidadReclamosPorPedidoConfig);
            $("#divConfirmEnviarSolicitudCDR").show();
        }
    });

    $("#btnAceptoPoliticas").on("click", function () {
        if ($(this).hasClass("politica_reclamos_icono_active")) {
            $(this).removeClass("politica_reclamos_icono_active");
        } else {
            $(this).addClass("politica_reclamos_icono_active");
        }
    });

    $("#btnDespachoNormal").on("click", function () {
        var claseBotonActivado = "cdr_tipo_despacho_icono_active";
        var claseBotonDesactivado = "cdr_tipo_despacho_icono";
        var botonExpress = $("#btnDespachoExpress");

        if (!$(this).hasClass(claseBotonActivado)) {
            $(this).addClass(claseBotonActivado);
            botonExpress.removeClass(claseBotonActivado);
            botonExpress.addClass(claseBotonDesactivado);
            tipoDespacho = false;
        }
    });

    $("#btnDespachoExpress").on("click", function () {
        var claseBotonActivado = "cdr_tipo_despacho_icono_active";
        var claseBotonDesactivado = "cdr_tipo_despacho_icono";
        var botonNormal = $("#btnDespachoNormal");

        if (!$(this).hasClass(claseBotonActivado)) {
            $(this).addClass(claseBotonActivado);
            botonNormal.removeClass(claseBotonActivado);
            botonNormal.addClass(claseBotonDesactivado);
            tipoDespacho = true;
        }
    });

    $("#txtTelefono").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });

    $("#txtEmail").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /^[a-zA-Z@._0-9\-]*$/;
            return re.test(keyChar);
        }
    });

    if (parseInt($("#txtPedidoID").val()) != 0) {
        CambiarVistaPaso(reclamo.pasos.tres_finalizar_envio_solicitud)
        DetalleCargar();
    }


    $('#alertEMailDialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons: {
            "Aceptar": function () {
                HideDialog("alertEMailDialogMensajes");
            }
        }
    });
    $('#btnRegresarPasoUno').on('click', function () {
        CambiarVistaPaso(reclamo.pasos.uno_seleccion_de_producto);
    });
});

function callAjax(pUrl, pSendData, callbackSuccessful, callbackError) {
    var sendData = typeof pSendData === "undefined" ? {} : pSendData;
    $.ajax({
        type: "POST",
        url: pUrl,
        beforeSend: function () {
            waitingDialog();
        },
        complete: function () {
            closeWaitingDialog();
        },
        data: JSON.stringify(sendData),
        contentType: "application/json; charset=utf-8",
        async: true,
        dataType: "json",
        success: function (result) {
            if (callbackSuccessful && typeof callbackSuccessful === "function") {
                callbackSuccessful(result);
            }
        },
        error: function (msg) {
            if (callbackError && typeof callbackError === "function") {
                callbackError(msg);
            } else {
                closeWaitingDialog();
            }
        }
    });
}


function CambiarVistaPaso(paso) {
    var tagContenedorPasos = $('#contenedor_paso .content_reclamo');
    var tagContenedorBarraPasos = $('#barra_progreso .paso_reclamo');
    var lineaProgresoPasos = $('.progreso_pasos');


    //seteamos la barra
    tagContenedorBarraPasos.each(function (index, element) {
        var elBarra = $(element);
        if (elBarra.hasClass(reclamo.clasesCss.activo))
            elBarra.removeClass(reclamo.clasesCss.activo);
        if (elBarra.hasClass(reclamo.clasesCss.completado))
            elBarra.removeClass(reclamo.clasesCss.completado);
    });

    //agregamos las clases según paso a cambiar
    if (paso === reclamo.pasos.uno_seleccion_de_producto) {
        $(reclamo.progreso.uno_producto).addClass(reclamo.clasesCss.activo);
    }

    if (paso === reclamo.pasos.dos_seleccion_de_solucion) {
        $(reclamo.progreso.uno_producto).addClass(reclamo.clasesCss.completado);
        $(reclamo.progreso.dos_solucion).addClass(reclamo.clasesCss.activo);
        $(lineaProgresoPasos).css('width', '50%');
    }


    if (paso === reclamo.pasos.tres_finalizar_envio_solicitud) {
        $(reclamo.progreso.uno_producto).addClass(reclamo.clasesCss.completado);
        $(reclamo.progreso.dos_solucion).addClass(reclamo.clasesCss.completado);
        $(reclamo.progreso.tres_finalizar).addClass(reclamo.clasesCss.activo);
        $(lineaProgresoPasos).css('width', '100%');
    }

    if (paso === reclamo.pasos.dos_seleccion_de_solucion) {
        $('#infoOpcionesDeCambio').children('div').hide();
    }

    //no visible vista actual
    tagContenedorPasos.each(function (index, el) {
        if ($(el).is(':visible')) {
            idActivo = $(el).attr('id');
            $(el).fadeOut(100);
            return false;
        }
    });
    //activamos el paso del parametro
    $(paso).fadeIn(100);

    ValidarVisualizacionBannerResumen();
}

function SetTemplateDevolucion(data) {
    if (data) {
        SetHandlebars("#template-opcion-devolucion", data, "#divDevolucionSetsOrPack");
    }
}

function CUV2Cambio() {
    var cuv2Val = $("#txtCUV2").val();
    if (cuv2Val == null) cuv2Val = '';
    if (cuv2Val.length > 5) {
        cuv2Val = cuv2Val.substr(0, 5);
        $("#txtCUV2").val(cuv2Val);
    }

    var cambio = (cuv2Val != cuv2PrevVal);
    cuv2PrevVal = cuv2Val;
    return cambio;
}
function alertEMail_msg(message, titulo) {
    titulo = titulo || "MENSAJE";
    $('#alertEMailDialogMensajes .terminos_title_2').html(titulo);
    $('#alertEMailDialogMensajes .pop_pedido_mensaje').html(message);
    $('#alertEMailDialogMensajes').dialog('open');
}

function ListarPedidoID() {
    $("#txtPedidoID").val("");
    $("#txtNumeroPedido").val("");
    $("#ddlnumPedido").html("");
    $("#hdfCUVDescripcion").val("");
    var CampaniaId = $.trim($("#ddlCampania").val());

    var item = {
        CampaniaID: CampaniaId,
    };
    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ObtenerNumeroPedidos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success == false) {
                alert_msg(data.message);
                return false;
            }

            $('#ddlnumPedido').hide();
            if (data.datos.length == 1) {
                $("#txtPedidoID").val(data.datos[0].PedidoID);
                $("#txtNumeroPedido").val(data.datos[0].NumeroPedido);
                BuscarCUV();
            }
            else if (data.datos.length > 1) {
                $('#ddlnumPedido').append($('<option></option>').val(0).html("Elige un pedido"));
                $(data.datos).each(function (index, item) {
                    $('#ddlnumPedido').append($('<option></option>').val(item.PedidoID).html(item.strNumeroPedido));
                });
                $('#ddlnumPedido').show();
            }
            else {
                alert_msg(data.message)
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            checkTimeout(data);
        }
    });
}

function BuscarCUV() {
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;

    var PedidoId = $.trim($("#txtPedidoID").val()) || 0;

    var item = {
        CampaniaID: CampaniaId,
        PedidoID: PedidoId,
        CDRWebID: $("#CDRWebID").val() || 0
    };

    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarCUV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success == false) {
                alert_msg(data.message);
                return false;
            }

            if (data.detalle == null) return false;

            if (data.detalle.length > 1) {
                $(reclamo.form.txtCuv).html("");
                $(reclamo.form.resultadosBusquedaCuv).empty();
                var divPadre = $(reclamo.form.resultadosBusquedaCuv);
                SetHandlebars("#template-listado-cuv", data.detalle, divPadre);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            checkTimeout(data);
        }
    });
}

function SeleccionarCUVBusqueda(event) {
    var $el = $(event.currentTarget);
    var cuv = $el.attr("data-value-cuv");
    var producto = $el.attr("data-value-producto");
    $("#hdfCUV").val(cuv);
    $(reclamo.form.txtCuv).val(cuv + ' - ' + producto).attr("data-codigo", cuv);
    $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
    ObtenerDatosCuv();
}

function ValidarVisualizacionBannerResumen() {
    var cantidadDetalles = $("#spnCantidadUltimasSolicitadas").html();

    if ($('#Paso2:visible').length > 0 || cantidadDetalles == 0) $("#btn_ver_solicitudes").hide();
    else $("#btn_ver_solicitudes").show();
    if ($('#Paso3:visible').length > 0) $("#divUltimasSolicitudes").hide();
    else $("#divUltimasSolicitudes").show();
}

function PopupPedido(pedidos) {
    $("#divPopupPedido").hide();
    pedidos = pedidos || new Array();
    SetHandlebars("#template-pedido", pedidos, "#divPedido");
    if (pedidos.length > 0) {
        listaPedidos = pedidos;
        $("#divPopupPedido").show();
    }
}

function PopupPedidoSeleccionar(obj) {
    var objPedido = $(obj);
    var id = objPedido.attr("data-pedido-id");
    var pedidos = listaPedidos.Find("PedidoID", id);
    pedido = pedidos.length > 0 ? pedidos[0] : new Object();
    $("#divPopupPedido").hide();
    AsignarCUV(pedido);

}

function ObtenerDatosCuv() {
    waitingDialog();

    var item = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: $("#txtPedidoID").val()
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ObtenerDatosCuv',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success == false) {
                alert_msg(data.message);
                return false;
            }
            var arrCuv = data.datos[0].olstBEPedidoWebDetalle || [];
            reclamo.datosCuv = [];
            if (arrCuv.length > 0) {
                $.each(arrCuv, function (index, value) {
                    obj = {
                        cuv: value.CUV,
                        descripcion: value.DescripcionProd,
                        pedidoId: value.PedidoID,
                        CampaniaId: value.CampaniaID,
                        precioUnidad: value.PrecioUnidad,
                        cantidad: value.Cantidad
                    };
                    reclamo.datosCuv.push(obj);
                });
            }
            AsignarCUV(data.datos[0]);
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function AsignarCUV(pedido) {

    pedido = pedido || new Object();

    $("#divMotivo").html("");
    var EstadosConteo = 0;
    var CDRWebID = $("#CDRWebID").val() || 0;
    $.each(pedido.BECDRWeb, function (i, item) {
        if (item.Estado === 3 || item.Estado === 2) {
            EstadosConteo++;
        }
        //obtener el cdr en estado pendiente
        if (item.Estado === 1 && CDRWebID == 0)
            CDRWebID = item.CDRWebID;

    });
    //Nueva solicitud de reclamo
    var cantidad = CantidadReclamosPorPedidoConfig != null && CantidadReclamosPorPedidoConfig != '' ? parseInt(CantidadReclamosPorPedidoConfig) : 0;
    if (cantidad === EstadosConteo && EstadosConteo > 0) {
        alert_msg("Lo sentimos, usted ha excedido el límite de reclamos por pedido");
    } else {
        pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
        var cuvSeleccionado = $.trim($("#hdfCUV").val());
        var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", cuvSeleccionado || "");
        var data = detalle.length > 0 ? detalle[0] : new Object();
        $("#txtCantidad").removeAttr("disabled").attr("data-maxvalue", data.Cantidad).val(data.Cantidad);
        $("#hdfCUVDescripcion").val(data.DescripcionProd);
        $("#txtPedidoID").val(data.PedidoID);
        $("#txtNumeroPedido").val(pedido.NumeroPedido);
        $("#txtPrecioUnidad").val(data.PrecioUnidad);
        $("#hdImporteTotalPedido").val(pedido.ImporteTotal);
        $("#CDRWebID").val(CDRWebID) || 0;
        BuscarMotivo();
        DetalleCargar();
    }
}

function BuscarMotivo() {
    var PedidoId = $.trim($("#txtPedidoID").val()) || 0;
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (PedidoId <= 0 || CampaniaId <= 0)
        return false;

    var url = baseUrl + 'MisReclamos/BuscarMotivo';
    var sendData = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: PedidoId
    };

    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;

        if (data.success == false) {
            alert_msg(data.message);
            return false;
        }
        SetHandlebars("#template-motivo", data.detalle, "#divMotivo");
    });
}

function ValidarPasoUno() {
    if ($("#ddlCampania").val() == "" || $("#ddlCampania").val() == "0") {
        alert_msg("por favor, seleccionar una campaña.");
        $(this).focus();
        return false;
    }

    if ($("#txtPedidoID").val() == "") {
        alert_msg("por favor, seleccionar un pedido.");
        return false;
    }


    if ($(reclamo.form.txtCuv).val() == "") {
        alert_msg("por favor, seleccionar un producto.");
        $(this).focus();
        return false;
    }

    var $lis = $("#ResultadosBusquedaCUV li");
    if (!ValidarCUVYaIngresado($lis, $(reclamo.form.txtCuv).attr("data-codigo"), "data-value-cuv")) {
        $(reclamo.form.txtCuv).val("");
        $(reclamo.form.txtCuv).attr("data-codigo", "");
        alert_msg("Por favor, ingrese un producto válido");
        return false;
    }

    if ($("#divMotivo [data-check='1']").attr("id") == "0" || $("#divMotivo [data-check='1']").attr("id") == undefined || $("#divMotivo [data-check='1']").attr("id") == "undefined") {
        alert_msg("por favor, seleccione el motivo del cambio.");
        return false;
    }

    if (!(parseInt($("#txtCantidad").val()) > 0 && parseInt($("#txtCantidad").val()) <= parseInt($("#txtCantidad").attr("data-maxvalue")))) {
        alert_msg("Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
            $.trim($("#txtCantidad").attr("data-maxvalue")) + ")");
        $("#txtCantidad").focus();
        return false;
    }

    return true;
}

function ValidarPasoUnoServer(callbackWhenFinish) {
    var url = baseUrl + 'MisReclamos/ValidarPaso1';

    var sendData = {
        PedidoID: $("#txtPedidoID").val(),
        CUV: $.trim($("#hdfCUV").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id")),
        CampaniaID: $("#ddlCampania").val()
    };

    callAjax(url, sendData, function (d) {
        if (!checkTimeout(d))
            return false;

        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
            callbackWhenFinish(d);
        }
    });
}

function CargarOperacion(callbackWhenFinish) {
    var sendData = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: $("#txtPedidoID").val(),
        Motivo: $("#divMotivo [data-check='1']").attr("id")
    };

    var url = baseUrl + 'MisReclamos/BuscarOperacion';
    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;

        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
            callbackWhenFinish(data);
        }
    });
}

function ObtenerValorParametria(codigoSsic) {
    var url = baseUrl + 'MisReclamos/BuscarParametria';
    var sendData = {
        EstadoSsic: codigoSsic
    };

    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;
        var parametria = data.detalle;
        var parametriaAbs = data.detalleAbs;
        $("#hdParametriaCdr").val(parametria.ValorParametria);
        $("#hdParametriaAbsCdr").val(parametriaAbs.ValorParametria);
    });
}

function ObtenerValorCDRWebDatos(codigoSsic) {
    var sendData = {
        EstadoSsic: codigoSsic
    };
    var url = baseUrl + 'MisReclamos/BuscarCdrWebDatos';
    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;
        var cdrWebDatos = data.cdrWebdatos;
        $("#hdCdrWebDatos_Ssic").val(cdrWebDatos.Valor);
    });
}

function CargarPropuesta(codigoSsic) {
    $("#MensajeTenerEncuenta").fadeOut(100);
    var url = baseUrl + 'MisReclamos/BuscarPropuesta';
    var sendData = {
        CUV: $.trim($("#hdfCUV").val()),
        DescripcionProd: $.trim($("#hdfCUVDescripcion").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        EstadoSsic: $.trim(codigoSsic)
    };

    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;

        if (data.success == false) {
            return false;
        }
        console.log(data.texto);
        $("#MensajeTenerEncuenta").fadeIn(100);
        $('#spnMensajeTenerCuenta').html(data.texto);
    });
}


function DetalleGuardar(operacionId, callbackWhenFinish) {
    var Complemento = [];
    var cantidad = 0;
    if (dataCdrDevolucion !== null) {
        if (dataCdrDevolucion.DataRespuestaServicio.length > 0) {
            $.each(dataCdrDevolucion.DataRespuestaServicio, function (index, value) {
                var arr = $.grep(reclamo.datosCuv, function (item) {
                    return item.cuv === value.cuv;
                });
                cantidad = arr.length > 0 ? arr[0].cantidad : 1;
                var obj = {
                    cuv: value.cuv,
                    descripcion: value.descripcion,
                    cantidad: cantidad
                }
                Complemento.push(obj);
            });

        }
    }
    var Reemplazo = [];
    if (operacionId === reclamo.operacion.trueque) {
        //obtener los valores del cada cuv para el trueque
        var items = $("#contenedorCuvTrueque .item-producto-cambio");
        items.each(function (i, el) {
            var $el = $(el);
            var obj = {
                cuv: $el.find("input[name=codigo]").attr("data-codigo"),
                precio: $el.find("input[name=precio]").attr("data-precio") !== "" ? parseFloat($el.find("input[name=precio]").attr("data-precio")).toFixed(2) : 0,
                simbolo: variablesPortal.SimboloMoneda,
                cantidad: $el.find("input[name=cantidad]").val(),
                descripcion: $el.find("input[name=descripcion]").attr("data-descripcion")
            };

            Reemplazo.push(obj);
        });
    }


    var url = baseUrl + 'MisReclamos/DetalleGuardar';
    var sendData = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
        NumeroPedido: $("#txtNumeroPedido").val() || 0,
        CampaniaID: $("#ddlCampania").val() || 0,
        Motivo: $(".reclamo_motivo_select[data-check='1']").attr("id"),
        Operacion: operacionId,
        CUV: $.trim($("#hdfCUV").val()),
        Cantidad: $("#txtCantidad").val(),
        CUV2: $("#txtCUV2").val(),
        Cantidad2: $("#txtCantidad2").val(),
        Complemento: Complemento,
        Reemplazo: operacionId === reclamo.operacion.trueque ? Reemplazo : null
    };

    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data)) {
            return false;
        }
        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
            callbackWhenFinish(data);
        }
    });
}

function ValidarPasoDosDevolucion(codigoSsic) {
    var montoMinimoPedido = $("#hdMontoMinimoPedido").val();
    var montoTotalPedido = $("#hdImporteTotalPedido").val();
    var montoProductosDevolverActual = ObtenerMontoProductosDevolver(codigoSsic);

    var diferenciaMonto = montoTotalPedido - montoMinimoPedido;
    var montoCuvActual = (parseFloat($("#txtPrecioUnidad").val()) || 0) * (parseInt($("#txtCantidad").val()) || 0);

    var montoDevolver = montoProductosDevolverActual + montoCuvActual;

    if (diferenciaMonto < montoDevolver) {
        alert_msg("Por favor, selecciona otra solución, ya que tu pedido está quedando por debajo del monto mínimo permitido");
        return false;
    }
    var valorParametria = $("#hdParametriaCdr").val() || 0;

    valorParametria = parseFloat(valorParametria);

    var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

    if (montoMaximoDevolver < montoDevolver) {
        alert_msg("Por favor, selecciona otra solución, ya que superas el porcentaje de devolución permitido en tu pedido facturado");
        return false;
    }

    return true;
}


function ValidarPasoDosFaltante(codigoSsic) {
    var esCantidadPermitidaValida = ValidarCantidadMaximaPermitida(codigoSsic);

    if (esCantidadPermitidaValida) {
        var montoTotalPedido = $("#hdImporteTotalPedido").val();
        var montoProductosFaltanteActual = ObtenerMontoProductosDevolver(codigoSsic);
        var montoCuvActual = (parseFloat($("#txtPrecioUnidad").val()) || 0) * (parseInt($("#txtCantidad").val()) || 0);
        var montoDevolver = montoProductosFaltanteActual + montoCuvActual;
        var valorParametria = $("#hdParametriaCdr").val() || 0;
        valorParametria = parseFloat(valorParametria);
        var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;
        if (montoMaximoDevolver < montoDevolver) {
            alert_msg("Por favor, selecciona otra solución, ya que superas el porcentaje de faltante permitido en tu pedido facturado");
            return false;
        }

        return true;
    } else
        return false;
}

function ValidarPasoDosFaltanteAbono(codigoSsic) {
    return ValidarCantidadMaximaPermitida(codigoSsic);
}

function ValidarPasoDosTrueque() {
    //agregar aquí
    var $cuvs = $("#contenedorCuvTrueque .item-producto-cambio").find("input[name=codigo]");

    var ok = true;
    $.each($cuvs, function (i, el) {
        var $el = $(el);
        if ($el.attr("data-codigo") === "" || ($el.attr("data-codigo") !== "" && $el.attr("data-codigo").length !== 5)) {
            ok = false;
            return false;
        }
    });

    if (!ok) {
        alert_msg("Por favor, ingrese el CUV con el que desea cambiar.");
        return false;
    }

    var montoMinimoReclamo = $("#hdMontoMinimoReclamo").val();
    var montoPedidoTrueque = $("#hdImporteTotal2").val();

    var valorParametria = $("#hdParametriaCdr").val();
    var valorParametriaAbs = $("#hdParametriaAbsCdr").val();

    if (valorParametriaAbs == "1") {
        var diferencia = parseFloat(montoMinimoReclamo) - parseFloat(montoPedidoTrueque);
        if (diferencia > parseInt(valorParametria)) {
            alert_msg("Diferencia en trueques excede lo permitido");
            return false;
        }
    } else {
        if (valorParametriaAbs == "2") {
            if (montoPedidoTrueque < montoMinimoReclamo) {
                alert_msg("Está devolviendo menos de lo permitido");
                return false;
            }
        } else {
            var diferencia2 = parseFloat(montoMinimoReclamo) - parseFloat(montoPedidoTrueque);
            diferencia2 = Math.abs(diferencia2);

            if (diferencia2 > parseInt(valorParametria)) {
                alert_msg("Diferencia en trueques excede lo permitido");
                return false;
            }
        }
    }

    return true;
}

function ValidarCantidadMaximaPermitida(codigoSsic) {
    ObtenerValorCDRWebDatos(codigoSsic);
    var cantidadProductosFaltanteActual = ObtenerCantidadProductosByCodigoSsic(codigoSsic);
    var cantidadCuvActual = parseInt($("#txtCantidad").val()) || 0;

    var cantidadFaltante = cantidadProductosFaltanteActual + cantidadCuvActual;

    var valorCdrWebDatos = $("#hdCdrWebDatos_Ssic").val() || 0;
    valorCdrWebDatos = parseInt(valorCdrWebDatos);

    if (cantidadFaltante > valorCdrWebDatos) {
        alert_msg("Superas la cantidad máxima permitida de (" + valorCdrWebDatos +
            ") unidades a reclamar para este servicio postventa, por favor modifica tu solicitud");
        return false;
    }

    return true;
}
function DetalleCargar() {
    var url = baseUrl + 'MisReclamos/DetalleCargar';
    var sendData = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0
    };
    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;

        if (data.success != true) {
            alert_msg(data.message);
            return false;
        }

        $("#spnCantidadUltimasSolicitadas").html(data.detalle.length);
        CalcularMontoTotalTrueque(data);
        SetHandlebars("#template-detalle-banner", data.detalle, "#divDetalleUltimasSolicitudes");
        ValidarVisualizacionBannerResumen();

        SetHandlebars("#template-detalle-paso3", data, "#divDetallePaso3");
        SetHandlebars("#template-detalle-paso3-enviada", data, "#divDetalleEnviar");

        if (data.esCDRExpress) $("#TipoDespacho").show();
        else $("#TipoDespacho").hide();
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

function DetalleEliminar(objItem) {
    var url = baseUrl + 'MisReclamos/DetalleEliminar';
    callAjax(url, objItem, function (data) {
        if (!checkTimeout(data)) {
            return false;
        }

        if (data.success == true) {
            DetalleCargar();
        }
    });
}

function ControlSetError(inputId, spanId, message) {
    if (IfNull(message, '') == '') {
        $(inputId).css('border-color', '#b5b5b5');
        $(spanId).css('display', 'none');
    }
    else {
        $(inputId).css('border-color', 'red');
        $(spanId).css('display', '');
        $(spanId).html(message);
    }
}

function ValidarSolicitudCDREnvio(validarCorreoVacio, validarCelularVacio) {
    var ok = true;
    var correo = $.trim($("#txtEmail").val());
    var celular = $.trim($("#txtTelefono").val());
    ControlSetError('#txtEmail', '#spnEmailError', null);
    ControlSetError('#txtTelefono', '#spnTelefonoError', null);

    if (IfNull(validarCorreoVacio, true) && correo == "") {
        ControlSetError('#txtEmail', '#spnEmailError', '*Correo Electrónico incorrecto');
        ok = false;
    }
    if (IfNull(validarCelularVacio, true) && celular == "") {
        ControlSetError('#txtTelefono', '#spnTelefonoError', '*Celular incorrecto');
        ok = false;
    }
    if (!ok) {
        alert_msg("Debe completar la sección de VALIDA TUS DATOS para finalizar");
        return false;
    }

    if (correo != "" && !validateEmail(correo)) {
        ControlSetError('#txtEmail', '#spnEmailError', '*Correo Electrónico incorrecto');
        ok = false;
    }
    if (celular != "" && celular.length < 6) {
        ControlSetError('#txtTelefono', '#spnTelefonoError', '*Celular incorrecto');
        ok = false;
    }

    if (!ok) return false;

    if (!$("#btnAceptoPoliticas").hasClass("politica_reclamos_icono_active")) {
        alert_msg("Debe aceptar la política de Cambios y Devoluciones");
        return false;
    }

    return true;
}

function ValidarTelefonoServer(celular, callbackWhenFinish) {
    var url = baseUrl + 'Bienvenida/ValidadTelefonoConsultora';
    var sendData = {
        Telefono: celular
    };
    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data)) {
            return false;
        }
        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
            callbackWhenFinish(data);
        }
    });


}

function ValidarCorreoDuplicadoServer(correo, callbackWhenFinish) {
    var url = baseUrl + 'MisReclamos/ValidarCorreoDuplicado';
    var sendData = {
        correo: correo
    };

    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data)) {
            return false;
        }
        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
            callbackWhenFinish(data);
        }
    });
}

function SolicitudCDREnviar(callbackWhenFinish) {
    var url = baseUrl + 'MisReclamos/SolicitudEnviar';
    var sendData = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
        Email: $("#txtEmail").val(),
        Telefono: $("#txtTelefono").val(),
        TipoDespacho: false,
        FleteDespacho: 0,
        MensajeDespacho: '',
        EsMovilFin: OrigenCDR
    };

    if ($("#hdTieneCDRExpress").val() == '1') {
        sendData.TipoDespacho = tipoDespacho;
        sendData.FleteDespacho = !tipoDespacho ? 0 : $("#hdFleteDespacho").val();
        sendData.MensajeDespacho = $(!tipoDespacho ? '#divDespachoNormal' : '#divDespachoExpress').CleanWhitespace().html();
    }

    setTimeout(function () {
        callAjax(url, sendData, function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success) {
                var formatoFechaCulminado = "";
                var numeroSolicitud = 0;
                var formatoCampania = "";
                var mensajeDespacho = IfNull(data.cdrWeb.MensajeDespacho, '');
                if (data.cdrWeb.CDRWebID > 0) {
                    if (data.cdrWeb.FechaCulminado != 'null' || data.cdrWeb.FechaCulminado != "" || data.cdrWeb.FechaCulminado != "undefined") {
                        var dateString = data.cdrWeb.FechaCulminado.substr(6);
                        var currentTime = new Date(parseInt(dateString));
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        formatoFechaCulminado = (day < 10 ? "0" + day : day) + "/" + (month < 10 ? "0" + month : month) + "/" + year;
                    }
                    numeroSolicitud = data.cdrWeb.CDRWebID;
                    if (data.cdrWeb.CampaniaID.toString().length == 6) {
                        formatoCampania = data.cdrWeb.CampaniaID.toString().substring(0, 4) + "-" + data.cdrWeb.CampaniaID.toString().substring(4);
                    }
                }

                $("#spnSolicitudFechaCulminado").html(formatoFechaCulminado);
                $("#spnSolicitudNumeroSolicitud").html(numeroSolicitud);
                $("#spnSolicitudCampania").html(formatoCampania);
                if (mensajeDespacho == '') $("#spnTipoDespacho").hide();
                else $("#spnTipoDespacho").show().html(mensajeDespacho);
                $("#divProcesoReclamo").hide();
                $("#divUltimasSolicitudes").hide();
                $("#TituloReclamo").hide();
                $("#SolicitudEnviada").show();
            }
            if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                callbackWhenFinish(data);
            }
        });
    }, 0);
}

function ObtenerMontoProductosDevolver(codigoOperacion) {
    var resultado = 0;

    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
        EstadoSsic: codigoOperacion
    };
    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ObtenerMontoProductosCdrByCodigoOperacion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                alert_msg(data.message);
                return false;
            }

            resultado = data.montoProductos;
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

    return resultado;
}

function ObtenerCantidadProductosByCodigoSsic(codigoSsic) {
    var resultado = 0;

    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
        EstadoSsic: codigoSsic
    };
    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ObtenerCantidadProductosByCodigoSsic',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                alert_msg(data.message);
                return false;
            }

            resultado = data.cantidadProductos;
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

    return resultado;
}

function ValidarTelefono() {
    var resultado = false;
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ValidadTelefonoConsultora',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ Telefono: $("#txtTelefono").val() }),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) resultado = false;
            else resultado = data.success;
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
    return resultado;
}

function ValidarCorreoDuplicado(correo) {
    var resultado = false;
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ValidarCorreoDuplicado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ correo: correo }),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                resultado = false;
            else
                resultado = data.success;
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
    return resultado;
}

function limitarMaximo(e, contenido, caracteres, id) {
    var unicode = e.keyCode ? e.keyCode : e.charCode;
    if (unicode == 8 || unicode == 46 || unicode == 13 || unicode == 9 || unicode == 37 ||
        unicode == 39 || unicode == 38 || unicode == 40 || unicode == 17 || unicode == 67 || unicode == 86)
        return true;

    if (contenido.length >= caracteres) {
        selectedText = document.getSelection();
        if (selectedText == contenido) {
            $("#" + id).val("");
            return true;
        } else if (selectedText != "") {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

function limitarMinimo(contenido, caracteres, a) {
    if (contenido.length < caracteres && contenido.trim() != "") {
        var texto = a == 1 ? "teléfono" : "celular";
        alert('El número de ' + texto + ' debe tener como mínimo ' + caracteres + ' números.');
        return false;
    }
    return true;
}
function PreValidarCUV(event) {

    event = event || window.event;

    if (event.keyCode == 13) {
        if ($("#btnAgregar")[0].disabled == false) {
            PedidoRegistroModule.AgregarProductoListadoPasePedido();
        }
    }
}

function CancelarConfirmEnvioSolicitudCDR() {
    $('#divConfirmEnviarSolicitudCDR').hide();
}

function ContinuarConfirmEnvioSolicitudCDR() {
    $.when(CancelarConfirmEnvioSolicitudCDR()).then(function () {
        ValidarTelefonoServer($.trim($("#txtTelefono").val()), function (data) {
            if (!data.success) {
                ControlSetError('#txtTelefono', '#spnTelefonoError', '*Este número de celular ya está siendo utilizado. Intenta con otro.');
                $('#IrSolicitudEnviada').removeClass("btn_deshabilitado");
                return false;
            } else if ($.trim($("#txtEmail").val()) != $.trim($("#hdEmail").val())) {
                ValidarCorreoDuplicadoServer($.trim($("#txtEmail").val()), function (data) {
                    if (!data.success) {
                        ControlSetError('#txtEmail', '#spnEmailError', data.message);
                        $('#IrSolicitudEnviada').removeClass("btn_deshabilitado");
                        return false;
                    } else {
                        SolicitudCDREnviar(function (data) {
                            if (!data.success) {
                                alert_msg(data.message);
                                $('#IrSolicitudEnviada').removeClass("btn_deshabilitado");
                                return false;
                            } else {
                                if (data.Cantidad == 1) {
                                    $('#IrSolicitudEnviada').removeClass("btn_deshabilitado");
                                    alertEMail_msg(data.message, "MENSAJE");
                                }
                            }
                        });
                    }
                });
            } else {
                SolicitudCDREnviar(function (data) {
                    if (!data.success) {
                        alert_msg(data.message);
                        $('#IrSolicitudEnviada').removeClass("btn_deshabilitado");
                        return false;
                    } else {
                        if (data.Cantidad == 1) {
                            $('#IrSolicitudEnviada').removeClass("btn_deshabilitado");
                            alertEMail_msg(data.message, "MENSAJE");
                        }
                    }
                });
            }
        });
    });
}

function SeleccionarContenido(control) {
    control.select();
}

function EscogerSolucion(opcion, event) {
    var tagCheck = $("#divOperacion input[type=checkbox]");
    var tagDivInfo = $('#infoOpcionesDeCambio');
    var cantidad = $('#txtCantidad').val() == "" ? 1 : parseInt($('#txtCantidad').val());
    tagCheck.not(opcion).prop('checked', false);
    $(".opcion_cdr").removeClass("opcion_cdr_seleccionada");
    if ($(opcion).is(':checked')) {
        $(opcion).parents(".opcion_cdr").removeClass("opcion_cdr_seleccionada");
        $(opcion).prop('checked', false);
    } else {
        $(opcion).parents(".opcion_cdr").addClass("opcion_cdr_seleccionada");
        $(opcion).prop('checked', true);
    }
    var id = opcion.id;
    var isChecked = tagCheck.is(':checked');
    if (id == "" || !isChecked) {
        $("#btnIrPaso3").fadeOut(100);
        tagDivInfo.fadeOut(100).children().fadeOut(100); //ocultamos la capa padre y los hijos
        $(opcion).parents(".opcion_cdr").removeClass("opcion_cdr_seleccionada");
        $("#MensajeTenerEncuenta").fadeOut(100);
        return false;
    }
    tagDivInfo.show();//Mostramos la capa padre

    //ocultamos la capa hijo visible
    tagDivInfo.children().each(function (index, element) {
        if ($(element).is(':visible')) {
            $(element).fadeOut(200);
            return false;
        }
    });

    $("#btnIrPaso3").fadeIn(100);
    var textoUnidades = " X " + cantidad + " Unidad(es)";

    //en base al id, mostramos la capa correspondiente
    if (id == reclamo.operacion.trueque) {
        ObtenerValorParametria(id);
        var $contenedor = $("#contenedorCuvTrueque");
        $contenedor.empty();
        $contenedor.append($("#template-cuv-cambio").html());
        $('#OpcionCambioPorOtroProducto').fadeIn(200);
        $("#MontoTotalProductoACambiar").hide();
        SetMontoCampaniaTotal();
    } else if (id == reclamo.operacion.canje) {
        $('#OpcionCambioMismoProducto').fadeIn(200);
        $('#spnDescProdDevolucionC').html($('#ddlCuv').val());
        $('#spnCantidadC').html(textoUnidades);
    } else if (id == reclamo.operacion.devolucion) {
        ObtenerValorParametria(id);
        $('#divDevolucionSetsOrPack').show();
        $('#OpcionDevolucion').fadeIn(200);
        $('#spnCantidadD').html(textoUnidades);
        SetHandlebars("#template-opcion-devolucion", dataCdrDevolucion, "#divDevolucionSetsOrPack");
        (flagSetsOrPack) ? $('#spnCantidadDVarios').text(textoUnidades) : $('#spnCantidadIndividual').text(textoUnidades);
    } else if (id == reclamo.operacion.faltante) {
        ObtenerValorParametria(id);
        $('#spnDescripcionProductoOpcionF').text($('#ddlCuv').val());
        $('#spnCantidadF').html(textoUnidades);
        $('#OpcionEnvioDelProducto').fadeIn(200);
    } else {
        $('#spnDescripcionProductoOpcionG').html($('#ddlCuv').val());
        $('#spnCantidadG').html(textoUnidades);
        $('#OpcionDevolucionDinero').fadeIn(200);
    }
    CargarPropuesta(id);
}

function SetMontoCampaniaTotal() {
    $("#spnSimboloMonedaReclamo").html(variablesPortal.SimboloMoneda);
    var precioUnidad = $("#txtPrecioUnidad").val();
    var cantidad = $("#txtCantidad").val();
    var totalTrueque = parseFloat(precioUnidad) * parseFloat(cantidad);
    $("#hdMontoMinimoReclamo").val(totalTrueque);
    $("#spnMontoMinimoReclamoFormato").html(DecimalToStringFormat(totalTrueque));
    var campania = $("#ddlCampania").val() || 0;
    var numeroCampania = '00';
    if (campania > 0) {
        numeroCampania = campania.substring(4);
    }
    $("#spnNumeroCampaniaReclamo").html(numeroCampania);
}

function AgregarODisminuirCantidad(event, opcion) {
    if (opcion === 1) {
        EstrategiaAgregarModule.AdicionarCantidad(event);
    }
    if (opcion === 2) {
        EstrategiaAgregarModule.DisminuirCantidad(event);
    }
    CalcularTotal();
}

function IrAFinalizar() {
    var fnPreValidacion = PreValidacionIrFinalizar();
    if (fnPreValidacion.result) {
        DetalleGuardar(fnPreValidacion.id, function (data) {
            if (data.success) {
                $("#CDRWebID").val(data.detalle);
                CambiarVistaPaso(reclamo.pasos.tres_finalizar_envio_solicitud);
                DetalleCargar();
            } else {
                alert_msg(data.message);
                return false;
            }
        });
    }
}



function PreValidacionIrFinalizar() {
    var id = "";
    var tag = $("#divOperacion input[type=checkbox]");
    var isChecked = tag.is(':checked');

    if (!isChecked) {
        alert_msg("Por favor, escoge una solución.");
        return false;
    }

    tag.each(function () {
        if ($(this).is(':checked')) {
            id = $(this).attr("id");
            return true;
        }
    });

    //Validaciones

    //Trueque
    if (id === reclamo.operacion.trueque) {
        if (!ValidarPasoDosTrueque()) {
            return false;
        }
    }

    //Devolución
    if (id === reclamo.operacion.devolucion) {
        if (!ValidarPasoDosDevolucion(id)) {
            return false;
        }
    }

    //Faltante
    if (id === reclamo.operacion.faltante) {
        if (!ValidarPasoDosFaltante(id)) {
            return false;
        }
    }

    //Faltante de abono
    if (id === reclamo.operacion.faltanteAbono) {
        if (!ValidarPasoDosFaltanteAbono(id)) {
            return false;
        }
    }

    return { result: true, id: id, };
}

function EliminarDetalle(el) {
    var pedidodetalleid = $.trim($(el).attr("data-pedidodetalleid"));
    var grupoid = $.trim($(el).attr("data-detalle-grupoid"));

    var item = {
        CDRWebDetalleID: pedidodetalleid,
        GrupoID: grupoid,
        Accion: "D"
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

//HD-4017 EINCA
function AgregarCUVTrueque() {
    $("#contenedorCuvTrueque").append($("#template-cuv-cambio").html());
}

function BuscarInfoCUV(e) {
    var $this = $(e.target);
    if ($this.val().length !== 5) {
        $this.val($this.val().substring(0, 5));
        return false;
    }
    var $elements = $this.parent();
    var dataValue = $this.attr("data-codigo");
    if (dataValue === $this.val())
        return false;
    
    var $elementsCUV = $("#contenedorCuvTrueque .item-producto-cambio");
    var $arrCuv = $elementsCUV.find("input[name=codigo]");
    if (ValidarCUVYaIngresado($arrCuv, $this.val(), "data-codigo")) {
        $this.val("");
        alert_msg("El CUV se encuentra en la lista, puedes aumentar la cantidad.");
        return false;
    }

    BuscarCUVCambiarServer($this.val(), function (data) {
        if (!data.success) {
            //Limpiar controles
            $elements.children("input").val("").end()
                .children(".contenedor-cantidad").find("input[name=cantidad]").val("1");

            $this.attr("data-codigo", $this.val());
            $elements
                .children("input[name=descripcion]").val("").end()
                .children("input[name=descripcion]").attr("data-descripcion", "").end()
                .children("input[name=precio]").val("").end()
                .children("input[name=precio]").attr("data-precio", "");
            CalcularTotal();
            alert_msg(data.message);
            return false;
        }
        var datosCUV = data.producto[0];

        //obtener los elementos a setear 
        if (datosCUV.MarcaID != 0) {
            $this.attr("data-codigo", datosCUV.CUV);
            $elements
                .children("input[name=descripcion]").val(datosCUV.Descripcion).end()
                .children("input[name=descripcion]").attr("data-descripcion", datosCUV.Descripcion).end()
                .children("input[name=precio]").val(DecimalToStringFormat(datosCUV.PrecioCatalogo)).end()
                .children("input[name=precio]").attr("data-precio", datosCUV.PrecioCatalogo);
            CalcularTotal();
        }
    });
}

//HD-4017 EINCA
function EliminarCUVTrueque(el) {
    if ($("#contenedorCuvTrueque .item-producto-cambio").length > 1) {
        $(el).parent().parent().remove();
        CalcularTotal();
    } else {
        return false;
    }
}

function CalcularTotal() {
    var precioTotal = 0;
    var items = $("#contenedorCuvTrueque .item-producto-cambio");
    items.each(function (i, el) {
        var $el = $(el);
        var precio = $($el).find("input[name=precio]").attr("data-precio");
        var cantidad = $($el).find("input[name=cantidad]").val();
        if (precio !== "" && cantidad !== "") {
            precioTotal = precioTotal + parseFloat(precio) * parseInt(cantidad);
        }
    });
    $("#spnImporteTotal2").text(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(precioTotal));
    $("#hdImporteTotal2").val(precioTotal);
    $("#MontoTotalProductoACambiar").fadeIn(100);
}


function BuscarCUVCambiarServer(cuv, callbackWhenFinish) {
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (CampaniaId <= 0 || cuv.length < 5)
        return false;

    var PedidoId = $.trim($("#txtPedidoID").val()) || 0;
    var url = baseUrl + 'MisReclamos/BuscarCuvCambiar';
    var sendData = {
        CampaniaID: CampaniaId,
        PedidoID: PedidoId,
        CDRWebID: $("#CDRWebID").val() || 0,
        CUV: cuv
    };

    callAjax(url, sendData, function (data) {
        if (!checkTimeout(data))
            return false;

        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
            callbackWhenFinish(data);
        }

    });
}

function ValidarCUVYaIngresado(arrElements, cuv, atributo) {
    var arrFilter = $.grep(arrElements, function (element, index) {
        return $(element).attr(atributo) == cuv;
    });
    return arrFilter.length > 0;
}


