var GruposDesktopView = function() {

    var _presenter = null;

    var _elements = {
        gruposDesktop: {
            templateId: "#grupos-template",
            id: "#grupos"
        }
    };

    var _setPresenter = function(presenter){
        _presenter = presenter;
    };

    var _renderGrupos = function(packComponents) {
        SetHandlebars(_elements.gruposDesktop.templateId, packComponents, _elements.gruposDesktop.id);
        $(_elements.gruposDesktop.id).on("click","[data-add-component]",function(e){
            var $btn = $(e.target);
            var cuvGrupo = $btn.data("cuv-grupo");
            var cuvComponente = $btn.data("cuv-componente");
            _presenter.addComponente(cuvGrupo,cuvComponente);
        });
    };

    return {
        renderGrupos: _renderGrupos,
        setPresenter : _setPresenter
    };
};