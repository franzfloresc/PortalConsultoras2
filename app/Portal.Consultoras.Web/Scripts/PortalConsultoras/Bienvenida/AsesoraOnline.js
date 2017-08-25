var AsesoraOnline = function (config) {

    var _config = {
        asesoraOnlineUrl: config.asesoraOnlineUrl || '',
        codigoConsultora: config.codigoConsultora || '',
        isoPais: config.isoPais || '',
        origen: 'SB'
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

    return {
        asignarEventos: _asignarEventos,
        mostrar: _mostrar
    }
}