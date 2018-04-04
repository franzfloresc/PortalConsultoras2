var detalleLanzamiento = (function () {
    "use strict";
    var _player;

    var _elements = {
        idPlantillaProductoLanding: "#producto-landing-template",
        divCarruselSetsProductosRelacionados: "#divOfertaProductos",
        divContenidoProductoDesktop: "[data-item-tag='contenido']",
        verDetalleButtons: "[data-item-tag='verdetalle']",
        eligeTuOpcionButtons: "[data-item-tag='eligetuopcion']",
        divSetsProductosRelacionados: "#set_relacionados"
    };
    
    var _params = {
        videoId: "",
        descripcionResumen: ""
    };

    var _configYouTubeScriptTag = function () {
        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    };

    var _getParamValueFromQueryString = function (queryStringName) {
        queryStringName = queryStringName || '';
        queryStringName = queryStringName.toLowerCase();
        var queryStringValue = '';
        var stringUrlParameters = location.href.toLowerCase().split('?');
        if (stringUrlParameters.length > 1 && queryStringName != '') {
            var arrParameterString = stringUrlParameters[1].split('&');
            $.each(arrParameterString, function (index, stringParameter) {
                var items = stringParameter.split('=');
                var parameterName = $.trim(items[0]);
                var parameterValue = $.trim(items[1]);
                if (parameterName == queryStringName) {
                    queryStringValue = parameterValue;
                    return false;
                }
            });
        }
        return queryStringValue;
    };

    var _mostrarSetRelacionados = function () {
        $(_elements.divSetsProductosRelacionados).fadeOut();

        var platform = !isMobile() ? 'desktop':'mobile';
        var cuv = _getParamValueFromQueryString("cuv");
        var campaniaId = _getParamValueFromQueryString("campaniaid");
        
        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return false;
        }

        var str = LocalStorageListado(lsListaRD + campaniaId, '', 1) || '';

        if (str === '') {
            return false;
        }

        var data = {
            lista: JSON.parse(str).response.listaLan
        };

        var setRelacionados = [];
        var codigoProducto = '';
        $.each(data.lista, function (index, lanzamiento) {
            if (cuv === lanzamiento.CUV2) {
                codigoProducto = lanzamiento.CodigoProducto;
                return false;
            }
        });

        $.each(data.lista, function (index, lanzamiento) {
            if (cuv != lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                setRelacionados.push(lanzamiento);
            }
        });
        if (setRelacionados.length == 0) {
            return false;
        }
        data.lista = setRelacionados;
        SetHandlebars(_elements.idPlantillaProductoLanding, data, _elements.divCarruselSetsProductosRelacionados);
        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

        var slickArrows = {
            'mobile': {
                prev: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-left:-12%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-right:-12%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>', 
                next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        $(_elements.divCarruselSetsProductosRelacionados + '.slick-initialized').slick('unslick');
        $(_elements.divCarruselSetsProductosRelacionados).not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            centerMode: false,
            centerPadding: '0px',
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 270,
            pantallaPedido: false,
            prevArrow: slickArrows[platform].prev,
            nextArrow: slickArrows[platform].next,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 900,
                    settings: { slidesToShow: 2, slidesToScroll: 1 }
                },
                {
                    breakpoint: 600,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        });

        $(_elements.divSetsProductosRelacionados).fadeIn();
    };

    var _redigirAVerDetallaLanzamiento = function (event) {
        event.stopPropagation();
        
        var cadenaEstrategia = $(event.target).closest("[data-item]").find("[data-estrategia]").attr("data-estrategia");
        var estrategia = (cadenaEstrategia != "") ? JSON.parse(cadenaEstrategia) : {};
        if (EstrategiaGuardarTemporal(estrategia)) {
            var url = "/";
            if (isMobile()) {
                url += "mobile/";
            }
            url += "Lanzamientos/Detalle?";
            url += "cuv=" + estrategia.CUV2;
            url += "&campaniaId=" + estrategia.CampaniaID;

            location.href = url;
        }
    };

    var _bindEvents = function () {
        if(!isMobile()){
            $(_elements.divContenidoProductoDesktop)
            .removeAttr("onclick")
            .off("click");
        }
        $(_elements.verDetalleButtons)
            .removeAttr("onclick")
            .off("click")
            .on("click", _redigirAVerDetallaLanzamiento);
        $(_elements.eligeTuOpcionButtons)
            .removeAttr("onclick")
            .off("click")
            .on("click", _redigirAVerDetallaLanzamiento);
        
    };

    var _init = function (params) {
        var _params = $.extend(_params, params);
        _configYouTubeScriptTag();
        _mostrarSetRelacionados();
        _bindEvents();
    };

    var _onYouTubePlayerStateChange = function (event) {
        if (event.data == YT.PlayerState.PLAYING) {
            rdAnalyticsModule.CompartirProducto("YTI", _player.getVideoUrl(), _params.descripcionResumen);
        }
        if (event.data == YT.PlayerState.ENDED) {
            rdAnalyticsModule.CompartirProducto("YTF", _player.getVideoUrl(), _params.descripcionResumen);
        }
    };

    var _onYouTubeIframeAPIReady = function () {
        _player = new YT.Player('player', {
            height: '415',
            width: '100%',
            videoId: videoId,
            events: {
                'onStateChange': _onYouTubePlayerStateChange
            }
        });
    };

    return {    
        init: _init,
        onYouTubeIframeAPIReady: _onYouTubeIframeAPIReady
    };
}());





