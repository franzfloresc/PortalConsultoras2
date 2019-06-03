﻿var EstrategiaView = function () {
    var _presenter = null;

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _elements = {
        breadcrumbs: {
            templateId: "#breadcrumbs-template",
            id: "#breadcrumbs",
        },
        imagenEstrategia: {
            templateId: "#imagen-estrategia-template",
            id: "#imagen-estrategia",
        },
        estrategia: {
            templateId: "#estrategia-template",
            id: "#estrategia",
            background: "#ImagenDeFondo",
            stamp: "#ImagenDeFondo",
        },
        compartirEstrategia: {
            templateId: "#compartir-estrategia-template",
            id: "#compartir-estrategia",
        },
        reloj: {
            templateId: "#ofertadeldia-template-style",
            id: "[data-ficha-contenido=\"ofertadeldia-template-style\"]",
            clase: ".clock_odd"
        },
        agregar: {
            templateId: "#agregar-estrategia-template",
            id: "#dvContenedorAgregar",
            contenedor: "#ContenedorAgregado"
        }
    };

    var _renderBreadcrumbs = function (estrategia) {
        SetHandlebars(_elements.breadcrumbs.templateId, estrategia, _elements.breadcrumbs.id);
        return true;
    };

    var _renderEstrategia = function (estrategia) {
        SetHandlebars(_elements.imagenEstrategia.templateId, estrategia, _elements.imagenEstrategia.id);
        SetHandlebars(_elements.estrategia.templateId, estrategia, _elements.estrategia.id);
        return true;
    };

    var _renderBackgroundAndStamp = function (estrategia) {
        var backgroundImg = estrategia.TipoEstrategiaDetalle.ImgFichaFondoDesktop || "";
        var stampImg = estrategia.TipoEstrategiaDetalle.ImgFichaDesktop || "";

        if(estrategia.isMobile){
            backgroundImg = estrategia.TipoEstrategiaDetalle.ImgFichaFondoMobile || "";
            stampImg = estrategia.TipoEstrategiaDetalle.ImgFichaMobile || "";
        }

        // background
        $(_elements.estrategia.background).css("background-image", 'url(' + backgroundImg + ')');

        // stamp
        $(_elements.estrategia.stamp).css("background-image", 'url(' + stampImg + ')');
        $(_elements.estrategia.stamp).css("padding-top","75px");

        return true;
    };

    var _renderReloj = function (estrategia) {
        $(_elements.reloj.clase).each(function (i, e) {
            $(e).FlipClock(estrategia.TeQuedan, {
                countdown: true,
                clockFace: "HourlyCounter",
                language: "es-es"
            });
        });

        return true;
    };

    var _renderRelojStyle = function (estrategia) {
        SetHandlebars(_elements.reloj.templateId, estrategia, _elements.reloj.id);
        return true;
    };

    var _renderAgregar = function (estrategia) {
        SetHandlebars(_elements.agregar.templateId, estrategia, _elements.agregar.id);
        return true;
    };

    var _showTitleAgregado = function (estrategia) {
        if (estrategia.EsEditable) {
            $(_elements.agregar.contenedor).remove();
        }
        else {
            if (estrategia.IsAgregado) {
                $(_elements.agregar.contenedor).show();
            }
        }

        return true;
    };
    
    var _showCarrusel = function(){
        $('#carousel_upselling').slick({
            lazyLoad: 'ondemand',
            infinite: false,
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            variableWidth: true,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style=""><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style=""><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
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
        });
    };

    return {
        setPresenter: _setPresenter,
        renderBreadcrumbs : _renderBreadcrumbs,
        renderEstrategia : _renderEstrategia,
        renderBackgroundAndStamp: _renderBackgroundAndStamp,
        renderReloj: _renderReloj,
        renderRelojStyle: _renderRelojStyle,
        renderAgregar: _renderAgregar,
        showTitleAgregado: _showTitleAgregado,
        showCarrusel : _showCarrusel
    };
};