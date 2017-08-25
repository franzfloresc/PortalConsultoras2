var AsesoraOnline = function (config) {

    var _config = {
        asesoraOnlineUrl: config.asesoraOnlineUrl || '',
        codigoConsultora: config.codigoConsultora || '',
        isoPais: config.isoPais || '',
        origen: 'SB',
        actualizarEstadoConfiguracionPaisDetalleUrl: config.actualizarEstadoConfiguracionPaisDetalleUrl || ''

    };

    var _armarAsesoraOnlineUrl = function (isoPais, codigoConsultora, origen) {
        return _config.asesoraOnlineUrl + '?isoPais=' + isoPais + '&codigoConsultora=' + codigoConsultora + '&origen=' + origen;
    };

    var _hidePopup = function () {
        $("#fondoComunPopUp").hide();
        $("#virtual-coach-dialog").hide();
    };

    var _asignarEventos = function () {
        $("#quiero-tips-ofertas").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen) + '#formulario-inscripcion');
        $("#ver-mas-informacion").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen));
        $("#cerrar-virtual-coach-dialog").on("click", _hidePopup);        
    };

    var _mostrar = function () {
        $("#fondoComunPopUp").show();
        $("#virtual-coach-dialog").show();
    };

    var _actualizarEstadoConfiguracionPaisDetalle = function (isoPais, codigoConsultora) {
        var params = {
            isoPais: typeof isoPais === "undefined" ? '' : isoPais,
            codigoConsultora: typeof codigoConsultora === "undefined" ? '' : codigoConsultora
        };

        jQuery.ajax({
            type: 'POST',
            url: _config.actualizarEstadoConfiguracionPaisDetalleUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                if (data.success) {                    
                }
            },
            error: function (data, error) {
                alert(data.message);
            }
        });
    };

    return {
        asignarEventos: _asignarEventos,
        mostrar: _mostrar
    }
}