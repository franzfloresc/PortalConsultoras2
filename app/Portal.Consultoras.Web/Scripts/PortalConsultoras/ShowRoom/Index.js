var listatipo = "";
var rangoPrecios = 0;
//var busquedaModel = null;

$(document).ready(function () {
    $(".footer_e").css("margin-bottom", "73px");

    $(".seleccion_filtro_fav").on("click", function () {

        $(this).toggleClass("seleccion_click_flitro");
    });

    TagManagerOfertaShowRoom();

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
                $(this).dialog('close');
            }
        }
    });

    $('#divMensajeProductoAgregado').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 456,
        draggable: true,
    });

    $("#btnCerrarSet").click(function () {
        $("#divMensajeProductoAgregado").dialog('close');
        $("#DialogSetDetalle").dialog("close");

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

    $("#btnVerDetalleCompraPorCompra").click(function () {
        $("#PopDetalleCompra").show();
        $('.content_carrusel_pop_compra').not('.slick-initialized').slick({
            dots: true,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -13%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -13%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        });        
    });

    $("#filter-sorting").change(function() {
        ObtenerProductosShowRoom();
    });

    $("[data-filtro-categoria]").click(function () {
        ObtenerProductosShowRoom();
    });

    $("#divBorrarFiltros").click(function () {
        $(".content_filtro_range").html("");
        $(".content_filtro_range").html('<input class="range-slider" value="" style="width: 100%; display: none;" />');
        CargarFiltroRangoPrecio();

        $.each($("[data-filtro-categoria]"), function (index, value) {
            $(value).removeClass("seleccion_click_flitro");
        });

        var busquedaModel = null;
        var ordenamiento = null;

        /*Ordenamiento*/
        var tipoOrdenamiento = "PRECIO";
        var valorOrdenamiento = $("#filter-sorting").val();

        ordenamiento = {
            Tipo: tipoOrdenamiento,
            Valor: valorOrdenamiento
        }

        busquedaModel = {
            Ordenamiento: ordenamiento
        };

        CargarProductosShowRoom(busquedaModel);
    });

    $("#linkTerminosCondicionesShowRoom").attr("href", urlTerminosCondiciones);

    CargarFiltroRangoPrecio();
    CargarProductosShowRoom(null);
});

function ObtenerProductosShowRoom() {
    var busquedaModel = filterShowRoomDesktop();
    CargarProductosShowRoom(busquedaModel);
}

function CargarFiltroRangoPrecio() {
    var precioMinFormat = DecimalToStringFormat(precioMin);
    var precioMaxFormat = DecimalToStringFormat(precioMax);

    precioMin = parseFloat(precioMin);
    precioMax = parseFloat(precioMax);

    var myformat = simbolo + '%s';
    var scala1 = simbolo + precioMinFormat;
    var scala2 = simbolo + precioMaxFormat;
    $('.range-slider').val(precioMin + ',' + precioMax);

    $('.range-slider').show();
    $('.range-slider').jRange({
        from: precioMin,
        to: precioMax,
        step: 1,
        scale: [scala1, scala2],
        format: myformat,
        width: '',
        showLabels: true,
        isRange: true,
        //onstatechange: function () {

        //},
        ondragend: function (myvalue) {
            rangoPrecios = myvalue;
            $(".slider-container").addClass("disabledbutton");
            ObtenerProductosShowRoom();
        },
        onbarclicked: function (myvalue) {
            rangoPrecios = myvalue;
            $(".slider-container").addClass("disabledbutton");
            ObtenerProductosShowRoom();
        }
    });
    //$('.range-slider').jRange('setValue', '0,100');
    //$('.range-slider').jRange('updateRange', '0,100');
    $('.slider-container').css('width', '');
}

function filterShowRoomDesktop() {
    var busquedaModel = null;
   
    var listaFiltro = null;
    var ordenamiento = null;
    
    /*Ordenamiento*/
    var tipoOrdenamiento = "PRECIO";
    var valorOrdenamiento = $("#filter-sorting").val();

    ordenamiento = {
        Tipo: tipoOrdenamiento,
        Valor: valorOrdenamiento
    }

    /*Filtros de Busqueda*/    
    var filtroCategoria = null;
    var tipoBusqueda = "CATEGORIA";
    var valores = new Array();

    var seleccionado = false;
    $.each($("[data-filtro-categoria]"), function (index, value) {               
        if ($(value).hasClass("seleccion_click_flitro")) {
            seleccionado = true;
            var valor = $(value).attr("data-categoriacodigo");
            valores.push(valor);
        }        
    });

    if (!seleccionado) {
        valores = null;
    }

    if (valores != null) {
        filtroCategoria = {
            Tipo: tipoBusqueda,
            Valores: valores
        };
    }
    
    var filtroRangoPrecio = null;
    var tipoBusquedaRangoPRecio = "RANGOPRECIOS";
    var valoresRangoPrecio = null;

    if (rangoPrecios != 0) {
        var arr = rangoPrecios.toString().split(',');
        valoresRangoPrecio = new Array();
        valoresRangoPrecio.push(arr[0]);
        valoresRangoPrecio.push(arr[1]);
    }

    if (valoresRangoPrecio != null) {
        filtroRangoPrecio = {
            Tipo: tipoBusquedaRangoPRecio,
            Valores: valoresRangoPrecio
        };
    }

    if (filtroCategoria != null || filtroRangoPrecio != null) {
        listaFiltro = new Array();

        if (filtroCategoria != null)
            listaFiltro.push(filtroCategoria);

        if (filtroRangoPrecio != null)
            listaFiltro.push(filtroRangoPrecio);
    }           

    busquedaModel = {
        ListaFiltro: listaFiltro,
        Ordenamiento: ordenamiento
    };

    return busquedaModel;
    //CargarProductosShowRoom(busquedaModel);
}

function maxLengthCheck(object, cantidadMaxima) {
    if (object.value.length > cantidadMaxima)
        object.value = object.value.slice(0, cantidadMaxima);
}

function TagManagerOfertaShowRoom() {
    var cadListaofertaShowRoom = $("#hdListaProductosEnShowRoom").val();
    var listaofertaShowRoom = JSON.parse(cadListaofertaShowRoom);
    var cantidadofertaShowRoom = $('.set-productos-showroom').length;

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

function AgregarTagManagerClickProducto(article, opcion) {
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var cuv = $(article).find(".valorCuv").val();
    var precio = $(article).find(".clasePrecioUnidad").val();
    var marca = $(article).find(".DescripcionMarca").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var list = opcion == 1 ? 'Ofertas Showroom' : 'Ofertas Showroom popUp';

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

    dataLayer.push({
        'event': 'productDetails',
        'ecommerce': {
            'detail': {
                'products': [{
                    'name': nombreProducto,
                    'id': cuv,
                    'price': precio,
                    'brand': marca,
                    'category': 'NO DISPONIBLE',
                }]
            }
        }
    });

}

function AgregarTagManagerProductoAgregadoSW(CUV, nombreProducto, PrecioUnidad, cantidad, descripcionMarca, tipo) {
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