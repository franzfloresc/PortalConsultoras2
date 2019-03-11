var SeleccionadosView = function () {

    var _presenter = null;

    var _elements = {
        seleccionados: {
            templateId: "#seleccionados-template",
            id: "#seleccionados",
            attrCarruselContainer: "[data-carruselseleccionados-container]"
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

        //$('#seleccionados .Select_Group li:last').hide();

        var slickSettings = {
            slidesToShow: 10,
            slidesToScroll: 1,
            autoplaySpeed: 2000
        };

        $(_elements.seleccionados.attrCarruselContainer).slick(slickSettings);
    };

    return {
        renderSeleccionados: _renderSeleccionados,
        setPresenter: _setPresenter
    };
};