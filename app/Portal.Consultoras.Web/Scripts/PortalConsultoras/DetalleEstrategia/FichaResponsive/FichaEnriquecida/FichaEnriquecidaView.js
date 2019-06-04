var FichaEnriquecidaView = function () {

    var _elements = {
        tabsComponente: {
            templateId: "#tabs-ficha-enriquecida-template",
            id: "#contenedor-tabs-ficha-enriquecida",
            contenedorPopup: "#popup_tabs_ficha_enriquecida_contenedor"
        },
        popup: {
            templateId: "#popup-ficha-enriquecida-responsive",
            id: "#modal_popup_ficha_enriquecida",
            contenedor: "#contenedor_popup_ficha_enriquecida"
        },
        carruselVideo: {
            id: "#carrusel-video"
        }
    };

    var _util = {
        setCarrusel: function (id) {
            $(id).slick({
                infinite: false,
                speed: 300,
                centerMode: false,
                variableWidth: true,
                slidesToShow: 3,
                slidesToScroll: 1,
                prevArrow:
                    "<a id=\"opciones-seleccionadas-prev\" class=\"flecha_ofertas-tipo prev\" style=\"left:-5%; text-align:left;display:none;\">" +
                    "<img src=\"" + baseUrl + "Content/Images/Esika/previous_ofertas_home.png\")\" alt=\"\" />" +
                    "</a>",
                nextArrow:
                    "<a id=\"opciones-seleccionadas-next\" class=\"flecha_ofertas-tipo\" style=\"display: block; right:-5%; text-align:right;display:none;\">" +
                    "<img src=\"" + baseUrl + "Content/Images/Esika/next.png\")\" alt=\"\" />" +
                    "</a>",
                responsive: [
                    {
                        breakpoint: 768, settings: { slidesToShow: 1, slidesToScroll: 1, dots: true }
                    }
                ]
            });
        },
        setYoutubeId: function () {
            $.each($("[data-youtube-key]"), function (i, ytEle) {
                var idyt = $(ytEle).attr('id') + "-" + i;
                $(ytEle).attr('id', idyt);
            });
        },
        setYoutubeApi: function () {
            try {
                if (youtubeModule) {
                    youtubeModule.Inicializar();
                    window.onYouTubeIframeAPIReady();
                }
            } catch (e) {
                console.log('setYoutubeApi => ', e);
            }
        }
    }

    var _renderFichaEnriquecida = function (componente, popup) {
        var contenedor = popup ? _elements.tabsComponente.contenedorPopup : _elements.tabsComponente.id;
        SetHandlebars(_elements.tabsComponente.templateId, componente, contenedor);
        _util.setCarrusel(_elements.carruselVideo.id);
        _util.setYoutubeId();
        _util.setYoutubeApi();
        return true;
    };

    var _showPopup = function (data) {
        SetHandlebars(_elements.popup.templateId, data, _elements.popup.contenedor);
        _renderFichaEnriquecida(data, true);
        $("body").css("overflow", "hidden");
        $(_elements.popup.id).show();
        return true;
    };

    var _hidePopup = function () {
        $("body").css("overflow", "auto");
        $(_elements.popup.id).hide();
        return true;
    };

    return {
        renderFichaEnriquecida: _renderFichaEnriquecida,
        showPopup: _showPopup,
        hidePopup: _hidePopup
    };
}