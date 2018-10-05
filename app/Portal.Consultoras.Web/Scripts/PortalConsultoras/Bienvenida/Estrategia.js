
// 1: escritorio Home    11 : escritorio Pedido 
// 2: mobile  Home       21 : mobile pedido
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";

// Cuarto Dígito
// 0. Sin popUp         1. Con popUp
var conPopup = conPopup || "";

var tieneOPT = false;
var origenRetorno = $.trim(origenRetorno);
var origenPedidoWebEstrategia = origenPedidoWebEstrategia || "";
var divAgregado = null;

var revistaDigital = revistaDigital || {};

function CargarCarouselEstrategias() {
    $.ajax({
        type: "GET",
        url: baseUrl + "Estrategia/JsonConsultarEstrategias",
        data: {
            tipoOrigenEstrategia: tipoOrigenEstrategia
        },
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            data.Lista = Clone(data.ListaModelo);
            data.ListaModelo = [];
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $("#divListadoEstrategia").html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
}

var CargarCarouselMasVendidos = function (origen) {
    var model = obtenerModelMasVendidos();
    if (model != null) {
        $("#divCarrouselMasVendidos.slick-initialized").slick("unslick");
        ArmarCarouselMasVendidos(model);
        inicializarDivMasVendidos(origen);
        _validarDivTituloMasVendidos();
    }
};

var obtenerModelMasVendidos = function () {
    var model = get_local_storage("data_mas_vendidos");
    if (typeof model === "undefined" || model === null) {
        var promesa = _obtenerModelMasVendidosPromise();
        $.when(promesa)
            .then(function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        model = response.data;
                        set_local_storage(model, "data_mas_vendidos");
                    }
                }
            });
    }
    return model;
};

var _obtenerModelMasVendidosPromise = function () {
    var d = $.Deferred();
    var promise = $.ajax({
        type: "GET",
        url: baseUrl + "Estrategia/BSObtenerOfertas",
        data: "",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: false
    });

    promise.done(function (response) {
        d.resolve(response);
    });
    promise.fail(d.reject);

    return d.promise();
};

function inicializarDivMasVendidos(origen) {
    $("#divCarrouselMasVendidos.slick-initialized").slick("unslick");

    var slickArrows = {
        'mobile': {
            prev: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-left:-12%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
            next: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-right:-12%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
        },
        'desktop': {
            prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
        }
    };

    $("#divCarrouselMasVendidos").not(".slick-initialized").slick({
        infinite: true,
        vertical: false,
        centerMode: false,
        centerPadding: "0px",
        slidesToShow: 4,
        slidesToScroll: 1,
        autoplay: false,
        speed: 270,
        pantallaPedido: false,
        prevArrow: slickArrows[origen].prev,
        nextArrow: slickArrows[origen].next,
        responsive: [
            {
                breakpoint: 1200,
                settings: { slidesToShow: 3, slidesToScroll: 1 }
            },
            {
                breakpoint: 900,
                settings: { slidesToShow: 2, slidesToScroll: 1 }
            },
            {
                breakpoint: 600,
                settings: { slidesToShow: 1, slidesToScroll: 1 }
            }
        ]
    });
}

function ArmarCarouselMasVendidos(data) {
    data.Lista = EstructurarDataCarousel(data.Lista);
    $("#divCarrouselMasVendidos").empty();

    var promesa = _actualizarModelMasVendidosPromise(data);
    $.when(promesa)
        .then(function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    data = response.data;
                    SetHandlebars("#mas-vendidos-template", data, "#divCarrouselMasVendidos");
                    if (data.Lista == null) data.Lista = [];
                    PintarEstrellas(data.Lista);
                    PintarRecomendaciones(data.Lista);
                    PintarPrecioTachado(data.Lista);
                }
            }
        });
}

function PintarPrecioTachado(listaMasVendidos) {
    for (var i = 0; i < listaMasVendidos.length; i++) {
        _pintarPrecioTachado(listaMasVendidos[i]);
    }
}

function _pintarPrecioTachado(item) {
    var xdiv = "#precio-tachado-" + item.EstrategiaID.toString();
    if (item.Ganancia > 0) {
        $(xdiv).show();
    }
    else {
        $(xdiv).hide();
    }
}

function PintarRecomendaciones(listaMasVendidos) {
    for (var i = 0; i < listaMasVendidos.length; i++) {
        _pintarRecomendaciones(listaMasVendidos[i]);
    }
}

function _pintarRecomendaciones(item) {
    var xdiv = "#recommedation-" + item.EstrategiaID.toString();
    var recommendation = "(" + item.CantComenAprob.toString() + ")";
    $(xdiv).html(recommendation);
    $(xdiv).show();
}

function PintarEstrellas(listaMasVendidos) {
    for (var i = 0; i < listaMasVendidos.length; i++) {
        _pintarEstrellas(listaMasVendidos[i]);
    }
}

function _pintarEstrellas(item) {
    if (item != null && item != undefined) {
        item.EstrategiaID = item.EstrategiaID || 0;
        item.PromValorizado = item.PromValorizado || 0;

        var xdiv = "#star-" + item.EstrategiaID.toString();
        var rating = "";
        rating = item.PromValorizado.toString() + "%";

        if ($(xdiv).length) {
            $(xdiv).rateYo({
                rating: rating,
                numStars: 5,
                precision: 2,
                minValue: 1,
                maxValue: 5,
                starWidth: "17px",
                readOnly: true
            });
            $(xdiv).show();
        }
    }

}

function ArmarCarouselEstrategias(data) {
    $("#divListaEstrategias").hide();
    $(".js-slick-prev").remove();
    $(".js-slick-next").remove();
    $("#divListadoEstrategia.slick-initialized").slick("unslick");

    data.Lista = data.Lista || [];
    if (data.Lista.length == 0) {
        $("#divListaEstrategias").show();
        $("#divContenedorListaEstrategia").hide();
        $(".contenido_gana_mas").hide();
        //if (revistaDigital) {
        //    if (revistaDigital.TieneRDC) {
                if (isMobile()) {
                    $(".wrapper_resumen_mobile_clubganamas .zonadecolor, .wrapper_resumen_mobile_clubganamas").css({ "height": "200px" });
                } else {
                    $(".contenedor_ganamas").css({ "height": "100px" });
                    $(".sb_contenedor_ganamas_bg").css({ "height": "100px" });
                    $(".contenedor_ganamas .sb_contenedor_ganamas").css({ "top": "-100px" });
                }
        //    }
        //}
        
        return false;
    }

    $.each(data.ListaLan, function (i, item) { item.Posicion = i + 1; });
    $.each(data.Lista, function (i, item) {
        item.EsBanner = false;
        item.EsLanzamiento = false;
    });
    tieneOPT = true;

    $("#divListaEstrategias").attr("data-OrigenPedidoWeb", data.OrigenPedidoWeb);
    
    if (revistaDigital != null) {
        if (revistaDigital.TieneRDC) {            
            if (data.ListaLan) {
                if (data.ListaLan.length > 0) {
                    if (revistaDigital.EsActiva) {
                        var productoLanzamiento = {};
                        $.extend(true, productoLanzamiento, data.ListaLan[0]);
                        productoLanzamiento.EsLanzamiento = true;
                        productoLanzamiento.EsBanner = false;
                        productoLanzamiento.ClaseEstrategia = data.Lista[0].ClaseEstrategia;

                        if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 2) {
                            data.Lista.splice(0, 0, productoLanzamiento);
                        }
                    }
                }
            }

            if (!revistaDigital.EsSuscrita) {
                var bannerClubGanaMas = {};
                $.extend(true, bannerClubGanaMas, data.Lista[0]);
                bannerClubGanaMas.EsBanner = true;

                if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 2) {
                    data.Lista.splice(3, 0, bannerClubGanaMas);
                }
                else if (tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 21) {
                    data.Lista.splice(1, 0, bannerClubGanaMas);
                }
            }            
        }
    }

    $.each(data.Lista, function (i, item) { item.Posicion = i + 1; });
    arrayOfertasParaTi = data.Lista;
    data.lista = data.Lista;
    SetHandlebars("#producto-landing-template", data, "#divListadoEstrategia");

    if (tipoOrigenEstrategia == 11) {
        $("#cierreCarousel").hide();
        $("[data-barra-width]").css("width", indicadorFlexiPago == 1 ? "68%" : "100%");

        $(".caja_pedidos").addClass("sinOfertasParaTi");
        $(".tooltip_infoCopy").addClass("tooltip_infoCopy_expand");
    }

    if ($.trim($("#divListadoEstrategia").html()).length == 0) {
        return false;
    }

    RevisarMostrarContenedorCupon();

    if (tipoOrigenEstrategia == 1) {
        var cantProCarrusel = 4;
        var esVariableWidth = true;

        $("#divListaEstrategias #divListadoEstrategia [data-item] > div").attr("class", "content_item_carrusel");
        $("#divListaEstrategias").show();

        EstablecerLazyCarrusel("#divListadoEstrategia");

        $("#divListadoEstrategia").not(".slick-initialized").slick({
            lazyLoad: "ondemand",
            infinite: true,
            vertical: false,
            slidesToShow: cantProCarrusel,
            slidesToScroll: 1,
            autoplay: false,
            variableWidth: esVariableWidth,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
            responsive: [
                {
                    breakpoint: 1025,
                    settings: {
                        slidesToShow: cantProCarrusel > 3 ? 3 : cantProCarrusel
                    }
                }
            ]
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange("#divListadoEstrategia");
        });
    }
    else if (tipoOrigenEstrategia == 11) {
        $("#divListaEstrategias #divListadoEstrategia [data-item] > div").attr("class", "producto_carousel");
        $("#divListaEstrategias #divListadoEstrategia [data-item]").css("padding-bottom", "0");

        $("[data-barra-width]").css("width", "100%");
        $("#divListaEstrategias").show();
        if (indicadorFlexiPago == 1) {
            $("#divListaEstrategias").css("margin-top", ($(".flexiPago_belcorp").outerHeight() + 50) + "px");
        }
        $(".caja_pedidos").removeClass("sinOfertasParaTi");
        $(".tooltip_infoCopy").removeClass("tooltip_infoCopy_expand");
        var hCar = $($("#divListadoEstrategia").find("[data-item]").get(0)).height();
        var heightReference = $("#divListadoPedido").find("[data-tag='table']").height();
        var cant = parseInt(heightReference / hCar);
        cant = cant < 3 ? 3 : cant > 5 ? 5 : cant;
        cant = data.CodigoEstrategia == "101" ? (data.Lista.length > 4 ? 4 : data.Lista.length) : cant;

        EstablecerLazyCarrusel("#divListadoEstrategia");

        var claseFlechaDoradaNext = "";
        var claseFlechaDoradaPrev = "";

        if (revistaDigital) {
            if (revistaDigital.TieneRDC) {
                if (revistaDigital.EsSuscrita) {
                    claseFlechaDoradaNext = "next-flecha-dorada";
                    claseFlechaDoradaPrev = "prev-flecha-dorada";
                }
            }
        }        

        $("#divListadoEstrategia").not(".slick-initialized").slick({
            lazyLoad: "ondemand",
            infinite: true,
            vertical: true,
            centerMode: false,
            centerPadding: "0px",
            slidesToShow: cant,
            slidesToScroll: 1,
            autoplay: false,
            speed: 270,
            pantallaPedido: false,
            prevArrow: '<button type="button" data-role="none" class="slick-next ' + claseFlechaDoradaNext+' "></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev ' + claseFlechaDoradaPrev+'"></button>'
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange("#divListadoEstrategia");
        });

        if (data.Lista.length > cant) {
            $("#cierreCarousel").show();
        }
        MostrarBarra();
    }
    else if (tipoOrigenEstrategia == 2) {
        $("#div-linea-OPT").show();
        $("#divListaEstrategias").show();

        EstablecerLazyCarrusel("#divListadoEstrategia");

        $("#divListadoEstrategia").slick({
            lazyload: "ondemand",
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev" href="javascript:void(0);" style="margin-left:-12%; padding-top:150px; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next" href="javascript:void(0);" style="margin-right:-12%; padding-top:150px; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>',
            arrows: false,
            centerMode: true,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 900,
                    settings: { slidesToShow: 2, slidesToScroll: 1 }
                },
                {
                    breakpoint: 600,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange("#divListadoEstrategia");
        });
    }
    else if (tipoOrigenEstrategia == 21) {
        $("#divListaEstrategias").show();

        EstablecerLazyCarrusel("#divListadoEstrategia");

        $("#divListadoEstrategia").slick({
            lazyLoad: "ondemand",
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            dots: false,
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev" href="javascript:void(0);" id="slick-prev" style="margin-left:-13%; padding-top:150px;"><img src="' + urlCarruselPrev + '")" alt="-"/></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next" href="javascript:void(0);" id="slick-next" style="margin-right:-7%; padding-top:150px; text-align:right; right:0;"><img src="' + urlCarruselNext + '" alt="-"/></a>',
            infinite: true,
            speed: 300,
            arrows: false,
            centerMode: true,
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
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            EstablecerLazyCarruselAfterChange("#divListadoEstrategia");
        });
    }

    TagManagerCarruselInicio(data.Lista);
}

function EstrategiaCarouselOn(event, slick, currentSlide, nextSlide) {
    var posicionEstrategia, recomendado, arrayEstrategia;
    var origen = tipoOrigenEstrategia == 1 ? "Home" : tipoOrigenEstrategia == 11 ? "Pedido" :
        tipoOrigenEstrategia == 2 ? "MobileHome" : tipoOrigenEstrategia == 21 ? "MobilePedido" : "";
    var accion;
    if (nextSlide == 0 && currentSlide + 1 == arrayOfertasParaTi.length) {
        accion = "next";
    } else if (currentSlide == 0 && nextSlide + 1 == arrayOfertasParaTi.length) {
        accion = "prev";
    } else if (nextSlide > currentSlide) {
        accion = "next";
    } else {
        accion = "prev";
    }

    if (accion == "prev") {
        var posicionPrimerActivo = $($("#divListadoEstrategia").find(".slick-active")[0]).find(".PosicionEstrategia").val();
         posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length - 1 : posicionPrimerActivo - 2;
         recomendado = arrayOfertasParaTi[posicionEstrategia];
         arrayEstrategia = [];
        arrayEstrategia.push({
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': $.trim(recomendado.Precio2),
            'brand': recomendado.DescripcionMarcaEstrategiaAgregarProducto,
            'category': "NO DISPONIBLE",
            'variant': recomendado.DescripcionEstrategia,
            'list': "Ofertas para ti - " + origen,
            'position': recomendado.Posicion
        });

        dataLayer.push({
            'event': "productImpression",
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
        dataLayer.push({
            'event': "virtualEvent",
            'category': origen,
            'action': "Ofertas para ti",
            'label': "Ver anterior"
        });
    } else if (accion == "next") {
        var posicionUltimoActivo = $($("#divListadoEstrategia").find(".slick-active").slice(-1)[0]).find(".PosicionEstrategia").val();
         posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
         recomendado = arrayOfertasParaTi[posicionEstrategia];
         arrayEstrategia = [];
         arrayEstrategia.push({
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': $.trim(recomendado.Precio2),
            'brand': recomendado.DescripcionMarca,
            'category': "NO DISPONIBLE",
            'variant': recomendado.DescripcionEstrategia,
            'list': "Ofertas para ti - " + origen,
            'position': recomendado.Posicion
        });

        dataLayer.push({
            'event': "productImpression",
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
        dataLayer.push({
            'event': "virtualEvent",
            'category': origen,
            'action': "Ofertas para ti",
            'label': "Ver siguiente"
        });
    }
}

function EstructurarDataCarousel(array) {
    array = array || [];
    var isList = array.length != undefined;
    var lista = [];
    if (typeof array == "object") {
        lista = isList ? array : [];
        if (!isList)
            lista.push(array);
    }

    var urlOfertaDetalle = $.trim(urlOfertaDetalle);
    $.each(lista, function (i, item) {
        item.DescripcionCUV2 = $.trim(item.DescripcionCUV2);
        item.DescripcionCompleta = item.DescripcionCUV2.split("|")[0];
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split("|")[0];
            item.ArrayContenidoSet = item.DescripcionCUV2.split("|").slice(1);
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        }

        item.Posicion = i + 1;
        item.MostrarTextoLibre = (item.TextoLibre ? $.trim(item.TextoLibre).length > 0 : false);
        item.UrlDetalle = urlOfertaDetalle + "/" + (item.ID || item.Id) || "";
        item.PrecioVenta = item.PrecioString;
    });
    return isList ? lista : lista[0];
}

function EstrategiaVerDetalle(id, origen) {
    if ($.trim(origen) == "") {
        origen = $("#divListadoEstrategia").attr("data-OrigenPedidoWeb") || origenPedidoWebEstrategia || 0;
    }
    origen = $.trim(origen) || 0;
    var url = getMobilePrefixUrl() + "/OfertasParaTi/Detalle?id=" + id + "&&origen=" + origen;
    try {
        if (typeof GuardarProductoTemporal == "function" && typeof GetProductoStorage == "function") {
            var campania = $("[data-item=" + id + "]").parents("[data-tag-html]").attr("data-tag-html");
            var cuv = $("[data-item=" + id + "]").attr("data-item-cuv");
            var obj = {};
            if (typeof cuv == "undefined" || typeof campania == "undefined") {
                obj = JSON.parse($("[data-item=" + id + "]").attr("data-estrategia"));
            }
            if (obj.length == 0) {
                obj = GetProductoStorage(cuv, campania);
            }

            obj.CUV2 = $.trim(obj.CUV2);
            if (obj.CUV2 != "") {
                if (GuardarProductoTemporal(obj)){
                    window.location = url;
                    return true;
                }
            }
        }
    } catch (e) {
        console.log(e);
    }
    window.location = url;
}



function CargarProductoDestacado(objParameter, objInput, popup, limite) {
    if ($.trim($(objInput).attr("data-bloqueada")) != "") {
        if (isMobile()) {
            EstrategiaVerDetalle(objParameter.EstrategiaID);
        } else {
            var divMensaje = $("#divMensajeBloqueada");
            if (divMensaje.length > 0) {
                var itemClone = $(objInput).parents("[data-item]");
                var cuvClone = $.trim(itemClone.attr("data-clone-item"));
                if (cuvClone != "") {
                    itemClone = $("body").find("[data-content-item='" + $.trim(itemClone.attr("data-clone-content")) + "']").find("[data-item='" + cuvClone + "']");
                }
                if (itemClone.length > 0) {
                    divMensaje.find("[data-item-html]").html(itemClone.html());
                    divMensaje = divMensaje.find("[data-item-html]");
                    divMensaje.find('[data-item-tag="body"]').removeAttr("data-estrategia");
                    divMensaje.find('[data-item-tag="body"]').css("min-height", "auto");
                    divMensaje.find('[data-item-tag="body"]').css("float", "none");
                    divMensaje.find('[data-item-tag="body"]').css("margin", "0 auto");
                    divMensaje.find('[data-item-tag="body"]').css("background-color", "#fff");
                    divMensaje.find('[data-item-tag="body"]').attr("class", "");
                    divMensaje.find('[data-item-tag="agregar"]').remove();
                    divMensaje.find('[data-item-tag="fotofondo"]').remove();
                    divMensaje.find('[data-item-tag="verdetalle"]').remove();
                    divMensaje.find('[data-item-accion="verdetalle"]').remove();
                    divMensaje.find('[data-item-tag="contenido"]').removeAttr("onclick");
                    divMensaje.find('[data-item-tag="contenido"]').css("position", "initial");
                    divMensaje.find('[data-item-tag="contenido"]').attr("class", "");
                }

                //$(".contenedor_popup_detalleCarousel").hide(); DEUDA TECNICA
                $("#divMensajeBloqueada").show();
            }
        }

        return false;
    }
    var attrClass = $.trim($(objInput).attr("class"));
    if ((" " + attrClass + " ").indexOf(" btn_desactivado_general ") >= 0) {
        $(objInput).parents("[data-item]").find("[data-tono-select='']").find("[data-tono-change='1']").parent().addClass("tono_no_seleccionado");
        setTimeout(function () {
            $(objInput).parents("[data-item]").find("[data-tono-change='1']").parent().removeClass("tono_no_seleccionado");
        }, 500);
        return false;
    }

    if (ReservadoOEnHorarioRestringido())
        return false;

    AbrirLoad();

    popup = popup || false;
    limite = limite || 0;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;

    var cantidadIngresada = (limite > 0) ? limite : $(".btn_agregar_ficha_producto ").parents("[data-item]").find("input.liquidacion_rango_cantidad_pedido").val() ||
        $(objInput).parents("[data-item]").find("input.rango_cantidad_pedido").val() || 
        $(objInput).parents("[data-item]").find("[data-input='cantidad']").val();
    origenPedidoWebEstrategia =
        $(objInput).parents("[data-item]").find("input.OrigenPedidoWeb").val() ||
        $(objInput).parents("[data-item]").attr("OrigenPedidoWeb") || 
        $(objInput).parents("[data-item]").attr("data-OrigenPedidoWeb") || 
        $(objInput).parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb") || 
        origenPedidoWebEstrategia;

    var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    divAgregado = $(objInput).parents("[data-item]").find(".agregado.product-add");

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "AdministrarEstrategia/FiltrarEstrategiaPedido",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {

            if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
                agregarProductoAlCarrito(objInput);

                if (objParameter.FlagNueva == "1")
                    $("#OfertaTipoNuevo").val(objParameter.FlagNueva);
                else
                    $("#OfertaTipoNuevo").val("");
            }

            datos.data.cantidadIngresada = cantidadIngresada;
            datos.data.posicionItem = posicionItem;

            var estrategiaCarrusel = popup ? {} : JSON.parse($(objInput).parents("[data-estrategia]").attr("data-estrategia"));

            var codigoEstrategia = popup ? $(objInput).parents("[data-item]").find("[data-estrategia]").attr("data-estrategia") : estrategiaCarrusel.CodigoEstrategia;
            if ((codigoEstrategia == "2001" || codigoEstrategia == "2003") && popup) {
                var cuvs = $("[data-tono][data-tono-select]");
                if (cuvs.length > 0) {
                    $.each(cuvs,
                        function (i, item) {
                            var cuv = $(item).attr("data-tono-select");
                            if (cuv != "") {
                                datos.data.CUV2 = cuv;
                                if (codigoEstrategia == "2003") {
                                    datos.data.MarcaID = $(item).find("#Estrategia_hd_MarcaID").val();
                                    datos.data.Precio2 = $(item).find("#Estrategia_hd_PrecioCatalogo").val();
                                }
                                EstrategiaAgregarProducto(datos.data, popup, tipoEstrategiaImagen);
                            }
                        });
                } else {
                    EstrategiaAgregarProducto(datos.data, popup, tipoEstrategiaImagen);
                }
            }
            else {
                EstrategiaAgregarProducto(datos.data, popup, tipoEstrategiaImagen);
            }
            $(objInput).parents("[data-item]").find("input.rango_cantidad_pedido").val(1);
            $(objInput).parents("[data-item]").find("[data-input='cantidad']").val(1);
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function EstrategiaAgregarProducto(datosEst, popup, tipoEstrategiaImagen) {
    AbrirLoad();
    var marcaID = datosEst.MarcaID;
    var cuv = datosEst.CUV2;
    var precio = datosEst.Precio2;
    var ofertas = datosEst.DescripcionCUV2.split("|");
    var descripcion = ofertas[0];
    var cantidad = datosEst.cantidadIngresada;
    var cantidadLimite = datosEst.LimiteVenta;
    var indicadorMontoMinimo = datosEst.IndicadorMontoMinimo;
    var OrigenPedidoWeb = origenPedidoWebEstrategia;

    if (datosEst.FlagNueva == 1) {
        cantidad = cantidadLimite;
    }
    else {
        descripcion = datosEst.DescripcionCUV2;
    }

    if (!$.isNumeric(cantidad)) {
        AbrirMensajeEstrategia("Ingrese un valor numérico.");
        $(".liquidacion_rango_cantidad_pedido").val(1);
        CerrarLoad();
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        AbrirMensajeEstrategia("La cantidad debe ser mayor a cero.");
        $(".liquidacion_rango_cantidad_pedido").val(1);
        CerrarLoad();
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        AbrirMensajeEstrategia("La cantidad no debe ser mayor que la cantidad límite ( " + cantidadLimite + " ).");
        CerrarLoad();
        return false;
    }

    var param = {
        CUV: cuv,
        Cantidad: cantidad,
        PrecioUnidad: precio,
        TipoEstrategiaID: datosEst.TipoEstrategiaID || $("#hdTipoEstrategiaID").val(),
        OrigenPedidoWeb: OrigenPedidoWeb,
        MarcaID: marcaID,
        DescripcionProd: descripcion,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        ClienteID_: "-1",
        TipoEstrategiaImagen: tipoEstrategiaImagen || 0,
        Descripcion: descripcion,
        TipoOferta: datosEst.TipoEstrategiaID || $("#hdTipoEstrategiaID").val(),
        enRangoProgNuevas: datosEst.FlagNueva == "1"
    };

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/ValidarStockEstrategia",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        async: false,
        success: function (datos) {
            if (!datos.result) {
                if (datos.message.length > 0) {
                    AbrirMensajeEstrategia(datos.message);
                }
                CerrarLoad();
            }
            else {
                jQuery.ajax({
                    type: "POST",
                    url: baseUrl + "Pedido/AgregarProductoZE",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            CerrarLoad();
                            return false;
                        }

                        if (data.success != true) {
                            if (!IsNullOrEmpty(data.tituloMensaje)) AbrirMensaje(data.message, data.tituloMensaje);
                            else messageInfoError(data.message);
                            CerrarLoad();
                            return false;
                        }

                        AbrirLoad();

                        if (divAgregado != null) {
                            $(divAgregado).show();
                        }
                        if (tipoOrigenEstrategia == 1) {
                            MostrarBarra(data, "1");
                            ActualizarGanancia(data.DataBarra);
                            CargarCarouselEstrategias();
                            CargarResumenCampaniaHeader(true);
                        }
                        else if (tipoOrigenEstrategia == 11) {
                            $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);
                            cierreCarouselEstrategias();
                            CargarCarouselEstrategias();
                            CargarResumenCampaniaHeader();
                            HideDialog("divVistaPrevia");

                            tieneMicroefecto = true;
                            CargarDetallePedido();
                            MostrarBarra(data);
                        }
                        else if ($.trim(tipoOrigenEstrategia)[0] == "1") {
                            CargarResumenCampaniaHeader(true);
                        }
                        else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21 || tipoOrigenEstrategia == 27 || tipoOrigenEstrategia == 262 || tipoOrigenEstrategia == 272) {

                            ActualizarGanancia(data.DataBarra);
                            if (tipoOrigenEstrategia == 262) {
                                origenRetorno = $.trim(origenRetorno);
                                if (origenRetorno != "") {
                                    window.location = origenRetorno;
                                }
                            }
                            else if (tipoOrigenEstrategia != 272) {
                                CargarCarouselEstrategias();                           
                            }
                        }
                        
                        // falta agregar este metodo en para las revista digital
                        try {
                            TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                            TagManagerClickAgregarProductoOfertaParaTI(datosEst);
                        } catch (e) { }

                        CerrarLoad();
                        if (popup) {
                            CerrarPopup("#popupDetalleCarousel_lanzamiento");
                            HidePopupEstrategiasEspeciales();
                        }
                        if (!IsNullOrEmpty(data.mensajeAviso)) AbrirMensaje(data.mensajeAviso, data.tituloMensaje);

                        ActualizarLocalStorageAgregado("rd", param.CUV, true);
                        ActualizarLocalStorageAgregado("gn", param.CUV, true);
                        ActualizarLocalStorageAgregado("hv", param.CUV, true);
                        ActualizarLocalStorageAgregado("lan", param.CUV, true);

                        ProcesarActualizacionMostrarContenedorCupon();
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CerrarLoad();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarLoad();
            }
        }
    });
}

function HidePopupEstrategiasEspeciales() {
    //$("#popupDetalleCarousel_packNuevas").hide(); DEUDA TECNICA (BORRAR ESTA FUNCIÓN DESPUES)
}

function CerrarLoad() {
    if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
        closeWaitingDialog();
    }
    else if (tipoOrigenEstrategia == 11) {
        CerrarSplash();
    }
    else if ($.trim(tipoOrigenEstrategia)[0] == 2) {
        CloseLoading();
    } else if (isMobile()) {
        CloseLoading();
    }
    else {
        closeWaitingDialog();
    }
}

function AbrirLoad() {
    if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
        waitingDialog();
    }
    else if (tipoOrigenEstrategia == 11) {
        AbrirSplash();
    }
    else if ($.trim(tipoOrigenEstrategia)[0] == 2) {
        ShowLoading();
    }
    else if (isMobile()) {
        ShowLoading();
    }
    else {
        waitingDialog();
    }
}

function AbrirMensajeEstrategia(txt) {
    if (tipoOrigenEstrategia == 1) {
        alert_msg_pedido(txt);
    }
    else if (tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
        alert_msg(txt);
    }
    else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21 || tipoOrigenEstrategia == 262) {
        messageInfo(txt);
    }

    else if (isMobile()) {
        messageInfo(txt);
    }
    else {
        alert_msg(txt);
    }
}

function ProcesarActualizacionMostrarContenedorCupon() {
    if (typeof paginaOrigenCupon !== "undefined" && paginaOrigenCupon) {
        if (cuponModule) {
            cuponModule.actualizarContenedorCupon();
        }
    }
}

function RevisarMostrarContenedorCupon() {
   
    if (typeof finishLoadCuponContenedorInfo !== "undefined" && finishLoadCuponContenedorInfo) {
        if (cuponModule) {
            cuponModule.revisarMostrarContenedorCupon();
        }
    }
}

function _validarDivTituloMasVendidos() {
    var tieneMasVendidosFlag = _validartieneMasVendidos();
    var xmodel = get_local_storage("data_mas_vendidos");
    var xlista = [];

    if (xmodel !== "undefined" && xmodel !== null) {
        xlista = xmodel.Lista;
    }

    if (tieneMasVendidosFlag === 0) {
        $(".content_mas_vendidos").hide();
        return;
    }

    if (tieneMasVendidosFlag === 1) {
        if (xlista.length === 0) {
            $(".content_mas_vendidos").hide();
        }
        else {
            $(".content_mas_vendidos").show();
        }
    }
}

function GuardarProductoTemporal(obj) {

    $.ajaxSetup({
        cache: false
    });

    AbrirLoad();

    var varReturn = false;

    obj.TipoAccionAgregar = obj.TipoAccionAgregarBack || obj.TipoAccionAgregar;

    jQuery.ajax({
        type: "POST",
        url: urlOfertaDetalleProductoTem,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        async: false,
        success: function (response) {
            varReturn = response.success;
        },
        error: function (response, error) {
            CerrarLoad();
            localStorage.setItem(lsListaRD, "");
        }
    });

    return varReturn;
}
