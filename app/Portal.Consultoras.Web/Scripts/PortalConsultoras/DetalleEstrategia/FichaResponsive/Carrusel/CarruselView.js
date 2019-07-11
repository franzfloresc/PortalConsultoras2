"use strict";
class CarruselView {

    constructor(presenter) {
        this.presenter = presenter;

        this.divCarruselContenedor = "#divFichaCarrusel";
        this.divCarruselProducto = ".carrusel_seccion";
        this.idPlantillaProducto = "#template-producto-carrusel-responsive";
        this.idTituloCarrusel = ".titulo_seccion";

        this.dataLazy = "img[data-lazy-seccion-revista-digital]";
        this.dataOrigenPedidoWeb = {
            busca: "[data-OrigenPedidoWeb]",
            atributo: "data-OrigenPedidoWeb",
            buscaAgregar: "[data-origenpedidowebagregar]",
            atributoAgregar: "data-origenpedidowebagregar"
        }
        this.fichaEnriquecida = {
            id:"#divFichaEnriquecida",
            capa: "divFichaEnriquecida"
        };

        this.divCarrusel = {
            id: [
                "#divFichaCarrusel_UpSelling", 
                "#divFichaCarrusel_CrossSell", 
                "#divFichaCarrusel_Suggested"
            ],
            capa: [
                "divFichaCarrusel_UpSelling", 
                "divFichaCarrusel_CrossSell", 
                "divFichaCarrusel_Suggested"
            ]
        };
        this.divCarruselFicha = {
            ficha: ".contenedor_seccion_fichas .seccion_ficha",
            visible: ".contenedor_seccion_fichas .seccion_ficha:not(:hidden)"
        }
    }

    fijarObjetosCarrusel(tipo) {
        this.divCarruselContenedor = this.divCarruselContenedor + "_" + tipo;
        this.divCarruselProducto = this.divCarruselContenedor + " " + this.divCarruselProducto;
        this.idTituloCarrusel = this.divCarruselContenedor + " " + this.idTituloCarrusel;
    }

    crearPlantilla(data, titulo) {
        SetHandlebars(this.idPlantillaProducto, data, this.divCarruselProducto);
        this.mostrarSlicks();
        $(this.idTituloCarrusel).html(titulo);
        $(this.divCarruselContenedor).show();
        this.marcarAnalytics(1, data);
    }
    setValueAttrHtml(attrObj, value) {
        $(this.divCarruselProducto).attr(attrObj, value);
    }

    setAttrHtml(origenIni, OrigenAgregar) {
        this.setValueAttrHtml(this.dataOrigenPedidoWeb.atributo, origenIni);
        this.setValueAttrHtml(this.dataOrigenPedidoWeb.atributoAgregar, OrigenAgregar);
    }

    mostrarSlicks() {
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
            slidesToShow: 3,
            slidesToScroll: 1,
            variableWidth: true,
            prevArrow: slickArrows[platform].prev,
            nextArrow: slickArrows[platform].next,
            responsive: [
                {
                    breakpoint: 900,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
            parent.marcarAnalytics(2, null, slick, currentSlide, nextSlide);
        }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
            parent.marcarAnalytics(3, null, slick, currentSlide);
        }).on("lazyLoaded", function (event, slick, image, imageSource) {
            const aspectRatio = image[0].naturalWidth / image[0].naturalHeight;
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

        var origenModelo = CodigoOrigenPedidoWeb.GetOrigenModelo(origen);
        if (tipo === 1) {
            CarruselAyuda.MarcarAnalyticsInicio(this.divCarruselProducto, data.lista, origenModelo);
        }
        else if (tipo === 2) {
            const estrategia = CarruselAyuda.ObtenerEstrategiaSlick(slick, currentSlide, nextSlide, origenModelo);
            origen = CodigoOrigenPedidoWeb.GetCambioSegunTipoEstrategia(origen, estrategia.CodigoEstrategia);
            origenModelo = CodigoOrigenPedidoWeb.GetOrigenModelo(origen);
            CarruselAyuda.MarcarAnalyticsChange(slick, currentSlide, nextSlide, origenModelo);
        }
        else if (tipo === 3) {
            const estrategia = CarruselAyuda.ObtenerEstrategiaSlick(slick, currentSlide, nextSlide);
            origen = CodigoOrigenPedidoWeb.GetCambioSegunTipoEstrategia(origen, estrategia.CodigoEstrategia);
            CarruselAyuda.MostrarFlechaCarrusel(slick, currentSlide, origen);
        }
    }

    filterFichaVisible(ficha){
        return $(this.divCarruselFicha.visible).filter(function (indice, elemento) {
            return elemento.id === ficha;
        })[0];
    }

}