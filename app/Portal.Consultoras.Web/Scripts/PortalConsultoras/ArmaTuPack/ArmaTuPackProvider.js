var ArmaTuPackProvider = function () {

    var _getPackComponentsPromise = function (params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "DetalleEstrategia/ObtenerComponentes",
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
        getPackComponentsPromise : _getPackComponentsPromise
    };
};