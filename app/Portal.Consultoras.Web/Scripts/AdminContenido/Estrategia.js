var Estrategia = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        getImagesBySapCodeAction: config.getImagesBySapCodeAction || '',
        getFiltrarEstrategiaAction: config.getFiltrarEstrategiaAction || '',
        uploadAction: config.uploadAction || '',
        getImagesByCodigoSAPAction: config.getImagesByCodigoSAPAction
    };

    var _editData = {};

    var _paginadorClick = function (page) {
        _obtenerImagenes(_editData, page).done(function () {
            showDialog("matriz-comercial-dialog");
            closeWaitingDialog();
        });
    };

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick });

    var _crearFileUploadAdd = function (editData) {
        var itemData = { elementId: 'file-upload', IdMatrizComercialImagen: 0 };
        _crearObjetoUpload(itemData, editData);
        $("#file-upload .qq-upload-button span").text("Nueva Imagen");
    };

    var _crearObjetoUpload = function (itemData, editData) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ['jpg', 'png', 'jpeg'],
            element: document.getElementById(itemData.elementId),
            action: _config.actualizarMatrizComercialAction,
            params: {
                IdMatrizComercial: editData.IdMatrizComercial,
                IdMatrizComercialImagen: itemData.IdMatrizComercialImagen,
                CodigoSAP: editData.CodigoSAP,
                Foto: itemData.foto,
                PaisID: editData.paisID
            },
            onComplete: _uploadComplete,
            onSubmit: function (id, fileName) { $(".qq-upload-list").css("display", "none"); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    };

    var _uploadComplete = function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").css("display", "none");
            if (response.success) {
                _editData.IdMatrizComercial = response.idMatrizComercial;
                if (response.isNewRecord) {
                    //$('#list').trigger('reloadGrid');//refrescar la grilla con id generado
                    //regenerar el file-upload-add para que use el id generado
                    //$("#file-upload-add").empty();
                    //_crearFileUploadAdd(_editData);
                }
                $("#matriz-imagenes-paginacion").empty();
                _obtenerImagenes(_editData, 1, true);
            } else {
                alert(response.message);
            };
        }
        closeWaitingDialog();
    };

    var _editar = function (data, id) {
        _editData = {
            EstrategiaID: data.EstrategiaID,
            CUV2: data.CUV2,
            TipoEstrategiaID: data.TipoEstrategiaID,
            CodigoSAP: 0,
            CampaniaID: data.CampaniaID,
            IdMatrizComercial: 0,
            paisID: $("#ddlPais").val(),
            imagenes: [],
            imagen: null
        };

        _obtenerFiltrarEstrategia(_editData, id).done(function (data) {
            showDialog("DialogAdministracionEstrategia");
            _editData.IdMatrizComercial = data.IdMatrizComercial;

            _crearFileUploadAdd(_editData);

            _obtenerImagenes(_editData, 1, true).done(function () {
                showDialog("matriz-comercial-dialog");
                closeWaitingDialog();
            });
        }).error(function () {
            alert(data.message);
            closeWaitingDialog();
        }
        );

        return false;
    };

    var _obtenerFiltrarEstrategia = function (data, id) {
        var params = { EstrategiaID: data.EstrategiaID, cuv2: data.CUV2, CampaniaID: data.CampaniaID, TipoEstrategiaID: data.TipoEstrategiaID};
        return $.post(_config.getFiltrarEstrategiaAction, params).done(_obtenerFiltrarEstrategiaSuccess(data, id));
    };

    var _obtenerFiltrarEstrategiaSuccess = function (editData, id) {
     return function (data, textStatus, jqXHR) {

        if (data.success == false) {
            alert(data.message);
            closeWaitingDialog();
            return false;
        }

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
        _editData.CodigoSAP = data.CodigoSAP;
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
        var aux2 = $("#hdEstrategiaCodigo").val();

        if (aux1 == "4" || aux2 == "005" || aux2 == "007" || aux2 == "008") {
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

        if (aux1 == "4" || aux1 == "5" || aux2 == "005" || aux2 == "007" || aux2 == "008") {
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

        $('#file-upload').show();

        if (id != 0) {
            var imagen = jQuery("#list").jqGrid('getCell', id, 'ImagenURL') || "";
            _editData.imagen = imagen == rutaImagenVacia ? "" : $.trim(imagen);
        };

        if (data.FlagEstrella == "1") $("#chkOfertaUltimoMinuto").attr("checked", true);
        else $("#chkEstrella").attr("checked", false);
        $(".checksPedidosAsociados").append('<div class="selectP2 borde_redondeado"><input type="text" id="txtPedidoAsociado" value="' + data.NumeroPedido + '" readonly /></div>');

        _agregarCamposLanzamiento('img-fondo-desktop', data.ImgFondoDesktop);
        _agregarCamposLanzamiento('img-prev-desktop', data.ImgPrevDesktop);
        //_agregarCamposLanzamiento('img-fondo-mobile', data.ImgFondoMobile);
        _agregarCamposLanzamiento('img-ficha-desktop', data.ImgFichaDesktop);
        _agregarCamposLanzamiento('img-ficha-mobile', data.ImgFichaMobile);
        _agregarCamposLanzamiento('img-ficha-fondo-desktop', data.ImgFichaFondoDesktop);
        _agregarCamposLanzamiento('img-ficha-fondo-mobile', data.ImgFichaFondoMobile);
        $("#url-video-desktop").val(data.UrlVideoDesktop);
        $("#url-video-mobile").val(data.UrlVideoMobile);

        closeWaitingDialog();

        return data;
    };
};

    var _obtenerImagenes = function (data, pagina, recargarPaginacion) {
        var params = { paisID: data.paisID, estragiaId: data.EstrategiaID, cuv2: data.CUV2, CampaniaID: data.CampaniaID, TipoEstrategiaID: data.TipoEstrategiaID, pagina: pagina };
        return $.post(_config.getImagesBySapCodeAction, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
    };

    var _obtenerImagenesSuccess = function (editData, recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            editData.imagenes = data.imagenes;
            _editData = editData;

            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(_editData);
            marcarCheckRegistro(_editData.imagen);
        };
    };
    var _obtenerImagenesByCodigoSAP = function (data, pagina, recargarPaginacion) {
        var params = { paisID: data.paisID, estragiaId: data.EstrategiaID, codigoSAP: data.CodigoSAP, CampaniaID: data.CampaniaID, TipoEstrategiaID: data.TipoEstrategiaID, pagina: pagina };
        return $.post(_config.getImagesByCodigoSAPAction, params).done(_obtenerImagenesByCodigoSAPSuccess(data, recargarPaginacion));
    };
    
    var _obtenerImagenesByCodigoSAPSuccess = function (editData, recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            editData.imagenes = data.imagenes;
            _editData = editData;
            
            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(_editData);
            marcarCheckRegistro(_editData.imagen);
        };
    };

    function marcarCheckRegistro(imgRow) {
        $('.chkImagenProducto[value="' + imgRow + '"]').first().attr('checked', 'checked');
        imagen = imgRow;
        $("#imgSeleccionada").attr("src", imagen);
    }

    var _mostrarPaginacion = function (numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }

        _paginador.paginar(numRegistros);
        
    };

    var _mostrarListaImagenes = function (editData) {
        SetHandlebars('#matriz-comercial-item-template', editData, '#matriz-comercial-images');
    };

    var _clearFields = function () {

        $("#hdnCodigoSAP").val("")
        $('#mensajeErrorCUV').val("")
        $('#mensajeErrorCUV2').val("");
        $(".checksPedidosAsociados").html('');

        $('#hdColorFondo').val("#FFF");
        ActivarDesactivarChecks();
        $(".checksPedidosAsociados").html('');

        $('#txtCUV2').val('');
        $('#txtPrecio2').val('');
        $('#txtCUV').val('');
        $('#txtPrecio').val('');
        $('#txtDescripcion').val('');

        $('#matriz-imagenes-paginacion').empty();
        $('#matriz-comercial-images').empty();
        $('#file-upload').hide();

        $('#imgSeleccionada').attr("src", rutaImagenVacia);
        $('#imgZonaEstrategia').attr("src", rutaImagenVacia);

        $("#divImagenEstrategiaContenido").show();
        $("#divInformacionAdicionalEstrategiaContenido").hide();

        $("#divImagenEstrategia").css("color", "white");
        $("#divImagenEstrategia").css("background", "#00A2E8");
        $("#divInformacionAdicionalEstrategia").css("color", "#702789");
        $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");
        $("#txtTextoLibre").val("");
        _limpiarCamposLanzamiento('img-fondo-desktop');
        _limpiarCamposLanzamiento('img-prev-desktop');
        //_limpiarCamposLanzamiento('img-fondo-mobile');
        _limpiarCamposLanzamiento('img-ficha-desktop');
        _limpiarCamposLanzamiento('img-ficha-mobile');
        _limpiarCamposLanzamiento('img-ficha-fondo-desktop');
        _limpiarCamposLanzamiento('img-ficha-fondo-mobile');
        $("#url-video-desktop").val("");
        $("#url-video-mobile").val("");
        if ($("#hdEstrategiaCodigo").val() === '005') $('#div-revista-digital').show();
        else $('#div-revista-digital').hide();

    };
    var _limpiarCamposLanzamiento = function limpiarCamposLanzamiento(nombreCampo) {
        $("#nombre-" + nombreCampo).val("");
        $("#src-" + nombreCampo).attr("src", rutaImagenVacia);
    };
    var _agregarCamposLanzamiento = function agregarCamposLanzamiento(nombreCampo, valor) {
        $("#nombre-" + nombreCampo).val(valor);
        $("#src-" + nombreCampo).attr("src", urlS3 + valor);
    };
    var _mostrarInformacionCUV = function mostrarInformacionCUV(cuvIngresado) {
        $("#hdnCodigoSAP").val("");
        $("#hdnEnMatrizComercial").val("");
        if (cuvIngresado.length == 5) {
            waitingDialog({});
            $.ajaxSetup({ cache: false });

            var flagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
            var flagRecoProduc = $("#ddlTipoEstrategia option:selected").attr("flag-recoproduct");
            var flagRecoPerfil = $("#ddlTipoEstrategia option:selected").attr("flag-recoperfil");
            var auxOD = $('#ddlTipoEstrategia').find(':selected').data('id');

            var flagOD = "";
            if (auxOD == '7') {
                flagOD = '4';
            }
            else if (auxOD == '9' || auxOD == '10' || auxOD == '11') {
                flagOD = auxOD;
            } else {
                flagOD = '0';
            }

            var params = {
                CampaniaID: $("#ddlCampania").val(),
                CUV2: $("#txtCUV2").val(),
                TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                CUV1: "0",
                flag: flagOD,
                FlagNueva: flagNueva,
                FlagRecoProduc: flagRecoProduc,
                FlagRecoPerfil: flagRecoPerfil
            };

            jQuery.ajax({
                type: 'POST',
                url: urlGetOfertaByCUV,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(params),
                async: true,
                success: function (data) {
                    var objPreview, objChkImagen, idImagen, dataImagen, imgFormat;
                    $('#mensajeErrorCUV').val("");

                    if (data.message == "OK") {
                        $("#txtDescripcion").val(data.descripcion);

                        if (data.wsprecio > 0) {
                            $("#txtPrecio2").val(parseFloat(data.wsprecio).toFixed(2));
                            $("#txtPrecio2")[0].disabled = true;
                        }
                        else if (data.wsprecio == 0) {
                            if (data.precio == 0) {
                                $("#txtPrecio2").val(parseFloat(data.precio).toFixed(2));
                                $("#txtPrecio2")[0].disabled = true;
                            }
                            else {
                                $("#txtPrecio2").val(parseFloat(data.precio).toFixed(2));
                                $("#txtPrecio2")[0].disabled = true;
                            }
                        }
                        else if (data.wsprecio == -1) {
                            $("#txtPrecio2")[0].disabled = true;
                            alert("No se pudo  obtener el precio del producto. Por favor, comunicarse con Soporte Digital Consultoras");
                        }
                        else if (data.wsprecio == -2) {
                            $("#txtPrecio2")[0].disabled = false;
                            $("#txtPrecio2").val("");
                            $("#txtPrecio2").focus();
                        }

                        $("#hdnCodigoSAP").val(data.codigoSAP);
                        $("#hdnEnMatrizComercial").val(data.enMatrizComercial);

                        //Carga de Imagenes
                        _editData = {
                            EstrategiaID: 0,
                            CUV2: '',
                            TipoEstrategiaID: 0,
                            CodigoSAP: data.codigoSAP,
                            CampaniaID: 0,
                            IdMatrizComercial: data.idMatrizComercial,
                            paisID: $("#ddlPais").val(),
                            imagenes: [],
                            imagen: null
                        };

                        _crearFileUploadAdd(_editData);

                        _obtenerImagenesByCodigoSAP(_editData, 1, true).done(function () {
                            showDialog("matriz-comercial-dialog");
                        });

                        $('#file-upload').show();

                        $("#divInformacionAdicionalEstrategiaContenido").hide();

                        $('#mensajeErrorCUV2').val("");
                        closeWaitingDialog();
                    } else {
                        $('#mensajeErrorCUV2').val(data.message);
                        alert($('#mensajeErrorCUV2').val());
                        $("#txtDescripcion").val("");
                        $("#txtPrecio2").val("");

                        $("#txtPrecio").val("");
                        $("#txtCUV").val("");
                        try {
                            for (var i = 1; i <= nroImagenes; i++) {
                                idImagen = ('0' + i).substr(-2);
                                objPreview = $('#preview' + i);
                                objChkImagen = $('#chkImagenProducto' + idImagen);
                                dataImagen = data['imagen' + i];

                                if (dataImagen != '') {
                                    objPreview.attr('src', data.imagen1);
                                    objChkImagen.attr('disabled', false);
                                }
                                else {
                                    objPreview.attr('src', rutaImagenVacia);
                                    objChkImagen.attr('disabled', true);
                                }
                                objChkImagen.attr('checked', false);
                            }
                        }catch (e) {
                            console.error('error al procesar nroImagenes');
                        }
                        closeWaitingDialog();
                    }
                },
                error: function (data, error) {
                    closeWaitingDialog();
                    alert(data.message);
                }
            });
        }
    }

    return {
        editar: function (id, event) {
            event.preventDefault();
            event.stopPropagation();

            if (id != 0)
                isNuevo = false;

            if (id) {
                waitingDialog({});

                $("#hdEstrategiaID").val(id);
               

                _clearFields();
               
                var params = {
                    EstrategiaID: $("#hdEstrategiaID").val()
                };

                _editar(params, id);
            }

            return false;
        },
        mostrarInformacionCUV: function (cuv2) {

            _mostrarInformacionCUV(cuv2);
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