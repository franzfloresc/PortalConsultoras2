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

    var _asignarEventos = function () {
        $("#quiero-tips-ofertas").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen));
        $("#ver-mas-informacion").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen));
    };

    return {
        asignarEventos: _asignarEventos
    }
}