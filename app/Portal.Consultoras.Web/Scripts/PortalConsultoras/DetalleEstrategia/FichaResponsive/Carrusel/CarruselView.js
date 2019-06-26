﻿"use strict";
class CarruselView {
    constructor(presenter) {
        this.presenter = presenter;

        this.divCarruselProducto = "#divFichaCarruselProducto";
        this.idPlantillaProducto = "#template-producto-carrusel-responsive";
        this.divCarruselContenedor = "#divFichaCarrusel";
        this.idTituloCarrusel = "#tituloCarrusel";
        this.dataLazy = "img[data-lazy-seccion-revista-digital]";
        this.dataOrigenPedidoWeb = {
            busca: "[data-OrigenPedidoWeb]",
                atributo: "data-OrigenPedidoWeb",
                buscaAgregar: "[data-origenpedidowebagregar]",
                atributoAgregar: "data-origenpedidowebagregar"
        }
    }

    ocultarElementos() {
        $(this.divCarruselProducto).fadeOut();
        $(this.divCarruselContenedor).hide();
    }

    crearPlantilla(data, titulo, cantidadProdCarrusel) {
        SetHandlebars(this.idPlantillaProducto, data, this.divCarruselProducto);
        this.mostrarSlicks(cantidadProdCarrusel);
        $(this.idTituloCarrusel).html(titulo);
        $(this.divCarruselContenedor).show();
        this.marcarAnalytics(1, data);
    }

    mostrarSlicks(cantidadProdCarrusel) {
        const platform = !isMobile() ? "desktop" : "mobile";
        const slickArrows = {
            mobile: {
                prev: `<a class="carrusel_fechaprev_mobile" href="javascript:void(0);"><img src="${baseUrl}Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>`,
                next: `<a class="carrusel_fechanext_mobile" href="javascript:void(0);"><img src="${baseUrl}Content/Images/mobile/Esika/next.png")" alt="" /></a>`
            },
            desktop: {
                prev: `<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="${baseUrl}Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>`,
                next: `<a class="previous_ofertas" style="right:-5%; text-align:right;"><img src="${baseUrl}Content/Images/Esika/next.png")" alt="" /></a>`
            }
        };

        $(this.divCarruselProducto + ".slick-initialized").slick("unslick");
        const parent = this;
        $(this.divCarruselProducto).not(".slick-initialized").slick({
            lazyLoad: "progressive",
            dots: false,
            infinite: false,
            speed: 260,
            slidesToShow: isMobile() ? 1 : 3,
            slidesToScroll: 1,
            variableWidth: false,
            prevArrow: slickArrows[platform].prev,
            nextArrow: slickArrows[platform].next,
            responsive: [
                {
                    breakpoint: 720,
                    settings: {
                        slidesToShow: 1
                    }
                }
            ]
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            parent.marcarAnalytics(2, null, slick, currentSlide, nextSlide);
        }).on("lazyLoaded", function(event, slick, image, imageSource) {
            const aspectRatio = image[0].naturalWidth / image[0].naturalHeight;
            console.log(`aspect_ratio: ${aspectRatio}`);
            switch (true) {
            case aspectRatio === 1:
                break;
            case aspectRatio > 1.3:
                $(image[0].parentNode).closest("article").removeClass("caja_vertical").addClass("caja_horizontal");
                break;
            case aspectRatio < 1:
                break;
            }
        }).on("lazyLoadError", function (event, slick, image, imageSource) {
            //$(image[0].parentNode).closest("article").addClass("caja_vertical");
        });

        $(this.divCarruselProducto).fadeIn();
    }

    marcarAnalytics(tipo, data, slick, currentSlide, nextSlide) {
        if (typeof AnalyticsPortalModule === "undefined") {
            return;
        }
        let origen = $(this.divCarruselProducto).attr(this.dataOrigenPedidoWeb.atributoAgregar)
            || $(this.divCarruselProducto).attr(this.dataOrigenPedidoWeb.atributo)
            || $(this.divCarruselProducto).parents(this.dataOrigenPedidoWeb.buscaAgregar).attr(this.dataOrigenPedidoWeb.atributoAgregar)
            || $(this.divCarruselProducto).parents(this.dataOrigenPedidoWeb.busca).attr(this.dataOrigenPedidoWeb.atributo);

        if (tipo === 1) {
            CarruselAyuda.MarcarAnalyticsInicio(this.divCarruselProducto, data.lista, origen);
        }
        else if (tipo === 2) {
            const estrategia = CarruselAyuda.ObtenerEstrategiaSlick(slick, currentSlide, nextSlide);
            origen = CodigoOrigenPedidoWeb.GetCambioSegunTipoEstrategia(origen, estrategia.CodigoEstrategia);
            CarruselAyuda.MarcarAnalyticsChange(slick, currentSlide, nextSlide, origen);
        }
    }
}