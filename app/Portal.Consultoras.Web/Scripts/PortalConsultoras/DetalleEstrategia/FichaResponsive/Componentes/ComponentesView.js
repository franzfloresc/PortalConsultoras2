var ComponenteView = function () {
    var _elements = {
        componente: {
            templateId: "#producto-componente-template",
            id: "#componente",
        }
    };

    var _renderComponente = function (componente) {
        SetHandlebars(_elements.componente.templateId, componente, _elements.componente.id);

        return true;
    };

    return {
        renderComponente: _renderComponente,
    };
};