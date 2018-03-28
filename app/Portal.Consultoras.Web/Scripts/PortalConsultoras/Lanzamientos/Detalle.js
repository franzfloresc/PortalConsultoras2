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

    var _bindEvents = function () {

    }

    var _init = function (params) {
        var _params = $.extend(_params, params);
        _configScriptTag();
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





