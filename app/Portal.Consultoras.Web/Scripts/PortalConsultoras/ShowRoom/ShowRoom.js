/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";
var origenPedidoWeb = origenPedidoWeb || 0;
var origenPedidoWebTactica = origenPedidoWebTactica || 0;
var origenPedidoWebCarrusel = origenPedidoWebCarrusel || 0;
var showRoomOrigenInsertar = showRoomOrigenInsertar || 0;

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {
        $(".verDetalleCompraPorCompra").click(function () {
            var padre = $(this).parents("[data-item]")[0];
            var article = $(padre).find("[data-campos]").eq(0);
            var posicion = $(article).find(".posicionEstrategia").val();

            $("#PopDetalleCompra").show();

            $('.content_carrusel_pop_compra.slick-initialized').slick('unslick');
            
            $('.content_carrusel_pop_compra').not('.slick-initialized').slick({
                dots: false,
                infinite: true,
                vertical: false,
                speed: 300,
                slidesToShow: 1,
                slidesToScroll: 1,
                prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -13%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
                nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -13%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
            });

            $('.content_carrusel_pop_compra').slick('slickGoTo', parseInt(posicion) - 1);
        });

        $('.responsive').not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;text-align:right"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
        });
        $('.content_ficha_compra').slick({
            dots: true,
            infinite: true,
            vertical: true,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            pantallaPedido: false,
            prevArrow: '<button type="button" data-role="none" class="slick-next next_compraxcompra"></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev previous_compraxcompra"></button>'
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

            $('.content_pop_compra.slick-initialized').slick('unslick');

            $('.content_pop_compra').slick({
                dots: false,
                infinite: true,
                vertical: false,
                speed: 300,
                slidesToShow: 1,
                slidesToScroll: 1,
                prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -10%; top: 35%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
                nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -10%; text-align:right;  top: 35%;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
            });

            $('.content_pop_compra').slick('slickGoTo', parseInt(posicion) - 1);
        });

        $("#CerrarPopCompra").click(function () {
            $('body').css({ 'overflow-y': 'scroll' });
            $('#PopCompra').hide();
        });

        $("footer").hide();
        $("#content").css("margin-top", "63px");

        $('.variable-width').on('init', function (event, slick) {
            setTimeout(function () {
                slick.setPosition();
                slick.slickGoTo(1);
                $("#divEstrategias").find("[data-posicion-set]").find(".orden_listado_numero").find("[data-posicion-current]").html(2);
            }, 500);
        }).slick({
            dots: true,
            infinite: false,
            speed: 300,
            slidesToShow: 2,
            centerPadding: '0px',
            centerMode: true,
            variableWidth: true,
            slidesToScroll: 1,
            centerMode: true,
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
        });

        $('.content_compra_carrusel').slick({
            dots: false,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: -13%; top:30%;"><img src="' + baseUrl + 'Content/Images/Esika/flecha_compra_left.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: -13%; top:30%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/flecha_compra_right.png")" alt="" /></a>'
        });
    }

    $("body").on("click", "[data-btn-agregar-sr]", function (e) {
        var padre = $(this).parents("[data-item]");        
        var article = $(padre).find("[data-campos]").eq(0);
        var cantidad = $(padre).find("[data-input='cantidad']").val();

        if (cantidad == "" || cantidad == 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.");
            return false;
        }        

        //AgregarProductoAlCarrito(padre);
        AgregarOfertaShowRoom(article, cantidad);
        e.preventDefault();
        (this).blur();
    });

    $("body").on("click", "[data-btn-agregar-cpc]", function (e) {
        var padre = $(this).parents("[data-item]");
        var article = $(padre).find("[data-campos]").eq(0);
        var cantidad = $(padre).find("[data-input='cantidad']").val();

        if (cantidad == "" || cantidad == 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.");
            return false;
        }

        //AgregarProductoAlCarrito(padre);
        AgregarOfertaShowRoomCpc(article, cantidad);
        e.preventDefault();
        (this).blur();
    });    

});

function CargarProductosShowRoom(busquedaModel) {
    //AbrirLoad();
    $.ajaxSetup({
        cache: false
    });

    $('#divProductosShowRoom').html('<div style="text-align: center; min-height:150px;"><br><br><br><br>Cargando Productos ShowRoom<br><img src="' + urlLoad + '" /></div>');

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ShowRoom/CargarProductosShowRoom',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(busquedaModel),
        async: true,
        success: function (response) {
            //CerrarLoad();

            if (response.success == true) {
                var lista = response.lista;

                $.each(lista, function (index, value) {
                    value.Posicion = index + 1;
                    value.UrlDetalle = urlDetalleShowRoom + '/' + value.OfertaShowRoomID;
                });

                $("#divProductosShowRoom").html("");

                var htmlDiv = SetHandlebars("#template-showroom", lista);
                $('#divProductosShowRoom').append(htmlDiv);

                $("#spnCantidadFiltro").html(response.cantidad);
                $("#spnCantidadTotal").html(response.cantidadTotal);

            } else messageInfoError(response.message);
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                CerrarLoad();
                console.log(response);
            }
        }
    });
}

function AgregarOfertaShowRoom(article, cantidad) {
    var CUV = $(article).find(".valorCuv").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var descripcionMarca = $(article).find(".DescripcionMarca").val();

    var origen;
    if (posicion != "0") {
        if (origenPedidoWebCarrusel != -1)
            origen = origenPedidoWebCarrusel;
        else if (tipoOrigenPantalla == 1) {
            origen = showRoomOrigenInsertar == 0 ? origenPedidoWeb : showRoomOrigenInsertar;
        }
        else
            origen = origenPedidoWeb;
    } else {
        origen = origenPedidoWeb;
    }

    AbrirLoad();
    $.ajaxSetup({
        cache: false
    });
    $.getJSON(baseUrl + 'ShowRoom/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
        if (parseInt(data.Saldo) < parseInt(cantidad)) {
            var Saldo = data.Saldo;
            var UnidadesPermitidas = data.UnidadesPermitidas;

            CerrarLoad();

            if (Saldo == UnidadesPermitidas)
                AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
            else {
                if (Saldo == "0")
                    AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                else
                    AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
            }
        } else {
            var Item = {
                MarcaID: MarcaID,
                Cantidad: cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID,
                OrigenPedidoWeb: origen
            };

            AgregarProductoAlCarrito($(article).parents("[data-item]"));

            $.ajaxSetup({ cache: false });

            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'ShowRoom/InsertOfertaWebPortal',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(Item),
                async: true,
                success: function (response) {
                    CerrarLoad();

                    if (response.success == true) {

                        if ($.trim(tipoOrigenPantalla)[0] == '1') {
                            CargarResumenCampaniaHeader(true);

                            $(article).parents("[data-item]").find(".product-add").css("display", "block");
                        }

                        if (tipoOrigenPantalla == 21) {
                            CargarCantidadProductosPedidos();
                        }

                        var padre = $(article).parents("[data-item]");
                        $(padre).find("[data-input='cantidad']").val(1);                        
                    }
                    else messageInfoError(response.message);
                },
                error: function (response, error) {
                    if (checkTimeout(response)) {
                        CerrarLoad();
                        console.log(response);
                    }
                }
            });
        }
    });
}

function AgregarOfertaShowRoomCpc(article, cantidad) {
    var CUV = $(article).find(".valorCuv").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var descripcionMarca = $(article).find(".DescripcionMarca").val();
     
    AbrirLoad();

    AgregarProductoAlCarrito($(article).parents("[data-item]"));

    $.ajaxSetup({
        cache: false
    });

    var Item = {
        MarcaID: MarcaID,
        Cantidad: cantidad,
        PrecioUnidad: PrecioUnidad,
        CUV: CUV,
        OrigenPedidoWeb: origenPedidoWebTactica
    };

    $.ajaxSetup({ cache: false });

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ShowRoom/InsertOfertaWebPortalCpc',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(Item),
        async: true,
        success: function(response) {
            CerrarLoad();

            if (response.success == true) {
                if ($.trim(tipoOrigenPantalla)[0] == '1') {
                    CargarResumenCampaniaHeader(true);
                    $("#PopDetalleCompra").hide();
                }

                if ($.trim(tipoOrigenPantalla)[0] == '2') {
                    CargarCantidadProductosPedidos();

                    $('#PopCompra').hide();
                    $('body').css({ 'overflow-x': 'auto' });
                    $('body').css({ 'overflow-y': 'auto' });
                }

                var padre = $(article).parents("[data-item]");
                $(padre).find("[data-input='cantidad']").val(1);

            } else messageInfoError(response.message);
        },
        error: function(response, error) {
            if (checkTimeout(response)) {
                CerrarLoad();
                console.log(response);
            }
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

        var carrito = $('.campana');
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
            'top': carrito.offset().top - 60,
            'left': carrito.offset().left + 100,
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
