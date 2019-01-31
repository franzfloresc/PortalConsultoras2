function ClientePanelModule(panelId, panelContenedorId, baseUrl) {
    this.PanelId = panelId;
    this.PanelContenedorId = panelContenedorId;
    this.BaseUrl = baseUrl;
    this.AceptarClick = null;

    this.Abrir = function () {
        $("#" + this.PanelId).css("width", "400px");
    };

    this.Cerrar = function () {
        $("#" + this.PanelId).css("width", "0");
    };

    this.ConfiguracionInicial = function (instancia) {

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
                instancia.Cerrar();
                if ($.isFunction(instancia.AceptarClick)) {
                    instancia.AceptarClick(clienteSeleccion);
                }
            } else {
                alert('Seleccione un Cliente');
            }

        });

        $("#btnPanelListaCerrar").click(function () {
            instancia.Cerrar();
        });

    };

    this.RenderizarPagina = function () {
        var instancia = this;
        //console.log(this.BaseUrl + "TusClientes/PanelLista");
        $.ajax({
            type: "GET", dataType: "html", cache: false,
            url: this.BaseUrl + "TusClientes/PanelLista",
            success: function (data) {
                $('#' + instancia.PanelContenedorId).html(data);
                instancia.ConfiguracionInicial(instancia);
            },
            error: function (e) {
                console.log("ERROR al cargar html PanelLista: ", e);
            }
        });
    }
}