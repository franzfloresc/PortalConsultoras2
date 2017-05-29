var Nemotecnico = function (config) {
    var _config = {
        expresionValidacion: config.expresionValidacion || /^((\d{9}#\d{2})?(&\d{9}#\d{2}?)*)$/g
    };

    var _validarNemotecnico = function (valor) {
        var patt = new RegExp(_config.expresionValidacion);
        return patt.test(valor);
    };

    var _normalizarParametro = function (valor) {
        var removerEspaciosOperadorAnd = /\s*&\s*/g;
        var removerEspacios = /\s+/g;
        var result = valor.replace(removerEspaciosOperadorAnd, '&');
        result = result.replace(removerEspacios, '&');
        return result;
    };

    return {
        validarNemotecnico: _validarNemotecnico,
        normalizarParametro: _normalizarParametro
    }
};