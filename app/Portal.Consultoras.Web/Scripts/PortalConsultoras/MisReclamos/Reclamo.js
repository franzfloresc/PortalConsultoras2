
var pasoActual = 1;
var paso2Actual = 1;
var listaPedidos = new Array();

$(document).ready(function () {

    $("#txtCUV").keyup(function (evt) {
        $("#txtCantidad").attr("disabled", "disabled");
        $("#txtCantidad").attr("data-maxvalue", "0")
        $("#txtCUVDescripcion").val("");
        $("#pedidoId").val("0");

        if ($(this).val().length == 5) {
            //$("#txtCantidad").removeAttr("disabled");
            //$("#txtCUV").attr("disabled", "disabled");
            BuscarCUV($(this).val());
        }
        else {
            PopupPedido();
        }
    });

    $(".reclamo_motivo_select").on("click", function () {
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

    $(".btn_solución_reclamo").on("click", function () {
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

    $("#IrPaso3").on("click", function () {
        DetalleGuardar();
    });

    $("[data-accion]").on("click", function () {
        DetalleAccion(this);
    });
    
});

// Paso 1
function BuscarCUV(CUV) {
    var item = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: $("txtPedidoID").val(),
        CUV: CUV
    };

    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/BuscarCUV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
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

function PopupPedido(pedidos) {
    $("#divPopupPedido").hide();
    pedidos = pedidos || new Array();
    SetHandlebars("#template-pedido", pedidos, "#divPedido");
    if (pedidos.length > 0) {
        $("#divPopupPedido").show();
    }
}

function PopupPedidoSeleccionar(obj) {
    var objPedido = $(obj);//.parents("[data-pedido]");
    var id = objPedido.attr("data-pedido-id");
    var pedidos = listaPedidos.Find("PedidoID", id);
    pedido = pedidos.length > 0 ? pedidos[0] : new Object();
    AsignarCUV(pedido);
}

function AsignarCUV(pedido) {
    pedido = pedido || new Object();
    pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
    var detalle = pedido.olstBEPedidoWebDetalle.Find("PedidoID", $("#txtCUV").val() || "");
    var data = detalle.length > 0 ? detalle[0] : new Object();
    $("#txtCantidad").removeAttr("disabled");
    $("#txtCantidad").attr("data-maxvalue", data.Cantidad);
    $("#txtCUVDescripcion").val(data.DescripcionProd);
    $("#pedidoId").val(data.PedidoDetalleID);

    BuscarMotivo();
}

function BuscarMotivo() {

    waitingDialog();

    var item = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: $("txtPedidoID").val()
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
    ok = $.trim($("#pedidoId").val()) > 0 ? ok : false;
    ok = $.trim($("#txtCUV").val()) != "" ? ok : false;
    ok = $.trim($("#txtCUVDescripcion").val()) != "" ? ok : false;
    ok = $.trim($("#txtCantidad").val()) > 0 && $.trim($("#txtCantidad").val()) < $.trim($("#txtCantidad").attr("data-maxvalue")) ? ok : false;
    ok = $.trim($("#divMotivo [data-check='1']").attr("id")) > 0 ? ok : false;
    if (!ok) {
        messageInfoError("Datos incorrectos");
        return false;
    }

    waitingDialog();

    var item = {
        PedidoID: $("txtPedidoID").val(),
        CUV: $.trim($("#txtCUV").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id"))
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
        PedidoID: $("txtPedidoID").val(),
        MotivoID: $("#divMotivo [data-check='1']").attr("id")
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
    var tipo = $.trim($("#" + id).attr("data-tipo"));
    if (tipo == "") 
        return false;
    
    tipo = tipo.toLocaleLowerCase();
    if (tipo == "canje") {
        // ir al final del paso 2
        CambioPaso2(100);
        $("[data-tipo-confirma^='']").hide();
        $("[data-tipo-confirma=" + tipo + "]").show();
    }
    
}

function DetalleGuardar() {
    var item = {
        CDRWebID: $("#$CDRWebID").val() || 0,
        MotivoID: $(".reclamo_motivo_select[data-check='1']").attr("id"),
        OperacionID: $(".btn_solución_reclamo[data-check='1']").attr("id"),
        CUV: $("#txtCUV").val(),
        Cantidad: $("#txtCantidad").val(),
        CUV2: $("#txtCUV2").val(),
        Cantidad2: $("#txtCantidad2").val(),
        Precio2: $("#txtCUVPrecio").val(),
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
            $("#$CDRWebID").val(data.detalle);
            CambioPaso();
            DetalleCargar();
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
function DetalleCargar() {
    var item = {
        CDRWebID: $("#$CDRWebID").val() || 0
    };
    waitingDialog();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisReclamos/DetalleCargar',
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
                SetHandlebars("#template-detalle-paso3", data.detalle, "#divMotivo");
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
                DetalleCargar
            }
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
    $(".paso_reclamo[data-paso]").each(function (ind, tag) { if ($(tag).attr("data-paso") < pasoActual) $(tag).find("span").html("<img src='" + imgCheck + "' />"); });
    $(".paso_reclamo[data-paso=" + pasoActual + "]").addClass("paso_active_reclamo");
    $('div[id^=Cambio]').hide();
    $('div[id^=Paso]').hide();
    $('[id=Paso' + pasoActual + ']').show();
    $('[id=Paso' + pasoActual + '] #Cambio' + paso2Actual).show();
}
