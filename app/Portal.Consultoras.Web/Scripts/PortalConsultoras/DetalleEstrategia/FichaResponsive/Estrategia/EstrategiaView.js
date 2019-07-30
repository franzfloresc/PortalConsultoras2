var EstrategiaView = function () {
    var _presenter = null;

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _elements = {
        htmlAttrView: {
            origenPedidoWebAgregar: 'data-OrigenPedidoWebAgregar',
            origenPedidoEditar: 'data-OrigenPedidoEditar',
            codigovariante: 'data-codigovariante'            
        },
        btnAgregar: {
            id: "#btnAgregalo",
            classDesactivado: "btn_deshabilitado"
        },
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
            stamp: ".tag_nuevo",
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
        },
        galeria: {
            templateId: "#galeria-template",
            id: "#contenedor-galeria"
        }
    };

    var _renderBreadcrumbs = function (estrategia) {
        SetHandlebars(_elements.breadcrumbs.templateId, estrategia, _elements.breadcrumbs.id);
        return true;
    };

    var _renderEstrategia = function (estrategia) {
        SetHandlebars(_elements.imagenEstrategia.templateId, estrategia, _elements.imagenEstrategia.id);
        _renderGaleria(estrategia, false);

        $('.slider-for').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false,
            asNavFor: '.slider-nav',
            infinite: false,
            dots: false,
            fade: true,
            cssEase: 'linear',
            responsive: [

                {
                    breakpoint: 992,
                    settings: {
                        dots: true,
                        fade: false
                    }
                }
            ]
        });

        $('.slider-nav').slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            asNavFor: '.slider-for',
            dots: false,
            infinite: false,
            focusOnSelect: true,
            vertical: true,
            prevArrow: '<div class="arrow prev arrow_vertical"><div class="arrow-top"></div><div class="arrow-bottom"></div></div>',
            nextArrow: '<div class="arrow next arrow_vertical"><div class="arrow-top"></div><div class="arrow-bottom"></div></div>',
        });

        SetHandlebars(_elements.estrategia.templateId, estrategia, _elements.estrategia.id);
        return true;
    };

    var _renderBackgroundAndStamp = function (estrategia) {
        var backgroundImg = estrategia.TipoEstrategiaDetalle.ImgFichaFondoDesktop || "";
        var stampImg = estrategia.TipoEstrategiaDetalle.ImgFichaDesktop || "";

        if (estrategia.isMobile) {
            backgroundImg = estrategia.TipoEstrategiaDetalle.ImgFichaFondoMobile || "";
            stampImg = estrategia.TipoEstrategiaDetalle.ImgFichaMobile || "";
        }

        // background
        $(_elements.estrategia.background).css("background-image", 'url(' + backgroundImg + ')');

        // stamp
        $(_elements.estrategia.stamp).css("background-image", 'url(' + stampImg + ')');
        $(_elements.estrategia.stamp).css("padding-top", "75px");

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

    let _fixButtonAddProduct = function () {
        const isMobile = window.matchMedia("(max-width:991px)").matches;
        if (!isMobile) return;
        var heightWindow = $(window).height();
        $(window).scroll(function () {
            const fixmeTop = $(".fixme_button").offset().top + 75;
            const currentScroll = $(window).scrollTop();
            if (currentScroll + heightWindow >= fixmeTop) {
                $("#dvContenedorAgregar").removeClass("contenedor_fixed");
            } else {
                if (!($("#dvContenedorAgregar").hasClass("contenedor_fixed"))) {
                    $("#dvContenedorAgregar").addClass("contenedor_fixed");
                }
            }
        });
    }

    var _showCarrusel = function () {
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

    var _validarDesactivadoGeneral = function (pEstrategia) {
        if (pEstrategia.esEditable) {
            $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.classDesactivado);
        } else {
            $.each(pEstrategia.Hermanos, function (index, hermano) {
                if (hermano.Hermanos && hermano.Hermanos.length > 0) {
                    $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.classDesactivado);
                }
            });
        }

    };

    var _validarActivadoGeneral = function (pEstrategia) {
        if (!pEstrategia.esEditable) {
            $.each(pEstrategia.Hermanos, function (index, hermano) {
                if (!(hermano.Hermanos && hermano.Hermanos.length > 0)) {
                    $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.classDesactivado);
                }
            });
        }

    };

    var _setEstrategiaTipoBotonAgregar = function (estrategia) {
        pEstrategia = estrategia;
        if (pEstrategia.TipoAccionAgregar <= 0) {
            $(_elements.agregar.id).hide();
        }

        if (pEstrategia.CodigoVariante === ConstantesModule.CodigoVariedad.IndividualVariable ||
            pEstrategia.CodigoVariante === ConstantesModule.CodigoVariedad.CompuestaVariable ||
            pEstrategia.CodigoVariante === ConstantesModule.CodigoVariedad.ComuestaFija) {
            _validarDesactivadoGeneral(pEstrategia);
        }
        if (pEstrategia.CodigoVariante === ConstantesModule.CodigoVariedad.IndividualVariable ||
            pEstrategia.CodigoVariante === ConstantesModule.CodigoVariedad.ComuestaFija) {
            _validarActivadoGeneral(pEstrategia);
        }

        return true;
    };

    var _cleanContainer = function () {
        $(_elements.breadcrumbs.id).empty();
        $(_elements.imagenEstrategia.id).empty();
        $(_elements.agregar.id).empty();
    };

    var _setValueAttrElementHtml = function (attrObj, value) {
        $("[" + attrObj + "]").attr(attrObj, value);
    };

    var _setEstrategiaAtributosHtml = function (estrategia) {
        _setValueAttrElementHtml(_elements.htmlAttrView.origenPedidoWebAgregar, estrategia.OrigenAgregar);
        _setValueAttrElementHtml(_elements.htmlAttrView.origenPedidoEditar, estrategia.CodigoUbigeoPortal);
        _setValueAttrElementHtml(_elements.htmlAttrView.codigovariante, estrategia.CodigoVariante);
    };

    var _renderGaleria = function (objeto, esFichaEnriquecida) {
        objeto.EsFichaEnriquecida = esFichaEnriquecida;

        SetHandlebars(_elements.galeria.templateId, objeto, _elements.galeria.id);
        return true;
    };

    return {
        setPresenter: _setPresenter,
        renderBreadcrumbs: _renderBreadcrumbs,
        renderEstrategia: _renderEstrategia,
        renderBackgroundAndStamp: _renderBackgroundAndStamp,
        renderReloj: _renderReloj,
        renderRelojStyle: _renderRelojStyle,
        renderAgregar: _renderAgregar,
        showTitleAgregado: _showTitleAgregado,
        cleanContainer: _cleanContainer,
        showCarrusel: _showCarrusel,
        fixButtonAddProduct: _fixButtonAddProduct,
        setEstrategiaTipoBotonAgregar: _setEstrategiaTipoBotonAgregar,
        setEstrategiaAtributosHtml: _setEstrategiaAtributosHtml
    };
};
