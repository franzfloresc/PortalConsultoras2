//dependencia con variable global 'imagen', paginador.js y MatrizComercialFileUpload.js
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

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick, numeroImagenesPorPagina: _config.numeroImagenesPorPagina });

    var _matrizFileUploader = MatrizComercialFileUpload({ actualizarMatrizComercialAction: _config.actualizarMatrizComercialAction });

    var _crearObjetoUpload = function (params) {
        params.elementId = _config.fileUploadElementId;
        params.onComplete = _uploadComplete;
        params.paisID = _config.paisID;
        _matrizFileUploader.crearFileUpload(params);
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
                        elementId: _config.fileUploadElementId,
                        idMatrizComercial: response.idMatrizComercial,
                        idImagenMatriz: 0,
                        paisID: _config.paisID,
                        codigoSAP: response.codigoSap,
                        onComplete: _uploadComplete
                    };
                    _matrizFileUploader.crearFileUpload(params);
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
        var params = { paisID: _config.paisID, idMatrizComercial: data.idMatrizComercial, pagina: pagina };
        return $.post(_config.getImagesByIdMatrizAction, params).done(_obtenerImagenesSuccess);
    };

    var _obtenerImagenesSuccess = function (data) {
        _mostrarPaginacion(data.totalRegistros);
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

    var _actualizarPais = function (pais) {
        _config.paisID = pais;
    };

    return {
        crearObjetoUpload: _crearObjetoUpload,
        obtenerMatriz: _obtenerMatrizComercialByCUV,
        mostrarListaImagenes: _mostrarListaImagenes,
        mostrarPaginacion: _mostrarPaginacion,
        actualizarPais: _actualizarPais
    }
};