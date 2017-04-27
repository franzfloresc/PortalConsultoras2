﻿//depende de Paginador
var MatrizComercial = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        getImagesByIdMatrizAction: config.getImagesByIdMatrizAction || ''
    };
    var _editData = {};

    var _paginadorClick = function (page) {
        _obtenerImagenes(_editData, page, false);
    };

    var _paginador = Paginador({elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick});

    var _crearFileUploadElements = function (editData) {
        $.ajaxSetup({ cache: false });

        for (var x = 0; x < editData.imagenes.length; x++) {
            var img = editData.imagenes[x];
            var id = img.IdMatrizComercialImagen;
            var foto = img.Foto.substring(img.Foto.lastIndexOf('/') + 1);
            var itemData = { elementId: 'file-upload-' + x, imageElementId: 'img-matriz-' + x, idImagenMatriz: id, foto: foto}
            _crearObjetoUpload(itemData, editData);
        }
    };

    var _crearFileUploadAdd = function (editData) {
        var itemData = { elementId: 'file-upload-add', idImagenMatriz: 0 };
        _crearObjetoUpload(itemData, editData);
        $("#file-upload-add .qq-upload-button span").text("Nueva Imagen");
    };

    var _onFileSubmit = function (id, fileName) {
        $(".qq-upload-list").css("display", "none");
        waitingDialog({});
    };

    var _crearObjetoUpload = function (itemData, editData) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: document.getElementById(itemData.elementId),
            action: _config.actualizarMatrizComercialAction,
            params: {
                IdMatrizComercial: editData.idMatrizComercial,
                IdMatrizComercialImagen: itemData.idImagenMatriz,
                Foto: itemData.foto,
                PaisID: editData.paisID,
                CodigoSAP: editData.codigoSAP,
                DescripcionOriginal: editData.descripcionOriginal
            },
            onComplete: _uploadComplete(itemData.imageElementId),
            onSubmit: _onFileSubmit,
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    var _uploadComplete = function (imageElementId) {
        return function (id, fileName, response) {
            if (checkTimeout(response)) {
                $(".qq-upload-list").css("display", "none");
                if (response.success) {
                    _editData.idMatrizComercial = response.idMatrizComercial;
                    if (response.isNewRecord) {
                        $('#list').trigger('reloadGrid');//refrescar la grilla con id generado
                        //regenerar el file-upload-add para que use el id generado
                        $("#file-upload-add").empty();
                        _crearFileUploadAdd(_editData);
                    }
                    _updateImageListOnUpload(imageElementId, response);
                } else {
                    alert(response.message);
                }
            }
            closeWaitingDialog();
        };
    };

    var _updateImageListOnUpload = function (imageElementId, response) {
        if (response.isNewImage) {
            _obtenerImagenes(_editData, 1, true);
        } else {
            $('#' + imageElementId).attr('src', response.foto);
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

        $("#matriz-imagenes-paginacion").empty();

        SetHandlebars('#matriz-comercial-template', editData, '#matriz-comercial-dialog');
        _crearFileUploadAdd(editData);

        _obtenerImagenes(editData, 1, true).done(function () {
            showDialog("matriz-comercial-dialog");
        });

        return false;
    };

    var _obtenerImagenes = function (data, pagina, recargarPaginacion) {
        var params = { paisID: data.paisID, idMatrizComercial: data.idMatrizComercial, pagina: pagina };
        return $.post(_config.getImagesByIdMatrizAction, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
    };

    var _obtenerImagenesSuccess = function (editData, recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            editData.imagenes = data.imagenes;
            _editData = editData;

            if (recargarPaginacion) {
                $("#matriz-imagenes-paginacion").empty();
            }

            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(_editData);
            closeWaitingDialog();
        };
    };

    var _mostrarPaginacion = function (numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }
        _paginador.paginar(numRegistros);
    };

    var _mostrarListaImagenes = function(editData) {
        SetHandlebars('#matriz-comercial-item-template', editData, '#matriz-comercial-images');
        _crearFileUploadElements(editData);
    };

    return {
        editar: _editar
    }
};