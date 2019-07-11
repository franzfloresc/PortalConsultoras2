var campaniaModule = (function () {
    "use strict"

    var setting = {
        UrlListarCampanias: ''
    };

    var _bindEvents = function () {
        $(document).on("click", "", function () { });

        $(document).on("change", "", function () { });
    }

    var _setDefaultValues = function () { };

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