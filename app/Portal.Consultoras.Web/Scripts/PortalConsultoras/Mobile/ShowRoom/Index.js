$(document).ready(function () {
    CargarFiltroRangoPrecio();
    //CargarProductosShowRoom(null);
    CargarShowroomMobile(null);

    var AbrirBanner = 0;
    $("#AbrirBannerCompra").click(function () {
        if (AbrirBanner == 0) {
            $('#BannerCompra').slideDown();
            AbrirBanner = 1;
        }
        else {
            $('#BannerCompra').slideUp();
            AbrirBanner = 0;
        }

    });

    $("#LlamarPopCompra").click(function () {
        $('body').css({ 'overflow-x': 'hidden' });
        $('body').css({ 'overflow-y': 'hidden' });
        $('#PopCompra').show();
        var id = $("#LlamarPopCompra").data("promotion-impresion-id");
        var name = $("#LlamarPopCompra").data("promotion-impresion-name");
        odd_mobile_promotion_impression(id, name);

        EstablecerLazyCarrusel($('.content_pop_compra'));
        $('.content_pop_compra').slick({
            lazyLoad: 'ondemand',
            dots: false,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -10%; top: 35%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -10%; text-align:right;  top: 35%;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarrusel($('.content_pop_compra'));
        });
    });

    $("#CerrarPopCompra").click(function () {
        $('body').css({ 'overflow-y': 'scroll' });
        $('#PopCompra').hide();
    });

    $("#btnCerrarPedido").click(function () {
        $("#divMensajeProductoAgregado").modal("hide");

        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ofertas Showroom',
            'action': 'Click popup Bolsa',
            'label': 'Volver a sets'
        });
    });

    $("#btnIrMipedido").click(function () {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ofertas Showroom',
            'action': 'Click popup Bolsa',
            'label': 'Ir a carrito'
        });
    });

    $("#orderby-price").change(function () {
        ObtenerProductosShowRoom();
        $("#orderby-price option:selected").each(function () {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ofertas Showroom',
                'action': 'Ordenar',
                'label': 'Ordenar por ' + $(this).text()
            });
        });
    });

    $("#btnBuscarShowRoom").click(function () {
        $('#custom-filters').hide();
        $('#div-delete-filters').hide();
        $('#orderby-filter').show();
        $('#divProductosShowRoom').show();
        $('body').css({ 'overflow-y': 'auto' });

        ObtenerProductosShowRoom();
    });
});

function ObtenerProductosShowRoom() {
    var busquedaModel = filterShowRoomMobile();
    CargarProductosShowRoom(busquedaModel);
}

function filterShowRoomMobile() {
    var busquedaModel = null;
    var mostrarBorrarFiltros = false;

    var listaFiltro = null;
    var ordenamiento = null;

    /*Ordenamiento*/
    var tipoOrdenamiento = "PRECIO";
    var valorOrdenamiento = $("#orderby-price").val();

    ordenamiento = {
        Tipo: tipoOrdenamiento,
        Valor: valorOrdenamiento
    }

    /*Filtros de Busqueda*/
    var filtroCategoria = null;
    var tipoBusqueda = "CATEGORIA";
    var valores = new Array();

    var seleccionado = false;
    $.each($('#idcategory').find('input[type="checkbox"]:checked'), function (index, value) {
        seleccionado = true;
        var valor = $(value).val();
        valores.push(valor);
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ofertas Showroom',
            'action': "Filtrar por Categorías",
            'label': $(value).val()
        });
    });

    if (!seleccionado) {
        valores = null;
    }

    if (valores != null) {
        filtroCategoria = {
            Tipo: tipoBusqueda,
            Valores: valores
        };

        mostrarBorrarFiltros = true;
    }

    var filtroRangoPrecio = null;
    var tipoBusquedaRangoPRecio = "RANGOPRECIOS";
    var valoresRangoPrecio = null;

    var range = $('#txt-range-price').bootstrapSlider('getValue');
    if (range != 'undefined') {
        valoresRangoPrecio = new Array();
        valoresRangoPrecio.push(range[0]);
        valoresRangoPrecio.push(range[1]);
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ofertas Showroom',
            'action': "Filtrar por Precios",
            'label': range[0] + " - " + range[1]
        });
    }

    if (valoresRangoPrecio != null) {
        filtroRangoPrecio = {
            Tipo: tipoBusquedaRangoPRecio,
            Valores: valoresRangoPrecio
        };

        mostrarBorrarFiltros = true;
    }

    if (filtroCategoria != null || filtroRangoPrecio != null) {
        listaFiltro = new Array();

        if (filtroCategoria != null)
            listaFiltro.push(filtroCategoria);

        if (filtroRangoPrecio != null)
            listaFiltro.push(filtroRangoPrecio);
    }

    if (mostrarBorrarFiltros) {
        $('#div-delete-filters').show();
    } else {
        $('#div-delete-filters').hide();
    }

    busquedaModel = {
        ListaFiltro: listaFiltro,
        Ordenamiento: ordenamiento
    };

    return busquedaModel;
}

function CargarFiltroRangoPrecio() {
    var min = Math.floor(precioMin);
    var max = Math.ceil(precioMax);

    var precioMinFormat = DecimalToStringFormat(min);
    var precioMaxFormat = DecimalToStringFormat(max);

    var mPremin = parseFloat(precioMin);
    var mPremax = parseFloat(precioMax);

    var rr = [];
    rr.push(mPremin);
    rr.push(mPremax);

    $('#min-range-price').text(precioMinFormat);
    $('#max-range-price').text(precioMaxFormat);

    $('#txt-range-price').bootstrapSlider({
        'precision': 2,
        'min': parseFloat(mPremin),
        'max': parseFloat(mPremax),
        'value': rr,
        'step': 1,
    });
}

function SetMarcaGoogleAnalyticsTermino() {
    dataLayer.push({ 'event': 'virtualEvent', 'category': 'Ofertas Showroom', 'action': 'Click enlace', 'label': 'Términos y Condiciones' });

}

function TagManagerOfertaShowRoom() {
    var cadListaofertaShowRoom = $("#hdListaProductosEnShowRoom").val();
    var listaofertaShowRoom = JSON.parse(cadListaofertaShowRoom);
    var cantidadofertaShowRoom = $('.listado_item').length;

    var arrayEstrategia = new Array();
    var position = 1;
    for (var i = 0; i < cantidadofertaShowRoom; i++) {
        var ofertaShowRoom = listaofertaShowRoom[i];
        var list = ofertaShowRoom.Stock > 0 ? 'Ofertas Showroom' : 'Ofertas Showroom - agotados';

        var impresionofertaShowRoom = {
            'name': ofertaShowRoom.Descripcion,
            'id': ofertaShowRoom.CUV,
            'price': ofertaShowRoom.PrecioCatalogo.toString(),
            'category': 'NO DISPONIBLE',
            'brand': ofertaShowRoom.DescripcionMarca,
            'position': position,
            'list': list
        };
        position++;
        arrayEstrategia.push(impresionofertaShowRoom);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}

function AgregarTagManagerProductoAgregadoSWR(CUV, nombreProducto, PrecioUnidad, cantidad, descripcionMarca, tipo) {

    var lista = tipo == 0 ? "Ofertas Showroom" : "Ofertas Showroom popUp";
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': lista },
                'products': [{
                    'name': nombreProducto,
                    'id': CUV,
                    'price': PrecioUnidad,
                    'brand': descripcionMarca,
                    'variant': 'Ofertas Showroom',
                    'category': 'NO DISPONIBLE',
                    'quantity': cantidad
                }]
            }
        }
    });
}

function AgregarTagManagerProductoAgregado(CUV, nombreProducto, PrecioUnidad, cantidad, descripcionMarca) {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'products': [{
                    'name': nombreProducto,
                    'id': CUV,
                    'price': PrecioUnidad,
                    'brand': descripcionMarca,
                    'variant': 'Ofertas Showroom',
                    'category': 'NO DISPONIBLE',
                    'quantity': cantidad
                }]
            }
        }
    });
}

function AgregarTagManagerClickProducto(article) {
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var cuv = $(article).find(".valorCuv").val();
    var precio = $(article).find(".clasePrecioUnidad").val();
    var marca = $(article).find(".DescripcionMarca").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var list = 'Ofertas Showroom';

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': list },
                'products': [{
                    'name': nombreProducto,
                    'id': cuv,
                    'price': precio,
                    'brand': marca,
                    'category': 'NO DISPONIBLE',
                    'position': parseInt(posicion)
                }]
            }
        }
    });
}

function CompartirFacebook(urlBase) {
    var popWwidth = 570;
    var popHeight = 420;
    var left = (screen.width / 2) - (popWwidth / 2);
    var top = (screen.height / 2) - (popHeight / 2);
    var url = "http://www.facebook.com/sharer/sharer.php?u=" + urlBase;

    window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
}

function showCustomFilters() {
    $('body').css({ 'overflow-x': 'hidden' });
    $('body').css({ 'overflow-y': 'hidden' });
    $('#orderby-filter').hide();
    $('#divProductosShowRoom').hide();
    $('#custom-filters').show();
}

function deleteFilters() {

    $('#custom-filters').hide();
    $('#div-delete-filters').hide();
    $('#orderby-filter').show();

    var mPremin = parseFloat(precioMin);
    var mPremax = parseFloat(precioMax);
    $('#txt-range-price').bootstrapSlider('setValue', [mPremin, mPremax]);

    $.each($('#idcategory').find('input[type="checkbox"]:checked'), function (index, value) {
        $(this).prop("checked", false);
    });

    $('#divProductosShowRoom').show();
    $('body').css({ 'overflow-y': 'auto' });
    var busquedaModel = null;
    var ordenamiento = null;

    /*Ordenamiento*/
    var tipoOrdenamiento = "PRECIO";
    var valorOrdenamiento = $("#orderby-price").val();

    ordenamiento = {
        Tipo: tipoOrdenamiento,
        Valor: valorOrdenamiento
    }

    busquedaModel = {
        Ordenamiento: ordenamiento
    };

    CargarProductosShowRoom(busquedaModel);
}

function showOrderbyFilter() {
    $('#custom-filters').hide();
    $('#div-delete-filters').hide();
    $('#orderby-filter').show();
    $('#divProductosShowRoom').show();
    $('body').css({ 'overflow-y': 'auto' });
}

function OcultarSliderMobile() {
    $('#custom-filters').hide();
    $('#orderby-filter').show();
    $('#divCatalogoPersonalizado').show();
}

function odd_mobile_promotion_impression(id, name) {
    dataLayer.push({
        'event': 'promotionView',
        'ecommerce': {
            'promoView': {
                'promotions': [
                {
                    'id': id,
                    'name': name,
                    'position': 'Showroom Footer',
                    'creative': 'Promocion Showroom'
                }]
            }
        }
    });

    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                {
                    'id': id,
                    'name': name,
                    'position': 'Showroom Footer',
                    'creative': 'Promocion Showroom'
                }]
            }
        }
    });
}