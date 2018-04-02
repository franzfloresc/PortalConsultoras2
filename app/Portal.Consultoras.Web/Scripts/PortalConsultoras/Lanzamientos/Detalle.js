"use strict";

var detalleLanzamiento = (function () {
    var _player;
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
        var campania = _getParamValueFromQueryString("campaniaid");
        

        if (cuv == "" || campania == "" || campania == "0") {
            return false;
        }

        var prod = GetProductoStorage(cuv, campania);
        if (prod == null || prod == undefined || prod.CUV2 == undefined) {
            return false;
        }

        var obj = new Object();
        obj.CampaniaID = prod.CampaniaID;
        obj.lista = new Array();
        obj.lista.push(prod);

        $.each(obj.lista, function (index, item) {
            item.ClaseBloqueada = $.trim(item.ClaseBloqueada);
            item.Posicion = index + 1;
        });

        SetHandlebars("#producto-landing-template", obj, "#divOfertaProductos");
        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

        $("#divOfertaProductos").find('[data-item-accion="verdetalle"]').removeAttr("onclick");
        $("#divOfertaProductos").find('[data-item-accion="verdetalle"]').removeAttr("data-item-accion");

        $(".ver_detalle_carrusel").parent().parent().attr("onclick", "");
        $(".ver_detalle_carrusel").remove();
    }

    var _bindEvents = function () {

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





