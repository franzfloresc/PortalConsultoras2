var PanelMantenerModule = function (config) {
    "user strict";

    if (typeof config === "undefined" || config === null) throw "config parameter is null";


    var _config = {
        tusClientesProvider: config.tusClientesProvider || TusClientesProvider(),
        panelListaModule: config.panelListaModule || PanelListaModule(),
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

    var _btnGuardarClienteOnClick = function (e) {
        $(_elements.divErrorNombre).hide();
        $(_elements.divErrorCorreo).hide();
        $(_elements.divErrorTelefonos).hide();

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
                    _config.panelListaModule.setNombreCliente(cliente.NombreCliente);
                    _config.panelListaModule.mostrarTusClientes();
                    _config.panelListaModule.panelRegistroHide();
                }
                else {
                    alert(data.message);
                }
                //}
            });
        //CerrarSplash();
        $(_elements.btnGuardarCliente).hide();
    };

    var _init = function () {
        $(_elements.btnGuardarCliente).click(_btnGuardarClienteOnClick);
        $(_elements.btnCancelarCliente).click(function (e) {
            _config.panelListaModule.panelRegistroHide();
        });
    };

    return {
        init: _init
    };
};