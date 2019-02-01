/// <reference path="tusclientesprovider.js" />
/// <reference path="../../General.js" />


var TusClientesModule = function (config) {
    "use strict";

    var _config = {
        tusClientesProvider: config.tusClientesProvider /*|| TusClientesProvider()*/,
        checkTimeout: checkTimeout
    };

    var _elements = {
        txtNombreCliente: "#txtNombreCliente",
        divClientes: "#divClientes",
        hbsClientes: "#hbsClientes",
        //
        divPopupEditarCliente: "#divPopupEditarCliente",
        //
        divConfirmarEliminarCliente: "#divConfirmarEliminarCliente",
        btnConfirmarEliminarCliente: "#btnConfirmarEliminarCliente",
        btnCancelarEliminarCliente: "#btnCancelarEliminarCliente",
    };

    var _panelMantenerCliente = null;

    var _buscarClientes = function () {
        var nombreCliente = $.trim($(_elements.txtNombreCliente).val());

        _config.tusClientesProvider
            .consultarPromise(nombreCliente)
            .done(function (result) {
                SetHandlebars(_elements.hbsClientes, result, _elements.divClientes);
            })
            .fail(function (data, error) {
                throw "Error al invocar tusClienteProvider.consultarPromise";
            });

        return false;
    };

    var _setNombreCliente = function (nombreCliente) {
        $(_elements.txtNombreCliente).val(nombreCliente);
    };

    var _ocultarEditarCliente = function () {
        $(_elements.divPopupEditarCliente).hide();
    };

    var _editarCliente = function (cliente) {
        _panelMantenerCliente.setCliente(cliente)
        $(_elements.divPopupEditarCliente).show();
    };

    var _eliminarCliente = function () {
        var clientId = parseInt($(_elements.divConfirmarEliminarCliente).data("clienteId"));
        _config
            .tusClientesProvider
            .eliminarClientePromise(clientId)
            .done(function (data) {
                alert(data.message);
                _ocultarConfirmarEliminarCliente();
                _buscarClientes();
                
            })
            .fail(function (data, error) {

            });
    };

    var _mostarConfirmarEliminarCliente = function (clienteId) {
        $(_elements.divConfirmarEliminarCliente).show();
        $(_elements.divConfirmarEliminarCliente).data("clienteId", clienteId);
    };

    var _ocultarConfirmarEliminarCliente = function () {
        $(_elements.divConfirmarEliminarCliente).hide();
        $(_elements.divConfirmarEliminarCliente).data("clienteId", "");
    };

    var _init = function () {
        _panelMantenerCliente = PanelMantenerModule({
            tusClientesProvider: _config.tusClientesProvider,
            setNombreClienteCallback: _setNombreCliente,
            mostrarTusClientesCallback: _buscarClientes,
            panelRegistroHideCallback: _ocultarEditarCliente,
            seleccionarClienteDespuesEditar: false
        });

        _panelMantenerCliente.init();

        _buscarClientes();

        $(_elements.txtNombreCliente).keypress(function (e) {
            if (e.which == 13 && _config.checkTimeout()) {
                _buscarClientes();
            }
        });

        _ocultarEditarCliente();
    };

    return {
        init: _init,
        ocultarEditarCliente: _ocultarEditarCliente,
        editarCliente: _editarCliente,
        eliminarCliente: _eliminarCliente,
        mostarConfirmarEliminarCliente: _mostarConfirmarEliminarCliente,
        ocultarConfirmarEliminarCliente: _ocultarConfirmarEliminarCliente
    };
};