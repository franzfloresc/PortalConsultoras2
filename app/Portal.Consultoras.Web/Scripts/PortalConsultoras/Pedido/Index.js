﻿var animacion = true;
var tieneMicroefecto = false;
//Marcación ProductoDestacado - Pedidos ProductoClick
var contadorNext = 2;
//inicia el contador a partir del 3to producto ya que es el que se va mostrar
var positionCarrousel = 0;
var posicionInicial = 0;
var posicionFinalPantalla = 2;
var posicionTotal = 0;
var salto = 3;

var esPedidoValidado = false;

$(document).ready(function () {
    $('#txtClienteDescripcion').autocomplete({
        source: baseUrl + "Pedido/AutocompleteByCliente",
        minLength: 4,
        select: function (event, ui) {
            ui.item.ClienteID = ui.item.ClienteID || 0;
            if (ui.item.ClienteID == 0) {
                return false;
            }

            if (ui.item.ClienteID != -1) {
                $("#hdfClienteID").val(ui.item.ClienteID);
                $("#hdnClienteID_").val(ui.item.ClienteID);
                $("#txtClienteDescripcion").val(ui.item.Nombre);
                $("#hdfClienteDescripcion").val(ui.item.Nombre);
            } else {
                $('#Nombres').val($("#txtClienteDescripcion").val());
                $("#divClientes").show();
            }
            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.Nombre + "</a>")
            .appendTo(ul);
    };
    $('#txtDescripcionProd').keyup(function (evt) {
        $("#divObservaciones").html("");
    });
    $('#txtDescripcionProd').autocomplete({
        source: baseUrl + "Pedido/AutocompleteByProductoDescripcion",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.CUV == "0") {
                return false;
            }

            $("#txtDescripcionProd").val(ui.item.Descripcion);
            $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
            $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
            $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
            ObservacionesProducto(ui.item);

            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.Descripcion + "</a>")
            .appendTo(ul);
    };
    $("#txtCUV").keyup(function (evt) {
        $("#txtCantidad").val("");
        $("#hdfDescripcionProd").val("");
        $("#txtDescripcionProd").val("");
        $("#btnAgregar").attr("disabled", "disabled");
        $("#divMensaje").text("");
        $("#txtPrecioR").val("");
        $("#hdfPrecioUnidad").val("");

        if ($(this).val().length == 5) {
            BuscarByCUV($(this).val());
        } else {
            $("#hdfCUV").val("");

            $("#divObservaciones").html("");
        }
    });
    $('#txtCUV').autocomplete({
        source: baseUrl + "Pedido/AutocompleteByProductoCUV",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.MarcaID != 0) {
                $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
                $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
                $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
                $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
                ObservacionesProducto(ui.item);
            }
            event.preventDefault();
            return false;
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.CUV + "</a>")
            .appendTo(ul);
    };
    $(".ValidaAlfanumerico").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return true;
        } else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ' ]/;
            return re.test(keyChar);
        }
    });
    $('.ValidaNumeralPedido').live('keyup', function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });
    $('.ValidaNumeralPedido').live('keypress', function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });
    $('#btnValidarPROL').click(function () {
        EjecutarPROL();
    });
    $("body").on("mouseenter", ".info_copy", function () {
        var mar = $(this).parent().parent() || '0';
        mar = mar === '0' ? mar : mar.parent();
        mar = mar === '0' ? mar : $.trim(mar.css("margin-top")).replace("px", "");
        var pos = $(this).position();
        $(this).parent().parent().find("div.msj_info").show();
    });
    $("body").on("mouseleave", ".info_copy", function () {
        $(this).parent().parent().find("div.msj_info").hide();
    });
    $("body").on("mouseleave", ".cantidad_detalle_focus", function () {
        var idPed = $(this).find("input.liquidacion_rango_cantidad_pedido").attr('data-pedido');
        var cant = $('#txtLPCant' + idPed).val();
        var cantAnti = $('#txtLPTempCant' + idPed).val();
        if (cant == cantAnti) {
            return false;
        }
        $(this).find("input.liquidacion_rango_cantidad_pedido").focus();
        $(this).find("input.liquidacion_rango_cantidad_pedido").select();
        $('#txtCUV').focus();
    });
    $("body").on("click", ".agregarSugerido", function () {
        AbrirSplash();

        var divPadre = $(this).parents("[data-item='producto']").eq(0);
        var cuv = $(divPadre).find(".hdSugeridoCuv").val();
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var tipoOfertaSisID = $(divPadre).find(".hdSugeridoTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdSugeridoConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdSugeridoIndicadorMontoMinimo").val();
        var tipo = $(divPadre).find(".hdSugeridoTipo").val();
        var marcaID = $(divPadre).find(".hdSugeridoMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdSugeridoPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdSugeridoDescripcionProd").val();
        var pagina = $(divPadre).find(".hdSugeridoPagina").val();
        var descripcionCategoria = $(divPadre).find(".hdSugeridoDescripcionCategoria").val();
        var descripcionMarca = $(divPadre).find(".hdSugeridoDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdSugeridoDescripcionEstrategia").val();

        if (!isInt(cantidad)) {
            alert_msg("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarSplash();
            limpiarInputsPedido();
            return false;
        }

        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarSplash();
            limpiarInputsPedido();
            return false;
        } else {
            var model = {
                TipoOfertaSisID: tipoOfertaSisID,
                ConfiguracionOfertaID: configuracionOfertaID,
                IndicadorMontoMinimo: indicadorMontoMinimo,
                MarcaID: marcaID,
                Cantidad: cantidad,
                PrecioUnidad: precioUnidad,
                CUV: cuv,
                Tipo: tipo,
                DescripcionProd: descripcionProd,
                Pagina: pagina,
                DescripcionCategoria: descripcionCategoria,
                DescripcionMarca: descripcionMarca,
                DescripcionEstrategia: descripcionEstrategia,
                EsSugerido: true
            };

            AgregarProducto('Insert', model, 'divProductoSugerido', true);

            $("#divProductoAgotadoFinal").hide();
        }
    });
    $("body").on("click", "[data-close='divProductoAgotadoFinal']", function () {
        limpiarInputsPedido();
        $("#divProductoAgotadoFinal").hide();
    });
    $('#frmInsertPedido').on('submit', function () {
        if (!$(this).valid()) {
            alert_msg("Argumentos no validos");
            return false;
        }

        if (HorarioRestringido()) {
            return false;
        }

        AbrirSplash();

        /*Logica Kit Nuevas*/
        var cuv = $("#txtCUV").val();
        var esKit = $("#divListadoPedido").find("input[data-kit='True']") || $("#divListadoPedido").find("input[data-kit='true']") || [];
        if (esKit.length > 0) {
            var tag = $(esKit).parents("tr");
            var cuvKit = $.trim(tag.attr('data-cuv'));
            if (cuv == cuvKit) {
                alert_msg("El CUV ingresado pertenece a un Kit Nuevas, solo puede ser registrado 1 vez");
                return false;
            }
        }

        var form = FuncionesGenerales.GetDataForm(this);
        var validarEstrategia = ValidarStockEstrategia();

        if (validarEstrategia.success) {
            if ($("#hdFlagNueva").val() == "0" || $("#hdFlagNueva").val() == "") {
                //CerrarSplash();
                InsertarProducto(form);
            } else {
                AgregarProductoZonaEstrategia();
            }

            $("#btnAgregar").removeAttr("disabled");
        } else {
            CerrarSplash();
            alert_msg(validarEstrategia.message);
            $("#btnAgregar").removeAttr("disabled");
        }

        return false;
    });
    $("body").on("click", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "back" || accion === "next") {
            CambioPagina(obj);
        }
    });
    $("body").on("change", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "page" || accion === "rows") {
            CambioPagina(obj);
        }
    });
    
    $("body").on("click", ".agregarOfertaFinal", function () {
        AbrirSplash();

        var divPadre = $(this).parents("[data-item='ofertaFinal']").eq(0);
        var cuv = $(divPadre).find(".hdOfertaFinalCuv").val();
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var tipoOfertaSisID = $(divPadre).find(".hdOfertaFinalTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdOfertaFinalConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdOfertaFinalIndicadorMontoMinimo").val();
        var tipo = $(divPadre).find(".hdOfertaFinalTipo").val();
        var marcaID = $(divPadre).find(".hdOfertaFinalMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdOfertaFinalPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdOfertaFinalDescripcionProd").val();
        var pagina = $(divPadre).find(".hdOfertaFinalPagina").val();
        var descripcionCategoria = $(divPadre).find(".hdOfertaFinalDescripcionCategoria").val();
        var descripcionMarca = $(divPadre).find(".hdOfertaFinalDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdOfertaFinalDescripcionEstrategia").val();

        if (!isInt(cantidad)) {
            alert_msg("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarSplash();
            //limpiarInputsPedido();
            return false;
        }

        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarSplash();
            return false;
        } else {
            var model = {
                TipoOfertaSisID: tipoOfertaSisID,
                ConfiguracionOfertaID: configuracionOfertaID,
                IndicadorMontoMinimo: indicadorMontoMinimo,
                MarcaID: marcaID,
                Cantidad: cantidad,
                PrecioUnidad: precioUnidad,
                CUV: cuv,
                Tipo: tipo,
                DescripcionProd: descripcionProd,
                Pagina: pagina,
                DescripcionCategoria: descripcionCategoria,
                DescripcionMarca: descripcionMarca,
                DescripcionEstrategia: descripcionEstrategia,
                EsSugerido: false
            };                        
            
            AgregarProducto('Insert', model, "", false);                       
            
            setTimeout(function () {
                $("#divOfertaFinal").hide();
                EjecutarServicioPROLSinOfertaFinal();
            }, 1000);                                   
        }
    });

    $('#btnNoGraciasOfertaFinal, #lnkCerrarPopupOfertaFinal').click(function () {
        var esMontoMinimo = $("#divIconoOfertaFinal").attr("class") == "icono_exclamacion";
        
        if (esMontoMinimo) {
            $("#divOfertaFinal").hide();
        } else {
            var data = $("#btnNoGraciasOfertaFinal")[0].data;
            MostrarMensajeProl(data);
        }
    });
    
    CrearDialogs();
    CargarDetallePedido();
    CargarCarouselEstrategias("");
    MostrarBarra();
});

function CrearDialogs() {
    $('#DialogMensajes').dialog({
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

    $('#divMensajeCUV').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 364,
        height: 158,
        draggable: true,
        title: "Importante"
    });

    $('#divConfirmEliminarTotal').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
        title: "",
        close: function (event, ui) {
            $(this).dialog('close');
        }
    });

    $('#divObservacionesPROL').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
    });

    $('#divConfirmValidarPROL').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 550,
        draggable: true,
        close: function (event, ui) {
            $(this).dialog('close');
        }
    });

    $('#divReservaSatisfactoria').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
    });

    $('#divReservaSatisfactoria2').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
    });

    $('#divReservaSatisfactoria3').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true
    });

    $('#divReservaSatisfactoriaVE').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 550,
        height: 230,
        draggable: true,
    });

    $('#divReservaSatisfactoriaCO').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 550,
        height: 230,
        draggable: true,
    });

    $('#divVistaPrevia').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 350,
        draggable: false,
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        }
    });

    $('#divProductoSugerido').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        height: 300,
        draggable: true,
        title: "PRODUCTOS SUGERIDOS"
    });
}

function CargarDetallePedido(page, rows) {
    $(".pMontoCliente").css("display", "none");

    $('#tbobyDetallePedido').html('<tr><td colspan="7"><div style="text-align: center;">Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></td></tr>');

    var clienteId = $("#ddlClientes").val() || -1;
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 10,
        clienteId: clienteId
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/CargarDetallePedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            var data = response.data;

            ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

            $("#pCantidadProductosPedido").html(data.TotalProductos);

            //Index
            $("#hdnRegistrosPaginar").val(data.Registros);
            $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
            $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
            $("#hdnPaginaPaginar").val(data.Pagina);
            $("#hdnPaginaDePaginar").val(data.PaginaDe);

            //ListadoPedido
            $("#hdnRegistros").val(data.Registros);
            $("#hdnRegistrosDe").val(data.RegistrosDe);
            $("#hdnRegistrosTotal").val(data.RegistrosTotal);
            $("#hdnPagina").val(data.Pagina);
            $("#hdnPaginaDe").val(data.PaginaDe);

            //Listado Cliente en la Vista ListadoPedido
            var htmlCliente = "";

            $("#ddlClientes").empty();

            $.each(data.ListaCliente, function (index, value) {
                if (value.ClienteID == -1) {
                    htmlCliente += '<option value="-1">Cliente</option>';
                } else {
                    htmlCliente += '<option value="' + value.ClienteID + '">' + value.Nombre + '</option>';
                }
            });

            $("#ddlClientes").append(htmlCliente);
            $("#ddlClientes").val(clienteId);

            data.ListaDetalleModel = data.ListaDetalleModel || new Array();
            $.each(data.ListaDetalleModel, function (ind, item) {
                item.EstadoSimplificacionCuv = data.EstadoSimplificacionCuv;
            });

            var html = ArmarDetallePedido(data.ListaDetalleModel);
            $('#tbobyDetallePedido').html(html);

            var htmlPaginador = ArmarDetallePedidoPaginador(data);
            $('#paginadorCab').html(htmlPaginador);
            $('#paginadorPie').html(htmlPaginador);

            $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
            $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

            MostrarInformacionCliente(clienteId);
            mostrarSimplificacionCUV();
            //if (tieneMicroefecto)
            //MostrarMicroEfecto();
        },
        error: function (error) {
            //alert(error);
        }
    });
}

function MostrarInformacionCliente(clienteId) {
    $("#hdnClienteID_").val(clienteId);
    var nomCli = $("#ddlClientes option:selected").text();
    var simbolo = $("#hdfSimbolo").val();
    var monto = $("#hdfTotalCliente").val();

    $(".pMontoCliente").css("display", "none");

    if ($("#hdnClienteID_").val() != "-1") {
        $(".pMontoCliente").css("display", "block");
        $("#spnNombreCliente").html(nomCli + " :");
        $("#spnTotalCliente").html(simbolo + monto);
    }
}

function ValidarStockEstrategia() {
    var resultado;

    var success = false;
    var message = "";

    var CUV = $('#txtCUV').val();
    $("#hdCuvRecomendado").val(CUV);
    $("#btnAgregar").attr("disabled", "disabled");

    if ($("#hdTipoOfertaSisID").val() == constConfiguracionOfertaLiquidacion) {
        resultado = {
            success: false,
            message: "No se puede agregar una Oferta Liquidacion por este medio."
        };

        return resultado;
    }

    var cantidadSol = $("#txtCantidad").val();

    var param = {
        MarcaID: 0,
        CUV: CUV,
        PrecioUnidad: 0,
        Descripcion: 0,
        Cantidad: cantidadSol,
        IndicadorMontoMinimo: 0,
        TipoOferta: $("#hdTipoEstrategiaID").val()
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: false,
        success: function (datos) {
            success = datos.result;
            message = datos.message;
        },
        error: function (data, error) {
            resultado = false;
        }
    });

    resultado = {
        success: success,
        message: message
    };

    return resultado;
}

function InsertarProducto(form) {
    $.ajax({
        url: form.url,
        type: form.type,
        data: form.data,
        success: function (response) {
            if (response.success == true) {
                $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                tieneMicroefecto = true;
                MostrarBarra(response);
                CargarDetallePedido();
                TrackingJetloreAdd(form.data.Cantidad, $("#hdCampaniaCodigo").val(), form.data.CUV);
            } else {
                alert(response.message);
            }

            PedidoOnSuccess();

            CerrarSplash();
        },
        error: function (x, xh, xhr) {
            console.error(xh);
        }
    });
}

function MostrarMicroEfecto() {
    if (animacion) {
        animacion = false;
        var obj = $("#frmInsertPedido");
        var button = $("#btnAgregar", obj);
        var efecto = '<div class="btn_animado"><img src="' + urlImagenMicroEfecto + '" alt="" /></div>';
        var trFirst = $("#tbobyDetallePedido tr:first-child");

        $("body").prepend(efecto);

        $(".btn_animado").css({
            'top': button.offset().top,
            'left': button.offset().left
        }).show().animate({
            'top': trFirst.offset().top,
            'left': trFirst.offset().left + (trFirst.width() / 2),
            'opacity': 0
        }, 1500, 'swing', function () {
            $(this).remove();

            trFirst.addClass("no_mostrar");

            $(".no_mostrar").fadeIn();

            trFirst.removeClass("no_mostrar");
            //setTimeout(trFirst.removeClass("no_mostrar"), 3000);

            animacion = true;
            tieneMicroefecto = false;
        });
    }
}

function ActualizarMontosPedido(formatoTotal, total, formatoTotalCliente) {
    if (formatoTotal != undefined) {
        //$("#sTotal").html(formatoTotal);
        //$("#spPedidoWebAcumulado").text(vbSimbolo + " " + formatoTotal);
    }

    if (total != undefined)
        $("#hdfTotal").val(total);

    if (formatoTotalCliente != undefined)
        $("#hdfTotalCliente").val(formatoTotalCliente);
}

function ArmarDetallePedidoPaginador(data) {
    return SetHandlebars("#paginador-template", data);
}

function ArmarDetallePedido(array) {
    return SetHandlebars("#producto-template", array);
}

function AgregarProductoListado() {
    if (HorarioRestringido()) {
        return false;
    }

    var CUV = $('#txtCUV').val();
    $("#hdCuvRecomendado").val(CUV);
    $("#btnAgregar").attr("disabled", "disabled");

    if ($("#hdTipoOfertaSisID").val() == constConfiguracionOfertaLiquidacion) {
        return false;
    }

    var cantidadSol = $("#txtCantidad").val();

    var param = {
        MarcaID: 0,
        CUV: CUV,
        PrecioUnidad: 0,
        Descripcion: 0,
        Cantidad: cantidadSol,
        IndicadorMontoMinimo: 0,
        TipoOferta: 0
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                CerrarSplash();
                alert_msg(datos.message);
                return false;
            }

            if ($("#hdFlagNueva").val() == "0" || $("#hdFlagNueva").val() == "") {
                //CerrarSplash();
                $('form#frmInsertPedido').submit();
            } else {
                AgregarProductoZonaEstrategia();
            }

            $("#btnAgregar").removeAttr("disabled");
            return false;
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                $("#btnAgregar").removeAttr("disabled");
            }
        }
    });

    return false;
}

function AgregarProductoZonaEstrategia() {
    var param2 = {
        MarcaID: $("#hdfMarcaID").val(),
        CUV: $("#txtCUV").val(),
        PrecioUnidad: $("#hdfPrecioUnidad").val(),
        Descripcion: $("#txtDescripcionProd").val(),
        Cantidad: $("#txtCantidad").val(),
        IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ElementoOfertaTipoNuevo: $("#OfertaTipoNuevo").val()
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/AgregarProductoZE',
        dataType: 'html',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param2),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success == true) {
                    //var producto = response.data;
                    //var array = new Array();
                    //array.push(producto);

                    //var html = ArmarDetallePedido(array);

                    //if (response.tipo == "I" || response.tipo == "I_S") {
                    //    $("#tbobyDetallePedido").prepend(html);
                    //} else {
                    //    var trCuv = $("#tbobyDetallePedido").find("tr[data-cuv='" + producto.CUV + "']");
                    //    $(trCuv).remove();

                    //    $("#tbobyDetallePedido").prepend(html);
                    //}

                    //ActualizarMontosPedido(response.formatoTotal, response.total, undefined);

                    $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                    cierreCarouselEstrategias();
                    CargarCarouselEstrategias(cuv);
                    HideDialog("divVistaPrevia");
                    MostrarProductoAgregado(urlImagen, descripcion, cantidad, (cantidad * precio).toFixed(2));

                    CargarDetallePedido();
                    MostrarBarra(response);
                    TrackingJetloreAdd(param2.Cantidad, $("#hdCampaniaCodigo").val(), param2.CUV);
                    CerrarSplash();
                } else {
                    CerrarSplash();
                    alert(response.message);
                }
            }
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
            }
        }
    });
}

function mostrarSimplificacionCUV() {
    var clase = $('#divListadoPedido').find('.icon-advertencia').length;
    $('.datos_simplificacionCUV').Visible(clase > 0);

    var icoCell = $('#divListadoPedido').find('.icon-mobile').length;
    $('.datos_para_movil').Visible(icoCell > 0);
}

function ValidarCUV() {
    if ($("#hdfCUV").val() != "" && $("#txtCUV").val() != "") {
        if ($("#txtCUV").val() != $("#hdfCUV").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        if ($("#txtCUV").val().length == 5) {
            //BuscarByCUV($("#txtCUV").val());
        } else {
            $("#txtCantidad").val("");
            $("#hdfCUV").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtDescripcionProd").val("");
            $("#btnAgregar").attr("disabled", "disabled");
            $("#divMensaje").text("");
            $("#txtPrecioR").val("");
            $("#hdfPrecioUnidad").val("");

            //if ($("#txtCUV").val().length == 0) {
            //    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Debe ingresar un CUV.</div></div>");
            //}
        }
    }
}

function ValidarDescripcion() {
    if ($("#hdfDescripcionProd").val() != "" && $("#txtDescripcionProd").val() != "") {
        if ($("#txtDescripcionProd").val() != $("#hdfDescripcionProd").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        $("#txtCantidad").val("");
        $("#hdfCUV").val("");
        $("#txtCUV").val("");
        $("#hdfDescripcionProd").val("");
        $("#btnAgregar").attr("disabled", "disabled");
        $("#divMensaje").text("");
    }
}

function PreValidarCUV() {
    if (event.keyCode == 13) {
        if ($("#btnAgregar")[0].disabled == false) {
            AgregarProductoListado();
        }
    }
}

function SeleccionarContenido(control) {
    control.select();
}

function PedidoFailure(param) {
    alert_msg("Ocurrió un error. Por favor, vuelva a realizar la acción.");
}

function ValidarCliente() {
    if ($("#hdfClienteDescripcion").val() != "" && $("#txtClienteDescripcion").val() != "") {
        if ($("#txtClienteDescripcion").val() != $("#hdfClienteDescripcion").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un cliente válido.");
        }
    } else {
        $("#hdfClienteDescripcion").val("");
        $("#hdfClienteID").val("0");
        $("#divMensaje").text("");
    }
}

function ValidarClienteFocus() {
    if (event.keyCode == 9) {
        if ($("#btnAgregar")[0].disabled == true) {
            if (event.preventDefault)
                event.preventDefault();
            else
                event.returnValue = false;
            $("#txtCUV").focus();
        }
    }
}

function AbrirModalCliente() {
    _gaq.push(['_trackEvent', 'Pedido', 'Nuevo-cliente']);
    $('#Nombres').val($('#txtClienteDescripcion').val());
    //showDialog('divClientes');
    $("#divClientes").show();
}

function ValidarRegistroCliente() {
    var vMessage = "";

    if (jQuery.trim($('#Nombres').val()) == "") {
        vMessage += "- Debe ingresar el Nombre del Cliente.\n";
    }

    if (jQuery.trim($('#Correo').val()) != "") {
        if (!validateEmail($('#Correo').val())) {
            vMessage += "- Debe ingresar un correo con la estructura válida.\n";
        }
    }

    if (vMessage != "") {
        alert_msg(vMessage);
        $('#Nombres').focus();
        return false;
    }

    GuardarCliente();
}

function GuardarCliente() {
    var item = {
        Nombre: $('#Nombres').val(),
        eMail: $('#Correo').val()
    };
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/RegistrarCliente',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    _gaq.push(['_trackEvent', 'Pedido', 'Nuevo-cliente', 'Guardar']);
                    $("#hdfClienteID").val(data.extra);
                    $("#txtClienteDescripcion").val($('#Nombres').val());
                    $("#hdfClienteDescripcion").val($('#Nombres').val());
                    $('#Nombres').val("");
                    $('#Correo').val("");
                    //HideDialog("divClientes");
                    $("#divClientes").hide();
                }
                alert_msg(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert_msg(data.message);
                //HideDialog("divClientes");
                $("#divClientes").hide();
            }
        }
    });
}

function Tabular() {
    if (event.keyCode == 9) {
        if (event.preventDefault)
            event.preventDefault();
        else
            event.returnValue = false;
        $("#txtCUV").focus();
    }
}

function PedidoOnSuccess() {
    _gaq.push(['_trackEvent', 'Pedido', 'Agregar-Producto']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Pedido/Agregar-Producto'
    });

    var ItemCantidad = $("#txtCantidad").val();
    var ItemPrecio = $("#hdfPrecioUnidad").val();
    var descripcion = $('#txtDescripcionProd').val();
    var ItemTotal = parseFloat(ItemCantidad * ItemPrecio).toFixed(2);

    MostrarProductoAgregado("", descripcion, ItemCantidad, ItemTotal);

    $("#divObservaciones").html("");
    $("#hdnDescripcionEstrategia").val("");
    $("#hdnDescripcionLarga").val("");
    $("#hdnDescripcionProd").val("");

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#txtCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtPrecioR").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val($("#hdfClienteDescripcion").val());
    $("#btnAgregar").attr("disabled", "disabled");

    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#ddlClientes").val($("#hdnClienteID2_").val());
    $("#hdnClienteID_").val($("#hdnClienteID2_").val());

    //var simbolo = $("#hdfSimbolo").val();
    //var monto = $("#hdfTotalCliente").val();

    //$(".pMontoCliente").css("display", "none");

    //if ($("#hdnClienteID_").val() != "-1") {
    //    $(".pMontoCliente").css("display", "block");
    //    $("#spnNombreCliente").html("prueba :");
    //    $("#spnTotalCliente").html(simbolo + monto);
    //}

    CalcularTotal();
    $("#txtCUV").focus();

    //Esta marcación se realizará para productos recomendados únicamente
    InfoCommerceGoogleProductoRecomendados();
}

function CargarCarouselEstrategias(cuv) {
    $('.js-slick-prev').remove();
    $('.js-slick-next').remove();
    $('#divListadoEstrategia').unslick();
    $('#divListadoEstrategia').html('<div style="text-align: center;">Cargando Productos Destacados<br><img src="' + urlLoad + '" /></div>');
    heightReference = $("#divListadoPedido").find("[data-tag='table']").height();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/JsonConsultarEstrategias?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $('#divListadoEstrategia').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
};

function ArmarCarouselEstrategias(data) {
    data = EstructurarDataCarousel(data);

    SetHandlebars("#estrategia-template", data, '#divListadoEstrategia');

    cierreCarouselEstrategias();
    if ($.trim($('#divListadoEstrategia').html()).length == 0) {
        $('#divListadoEstrategia').parents('.caja_carousel_productos').hide();
    } else {
        var hCar = $($("#divListadoEstrategia").find("[data-item='producto']").get(0)).height();
        var cant = parseInt(heightReference / hCar);
        cant = cant < 3 ? 3 : cant > 5 ? 5 : cant;
        $('#divListadoEstrategia').slick({
            infinite: true,
            vertical: true,
            centerMode: true,
            centerPadding: '50px',
            slidesToShow: cant,
            slidesToScroll: 1,
            autoplay: false,
            pantallaPedido: false,
            prevArrow: '<button type="button" data-role="none" class="slick-next" onclick="javascript:TagManagerCarruselPrevia(false);"></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev" onclick="javascript:TagManagerCarruselSiguiente(false);"></button>'
        });
        $(".slick-prev").insertAfter('#divCarruselVertical');
        $(".slick-next").insertBefore('#divCarruselVertical');
        if (data.length > cant) {
            $('#cierreCarousel').show();
        }
    }
    
};

function cierreCarouselEstrategias() {
    $('#cierreCarousel').hide();
}

function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
            item.ArrayContenidoSet = item.DescripcionCUV2.split('|').slice(1);
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        };

        item.MostrarTextoLibre = item.TextoLibre.length > 0;
    });

    return array;
};

function limpiarInputsPedido() {
    $("#txtCUV").val("");
    $("#txtPrecioR").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val("");
    $("#txtCUV").focus();
}

function PedidoOnSuccessSugerido(model) {
    if (model != null) {
        var ItemCantidad = model.Cantidad;
        var ItemPrecio = model.PrecioUnidad;
        var descripcion = model.DescripcionProd;
        var ItemTotal = parseFloat(ItemCantidad * ItemPrecio).toFixed(2);

        MostrarProductoAgregado("", descripcion, ItemCantidad, ItemTotal);
    }

    $("#divObservaciones").html("");
    $("#hdnDescripcionEstrategia").val("");
    $("#hdnDescripcionLarga").val("");
    $("#hdnDescripcionProd").val("");

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#txtCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtPrecioR").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val($("#hdfClienteDescripcion").val());
    $("#btnAgregar").attr("disabled", "disabled");

    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#ddlClientes").val($("#hdnClienteID2_").val());
    $("#hdnClienteID_").val($("#hdnClienteID2_").val());

    //var simbolo = $("#hdfSimbolo").val();
    //var monto = $("#hdfTotalCliente").val();

    //$(".pMontoCliente").css("display", "none");

    //if ($("#hdnClienteID_").val() != "-1") {
    //    $(".pMontoCliente").css("display", "block");
    //    $("#spnNombreCliente").html("prueba :");
    //    $("#spnTotalCliente").html(simbolo + monto);
    //}

    CalcularTotal();
    $("#txtCUV").focus();

    //Esta marcación se realizará para productos recomendados únicamente
    //InfoCommerceGoogleProductoRecomendados();
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    mostrarSimplificacionCUV();
    closeWaitingDialog();
}

function BuscarByCUV(CUV) {
    if (CUV != $('#hdfCUV').val()) {
        var item = {
            CUV: CUV
        };

        AbrirSplash();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'Pedido/FindByCUV',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            cache: false,
            success: function (data) {
                CerrarSplash();
                if (!checkTimeout(data)) {
                    return false;
                }

                $("#divObservaciones").html("");

                if (data[0].MarcaID != 0) {
                    $("#hdTipoOfertaSisID").val(data[0].TipoOfertaSisID);
                    $("#hdConfiguracionOfertaID").val(data[0].ConfiguracionOfertaID);
                    ObservacionesProducto(data[0]);
                    if (data[0].ObservacionCUV != null && data[0].ObservacionCUV != "") {
                        $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>" + data[0].ObservacionCUV + "</div></div>");
                    }
                } else {
                    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>" + data[0].CUV + "</div></div>");

                    if (data[0].TieneSugerido != 0)
                        ObtenerProductosSugeridos(CUV);
                }
            },
            error: function (data, error) {
                CerrarSplash();
                if (checkTimeout(data)) {
                    if (data.message == "" || data.message === undefined) {
                        location.href = baseUrl + "SesionExpirada.html";
                    } else {
                        alert_msg(data.message);
                    }
                }
            }
        });
    }
}

function ObtenerProductosSugeridos(CUV) {
    var item = {
        CUV: CUV
    };

    $('.js-slick-prev-h').remove();
    $('.js-slick-next-h').remove();
    $('#divCarruselSugerido').unslick();
    $('#divCarruselSugerido').html('<div style="text-align: center;">Actualizando Productos Destacados<br><img src="' + urlLoad + '" /></div>');

    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerProductosSugeridos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) {
                return false;
            }

            var lista = data;

            if (lista.length <= 0) {
                return false;
            }

            $("#divCarruselSugerido").html('');

            $('#divProductoAgotadoFinal').show();

            SetHandlebars("#js-CarruselSugerido", lista, '#divCarruselSugerido');

            $.each($("#divCarruselSugerido .sugerido"), function (index, obj) {
                var h = $(obj).find(".nombre_producto").height();
                if (h > 40) {
                    var txt = $(obj).find(".nombre_producto b").html();
                    var splits = txt.split(" ");
                    var lent = splits.length;
                    var cont = false;
                    for (var i = lent ; i > 0; i--) {
                        if (cont) continue;
                        splits.splice(i - 1, 1);
                        $(obj).find(".nombre_producto b").html(splits.join(" "));
                        var hx = $(obj).find(".nombre_producto").height();
                        if (hx <= 40) {
                            var txtF = splits.join(" ");
                            txtF = txtF.substr(0, txtF.length - 3);
                            $(obj).find(".nombre_producto b").html(txtF + "...");
                            cont = true;
                        }
                    }
                }
            });

            $("#divObservaciones").html("");

            $('#divCarruselSugerido').slick({
                infinite: true,
                vertical: false,
                slidesToShow: 2,
                slidesToScroll: 1,
                autoplay: false,
                centerMode: true,
                centerPadding: '0',
                tipo: 'p', // popup
                prevArrow: '<a class="previous_ofertas-popup js-slick-prev-h"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                nextArrow: '<a class="previous_ofertas-popup next js-slick-next-h"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            });

            $('#divCarruselSugerido').prepend($(".js-slick-prev-h"));
            $('#divCarruselSugerido').prepend($(".js-slick-next-h"));
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                if (data.message == "" || data.message === undefined) {
                    location.href = baseUrl + "SesionExpirada.html";
                } else {
                    alert_msg(data.message);
                }
            }
        }
    });
}

function alert_msg(message, titulo) {
    titulo = titulo || "MENSAJE";
    $('#DialogMensajes .terminos_title_2').html(titulo);
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
    CerrarSplash();
}

function CambiarCliente(elem) {
    var rows = $($('[data-paginacion="rows"]')[0]).val() || 10;
    CargarDetallePedido(1, rows, elem.value);

    //var item = {
    //    ClienteID: elem.value
    //};

    //jQuery.ajax({
    //    type: 'POST',
    //    url: baseUrl + "Pedido/CambiarCliente",
    //    dataType: 'json',
    //    contentType: 'application/json; charset=utf-8',
    //    data: JSON.stringify(item),
    //    async: true,
    //    success: function (response) {
    //        if (checkTimeout(response)) {
    //            if (response.success == true) {
    //                var data = response.data;

    //                ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

    //                //Index
    //                $("#hdnRegistrosPaginar").val(data.Registros);
    //                $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
    //                $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
    //                $("#hdnPaginaPaginar").val(data.Pagina);
    //                $("#hdnPaginaDePaginar").val(data.PaginaDe);

    //                //ListadoPedido
    //                $("#hdnRegistros").val(data.Registros);
    //                $("#hdnRegistrosDe").val(data.RegistrosDe);
    //                $("#hdnRegistrosTotal").val(data.RegistrosTotal);
    //                $("#hdnPagina").val(data.Pagina);
    //                $("#hdnPaginaDe").val(data.PaginaDe);

    //                var html = ArmarDetallePedido(data.ListaDetalleModel);
    //                $('#tbobyDetallePedido').html(html);

    //                var htmlPaginador = ArmarDetallePedidoPaginador(data);
    //                $('#paginadorCab').html(htmlPaginador);
    //                $('#paginadorPie').html(htmlPaginador);

    //                $("#hdnClienteID_").val(elem.value);

    //                var nomCli = $("#ddlClientes option:selected").text();
    //                var simbolo = $("#hdfSimbolo").val();
    //                var monto = $("#hdfTotalCliente").val();

    //                $(".pMontoCliente").css("display", "none");

    //                if ($("#hdnClienteID_").val() != "-1") {
    //                    $(".pMontoCliente").css("display", "block");
    //                    $("#spnNombreCliente").html(nomCli + " :");
    //                    $("#spnTotalCliente").html(simbolo + monto);
    //                }

    //                CerrarSplash();
    //            } else {
    //                CerrarSplash();
    //                alert_msg(response.message);
    //            }

    //        }
    //    },
    //    error: function (response, error) {
    //        if (checkTimeout(response)) {
    //            alert_msg(response.message);
    //        }
    //    }
    //});

    //$.get(baseUrl + "Pedido/CambiarCliente?ClienteID=" + elem.value, function (data) {
    //    if (checkTimeout(data)) {
    //        $('#divListadoPedido').html(data);
    //        CalcularTotal();
    //        $("#ddlClientes").val(elem.value);
    //        $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    //        $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    //        $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    //        $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    //        $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    //        $("#hdnClienteID_").val(elem.value);

    //        var nomCli = $("#ddlClientes option:selected").text();
    //        var simbolo = $("#hdfSimbolo").val();
    //        var monto = $("#hdfTotalCliente").val();

    //        $(".pMontoCliente").css("display", "none");

    //        if ($("#hdnClienteID_").val() != "-1") {
    //            $(".pMontoCliente").css("display", "block");
    //            $("#spnNombreCliente").html(nomCli + " :");
    //            $("#spnTotalCliente").html(simbolo + monto);
    //        }

    //        CerrarSplash();
    //    }
    //});
}

function ObservacionesProducto(item) {
    if (item.TieneStock == true) {
        if (item.TieneSugerido != 0) {
            $("#divObservaciones").html("");

            $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>Lo sentimos, este producto está agotado.</div></div>");
            //$("#divObservaciones").append("<div class='noti'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");

            $("#btnAgregar").attr("disabled", "disabled");
            ObtenerProductosSugeridos(item.CUV);
        } else {
            $("#divObservaciones").html("");
            if (item.EsExpoOferta == true) {
                _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Producto-expoferta']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Pedido/Mensajes/Producto-expoferta'
                });

                $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto de ExpoOferta.</div></div>");
                //$("#divObservaciones").append("<div class='noti'><div class='noti_message red_texto_size'>Producto de ExpoOferta.</div></div>");
            }
            if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
                _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Producto-revista']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Pedido/Mensajes/Producto-revista'
                });
                if (isEsika) {
                    $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto en la Guía de Negocio Ésika con oferta especial.</div></div>");
                } else {
                    $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto en la revista Somos Belcorp con oferta especial.</div></div>");
                }                
            }

            if (item.MensajeCUV != null) {
                if (item.MensajeCUV != "") {
                    //$("#divMensajeCUV").html(item.MensajeCUV);
                    //showDialog("divMensajeCUV");
                    alert_msg(item.MensajeCUV, "IMPORTANTE");
                }
            }

            $("#btnAgregar").removeAttr("disabled");
        }
    } else {
        _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Producto-agotado']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Pedido/Mensajes/Producto-agotado'
        });

        $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");
        //$("#divObservaciones").html("<div class='noti'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");
        $("#btnAgregar").attr("disabled", "disabled");
        IngresoFAD(item);

        if (item.TieneSugerido != 0)
            ObtenerProductosSugeridos(item.CUV);
    }

    $("#txtCUV").val(item.CUV);
    $("#hdfCUV").val(item.CUV);
    $("#hdfDescripcionCategoria").val(item.DescripcionCategoria);
    $("#hdfDescripcionEstrategia").val(item.DescripcionEstrategia);
    $("#hdfDescripcionMarca").val(item.DescripcionMarca);
    $("#hdfIndicadorMontoMinimo").val(item.IndicadorMontoMinimo);
    $("#hdfMarcaID").val(item.MarcaID);
    $("#txtCantidad").val("1");
    $("#hdfPrecioUnidad").val(item.PrecioCatalogo);

    $("#txtPrecioR").val(DecimalToStringFormat(item.PrecioCatalogo));

    $("#txtDescripcionProd").val(item.Descripcion.split('|')[0]);
    $("#hdfDescripcionProd").val(item.Descripcion.split('|')[0]);
    $("#hdFlagNueva").val(item.FlagNueva);
    $("#hdTipoEstrategiaID").val(item.TipoEstrategiaID);
    $("#OfertaTipoNuevo").val("");

    if (item.FlagNueva == 1) {
        var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

        pedidosData.each(function (indice, valor) {
            if (valor.value == 1) {
                var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                    $('#hdnPagina').val(), ";",
                    $('#hdnClienteID2_').val());

                $("#OfertaTipoNuevo").val(OfertaTipoNuevo)
                return;
            }
        });
    }
    $("#divMensaje").text("");
    $("#txtCantidad").focus();
}

function IngresoFAD(producto) {
    var item = {
        CUV: producto.CUV,
        PrecioUnidad: producto.PrecioCatalogo
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/IngresoFAD',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert_msg(data.message);
            }
        }
    });
}

function Ignorar(tipo) {
    if (tipo == 1)
        $("#divProdRevista").remove();
    else
        $("#divProdComplementario").remove();
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
                // esta en horario restringido
                if (data.success == true) {
                    if (mostrarAlerta == true)
                        alert_msg(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert_msg(data.message);
            }
        }
    });
    return horarioRestringido;
}

function CargarAutocomplete() {
    var array = $(".classClienteNombre");
    for (var i = 0; i < array.length; i++) {
        $('#' + array[i].id).focus(function () {
            //alert('No se puede');
            if (HorarioRestringido())
                this.blur();
        });
        $('#' + array[i].id).autocomplete({
            source: baseUrl + "Pedido/AutocompleteByClienteListado",
            minLength: 4,
            select: function (event, ui) {
                //
                if (ui.item.ClienteID != 0) {
                    $(this).val(ui.item.Nombre);
                    var hdf = this.id.replace('txtLPCli', 'hdfLPCli');
                    var hdfDes = this.id.replace('txtLPCli', 'hdfLPCliDes');
                    $('#' + hdf).val(ui.item.ClienteID);
                    $('#' + hdfDes).val(ui.item.Nombre);
                }

                isShown = false;
                event.preventDefault();
                return false;
            }
        }).data("autocomplete")._renderItem = function (ul, item) {
            //
            ul.mouseover(function () {
                isShown = true;
            }).mouseout(function () {
                isShown = false;
            });
            return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a>" + item.Nombre + "</a>")
                .appendTo(ul);
        };
    }
}

function CalcularTotal() {
    $('#sSimbolo').html($('#hdfSimbolo').val());
    $('#sSimbolo_minimo').html($('#hdfSimbolo').val());
    var hdfTotal = $('#hdfTotal').val();
    //var paisColombia = "4";
    //if (paisColombia == viewBagPaisID) {
    //    hdfTotal = hdfTotal.replace(/\,/g, '');
    //    hdfTotal = parseFloat(hdfTotal).toFixed(0);
    //    $('#sTotal').html(SeparadorMiles(hdfTotal));
    //} else {
    //    $('#sTotal').html(hdfTotal);
    //}

    $("#divListadoPedido").find('a[class="imgIndicadorCUV"]').tooltip({
        content: "<img src='" + baseUrl + "Content/Images/aviso.png" + "' />",
        position: { my: "left bottom", at: "left top-20%", collision: "flipfit" }
    });
    CargarResumenCampaniaHeader();
}

function MostrarProductoAgregado(imagen, descripcion, cantidad, total) {
    if (imagen == "") {
        $(".info_pop_liquidacion").addClass("info_pop_liquidacion_sinimagen");
        $("#contenedorProductoAgregado").hide();
    } else {
        $(".info_pop_liquidacion").removeClass("info_pop_liquidacion_sinimagen");
        $("#imgProductoAgregado").attr("src", imagen);
        $("#contenedorProductoAgregado").show();
    }
    $("#nombreProductoAgregado").text(descripcion);
    $("#cantidadProductoAgregado").text(cantidad);
    $("#totalProductoAgregado").text(total);
    //$('#pop_liquidacion').show();

    //setTimeout(CerrarProductoAgregado, 5000);
}

function CerrarProductoAgregado() {
    $('#pop_liquidacion').hide();
}

function CargarProductoDestacado(objParameter, objInput, popup, limite) {
    AbrirSplash();

    popup = popup || false;
    limite = limite || 0;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;
    var cantidadIngresada = $(objInput).parent().find("input.liquidacion_rango_cantidad_pedido").val();

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'AdministrarEstrategia/FiltrarEstrategiaPedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {
            var flagEstrella = (datos.data.FlagEstrella == 0) ? "hidden" : "visible";
            $("#imgTipoOfertaEdit").attr("src", datos.data.ImagenURL);
            $("#imgEstrellaEdit").css({ "visibility": flagEstrella });
            $("#imgZonaEstrategiaEdit").attr("src", datos.data.FotoProducto01);

            if (datos.data.Precio != "0") {
                $(".zona2Edit").html(datos.data.EtiquetaDescripcion + ' ' + datos.data.Simbolo + '' + datos.precio);
            } else {
                $(".zona2Edit").html("");
            }

            if (datos.data.Precio2 != "0") {
                $(".zona3Edit_1").html(datos.data.EtiquetaDescripcion2);
                $(".zona3Edit_2").html('<span>' + datos.data.Simbolo + '' + datos.precio2 + '</span>');
            } else {
                $(".zona3Edit_1").html("");
                $(".zona3Edit_2").html("");
            }

            if (datos.data.TextoLibre != "") {
                $(".zona4Edit").html(datos.data.TextoLibre);
            } else {
                $(".zona4Edit").html("");
            }

            if (datos.data.ColorFondo != "") {
                $("#divVistaPrevia").css({ "background-color": datos.data.ColorFondo });
            } else {
                $("#divVistaPrevia").css({ "background-color": "#FFF" });
            }

            $("#txtCantidadZE").val(cantidadIngresada);
            $("#txtCantidadZE").attr("est-cantidad", datos.data.LimiteVenta);
            $("#txtCantidadZE").attr("est-cuv2", datos.data.CUV2);
            $("#txtCantidadZE").attr("est-marcaID", datos.data.MarcaID);
            $("#txtCantidadZE").attr("est-precio2", datos.data.Precio2);
            $("#txtCantidadZE").attr("est-montominimo", datos.data.IndicadorMontoMinimo);
            $("#txtCantidadZE").attr("est-tipooferta", datos.data.TipoOferta);
            $("#txtCantidadZE").attr("est-descripcionMarca", datos.data.DescripcionMarca);
            $("#txtCantidadZE").attr("est-descripcionEstrategia", datos.data.DescripcionEstrategia);
            $("#txtCantidadZE").attr("est-descripcionCategoria", datos.data.DescripcionCategoria);
            $("#txtCantidadZE").attr("est-posicion", posicionItem);

            $("#ddlTallaColor").empty();
            $(".zona0Edit").html(datos.data.DescripcionMarca);

            /*Validar Programa Ofertas Nuevas*/
            $("#hdnProgramaOfertaNuevo").val(false);
            $("#OfertasResultados li").hide();
            $("#OfertaTipoNuevo").val("");

            if (datos.data.FlagNueva == 1) {
                $(".zona4Edit").hide();
                $(".zonaCantidad").hide();
                $("#hdnProgramaOfertaNuevo").val(true);
                var nroPedidos = false;
                var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

                pedidosData.each(function (indice, valor) {
                    if (valor.value == 1) {
                        nroPedidos = true;
                        var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                            $('#hdnPagina').val(), ";",
                            $('#hdnClienteID2_').val());

                        $("#OfertaTipoNuevo").val(OfertaTipoNuevo);
                        return;
                    }
                });

                if (nroPedidos) {
                    $(".zona4Edit").text(datos.data.TextoLibre);
                    $(".zona4Edit").show();
                }

                var ofertas = datos.data.DescripcionCUV2.split('|');
                $(".zona1Edit").html(ofertas[0]);
                $("#txtCantidadZE").attr("est-descripcion", ofertas[0]);
                $("#OfertasResultados li").remove(); // Limpiar la lista.

                $.each(ofertas, function (i) {
                    if (i != 0 && $.trim(ofertas[i]) != "") {
                        $("#OfertasResultados").append("<li>" + ofertas[i] + "</li>");
                    }
                });

                CerrarSplash();
                AgregarProductoDestacado(popup);
            } else {
                $(".zona4Edit").show();
                $(".zonaCantidad").show();
                $(".zona1Edit").html(datos.data.DescripcionCUV2);
                $("#txtCantidadZE").attr("est-descripcion", datos.data.DescripcionCUV2);
                var option = "";
                $(".tallaColor").hide();
                if (datos.data.TallaColor != "") {
                    var arrOption = datos.data.TallaColor.split('</>');
                    if (arrOption.length > 2) {
                        for (var i = 0; i < arrOption.length; i++) {
                            if (arrOption[i] != "") {
                                option = "<option ";
                                var strOption = arrOption[i].split('|');
                                var strCuv = strOption[0];
                                var strDescCuv = strOption[1];
                                var strDescTalla = strOption[2];
                                option += " value='" + strCuv + "' desc-talla='" + strDescCuv + "' >" + strDescTalla + "</option>";
                                $("#ddlTallaColor").append(option);
                            }
                        }

                        $(".tallaColor").show();
                        showDialog('divVistaPrevia');
                    }
                }
                if (option == "") {
                    AgregarProductoDestacado(popup);
                } else {
                    CerrarSplash();
                }
            }

            InfoCommerceGoogleDestacadoProductClick(datos.data.DescripcionCUV2, datos.data.CUV2, datos.data.DescripcionCategoria, datos.data.DescripcionEstrategia, posicionItem);

            //CerrarSplash();
            //showDialog('divVistaPrevia');
        },
        error: function (data, error) {
            alert(datos.data.message);
            CerrarSplash();
        }
    });
};

function AgregarProductoDestacado(popup) {
    var cantidad = $("#txtCantidadZE").val();
    var cantidadLimite = $("#txtCantidadZE").attr("est-cantidad");
    var cuv = $("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $("#txtCantidadZE").attr("est-marcaID");
    var precio = $("#txtCantidadZE").attr("est-precio2");
    var descripcion = $("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $("#txtCantidadZE").attr("est-montominimo");
    var urlImagen = $("#imgZonaEstrategiaEdit").attr("src");

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            alert_msg("Por favor, seleccione la Talla/Color del producto.");
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        alert_msg("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        alert_msg("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        alert_msg("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        return false;
    }

    AbrirSplash();

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ElementoOfertaTipoNuevo: $("#OfertaTipoNuevo").val(),
        ClienteID_: '-1',
        EsKitNueva: ($("#OfertaTipoNuevo").val() != undefined && String($("#OfertaTipoNuevo").val()).trim() != "") ? true : false
    });

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                alert_msg(datos.message);
                CerrarSplash();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'Pedido/AgregarProductoZE',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (response) {
                        if (checkTimeout(response)) {
                            if (response.success == true) {
                                $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                                cierreCarouselEstrategias();
                                CargarCarouselEstrategias(cuv);
                                HideDialog("divVistaPrevia");
                                CargarResumenCampaniaHeader();
                                MostrarProductoAgregado(urlImagen, descripcion, cantidad, (cantidad * precio).toFixed(2));

                                tieneMicroefecto = true;

                                CargarDetallePedido();
                                MostrarBarra(response);
                                TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                                CerrarSplash();
                                if (popup) {
                                    HidePopupEstrategiasEspeciales();
                                };
                            } else {
                                CerrarSplash();
                                alert(response.message);
                            }
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            HideDialog("divVistaPrevia");
                            CerrarSplash();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                HideDialog("divVistaPrevia");
                CerrarSplash();
            }
        }
    });
}

function DeletePedido(campaniaId, pedidoId, pedidoDetalleId, tipoOfertaSisId, cuv, cantidad, clienteId, cuvReco) {
    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        TipoOfertaSisID: tipoOfertaSisId,
        CUV: cuv,
        Cantidad: cantidad,
        ClienteID_: clienteId,
        CUVReco: cuvReco
    };

    AbrirSplash();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/Delete',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (response) {
            if (response.success) {
                CargarDetallePedido();

                if (tipoOfertaSisId != '0') {
                    cierreCarouselEstrategias();
                    CargarCarouselEstrategias(cuv);
                }
                MostrarBarra(response);
                TrackingJetloreRemove(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                CerrarSplash();
            } else {
                CerrarSplash();
                alert(response.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                HideDialog("divVistaPrevia");
                CerrarSplash();
            }
        }
    });
}

function CargandoProductos() {
    $('#tbobyDetallePedido').html('<tr><td colspan="7"><div style="text-align: center;">Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></td></tr>');
}

function MostrarEliminarPedidoTotal() {
    var total = parseFloat($('#sTotal').html());
    if (total != 0) {
        showDialog("divConfirmEliminarTotal");
    }
}

function EliminarPedidoTotalSi() {
    EliminarPedidoTotalNo();
    EliminarPedido();
}

function EliminarPedidoTotalNo() {
    $('#divConfirmEliminarTotal').dialog('close');
}

function ActualizarModeloPaginar(ClienteID) {
    CalcularTotal();
    $("#ddlClientes").val(ClienteID);
    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#hdnClienteID_").val(ClienteID);

    var nomCli = $("#ddlClientes option:selected").text();
    var simbolo = $("#hdfSimbolo").val();
    var monto = $("#hdfTotalCliente").val();

    $(".pMontoCliente").css("display", "none");

    if ($("#hdnClienteID_").val() != "-1") {
        $(".pMontoCliente").css("display", "block");
        $("#spnNombreCliente").html(nomCli + " :");
        $("#spnTotalCliente").html(simbolo + monto);
    }
}

function SaveDeleteAnalytics(descripcion, cuv, price, brand, category, variant, quantity) {
    if (variant == null || $.trim(variant) == "") {
        variant = "Estándar";
    }
    if (category == null || $.trim(category) == "") {
        category = "Sin Categoría";
    }
    dataLayer.push({
        'event': 'removeFromCart',
        'ecommerce': {
            'remove': {
                'products': [{
                    'name': descripcion.replace(/&#39;/g, "'"),
                    'id': cuv,
                    'price': price,
                    'brand': brand.replace(/&#39;/g, "'"),
                    'category': category,
                    'variant': variant,
                    'quantity': parseInt(quantity)
                }]
            }
        }
    });
}

function EjecutarPROL() {
    if (HorarioRestringido())
        return;

    AbrirSplash();
    RecalcularPROL();
}

function RecalcularPROL() {
    var total = parseFloat($('#hdfTotal').val());

    if (total != 0) {
        EjecutarServicioPROL();
    } else {
        if ($('#hdfEstadoPedido').val() == 1)
            EliminarPedido();
        else
            CerrarSplash();
    }
}

function EjecutarServicioPROL() {
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/EjecutarServicioPROL',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            CerrarSplash();

            $("#hdfAccionPROL").val(response.data.Prol);
            $("#hdfReserva").val(response.data.Reserva);
            $("#hdfObsInfor").val(response.data.ObservacionInformativa);
            $("#hdfModificaPedido").val(response.data.EsModificacion);
            $("#hdfZonaValida").val(response.data.ZonaValida);
            $("#hdfPROLSinStock").val(response.data.ProlSinStock);
            $("#hdMontoAhorroCatalogo").val(response.data.MontoAhorroCatalogo);
            $("#hdMontoAhorroRevista").val(response.data.MontoAhorroRevista);
            $("#hdMontoDescuento").val(response.data.MontoDescuento);
            $("#hdMontoEscala").val(response.data.MontoEscala);
            var mensajePedido = "";

            if (response.data.ErrorProl == false) {
                if (response.data.ObservacionRestrictiva == false && response.data.ObservacionInformativa == false) {
                    mensajePedido += "Tu pedido se guardó con éxito";

                    if (response.data.ProlSinStock) {
                        $("#divTituloObservacionesPROL").html("¡Lo lograste! Tu pedido fue guardado con éxito");
                    }
                    else {
                        $("#divTituloObservacionesPROL").html("¡Lo lograste! Tu pedido fue guardado con éxito");
                        if (response.data.ZonaNuevoProlM == false) {
                            $("#divMensajeObservacionesPROL").html("Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.");
                        }
                    }
                } else {
                    if (response.data.EsDiaProl) {
                        $("#divTituloObservacionesPROL").html("Importante");
                    } else {
                        $("#divTituloObservacionesPROL").html("Aviso");
                    }

                    var html = "<ul>";
                    $.each(response.data.ListaObservacionesProl, function (index, item) {
                        if (response.data.CodigoIso == "BO" || response.data.CodigoIso == "MX") {
                            if (item.Caso == 6 || item.Caso == 8 || item.Caso == 9 || item.Caso == 10) {
                                item.Caso = 105;
                            }
                        }

                        if (item.Caso == 95 || item.Caso == 105) {
                            html += "<li>" + item.Descripcion + "</li>";

                            mensajePedido += item.Caso + " " + item.Descripcion + " ";

                            _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Tipo-' + item.Caso]);
                            dataLayer.push({
                                'event': 'pageview',
                                'virtualUrl': '/Pedido/Mensajes/Tipo-' + item.Caso
                            });
                            return;
                        }

                        if (viewBagMenuNotificaciones == 0 && item.Caso == 0 && response.data.ObservacionInformativa) {
                            html += "<li>" + item.Descripcion + "</li>";

                            mensajePedido += item.Caso + " " + item.Descripcion + " ";

                            _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Tipo-' + item.Caso]);
                            dataLayer.push({
                                'event': 'pageview',
                                'virtualUrl': '/Pedido/Mensajes/Tipo-' + item.Caso
                            });
                        } else {
                            html += "<li>Tu pedido tiene observaciones, por favor revísalo.</li>";

                            mensajePedido += "-1" + " " + "Tu pedido tiene observaciones, por favor revísalo." + " ";
                        }
                    });
                    html += "</ul>";

                    $("#divMensajeObservacionesPROL").html(html);
                }
                mensajePedido = "-1 " + mensajePedido;
            } else {
                mensajePedido = response.data.ListaObservacionesProl[0].Descripcion;

                $("#divTituloObservacionesPROL").html("ERROR");
                $("#divMensajeObservacionesPROL").html("ERROR: " + mensajePedido);
            }

            $("#hdfMensajePedido").val(mensajePedido);

            var montoAhorro = parseFloat(response.data.MontoAhorroCatalogo) + parseFloat(response.data.MontoAhorroRevista);

            $("#spnMontoGanancia").html(DecimalToStringFormat(montoAhorro));

            var montoDescuento = parseFloat(response.data.MontoDescuento);
            var montoEscala = parseFloat(response.data.MontoEscala);
            if (montoDescuento > 0) {               
                var htmlTexto = "";
                htmlTexto += '<p class="monto_descuento">';
                htmlTexto += '<span class="display: inline-block;">DESCUENTO</span><span class="icon-advertencia"></span>:';
                htmlTexto += '</p>';
                htmlTexto += '<p class="monto_montodescuento">';
                htmlTexto += 'MONTO DESCUENTO :';
                htmlTexto += '</p>';
                
                $("#divMontosEscalaDescuentoTexto").html("");
                $("#divMontosEscalaDescuentoTexto").html(htmlTexto);
                $("#divMontosEscalaDescuentoTexto").css("display", "block");

                var htmlMontos = "";
                htmlMontos += '<p class="monto_descuento">';
                htmlMontos += '<b>';
                htmlMontos += $("#hdSimbolo").val() + ' <span class="num" id="spnMontoDescuento"></span>';
                htmlMontos += '</b>';
                htmlMontos += '</p>';
                htmlMontos += '<p class="monto_montodescuento">';
                htmlMontos += '<b>';
                htmlMontos += $("#hdSimbolo").val() + '<span class="num" id="spnMontoEscala"></span>';
                htmlMontos += '</b>';
                htmlMontos += '</p>';
                                        
                $("#divMontosEscalaDescuento").html("");
                $("#divMontosEscalaDescuento").html(htmlMontos);

                var totalConDescuento = Number($("#hdfTotal").val()) - montoDescuento;

                $("#spnMontoDescuento").html(DecimalToStringFormat(montoDescuento));
                $("#spnMontoEscala").html(" " + DecimalToStringFormat(totalConDescuento));
                $("#divMontosEscalaDescuento").css("display", "block");                                
            } else {
                $("#divMontosEscalaDescuentoTexto").html("");
                $("#divMontosEscalaDescuento").html("");
                
                $("#divMontosEscalaDescuentoTexto").css("display", "none");
                $("#divMontosEscalaDescuento").css("display", "none");
            }

            $('#btnValidarPROL').val(response.data.Prol);

            var codigoMensajeProl = response.data.CodigoMensajeProl;
            //var montoTotalPedido = parseFloat($("#hdfTotal").val());

            $("#btnNoGraciasOfertaFinal")[0].data = response.data;
            
            var cumpleOferta;
            if (response.data.Reserva == true) {
                if (response.data.ZonaValida == true) {
                    if (response.data.ObservacionInformativa == false) {
                        cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
                        if (cumpleOferta.resultado) {
                            esPedidoValidado = response.data.ProlSinStock != true;
                            MostrarPopupOfertaFinal(cumpleOferta, 1);
                        } else {
                            if (response.data.ProlSinStock == true) {
                                showDialog("divReservaSatisfactoria3");
                                CargarDetallePedido();
                            } else {
                                showDialog("divReservaSatisfactoria");
                                location.href = baseUrl + 'Pedido/PedidoValidado';
                            }
                        }
                    } else {
                        cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 2, codigoMensajeProl, response.data.ListaObservacionesProl);
                        if (cumpleOferta.resultado) {
                            MostrarPopupOfertaFinal(cumpleOferta, 2);
                        } else {
                            $('#DivObsBut').css({ "display": "none" });
                            $('#DivObsInfBut').css({ "display": "block" });

                            showDialog("divObservacionesPROL");
                            $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");
                        }

                        _gaq.push(['_trackEvent', 'Pedido', 'Observacion-Validar']);
                        dataLayer.push({
                            'event': 'pageview',
                            'virtualUrl': '/Pedido/Observacion-Validar'
                        });
                        CargarDetallePedido();
                    }
                } else {
                    _gaq.push(['_trackEvent', 'Pedido', 'Validar-Sin-Error']);
                    dataLayer.push({
                        'event': 'pageview',
                        'virtualUrl': '/Pedido/Validar-Sin-Error'
                    });

                    cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
                    if (cumpleOferta.resultado) {
                        MostrarPopupOfertaFinal(cumpleOferta, 1);
                    } else {
                        if (viewBagNombrePais == 'Venezuela') {
                            showDialog("divReservaSatisfactoriaVE");
                        } else {
                            if (viewBagNombrePais == 'Colombia') {
                                showDialog("divReservaSatisfactoriaCO");
                            } else {
                                showDialog("divReservaSatisfactoria3");
                            }
                        }
                    }

                    CargarDetallePedido();
                }
            } else {
                $('#DivObsBut').css({ "display": "block" });
                $('#DivObsInfBut').css({ "display": "none" });

                cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 2, codigoMensajeProl, response.data.ListaObservacionesProl);
                if (cumpleOferta.resultado) {
                    MostrarPopupOfertaFinal(cumpleOferta, 2);
                } else {
                    showDialog("divObservacionesPROL");
                    $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");
                }

                _gaq.push(['_trackEvent', 'Pedido', 'Observacion-Validar']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Pedido/Observacion-Validar'
                });
                CargarDetallePedido();
            }
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
            }
        }
    });
}

function EjecutarServicioPROLSinOfertaFinal() {
    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/EjecutarServicioPROL',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        //async: false,
        success: function (response) {
            CerrarSplash();

            $("#hdfAccionPROL").val(response.data.Prol);
            $("#hdfReserva").val(response.data.Reserva);
            $("#hdfObsInfor").val(response.data.ObservacionInformativa);
            $("#hdfModificaPedido").val(response.data.EsModificacion);
            $("#hdfZonaValida").val(response.data.ZonaValida);
            $("#hdfPROLSinStock").val(response.data.ProlSinStock);
            $("#hdMontoAhorroCatalogo").val(response.data.MontoAhorroCatalogo);
            $("#hdMontoAhorroRevista").val(response.data.MontoAhorroRevista);
            $("#hdMontoDescuento").val(response.data.MontoDescuento);
            $("#hdMontoEscala").val(response.data.MontoEscala);
            var mensajePedido = "";            

            if (response.data.ErrorProl == false) {
                if (response.data.ObservacionRestrictiva == false && response.data.ObservacionInformativa == false) {
                    mensajePedido += "Tu pedido se guardó con éxito";

                    if (response.data.ProlSinStock) {
                        $("#divTituloObservacionesPROL").html("¡Lo lograste! Tu pedido fue guardado con éxito");
                    }
                    else {
                        $("#divTituloObservacionesPROL").html("¡Lo lograste! Tu pedido fue guardado con éxito");
                        if (response.data.ZonaNuevoProlM == false) {
                            $("#divMensajeObservacionesPROL").html("Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.");
                        }
                    }
                } else {
                    if (response.data.EsDiaProl) {
                        $("#divTituloObservacionesPROL").html("Importante");
                    } else {
                        $("#divTituloObservacionesPROL").html("Aviso");
                    }

                    var html = "<ul>";
                    $.each(response.data.ListaObservacionesProl, function (index, item) {
                        if (response.data.CodigoIso == "BO" || response.data.CodigoIso == "MX") {
                            if (item.Caso == 6 || item.Caso == 8 || item.Caso == 9 || item.Caso == 10) {
                                item.Caso = 105;
                            }
                        }

                        if (item.Caso == 95 || item.Caso == 105) {
                            html += "<li>" + item.Descripcion + "</li>";

                            mensajePedido += item.Caso + " " + item.Descripcion + " ";

                            _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Tipo-' + item.Caso]);
                            dataLayer.push({
                                'event': 'pageview',
                                'virtualUrl': '/Pedido/Mensajes/Tipo-' + item.Caso
                            });
                            return;
                        }

                        if (viewBagMenuNotificaciones == 0 && item.Caso == 0 && response.data.ObservacionInformativa) {
                            html += "<li>" + item.Descripcion + "</li>";

                            mensajePedido += item.Caso + " " + item.Descripcion + " ";

                            _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Tipo-' + item.Caso]);
                            dataLayer.push({
                                'event': 'pageview',
                                'virtualUrl': '/Pedido/Mensajes/Tipo-' + item.Caso
                            });
                        } else {
                            html += "<li>Tu pedido tiene observaciones, por favor revísalo.</li>";

                            mensajePedido += "-1" + " " + "Tu pedido tiene observaciones, por favor revísalo." + " ";
                        }
                    });
                    html += "</ul>";

                    $("#divMensajeObservacionesPROL").html(html);
                }
                mensajePedido = "-1 " + mensajePedido;
            } else {
                mensajePedido = response.data.ListaObservacionesProl[0].Descripcion;

                $("#divTituloObservacionesPROL").html("ERROR");
                $("#divMensajeObservacionesPROL").html("ERROR: " + mensajePedido);
            }

            $("#hdfMensajePedido").val(mensajePedido);

            var montoAhorro = parseFloat(response.data.MontoAhorroCatalogo) + parseFloat(response.data.MontoAhorroRevista);

            $("#spnMontoGanancia").html(DecimalToStringFormat(montoAhorro));

            var montoDescuento = parseFloat(response.data.MontoDescuento);
            var montoEscala = parseFloat(response.data.MontoEscala);
            if (montoDescuento > 0) {
                var htmlTexto = "";
                htmlTexto += '<p class="monto_descuento">';
                htmlTexto += '<span class="display: inline-block;">DESCUENTO</span><span class="icon-advertencia"></span>:';
                htmlTexto += '</p>';
                htmlTexto += '<p class="monto_montodescuento">';
                htmlTexto += 'MONTO DESCUENTO :';
                htmlTexto += '</p>';

                $("#divMontosEscalaDescuentoTexto").html("");
                $("#divMontosEscalaDescuentoTexto").html(htmlTexto);
                $("#divMontosEscalaDescuentoTexto").css("display", "block");

                var htmlMontos = "";
                htmlMontos += '<p class="monto_descuento">';
                htmlMontos += '<b>';
                htmlMontos += $("#hdSimbolo").val() + ' <span class="num" id="spnMontoDescuento"></span>';
                htmlMontos += '</b>';
                htmlMontos += '</p>';
                htmlMontos += '<p class="monto_montodescuento">';
                htmlMontos += '<b>';
                htmlMontos += $("#hdSimbolo").val() + '<span class="num" id="spnMontoEscala"></span>';
                htmlMontos += '</b>';
                htmlMontos += '</p>';

                $("#divMontosEscalaDescuento").html("");
                $("#divMontosEscalaDescuento").html(htmlMontos);

                var totalConDescuento = Number($("#hdfTotal").val()) - montoDescuento;

                $("#spnMontoDescuento").html(DecimalToStringFormat(montoDescuento));
                $("#spnMontoEscala").html(" "+DecimalToStringFormat(totalConDescuento));
                $("#divMontosEscalaDescuento").css("display", "block");
            } else {
                $("#divMontosEscalaDescuentoTexto").html("");
                $("#divMontosEscalaDescuento").html("");

                $("#divMontosEscalaDescuentoTexto").css("display", "none");
                $("#divMontosEscalaDescuento").css("display", "none");
            }

            $('#btnValidarPROL').val(response.data.Prol);

            $("#btnNoGraciasOfertaFinal")[0].data = response.data;
            MostrarMensajeProl(response.data);                        
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
            }
        }
    });
}

function MostrarMensajeProl(data) {
    if (data.Reserva == true) {
        if (data.ZonaValida == true) {
            if (data.ObservacionInformativa == false) {
                if (data.ProlSinStock == true) {
                    showDialog("divReservaSatisfactoria3");
                    CargarDetallePedido();
                } else {
                    showDialog("divReservaSatisfactoria");
                    setTimeout(function () {
                        location.href = baseUrl + 'Pedido/PedidoValidado';
                    }, 8000);
                }
            } else {
                $('#DivObsBut').css({ "display": "none" });
                $('#DivObsInfBut').css({ "display": "block" });

                showDialog("divObservacionesPROL");
                $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");

                _gaq.push(['_trackEvent', 'Pedido', 'Observacion-Validar']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Pedido/Observacion-Validar'
                });
                CargarDetallePedido();
            }
        } else {
            _gaq.push(['_trackEvent', 'Pedido', 'Validar-Sin-Error']);
            dataLayer.push({
                'event': 'pageview',
                'virtualUrl': '/Pedido/Validar-Sin-Error'
            });

            if (viewBagNombrePais == 'Venezuela') {
                showDialog("divReservaSatisfactoriaVE");
            } else {
                if (viewBagNombrePais == 'Colombia') {
                    showDialog("divReservaSatisfactoriaCO");
                } else {
                    showDialog("divReservaSatisfactoria3");
                }
            }

            CargarDetallePedido();
        }
    } else {
        $('#DivObsBut').css({ "display": "block" });
        $('#DivObsInfBut').css({ "display": "none" });

        showDialog("divObservacionesPROL");
        $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");

        _gaq.push(['_trackEvent', 'Pedido', 'Observacion-Validar']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Pedido/Observacion-Validar'
        });
        CargarDetallePedido();
    }
}

function MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar) {
    $('.js-slick-prev-of').remove();
    $('.js-slick-next-of').remove();
    $('#divCarruselOfertaFinal').unslick();
    $('#divCarruselOfertaFinal').html('<div style="text-align: center;">Actualizando Productos de Oferta Final<br><img src="' + urlLoad + '" /></div>');

    SetHandlebars("#ofertaFinal-template", cumpleOferta.productosMostrar, "#divCarruselOfertaFinal");
    
    $("#divOfertaFinal").show();

    $('#divCarruselOfertaFinal').slick({
        infinite: true,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        centerMode: false,
        centerPadding: '0',
        tipo: 'p', // popup
        prevArrow: '<a class="previous_ofertas js-slick-prev-of"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
        nextArrow: '<a class="previous_ofertas next js-slick-next-of"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
    });

    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-of"));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-of"));
                    
    CargandoValoresPopupOfertaFinal(tipoPopupMostrar, cumpleOferta.montoFaltante, cumpleOferta.porcentajeDescuento);
}

function CargandoValoresPopupOfertaFinal(tipoPopupMostrar, montoFaltante, porcentajeDescuento) {
    var formatoMontoFaltante = DecimalToStringFormat(montoFaltante);
    if (tipoPopupMostrar == 1) {
        $("#divIconoOfertaFinal").addClass("icono_aprobacion");
        $("#spnTituloOfertaFinal").html("GUARDASTE TU<b>&nbsp;PEDIDO CON ÉXITO!</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $("#spnMensajeOfertaFinal").html("&nbsp;para conseguir " + porcentajeDescuento + "% DSCTO y gana más esta campaña.");
        $("#spnSubTituloOfertaFinal").html("Consigue más ganancias agregando uno de estos productos");
    } else {
        $("#divIconoOfertaFinal").addClass("icono_exclamacion");
        $("#spnTituloOfertaFinal").html("TODAVIA<b>&nbsp;TE FALTA UN POCO</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $("#spnMensajeOfertaFinal").html("&nbsp;para llegar al monto mínimo y guardar tu pedido");
        $("#spnSubTituloOfertaFinal").html("Completa tu pedido con alguno de estos productos");
    }

    $("#divOfertaFinal").show();
}

function CumpleOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var resultado = false;
    var productosMostrar = new Array();
    var montoFaltante = 0;
    var porcentajeDescuento = 0;

    var tipoOfertaFinal = $("#hdOfertaFinal").val();
    var esOfertaFinalZonaValida = $("#hdEsOfertaFinalZonaValida").val();
    var esFacturacion = $("#hdEsFacturacion").val();

    if (tipoOfertaFinal == "1" || tipoOfertaFinal == "2")
        resultado = true;

    if (resultado) {
        if (esFacturacion == "True" && esOfertaFinalZonaValida == "True")
            resultado = true;
        else
            resultado = false;
    }

    if (resultado) {
        var cumpleParametria = CumpleParametriaOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
        if (cumpleParametria.resultado) {
            montoFaltante = cumpleParametria.montoFaltante;
            porcentajeDescuento = cumpleParametria.porcentajeDescuento;
            var listaProductoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);

            if (listaProductoOfertaFinal != null) {
                $.each(listaProductoOfertaFinal, function(index, value) {
                    if (value.PrecioCatalogo >= montoFaltante && value.PrecioCatalogo > cumpleParametria.precioMinimoOfertaFinal) {
                        productosMostrar.push(value);
                        //return false;
                    }
                });

                if (productosMostrar.length == 0) {
                    resultado = false;
                } else {
                    resultado = true;
                }
            } else {
                resultado = false;
            }
        }            
        else
            resultado = false;
    }

    return {
        resultado: resultado,
        productosMostrar: productosMostrar,
        montoFaltante: montoFaltante,
        porcentajeDescuento: porcentajeDescuento
    };
}

function CumpleParametriaOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var resultado = false;
    var montoFaltante = 0;
    var porcentajeDescuento = 0;
    var precioMinimoOfertaFinal = 0;

    //Escala
    if (tipoPopupMostrar == 1) {
        var esConsultoraNueva = $("#hdEsConsultoraNueva").val();
        if (esConsultoraNueva == "False") {
            if (codigoMensajeProl == "00") {
                var escalaDescuento = null;
                var escalaDescuentoSiguiente = null;

                $.each(listaEscalaDescuento, function (index, value) {
                    if (value.MontoHasta >= monto) {
                        escalaDescuento = value;

                        if (index <= listaEscalaDescuento.length - 1) {
                            escalaDescuentoSiguiente = listaEscalaDescuento[index + 1];
                        } else {
                            escalaDescuentoSiguiente = null;
                        }

                        return false;
                    }
                });

                if (escalaDescuento == null) {
                    resultado = false;
                } else {
                    var diferenciaMontoEd = escalaDescuento.MontoHasta - monto;
                    var parametriaEd = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "E" + escalaDescuento.PorDescuento) : null;

                    if (parametriaEd != null && parametriaEd.length != 0) {
                        if (parametriaEd[0].MontoDesde <= diferenciaMontoEd && parametriaEd[0].MontoHasta >= diferenciaMontoEd) {
                            montoFaltante = diferenciaMontoEd;
                            porcentajeDescuento = escalaDescuentoSiguiente.PorDescuento;
                            precioMinimoOfertaFinal = parametriaEd[0].PrecioMinimo;
                            resultado = true;
                        } else {
                            resultado = false;
                        }
                    } else {
                        resultado = false;
                    }
                }
            }
        }        
    } else {
        //Monto Minimo y Maximo
        if (codigoMensajeProl == "01") {
            var tipoError = listaObservacionesProl[0].Caso;

            if (tipoError == 95) {
                //var mensajePedido = listaObservacionesProl[0].Descripcion || "";
                var mensajeCUV = listaObservacionesProl[0].CUV;

                if (mensajeCUV == "XXXXX") {
                    var montoMinimo = parseFloat($("#hdMontoMinimo").val());
                    var diferenciaMonto = montoMinimo - monto;

                    var parametria = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "MM") : null;

                    if (parametria != null && parametria.length != 0) {
                        if (parametria[0].MontoDesde <= diferenciaMonto && parametria[0].MontoHasta >= diferenciaMonto) {
                            montoFaltante = diferenciaMonto;
                            precioMinimoOfertaFinal = parametria[0].PrecioMinimo;
                            resultado = true;
                        } else {
                            resultado = false;
                        }
                    } else {
                        resultado = false;
                    }
                } else {
                    resultado = false;
                }
            } else {
                resultado = false;
            }
        }
    }

    return {
        resultado: resultado,
        montoFaltante: montoFaltante,
        porcentajeDescuento: porcentajeDescuento,
        precioMinimoOfertaFinal: precioMinimoOfertaFinal
    };
}

function ObtenerProductosOfertaFinal(tipoOfertaFinal) {
    var item = { tipoOfertaFinal: tipoOfertaFinal };

    var lista = null;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerProductosOfertaFinal',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    lista = response.data;
                } else {
                    lista = null;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
                lista = null;
                //CerrarSplash();
            }
        }
    });

    return lista;
}

function EliminarPedido() {
    if (HorarioRestringido()) {
        CerrarSplash();
        return;
    }

    var listaDetallePedido = new Array();
    var campania = $("#hdCampaniaCodigo").val();

    $.each($("#tbobyDetallePedido tr"), function(index, value) {
        var cuv = $(value).attr("data-cuv");
        var cantidad = $(value).find(".liquidacion_rango_cantidad_pedido").val();

        var detalle = {
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        };

        listaDetallePedido.push(detalle);
    });

    var item = {};
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/DeleteAll',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                location.href = baseUrl + 'Pedido/Index';
                MostrarBarra(data);
                TrackingJetloreRemoveAll(listaDetallePedido);
                CerrarSplash();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert_msg(data.message);
                CerrarSplash();
            }
        }
    });
}

function EjecutarPROL2() {
    _gaq.push(['_trackEvent', 'Pedido', 'Validar-Pedido', 'Validar']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Pedido/Validar-Pedido/Validar'
    });
    $('#divConfirmValidarPROL').dialog('close');
    EjecutarPROL();
}

function AbrirModal(tipo) {
    switch (tipo) {
        case 1:
            showDialog("divFaltantesAnunciados");
            break;
        case 2:
            showDialog("divOfertasWeb");
            break;
    }
}

function AceptarObsInformativas() {
    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarDesglose',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if ($('#hdfPROLSinStock').val() == 'True') {
                        $('#divObservacionesPROL').dialog('close');
                        showDialog("divReservaSatisfactoria3");
                        $("#divReservaSatisfactoria3").siblings(".ui-dialog-titlebar").hide();
                        CargarDetallePedido();
                    } else
                        location.href = baseUrl + 'Pedido/PedidoValidado';
                } else {
                    alert_msg(data.message);
                }
            }
            CerrarSplash();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarSplash();
                alert_msg("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
}

function CancelarObsInformativas() {
    if ($('#hdfModificaPedido').val() != 'True') {
        AbrirSplash();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'Pedido/PedidoValidadoDeshacerReserva?Tipo=PI',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    if (data.success == true) {
                        $('#divObservacionesPROL').dialog('close');
                        CerrarSplash();
                    } else {
                        CerrarSplash();
                        alert_msg(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    CerrarSplash();
                    alert_msg("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
                }
            }
        });
    } else {
        $('#divObservacionesPROL').dialog('close');
    }
}

function CalcularTotalPedido(Total, Total_Minimo) {
    var paisColombia = "4";
    if (paisColombia == viewBagPaisID) {
        Total = Total.replace(/\,/g, '');
        Total = parseFloat(Total).toFixed(0);
        $('#sTotal').html(SeparadorMiles(Total));
        $('#hdfTotal').val(SeparadorMiles(Total));
        $("#spPedidoWebAcumulado").text(vbSimbolo + " " + SeparadorMiles(Total));
    } else {
        Total = parseFloat(Total.replace(',', ''));
        $('#sTotal').html(parseFloat(Total).toFixed(2));
        $('#hdfTotal').val(parseFloat(Total).toFixed(2));
        $("#spPedidoWebAcumulado").text(vbSimbolo + " " + parseFloat(Total).toFixed(2));
    }
    CargarResumenCampaniaHeader();
}

function ValidarUpdate(PedidoDetalleID, FlagValidacion) {
    var CliID = $('#hdfLPCli' + PedidoDetalleID).val();
    var CliDes = $('#txtLPCli' + PedidoDetalleID).val();
    var CliDesVal = $('#hdfLPCliDes' + PedidoDetalleID).val();
    var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
    var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();
    var ClienteAnti = $('#hdfLPTempCliDes' + PedidoDetalleID).val();
    var DesProd = $('#lblLPDesProd' + PedidoDetalleID).html();

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad)
            return false;
    } else {
        if (ClienteAnti == CliDes)
            return false;
    }

    if (Cantidad.length == 0) {
        alert_msg('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        alert_msg('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (CliDes.length != 0 && CliDes != CliDesVal) {
        alert_msg('Por favor ingrese un cliente válido.');
        return false;
    }

    return true;
}

function UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi) {
    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion);
    if (!val) {
        return false;
    }

    var CliID = $('#hdfLPCli' + PedidoDetalleID).val();
    var CliDes = $('#txtLPCli' + PedidoDetalleID).val();
    var CliDesVal = $('#hdfLPCliDes' + PedidoDetalleID).val();
    var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
    var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();
    var ClienteAnti = $('#hdfLPTempCliDes' + PedidoDetalleID).val();
    var DesProd = $('#lblLPDesProd' + PedidoDetalleID).html();

    var PrecioUnidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    if (CliDes.length == 0) {
        CliID = 0
    }

    var Cantidad = CantidadModi;
    var Unidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    var Total = parseFloat(Cantidad * Unidad).toFixed(2);
    var ClienteID_ = $('#ddlClientes').val();
    $('#lblLPImpTotal' + PedidoDetalleID).html(Total);
    $('#lblLPImpTotalMinimo' + PedidoDetalleID).html(Total);
    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        ClienteDescripcion: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: ClienteID_
    };

    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/Update',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                CerrarSplash();
                if (data.success == true) {
                    var item = data.items;
                    if ($('#txtLPCli' + PedidoDetalleID).val().length == 0) {
                        $('#hdfLPCliDes' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                        $('#txtLPCli' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                    }
                    $('#txtLPTempCant' + PedidoDetalleID).val($('#txtLPCant' + PedidoDetalleID).val());

                    var nomCli = $("#ddlClientes option:selected").text();
                    var simbolo = data.Simbolo;
                    var monto = data.Total_Cliente;

                    $(".pMontoCliente").css("display", "none");

                    if (data.ClienteID_ != "-1") {
                        $(".pMontoCliente").css("display", "block");
                        $("#spnNombreCliente").html(nomCli + " :");
                        $("#spnTotalCliente").html(simbolo + monto);
                    }

                    CalcularTotalPedido(data.Total, data.Total_Minimo);

                    MostrarBarra(data);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarSplash();
                alert_msg(data.message);
            }
        }
    });
}

function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {
    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion);
    if (!val) {
        return false;
    }

    var CliID = $('#hdfLPCli' + PedidoDetalleID).val();
    var CliDes = $('#txtLPCli' + PedidoDetalleID).val();
    var CliDesVal = $('#hdfLPCliDes' + PedidoDetalleID).val();
    var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
    var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();
    var ClienteAnti = $('#hdfLPTempCliDes' + PedidoDetalleID).val();
    var DesProd = $('#lblLPDesProd' + PedidoDetalleID).html();
    var ClienteID_ = $('#ddlClientes').val();

    var PrecioUnidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    if (CliDes.length == 0) {
        CliID = 0;
    }

    var Unidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    var Total = parseFloat(Cantidad * Unidad).toFixed(2)
    $('#lblLPImpTotal' + PedidoDetalleID).html(DecimalToStringFormat(Total));
    $('#lblLPImpTotalMinimo' + PedidoDetalleID).html(Total);
    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        Nombre: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: ClienteID_
    };

    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/Update',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CerrarSplash();

            if (!checkTimeout(data))
                return false;

            if (data.success != true)
                return false;

            if ($('#txtLPCli' + PedidoDetalleID).val().length == 0) {
                $('#hdfLPCliDes' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                $('#txtLPCli' + PedidoDetalleID).val($('#hdfNomConsultora').val());
            }
            $('#txtLPTempCant' + PedidoDetalleID).val($('#txtLPCant' + PedidoDetalleID).val());

            var nomCli = $("#ddlClientes option:selected").text();
            var simbolo = data.Simbolo;
            var monto = data.Total_Cliente;

            $(".pMontoCliente").css("display", "none");

            if (data.ClienteID_ != "-1") {
                $(".pMontoCliente").css("display", "block");
                $("#spnNombreCliente").html(nomCli + " :");
                $("#spnTotalCliente").html(simbolo + monto);
            }

            //$('#sTotal').html(data.TotalFormato);
            $('#hdfTotal').val(data.Total);
            $("#spPedidoWebAcumulado").text(vbSimbolo + " " + data.TotalFormato);

            var totalUnidades = parseInt($("#pCantidadProductosPedido").html());
            totalUnidades = totalUnidades - parseInt(CantidadAnti) + parseInt(Cantidad);
            $("#pCantidadProductosPedido").html(totalUnidades);

            MostrarBarra(data);
            
            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
                TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                alert_msg(data.message);
            }
        }
    });
}

function UpdateLiquidacion(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi) {
    AbrirSplash();
    if (HorarioRestringido()) {
        CerrarSplash();
        return false;
    }

    var cant = $('#txtLPCant' + PedidoDetalleID).val();
    var cantAnti = $('#txtLPTempCant' + PedidoDetalleID).val();

    if (cant == cantAnti) {
        CerrarSplash();
        return false;
    }

    if (cant == "" || cant == "0") {
        alert_msg("Ingrese una cantidad mayor que cero.");
        $('#txtLPCant' + PedidoDetalleID).val("1");
        CerrarSplash();
        return false;
    }

    if (parseInt(cant) == NaN) {
        CerrarSplash();
        return false;
    }

    if (TipoOfertaSisID == constConfiguracionOfertaLiquidacion) {
        var PROL = $("#hdValidarPROL").val();

        $.ajaxSetup({
            cache: false
        });

        var val = ValidarUpdate(PedidoDetalleID, FlagValidacion);
        if (!val) {
            CerrarSplash();
            return false;
        }

        var CliID = $('#hdfLPCli' + PedidoDetalleID).val();
        var CliDes = $('#txtLPCli' + PedidoDetalleID).val();
        var CliDesVal = $('#hdfLPCliDes' + PedidoDetalleID).val();
        var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
        var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();
        var ClienteAnti = $('#hdfLPTempCliDes' + PedidoDetalleID).val();
        var DesProd = $('#lblLPDesProd' + PedidoDetalleID).html();

        var Flag = 0;
        var StockNuevo = 0;
        if (parseInt(CantidadAnti) > parseInt(Cantidad)) {
            Flag = 1;
            StockNuevo = parseInt(CantidadAnti) - parseInt(Cantidad);
        } else if (parseInt(Cantidad) > parseInt(CantidadAnti)) {
            Flag = 2;
            StockNuevo = parseInt(Cantidad) - parseInt(CantidadAnti);
        }

        var PrecioUnidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
        if (CliDes.length == 0) {
            CliID = 0;
        }
        AbrirSplash();
        $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
            CerrarSplash();
            var Saldo = data.Saldo;
            var UnidadesPermitidas = data.UnidadesPermitidas;
            var CantidadPedida = data.CantidadPedida;
            Cantidad = parseInt(Cantidad) + parseInt(CantidadPedida);

            if (parseInt(data.UnidadesPermitidas) < parseInt(Cantidad)) {
                if (PROL == "1") {
                    UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi);
                    $('#txtLPCant' + PedidoDetalleID).val(CantidadModi);
                } else
                    $('#txtLPCant' + PedidoDetalleID).val($('#txtLPTempCant' + PedidoDetalleID).val());

                if (Saldo == UnidadesPermitidas)
                    alert_msg("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                else {
                    if (Saldo == "0")
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                    else
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                }
                return false;
            } else {
                AbrirSplash();
                $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                    var CantidadActual = $('#txtLPCant' + PedidoDetalleID).val();
                    var CantidadaValidar = parseInt(CantidadActual) - parseInt(CantidadAnti);
                    if (parseInt(data.Stock) < parseInt(CantidadaValidar)) {
                        if (PROL == "1") {
                            UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi);
                            $('#txtLPCant' + PedidoDetalleID).val(CantidadModi);
                        } else
                            $('#txtLPCant' + PedidoDetalleID).val($('#txtLPTempCant' + PedidoDetalleID).val());

                        alert_msg("Lamentablemente, no puede actualizar la cantidad del Producto , ya que sobrepasa el stock actual (" + data.Stock + "), verifique");
                        CerrarSplash();
                        return false;
                    } else {
                        var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
                        var Unidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
                        var Total = parseFloat(Cantidad * Unidad).toFixed(2);
                        $('#lblLPImpTotal' + PedidoDetalleID).html(Total);
                        var ClienteID_ = $('#ddlClientes').val();
                        var item = {
                            CampaniaID: CampaniaID,
                            PedidoID: PedidoID,
                            PedidoDetalleID: PedidoDetalleID,
                            ClienteID: CliID,
                            Cantidad: Cantidad,
                            PrecioUnidad: PrecioUnidad,
                            ClienteDescripcion: CliDes,
                            DescripcionProd: DesProd,
                            Stock: StockNuevo,
                            Flag: Flag,
                            TipoOfertaSisID: TipoOfertaSisID,
                            CUV: CUV,
                            ClienteID_: ClienteID_
                        };

                        AbrirSplash();
                        jQuery.ajax({
                            type: 'POST',
                            url: baseUrl + 'Pedido/Update',
                            dataType: 'json',
                            contentType: 'application/json; charset=utf-8',
                            data: JSON.stringify(item),
                            async: true,
                            success: function (data) {
                                if (checkTimeout(data)) {
                                    CerrarSplash();
                                    if (data.success == true) {
                                        var item = data.items;
                                        if ($('#txtLPCli' + PedidoDetalleID).val().length == 0) {
                                            $('#hdfLPCliDes' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                                            $('#txtLPCli' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                                        }
                                        if (PROL == "0")
                                            $('#txtLPTempCant' + PedidoDetalleID).val($('#txtLPCant' + PedidoDetalleID).val());

                                        var nomCli = $("#ddlClientes option:selected").text();
                                        var simbolo = data.Simbolo;
                                        var monto = data.Total_Cliente;

                                        $(".pMontoCliente").css("display", "none");

                                        if (data.ClienteID_ != "-1") {
                                            $(".pMontoCliente").css("display", "block");
                                            $("#spnNombreCliente").html(nomCli + " :");
                                            $("#spnTotalCliente").html(simbolo + monto);
                                        }

                                        CalcularTotalPedido(data.Total, data.Total_Minimo);

                                        var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
                                        if (diferenciaCantidades > 0)
                                            TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
                                        else if (diferenciaCantidades < 0)
                                            TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);


                                        MostrarBarra(data);
                                    }
                                }
                            },
                            error: function (data, error) {
                                CerrarSplash();
                                if (checkTimeout(data)) {
                                    alert_msg(data.message);
                                }
                            }
                        });
                    }
                });
            }
        });
    } else {
        var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();

        var param = ({
            MarcaID: 0,
            CUV: CUV,
            PrecioUnidad: 0,
            Descripcion: 0,
            Cantidad: $('#txtLPCant' + PedidoDetalleID).val(),
            IndicadorMontoMinimo: 0,
            TipoOferta: 1
        });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'Pedido/ValidarStockEstrategia',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(param),
            async: true,
            success: function (datos) {
                if (!datos.result) {
                    alert_msg(datos.message);
                    CerrarSplash();
                    $('#txtLPCant' + PedidoDetalleID).val(CantidadAnti);
                    return false;
                } else {
                    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    HideDialog("divVistaPrevia");
                    CerrarSplash();
                }
            }
        });
    }
}

function BlurF(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {
    if (isShown)
        return true;

    // validar cambio de cliente

    var idPed = $("#divListadoPedido").find("input.classClienteNombre").attr('datapedido');
    var cliAnt = $("#hdfLPCliIni" + idPed).val();
    var cliNue = $("#hdfLPCli" + idPed).val();
    if (cliAnt == cliNue) {
        //por verificar
        $("#txtLPCli" + idPed).val($("#hdfLPCliDes" + idPed).val());
        return true;
    }

    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
}

function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
};

function InfoCommerceGoogleProductoRecomendados() {
    var cantidadProductosRecomendado = $("#hdCantItemRecomendado").val();
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val();

    if (cantidadProductosRecomendado == undefined || cadListaRecomendados == undefined) {
        return false;
    }

    var listaRecomendados = JSON.parse(cadListaRecomendados);
    var arrayEstrategiaRecomendado = new Array();
    if (parseInt(cantProductosLoad) < parseInt(cantidadProductosRecomendado)) {
        var posProductoEstrategia = 0;
        var variantcadEstrategia = "";
        var categoriacadEstrategia = "";
        $.each(listaRecomendados, function (index, item) {
            if (item.CUV2 != "00000") {
                posProductoEstrategia += 1;
                //Arreglo con productos completos
                if (item.DescripcionEstrategia == null || item.DescripcionEstrategia == "") {
                    variantcadEstrategia = "Estándar";
                } else {
                    variantcadEstrategia = item.DescripcionEstrategia;
                }
                if (item.DescripcionCategoria == null || item.DescripcionCategoria == "") {
                    categoriacadEstrategia = "Sin Categoría";
                } else {
                    categoriacadEstrategia = item.DescripcionCategoria;
                }
                arrayEstrategiaRecomendado.push(
                    {
                        name: item.DescripcionCUV2,
                        id: item.CUV2,
                        price: item.Precio2.toString(),
                        brand: item.DescripcionMarca,
                        category: categoriacadEstrategia,
                        variant: variantcadEstrategia,
                        list: "Productos destacados (actualizado) - Pedido",
                        position: posProductoEstrategia
                    });
            }
        });
        //Validando si existen datos en el Arreglo
        if (arrayEstrategiaRecomendado != null) {
            if (arrayEstrategiaRecomendado.length > 0) {
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategiaRecomendado
                    }
                });
            }
        }
    }
}

function InfoCommerceGoogleDestacadoPreviousCarrusel() {
    if ($.parseJSON(arregloProductos) != null) {
        // La marcación se realiza cuando hay más de 3 productos que se muestran al inicio.
        if ($.parseJSON(arregloProductos).length > 3) {
            var jsonArray = $.parseJSON(arregloProductos);
            var posicionTotal = jsonArray.length - 1;

            if (jsonArray.length > 0) {
                if (posicionFinalPantalla == 0) {
                    posicionFinalPantalla = posicionTotal;
                } else {
                    posicionFinalPantalla -= 1;
                }

                if (posicionInicial == 0) {
                    posicionInicial = posicionTotal;
                } else {
                    posicionInicial -= 1;
                }

                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': jsonArray[posicionInicial]
                    }
                });
            }
        }
    }
}

function InfoCommerceGoogleDestacadoNextCarrusel() {
    if ($.parseJSON(arregloProductos) != null) {
        // La marcación se realiza cuando hay más de 3 productos que se muestran al inicio.
        if ($.parseJSON(arregloProductos).length > 3) {
            var jsonArray = $.parseJSON(arregloProductos);
            var posicionTotal = jsonArray.length - 1;

            if (jsonArray.length > 0) {
                if (posicionFinalPantalla == posicionTotal) {
                    posicionFinalPantalla = 0;
                } else {
                    posicionFinalPantalla += 1;
                }

                if (posicionInicial == posicionTotal) {
                    posicionInicial = 0;
                } else {
                    posicionInicial += 1;
                }

                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': jsonArray[posicionFinalPantalla]
                    }
                });
            }
        }
    }
}

function InfoCommerceGoogleDestacadoProductClick(name, id, category, variant, position) {
    if (variant == null || variant == "") {
        variant = "Estándar";
    }
    if (category == null || category == "") {
        category = "Sin Categoría";
    }

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': 'Productos destacados', 'action': 'click' },
                'products': [{
                    'name': name,
                    'id': id,
                    'category': category,
                    'variant': variant,
                    'position': position
                }]
            }
        }
    });
}

function TagManagerCarruselPrevia(esDrag) {
}

function TagManagerCarruselSiguiente(esDrag) {
}

function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    CargarDetallePedido(rpt.page, rpt.rows);
    return true;
}

function AgregarProducto(url, model, divDialog, cerrarSplash) {
    AbrirSplash();

    tieneMicroefecto = true;    
    
    divDialog = $.trim(divDialog);

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/' + url,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) {
                if (cerrarSplash) CerrarSplash();
                return false;
            }

            if (response.success == true) {
                $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                if (divDialog != "") {
                    $("#" + divDialog).dialog("close");
                }

                if (model != null && model != undefined)
                    PedidoOnSuccessSugerido(model);

                CargarDetallePedido();
                CargarResumenCampaniaHeader();
                if (cerrarSplash) CerrarSplash();
                MostrarBarra(response);
                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
            } else {
                if (cerrarSplash) CerrarSplash();
            }
            return true;
        },
        error: function (data, error) {
            tieneMicroefecto = false;
            AjaxError(data, error);
        }
    });
}

function CargarProductoAgotados() {
    AbrirSplash();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetProductoFaltante',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) {
                CerrarSplash();
                return false;
            }

            CerrarSplash();
            if (response.result) {
                $("#tblProductoSugerido").html('');
                var html = '<table>';
                html += '<tr>';
                html += '<th class="codigo_productoAgotado">Código</th>';
                html += '<th class="producto_productoAgotado">Producto</th>';
                html += '</tr>';

                var lista = response.data;

                $.each(lista, function (index, value) {
                    html += '<tr>';
                    html += '<td class="codigo_productoAgotado">' + value.CUV + '</td>';
                    html += '<td class="producto_productoAgotado">' + value.Descripcion + '</td>';
                    html += '</tr>';
                });

                html += '</table>';

                $("#tblProductoSugerido").html(html);
                $("#divProductoAgotado").show();
            } else {
                alert(response.data);
            }

            return true;
        },
        error: function (data, error) {
            AjaxError(data, error);
        }
    });
}

function AjaxError(data) {
    CerrarSplash();
    if (checkTimeout(data)) {
        alert_msg(data.message);
    }
}

// Barra

function MostrarBarra(datax) {
    //$("#divBarra").hide();
    //return false;

    //return;
    $("#divBarra #divLimite").html("");
    var datax = datax || new Object();
    data = datax.dataBarra || datax.DataBarra || dataBarra || new Object();
    dataBarra = data;
    ActualizarGanancia(data);

    ActualizarGanancia(data);

    //data.MontoMinimo = 100;
    //data.MontoMinimoStr = "100.00";
    //data.TippingPoint = 150.99;
    //data.TippingPointStr = "150.99";
    //data.MontoMaximo = 200.99;
    //data.MontoMaximoStr = "200.99";
    //data.MontoEscala = 2900.99;
    //data.MontoEscalaStr = "2900.99";

    var me = data.MontoEscala;
    var md = data.MontoDescuento;
    var mx = data.MontoMaximo;
    var mn = data.MontoMinimo;
    var tp = data.TippingPoint;
    var mt = data.TotalPedido;

    var salto = "<br>";
    var listaLimite = new Array();

    var widthTotal = $("#divListadoPedido").outerWidth();
    var wPrimer = 0;
    var vLogro = 0;
    var wMsgFin = 0;
    var wmin = 45; //parseInt(parseInt(widthTotal, 10) / 20, 10);

    if (!(mn == "0,00" || mn == "0.00" || mn == "0")) {
        wPrimer = wmin;
    }
    var textoPunto = '<div style="font-weight: bold;">{titulo}</div><div style="font-size: 11px;">{detalle}</div>';
    if (mx > 0) {
        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "M. mínimo").replace("{detalle}", vbSimbolo + " " + data.MontoMinimoStr),
            msgLimite: "!VAMOS, ADELANTE!",
            msgFalta: "Te faltan " + vbSimbolo + " {falta} para pasar pedido.",
            tipoMensaje: 'MontoMinimo',
            width: wPrimer,
            valor: data.MontoMinimo,
            valorStr: data.MontoMinimoStr
        });

        vLogro = mt - md;

        if (tp > 0) {
            listaLimite.push({
                nombre: "",
                msgLimite: "!VAMOS POR LA BONIFICACIÓN!",
                msgFalta: "Solo te faltan " + vbSimbolo + " {falta}.",
                tipoMensaje: 'TippingPoint',
                valor: data.TippingPoint,
                valorStr: data.TippingPointStr
            });
        }

        var dif = parseFloat(data.MontoMaximo - vLogro).toFixed(2);
        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "L. crédito").replace("{detalle}", vbSimbolo + " " + data.MontoMaximoStr),
            msgLimite: dif <= 0 ? "" : ("SOLO PUEDES AGREGAR " + vbSimbolo + " " + dif + " MÁS"),
            msgFalta: "Ya estas por llegar a tu tope de linea de crédito.",
            tipoMensaje: 'MontoMaximo',
            widthR: wmin,
            valor: data.MontoMaximo,
            valorStr: data.MontoMaximoStr
        });
    }
    else {
        if (mt < mn)
            vLogro = mt - md;
        else
            vLogro = me < mn ? mn : me;

        listaLimite = new Array();
        listaEscalaDescuento = listaEscalaDescuento || new Array();
        $.each(listaEscalaDescuento, function (ind, monto) {
            if (ind == 0) {
                listaLimite.push({
                    nombre: textoPunto.replace("{titulo}", monto.PorDescuento + "% DSCTO").replace("{detalle}", "M. mínimo: " + vbSimbolo + " " + data.MontoMinimoStr),
                    msgLimite: "!VAMOS, ADELANTE!",
                    msgFalta: "Te faltan " + vbSimbolo + " {falta} para pasar pedido.",
                    width: wPrimer,
                    tipoMensaje: 'EscalaDescuento',
                    valPor: monto.PorDescuento,
                    valor: data.MontoMinimo,
                    valorStr: data.MontoMinimoStr,
                    tipo: 'min'
                });
            }
            else {
                var montox = listaEscalaDescuento[ind - 1];
                if (me > montox.MontoHasta && me <= monto.MontoHasta) {
                }
                listaLimite.push({
                    nombre: textoPunto.replace("{titulo}", monto.PorDescuento + "% DSCTO").replace("{detalle}", vbSimbolo + " " + montox.MontoHastaStr),
                    msgLimite: "¡YA LLEGAS AL " + monto.PorDescuento + "% DSCTO!",
                    msgFalta: "Solo agrega " + vbSimbolo + " {falta}",
                    widthR: ind == listaEscalaDescuento.length - 1 ? wmin : null,
                    tipoMensaje: 'EscalaDescuento',
                    valPor: monto.PorDescuento,
                    valor: montox.MontoHasta,
                    valorStr: montox.MontoHastaStr,
                    tipo: ind == listaEscalaDescuento.length - 1 ? 'max' : 'int'
                });
            }
        });
    }

    // validar si hay algun limite
    listaLimite = listaLimite || new Array();
    if (listaLimite.length == 0) {
        $("#divBarra").hide();
        return false;
    }

    var indPuntoLimite = 0;
    // obtener el punto limite actual
    $.each(listaLimite, function (ind, limite) {
        if (ind == 0) {
            indPuntoLimite = 0;
        }
        else {
            var valBack = listaLimite[ind - 1].valor;
            if (valBack < vLogro && vLogro < limite.valor) {
                indPuntoLimite = ind;
            }
            else if (vLogro >= limite.valor) {
                indPuntoLimite = ind;
            }
            else if (valBack == vLogro && vLogro > 0) {
                indPuntoLimite = ind;
            }
        }
    });

    var wTotal = widthTotal;
    var vLimite = listaLimite[indPuntoLimite].valor;

    $("#divBarra").show();
    $("#divBarra #divBarraPosicion").css("width", wTotal);
    $("#divBarra").css("width", wTotal);

    // colocar los puntos limites
    var styleMin = 'style="margin-left: 6px;"';
    var htmlPunto = '<div id="punto_{punto}">'
                + '<div class="monto_minimo_barra">'
                    + '<div style="width:{wText}px;position: absolute;" data-texto>{texto}</div>'
                    + '<div class="linea_indicador_barra" {style}></div>'
                + '</div>'
            + '</div>';
    var htmlTippintPoint = '<div id="punto_{punto}">'
                + '<div class="monto_minimo_barra">'
                    + '<div style="width:{wText}px;position: absolute;" data-texto><div class="tippingPoint {estado}"></div></div>'
                    + '<div class="linea_indicador_barra"></div>'
                + '</div>'
            + '</div>';
    var htmlPuntoLimite = '<div id="punto_{punto}">'
                + '<div class="monto_minimo_barra">'
                    + '<div class="bandera_marcador" style="margin-top: -6px;"></div>'
                    + '<div style="margin-left: {marl}px;width: {wText}px;position: absolute;" data-texto>{texto}</div>'
                + '</div>'
            + '</div>';

    if (mx > 0)
        htmlPuntoLimite = htmlPunto;

    var wTotalPunto = 0;
    $("#divBarra #divBarraLimite").html("");
    $.each(listaLimite, function (ind, limite) {
        var htmlSet = indPuntoLimite == ind && ind > 0 ? vLogro < vLimite ? htmlPuntoLimite : htmlPunto : htmlPunto;
        htmlSet = ind == 1 && indPuntoLimite == 0 && mn == 0 ? htmlPuntoLimite : htmlSet;
        htmlSet = limite.tipoMensaje == 'TippingPoint' ? htmlTippintPoint : htmlSet;

        var wText = ind == 0 ? "130" : "90";
        var marl = indPuntoLimite == listaLimite.length - 1 ? "-80" : "21";
        var activo = limite.tipoMensaje == 'TippingPoint' && indPuntoLimite == 1 ? "activo" : "";
        var styleMinx = mn == 0 && ind == 0 ? styleMin : "";
        htmlSet = htmlSet
            .replace("{punto}", ind)
            .replace("{texto}", limite.nombre)
            .replace("{wText}", wText)
            .replace("{marl}", marl)
            .replace("{estado}", activo)
            .replace("{style}", styleMinx);

        var objH = $(htmlSet).css("float", 'left');
        $("#divBarra #divBarraLimite").append(objH);

        var wPunto = $("#punto_" + ind + " [data-texto]").width();
        wPunto += $("#punto_" + ind + " .bandera_marcador").width() || 0;
        if (indPuntoLimite == listaLimite.length - 1 && indPuntoLimite == ind) {
            if (vLogro < vLimite) {
                if (mx <= 0) {
                    wPunto = wmin;
                }
            }
        }

        $("#punto_" + ind).css("width", wPunto);
        if (ind == 0) {
            if (mn == 0) {
                $("#punto_" + ind + " .linea_indicador_barra").css("margin-left", "0px;");
            }
        }
        wTotalPunto += wPunto;

    });
    $("#divBarra #divBarraLimite").append("<div class='clear'></div>");

    //console.log(listaLimite, indPuntoLimite, wTotalPunto);

    if (wTotalPunto > wTotal) {
        var indAux = indPuntoLimite;
        while (indAux > 1) {
            if (indAux - 1 < indPuntoLimite - 1) {
                var wwx = $("#punto_" + (indAux - 1) + " [data-texto]").width();
                wTotalPunto -= wwx;
                $("#punto_" + (indAux - 1)).remove();
                listaLimite.splice(indAux - 1, 1);
                if (wTotalPunto < wTotal) {
                    indAux = 0;
                }
            }
            indAux--;
        }
        if (wTotalPunto > wTotal) {
            indAux = listaLimite.length;
            while (indAux > indPuntoLimite + 1) {
                var wwx = $("#punto_" + (indAux) + " [data-texto]").width();
                wTotalPunto -= wwx;
                $("#punto_" + indAux).remove();
                listaLimite.splice(indAux, 1);
                indAux--;
                if (wTotalPunto < wTotal) {
                    indAux = 0;
                }
            }
        }
    }

    //console.log(listaLimite, indPuntoLimite, wTotalPunto);
    // asignar espacio para el progreso
    var wAreaMover = widthTotal - wTotalPunto;
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) {
            $("#punto_" + (indPuntoLimite)).css("margin-right", wAreaMover);
        }
        else {
            $("#punto_" + (indPuntoLimite - 1)).css("margin-right", wAreaMover);
        }
    }
    else {
        if (mn > 0) {
            $("#punto_" + indPuntoLimite).css("margin-left", wAreaMover);
        }
        else {
            $("#punto_" + indPuntoLimite).css("margin-right", wAreaMover);
        }
    }

    if (mn == 0) {
        wAreaMover += $("#punto_" + 0).width();
    }

    var wPuntosAnterior = 0;
    indAux = indPuntoLimite;
    while (indAux > 0) {
        if (indAux == 1 && mn == 0) {
            wPuntosAnterior += 0;
        }
        else {
            wPuntosAnterior += $("#punto_" + (indAux - 1)).width();
        }
        indAux--;
    }
    if (vLogro >= vLimite) {
        if (indPuntoLimite > 0 && mn > 0) {
            wPuntosAnterior += $("#punto_" + indPuntoLimite).width()
        }
    }

    var wLimite = wAreaMover + wPuntosAnterior; // hasta el borde inicial  del texto del limite
    var wLimiteAnterior = wPuntosAnterior;
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) { // supero el ultimo limite
            wLimite = widthTotal;
            wLimiteAnterior -= parseInt($("#punto_" + (indPuntoLimite) + " >  div").width() / 2, 10);
        }
        else {
            wLimiteAnterior -= $("#punto_" + (indPuntoLimite - 1)).width() - parseInt($("#punto_" + (indPuntoLimite - 1) + " >  div").width() / 2, 10);
            if ($("#punto_" + indPuntoLimite).find(".bandera_marcador").length == 0) {
                wLimite += parseInt($("#punto_" + (indPuntoLimite) + " >  div").width() / 2, 10);
            }
        }
    }
    else {
        var indxx = indPuntoLimite == 0 && mn == 0 ? (indPuntoLimite + 1) : indPuntoLimite;
        if ($("#punto_" + indxx).find(".bandera_marcador").length == 0) {
            wLimite += parseInt($("#punto_" + (indxx) + " >  div").width() / 2, 10);
        }
    }
    wAreaMover = wLimite - wLimiteAnterior;

    // ancho de logrado
    var vLimiteAnterior = indPuntoLimite > 0 ? listaLimite[indPuntoLimite - 1].valor : 0;
    var vMover = vLogro - vLimiteAnterior;
    var vDiferencia = listaLimite[indPuntoLimite].valor - vLimiteAnterior;
    var wLogro = wLimiteAnterior;
    wLogro += vDiferencia > 0 ? (vMover * wAreaMover) / vDiferencia : 0;

    if (wLimite == widthTotal) {
        if (vLogro > vLimite) {
            wLogro = widthTotal - 20;
        }
        else if (vLogro == vLimite) {
            wLogro = wLimiteAnterior;
        }
    }

    //wLogro = wLimite == widthTotal ? vLogro > vLimite ? widthTotal - 20 : wLimite : wLogro;
    $("#divBarra #divBarraEspacioLimite").css("width", wLimite);
    $("#divBarra #divBarraEspacioLogrado").css("width", wLogro);

    //console.log(widthTotal, wTotalPunto, wAreaMover, wLimite, indPuntoLimite, vLogro, vLimite, wLimiteAnterior);

    // mensaje
    var tipoMensaje = listaLimite[indPuntoLimite].tipoMensaje;
    tipoMensaje += vLogro >= vLimite ? "Supero" : "";

    listaMensajeMeta = listaMensajeMeta || new Array();
    var objMsg = listaMensajeMeta.Find("TipoMensaje", tipoMensaje)[0] || new Object();
    objMsg.Titulo = $.trim(objMsg.Titulo);
    objMsg.Mensaje = $.trim(objMsg.Mensaje);
    if (objMsg.Titulo == "" && objMsg.Mensaje == "") {
        $("#divBarra #divBarraMensajeLogrado").hide();
        return false;
    }
    var valPor = listaLimite[indPuntoLimite].valPor || "";
    var valorMonto = vbSimbolo + " " + DecimalToStringFormat(parseFloat(vLimite - vLogro));
    $("#divBarra #divBarraMensajeLogrado").show();
    $("#divBarra #divBarraMensajeLogrado .mensaje_barra").html(objMsg.Titulo.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    $("#divBarra #divBarraMensajeLogrado .agrega_barra").html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    var wMsgTexto = $("#divBarra #divBarraMensajeLogrado > div").width();
    wMsgTexto = wLogro + wMsgTexto >= wTotal ? wTotal : (wLogro + wMsgTexto);
    $("#divBarra #divBarraMensajeLogrado").css("width", wMsgTexto);

    return false;

    // obtener valor minimo y maximo, distancia a trabajar
    var vm = 0, vx = 0, w = 0;
    $.each(listaLimite, function (ind, limite) {
        limite.valor = limite.valor || 0;
        var ww = limite.valor || 0;
        vx = vx < ww ? ww : vx;
        vm = ind == 0 ? ww : vm > ww ? ww : vm;

        w += limite.width || limite.widthR || 0;
    });
    w = widthTotal - w;
    var fk = vx - vm;

    // poner width segun el rango min y max, dentro del area
    $.each(listaLimite, function (ind, limite) {
        if (!limite.width) {
            var valor = limite.valor - vm;
            if (valor > 0 && fk > 0) {
                valor = valor / fk;
                valor = parseInt(w * valor * 100) / 100;
            }
            limite.width = valor;
        }
        if (ind == 0) {
            wLimite = limite.width;
            indPuntoLimite = 0;
            vLimite = limite.valor;
            tipoMensaje = limite.tipoMensaje;
            valPor = limite.valPor;
        }
        else {
            var valBack = listaLimite[ind - 1].valor;
            if (valBack < vLogro && vLogro < limite.valor) {
                wLimite = limite.width;
                indPuntoLimite = ind;
                vLimite = limite.valor;
                tipoMensaje = limite.tipoMensaje;
                valPor = limite.valPor;
            }
            else if (vLogro >= limite.valor) {
                wLimite = ind == listaLimite.length - 1 ? widthTotal : limite.width;
                indPuntoLimite = ind;
                vLimite = limite.valor;
                tipoMensaje = limite.tipoMensaje + (ind == listaLimite.length - 1 ? "Supero" : "");
                valPor = limite.valPor;
            }
            else if (valBack == vLogro && vLogro > 0) {
                wLimite = limite.width;
                indPuntoLimite = ind;
                vLimite = limite.valor;
                tipoMensaje = limite.tipoMensaje;
                valPor = limite.valPor;
            }
        }
    });

    //console.log(wLimite, vLogro, indPuntoLimite, mx, listaLimite);

    // ancho de logrado
    var wLogro = 0;
    if (vLogro == vm) {
        wLogro = vLogro > 0 ? wmin : 0;
    }
    else if (vLogro > vm) {
        wLogro = (vLogro - vm) / fk;
        wLogro = parseInt(w * wLogro * 100) / 100;
    } else if (vm > 0 && vLogro > 0) {
        wLogro = vLogro / vm;
        wLogro = parseInt(wmin * wLogro * 100) / 100;
    }

    // colocar los puntos de limite
    var w1 = 0;

    var wSumLeft = 0, msgLimite = "";
    //$("#divBarra #divBarraLimite").html("");
    $.each(listaLimite, function (ind, limite) {
        w1 = ind == 0 ? limite.width : w1;
        var www = limite.width + (ind == 0 ? 0 : w1);
        var wadd = www - wSumLeft;
        wSumLeft += wadd;
        limite.widthAdd = wadd;
        limite.widthSum = wSumLeft;

        $("#punto_" + ind).css("width", wadd);
        $("#punto_" + ind + " [data-texto]").css("float", "right");

        $("#punto_" + ind + " > div").css("float", "right");
        $("#punto_" + ind + " > div").css("left", "45px");
        if (ind == 0) {
            if (mn == 0) {
                $("#punto_" + ind + " .linea_indicador_barra").css("margin-left", "6px;");
            }
        }
        if (indPuntoLimite == ind) {
            $("#punto_" + ind).css("left", "45px");
            $("#punto_" + ind + " .bandera_marcador").css("margin-left", "45px");
            $("#punto_" + ind + " [data-texto]").css("margin-left", "55px");
        }
        //var wText = ind == 0 ? "130" : "90";
        //var marl = indPuntoLimite == listaLimite.length - 1 ? "-45" : "55";
        //var activo = limite.tipoMensaje == 'TippingPoint' && indPuntoLimite == 1 ? "activo" : "";
        //var styleMinx = mn == 0 && ind == 0 ? styleMin : "";
        //var htmlSet = indPuntoLimite == ind && ind > 0 ? htmlPuntoLimite : htmlPunto;
        //htmlSet = limite.tipoMensaje == 'TippingPoint' ? htmlTippintPoint : htmlSet;
        //htmlSet = htmlSet.replace("{texto}", limite.nombre).replace("{wText}", wText).replace("{marl}", marl).replace("{estado}", activo).replace("{style}", styleMinx);
        //var objH = $(htmlSet).css("width", wadd).css("float", 'left');
        //$("#divBarra #divBarraLimite").append(objH);

        msgLimite = indPuntoLimite == ind ? limite.msgLimite : msgLimite;
        msgLimite = indPuntoLimite == listaLimite.length - 1 && vLogro > limite.valor ? "" : msgLimite;
    });
    //$("#divBarra #divBarraLimite").append("<div class='clear'></div>");

    // pintar la barra
    $("#divBarra #divBarraMinimo").css("width", wPrimer);
    //wLogro = wLogro <= wmin ? wLogro : wLogro > w ? w + 25 : (wLogro + wPrimer);
    wLogro = vLogro < vm ? wLogro : wLogro > w ? w + 25 + wPrimer : vLogro != vm ? (wLogro + wPrimer) : wLogro;
    wLimite = wLogro <= 0 ? listaLimite[indPuntoLimite].widthSum : vLogro < vm ? wLimite : ((wLimite > w ? w + wmin : wLimite) + wPrimer + (mn == 0 ? wmin : 0));

    $("#divBarra #divBarraEspacioLimite").css("width", wLimite);
    $("#divBarra #divBarraEspacioLogrado").css("width", wLogro);

    var objMsg = listaMensajeMeta.Find("TipoMensaje", tipoMensaje)[0] || new Object();
    objMsg.Titulo = $.trim(objMsg.Titulo);
    objMsg.Mensaje = $.trim(objMsg.Mensaje);
    if (objMsg.Titulo == "" && objMsg.Mensaje == "") {
        $("#divBarra").show();
        $("#divBarra #divBarraMensajeLogrado").hide();
        return false;
    }
    valPor = valPor || "";
    var valorMonto = vbSimbolo + " " + DecimalToStringFormat(parseFloat(vLimite - vLogro));
    $("#divBarra").show();
    $("#divBarra #divBarraMensajeLogrado").show();
    $("#divBarra #divBarraMensajeLogrado .mensaje_barra").html(objMsg.Titulo.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    $("#divBarra #divBarraMensajeLogrado .agrega_barra").html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    var wMsgTexto = $("#divBarra #divBarraMensajeLogrado > div").width();
    wMsgTexto = wLogro + wMsgTexto >= wTotal ? wTotal : (wLogro + wMsgTexto);
    $("#divBarra #divBarraMensajeLogrado").css("width", wMsgTexto);
}

// Fin Barra

function CargarEstrategiasEspeciales(objInput, e) {
    if ($(e.target).attr('class') === undefined || $(e.target).attr('class').indexOf('js-no-popup') == -1) {
        var estrategia = JSON.parse($(objInput).attr("data-estrategia"));

        if (estrategia.TipoEstrategiaImagenMostrar == '2') {
            var html = ArmarPopupPackNuevas(estrategia);
            $('#popupDetalleCarousel_packNuevas').html(html);
            $('#popupDetalleCarousel_packNuevas').show();
        } else if (estrategia.TipoEstrategiaImagenMostrar == '5' || estrategia.TipoEstrategiaImagenMostrar == '3') {
            var html = ArmarPopupLanzamiento(estrategia);
            $('#popupDetalleCarousel_lanzamiento').html(html);
            $('#popupDetalleCarousel_lanzamiento').show();
        };
    } else {
        return false;
    }
};
function ArmarPopupPackNuevas(obj) {
    console.log(obj);
    return SetHandlebars("#packnuevas-template", obj);
};
function ArmarPopupLanzamiento(obj) {
    console.log(obj);
    return SetHandlebars("#lanzamiento-template", obj);
};

function HidePopupEstrategiasEspeciales() {
    $('#popupDetalleCarousel_lanzamiento').hide();
    $('#popupDetalleCarousel_packNuevas').hide();
};
