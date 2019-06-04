var CarruselModule = (function (config) {
    'use strict';

    var _config = {
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlDataCarrusel: config.urlDataCarrusel || "/Estrategia/FichaObtenerProductosUpSellingCarrusel",
        OrigenPedidoWeb: config.OrigenPedidoWeb || "",
        pantalla: "Ficha",
        usaLocalStorage: config.usaLocalStorage,
        tituloCarrusel: config.tituloCarrusel,
        cantidadPack: config.productosHermanos.length,
        codigoProducto: config.codigoProducto,
        precioProducto: config.precioProducto,
        productosHermanos: config.productosHermanos,
        tieneStock: config.tieneStock
    };

    var _elementos = {
        idPlantillaProducto: config.idPlantillaProducto,
        divCarruselContenedor: config.divCarruselContenedor,
        idTituloCarrusel: config.idTituloCarrusel,
        divCarruselProducto: config.divCarruselProducto,
        dataLazy: config.dataLazy || "img[data-lazy-seccion-revista-digital]",
        dataOrigenPedidoWeb: {
            busca: "[data-OrigenPedidoWeb]",
            atributo: "data-OrigenPedidoWeb",
            buscaAgregar: "[data-origenpedidowebagregar]",
            atributoAgregar: "data-origenpedidowebagregar"
        }
    };

    var _variable = {
        cantidadProdCarrusel: 0
    };

    var _promiseObternerDataCarrusel = function (params) {
        var dfd = $.Deferred();
        $.ajax({
            type: "POST",
            url: _config.urlDataCarrusel,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _cargarDatos = function () {

        var setRelacionados = [];

        var cuv = _config.cuv;
        var campaniaId = _config.campania;

        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return setRelacionados;
        }

        var lista = [];
        if (_config.usaLocalStorage) {
            var str = LocalStorageListado("LANLista" + campaniaId, "", 1) || "";

            if (str === '') {
                return setRelacionados;
            }

            lista = JSON.parse(str).response.listaLan;
        } else {
            var localStorageModule = new LocalStorageModule();
            lista = localStorageModule.ObtenerEstrategiasNoLS(campaniaId, ConstantesModule.TipoEstrategiaTexto.Lanzamiento);

            if (lista === []) {
                return setRelacionados;
            }
        }

        var codigoProducto = "";

        $.each(lista, function (index, lanzamiento) {
            if (cuv === lanzamiento.CUV2) {
                codigoProducto = lanzamiento.CodigoProducto;
                return false;
            }
        });

        $.each(lista, function (index, lanzamiento) {
            if (cuv != lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                lanzamiento.ImagenURL = "";
                setRelacionados.push(lanzamiento);
            }
        });

        return setRelacionados;
    }

    var _mostrarSlicks = function (data) {

        var platform = !isMobile() ? 'desktop' : 'mobile';

        var slickArrows = {
            'mobile': {
                prev: '<a class="carrusel_fechaprev_mobile" href="javascript:void(0);">'
                    + '<img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="carrusel_fechanext_mobile" href="javascript:void(0);">'
                    + '<img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;">'
                    + '<img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;">'
                    + '<img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        var widthDimamico = !isMobile();

        $(_elementos.divCarruselProducto).fadeIn();

        if ((widthDimamico && _variable.cantidadProdCarrusel > 2) || !widthDimamico) {

            $(_elementos.divCarruselProducto + '.slick-initialized').slick('unslick');
            $(_elementos.divCarruselProducto).not('.slick-initialized').slick({
                dots: false,
                infinite: false,
                speed: 260,
                slidesToShow: 2,
                slidesToScroll: 1,
                variableWidth: widthDimamico,
                prevArrow: slickArrows[platform].prev,
                nextArrow: slickArrows[platform].next,
                //centerMode: true,
                responsive: [
                    {
                        breakpoint: 720,
                        settings: {
                            slidesToShow: 1
                        }
                    }
                ]
            }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
                _marcarAnalytics(2, null, slick, currentSlide, nextSlide);
            });
        }

        EstablecerAccionLazyImagen(_elementos.divCarruselProducto + " " + _elementos.dataLazy);

        _marcarAnalytics(1, data);
    }

    var _marcarAnalytics = function (tipo, data, slick, currentSlide, nextSlide) {

        //tipo : 1= inicio, 2: cambio

        if (typeof AnalyticsPortalModule === 'undefined') {
            return;
        }

        //var origen = {
        //    Seccion: CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.CarruselVerMas,
        //    OrigenPedidoWeb: _config.OrigenPedidoWeb.toString()
        //};

        var origen = $(_elementos.divCarruselProducto).attr(_elementos.dataOrigenPedidoWeb.atributoAgregar)
            || $(_elementos.divCarruselProducto).attr(_elementos.dataOrigenPedidoWeb.atributo)
            || $(_elementos.divCarruselProducto).parents(_elementos.dataOrigenPedidoWeb.buscaAgregar).attr(_elementos.dataOrigenPedidoWeb.atributoAgregar)
            || $(_elementos.divCarruselProducto).parents(_elementos.dataOrigenPedidoWeb.busca).attr(_elementos.dataOrigenPedidoWeb.atributo);

        if (tipo == 1) {
            CarruselAyuda.MarcarAnalyticsInicio(_elementos.divCarruselProducto, data.lista, origen);
        }
        else if (tipo == 2) {
            var estrategia = CarruselAyuda.ObtenerEstrategiaSlick(slick, currentSlide, nextSlide);
            origen = CodigoOrigenPedidoWeb.GetCambioSegunTipoEstrategia(origen, estrategia.CodigoEstrategia);
            CarruselAyuda.MarcarAnalyticsChange(slick, currentSlide, nextSlide, origen);
        }
    }

    var _ocultarElementos = function () {
        $(_elementos.divCarruselProducto).fadeOut();
    }

    var _mostrarTitulo = function () {

        var titulo = '';
        if (_config.palanca == ConstantesModule.TipoEstrategiaTexto.OfertaDelDia) {
            titulo = 'Ver más ofertas ¡Solo Hoy!';
        } else {
            if (_config.cantidadPack > 1) {
                titulo = 'Packs parecidos con más productos';
            } else {
                var componenteInicial = {};
                if (_config.cantidadPack == 1) {
                    componenteInicial = _config.productosHermanos[0];
                }
                if (componenteInicial.FactorCuadre * componenteInicial.Cantidad == 1) {
                    titulo = 'Packs que contienen <span style="text-transform:capitalize">' + _config.tituloCarrusel.toLowerCase() + '</span>';
                } else {
                    titulo = 'Packs parecidos con más productos';
                }
            }
        }

        $(_elementos.idTituloCarrusel).html(titulo);
    }
    var _mostrarCarrusel = function () {

        var data = {
            lista: []
        };

        if (_config.palanca == ConstantesModule.TipoEstrategiaTexto.Lanzamiento) {
            data.lista = _cargarDatos();
            _buildCarrusel(data);
        }
        else {
            if (_config.tieneStock) {
                var codigosProductos = _obtenerCodigoProductos();
                var param = {
                    cuvExcluido: _config.cuv,
                    palanca: _config.palanca,
                    codigosProductos: codigosProductos,
                    precioProducto: _config.precioProducto
                }
                _promiseObternerDataCarrusel(param).done(function (response) {
                    if (response) {
                        if (response.success) {
                            data.lista = response.result;
                            _buildCarrusel(data);
                        }
                    }
                });
            }
        }
    };
    var _buildCarrusel = function (data) {

        if (data.lista.length > 0) {
            _variable.cantidadProdCarrusel = data.lista.length;
            $.each(data.lista, function (i, item) { item.Posicion = i + 1; });

            SetHandlebars(_elementos.idPlantillaProducto, data, _elementos.divCarruselProducto);
            _mostrarTitulo();
            _mostrarSlicks(data);
        }
        _ocultarCarrusel(data);
    };
    var _ocultarCarrusel = function (data) {
        if (typeof data != "undefined") {
            if (Array.isArray(data.lista) && data.lista.length > 0) {
                $(_elementos.divCarruselContenedor).show();
                return;
            }
            else {
                $(_elementos.divCarruselContenedor).hide();
            }
        }
        $(_elementos.divCarruselContenedor).hide();
    }

    var _obtenerCodigoProductos = function () {
        var componentes = _config.productosHermanos;
        var codigosProductos = [];
        var contarProductosHermanos = componentes.length;
        if (contarProductosHermanos == 0) {
            codigosProductos.push(_config.codigoProducto);
        } else {
            if (contarProductosHermanos == 1) {
                var valores = componentes[0];
                if (valores.FactorCuadre > 1) codigosProductos.push(valores.CodigoProducto);
                else {
                    codigosProductos.push(_config.codigoProducto);
                }
            } else {
                for (var i = 0; i < contarProductosHermanos; i++) {
                    if (componentes[i].NombreComercial.indexOf("Bolsa") == -1) codigosProductos.push(componentes[i].CodigoProducto);
                }
            }

        }
        return codigosProductos;
    }

    function Inicializar() {
        _ocultarElementos();
        _mostrarCarrusel();
    }

    return {
        Inicializar: Inicializar
    };
});

////////////////////////////////////////////////////////////////////
//// Ini - Home y Pedido
////////////////////////////////////////////////////////////////////
function ArmarCarouselEstrategias(data) {
    $("#divListaEstrategias").hide();
    $(".js-slick-prev").remove();
    $(".js-slick-next").remove();
    $("#divListadoEstrategia.slick-initialized").slick("unslick");

    data.Lista = data.Lista || [];
    data.ListaLan = data.ListaLan || [];
    if (data.Lista.length == 0 && data.ListaLan.length == 0) {
        $("#divListaEstrategias").show();
        $("#divContenedorListaEstrategia").hide();
        $(".contenido_gana_mas").hide();

        if (isMobile()) {
            $(".wrapper_resumen_mobile_clubganamas .zonadecolor, .wrapper_resumen_mobile_clubganamas").css({ "height": "200px" });
        } else {
            $(".contenedor_ganamas").css({ "height": "100px" });
            $(".sb_contenedor_ganamas_bg").css({ "height": "100px" });
            $(".contenedor_ganamas .sb_contenedor_ganamas").css({ "top": "-100px" });
        }

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
                        productoLanzamiento.ClaseEstrategia = data.Lista.length > 0 ? data.Lista[0].ClaseEstrategia : "revistadigital-landing";

                        if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 2) {
                            data.Lista.splice(0, 0, productoLanzamiento);
                        }
                    }
                }
            }

            if (!revistaDigital.EsSuscrita) {
                var bannerClubGanaMas = {};
                if (data.Lista.length > 0) {
                    $.extend(true, bannerClubGanaMas, data.Lista[0]);
                }
                bannerClubGanaMas.EsBanner = true;

                if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 2) {
                    if (data.Lista.length > 3) {
                        data.Lista.splice(3, 0, bannerClubGanaMas);
                    }
                    else {
                        data.Lista.push(bannerClubGanaMas);
                    }
                }
                else if (tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 21) {
                    if (data.Lista.length > 1) {
                        data.Lista.splice(1, 0, bannerClubGanaMas);
                    }
                    else {
                        data.Lista.push(bannerClubGanaMas);
                    }
                }
            }
        }
    }

    arrayOfertasParaTi = data.Lista;
    data.lista = data.Lista;
    $.each(data.Lista, function (i, item) { item.Posicion = i + 1; });
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
            MarcarAnalyticsChangeHomePedido(event, slick, currentSlide, nextSlide);
        });
    }
    else if (tipoOrigenEstrategia == 11) {

        var divList = $("#divListaEstrategias #divListadoEstrategia [data-item] > div");
        $.each(divList, function (k, obj) {
            if ($(obj).hasClass('producto-agotado'))
                $(obj).attr('class', 'producto_carousel producto-agotado')
            else
                $(obj).attr('class', 'producto_carousel')
        });

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
            prevArrow: '<button type="button" data-role="none" class="slick-next ' + claseFlechaDoradaNext + ' "></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev ' + claseFlechaDoradaPrev + '"></button>'
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            MarcarAnalyticsChangeHomePedido(event, slick, currentSlide, nextSlide);
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
            MarcarAnalyticsChangeHomePedido(event, slick, currentSlide, nextSlide);
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
            MarcarAnalyticsChangeHomePedido(event, slick, currentSlide, nextSlide);
        });
    }

    MarcarAnalyticsInicioHomePedido(data.Lista);
}

function MarcarAnalyticsInicioHomePedido(arrayItems) {
    arrayItems = arrayItems || new Array();

    var origen = {
        Pagina: isHome()
            ? CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home
            : CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Pedido,
        Palanca: CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.OfertasParaTi,
        Seccion: CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel
    };

    CarruselAyuda.MarcarAnalyticsInicio("#divListadoEstrategia", arrayItems, origen);
}

function MarcarAnalyticsChangeHomePedido(event, slick, currentSlide, nextSlide) {

    var origen = {
        Pagina: isHome()
            ? CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home
            : CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Pedido,
        Palanca: CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.OfertasParaTi,
        Seccion: CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel
    };

    CarruselAyuda.MarcarAnalyticsChange(slick, currentSlide, nextSlide, origen);// Home Pedido
}

////////////////////////////////////////////////////////////////////
//// Fin - Home y Pedido
////////////////////////////////////////////////////////////////////
//// Ini - Home Liquidacion
////////////////////////////////////////////////////////////////////
function ArmarCarouselLiquidaciones(data) {

    arrayLiquidaciones = data;
    var htmlDiv = SetHandlebars("#liquidacion-template", data);
    if ($.trim(htmlDiv).length > 0) {
        htmlDiv += [
            '<div data-banner="1">',
            '<div class="content_item_carrusel background_vermas">',
            '<input type="hidden" id="Posicion" value="' + (data.length + 1) + '"/>',
            '<div class="producto_img_home">',
            '</div>',
            '<div class="producto_nombre_descripcion">',
            '<p class="nombre_producto">',
            '</p>',
            '<div class="producto_precio" style="margin-bottom: -8px;">',
            '<span class="producto_precio_oferta"></span>',
            '</div>',
            '<a href="' + baseUrl + 'OfertaLiquidacion/OfertasLiquidacion" class="boton_Agregalo_home no_accionar" style="width:100%;">',
            'VER MÁS',
            '</a>',
            '</div>',
            '</div>',
            '</div>'
        ].join("\n");
    }
    $('#divCarruselLiquidaciones').empty().html(htmlDiv);

    EstablecerLazyCarrusel('#divCarruselLiquidaciones');

    $('#divCarruselLiquidaciones').slick({
        lazyLoad: 'ondemand',
        infinite: false,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        speed: 260,
        prevArrow: '<a class="previous_ofertas js-slick-prev-liq"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
        nextArrow: '<a class="previous_ofertas js-slick-next-liq" style="right: 0;display: block;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
    }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        CarruselAyuda.MarcarAnalyticsLiquidacion(2, null, slick, currentSlide, nextSlide);
    }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
        CarruselAyuda.MarcarAnalyticsLiquidacion(3, event, slick, currentSlide);
    });

    CarruselAyuda.MarcarAnalyticsLiquidacion(1, data, null, 1);

}

////////////////////////////////////////////////////////////////////
//// Fin - Home Liquidacion
////////////////////////////////////////////////////////////////////
