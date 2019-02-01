var PanelMantenerModule = function (config) {
    "user strict";

    if (typeof config === "undefined" || config === null) throw "config parameter is null";


    var _config = {
        tusClientesProvider: config.tusClientesProvider || TusClientesProvider(),
        setNombreClienteCallback: config.setNombreClienteCallback,
        mostrarTusClientesCallback: config.mostrarTusClientesCallback,
        panelRegistroHideCallback: config.panelRegistroHideCallback,
        seleccionarClienteDespuesEditar: typeof config.seleccionarClienteDespuesEditar === "undefined" ||
            config.seleccionarClienteDespuesEditar === null ?
            true :
            config.seleccionarClienteDespuesEditar
    };

    var _elements = {
        btnCancelarCliente: "#btnPanelMantenerCerrar",
        btnGuardarCliente: "#btnPanelMantenerAgregar",
        //
        divErrorNombre: "#divNotiNombre",
        divErrorCorreo: "#divNotiCorreo",
        divErrorTelefonos: "#divValidationSummary",
        //
        hdnId: "#ClienteID",
        hdnCodigo: "#CodigoCliente",
        txtNombre: "#NombreCliente",
        txtApellido: "#ApellidoCliente",
        txtCorreo: "#eMail",
        txtTelefono: "#Telefono",
        txtCelular: "#Celular",
    };

    var _ocultarMensajesError = function () {
        $(_elements.divErrorNombre).hide();
        $(_elements.divErrorCorreo).hide();
        $(_elements.divErrorTelefonos).hide();
    };

    var _btnGuardarClienteOnClick = function (e) {
        _ocultarMensajesError();
        var id = $.trim($(_elements.hdnId).val());
        var codigo = $.trim($(_elements.hdnCodigo).val());
        var nombreCliente = $.trim($(_elements.txtNombre).val());
        var apellidoCliente = $.trim($(_elements.txtApellido).val());
        var correo = $.trim($(_elements.txtCorreo).val());
        var telefono = $.trim($(_elements.txtTelefono).val());
        var celular = $.trim($(_elements.txtCelular).val());

        if (nombreCliente === "") {
            $(_elements.divErrorNombre).show();
            return;
        }

        if (telefono === "" && celular === "") {
            $(_elements.divErrorTelefonos).show();
            return;
        }

        if (correo !== "" && !validateEmail(correo)) {
            $(_elements.divErrorCorreo).show();
            return;
        }

        var cliente = {
            ClienteID: id,
            CodigoCliente: codigo,
            NombreCliente: nombreCliente,
            ApellidoCliente: apellidoCliente,
            Nombre: jQuery.trim(nombreCliente + " " + apellidoCliente),
            eMail: correo,
            Telefono: telefono,
            Celular: celular
        };

        $(_elements.btnGuardarCliente).hide();
        //AbrirSplash();
        _config
            .tusClientesProvider
            .mantenerPromise(cliente)
            .done(function (data) {
                //if (checkTimeout(data)) {
                console.log(data);

                if (data.success == true) {
                    console.log(data);
                    //
                    alert(data.message);
                    if (typeof _config.setNombreClienteCallback === "function") {
                        if (_config.seleccionarClienteDespuesEditar) {
                            _config.setNombreClienteCallback(cliente.NombreCliente);
                        } else {
                            _config.setNombreClienteCallback("");
                        }
                    }
                    if (typeof _config.mostrarTusClientesCallback === "function")_config.mostrarTusClientesCallback();
                    if (typeof _config.panelRegistroHideCallback === "function")_config.panelRegistroHideCallback();
                }
                else {
                    alert(data.message);
                }
                //}
                $(_elements.btnGuardarCliente).show();
            })
            .fail(function (data, error) {
                $(_elements.btnGuardarCliente).show();
            });;
        //CerrarSplash();
    };

    var _btnCancelarClienteOnClick = function (e) {
        if (typeof _config.panelRegistroHideCallback === "function") _config.panelRegistroHideCallback();
    };

    var _setCliente = function (cliente) {
        _ocultarMensajesError();

        if (typeof cliente === "undefined" || cliente === null) {
            $(_elements.hdnId).val("");
            $(_elements.hdnCodigo).val("");
            $(_elements.txtNombre).val("");
            $(_elements.txtApellido).val("");
            $(_elements.txtTelefono).val("");
            $(_elements.txtCelular).val("");
            $(_elements.txtCorreo).val("");
            $(_elements.btnGuardarCliente).show();
            return;
        }

        $(_elements.hdnId).val(cliente.ClienteID);
        $(_elements.hdnCodigo).val(cliente.CodigoCliente);
        $(_elements.txtNombre).val(cliente.NombreCliente);
        $(_elements.txtApellido).val(cliente.ApellidoCliente);
        $(_elements.txtTelefono).val(cliente.Telefono);
        $(_elements.txtCelular).val(cliente.Celular);
        $(_elements.txtCorreo).val(cliente.eMail);
        $(_elements.btnGuardarCliente).show();

        return;
    }

    var _init = function () {
        $("body").on("click", _elements.btnGuardarCliente, _btnGuardarClienteOnClick);
        $("body").on("click", _elements.btnCancelarCliente, _btnCancelarClienteOnClick);
    };

    return {
        init: _init,
        setCliente : _setCliente
    };
};