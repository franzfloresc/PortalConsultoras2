//depende de ToastHelper.js
var Nemotecnico = function (config) {
    var _config = {
        expresionValidacion: config.expresionValidacion || /^((\d{9}#\d{2})?(&\d{9}#\d{2}?)*)$/g,
        prefixControlNemotecnico: config.prefixControlNemotecnico || 'label-nemotecnico-',
        actualizarNemotecnicoAction: config.actualizarNemotecnicoAction || '',
        paisID: config.paisID || 0,
    };

    var _toastHelper = ToastHelper();

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

    var _generarControlEditable = function (id, val) {
        var template = '<input class="input-nemotecnico" id="input-nemotecnico-{0}" type = "text" value="{1}" />';
        return template.replace('{0}', id).replace('{1}', val);
    };

    var _editarNemotecnico = function (idImagen) {
        var input = $('#input-nemotecnico-' + idImagen);
        if (input.length > 0) {
            return false;
        }
        var label = $('#' + _config.prefixControlNemotecnico + idImagen);
        var value = label.prop('title');
        var htmlInput = _generarControlEditable(idImagen, value);
        label.after(htmlInput);
        _agregarEventos(idImagen);

        input = $('#input-nemotecnico-' + idImagen);
        input.focus();
        var strLength = input.val().length;
        input[0].setSelectionRange(strLength, strLength);
        label.hide();
    };

    var _agregarEventos = function (id) {
        var input = $('#input-nemotecnico-' + id);
        input.focusout(_inputFocusOut);
        input.keydown(_inputKeyUp(id));
    };

    var _inputKeyUp = function (id) {
        return function (e) {
            if (e.which == 13) {
                _grabarNemotecnico(id, $(this).val());
            } else if (e.which == 27) {
                $(this).blur();
                return false;
            }
        }
    };

    var _grabarNemotecnico = function (id, valor) {
        var validacion = _validarNemotecnico(valor);
        if (validacion) {
            waitingDialog({});
            var params = { PaisID: _config.paisID, IdMatrizComercialImagen: id, Nemotecnico: valor };
            $.post(_config.actualizarNemotecnicoAction, params).done(_actualizarNemotecnicoSuccess);
        } else {
            _toastHelper.error('El formato del nemotécnico no es válido.');
            return false;
        }
    };

    var _actualizarNemotecnicoSuccess = function (response) {
        var entity = response.entity;
        var label = $('#' + _config.prefixControlNemotecnico + entity.IdMatrizComercialImagen);
        label.prop('title', entity.Nemotecnico).text(entity.Nemotecnico);
        closeWaitingDialog();
        _toastHelper.success(response.message);
    };

    var _inputFocusOut = function () {
        $(this).hide();
        $(this).prev().show();
        $(this).remove();
    };

    var _actualizarPais = function (pais) {
        _config.paisID = pais;
    };

    return {
        validarNemotecnico: _validarNemotecnico,
        normalizarParametro: _normalizarParametro,
        editarNemotecnico: _editarNemotecnico,
        actualizarPais: _actualizarPais
    }
};