var CarruselVariable = function () {
    var direccion = {
        left: 'left',
        right: 'right'
    };

    return {
        Direccion: direccion
    }
}();

var _slick = null;

var CarruselAyuda = function () {
    "use strict";
        
    var _obtenerSlideMostrar = function (slick, currentSlide, nextSlide) {
        //'slick-current', 'slick-active'
        var indexMostrar = nextSlide == undefined ? currentSlide : nextSlide;
        var indexActive = -1;

        var cantActive = $(_slick.$slider).find('.slick-active').length;
        var indexCurrent = parseInt($(_slick.$slider).find('.slick-current').attr("data-slick-index"));

        console.log('_obtenerSlideMostrar', indexMostrar, indexCurrent, indexActive, currentSlide, nextSlide);
        var direccion = "prev";
        if (indexCurrent === 0) {
            if (indexMostrar + 1 != slick.$slides.length) {
                direccion = "next";
                indexMostrar = indexCurrent + cantActive;
            }
        }
        else if (indexCurrent + 1 === slick.$slides.length) {
            if (indexMostrar == 0) {
                direccion = "next";
                indexMostrar = cantActive - 1;
            }
        }
        else if (indexMostrar > indexCurrent) {
            direccion = "next";
            indexMostrar = indexCurrent + cantActive;
            if (indexMostrar + 1 > slick.$slides.length) {
                indexMostrar = indexMostrar - slick.$slides.length;
            }
        }

        var slideMostrar = $(_slick.$slider).find("[data-slick-index='" + indexMostrar + "']");
        console.log('_obtenerSlideMostrar', direccion, indexMostrar, $(slideMostrar));
        return {
            Direccion: direccion,
            IndexMostrar: indexMostrar,
            SlideMostrar: slideMostrar
        }
    };

    var marcarAnalyticsInicio = function (idHtmlSeccion, arrayItems, pagina, seccion) {
        idHtmlSeccion = idHtmlSeccion || "";
        idHtmlSeccion = idHtmlSeccion[0] == "#" ? idHtmlSeccion : ("#" + idHtmlSeccion);
        //var pagina = isHome() ? "Home" : "Carrito de Compras";
        var cantidadRecomendados = $(idHtmlSeccion).find(".slick-active").length;
        var arrayEstrategia = [];
        for (var i = 0; i < cantidadRecomendados; i++) {
            var recomendado = arrayItems[i];
            var impresionRecomendado = {
                'name': recomendado.DescripcionCompleta,
                'id': recomendado.CUV2,
                'price': $.trim(recomendado.Precio2),
                'brand': recomendado.DescripcionMarca,
                'category': AnalyticsPortalModule.Texto.Notavaliable,
                'variant': AnalyticsPortalModule.Texto.Estandar,
                'list': AnalyticsPortalModule.Texto.List(false, pagina, seccion),
                'position': recomendado.Posicion
            };

            arrayEstrategia.push(impresionRecomendado);
        }

        AnalyticsPortalModule.MarImpresionSetProductos(arrayEstrategia);
    }

    var marcarAnalyticsChange = function (event, slick, currentSlide, nextSlide, pagina, seccion) {
        try {
            _slick = slick;
            console.log('marcarAnalyticsChange - Ini ', pagina, seccion);

            if (typeof AnalyticsPortalModule == "undefined") {
                return;
            }

            var objMostrar = _obtenerSlideMostrar(slick, currentSlide, nextSlide);
            
            var item = objMostrar.SlideMostrar;
            var estrategia = $($(item).find("[data-estrategia]")[0]).data("estrategia") || "";
            console.log('marcarAnalyticsChange', estrategia);
            if (estrategia !== "") {
                estrategia.Position = objMostrar.IndexMostrar;
                var obj = {
                    lista: Array(estrategia)
                };
                AnalyticsPortalModule.MarcaGenericaLista(pagina, obj, obj.lista.length);// home y pedido
            }

        } catch (e) {
            console.log('marcarAnalyticsChange - ' + _texto.excepcion + e, e);
        }

    }


    return {
        MarcarAnalyticsChange: marcarAnalyticsChange,
        MarcarAnalyticsInicio: marcarAnalyticsInicio
    };
}();

var CarruselModule = (function (config) {
    'use strict';

    //var setCarruselMarcacionAnalytics = []; //Elementos en el carrusel de la ficha para ser marcados cuando el usuario visualiza y rota sobre los elementos
    //var setCarruselCuv = [];  //Representa el casillero de un CUV del carrusel

    var _config = {
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlDataCarrusel: config.urlDataCarrusel || "",
        pantalla: "Ficha"
    };

    var _elementos = {
        idPlantillaProducto: config.idPlantillaProducto,
        divCarruselContenedor: config.divCarruselContenedor,
        idTituloCarrusel: config.idTituloCarrusel,
        divCarruselProducto: config.divCarruselProducto,
        dataLazy: config.dataLazy || "img[data-lazy-seccion-revista-digital]"
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
            async: false,
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

        var str = LocalStorageListado("LANLista" + campaniaId, "", 1) || "";

        if (str === '') {
            return setRelacionados;
        }

        var lista = JSON.parse(str).response.listaLan;
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

    var _mostrarSlicks = function () {

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
                infinite: true,
                speed: 260,
                slidesToShow: 2,
                slidesToScroll: 1,
                variableWidth: widthDimamico,
                prevArrow: slickArrows[platform].prev,
                nextArrow: slickArrows[platform].next,
                //centerMode: true,
                responsive: [
                    {
                        breakpoint: 480,
                        settings: {
                            slidesToShow: 1
                        }
                    }
                ]
            }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
                var seccion = ConstantesModule.OrigenPedidoWebEstructura.Seccion.CarruselVerMas;
                CarruselAyuda.MarcarAnalyticsChange(event, slick, currentSlide, nextSlide, _config.pantalla, seccion); // Ficha
            });
        }

        EstablecerAccionLazyImagen(_elementos.divCarruselProducto + " " + _elementos.dataLazy);
    }

    var _ocultarElementos = function () {
        $(_elementos.divCarruselProducto).fadeOut();
    }

    var _mostrarTitulo = function () {

        var titulo = '';

        if (_config.palanca == ConstantesModule.CodigosPalanca.Lanzamiento) {
            titulo = 'SET DONDE ENCUENTRAS EL PRODUCTO';
        }
        else if (_config.palanca == ConstantesModule.CodigosPalanca.ShowRoom) {
            titulo = 'VER MÁS SETS EXCLUSIVOS PARA TI';
        }
        else if (_config.palanca == ConstantesModule.CodigosPalanca.OfertaDelDia) {
            titulo = 'VER MÁS OFERTAS ¡SOLO HOY!';
        }

        $(_elementos.idTituloCarrusel).html(titulo);
    }
    var _mostrarCarrusel = function () {

        var data = {
            lista: []
        };

        if (_config.palanca == ConstantesModule.CodigosPalanca.Lanzamiento) {
            data.lista = _cargarDatos();
        }
        else if (
            (_config.palanca == ConstantesModule.CodigosPalanca.ShowRoom)
            || (_config.palanca == ConstantesModule.CodigosPalanca.OfertaDelDia)
            || (_config.palanca == ConstantesModule.CodigosPalanca.PackNuevas)
        ) {
            var param = { cuvExcluido: _config.cuv, palanca: _config.palanca }
            _promiseObternerDataCarrusel(param).done(function (response) {

                if (response) {
                    if (response.success) {
                        data.lista = response.data;
                    }
                }

            });
        }

        if (data.lista.length > 0) {
            _variable.cantidadProdCarrusel = data.lista.length;
            SetHandlebars(_elementos.idPlantillaProducto, data, _elementos.divCarruselProducto);
            _mostrarTitulo();
            _mostrarSlicks();

            if (!(typeof AnalyticsPortalModule === 'undefined')) {
                var cantSlickActivos = $(_elementos.divCarruselProducto).find(".slick-active").length
                    || data.lista;
                AnalyticsPortalModule.MarcaGenericaLista(_config.pantalla, data, cantSlickActivos);// Inicio ficha
            }

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

    ////////////////////////////////////////////////////////////////////
    //// Ini - Analytic
    ////////////////////////////////////////////////////////////////////
    //var _initSwipeCarrusel = function () {
    //    _initArraysCarrusel();
    //    //quita duplicados

    //    setCarruselMarcacionAnalytics = multiDimensionalUnico(setCarruselMarcacionAnalytics);
    //    marcaCuvsActivos();
    //    //Hace la marcación a analytics
    //    _marcarSwipeCarrusel();
    //    _initSlideArrowCarrusel();

    //}
    //var _initArraysCarrusel = function () {
    //    var containerItemsSlick = $(".slick-slide");
    //    $(containerItemsSlick).each(function (index, element) {
    //        var infoCuvItem = $(element).find("[data-estrategia]").data("estrategia");
    //        if ("undefined" !== typeof infoCuvItem) {
    //            setCarruselMarcacionAnalytics.push([infoCuvItem.CUV2, 0]);
    //            setCarruselCuv.push(infoCuvItem);
    //        }
    //    });
    //}
    //cuando el usuario hace clic sobre las flechas del carrusel.
    //var _initSlideArrowCarrusel = function () {

    //    var containerItemsSlick = $(".slick-arrow");
    //    $(containerItemsSlick).click(function (e) {
    //        EstablecerAccionLazyImagen(_elementos.divCarruselProducto + " " + _elementos.dataLazy);
    //        _agregaNewCuvActivo();
    //        setCarruselMarcacionAnalytics = multiDimensionalUnico(setCarruselMarcacionAnalytics);
    //        marcaCuvsActivos();
    //        _marcarSwipeCarrusel();
    //    });

    //}
    //function _agregaNewCuvActivo() {
    //    var containterSlickActive = $(".slick-active");
    //    $(containterSlickActive).each(function (index, element) {
    //        var infoCuvItem = $(element).find("[data-estrategia]").data("estrategia");
    //        if ("undefined" !== typeof infoCuvItem && verificaNuevoCUVParaAnalytic(infoCuvItem))
    //            setCarruselMarcacionAnalytics.push([infoCuvItem.CUV2, 0]);
    //    });
    //}
    //function marcaCuvsActivos() {
    //    var containterSlickActive = $(".slick-active");
    //    $(containterSlickActive).each(function (index, element) {
    //        var infoCuvItem = $(element).find("[data-estrategia]").data("estrategia");
    //        if ("undefined" !== typeof infoCuvItem) {
    //            preparaCUVAnalytic(infoCuvItem);
    //        }
    //    });
    //}

    //Marca como registrado
    //function preparaCUVAnalytic(infoCuvItem) {
    //    infoCuvItem = infoCuvItem || {};
    //    for (var i = 0; i < setCarruselMarcacionAnalytics.length; i++) {
    //        if (setCarruselMarcacionAnalytics[i][0] == infoCuvItem.CUV2 && setCarruselMarcacionAnalytics[i][1] == 0)
    //            setCarruselMarcacionAnalytics[i][1] = 1;
    //    }
    //}
    //function verificaNuevoCUVParaAnalytic(infoCuvItem) {
    //    infoCuvItem = infoCuvItem || {};
    //    for (var i = 0; i < setCarruselMarcacionAnalytics.length; i++) {
    //        if (setCarruselMarcacionAnalytics[i][0] == infoCuvItem.CUV2 && setCarruselMarcacionAnalytics[i][1] == 2)
    //            return false
    //    }
    //    return true;
    //}
    //quita duplicado
    //function multiDimensionalUnico(arr) {
    //    var unicos = [];
    //    var itemsFound = {};
    //    for (var i = 0, l = arr.length; i < l; i++) {
    //        var stringified = JSON.stringify(arr[i]);
    //        if (itemsFound[stringified]) { continue; }
    //        unicos.push(arr[i]);
    //        itemsFound[stringified] = true;
    //    }
    //    return unicos;
    //}

    //obtiene el cuv
    //function getCuvDeCarrusel(CUV) {
    //    for (var i = 0; i < setCarruselCuv.length; i++) {
    //        if (setCarruselCuv[i].CUV2 == CUV)
    //            return setCarruselCuv[i];
    //    }
    //}
    //var _marcarSwipeCarrusel = function () {
    //    var cuvsAnalytics = [];

    //    for (var i = 0; i < setCarruselMarcacionAnalytics.length; i++) {
    //        if (setCarruselMarcacionAnalytics[i][1] == 1) {
    //            var infoCuv = getCuvDeCarrusel(setCarruselMarcacionAnalytics[i][0]); //obtiene info del cuv

    //            cuvsAnalytics.push({
    //                'name': infoCuv.DescripcionCortada,
    //                'id': infoCuv.CUV2,
    //                'price': infoCuv.Precio2,
    //                'brand': infoCuv.DescripcionMarca,
    //                'category': infoCuv.CodigoCategoria,
    //                'variant': infoCuv.CodigoVariante,
    //                'list': infoCuv.DescripcionCortada + ' - Set productos',
    //                'position': i
    //            });
    //            setCarruselMarcacionAnalytics[i][1] = 2;
    //        }
    //    }

    //    //if (cuvsAnalytics.length > 0) {
    //    //    cuvsAnalytics = JSON.stringify(cuvsAnalytics);
    //    //    AnalyticsPortalModule.MarImpresionSetProductos(cuvsAnalytics);
    //    //}
    //}

    ////////////////////////////////////////////////////////////////////
    //// Fin - Analytic
    ////////////////////////////////////////////////////////////////////
    function Inicializar() {
        _ocultarElementos();
        _mostrarCarrusel();
        //_initSwipeCarrusel();
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
    if (data.Lista.length == 0) {
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
            MarcarAnalyticsChangePedidoHome(event, slick, currentSlide, nextSlide);
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
            prevArrow: '<button type="button" data-role="none" class="slick-next ' + claseFlechaDoradaNext + ' "></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev ' + claseFlechaDoradaPrev + '"></button>'
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            MarcarAnalyticsChangePedidoHome(event, slick, currentSlide, nextSlide);
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
            MarcarAnalyticsChangePedidoHome(event, slick, currentSlide, nextSlide);
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
            MarcarAnalyticsChangePedidoHome(event, slick, currentSlide, nextSlide);
        });
    }

    TagManagerCarruselInicio(data.Lista);
}

function TagManagerCarruselInicio(arrayItems) {
    arrayItems = arrayItems || new Array();
    var pagina = isHome()
        ? ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
        : ConstantesModule.OrigenPedidoWebEstructura.Pagina.Pedido
    var seccion = ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel; // "Gana+"

    CarruselAyuda.MarcarAnalyticsInicio("#divListadoEstrategia", arrayItems, pagina, seccion);

    //var pagina = isHome() ? "Home" : "Carrito de Compras";
    //var cantidadRecomendados = $('#divListadoEstrategia').find(".slick-active").length;
    //var arrayEstrategia = [];
    //for (var i = 0; i < cantidadRecomendados; i++) {
    //    var recomendado = arrayItems[i];
    //    var impresionRecomendado = {
    //        'name': recomendado.DescripcionCompleta,
    //        'id': recomendado.CUV2,
    //        'price': $.trim(recomendado.Precio2),
    //        'brand': recomendado.DescripcionMarca,
    //        'category': AnalyticsPortalModule.Texto.Notavaliable,
    //        'variant': AnalyticsPortalModule.Texto.Estandar,
    //        'list': AnalyticsPortalModule.Texto.List(false, pagina, seccion),
    //        'position': recomendado.Posicion
    //    };

    //    arrayEstrategia.push(impresionRecomendado);
    //}

    //AnalyticsPortalModule.MarImpresionSetProductos(arrayEstrategia);
}

function MarcarAnalyticsChangePedidoHome(event, slick, currentSlide, nextSlide) {

    var paginaOrigen = isHome()
        ? ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
        : ConstantesModule.OrigenPedidoWebEstructura.Pagina.Pedido
    var seccion = ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel;

    CarruselAyuda.MarcarAnalyticsChange(event, slick, currentSlide, nextSlide, paginaOrigen, seccion);// Home Pedido

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

    //var posicionEstrategia = 0
    var paramlabel = "";
    //var arrayEstrategia = [];

    if (accion == "prev") {
        //var posicionPrimerActivo = $($("#divListadoEstrategia").find(".slick-active")[0]).find(".PosicionEstrategia").val();
        //posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length - 1 : posicionPrimerActivo - 2;

        paramlabel = "Ver anterior";

    } else {
        //var posicionUltimoActivo = $($("#divListadoEstrategia").find(".slick-active").slice(-1)[0]).find(".PosicionEstrategia").val();
        //posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;

        paramlabel = "Ver siguiente";
    }

    var pagina = isHome() ? "Home" : "Carrito de Compras";

    //var recomendado = arrayOfertasParaTi[posicionEstrategia];
    //arrayEstrategia.push({
    //    'name': recomendado.DescripcionCompleta,
    //    'id': recomendado.CUV2,
    //    'price': recomendado.PrecioVenta,
    //    'brand': recomendado.DescripcionMarca,
    //    'category': AnalyticsPortalModule.Texto.Notavaliable,
    //    'variant': AnalyticsPortalModule.Texto.Estandar,
    //    'list': AnalyticsPortalModule.Texto.List(false, pagina, "Gana+"),
    //    'position': recomendado.Posicion
    //});

    //AnalyticsPortalModule.MarImpresionSetProductos(arrayEstrategia);

    dataLayer.push({
        'event': "virtualEvent",
        'category': pagina,
        'action': "Ofertas para ti",
        'label': paramlabel
    });
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

        var accion = nextSlide > currentSlide ? 'next' : 'prev';

        var itemsLength = $('#divCarruselLiquidaciones').find('.slick-slide').length;
        var indexActive = $($('#divCarruselLiquidaciones').find('.slick-active')).attr('data-slick-index');


        if (accion == 'prev') {
            if (Number(indexActive) - 1 == 0) {
                $('.js-slick-prev-liq').hide();
                $('.js-slick-next-liq').show();
            } else {
                $('.js-slick-next-liq').show();
            }
        }
        else {
            if (Number(indexActive) + 1 == Number(itemsLength) - 1) {
                $('.js-slick-next-liq').hide();
                $('.js-slick-prev-liq').show();
            } else {
                $('.js-slick-prev-liq').show();
            }
        }

        var posicionEstrategia = $($('#divCarruselLiquidaciones').find(".slick-active")).find('#Posicion').val();
        var arrayEstrategia;
        if (accion == 'prev') {

            posicionEstrategia = posicionEstrategia - 2;

            TagManagerCarruselNavegar(posicionEstrategia, 'Ver anterior');

        } else {

            if (posicionEstrategia != arrayLiquidaciones.length) {

                TagManagerCarruselNavegar(posicionEstrategia, 'Ver siguiente');

            } else {
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Liquidacion Web',
                    'label': 'Ver más'
                });
            }
        }
    });

    TagManagerCarruselLiquidacionesInicio(data);

    $(".js-slick-prev-liq").insertBefore('#divCarruselLiquidaciones').hide();
    $(".js-slick-next-liq").insertAfter('#divCarruselLiquidaciones');
}

function TagManagerCarruselNavegar(posicionEstrategia, direccion) {

    var recomendado = arrayLiquidaciones[posicionEstrategia] || {};

    if (recomendado.PrecioOferta != null || recomendado.PrecioOferta != undefined) {

        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV,
            'price': recomendado.PrecioOferta.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': AnalyticsPortalModule.Texto.Notavaliable,
            'variant': AnalyticsPortalModule.Texto.Estandar,
            'list': AnalyticsPortalModule.Texto.List(false, 'Home', "Liquidación Web"), //'Liquidación Web - Home',
            'position': recomendado.Posicion
        };

        var arrayEstrategia = new Array();
        arrayEstrategia.push(impresionRecomendado);

        AnalyticsPortalModule.MarImpresionSetProductos(arrayEstrategia); // Liquidacion Home

        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Home',
            'action': 'Liquidacion Web',
            'label': direccion
        });
    }
}

////////////////////////////////////////////////////////////////////
//// Fin - Home Liquidacion
////////////////////////////////////////////////////////////////////
