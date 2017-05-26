var MatrizComercialFileUpload = function (config) {
    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        allowedExtensions: config.allowedExtensions || ['jpg', 'png', 'jpeg'],
        habilitarNemotecnico: config.habilitarNemotecnico || false       
    };

    var _nemotecnico = config.nemotecnico || Nemotecnico({})

    var _validarNemotecnico = function (fileName) {
        var sinExtension = fileName.substring(0, fileName.lastIndexOf('.'));
        //var expr = /^((\d{9}#\d{2})?(&\d{9}#\d{2}?)*)$/g;
        //var patt = new RegExp(expr);
        //return patt.test(sinExtension);
        //_nemotecnico.
    };

    var _onFileSubmit = function (id, fileName) {
        if (_config.habilitarNemotecnico && !_validarNemotecnico(fileName)) {
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
                DescripcionOriginal: data.descripcionOriginal,
                NemotecnicoActivo: _config.habilitarNemotecnico
            },
            onComplete: data.onComplete,
            onSubmit: _onFileSubmit,
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    var _actualizarParNemotecnico = function (val) {
        _config.habilitarNemotecnico = val;
    }

    return {
        crearFileUpload: _crearFileUpload,
        actualizarParNemotecnico: _actualizarParNemotecnico
    }
}