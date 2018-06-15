//dependencia con variable global 'imagen', paginador.js, Nemotecnico.js y MatrizComercialFileUpload.js
var OfertaLiquidacion = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction,
        actualizarDescripcionComercialAction: config.actualizarDescripcionComercialAction,
        getImagesByCodigoSAPAction: config.getImagesByCodigoSAPAction,
        getImagesByNemotecnico: config.getImagesByNemotecnico || '',
        paisID: config.paisID || 0,
        fileUploadElementId: config.fileUploadElementId || '',
        codigoSapElementId: config.codigoSapElementId || '',
        numeroImagenesPorPagina: config.numeroImagenesPorPagina || 10,
        imagenProductoElementId: config.imagenProductoElementId || '',
        habilitarNemotecnico: false,
        expValidacionNemotecnico: config.expValidacionNemotecnico
    };

    var _paginadorClick = function (page) {
        var codigoSap = $('#' + _config.codigoSapElementId).val();

        var valNemotecnico = $('#txtBusquedaNemotecnico').val();
        var fnObtenerImagenes = (_config.habilitarNemotecnico && valNemotecnico) ? _obtenerImagenesByNemotecnico : _obtenerImagenes;
        fnObtenerImagenes(codigoSap, page, false);
    };

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick, numeroImagenesPorPagina: _config.numeroImagenesPorPagina });

    var _nemotecnico = Nemotecnico({ expresionValidacion: _config.expValidacionNemotecnico });
    var _descripcionComercial = DescripcionComercial({
        prefixControlDescripcionComercial: 'label-descripcioncomercial-', actualizarDescripcionComercialAction: _config.actualizarDescripcionComercialAction, isLiquidacionDescripcionComercial: true
    });

    var _limpiarFiltrosNemotecnico = function () {
        $('#txtBusquedaNemotecnico').val('');
        $('#chkTipoBusquedaNemotecnico').prop('checked', false);
    };

    var _matrizFileUploader = MatrizComercialFileUpload({ actualizarMatrizComercialAction: _config.actualizarMatrizComercialAction, habilitarNemotecnico: _config.habilitarNemotecnico, nemotecnico: _nemotecnico });

    var _crearObjetoUpload = function (params) {
        params.elementId = _config.fileUploadElementId;
        params.onComplete = _uploadComplete;
        _matrizFileUploader.crearFileUpload(params);
    };

    var _uploadComplete = function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").css("display", "none");
            if (response.success) {
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
                $("#matriz-imagenes-paginacion").empty();
                _limpiarFiltrosNemotecnico();
                _obtenerImagenes(response.codigoSap, 1, true);
            } else {
                alert(response.message);
            }
        }
        closeWaitingDialog();
    };

    var _obtenerImagenes = function (codigoSap, pagina, recargarPaginacion) {
        var params = { paisID: _config.paisID, codigoSAP: codigoSap, pagina: pagina };
        return $.post(_config.getImagesByCodigoSAPAction, params).done(_obtenerImagenesSuccess(recargarPaginacion));
    };

    var _obtenerImagenesByNemotecnico = function (codigoSap, pagina, recargarPaginacion) {
        var tipoBusqueda = $("#chkTipoBusquedaNemotecnico:checked").length === 1 ? 2 : 1;
        var nemoTecnico = tipoBusqueda === 1 ? _nemotecnico.normalizarParametro($('#txtBusquedaNemotecnico').val()) : $('#txtBusquedaNemotecnico').val();
        var params = { paisID: _config.paisID, codigoSAP: codigoSap, nemoTecnico: nemoTecnico, tipoBusqueda: tipoBusqueda, pagina: pagina };
        return $.post(_config.getImagesByNemotecnico, params).done(_obtenerImagenesSuccess(recargarPaginacion));
    };

    var _limpiarBusquedaNemotecnico = function () {
        _limpiarFiltrosNemotecnico();
        waitingDialog({});
        var codigoSap = $('#' + _config.codigoSapElementId).val();
        _obtenerImagenes(codigoSap, 1, true);
    };

    var _obtenerImagenesSuccess = function (recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            if (recargarPaginacion) {
                $("#matriz-imagenes-paginacion").empty();
            }
            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(data);

            $('.chkImagenProducto[value*="' + $('#' + _config.imagenProductoElementId).val() + '"]').first().attr('checked', 'checked');
            closeWaitingDialog();
            return data;
        }
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

    var _actualizarPais = function (pais) {
        _config.paisID = pais;
        _nemotecnico.actualizarPais(pais);
        _descripcionComercial.actualizarPais(pais);
    };

    var _actualizarParNemotecnico = function (val) {
        _config.habilitarNemotecnico = val;
        _matrizFileUploader.actualizarParNemotecnico(val);
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
        var codigoSap = $('#' + _config.codigoSapElementId).val();
        _obtenerImagenesByNemotecnico(codigoSap, 1, true);
    };

    var _editarDescripcionComercial = function editarDescripcionComercial(idImagen) {
        _descripcionComercial.editarDescripcionComercial(idImagen);
    }

    return {
        crearObjetoUpload: _crearObjetoUpload,
        mostrarListaImagenes: _mostrarListaImagenes,
        mostrarPaginacion: _mostrarPaginacion,
        actualizarPais: _actualizarPais,
        obtenerImagenes: _obtenerImagenes,
        actualizarParNemotecnico: _actualizarParNemotecnico,
        buscarNemotecnico: _buscarNemotecnico,
        limpiarBusquedaNemotecnico: _limpiarBusquedaNemotecnico,
        limpiarFiltrosNemotecnico: _limpiarFiltrosNemotecnico,
        editarDescripcionComercial: _editarDescripcionComercial
    }
};