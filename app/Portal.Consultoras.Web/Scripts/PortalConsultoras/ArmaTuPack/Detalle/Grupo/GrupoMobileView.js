var GrupoMobileView = function () {

    var _elements = {
        grupoMobile: {
            templateId: "grupo-template",
            id: "grupo"
        }
    }
    var _config = {

    };

    var _PackComponents = null;
    var _renderGrupos = function (PackComponents) {
        if (typeof PackComponents === undefined){
            return _PackComponents;
        }else{
            //todo:implement render method.
            SetHandlebars(_elements.listaOpciones.templateId, PackComponents, _elements.listaOpciones.id);
        }
    };

    return {
        renderGrupos : _renderGrupos,
    };
};