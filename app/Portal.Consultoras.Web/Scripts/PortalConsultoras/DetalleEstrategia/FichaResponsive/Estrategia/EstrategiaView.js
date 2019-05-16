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


    
    return {
        setPresenter: _setPresenter,
        renderBreadcrumbs : _renderBreadcrumbs,
        renderEstrategia : _renderEstrategia,
        renderBackgroundAndStamp : _renderBackgroundAndStamp,
    };
};