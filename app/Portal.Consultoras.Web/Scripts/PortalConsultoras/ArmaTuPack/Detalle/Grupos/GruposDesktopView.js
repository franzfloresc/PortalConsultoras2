var GruposDesktopView = function(config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    
    var _config = {
        generalModule: config.generalModule
    };

    var _presenter = null;

    var _elements = {
        gruposDesktop: {
            templateId: "#grupos-template",
            id: "#grupos",
            attrCarruselContainer: "[data-carrusel-container]"
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

        var slickSettings = {
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false,
            arrows: false,
            infinite : false
        };
        if (!_config.generalModule.isMobile()) {
            slickSettings.arrows = true;
            slickSettings.prevArrow =
                "<a id=\"opciones-seleccionadas-prev\" class=\"flecha_ofertas-tipo prev\" style=\"left:-5%; text-align:left;display:none;\">" +
                    "<img src=\"" + baseUrl + "Content/Images/Esika/previous_ofertas_home.png\")\" alt=\"\" />" +
                "</a>";
            slickSettings.nextArrow =
                "<a id=\"opciones-seleccionadas-next\" class=\"flecha_ofertas-tipo\" style=\"display: block; right:-5%; text-align:right;display:none;\">" +
                    "<img src=\"" + baseUrl + "Content/Images/Esika/next.png\")\" alt=\"\" />" +
                "</a>";
        } else {
            slickSettings.slidesToShow = 5;
        }

        $(_elements.gruposDesktop.attrCarruselContainer).slick(slickSettings);
    };

    return {
        renderGrupos: _renderGrupos,
        setPresenter : _setPresenter
    };
};