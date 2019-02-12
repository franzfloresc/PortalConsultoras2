/// <reference path="../shared/constantesmodule.js" />

var PedidoProvider = function () {
    
    _cargarDetallePedidoPromise = function (pageParams) {
        if (typeof pageParams === "undefined" || pageParams === null) throw "pageParams is null or indefined. PedidoProvider._cargarDetallePedidoPromise]";

        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: 'POST',
            url: ConstantesModule.UrlPedido.cargarDetallePedido,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pageParams),
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    _ejecutarServicioProlPromise = function (enviarCorreo) {
        if (typeof enviarCorreo === "undefined" || enviarCorreo === null) enviarCorreo = false;

        var dfd = jQuery.Deferred();

        var params = {
            enviarCorreo : enviarCorreo
        };
        jQuery.ajax({
            type: 'POST',
            url: ConstantesModule.UrlPedido.ejecutarServicioProl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
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
        cargarDetallePedidoPromise: _cargarDetallePedidoPromise,
        ejecutarServicioProlPromise: _ejecutarServicioProlPromise,
    };
};