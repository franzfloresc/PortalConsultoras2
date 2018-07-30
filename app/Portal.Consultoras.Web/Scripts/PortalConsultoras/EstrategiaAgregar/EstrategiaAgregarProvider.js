var EstrategiaAgregarProvider = function () {
    "use strict";

    var pedidoAgregarProductoPromise = function (params) {
        var dfd = jQuery.Deferred();
        console.log('CatalogoPersonalizado.js - pedidoAgregarProductoPromise - ajax ante CargarCantidadProductosPedidos', "Pedido/PedidoAgregarProducto", params);
        jQuery.ajax({
            type: "POST",
            url: baseUrl + "Pedido/PedidoAgregarProducto",
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