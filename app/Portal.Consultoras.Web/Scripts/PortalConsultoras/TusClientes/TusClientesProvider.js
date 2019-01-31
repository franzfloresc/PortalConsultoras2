
var TusClientesProvider = function () {
    "use strict";

    var _consultarPromise = function (nombreCliente) {
        var dfd = jQuery.Deferred();

        $.ajax({
            type: 'POST',
            url: '/TusClientes/Consultar',
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

    var _mantenerPromise = function (cliente) {
        var dfd = jQuery.Deferred();

        $.ajax({
            type: 'POST',
            url: '/TusClientes/Mantener',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(cliente),
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

    var _panelListaPromise = function () {
        var dfd = jQuery.Deferred();

        $.ajax({
            type: "GET",
            url: "/TusClientes/PanelLista",
            dataType: "html",
            cache: false,
            async: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _panelMantenerPromise = function () {
        var dfd = jQuery.Deferred();

        $.ajax({
            type: "GET",
            url: "/TusClientes/PanelMantener",
            dataType: "html",
            cache: false,
            async: false,
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
        consultarPromise: _consultarPromise,
        mantenerPromise: _mantenerPromise,
        panelListaPromise: _panelListaPromise,
        panelMantenerPromise: _panelMantenerPromise
    };
};