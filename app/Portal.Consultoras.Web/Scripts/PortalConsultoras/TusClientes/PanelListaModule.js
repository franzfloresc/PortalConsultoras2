var PanelListaModule = function (config) {

    if (typeof config === "undefined" || config === null) throw "config parameter is null";

    var _config = {
        //urlPanelMantener: config.urlPanelMantener || "",
        urlPanelMantener: "#hfUrlFrmRegistro",
        tusClientesProvider: config.tusClientesProvider /*|| TusClientesProvider()*/
    };

    var _elements = {
        panelRegistroContenedor: "#PanelClienteRegistro_contenedor",
        panelClienteRegistro: "#PanelClienteRegistro",
        btnAgregar: "#btnPanelListaAgregar",
        txtNombreCliente: "#txtPanelListaBusqueda",
        //
        hfPaisID: "#hfPaisID",
        hfClienteID: "#hfClienteID",
        hfCodigoCliente: "#hfCodigoCliente",
        hfNombreCliente: "#hfNombreCliente",
        hfNombre: "#hfNombre",
        //
        hbsClientes: "#handlebars_plantilla1",
        divClientes: "#handlebars_contenedor1",

        hdnId: "#ClienteID",
        hdnCodigo: "#CodigoCliente",
        txtNombre: "#NombreCliente",
        txtApellido: "#ApellidoCliente",
        txtCorreo: "#eMail",
        txtTelefono: "#Telefono",
        txtCelular: "#Celular",

        // Ini - Estructura Panel
        panelMain: "#PanelClienteLista",
        panelCabecera: '[data-panelcliente-seccion="cabecera"]',
        panelFuncionesAdd: '[data-panelcliente-seccion="funciones"]',
        panelListaCliente: '[data-panelcliente-seccion="lista"]'
        // Fin - Estructura Panel

    };

    var _loadPanelMantener = function () {
        _config
            .tusClientesProvider
            .panelMantenerPromise()
            .done(function (data) {
                $(_elements.panelRegistroContenedor).html(data);
            })
            .fail(function (data, error) {
                console.log("ERROR al cargar html PanelLista.");
                console.log("data : " + data);
                console.log("error : " + error);
            });
    };

    var _panelRegistroShow = function () {

        $(_elements.hdnId).val('');
        $(_elements.hdnCodigo).val('');
        $(_elements.txtNombre).val('');
        $(_elements.txtApellido).val('');
        $(_elements.txtCorreo).val('');
        $(_elements.txtTelefono).val('');
        $(_elements.txtCelular).val('');

        $(_elements.panelClienteRegistro).show();
    };

    var _panelRegistroHide = function () {
        $(_elements.panelClienteRegistro).hide();
    };

    var _seleccionarRegistro = function (paisId, clienteId, codigoCliente, nombreCliente, nombre) {
        //console.log(paisId, clienteId, codigoCliente, nombreCliente, nombre);

        $(_elements.hfPaisID).val(paisId);
        $(_elements.hfClienteID).val(clienteId);
        $(_elements.hfCodigoCliente).val(codigoCliente);
        $(_elements.hfNombreCliente).val(nombreCliente);
        $(_elements.hfNombre).val(nombre);

        $("#btnPanelListaAceptar").click();
    };

    var _renderLayoutPanel = function () {
        var w = window.innerHeight;
        var c = $(_elements.panelCabecera).innerHeight();
        var a = $(_elements.panelFuncionesAdd).innerHeight();
        var l = w - c - a;
        $(_elements.panelMain).css("height", w);
        $(_elements.panelListaCliente).css("height", l);
        $(_elements.panelListaCliente).css("overflow", "auto");
    };

    var _mostrarTusClientes = function () {
        $(_elements.btnAgregar).hide();
        var nombreClinete = $.trim($(_elements.txtNombreCliente).val());
        _config.tusClientesProvider
            .consultarPromise(nombreClinete)
            .done(function (data) {
                data.mostrarNoTieneClientes = nombreClinete === "";
                if (data.mostrarNoTieneClientes) $(_elements.btnAgregar).show();
                SetHandlebars(_elements.hbsClientes, data, _elements.divClientes);
                _seleccionarRegistro("", "", "", "", "");
                _renderLayoutPanel();
            });
    };

    var _setNombreCliente = function (nombreCliente) {
        $(_elements.txtNombreCliente).val(nombreCliente);
    };

    var _init = function () {
        _loadPanelMantener();

        _setNombreCliente('');
        _mostrarTusClientes();

        $("body").on("click", _elements.btnAgregar, function (e) {
            _panelRegistroShow();
        });

        $("body").on("keypress", _elements.txtNombreCliente, function (e) {
            if (e.which == 13) {
                //if (checkTimeout()) {
                _mostrarTusClientes();
                //}
            }
        });

        $("#btnPanelListaCerrar_todo").click(function () {
            $('#PanelClienteLista').css('margin-right', '-330px');
            $('#PanelClienteLista').css('opacity', '.0');
            $('#PanelClienteLista').hide();
            $('.modal-fondo').hide();
            $('.modal-fondo').css('opacity', '.0');
            $(_elements.panelClienteRegistro).hide();
        });

    };

    return {
        init: _init,
        seleccionarRegistro: _seleccionarRegistro,
        setNombreCliente: _setNombreCliente,
        mostrarTusClientes: _mostrarTusClientes,
        panelRegistroShow: _panelRegistroShow,
        panelRegistroHide: _panelRegistroHide
    };
};