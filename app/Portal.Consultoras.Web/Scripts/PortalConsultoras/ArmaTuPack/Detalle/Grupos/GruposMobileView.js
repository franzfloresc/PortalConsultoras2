var GruposMobileView = function () {

    var _config = {

    };

    var _elements = {
        grupoMobile: {
            templateId: "#grupo-template",
            id: "#grupo"
        }
    };

    var _packComponents = null;
    var _renderGrupos = function (packComponents) {
        if (typeof packComponents === undefined){
            return _packComponents;
        }else{
            //todo:implement render method.
            SetHandlebars(_elements.grupoMobile.templateId, packComponents, _elements.grupoMobile.id);
        }
    };

    return {
        renderGrupos : _renderGrupos,
    };
};