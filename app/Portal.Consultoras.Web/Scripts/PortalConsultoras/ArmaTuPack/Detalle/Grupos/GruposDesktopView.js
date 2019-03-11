var GruposDesktopView = function() {

    var _presenter = null;

    var _elements = {
        gruposDesktop: {
            templateId: "#grupos-template",
            id: "#grupos"
        },
        seleccionadosDesktop: {
            id: "#seleccionados"
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

        $(document).on("click", "[data-delete-component]", function (e) {
            var $btn = $(e.target);
            var grupo = $btn.data("grupo");
            var cuvComponente = $btn.data("cuv-componente");
            _presenter.deleteComponente(grupo, cuvComponente);
        });
    };

    return {
        renderGrupos: _renderGrupos,
        setPresenter : _setPresenter
    };
};