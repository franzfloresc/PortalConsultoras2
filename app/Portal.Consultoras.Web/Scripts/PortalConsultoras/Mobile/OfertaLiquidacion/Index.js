var cantidadRegistros = 10;
var offset = 0;
var puedeCargar = true;
$(document).ready(function () {
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

    CargarOfertasLiquidacion();

    $(".footer-page").css({ "margin-bottom": "54px" });

    $("body").on("click", ".suma", function () {
        var article = $(this).parents("article").eq(0);
        var cantidad = $(article).find("#txtCantidad").val();
        var cajaTexto = $(article).find("#txtCantidad");
        if (cantidad == 99)
            $(cajaTexto).val(Number(99));
        else
            $(cajaTexto).val(Number(cantidad) + 1);
    });
    $("body").on("click", ".resta", function () {
        var article = $(this).parents("article").eq(0);
        var cantidad = $(article).find("#txtCantidad").val();
        var cajaTexto = $(article).find("#txtCantidad");
        if (cantidad == 1)
            $(cajaTexto).val(Number(1));
        else
            $(cajaTexto).val(Number(cantidad) - 1);
    });

    $("body").on("click", ".btnAgregarOfertaProducto", function (e) {
        var article = $(this).parents(".liquidacion_item").eq(0);
        PedidoRegistroModule.AgregarProductoOfertaLiquidacionMobile(article);
        e.preventDefault();
        (this).blur();
    });
    
});
function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {

            if (checkTimeout(data)) {
                if (data.success == false)
                    restringido = false;
                else {

                    if (data.pedidoReservado) {
                        var fnRedireccionar = function () {
                            ShowLoading();
                            location.href = urlPedidoValidado;
                        }
                        if (mostrarAlerta == true) {
                            CloseLoading();
                            AbrirPopupPedidoReservado(data.message, '2')
                        }
                        else fnRedireccionar();
                    }
                    else if (mostrarAlerta == true)
                        AbrirMensaje(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
            }
        }
    });
    return restringido;
}
function CargarOfertasLiquidacion() {
    $.ajax({
        type: 'GET',
        url: urlGetJSONLiquidaciones,
        data: { offset: offset, cantidadregistros: cantidadRegistros, origen: 'OfertaLiquidacion' },
        dataType: 'json',
        beforeSend: function () {
            $('#loader').show();
            $('#boton_vermas').hide();
        },
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                ArmarProductoLiquidaciones(data.lista);
                if (data.verMas == true) {
                    $('#boton_vermas').show();
                }
                offset += cantidadRegistros;
            }
        },
        complete: function (data) {
            $('#loader').hide();
            puedeCargar = true;
        },
        error: function (data) {
            if (checkTimeout(data)) {
                puedeCargar = true;
                $('#boton_vermas').show();
                $('#loader').hide();
            }
        }
    });
}
function ArmarProductoLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#OfertasLiquidacionMobile-template", data);
    $('#liquidacionMobile').append(htmlDiv);

    EstablecerAccionLazyImagen("img[data-lazy-seccion-liquidacion]");
}
function EstructurarDataCarouselLiquidaciones(array) {
    var contadorLq = 1;
    $.each(array, function (i, item) {
        item.Descripcion = (item.Descripcion.length > 60 ? item.Descripcion.substring(0, 60) + "..." : item.Descripcion);
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
        /* INI HD-4009 */
        item.ValPUM = (item.UnidadMedida == "" || item.PUM == "") ? false : true;
        item.UnidadMedida = (item.UnidadMedida || '').toLowerCase();
        /* FIN HD-4009 */
        contadorLq++;
    });

    return array;
}

function HorarioRestringido() {
    var horarioRestringido = false;
    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    window.messageInfo(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) { }
    });
    return horarioRestringido;
}
function ActualizarCantidadTotalPedido() {

    jQuery.ajax({
        type: 'POST',
        url: urlActualizarCantidadTotalPedido,
        dataType: 'json',
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    var data = response.data;

                    $(".num-menu-shop").html(data.CantidadProductos);
                } else {
                    window.messageInfo(response.message);
                }
            }
        },
        error: function (response, error) { }
    });
}
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, posicion) {
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "" || variant == "NO DISPONIBLE") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': 'Liquidaciones Web' },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': 'NO DISPONIBLE',
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': parseInt(posicion)
                    }]
                }
            }
        })
    }
}

