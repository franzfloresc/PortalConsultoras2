var CaminoBrillanteProvider = function () {

    var _getNivelesPromise = function (params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "CaminoBrillante/ObtenerNiveles",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _getLogrosPromise = function (params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "CaminoBrillante/ObtenerLogros",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _getKitsPromise = function (params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "CaminoBrillante/ObtenerKits",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _getDemostradoresPromise = function (params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "CaminoBrillante/ObtenerDemostradores",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    return {
        getNivelesPromise: _getNivelesPromise,
        getLogrosPromise: _getLogrosPromise,
        getKitsPromise: _getKitsPromise,
        getDemostradoresPromise: _getDemostradoresPromise
    };

};