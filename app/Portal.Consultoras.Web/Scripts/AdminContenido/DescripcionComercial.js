//depende de ToastHelper.js
var DescripcionComercial = function (config) {
    var _config = {
        prefixControlDescripcionComercial: config.prefixControlNemotecnico || 'label-descripcioncomercial-',
        actualizarDescripcionComercialAction: config.actualizarDescripcionComercialAction || '',
        paisID: config.paisID || 0,
    };

    var _toastHelper = ToastHelper();

    var _generarControlEditable = function (id, val) {
        var template = '<input class="input-descripcioncomercial" id="input-descripcioncomercial-{0}" type = "text" value="{1}" />';
        return template.replace('{0}', id).replace('{1}', val);
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

    var _grabarDescripcionComercial= function (id, valor) {

       waitingDialog({});
       var params = { PaisID: _config.paisID, IdMatrizComercialImagen: id, DescripcionComercial: valor };
       $.post(_config.actualizarDescripcionComercialAction, params).done(_actualizarDescripcionComercialActionSuccess);

    };

    var _actualizarDescripcionComercialActionSuccess = function (response) {
        var entity = response.entity;
        var label = $('#' + _config.prefixControlDescripcionComercial + entity.IdMatrizComercialImagen);
        label.prop('title', entity.DescripcionComercial).text(entity.DescripcionComercial);
        closeWaitingDialog();
        //alert(response.message);
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
        actualizarPais: _actualizarPais
    }
};