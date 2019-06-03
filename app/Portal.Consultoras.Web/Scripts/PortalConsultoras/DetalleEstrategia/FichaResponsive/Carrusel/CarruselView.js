"use strict";
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
        const widthDimamico = !isMobile();
        const slickArrows = {
            mobile: {
                prev: `<a class="carrusel_fechaprev_mobile" href="javascript:void(0);"><img src="${baseUrl}Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>`,
                next: `<a class="carrusel_fechanext_mobile" href="javascript:void(0);"><img src="${baseUrl}Content/Images/mobile/Esika/next.png")" alt="" /></a>`
            },
            desktop: {
                prev: `<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="${baseUrl}Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>`,
                next: `<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="${baseUrl}Content/Images/Esika/next.png")" alt="" /></a>`
            }
        };

        $(this.divCarruselProducto).fadeIn();

        if ((widthDimamico && cantidadProdCarrusel > 2) || !widthDimamico) {
            $(this.divCarruselProducto + ".slick-initialized").slick("unslick");
            const parent = this;
            $(this.divCarruselProducto).not(".slick-initialized").slick({
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
                parent.marcarAnalytics(2, null, slick, currentSlide, nextSlide);
            });
        }

        EstablecerAccionLazyImagen(this.divCarruselProducto + " " + this.dataLazy);
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