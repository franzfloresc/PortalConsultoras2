var CarruselVariable = function () {
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

        var cantActive = $(slick.$slider).find('.slick-active').length;
        var indexCurrent = parseInt($(slick.$slider).find('.slick-current').attr("data-slick-index"));

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

        var slideMostrar = $(slick.$slider).find("[data-slick-index='" + indexMostrar + "']");

        return {
            Direccion: direccion,
            IndexMostrar: indexMostrar,
            SlideMostrar: slideMostrar
        }
    };

    var obtenerEstrategiaSlick = function (slick, currentSlide, nextSlide) {

        var objMostrar = _obtenerSlideMostrar(slick, currentSlide, nextSlide);
        var item = objMostrar.SlideMostrar;
        var estrategia = $($(item).find("[data-estrategia]")[0]).data("estrategia") || "";

        if (estrategia === "") {
            if (origen.Palanca == CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Liquidacion) {
                estrategia = _obtenerEstrategiaLiquidacion(objMostrar);
            }
        }

        return estrategia || {};
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
            arrayItems = arrayItems || [];
            origen = origen || {};
            slidesToShow = isInt(slidesToShow) ? parseInt(slidesToShow, 10) : 0;
            var cantActive = slidesToShow || ($(idHtmlSeccion).find(".slick-active") || []).length;

            cantActive = isInt(cantActive) ? parseInt(cantActive, 10) : 0;

            if (cantActive <= 0) {
                cantActive = arrayItems.length;
                cantActive = isInt(cantActive) ? parseInt(cantActive, 10) : 0;
            }

            if (cantActive <= 0) {
                return;
            }

            var arrayEstrategia = [];
            for (var i = 0; i < cantActive; i++) {
                var recomendado = arrayItems[i];
                if (recomendado != undefined) {
                    recomendado.Posicion = i;
                    if (origen.Palanca == CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Liquidacion) {
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
                    AnalyticsPortalModule.MarcaPromotionView(ConstantesModule.CodigoPalanca.DP, uniqueProgramNuevas, pos);
                }
            }
            //FIN DH-3473 EINCA Marcar las estrategias de programas nuevas(dúo perfecto)



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

            //var item = objMostrar.SlideMostrar;
            //var estrategia = $($(item).find("[data-estrategia]")[0]).data("estrategia") || "";

            //if (estrategia === "") {
            //    if (origen.Palanca == CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Liquidacion) {
            //        estrategia = _obtenerEstrategiaLiquidacion(objMostrar);
            //    }
            //}

            var estrategia = obtenerEstrategiaSlick(slick, currentSlide, nextSlide);

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
                Pagina: CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Contenedor,
                Seccion: CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel,
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
                Pagina: CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home,
                Palanca: CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Liquidacion,
                Seccion: CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel
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
            var pagina = isHome() ? CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home : CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Pedido;
            var OrigenPedidoWeb = CodigoOrigenPedidoWeb.CodigoEstructura.Dispositivo.Desktop
                + pagina + CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.DuoPerfecto
                + CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel;
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
        MarcaAnalycticCarruselProgramasNuevas: marcaAnalycticCarruselProgramasNuevas,
        ObtenerEstrategiaSlick: obtenerEstrategiaSlick
    };
}();
