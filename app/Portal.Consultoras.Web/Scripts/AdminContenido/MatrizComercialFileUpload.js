﻿var MatrizComercialFileUpload = function (config) {
    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        allowedExtensions: config.allowedExtensions || ['jpg', 'png', 'jpeg']
    };

    var _validarNemotecnico = function (fileName) {
        var sinExtension = fileName.substring(0, fileName.lastIndexOf('.'));
        var expr = /^((\d{9}#\d{1,2})?(&\d{9}#\d{1,2}?)*)$/g;
        var patt = new RegExp(expr);
        return patt.test(sinExtension);
    };

    var _onFileSubmit = function (id, fileName) {
        if (!_validarNemotecnico(fileName)) {
            alert('El formato del nombre de imagen no es válido.');
            return false;
        }

        $(".qq-upload-list").css("display", "none");
        waitingDialog({});
    };

    var _crearFileUpload = function (data) {
        var uploader = new qq.FileUploader({
            allowedExtensions: _config.allowedExtensions,
            element: document.getElementById(data.elementId),
            action: _config.actualizarMatrizComercialAction,
            params: {
                IdMatrizComercial: data.idMatrizComercial,
                IdMatrizComercialImagen: data.idImagenMatriz,
                Foto: data.foto,
                PaisID: data.paisID,
                CodigoSAP: data.codigoSAP,
                DescripcionOriginal: data.descripcionOriginal
            },
            onComplete: data.onComplete,
            onSubmit: _onFileSubmit,
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    return {
        crearFileUpload: _crearFileUpload
    }
}