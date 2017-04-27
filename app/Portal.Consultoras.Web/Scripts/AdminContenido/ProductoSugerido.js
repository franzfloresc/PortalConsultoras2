var ProductoSugerido = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction,
        obtenerMatrizAction: config.obtenerMatrizAction
    };

    var _onFileSubmit = function (id, fileName) {
        $(".qq-upload-list").css("display", "none");
        waitingDialog({});
    };

    var _crearObjetoUpload = function (params) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: document.getElementById(params.elementId),
            action: _config.actualizarMatrizComercialAction,
            params: {
                IdMatrizComercial: params.idMatrizComercial,
                IdMatrizComercialImagen: params.idImagenMatriz,
                PaisID: params.paisID,
                CodigoSAP: params.codigoSAP,
                DescripcionOriginal: params.descripcionOriginal
            },
            onComplete: _uploadComplete,
            onSubmit: _onFileSubmit,
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    var _obtenerMatrizComercialByCUV = function (params) {
        return $.getJSON(_config.obtenerMatrizAction, params).done(_validarobtenerMatrizResponse);
    };

    var _validarobtenerMatrizResponse = function (response) {
        if (!checkTimeout(response)) {
            closeWaitingDialog();
            return false;
        }
        if (response.success != true) {
            closeWaitingDialog();
            alert(response.message);
            return false;
        }
        return response;
    };

    var _uploadComplete = function (id, fileName, response) {
        if (checkTimeout(response)) {
            if (!response.success) alert(response.message);
        }
    };

    return {
        crearObjetoUpload: _crearObjetoUpload,
        obtenerMatriz: _obtenerMatrizComercialByCUV
    }
};