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

    var _refreshSeleccionados = function (packComponents) {
        SetHandlebars(_elements.seleccionados.templateId, packComponents, _elements.seleccionados.id);

        //$('#seleccionados .Select_Group li:last').hide();

        var slickSettings = {
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false,
            arrows: true,
            infinite: false
        };

        $(_elements.seleccionados.attrCarruselContainer).slick(slickSettings);
    };

    var _renderSeleccionados = function (packComponents) {

        _refreshSeleccionados(packComponents);

        $(_elements.seleccionados.id).on("click", "[data-delete-component]", function (e) {
            var $btn = $(e.target);
            var grupoComponente = $btn.data("grupo-componente");
            var cuvComponente = $btn.data("cuv-componente");
            var indiceComponente = $btn.data("indice-componente");
            _presenter.deleteComponente(grupoComponente, cuvComponente, indiceComponente);
        });
    };

    return {
        renderSeleccionados: _renderSeleccionados,
        refreshSeleccionados: _refreshSeleccionados,
        setPresenter: _setPresenter
    };
};