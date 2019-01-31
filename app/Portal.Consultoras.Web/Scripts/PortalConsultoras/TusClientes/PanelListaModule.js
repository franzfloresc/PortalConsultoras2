var PanelListaModule = function (config) {

    if (typeof config === "undefined" || config === null) throw "config parameter is null";

    var _config = {
        //urlPanelMantener: config.urlPanelMantener || "",
        urlPanelMantener:  "#hfUrlFrmRegistro",
        tusClientesProvider: config.tusClientesProvider /*|| TusClientesProvider()*/
    };

    var _elements = {
        panelRegistroContenedor : "#PanelClienteRegistro_contenedor",
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
        divClientes:"#handlebars_contenedor1"
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
        $(_elements.panelClienteRegistro).css("width", "400px");
    };

    
    var _panelRegistroHide = function () {
        $(_elements.panelClienteRegistro).css("width", "0");
    };

    var _seleccionarRegistro = function (paisId, clienteId, codigoCliente, nombreCliente, nombre) {
        console.log(paisId, clienteId, codigoCliente, nombreCliente, nombre);

        $(_elements.hfPaisID).val(paisId);
        $(_elements.hfClienteID).val(clienteId);
        $(_elements.hfCodigoCliente).val(codigoCliente);
        $(_elements.hfNombreCliente).val(nombreCliente);
        $(_elements.hfNombre).val(nombre);
    };

    var _mostrarTusClientes = function () {

        var nombreClinete = $.trim($(_elements.txtNombreCliente).val());
        _config.tusClientesProvider
            .consultarPromise(nombreClinete)
            .done(function (data) {
                console.log(data);
                SetHandlebars(_elements.hbsClientes, data, _elements.divClientes);
                _seleccionarRegistro("", "", "", "","");
            });
    };

    var _setNombreCliente = function (nombreCliente) {
        $(_elements.txtNombreCliente).val(nombreCliente);
    };

    var _init = function () {
        _loadPanelMantener();

        _mostrarTusClientes();

        $("body").on("click", _elements.btnAgregar,function (e) {
            _panelRegistroShow();
        });

        $("body").on("keypress", _elements.txtNombreCliente, function (e) {
            if (e.which == 13) {
                //if (checkTimeout()) {
                _mostrarTusClientes();
                //}
            }
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