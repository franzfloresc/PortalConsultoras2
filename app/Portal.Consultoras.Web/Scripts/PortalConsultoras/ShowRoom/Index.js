var listatipo = "";
var rangoPrecios = 0;

$(document).ready(function () {
    $("body").on("click", "#VerOfertaEspecial", function () {
        $('#PopupBannerEspecial').css('display', 'block');
        $('div.banner_especial_showroom').css('z-index', 1000);

        $('#content_set_especial_header').hide();
        $('#BajarOfertaEspecial').show();
        $('.content_set_oferta_especial').slideDown();

        $('#contenedor-showroom-subcampanias.slick-initialized').slick('unslick');
        $('#contenedor-showroom-subcampanias').not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            slidesToShow: 3,
            dots: false,
            vertical: false,
            infinite: true,
            speed: 300,
            useCSS: true,
            centerPadding: '0px',
            centerMode: true,
            slidesToScroll: 1,
            variableWidth: false,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: -35px; text-align:left; top:10%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: -35px; text-align:right; top:10%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
        });

        $('#contenedor-showroom-subcampanias').slick('slickGoTo', 1);
    });
    $("body").on("click", "#BajarOfertaEspecial", function() {
            $('#PopupBannerEspecial').css('display', 'none');
            $('div.banner_especial_showroom').css('z-index', 150);

            $('#content_set_especial_header').show();
            $('#BajarOfertaEspecial').hide();

            $('.content_set_oferta_especial').slideUp();

        });
    var stilo;
    $("#CerrarOfertaEspecial").on("click", function () {
        $('.banner_especial_showroom').hide();
        $(".footer_e").css("margin-bottom", "0px");
        localStorage["cerrar_banner_sub_campanias"] = true;
    });

    if (localStorage["cerrar_banner_sub_campanias"])
        $('.banner_especial_showroom').hide();
    else {
        stilo = $('.banner_especial_showroom').attr("style");
        if (stilo != null) {
            stilo = stilo.replace("display:none", "display:block");
            //$('.banner_especial_showroom').attr("style", stilo);
            //$('.banner_especial_showroom').show();
        }
    }

    $(".seleccion_filtro_fav").on("click", function () {
        $(this).toggleClass("seleccion_click_flitro");
    });

    //TagManagerOfertaShowRoom();

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
        draggable: true
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

        EstablecerLazyCarrusel('.content_carrusel_pop_compra');

        $('.content_carrusel_pop_compra').not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            dots: false,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -13%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -13%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange('.content_carrusel_pop_compra');
        });

        var divs = $("#PopDetalleCompra").find("[data-campos]");
        var array_impresions_tactica_desktop = new Array();

        $(divs).each(function (index, value) {
            var existe = false;
            var id = $(value).find(".valorCuv").val();
            $(array_impresions_tactica_desktop).each(function(ind, val) {
                if (val.id == id)
                    existe = true;
            });

            if (!existe) {
                array_impresions_tactica_desktop.push({
                    name: $(value).find(".DescripcionProd").val(),
                    id: id,
                    price: $(value).find(".clasePrecioUnidad").val(),
                    category: 'NO DISPONIBLE',
                    brand: $(value).find(".DescripcionMarca").val(),
                    position: $(value).find(".posicionEstrategia").val(),
                    list: 'Ofertas Showroom'
                });
            }
        });
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': array_impresions_tactica_desktop
            }
        });
    });

    $("#filter-sorting").change(function () {
        ObtenerProductosShowRoom();
        $("#filter-sorting option:selected").each(function () {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ofertas Showroom',
                'action': 'Ordenar',
                'label': 'Ordenar por ' + $(this).text()
            });
        });
    });

    $("[data-filtro-categoria]").click(function () {
        ObtenerProductosShowRoom();
    });

    $("#divBorrarFiltros").click(function () {
        $(".content_filtro_range").html("");
        $(".content_filtro_range").html('<input class="range-slider" type="text" value="" />');
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

        $(this).hide();
    });

    $("#linkTerminosCondicionesShowRoom").attr("href", urlTerminosCondiciones);

    CargarFiltroRangoPrecio();
    CargarProductosShowRoom(null);

    if (closeBannerCompraPorCompra == "True") {
        $("#divBannerCompraPorCompra").hide();
        $(".footer_e").css("margin-bottom", "0px");
    } else {
        $("#divBannerCompraPorCompra").show();
        compraxcompra_promotion_impression();
        $(".footer_e").css("margin-bottom", "73px");
    }

    var cerrar_banner_sub_campanias = false;
    var ver_subcamapania = false;
    var ver_compraxcompra = false;

    if (localStorage["cerrar_banner_sub_campanias"]) {
        cerrar_banner_sub_campanias = true;
    }
    //if (tieneSubCampania == "True" && itemsSubCampania > 0 && cerrar_banner_sub_campanias == false) {
    //    ver_subcamapania = true;
    //}
    if (tieneCompraXCompra == "True" && itemsCompraXCompra > 0 && closeBannerCompraPorCompra == "False") {
        ver_compraxcompra = true;
    }
    if (ver_subcamapania == false && ver_compraxcompra == false) {
        $(".footer_e").css("margin-bottom", "0px");
    }
    else if (ver_subcamapania == true && ver_compraxcompra == true) {
        $("#divBannerCompraPorCompra").hide();
         stilo = $('.banner_especial_showroom').attr("style");
        if (stilo != null) {
             stilo = stilo.replace("display:none", "display:block");
            //$('.banner_especial_showroom').attr("style", stilo);
            //$('.banner_especial_showroom').show();
        }
        $(".footer_e").css("margin-bottom", "73px");
    }
    else if (ver_subcamapania == true) {
        $("#divBannerCompraPorCompra").hide();
         stilo = $('.banner_especial_showroom').attr("style");
        if (stilo != null) {
             stilo = stilo.replace("display:none", "display:block");
            //$('.banner_especial_showroom').attr("style", stilo);
            //$('.banner_especial_showroom').show();
        }
    }
    else if (ver_compraxcompra == true) {
        $('.banner_especial_showroom').hide();
        $("#divBannerCompraPorCompra").show();
        compraxcompra_promotion_impression();
        if ($("#divBannerCompraPorCompra").length > 0) {
            $(".footer_e").css("margin-bottom", "73px");
        }
        else {
            $(".footer_e").css("margin-bottom", "0px");
        }
    }

    $(".swproddetcompra").on("click", function () {

    });

    $('#filtro_categoria').on('click', function () {
        $('#detalle_filtro_categoria').toggle();
    });

    $('#filtro_precio').on('click', function () {
        $('#detalle_filtro_precio').toggle();
    });

    $('div.pointer-label.low').css('left', '0');
    $('div.pointer-label.high').css('left', '214px');
});

function ObtenerProductosShowRoom() {
    var busquedaModel = filterShowRoomDesktop();
    CargarProductosShowRoom(busquedaModel);
}

function CargarFiltroRangoPrecio() {
    var min = Math.floor(precioMin);
    var max = Math.ceil(precioMax);
    var precioMinFormat = DecimalToStringFormat(min);
    var precioMaxFormat = DecimalToStringFormat(max);

    var myformat = variablesPortal.SimboloMoneda;
    var scala1 = variablesPortal.SimboloMoneda + precioMinFormat;
    var scala2 = variablesPortal.SimboloMoneda + precioMaxFormat;

    $('.range-slider').val(min + ',' + max);

    $('.range-slider').ionRangeSlider({
        hide_min_max: true,
        keyboard: true,
        min: min,
        max: max,
        from: min,
        to: max,
        type: 'double',
        step: 1,
        prefix: myformat,
        grid: true,
        grid_num: 1,
        onFinish: function (data) {
            rangoPrecios = data.from + "," + data.to;
            $(".slider-container").addClass("disabledbutton");
            ObtenerProductosShowRoom();

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ofertas ShowRoom',
                'action': "Filtrar por Precios",
                'label': data.from + " - " + data.to
            });
        }
    });

    $(".js-grid-text-0").text(scala1);
    $(".js-grid-text-1").text(scala2);
    $("#detalle_filtro_precio").css("display", "none");
}

function filterShowRoomDesktop() {
    var busquedaModel = null;
    var mostrarBorrarFiltros = false;

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
            var descripcion = $('.seleccion_filtro_fav.seleccion_click_flitro').html();

            valores.push(valor);
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ofertas ShowRoom',
                'action': "Filtrar por Categorías",
                'label': descripcion
            });

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

        mostrarBorrarFiltros = true;
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
        $("#divBorrarFiltros").show();
    } else {
        $("#divBorrarFiltros").hide();
    }

    busquedaModel = {
        ListaFiltro: listaFiltro,
        Ordenamiento: ordenamiento
    };

    return busquedaModel;
}

function closeCompraPorCompra() {
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ShowRoom/CerrarBannerCompraPorCompra',
        dataType: 'json',
        async: true,
        success: function (response) {
            if (response.success == true) {
                $(".footer_e").css("margin-bottom", "0px");
                $("#divBannerCompraPorCompra").hide();
            } else messageInfoError(response.message);
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                CerrarLoad();
            }
        }
    });
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
            'price': ofertaShowRoom.PrecioOferta.toString(),
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

function compraxcompra_promotion_impression() {
    var id = $("#divBannerCompraPorCompra").data("cuv");
    var name = 'Showroom – ' + $("#divBannerCompraPorCompra").data("descripcion");
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
}

