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

        var params = {
            TipsVentas: tipsVentas,
            TipsGestionClientes: tipsGestionClientes,
            TasCatalogos: masCatalogos,
            TipsMasClientes: tipsMasClientes
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