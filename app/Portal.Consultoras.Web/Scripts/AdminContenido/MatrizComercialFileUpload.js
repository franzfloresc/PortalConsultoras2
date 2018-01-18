//depende de Nemotecnico.js
var MatrizComercialFileUpload = function (config) {
    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        allowedExtensions: config.allowedExtensions || ['jpg', 'png', 'jpeg'],
        habilitarNemotecnico: config.habilitarNemotecnico || false
    };

    var _validarImagen = '1';
    var _nemotecnico = config.nemotecnico; //|| Nemotecnico({})
    var _uploader = '';

    var _validarNemotecnico = function (fileName) {
        var sinExtension = fileName.substring(0, fileName.lastIndexOf('.'));
        return _nemotecnico.validarNemotecnico(sinExtension);
    };

    var _validarTamano = function () {


        var tamanoMaximo = $("#ddlTipoEstrategia option:selected").attr("data-PesoMaximo");

        if ($("#ddlTipoEstrategia option:selected").attr("data-FValidarImagen") == _validarImagen) {
            return tamanoMaximo;
        }
        else {
            return 0;
        }
    }

    var _onFileSubmit = function (id, fileName) {
        if (_config.habilitarNemotecnico && !_validarNemotecnico(fileName)) {
            alert('El formato del nombre de imagen no es válido.');
            return false;
        }

        $(".qq-upload-list").css("display", "none");
        waitingDialog({});
    };

    var _crearFileUpload = function (data) {

        _uploader = new qq.FileUploader({
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
                DescripcionComercial: data.descripcionOriginal,
                NemotecnicoActivo: _config.habilitarNemotecnico
            },
            sizeLimit: _validarTamano() * 1024,
            onComplete: data.onComplete,
            onSubmit: _onFileSubmit,
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); },
            maxConnections: data.maxConnections || 3,
            multiple: data.multiple || false
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