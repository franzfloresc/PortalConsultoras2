var ClientePanelModule = function (config) {

    if (typeof config === "undefined" || config === null) throw "config parameter is null";

    var PanelId = "#" + config.panelId;
    var PanelContenedorId = "#" + config.panelContenedorId;

    var _config = {
        tusClientesProvider: config.tusClientesProvider || TusClientesProvider(),
        panelListaModule: config.panelListaModule || PanelListaModule(),
        panelMantenerModule: config.panelMantenerModule || PanelMantenerModule(),
    }

    var _aceptarClick = null;

    var _abrir = function () {
        $(PanelId).css("width", "400px");
    };

    var _cerrar = function () {
        $(PanelId).css("width", "0");
    };

    var _configuracionInicial = function () {
        if ($("#btnPanelListaAceptar").length == 0) {
            console.log("no existe 'PanelLista.btnPanelListaAceptar'");
        }

        $("#btnPanelListaAceptar").click(function () {
            var clienteSeleccion =
            {
                PaisID: $("#hfPaisID").val(),
                ClienteID: $("#hfClienteID").val(),
                CodigoCliente: $("#hfCodigoCliente").val(),
                NombreCliente: $("#hfNombreCliente").val(),
                Nombre: $("#hfNombre").val()
            };

            if (clienteSeleccion.ClienteID != "") {
                console.log("Selecciónxx: ", clienteSeleccion);
                console.log("_aceptaSeleccionClick: ", _aceptaSeleccionClick);
                _cerrar();
                if ($.isFunction(_aceptaSeleccionClick)) {
                    _aceptaSeleccionClick(clienteSeleccion);
                }
            } else {
                alert('Seleccione un Cliente');
            }
        });

        $("#btnPanelListaCerrar").click(function () {
            _cerrar();
        });
    };

    var _renderizarPagina = function () {
        _config
            .tusClientesProvider
            .panelListaPromise()
            .done(function (data) {
                $(PanelContenedorId).html(data);
                _configuracionInicial();
            })
            .fail(function (data, error) {
                console.log("ERROR al cargar html PanelLista.");
                console.log("data : " + data);
                console.log("error : " + error);
            });
    };

    var _aceptaSeleccionClick = function (fn) {
        _aceptaSeleccionClick = fn;
    };

    var _init = function () {
        _renderizarPagina();
        _config.panelListaModule.init();
        _config.panelMantenerModule.init();
        _abrir();
    };

    return {
        Abrir: _abrir,
        Cerrar: _cerrar,
        init: _init,
        AceptarClick: _aceptarClick,
        AceptaSeleccionClick: _aceptaSeleccionClick
    };
}