"use strict";

var detalleLanzamiento = (function () {
    var _player;
    var _elements = {
        idPlantillaProductoLanding: "#producto-landing-template",
        idDivSetsProductosRelacionados: "#divOfertaProductos",
        verDetalleButtons: "[data-item-tag='verdetalle']",
        eligeTuOpcionButtons: "[data-item-tag='eligetuopcion']"
    };
    var _params = {
        videoId: "",
        descripcionResumen: ""
    };

    var _configScriptTag = function () {
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
        var cuv = _getParamValueFromQueryString("cuv");
        var campaniaId = _getParamValueFromQueryString("campaniaid");
        

        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return false;
        }

        var prod = GetProductoStorage(cuv, campaniaId);
        if (prod == null || prod == undefined || prod.CUV2 == undefined) {
            return false;
        }

        var data = new Object();
        data.CampaniaID = prod.CampaniaID;
        data.lista = new Array();
        data.lista.push(prod);

        $.each(data.lista, function (index, item) {
            item.ClaseBloqueada = $.trim(item.ClaseBloqueada);
            item.Posicion = index + 1;
        });

        SetHandlebars(_elements.idPlantillaProductoLanding, data, _elements.idDivSetsProductosRelacionados);
    }

    var _redigirAVerDetallaLanzamiento = function (event) {
        event.stopPropagation();
        
        var cadenaEstrategia = $(event.target).parents("[data-item]").find("[data-estrategia]").attr("data-estrategia");
        var estrategia = (cadenaEstrategia != "") ? JSON.parse(cadenaEstrategia) : {};

        var url = "/";
        if (isMobile()) {
            url += "mobile/";
        }
        url += "Lanzamientos/Detalle?";
        url += "cuv=" + estrategia.CUV2;
        url += "&campaniaId=" + estrategia.CampaniaID;

        location.href = url;
    };

    var _bindEvents = function () {
        $(_elements.verDetalleButtons)
            .removeAttr("onclick")
            .off("click")
            .on("click", _redigirAVerDetallaLanzamiento);
        $(_elements.eligeTuOpcionButtons)
            .removeAttr("onclick")
            .off("click")
            .on("click", _redigirAVerDetallaLanzamiento);
        
    }

    var _init = function (params) {
        var _params = $.extend(_params, params);
        _configScriptTag();
        _mostrarSetRelacionados();
        _bindEvents();
    };

    var _onPlayerStateChange = function (event) {
        if (event.data == YT.PlayerState.PLAYING) {
            rdAnalyticsModule.CompartirProducto("YTI", _player.getVideoUrl(), _params.descripcionResumen);
        }
        if (event.data == YT.PlayerState.ENDED) {
            rdAnalyticsModule.CompartirProducto("YTF", _player.getVideoUrl(), _params.descripcionResumen);
        }
    }

    var _onYouTubeIframeAPIReady = function () {
        _player = new YT.Player('player', {
            height: '415',
            width: '100%',
            videoId: videoId,
            events: {
                'onStateChange': _onPlayerStateChange
            }
        });
    }

    return {    
        init: _init,
        onYouTubeIframeAPIReady: _onYouTubeIframeAPIReady
    }
}());





