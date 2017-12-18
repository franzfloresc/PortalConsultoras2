var Analytics = function (config) {
    config = config || {};
    var _config = { listPaisAnalytics: config.listPaisAnalytics || [] };

    var _listImagenAnalyticsId = [], _listScriptAnalyticsId = [], _callingScriptAnalytics = false;
    var _listImagenPixelId = [];

    var _consoleLog = function(variable){
        if (!window.console) return;
        if (!window.console.log) return;

        console.log(variable);
    }

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
            _listScriptAnalyticsId.shift();
            _consoleLog('Cargó analytics Id: ' + google_conversion_id);
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
    var _invocarPixelFacebook = function (id) {
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

        window.fbq('init', id);
        _consoleLog('Cargó Pixel Id: ' + id);
    }
    var _limpiarPixelFacebook = function () {
        window.fbq = window._fbq = null;
    }
    var _invocarPageViewPixel = function () {
        if (!window.fbq) return;

        window.fbq('track', 'PageView');
        _consoleLog('Pixel PageView');
    }

    var _invocarAnalyticsByCodigoIso = function (codigoIso) {
        _limpiarPixelFacebook();
        $.each(_config.listPaisAnalytics, function (key, item) {
            if (item.CodigoISO == codigoIso) {
                _crearImagenAnalyticsWithId(item.GndId);
                _crearImagenAnalyticsWithId(item.SearchId);
                _crearImagenAnalyticsWithId(item.YoutubeId);
                _crearImagenPixelWithId(item.PixelId);

                _addListScriptAnalytics([item.GndId, item.SearchId, item.YoutubeId]);
                _invocarPixelFacebook(item.PixelId);
                _invocarPageViewPixel();

                return false;
            }
        });
    }

    var _invocarEventoPixel = function (link) {
        if (!window.fbq) return;

        window.fbq('trackCustom', 'Convert', { 'link': link });
        _consoleLog('Pixel Convert: ' + link);
    }

    var _invocarEventoPixelById = function (link, id) {
        _limpiarPixelFacebook();
        _crearImagenPixelWithId(id);
        _invocarPixelFacebook(id);
        _invocarEventoPixel(link);
    }

    return {
        invocarAnalyticsByCodigoIso: _invocarAnalyticsByCodigoIso,
        invocarEventoPixel: _invocarEventoPixel,
        invocarEventoPixelById: _invocarEventoPixelById
    }
};
