﻿var animacion = true;
var tieneMicroefecto = false;
var contadorNext = 2;
var positionCarrousel = 0;
var posicionInicial = 0;
var posicionFinalPantalla = 2;
var posicionTotal = 0;
var salto = 3;
var analyticsGuardarValidarEnviado = false;

var esPedidoValidado = false;
var arrayOfertasParaTi = [];
var arrayProductosSugeridos = [];
var numImagen = 1;
var fnMovimientoTutorial;
var origenPedidoWebEstrategia = origenPedidoWebEstrategia || 0;

var tipoOfertaFinal_Log = "";
var gap_Log = 0;
var tipoOrigen = '1';
var FlagEnviarCorreo = false; //EPD-23787

$(document).ready(function () {
     
 
    ReservadoOEnHorarioRestringido(false);

    AnalyticsBannersInferioresImpression();
    $('#salvavidaTutorial').show();

    $("#salvavidaTutorial").click(function () {
        abrir_popup_tutorial();
    });

    $(".cerrar_tutorial").click(function () {
        cerrar_popup_tutorial();
    });


    //EPD-1564
    $("body").click(function (e) {        
        if (!$(e.target).closest('.ui-dialog').length) {
            if ($('#divObservacionesPROL').is(':visible'))
                HideDialog("divObservacionesPROL");
            if ($('#divReservaSatisfactoria').is(':visible'))
                HideDialog("divReservaSatisfactoria");
            if ($('#divReservaSatisfactoriaCO').is(':visible'))
                HideDialog("divReservaSatisfactoriaCO");
            if ($('#divReservaSatisfactoria3').is(':visible'))
                HideDialog("divReservaSatisfactoria3");
        }
    })
    //FIn EPD-1564

   

    $(document).on('change', '.seleccion_pagina select', function () {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ingresa tu pedido',
            'action': 'Ver lista de productos',
            'label': $(this).find('option:selected').text()
        });
    });
    $('#txtClienteDescripcion').autocomplete({
        source: baseUrl + "Pedido/AutocompleteByCliente",
        minLength: 4,
        select: function (event, ui) {
            ui.item.ClienteID = ui.item.ClienteID || 0;

            if (gTipoUsuario == 2)  {
                var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp";
                $('#dialog_MensajePostulante #tituloContenido').text("LO SENTIMOS");
                $('#dialog_MensajePostulante #mensajePostulante').text(mesg);
                $('#dialog_MensajePostulante').show();
                return false;
            } else {
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
        $("#txtCantidad").removeAttr("disabled");
    });
    $('#txtDescripcionProd').autocomplete({
        source: baseUrl + "Pedido/AutocompleteByProductoDescripcion",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.CUV == "0") {
                return false;
            }

            $('#txtDescripcionProd')[0].item = ui.item;
            $("#txtDescripcionProd").val(ui.item.Descripcion);
            $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
            $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
            $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
            ObservacionesProducto(ui.item);
            $('#hdMetodoBusqueda').val('Por descripción');

            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.Descripcion + "</a>")
            .appendTo(ul);
    };
    $("#txtCUV").keyup(function (evt) {
        $("#txtCantidad").removeAttr("disabled");
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
    $(".ValidaAlfabeto").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return true;
        } else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-ZñÑáéíóúÁÉÍÓÚ' ]/;
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
        if (gTipoUsuario == 2) { //Postulante
            var mesg = "Recuerda que este pedido no se va a facturar. Pronto podrás acceder a todos los beneficios de Somos Belcorp.";
            $('#dialog_MensajePostulante #tituloContenido').text("IMPORTANTE");
            $('#dialog_MensajePostulante #mensajePostulante').text(mesg);
            $('#dialog_MensajePostulante').show();
            
            if (indicadorGPRSB == 1) {
            ConfirmarModificar();            
        }
        }
        else {
            EjecutarPROL();
        }
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
        var OrigenPedidoWeb = DesktopPedidoSugerido;
        var posicion = $(divPadre).find(".hdPosicionSugerido").val();

        if (!isInt(cantidad)) {
            AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarSplash();
            limpiarInputsPedido();
            return false;
        }

        if (cantidad <= 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
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
                EsSugerido: true,
                OrigenPedidoWeb: OrigenPedidoWeb,
                Posicion: posicion
            };

            AgregarProducto('Insert', model, 'divProductoSugerido', true);
            dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                    'add': {
                        'actionField': { 'list': 'Productos de reemplazo - Pedido' },
                        'products': [{
                            'name': model.DescripcionProd,
                            'price': model.PrecioUnidad,
                            'brand': model.DescripcionMarca,
                            'id': model.CUV,
                            'category': 'NO DISPONIBLE',
                            'variant': (model.DescripcionEstrategia == "" || model.DescripcionEstrategia == null) ? 'Estándar' : model.DescripcionEstrategia,
                            'quantity': Number(model.Cantidad),
                            'position': Number(model.Posicion)
                        }]
                    }
                }
            })

            $("#divProductoAgotadoFinal").hide();
        }
    });
    $("body").on("click", "[data-close='divProductoAgotadoFinal']", function () {
        limpiarInputsPedido();
        $("#divProductoAgotadoFinal").hide();
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ingresa tu pedido',
            'action': 'Productos de reemplazo',
            'label': 'No gracias'
        });
    });
    $('#frmInsertPedido').on('submit', function () {
        if (!$(this).valid()) {
            AbrirMensaje("Argumentos no validos");
            return false;
        }

        if (HorarioRestringido()) {
            return false;
        }

        var cantidad = $.trim($("#txtCantidad").val());
        if (cantidad == "" || cantidad[0] == "-") {
            AbrirMensaje("Ingrese una cantidad mayor que cero.");
            return false;
        }
        if (!isInt(cantidad)) {
            AbrirMensaje("Ingrese una cantidad mayor que cero.");
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            AbrirMensaje("Ingrese una cantidad mayor que cero.");
            return false;
        }

        AbrirSplash();

        var cuv = $("#txtCUV").val();
        var esKit = $("#divListadoPedido").find("input[data-kit='True']") || $("#divListadoPedido").find("input[data-kit='true']") || [];
        if (esKit.length > 0) {
            var tag = $(esKit).parents("tr");
            var cuvKit = $.trim(tag.attr('data-cuv'));
            if (cuv == cuvKit) {
                AbrirMensaje("El CUV ingresado pertenece a un Kit Nuevas, solo puede ser registrado 1 vez");
                return false;
            }
        }

        var form = FuncionesGenerales.GetDataForm(this);
        var validarEstrategia = ValidarStockEstrategia();

        if (validarEstrategia.success) {

            var flagNueva = $.trim($("#hdFlagNueva").val());
            if (flagNueva == "0" || flagNueva == "") {
                InsertarProducto(form);
            } else {
                AgregarProductoZonaEstrategia(flagNueva == "1" ? 2 : flagNueva);
            }

            $("#btnAgregar").removeAttr("disabled");
        } else {
            CerrarSplash();
            AbrirMensaje(validarEstrategia.message);
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
    
    $(document).on('click', '#idImagenCerrar', function (e) {
        $(this).parent().remove();
    });

    CrearDialogs();
    CargarDetallePedido();
    CargarCarouselEstrategias("");
    CargarAutocomplete();
    MostrarBarra();
    CargarDialogMesajePostulantePedido();
});

function CargarDialogMesajePostulantePedido() {
    if (gTipoUsuario == '2' && MensajePedidoDesktop == '0') {
        var mesg = "En este momento podrás simular el ingreso de tu pedido.";
        var title = "TE ENCUENTRAS EN UNA SESIÓN DE PRUEBA";
        $('#dialog_MensajePostulante_Pedido #titutloPedido').text(title);
        $('#dialog_MensajePostulante_Pedido #mensajePedido').text(mesg);
        $('#dialog_MensajePostulante_Pedido #btnOk').text('CONTINUAR');
        $('#dialog_MensajePostulante_Pedido').show();
        return false;
    }
}
function CerrarDialogMesajePostulantePedido() {
    $('#dialog_MensajePostulante_Pedido').hide();
    abrir_popup_tutorial();
    UpdateUsuarioTutoriales();
}

function abrir_popup_tutorial() {
    $('#popup_tutorial_pedido').fadeIn();
    $('html').css({ 'overflow-y': 'hidden' });

    fnMovimientoTutorial = setInterval(function () {
        $(".img_slide" + numImagen + "Pedido").animate({ 'opacity': '0' });
        numImagen++;
        if (numImagen > 5) {
            numImagen = 1;
            $(".imagen_tutorial").animate({ 'opacity': '1' });
        }

    }, 3000);
}

function UpdateUsuarioTutoriales() {
    var item = {
        tipo: '1' // Para Desktop
    };
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/UpdatePostulanteMensaje',
        data: JSON.stringify(item),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
        },
        error: function (data) {
        }
    });
    return true; 
}

function cerrar_popup_tutorial() {
    $('#popup_tutorial_pedido').fadeOut();
    $('html').css({ 'overflow-y': 'auto' });
    $(".imagen_tutorial").animate({ 'opacity': '1' });
    window.clearInterval(fnMovimientoTutorial);
    numImagen = 1;
}

function CrearDialogs() {

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
        closeOnEscape: true,
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
        closeOnEscape: true,
        width: 400,
        draggable: true
    });

    $('#divBackOrderModificado').dialog({
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
        closeOnEscape: true,
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
    /*
    if (typeof gTipoUsuario !== 'undefined') {
        if (gTipoUsuario == '2') {
            return false;
        }
    }
    */

    $(".pMontoCliente").css("display", "none");

    $('#tbobyDetallePedido').html('<div><div style="width:100%;"><div style="text-align: center;"><br>Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></div></div>');

    var clienteId = $("#ddlClientes").val() || -1;
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 20,
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
            if (checkTimeout(response)) { //EPD-1780
                var data = response.data;

                ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

                $("#pCantidadProductosPedido").html(data.TotalProductos);

                $("#hdnRegistrosPaginar").val(data.Registros);
                $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
                $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
                $("#hdnPaginaPaginar").val(data.Pagina);
                $("#hdnPaginaDePaginar").val(data.PaginaDe);

                $("#hdnRegistros").val(data.Registros);
                $("#hdnRegistrosDe").val(data.RegistrosDe);
                $("#hdnRegistrosTotal").val(data.RegistrosTotal);
                $("#hdnPagina").val(data.Pagina);
                $("#hdnPaginaDe").val(data.PaginaDe);

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

                MostrarBarra(response);
                CargarAutocomplete();

                if ($('#penmostreo').length > 0) {
                    if ($('#penmostreo').attr('[data-tab-activo]') == '1') {
                        $('ul.paginador_notificaciones').hide();
                    }
                }
            }
        },
        error: function (response, error) {
            if(checkTimeout(response)){

            }
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
            if (checkTimeout(datos)) {
                success = datos.result;
                message = datos.message;
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                resultado = false;
            }
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
            if (checkTimeout(response)) { 
                if (response.success == true) {
                    $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                    tieneMicroefecto = true;
                    MostrarBarra(response);
                    if (response.modificoBackOrder) showDialog('divBackOrderModificado');
                    CargarDetallePedido();

                    TrackingJetloreAdd(form.data.Cantidad, $("#hdCampaniaCodigo").val(), form.data.CUV);
                    dataLayer.push({
                        'event': 'addToCart',
                        'label': $('#hdMetodoBusqueda').val(),
                        'ecommerce': {
                            'add': {
                                'actionField': { 'list': 'Estándar' },
                                'products': [{
                                    'name': form.data.DescripcionProd,
                                    'price': form.data.PrecioUnidad,
                                    'brand': response.data.DescripcionLarga,
                                    'id': form.data.CUV,
                                    'category': 'NO DISPONIBLE',
                                    'variant': response.data.DescripcionOferta == "" ? 'Estándar' : response.data.DescripcionOferta,
                                    'quantity': Number(form.data.Cantidad),
                                    'position': 1
                                }]
                            }
                        }
                    });
                } else {
                AbrirMensaje(response.message);
                }

                PedidoOnSuccess();

                CerrarSplash();
            }
        },
        error: function (response, x, xh, xhr) {
            if (checkTimeout(response)) {
                //console.error(xh);
            }
        }
    });
}
function AgregarProductoZonaEstrategia(tipoEstrategiaImagen) {
    var param2 = {
        MarcaID: $("#hdfMarcaID").val(),
        CUV: $("#txtCUV").val(),
        PrecioUnidad: $("#hdfPrecioUnidad").val(),
        Descripcion: $("#txtDescripcionProd").val(),
        Cantidad: $("#txtCantidad").val(),
        IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/AgregarProductoZE',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param2),
        async: true,
        success: function (data) {
            if (!checkTimeout(data)) {
                CerrarSplash();
                return false;
            }

            if (data.success != true) {
                CerrarSplash();
                messageInfoError(data.message);
                return false;
            }
            
            $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

            cierreCarouselEstrategias();
            CargarCarouselEstrategias(param2.CUV);
            HideDialog("divVistaPrevia");
            PedidoOnSuccess();
            if (data.modificoBackOrder) showDialog('divBackOrderModificado');
            CargarDetallePedido();
            MostrarBarra(data);
            TrackingJetloreAdd(param2.Cantidad, $("#hdCampaniaCodigo").val(), param2.CUV);
            dataLayer.push({
                'event': 'addToCart',
                'label': $('#hdMetodoBusqueda').val(),
                'ecommerce': {
                    'add': {
                        'actionField': { 'list': 'Estándar' },
                        'products': [{
                            'name': data.data.DescripcionProd,
                            'price': String(data.data.PrecioUnidad),
                            'brand': data.data.DescripcionLarga,
                            'id': data.data.CUV,
                            'category': 'NO DISPONIBLE',
                            'variant': data.data.DescripcionOferta == "" ? 'Estándar' : data.data.DescripcionOferta,
                            'quantity': Number(param2.Cantidad),
                            'position': 1
                        }]
                    }
                }
            });
            CerrarSplash();
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
            }
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

            animacion = true;
            tieneMicroefecto = false;
        });
    }
}

function ActualizarMontosPedido(formatoTotal, total, formatoTotalCliente) {
    if (formatoTotal != undefined) {
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
            if (checkTimeout(datos)) {
                if (!datos.result) {
                    CerrarSplash();
                AbrirMensaje(datos.message);
                    return false;
                }
                var flagNueva = $.trim($("#hdFlagNueva").val());
                if (flagNueva == "0" || flagNueva == "") {
                    $('form#frmInsertPedido').submit();
                } else {
                    AgregarProductoZonaEstrategia(flagNueva == "1" ? 2 : flagNueva);
                }

                $("#btnAgregar").removeAttr("disabled");
                return false;
            }
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
        } else {
            $("#txtCantidad").val("");
            $("#hdfCUV").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtDescripcionProd").val("");
            $("#btnAgregar").attr("disabled", "disabled");
            $("#divMensaje").text("");
            $("#txtPrecioR").val("");
            $("#hdfPrecioUnidad").val("");
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
    AbrirMensaje("Ocurrió un error. Por favor, vuelva a realizar la acción.");
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
    /*
    if (typeof gTipoUsuario !== 'undefined') {
        if (gTipoUsuario == '2') {
            alert('Acceso restringido, aun no puede agregar pedidos');
            return false;
        }
    }
    */

    if (gTipoUsuario == '2') {
        var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
        $('#dialog_MensajePostulante #tituloContenido').text("LO SENTIMOS");
        $('#dialog_MensajePostulante #mensajePostulante').text(mesg);
        $('#dialog_MensajePostulante').show();
        return false;
    }

    $('#Nombres').val($('#txtClienteDescripcion').val());
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
        AbrirMensaje(vMessage);
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
                    $("#hdfClienteID").val(data.extra);
                    $("#txtClienteDescripcion").val($('#Nombres').val());
                    $("#hdfClienteDescripcion").val($('#Nombres').val());
                    $('#Nombres').val("");
                    $('#Correo').val("");
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Clientes',
                        'action': 'Agregar',
                        'label': 'Satisfactorio'
                    });
                    $("#divClientes").hide();
                }
                AbrirMensaje(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje(data.message);
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
    var ItemCantidad = $("#txtCantidad").val();
    var ItemPrecio = $("#hdfPrecioUnidad").val();
    var descripcion = $('#txtDescripcionProd').val();
    var ItemTotal = parseFloat(ItemCantidad * ItemPrecio).toFixed(2);

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

    CalcularTotal();
    $("#txtCUV").focus();

    InfoCommerceGoogleProductoRecomendados();
}

function TagManagerCarruselInicio(arrayItems) {
    var cantidadRecomendados = $('#divListadoEstrategia').find(".slick-active").length;

    var arrayEstrategia = [];
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = arrayItems[i];
        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – Pedido',
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        var sentListEstrategia = false;
        if (typeof (Storage) !== 'undefined') {
            var sle = localStorage.getItem('sentListEstrategia2');
            if (sle !== null && sle === '1') {
                sentListEstrategia = true;
            }
            else {
                localStorage.setItem('sentListEstrategia2', '1');
            }
        }
        if (!sentListEstrategia) {
            dataLayer.push({
                'event': 'productImpression',
                'ecommerce': {
                    'impressions': arrayEstrategia
                }
            });
        }
    }
}
function TagManagerClickAgregarProducto() {
    dataLayer.push({
        'event': 'addToCart',

        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Ofertas para ti – Pedido' },
                'products': [
                    {
                        'name': $("#txtCantidadZE").attr("est-descripcion"),
                        'price': $("#txtCantidadZE").attr("est-precio2"),
                        'brand': $("#txtCantidadZE").attr("est-descripcionMarca"),
                        'id': $("#txtCantidadZE").attr("est-cuv2"),
                        'category': 'NO DISPONIBLE',
                        'variant': $("#txtCantidadZE").attr("est-descripcionEstrategia") == "" ? 'Estándar' : $("#txtCantidadZE").attr("est-descripcionEstrategia"),
                        'quantity': parseInt($("#txtCantidadZE").val()),
                        'position': parseInt($("#txtCantidadZE").attr("est-posicion"))
                    }
                ]
            }
        }
    });
}
function TagManagerCarruselPrevia() {
    var posicionPrimerActivo = $($('#divListadoEstrategia').find(".slick-active")[0]).find('.PosicionEstrategia').val();
    var posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length - 1 : posicionPrimerActivo - 2;
    var recomendado = arrayOfertasParaTi[posicionEstrategia];
    var arrayEstrategia = new Array();


    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Ofertas para ti – Pedido',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ingresa tu pedido',
        'action': 'Ofertas para ti',
        'label': 'Ver anterior'
    });

}
function TagManagerCarruselSiguiente() {
    var posicionUltimoActivo = $($('#divListadoEstrategia').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
    var posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
    var recomendado = arrayOfertasParaTi[posicionEstrategia];
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Ofertas para ti – Pedido',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ingresa tu pedido',
        'action': 'Ofertas para ti',
        'label': 'Ver siguiente'
    });

}

function cierreCarouselEstrategias() {
    $('#cierreCarousel').hide();
}

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

    CalcularTotal();
    $("#txtCUV").focus();
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
                    TrackingJetloreSearch(CUV, $("#hdCampaniaCodigo").val());
                    $("#hdTipoOfertaSisID").val(data[0].TipoOfertaSisID);
                    $("#hdConfiguracionOfertaID").val(data[0].ConfiguracionOfertaID);
                    ObservacionesProducto(data[0]);
                    $('#hdMetodoBusqueda').val('Por código');
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
                        location.href = baseUrl + "Login/SesionExpirada";
                    } else {
                        AbrirMensaje(data.message);
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
    $('#divCarruselSugerido.slick-initialized').slick('unslick');

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
            $.each(data, function (index, item) {
                item.posicion = index + 1;
            });
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
                centerMode: false,
                centerPadding: '0',
                tipo: 'p',
                prevArrow: '<a class="previous_ofertas-popup js-slick-prev-h"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                nextArrow: '<a class="previous_ofertas-popup next js-slick-next-h"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                var accion;
                if (nextSlide == 0 && currentSlide + 1 == arrayProductosSugeridos.length) {
                    accion = 'next';
                } else if (currentSlide == 0 && nextSlide + 1 == arrayProductosSugeridos.length) {
                    accion = 'prev';
                } else if (nextSlide > currentSlide) {
                    accion = 'next';
                } else {
                    accion = 'prev';
                };

                if (accion == 'prev') {
                    var posicionPrimerActivo = $($('#divCarruselSugerido').find(".slick-active")[0]).find('.hdPosicionSugerido').val();
                    var posicionEstrategia = posicionPrimerActivo == 1 ? arrayProductosSugeridos.length - 1 : posicionPrimerActivo - 2;
                    var recomendado = arrayProductosSugeridos[posicionEstrategia];
                    var arraySugerido = new Array();

                    var impresionSugerido = {
                        'name': recomendado.Descripcion,
                        'id': recomendado.CUV,
                        'price': recomendado.PrecioCatalogoString,
                        'brand': recomendado.DescripcionMarca,
                        'category': 'NO DISPONIBLE',
                        'variant': (recomendado.DescripcionEstrategia == "" || recomendado.DescripcionEstrategia == null) ? 'Estándar' : recomendado.DescripcionEstrategia,
                        'list': 'Productos de reemplazo - Pedido',
                        'position': recomendado.posicion
                    };

                    arraySugerido.push(impresionSugerido);
                    
                    dataLayer.push({
                        'event': 'productImpression',
                        'ecommerce': {
                            'impressions': arraySugerido
                        }
                    });
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Ingresa tu pedido',
                        'action': 'Productos de reemplazo',
                        'label': 'Ver anterior'
                    });
                } else if (accion == 'next') {
                    var posicionUltimoActivo = $($('#divCarruselSugerido').find(".slick-active").slice(-1)[0]).find('.hdPosicionSugerido').val();
                    var posicionEstrategia = arrayProductosSugeridos.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
                    var recomendado = arrayProductosSugeridos[posicionEstrategia];
                    var arraySugerido = new Array();

                    var impresionSugerido = {
                        'name': recomendado.Descripcion,
                        'id': recomendado.CUV,
                        'price': recomendado.PrecioCatalogoString,
                        'brand': recomendado.DescripcionMarca,
                        'category': 'NO DISPONIBLE',
                        'variant': (recomendado.DescripcionEstrategia == "" || recomendado.DescripcionEstrategia == null) ? 'Estándar' : recomendado.DescripcionEstrategia,
                        'list': 'Productos de reemplazo - Pedido',
                        'position': recomendado.posicion
                    };

                    arraySugerido.push(impresionSugerido);
                    
                    dataLayer.push({
                        'event': 'productImpression',
                        'ecommerce': {
                            'impressions': arraySugerido
                        }
                    });
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Ingresa tu pedido',
                        'action': 'Productos de reemplazo',
                        'label': 'Ver siguiente'
                    });
                }
            });

            $('#divCarruselSugerido').prepend($(".js-slick-prev-h"));
            $('#divCarruselSugerido').prepend($(".js-slick-next-h"));

            TagManagerCarruselSugeridosInicio(data);

        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                if (data.message == "" || data.message === undefined) {
                    location.href = baseUrl + "Login/SesionExpirada";
                } else {
                    AbrirMensaje(data.message);
                }
            }
        }
    });
}

function TagManagerCarruselSugeridosInicio(data) {
    arrayProductosSugeridos = data;    
    var arraySugeridos = [];

    arraySugeridos.push({
        'name': data[0].Descripcion,
        'id': data[0].CUV,
        'price': data[0].PrecioCatalogoString,
        'brand': data[0].DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': (data[0].DescripcionEstrategia == null || data[0].DescripcionEstrategia == '') ? 'Estándar' : data[0].DescripcionEstrategia,
        'list': 'Productos de reemplazo - Pedido',
        'position': data[0].posicion
    });

    if (data.length > 1) {
        arraySugeridos.push({
            'name': data[1].Descripcion,
            'id': data[1].CUV,
            'price': data[1].PrecioCatalogoString,
            'brand': data[1].DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': (data[1].DescripcionEstrategia == null || data[1].DescripcionEstrategia == '') ? 'Estándar' : data[1].DescripcionEstrategia,
            'list': 'Productos de reemplazo - Pedido',
            'position': data[1].posicion
        });
    }

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arraySugeridos
        }
    })
}

function CambiarCliente(elem) {
    var rows = $($('[data-paginacion="rows"]')[0]).val() || 10;
    CargarDetallePedido(1, rows, elem.value);
}

function ObservacionesProducto(item) {
    
    if (item.TipoOfertaSisID == "1707") {

        $("#divObservaciones").html("");

        if (sesionEsShowRoom == "1") {
            $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>Este producto sólo se puede agregar desde la sección de Pre-venta Digital.</div></div>");
        } else {
            $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>Esta promoción no se encuentra disponible.</div></div>");
        }

        $("#btnAgregar").attr("disabled", "disabled");
    } else {
        if (item.TieneStock == true) {
            if (item.TieneSugerido != 0) {
                $("#divObservaciones").html("");

                $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>Lo sentimos, este producto está agotado.</div></div>");
                
                $("#btnAgregar").attr("disabled", "disabled");
                ObtenerProductosSugeridos(item.CUV);
            } else {
                $("#divObservaciones").html("");
                if (item.EsExpoOferta == true) {
                    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto de ExpoOferta.</div></div>");
                }
                if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
                    $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>" + mensajeCUVOfertaEspecial + "</div></div>");                    
                }

                if (item.MensajeCUV != null) {
                    if (item.MensajeCUV != "") {
                        AbrirMensaje(item.MensajeCUV, "IMPORTANTE");
                    }
                }

                $("#btnAgregar").removeAttr("disabled");
            }
        } else {
            $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");
            $("#btnAgregar").attr("disabled", "disabled");
            IngresoFAD(item);

            if (item.TieneSugerido != 0)
                ObtenerProductosSugeridos(item.CUV);
        }
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

    $("#txtCantidad").removeAttr("disabled");
    if (item.FlagNueva == 1) {
        $("#txtCantidad").attr("disabled", "disabled");
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
    
    if (item.TipoOfertaSisID == "1707") {
        if (sesionEsShowRoom != "1") {
            $("#txtDescripcionProd").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtPrecioR").val("");
            $("#txtCantidad").val("");
            $("#divMensaje").text("");
            $("#txtCUV").focus();
        }
    }
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
                AbrirMensaje(data.message);
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

    /*
    if (typeof gTipoUsuario !== 'undefined') {
        if (gTipoUsuario == '2') {
            alert('Acceso restringido, aun no puede agregar pedidos');
            return true;
        }
    }
    */
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
                if (data.success == true) {
                    if (mostrarAlerta == true)
                        AbrirMensaje(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje(data.message);
            }
        }
    });
    return horarioRestringido;
}

function CargarAutocomplete() {
    var array = $(".classClienteNombre");
    for (var i = 0; i < array.length; i++) {
        $('#' + array[i].id).focus(function () {
            if (HorarioRestringido())
                this.blur();
        });
        $('#' + array[i].id).autocomplete({
            source: baseUrl + "Pedido/AutocompleteByClienteListado",
            minLength: 4,
            select: function (event, ui) {
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
}

function CerrarProductoAgregado() {
    $('#pop_liquidacion').hide();
}

function DeletePedido(campaniaId, pedidoId, pedidoDetalleId, tipoOfertaSisId, cuv, cantidad, clienteId, cuvReco, esBackOrder) {
    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        TipoOfertaSisID: tipoOfertaSisId,
        CUV: cuv,
        Cantidad: cantidad,
        ClienteID_: clienteId,
        CUVReco: cuvReco,
        EsBackOrder: esBackOrder == 'true'
    };

    AbrirSplash();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/Delete',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) return false;
            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }

            AbrirSplash();
            CargarDetallePedido();

            if (tipoOfertaSisId != '0') {
                cierreCarouselEstrategias();
                CargarCarouselEstrategias(cuv);
            }
            MostrarBarra(data);
            CargarResumenCampaniaHeader(true);
            TrackingJetloreRemove(cantidad, $("#hdCampaniaCodigo").val(), cuv);
            dataLayer.push({
                'event': 'removeFromCart',
                'ecommerce': {
                    'remove': {
                        'products': [{
                            'name': data.data.DescripcionProducto,
                            'id': data.data.CUV,
                            'price': data.data.Precio,
                            'brand': data.data.DescripcionMarca,
                            'category': 'NO DISPONIBLE',
                            'variant': data.data.DescripcionOferta == "" ? 'Estándar' : data.data.DescripcionOferta,
                            'quantity': Number(cantidad)
                        }]
                    }
                }
            });
            CerrarSplash();

            window.OfertaDelDia.CargarODDEscritorio();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                HideDialog("divVistaPrevia");
                CerrarSplash();
            }
        }
    });
}

function AceptarBackOrder(campaniaId, pedidoId, pedidoDetalleId, clienteId) {
    if (ReservadoOEnHorarioRestringido(true)) {
        return false;
    }

    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        ClienteID_: clienteId
    };

    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/AceptarBackOrder',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) return false;
            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            AbrirSplash();
            CargarDetallePedido();
            MostrarBarra(data);
            CargarResumenCampaniaHeader(true);
            CerrarSplash();
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
    // HorarioRestringido()||(AbrirSplash(),RecalcularPROL())
    if (ReservadoOEnHorarioRestringido(true)) {
        return false;
    }
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
    analyticsGuardarValidarEnviado = false;
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/EjecutarServicioPROL',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                RespuestaEjecutarServicioPROL(response);

                var montoEscala = response.data.MontoEscala;
                var montoPedido = response.data.Total - response.data.MontoDescuento;

                var codigoMensajeProl = response.data.CodigoMensajeProl;
                var cumpleOferta;
                if (response.data.Reserva == true) {
                    if (response.data.ZonaValida == true) {
                        if (response.data.ObservacionInformativa == false) {
                            cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
                            if (cumpleOferta.resultado) {
                                esPedidoValidado = response.data.ProlSinStock != true;
                                FlagEnviarCorreo = true; //EPD-2378
                            } else {
                                if (response.data.ProlSinStock == true) {
                                    showDialog("divReservaSatisfactoria3");
                                    CargarDetallePedido();
                                } else {
                                    $('#dialog_divReservaSatisfactoria').show(); //EPD-2278
                                    AnalyticsGuardarValidar(response);
                                    AnalyticsPedidoValidado(response);
                                    setTimeout(function () {
                                        location.href = baseUrl + 'Pedido/PedidoValidado';
                                    }, 3000);
                                    /*** EPD-2378 ***/
                                    if (!FlagEnviarCorreo && response.flagCorreo == '1')
                                        EnviarCorreoPedidoReservado();
                                    /*** ***/
                                    return false;
                                }
                            }
                        } else {
                            var tipoMensaje = codigoMensajeProl == "00" ? 1 : 2;

                            cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, tipoMensaje, codigoMensajeProl, response.data.ListaObservacionesProl);
                            if (!cumpleOferta.resultado) {
                                $('#DivObsBut').css({ "display": "none" });
                                $('#DivObsInfBut').css({ "display": "block" });

                                showDialog("divObservacionesPROL");
                                $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");
                            }
                            CargarDetallePedido();
                        }
                    } else {

                        cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
                        if (!cumpleOferta.resultado) {
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

                    var tipoMensaje = codigoMensajeProl == "00" ? 1 : 2;

                    cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, tipoMensaje, codigoMensajeProl, response.data.ListaObservacionesProl);
                    if (!cumpleOferta.resultado) {
                        showDialog("divObservacionesPROL");
                        $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");
                    }
                    CargarDetallePedido();
                }

                AnalyticsGuardarValidar(response);
                analyticsGuardarValidarEnviado = true;
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
    analyticsGuardarValidarEnviado = false;
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/EjecutarServicioPROL',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.flagCorreo == "1")
                    EnviarCorreoPedidoReservado(); //EPD-2378
                RespuestaEjecutarServicioPROL(response, false);
                MostrarMensajeProl(response);                
            }
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
            }
        }
    });
}

function RespuestaEjecutarServicioPROL(response, inicio) {
    CerrarSplash();
    inicio = inicio == null || inicio == undefined ? true : inicio;
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
    $("#divMensajeObservacionesPROL").html("");

    var mensajePedido = "";

    if (response.data.ErrorProl == false) {
        if (inicio) {
            if (!response.data.ValidacionInteractiva) {

                html = '<div id="divContendor" style="border-radius: 10px;padding: 5px;border: 1px solid #ccc;background-color: #efefef;margin-bottom: 5px;">';
                html += '<img src="/Content/Images/icons/warning.png">';
                html += '<span id="idmensajeProl" style="padding-left:5px;"> ' + response.data.MensajeValidacionInteractiva + '</span>';
                html += '<img id="idImagenCerrar" src="/Content/Images/icons/close.png" style="padding-left: 35px;">'
                html += '</div>';
                $("#divContendorPrincipal").after(html);
                return false;
            }
        }

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
            var msgDefault = "<li>Tu pedido tiene observaciones, por favor revísalo.</li>";
            var msgDefaultCont = 0;
            if (response.data.ListaObservacionesProl.length == 0) {
                html += msgDefault;
                mensajePedido += "-1" + " " + "Tu pedido tiene observaciones, por favor revísalo." + " ";
            }
            else {
                $.each(response.data.ListaObservacionesProl, function (index, item) {
                    if (response.data.CodigoIso == "BO" || response.data.CodigoIso == "MX") {
                        if (item.Caso == 6 || item.Caso == 8 || item.Caso == 9 || item.Caso == 10) {
                            item.Caso = 105;
                        }
                    }

                    if (item.Caso == 95 || item.Caso == 105 || (item.Caso == 0 && inicio)) {
                        html += "<li>" + item.Descripcion + "</li>";

                        mensajePedido += item.Caso + " " + item.Descripcion + " ";
                        return;
                    }

                    if (viewBagMenuNotificaciones == 0 && item.Caso == 0 && response.data.ObservacionInformativa) {
                        html += "<li>" + item.Descripcion + "</li>";

                        mensajePedido += item.Caso + " " + item.Descripcion + " ";
                    } else {
                        if (msgDefaultCont == 0) {
                            html += html == "" ? msgDefault : html == msgDefault ? "" : msgDefault;
                        }
                        msgDefaultCont++;
                        mensajePedido += "-1" + " " + "Tu pedido tiene observaciones, por favor revísalo." + " ";
                    }
                });
            }
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
    var tooltips = response.data.ProlTooltip.split('|');
    $('.tooltip_importanteGuardarPedido')[0].children[0].innerHTML = tooltips[0];
    $('.tooltip_importanteGuardarPedido')[0].children[1].innerHTML = tooltips[1];
}

function MostrarMensajeProl(response) {
    var data = response.data;

    if (!analyticsGuardarValidarEnviado)
        AnalyticsGuardarValidar(response);

    if (data.Reserva == true) {
        if (data.ZonaValida == true) {
            if (data.ObservacionInformativa == false) {
                if (data.ProlSinStock == true) {
                    showDialog("divReservaSatisfactoria3");
                    CargarDetallePedido();
                } else {
                    $('#dialog_divReservaSatisfactoria').show(); //EPD-2278
                    AnalyticsPedidoValidado(response);
                    setTimeout(function () {
                        location.href = baseUrl + 'Pedido/PedidoValidado';
                    }, 3000);
                }
            } else {
                $('#DivObsBut').css({ "display": "none" });
                $('#DivObsInfBut').css({ "display": "block" });

                showDialog("divObservacionesPROL");
                $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");
                CargarDetallePedido();
            }
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

            CargarDetallePedido();
        }
    } else {
        $('#DivObsBut').css({ "display": "block" });
        $('#DivObsInfBut').css({ "display": "none" });

        showDialog("divObservacionesPROL");
        $("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");

        CargarDetallePedido();
    }
}

function EliminarPedido() {
    AbrirSplash();
    if (HorarioRestringido()) {
        CerrarSplash();
        return;
    }

    var listaDetallePedido = new Array();
    var campania = $("#hdCampaniaCodigo").val();

    $.each($("#tbobyDetallePedido > .contenido_ingresoPedido"), function (index, value) {
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
            if (!checkTimeout(data)) {
                CerrarSplash();
                return false;
            }

            if (data.success != true) {
                messageInfoError(data.message);
                CerrarSplash();
                return false;
            }

            TrackingJetloreRemoveAll(listaDetallePedido);
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ingresa tu pedido',
                'action': 'Eliminar pedido completo',
                'label': '(not available)'
            });
            MostrarBarra(data);
            CerrarSplash();
            location.href = baseUrl + 'Pedido/Index';            
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje(data.message);
                CerrarSplash();
            }
        }
    });
}

function EjecutarPROL2() {
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
                    AbrirMensaje(data.message);
                }
            }
            CerrarSplash();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarSplash();
                AbrirMensaje("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
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
                        AbrirMensaje(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    CerrarSplash();
                    AbrirMensaje("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
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
        AbrirMensaje('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        AbrirMensaje('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (CliDes.length != 0 && CliDes != CliDesVal) {
        AbrirMensaje('Por favor ingrese un cliente válido.');
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
        CliID = 0;
    }

    var Cantidad = CantidadModi;
    var Unidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    var Total = DecimalToStringFormat(parseFloat(Cantidad * Unidad));
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
            CerrarSplash();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }

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

        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                AbrirMensaje(data.message);
            }
        }
    });
}

function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {
    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion);
    if (!val) return false;

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
    var Total = DecimalToStringFormat(parseFloat(Cantidad * Unidad));
    $('#lblLPImpTotal' + PedidoDetalleID).html(Total);
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

            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }

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

            $('#hdfTotal').val(data.Total);
            $("#spPedidoWebAcumulado").text(vbSimbolo + " " + data.TotalFormato);

            var totalUnidades = parseInt($("#pCantidadProductosPedido").html());
            totalUnidades = totalUnidades - parseInt(CantidadAnti) + parseInt(Cantidad);
            $("#pCantidadProductosPedido").html(totalUnidades);

            MostrarBarra(data);
            CargarResumenCampaniaHeader();
            if (data.modificoBackOrder) {
                showDialog('divBackOrderModificado');
                CargarDetallePedido();
            }

            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
                TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                AbrirMensaje(data.message);
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
        AbrirMensaje("Ingrese una cantidad mayor que cero.");
        $('#txtLPCant' + PedidoDetalleID).val(cantAnti);
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
                    AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                else {
                    if (Saldo == "0")
                        AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                    else
                        AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
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

                        AbrirMensaje("Lamentablemente, no puede actualizar la cantidad del Producto , ya que sobrepasa el stock actual (" + data.Stock + "), verifique");
                        CerrarSplash();
                        return false;
                    } else {
                        var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
                        var Unidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
                        var Total = DecimalToStringFormat(parseFloat(Cantidad * Unidad));
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
                                CerrarSplash();
                                if (!checkTimeout(data)) return false;
                                if (data.success != true) {
                                    messageInfoError(data.message);
                                    return false;
                                }

                                CerrarSplash();
                                var item = data.items;
                                if ($('#txtLPCli' + PedidoDetalleID).val().length == 0) {
                                    $('#hdfLPCliDes' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                                    $('#txtLPCli' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                                }
                                if (PROL == "0") $('#txtLPTempCant' + PedidoDetalleID).val($('#txtLPCant' + PedidoDetalleID).val());

                                var nomCli = $("#ddlClientes option:selected").text();
                                var simbolo = data.Simbolo;
                                var monto = data.Total_Cliente;

                                $(".pMontoCliente").css("display", "none");

                                if (data.ClienteID_ != "-1") {
                                    $(".pMontoCliente").css("display", "block");
                                    $("#spnNombreCliente").html(nomCli + " :");
                                    $("#spnTotalCliente").html(simbolo + monto);
                                }

                                var totalUnidades = parseInt($("#pCantidadProductosPedido").html());
                                totalUnidades = totalUnidades - parseInt(CantidadAnti) + parseInt(Cantidad);
                                $("#pCantidadProductosPedido").html(totalUnidades);

                                var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
                                if (diferenciaCantidades > 0)
                                    TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
                                else if (diferenciaCantidades < 0)
                                    TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);
                                
                                MostrarBarra(data);
                                CargarResumenCampaniaHeader();
                                if (data.modificoBackOrder) {
                                    showDialog('divBackOrderModificado');
                                    CargarDetallePedido();
                                }
                            },
                            error: function (data, error) {
                                CerrarSplash();
                                if (checkTimeout(data)) {
                                    AbrirMensaje(data.message);
                                }
                            }
                        });
                    }
                });
            }
        });
    } else {
        if (TipoOfertaSisID == constConfiguracionOfertaShowRoom) {
            var PROL = $("#hdValidarPROL").val();

            $.ajaxSetup({
                cache: false
            });
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
            if (FlagValidacion == "1") {
                if (CantidadAnti == Cantidad)
                    return false;
            } else {
                if (ClienteAnti == CliDes)
                    return false;
            }

            if (Cantidad.length == 0) {
                AbrirMensaje('Por favor ingrese una cantidad válida.');
                return;
            }

            if (Cantidad == 0) {
                AbrirMensaje('Por favor ingrese una cantidad mayor a cero.');
                return;
            }

            if ((CliDes.length != 0 && CliDes != CliDesVal)) {
                AbrirMensaje('Por favor ingrese un cliente válido.');
                return;
            }

            var PrecioUnidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
            if (CliDes.length == 0) {
                CliID = 0;
            }
            $.getJSON(baseUrl + 'ShowRoom/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
                var Saldo = data.Saldo;
                var UnidadesPermitidas = data.UnidadesPermitidas;
                var CantidadPedida = data.CantidadPedida;
                Cantidad = parseInt(Cantidad) + parseInt(CantidadPedida);
                if (parseInt(data.UnidadesPermitidas) < parseInt(Cantidad)) {
                    if (PROL == "1") {
                        UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi);
                        $('#txtLPCant' + PedidoDetalleID).val(CantidadModi);
                    }
                    else
                        $('#txtLPCant' + PedidoDetalleID).val($('#txtLPTempCant' + PedidoDetalleID).val());
                    if (Saldo == UnidadesPermitidas)
                        AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                    else {
                        if (Saldo == "0")
                            AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                        else
                            AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                    }

                    return false;
                } else {
                    $.getJSON(baseUrl + 'ShowRoom/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                        var CantidadActual = $('#txtLPCant' + PedidoDetalleID).val();
                        var CantidadaValidar = parseInt(CantidadActual) - parseInt(CantidadAnti);
                        if (parseInt(data.Stock) < parseInt(CantidadaValidar)) {
                            if (PROL == "1") {
                                UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi);
                                $('#txtLPCant' + PedidoDetalleID).val(CantidadModi);
                            }
                            else
                                $('#txtLPCant' + PedidoDetalleID).val($('#txtLPTempCant' + PedidoDetalleID).val());

                            AbrirMensaje("Lamentablemente, no puede actualizar la cantidad del Producto , ya que sobrepasa el stock actual (" + data.Stock + "), verifique");


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
                                    CerrarSplash();
                                    if (!checkTimeout(data)) return false;
                                    if (data.success != true) {
                                        messageInfoError(data.message);
                                        return false;
                                    }

                                    CerrarSplash();
                                    if ($('#txtLPCli' + PedidoDetalleID).val().length == 0) {
                                        $('#hdfLPCliDes' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                                        $('#txtLPCli' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                                    }
                                    if (PROL == "0") $('#txtLPTempCant' + PedidoDetalleID).val($('#txtLPCant' + PedidoDetalleID).val());

                                    var nomCli = $("#ddlClientes option:selected").text();
                                    var simbolo = data.Simbolo;
                                    var monto = data.Total_Cliente;

                                    $(".pMontoCliente").css("display", "none");

                                    if (data.ClienteID_ != "-1") {
                                        $(".pMontoCliente").css("display", "block");
                                        $("#spnNombreCliente").html(nomCli + " :");
                                        $("#spnTotalCliente").html(simbolo + monto);
                                    }

                                    var totalUnidades = parseInt($("#pCantidadProductosPedido").html());
                                    totalUnidades = totalUnidades - parseInt(CantidadAnti) + parseInt(Cantidad);
                                    $("#pCantidadProductosPedido").html(totalUnidades);

                                    var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
                                    if (diferenciaCantidades > 0)
                                        TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
                                    else if (diferenciaCantidades < 0)
                                        TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);
                                    
                                    MostrarBarra(data);
                                    CargarResumenCampaniaHeader();
                                    if (data.modificoBackOrder) {
                                        showDialog('divBackOrderModificado');
                                        CargarDetallePedido();
                                    }
                                },
                                error: function (data, error) {
                                    if (checkTimeout(data)) {
                                        CerrarSplash();
                                        AbrirMensaje(data.message);
                                    }
                                }
                            });
                        }
                    });
                }
            });
        } else {

            var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();
            var CantidadNueva = $('#txtLPCant' + PedidoDetalleID).val();

            var CantidadSoli = CantidadNueva;
            if (TipoOfertaSisID) {
                CantidadSoli = (CantidadNueva - CantidadAnti);
            }

            var param = ({
                MarcaID: 0,
                CUV: CUV,
                PrecioUnidad: 0,
                Descripcion: 0,
                Cantidad: CantidadSoli,
                IndicadorMontoMinimo: 0,
                TipoOferta: TipoOfertaSisID || 0
            });

            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'Pedido/ValidarStockEstrategia',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(param),
                async: true,
                success: function (datos) {
                    if (checkTimeout(datos)) {
                        if (!datos.result) {
                            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(datos.message);
                            $('#dialog_ErrorMainLayout').show();
                            CerrarSplash();
                            $('#txtLPCant' + PedidoDetalleID).val(CantidadAnti);
                            return false;
                        } else {
                            Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
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
    }
}

function BlurF(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {
    if (isShown)
        return true;

    var cliAnt = $("#hdfLPCliIni" + PedidoDetalleID).val();
    var cliNue = $("#hdfLPCli" + PedidoDetalleID).val();
    if (cliAnt == cliNue) {
        $("#txtLPCli" + PedidoDetalleID).val($("#hdfLPCliDes" + PedidoDetalleID).val());
        return true;
    }

    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
}
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

function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    var accion = obj.attr("data-paginacion");
    if (accion === "back" || accion === "next") {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ingresa tu pedido',
            'action': 'Ir a página',
            'label': 'Pág. ' + rpt.page
        });
    }
    CargarDetallePedido(rpt.page, rpt.rows);
    return true;
}

function AgregarProducto(url, model, divDialog, cerrarSplash, asyncX) {
    AbrirSplash();

    tieneMicroefecto = true;

    divDialog = $.trim(divDialog);

    var retorno = new Object();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/' + url,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: asyncX == undefined || asyncX == null ? true : asyncX,
        success: function (data) {
            if (!checkTimeout(data)) {
                if (cerrarSplash) CerrarSplash();
                return false;
            }

            if (data.success != true) {
                if (cerrarSplash) CerrarSplash();
                messageInfoError(data.message);
                return false;
            }

            $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

            if (divDialog != "") {
                $("#" + divDialog).dialog("close");
            }

            if (model != null && model != undefined)
                PedidoOnSuccessSugerido(model);

            CargarDetallePedido();
            CargarResumenCampaniaHeader();
            if (cerrarSplash) CerrarSplash();
            MostrarBarra(data);
            TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
            
            retorno = data;
            return true;
        },
        error: function (data, error) {
            tieneMicroefecto = false;
            AjaxError(data, error);
            return false;
        }
    });

    return retorno;
}

function CerrarProductoAgotados() {
    $('#divProductoAgotado').hide();
    $('#producto-faltante-busqueda-cuv').val('');
    $('#producto-faltante-busqueda-descripcion').val('');
}

function CargarProductoAgotados() {
    var data = {
        cuv: $('#producto-faltante-busqueda-cuv').val(),
        descripcion: $('#producto-faltante-busqueda-descripcion').val()
    }

    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetProductoFaltante',
        dataType: 'json',
        data: data,
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) return false;

            CerrarSplash();
            if (response.result) {
                SetHandlebars("#productos-faltantes-template", response.data, '#tblProductosFaltantes');
                $("#divProductoAgotado").show();
            }
            else alert(response.data);
        },
        error: function (data, error) { AjaxError(data, error); }
    });
}

function AjaxError(data) {
    CerrarSplash();
    if (checkTimeout(data)) AbrirMensaje(data.message);
}

function MostrarDetalleGanancia() {
    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').fadeIn(200);
}

function AnalyticsBannersInferiores(obj) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                {
                    'id': obj.id,
                    'name': obj.name,
                    'position': obj.position
                }]
            }
        }
    });
}
function AnalyticsBannersInferioresImpression() {
    var promotionsBajos = [];
    $('.contenedor_banners li').each(function (index) {
        var $this = $(this);
        promotionsBajos.push({
            id: $this.attr('data-id'),
            name: $this.attr('data-name'),
            position: $this.attr('data-position')
        });
    });
    if (promotionsBajos.length > 0) {
        dataLayer.push({
            'event': 'promotionView',
            'ecommerce': {
                'promoView': {
                    'promotions': promotionsBajos
                }
            }
        });
    }
}
function AnalyticsGuardarValidar(response) {
    var arrayEstrategiasAnalytics = [];
    var accion = $('#hdAccionBotonProl').val();

    response.pedidoDetalle = response.pedidoDetalle || new Array();
    $.each(response.pedidoDetalle, function (index, value) {
        var estrategia = {
            'name': value.name,
            'id': value.id,
            'price': $.trim(value.price),
            'brand': value.brand,
            'category': 'NO DISPONIBLE',
            'variant': value.variant == "" ? 'Estándar' : value.variant,
            'quantity': value.quantity
        };
        arrayEstrategiasAnalytics.push(estrategia);
    });

    dataLayer.push({
        'event': 'productCheckout',
        'action': accion == 'guardar' ? 'Guardar' : 'Validar',
        'label': response.mensajeAnalytics,
        'ecommerce': {
            'checkout': {
                'actionField': {
                    'step': accion == 'guardar' ? 1 : 2,
                    'option': response.mensajeAnalytics
                },
                'products': arrayEstrategiasAnalytics
            }
        }
    });
}
function AnalyticsPedidoValidado(response) {
    var arrayEstrategiasAnalytics = [];

    response.pedidoDetalle = response.pedidoDetalle || new Array();
    $.each(response.pedidoDetalle, function (index, value) {
        var estrategia = {
            'name': value.name,
            'id': value.id,
            'price': $.trim(value.price),
            'brand': value.brand,
            'category': 'NO DISPONIBLE',
            'variant': value.variant == "" ? 'Estándar' : value.variant,
            'quantity': value.quantity
        };
        arrayEstrategiasAnalytics.push(estrategia);
    });

    dataLayer.push({
        'event': 'productCheckout',
        'action': 'Validado',
        'label': 'Validado con éxito',
        'ecommerce': {
            'checkout': {
                'actionField': { 'step': 3 },
                'products': arrayEstrategiasAnalytics
            }
        }
    });
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    /*
    if (mostrarAlerta) {
        if (typeof gTipoUsuario !== 'undefined') {
            if (gTipoUsuario == '2') {
                alert('Acceso restringido, aun no puede agregar pedidos');
                return true;
            }
        }
    }
    */

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                if (mostrarAlerta == true) {
                    CerrarSplash();
                    AbrirMensaje(data.message);
                }
                else {
                    AbrirSplash();
                    location.href = urlValidadoPedido;
                }
            }
            else if (mostrarAlerta == true) {
                AbrirPopupPedidoReservado(data.message, '1')
            }
        },
        error: function (error, x) {
            console.log(error, x);
            AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
};

function ConfirmarModificar() {
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/PedidoValidadoDeshacerReserva?Tipo=PV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Ecommerce',
                        'action': 'Modificar Pedido',
                        'label': '(not available)'
                    });
                    location.href = baseUrl + 'Pedido/Index';
                }
                else {
                    closeWaitingDialog();
                    messageInfoError(data.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
    return false;
}

