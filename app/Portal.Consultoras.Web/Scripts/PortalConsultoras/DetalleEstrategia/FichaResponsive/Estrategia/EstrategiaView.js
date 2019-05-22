var EstrategiaView = function () {
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
        },
        tabsComponente: {
            templateId: "#tabs-ficha-enriquecida-template",
            id: "#contenedor-tabs-ficha-enriquecida",
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
        if(estrategia.isMobile){
            backgroundImg = estrategia.TipoEstrategiaDetalle.ImgFichaFondoMobile || "";
        }

        // background
        $(".ficha_detalle").css("background", backgroundImg);
        $(".condenedor_detalle").css("background", backgroundImg);

        // stamp
        // $(".ficha_detalle").css("background", backgroundImg);
        // $(".condenedor_detalle").css("background", backgroundImg);

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

    return {
        setPresenter: _setPresenter,
        renderBreadcrumbs : _renderBreadcrumbs,
        renderEstrategia : _renderEstrategia,
        renderBackgroundAndStamp: _renderBackgroundAndStamp,
        renderReloj: _renderReloj,
        renderRelojStyle: _renderRelojStyle,
        renderAgregar: _renderAgregar,
        showTitleAgregado: _showTitleAgregado
    };
};