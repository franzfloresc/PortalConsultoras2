var AsesoraOnline = function (config) {

    var _config = {
        enviarFormularioUrl: config.enviarFormularioUrl || ''
    };

    var _enviarFormulario = function () {

        var respuesta1 = $("#revisar-catalogo-clientes:checked").val();
        var respuesta2 = $("#dejar-catalogo-clientes:checked").val();
        var respuesta3 = $("#mis-clientes-vienen:checked").val();
        var respuesta4 = $("#llamar-pedir-productos:checked").val();
        var TYCchecked = $("#terminos-condiciones").prop('checked')

        if (!TYCchecked) {
            $("#AcepteTYC").show();
            setTimeout(function () { $("#AcepteTYC").hide(); }, 3000);
            return false
        }
        
        var params = {
            Respuesta1: typeof respuesta1 === "undefined" ? 0 : respuesta1,
            Respuesta2: typeof respuesta2 === "undefined" ? 0 : respuesta2,
            Respuesta3: typeof respuesta3 === "undefined" ? 0 : respuesta3,
            Respuesta4: typeof respuesta4 === "undefined" ? 0 : respuesta4
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