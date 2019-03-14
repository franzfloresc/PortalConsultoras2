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
        },
        tooltip : {
            id: "[data-tooltip-component]",
        }
    };

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _disableAgregar = function () {
        $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.claseBloqueada);
        $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.deshabilitado);
    };

    var _enableAgregar = function () {
        $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.claseBloqueada);
        $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.deshabilitado);
    };

    var _refreshSeleccionados = function (packComponents) {
        SetHandlebars(_elements.seleccionados.templateId, packComponents, _elements.seleccionados.id);

        var slickSettings = {
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false,
            arrows: true,
            infinite: false
        };

        $(_elements.seleccionados.attrCarruselContainer).slick(slickSettings);

        if (packComponents.componentesSeleccionados.length > slickSettings.slidesToShow) {
            var lastSlideIndex = cantidadSeleccionados - slickSettings.slidesToShow;
            $(_elements.divOpcionesSeleccionadas.id).slick("slickGoTo", lastSlideIndex);
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

        $(_elements.btnAgregar.id).on("click", function (e) {
            _presenter.addPack();
        });
    };

    var _hideTooltip = function () {
        $(_elements.tooltip.id).hide();
    };

    var _showTooltip = function () {
        $(_elements.tooltip.id).show();
    };

    return {
        renderSeleccionados: _renderSeleccionados,
        refreshSeleccionados: _refreshSeleccionados,
        setPresenter: _setPresenter,
        disableAgregar: _disableAgregar,
        enableAgregar: _enableAgregar,
        hideTooltip: _hideTooltip,
        showTooltip: _showTooltip,
    };
};


