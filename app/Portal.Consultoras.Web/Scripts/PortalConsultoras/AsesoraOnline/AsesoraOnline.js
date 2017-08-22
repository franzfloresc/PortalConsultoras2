var AsesoraOnline = function (config) {

    var _config = {
        enviarFormularioUrl: config.enviarFormularioUrl || ''
    };

    var _enviarFormulario = function () {
      
            /*if ($("#ddlPais").val() == "") {
                alert("Debe seleccionar el País, verifique.");
                return false;
            }
            if ($("#ddlCampania").val() == "") {
                alert("Debe seleccionar la Campaña, verifique.");
                return false;
            }
            if ($("#ddlTipoEstrategia").val() == "") {
                alert("Debe seleccionar el tipo de estrategia, verifique.");
                return false; 
            }*/
        var tipsVentas = $("#tips-ventas:checked").val();
        var tipsGestionClientes = $("#tips-gestion-clientes:checked").val();
        var masCatalogos = $("#mas-catalogos:checked").val();
        var tipsMasClientes = $("#tips-mas-clientes:checked").val();

        var params = {
            TipsVentas: typeof tipsVentas === "undefined" ? 0 : tipsVentas,
            TipsGestionClientes: typeof tipsGestionClientes === "undefined" ? 0 : tipsGestionClientes,
            MasCatalogos: typeof masCatalogos === "undefined" ? 0 : masCatalogos,
            TipsMasClientes: typeof tipsMasClientes === "undefined" ? 0 : tipsMasClientes
            };

        jQuery.ajax({
            type: 'POST',
            url: _config.enviarFormularioUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                alert(data.message);
            },
            error: function (data, error) {
                alert(data.message);
            }
        });

    };

    return {
        enviarFormulario : _enviarFormulario
    }
}