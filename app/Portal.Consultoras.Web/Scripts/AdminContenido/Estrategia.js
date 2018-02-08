
var Estrategia = function (config) {

    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || '',
        getImagesBySapCodeAction: config.getImagesBySapCodeAction || '',
        getFiltrarEstrategiaAction: config.getFiltrarEstrategiaAction || '',
        uploadAction: config.uploadAction || '',
        getImagesByCodigoSAPAction: config.getImagesByCodigoSAPAction || '',
        habilitarNemotecnico: config.habilitarNemotecnico || false,
        getImagesByNemotecnico: config.getImagesByNemotecnico,
        expValidacionNemotecnico: config.expValidacionNemotecnico,
        actualizarDescripcionComercialAction: config.actualizarDescripcionComercialAction
    };

    var _editData = {};
    var _idImagen = 0;

    var _paginadorClick = function (page) {
        var valNemotecnico = $('#txtBusquedaNemotecnico').val();
        var fnObtenerImagenes = (_config.habilitarNemotecnico && valNemotecnico) ? _obtenerImagenesByNemotecnico : _obtenerImagenesByCodigoSAP;
        fnObtenerImagenes(_editData, page, false).done(function () { closeWaitingDialog(); });
    };

    var _paginador = Paginador({ elementId: 'matriz-imagenes-paginacion', elementClick: _paginadorClick });

    var _nemotecnico = Nemotecnico({ expresionValidacion: _config.expValidacionNemotecnico });
    var _descripcionComercial = DescripcionComercial({ prefixControlDescripcionComercial: 'label-descripcioncomercial-', actualizarDescripcionComercialAction: _config.actualizarDescripcionComercialAction, isEstrategiaDescripcionComercial: true });

    var _limpiarFiltrosNemotecnico = function () {
        $('#txtBusquedaNemotecnico').val('');
        $('#chkTipoBusquedaNemotecnico').prop('checked', false);
    };

    var _matrizFileUploader = MatrizComercialFileUpload({ actualizarMatrizComercialAction: _config.actualizarMatrizComercialAction, habilitarNemotecnico: _config.habilitarNemotecnico, nemotecnico: _nemotecnico });

    var _crearFileUploadAdd = function (editData) {
        var itemData = { elementId: 'file-upload', IdMatrizComercialImagen: 0 };
        var params = _obtenerParamsFileUpload(itemData, editData);
        _matrizFileUploader.crearFileUpload(params);
        $("#file-upload .qq-upload-button span").text("Nueva Imagen");
    };

    var _obtenerParamsFileUpload = function (itemData, editData) {
        return {
            elementId: itemData.elementId,
            idMatrizComercial: editData.IdMatrizComercial,
            idImagenMatriz: itemData.idImagenMatriz,
            paisID: $("#ddlPais").val(),
            descripcionOriginal: editData.descripcionOriginal,
            codigoSAP: editData.CodigoSAP,
            onComplete: _uploadComplete
        }
    };

    var _uploadComplete = function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").css("display", "none");
            _limpiarFiltrosNemotecnico();
            if (response.success) {
                _editData.IdMatrizComercial = response.idMatrizComercial;
                _editData.CodigoSAP = response.codigoSap;
                $("#matriz-imagenes-paginacion").empty();
                //actualiza para la carga de imagenes actualizada
                _obtenerImagenesByCodigoSAP(_editData, 1, true).done(function () {
                    showDialog("matriz-comercial-dialog");
                });
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
            imagen: _obtenerImagenGrilla(id),
            descripcionOriginal: jQuery("#list").jqGrid('getCell', _idImagen, 'DescripcionCUV2'),
            //EsOfertaIndependiente: true //jQuery("#list").jqGrid('getCell', id, 'EsOfertaIndependiente'), BPT-369
            ValidarImagen: data.ValidarImagen,
            PesoMaximo: data.PesoMaximo
        };

        _obtenerFiltrarEstrategia(_editData, id).done(function (data) {
            var TipoEstrategiaCodigo = $('#ddlTipoEstrategia').find(':selected').data('codigo');
            if (TipoEstrategiaCodigo == TipoEstrategiaIncentivosProgramaNuevas)
                $("#divPrecioValorizado").html("Ganancia");
            else
                $("#divPrecioValorizado").html("Precio Valorizado");

            showDialog("DialogAdministracionEstrategia");
            _editData.IdMatrizComercial = data.IdMatrizComercial;
            _editData.CUV2 = data.CUV2;

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

        _descripcionComercial.actualizarPais(_editData.paisID);

        return false;
    };

    var _obtenerFiltrarEstrategia = function (data, id) {
        var params = { EstrategiaID: data.EstrategiaID, cuv2: data.CUV2, CampaniaID: data.CampaniaID, TipoEstrategiaID: data.TipoEstrategiaID };
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

            if (data.EsOfertaIndependiente == "1") $("#chkEsOfertaIndependiente").attr('checked', true);
            else $("#chkEsOfertaIndependiente").attr('checked', false);

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
            if (data.ImagenMiniaturaURL == "") {
                $("#imgMiniSeleccionada").attr('src', rutaImagenVacia);
                $("#hdImagenMiniaturaURLAnterior").val('');
            } else {
                $("#imgMiniSeleccionada").attr('src', data.ImagenMiniaturaURL);
                $("#hdImagenMiniaturaURLAnterior").val(data.ImagenMiniaturaURL.replace(/^.*[\\\/]/, ''));
            }
            if (data.EsSubCampania == 1) {
                $('#chkEsSubCampania').attr('checked', true);
            } else {
                $('#chkEsSubCampania').removeAttr('checked');
            }
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
                $("#hdEstrategiaPrecioAnt").val(parseFloat(data.Precio2).toFixed(2));
            } else {
                $("#txtPrecio").val('0.00');
            }
            $("#txtCUV2").val(data.CUV2);
            $("#ddlEtiqueta2").val(data.EtiquetaID2);
            if (data.Precio2 != "0") {
                $("#txtPrecio2").val(parseFloat(data.Precio2).toFixed(2));
            } else {
                $("#txtPrecio2").val('0.00');
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
            
            if (aux1 == "4" || aux2 == "005" || aux2 == "007" || aux2 == "008" || aux2 == codigoShowRoom) {
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

            if (aux1 == "4" || aux1 == "5" || aux2 == "005" || aux2 == "007" || aux2 == "008" || aux2 == codigoShowRoom) {
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

            _editData.imagen = _obtenerImagenGrilla(id);

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
            _agregarCamposLanzamiento('img-home-desktop', data.ImgHomeDesktop);
            _agregarCamposLanzamiento('img-home-mobile', data.ImgHomeMobile);
            $("#url-video-desktop").val(data.UrlVideoDesktop);
            $("#url-video-mobile").val(data.UrlVideoMobile);
            $("#txtPrecioPublico").val(data.PrecioPublico);
            $("#txtGanancia").val(data.Ganancia);
            closeWaitingDialog();
            if ($('#ddlTipoEstrategia').find(':selected').data('codigo') == codigoShowRoom) {
                VistaNuevoProductoShowroon();
            } else {
                VistaNuevoProductoGeneral();
            }

            return data;
        };
    };

    var _obtenerImagenGrilla = function (id) {
        if (id == 0) return "";
        var imagen = jQuery("#list").jqGrid('getCell', id, 'ImagenURL') || "";
        return (imagen == rutaImagenVacia) ? "" : $.trim(imagen);
    };

    var _obtenerImagenes = function (data, pagina, recargarPaginacion) {
        var params = { paisID: data.paisID, estragiaId: data.EstrategiaID, cuv2: data.CUV2, CampaniaID: data.CampaniaID, TipoEstrategiaID: data.TipoEstrategiaID, pagina: pagina };
        return $.post(_config.getImagesBySapCodeAction, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
    };

    var _obtenerImagenesByNemotecnico = function (data, pagina, recargarPaginacion) {
        var tipoBusqueda = $("#chkTipoBusquedaNemotecnico:checked").length === 1 ? 2 : 1;
        var nemoTecnico = tipoBusqueda === 1 ? _nemotecnico.normalizarParametro($('#txtBusquedaNemotecnico').val()) : $('#txtBusquedaNemotecnico').val();
        var params = { paisID: data.paisID, codigoSAP: data.CodigoSAP, nemoTecnico: nemoTecnico, tipoBusqueda: tipoBusqueda, pagina: pagina };

        return $.post(_config.getImagesByNemotecnico, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
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
            marcarCheckRegistro(_obtenerImagenGrilla(_idImagen));

            closeWaitingDialog();
            return data;
        }
    };
    var _obtenerImagenesByCodigoSAP = function (data, pagina, recargarPaginacion) {
        var params = { paisID: $("#ddlPais").val(), codigoSAP: data.CodigoSAP, pagina: pagina };
        return $.post(_config.getImagesByCodigoSAPAction, params).done(_obtenerImagenesByCodigoSAPSuccess(data, recargarPaginacion));
    };
    var _limpiarBusquedaNemotecnico = function () {
        _limpiarFiltrosNemotecnico();
        waitingDialog({});
        _obtenerImagenesByCodigoSAP(_editData, 1, true);
    };

   

    var _obtenerImagenesByCodigoSAPSuccess = function (editData, recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            editData.imagenes = data.imagenes;
            _editData = editData;

            if (recargarPaginacion) {
                $("#matriz-imagenes-paginacion").empty();
            }

            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(_editData);
            marcarCheckRegistro(_obtenerImagenGrilla(_idImagen));
            closeWaitingDialog();
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
        _obtenerImagenesByNemotecnico(_editData, 1, true);
    };


    var _limpiarCamposLanzamiento = function(nombreCampo) {
        $("#nombre-" + nombreCampo).val("");
        $("#src-" + nombreCampo).attr("src", rutaImagenVacia);
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
        $('#imgMiniSeleccionada').attr("src", rutaImagenVacia);
        $("#hdImagenMiniaturaURLAnterior").val('');
        $('#imgZonaEstrategia').attr("src", rutaImagenVacia);
        $('#chkEsSubCampania').removeAttr('checked');
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
        _limpiarCamposLanzamiento('img-home-desktop');
        _limpiarCamposLanzamiento('img-home-mobile');
        $("#url-video-desktop").val("");
        $("#url-video-mobile").val("");
        $("#txtPrecioPublico").val("");
        $("#txtGanancia").val("");
        if ($("#hdEstrategiaCodigo").val() === '005') $('#div-revista-digital').show();
        else $('#div-revista-digital').hide();

    };

    

    var _agregarCamposLanzamiento = function agregarCamposLanzamiento(nombreCampo, valor) {
        $("#nombre-" + nombreCampo).val(valor);
        $("#src-" + nombreCampo).attr("src", urlS3 + valor);
    };

    var _mostrarInformacionCUV = function mostrarInformacionCUV(cuvIngresado, isNuevo) {
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
            else if (auxOD == '9' || auxOD == '10' || auxOD == '11' || auxOD == '12') {
                flagOD = auxOD;
            }
            else if (!isNuevo) {
                flagOD = '99';
            }
            else {
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
                            $("#txtPrecio").val(data.precio);
                            $("#txtGanancia").val(data.ganancia);
                        }
                        else if (data.wsprecio === 0.0) {
                            if (data.precio === 0.0) {
                                $("#txtPrecio2").val(parseFloat(data.precio).toFixed(2));
                            }
                            else {
                                $("#txtPrecio2").val(parseFloat(data.precio).toFixed(2));
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

                        _editData.CUV2 = $("#txtCUV2").val();
                        _editData.CodigoSAP = data.codigoSAP;
                        _editData.IdMatrizComercial = data.idMatrizComercial;
                        _editData.imagenes = [];
                        _editData.imagen = _obtenerImagenGrilla(_idImagen);

                        _limpiarFiltrosNemotecnico();

                        _crearFileUploadAdd(_editData);

                        _obtenerImagenesByCodigoSAP(_editData, 1, true).done(function () {
                            showDialog("matriz-comercial-dialog");
                        });

                        $('#file-upload').show();

                        $("#divInformacionAdicionalEstrategiaContenido").hide();

                        $('#mensajeErrorCUV2').val("");
                    } else {
                        $('#mensajeErrorCUV2').val(data.message);
                        alert($('#mensajeErrorCUV2').val());
                        $("#txtDescripcion").val("");
                        $("#txtPrecio2").val("");

                        $("#txtPrecio").val("");
                        $("#txtCUV").val("");
                        try {
                            for (var i = 1; i <= 10; i++) {
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
                        } catch (e) {
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

    var _actualizarParNemotecnico = function (val) {
        _config.habilitarNemotecnico = val;
        _matrizFileUploader.actualizarParNemotecnico(val);
    };

    var _editarDescripcionComercial = function (idImagen) {
        _descripcionComercial.editarDescripcionComercial(idImagen);
    };

    return {
        editar: function (id, event) {
            event.preventDefault();
            event.stopPropagation();

            if (id != 0)
                isNuevo = false;

            if (id) {
                estrategiaObj.limpiarFiltrosNemotecnico();

                waitingDialog({});

                $("#hdEstrategiaID").val(id);

                _clearFields();

                var params = {
                    EstrategiaID: $("#hdEstrategiaID").val(),
                    TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                    CampaniaID: $("#ddlCampania").val(),
                    ValidarImagen: $("#ddlTipoEstrategia option:selected").attr("data-FValidarImagen"),
                    PesoMaximo: $("#ddlTipoEstrategia option:selected").attr("data-PesoMaximo")
                };

                _idImagen = id;
                _editar(params, id);
            }

            return false;
        },
        mostrarInformacionCUV: function (cuv2, isNuevo) {

            _mostrarInformacionCUV(cuv2, isNuevo);
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
        },
        remover: function (id, event) {
            event.preventDefault();
            event.stopPropagation();
            var elimina = confirm('¿Está seguro que desea eliminar el set seleccionado?');
            if (!elimina){
                return false;
            }
            if (id) {
                waitingDialog({});
                $("#hdEstrategiaID").val(id);
                var params = { EstrategiaID: $("#hdEstrategiaID").val() };
                jQuery.ajax({
                    type: 'POST',
                    url: urlEliminarEstrategia,
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
        },
        actualizarParNemotecnico: _actualizarParNemotecnico,
        habilitarNemotecnico: _config.habilitarNemotecnico,
        buscarNemotecnico: _buscarNemotecnico,
        limpiarBusquedaNemotecnico: _limpiarBusquedaNemotecnico,
        limpiarFiltrosNemotecnico: _limpiarFiltrosNemotecnico,
        editarDescripcionComercial: _editarDescripcionComercial,
        obtenerImagenes: _obtenerImagenes
    }
};