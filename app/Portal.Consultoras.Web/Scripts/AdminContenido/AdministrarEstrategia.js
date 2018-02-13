var AdministrarEstrategia = (function(config) {
    var _config = {
        actualizarMatrizComercialAction: config.actualizarMatrizComercialAction || "",
        getImagesBySapCodeAction: config.getImagesBySapCodeAction || "",
        getFiltrarEstrategiaAction: config.getFiltrarEstrategiaAction || "",
        uploadAction: config.uploadAction || "",
        getImagesByCodigoSAPAction: config.getImagesByCodigoSAPAction || "",
        habilitarNemotecnico: config.habilitarNemotecnico || false,
        getImagesByNemotecnico: config.getImagesByNemotecnico,
        expValidacionNemotecnico: config.expValidacionNemotecnico,
        actualizarDescripcionComercialAction: config.actualizarDescripcionComercialAction,
        tipoEstrategiaIncentivosProgramaNuevas: config.TipoEstrategiaIncentivosProgramaNueva,
        rutaImagenVacia: config.rutaImagenVacia,
        urlActivarDesactivarEstrategias: config.urlActivarDesactivarEstrategias,
        rutaImagenEdit: config.rutaImagenEdit,
        rutaImagenDelete: config.rutaImagenDelete,
        urlGetOfertaByCUV: config.urlGetOfertaByCUV,
        urlS3: config.urlS3,
        rutaTemporal: config.rutaTemporal,
        urlConsultarCuvTipoConfigurado: config.urlConsultarCuvTipoConfigurado,
        urlConsultarCuvTipoConfiguradoTemporal: config.urlConsultarCuvTipoConfiguradoTemporal,
        urlDeshabilitarEstrategia: config.urlDeshabilitarEstrategia,
        urlImageLanzamientoUpload: config.urlImageLanzamientoUpload,
        urlUploadCvs: config.UploadCvs
    };

    var _variables = {
        isNuevo: false,
        cantidadPrecargar: 0,
        cantidadPrecargar2: 0,
        imagen: "",
        isVistaPreviaOpened: false
    }

    var _codigoEstrategia = {
        OfertaParaTi: "001",
        PackNuevas: "002",
        OfertaWeb: "003",
        Lanzamiento: "005",
        OfertasParaMi: "007",
        PackAltoDesembolso: "008",
        OfertaDelDia: "009",
        GuiaDeNegocio: "010",
        LosMasVendidos: "020",
        HerramientaVenta: "011"
    }
    var _idEstrategia = {
        OfertaParaTi: 4,
        PackNuevas: 6,
        //OfertaWeb: "003",
        Lanzamiento: 9,
        OfertasParaMi: 10,
        PackAltoDesembolso: 11,
        OfertaDelDia: 7,
        GuiaDeNegocio: 12,
        LosMasVendidos: 20
    }

    var _editData = {};
    var _idImagen = 0;

    var _paginadorClick = function(page) {
        var valNemotecnico = $("#txtBusquedaNemotecnico").val();
        var fnObtenerImagenes = (_config.habilitarNemotecnico && valNemotecnico)
            ? _obtenerImagenesByNemotecnico
            : _obtenerImagenesByCodigoSAP;
        fnObtenerImagenes(_editData, page, false).done(function() { closeWaitingDialog(); });
    };

    var _paginador = Paginador({
        elementId: "matriz-" +
            "imagen" +
            "es-paginacion",
        elementClick: _paginadorClick
    });

    var _mostrarPaginacion = function(numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }

        _paginador.paginar(numRegistros);

    };
    var _mostrarListaImagenes = function(editData) {
        SetHandlebars("#matriz-comercial-item-template", editData, "#matriz-comercial-images");
        $(".qq-upload-list").css("display", "none");
    };

    var _agregarCamposLanzamiento = function(nombreCampo, valor) {
        $("#nombre-" + nombreCampo).val(valor);
        $("#src-" + nombreCampo).attr("src", _config.urlS3 + valor);
    };

    var _paletaColores = function() {
        $("#txtColorFondo").spectrum({
            color: $("#hdColorFondo").val(),
            showInput: true,
            className: "full-spectrum",
            showInitial: true,
            showPalette: true,
            showSelectionPalette: true,
            maxPaletteSize: 10,
            preferredFormat: "hex",
            localStorageKey: "spectrum.demo",
            move: function(color) {

            },
            show: function() {

            },
            beforeShow: function() {

            },
            hide: function() {

            },
            change: function() {
                $("#hdColorFondo").val($(this).val());
            },
            palette: [
                [
                    "rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
                    "rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)"
                ],
                [
                    "rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
                    "rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"
                ],
                [
                    "rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)",
                    "rgb(217, 234, 211)",
                    "rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)",
                    "rgb(234, 209, 220)",
                    "rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)",
                    "rgb(182, 215, 168)",
                    "rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)",
                    "rgb(213, 166, 189)",
                    "rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)",
                    "rgb(147, 196, 125)",
                    "rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)",
                    "rgb(194, 123, 160)",
                    "rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
                    "rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)",
                    "rgb(166, 77, 121)",
                    "rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
                    "rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"
                ]
            ]
        });
    }
    var _activarDesactivarChecks = function() {
        $(".activar-desactivar").each(function() {
            if (!$(this).attr("checked")) {
                $(this).parent().parent().find("input").each(function() {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", true);
                });
                $(this).parent().parent().find("select").each(function() {
                    $(this).val("");
                    $(this).attr("disabled", true);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            } else {
                $(this).parent().parent().find("input").each(function() {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", false);
                });
                $(this).parent().parent().find("select").each(function() {
                    $(this).val("");
                    $(this).attr("disabled", false);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            }
        });
    }
    var _obtenerImagenGrilla = function(id) {
        if (id === 0) return "";
        var imagen = jQuery("#list").jqGrid("getCell", id, "ImagenURL") || "";
        return (imagen === _config.rutaImagenVacia) ? "" : $.trim(imagen);
    };

    var _seleccionarTipoOferta = function() {
        var flagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
        var flagRecoProduc = $("#ddlTipoEstrategia option:selected").attr("flag-recoproduct");
        var flagRecoPerfil = $("#ddlTipoEstrategia option:selected").attr("flag-recoperfil");
        var codigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");;

        (flagNueva == "1") ? $(".chkEsOfertaIndependiente").show() : $(".chkEsOfertaIndependiente").hide();

        $("#ddlCampaniaFin").val("");
        $("#list").jqGrid("hideCol", ["NumeroPedido"]);
        if (flagNueva === "1") {
            $(".DatosNuevas").show();
            $(".OcultarNuevas").css({ visibility: "hidden" });
            $("#txtLimite").val("1");
            $("#list").jqGrid("showCol", ["NumeroPedido"]);
            $(".DatosNuevas .checksPedidosAsociados").prev().css("display", "");
            $(".DatosNuevas .checksPedidosAsociados").css("display", "");
        } else {
            if (codigo === _config.tipoEstrategiaIncentivosProgramaNuevas) {
                $(".DatosNuevas").show();
                $(".OcultarNuevas").css({ visibility: "hidden" });
                $(".DatosNuevas .checksPedidosAsociados").prev().css("display", "none");
                $(".DatosNuevas .checksPedidosAsociados").css("display", "none");
            } else {
                $(".DatosNuevas").hide();
                $(".OcultarNuevas").css({ visibility: "visible" });
                $(".DatosNuevas .checksPedidosAsociados").prev().css("display", "");
                $(".DatosNuevas .checksPedidosAsociados").css("display", "");
            }
            $("#txtLimite").val("99");
        }
        if (flagRecoProduc == "1" || flagRecoPerfil == "1") {
            $(".Recomendados").show();
            if (flagRecoProduc == "1") {
                $("#idEstrella").hide();
                $("#idColorFondo").show();
            }
            if (flagRecoPerfil == "1") {
                $("#idColorFondo").hide();
                $("#idEstrella").show();
                $("#idEstrella").attr("checked", false);
            }
        } else {
            $(".Recomendados").hide();
        }
    }

    var _nemotecnico = Nemotecnico({ expresionValidacion: _config.expValidacionNemotecnico });
    var _descripcionComercial = DescripcionComercial({
        prefixControlDescripcionComercial: "label-descripcioncomercial-",
        actualizarDescripcionComercialAction: _config.actualizarDescripcionComercialAction,
        isEstrategiaDescripcionComercial: true
    });

    var _limpiarFiltrosNemotecnico = function() {
        $("#txtBusquedaNemotecnico").val("");
        $("#chkTipoBusquedaNemotecnico").prop("checked", false);
    };

    var _matrizFileUploader = MatrizComercialFileUpload({
        actualizarMatrizComercialAction: _config.actualizarMatrizComercialAction,
        habilitarNemotecnico: _config.habilitarNemotecnico,
        nemotecnico: _nemotecnico
    });
    var _uploadComplete = function(id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").css("display", "none");
            _limpiarFiltrosNemotecnico();
            if (response.success) {
                _editData.IdMatrizComercial = response.idMatrizComercial;
                _editData.CodigoSAP = response.codigoSap;
                $("#matriz-imagenes-paginacion").empty();
                //actualiza para la carga de imagenes actualizada
                _obtenerImagenesByCodigoSAP(_editData, 1, true).done(function() {
                    showDialog("matriz-comercial-dialog");
                });
            } else {
                _toastHelper.error(response.message);
            };
        }
        closeWaitingDialog();
    };
    var _obtenerParamsFileUpload = function(itemData, editData) {
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
    var _crearFileUploadAdd = function(editData) {
        var itemData = { elementId: "file-upload", IdMatrizComercialImagen: 0 };
        var params = _obtenerParamsFileUpload(itemData, editData);
        _matrizFileUploader.crearFileUpload(params);
        $("#file-upload .qq-upload-button span").text("Nueva Imagen");
    };

    var _editar = function(data, id) {

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
            descripcionOriginal: jQuery("#list").jqGrid("getCell", _idImagen, "DescripcionCUV2"),
            ValidarImagen: data.ValidarImagen,
            PesoMaximo: data.PesoMaximo
        };

        _obtenerFiltrarEstrategia(_editData, id).done(function(data) {
            var TipoEstrategiaCodigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");
            if (TipoEstrategiaCodigo == _config.tipoEstrategiaIncentivosProgramaNuevas)
                $("#divPrecioValorizado").html("Ganancia");
            else
                $("#divPrecioValorizado").html("Precio Valorizado");

            showDialog("DialogAdministracionEstrategia");
            _editData.IdMatrizComercial = data.IdMatrizComercial;
            _editData.CUV2 = data.CUV2;

            _crearFileUploadAdd(_editData);

            _obtenerImagenes(_editData, 1, true).done(function() {
                showDialog("matriz-comercial-dialog");
                closeWaitingDialog();
            });
        }).error(function() {
            _toastHelper.error(data.message);
            closeWaitingDialog();
        });

        _descripcionComercial.actualizarPais(_editData.paisID);
        return false;
    };

    var _editarDescripcionComercial = function(idImagen) {
        _descripcionComercial.editarDescripcionComercial(idImagen);
    };

    var _obtenerFiltrarEstrategia = function(data, id) {
        var params = {
            EstrategiaID: data.EstrategiaID,
            cuv2: data.CUV2,
            CampaniaID: data.CampaniaID,
            TipoEstrategiaID: data.TipoEstrategiaID
        };
        return $.post(_config.getFiltrarEstrategiaAction, params).done(_obtenerFiltrarEstrategiaSuccess(data, id));
    };

    var _obtenerFiltrarEstrategiaSuccess = function(editData, id) {
        return function(data, textStatus, jqXHR) {

            if (data.success == false) {
                _toastHelper.success(data.message);
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

            if (data.EsOfertaIndependiente == "1") $("#chkEsOfertaIndependiente").attr("checked", true);
            else $("#chkEsOfertaIndependiente").attr("checked", false);

            _activarDesactivarChecks();

            $("#hdCampania").val($("#ddlCampania").val());
            $("#hdTipoEstrategiaID").val(data.TipoEstrategiaID);
            $("#ddlTipoEstrategia").val(data.TipoEstrategiaID);
            $("#hdnCodigoSAP").val(data.CodigoSAP);

            _editData.CodigoSAP = data.CodigoSAP;

            _seleccionarTipoOferta();

            $("#txtAlcance").val($("#ddlPais option:selected").html());
            $("#spanCampania").val($("#ddlCampania option:selected").html());
            $("#spanTipoEstrategia").val($("#ddlTipoEstrategia option:selected").html().trim());
            $("#hdEstrategiaID").val(data.EstrategiaID);
            $("#hdTipoEstrategiaID").val(data.TipoEstrategiaID);
            $("#hdCampania").val(data.CampaniaID);
            $("#ddlCampaniaFin").val(data.CampaniaIDFin);
            $("#hdNumeroPedido").val(data.NumeroPedido);
            $("#imgSeleccionada").attr("src", _config.rutaImagenVacia);

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
                $("#txtPrecio").val("0.00");
            }
            $("#txtCUV2").val(data.CUV2);
            $("#ddlEtiqueta2").val(data.EtiquetaID2);
            if (data.Precio2 != "0") {
                $("#txtPrecio2").val(parseFloat(data.Precio2).toFixed(2));
            } else {
                $("#txtPrecio2").val("0.00");
            }
            $("#txtTextoLibre").val(data.TextoLibre);
            $("#txtCantidad").val(data.Cantidad);
            $("#hdZonas").val(data.Zona);

            //var strZonas = $("#hdZonas").val();
            //if (strZonas != "") {
            //    $.jstree._reference($("#arbolRegionZona")).uncheck_all();
            //    var strZonasArreglo = strZonas.split(",");
            //    for (i = 0; i < strZonasArreglo.length; i++) {
            //        $("#arbolRegionZona").jstree("check_node", "#" + strZonasArreglo[i], true);
            //    }
            //} else {
            //    $.jstree._reference($("#arbolRegionZona")).uncheck_all();
            //    $("#chkSeleccionar").attr("checked", false);
            //}

            var aux1 = $("#ddlTipoEstrategia").find(":selected").data("id");
            var aux2 = $("#hdEstrategiaCodigo").val();

            if (aux1 == "4" || aux2 == "005" || aux2 == "007" || aux2 == "008") {
                $("#txtOrden").val("");
                $("#div-orden").hide();

                $("#txt1-estrella").html("Oferta de Último Minuto");
                $("#txt2-estrella").hide();
            } else {
                $("#txtOrden").val(data.Orden);
                $("#div-orden").show();

                $("#txt1-estrella").html("Mostrar estrella");
                $("#txt2-estrella").show();
            }

            if (aux1 == "4" || aux1 == "5" || aux2 == "005" || aux2 == "007" || aux2 == "008") {
                $("#ddlEtiqueta1").children("option").hide();
                $("#ddlEtiqueta1").children("option[data-id='1']").show();

                $("#ddlEtiqueta2").children("option").hide();
                $("#ddlEtiqueta2").children("option[data-id='3']").show();
            } else {
                $("#ddlEtiqueta1").children("option").show();
                $("#ddlEtiqueta2").children("option").show();
            }

            if (aux1 == "6") {
                $(".OfertaUltimoMinuto").hide();
            } else {
                $(".OfertaUltimoMinuto").show();
            }

            if (aux1 == "7") {
                $(".Recomendados").hide();

                $("#ddlEtiqueta1").children("option").hide();
                $("#ddlEtiqueta1").children("option[data-id='1']").show();

                $("#ddlEtiqueta2").children("option").hide();
                $("#ddlEtiqueta2").children("option[data-id='5']").show();

                $("#div-orden").hide();
            }

            $("#file-upload").show();

            _editData.imagen = _obtenerImagenGrilla(id);

            if (data.FlagEstrella == "1") $("#chkOfertaUltimoMinuto").attr("checked", true);
            else $("#chkEstrella").attr("checked", false);
            $(".checksPedidosAsociados")
                .append('<div class="selectP2 borde_redondeado"><input type="text" id="txtPedidoAsociado" value="' +
                    data.NumeroPedido +
                    '" readonly /></div>');

            _agregarCamposLanzamiento("img-fondo-desktop", data.ImgFondoDesktop);
            _agregarCamposLanzamiento("img-prev-desktop", data.ImgPrevDesktop);
            _agregarCamposLanzamiento("img-ficha-desktop", data.ImgFichaDesktop);
            _agregarCamposLanzamiento("img-ficha-mobile", data.ImgFichaMobile);
            _agregarCamposLanzamiento("img-ficha-fondo-desktop", data.ImgFichaFondoDesktop);
            _agregarCamposLanzamiento("img-ficha-fondo-mobile", data.ImgFichaFondoMobile);
            _agregarCamposLanzamiento("img-home-desktop", data.ImgHomeDesktop);
            _agregarCamposLanzamiento("img-home-mobile", data.ImgHomeMobile);
            $("#url-video-desktop").val(data.UrlVideoDesktop);
            $("#url-video-mobile").val(data.UrlVideoMobile);
            $("#txtPrecioPublico").val(data.PrecioPublico);
            $("#txtGanancia").val(data.Ganancia);
            closeWaitingDialog();

            return data;
        };
    };

    var _obtenerImagenes = function(data, pagina, recargarPaginacion) {
        var params = {
            paisID: data.paisID,
            estragiaId: data.EstrategiaID,
            cuv2: data.CUV2,
            CampaniaID: data.CampaniaID,
            TipoEstrategiaID: data.TipoEstrategiaID,
            pagina: pagina
        };
        return $.post(_config.getImagesBySapCodeAction, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
    }

    var _obtenerImagenesByNemotecnico = function(data, pagina, recargarPaginacion) {
        var tipoBusqueda = $("#chkTipoBusquedaNemotecnico:checked").length === 1 ? 2 : 1;
        var nemoTecnico = tipoBusqueda === 1
            ? _nemotecnico.normalizarParametro($("#txtBusquedaNemotecnico").val())
            : $("#txtBusquedaNemotecnico").val();
        var params = {
            paisID: data.paisID,
            codigoSAP: data.CodigoSAP,
            nemoTecnico: nemoTecnico,
            tipoBusqueda: tipoBusqueda,
            pagina: pagina
        };

        return $.post(_config.getImagesByNemotecnico, params).done(_obtenerImagenesSuccess(data, recargarPaginacion));
    };

    var _marcarCheckRegistro = function(imgRow) {
        $('.chkImagenProducto[value="' + imgRow + '"]').first().attr("checked", "checked");
        _variables.imagen = imgRow;
        $("#imgSeleccionada").attr("src", _variables.imagen);
    }

    var _obtenerImagenesSuccess = function(editData, recargarPaginacion) {
        return function(data, textStatus, jqXHR) {
            editData.imagenes = data.imagenes;
            _editData = editData;
            if (recargarPaginacion) {
                $("#matriz-imagenes-paginacion").empty();
            }
            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(_editData);
            _marcarCheckRegistro(_obtenerImagenGrilla(_idImagen));
            closeWaitingDialog();
            return data;
        }
    };
    var _obtenerImagenesByCodigoSAP = function(data, pagina, recargarPaginacion) {
        var params = { paisID: $("#ddlPais").val(), codigoSAP: data.CodigoSAP, pagina: pagina };
        return $.post(_config.getImagesByCodigoSAPAction, params)
            .done(_obtenerImagenesByCodigoSAPSuccess(data, recargarPaginacion));
    };

    var _obtenerImagenesByCodigoSAPSuccess = function(editData, recargarPaginacion) {
        return function(data, textStatus, jqXHR) {
            editData.imagenes = data.imagenes;
            _editData = editData;

            if (recargarPaginacion) {
                $("#matriz-imagenes-paginacion").empty();
            }

            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(_editData);
            _marcarCheckRegistro(_obtenerImagenGrilla(_idImagen));
            closeWaitingDialog();
        };
    };

    var _validarNemotecnico = function() {
        var msj = "";
        var val = $("#txtBusquedaNemotecnico").val();
        if (!val) {
            msj += " - Debe ingresar un Nemotecnico .\n";
        }

        return msj;
    };
    var _uploadFileLanzamineto = function(divId) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ["jpg", "png", "jpeg"],
            element: document.getElementById(divId),
            action: _config.urlImageLanzamientoUpload,
            onComplete: function(id, fileName, responseJSON) {
                if (checkTimeout(responseJSON)) {
                    if (responseJSON.success) {
                        $("#nombre-" + divId).val(responseJSON.name);
                        $("#src-" + divId).attr("src", _config.rutaTemporal + responseJSON.name);
                    } else _toastHelper.error(responseJSON.message);
                }
                return false;
            },
            onSubmit: function(id, fileName) { $(".qq-upload-list").remove(); },
            onProgress: function(id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
            onCancel: function(id, fileName) { $(".qq-upload-list").remove(); }
        });
        return false;
    }

    var _createGridUpdated = function(list) {
        var gridJson = { page: 1, total: 2, records: 10, rows: list };
        $("#listDescActualizada").jqGrid("GridUnload");
        $("#listDescActualizada").empty().jqGrid({
            datatype: "jsonstring",
            datastr: gridJson,
            colNames: ["CUV", "Descripcion"],
            colModel: [
                { name: "Cuv", index: "Cuv", width: 30, sortable: false },
                { name: "Descripcion", index: "Descripcion", sortable: false }
            ],
            pager: jQuery("#pagerDescActualizada"),
            jsonReader: {
                repeatitems: false
            },
            width: 540,
            height: "auto",
            scrollOffset: 20,
            rowNum: 10,
            rowList: [10, 15, 20, 25],
            sortname: "Label",
            sortorder: "asc",
            viewrecords: true,
            hoverrows: false,
            caption: "",
            beforeSelectRow: function(rowid, e) { return false; } //this disables row being highlighted when clicked
        });
    }
    var _createGridNotUpdated = function(list) {
        var gridJson = { page: 1, total: 2, records: 10, rows: list };
        $("#listDescNoActualizada").jqGrid("GridUnload");
        $("#listDescNoActualizada").empty().jqGrid({
            datatype: "jsonstring",
            datastr: gridJson,
            colNames: ["CUV", "Descripcion"],
            colModel: [
                { name: "Cuv", index: "Cuv", width: 30, sortable: false },
                { name: "Descripcion", index: "Descripcion", sortable: false }
            ],
            pager: jQuery("#pagerDescNoActualizada"),
            jsonReader: {
                repeatitems: false
            },
            width: 540,
            height: "auto",
            scrollOffset: 20,
            rowNum: 10,
            rowList: [10, 15, 20, 25],
            sortname: "Label",
            sortorder: "asc",
            viewrecords: true,
            hoverrows: false,
            caption: "",
            beforeSelectRow: function(rowid, e) { return false; } //this disables row being highlighted when clicked
        });
    }
    var _createGridTonoUpdated = function(list) {
        var gridJson = { page: 1, total: 2, records: 10, rows: list };
        $("#listTonoActualizada").jqGrid("GridUnload");
        $("#listTonoActualizada").empty().jqGrid({
            datatype: "jsonstring",
            datastr: gridJson,
            colNames: ["CUV", "Descripción"],
            colModel: [
                { name: "CUV2", index: "CUV2", width: 30, sortable: false },
                { name: "DescripcionCUV2", index: "DescripcionCUV2", sortable: false }
            ],
            pager: jQuery("#pagerTonoActualizada"),
            jsonReader: {
                repeatitems: false
            },
            width: 540,
            height: "auto",
            scrollOffset: 20,
            rowNum: 10,
            rowList: [10, 15, 20, 25],
            sortname: "Label",
            sortorder: "asc",
            viewrecords: true,
            hoverrows: false,
            caption: "",
            beforeSelectRow: function(rowid, e) { return false; } //this disables row being highlighted when clicked
        });
    }

    var _showActions = function(cellvalue, options, rowObject) {

        var Des = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Editar('" +
            rowObject[0] +
            "',event);\" >" +
            "<img src='" +
            _config.rutaImagenEdit +
            "' alt='Editar Estrategia' title='Editar Estrategia' border='0' /></a>";
        if (rowObject[10] == "1") {
            Des += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" +
                rowObject[0] +
                "',event);\" >" +
                "<img src='" +
                _config.rutaImagenDelete +
                "' alt='Deshabilitar Estrategia' title='Deshabilitar Estrategia' border='0' /></a>";
        }
        return Des;
    }
    var _showActionsVer1 = function(cellvalue, options, rowObject) {
        var text;

        var cantidad = rowObject[2];
        var tipo = rowObject[3];

        if (tipo == "2")
            _variables.cantidadPrecargar = parseInt(cantidad);

        if (cantidad != "0")
            text = rowObject[2] +
                " <a href='javascript:;' onclick=adminEstrategiaModule.VerCuvsTipo('" +
                tipo +
                "')>ver</a>";
        else
            text = rowObject[2];

        return text;
    }

    var _showActionsVer2 = function(cellvalue, options, rowObject) {
        var text;

        var cantidad = rowObject[2];
        var tipo = rowObject[3];

        if (tipo == "1") {
            _variables.cantidadPrecargar2 = parseInt(cantidad);
            $("#spnCantidadConfigurar3").html(parseInt(cantidad));
        }
        if (tipo == "2")
            $("#spnCantidadNoConfigurar3").html(parseInt(cantidad));

        if (cantidad != "0")
            text = rowObject[2] +
                " <a href='javascript:;' onclick=adminEstrategiaModule.VerCuvsTipo2('" +
                tipo +
                "')>ver</a>";
        else
            text = rowObject[2];

        return text;
    }
    var _showImage = function(cellvalue, options, rowObject) {
        var image = $.trim(rowObject[9]);
        var filename = image.replace(/^.*[\\\/]/, "");
        image = '<img src="' +
            (filename != "" ? image : _config.rutaImagenVacia) +
            '" alt="" width="70px" height="60px" title="" border="0" />';
        return image;
    }
    var _mostrarInformacionCuv = function(cuvIngresado) {
        var isNuevo = _variables.isNuevo;
        $("#hdnCodigoSAP").val("");
        $("#hdnEnMatrizComercial").val("");
        if (cuvIngresado.length == 5) {
            waitingDialog({});
            $.ajaxSetup({ cache: false });

            var flagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
            var flagRecoProduc = $("#ddlTipoEstrategia option:selected").attr("flag-recoproduct");
            var flagRecoPerfil = $("#ddlTipoEstrategia option:selected").attr("flag-recoperfil");
            var auxOD = $("#ddlTipoEstrategia").find(":selected").data("id");

            var flagOD = "";
            if (auxOD == "7") {
                flagOD = "4";
            } else if (auxOD == "9" || auxOD == "10" || auxOD == "11" || auxOD == "12") {
                flagOD = auxOD;
            } else if (!isNuevo) {
                flagOD = "99";
            } else {
                flagOD = "0";
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
                type: "POST",
                url: _config.urlGetOfertaByCUV,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    var objPreview, objChkImagen, idImagen, dataImagen, imgFormat;
                    $("#mensajeErrorCUV").val("");

                    if (data.message == "OK") {
                        $("#txtDescripcion").val(data.descripcion);

                        if (data.wsprecio > 0) {
                            $("#txtPrecio2").val(parseFloat(data.wsprecio).toFixed(2));
                            $("#txtPrecio").val(data.precio);
                            $("#txtGanancia").val(data.ganancia);
                        } else if (data.wsprecio === 0.0) {
                            $("#txtPrecio2").val(parseFloat(data.precio).toFixed(2));
                        } else if (data.wsprecio == -1) {
                            $("#txtPrecio2")[0].disabled = true;
                            _toastHelper.error(
                                "No se pudo  obtener el precio del producto. Por favor, comunicarse con Soporte Digital Consultoras");
                        } else if (data.wsprecio == -2) {
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

                        _obtenerImagenesByCodigoSAP(_editData, 1, true).done(function() {
                            showDialog("matriz-comercial-dialog");
                        });

                        $("#file-upload").show();

                        $("#divInformacionAdicionalEstrategiaContenido").hide();

                        $("#mensajeErrorCUV2").val("");
                    } else {
                        $("#mensajeErrorCUV2").val(data.message);
                        _toastHelper.error($("#mensajeErrorCUV2").val());
                        $("#txtDescripcion").val("");
                        $("#txtPrecio2").val("");

                        $("#txtPrecio").val("");
                        $("#txtCUV").val("");
                        try {
                            for (var i = 1; i <= 10; i++) {
                                idImagen = ("0" + i).substr(-2);
                                objPreview = $("#preview" + i);
                                objChkImagen = $("#chkImagenProducto" + idImagen);
                                dataImagen = data["imagen" + i];

                                if (dataImagen != "") {
                                    objPreview.attr("src", data.imagen1);
                                    objChkImagen.attr("disabled", false);
                                } else {
                                    objPreview.attr("src", _config.rutaImagenVacia);
                                    objChkImagen.attr("disabled", true);
                                }
                                objChkImagen.attr("checked", false);
                            }
                        } catch (e) {
                            _toastHelper.error("error al procesar nroImagenes");
                        }
                        closeWaitingDialog();
                    }
                },
                error: function(data, error) {
                    closeWaitingDialog();
                    _toastHelper.error(data.message);
                }
            });
        }
    }
    var _limpiarCamposLanzamiento = function(nombreCampo) {
        $("#nombre-" + nombreCampo).val("");
        $("#src-" + nombreCampo).attr("src", _config.rutaImagenVacia);
    };
    var _limpiarBusquedaNemotecnico = function() {
        _limpiarFiltrosNemotecnico();
        waitingDialog({});
        _obtenerImagenesByCodigoSAP(_editData, 1, true);
    }
    var _clearFields = function() {

        $("#hdnCodigoSAP").val("")
        $("#mensajeErrorCUV").val("")
        $("#mensajeErrorCUV2").val("");
        $(".checksPedidosAsociados").html("");

        $("#hdColorFondo").val("#FFF");
        _activarDesactivarChecks();
        $(".checksPedidosAsociados").html("");

        $("#txtCUV2").val("");
        $("#txtPrecio2").val("");
        $("#txtCUV").val("");
        $("#txtPrecio").val("");
        $("#txtDescripcion").val("");

        $("#matriz-imagenes-paginacion").empty();
        $("#matriz-comercial-images").empty();
        $("#file-upload").hide();

        $("#imgSeleccionada").attr("src", _config.rutaImagenVacia);
        $("#imgZonaEstrategia").attr("src", _config.rutaImagenVacia);

        $("#divImagenEstrategiaContenido").show();
        $("#divInformacionAdicionalEstrategiaContenido").hide();

        $("#divImagenEstrategia").css("color", "white");
        $("#divImagenEstrategia").css("background", "#00A2E8");
        $("#divInformacionAdicionalEstrategia").css("color", "#702789");
        $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");
        $("#txtTextoLibre").val("");
        _limpiarCamposLanzamiento("img-fondo-desktop");
        _limpiarCamposLanzamiento("img-prev-desktop");
        _limpiarCamposLanzamiento("img-ficha-desktop");
        _limpiarCamposLanzamiento("img-ficha-mobile");
        _limpiarCamposLanzamiento("img-ficha-fondo-desktop");
        _limpiarCamposLanzamiento("img-ficha-fondo-mobile");
        _limpiarCamposLanzamiento("img-home-desktop");
        _limpiarCamposLanzamiento("img-home-mobile");
        $("#url-video-desktop").val("");
        $("#url-video-mobile").val("");
        $("#txtPrecioPublico").val("");
        $("#txtGanancia").val("");
        if ($("#hdEstrategiaCodigo").val() === "005") $("#div-revista-digital").show();
        else $("#div-revista-digital").hide();

    };
    var _fnGrillaEstrategias1 = function() {
        $("#listCargaMasiva1").jqGrid("GridUnload");
        jQuery("#listCargaMasiva1").jqGrid({
            url: baseUrl + "AdministrarEstrategia/ConsultarOfertasParaTi",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                EstrategiaID: $("#ddlTipoEstrategia").find(":selected").data("id")
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["Id", "Descripción", "Cantidad"],
            colModel: [
                { name: "Id", index: "Id", width: 100, editable: true, resizable: false, hidden: true },
                { name: "Descripcion", index: "Descripcion", width: 100, editable: true, resizable: false },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 30,
                    align: "center",
                    editable: true,
                    resizable: false,
                    formatter: _showActionsVer1
                }
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pagerCargaMasiva1"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function() {},
            gridComplete: function() {
                if (_variables.cantidadPrecargar == 0) {
                    $("#divMostrarPreCarga").css("display", "none");
                } else {
                    $("#divMostrarPreCarga").css("display", "");
                    $("#spnCantidadConfigurar1").html(_variables.cantidadPrecargar);
                }
            }
        });
        jQuery("#listCargaMasiva1").jqGrid("navGrid",
            "#pagerCargaMasiva1",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listCargaMasiva1").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }
    var _fnGrillaEstrategias2 = function() {
        $("#listCargaMasiva2").jqGrid("GridUnload");
        jQuery("#listCargaMasiva2").jqGrid({
            url: baseUrl + "AdministrarEstrategia/ConsultarOfertasParaTiTemporal",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["Id", "Descripción", "Cantidad"],
            colModel: [
                { name: "Id", index: "Id", width: 100, editable: true, resizable: false, hidden: true },
                { name: "Descripcion", index: "Descripcion", width: 100, editable: true, resizable: false },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 30,
                    align: "center",
                    editable: true,
                    resizable: false,
                    formatter: _showActionsVer2
                }
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pagerCargaMasiva2"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function() {},
            gridComplete: function() {
                if (_variables.cantidadPrecargar2 == 0) {
                    $("#divMostrarPreCarga2").css("display", "none");
                } else {
                    $("#divMostrarPreCarga2").css("display", "");
                    $("#spnCantidadConfigurar2").html(_variables.cantidadPrecargar2);
                }

                $("#divMasivoPaso1").hide();
                $("#divMasivoPaso2").show();

                $("#divPaso1").removeClass("boton_redondo_admcontenido_on");
                $("#divPaso1").addClass("boton_redondo_admcontenido_off");

                $("#divPaso2").removeClass("boton_redondo_admcontenido_off");
                $("#divPaso2").addClass("boton_redondo_admcontenido_on");
            }
        });
        jQuery("#listCargaMasiva2").jqGrid("navGrid",
            "#pagerCargaMasiva2",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listCargaMasiva2").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }
    var _fnGrillaCuv1 = function(tipo) {
        $("#listGrillaCuv1").jqGrid("clearGridData");

        var parametros = {
            campaniaId: parseInt($("#ddlCampania").val()),
            tipoConfigurado: parseInt(tipo),
            estrategiaCodigo: $("#ddlTipoEstrategia").find(":selected").data("codigo")
        };

        $("#listGrillaCuv1").setGridParam({ postData: parametros });

        jQuery("#listGrillaCuv1").jqGrid({
            url: _config.urlConsultarCuvTipoConfigurado,
            hidegrid: false,
            datatype: "json",
            postData: (parametros),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["CUV", "Descripción"],
            colModel: [
                { name: "CUV2", index: "CUV", width: 10, editable: true, resizable: false },
                { name: "DescripcionCUV2", index: "DescripcionCUV2", width: 90, editable: true, resizable: false },
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pagerGrillaCuv1"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Nombre",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function() {
            },
            gridComplete: function() {
                showDialog("DialogGrillaCuv1");
            }
        });
        jQuery("#listGrillaCuv1").jqGrid("navGrid",
            "#pagerGrillaCuv1",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listGrillaCuv1").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }
    var _fnGrillaCuv2 = function(tipo) {
        $("#listGrillaCuv2").jqGrid("clearGridData");

        var parametros = {
            campaniaId: parseInt($("#ddlCampania").val()),
            tipoConfigurado: parseInt(tipo)
        };

        $("#listGrillaCuv2").setGridParam({ postData: parametros });

        jQuery("#listGrillaCuv2").jqGrid({
            url: _config.urlConsultarCuvTipoConfiguradoTemporal,
            hidegrid: false,
            datatype: "json",
            postData: (parametros),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["CUV", "Descripción"],
            colModel: [
                { name: "CUV2", index: "CUV", width: 10, editable: true, resizable: false },
                { name: "DescripcionCUV2", index: "DescripcionCUV2", width: 90, editable: true, resizable: false },
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pagerGrillaCuv2"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Nombre",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 540,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function() {
            },
            gridComplete: function() {
                showDialog("DialogGrillaCuv2");
            }
        });
        jQuery("#listGrillaCuv2").jqGrid("navGrid",
            "#pagerGrillaCuv2",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listGrillaCuv2").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }

    var _uploadFileCvs = function() {
        var formData = new FormData();
        var totalFiles = document.getElementById("fileDescMasivo").files.length;
        if (totalFiles <= 0) {
            _toastHelper.error("Seleccione al menos un archivo.");
            return false;
        }

        formData.append("Documento", document.getElementById("fileDescMasivo").files[0]);
        formData.append("Pais", $("#ddlPais").val());
        formData.append("CampaniaId", $("#ddlCampania").val());
        formData.append("TipoEstrategia", $("#ddlTipoEstrategia").val());

        $.ajax({
            url: _config.urlUploadCvs,
            type: "POST",
            dataType: "JSON",
            data: formData,
            contentType: false,
            processData: false,
            success: function(data) {
                $("#listCargaDescMasiva").jqGrid("GridUnload");
                var gridJson = {
                    page: 1,
                    total: 2,
                    records: 10,
                    rows: [
                        {
                            Descripcion: "CUVs Actualizados",
                            Cantidad: data.listActualizado.length +
                                " <a href='#' onclick=showDialog(\'DialogDescActualizada\')> Ver </a>"
                        },
                        {
                            Descripcion: "CUVs no Actualizados",
                            Cantidad: data.listNoActualizado.length +
                                " <a href='#' onclick=showDialog(\'DialogDescNoActualizada\')> Ver </a>"
                        }
                    ]
                };

                $("#listCargaDescMasiva").empty().jqGrid({
                    datatype: "jsonstring",
                    datastr: gridJson,
                    colNames: ["Descripcion", "Cantidad"],
                    colModel: [
                        { name: "Descripcion", index: "Descripcion", sortable: false },
                        { name: "Cantidad", index: "Cantidad", width: 30, sortable: false }
                    ],
                    pager: false,
                    jsonReader: {
                        repeatitems: false
                    },
                    width: 540,
                    height: "auto",
                    scrollOffset: 20,
                    rowNum: 10,
                    rowList: [10, 15, 20, 25],
                    sortname: "Label",
                    sortorder: "asc",
                    viewrecords: true,
                    hoverrows: false,
                    caption: ""
                });
                _createGridUpdated(data.listActualizado);
                _createGridNotUpdated(data.listNoActualizado);
                $("#divDescMasivoPaso1").fadeOut(function() {
                    $("#divDescMasivoPaso2").fadeIn();
                });
            },
            error: function(data) {
                _toastHelper.error(data.statusText);
            }
        });
    }

    var _actualizarTonos = function() {
        waitingDialog({});
        var params = {
            CampaniaID: $("#ddlCampania").val(),
            TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
            CUV: $("#CUV").val()
        };

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "AdministrarEstrategia/ActualizarTono",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            success: function(data) {
                $("#listActualizarTono").jqGrid("GridUnload");
                var gridJson = {
                    page: 1,
                    total: 2,
                    records: 10,
                    rows: [
                        {
                            Descripcion: "CUVs Actualizados",
                            Cantidad: data.listActualizado.length +
                                " <a href='#' onclick=showDialog(\'DialogTonoActualizada\')> Ver </a>"
                        }
                    ]
                };

                $("#listActualizarTono").empty().jqGrid({
                    datatype: "jsonstring",
                    datastr: gridJson,
                    colNames: ["Descripcion", "Cantidad"],
                    colModel: [
                        { name: "Descripcion", index: "Descripcion", sortable: false },
                        {
                            name: "Cantidad",
                            index: "Cantidad",
                            width: 30,
                            sortable: false
                        }
                    ],
                    pager: false,
                    jsonReader: {
                        repeatitems: false
                    },
                    width: 540,
                    height: "auto",
                    scrollOffset: 20,
                    rowNum: 10,
                    rowList: [10, 15, 20, 25],
                    sortname: "Label",
                    sortorder: "asc",
                    viewrecords: true,
                    hoverrows: false,
                    caption: ""
                });
                _createGridTonoUpdated(data.listActualizado);
                _toastHelper.success(data.message);
                closeWaitingDialog();
                showDialog("DialogActualizarTono");
            },
            error: function(data, error) {
                closeWaitingDialog();
                _toastHelper.error(data.message);
            }
        });
    }
    var _basicFieldsValidation = function() {
        if ($("#ddlPais").val() === "") {
            _toastHelper.error("Debe seleccionar el País, verifique.");
            return false;
        }
        if ($("#ddlCampania").val() === "") {
            _toastHelper.error("Debe seleccionar la Campaña, verifique.");
            return false;
        }
        if ($("#ddlTipoEstrategia").val() === "") {
            _toastHelper.error("Debe seleccionar un tipo de estrategia, verifique.");
            return false;
        }
        return true;
    }
    var _fnGrilla = function() {
        $("#list").jqGrid("GridUnload");
        var tipo = $("#ddlTipoEstrategia").find(":selected").data("id");
        var codigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");
        jQuery("#list").jqGrid({
            url: baseUrl + "AdministrarEstrategia/Consultar",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                CUV: $("#CUV").val(),
                Consulta: $("#hdTipoConsulta").val(),
                Imagen: $("#ddlTieneImagen").val(),
                Activo: $("#ddlOfertaActiva").val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            multiselect: (tipo == "4" ||
                tipo == "7" ||
                tipo == "20" ||
                codigo == "005" ||
                codigo == "007" ||
                codigo == "008" ||
                codigo == "010"),
            colNames: [
                "EstrategiaID", "Orden", "#", "Pedido Asociado", "Precio", "CUV2", "Descripción", "Limite Venta",
                "Código SAP", "ImagenURL", "Foto", "", "EsOfertaIndependiente"
            ],
            colModel: [
                {
                    name: "EstrategiaID",
                    index: "EstrategiaID",
                    width: 20,
                    editable: true,
                    resizable: false,
                    hidden: true
                },
                {
                    name: "Orden",
                    index: "Orden",
                    width: 20,
                    editable: true,
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                { name: "ID", index: "ID", width: 20, editable: true, hidden: false, sortable: false },
                {
                    name: "NumeroPedido",
                    index: "NumeroPedido",
                    width: 40,
                    editable: true,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "Precio2",
                    index: "Precio2",
                    width: 70,
                    editable: true,
                    align: "center",
                    resizable: false,
                    sortable: false
                },
                {
                    name: "CUV2",
                    index: "CUV2",
                    width: 70,
                    editable: true,
                    resizable: false,
                    sortable: true,
                    align: "center"
                },
                {
                    name: "DescripcionCUV2",
                    index: "DescripcionCUV2",
                    width: 120,
                    editable: true,
                    resizable: false,
                    hidden: false,
                    sortable: false
                },
                {
                    name: "LimiteVenta",
                    index: "LimiteVenta",
                    width: 40,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: false
                },
                {
                    name: "CodigoProducto",
                    index: "CodigoProducto",
                    width: 70,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: true
                },
                { name: "ImagenURL", index: "ImagenURL", hidden: true },
                {
                    name: "ImagenProducto",
                    index: "ImagenProducto",
                    width: 70,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: false,
                    formatter: _showImage
                },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 30,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: false,
                    formatter: _showActions
                },
                {
                    name: "EsOfertaIndependiente",
                    index: "EsOfertaIndependiente",
                    width: 0,
                    editable: true,
                    hidden: true
                }
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pager"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [10, 20, 30, 40, 50],
            sortname: "Orden",
            sortorder: "asc",
            viewrecords: true,
            height: "auto",
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function(data) {

                if (data.rows.length > 0) {
                    for (var i = 0; i < data.rows.length; i++) {
                        if (data.rows[i].cell[10] == "1") {
                            $("#list").jqGrid("setSelection", data.rows[i].id, true);
                        }
                    }
                }
            }
        });
        jQuery("#list").jqGrid("navGrid",
            "#pager",
            { edit: false, add: false, refresh: false, del: false, search: false });
        if (tipo == "4" || codigo == "005" || codigo == "007" || codigo == "008" || codigo == "010") {
            $("#list").jqGrid("hideCol", ["Orden"]);
        }
    }

    var _buscarNemotecnico = function() {
        var validacionMsj = _validarNemotecnico();

        if (validacionMsj) {
            _toastHelper.error(validacionMsj);
            return false;
        }
        waitingDialog({});
        _obtenerImagenesByNemotecnico(_editData, 1, true);
        return true;
    }
    var _pedidoAsociadoChecks = function() {
        waitingDialog({});
        $.ajaxSetup({ cache: false });
        var codigoPrograma = $("#ddlTipoEstrategia option:selected").attr("Codigo-Programa");

        if (codigoPrograma == undefined) {
            codigoPrograma = "00";
        }
        $.ajax({
            type: "GET",
            url: baseUrl + "AdministrarEstrategia/ObtenerPedidoAsociado",
            data: "CodigoPrograma=" + codigoPrograma,
            async: true,
            dataType: "Json",
            success: function(data) {
                if (data != null && data.pedidoAsociado.length > 0) {
                    var pedidoAsociados = data.pedidoAsociado[0].PedidoAsociado.split(",");
                    $.each(pedidoAsociados,
                        function(x) {
                            var item = $(this)[0];
                            $(".checksPedidosAsociados")
                                .append(
                                    '<div class="titB" style="width:9px;"><input type="checkbox" class="chkclass" id="PedidoAsociado_' +
                                    item +
                                    '" name="PedidoAsociado_' +
                                    item +
                                    '" value=' +
                                    item +
                                    " >" +
                                    item +
                                    "</div>");
                        });
                }
                closeWaitingDialog();
            },
            error: function(x, xh, xhr) {
                if (checkTimeout(x)) {
                    closeWaitingDialog();
                }
            }
        });
    }
    var _validarMasivo = function() {
        if ($("#ddlPais").val() == "") {
            _toastHelper.error("Debe seleccionar el País, verifique.");
            return false;
        }
        if ($("#ddlCampania").val() == "") {
            _toastHelper.error("Debe seleccionar la Campaña, verifique.");
            return false;
        }
        if ($("#ddlTipoEstrategia").val() == "") {
            _toastHelper.error("Debe seleccionar un tipo de estrategia, verifique.");
            return false;
        } else {
            var estrategiaId = $("#ddlTipoEstrategia option:selected").data("id");
            if (!estrategiaId.in(_idEstrategia.OfertaParaTi,
                _idEstrategia.GuiaDeNegocio,
                _idEstrategia.LosMasVendidos,
                _idEstrategia.Lanzamiento,
                _idEstrategia.OfertasParaMi,
                _idEstrategia.PackAltoDesembolso,
                _idEstrategia.OfertaDelDia)) {
                _toastHelper.error("Debe seleccionar el tipo de Estrategia que permita esta funcionalidad.");
                return false;
            }
        }
        return true;
    }
    var _cerrarTallaColor = function() {
        var params = {
            CampaniaID: $("#ddlCampania").val(),
            CUV2: $("#txtCUV2").val(),
            TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
            CUV1: "",
            flag: "3",
            FlagNueva: "0",
            FlagRecoProduc: "0",
            FlagRecoPerfil: "0"
        };

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "AdministrarEstrategia/GetOfertaByCUV",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            success: function(data) {
                if (data.message == "OK") {
                    var cantidad = parseInt(data.precio);
                    if (cantidad > 0) {
                        _toastHelper.error("Debe ingresar todas las descripciones a las tallas/colores.");
                        return false;
                    } else {
                        HideDialog("DialogTonoMarca");
                    }
                } else {
                    _toastHelper.error(data.message);
                }
            },
            error: function(data, error) {
                _toastHelper.error(data.message);
            }
        });
    }

    var _fnGrillaTC = function() {
        $("#listTC").jqGrid("GridUnload");
        jQuery("#listTC").jqGrid({
            url: baseUrl + "AdministrarEstrategia/ConsultarTallaColor",
            hidegrid: false,
            datatype: "json",
            postData: ({
                CampaniaID: $("#ddlCampania").val(),
                CUV: $("#txtCUV2").val()
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["ID", "CUV", "Descripción", "Precio", "Tipo", "Talla/Color", "Desc T/C", "", ""],
            colModel: [
                { name: "ID", index: "ID", width: 0, editable: true, resizable: false, hidden: true },
                { name: "CUV", index: "CUV", width: 20, editable: true, resizable: false, hidden: false },
                {
                    name: "DescripcionCUV",
                    index: "DescripcionCUV",
                    width: 110,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "PrecioUnitario",
                    index: "PrecioUnitario",
                    width: 30,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                { name: "Tipo", index: "Tipo", width: 0, editable: true, resizable: false, hidden: true },
                {
                    name: "DescripcionTipo",
                    index: "DescripcionTipo",
                    width: 50,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "DescripcionTallaColor",
                    index: "DescripcionTallaColor",
                    width: 90,
                    editable: true,
                    resizable: false,
                    hidden: false
                },
                {
                    name: "Accion",
                    index: "Accion",
                    width: 30,
                    editable: true,
                    resizable: false,
                    hidden: false,
                    align: "center",
                    formatter: ShowActionsTC
                },
                { name: "IDAux", index: "IDAux", width: 0, editable: true, resizable: false, hidden: true }
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: true,
                cell: "cell",
                id: "id"
            },
            pager: jQuery("#pagerTC"),
            loadtext: "Cargando datos...",
            recordtext: "{0} - {1} de {2} Registros",
            emptyrecords: "No hay resultados",
            rowNum: 10,
            scrollOffset: 0,
            rowList: [],
            sortname: "ID",
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            height: "auto",
            width: 650,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function() {},
            gridComplete: function() {
                showDialog("DialogTonoMarca");
            }
        });
        jQuery("#listTC").jqGrid("navGrid",
            "#pagerTC",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listTC").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }

    // Binding events dialogs 
    var _iniDialog = function() {
        $("#DialogAdministracionEstrategia").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 830,
            close: function() {
            },
            draggable: false,
            title: "Registro de Estrategias",
            open: function(event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Guardar": function() {
                    waitingDialog({});
                    if ($("#mensajeErrorCUV").val() != "") {
                        _toastHelper.error($("#mensajeErrorCUV").val());
                        return false;
                    }
                    if ($("#mensajeErrorCUV2").val() != "") {
                        _toastHelper.error($("#mensajeErrorCUV2").val());
                        return false;
                    }
                    if ($(".DatosNuevas").css("display") == "block") {
                        if ($("#ddlCampaniaFin").val() == "") {
                            _toastHelper.error("Seleccione la campaña de vigencia hasta.");
                            return false;
                        }
                        var campaniaIni = $("#spanCampania").val();
                        var campaniaFin = $("#ddlCampaniaFin").val();
                        if (parseInt(campaniaFin) < parseInt(campaniaIni)) {
                            _toastHelper.error(
                                "La campaña de vigencia final  no puede ser menor a la campaña de inicio.");
                            return false;
                        }
                    }

                    var valor = $("#txtDescripcion").val();
                    if ($.trim(valor) == "") {
                        _toastHelper.error("Ingrese el valor del CUV2 para obtener la descripción o ingrese una.");
                        return false;
                    }
                    var m = "";

                    if (($.trim($("#txtCUV").val()) != "" && $.trim($("#txtPrecio").val()) == "") ||
                        ($.trim($("#txtCUV").val()) != "" && $.isNumeric($("#txtPrecio").val()) == false)) {
                        m += "- Digite un valor correspondiente para el precio." + "\n";
                    }
                    if ($.trim($("#txtCUV").val()) != "" && $("#txtPrecio").val() <= 0) {
                        m += "- Ingrese un valor para el precio mayor a cero." + "\n";
                    }

                    if ($.trim($("#txtCUV2").val()) == "") {
                        m += "- Ingrese un valor para el CUV2." + "\n";
                    }

                    if ($.trim($("#txtPrecio2").val()) == "" || $.isNumeric($("#txtPrecio2").val()) == false) {
                        m += "- Digite un valor correspondiente para el precio." + "\n";
                    }
                    if ($("#txtPrecio2").val() <= 0) {
                        m += "- Ingrese un valor para el precio mayor a cero." + "\n";
                    }
                    if (m != "") {
                        _toastHelper.error(m);
                        return false;
                    }

                    if ($("#idEstrella").css("display") == "block") {
                        if (!$("#chkEstrella").attr("checked")) {
                            _toastHelper.error(
                                "Debe activar el la opción para mostrar estrella en la zona de producto.  ");
                            return false;
                        }
                    }

                    if ($(".chkImagenProducto:checked").length == 0) {
                        _toastHelper.error("Seleccione una imagen a mostrar.");
                        return false;
                    }

                    if (_variables.imagen == "") {
                        _toastHelper.error("Seleccione una imagen a mostrar.");
                        return false;
                    }
                    var aux2 = $("#ddlTipoEstrategia").find(":selected").data("id");
                    var aux3 = $("#ddlTipoEstrategia").find(":selected").data("codigo");
                    if (aux2 !== 4 &&
                        aux2 !== 7 &&
                        aux2 !== 20 &&
                        aux2 !== 9 &&
                        aux2 !== 10 &&
                        aux2 !== 11 &&
                        aux2 !== 12) {
                        if ($.trim($("#txtOrden").val()) == "" || $.isNumeric($("#txtOrden").val()) == false) {
                            _toastHelper.error("Ingrese un orden para mostrar.");
                            return false;
                        }
                        if ($("#txtOrden").val() <= 0) {
                            _toastHelper.error("Ingrese un valor para el orden a mostrar mayor a cero.");
                            return false;
                        }
                    }

                    if ($.trim($("#txtLimite").val()) == "" || $.isNumeric($("#txtLimite").val()) == false) {
                        _toastHelper.error("Ingrese un valor para el limite de venta.");
                        return false;
                    }
                    if ($("#txtLimite").val() <= 0) {
                        _toastHelper.error("Ingrese un valor para el limite de venta mayor a cero.");
                        return false;
                    }
                    var imagenEstrategiaProducto = $("#imgSeleccionada").attr("src");

                    var EstrategiaID = 0;
                    if (!_variables.isNuevo)
                        EstrategiaID = $("#hdEstrategiaID").val();

                    var TipoEstrategiaID = $("#hdTipoEstrategiaID").val();
                    var CampaniaID = $("#hdCampania").val();
                    var CampaniaIDFin = $("#ddlCampaniaFin").val();
                    var Activo = ($("#chkHabilitarOferta").attr("checked")) ? "1" : "0";
                    var ImagenURL = imagenEstrategiaProducto.substr(imagenEstrategiaProducto.lastIndexOf("/") + 1);
                    var LimiteVenta = $("#txtLimite").val();
                    var DescripcionCUV2 = $("#txtDescripcion").val();
                    var FlagDescripcion = (DescripcionCUV2 != "") ? "1" : "0";
                    var CUV = $("#txtCUV").val();
                    var EtiquetaID = $("#hdnEtiqueta1").val();
                    var Precio = $("#txtPrecio").val();
                    var FlagCEP = (CUV != "") ? "1" : "0";
                    var CUV2 = $("#txtCUV2").val();
                    var EtiquetaID2 = $("#hdnEtiqueta2").val();
                    var Precio2 = $("#txtPrecio2").val();
                    var FlagCEP2 = (CUV2 != "") ? "1" : "0";
                    var TextoLibre = $("#txtTextoLibre").val();
                    var FlagTextoLibre = (TextoLibre != "") ? "1" : "0";
                    var Cantidad = "";
                    var FlagCantidad = "0";
                    var Zona = $("#hdZonas").val();
                    var Orden = $("#txtOrden").val();
                    var flagEstrella = ($("#chkOfertaUltimoMinuto").attr("checked")) ? "1" : "0";
                    var colorFondo = $("#hdColorFondo").val();

                    var NumeroPedidoAsociado = $(".checksPedidosAsociados input:checked").map(function() {
                        return $(this).val();
                    }).get().join(",");

                    if (NumeroPedidoAsociado == "" && $("#txtPedidoAsociado").length) {
                        NumeroPedidoAsociado = $("#txtPedidoAsociado").val();
                    }
                    //valores para el carrusel de la estrategia de lanzamiento
                    var imgFondoDesktop = $("#nombre-img-fondo-desktop").val();
                    var imgPrevDesktop = $("#nombre-img-prev-desktop").val();
                    var imgFichaDesktop = $("#nombre-img-ficha-desktop").val();
                    var urlVideoDesktop = $("#url-video-desktop").val();
                    var imgFondoMobile = $("#nombre-img-fondo-mobile").val();
                    var imgFichaMobile = $("#nombre-img-ficha-mobile").val();
                    var urlVideoMobile = $("#url-video-mobile").val();
                    var imgFichaFondoDesktop = $("#nombre-img-ficha-fondo-desktop").val();
                    var imgFichaFondoMobile = $("#nombre-img-ficha-fondo-mobile").val();
                    var imgHomeDesktop = $("#nombre-img-home-desktop").val();
                    var imgHomeMobile = $("#nombre-img-home-mobile").val();
                    var ganancia = $("#txtGanancia").val();
                    var esOfertaIndependiente = ($("#chkEsOfertaIndependiente").attr("checked")) ? true : false;

                    var params = {
                        EstrategiaID: EstrategiaID,
                        TipoEstrategiaID: TipoEstrategiaID,
                        CampaniaID: CampaniaID,
                        CampaniaIDFin: CampaniaIDFin,
                        NumeroPedido: NumeroPedidoAsociado,
                        Activo: Activo,
                        ImagenURL: ImagenURL,
                        LimiteVenta: LimiteVenta,
                        DescripcionCUV2: DescripcionCUV2,
                        FlagDescripcion: FlagDescripcion,
                        CUV: CUV,
                        EtiquetaID: EtiquetaID,
                        Precio: Precio,
                        FlagCEP: FlagCEP,
                        CUV2: CUV2,
                        EtiquetaID2: EtiquetaID2,
                        Precio2: Precio2,
                        FlagCEP2: FlagCEP2,
                        TextoLibre: TextoLibre,
                        FlagTextoLibre: FlagTextoLibre,
                        Cantidad: Cantidad,
                        FlagCantidad: FlagCantidad,
                        Zona: Zona,
                        Orden: Orden,
                        ColorFondo: colorFondo,
                        FlagEstrella: flagEstrella,
                        CodigoTipoEstrategia: aux3,
                        ImgFondoDesktop: imgFondoDesktop,
                        ImgPrevDesktop: imgPrevDesktop,
                        ImgFichaDesktop: imgFichaDesktop,
                        UrlVideoDesktop: urlVideoDesktop,
                        ImgFondoMobile: imgFondoMobile,
                        ImgFichaMobile: imgFichaMobile,
                        UrlVideoMobile: urlVideoMobile,
                        ImgFichaFondoDesktop: imgFichaFondoDesktop,
                        ImgFichaFondoMobile: imgFichaFondoMobile,
                        ImgHomeDesktop: imgHomeDesktop,
                        ImgHomeMobile: imgHomeMobile,
                        PrecioAnt: $("#hdEstrategiaPrecioAnt").val(),
                        EsOfertaIndependiente: esOfertaIndependiente,
                        Ganancia: ganancia,
                        RutaImagenCompleta: imagenEstrategiaProducto
                    };
                    jQuery.ajax({
                        type: "POST",
                        url: baseUrl + "AdministrarEstrategia/RegistrarEstrategia",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(params),
                        async: true,
                        success: function(data) {
                            closeWaitingDialog();
                            if (data.success) {
                                _toastHelper.success(data.message);
                                $("#ddlTipoEstrategia").val($("#hdEstrategiaIDConsulta").val());
                                HideDialog("DialogAdministracionEstrategia");
                                $("#list").jqGrid("clearGridData", true).trigger("reloadGrid");
                            } else {
                                _toastHelper.error(data.message);
                            }
                        },
                        error: function (data, error) {
                            closeWaitingDialog();
                            _toastHelper.error(data.message);
                        }
                    });

                },
                "Salir": function() {
                    $("#ddlTipoEstrategia").val($("#hdEstrategiaIDConsulta").val());
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogZona").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 500,
            draggable: false,
            title: "Seleccione el alcance de la estrategia",
            open: function(event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Guardar": function() {
                    var zonas = "";
                    $.jstree._reference($("#arbolRegionZona")).get_checked(null, true).each(function() {
                        if (this.className.toLowerCase().indexOf("jstree-leaf") == -1) {
                            return true;
                        }
                        zonas += this.id + ",";
                    });
                    if (zonas != "") {
                        zonas = zonas.substring(0, zonas.length - 1);
                    }
                    if (zonas == "") {
                        _toastHelper.error("No se ha marcado ninguna zona o región.");
                        return false;
                    }
                    $("#hdZonas").val(zonas);
                    _toastHelper.error("Se agregaron las zonas seleccionadas.");
                    $(this).dialog("close");
                },
                "Salir": function() {
                    $(this).dialog("close");
                }
            }
        });

        $("#divVistaPrevia").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 250,
            draggable: false,
            title: "Vista previa",
            buttons:
            {
                "Cerrar": function() {
                    if (_variables.isVistaPreviaOpened) {
                        var params = {
                            paisID: $("#ddlPais").val(),
                            EstrategiaID: $("#hdEstrategiaID").val(),
                            CampaniaID: $("#ddlCampania").val(),
                            TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                            CUV2: $("#txtCUV2").val()
                        };
                        _obtenerImagenes(params, 1, true).done(function() {
                            showDialog("matriz-comercial-dialog");
                            closeWaitingDialog();
                        });
                    }
                    _variables.isVistaPreviaOpened = false;
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogTonoMarca").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: false,
            width: 700,
            draggable: false,
            title: "Seleccionar Talla/Color",
            open: function(event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Nueva Talla/Color": function() {
                    $("#hdTallaColorID").val("0");
                    $("#ddlTallaColor").val("0");
                    $("#txtDescripcionTC").val("");
                    $("#txtCUVTC").val("");
                    $("#txtDescripcionCUVTC").val("");
                    $("#txtPrecioCUVTC").val("");
                    $("#txtCUVTC").attr("readonly", false);
                    showDialog("DialogEditarTallaColor");
                },
                "Salir": _cerrarTallaColor
            }
        });

        $("#DialogEditarTallaColor").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 550,
            draggable: false,
            title: "Registro Talla/Color",
            buttons:
            {
                "Guardar": function() {
                    var msj = "";

                    if ($("#txtCUVTC").val() == "") {
                        msj += "- Ingrese un CUV." + "\n";
                    }

                    if ($("#ddlTallaColor").val() == "0") {
                        msj += "- Seleccione el tipo (Talla/Color)." + "\n";
                    }

                    if ($("#txtDescripcionTC").val() == "") {
                        msj += "- Ingrese descripción (Talla/Color)." + "\n";
                    }

                    if (msj != "") {
                        _toastHelper.error(msj);
                        return false;
                    }

                    var id = $("#hdTallaColorID").val();
                    var cuv = $("#txtCUVTC").val();
                    var campaniaID = $("#ddlCampania").val();
                    var tipo = $("#ddlTallaColor").val();
                    var descripcion = $("#txtDescripcionTC").val();
                    var CUVPadre = $("#txtCUV2").val();
                    var xmlString = "<params>";

                    xmlString += "<param ";
                    xmlString += ' ID = "' + id + '"';
                    xmlString += ' CampaniaID = "' + campaniaID + '"';
                    xmlString += ' CUV = "' + cuv + '"';
                    xmlString += ' Tipo = "' + tipo + '"';
                    xmlString += ' Descripcion = "' + descripcion + '"';
                    xmlString += ' CUVPadre = "' + CUVPadre + '"';
                    xmlString += " />";
                    xmlString += "</params>";

                    var params = {
                        xmlTallaColor: xmlString
                    };

                    jQuery.ajax({
                        type: "POST",
                        url: baseUrl + "AdministrarEstrategia/RegistrarTallaColor",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(params),
                        async: true,
                        success: function(data) {
                            if (data.success) {
                                _toastHelper.success(data.message);
                                _fnGrillaTC();
                                HideDialog("DialogEditarTallaColor");
                            } else {
                                _toastHelper.error(data.message);
                            }
                        },
                        error: function(data, error) {
                            _toastHelper.error(data.message);
                        }
                    });
                },
                "Salir": function() {
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogNuevoMasivo").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de Estrategias"
        });

        $("#DialogGrillaCuv1").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de Estrategias",
            buttons:
            {
                "Salir": function() {
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogGrillaCuv2").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de Estrategias",
            buttons:
            {
                "Salir": function() {
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogDescMasivo").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga Masiva de descripciones de Estrategias"
        });

        $("#DialogDescActualizada").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Resultado de estrategias actualizadas"
        });

        $("#DialogDescNoActualizada").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Resultado de estrategias no actualizadas"
        });

        $("#DialogActualizarTono").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Resultado de actualización de tonos."
        });

        $("#DialogTonoActualizada").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Lista de CUVs actualizados."
        });
    }
    var _eventos = {
        clickNuevo : function() {
            _variables.isNuevo = true;

            var tieneFlagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
            (tieneFlagNueva == "1") ? $(".chkEsOfertaIndependiente").show() : $(".chkEsOfertaIndependiente").hide();

            //$.jstree._reference($("#arbolRegionZona")).check_all();
            if (!_basicFieldsValidation()) return false;

            _seleccionarTipoOferta();
            _pedidoAsociadoChecks();
            _activarDesactivarChecks();

            $("#hdTipoConsulta").val("1");
            $("#ddlCampaniaFin").val("");
            $("#hdEstrategiaIDConsulta").val($("#ddlTipoEstrategia").val());
            $("#hdEstrategiaID").val("0");
            $("#hdCampania").val($("#ddlCampania").val());
            $("#hdTipoEstrategiaID").val($("#ddlTipoEstrategia").val());
            $("#txtAlcance").val($("#ddlPais option:selected").html());
            $("#spanCampania").val($("#ddlCampania option:selected").html());
            $("#spanTipoEstrategia").val($("#ddlTipoEstrategia option:selected").html().trim());
            $("#chkHabilitarOferta").attr("checked", false);
            $("#chkEsOfertaIndependiente").attr("checked", false);
            $("#chkOfertaUltimoMinuto").attr("checked", false);
            $("#hdZonas").val("");
            $("#txtCUV2").val("");
            $("#txtPrecio2").val("");
            $("#txtCUV").val("");
            $("#txtPrecio").val("");
            $("#txtDescripcion").val("");
            $("#txtGanancia").val("");
            $("#matriz-imagenes-paginacion").empty();
            $("#matriz-comercial-images").empty();
            $("#file-upload").hide();
            $("#imgSeleccionada").attr("src", _config.rutaImagenVacia);
            $("#imgZonaEstrategia").attr("src", _config.rutaImagenVacia);
            $("#divImagenEstrategiaContenido").show();
            $("#divInformacionAdicionalEstrategiaContenido").hide();
            $("#divImagenEstrategia").css("color", "white");
            $("#divImagenEstrategia").css("background", "#00A2E8");
            $("#divInformacionAdicionalEstrategia").css("color", "#702789");
            $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");
            $("#txtTextoLibre").val("");
            $("#hdColorFondo").val("#FFF");
            $("#mensajeErrorCUV").val("");
            $("#mensajeErrorCUV2").val("");
            $(".checksPedidosAsociados").html("");

            var aux1 = $("#ddlTipoEstrategia").find(":selected").data("id");
            var aux2 = $("#ddlTipoEstrategia").find(":selected").data("codigo");

            if (aux1 == "4" || aux2 == "005" || aux2 == "007" || aux2 == "008") {
                $("#txtOrden").val("");
                $("#div-orden").hide();

                $("#txt1-estrella").html("Oferta de Último Minuto");
                $("#txt2-estrella").hide();
            } else {
                $("#div-orden").show();

                $("#txt1-estrella").html("Mostrar estrella");
                $("#txt2-estrella").show();
            }

            $("#ddlEtiqueta1").children("option").show();
            $("#ddlEtiqueta2").children("option").show();

            if (aux1 == "2") {
                $("#ddlEtiqueta1").children("option").hide();
                $("#ddlEtiqueta1").children("option[data-id='4']").show();

                $("#hdnEtiqueta1").val("4");
            } else if (aux1 == "4" || aux1 == "5" || aux2 == "005" || aux2 == "007" || aux2 == "008") {

                $("#hdnEtiqueta1").val("1");
                $("#hdnEtiqueta2").val("3");

            } else if (aux1 == "0" || aux1 == "6") {
                $("#ddlEtiqueta1").children("option[data-id='5']").hide();
                $("#ddlEtiqueta2").children("option[data-id='5']").hide();
                $("#hdnEtiqueta1").val("5");
                $("#hdnEtiqueta2").val("5");
            }

            if (aux1 == "6") {
                $(".OfertaUltimoMinuto").hide();
            } else {
                $(".OfertaUltimoMinuto").show();
            }

            if (aux1 == "7") {
                $(".Recomendados").hide();

                $("#ddlEtiqueta1").children("option").hide();
                $("#ddlEtiqueta1").children("option[data-id='1']").show();

                $("#ddlEtiqueta2").children("option").hide();
                $("#ddlEtiqueta2").children("option[data-id='5']").show();

                $("#div-orden").hide();

                $("#hdnEtiqueta1").val("1");
                $("#hdnEtiqueta2").val("5");
            }

            if (aux2 == "005") $("#div-revista-digital").show();
            else $("#div-revista-digital").hide();

            _limpiarCamposLanzamiento("img-fondo-desktop");
            _limpiarCamposLanzamiento("img-prev-desktop");
            _limpiarCamposLanzamiento("img-ficha-desktop");
            _limpiarCamposLanzamiento("img-ficha-mobile");
            _limpiarCamposLanzamiento("img-ficha-fondo-desktop");
            _limpiarCamposLanzamiento("img-ficha-fondo-mobile");
            _limpiarCamposLanzamiento("img-home-desktop");
            _limpiarCamposLanzamiento("img-home-mobile");
            $("#url-video-desktop").val("");
            $("#url-video-mobile").val("");

            if (aux2 == _config.tipoEstrategiaIncentivosProgramaNuevas)
                $("#divPrecioValorizado").html("Ganancia");
            else
                $("#divPrecioValorizado").html("Precio Valorizado");

            HideDialog("DialogZona");
            showDialog("DialogAdministracionEstrategia");
            return true;
        },
        clickActivarDesactivar: function() {
            var proceder = confirm("¿ Desea habilitar/deshabiltar las estrategias?");
            if (!proceder)
                return false;

            waitingDialog({});

            var estrategias = jQuery("#list").jqGrid("getDataIDs", "EstrategiaID");
            var estrategiasSeleccionadas = jQuery("#list").jqGrid("getGridParam", "selarrrow");
            var estrategiasNoSeleccionadas = estrategias.filter(function(obj) {
                return estrategiasSeleccionadas.indexOf(obj) == -1;
            });

            var params = {
                EstrategiasActivas: estrategiasSeleccionadas.join(","),
                EstrategiasDesactivas: estrategiasNoSeleccionadas.join(","),
                campaniaID: $("#ddlCampania").val(),
                tipoEstrategiaCod: $("#ddlTipoEstrategia :selected").data("codigo")
            };

            jQuery.ajax({
                type: "POST",
                url: _config.urlActivarDesactivarEstrategias,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    _toastHelper.success(data.message);
                    _fnGrilla();
                    closeWaitingDialog();
                },
                error: function(data, error) {
                    _toastHelper.error(data.message);
                    closeWaitingDialog();
                }
            });
            return true;
        },
        clickBuscar: function() {
            if (!_basicFieldsValidation()) return false;
            $("#hdEstrategiaIDConsulta").val($("#ddlTipoEstrategia").val());
            $("#hdTipoConsulta").val("1");
            $("#hdEstrategiaCodigo").val($("#ddlTipoEstrategia option:selected").data("codigo"));
            _fnGrilla();
            return true;
        },
        clickBuscarNemotencnico: function() {
            _buscarNemotecnico();
        },
        clickLimipiarNemotecnico: function() {
        _limpiarBusquedaNemotecnico();
        },
        clickClassEstrategiaImagen: function() {
            var id = $(this).attr("data-id");
            if ($(this).attr("checked")) {
                $("#ImagenProducto").val($(this).val());
                $('.chk-estrategia-imagen[data-id!="' + id + '"]').removeAttr("checked");
            }
        },
        clickClassActivarDesactivar: function() {
            if (!$(this).attr("checked")) {
                $(this).parent().parent().find("input").each(function() {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", true);
                });
                $(this).parent().parent().find("select").each(function() {
                    $(this).val("");
                    $(this).attr("disabled", true);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            } else {
                $(this).parent().parent().find("input").each(function() {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", false);
                });
                $(this).parent().parent().find("select").each(function() {
                    $(this).val("");
                    $(this).attr("disabled", false);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            }
        },
        clickNuevoMasivo: function() {
            if (_validarMasivo()) {
                $("#divMasivoPaso1").show();
                $("#divMasivoPaso2").hide();
                $("#divMasivoPaso3").hide();

                $("#divPaso1").removeClass("boton_redondo_admcontenido_off");
                $("#divPaso1").addClass("boton_redondo_admcontenido_on");

                $("#divPaso2").removeClass("boton_redondo_admcontenido_on");
                $("#divPaso2").addClass("boton_redondo_admcontenido_off");

                $("#divPaso3").removeClass("boton_redondo_admcontenido_on");
                $("#divPaso3").addClass("boton_redondo_admcontenido_off");

                _fnGrillaEstrategias1();
                showDialog("DialogNuevoMasivo");
            }
        },
        clickDescripcionMasivo: function() {
            if (_validarMasivo()) {
                $("#divDescMasivoPaso1").show();
                $("#divDescMasivoPaso2").hide();
                showDialog("DialogDescMasivo");
            }
        },
        clickCancelarDescMasivo1: function() {
            HideDialog("DialogDescMasivo");
        },
        clickAceptarDescMasivo1: function() {
            $("#divDescMasivoPaso1").show();
            $("#divDescMasivoPaso2").hide();
            _uploadFileCvs();
        },
        clickActualizarTonos: function() {
            if (_validarMasivo()) _actualizarTonos();
        },
        clickAceptarMasivo1: function() {
            var params = {
                campaniaId: parseInt($("#ddlCampania").val()),
                tipoConfigurado: 2,
                estrategiaCodigo: $("#ddlTipoEstrategia").find(":selected").data("codigo"),
                habilitarNemotecnico: _config.habilitarNemotecnico
            };

            waitingDialog({});

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "AdministrarEstrategia/InsertEstrategiaTemporal",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    if (data.success) {
                        closeWaitingDialog();
                        _fnGrillaEstrategias2();
                    } else {
                        _toastHelper.error(data.message);
                    }
                },
                error: function(data, error) {
                    _toastHelper.error(data.message);
                }
            });
        },
        clickAceptarMasivo2: function() {
            var params = {
                campaniaId: parseInt($("#ddlCampania").val()),
                tipoConfigurado: 1,
                estrategiaId: $("#ddlTipoEstrategia").find(":selected").data("id")
            };

            waitingDialog({});

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "AdministrarEstrategia/InsertEstrategiaOfertaParaTi",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    if (data.success) {
                        closeWaitingDialog();
                        $("#divMasivoPaso1").hide();
                        $("#divMasivoPaso2").hide();
                        $("#divMasivoPaso3").show();

                        $("#divPaso1").removeClass("boton_redondo_admcontenido_on");
                        $("#divPaso1").addClass("boton_redondo_admcontenido_off");

                        $("#divPaso2").removeClass("boton_redondo_admcontenido_on");
                        $("#divPaso2").addClass("boton_redondo_admcontenido_off");

                        $("#divPaso3").removeClass("boton_redondo_admcontenido_off");
                        $("#divPaso3").addClass("boton_redondo_admcontenido_on");
                    } else {
                        _toastHelper.error(data.message);
                    }
                },
                error: function(data, error) {
                    _toastHelper.error(data.message);
                }
            });
        },
        clickCancelarMasivo1: function() {
            HideDialog("DialogNuevoMasivo");
        },
        clickCancelarMasivo2: function() {
            var params = {
                campaniaId: parseInt($("#ddlCampania").val())
            };

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "AdministrarEstrategia/CancelarInsertEstrategiaTemporal",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    if (data.success) {
                        HideDialog("DialogNuevoMasivo");
                    }
                    _toastHelper.success(data.message);
                },
                error: function(data, error) {
                    _toastHelper.error(data.message);
                }
            });
        },
        clickAceptarMasivo3: function() {
            HideDialog("DialogNuevoMasivo");
        },
        clickCargaMasivaImagenes: function() {
            if ($("#ddlPais").val() == "") {
                _toastHelper.error("Debe seleccionar el País, verifique.");
                return false;
            }
            if ($("#ddlCampania").val() == "") {
                _toastHelper.error("Debe seleccionar la Campaña, verifique.");
                return false;
            }

            var campaniaId = $("#ddlCampania").val();
            var params = {
                campaniaID: campaniaId
            };

            waitingDialog({});
            jQuery.ajax({
                type: "POST",
                url: baseUrl + "AdministrarEstrategia/CargaMasivaImagenes",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    //if(data.success)
                    closeWaitingDialog();
                    _toastHelper.success(data.message);
                },
                error: function(data, error) {
                    _toastHelper.error(data.message);
                }
            });
        },
        clickImagenEstrategia: function() {
            $(this).css("color", "white");
            $(this).css("background", "#00A2E8");

            $("#divInformacionAdicionalEstrategia").css("color", "#702789");
            $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");

            $("#divImagenEstrategiaContenido").show();
            $("#divInformacionAdicionalEstrategiaContenido").hide();
        },
        clickInformacionAdicionalEstrategia:function() {
            $(this).css("color", "white");
            $(this).css("background", "#00A2E8");

            $("#divImagenEstrategia").css("color", "#702789");
            $("#divImagenEstrategia").css("background", "#D0D0D0");

            $("#divInformacionAdicionalEstrategiaContenido").show();
            $("#divImagenEstrategiaContenido").hide();
        },
        clickLinkTallaColor: function() {
            if ($.trim($("#txtCUV2").val()) == "") {
                _toastHelper.error("Debe ingresar un valor para CUV2");
                return false;
            }
            _fnGrillaTC();
            showDialog("DialogTonoMarca");
            return false;
        },
        clickChkImagenProducto: function() {

            _variables.imagen = "";

            $(".chkImagenProducto").prop("checked", false);
            $(this).attr("checked", "checked");
            _variables.imagen = $(this).attr("value");
            $("#imgSeleccionada").attr("src", _variables.imagen);
        },
        clickImgSeleccionada: function() {
            $("#imgZonaEstrategia").attr("src", $(this).attr("src"));
            var index = $(this).attr("id").split("-");
            var descripcionComercial = $("#descripcion-comercial-" + index[2]).attr("value");
            var idMatrizComercial = $("#id-matriz-comercial-imagen-" + index[2]).attr("value");
            var editData = {
                IdMatrizComercialImagen: idMatrizComercial,
                DescripcionComercial: descripcionComercial
            };
            if (_config.habilitarNemotecnico) {
                SetHandlebars("#descripcion-comercial-template", editData, "#descripcion-comercial");
                $("#divVistaPrevia").find("#descripcion-comercial").show();
            } else {
                $("#divVistaPrevia").find("#descripcion-comercial").hide();
            }
            _variables.isVistaPreviaOpened = true;
            showDialog("divVistaPrevia");
        },

        changeTipoEstrategia: function() {
            var aux2 = $("#ddlTipoEstrategia").find(":selected").data("codigo");
            $("#btnActivarDesactivar").hide();
            $("#btnNuevoMasivo").hide();
            $("#btnDescripcionMasivo").hide();
            $("#btnActualizarTonos").hide();

            if (aux2.in(_codigoEstrategia.OfertaParaTi,
                _codigoEstrategia.OfertaDelDia,
                _codigoEstrategia.LosMasVendidos,
                _codigoEstrategia.Lanzamiento,
                _codigoEstrategia.OfertasParaMi,
                _codigoEstrategia.PackAltoDesembolso,
                _codigoEstrategia.GuiaDeNegocio)) {
                $("#btnActivarDesactivar").show();
                $("#btnNuevoMasivo").show();
                $("#btnDescripcionMasivo").show();
                $("#btnActualizarTonos").show();
            }

            _seleccionarTipoOferta();
            _pedidoAsociadoChecks();
        },
        changePais: function() {
            $("#hdTipoConsulta").attr("value", "0");
            $("#list").jqGrid("clearGridData", true).trigger("reloadGrid");
            var Id = $(this).val();
            waitingDialog({});
            $.ajaxSetup({ cache: false });
            $.ajax({
                type: "GET",
                url: baseUrl + "AdministrarEstrategia/ObtenterCampanias",
                data: "PaisID=" + (Id == "" ? 0 : Id),
                cache: false,
                dataType: "Json",
                success: function(data) {
                    if (checkTimeout(data)) {
                        var ddlCampania = $("#ddlCampania");
                        var ddlCampaniaFin = $("#ddlCampaniaFin");
                        ddlCampania.empty();
                        ddlCampaniaFin.empty();
                        if (data.lista.length > 0) {
                            ddlCampania.append($("<option/>",
                                {
                                    value: "",
                                    text: "-- Seleccionar --"
                                }));
                            ddlCampaniaFin.append($("<option/>",
                                {
                                    value: "",
                                    text: "-- Seleccionar --"
                                }));
                            if (Id != "") {
                                for (var item in data.lista) {
                                    ddlCampania.append($("<option/>",
                                        {
                                            value: data.lista[item].CampaniaID,
                                            text: data.lista[item].Codigo
                                        }));
                                    ddlCampaniaFin.append($("<option/>",
                                        {
                                            value: data.lista[item].CampaniaID,
                                            text: data.lista[item].Codigo
                                        }));
                                }
                            }
                        }
                        //cargarArbol();
                        closeWaitingDialog();
                    }
                },
                error: function(x, xh, xhr) {
                    if (checkTimeout(x)) {
                        closeWaitingDialog();
                    }
                }
            });

            $.getJSON(baseUrl + "MatrizComercial/ObtenerISOPais",
                { paisID: Id },
                function(data) {
                    closeWaitingDialog();
                });

        },

        keyUpCuv: function() {
            if ($(this).val().length == 5) {

                if ($("#txtCUV2").val() == "") {
                    _toastHelper.error("Debe ingresar un valor para el CUV2");
                    return false;
                }

                waitingDialog({});
                $.ajaxSetup({ cache: false });

                var flagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
                var flagRecoProduc = $("#ddlTipoEstrategia option:selected").attr("flag-recoproduct");
                var flagRecoPerfil = $("#ddlTipoEstrategia option:selected").attr("flag-recoperfil");
                var auxOD = $("#ddlTipoEstrategia").find(":selected").data("id");

                var flagOD = "";
                if (auxOD == "7" || auxOD == "4") {
                    flagOD = "1";
                } else if (auxOD == "9" || auxOD == "10" || auxOD == "11") {
                    flagOD = auxOD;
                } else {
                    flagOD = "0";
                }

                var params = {
                    CampaniaID: $("#ddlCampania").val(),
                    CUV2: $("#txtCUV2").val(),
                    TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                    CUV1: $("#txtCUV").val(),
                    flag: flagOD,
                    FlagNueva: flagNueva,
                    FlagRecoProduc: flagRecoProduc,
                    FlagRecoPerfil: flagRecoPerfil
                };

                jQuery.ajax({
                    type: "POST",
                    url: baseUrl + "AdministrarEstrategia/GetOfertaByCUV",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(params),
                    async: true,
                    success: function(data) {
                        if (data.message == "OK") {
                            $("#txtPrecio").val(parseFloat(data.precio).toFixed(2));
                            $("#mensajeErrorCUV").val("");
                            closeWaitingDialog();
                        } else {
                            $("#mensajeErrorCUV").val(data.message);
                            _toastHelper.error($("#mensajeErrorCUV").val());
                            closeWaitingDialog();
                        }
                    },
                    error: function(data, error) {
                        $("#mensajeErrorCUV").val(data.message);
                        _toastHelper.error($("#mensajeErrorCUV").val());
                        closeWaitingDialog();
                    }
                });
            }
            return true;
        },
        keyUpCuvTc: function() {
            if ($(this).val().length == 5) {

                if ($("#txtCUV2").val() == "") {
                    _toastHelper.error("Debe ingresar un valor para el CUV2");
                    return false;
                }

                waitingDialog({});
                $.ajaxSetup({ cache: false });

                var flagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
                var flagRecoProduc = $("#ddlTipoEstrategia option:selected").attr("flag-recoproduct");
                var flagRecoPerfil = $("#ddlTipoEstrategia option:selected").attr("flag-recoperfil");

                var params = {
                    CampaniaID: $("#ddlCampania").val(),
                    CUV2: $("#txtCUVTC").val(),
                    TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                    CUV1: "0",
                    flag: "2",
                    FlagNueva: flagNueva,
                    FlagRecoProduc: flagRecoProduc,
                    FlagRecoPerfil: flagRecoPerfil

                };

                jQuery.ajax({
                    type: "POST",
                    url: baseUrl + "AdministrarEstrategia/GetOfertaByCUV",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(params),
                    async: true,
                    success: function(data) {
                        if (data.message == "OK") {
                            $("#txtDescripcionCUVTC").val(data.descripcion);
                            $("#txtPrecioCUVTC").val(parseFloat(data.precio).toFixed(2));
                            closeWaitingDialog();
                        } else {
                            _toastHelper.error(data.message);
                            closeWaitingDialog();
                        }
                    },
                    error: function(data, error) {
                        $("#mensajeErrorCUV").val(data.message);
                        _toastHelper.error($("#mensajeErrorCUV").val());
                        closeWaitingDialog();
                    }
                });
            }
            return true;
        },
        keyUpCuv2: function() {
            var cuvIngresado = $(this).val();
            $("#imgSeleccionada").attr("src", _config.rutaImagenVacia);
            $("#imgSeleccionada").attr("data-id", "0");
            _mostrarInformacionCuv(cuvIngresado);
        }

    }
     
    var _bindingEvents = function(){
        $("body").on("click", "#btnNuevo", _eventos.clickNuevo);
        $("body").on("click", "#btnBuscar", _eventos.clickBuscar);
       $("body").on("click", "#btnActivarDesactivar", _eventos.clickActivarDesactivar);
       $("body").on("click", ".chk-estrategia-imagen", _eventos.clickClassEstrategiaImagen);
       $("body").on("click", ".activar-desactivar", _eventos.clickClassActivarDesactivar);
       $("body").on("click", "#btnNuevoMasivo", _eventos.clickNuevoMasivo);
       $("body").on("click", "#btnDescripcionMasivo", _eventos.clickDescripcionMasivo);
       $("body").on("click", "#btnCancelarDescMasivo1", _eventos.clickCancelarDescMasivo1);
       $("body").on("click", "#btnAceptarDescMasivo1", _eventos.clickAceptarDescMasivo1);
       $("body").on("click", "#btnActualizarTonos", _eventos.clickActualizarTonos);
       $("body").on("click", "#btnAceptarMasivo1", _eventos.clickAceptarMasivo1);
       $("body").on("click", "#btnAceptarMasivo2", _eventos.clickAceptarMasivo2);
       $("body").on("click", "#btnCancelarMasivo1", _eventos.clickCancelarMasivo1);
       $("body").on("click", "#btnCancelarMasivo2", _eventos.clickCancelarMasivo2);
       $("body").on("click", "#btnAceptarMasivo3", _eventos.clickAceptarMasivo3);
       $("body").on("click", "#btnCargaMasivaImagenes", _eventos.clickCargaMasivaImagenes);
       $("body").on("click", "#divImagenEstrategia", _eventos.clickImagenEstrategia);
       $("body").on("click", "#divInformacionAdicionalEstrategia", _eventos.clickInformacionAdicionalEstrategia);
       $("body").on("click", "#linkTallaColor", _eventos.clickLinkTallaColor);
        

       $("#matriz-comercial-header").on("click", "#matriz-busqueda-nemotecnico #btnBuscarNemotecnico",_eventos.clickBuscarNemotencnico);
       $("#matriz-comercial-header").on("click", "#matriz-busqueda-nemotecnico #btnLimpiarBusquedaNemotecnico", _eventos.clickLimipiarNemotecnico);
       $(".chkImagenProducto").on("click", _eventos.clickChkImagenProducto);
       $("#imgSeleccionada").on("click", _eventos.clickImgSeleccionada);
       $("#matriz-comercial-images").on("click", ".img-matriz-preview", _eventos.clickImgSeleccionada);
       $("#matriz-comercial-images").on("click", ".chkImagenProducto", _eventos.clickChkImagenProducto);
       $("#divImagenEstrategia").on("click", _eventos.clickImagenEstrategia);
       $("#divInformacionAdicionalEstrategia").on("click", _eventos.clickInformacionAdicionalEstrategia);
        
       $("body").on("chage", "#ddlTipoEstrategia", _eventos.changeTipoEstrategia);
       $("body").on("change", "#ddlPais", _eventos.changePais);
       $("body").on("keyup", "#txtCUV", _eventos.keyUpCuv);
       $("body").on("keyup", "#txtCUVTC", _eventos.keyUpCuvTc);
       $("body").on("keyup", "#txtCUV2", _eventos.keyUpCuv2);
    }

    
    // Public functions 
    function VerCuvsTipo(tipo) {
        _fnGrillaCuv1(tipo);
    }
    function VerCuvsTipo2(tipo) {
        _fnGrillaCuv2(tipo);
    }
    function Editar(id, event) {
        event.preventDefault();
        event.stopPropagation();

        if (id != 0)
            _variables.isNuevo = false;

        if (id) {
            _limpiarFiltrosNemotecnico();

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
    };
    function Deshabilitar(id, event) {
        event.preventDefault();
        event.stopPropagation();

        var elimina = confirm("¿Está seguro que desea deshabiltar la estrategia seleccionada?");
        if (!elimina)
            return false;

        if (id) {
            waitingDialog({});

            $("#hdEstrategiaID").val(id);

            var params = {
                EstrategiaID: $("#hdEstrategiaID").val()
            };

            jQuery.ajax({
                type: "POST",
                url: _config.urlDeshabilitarEstrategia,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function(data) {
                    _toastHelper.success(data.message);
                    fnGrilla();
                    closeWaitingDialog();
                },
                error: function(data, error) {
                    _toastHelper.error(data.message);
                    closeWaitingDialog();
                }
            });
        }
        return false;
    }
    
    function ActualizarParNemotecnico(val) {
        _config.habilitarNemotecnico = val;
        _matrizFileUploader.actualizarParNemotecnico(val);
    }
    function EditarDescripcionComercial(idImagen) {
        _editarDescripcionComercial(idImagen);
    }
    function Inicializar() {
        _iniDialog();
        _bindingEvents();
        _fnGrilla();
        _activarDesactivarChecks();
        _paletaColores();
        
        _uploadFileLanzamineto("img-fondo-desktop");
        _uploadFileLanzamineto("img-prev-desktop");
        _uploadFileLanzamineto("img-ficha-desktop");
        _uploadFileLanzamineto("img-ficha-fondo-desktop");
        _uploadFileLanzamineto("img-ficha-mobile");
        _uploadFileLanzamineto("img-ficha-fondo-mobile");
        _uploadFileLanzamineto("img-home-desktop");
        _uploadFileLanzamineto("img-home-mobile");

        if (_config.habilitarNemotecnico) {
            $("#matriz-busqueda-nemotecnico").show();
        } else {
            $("#matriz-busqueda-nemotecnico").hide();
        }
    }
    
    return {
        Inicializar: Inicializar,
        Editar: Editar,
        Deshabilitar: Deshabilitar,
        VerCuvsTipo: VerCuvsTipo,
        VerCuvsTipo2: VerCuvsTipo2,
        ActualizarParNemotecnico: ActualizarParNemotecnico,
        EditarDescripcionComercial: EditarDescripcionComercial
    }
});