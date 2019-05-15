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

    var _render = function (estrategia) {
        console.log(estrategia);
        SetHandlebars(_elements.breadcrumbs.templateId, estrategia, _elements.breadcrumbs.id);
        SetHandlebars(_elements.imagenEstrategia.templateId, estrategia, _elements.imagenEstrategia.id);
        SetHandlebars(_elements.estrategia.templateId, estrategia, _elements.estrategia.id);
        // todo : validar si tiene un solo componente
        SetHandlebars(_elements.tabsComponente.templateId, estrategia, _elements.tabsComponente.id);
        //SetHandlebars(_elements.compartirEstrategia.templateId, estrategia, _elements.compartirEstrategia.id);
        //
        return true;
    };

    return {
        setPresenter: _setPresenter,
        render: _render
    };
};