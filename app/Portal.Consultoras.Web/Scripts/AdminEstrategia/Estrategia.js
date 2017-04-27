var Estrategia = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        getImagesBySapCodeAction: config.getImagesBySapCodeAction || '',
        getFiltrarEstrategiaAction: config.getFiltrarEstrategiaAction || '',
        uploadAction: config.uploadAction || ''
    };

    var _editData = {};

    var _crearFileUploadElements = function (editData) {
        $.ajaxSetup({ cache: false });

        for (var x = 0; x < editData.imagenes.length; x++) {
            var img = editData.imagenes[x];
            var id = img.IdMatrizComercialImagen;
            var foto = img.Foto.substring(img.Foto.lastIndexOf('/') + 1);
            var itemData = { elementId: 'file-upload-' + x, imageElementId: 'img-matriz-' + x, idImagenMatriz: id, foto: foto }
            _crearObjetoUpload(itemData, editData);
        }
    };

    var _crearFileUploadAdd = function (editData) {
        var itemData = { elementId: 'file-upload-add', idImagenMatriz: 0 };
        _crearObjetoUpload(itemData, editData);
        $("#file-upload-add .qq-upload-button span").text("Nueva Imagen")
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
                    _editData.idMatrizComercial = response.idMatrizComercial;
                    if (response.isNewRecord) {
                        $('#list').trigger('reloadGrid');//refrescar la grilla con id generado
                        //regenerar el file-upload-add para que use el id generado
                        $("#file-upload-add").empty();
                        _crearFileUploadAdd(_editData);
                    }
                    _updateImageListOnUpload(imageElementId, response)
                } else {
                    alert(response.message)
                };
            }
        };
    };

    var _updateImageListOnUpload = function (imageElementId, response) {
        if (response.isNewImage) {
            _obtenerImagenes(_editData, 1, true);
        } else {
            $('#' + imageElementId).attr('src', response.foto);
        }
    };

    var _editar = function (data) {
        var editData = {
            estrategiaID: data.EstrategiaID,
            paisID: $("#ddlPais").val(),
            imagenes: []
        };

        $("#matriz-imagenes-paginacion").empty();

        _obtenerFiltrarEstrategia(editData, 1, true).done(function () {
            showDialog("DialogAdministracionEstrategia");

            _crearFileUploadAdd(editData);

            _obtenerImagenes(editData, 1, true).done(function () {
                showDialog("matriz-comercial-dialog");
            });
        }).error(
            alert(data.message); 
            closeWaitingDialog();
        );

        return false;
    };

    var _obtenerFiltrarEstrategia = function () (data) {
        var params = { estrategiaId: data.estrategiaId };
        return $.post(_config.getFiltrarEstrategiaAction, params).done(_obtenerFiltrarEstrategiaSuccess(data));
    };

    var _obtenerFiltrarEstrategiaSuccess = function = function (editData) {
     return function (data, textStatus, jqXHR) {

        if (data.success == false) {
            alert(data.message);
            closeWaitingDialog();
            return false;
        }

        var dataImagen, imgFormat;
        $("#hdSimbolo").val(data.Simbolo);

        if (data.Activo == "1") $("#chkHabilitarOferta").attr("checked", true);
        else $("#chkHabilitarOferta").attr("checked", false);

        if (data.FlagDescripcion == "1") $("#chkVisible1").attr("checked", true);
        else $("#chkVisible1").attr("checked", false);

        if (data.FlagCEP == "1") $("#chkVisible2").attr("checked", true);
        else $("#chkVisible2").attr("checked", false);

        if (data.FlagCEP2 == "1") $("#chkVisible3").attr("checked", true);
        else $("#chkVisible3").attr("checked", false);

        if (data.FlagTextoLibre == "1") $("#chkVisible4").attr("checked", true);
        else $("#chkVisible4").attr("checked", false);

        if (data.FlagCantidad == "1") $("#chkVisible5").attr("checked", true);
        else $("#chkVisible5").attr("checked", false);

        if (data.ColorFondo != "") $("#hdColorFondo").val(data.ColorFondo);
        else $("#hdColorFondo").val("#FFF");
        ActivarDesactivarChecks();

        $("#hdCampania").val($("#ddlCampania").val());
        $("#hdTipoEstrategiaID").val(data.TipoEstrategiaID);
        $("#ddlTipoEstrategia").val(data.TipoEstrategiaID);
        $("#hdnCodigoSAP").val(data.CodigoSAP);
        SeleccionarTipoOferta();

        $("#txtAlcance").val($("#ddlPais option:selected").html());
        $("#spanCampania").val($("#ddlCampania option:selected").html());
        $("#spanTipoEstrategia").val($("#ddlTipoEstrategia option:selected").html().trim());
        $("#hdEstrategiaID").val(data.EstrategiaID);
        $("#hdTipoEstrategiaID").val(data.TipoEstrategiaID);
        $("#hdCampania").val(data.CampaniaID);
        $("#ddlCampaniaFin").val(data.CampaniaIDFin);
        $("#hdNumeroPedido").val(data.NumeroPedido);
        $("#imgSeleccionada").attr('src', rutaImagenVacia);

        $("#divInformacionAdicionalEstrategiaContenido").hide();

        $("#divImagenEstrategia").css("color", "white");
        $("#divImagenEstrategia").css("background", "#00A2E8");
        $("#divInformacionAdicionalEstrategia").css("color", "#702789");
        $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");

        $("#txtLimite").val(data.LimiteVenta);
        $("#txtDescripcion").val(data.DescripcionCUV2);
        $("#txtCUV").val(data.CUV1);
        $("#ddlEtiqueta1").val(data.EtiquetaID);
        if (data.Precio != "0") {
            $("#txtPrecio").val(parseFloat(data.Precio).toFixed(2));
        } else {
            $("#txtPrecio").val('');
        }
        $("#txtCUV2").val(data.CUV2);
        $("#ddlEtiqueta2").val(data.EtiquetaID2);
        if (data.Precio2 != "0") {
            $("#txtPrecio2").val(parseFloat(data.Precio2).toFixed(2));
        } else {
            $("#txtPrecio2").val('');
        }
        $("#txtTextoLibre").val(data.TextoLibre);
        $("#txtCantidad").val(data.Cantidad);
        $("#hdZonas").val(data.Zona);

        var strZonas = $("#hdZonas").val();
        if (strZonas != "") {
            $.jstree._reference($("#arbolRegionZona")).uncheck_all();
            var strZonasArreglo = strZonas.split(",");
            for (i = 0; i < strZonasArreglo.length; i++) {
                $("#arbolRegionZona").jstree("check_node", "#" + strZonasArreglo[i], true);
            }
        } else {
            $.jstree._reference($("#arbolRegionZona")).uncheck_all();
            $("#chkSeleccionar").attr("checked", false);
        }

        var aux1 = $('#ddlTipoEstrategia').find(':selected').data('id');

        if (aux1 == "4") {
            $("#txtOrden").val("");
            $('#div-orden').hide();

            $('#txt1-estrella').html('Oferta de Último Minuto');
            $('#txt2-estrella').hide();
        }
        else {
            $("#txtOrden").val(data.Orden);
            $('#div-orden').show();

            $('#txt1-estrella').html('Mostrar estrella');
            $('#txt2-estrella').show();
        }

        if (aux1 == "4" || aux1 == "5") {
            $("#ddlEtiqueta1").children('option').hide();
            $("#ddlEtiqueta1").children("option[data-id='1']").show();

            $("#ddlEtiqueta2").children('option').hide();
            $("#ddlEtiqueta2").children("option[data-id='3']").show();
        }
        else {
            $("#ddlEtiqueta1").children('option').show();
            $("#ddlEtiqueta2").children('option').show();
        }

        if (aux1 == "6") {
            $('.OfertaUltimoMinuto').hide();
        } else { $('.OfertaUltimoMinuto').show(); }

        if (aux1 == "7") {
            $('.Recomendados').hide();

            $("#ddlEtiqueta1").children('option').hide();
            $("#ddlEtiqueta1").children("option[data-id='1']").show();

            $("#ddlEtiqueta2").children('option').hide();
            $("#ddlEtiqueta2").children("option[data-id='5']").show();

            $('#div-orden').hide();
        }

        if (data.FlagEstrella == "1") $("#chkOfertaUltimoMinuto").attr("checked", true);
        else $("#chkEstrella").attr("checked", false);
        $(".checksPedidosAsociados").append('<div class="selectP2 borde_redondeado"><input type="text" id="txtPedidoAsociado" value="' + data.NumeroPedido + '" readonly /></div>');
        closeWaitingDialog();   
    };
};

    var _obtenerImagenes = function (data, pagina, recargarPaginacion) {
        var params = { paisID: data.paisID, estrategiaId: data.estrategiaId, pagina: pagina };
        return $.post(_config.getImagesBySapCodeAction, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
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
        };
    };

    var _mostrarPaginacion = function (numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }

        $("#matriz-imagenes-paginacion").paging(numRegistros, {
            format: '[< ncnnn >]',
            onClick: function (ev) {
                ev.preventDefault();
                var page = $(this).data('page');
                _obtenerImagenes(_editData, page, false);
            },
            onFormat: function (type) {
                switch (type) {
                    case 'block': // n and c
                        return '<div class="item"><a href="#">' + this.value + '</a></div>';
                    case 'next': // >
                        return '<div class="action"><a href= "#"><span class="ui-icon ui-icon-seek-next"></span></a></div>';
                    case 'prev': // <
                        return '<div class="action"><a href="#"><span class="ui-icon ui-icon-seek-prev"></span></a></div>';
                    case 'first': // [
                        return '<div class="action"><a href="#"><span class="ui-icon ui-icon-seek-first"></span></a></div>';
                    case 'last': // ]
                        return '<div class="action"><a href="#"><span class="ui-icon ui-icon-seek-end"></span></a></div>';
                }
            }
        });
    };

    var _mostrarListaImagenes = function (editData) {
        SetHandlebars('#matriz-comercial-item-template', editData, '#matriz-comercial-images');
        _crearFileUploadElements(editData);
    };

    return {
        editar: function (id, event) {
            event.preventDefault();
            event.stopPropagation();
            if (id) {
                waitingDialog({});

                $("#hdEstrategiaID").val(id);
                $("#hdnCodigoSAP").val("")
                $('#mensajeErrorCUV').val("")
                $('#mensajeErrorCUV2').val("");
                $(".checksPedidosAsociados").html('');

                var params = {
                    EstrategiaID: $("#hdEstrategiaID").val()
                };
                $('#ContenidoImagenes').empty();

                _editar(params);
            }

            return false;
        },
        eliminar: function (id, event) {
            event.preventDefault();
            event.stopPropagation();

            var elimina = confirm('¿ Está seguro que desea deshabiltar la estrategia seleccionada?');
            if (!elimina)
                return false;

            if (id) {
                waitingDialog({});

                $("#hdEstrategiaID").val(id);

                var params = {
                    EstrategiaID: $("#hdEstrategiaID").val()
                };

                jQuery.ajax({
                    type: 'POST',
                    url: urlDeshabilitarEstrategia,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        alert(data.message);
                        fnGrilla();
                        closeWaitingDialog();
                    },
                    error: function (data, error) {
                        alert(data.message);
                        closeWaitingDialog();
                    }
                });
            }
            return false;
        }
    }
};