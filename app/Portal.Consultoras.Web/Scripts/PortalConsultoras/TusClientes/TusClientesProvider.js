var TusClientesProvider = function () {
    "use strict";

    var _consultarPromise = function (nombreCliente) {
        var dfd = jQuery.Deferred();

        var baseUrl = baseUrl || $("#hfBaseUrl").val();

        $.ajax({
            type: 'POST',
            url: baseUrl + 'TusClientes/Consultar',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                texto: nombreCliente
            }),
            async: true,
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
        consultarPromise: _consultarPromise
    };
};