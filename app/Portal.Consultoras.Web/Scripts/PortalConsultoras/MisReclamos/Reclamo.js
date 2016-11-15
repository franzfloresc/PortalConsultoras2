
var pasoActual = 1;
var paso2Actual = 1;
var listaPedidos = new Array();
var codigoSsic = "";

$(document).ready(function () {

    $("#ddlCampania").on("change", function () {
        $("#txtPedidoID").val(0);
        BuscarCUV();
    });

    $("#txtCUV").keyup(function (evt) {
        $("#txtCantidad").attr("disabled", "disabled");
        $("#txtCantidad").attr("data-maxvalue", "0")
        $("#txtCUVDescripcion").val("");
        //$("#txtPedidoID").val("0");

        if ($(this).val().length == 5) {
            //$("#txtCantidad").removeAttr("disabled");
            //$("#txtCUV").attr("disabled", "disabled");
            BuscarCUV($(this).val());
        }
    });

    $("#txtCUV2").keyup(function (evt) {        
        if ($(this).val().length == 5) {
            BuscarCUVCambiar($(this).val());
        }
    });

    $('#divMotivo').on("click", ".reclamo_motivo_select", function () {
        $(".reclamo_motivo_select").removeClass("reclamo_motivo_select_click");
        $(".reclamo_motivo_select").attr("data-check", "0");
        $(this).addClass("reclamo_motivo_select_click");
        $(this).attr("data-check", "1");
    });

    $("#IrPAso2").on("click", function () {
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

    $("#RegresarPaso1").on("click", function () {       
        CambioPaso(-1);
    });

    $("#RegresarCambio1").on("click", function () {
        CambioPaso(-1);
    });

    $("#RegresarCanje1").on("click", function () {
        CambioPaso(-1);
    });

    $("#CambioProducto2").on("click", function () {
        CambioPaso2(1);

        $("#spnCuv1").html($("#txtCUV").val());
        $("#spnDescripcionCuv1").html($("#txtCUVDescripcion").val());
        $("#spnCantidadCuv1").html($("#txtCantidad").val());

        $("#spnCuv2").html($("#txtCUV2").val());
        $("#spnDescripcionCuv2").html($("#txtCUVDescripcion2").val());
        $("#spnCantidadCuv2").html($("#txtCantidad2").val());
    });

    $("#RegresarPaso2").on("click", function () {
        CambioPaso(-1);
    });

    $("[data-cambiopaso]").on("click", function () {
        DetalleGuardar();
    });

    $("#IrSolicitudInicial").on("click", function () {
        $("#txtCUV").val("");
        $("#txtCUVDescripcion").val("");
        $("#txtCantidad").val("1");
        $("#txtCUV2").val("");
        $("#txtCUVDescripcion2").val("");
        $("#txtCantidad2").val("1");
        CambioPaso(-100);
        BuscarMotivo();
    });

    $("#IrSolicitudEnviada").on("click", function () {        
        SolicitudEnviar();
    });

    $("[data-accion]").on("click", function () {
        DetalleAccion(this);
    });

    $("#btnAceptoPoliticas").on("click", function() {
        if ($(this).hasClass("politica_reclamos_active")) {
            $(this).removeClass("politica_reclamos_active");
        } else {
            $(this).addClass("politica_reclamos_active");
        }
    });

    $(".modificarPrecioMas").on("click", function () {
        var precio = $("#hdCuvPrecio2").val();
        var cantidad = parseInt($("#txtCantidad2").val());

        cantidad = cantidad == 99 ? 99 : cantidad + 1;

        var importeTotal = precio * cantidad;

        $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
    });

    $(".modificarPrecioMenos").on("click", function () {
        var precio = $("#hdCuvPrecio2").val();
        var cantidad = parseInt($("#txtCantidad2").val());

        cantidad = cantidad == 1 ? 1 : cantidad - 1;

        var importeTotal = precio * cantidad;

        $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
    });
});

// Paso 1
function BuscarCUV(CUV) {
    CUV = $.trim(CUV) || $.trim($("#txtCUV").val());
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (CampaniaId <= 0 || CUV.length < 5)
        return false;

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
                messageInfoError(data.message);
                return false;
            }
            data.detalle = data.detalle || new Array();
            if (data.detalle.length > 1) {
                PopupPedido(data.detalle);
            }
            else {
                AsignarCUV(data.detalle[0]);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
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
                var descripcion = data[0].Descripcion;
                var precio = data[0].PrecioCatalogo;
                
                $("#txtCUVDescripcion2").val(descripcion);
                $("#txtCUVPrecio2").val(DecimalToStringFormat(precio));
                $("#hdCuvPrecio2").val(precio);

                var cantidad = $("#txtCantidad2").val();
                $("#spnImporteTotal2").html(DecimalToStringFormat(precio * cantidad));
            } else {
                messageInfoError(data.CUV);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
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
    pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
    var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $("#txtCUV").val() || "");
    var data = detalle.length > 0 ? detalle[0] : new Object();
    $("#txtCantidad").removeAttr("disabled");
    $("#txtCantidad").attr("data-maxvalue", data.Cantidad);
    $("#txtCUVDescripcion").val(data.DescripcionProd);
    $("#txtPedidoID").val(data.PedidoID);
    $("#txtImporteTotal").val(data.ImporteTotal);

    BuscarMotivo();
    DetalleCargar(true);
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
                messageInfoError(data.message);
                return false;
            }

            SetHandlebars("#template-motivo", data.detalle, "#divMotivo");
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function ValidarPaso1() {
    var ok = true;
    ok = $("#ddlCampania").val() > 0 ? ok : false;
    ok = $.trim($("#txtPedidoID").val()) > 0 ? ok : false;
    ok = $.trim($("#txtCUV").val()) != "" ? ok : false;
    //ok = $.trim($("#txtCUVDescripcion").val()) != "" ? ok : false;
    ok = $.trim($("#txtCantidad").val()) > 0 && $.trim($("#txtCantidad").val()) <= $.trim($("#txtCantidad").attr("data-maxvalue")) ? ok : false;
    ok = $.trim($("#divMotivo [data-check='1']").attr("id")) != "" ? ok : false;
    if (!ok) {
        messageInfoError("Datos incorrectos");
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
            ok = data.success;
        },
        error: function (data, error) {
            closeWaitingDialog();
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
                messageInfoError(data.message);
                return false;
            }
            SetHandlebars("#template-operacion", data.detalle, "#divOperacion");

        },
        error: function (data, error) {
            closeWaitingDialog();
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
        // ir al final del paso 2
        CambioPaso2(100);
        $("[data-tipo-confirma='cambio']").hide();
        $("[data-tipo-confirma=canje]").show();

        CargarPropuesta(id);
    }

    if (id == "F") {
        // ir al final del paso 2
        CambioPaso2(100);
        $("[data-tipo-confirma='cambio']").hide();
        $("[data-tipo-confirma=canje]").show();

        CargarPropuesta(id);
    }

    if (id == "G") {
        // ir al final del paso 2
        CambioPaso2(100);
        $("[data-tipo-confirma='cambio']").hide();
        $("[data-tipo-confirma=canje]").show();

        CargarPropuesta(id);
    }

    if (id == "T") {
        CambioPaso2();
        $("[data-tipo-confirma='canje']").hide();
        $("[data-tipo-confirma=cambio]").show();

        $("#spnSimboloMonedaReclamo").html(vbSimbolo);
        $("#spnMontoMaximoReclamo").html($("#txtImporteTotal").val());
        var campania = $("#ddlCampania").val() || 0;
        var numeroCampania = '00';
        if (campania > 0) {
            numeroCampania = campania.substring(4);
        }

        $("#spnNumeroCampaniaReclamo").html(numeroCampania);
        CargarPropuesta(id);
    }
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
                messageInfoError(data.message);
                return false;
            }

            if (tipo == "canje")
                SetHandlebars("#template-confirmacion", data.detalle, "[data-tipo-confirma='" + tipo + "'] [data-detalle-confirma]");
            $("#spnMensajeTenerEnCuentaCanje").html(data.descripcionTenerEnCuenta);
            $("#spnMensajeTenerEnCuentaCambio").html(data.descripcionTenerEnCuenta);
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function DetalleGuardar() {
    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
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
                messageInfoError(data.message);
                return false;
            }
            $("#CDRWebID").val(data.detalle);
            CambioPaso();
            DetalleCargar(false);
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
    
}

function CambioPaso2(paso) {
    paso2Actual = paso2Actual + (paso || 1);
    paso2Actual = paso2Actual < 1 ? 1 : paso2Actual > 3 ? 3 : paso2Actual;
    $('div[id^=Cambio]').hide();
    $('[id=Cambio' + paso2Actual + ']').show();
}
// FIN Paso 2

// Paso 3

function DetalleCargar(mostrarBanner) {
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
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }            

            if (mostrarBanner) {
                $("#spnCantidadUltimasSolicitadas").html(data.detalle.length);
                SetHandlebars("#template-detalle-banner", data.detalle, "#divDetalleUltimasSolicitudes");
                $("#divUltimasSolicitudes").show();
            } else {
                SetHandlebars("#template-detalle-paso3", data.detalle, "#divDetallePaso3");
                SetHandlebars("#template-detalle-paso3-enviada", data.detalle, "#divDetalleEnviar");
            }            
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function DetalleAccion(obj) {
    var accion = $.trim($(obj).attr("data-accion"));
    if (accion == "") {
        return false;
    }
    var objItem = $(obj).parents("data-item");
    if (accion == "x") {// Eliminar
        DetalleEliminar(objItem);
    }
}

function DetalleEliminar(objItem) {
    var item = {
        CDRWebDetalleID: objItem.find("item[name='id']").val()
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

            messageInfoError(data.message);
            if (data.success == true) {
                DetalleCargar(false);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function SolicitudEnviar() {
    var ok = true;
    ok = $("#btnAceptoPoliticas").hasClass("politica_reclamos_active");
    if (!ok) {
        messageInfoError("Debe Aceptar la politica de Cambios y Devoluciones");
        return false;
    }
    
    ok = $.trim($("#txtEmail").val()) != "" ? ok : false;
    if (!ok) {
        messageInfoError("Debe ingresar un Email");
        return false;
    }
    
    ok = $.trim($("#txtTelefono").val()) != "" ? ok : false;
    if (!ok) {
        messageInfoError("Debe ingresar un Telefono");
        return false;
    }

    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0,
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
                messageInfoError(data.message);
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
            $("#SolicitudEnviada").show();
        },
        error: function (data, error) {
            closeWaitingDialog();
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
}
