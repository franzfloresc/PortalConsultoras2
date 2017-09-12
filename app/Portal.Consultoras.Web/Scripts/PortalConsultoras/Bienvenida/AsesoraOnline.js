var AsesoraOnline = function (config) {
    var _config = {
        asesoraOnlineUrl: config.asesoraOnlineUrl || '',
        cerrarPopupInicialUrl: config.cerrarPopupInicialUrl || '',
        codigoConsultora: config.codigoConsultora || '',
        isoPais: config.isoPais || '',
        origen: 'SB',
        actualizarEstadoConfiguracionPaisDetalleUrl: config.actualizarEstadoConfiguracionPaisDetalleUrl || ''
    };

    var _armarAsesoraOnlineUrl = function (isoPais, codigoConsultora, origen) {
        return _config.asesoraOnlineUrl + '?isoPais=' + isoPais + '&codigoConsultora=' + codigoConsultora + '&origen=' + origen;
    };
    
    var _hidePopup = function () {
        waitingDialog();
        $.post(config.cerrarPopupInicialUrl)
            .always(closeWaitingDialog)
            .done(function () {
                $("#fondoComunPopUp").hide();
                $("#virtual-coach-dialog").hide();
            })
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
                    _hidePopup();
                }
            },
            error: function (data, error) {
                alert(data.message);
                _hidePopup();
            }
        });
    };

    var _asignarEventos = function (isoPais, codigoConsultora) {
        $("#quiero-tips-ofertas").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen) + '#formulario-inscripcion');
        $("#ver-mas-informacion").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen));
        $("#cerrar-virtual-coach-dialog").on("click", _hidePopup);
        $("#no-volver-mostrar-mensaje").on("click",function(){ _actualizarEstadoConfiguracionPaisDetalle(isoPais, codigoConsultora);});
    };

    var _mostrar = function () {
        $("#fondoComunPopUp").show();
        $("#virtual-coach-dialog").show();
    };

    return {
        asignarEventos: _asignarEventos,
        mostrar: _mostrar,
        hidePopup: _hidePopup
    }
}