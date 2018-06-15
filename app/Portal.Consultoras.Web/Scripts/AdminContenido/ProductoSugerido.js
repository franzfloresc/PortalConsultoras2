//dependencia con variable global 'imagen', paginador.js, Nemotecnico.js y MatrizComercialFileUpload.js
var ProductoSugerido = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction,
        actualizarDescripcionComercialAction: config.actualizarDescripcionComercialAction,
        obtenerMatrizAction: config.obtenerMatrizAction,
        getImagesByIdMatrizAction: config.getImagesByIdMatrizAction,
        paisID: config.paisID || 0,
        fileUploadElementId: config.fileUploadElementId || '',
        matrizIdElementId: config.matrizIdElementId || '',
        numeroImagenesPorPagina: config.numeroImagenesPorPagina || 10,
        habilitarNemotecnico: false,
        getImagesByNemotecnico: config.getImagesByNemotecnico,
        expValidacionNemotecnico: config.expValidacionNemotecnico
    };

    var _paginadorClick = function (page) {
        var params = _obtenerParametrosGetImagenes();
        var valNemotecnico = $('#txtBusquedaNemotecnico').val();
        var fnObtenerImagenes = (_config.habilitarNemotecnico && valNemotecnico) ? _obtenerImagenesByNemotecnico : _obtenerImagenes;
        fnObtenerImagenes(params, page, false);
    };

    var _obtenerParametrosGetImagenes = function () {
        return { paisID: _config.paisID, idMatrizComercial: $('#' + _config.matrizIdElementId).val() };
    };

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick, numeroImagenesPorPagina: _config.numeroImagenesPorPagina });

    var _nemotecnico = Nemotecnico({ expresionValidacion: _config.expValidacionNemotecnico });
    var _descripcionComercial = DescripcionComercial({
        prefixControlDescripcionComercial: 'label-descripcioncomercial-', actualizarDescripcionComercialAction: _config.actualizarDescripcionComercialAction, isSugeridosDescripcionComercial: true
    });

    var _limpiarFiltrosNemotecnico = function () {
        $('#txtBusquedaNemotecnico').val('');
        $('#chkTipoBusquedaNemotecnico').prop('checked', false);
    };

    var _matrizFileUploader = MatrizComercialFileUpload({ actualizarMatrizComercialAction: _config.actualizarMatrizComercialAction, habilitarNemotecnico: _config.habilitarNemotecnico, nemotecnico: _nemotecnico });

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
                _limpiarFiltrosNemotecnico();
                _obtenerImagenes(params, 1);
            } else {
                alert(response.message);
            }
        }
        closeWaitingDialog();
    };

    var _obtenerImagenes = function (data, pagina, recargarPaginacion) {
        var params = { paisID: _config.paisID, idMatrizComercial: data.idMatrizComercial, pagina: pagina };
        return $.post(_config.getImagesByIdMatrizAction, params).done(_obtenerImagenesSuccess(recargarPaginacion));
    };

    var _obtenerImagenesByNemotecnico = function (data, pagina, recargarPaginacion) {
        var tipoBusqueda = $("#chkTipoBusquedaNemotecnico:checked").length === 1 ? 2 : 1;
        var nemoTecnico = tipoBusqueda === 1 ? _nemotecnico.normalizarParametro($('#txtBusquedaNemotecnico').val()) : $('#txtBusquedaNemotecnico').val();

        var params = { paisID: _config.paisID, idMatrizComercial: data.idMatrizComercial, nemoTecnico: nemoTecnico, tipoBusqueda: tipoBusqueda, pagina: pagina };
        return $.post(_config.getImagesByNemotecnico, params).done(_obtenerImagenesSuccess(recargarPaginacion));
    };

    var _obtenerImagenesSuccess = function (recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            if (recargarPaginacion) {
                $("#matriz-imagenes-paginacion").empty();
            }
            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(data);

            $('.chkImagenProducto[value="' + imagen + '"]').first().attr('checked', 'checked');
            closeWaitingDialog();
            return data;
        }
    };

    var _limpiarBusquedaNemotecnico = function () {
        _limpiarFiltrosNemotecnico();
        waitingDialog({});
        var params = _obtenerParametrosGetImagenes();
        _obtenerImagenes(params, 1, true);
    };

    var _mostrarPaginacion = function (numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }
        _paginador.paginar(numRegistros);
    };

    var _mostrarListaImagenes = function (data) {
        SetHandlebars('#matriz-comercial-listado-imagenes-template', data, '#matriz-comercial-lista-imagenes');
        $(".qq-upload-list").css("display", "none");
    };

    var _validarNemotecnico = function () {
        var msj = '';
        var val = $('#txtBusquedaNemotecnico').val();
        if (!val) {
            msj += ' - Debe ingresar un Nemotecnico .\n';
        }

        return msj;
    };

    var _buscarNemotecnico = function () {
        var validacionMsj = _validarNemotecnico();

        if (validacionMsj) {
            alert(validacionMsj);
            return false;
        }
        waitingDialog({});
        var params = _obtenerParametrosGetImagenes();
        _obtenerImagenesByNemotecnico(params, 1, true);
    };

    var _actualizarPais = function (pais) {
        _config.paisID = pais;
    };

    var _actualizarParNemotecnico = function (val) {
        _config.habilitarNemotecnico = val;
        _matrizFileUploader.actualizarParNemotecnico(val);
    };

    var _editarDescripcionComercial = function editarDescripcionComercial(idImagen) {
        _descripcionComercial.actualizarPais(_config.paisID);
        _descripcionComercial.editarDescripcionComercial(idImagen);
    }

    return {
        crearObjetoUpload: _crearObjetoUpload,
        obtenerMatriz: _obtenerMatrizComercialByCUV,
        mostrarListaImagenes: _mostrarListaImagenes,
        mostrarPaginacion: _mostrarPaginacion,
        actualizarPais: _actualizarPais,
        actualizarParNemotecnico: _actualizarParNemotecnico,
        buscarNemotecnico: _buscarNemotecnico,
        obtenerImagenes: _obtenerImagenes,
        limpiarBusquedaNemotecnico: _limpiarBusquedaNemotecnico,
        limpiarFiltrosNemotecnico: _limpiarFiltrosNemotecnico,
        editarDescripcionComercial: _editarDescripcionComercial
    }
};