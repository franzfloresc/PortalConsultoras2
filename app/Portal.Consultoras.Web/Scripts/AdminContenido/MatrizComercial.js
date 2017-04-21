var MatrizComercial = function (config) {

    var _config = {
        urlTemporales: config.urlTemporales || '',
        uploadAction: config.uploadAction || ''
    };

    var _obtenerImagenesByCodigoSap = function(codigoSAP) {
        return $.post(baseUrl + 'MatrizComercial/GetImagesBySapCode', { paisID: paisID, sapCode: codigoSAP });
    };

    var _obtenerImagenesSuccess = function (editData) {
        return function (data, textStatus, jqXHR) {
            editData.imagenes = data;
            SetHandlebars("#matriz-comercial-template", editData, '#matriz-comercial-dialog');
            _crearFileUploadControls(data);
            showDialog("matriz-comercial-dialog");

        };
    };

    var _crearFileUploadControls = function (imagenes) {
        $.ajaxSetup({ cache: false });

        for(var x=0; x < imagenes.length; x++) {
            _crearObjetoUpload(x);
        }
    };

    var _uploadComplete = function (index) {
        return function (id, fileName, response) {
            if (checkTimeout(response)) {
                $(".qq-upload-list").css("display", "none");
                if (response.success) {
                    // req. 1664
                    $('#img-matriz-' + index).attr('src', _config.urlTemporales + response.name);
                } else {
                    alert(response.message)
                };
            }
        };
    };

    var _crearObjetoUpload = function (index) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: document.getElementById('file-upload-' + index),
            action: _config.uploadAction,
            onComplete: _uploadComplete(index),
            onSubmit: function (id, fileName) { $(".qq-upload-list").css("display", "none"); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    var _editar = function (id, flagTransaccion) {
        $("#hdFlagTransaccion").val(flagTransaccion == '0' ? '0' : '1');

        var editData = {
            pais: paisNombre,
            codigoSAP: getCell(id, 'CodigoSAP'),
            descripcionOriginal: getCell(id, 'DescripcionOriginal'),
            imagenes: []
        };

        _obtenerImagenesByCodigoSap(editData.codigoSAP).done(_obtenerImagenesSuccess(editData));

        return false;
    };

    var _actualizarMatrizComercial = function () {

    };

    return {
        editar: _editar
    }
};