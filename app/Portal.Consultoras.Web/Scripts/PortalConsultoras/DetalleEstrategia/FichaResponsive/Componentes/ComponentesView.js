var ComponenteView = function () {
    var _elements = {
        componentes: {
            templateId: "#componente-estrategia-template",
            id: "#componentes",
        }
    };

    var _renderComponente = function (componente) {
        SetHandlebars(_elements.componentes.templateId, componente, _elements.componentes.id);

        return true;
    };

    return {
        renderComponente: _renderComponente,
    };
};