/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {
        $(".verDetalleCompraPorCompra").click(function () {
            var padre = $(this).parents("[data-item]");
            var article = $(padre).find("[data-campos]").eq(0);
            var posicion = $(article).find(".posicionEstrategia").val();

            $("#PopDetalleCompra").show();

            $('.content_carrusel_pop_compra.slick-initialized').slick('unslick');
            
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
        var cantidad = 1;

        AgregarProductoAlCarrito(padre);
        AgregarOfertaShowRoomCpc(article, cantidad);
        e.preventDefault();
        (this).blur();
    });    

    $("body").on("click", "[data-compartir]", function (e) {
        CompartirRedesSociales(e);
    });
});

function AgregarOfertaShowRoom(article, cantidad) {
    var CUV = $(article).find(".valorCuv").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var descripcionMarca = $(article).find(".DescripcionMarca").val();

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
                ConfiguracionOfertaID: ConfiguracionOfertaID
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

    if (cantidad == "" || cantidad == 0) {
        AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.");
    } else {
        AbrirLoad();
        $.ajaxSetup({
            cache: false
        });

        var Item = {
            MarcaID: MarcaID,
            Cantidad: cantidad,
            PrecioUnidad: PrecioUnidad,
            CUV: CUV
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
                    }

                    if (tipoOrigenPantalla == 2) {
                        $('#PopCompra').hide();
                        $('body').css({ 'overflow-x': 'auto' });
                        $('body').css({ 'overflow-y': 'auto' });
                    }
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

function CompartirRedesSociales(e) {
    var obj = $(e.target);
    var tipoRedes = $.trim($(obj).parents("[data-compartir]").attr("data-compartir"));
    if (tipoRedes == "") return false;

    var padre = obj.parents("[data-item]");
    var article = $(padre).find("[data-compartir-campos]").eq(0);

    var label = $(article).find(".rs" + tipoRedes + "Mensaje").val();
    var ruta = $(article).find(".rs" + tipoRedes + "Ruta").val();

    if (label != "") {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ofertas Showroom',
            'action': 'Compartir ' + tipoRedes,
            'label': label,
            'value': 0
        });
    }
    
    if (ruta == "") return false;
    
    CompartirRedesSocialesInsertar(article, tipoRedes, ruta);
}

function CompartirRedesSocialesAbrirVentana(id, tipoRedes, ruta, texto) {
    id = $.trim(id);
    if (id == "0" || id == "")
        return false;
    ruta = $.trim(ruta);
    if (ruta == "") return false;

    ruta = ruta.replace('[valor]', id);

    if (tipoRedes == "FB") {
        var popWwidth = 570;
        var popHeight = 420;
        var left = (screen.width / 2) - (popWwidth / 2);
        var top = (screen.height / 2) - (popHeight / 2);
        var url = "http://www.facebook.com/sharer/sharer.php?u=" + ruta;
        window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
    } else if (tipoRedes == "WA") {
        ruta = ruta.ReplaceAll('/', '%2F');
        ruta = ruta.ReplaceAll(":", "%3A");
        ruta = ruta.ReplaceAll("?", "%3F");
        ruta = ruta.ReplaceAll("=", "%3D");

        if (texto != "")
            texto = texto + " - ";
        texto = texto.ReplaceAll("/", '%2F');
        texto = texto.ReplaceAll(":", "%3A");
        texto = texto.ReplaceAll("?", "%3F");
        texto = texto.ReplaceAll("=", "%3D");
        texto = texto.ReplaceAll(" ", "%32");
        texto = texto.ReplaceAll("+", "%43");
    }

    return "whatsapp://send?text=" + texto + ruta;
}

function CompartirRedesSocialesInsertar(article, tipoRedes, ruta) {
    AbrirLoad();
  
    var _rutaImagen = $.trim($(article).find(".rs" + tipoRedes + "RutaImagen").val());
    var _nombre = $.trim($(article).find(".rs" + tipoRedes + "Mensaje").val());
    var _marcaID = $.trim($(article).find(".MarcaID").val());
    var _marcaDesc = $.trim($(article).find(".MarcaNombre").val());
    var _descProd = $.trim($(article).find(".ProductoDescripcion").val());
    var _vol = $.trim($(article).find(".Volumen").val());
    var _palanca = $.trim($(article).find(".Palanca").val());

    var pcDetalle = _rutaImagen + "|" + _marcaID + "|" + _marcaDesc + "|" + _nombre;
    if (_palanca == "FAV") {
        pcDetalle += "|" + _vol + "|" + _descProd;
    }

    var Item = {
        mCUV: $(article).find(".CUV").val(),
        mPalanca: _palanca,
        mDetalle: pcDetalle,
        mApplicacion: tipoRedes
    };

    jQuery.ajax({
        type: 'POST',
        url: "/CatalogoPersonalizado/InsertarProductoCompartido",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(Item),
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    CompartirRedesSocialesAbrirVentana(response.data.id, tipoRedes, ruta, _nombre);
                } else {
                    window.messageInfo(response.message);
                }
            }
            CerrarLoad();
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                console.log(response);
            }
        }
    });
}
