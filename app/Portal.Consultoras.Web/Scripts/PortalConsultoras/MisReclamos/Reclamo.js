﻿
var cuvKeyUp = false, cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';
var pasoActual = 1;
var paso2Actual = 1;
var listaPedidos = new Array();
var codigoSsic = "";
var tipoDespacho = false;

var dataCdrServicio = {};

$(document).ready(function () {

    //$('.chosen-select').chosen();
    //$('.chosen-select-deselect').chosen({ allow_single_deselect: true });

    //$('.chosen-search-input').attr('placeholder', 'Buscar código o descripción');

    $("#ddlCampania").on("change", function () {
        $("#txtCantidad").val("1");
        $("#divMotivo").html("");
        $('#ResultadosBusquedaCUV').empty(); //HD-7303 EINCA
        $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
        $('#ddlCuv').val('');
        if ($(this).val() == "0") {
            $("#ddlnumPedido").html("");
            $("#ddlnumPedido").hide();
            $("#ddlCuv").html("");
            $('.chosen-select').chosen();
            $(".chosen-select").val('').trigger("chosen:updated");
            $('#ddlCuv').addClass('btn_deshabilitado');
            $('#RangoCantidad').addClass('btn_deshabilitado');
            return false;
        } else {
            $('#ddlCuv').removeClass('btn_deshabilitado');
            $('#RangoCantidad').removeClass('btn_deshabilitado');
        }
        $("#txtPedidoID").val(0);
        $("#txtNumeroPedido").val(0);
        ListarPedidoID();
    });

    $("#ddlnumPedido").on("change", function () {
        $("#divMotivo").html("");
        $("#txtCantidad").val("1");
        if ($("#ddlnumPedido").val() == 0) {
            $("#ddlCuv").html("");
            $('.chosen-select').chosen();
            $(".chosen-select").val('').trigger("chosen:updated");
            return false;
        }
        $("#txtPedidoID").val($.trim($("#ddlnumPedido").val()));
        BuscarCUV();
    });

    $("#ddlCuv").on("change", function () {
        cuvKeyUp = true;
        ObtenerDatosCuv();
    });

    $("#txtCUV2").on('keyup', function (evt) {
        cuv2KeyUp = true;
        EvaluarCUV2();
    });

    setInterval(function () {
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
        if (ValidarPasoUno()) {
            //HD-3412 EINCA
            //validar lado del server
            ValidarPasoUnoServer(function (result, msg, data) {
                if (!result) {
                    alert_msg(msg);
                } else {
                    //Seteamos la data de la respuesta del servicio de cdr
                    var ProductoSeleccionado = {
                        CUV: $("#hdfCUV").val(),
                        Descripcion: $("#hdtxtCUVDescripcion").val()
                    };

                    dataCdrServicio.ProductoSeleccionado = ProductoSeleccionado;
                    dataCdrServicio.DataRespuestaServicio = data[0].LProductosComplementos;

                    paso2Actual = 1;
                    $.when(CambioPaso()).then(function () {
                        CargarOperacion();
                    });
                }
            });
        }
    });

    $('#divOperacion').on("click", ".btn_solucion_reclamo", function () {
        $(".btn_solucion_reclamo").attr("data-check", "0");
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

    // HD-3703

    $(document).on("click", function (e) {
        var listaResultadosBusquedaPorCuv = $(".contenedor_descripcion_reclamo");
        if ((!listaResultadosBusquedaPorCuv.is(e.target) && listaResultadosBusquedaPorCuv.has(e.target).length === 0)) {
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
            $("#ResultadosBusquedaCUV").fadeIn(100);
        }
    });


    $("#ddlCuv").on("click", function () {
        if ($("#ddlCampania").val() != 0) {
            $("#ResultadosBusquedaCUV").fadeIn(100);
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeIn(100);
        }
    });

    $("#ddlCuv").on("keyup", function () {
        if ($(this).val().length === 0) {
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
            $("#ResultadosBusquedaCUV").fadeOut(100);
        } else {
            $("#ResultadosBusquedaCUV").fadeIn(100);
            $(".lista_resultados_busqueda_por_cuv_wrapper").fadeIn(100);
            var cuvIngresado = $('#ddlCuv').val();
            $("#ResultadosBusquedaCUV li").filter(function () {
                $(this).toggle($(this).attr("data-value-cuv").indexOf(cuvIngresado) > -1);
            });
        }
    });

    $('#ddlCuv').focusout(function () {
        $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);
    });

    $("#ResultadosBusquedaCUV").on("click", ".resultado_busqueda_por_cuv_enlace", function (e) {
        e.preventDefault();
        var codigoProdCdr = $(this).find(".resultado_busqueda_por_cuv_codigo_prod").html();
        $('#hdfCUV').val(codigoProdCdr);//HD-3703 EINCA
        var descripProdCdr = $(this).find(".resultado_busqueda_por_cuv_descrip_prod").html();
        $("#ddlCuv").val(codigoProdCdr + ' - ' + descripProdCdr);
        $(".lista_resultados_busqueda_por_cuv_wrapper").fadeOut(100);        
        $(this).fadeOut(100);
        ObtenerDatosCuv();
    });

    // FIN - HD-3703

    $("#CambioProducto2").on("click", function () {
        //HD-3412 EINCA
        if (ValidarPasoDosTrueque()) {
            ValidarPasoDosTruequeServer(function (result, msg) {
                if (!result) {
                    alert_msg(msg);
                    return false;
                } else {
                    CambioPaso2(1);
                    $("#spnCuv1").html($.trim($("#ddlCuv").val()));
                    $("#spnDescripcionCuv1").html($("#hdtxtCUVDescripcion").val());
                    $("#spnCantidadCuv1").html($("#txtCantidad").val());

                    $("#spnCuv2").html($("#txtCUV2").val());
                    $("#spnDescripcionCuv2").html($("#txtCUVDescripcion2").val());
                    $("#spnCantidadCuv2").html($("#txtCantidad2").val());
                }
            });


        }
    });

    $("[data-cambiopaso]").on("click", function () {
        DetalleGuardar();
    });

    $("#IrSolicitudInicial").on("click", function () {
        if (mensajeGestionCdrInhabilitada != '') {
            alert_msg(mensajeGestionCdrInhabilitada);
            return false;
        }

        //El if se hizo con !() para colnsiderar posibles valores null o undefined de $('#ddCampania').val()
        if (!($('#ddlCampania').val() > 0)) {
            alert_msg(mensajeCdrFueraDeFechaCompleto);
            return false;
        }

        $('.chosen-select').chosen();
        $(".chosen-select").val('').trigger("chosen:updated");

        $("#hdtxtCUVDescripcion").val("");
        $("#txtCantidad").val("1");
        $("#divMotivo").html('');
        $("#txtCUV2").val("");
        $("#txtCUVPrecio2").val("");
        $("#spnImporteTotal2").html("");
        $("#hdImporteTotal2").val(0);
        $("#txtCUVDescripcion2").val("");
        $("#txtCantidad2").val("1");
        CambioPaso(-100);
        $('#ddlnumPedido').append($('<option></option>').val($("#txtPedidoID").val()).html("N° " + $("#txtNumeroPedido").val()));
        $("#ddlnumPedido").show();
        $("#ddlnumPedido").attr("disabled", "disabled");
        BuscarCUV();
        $("#divUltimasSolicitudes").show();
        $("#ddlCampania").attr("disabled", "disabled");
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
            $('#txtCantidadPedidoConfig').text(CantidadReclamosPorPedidoConfig);
            $('#divConfirmEnviarSolicitudCDR').show();
        }
    });

    $(document).on('click', '[data-accion]', function () {
        DetalleAccion(this);
    });

    $("#btnAceptoPoliticas").on("click", function () {
        if ($(this).hasClass("politica_reclamos_icono_active")) {
            $(this).removeClass("politica_reclamos_icono_active");
        } else {
            $(this).addClass("politica_reclamos_icono_active");
        }
    });



    //$(".modificarPrecioMas").on("click", function () {
    //    var precio = $("#hdCuvPrecio2").val();
    //    var cantidad = parseInt($("#txtCantidad2").val());

    //    cantidad = cantidad == 99 ? 99 : cantidad; //+ 1;

    //    var importeTotal = precio * cantidad;

    //    $("#hdImporteTotal2").val(importeTotal);
    //    $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
    //});

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

    //HD-3703 EINCA
    //$(".modificarPrecioMenos").on("click", function () {
    //    var precio = $("#hdCuvPrecio2").val();
    //    var cantidad = parseInt($("#txtCantidad2").val());

    //    cantidad = cantidad == 1 ? 1 : cantidad; //- 1;

    //    var importeTotal = precio * cantidad;

    //    $("#hdImporteTotal2").val(importeTotal);
    //    $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
    //});

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

    var pedidoId = parseInt($("#txtPedidoID").val());
    if (pedidoId != 0) {
        CambioPaso(1);
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
        buttons: {
            "Aceptar": function () {
                HideDialog("alertEMailDialogMensajes");
            }
        }
    });
});


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

function EvaluarCUV2() {

    if (!CUV2Cambio()) return false;

    if (cuv2PrevVal.length == 5) BuscarCUVCambiar(cuv2PrevVal);
    else {
        $("#txtCUVDescripcion2").val("");
        $("#txtCUVPrecio2").val("");
        $("#hdImporteTotal2").val(0);
        $("#spnImporteTotal2").html("");
        $("#CambioProducto2").addClass("disabledClick");
        $("#MontoTotalProductoACambiar").fadeOut(100);
    }
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
    $("#hdtxtCUVDescripcion").val("");
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
        CDRWebID: $("#CDRWebID").val()
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
                $("#ddlCuv").html("");
                $("#ResultadosBusquedaCUV").empty();


                //$('.descripcion_reclamo_fake_placeholder').hide();
                //$('#ddlCuv').append($('<option></option>').val("").html(""));
                $(data.detalle).each(function (index, item) {
                    //$('#ddlCuv').append($('<option></option>').val(item.CUV).html(item.CUV + " - " + item.DescripcionProd));
                    $('#ResultadosBusquedaCUV').append('<li class="resultado_busqueda_por_cuv" data-value-cuv="' + item.CUV + '"><a class="resultado_busqueda_por_cuv_enlace" title="' + item.DescripcionProd + '"><div class="resultado_busqueda_por_cuv_datos_imagen"><img src="https://cdn1-prd.somosbelcorp.com/Matriz/PE/PE_201905_30709.jpg" alt="' + item.DescripcionProd + '" /></div><div class="resultado_busqueda_por_cuv_datos_prod">' + '<div class="resultado_busqueda_por_cuv_codigo_prod">' + item.CUV + '</div>' + '<div class="resultado_busqueda_por_cuv_descrip_prod">' + item.DescripcionProd + '</div>' + '</div></a></li>');
                });
                //$('.chosen-select').chosen();
                //$(".chosen-select").val('').trigger("chosen:updated");
                //$('.chosen-select-deselect').chosen({ allow_single_deselect: true });
                //$('.chosen-search-input').attr('placeholder', 'Ingresa el código');

                // FIN - HD-3703
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            checkTimeout(data);
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
                $("#MontoTotalProductoACambiar").fadeIn(100);
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
    var objPedido = $(obj);
    var id = objPedido.attr("data-pedido-id");
    var pedidos = listaPedidos.Find("PedidoID", id);
    pedido = pedidos.length > 0 ? pedidos[0] : new Object();
    $("#divPopupPedido").hide();
    alert('PopupPedidoSeleccionar(obj)');
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
    var CDRWebID = 0;
    $.each(pedido.BECDRWeb, function (i, item) {
        if (item.Estado === 3 || item.Estado === 2) {
            EstadosConteo++;
        }
        //obtener el cdr en estado pendiente
        if (item.Estado === 1) { CDRWebID = item.CDRWebID; }

    });
    //Nueva solicitud de reclamo
    var cantidad = CantidadReclamosPorPedidoConfig != null && CantidadReclamosPorPedidoConfig != '' ? parseInt(CantidadReclamosPorPedidoConfig) : 0;
    if (cantidad === EstadosConteo && EstadosConteo > 0) {
        alert_msg("Lo sentimos, usted ha excedido el límite de reclamos por pedido");
    } else {
        pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
        var cuvSeleccionado = $.trim($('#hdfCUV').val());
        //var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $.trim($("#ddlCuv").val()) || "");
        var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", cuvSeleccionado || "");
        var data = detalle.length > 0 ? detalle[0] : new Object();
        $("#txtCantidad").removeAttr("disabled");
        $("#txtCantidad").attr("data-maxvalue", data.Cantidad);
        $("#hdtxtCUVDescripcion").val(data.DescripcionProd);
        $("#txtPedidoID").val(data.PedidoID);
        $("#txtNumeroPedido").val(pedido.NumeroPedido);
        $("#txtPrecioUnidad").val(data.PrecioUnidad);
        $("#hdImporteTotalPedido").val(pedido.ImporteTotal);
        //$("#CDRWebID").val(pedido.CDRWebID); //HD-3412 EINCA
        $("#CDRWebID").val(CDRWebID); //HD-3412 EINCA
        $.when(BuscarMotivo()).then(function () {
            DetalleCargar();
        });

    }
}

function BuscarMotivo() {
    var PedidoId = $.trim($("#txtPedidoID").val()) || 0;
    var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
    if (PedidoId <= 0 || CampaniaId <= 0)
        return false;

    $.ajaxSetup({
        global: false,
        type: "POST",
        url: baseUrl + 'MisReclamos/BuscarMotivo',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        beforeSend: function () {
            waitingDialog();
        },
        complete: function () {
            closeWaitingDialog();
        }
    });
    var item = {
        CampaniaID: $.trim($("#ddlCampania").val()),
        PedidoID: PedidoId
    };

    $.ajax({
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
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
        }
    });
}

//function ValidarPaso1() {
//    var ok = true;
//    ok = $("#ddlCampania").val() > 0 ? ok : false;
//    ok = $.trim($("#txtPedidoID").val()) > 0 ? ok : false;
//    ok = $.trim($("#ddlCuv").val()) /*$.trim($("#txtCUV").val())*/ != "" ? ok : false;

//    ok = $.trim($("#divMotivo [data-check='1']").attr("id")) != "" ? ok : false;

//    if (!ok) {
//        alert_msg("Datos incorrectos");
//        return false;
//    }

//    if (!(parseInt($("#txtCantidad").val()) > 0 && parseInt($("#txtCantidad").val()) <= parseInt($("#txtCantidad").attr("data-maxvalue")))) {
//        alert_msg("Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
//            $.trim($("#txtCantidad").attr("data-maxvalue")) + ")");
//        return false;
//    }

//    waitingDialog();

//    var item = {
//        PedidoID: $("#txtPedidoID").val(),
//        CUV: $.trim($("#ddlCuv").val()),//$.trim($("#txtCUV").val()),
//        Cantidad: $.trim($("#txtCantidad").val()),
//        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id")),
//        CampaniaID: $("#ddlCampania").val()
//    };

//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'MisReclamos/ValidarPaso1',
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(item),
//        async: true,
//        cache: false,
//        success: function (data) {
//            closeWaitingDialog();
//            if (checkTimeout(data)) {
//                ok = data.success;
//                if (!data.success && data.message != "") {
//                    alert_msg(data.message);
//                }
//            }
//        },
//        error: function (data, error) {
//            closeWaitingDialog();
//        }
//    });

//    return ok;
//}

//HD-3412 EINCA
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


    if ($("#ddlCuv").val() == "") {
        alert_msg("por favor, seleccionar un CUV.");
        $(this).focus();
        return false;
    }

    if ($("#divMotivo [data-check='1']").attr("id") == "0" || $("#divMotivo [data-check='1']").attr("id") == undefined || $("#divMotivo [data-check='1']").attr("id") == "undefined") {
        alert_msg("por favor, seleccione el motivo del cambio.");
        return false;
    }

    //ok = $("#ddlCampania").val() > 0 ? ok : false;
    //ok = $.trim($("#txtPedidoID").val()) > 0 ? ok : false;
    //ok = $.trim($("#ddlCuv").val()) /*$.trim($("#txtCUV").val())*/ != "" ? ok : false;

    //ok = $.trim($("#divMotivo [data-check='1']").attr("id")) != "" ? ok : false;

    //if (!ok) {
    //    alert_msg("Datos incorrectos");
    //    return false;
    //}

    if (!(parseInt($("#txtCantidad").val()) > 0 && parseInt($("#txtCantidad").val()) <= parseInt($("#txtCantidad").attr("data-maxvalue")))) {
        alert_msg("Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
            $.trim($("#txtCantidad").attr("data-maxvalue")) + ")");
        $("#txtCantidad").focus();
        return false;
    }
    return true;
}

//HD-3412 EINCA
function ValidarPasoUnoServer(callbackWhenFinish) {

    $.ajaxSetup({
        global: false,
        type: "POST",
        url: baseUrl + 'MisReclamos/ValidarPaso1',
        beforeSend: function () {
            waitingDialog();
        },
        complete: function () {
            closeWaitingDialog();
        }
    });
    var item = {
        PedidoID: $("#txtPedidoID").val(),
        CUV: $.trim($('#hdfCUV').val()),// $.trim($("#ddlCuv").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id")),
        CampaniaID: $("#ddlCampania").val()
    };

    jQuery.ajax({
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (d) {
            if (checkTimeout(d)) {
                if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                    callbackWhenFinish(d.success, d.message, d.data);
                }
            }
        },
        error: function (d, error) {
            closeWaitingDialog();
        }
    });
}


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
        }
    });
}

//HD-3703 EINCA
function AnalizarOperacionV2(id) {
    //deshabilitar Escoge una elección
    $('#Cambio1').hide();

    codigoSsic = id;
    if (id == "C") {
        CambioPaso2(100);
        $("[data-tipo-confirma='cambio']").hide();
        $("[data-tipo-confirma=canje]").show();
        CargarPropuesta(id);
    }

    if (id == "D") {
        if (ValidarPaso2Devolucion(id)) {
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();
            CargarPropuesta(id);
        }
    }

    if (id == "F") {
        if (ValidarPaso2Faltante(id)) {
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();
            CargarPropuesta(id);
        }
    }

    if (id == "G") {
        if (ValidarPaso2FaltanteAbono(id)) {
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();
            CargarPropuesta(id);
        }
    }
    if (id == "T") {
        if (ValidarPasoDosTrueque()) {
            $("#spnCuv1").html($.trim($("#ddlCuv").val()));
            $("#spnDescripcionCuv1").html($("#hdtxtCUVDescripcion").val());
            $("#spnCantidadCuv1").html($("#txtCantidad").val());

            $("#spnCuv2").html($("#txtCUV2").val());
            $("#spnDescripcionCuv2").html($("#txtCUVDescripcion2").val());
            $("#spnCantidadCuv2").html($("#txtCantidad2").val());
            $("#Cambio3").show().find("[data-tipo-confirma='cambio']").show();
        }



    }
}

function AnalizarOperacion(id) {
    codigoSsic = id;

    if (id == "C") {
        CambioPaso2(100);
        $("[data-tipo-confirma='cambio']").hide();
        $("[data-tipo-confirma=canje]").show();

        CargarPropuesta(id);
    }

    if (id == "D") {
        if (ValidarPaso2Devolucion(id)) {
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();

            CargarPropuesta(id);
        }
    }

    if (id == "F") {
        if (ValidarPaso2Faltante(id)) {
            CambioPaso2(100);
            $("[data-tipo-confirma='cambio']").hide();
            $("[data-tipo-confirma=canje]").show();

            CargarPropuesta(id);
        }
    }

    if (id == "G") {
        if (ValidarPaso2FaltanteAbono(id)) {
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
        }
    });
}

function CargarPropuesta(codigoSsic) {
    var tipo = (codigoSsic == "C" || codigoSsic == "D" || codigoSsic == "F" || codigoSsic == "G") ? "canje" : "cambio";

    var item = {
        CUV: $.trim($("#hdfCUV").val()),// $.trim($("#ddlCuv").val()),//$.trim($("#txtCuv").text()),
        DescripcionProd: $.trim($("#hdtxtCUVDescripcion").val()),
        Cantidad: $.trim($("#txtCantidad").val()),
        EstadoSsic: $.trim(codigoSsic)
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
        Operacion: $(".btn_solucion_reclamo[data-check='1']").attr("id"),
        CUV: $.trim($("#hdfCUV").val()),//$.trim($("#ddlCuv").val()),//$("#txtCUV").val(),
        Cantidad: $("#txtCantidad").val(),
        CUV2: $("#txtCUV2").val(),
        Cantidad2: $("#txtCantidad2").val()
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
        }
    });

}

function CambioPaso2(paso) {
    paso2Actual = paso2Actual + (paso || 1);
    paso2Actual = paso2Actual < 1 ? 1 : paso2Actual > 3 ? 3 : paso2Actual;
    //$('div[id^=Cambio]').hide();
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

        return true;
    } else
        return false;
}

function ValidarPaso2FaltanteAbono(codigoSsic) {
    return ValidarCantidadMaximaPermitida(codigoSsic);
}

function ValidarPasoDosTrueque() {
    if ($("#CambioProducto2").hasClass("disabledClick")) {
        return false;
    }

    var ok = true;
    ok = $.trim($("#txtCUV2").val()).length == "5" ? ok : false;
    ok = $.trim($("#txtCUVDescripcion2").val()) != "" ? ok : false;
    ok = $.trim($("#txtCUVPrecio2").val()) != "" ? ok : false;

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

    return ok;
}

function ValidarPasoDosTruequeServer(callbackWhenFinish) {
    var item = {
        PedidoID: $("#txtPedidoID").val(),
        CUV: $.trim($("#txtCUV2").val()),
        Cantidad: $.trim($("#txtCantidad2").val()),
        Motivo: $.trim($("#divMotivo [data-check='1']").attr("id")),
        CampaniaID: $("#ddlCampania").val()
    };


    $.ajaxSetup({
        global: false,
        type: "POST",
        url: baseUrl + 'MisReclamos/ValidarNoPack',
        beforeSend: function () {
            waitingDialog();
        },
        complete: function () {
            closeWaitingDialog();
        }
    });

    $.ajax({
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                callbackWhenFinish(data.success, data.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
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
    var montoPedidoTrueque = $("#hdImporteTotal2").val();

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
        url: baseUrl + 'MisReclamos/ValidarNoPack',
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
                return false;
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });


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

    return ok;
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
    var item = {
        CDRWebID: $("#CDRWebID").val() || 0,
        PedidoID: $("#txtPedidoID").val() || 0
    };
    $.ajaxSetup({
        global: false,
        type: "POST",
        url: baseUrl + 'MisReclamos/DetalleCargar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        beforeSend: function () {
            waitingDialog();
        },
        complete: function () {
            closeWaitingDialog();
        }
    });
    $.ajax({
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
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

            if (data.esCDRExpress) $("#TipoDespacho").show();
            else $("#TipoDespacho").hide();

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

    if (accion == "x") {
        var pedidodetalleid = $.trim($(obj).attr("data-pedidodetalleid"));

        var item = {
            CDRWebDetalleID: pedidodetalleid
        };


        var functionEliminar = function () {
            DetalleEliminar(item);
        };
        messageConfirmacion("", "Se eliminará el registro seleccionado. <br/>¿Deseas continuar?", functionEliminar);

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

            if (data.success == true) {
                DetalleCargar();
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
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

    //if (celular != "" && !ValidarTelefono(celular)) {
    //    ControlSetError('#txtTelefono', '#spnTelefonoError', '*Este número de celular ya está siendo utilizado. Intenta con otro.');
    //    return false;
    //}

    if (!$("#btnAceptoPoliticas").hasClass("politica_reclamos_icono_active")) {
        alert_msg("Debe aceptar la política de Cambios y Devoluciones");
        return false;
    }

    //var correo = $.trim($("#txtEmail").val());
    //var correoActual = $.trim($("#hdEmail").val());
    //if (correo != correoActual ) {
    //    ControlSetError('#txtEmail', '#spnEmailError', '*Este correo ya está siendo utilizado. Intenta con otro');
    //    return false;
    //}


    return true;
}

function ValidarTelefonoServer(celular, callbackWhenFinish) {
    $.ajaxSetup({
        global: false,
        type: "POST",
        url: baseUrl + 'Bienvenida/ValidadTelefonoConsultora',
        beforeSend: function () {
            waitingDialog();
            $('#IrSolicitudEnviada').addClass('btn_deshabilitado');
        },
        complete: function () {
            closeWaitingDialog();
        }
    });

    var item = {
        Telefono: celular
    };

    $.ajax({
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                    callbackWhenFinish(data);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function ValidarCorreoDuplicadoServer(correo, callbackWhenFinish) {
    $.ajaxSetup({
        global: false,
        type: "POST",
        url: baseUrl + 'MisReclamos/ValidarCorreoDuplicado',
        beforeSend: function () {
            waitingDialog();
        },
        complete: function () {
            closeWaitingDialog();
        }
    });

    $.ajax({
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ correo: correo }),
        async: true,
        cache: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                    callbackWhenFinish(data);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function SolicitudCDREnviar(callbackWhenFinish) {
    var item = {
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
        item.TipoDespacho = tipoDespacho;
        item.FleteDespacho = !tipoDespacho ? 0 : $("#hdFleteDespacho").val();
        item.MensajeDespacho = $(!tipoDespacho ? '#divDespachoNormal' : '#divDespachoExpress').CleanWhitespace().html();
    }
    setTimeout(function () {
        $.ajaxSetup({
            global: false,
            type: "POST",
            url: baseUrl + 'MisReclamos/SolicitudEnviar',
            beforeSend: function () {
                waitingDialog();
            },
            complete: function () {
                closeWaitingDialog();
                $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
            }
        });

        $.ajax({
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            cache: false,
            success: function (data) {
                if (checkTimeout(data)) {
                    if (data.success) {
                        var formatoFechaCulminado = "";
                        var numeroSolicitud = 0;
                        var formatoCampania = "";
                        var mensajeDespacho = IfNull(data.cdrWeb.MensajeDespacho, '');
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

                }
            },
            error: function (data, error) {
                closeWaitingDialog();
            }
        });
    }, 0);



}

function CambioPaso(paso) {
    paso = paso || 1;
    pasoActual = pasoActual + paso || 1;
    pasoActual = pasoActual < 1 ? 1 : pasoActual > 3 ? 3 : pasoActual;

    $(".paso_reclamo[data-paso]").removeClass("paso_active_reclamo");
    $(".paso_reclamo[data-paso] span").html("");
    $(".paso_reclamo[data-paso]").each(function (ind, tag) {
        var pasoTag = $(tag).attr("data-paso");
        if (pasoTag < pasoActual) {
            $(tag).addClass("paso_active_reclamo");
            $(tag).find("span").html("<img src='" + imgCheck + "' />");
        }
        else if (pasoTag == pasoActual) {
            $(tag).addClass("paso_active_reclamo");
            $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoActual + "_activo") + "' />");
        }
        else $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoTag) + "' />");
    });

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
            AgregarProductoListado();
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
                $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
                return false;
            } else if ($.trim($("#txtEmail").val()) != $.trim($("#hdEmail").val())) {
                ValidarCorreoDuplicadoServer($.trim($("#txtEmail").val()), function (data) {
                    if (!data.success) {
                        ControlSetError('#txtEmail', '#spnEmailError', data.message);
                        $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
                        return false;
                    } else {
                        SolicitudCDREnviar(function (data) {
                            if (!data.success) {
                                alert_msg(data.message);
                                $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
                                return false;
                            } else {
                                if (data.Cantidad == 1) {
                                    $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
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
                        $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
                        return false;
                    } else {
                        if (data.Cantidad == 1) {
                            $('#IrSolicitudEnviada').removeClass('btn_deshabilitado');
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


//HD-3703 EINCA
function EscogerSolucion(opcion, event) {
    $("#divOperacion input[type=checkbox]").not(opcion).prop('checked', false);
    var id = opcion.id;

    var isChecked = $("#divOperacion input[type=checkbox]").is(':checked');
    if (id == "" || !isChecked) {
        $('#infoOpcionesDeCambio').fadeOut(200);
        if (id == "D" && !isChecked) {
            $('#divDevolucionSetsOrPack').hide();
        }
        return false;
    }
    $('#infoOpcionesDeCambio').show();

    if (id == "T") {
        $('#OpcionCambioMismoProducto').fadeOut(200);
        $('#OpcionDevolucion').fadeOut(200);
        $('#OpcionCambioPorOtroProducto').fadeIn(200);
        SetMontoCampaniaTotal();

    } else if (id == "C") {
        $('#OpcionDevolucion').fadeOut(200);
        $('#OpcionCambioPorOtroProducto').fadeOut(200);
        $('#OpcionCambioMismoProducto').fadeIn(200);
        $('#spnDescProdDevolucion').html($('#hdtxtCUVDescripcion').val());
    } else if (id == "D") {
        $('#OpcionCambioMismoProducto').fadeOut(200);
        $('#OpcionCambioPorOtroProducto').fadeOut(200);
        $('#divDevolucionSetsOrPack').show();
        $('#OpcionDevolucion').fadeIn(200);
        SetHandlebars("#template-opcion-devolucion", dataCdrServicio, "#divDevolucionSetsOrPack");
    } else {
        $('#infoOpcionesDeCambio').fadeOut(200);
    }

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

//HD-3703 EINCA
function AgregarODisminuirCantidad(event, opcion) {
    if (opcion === 1) {
        EstrategiaAgregarModule.AdicionarCantidad(event);
    }
    if (opcion === 2) {
        EstrategiaAgregarModule.DisminuirCantidad(event);
    }
    var precio = $("#hdCuvPrecio2").val() == "" ? 0 : parseFloat($("#hdCuvPrecio2").val());
    var cantidad = parseInt($("#txtCantidad2").val());
    cantidad = cantidad == 99 ? 99 : cantidad; //+ 1;
    var importeTotal = precio * cantidad;
    $("#hdImporteTotal2").val(importeTotal);
    $("#spnImporteTotal2").html(DecimalToStringFormat(importeTotal));
}

function IrAEscogiste() {
    var id = "";
    //$("#divOperacion input[type=checkbox]").each(function () {
    //    if ($(this).is(':checked')) {
    //        id = $(this).attr("id");
    //        return true;
    //    }
    //});
    $('#Cambio1').hide();
    $('#Paso3').show();
}


$('body').on('keypress', 'input[attrKey="PreValidarCUV"]', function (event) {

    if (event.keyCode == 13) {
        if ($("#btnAgregar")[0].disabled == false) {
            AgregarProductoListado();
        }
    }
})