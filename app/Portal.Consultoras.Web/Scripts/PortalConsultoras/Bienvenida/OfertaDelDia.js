/// <reference path="../EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />

var belcorp = belcorp || {};
belcorp.estrategia = belcorp.estrategia || {};
registerEvent.call(belcorp.estrategia, "onProductoAgregado");
belcorp.estrategia.subscribe("onProductoAgregado", function (data) {

});

var fechaMostrarBanner = Date.now();
var codigoAnclaOdd = codigoAnclaOdd || "";
var baseUrl = baseUrl || "";
var array_odd = array_odd || {};
var variablesPortal = variablesPortal || {};
var usuarioNombre = usuarioNombre || "";

var OfertaDelDiaProvider = function () {
    "use strict";

    var pedidoGetOfertaDelDiaPromise = function () {
        var dfd = $.Deferred();

        $.ajax({
            type: "GET",
            url: baseUrl + "OfertaDelDia/GetOfertaDelDia",
            cache: false,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    return {
        pedidoGetOfertaDelDiaPromise: pedidoGetOfertaDelDiaPromise
    };
}();

var OfertaDelDiaModule = function () {
    "use strict";

    var odd_desktop_google_analytics_promotion_impresion_flag = true;

    var CONS_TIPO_ORIGEN = {
        ESCRITORIO_HOME: 1,
        MOBILE_HOME: 2,
        ESCRITORIO_PEDIDO: 11,
        MOBILE_PEDIDO: 21,
        ESCRITORIO_OFERTAS: 111,
        MOBILE_OFERTAS: 211,
    };

    var CONS_POSICION_BANNER = {
        BANNER_HOME: "Banner Superior Home - 1",
        BANNER_PEDIDO: "Banner Superior Pedido - 1"
    };

    var props = {
        UrlActual: window.location.href.toLowerCase(),
        UrlValidarStockEstrategia: "Pedido/ValidarStockEstrategia",
        UrlAgregarProducto: "Pedido/AgregarProductoZE",
        TipoOrigenPantallaODD: TipoOrigenPantallaODD,
        OrigenDesktopODD: OrigenDesktopODD //para Analytics
    };

    var elements = {
        ContenedorOfertaDelDia: "#OfertaDelDia",    // desktop
        ContenedorOfertaDelDiaOfertas: "#OfertasDelDiaOfertas", // contenedor de ofertas
        ContenedorInternoSliderOfertaDelDiaMobileHome: "#content_oferta_dia_mobile",
        ContenedorInternoSliderOfertaDelDiaMobile: ".BloqueOfertaDiaHeader",
        TxtCantidadMobile: "#txtCantidad"
    };

    var seAtacharonEventosOdd = false;

    var IrContenedorOfertas = function () {
        try {
            odd_desktop_google_analytics_promotion_click_verofertas();
        } catch (e) {
            //
        }
        var urlOfertas = "/Ofertas" + (codigoAnclaOdd == "" ? "" : "#" + codigoAnclaOdd);
        document.location.href = urlOfertas;
        return true;
    };

    var odd_mobile_home_google_analytics_promotion_impresion = function () {
        if ($("#banner-odd-mobile").length > 0) {
            var id = $("#banner-odd-mobile").find("#estrategia-id-odd").val();
            var name = "Oferta del día - " + $("#banner-odd-mobile").find("#nombre-odd").val();
            var creative = $("#banner-odd-mobile").find("#nombre-odd").val() +
                " - " +
                $("#banner-odd-mobile").find("#cuv2-odd").val();
            var positionName = props.OrigenDesktopODD == 1
                ? CONS_POSICION_BANNER.BANNER_HOME
                : props.OrigenDesktopODD == 2
                ? CONS_POSICION_BANNER.BANNER_PEDIDO
                : "";
            dataLayer.push({
                'event': "promotionView",
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': id,
                                'name': name,
                                'position': positionName,
                                'creative': creative
                            }
                        ]
                    }
                }
            });
        }
    };

    var EsValidoResponseGetOfertaDelDia = function (response) {
        $("#ODD").find(".seccion-loading-contenedor").fadeOut();
        if (!response.success)
            return false;

        if (response.data.TeQuedan.TotalSeconds <= 0)
            return false;

        if (response.data.TieneOfertas != true) {
            $("#ODD").find(".seccion-content-contenedor").fadeOut();
            return false;
        }
        $("#ODD").find(".seccion-content-contenedor").fadeIn();
        return true;
    };

    var AsignarClaseCssAPalabraGratisDesktop = function (listaOfertas) {
        var listaOfertasConClases = [];

        $.each(listaOfertas, function (index, value) {
            value.DescripcionCompleta = value.DescripcionCompleta.replace("(¡GRATIS!)", "<span class='color-para-todas-marcas'>¡GRATIS!</span>");
            listaOfertasConClases.push(value);
        });

        return listaOfertasConClases;
    };

    var RenderOfertaDelDia = function (data, contenedorOfertas) {
        $(contenedorOfertas).hide();

        data.ListaOferta = data.ListaOferta || [];
        data.CantidadProductos = data.ListaOferta.length;
        data.Simbolo = variablesPortal.SimboloMoneda;
        data.UsuarioNombre = $.trim(usuarioNombre).toUpperCase();
        data.lista = AsignarClaseCssAPalabraGratisDesktop(data.ListaOferta);
        data.prod = {};
        data.SoloUno = false;
        if (data.lista.length > 0) {
            data.prod = data.lista[0];
            data.SoloUno = data.lista.length === 1;
        }

        SetHandlebars("#ofertadeldia-template", data, contenedorOfertas);
        if ($(contenedorOfertas).find("#divOddCarrusel").length > 0) {
            SetHandlebars("#producto-landing-template", data, $(contenedorOfertas).find("#divOddCarrusel"));
        }

        //odd_desktop_google_analytics_product_impresion(data, contenedorOfertas);

        if (typeof CarruselAyuda != "undefined") {
            // marcacion inicio de mostrar productos
            var origen = {
                Pagina: ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor,
                Palanca: ConstantesModule.OrigenPedidoWebEstructura.Palanca.OfertaDelDia,
                Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel
            };
            CarruselAyuda.MarcarAnalyticsInicio("#divOddCarrusel", data.ListaOferta, origen, 3);// contenedor
        }
    };

    var MostrarRelojOfertaDelDia = function (totalSegundos) {
        $(".clock").each(function (index, elem) {
            $(elem).FlipClock(totalSegundos, {
                countdown: true,
                clockFace: "HourlyCounter",
                language: "es-es"
            });
        });
    }

    var odd_desktop_procesar_evento_before_change = function (event, slick, currentSlide, nextSlide) {

        var origen = {
            Pagina: ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor,
            Palanca: ConstantesModule.OrigenPedidoWebEstructura.Palanca.OfertaDelDia,
            Seccion: ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel
        };

        CarruselAyuda.MarcarAnalyticsChange(slick, currentSlide, nextSlide, origen);// Home Pedido

        //if (currentSlide != nextSlide) {
        //    var accion = "";

        //    if (nextSlide == 0 && currentSlide + 1 == array_odd.CantidadProductos) {
        //        accion = "next";
        //    } else if (currentSlide == 0 && nextSlide + 1 == array_odd.CantidadProductos) {
        //        accion = "prev";
        //    } else if (nextSlide > currentSlide) {
        //        accion = "next";
        //    } else {
        //        accion = "prev";
        //    }

        //    var index = nextSlide;
        //    if (accion == "next") {
        //        index += 2;
        //    }

        //    if (index >= array_odd.CantidadProductos) {
        //        index = index - array_odd.CantidadProductos;
        //    }

        //    var div = $("#divOddCarrusel").find("[data-item-position=" + index + "]");
        //    var name = $(div).find("[data-item-campos]").find(".nombre-odd").val();
        //    var id = $(div).find("[data-item-campos]").find(".cuv2-odd").val();
        //    var price = $(div).find("[data-item-campos]").find(".precio-odd").val();
        //    var brand = $(div).find("[data-item-campos]").find(".marca-descripcion-odd").val();
        //    var variant = $(div).find("[data-item-campos]").find(".tipoestrategia-descripcion-odd").val();
        //    var position = index + 1;
        //    var estrategia = {
        //        DescripcionCompleta: name,
        //        CUV2: id,
        //        PrecioVenta: price,
        //        DescripcionMarca: brand,
        //        Position: position
        //    };
        //    var obj = {
        //        lista: Array(estrategia)
        //    };
        //    AnalyticsPortalModule.MarcaGenericaLista("ODD", obj, obj.lista.length);

        //    //impresions.push({
        //    //    'name': name,
        //    //    'id': id,
        //    //    'price': price,
        //    //    'brand': brand,
        //    //    'category': "No disponible",
        //    //    'variant': variant,
        //    //    'list': "Oferta del día",
        //    //    'position': position
        //    //});
        //    //dataLayer.push({
        //    //    'event': "productImpression",
        //    //    'ecommerce': {
        //    //        'impressions': impresions
        //    //    }
        //    //});
        //}
    };

    var ConfigurarCarruselProductos = function (contenedorOfertas, cantidadProductos) {
        if (cantidadProductos > 1) {
            $(contenedorOfertas + " #imgSoloHoy").show();
            $(contenedorOfertas + ' [data-odd-accion="regresar"]').hide();
            $(contenedorOfertas + ' [data-odd-tipoventana="carrusel"]').show();
        }
        var slidesToScroll = cantidadProductos;
        if (cantidadProductos > 2) {
            slidesToScroll = 2;
            EstablecerLazyCarrusel("#divOddCarrusel");

            $("#divOddCarrusel.slick-initialized").slick("unslick");
            $("#divOddCarrusel").not(".slick-initialized").slick({
                lazyLoad: "ondemand",
                infinite: true,
                vertical: false,
                slidesToShow: slidesToScroll,
                slidesToScroll: 1,
                variableWidth: true,
                autoplay: false,
                speed: 260,
                prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',
                nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>'
            }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
                odd_desktop_procesar_evento_before_change(event, slick, currentSlide, nextSlide);
            });

            // esto debe ser automatico
            $("#divOddCarrusel .slick-track > div.slick-slide").css("min-width", "auto");
        }
    }

    var odd_desktop_google_analytics_promotion_impresion = function () {
        if ($("#banner-odd").length > 0) {
            var id = $("#banner-odd").find(".estrategia-id-odd").val();
            var name = "Oferta del día - " + $("#banner-odd").find(".nombre-odd").val();
            var creative = $("#banner-odd").find(".nombre-odd").val() + " - " + $("#banner-odd").find(".cuv2-odd").val();
            var positionName = props.OrigenDesktopODD == 1 ? CONS_POSICION_BANNER.BANNER_HOME : props.OrigenDesktopODD == 2 ? CONS_POSICION_BANNER.BANNER_PEDIDO : "";
            dataLayer.push({
                'event': "promotionView",
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': id,
                                'name': name,
                                'position': positionName,
                                'creative': creative
                            }]
                    }
                }
            });
        }
    }

    var CargarODDEscritorio = function (tipoOrigenPantallaODD) {
        var contenedorOfertas = "";

        if (tipoOrigenPantallaODD === CONS_TIPO_ORIGEN.ESCRITORIO_HOME)
            contenedorOfertas = elements.ContenedorOfertaDelDia;

        if (tipoOrigenPantallaODD === CONS_TIPO_ORIGEN.ESCRITORIO_OFERTAS)
            contenedorOfertas = elements.ContenedorOfertaDelDiaOfertas;

        if (contenedorOfertas !== "" && $(contenedorOfertas).length === 0)
            return false;

        OfertaDelDiaProvider
            .pedidoGetOfertaDelDiaPromise()
            .done(function (response) {
                var array_odd = response.data;

                if (!EsValidoResponseGetOfertaDelDia(response))
                    return false;

                var _data = response.data;
                var origenPedidoWeb = 0;
                if (isPagina('bienvenida')) {
                    origenPedidoWeb = ConstantesModule.OrigenPedidoWeb.DesktopHomeOfertaDeliaBannerSuperior;
                }
                else if (isPagina('pedido')) {
                    origenPedidoWeb = ConstantesModule.OrigenPedidoWeb.DesktopPedidoOfertaDelDiaBannerSuperior;
                }
                else {
                    origenPedidoWeb = ConstantesModule.OrigenPedidoWeb.DesktopOtrasOfertaDelDiaBannerSuperior;
                }

                _data.OrigenPedidoWeb = origenPedidoWeb;
                RenderOfertaDelDia(_data, contenedorOfertas);
                MostrarRelojOfertaDelDia(_data.TeQuedan.TotalSeconds);

                var setColorFondo = _data.ColorFondo1;
                var setColorTexto = "";

                if (_data.ConfiguracionContenedor.ColorFondo !== "") {
                    setColorFondo = _data.ConfiguracionContenedor.ColorFondo;
                }

                if (_data.ConfiguracionContenedor.ColorTexto !== "") {
                    setColorTexto = _data.ConfiguracionContenedor.ColorTexto;
                }

                var url = window.location.href.toLowerCase() + "/";
                url = url.replace("#", "/");
                if (url.indexOf("/ofertas/") >= 0) {
                    if (_data.ConfiguracionContenedor.UsarImagenFondo &&
                        _data.ConfiguracionContenedor.ImagenFondo !== "") {
                        $(contenedorOfertas).css("background", 'url("' + _data.ConfiguracionContenedor.ImagenFondo + '")');
                    } else {
                        $(contenedorOfertas).css("background-color", setColorFondo);
                    }
                }
                else {
                    $("#banner-odd .izquierda_img img").attr("src", _data.ImagenFondo1);
                    $("#banner-odd .derecha_img img").attr("src", _data.ImagenFondo1);
                    $(contenedorOfertas).css("background-color", _data.ColorFondo1);
                }

                SetHandlebars("#ofertadeldia-template-style", _data, "#styleRelojOdd");

                $(contenedorOfertas).show();

                ConfigurarCarruselProductos(contenedorOfertas, _data.CantidadProductos);

                if (setColorTexto !== "") {
                    $(".clase_control_color_dinamico").css("color", setColorTexto);
                    $(".clase_control_color_dinamico").css("border-color", setColorTexto);
                    $(".icono_clase_control_color_dinamico").css("-webkit-filter", "opacity(.5) drop-shadow(0 0 0 " + setColorTexto + ")");
                    $(".icono_clase_control_color_dinamico").css("filter", "opacity(.5) drop-shadow(0 0 0 " + setColorTexto + ")");
                    $(".cross_clase_control_color_dinamico").css("background", setColorTexto);

                    var styleElemTrick = document.head.appendChild(document.createElement("style"));
                    styleElemTrick.innerHTML = ".cross_clase_control_color_dinamico:after {background: " + setColorTexto + ";}";

                    $(".cross_line_clase_control_color_dinamico").css("background", setColorTexto);
                }

                $("#PopOfertaDia").hide();

                if (tipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_OFERTAS) {
                    $("#banner-odd").parent().hide();
                    $("#PopOfertaDia").show();
                }

                if (tipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_HOME) {
                    LayoutHeader();
                    if (odd_desktop_google_analytics_promotion_impresion_flag) {
                        odd_desktop_google_analytics_promotion_impresion();
                        odd_desktop_google_analytics_promotion_impresion_flag = false;
                    }
                }
            })
            .fail(function (data, error) {
                //
            });

        if (!seAtacharonEventosOdd) {

            $("body").off("click", contenedorOfertas + " [data-odd-accion]");
            $("body").on("click", contenedorOfertas + " [data-odd-accion]", function (e) {
                var accion = $(this).attr("data-odd-accion").toUpperCase();
                if (accion == CONS_TIPO_ACCION.VERDETALLE) {
                    $(contenedorOfertas + " #imgSoloHoy").hide();
                    $(contenedorOfertas + ' [data-odd-accion="regresar"]').show();
                    $(contenedorOfertas + ' [data-odd-tipoventana="carrusel"]').hide();
                    $(contenedorOfertas + ' [data-odd-tipoventana="detalle"]').show();
                    var posicion = $(this).parents("[data-item]").attr("data-item-position");
                    $("#divOddCarruselDetalle").slick("slickGoTo", posicion);
                }
                else if (accion == CONS_TIPO_ACCION.REGRESAR) {

                    $("#divOddCarrusel").slick("refresh", false);
                    $(contenedorOfertas + " #imgSoloHoy").show();
                    $(contenedorOfertas + ' [data-odd-accion="regresar"]').hide();
                    $(contenedorOfertas + ' [data-odd-tipoventana="detalle"]').hide();
                    $(contenedorOfertas + ' [data-odd-tipoventana="carrusel"]').show();
                }
            });
            seAtacharonEventosOdd = true;
        }

        return false;
    };

    var ConstruirDescripcionOferta = function (arrDescripcion) {
        var descripcion = "";
        $.each(arrDescripcion,
            function (index, value) {
                value = value.replace("<br />", "");
                value = value.replace("<br/>", "");
                descripcion += "+ " + value + "<br />";
            });
        return descripcion;
    };

    var AsignarPosicionAListaOfertas = function (listaOfertas) {
        var posicion = 0;
        var nuevaListaOfertas = [];
        $.each(listaOfertas,
            function (index, value) {
                posicion++;
                value.Posicion = posicion;
                value.DescripcionOferta = (value.DescripcionOferta == "" || value.DescripcionOferta == null)
                    ? ""
                    : ConstruirDescripcionOferta(value.DescripcionOferta.split("+"));
                nuevaListaOfertas.push(value);
            });

        return nuevaListaOfertas;
    };

    var AsignarClaseCssAPalabraGratisMobile = function (listaOfertas) {
        var listaOfertasConClases = [];

        $.each(listaOfertas,
            function (index, value) {
                value.DescripcionOferta =
                    value.DescripcionOferta.replace("(¡GRATIS!)", "<span class='color-por-marca'>¡GRATIS!</span>");
                listaOfertasConClases.push(value);
            });

        return listaOfertasConClases;
    };

    //var odd_mobile_procesar_evento_before_change = function (event, slick, currentSlide, nextSlide, list) {
    //    if (currentSlide != nextSlide) {
    //        var accion = "";
    //        var index = 0;

    //        if (nextSlide == 0 && currentSlide + 1 == list.length) {
    //            accion = "next";
    //        } else if (currentSlide == 0 && nextSlide + 1 == list.length) {
    //            accion = "prev";
    //        } else if (nextSlide > currentSlide) {
    //            accion = "next";
    //        } else {
    //            accion = "prev";
    //        }

    //        if (accion == "prev") {
    //            index = nextSlide;
    //        }
    //        if (accion == "next") {
    //            index = nextSlide;
    //        }
    //        if (index >= list.length) {
    //            index = index - list.length;
    //        }

    //        return index;
    //    }
    //    else
    //        return -1;
    //}

    var CargarODDMobile = function () {
        MostrarRelojOfertaDelDia($(".clock").data("total-seconds"));

        OfertaDelDiaProvider
            .pedidoGetOfertaDelDiaPromise()
            .done(function (data) {
                array_odd = data.data;

                if (!EsValidoResponseGetOfertaDelDia(data))
                    return false;
                var _data = data.data;

                MostrarRelojOfertaDelDia(_data.TeQuedan.TotalSeconds);

                $("#txtCantidad").val("1");
                var overflowY = "auto";
                $("body").css({ 'overflow-y': "auto" });
                return false;
            })
            .fail(function (data, error) {
                checkTimeout(data);
            });
        return false;
    };

    var Inicializar = function () {
        if (isPagina("intriga")) {
            return false;
        }

        if (props.TipoOrigenPantallaODD === CONS_TIPO_ORIGEN.MOBILE_HOME) {
            CargarODDMobile();
            odd_mobile_home_google_analytics_promotion_impresion();
        }
        else if (props.TipoOrigenPantallaODD === CONS_TIPO_ORIGEN.ESCRITORIO_HOME ||
            props.TipoOrigenPantallaODD === CONS_TIPO_ORIGEN.ESCRITORIO_OFERTAS) {
            CargarODDEscritorio(props.TipoOrigenPantallaODD);
        }

        return false;
    };

    return {
        Inicializar: Inicializar,
        IrContenedorOfertas: IrContenedorOfertas,
        CargarODDEscritorio: CargarODDEscritorio
    };
}();

