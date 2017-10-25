var Analytics = function (config) {
    var _config = { listPaisAnalytics: config.listPaisAnalytics || [] };
    var _paisIso = null;
    var _listImagenAnalyticsId = [], _listScriptAnalyticsId = [], _callingScriptAnalytics = false;
    var _listImagenPixelId = [];

    var _crearImagenAnalyticsWithId = function (id) {
        if ($.inArray(id, _listImagenAnalyticsId) > -1) return;

        var element = $('<img>');
        element.attr('height', '1').attr('width', '1').attr('alt', '');
        element.attr('src', '//googleads.g.doubleclick.net/pagead/viewthroughconversion/' + id + '/?guid=ON&amp;script=0');
        element.css('border-style', 'none');
	
        var parent = $('#div-analytics-image');
        parent.append(element);
        _listImagenAnalyticsId.push(id);
    }
    var _addListScriptAnalytics = function (listId) {
        _listScriptAnalyticsId = $.merge(_listScriptAnalyticsId, listId);
        _invocarScriptAnalytics();
    }
    var _invocarScriptAnalytics = function () {
        if (_listScriptAnalyticsId.length == 0 || _callingScriptAnalytics == true) return;

        var google_conversion_id = _listScriptAnalyticsId[0];

        _callingScriptAnalytics = true;
        $.getScript("//www.googleadservices.com/pagead/conversion.js").done(function() {
            console.log(_listScriptAnalyticsId.shift());
            _callingScriptAnalytics = false;
            _invocarScriptAnalytics();
        });
    }
    
    var _crearImagenPixelWithId = function (id) {
        if ($.inArray(id, _listImagenPixelId) > -1) return;

        var element = $('<img>');
        element.attr('height', '1').attr('width', '1');
        element.attr('src', 'https://www.facebook.com/tr?id=' + id + '&ev=PageView&noscript=1');
        element.css('display', 'none');

        var parent = $('#noscript-pixel-image');
        parent.append(element);
        _listImagenPixelId.push(id);
    }
    var _functionPixelFacebook = function () {
        !function (f, b, e, v, n, t, s) {
            if (f.fbq) return;

            n = f.fbq = function () { n.callMethod ? n.callMethod.apply(n, arguments) : n.queue.push(arguments) };
            if (!f._fbq) f._fbq = n;

            n.push = n;
            n.loaded = !0;
            n.version = '2.0';
            n.queue = [];

            t = b.createElement(e);
            t.async = !0;
            t.src = v;

            s = b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t, s)
        }(window, document, 'script', 'https://connect.facebook.net/en_US/fbevents.js');
    }
    var _invocarScriptPixel = function (id) {
        window.fbq = window._fbq = null;
        _functionPixelFacebook();

        window.fbq('init', id);
        window.fbq('track', 'PageView');
    }

    var _invocarAnalyticsByCodigoIso = function (codigoIso) {
        $.each(_config.listPaisAnalytics, function (key, item) {
            if (item.CodigoISO == codigoIso) {
                _crearImagenAnalyticsWithId(item.GndId);
                _crearImagenAnalyticsWithId(item.SearchId);
                _crearImagenAnalyticsWithId(item.YoutubeId);
                _crearImagenPixelWithId(item.PixelId);

                _addListScriptAnalytics([item.GndId, item.SearchId, item.YoutubeId]);
                _invocarScriptPixel(item.PixelId);

                return false;
            }
        })
    }

    return {
        invocarAnalyticsByCodigoIso: _invocarAnalyticsByCodigoIso
    }
};
