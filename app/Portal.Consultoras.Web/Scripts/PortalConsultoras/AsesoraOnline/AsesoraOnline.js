var AsesoraOnline = function (config) {

    var _config = {
        enviarFormularioUrl: config.enviarFormularioUrl || '',
        irAModificarMisDatosUrl: config.irAModificarMisDatosUrl || ''
    };

    var _irAModificarMisDatos = function () {
        _dataLayerVC("Banner Confirmación", "Click botón Modificar mis datos");
        window.location = _config.irAModificarMisDatosUrl;
    };

    var _showAndsetPopupValues = function (data, popup, element1, element2, element3) {
        $(popup).show();
        $(element1).text(data.usuario.EMail);
        $(element2).text(data.usuario.Celular);
        $(element3).text(data.usuario.Nombre);
    };

    var _clearElements = function () {
        $("#revisar-catalogo-clientes").prop("checked", false);
        $("#dejar-catalogo-clientes").prop("checked", false);
        $("#mis-clientes-vienen").prop("checked", false);
        $("#llamar-pedir-productos").prop("checked", false);
    };

    var _enviarFormulario = function () {

        _dataLayerVC("Suscripción Exitosa", "(not available)");
        var respuesta1 = $("#revisar-catalogo-clientes:checked").val();
        var respuesta2 = $("#dejar-catalogo-clientes:checked").val();
        var respuesta3 = $("#mis-clientes-vienen:checked").val();
        var respuesta4 = $("#llamar-pedir-productos:checked").val();
        var respuesta5 = $("#compartir-catalogos:checked").val();
        var TYCchecked = $("#terminos-condiciones").prop('checked');

        if (!TYCchecked) {
            $("#AcepteTYC").show();
            setTimeout(function () { $("#AcepteTYC").hide(); }, 3000);
            return false
        }

        var params = {
            Respuesta1: typeof respuesta1 === "undefined" ? 0 : respuesta1,
            Respuesta2: typeof respuesta2 === "undefined" ? 0 : respuesta2,
            Respuesta3: typeof respuesta3 === "undefined" ? 0 : respuesta3,
            Respuesta4: typeof respuesta4 === "undefined" ? 0 : respuesta4,
            Respuesta5: typeof respuesta5 === "undefined" ? 0 : respuesta5
        };

        jQuery.ajax({
            type: 'POST',
            url: _config.enviarFormularioUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                if (data.success) {
                    switch (data.resultado) {
                        case -1:
                            _showAndsetPopupValues(data, "#popup-consultora-ya-registrada-coach-virtual", "#correo_consultora_registrada_coach",
                                "#telefono_consultora_registrada_coach", "#nombre_consultora_registrada_coach");
                            break;
                        case 1:
                            _showAndsetPopupValues(data, "#popup-felicitaciones", "#correo_consultora", "#telefono_consultora", "#nombre_consultora");
                            break;
                    }
                    _clearElements();
                }

            },
            error: function (data, error) { }
        });

        return false;

    };
    var _dataLayerVC = function (action, label) {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Coach Virtual',
            'action': action,
            'label': label
        });
    }
    return {
        enviarFormulario: _enviarFormulario,
        irAModificarMisDatos: _irAModificarMisDatos
    }
}