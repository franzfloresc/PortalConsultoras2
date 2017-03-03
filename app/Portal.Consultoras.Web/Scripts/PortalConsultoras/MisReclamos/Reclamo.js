
var cuvKeyUp = false, cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';
var pasoActual = 1;
var paso2Actual = 1;
var listaPedidos = new Array();
var codigoSsic = "";

$(document).ready(function () {
    $("#ddlCampania").on("change", function () {
        $("#txtPedidoID").val(0);
        $("#txtNumeroPedido").val(0);
        BuscarCUV();
    });

    $("#txtCUV").on('keyup', function (evt) {
        cuvKeyUp = true;
        EvaluarCUV();
    });
    $("#txtCUV2").on('keyup', function (evt) {
        cuv2KeyUp = true;
        EvaluarCUV2();
    });
    setInterval(function () {
        if (cuvKeyUp) cuvKeyUp = false;
        else EvaluarCUV();

        if (cuv2KeyUp) cuv2KeyUp = false;
        else EvaluarCUV2();
    }, 1000)

    $('#divMotivo').on("click", ".reclamo_motivo_select", function () {
        $(".reclamo_motivo_select").removeClass("reclamo_motivo_select_click");
        $(".reclamo_motivo_select").attr("data-check", "0");
        $(this).addClass("reclamo_motivo_select_click");
        $(this).attr("data-check", "1");
    });

    $("#IrPAso2").on("click", function () {
        $("#txtCUVDescripcion2").val('')
        $("#txtCUV2").val('');
        $("#txtCUVPrecio2").val('');
        
        if (ValidarPaso1()) {
            paso2Actual = 1;
            CambioPaso();
            CargarOperacion();
        }
    });

    $('#divOperacion').on("click", ".btn_solución_reclamo", function () {
        $(".btn_solución_reclamo").attr("data-check", "0");
        var id = $.trim($(this).attr("id"));
        if (id == "") {
            return false;
        }
        $(this).attr("data-check", "1");
        AnalizarOperacion(id);
    });

    $("#RegresarPaso1, #RegresarPaso2, #RegresarCambio1, #RegresarCanje1").on("click", function () {
        CambioPaso(-1);
    });

    $("#CambioProducto2").on("click", function () {
        if (ValidarPaso2Trueque()) {
            CambioPaso2(1);

            $("#spnCuv1").html($("#txtCUV").val());
            $("#spnDescripcionCuv1").html($("#txtCUVDescripcion").val());
            $("#spnCantidadCuv1").html($("#txtCantidad").val());

            $("#spnCuv2").html($("#txtCUV2").val());
            $("#spnDescripcionCuv2").html($("#txtCUVDescripcion2").val());
            $("#spnCantidadCuv2").html($("#txtCantidad2").val());
        }        
    });

    $("[data-cambiopaso]").on("click", function () {
        DetalleGuardar();
    });

    $("#IrSolicitudInicial").on("click", function () {
        if (mensajePeriodoInvalido != '') {
            alert_msg(mensajePeriodoInvalido);
            return false;
        }

        $("#txtCUV").val("");
        $("#txtCUVDescripcion").val("");
        $("#txtCantidad").val("1");
        $("#txtCUV2").val("");
        $("#txtCUVPrecio2").val("");
        $("#spnImporteTotal2").html("");
        $("#hdImporteTotal2").val(0);
        $("#txtCUVDescripcion2").val(""); 
        $("#txtCantidad2").val("1");
        CambioPaso(-100);
        BuscarMotivo();
        
        $("#divUltimasSolicitudes").show();
        $("#ddlCampania").attr("disabled", "disabled");
    });

    $("#IrSolicitudEnviada").on("click", function () {
        var cantidadDetalle = $("#divDetallePaso3 .content_listado_reclamo").length || 0;

        if (cantidadDetalle > 0) {
            $("#ddlCampania").removeAttr("disabled");
            SolicitudEnviar();
        } else {
            var functionRegresar = function() {
                window.location = urlRegresar;
            };
            messageConfirmacion("", "No se puede finalizar la solicitud porque no cuenta con registros.", functionRegresar);
        }
    });

    $(document).on('click', '[data-accion]', function () {
        DetalleAccion(this);
    });

    $("#btnAceptoPoliticas").on("click", function() {
        if ($(this).hasClass("politica_reclamos_icono_active")) {
            $(this).removeClass("politica_reclamos_icono_active");
        } else {
            $(this).addClass("politica_reclamos_icono_active");
        }
    });

    $(".modificarPrecioMas").on("click", function () {
        var precio = $("#hdCuvPrecio2").val();
        var cantidad = parseInt($("#txtCantidad2").val());

        cantidad = cantidad == 99 ? 99 : cantidad + 1;

        var importeTotal = precio * cantidad;

        $("#hdImporteTotal2").val(importeTotal);
        $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
    });

    $(".modificarPrecioMenos").on("click", function () {
        var precio = $("#hdCuvPrecio2").val();
        var cantidad = parseInt($("#txtCantidad2").val());

        cantidad = cantidad == 1 ? 1 : cantidad - 1;

        var importeTotal = precio * cantidad;

        $("#hdImporteTotal2").val(importeTotal);
        $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
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
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
            return re.test(keyChar);
        }
    });

    var pedidoId = parseInt($("#txtPedidoID").val());
    if (pedidoId != 0) {
        CambioPaso(1);      //EPD-1309
        CambioPaso(3);
        DetalleCargar();
    }


    $('#alertEMailDialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');              
            }
        }
    });
});

function CUVCambio() {
    var cuvVal = $("#txtCUV").val();
    if (cuvVal == null) cuvVal = '';
    if (cuvVal.length > 5) {
        cuvVal = cuvVal.substr(0, 5);
        $("#txtCUV").val(cuvVal);
    }

    var cambio = (cuvVal != cuvPrevVal);
    cuvPrevVal = cuvVal;
    return cambio;
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

function EvaluarCUV() {
    if (!CUVCambio()) return false;

    $("#txtCantidad").attr("disabled", "disabled");
    $("#txtCantidad").attr("data-maxvalue", "0");
    $("#txtCUVDescripcion").val("");
    //$("#txtPedidoID").val("0");

    if (cuvPrevVal.length == 5) {
        //$("#txtCantidad").removeAttr("disabled");
        //$("#txtCUV").attr("disabled", "disabled");
        BuscarCUV(cuvPrevVal);
    }
}

function EvaluarCUV2() {
    if (!CUV2Cambio()) return false;

    var cuv = $("#txtCUV2").val();

    if (cuv2PrevVal.length == 5) BuscarCUVCambiar(cuv2PrevVal);
    else {
        $("#txtCUVDescripcion2").val("");
        $("#txtCUVPrecio2").val("");
        $("#hdImporteTotal2").val(0);
        $("#spnImporteTotal2").html("");
        $("#CambioProducto2").addClass("disabledClick");
    }
}

function alertEMail_msg(message, titulo) {
    titulo = titulo || "MENSAJE";
    $('#alertEMailDialogMensajes .terminos_title_2').html(titulo);
    $('#alertEMailDialogMensajes .pop_pedido_mensaje').html(message);
    $('#alertEMailDialogMensajes').dialog('open');
}

// Paso 1
function BuscarCUV(CUV) {
    CUV = $.trim(CUV) || $.trim($("#txtCUV").val());
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (CampaniaId <= 0 || CUV.length < 5) return false;

    var PedidoId = $.trim($("#txtPedidoID").val()) || 0;

    var item = {
        CampaniaID: CampaniaId,
        PedidoID: PedidoId,
        CDRWebID: $("#CDRWebID").val(),
        CUV: CUV
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
            data.detalle = data.detalle || new Array();

            if (data.detalle.length <= 0) {
                $("#divMotivo").html("");
                alert_msg("El Producto Ingresado no existe");
            } else {
                if (data.detalle.length > 1) PopupPedido(data.detalle);
                else AsignarCUV(data.detalle[0]);
            }            
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
        }
        }
    });
}

function BuscarCUVCambiar(cuv) {    
    cuv = $.trim(cuv) || $.trim($("#txtCUV2").val());
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (CampaniaId <= 0 || cuv.length < 5)
        return false;

    var PedidoId = $.trim($("#txtPedidoID").val()) || 0;

    var item = {
        CampaniaID: CampaniaId,
        PedidoID: PedidoId,
        CDRWebID: $("#CDRWebID").val(),
        CUV: cuv
    };

    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarCuvCambiar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data[0].MarcaID != 0) {
                $("#CambioProducto2").removeClass("disabledClick");
                var descripcion = data[0].Descripcion;
                var precio = data[0].PrecioCatalogo;
                
                $("#txtCUVDescripcion2").val(descripcion);
                $("#txtCUVPrecio2").val(DecimalToStringFormat(precio));
                $("#hdCuvPrecio2").val(precio);

                var cantidad = $("#txtCantidad2").val();
                $("#hdImporteTotal2").val(precio * cantidad);
                $("#spnImporteTotal2").html(DecimalToStringFormat(precio * cantidad));
            } else {
                $("#txtCUVDescripcion2").val("");
                $("#txtCUVPrecio2").val("");
                $("#hdImporteTotal2").val(0);
                $("#spnImporteTotal2").html("");
                alert_msg(data[0].CUV);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
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
    var objPedido = $(obj);//.parents("[data-pedido]");
    var id = objPedido.attr("data-pedido-id");
    var pedidos = listaPedidos.Find("PedidoID", id);
    pedido = pedidos.length > 0 ? pedidos[0] : new Object();
    $("#divPopupPedido").hide();
    AsignarCUV(pedido);
}

function AsignarCUV(pedido) {
    pedido = pedido || new Object();

    $("#divMotivo").html("");

    if (pedido.CDRWebID > 0 && pedido.CDRWebEstado != 1 && pedido.CDRWebEstado != 4) {
        alert_msg("Lo sentimos, ya cuentas con una solicitud web para este pedido. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
    } else {
        pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
        var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $("#txtCUV").val() || "");
        var data = detalle.length > 0 ? detalle[0] : new Object();
        $("#txtCantidad").removeAttr("disabled");
        $("#txtCantidad").attr("data-maxvalue", data.Cantidad);
        $("#txtCUVDescripcion").val(data.DescripcionProd);
        $("#txtPedidoID").val(data.PedidoID);
        $("#txtNumeroPedido").val(pedido.NumeroPedido);

        $("#txtPrecioUnidad").val(data.PrecioUnidad);
        $("#hdImporteTotalPedido").val(pedido.ImporteTotal);
        $("#CDRWebID").val(pedido.CDRWebID);

        BuscarMotivo();
        DetalleCargar();
    }
}

function BuscarMotivo() {

    var PedidoId = $.trim( $("#txtPedidoID").val()) || 0;
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (PedidoId <= 0 || CampaniaId <= 0)
        return false;

    waitingDialog();

    var item = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: PedidoId
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarMotivo',
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

            SetHandlebars("#template-motivo", data.detalle, "#divMotivo");
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
}

function ValidarPaso1() {
    var ok = true;
    ok = $("#ddlCampania").val() > 0 ? ok : false;
    ok = $.trim($("#txtPedidoID").val()) > 0 ? ok : false;
    ok = $.trim($("#txtCUV").val()) != "" ? ok : false;
    //ok = $.trim($("#txtCUVDescripcion").val()) != "" ? ok : false;
    //ok = $.trim($("#txtCantidad").val()) > 0 && $.trim($("#txtCantidad").val()) <= $.trim($("#txtCantidad").attr("data-maxvalue")) ? ok : false;                
    ok = $.trim($("#divMotivo [data-check='1']").attr("id")) != "" ? ok : false;

    if (!ok) {
        alert_msg("Datos incorrectos");
        return false;
    }

    if (!($.trim($("#txtCantidad").val()) > 0 && $.trim($("#txtCantidad").val()) <= $.trim($("#txtCantidad").attr("data-maxvalue")))) {
        alert_msg("Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
            $.trim($("#txtCantidad").attr("data-maxvalue")) + ")");
        return false;
    }

    waitingDialog();

    var item = {
        PedidoID: $("#txtPedidoID").val(),
        CUV: $.trim($("#txtCUV").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id")),
        CampaniaID: $("#ddlCampania").val()
    };
    
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ValidarPaso1',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
            ok = data.success;

            if (!data.success && data.message != "") {
                alert_msg(data.message);
            }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });

    return ok;
}
// FIN Paso 1

// Paso 2
function CargarOperacion() {
    var item = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: $("#txtPedidoID").val(),
        Motivo: $("#divMotivo [data-check='1']").attr("id")
    };

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarOperacion',
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
            SetHandlebars("#template-operacion", data.detalle, "#divOperacion");

        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
            }
        }
    });
}

function AnalizarOperacion(id) {
    //var tipo = $.trim($("#" + id).attr("data-tipo"));
    //if (tipo == "") 
    //    return false;
    
    //tipo = tipo.toLocaleLowerCase();

    codigoSsic = id;

    if (id == "C") {
        // ir al final del paso 2
        CambioPaso2(100);
        $("[data-tipo-confirma='cambio']").hide();
        $("[data-tipo-confirma=canje]").show();

        CargarPropuesta(id);
    }
    
    if (id == "D") {
        if (ValidarPaso2Devolucion(id)) {
            // ir al final del paso 2
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();

            CargarPropuesta(id);
        }        
    }

    if (id == "F") {
        if (ValidarPaso2Faltante(id)) {
            // ir al final del paso 2
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();

            CargarPropuesta(id);
        }        
    }

    if (id == "G") {
        if (ValidarPaso2FaltanteAbono(id)) {
            // ir al final del paso 2
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();

            CargarPropuesta(id);
        }       
    }

    if (id == "T") {
        CambioPaso2();
        $("[data-tipo-confirma='canje']").hide();
        $("[data-tipo-confirma=cambio]").show();

        $("#spnSimboloMonedaReclamo").html(vbSimbolo);

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
        ObtenerValorParametria(id);
        CargarPropuesta(id);
    }
}

function ObtenerValorParametria(codigoSsic) {
    var item = {
        EstadoSsic: codigoSsic
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarParametria',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            var parametria = data.detalle;
            var parametriaAbs = data.detalleAbs;

            $("#hdParametriaCdr").val(parametria.ValorParametria);
            $("#hdParametriaAbsCdr").val(parametriaAbs.ValorParametria);
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
            }
        }
    });
}

function ObtenerValorCDRWebDatos(codigoSsic) {
    var item = {
        EstadoSsic: codigoSsic
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarCdrWebDatos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            var cdrWebDatos = data.cdrWebdatos;

            $("#hdCdrWebDatos_Ssic").val(cdrWebDatos.Valor);
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
}

function CargarPropuesta(codigoSsic) {
    var tipo = (codigoSsic == "C" || codigoSsic == "D" || codigoSsic == "F" || codigoSsic == "G") ? "canje" : "cambio";

    var item = {
        CUV: $.trim($("#txtCUV").val()),
        DescripcionProd: $.trim($("#txtCUVDescripcion").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        //CUV2: $.trim($("#txtCUV2").val()),
        //DescripcionProd2: $.trim($("#txtCUVDescripcion2").val()),
        //Cantidad2: $.trim($("#txtCantidad2").val()),
        EstadoSsic: $.trim(codigoSsic),
        //EstadoSsic2: $.trim($("[data-tipo-confirma='" + tipo + "][data-detalle-confirma-tipo2]").val())
    };
    
    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarPropuesta',
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

            if (tipo == "canje")
                SetHandlebars("#template-confirmacion", data.detalle, "[data-tipo-confirma='" + tipo + "'] [data-detalle-confirma]");
            $("#spnMensajeTenerEnCuentaCanje").html(data.descripcionTenerEnCuenta);
            $("#spnMensajeTenerEnCuentaCambio").html(data.descripcionTenerEnCuenta);
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
}

function DetalleGuardar() {
    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
        NumeroPedido: $("#txtNumeroPedido").val() || 0,
        CampaniaID: $("#ddlCampania").val() || 0,
        Motivo: $(".reclamo_motivo_select[data-check='1']").attr("id"),
        Operacion: $(".btn_solución_reclamo[data-check='1']").attr("id"),
        CUV: $("#txtCUV").val(),
        Cantidad: $("#txtCantidad").val(),
        CUV2: $("#txtCUV2").val(),
        Cantidad2: $("#txtCantidad2").val()
        //Precio2: $("#txtCUVPrecio").val(),
    };

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleGuardar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                alert_msg(data.message);
                return false;
            }
            $("#CDRWebID").val(data.detalle);
            CambioPaso();
            DetalleCargar();
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
    
}

function CambioPaso2(paso) {
    paso2Actual = paso2Actual + (paso || 1);
    paso2Actual = paso2Actual < 1 ? 1 : paso2Actual > 3 ? 3 : paso2Actual;
    $('div[id^=Cambio]').hide();
    $('[id=Cambio' + paso2Actual + ']').show();
}

function ValidarPaso2Devolucion(codigoSsic) {    
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

    ObtenerValorParametria(codigoSsic);
    var valorParametria = $("#hdParametriaCdr").val() || 0;

    valorParametria = parseFloat(valorParametria);

    var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

    if (montoMaximoDevolver < montoDevolver) {
        alert_msg("Por favor, selecciona otra solución, ya que superas el porcentaje de devolución permitido en tu pedido facturado");
        return false;
    }

    return true;
}

function ValidarPaso2Faltante(codigoSsic) {
    var esCantidadPermitidaValida = ValidarCantidadMaximaPermitida(codigoSsic);

    if (esCantidadPermitidaValida) {
        /*Validacion de Porcentaje Maximo permitido*/
        var montoTotalPedido = $("#hdImporteTotalPedido").val();
        var montoProductosFaltanteActual = ObtenerMontoProductosDevolver(codigoSsic);
        var montoCuvActual = (parseFloat($("#txtPrecioUnidad").val()) || 0) * (parseInt($("#txtCantidad").val()) || 0);
        var montoDevolver = montoProductosFaltanteActual + montoCuvActual;

        ObtenerValorParametria(codigoSsic);
        var valorParametria = $("#hdParametriaCdr").val() || 0;

        valorParametria = parseFloat(valorParametria);

        var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

        if (montoMaximoDevolver < montoDevolver) {
            alert_msg("Por favor, selecciona otra solución, ya que superas el porcentaje de faltante permitido en tu pedido facturado");
            return false;
        }
        /*Fin Validacion de Porcentaje Maximo permitido*/

        return true;
    } else
        return false;
}

function ValidarPaso2FaltanteAbono(codigoSsic) {
    return ValidarCantidadMaximaPermitida(codigoSsic);
}

function ValidarPaso2Trueque() {
    if ($("#CambioProducto2").hasClass("disabledClick")) {
        return false;
    }

    var ok = true;
    ok = $.trim($("#txtCUV2").val()).length == "5" ? ok : false;
    ok = $.trim($("#txtCUVDescripcion2").val()) != "" ? ok : false;
    ok = $.trim($("#txtCUVPrecio2").val()) != "" ? ok : false;

    var montoMinimoReclamo = $("#hdMontoMinimoReclamo").val();
    var formatoMontoMinimo = $("#spnMontoMinimoReclamoFormato").html();
    var montoPedidoTrueque = $("#hdImporteTotal2").val();

    //ok = montoPedidoTrueque >= montoMinimoReclamo ? ok : false;
    //if (!ok) {
    //    alert_msg("El monto total del producto seleccionado debe ser mayor o igual a " + vbSimbolo + formatoMontoMinimo);
    //    return false;
    //}

    //------------------------------------------------------------
    waitingDialog();

    var item = {
        PedidoID: $("#txtPedidoID").val(),
        CUV: $.trim($("#txtCUV2").val()),
        Cantidad: $.trim($("#txtCantidad2").val()),
        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id")),
        CampaniaID: $("#ddlCampania").val()
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ValidarPaso1',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            ok = data.success;

            if (!data.success && data.message != "") {
                alert_msg(data.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
    //------------------------------------------------------------

    var valorParametria = $("#hdParametriaCdr").val();
    var valorParametriaAbs = $("#hdParametriaAbsCdr").val();

    var formatoMontoMaximo = DecimalToStringFormat(montoMinimoReclamo);

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

    return ok;
}

function ValidarCantidadMaximaPermitida(codigoSsic) {
    /*Validacion de cantidad maxima para faltante*/
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
    /*Fin Validacion de cantidad maxima para faltante*/

    return true;
}
// FIN Paso 2

// Paso 3
function DetalleCargar() {
    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0
    };

    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleCargar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        cache: false,
        success: function(data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                alert_msg(data.message);
                return false;
            }

            $("#spnCantidadUltimasSolicitadas").html(data.detalle.length);
            SetHandlebars("#template-detalle-banner", data.detalle, "#divDetalleUltimasSolicitudes");
            ValidarVisualizacionBannerResumen();            

            SetHandlebars("#template-detalle-paso3", data, "#divDetallePaso3");
            SetHandlebars("#template-detalle-paso3-enviada", data, "#divDetalleEnviar");
        },
        error: function(data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
}

function DetalleAccion(obj) {
    var accion = $.trim($(obj).attr("data-accion"));
    if (accion == "") {
        return false;
    }
       
    if (accion == "x") {// Eliminar
        var pedidodetalleid = $.trim($(obj).attr("data-pedidodetalleid"));

        var item = {
            CDRWebDetalleID: pedidodetalleid
        };


        var functionEliminar = function() {
            DetalleEliminar(item);
        };
        messageConfirmacion("", "Se eliminará el registro seleccionado. <br/>¿Deseas continuar?", functionEliminar);

        //DetalleEliminar(item);
        //var pedidoID = $("#txtPedidoID").val();
    }
}

function DetalleEliminar(objItem) {
    var item = {
        CDRWebDetalleID: objItem.CDRWebDetalleID
    };

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleEliminar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            //alert_msg(data.message);
            if (data.success == true) {
                DetalleCargar();
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
}

function SolicitudEnviar() {
    var ok = true;

    var correo = $.trim($("#txtEmail").val());
    var celular = $.trim($("#txtTelefono").val());

    if (correo == "" || celular == "") {
        alert_msg("Debe completar la sección de VALIDA TUS DATOS para finalizar");

        if (correo == "") {
            $("#spnEmailError").css("display", "");
            $("#spnEmailError").html("*Correo Electrónico incorrecto");
            $("#txtEmail").css("border-color", "red");
        }        

        if (celular == "") {
            $("#spnTelefonoError").css("display", "");
            $("#spnTelefonoError").html("*Celular incorrecto");
            $("#txtTelefono").css("border-color", "red");
        }

        return false;
    }
    else {
        $("#spnEmailError").css("display", "none");
        $("#txtEmail").css("border-color", "#b5b5b5");

        $("#spnTelefonoError").css("display", "none");
        $("#txtTelefono").css("border-color", "#b5b5b5");
    }

    if (!validateEmail(correo)) {
        $("#spnEmailError").css("display", "");
        $("#spnEmailError").html("*Correo Electrónico incorrecto");
        $("#txtEmail").css("border-color", "red");
        ok = false;
    }
    else {
        $("#spnEmailError").css("display", "none");
        $("#txtEmail").css("border-color", "#b5b5b5");
    }

    if (celular.length < 6) {
        $("#spnTelefonoError").css("display", "");
        $("#spnTelefonoError").html("*Celular incorrecto");
        $("#txtTelefono").css("border-color", "red");
        ok = false;
    }
    else {
        $("#spnTelefonoError").css("display", "none");
        $("#txtTelefono").css("border-color", "#b5b5b5");
    }

    if (ok) {
        var esTelefonoValido = ValidarTelefono(celular);
        if (!esTelefonoValido) {
            $("#spnTelefonoError").css("display", "");
            $("#spnTelefonoError").html("*Este teléfono ya está siendo utilizado. Intenta con otro");
            $("#txtTelefono").css("border-color", "red");
            ok = false;
        }
        else {
            $("#spnTelefonoError").css("display", "none");
            $("#txtTelefono").css("border-color", "#b5b5b5");
        }
    }

    if (!ok) return false;

    var correoActual = $.trim($("#hdEmail").val());
    if (correoActual != correo) {
        var esCorreoValido = ValidarCorreoDuplicado(correo);

        if (!esCorreoValido) {
            $("#spnEmailError").css("display", "");
            $("#spnEmailError").html("*Este correo ya está siendo utilizado. Intenta con otro");
            $("#txtEmail").css("border-color", "red");
            ok = false;
        }
        else {
            $("#spnTelefonoError").css("display", "none");
            $("#txtTelefono").css("border-color", "#b5b5b5");
        }
    }

    if (!ok) return false;

    ok = $("#btnAceptoPoliticas").hasClass("politica_reclamos_icono_active");
    if (!ok) {
        alert_msg("Debe aceptar la política de Cambios y Devoluciones");
        return false;
    }
    
    //ok = $.trim($("#txtEmail").val()) != "" ? ok : false;
    //if (!ok) {
    //    alert_msg("Debe ingresar un Email");
    //    return false;
    //}
    
    //ok = $.trim($("#txtTelefono").val()) != "" ? ok : false;
    //if (!ok) {
    //    alert_msg("Debe ingresar un Telefono");
    //    return false;
    //}

    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
        Email: $("#txtEmail").val(),
        Telefono: $("#txtTelefono").val(),
    };
    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/SolicitudEnviar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                alert_msg(data.message);
                return false;
            }
            
            var formatoFechaCulminado = "";
            var numeroSolicitud = 0;
            var formatoCampania = "";
            if (data.cdrWeb.CDRWebID > 0) {
                if (data.cdrWeb.FechaCulminado != 'null' || data.cdrWeb.FechaCulminado != "" || data.cdrWeb.FechaCulminado != undefined) {
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
                $("#divProcesoReclamo").hide();
                $("#divUltimasSolicitudes").hide();
                $("#TituloReclamo").hide();
            $("#SolicitudEnviada").show();

            if (data.Cantidad == 1) alertEMail_msg(data.message, "MENSAJE");
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });
}

// FIN Paso 3
function CambioPaso(paso) {
    paso = paso || 1;
    pasoActual = pasoActual + paso || 1;
    pasoActual = pasoActual < 1 ? 1 : pasoActual > 3 ? 3 : pasoActual;
    $(".paso_reclamo[data-paso] span").html("");
    $(".paso_reclamo[data-paso]").each(function (ind, tag) {
        var pasoTag = $(tag).attr("data-paso");
        if (pasoTag < pasoActual)
            $(tag).find("span").html("<img src='" + imgCheck + "' />");
        else {
            if (pasoTag == pasoActual) {
                $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoActual + "_activo") + "' />");
            } else {
                $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoTag) + "' />");
                if (paso < 0) {
                    $(".paso_reclamo[data-paso=" + pasoTag + "]").removeClass("paso_active_reclamo");
                }
            }
        }
    });
    $(".paso_reclamo[data-paso=" + pasoActual + "]").addClass("paso_active_reclamo");
    $('div[id^=Cambio]').hide();
    $('div[id^=Paso]').hide();
    $('[id=Paso' + pasoActual + ']').show();
    $('[id=Paso' + pasoActual + '] #Cambio' + paso2Actual).show();

    ValidarVisualizacionBannerResumen();
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
            if (checkTimeout(data)) { }
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
            if (checkTimeout(data)) { }
        }
    });

    return resultado;
}

function ValidarTelefono() {
    var resultado = false;

    var item = {
        Telefono: $("#txtTelefono").val()
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ValidadTelefonoConsultora',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
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
            if (checkTimeout(data)) { }
        }
    });

    return resultado;
}

function ValidarCorreoDuplicado(correo) {
    var resultado = false;

    var item = {
        correo: correo
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/ValidarCorreoDuplicado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
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
            if (checkTimeout(data)) { }
        }
    });

    return resultado;
}
