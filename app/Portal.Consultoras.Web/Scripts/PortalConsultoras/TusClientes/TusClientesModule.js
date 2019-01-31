/// <reference path="tusclientesprovider.js" />
/// <reference path="../../General.js" />


var TusClientesModule = function (config) {
    "use strict";

    var _config = {
        tusClienteProvider: config.tusClienteProvider || TusClientesProvider(),
        checkTimeout: checkTimeout
    };

    var _elements = {
        txtNombreCliente: "#txtNombreCliente",
        divClientes: "#divClientes",
        hbsClientes: "#hbsClientes"
    };

    var _buscarClientes = function () {
        var nombreCliente = $.trim($(_elements.txtNombreCliente).val());

        _config.tusClienteProvider
            .consultarPromise(nombreCliente)
            .done(function (result) {
                SetHandlebars(_elements.hbsClientes, result,_elements.divClientes );
            })
            .fail(function (data, error) {
                throw "Error al invocar tusClienteProvider.consultarPromise";
            });

        return false;
    };

    var _init = function () {
        _buscarClientes();
        $(_elements.txtNombreCliente).keypress(function (e) {
            if (e.which == 13 && _config.checkTimeout()) {
                _buscarClientes();
            }
        });     
    };

    return {
        init: _init,
    };
};