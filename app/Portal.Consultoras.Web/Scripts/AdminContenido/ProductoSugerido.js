//dependencia con variable global 'imagen', paginador.js
var ProductoSugerido = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction,
        obtenerMatrizAction: config.obtenerMatrizAction,
        getImagesByIdMatrizAction: config.getImagesByIdMatrizAction,
        paisID: config.paisID || 0,
        fileUploadElementId: config.fileUploadElementId || '',
        matrizIdElementId: config.matrizIdElementId || '',
        numeroImagenesPorPagina: config.numeroImagenesPorPagina || 10
    };

    var _paginadorClick = function (page) {
        var params = _obtenerParametrosGetImagenes();
        _obtenerImagenes(params, page);
    };

    var _obtenerParametrosGetImagenes = function () {
        return { paisID: _config.paisID, idMatrizComercial: $('#' + _config.matrizIdElementId).val() };
    };

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick });

    var _onFileSubmit = function (id, fileName) {
        $(".qq-upload-list").css("display", "none");
        waitingDialog({});
    };

    var _crearObjetoUpload = function (params) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: document.getElementById(_config.fileUploadElementId),
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
        $("#" + _config.fileUploadElementId + " .qq-upload-button span").text("Subir Imagen");
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
            $(".qq-upload-list").css("display", "none");
            if (response.success) {
                $('#' + _config.matrizIdElementId).val(response.idMatrizComercial);
                if (response.isNewRecord) {
                    $("#" + _config.fileUploadElementId).empty();
                    var params = {
                        idMatrizComercial: response.idMatrizComercial,
                        idImagenMatriz: 0,
                        paisID: _config.paisID,
                        codigoSAP: response.codigoSap
                    };
                    _crearObjetoUpload(params);
                }
                var params = _obtenerParametrosGetImagenes();
                $("#matriz-imagenes-paginacion").empty();
                _obtenerImagenes(params, 1);
            } else {
                alert(response.message)
            };
        }
        closeWaitingDialog();
    };

    var _obtenerImagenes = function (data, pagina) {
        var params = { paisID: data.paisID, idMatrizComercial: data.idMatrizComercial, pagina: pagina };
        return $.post(_config.getImagesByIdMatrizAction, params).done(_obtenerImagenesSuccess);
    };

    var _obtenerImagenesSuccess = function (data) {
        if (data.totalRegistros > _config.numeroImagenesPorPagina) {
            _mostrarPaginacion(data.totalRegistros);
        }
        _mostrarListaImagenes(data);
        
        $('.chkImagenProducto[value="' + imagen + '"]').first().attr('checked', 'checked');
        closeWaitingDialog();
    };

    var _mostrarPaginacion = function (numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }
        _paginador.paginar(numRegistros);
    };

    var _mostrarListaImagenes = function (data) {
        SetHandlebars('#matriz-comercial-listado-imagenes-template', data, '#matriz-comercial-lista-imagenes');
    };

    return {
        crearObjetoUpload: _crearObjetoUpload,
        obtenerMatriz: _obtenerMatrizComercialByCUV,
        mostrarListaImagenes: _mostrarListaImagenes,
        mostrarPaginacion: _mostrarPaginacion
    }
};