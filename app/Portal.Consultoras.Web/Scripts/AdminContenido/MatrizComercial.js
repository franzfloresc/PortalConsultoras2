var MatrizComercial = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        getImagesBySapCodeAction: config.getImagesBySapCodeAction || '',
        uploadAction: config.uploadAction || ''
    };

    var _editData = [];

    var _crearFileUploadElements = function (editData) {
        $.ajaxSetup({ cache: false });

        for (var x = 0; x < editData.imagenes.length; x++) {
            var id = editData.imagenes[x].IdMatrizComercialImagen;
            _crearObjetoUpload('file-upload-' + x, 'img-matriz-' + x, id, editData);
        }
    };

    var _crearFileUploadAdd = function (editData) {
        _crearObjetoUpload('file-upload-add', '', 0, editData);
    };

    var _crearObjetoUpload = function (elementId, imageElementId, idImagenMatriz, editData) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: document.getElementById(elementId),
            action: _config.actualizarMatrizComercialAction,
            params: {
                IdMatrizComercial: editData.idMatrizComercial,
                IdMatrizComercialImagen: idImagenMatriz,
                PaisID: editData.paisID,
                CodigoSAP: editData.codigoSAP,
                DescripcionOriginal: editData.descripcionOriginal
            },
            onComplete: _uploadComplete(imageElementId),
            onSubmit: function (id, fileName) { $(".qq-upload-list").css("display", "none"); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    var _uploadComplete = function (imageElementId) {
        
        return function (id, fileName, response) {
            if (checkTimeout(response)) {

                $(".qq-upload-list").css("display", "none");
                if (response.success) {
                    _updateImageListOnUpload(imageElementId, response)
                } else {
                    alert(response.message)
                };
            }
        };
    };

    var _updateImageListOnUpload = function (imageElementId, response) {
        if (response.isNew) {
            _editData.imagenes.push({ Foto: response.name, IdMatrizComercialImagen: response.idMatrizComercialImagen });
            _refreshImageList(_editData);
        } else {
            $('#' + imageElementId).attr('src', response.name);
        }
    };

    var _editar = function (id, idMatrizComercial) {
        var editData = {
            idMatrizComercial: idMatrizComercial,
            pais: paisNombre,
            paisID: $("#ddlPais").val(),
            codigoSAP: getCell(id, 'CodigoSAP'),
            descripcionOriginal: getCell(id, 'DescripcionOriginal'),
            imagenes: []
        };

        _obtenerImagenesByCodigoSap(editData.codigoSAP).done(_obtenerImagenesSuccess(editData));

        return false;
    };

    var _obtenerImagenesByCodigoSap = function (codigoSAP) {
        return $.post(_config.getImagesBySapCodeAction, { paisID: paisID, sapCode: codigoSAP, pagina:1, registros:10 });
    };

    var _obtenerImagenesSuccess = function (editData) {
        return function (data, textStatus, jqXHR) {
            editData.imagenes = data;
            _editData = editData;

            SetHandlebars('#matriz-comercial-template', _editData, '#matriz-comercial-dialog');
            _crearFileUploadAdd(_editData);

            _refreshImageList(_editData);
            showDialog("matriz-comercial-dialog");
        };
    };

    var _refreshImageList = function(editData) {
        SetHandlebars('#matriz-comercial-item-template', editData, '#matriz-comercial-images');
        _crearFileUploadElements(editData);
    };

    return {
        editar: _editar
    }
};