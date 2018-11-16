﻿var EstrategiaAgregarProvider = function () {
    "use strict";

    var pedidoAgregarProductoPromise = function (params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "PedidoRegistro/PedidoAgregarProductoTransaction",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,    
            success: function(data) {
                dfd.resolve(data);
            },
            error: function(data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    return {
        pedidoAgregarProductoPromise: pedidoAgregarProductoPromise
    };
}();