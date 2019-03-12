var GruposDesktopView = function(config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    
    var _config = {
        generalModule: config.generalModule
    };

    var _presenter = null;

    var _elements = {
        grupos: {
            templateId: "#grupos-template",
            id: "#grupos",
            attrCarruselContainer: "[data-carrusel-container]"
        },
        componente: {
            quantitySelector : function(cuv){ 
                return "[data-selector-cantidad-" + cuv + "]";
            },
            chooseIt : function(cuv){
                return "[data-eligelo-" + cuv + "]"; 
            }
        }
    };

    var _setPresenter = function(presenter){
        _presenter = presenter;
    };

    var _renderGrupos = function(packComponents) {
        SetHandlebars(_elements.grupos.templateId, packComponents, _elements.grupos.id);

        $(_elements.grupos.id).on("click","[data-add-component]",function(e){
            var $btn = $(e.target);
            var cuvGrupo = $btn.data("cuv-grupo");
            var cuvComponente = $btn.data("cuv-componente");
            _presenter.addComponente(cuvGrupo,cuvComponente);
        });

        $(_elements.grupos.id).on("click","[data-delete-component]",function(e){
            var $btn = $(e.target);
            var cuvGrupo = $btn.data("cuv-grupo");
            var cuvComponente = $btn.data("cuv-componente");
            _presenter.deleteComponente(cuvGrupo,cuvComponente);
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

        $(_elements.grupos.attrCarruselContainer).slick(slickSettings);
    };

    var _showQuantitySelector = function(cuvComponent){
        if(cuvComponent === undefined || 
            cuvComponent === null || 
            $.trim(cuvComponent) ==="" ) return;

        $(_elements.componente.chooseIt(cuvComponent)).hide();
        $(_elements.componente.quantitySelector(cuvComponent)).show();

    };

    var _showChooseIt = function(cuvComponent){
        if(cuvComponent === undefined || 
            cuvComponent === null || 
            $.trim(cuvComponent) ==="" ) return;


            alert($(_elements.componente.quantitySelector(cuvComponent)).length);
            alert($(_elements.componente.chooseIt(cuvComponent)).length);
        $(_elements.componente.quantitySelector(cuvComponent)).hide();
        $(_elements.componente.chooseIt(cuvComponent)).show();
    };

    return {
        renderGrupos: _renderGrupos,
        setPresenter : _setPresenter,
        showQuantitySelector : _showQuantitySelector,
        showChooseIt : _showChooseIt,
    };
};