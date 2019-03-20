var SeleccionadosView = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.seleccionadosContainerId === "undefined" || config.seleccionadosContainerId === null) throw "config.seleccionadosContainerId is null or undefined";

    var _presenter = null;

    var _elements = {
        seleccionados: {
            templateId: "#seleccionados-template",
            id: config.seleccionadosContainerId || "",
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
        $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.claseBloqueada);
        $(_elements.btnAgregar.id).addClass(_elements.btnAgregar.deshabilitado);
    };

    var _enableAgregar = function () {
        $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.claseBloqueada);
        $(_elements.btnAgregar.id).removeClass(_elements.btnAgregar.deshabilitado);
    };

    var _refreshSeleccionados = function (packComponents) {
        SetHandlebars(_elements.seleccionados.templateId, packComponents, _elements.seleccionados.id);

        var slickSettings = {
            slidesToShow: 6,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false,
            arrows: true,
            infinite: false,
            responsive:[
                {
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 4,
                    }
                }
            ]
        };

        $(_elements.seleccionados.attrCarruselContainer).slick(slickSettings);

        if (packComponents.componentesSeleccionados.length > slickSettings.slidesToShow) {
            var lastSlideIndex = packComponents.componentesSeleccionados.length - slickSettings.slidesToShow;
            $(_elements.seleccionados.attrCarruselContainer).slick("slickGoTo", lastSlideIndex);
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

        $(_elements.seleccionados.id).on("click",_elements.btnAgregar.id, function (e) {
            _presenter.addPack();
        });

        $(window).scroll(function () {

            var scrollTop = $(this).scrollTop();

            if (scrollTop > 230) {
                $(".Select_ArmaTuPack").addClass("Select_fixed");
                $(".Select_ArmaTuPack").fadeIn();
            }
            else {
                $(".Select_ArmaTuPack").removeClass("Select_fixed");
                $(".Select_ArmaTuPack").removeAttr('style');
            }
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


