var CabeceraView = function () {
    var _config = {

    };

    var _elements = {
        cabecera: {
            templateId: "#cabecera-template",
            id: "#cabecera",
        },
    };
    
    var _presenter = null;

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _renderTitle = function (packComponents) {
        SetHandlebars(_elements.cabecera.templateId, packComponents, _elements.cabecera.id);
        $(_elements.cabecera.id).show("fade", 1000);
    };

    return {
        setPresenter: _setPresenter,
        renderTitle: _renderTitle
    };
};