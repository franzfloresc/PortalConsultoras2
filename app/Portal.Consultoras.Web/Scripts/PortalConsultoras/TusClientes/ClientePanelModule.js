var ClientePanelModule = function (config) {

    if (typeof config === "undefined" || config === null) throw "config parameter is null";

    var PanelId = "#" + config.panelId;
    var PanelContenedorId = "#" + config.panelContenedorId;

    var _config = {
        tusClientesProvider: config.tusClientesProvider /*|| TusClientesProvider()*/,
        panelListaModule: config.panelListaModule /*|| PanelListaModule()*/,
        panelMantenerModule: config.panelMantenerModule /*|| PanelMantenerModule()*/,
    };

    var _abrir = function () {
        //$(PanelId).css("width", "400px");
        $('.modal-fondo').css('opacity', '.7');
        $('.modal-fondo').show();
        $(PanelId).show();
        $(PanelId).css('margin-right', '0');
        $(PanelId).css('opacity', '1'); 

        _config.panelListaModule.setNombreCliente('');
        _config.panelListaModule.mostrarTusClientes();
    };

    var _cerrar = function () {
 
        $(PanelId).css('margin-right', '-330px');
        $(PanelId).css('opacity', '.0');
        $(PanelId).hide();
        $('.modal-fondo').hide();
        $('.modal-fondo').css('opacity', '.0');
       
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
                console.log("Selección: ", clienteSeleccion);
                
                _cerrar();
                _aceptaClick(clienteSeleccion);

            } 
        });

        $("#btnPanelListaCerrar").click(function () {
            $("#DivPopupFichaResumida").css("overflow", "auto");
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

    var _aceptaClick = function (fn) {
        _aceptaClick = fn;
    };

    var _init = function () {
        _renderizarPagina();
        _config.panelListaModule.init();
        _config.panelMantenerModule.init();
    };

    return {
        Abrir: _abrir,
        Cerrar: _cerrar,
        init: _init,
        AceptaClick: _aceptaClick
    };
};