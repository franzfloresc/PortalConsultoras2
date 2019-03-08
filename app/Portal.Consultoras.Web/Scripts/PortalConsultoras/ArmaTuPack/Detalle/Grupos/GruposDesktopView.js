var GruposDesktopView = function () {

    var _config = {

    };

    var _elements = {
        grupoDesktop: {
            templateId: "#grupo-template",
            id: "#grupo"
        }
    };

    var _packComponents = null;
    var _renderGrupos = function (packComponents) {
        if (typeof packComponents === undefined) {
            return _packComponents;
        } else {
            //todo:implement render method.
            SetHandlebars(_elements.grupoDesktop.templateId, packComponents, _elements.grupoDesktop.id);
        }
    };

    return {
        renderGrupos : _renderGrupos,
    };
};