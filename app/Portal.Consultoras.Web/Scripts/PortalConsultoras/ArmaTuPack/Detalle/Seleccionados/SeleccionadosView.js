var SeleccionadosView = function () {

    var _presenter = null;

    var _elements = {
        seleccionados: {
            templateId: "#seleccionados-template",
            id: "#seleccionados",
            attrCarruselContainer: "[data-carruselseleccionados-container]"
        },
        btnAgregar: {
            id: "#btnAgregalo",
            claseBloqueada: "btn_desactivado_general",
            deshabilitado: "disable"
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

        if (packComponents.componentesNoSeleccionados.length == 0) {
            $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.claseBloqueada);
            $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.deshabilitado);
        } else {
            $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.claseBloqueada);
            $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.deshabilitado);
        }
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