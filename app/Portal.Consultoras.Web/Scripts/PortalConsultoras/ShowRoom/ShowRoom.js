/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";
var origenPedidoWeb = origenPedidoWeb || 0;
var origenPedidoWebCarrusel = origenPedidoWebCarrusel || 0;
var showRoomOrigenInsertar = showRoomOrigenInsertar || 0;

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {
        $(".verDetalleCompraPorCompra").click(function () {
            var padre = $(this).parents("[data-item]")[0];
            var article = $(padre).find("[data-campos]").eq(0);
            var posicion = $(article).find(".posicionEstrategia").val();

            $("#PopDetalleCompra").show();

            EstablecerLazyCarrusel('.content_carrusel_pop_compra');
            $('.content_carrusel_pop_compra.slick-initialized').slick('unslick');
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

            $('.content_carrusel_pop_compra').slick('slickGoTo', parseInt(posicion) - 1);
        });

        EstablecerLazyCarrusel('.responsive');

        $('.responsive').not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;text-align:right"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange($('.responsive'));
        });

        EstablecerLazyCarrusel('.content_ficha_compra');
        $('.content_ficha_compra').slick({
            lazyLoad: 'ondemand',
            dots: true,
            infinite: true,
            vertical: true,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            pantallaPedido: false,
            prevArrow: '<button type="button" data-role="none" class="slick-next next_compraxcompra"></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev previous_compraxcompra"></button>'
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange($('.content_ficha_compra'));
        });

        //marca google analytics*******************************
        var divs = $(".content_ficha_compra").find("[data-campos]");
        var array_impresions_tactica_desktop = [];

        $(divs).each(function (index, value) {
            var existe = false;
            var id = $(value).find(".valorCuv").val();
            $(array_impresions_tactica_desktop).each(function (ind, val) {
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
    }
    else if (tipoOrigenPantalla == 21) { // Mobile Oferta Detalle
        $(".verDetalleCompraPorCompra").click(function () {
            var padre = $(this).parents("[data-item]");
            var article = $(padre).find("[data-campos]").eq(0);
            var posicion = $(article).find(".posicionEstrategia").val();

            $('body').css({ 'overflow-x': 'hidden' });
            $('body').css({ 'overflow-y': 'hidden' });
            $('#PopCompra').show();

            EstablecerLazyCarrusel('.content_pop_compra');
            $('.content_pop_compra.slick-initialized').slick('unslick');
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
                EstablecerLazyCarruselAfterChange('.content_pop_compra');
            });

            $('.content_pop_compra').slick('slickGoTo', parseInt(posicion) - 1);
        });

        $("#CerrarPopCompra").click(function () {
            $('body').css({ 'overflow-y': 'scroll' });
            $('#PopCompra').hide();
        });

        $("footer").hide();
        $("#content").css("margin-top", "63px");

        EstablecerLazyCarrusel('.variable-width');

        $('.variable-width').on('init', function (event, slick) {
            setTimeout(function () {
                slick.setPosition();
                slick.slickGoTo(1);
                $("#divEstrategias").find("[data-posicion-set]").find(".orden_listado_numero").find("[data-posicion-current]").html(2);
            }, 500);
        }).slick({
            lazyLoad: 'ondemand',
            infinite: false,
            speed: 300,
            slidesToShow: 2,
            centerPadding: '0px',
            centerMode: true,
            variableWidth: true,
            slidesToScroll: 1,
            arrows: false,
            dots: false,
        }).on('swipe', function (event, slick, direction) {
            var posicion = slick.currentSlide;
            posicion = Math.max(parseInt(posicion), 0);

            if (direction == 'left') { // dedecha a izquierda
                posicion = posicion + 1;
            } else if (direction == 'right') {
                posicion = posicion + 1;
            }

            $("#divEstrategias").find("[data-posicion-set]").find(".orden_listado_numero").find("[data-posicion-current]").html(posicion);
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange('.variable-width');
        });

        EstablecerLazyCarrusel('.content_compra_carrusel');
        $('.content_compra_carrusel').slick({
            lazyLoad: 'ondemand',
            dots: false,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: -13%; top:30%;"><img src="' + baseUrl + 'Content/Images/Esika/flecha_compra_left.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: -13%; top:30%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/flecha_compra_right.png")" alt="" /></a>'
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange('.content_compra_carrusel');
        });

        var divs = $(".content_pop_compra").find("[data-campos]");
        var array_impresions_tactica_desktop = [];

        $(divs).each(function (index, value) {
            var existe = false;
            var id = $(value).find(".valorCuv").val();
            $(array_impresions_tactica_desktop).each(function (ind, val) {
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

    }
    else if (tipoOrigenPantalla == 2) {
    }

    $("#btn_descubre_mobile").on("click", function () {
        $('body').css({ 'overflow-y': 'hidden' });
        var effect = 'slide';
        var options = { direction: 'down' };
        var duration = 500;
        $('.content_display_set_suboferta').toggle(effect, options, duration);
        $('#agregarSetEspecial').slideDown();
        $("div.content_btn_agregar").find("#txtCantidad").val(1);
        ConfigurarSlick();
    });
    $("#btn_cerrar_mobile").on("click", function () {
        var effect = 'slide';
        var options = { direction: 'down' };
        var duration = 500;
        $('.content_display_set_suboferta').toggle(effect, options, duration);
        $('#agregarSetEspecial').slideUp();
        $('body').css({ 'overflow-y': 'auto' });

    });

});

function CargarProductosShowRoom(busquedaModel) {
    $.ajaxSetup({ cache: false });

    $('#divProductosShowRoom').html('<div style="text-align: center; min-height:150px;"><br><br><br><br>Cargando Productos ShowRoom<br><img src="' + urlLoad + '" /></div>');
    $("#divProductosShowRoom").show();

    var aplicarFiltrosSubCampanias = (busquedaModel == null);
    var cargarProductosShowRoomPromise = CargarProductosShowRoomPromise(busquedaModel);


    $.when(cargarProductosShowRoomPromise)

        .then(function (response) {
            ResolverCargarProductosShowRoomPromiseDesktop(response, aplicarFiltrosSubCampanias, busquedaModel);
            EstablecerAccionLazyImagen("img[data-lazy-seccion-showroom]");
        })
        .fail(function (response) {
            if (busquedaModel.hidden) {
                var impressions = [];

                if (typeof value != "undefined") {

                    var impression = {
                        name: value.Descripcion,
                        id: value.CUV,
                        price: value.PrecioOferta,
                        category: 'NO DISPONIBLE',
                        brand: value.DescripcionMarca,
                        position: index + 1,
                        list: 'Ofertas Showroom'
                    };

                    impressions.push(impression);
                }

                if (impressions.length > 0) {
                    dataLayer.push({
                        'event': 'productImpression',
                        'ecommerce': { 'impressions': impressions }
                    });
                }

                $("#divProductosShowRoom").hide();
            }
            if (checkTimeout(response)) {
                CerrarLoad();
            }
        });

}

function AgregarProductoAlCarrito(padre) {


    if ($.trim(tipoOrigenPantalla)[0] == '1') {
        var contenedorImagen = $(padre).find("[data-img]");
        var imagenProducto = $('.imagen_producto', contenedorImagen);

        if (imagenProducto.length <= 0) {
            return false;
        }

        var carrito = $('.campana.cart_compras');
        if (carrito.length <= 0) {
            return false;
        }

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
}

function CargarProductosShowRoomPromise(busquedaModel) {
    var d = $.Deferred();
    var promise = $.ajax({
        type: 'POST',
        url: baseUrl + 'Estrategia/SRObtenerProductos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(busquedaModel),
        async: true
    });
    promise.done(function (response) {
        d.resolve(response);
    });
    promise.fail(d.reject);
    return d.promise();
}

function ResolverCargarProductosShowRoomPromiseDesktop(response, aplicarFiltrosSubCampanias, busquedaModel) {
    var objData = {};
    if (response.success) {

        console.log('cantidadTotal-0', response);
        response.totalOfertas = response.cantidadTotal0;
        response.listaOfertas = Clone(response.lista || []);
        response.listaOfertasPerdio = Clone(response.listaPerdio || []);
        response.lista = [];
        response.listaPerdio = [];

        AnalyticsSRListaOferta(response);

        if (aplicarFiltrosSubCampanias) {
            if (response.listaSubCampania !== 'undefined') {
                if (response.listaSubCampania.length > 0) {
                    $.each(response.listaSubCampania,
                        function (i, v) { v.Descripcion = IfNull(v.Descripcion, '').SubStrToMax(35, true); });
                    objData.lista = response.listaSubCampania;
                    SetHandlebars("#banner-sub-campania-template", objData.lista[0], "#banner-sub-campania");
                    SetHandlebars("#producto-landing-template", objData, "#contenedor-showroom-subcampanias");
                    $('#divContentSubCampania').show();

                    EstablecerLazyCarrusel('#contenedor-showroom-subcampanias');

                    if (!$(objData.lista).filter(function (a, b) {
                        return b.Hermanos.length > 0
                    })[0]) {
                        $('.sub_campania_info_adicional').remove();
                    }
                }
            }
        }

        $.each(response.listaOfertas, function (index, value) {
            value.Descripcion = IfNull(value.Descripcion, '').SubStrToMax($.trim(tipoOrigenPantalla)[0] == '1' ? 40 : 30, true);
            value.Posicion = index + 1;
        });

        objData.lista = response.listaOfertas;
        SetHandlebars("#producto-landing-template", objData, '#divProductosShowRoom');

        if (response.listaOfertasPerdio != 'undefined') {
            if (response.listaOfertasPerdio.length > 0) {
                $("#contenido_zona_dorada").show();
                $("#block_inscribete").show();
                $("#divOfertaProductosPerdio").show();

                objData.lista = response.listaOfertasPerdio;

                SetHandlebars("#producto-landing-template", objData, '#divOfertaProductosPerdio');
            }
        }

        $('#divContentShowRoomHome').show();
        $("#spnCantidadFiltro").html(response.listaOfertas.length);
        $("#spnCantidadTotal").html(response.totalOfertas);

        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");
    }
    else {
        messageInfoError(response.message);
        if (busquedaModel && busquedaModel.hidden) { $("#divProductosShowRoom").hide(); }
    }
}

function CargarShowroomMobile(busquedaModel) {

    var cargarProductosShowRoomPromise = CargarProductosShowRoomPromise(busquedaModel);

    $.when(cargarProductosShowRoomPromise)
        .then(function (response) {
            ResolverCargarProductosShowRoomPromiseMobile(response, busquedaModel);
        })
        .fail(function (response) {
            if (busquedaModel && busquedaModel.hidden) {
                $("#divProductosShowRoom").hide();
            }
            if (checkTimeout(response)) {
                CerrarLoad();
            }
        });
}

function ResolverCargarProductosShowRoomPromiseMobile(response, busquedaModel) {
    if (response.success) {

        console.log('cantidadTotal-0', response);
        response.totalOfertas = response.cantidadTotal0;
        response.listaOfertas = Clone(response.lista || []);
        response.listaOfertasPerdio = Clone(response.listaPerdio || []);
        response.lista = [];
        response.listaPerdio = [];

        AnalyticsSRListaOferta(response);

        $.each(response.listaOfertas, function (index, value) {
            value.Descripcion = IfNull(value.Descripcion, '').SubStrToMax($.trim(tipoOrigenPantalla)[0] == '1' ? 40 : 30, true);
            value.Posicion = index + 1;
        });

        var objData = {};
        objData.lista = response.listaOfertas;

        SetHandlebars("#producto-landing-template", objData, '#divProductosShowRoom');

        if (response.listaOfertasPerdio != 'undefined') {
            if (response.listaOfertasPerdio.length > 0) {
                $("#contenido_zona_dorada").show();
                $("#block_inscribete").show();
                $("#divOfertaProductosPerdio").show();

                objData.lista = response.listaOfertasPerdio;

                SetHandlebars("#producto-landing-template", objData, '#divOfertaProductosPerdio');
            }
        }

        $("#spnCantidadFiltro").html(response.listaOfertas.length);
        $("#spnCantidadTotal").html(response.totalOfertas);

        if (response.listaSubCampania != 'undefined') {
            if (response.listaSubCampania.length > 0) {
                $.each(response.listaSubCampania,
                    function (i, v) { v.Descripcion = IfNull(v.Descripcion, '').SubStrToMax(30, true); });

                var dataSub = new Object();
                dataSub.CantidadProductos = response.listaSubCampania.length;
                dataSub.Lista = AsignarPosicionAListaOfertas(response.listaSubCampania);

                SetHandlebars("#template-showroom-subcampanias-mobile", dataSub, "#contenedor-showroom-subcampanias-mobile");
                $('#divContentSubCampania').show();

                EstablecerLazyCarrusel('#contenedor-showroom-subcampanias-mobile');

                if (!$(objData.lista).filter(function (a, b) {
                      return b.Hermanos.length > 0
                })[0]) {
                    $('.sub_campania_info_adicional').remove();
                }
            }
        }

        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");
    }
    else {
        messageInfoError(response.message);
        if (busquedaModel && busquedaModel.hidden) { $("#divProductosShowRoom").hide(); }
    }
}

function ConfigurarSlick() {
    $('#contenedor-showroom-subcampanias-mobile.slick-initialized').slick('unslick');
    $('#contenedor-showroom-subcampanias-mobile').slick({
        lazyLoad: 'ondemand',
        dots: false,
        infinite: true,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        speed: 260,
        prevArrow: '<a style="width: auto; display: block; left:  0; margin-left:  9%; top: 24%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
        nextArrow: '<a style="width: auto; display: block; right: 0; margin-right: 9%; text-align:right;  top: 24%;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
    });
    $('#contenedor-showroom-subcampanias-mobile').slick('slickGoTo', 0);
}

function AsignarPosicionAListaOfertas(listaOfertas) {
    var posicion = 0;
    var nuevaListaOfertas = [];

    $.each(listaOfertas, function (index, value) {
        posicion++;
        value.Posicion = posicion;
        value.Contenido = ConstruirDescripcionOferta(value.Hermanos);
        nuevaListaOfertas.push(value);
    });

    return nuevaListaOfertas;
}

function ConstruirDescripcionOferta(arrDescripcion) {
    var descripcion = "";
    if (arrDescripcion != null) {
        $.each(arrDescripcion, function (index, value) {
            descripcion += value.Descripcion + "<br />";
        });
    }
    return descripcion;
}

function AnalyticsSRListaOferta(response) {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        var origen = {
            Pagina: isHome() 
                ? ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
                : ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingShowroom,
            Palanca: ConstantesModule.OrigenPedidoWebEstructura.Palanca.Showroom,
            Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel
        };
        var obj = {
            lista: response.listaOfertas,
            CantidadMostrar: response.listaOfertas.length,
            Origen: origen
        };
        
        console.log('AnalyticsSRListaOferta', obj);
        AnalyticsPortalModule.MarcaGenericaLista("", obj);
    }
}
