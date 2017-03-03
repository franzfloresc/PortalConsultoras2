/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {

        //$('.js-slick-prev').remove();
        //$('.js-slick-next').remove();
        //$('.responsive').slick('unslick');

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
        $('.content_carrusel_pop_compra').slick({
            dots: true,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -13%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -13%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        });
        $('.content_ficha_compra').slick({
            dots: true,
            infinite: true,
            vertical: true,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -13%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -13%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        });
    }
    else if (tipoOrigenPantalla == 21) {
        $('.slider').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            dots: false,
            prevArrow: '<span class="previous_ofertas_mobile" id="slick-prev"><img src="' + urlCarruselPrev + '")" alt="-"/></span>',
            nextArrow: '<span class="previous_ofertas_mobile" id="slick-next" style="text-align:right; right:0;"><img src="' + urlCarruselNext + '" alt="-"/></span>',
            infinite: true,
            speed: 300,
            responsive: [
                {
                    breakpoint: 960,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 680,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                },
                {
                    breakpoint: 380,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        });
    }

    $("body").on("click", "[data-btn-agregar-sr]", function (e) {
        var padre = $(this).parents("[data-item]");
        var article = $(padre).find("[data-campos]").eq(0);
        var cantidad = $(padre).find("[data-input='cantidad']").val();
        //listatipo = "0";

        AgregarProductoAlCarrito(padre);
        AgregarOfertaShowRoom(article, cantidad);
        e.preventDefault();
        (this).blur();
    });

    $("body").on("click", "[data-btn-agregar-cpc]", function (e) {
        var padre = $(this).parents("[data-item]");
        var article = $(padre).find("[data-campos]").eq(0);
        var cantidad = $(padre).find("[data-input='cantidad']").val();
        //listatipo = "0";

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

    if (cantidad == "" || cantidad == 0) {
        alert_msg("La cantidad ingresada debe ser mayor que 0, verifique.");
    } else {
        waitingDialog({});
        $.ajaxSetup({
            cache: false
        });
        $.getJSON(baseUrl + 'ShowRoom/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
            if (parseInt(data.Saldo) < parseInt(cantidad)) {
                var Saldo = data.Saldo;
                var UnidadesPermitidas = data.UnidadesPermitidas;

                closeWaitingDialog();

                if (Saldo == UnidadesPermitidas)
                    alert_msg("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                else {
                    if (Saldo == "0")
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                    else
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                }
            } else {
                var Item = {
                    MarcaID: MarcaID,
                    Cantidad: cantidad,
                    PrecioUnidad: PrecioUnidad,
                    CUV: CUV,
                    ConfiguracionOfertaID: ConfiguracionOfertaID
                };

                $.ajaxSetup({ cache: false });

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'ShowRoom/InsertOfertaWebPortal',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(Item),
                    async: true,
                    success: function (response) {
                        closeWaitingDialog();

                        if (response.success == true) {                            

                            if ($.trim(tipoOrigenPantalla)[0] == '1') {
                                CargarResumenCampaniaHeader(true);

                                //Aparecer Agregado
                                $(article).parents("[data-item]").find(".product-add").css("display", "block");
                            }                            

                            //AgregarTagManagerProductoAgregadoSW(CUV, nombreProducto, PrecioUnidad, cantidad, descripcionMarca, listatipo);
                            //TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), CUV);

                            //AgregarProductoAlCarrito($(article).parents("[data-item]"));
                        }
                        else messageInfoError(response.message);
                    },
                    error: function (response, error) {
                        if (checkTimeout(response)) {
                            closeWaitingDialog();
                            console.log(response);
                        }
                    }
                });
            }
        });
    }
}

function AgregarOfertaShowRoomCpc(article, cantidad) {
    var CUV = $(article).find(".valorCuv").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var descripcionMarca = $(article).find(".DescripcionMarca").val();

    if (cantidad == "" || cantidad == 0) {
        alert_msg("La cantidad ingresada debe ser mayor que 0, verifique.");
    } else {
        waitingDialog({});
        $.ajaxSetup({
            cache: false
        });

        var Item = {
            MarcaID: MarcaID,
            Cantidad: cantidad,
            PrecioUnidad: PrecioUnidad,
            CUV: CUV,
            ConfiguracionOfertaID: ConfiguracionOfertaID
        };

        $.ajaxSetup({ cache: false });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'ShowRoom/InsertOfertaWebPortal',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(Item),
            async: true,
            success: function(response) {
                closeWaitingDialog();

                if (response.success == true) {
                    if ($.trim(tipoOrigenPantalla)[0] == '1') {
                        CargarResumenCampaniaHeader(true);
                        $("#PopDetalleCompra").hide();
                    }
                } else messageInfoError(response.message);
            },
            error: function(response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                    console.log(response);
                }
            }
        });
    }
}

function AgregarProductoAlCarrito(padre) {
    //Desktop
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
                'opacity': 0,
                //}, 100, 'swing', function () {
                //    $(".campana .info_cam").fadeIn(200);
                //    $(".campana .info_cam").delay(2500);
                //    $(".campana .info_cam").fadeOut(200);
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
    ShowLoading();
    //Capturando valores
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
            CloseLoading();
            if (checkTimeout(response)) {
                if (response.success) {
                    CompartirRedesSocialesAbrirVentana(response.data.id, tipoRedes, ruta, _nombre);
                } else {
                    window.messageInfo(response.message);
                }
            }
        },
        error: function (response, error) {
            CloseLoading();
            if (checkTimeout(response)) {
                console.log(response);
            }
        }
    });
}

