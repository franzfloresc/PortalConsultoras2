var GruposView = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.gruposContainerId === "undefined" || config.gruposContainerId === null) throw "config.gruposContainerId is null or undefined";

    var _config = {
        generalModule: config.generalModule
    };

    var _presenter = null;

    var _elements = {
        grupos: {
            templateId: "#grupos-template",
            id: config.gruposContainerId || "",
            attrCarruselContainer: "[data-carrusel-container]",
            headers: "[data-group-header]",
        },
        componente: {
            quantity: function (cuvComponente) {
                return "[data-quantity-" + cuvComponente + "]";
            },
            quantitySelector: function (cuvComponente) {
                return "[data-selector-cantidad-" + cuvComponente + "]";
            },
            chooseIt: function (cuvComponente) {
                return "[data-eligelo-" + cuvComponente + "]";
            }
        },
        grupo: {
            optionsLabel: function (grupo) {
                return "[data-options-label-" + grupo + "]";
            },
            readyLabel: function (grupo) {
                return "[data-ready-label-" + grupo + "]";
            },
            blockChooseIt: function (grupo, cuvComponente) {
                cuvComponente = cuvComponente || "";
                var selector = "[data-block-eligelo-" + grupo + "]";
                if (cuvComponente !== "") {
                    selector = selector + "[data-cuv-componente!=" + cuvComponente + "]";
                }
                return selector;
            },
            blockQuantitySelector: function (grupo) {
                return "[data-block-selector-cantidad-" + grupo + "]";
            },
            item: function (grupo) {
                return "[data-group-item][data-grupo=" + grupo + "]";
            },
            header: function (grupo) {
                return "[data-group-header][data-grupo=" + grupo + "]";
            },
            body: function (grupo) {
                return "[data-group-body][data-grupo=" + grupo + "]";
            }
        }
    };

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _collapseGroup = function (grupo) {
                                      
        //Analytics ATP Boton Descontraer
        if (!(typeof AnalyticsPortalModule === 'undefined')) {
            var codigoubigeoportal = JSON.parse($("#data-estrategia").attr("data-estrategia")).CodigoUbigeoPortal + "";
            if (codigoubigeoportal !== "") {
                var label = $("[data-group-header][data-grupo=" + grupo + "]").find("h3").text();
                
                AnalyticsPortalModule.MarcaPromotionClickArmaTuPack(codigoubigeoportal, label, "Clic en Categoría");
            }
        } 

        if (grupo === undefined ||
            grupo === null ||
            $.trim(grupo) === "") return;

        $(_elements.grupo.header(grupo)).addClass("active");
        $(_elements.grupo.body(grupo)).css("display", "block");
    };

    var _uncollapseGroup = function (grupo) {
        //Analytics ATP Boton Contraer
        
        if (!(typeof AnalyticsPortalModule === 'undefined')) {
            var codigoubigeoportal = JSON.parse($("#data-estrategia").attr("data-estrategia")).CodigoUbigeoPortal + "";
            if (codigoubigeoportal !== "") {
                var label = $("[data-group-header][data-grupo=" + grupo + "]").find("h3").text();

                AnalyticsPortalModule.MarcaPromotionClickArmaTuPack(codigoubigeoportal, label, "Clic en Categoría");
            }
        }

        if (grupo === undefined ||
            grupo === null ||
            $.trim(grupo) === "") return;

        $(_elements.grupo.header(grupo)).removeClass("active");
        $(_elements.grupo.body(grupo)).css("display", "none");
       
    };

    var _renderGrupos = function (packComponents) {
        SetHandlebars(_elements.grupos.templateId, packComponents, _elements.grupos.id);
        $(_elements.grupos.id).show();

        $(_elements.grupos.id).on("click", _elements.grupos.headers, function (e) {
            var $header = $(e.target);
            var codigoGrupo = $header.data("grupo");
            if ($(_elements.grupo.body(codigoGrupo)).is(":visible") == true) {
                _uncollapseGroup(codigoGrupo);
            } else {
                _collapseGroup(codigoGrupo);
            }
        });

        $(_elements.grupos.id).on("click", "[data-add-component]", function (e) {
              
            var $btn = $(e.target);
            var codigoGrupo = $btn.data("grupo");
            var cuvComponente = $btn.data("cuv-componente");
            _presenter.addComponente(codigoGrupo, cuvComponente);
             
        });

        $(_elements.grupos.id).on("click", "[data-delete-component]", function (e) {
             
            var $btn = $(e.target);
            var codigoGrupo = $btn.data("grupo");
            var cuvComponente = $btn.data("cuv-componente");
            _presenter.deleteComponente(codigoGrupo, cuvComponente);

            
        });

        var slickSettings = {
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false,
            infinite: false,
            arrows: true,
            prevArrow:
                "<a id=\"opciones-seleccionadas-prev\" class=\"flecha_ofertas-tipo prev\" style=\"left:-5%; text-align:left;display:none;\">" +
                "<img src=\"" + baseUrl + "Content/Images/Esika/previous_ofertas_home.png\")\" alt=\"\" />" +
                "</a>",
            nextArrow:
                "<a id=\"opciones-seleccionadas-next\" class=\"flecha_ofertas-tipo\" style=\"display: block; right:-5%; text-align:right;display:none;\">" +
                "<img src=\"" + baseUrl + "Content/Images/Esika/next.png\")\" alt=\"\" />" +
                "</a>"
        };
        $(_elements.grupos.attrCarruselContainer).slick(slickSettings);
    };

    var _showQuantitySelector = function (cuvComponent, quantity) {
        if (cuvComponent === undefined ||
            cuvComponent === null ||
            $.trim(cuvComponent) === "") return;

        $(_elements.componente.chooseIt(cuvComponent)).hide();
        $(_elements.componente.quantitySelector(cuvComponent)).show();
        $(_elements.componente.quantity(cuvComponent)).val(quantity);
    };

    var _showChooseIt = function (cuvComponent) {
        if (cuvComponent === undefined ||
            cuvComponent === null ||
            $.trim(cuvComponent) === "") return;

        $(_elements.componente.quantitySelector(cuvComponent)).hide();
        $(_elements.componente.quantity(cuvComponent)).val(1);

        $(_elements.componente.chooseIt(cuvComponent)).removeClass("active").text("Elígelo").show();
    };

    var _showChosen = function (cuvComponent) {
        if (cuvComponent === undefined ||
            cuvComponent === null ||
            $.trim(cuvComponent) === "") return;

        $(_elements.componente.quantitySelector(cuvComponent)).hide();
        $(_elements.componente.quantity(cuvComponent)).val(1);

        $(_elements.componente.chooseIt(cuvComponent)).addClass("active").text("Elegido").show();
    };

    var _showGroupOptions = function (codigoGrupo) {
        if (codigoGrupo === undefined ||
            codigoGrupo === null ||
            $.trim(codigoGrupo) === "") return;

        $(_elements.grupo.optionsLabel(codigoGrupo)).show();
    };

    var _hideGroupOptions = function (codigoGrupo) {
        if (codigoGrupo === undefined ||
            codigoGrupo === null ||
            $.trim(codigoGrupo) === "") return;

        $(_elements.grupo.optionsLabel(codigoGrupo)).hide();
    };

    var _showGroupReady = function (codigoGrupo) {
        if (codigoGrupo === undefined ||
            codigoGrupo === null ||
            $.trim(codigoGrupo) === "") return;

        $(_elements.grupo.readyLabel(codigoGrupo)).show();

    };

    var _hideGroupReady = function (codigoGrupo) {
        if (codigoGrupo === undefined ||
            codigoGrupo === null ||
            $.trim(codigoGrupo) === "") return;

        $(_elements.grupo.readyLabel(codigoGrupo)).hide();

    };

    var _blockGroup = function (codigoGrupo, cuvComponente) {
        if (codigoGrupo === undefined ||
            codigoGrupo === null ||
            $.trim(codigoGrupo) === "") return;

        $(_elements.grupo.blockChooseIt(codigoGrupo, cuvComponente)).removeClass("active").addClass("disable");
        $(_elements.grupo.blockQuantitySelector(codigoGrupo)).addClass("disable");
    };

    var _unblockGroup = function (codigoGrupo, cuvComponente) {
        if (codigoGrupo === undefined ||
            codigoGrupo === null ||
            $.trim(codigoGrupo) === "") return;


        $(_elements.grupo.blockChooseIt(codigoGrupo, cuvComponente)).removeClass("disable");
        $(_elements.grupo.blockQuantitySelector(codigoGrupo)).removeClass("disable");
    };

    var _addGroupHighlight = function (grupo) {
        if (grupo === undefined ||
            grupo === null ||
            $.trim(grupo) === "") return;

        $(_elements.grupo.item(grupo)).addClass("error");
    };

    var _removeGroupHighlight = function (grupo) {
        if (grupo === undefined ||
            grupo === null ||
            $.trim(grupo) === "") return;

        $(_elements.grupo.item(grupo)).removeClass("error");
    };

    return {
        renderGrupos: _renderGrupos,
        setPresenter: _setPresenter,
        showChooseIt: _showChooseIt,
        showChosen: _showChosen,
        showQuantitySelector: _showQuantitySelector,
        showGroupOptions: _showGroupOptions,
        hideGroupOptions: _hideGroupOptions,
        showGroupReady: _showGroupReady,
        hideGroupReady: _hideGroupReady,
        blockGroup: _blockGroup,
        unblockGroup: _unblockGroup,
        uncollapseGroup: _uncollapseGroup,
        addGroupHighlight: _addGroupHighlight,
        removeGroupHighlight: _removeGroupHighlight
    };
};