var CabeceraView = function () {

    var _elements = {
        cabecera: {
            templateId: "#cabecera-template",
            id: "#cabecera",
        },
    };

    var _renderTitle = function (packComponents) {
        SetHandlebars(_elements.cabecera.templateId, packComponents, _elements.cabecera.id);
        $(_elements.cabecera.id).show("fade", 1000);
    };

    return {
        renderTitle: _renderTitle
    };
};