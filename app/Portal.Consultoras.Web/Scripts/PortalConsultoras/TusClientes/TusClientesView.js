var TusClientesView = function () {
    var _elements = {
        txtNombreCliente: "#txtNombreCliente",
        btnExportarClientes: "#btnExportarClientes",
        divClientes: "#divClientes",
        hbsClientes: "#hbsClientes",
        //
        divPopupEditarCliente: "#divPopupEditarCliente",
        //
        divConfirmarEliminarCliente: "#divConfirmarEliminarCliente",
        btnConfirmarEliminarCliente: "#btnConfirmarEliminarCliente",
        btnCancelarEliminarCliente: "#btnCancelarEliminarCliente",
    };


    var _filtroNombreCliente = function (nombreCliente) {
        if (typeof nombreCliente === "undefined") {
            return $.trim($(_elements.txtNombreCliente).val());
        }

        if (nombreCliente !== "") {
            $(_elements.txtNombreCliente).val($.trim(nombreCliente));
        }
    };

    var _clientesModel = {
        miData : []
    };
    var _clientes = function (clientes) {
        if (typeof clientes === "undefined") {
            return _clientesArr;
        }

        if (clientes !== null && Array.isArray(clientes)) {
            _clientesModel.miData  = clientes;
            SetHandlebars(_elements.hbsClientes, _clientesModel, _elements.divClientes);
        }
    };

    return {
        filtroNombreCliente : _filtroNombreCliente,
        clientes : _clientes,
    };
};