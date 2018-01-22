var campaniaModule = (function () {
    "use strict"

    var elements = {};

    var setting = {
        UrlListarCampanias: ''
    };

    var _bindEvents = function () {
        $(document).on("click", "", function () { });

        $(document).on("change", "", function () { });
    }

    var _setDefaultValues = function () { };

    var _listarCampaniasPromise = function (paisId) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'GET',
            url: (setting.BaseUrl + setting.UrlListarCampanias),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    var initializer = function (parameters) {
        setting.UrlListarCampanias = parameters.urlListarCampanias;
        _bindEvents();
        _setDefaultValues();
    }

    return {
        ini: function (parameters) {
            initializer(parameters);
        }
    };
})();