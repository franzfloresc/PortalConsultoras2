//depende de ToastHelper.js
var DescripcionComercial = function (config) {
    var _config = {
        prefixControlDescripcionComercial: config.prefixControlNemotecnico || 'label-descripcioncomercial-',
        actualizarDescripcionComercialAction: config.actualizarDescripcionComercialAction || '',
        isEstrategiaDescripcionComercial: config.isEstrategiaDescripcionComercial || 0,
        isLiquidacionDescripcionComercial: config.isLiquidacionDescripcionComercial || 0,
        isSugeridosDescripcionComercial: config.isSugeridosDescripcionComercial || 0,
        paisID: config.paisID || 0,
    };

    var _actualizarConfig = function (config) {
        _config = config;
    }

    var _toastHelper = ToastHelper();

    var _generarControlEditable = function (id, val) {
        var template = '<input class="input-descripcioncomercial" id="input-descripcioncomercial-{0}" type = "text" value="{1}" />';
        return template.replace('{0}', id).replace('{1}', val);
    };

    var _generarControlEditableParaEstrategia = function (val) {
        var template = '<input class="input-descripcioncomercial" id="input-descripcioncomercial" type = "text" value="{0}" />';
        return template.replace('{0}', val);
    };

    var _editarDescripcionComercialParaEstrategia = function () {
        var input = $('#input-descripcioncomercial');
        if (input.length > 0) {
            return false;
        }
        var label = $('#' + _config.prefixControlDescripcionComercial);
        var value = label.prop('title');
        var htmlInput = _generarControlEditableParaEstrategia(value);
        label.after(htmlInput);
        _agregarEventos(idImagen);

        input = $('#input-descripcioncomercial-' + idImagen);
        input.focus();
        var strLength = input.val().length;
        input[0].setSelectionRange(strLength, strLength);
        label.hide();
    };

    var _editarDescripcionComercial = function (idImagen) {
        var input = $('#input-descripcioncomercial-' + idImagen);
        if (input.length > 0) {
            return false;
        }
        var label = $('#' + _config.prefixControlDescripcionComercial + idImagen);
        var value = label.prop('title');
        var htmlInput = _generarControlEditable(idImagen, value);
        label.after(htmlInput);
        _agregarEventos(idImagen);

        input = $('#input-descripcioncomercial-' + idImagen);
        input.focus();
        var strLength = input.val().length;
        input[0].setSelectionRange(strLength, strLength);
        label.hide();
    };

    var _agregarEventos = function (id) {
        var input = $('#input-descripcioncomercial-' + id);
        input.focusout(_inputFocusOut);
        input.keydown(_inputKeyUp(id));
    };

    var _inputKeyUp = function (id) {
        return function (e) {
            if (e.which == 13) {
                _grabarDescripcionComercial(id, $(this).val());
            } else if (e.which == 27) {
                $(this).blur();
                return false;
            }
        }
    };

    var _grabarDescripcionComercial = function (id, valor) {
        if (_validarTamañoMaximoCaracteres(valor)) {
            _toastHelper.error('Ha sobrepasado el tamaño de 800 caracteres.');
            return false;
        }
        else if (_validarCampoObligatorio(valor)) {
            _toastHelper.error('El campo Descripción Comercial es obligatorio.');
            return false;
        } else {
            waitingDialog({});
            var params = { PaisID: _config.paisID, IdMatrizComercialImagen: id, DescripcionComercial: valor };
            $.post(_config.actualizarDescripcionComercialAction, params).done(_actualizarDescripcionComercialActionSuccess);
        }
    };

    var _validarTamañoMaximoCaracteres = function (valor) {
        return (valor.length > 800);
    };

    var _validarCampoObligatorio = function (valor) {
        return (valor.trim().length === 0);
    };

    var _actualizarDescripcionComercialActionSuccess = function (response) {
        var entity = response.entity;
        var label = $('#' + _config.prefixControlDescripcionComercial + entity.IdMatrizComercialImagen);
        label.prop('title', entity.DescripcionComercial).text(entity.DescripcionComercial);
        closeWaitingDialog();

        if (_config.isEstrategiaDescripcionComercial)
            $("#txtDescripcion").val(entity.DescripcionComercial);
        if (_config.isLiquidacionDescripcionComercial)
            $("#txtDescripcionModal").val(entity.DescripcionComercial);

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
        editarDescripcionComercial: _editarDescripcionComercial,
        editarDescripcionComercialParaEstrategia: _editarDescripcionComercialParaEstrategia,
        actualizarPais: _actualizarPais,
        actualizarConfig: _actualizarConfig
    }
};