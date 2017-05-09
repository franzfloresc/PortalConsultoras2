//dependencia con variable global 'imagen', paginador.js
var OfertaLiquidacion = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction,
        getImagesByCodigoSAPAction: config.getImagesByCodigoSAPAction,
        paisID: config.paisID || 0,
        fileUploadElementId: config.fileUploadElementId || '',
        codigoSapElementId: config.codigoSapElementId || '',
        numeroImagenesPorPagina: config.numeroImagenesPorPagina || 10,
        imagenProductoElementId: config.imagenProductoElementId || ''
    };

    var _paginadorClick = function (page) {
        var codigoSap = $('#' + _config.codigoSapElementId).val();
        _obtenerImagenes(codigoSap, page).done(function () { closeWaitingDialog(); });
    };

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick, numeroImagenesPorPagina: _config.numeroImagenesPorPagina });

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

    var _uploadComplete = function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").css("display", "none");
            if (response.success) {
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
                $("#matriz-imagenes-paginacion").empty();
                _obtenerImagenes(response.codigoSap, 1);
            } else {
                alert(response.message)
            };
        }
        closeWaitingDialog();
    };

    var _obtenerImagenes = function (codigoSap, pagina) {
        var params = { paisID: _config.paisID, codigoSAP: codigoSap, pagina: pagina };
        return $.post(_config.getImagesByCodigoSAPAction, params).done(_obtenerImagenesSuccess);
    };

    var _obtenerImagenesSuccess = function (data) {
        _mostrarPaginacion(data.totalRegistros);
        _mostrarListaImagenes(data);

        $('.chkImagenProducto[value*="' + $('#' + _config.imagenProductoElementId).val() + '"]').first().attr('checked', 'checked');
        return data;
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

    var _actualizarPais = function (pais) {
        _config.paisID = pais;
    };

    return {
        crearObjetoUpload: _crearObjetoUpload,
        mostrarListaImagenes: _mostrarListaImagenes,
        mostrarPaginacion: _mostrarPaginacion,
        actualizarPais: _actualizarPais,
        obtenerImagenes: _obtenerImagenes
    }
};