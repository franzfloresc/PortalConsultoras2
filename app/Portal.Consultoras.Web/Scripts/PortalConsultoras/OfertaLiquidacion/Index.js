var cantidadRegistros = 12;
var offsetRegistros = 0;
var cargandoRegistros = false;

$(document).ready(function () {
    IniDialog();

    $(document).on('click', '#boton_vermas', function () {
        puedeCargar = false;
        CargarOfertasLiquidacion();
    });
    $(window).scroll(function () {
        if ($(this).scrollTop() > 70) {
            $('.productos_fixed').addClass("fixed");
        } else {
            $('.productos_fixed').removeClass("fixed");
        }
    });
    $(document).on('change', '.js-select_tallacolor', function () {

        $(this).parents('.Content_modal_ZE').find('.CUV').attr("value", $("option:selected", this).attr("value"));
        $(this).parents('.Content_modal_ZE').find('.pedidos_datos_info').html($("option:selected", this).attr("desc-talla"));
        $(this).parents('.Content_modal_ZE').find('.liquidacion_precio').html('<span>' + $("option:selected", this).attr("desc-precio") + '</span>');
        $(this).parents('.Content_modal_ZE').find(".DescripcionProd").attr("value", $("option:selected", this).attr("desc-talla"));
        $(this).parents('.Content_modal_ZE').find(".PrecioOferta").attr("value", $("option:selected", this).attr("precio-real"));

        var spanStock = $(this).parents('.Content_modal_ZE').find('.span_stock');
        var HiddenStock = $(this).parents('.Content_modal_ZE').find(".Stock");
        var CUV = $(this).parents('.Content_modal_ZE').find(".CUV").attr("value");

        $.ajaxSetup({
            cache: false
        });
        waitingDialog({});
        $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
            $(spanStock).text(data.Stock);
            $(HiddenStock).val(data.Stock);
            closeWaitingDialog();
        });

    });

    $('.ValidaNumeralOferta').live('keyup', function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });

    $('.ValidaNumeralOferta').live('keypress', function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $("#btnVerPedido").click(function () {
        location.href = baseUrl + 'Pedido/Index';
    });
    
    $(document).on('click', '.js-boton_tonotalla', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

        var contenedor = $(this).parent().parent();
        var objProducto = {
            imagenProducto: $(contenedor).find('.imagenpop').attr('src'),
            tituloMarca: $(contenedor).find('.liquidacion_titulo_item').text(),
            descripcion: $(contenedor).find('.liquidacion_descripcion').text(),
            precio: $(contenedor).find('.liquidacion_precio').text(),
            tonosTallas: $(contenedor).find('#tonostallas').attr('data-array-tonostallas')
        };
        var objHidden = {
            TipoOfertaSisID: $(contenedor).find('.TipoOfertaSisID').val(),
            OfertaProductoID: $(contenedor).find('.OfertaProductoID').val(),
            ConfiguracionOfertaID: $(contenedor).find('.ConfiguracionOfertaID').val(),
            MarcaID: $(contenedor).find('.MarcaID').val(),
            CUV: $(contenedor).find('.CUV').val(),
            PrecioOferta: $(contenedor).find('.PrecioOferta').val(),
            Stock: $(contenedor).find('.Stock').val(),
            DescripcionProd: $(contenedor).find('.DescripcionProd').val(),
            DescripcionMarca: $(contenedor).find('.DescripcionMarca').val(),
            DescripcionCategoria: $(contenedor).find('.DescripcionCategoria').val(),
            DescripcionEstrategia: $(contenedor).find('.DescripcionEstrategia').val()
        };

        cargarProductoPopup(objProducto, objHidden);
    });
    $(document).on('click', ".js-boton_agregar_popup", function () {
        PedidoRegistroModule.AgregarProductoOfertaLiquidacion(this);
    });
    
    $(document).on('click', ".js-boton_liquidacion", PedidoRegistroModule.RegistrarProductoOferta);

    Inicializar();
});

function Inicializar() {
    ValidarCargaOfertasLiquidacion();
    LinkCargarOfertasToScroll();
}

function LinkCargarOfertasToScroll() { $(window).scroll(CargarOfertasScroll); }

function UnlinkCargarOfertasToScroll() {
    $(window).off("scroll", CargarOfertasScroll);
    cargandoRegistros = false;
}

function CargarOfertasScroll() {
    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
        ValidarCargaOfertasLiquidacion();
    }
}

function ValidarCargaOfertasLiquidacion() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    waitingDialog();
    CargarOfertasLiquidacion();
}

function CargarOfertasLiquidacion() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertaLiquidacion/JsonGetOfertasLiquidacion',
        data: { offset: offsetRegistros, cantidadregistros: cantidadRegistros, origen: 'OfertaLiquidacion' },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.lista.length > 0) ArmarProductoLiquidaciones(data.lista);
                if (!data.verMas) UnlinkCargarOfertasToScroll();
                offsetRegistros += cantidadRegistros;
            }
        },
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            cargandoRegistros = false;
        }
    });
}

function ArmarProductoLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#OfertasLiquidacion-template", data);
    $('#htmlListado').append(htmlDiv);
    EstablecerAccionLazyImagen("img[data-lazy-seccion-liquidacion]");

}

function EstructurarDataCarouselLiquidaciones(array) {
    var contadorLq = 1;
    $.each(array, function (i, item) {
        item.Descripcion = (item.Descripcion.length > 159 ? item.Descripcion.substring(0, 159) + "..." : item.Descripcion);
        item.Posicion = contadorLq;

        item.TallaColor = $.trim(item.TallaColor);
        if (item.TallaColor.length > 2 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TieneTallaColor = false;
        }
        item.UnidadMedida = item.UnidadMedida || "";
        item.ValPUM = (item.UnidadMedida == "" || item.PUM == "") ? false : true;
        item.PUM = NumberToFormat(item.PUM, { decimalCantidad: DecimalPrecision(item.PUM)});
        item.UnidadMedida = item.UnidadMedida.toLowerCase();
        
        contadorLq++;
    });

    return array;
}

function cargarProductoPopup(objProducto, objHidden) {
    waitingDialog({});

    var divVistaPrevia = $("#divVistaPrevia");
    var arrayTonosTallas = objProducto.tonosTallas.split("@");
    var option = '';

    for (var i = 0; i < arrayTonosTallas.length - 1; i++) {

        var strOption = arrayTonosTallas[i].split("|");
        var strCuv = strOption[0];
        var strDescCuv = strOption[1];
        var strDescTalla = strOption[2];
        var strDescPrecio = Number(strOption[3]).toFixed(2);
        var strPrecioReal = strOption[3];

        option += '<option value="' + strCuv + '"' +
            'desc-talla="' + strDescCuv + '"' +
            'desc-precio="' + strDescPrecio + '"' +
            'precio-real="' + strPrecioReal + '"' +
            '>' + strDescTalla + '</option>';

    }
    $(divVistaPrevia).find('#ddlTallaColor').html(option);

    $(divVistaPrevia).find('#imgZonaEstrategiaEdit').attr('src', objProducto.imagenProducto);
    $(divVistaPrevia).find('.pedidos_datos_titulo').text(objProducto.tituloMarca);
    $(divVistaPrevia).find('.pedidos_datos_info').text(objProducto.descripcion);
    $(divVistaPrevia).find('.liquidacion_precio').html('<span>' + objProducto.precio + '</span>');
    $(divVistaPrevia).find('.span_stock').html(objHidden.Stock);

    $(divVistaPrevia).find('.TipoOfertaSisID').val(objHidden.TipoOfertaSisID);
    $(divVistaPrevia).find('.OfertaProductoID').val(objHidden.OfertaProductoID);
    $(divVistaPrevia).find('.ConfiguracionOfertaID').val(objHidden.ConfiguracionOfertaID);
    $(divVistaPrevia).find('.MarcaID').val(objHidden.MarcaID);
    $(divVistaPrevia).find('.CUV').val(objHidden.CUV);
    $(divVistaPrevia).find('.PrecioOferta').val(objHidden.PrecioOferta);
    $(divVistaPrevia).find('.Stock').val(objHidden.Stock);
    $(divVistaPrevia).find('.DescripcionProd').val(objHidden.DescripcionProd);
    $(divVistaPrevia).find('.DescripcionMarca').val(objHidden.DescripcionMarca);
    $(divVistaPrevia).find('.DescripcionCategoria').val(objHidden.DescripcionCategoria);
    $(divVistaPrevia).find('.DescripcionEstrategia').val(objHidden.DescripcionEstrategia);

    $(divVistaPrevia).find('#txtCantidadPopup').val(1);
    $(divVistaPrevia).css({ "background-color": "#FFF" });

    var spanStock = $(divVistaPrevia).find('.span_stock');
    var HiddenStock = $(divVistaPrevia).find(".Stock");
    var CUV = $(divVistaPrevia).find(".CUV").attr("value");

    $.ajaxSetup({
        cache: false
    });

    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
        $(spanStock).text(data.Stock);
        $(HiddenStock).val(data.Stock);
        closeWaitingDialog();
        showDialog('divVistaPrevia');
        $(divVistaPrevia).find('#txtCantidadPopup').blur();
    });
}

function IniDialog() {
    $('#DialogMensajeProducto').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true
    });

    $('#DialogMensajesBanner').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        title: ":: Mensaje ::",
        buttons:
            {
                "Aceptar": function () {
                    HideDialog("DialogMensajesBanner");
                }
            }
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
}

function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, posicion) {
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") { variant = "Estándar"; }
        if (Categoria == null || Categoria == "") { Categoria = "Sin Categoría"; }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': 'Liquidaciones Web' },
                    'products': [
                        {
                            'name': DescripcionProd,
                            'price': Precio,
                            'brand': Marca,
                            'id': CUV,
                            'category': Categoria,
                            'variant': variant,
                            'quantity': parseInt(Cantidad),
                            'position': posicion
                        }
                    ]
                }
            }
        });
    }
}

function CerrarProductoAgregado() {
    $('#pop_liquidacion').hide();
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        dataType: 'json',
        async: false,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    waitingDialog({});
                    location.href = location.href = baseUrl + 'Pedido/PedidoValidado'
                }
                if (mostrarAlerta == true) {
                    closeWaitingDialog();
                    AbrirPopupPedidoReservado(data.message, "1");
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true)
                AbrirMensaje(data.message, "LO SENTIMOS");
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.', "LO SENTIMOS");
            }
        }
    });
    return restringido;
}

function ReservadoOEnHorarioRestringidoAsync(mostrarAlerta, fnRestringido, fnNoRestringido) {
    if (!$.isFunction(fnRestringido)) return false;
    if (!$.isFunction(fnNoRestringido)) return false;
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        data: { tipoAccion: '2' },
        dataType: 'json',
        async: true,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (!data.success) {
                fnNoRestringido();
                return false;
            }

            if (data.pedidoReservado && !mostrarAlerta) {
                waitingDialog();
                location.href = location.href = baseUrl + 'Pedido/PedidoValidado';
                return false;
            }

            if (mostrarAlerta) {
                closeWaitingDialog();
                messageInfoError(data.message);
            }
            fnRestringido();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.', "LO SENTIMOS");
            }
        }
    });
}

function agregarProductoAlCarrito(o) {

    var btnClickeado = $(o);
    var contenedorItem = btnClickeado.parent();
    var imagenProducto = $('.imagen_producto', contenedorItem);
    var carrito = $('.campana.cart_compras');

    $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

    $(".transicion").css({
        'height': imagenProducto.css("height"),
        'width': imagenProducto.css("width"),
        'top': imagenProducto.offset().top,
        'left': imagenProducto.offset().left,
    }).animate({
        'top': carrito.offset().top,
        'left': carrito.offset().left,
        'height': carrito.css("height"),
        'width': carrito.css("width"),
        'opacity': 0.5
    }, 450, 'swing', function () {
        $(this).animate({
            'top': carrito.offset().top,
            'opacity': 0
        }, 150, 'swing', function () {
            $(this).remove();
        });
    });
}
