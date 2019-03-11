var SeleccionadosView = function () {
    var _presenter = null;

    var _elements = {
        seleccionados: {
            templateId: "#seleccionados-template",
            id: "#seleccionados"
        }
    };

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _renderSeleccionados = function (packComponents) {
        SetHandlebars(_elements.seleccionados.templateId, packComponents, _elements.seleccionados.id);
        // $(_elements.grupoDesktop.id).on("click","[data-add-component]",function(e){
        //     var $btn = $(e.target);
        //     var cuvGrupo = $btn.data("cuv-grupo");
        //     var cuvComponente = $btn.data("cuv-componente");
        //     _presenter.addComponente(cuvGrupo,cuvComponente);
        // });
    };

    return {
        renderSeleccionados: _renderSeleccionados,
        setPresenter: _setPresenter
    };
};