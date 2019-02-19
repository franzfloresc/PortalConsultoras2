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

    var _getCliente = function () {

        var id = $.trim($(_elements.hdnId).val());
        var codigo = $.trim($(_elements.hdnCodigo).val());
        var nombreCliente = $.trim($(_elements.txtNombre).val());
        var apellidoCliente = $.trim($(_elements.txtApellido).val());
        var correo = $.trim($(_elements.txtCorreo).val());
        var telefono = $.trim($(_elements.txtTelefono).val());
        var celular = $.trim($(_elements.txtCelular).val());

        var cliente = {
            ClienteID: id,
            CodigoCliente: codigo,
            NombreCliente: nombreCliente,
            ApellidoCliente: apellidoCliente,
            Nombre: $.trim(nombreCliente + " " + apellidoCliente),
            eMail: correo,
            Telefono: telefono,
            Celular: celular
        };

        return cliente;
    };

    var _btnGuardarClienteOnClick = function (e) {

        _ocultarMensajesError();
        
        var cliente = _getCliente();

        if (cliente.NombreCliente === "") {
            $(_elements.divErrorNombre).show();
            return;
        }

        if (cliente.Telefono === "" && cliente.Celular === "") {
            $(_elements.divErrorTelefonos).show();
            return;
        }

        if (cliente.Correo !== "" && !validateEmail(correo)) {
            $(_elements.divErrorCorreo).show();
            return;
        }

        $(_elements.btnGuardarCliente).hide();

        AbrirLoad();

        _config
            .tusClientesProvider
            .mantenerPromise(cliente)
            .done(function (data) {
                //if (checkTimeout(data)) {

                alert(data.message);

                if (data.success == true) {
                    if (typeof _config.setNombreClienteCallback === "function") {
                        if (_config.seleccionarClienteDespuesEditar) {
                            _config.setNombreClienteCallback(cliente.NombreCliente);

                            //todo: improve this call
                            _seteoCerrarPanelLista(data);//asignar datos a los controles
                        } else {
                            _config.setNombreClienteCallback("");
                        }
                    }
                    if (typeof _config.panelRegistroHideCallback === "function") _config.panelRegistroHideCallback();
                }
            })
            .fail(function (data, error) {
                //
            })
            .then(function () {
                CerrarLoad();
                $(_elements.btnGuardarCliente).show();
            });
        
    };


    //todo : move this method to another component
    var _seteoCerrarPanelLista = function (data) {

        $("#hfClienteID").val(data.ClienteID);
        $("#hfCodigoCliente").val(data.CodigoCliente);
        $("#hfNombreCliente").val(data.NombreCompleto);
        $("#hfNombre").val(data.NombreCompleto);

        $("#btnPanelListaAceptar").click();

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

        $('.ImputForm-item input').blur(function () {
            if ($(this).val().length !== 0) {
                $(this).addClass('ActiveLabel');
                $(this).addClass('bar-imputActive');
            }
            else {
                $(this).removeClass('ActiveLabel');
                $(this).removeClass('bar-imputActive');
            }
        });
      

    };

    return {
        init: _init,
        setCliente: _setCliente
    };
};