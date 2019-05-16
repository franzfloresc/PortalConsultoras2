﻿var CarruselVariable = function () {
    var direccion = {
        prev: 'prev',
        next: 'next'
    };

    return {
        Direccion: direccion
    }
}();

// para ayuda en consola
var _slick = null;

var CarruselAyuda = function () {
    "use strict";
    var _texto = {
        excepcion: "Excepción en AnalyticsPortal.js ==> "
    };

    var _obtenerSlideMostrar = function (slick, currentSlide, nextSlide) {

        var indexMostrar = nextSlide == undefined ? currentSlide : nextSlide;
        var indexActive = -1;

        var cantActive = $(_slick.$slider).find('.slick-active').length;
        var indexCurrent = parseInt($(_slick.$slider).find('.slick-current').attr("data-slick-index"));

        var direccion = CarruselVariable.Direccion.prev;
        if (indexCurrent === 0) {
            if (indexMostrar + 1 != slick.$slides.length) {
                direccion = CarruselVariable.Direccion.next;
                indexMostrar = indexCurrent + cantActive;
            }
        }
        else if (indexCurrent + 1 === slick.$slides.length) {
            if (indexMostrar == 0) {
                direccion = CarruselVariable.Direccion.next;
                indexMostrar = cantActive - 1;
            }
        }
        else if (indexMostrar > indexCurrent) {
            direccion = CarruselVariable.Direccion.next;
            indexMostrar = indexCurrent + cantActive;
            if (indexMostrar + 1 > slick.$slides.length) {
                indexMostrar = indexMostrar - slick.$slides.length;
            }
        }

        var slideMostrar = $(_slick.$slider).find("[data-slick-index='" + indexMostrar + "']");

        return {
            Direccion: direccion,
            IndexMostrar: indexMostrar,
            SlideMostrar: slideMostrar
        }
    };

    //var _obtenerPantalla = function (origen) {
    //    var pagina = origen.Pagina;
    //    var palanca = origen.Palanca;
    //    var seccion = origen.Seccion;
    //    return pagina;
    //}

    var _eliminarDuplicadosArray = function (arr, comp) {
        //emac5
        var unique = arr.map(function (e) {
            return e[comp];
        }).map(function (e, i, final) {
            return final.indexOf(e) === i && i;
        }).filter(function (e) {
            return arr[e];
        }).map(function (e) {
            return arr[e];
        });
        return unique;

    }


    var _obtenerEstrategiaLiquidacion = function (objMostrar) {
        var estrategia = "";
        var recomendado = arrayLiquidaciones[objMostrar.IndexMostrar] || {};
        if (recomendado.PrecioOferta != null || recomendado.PrecioOferta != undefined) {
            estrategia = {
                DescripcionCompleta: recomendado.DescripcionCompleta,
                CUV2: recomendado.CUV,
                PrecioVenta: recomendado.PrecioOferta.toString(),
                DescripcionMarca: recomendado.DescripcionMarca
            };
        }
        return estrategia;
    }

    var marcarAnalyticsInicio = function (idHtmlSeccion, arrayItems, origen, slidesToShow) {
        try {

            idHtmlSeccion = idHtmlSeccion || "";
            idHtmlSeccion = idHtmlSeccion[0] == "#" ? idHtmlSeccion : ("#" + idHtmlSeccion);
            var cantActive = slidesToShow || ($(idHtmlSeccion).find(".slick-active") || []).length;
            if (cantActive > 0) {
                var arrayEstrategia = [];
                for (var i = 0; i < cantActive; i++) {
                    var recomendado = arrayItems[i];
                    if (recomendado != undefined) {
                        recomendado.Posicion = i;
                        if (origen.Palanca == ConstantesModule.OrigenPedidoWebEstructura.Palanca.Liquidacion) {
                            recomendado.CUV2 = recomendado.CUV;
                            recomendado.PrecioVenta = recomendado.PrecioString;
                        }
                        arrayEstrategia.push(recomendado);
                    }
                }
                var obj = {
                    lista: arrayEstrategia,
                    CantidadMostrar: cantActive,
                    Origen: origen
                };

                AnalyticsPortalModule.MarcaGenericaLista("", obj);

                //INI DH-3473 EINCA Marcar las estrategias de programas nuevas(dúo perfecto)
                var programNuevas = arrayItems.filter(function (pn) {
                    return pn.EsBannerProgNuevas == true;
                });

                if (programNuevas) {
                    if (programNuevas.length > 0) {
                        var uniqueProgramNuevas = _eliminarDuplicadosArray(programNuevas, "CUV2");

                        var pos = (isHome()) ? "Home" : "Pedido";
                        AnalyticsPortalModule.MarcaGenericaLista(ConstantesModule.CodigoPalanca.DP, uniqueProgramNuevas, pos);
                    }
                }
                //FIN DH-3473 EINCA Marcar las estrategias de programas nuevas(dúo perfecto)
            }

        } catch (e) {
            console.log('marcarAnalyticsInicio - ' + _texto.excepcion + e, e);
        }

    }

    var marcarAnalyticsChange = function (slick, currentSlide, nextSlide, origen) {
        try {
            _slick = slick;

            if (typeof AnalyticsPortalModule == "undefined") {
                return;
            }

            var objMostrar = _obtenerSlideMostrar(slick, currentSlide, nextSlide);

            var item = objMostrar.SlideMostrar;
            var estrategia = $($(item).find("[data-estrategia]")[0]).data("estrategia") || "";

            if (estrategia === "") {
                if (origen.Palanca == ConstantesModule.OrigenPedidoWebEstructura.Palanca.Liquidacion) {
                    estrategia = _obtenerEstrategiaLiquidacion(objMostrar);
                }
            }

            estrategia = estrategia || "";
            if (estrategia != "") {
                estrategia.Position = objMostrar.IndexMostrar;
                var obj = {
                    lista: Array(estrategia),
                    CantidadMostrar: _slick.options.slidesToScroll,
                    Origen: origen,
                    Direccion: objMostrar.Direccion
                };

                AnalyticsPortalModule.MarcaGenericaLista("", obj);//Analytics Change Generico
            }

        } catch (e) {
            console.log('marcarAnalyticsChange - ' + _texto.excepcion + e, e);
        }

    }

    var marcarAnalyticsContenedor = function (tipo, data, seccionName, slick, currentSlide, nextSlide) {
        //tipo : 1= inicio, 2: cambio

        try {
            var origen = {
                Pagina: ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor,
                Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel,
                CodigoPalanca: seccionName
            };

            if (tipo == 1) {
                marcarAnalyticsInicio("", data.lista, origen, currentSlide);
            }
            else if (tipo == 2) {
                marcarAnalyticsChange(slick, currentSlide, nextSlide, origen);
            }
            else if (tipo == 3) {
                mostrarFlechaCarrusel(data, slick, currentSlide, origen);
            }
        } catch (e) {
            console.log('marcarAnalyticsContenedor - ' + _texto.excepcion + e, e);
        }
    }

    var marcarAnalyticsLiquidacion = function (tipo, data, slick, currentSlide, nextSlide) {
        //tipo : 1= inicio, 2: cambio
        try {

            var origen = {
                Pagina: ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home,
                Palanca: ConstantesModule.OrigenPedidoWebEstructura.Palanca.Liquidacion,
                Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel
            };

            if (tipo == 1) {

                $(".js-slick-prev-liq").insertBefore('#divCarruselLiquidaciones').hide();
                $(".js-slick-next-liq").insertAfter('#divCarruselLiquidaciones');

                marcarAnalyticsInicio("", data, origen, currentSlide);

            }
            else if (tipo == 2) {
                marcarAnalyticsChange(slick, currentSlide, nextSlide, origen);
            }
            else if (tipo == 3) {
                mostrarFlechaCarrusel(data, slick, currentSlide, origen);
            }
        } catch (e) {
            console.log('marcarAnalyticsLiquidacion - ' + _texto.excepcion + e, e);
        }
    }

    var mostrarFlechaCarrusel = function (event, slick, currentSlide, origen) {

        if (slick.options.infinite !== false) {
            return;
        }

        var objPrevArrow = slick.$prevArrow;
        var objNextArrow = slick.$nextArrow;
        //var objVisorSlick = $(event.target).find('.slick-list')[0];
        //var lastSlick = $(event.target).find('[data-slick-index]')[slick.slideCount - 1];

        if (currentSlide === 0) {
            $(objPrevArrow).hide();
            $(objNextArrow).show();
        }
        else {

            var item = currentSlide;
            var anchoFalta = 0;
            do {
                anchoFalta += $(slick.$slides[item]).innerWidth();
                item++;
            } while (item < slick.slideCount);

            if (anchoFalta > $(slick.$list).width()) {
                var currentSlideback = $(slick.$list).attr('data-currentSlide') || $(slick.$list).attr('data-currentslide') || "";
                if (currentSlideback == currentSlide) {
                    slick.options.slidesToShow = isMobile() ? 1 : 2;
                    slick.setPosition();
                    slick.slickGoTo(currentSlide + 1);
                    currentSlide = currentSlide + 1;

                    $(objPrevArrow).show();
                    $(objNextArrow).hide();
                    _marcaAnalyticsViewVerMas(origen);
                }
                else {
                    $(objPrevArrow).show();
                    $(objNextArrow).show();
                }
            }
            else {
                var cantFinal = slick.slideCount - slick.options.slidesToShow;
                if (cantFinal === currentSlide) {
                    $(objPrevArrow).show();
                    $(objNextArrow).hide();
                    _marcaAnalyticsViewVerMas(origen);
                }
            }
        }

        $(slick.$list).attr('data-currentSlide', currentSlide);
    }

    //Función que llama la la funcion de marcacion analytics cuando se visualiza el ultimo botón dorado de "ver más"
    var _marcaAnalyticsViewVerMas = function (origen) {
        if (typeof AnalyticsPortalModule !== "undefined") {
            AnalyticsPortalModule.MarcaPromotionViewCarrusel(origen);
        }
    }

    //HD-3473 EINCA Marcar Analytic, cuando se hace clic en el banner de duo perfecto
    var marcaAnalycticCarruselProgramasNuevas = function (e, url) {
        try {
            var category = (isHome()) ? "Home - Dúo Perfecto" : "Pedido - Dúo Perfecto";
            var pagina = isHome() ? ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home : ConstantesModule.OrigenPedidoWebEstructura.Pagina.Pedido;
            var OrigenPedidoWeb = ConstantesModule.OrigenPedidoWebEstructura.Dispositivo.Desktop
                + pagina + ConstantesModule.OrigenPedidoWebEstructura.Palanca.DuoPerfecto
                + ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel;
            AnalyticsPortalModule.MarcaPromotionClicBanner(OrigenPedidoWeb, "", url);

            dataLayer.push({
                'event': 'virtualEvent',
                'category': category,
                'action': 'Click Botón',
                'label': 'Elegir Ahora'
            });
            document.location.href = url;
            return false;
        } catch (e) {

        }

    }

    return {
        MarcarAnalyticsChange: marcarAnalyticsChange,
        MarcarAnalyticsInicio: marcarAnalyticsInicio,
        MarcarAnalyticsContenedor: marcarAnalyticsContenedor,
        MarcarAnalyticsLiquidacion: marcarAnalyticsLiquidacion,
        MostrarFlechaCarrusel: mostrarFlechaCarrusel,
        MarcaAnalycticCarruselProgramasNuevas: marcaAnalycticCarruselProgramasNuevas//HD-3473 EINCA
    };
}();

var CarruselModule = (function (config) {
    'use strict';

    var _config = {
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlDataCarrusel: config.urlDataCarrusel || "/Estrategia/FichaObtenerProductosCarrusel",
        OrigenPedidoWeb: config.OrigenPedidoWeb || "",
        pantalla: "Ficha",
        tituloCarrusel: config.tituloCarrusel,
        cantidadPack: config.cantidadPack
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
            }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
                _marcarAnalytics(2, null, slick, currentSlide, nextSlide);
            });
        }

        EstablecerAccionLazyImagen(_elementos.divCarruselProducto + " " + _elementos.dataLazy);
    }

    var _marcarAnalytics = function (tipo, data, slick, currentSlide, nextSlide) {

        //tipo : 1= inicio, 2: cambio

        if (typeof AnalyticsPortalModule === 'undefined') {
            return;
        }

        var origen = {
            Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.CarruselVerMas,
            OrigenPedidoWeb: _config.OrigenPedidoWeb.toString()
        };
        if (tipo == 1) {
            CarruselAyuda.MarcarAnalyticsInicio(_elementos.divCarruselProducto, data.lista, origen);
        }
        else if (tipo == 2) {
            CarruselAyuda.MarcarAnalyticsChange(slick, currentSlide, nextSlide, origen);
        }
    }

    var _ocultarElementos = function () {
        $(_elementos.divCarruselProducto).fadeOut();
    }

    var _mostrarTitulo = function () {

        var titulo = '';

        if (_config.palanca == ConstantesModule.TipoEstrategiaTexto.Lanzamiento) {
            titulo = 'SET DONDE ENCUENTRAS EL PRODUCTO';
        }
        else if (_config.palanca == ConstantesModule.TipoEstrategiaTexto.ShowRoom) {
            if (_config.cantidadPack > 1) {
                titulo = 'Packs parecidos que contienen más productos';
            } else {
                titulo = 'Packs que Contienen ' + _config.tituloCarrusel;
            }
        }
        else if (_config.palanca == ConstantesModule.TipoEstrategiaTexto.OfertaDelDia) {
            titulo = 'VER MÁS OFERTAS ¡SOLO HOY!';
        }

        $(_elementos.idTituloCarrusel).html(titulo);
    }
    var _mostrarCarrusel = function () {

        var data = {
            lista: []
        };

        if (_config.palanca == ConstantesModule.TipoEstrategiaTexto.Lanzamiento) {
            data.lista = _cargarDatos();
        }
        else if (
            (_config.palanca == ConstantesModule.TipoEstrategiaTexto.ShowRoom)
            || (_config.palanca == ConstantesModule.TipoEstrategiaTexto.OfertaDelDia)
            || (_config.palanca == ConstantesModule.TipoEstrategiaTexto.PackNuevas)
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
            $.each(data.lista, function (i, item) { item.Posicion = i + 1; });

            SetHandlebars(_elementos.idPlantillaProducto, data, _elementos.divCarruselProducto);
            _mostrarTitulo();
            _mostrarSlicks();

            _marcarAnalytics(1, data);

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
            ? ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
            : ConstantesModule.OrigenPedidoWebEstructura.Pagina.Pedido,
        Palanca: ConstantesModule.OrigenPedidoWebEstructura.Palanca.OfertasParaTi,
        Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel
    };

    CarruselAyuda.MarcarAnalyticsInicio("#divListadoEstrategia", arrayItems, origen);
}

function MarcarAnalyticsChangeHomePedido(event, slick, currentSlide, nextSlide) {

    var origen = {
        Pagina: isHome()
            ? ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
            : ConstantesModule.OrigenPedidoWebEstructura.Pagina.Pedido,
        Palanca: ConstantesModule.OrigenPedidoWebEstructura.Palanca.OfertasParaTi,
        Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel
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
