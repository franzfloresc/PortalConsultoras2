var AdministrarEstrategia = (function (config) {
    //'use strict';
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
        tipoEstrategiaIncentivosProgramaNuevas: config.tipoEstrategiaIncentivosProgramaNuevas,
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
        urlUploadCvs: config.urlUploadCvs,
        rutaImagenDisable: config.rutaImagenDisable,
        urlEliminarEstrategia: config.urlEliminarEstrategia,
        urlConsultarShowRoom: config.urlConsultarShowRoom,
        urlGetShowRoomNiveles: config.urlGetShowRoomNiveles,
        urlGetShowRoomPersonalizacionNivel: config.urlGetShowRoomPersonalizacionNivel,
        urlGuardarPersonalizacionNivelShowRoom: config.urlGuardarPersonalizacionNivelShowRoom,
        urlImageMatrizUpload: config.urlImageMatrizUpload,
        urlDeshabilitarShowRoomEvento: config.urlDeshabilitarShowRoomEvento,
        urlEliminarShowRoomEvento: config.urlEliminarShowRoomEvento,
        urlGuardarShowRoom: config.urlGuardarShowRoom,
        urlConsultarOfertaShowRoomDetalle: config.urlConsultarOfertaShowRoomDetalle,
        urlEliminarOfertaShowRoomDetalleAll: config.urlEliminarOfertaShowRoomDetalleAll,
        urlEliminarOfertaShowRoomDetalle: config.urlEliminarOfertaShowRoomDetalle,
        urlInsertOfertaShowRoomDetalle: config.urlInsertOfertaShowRoomDetalle,
        urlUpdateOfertaShowRoomDetalle: config.urlUpdateOfertaShowRoomDetalle,
        rutaImagenTemporal: config.rutaImagenTemporal,
        imagenEdit: config.imagenEdit,
        imagenDeshabilitar: config.imagenDeshabilitar,
        imagenEliminar: config.imagenEliminar,
        imagenProductoVacio: config.imagenProductoVacio,
        urlUploadFileStrategyShowroom: config.urlUploadFileStrategyShowroom,
        urlUploadFileProductStrategyShowroom: config.urlUploadFileProductStrategyShowroom,
        urlCargarArbolRegionesZonas: config.urlCargarArbolRegionesZonas,
        rutastylejstree: config.rutastylejstree,
        urlUploadBloqueoCuv: config.urlUploadBloqueoCuv
    };

    var _variables = {
        isNuevo: false,
        cantidadPrecargar: 0,
        cantidadPrecargar2: 0,
        cantidadOp: 0,
        imagen: "",
        isVistaPreviaOpened: false,
        paisNombre: "",
        cantGuardadaTemporal: 0,
        NroLote: 0,
        Pagina: 0
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
        HerramientaVenta: "011",
        ShowRoom: "030"

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
        LosMasVendidos: 20,
        HerramientaVenta: 13,
        ShowRoom: 30
    }

    var _editData = {};
    var _idImagen = 0;

    var _paginadorClick = function (page) {
        var valNemotecnico = $("#txtBusquedaNemotecnico").val();
        var fnObtenerImagenes = (_config.habilitarNemotecnico && valNemotecnico)
            ? _obtenerImagenesByNemotecnico
            : _obtenerImagenesByCodigoSAP;
        fnObtenerImagenes(_editData, page, false).done(function () { closeWaitingDialog(); });
    };

    var _paginador = Paginador({
        elementId: "matriz-" +
        "imagen" +
        "es-paginacion",
        elementClick: _paginadorClick
    });

    var _mostrarPaginacion = function (numRegistros) {
        if ($("#matriz-imagenes-paginacion").children().length !== 0) {
            return false;
        }

        _paginador.paginar(numRegistros);

    };
    var _mostrarListaImagenes = function (editData) {
        SetHandlebars("#matriz-comercial-item-template", editData, "#matriz-comercial-images");
        $(".qq-upload-list").css("display", "none");

        setInterval(function () { AddTitleCustom(); }, 1000);
    };

    var _agregarCamposLanzamiento = function (nombreCampo, valor) {
        $("#nombre-" + nombreCampo).val(valor);
        $("#src-" + nombreCampo).attr("src", _config.urlS3 + valor);
    };

    var _paletaColores = function () {
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
            move: function (color) {

            },
            show: function () {

            },
            beforeShow: function () {

            },
            hide: function () {

            },
            change: function () {
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
    var _activarDesactivarChecks = function () {
        $(".activar-desactivar").each(function () {
            if (!$(this).attr("checked")) {
                $(this).parent().parent().find("input").each(function () {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", true);
                });
                $(this).parent().parent().find("select").each(function () {
                    $(this).val("");
                    $(this).attr("disabled", true);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            } else {
                $(this).parent().parent().find("input").each(function () {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", false);
                });
                $(this).parent().parent().find("select").each(function () {
                    $(this).val("");
                    $(this).attr("disabled", false);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            }
        });
    }
    var _obtenerImagenGrilla = function (id) {
        if (id === 0) return "";
        var imagen = jQuery("#list").jqGrid("getCell", id, "ImagenURL") || "";
        return (imagen === _config.rutaImagenVacia) ? "" : $.trim(imagen);
    };

    var _seleccionarTipoOferta = function () {
        var flagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
        var flagRecoProduc = $("#ddlTipoEstrategia option:selected").attr("flag-recoproduct");
        var flagRecoPerfil = $("#ddlTipoEstrategia option:selected").attr("flag-recoperfil");
        var codigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");

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

    var _limpiarFiltrosNemotecnico = function () {
        $("#txtBusquedaNemotecnico").val("");
        $("#chkTipoBusquedaNemotecnico").prop("checked", false);
    };

    var _matrizFileUploader = MatrizComercialFileUpload({
        actualizarMatrizComercialAction: _config.actualizarMatrizComercialAction,
        habilitarNemotecnico: _config.habilitarNemotecnico,
        nemotecnico: _nemotecnico
    });
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
                _toastHelper.error(response.message);
            }
        }
        closeWaitingDialog();
    }
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
    var _crearFileUploadAdd = function (editData) {
        var itemData = { elementId: "file-upload", IdMatrizComercialImagen: 0 };
        var params = _obtenerParamsFileUpload(itemData, editData);
        _matrizFileUploader.crearFileUpload(params);
        $("#file-upload .qq-upload-button span").text("Nueva Imagen");
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
            descripcionOriginal: jQuery("#list").jqGrid("getCell", _idImagen, "DescripcionCUV2"),
            ValidarImagen: data.ValidarImagen,
            PesoMaximo: data.PesoMaximo
        };

        _obtenerFiltrarEstrategia(_editData, id).done(function (data) {
            var TipoEstrategiaCodigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");
            if (TipoEstrategiaCodigo == _config.tipoEstrategiaIncentivosProgramaNuevas)
                $("#divPrecioValorizado").html("Ganancia");
            else
                $("#divPrecioValorizado").html("Precio Valorizado");

            showDialog("DialogAdministracionEstrategia");
            _ActualizarFlagIndividual(data);
            _editData.IdMatrizComercial = data.IdMatrizComercial;
            _editData.CUV2 = data.CUV2;

            _crearFileUploadAdd(_editData);

            _obtenerImagenes(_editData, 1, true).done(function () {
                showDialog("matriz-comercial-dialog");
                closeWaitingDialog();
            });
        }).error(function () {
            _toastHelper.error(data.message);
            closeWaitingDialog();
        });

        _descripcionComercial.actualizarPais(_editData.paisID);
        return false;
    };

    var _editarDescripcionComercial = function (idImagen) {
        _descripcionComercial.editarDescripcionComercial(idImagen);
    };

    var _obtenerFiltrarEstrategia = function (data, id) {
        var params = {
            EstrategiaID: data.EstrategiaID,
            cuv2: data.CUV2,
            CampaniaID: data.CampaniaID,
            TipoEstrategiaID: data.TipoEstrategiaID
        };
        return $.post(_config.getFiltrarEstrategiaAction, params).done(_obtenerFiltrarEstrategiaSuccess(data, id));
    };

    var _obtenerFiltrarEstrategiaSuccess = function (editData, id) {
        return function (data, textStatus, jqXHR) {

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
            $("#spanTipoEstrategia").val($("#ddlTipoEstrategia option:selected").html() ? $("#ddlTipoEstrategia option:selected").html().trim():'');
            $("#hdEstrategiaID").val(data.EstrategiaID);
            $("#hdTipoEstrategiaID").val(data.TipoEstrategiaID);
            $("#hdCampania").val(data.CampaniaID);
            $("#ddlCampaniaFin").val(data.CampaniaIDFin);
            $("#hdNumeroPedido").val(data.NumeroPedido);
            $("#imgSeleccionada").attr("src", _config.rutaImagenVacia);

            if (data.ImagenMiniaturaURL == "") {
                $("#imgMiniSeleccionada").attr("src", _config.rutaImagenVacia);
                $("#hdImagenMiniaturaURLAnterior").val("");
            } else {
                $("#imgMiniSeleccionada").attr("src", data.ImagenMiniaturaURL);
                $("#hdImagenMiniaturaURLAnterior").val(data.ImagenMiniaturaURL.replace(/^.*[\\\/]/, ""));
            }
            if (data.EsSubCampania == 1) {
                $("#chkEsSubCampania").attr("checked", true);
            } else {
                $("#chkEsSubCampania").removeAttr("checked");
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
            $("#hdNiveles").val(data.Niveles);
            
            var aux1 = $("#ddlTipoEstrategia").find(":selected").data("id");
            var aux2 = $("#hdEstrategiaCodigo").val();

            if (aux1 == "4" || aux2 == "005" || aux2 == "007" || aux2 == "008" || aux2 == "030") {
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

            if (aux1 == "4" || aux1 == "5" || aux2 == "005" || aux2 == "007" || aux2 == "008" || aux2 == "030") {
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
            _agregarCamposLanzamiento("img-fondo-mobile", data.ImgFondoMobile);
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
            if ($("#ddlTipoEstrategia").find(":selected").data("codigo") == "030") {
                _vistaNuevoProductoShowroon();
            } else {
                _vistaNuevoProductoGeneral();
            }

            _ActualizarFlagIndividual(data);

            return data;
        };
    };

    var _obtenerImagenes = function (data, pagina, recargarPaginacion) {
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

    var _obtenerImagenesByNemotecnico = function (data, pagina, recargarPaginacion) {
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

    var _marcarCheckRegistro = function (imgRow) {
        $('.chkImagenProducto[value="' + imgRow + '"]').first().attr("checked", "checked");
        _variables.imagen = imgRow;
        $("#imgSeleccionada").attr("src", _variables.imagen);
    }

    var _obtenerImagenesSuccess = function (editData, recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
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
    var _obtenerImagenesByCodigoSAP = function (data, pagina, recargarPaginacion) {
        var params = { paisID: $("#ddlPais").val(), codigoSAP: data.CodigoSAP, pagina: pagina };
        return $.post(_config.getImagesByCodigoSAPAction, params)
            .done(_obtenerImagenesByCodigoSAPSuccess(data, recargarPaginacion));
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
            _marcarCheckRegistro(_obtenerImagenGrilla(_idImagen));
            closeWaitingDialog();
        };
    };

    var _validarNemotecnico = function () {
        var msj = "";
        var val = $("#txtBusquedaNemotecnico").val();
        if (!val) {
            msj += " - Debe ingresar un Nemotecnico .\n";
        }

        return msj;
    };
    var _uploadFileLanzamineto = function (divId) {
        var uploader = new qq.FileUploader({
            allowedExtensions: ["jpg", "png", "jpeg"],
            element: document.getElementById(divId),
            action: _config.urlImageLanzamientoUpload,
            onComplete: function (id, fileName, responseJSON) {
                if (checkTimeout(responseJSON)) {
                    if (responseJSON.success) {
                        $("#nombre-" + divId).val(responseJSON.name);
                        $("#src-" + divId).attr("src", _config.rutaTemporal + responseJSON.name);
                    } else _toastHelper.error(responseJSON.message);
                }
                return false;
            },
            onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
            onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
        });
        return false;
    }

    var _createGridUpdated = function (list) {
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
            beforeSelectRow: function (rowid, e) { return false; }
        });
    }
    var _createGridNotUpdated = function (list) {
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
            beforeSelectRow: function (rowid, e) { return false; }
        });
    }

    var _showActions = function (cellvalue, options, rowObject) {

        var id = rowObject[0];
        var edit = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Editar('" + id + "',event);\" >" + "<img src='" + _config.rutaImagenEdit + "' alt='Editar Estrategia' title='Editar Estrategia' border='0' /></a>";
        var disable = "";
        if (rowObject[10] == "1") {
            disable += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" + id + "',event);\" >" + "<img src='" + _config.rutaImagenDisable + "' alt='Deshabilitar Estrategia' title='Deshabilitar Estrategia' border='0' /></a>";
        }
        var remove = "";
        if ($("#ddlTipoEstrategia").find(":selected").data("codigo") == _codigoEstrategia.ShowRoom) {
            remove += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Remover('" + id + "',event);\" >" + "<img src='" + _config.rutaImagenDelete + "' alt='Eliminar Estrategia' title='Eliminar Estrategia' border='0' /></a>";
        }

        return edit + disable + remove;
    }

    var _showActionsProductos = function (cellvalue, options, rowObject) {

        var id = rowObject[0];
        var campaniaId = $("#ddlCampania").val();
        var cuv = rowObject[5];

        var edit = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').EditarProducto('" + id + "','" + campaniaId + "','" + cuv + "',event);\" >" + "<img src='" + _config.rutaImagenEdit + "' alt='Editar Productos ShowRoom' title='Editar Productos ShowRoom' border='0' /></a>";
        var remove = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').EliminarProducto('" + id + "',event);\" >" + "<img src='" + _config.rutaImagenDisable + "' alt='Deshabilitar Productos ShowRoom' title='Deshabilitar Productos ShowRoom' border='0' /></a>";

        return edit + remove;
    }
    
    var _showActionsTC = function (cellvalue, options, rowObject) {
        var Des = "<a href='javascript:;' onclick=\"return EditarTalla('" + rowObject[0] + "');\" >" + "<img src='" + _config.rutaImagenEdit + "' alt='Editar Talla/Color' title='Editar Talla/Color' border='0' /></a>";
        if ($.trim(rowObject[1]) != $.trim($("#txtCUV2").val())) {
            Des += "<a href='javascript:;' onclick=\"return Eliminar('" + rowObject[0] + "');\" >" + "<img src='" + _config.rutaImagenDelete + "' alt='Quitar Talla/Color' title='Quitar Talla/Color' border='0' /></a>";
        }
        return Des;
    }
    var _showImage = function (cellvalue, options, rowObject) {
        var image = $.trim(rowObject[9]);
        var filename = image.replace(/^.*[\\\/]/, "");
        image = '<img src="' +
            (filename != "" ? image : _config.rutaImagenVacia) +
            '" alt="" width="70px" height="60px" title="" border="0" />';
        return image;
    }
    var _mostrarInformacionCuv = function (cuvIngresado) {
        var isNuevo = _variables.isNuevo;
        $("#hdnCodigoSAP").val("");
        $("#hdnEnMatrizComercial").val("");
        if (cuvIngresado.length == 5) {
            waitingDialog();
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
                success: function (data) {
                    var objPreview, objChkImagen, idImagen, dataImagen;
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
                        $("#hdNiveles").val(data.niveles);
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
                error: function (data, error) {
                    closeWaitingDialog();
                    _toastHelper.error(data.message);
                }
            });
        }
    }
    var _limpiarCamposLanzamiento = function (nombreCampo) {
        $("#nombre-" + nombreCampo).val("");
        $("#src-" + nombreCampo).attr("src", _config.rutaImagenVacia);
    };
    var _limpiarBusquedaNemotecnico = function () {
        _limpiarFiltrosNemotecnico();
        waitingDialog();
        _obtenerImagenesByCodigoSAP(_editData, 1, true);
    }
    var _clearFields = function () {

        $("#hdnCodigoSAP").val("");
        $("#mensajeErrorCUV").val("");
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
        $("#imgMiniSeleccionada").attr("src", _config.rutaImagenVacia);
        $("#hdImagenMiniaturaURLAnterior").val("");
        $("#chkEsSubCampania").removeAttr("checked");

        $("#divImagenEstrategiaContenido").show();
        $("#divInformacionAdicionalEstrategiaContenido").hide();

        $("#divImagenEstrategia").css("color", "white");
        $("#divImagenEstrategia").css("background", "#00A2E8");
        $("#divInformacionAdicionalEstrategia").css("color", "#702789");
        $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");
        $("#txtTextoLibre").val("");
        _limpiarCamposLanzamiento("img-fondo-desktop");
        _limpiarCamposLanzamiento("img-fondo-mobile");
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
        if ($("#hdEstrategiaCodigo").val() === _codigoEstrategia.Lanzamiento) {
            $("#div-revista-digital").show();
            $("#divSeccionIndividual").show();
        }
        else {
            $("#div-revista-digital").hide();
            $("#divSeccionIndividual").hide();
        }
        _ActualizarFlagIndividual();

    };

    var _uploadFileCvs = function () {
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
            success: function (data) {
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
                $("#divDescMasivoPaso1").fadeOut(function () {
                    $("#divDescMasivoPaso2").fadeIn();
                });
            },
            error: function (data) {
                _toastHelper.error(data.statusText);
            }
        });
    }
    var _uploadFileBloqueoCuv = function () {
        var formData = new FormData();
        var totalFiles = document.getElementById("fileBloqueoCuv").files.length;
        if (totalFiles <= 0) {
            _toastHelper.error("Seleccione al menos un archivo.");
            return false;
        }
        var file = document.getElementById("fileBloqueoCuv").files[0];
        var filename = file.name;
        if ((file.size / 1024 / 1024) > 4) {
            _toastHelper.error("El archivo es demasiado extenso para ser procesado.");
            return false;
        }

        if (filename.substring(filename.lastIndexOf(".") + 1) !== "csv") {
            _toastHelper.error("El archivo no tiene la extensión correcta.");
            return false;
        }

        formData.append("Documento", document.getElementById("fileBloqueoCuv").files[0]);
        formData.append("Pais", $("#ddlPais").val());
        formData.append("CampaniaId", $("#ddlCampania").val());
        formData.append("TipoEstrategia", $("#ddlTipoEstrategia").val());

        $.ajax({
            url: _config.urlUploadBloqueoCuv,
            type: "POST",
            dataType: "JSON",
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {

                $("#listCargaBloqueoCuv").jqGrid("GridUnload");
                var gridJson = {
                    page: 1,
                    total: 2,
                    records: 10,
                    rows: [
                        {
                            Descripcion: "CUVs Cargados",
                            Cantidad: data.listActualizado
                        }
                    ]
                };

                $("#listCargaBloqueoCuv").empty().jqGrid({
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
                $("#titleCuvBloqueado").fadeOut();
                $("#listCuvsBloqueados").fadeOut();
                $("#divBloqueoCuvPaso1").fadeOut(function () {
                    $("#divBloqueoCuvPaso2").fadeIn();
                    $("#titleCuvBloqueado").html("Nuevas Cuvs cargados:").fadeIn();
                    $("#listCuvsBloqueados").html(data.valor).fadeIn();
                });
            },
            error: function (data) {
                _toastHelper.error(data.statusText);
            }
        });
    }

    var _basicFieldsValidation = function () {
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
    var _fnGrilla = function () {
        $("#divSeccionProductos").show();
        $("#list").jqGrid("GridUnload");
        var tipo = $("#ddlTipoEstrategia").find(":selected").data("id");
        var codigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");

        var colNameActions = (codigo == _codigoEstrategia.ShowRoom) ? "Set" : "";
        var hideColProducts = (codigo == _codigoEstrategia.ShowRoom) ? false : true;

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
                codigo == "010" ||
                codigo == _codigoEstrategia.ShowRoom ||
                codigo == _codigoEstrategia.HerramientaVenta),
            multiselectWidth: 35,
            colNames: [
                "EstrategiaID", "Orden", "#", "Pedido Asociado", "Precio", "CUV2", "Descripción", "Limite Venta", "Código SAP", "ImagenURL",
                "Foto", colNameActions, "Productos", "EsOfertaIndependiente"
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
                    width: 60,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: false,
                    formatter: _showActions
                },
                {
                    name: "Activo",
                    index: "Activo",
                    width: 60,
                    align: "center",
                    editable: true,
                    resizable: false,
                    sortable: false,
                    hidden: hideColProducts,
                    formatter: _showActionsProductos
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
            loadComplete: function (data) {

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
        if (tipo == "4" || codigo == "005" || codigo == "007" ||
            codigo == "008" || codigo == "010" || codigo == _codigoEstrategia.ShowRoom || codigo == _codigoEstrategia.HerramientaVenta) {
            $("#list").jqGrid("hideCol", ["Orden"]);
        }

        $("<span style=\"position: absolute;margin-top: 10px;\">(*)</span>").prependTo("#jqgh_list_cb");
    }

    var _buscarNemotecnico = function () {
        var validacionMsj = _validarNemotecnico();

        if (validacionMsj) {
            _toastHelper.error(validacionMsj);
            return false;
        }
        waitingDialog();
        _obtenerImagenesByNemotecnico(_editData, 1, true);
        return true;
    }
    var _pedidoAsociadoChecks = function () {
        waitingDialog();
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
            success: function (data) {
                if (data != null && data.pedidoAsociado.length > 0) {
                    var pedidoAsociados = data.pedidoAsociado[0].PedidoAsociado.split(",");
                    $.each(pedidoAsociados,
                        function (x) {
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
            error: function (x, xh, xhr) {
                if (checkTimeout(x)) {
                    closeWaitingDialog();
                }
            }
        });
    }
    var _validarMasivo = function () {
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

        var estrategiaId = $("#ddlTipoEstrategia option:selected").data("id") || "";
        if (!estrategiaId.in(_idEstrategia.OfertaParaTi,
            _idEstrategia.GuiaDeNegocio,
            _idEstrategia.LosMasVendidos,
            _idEstrategia.Lanzamiento,
            _idEstrategia.OfertasParaMi,
            _idEstrategia.PackAltoDesembolso,
            _idEstrategia.OfertaDelDia,
            _idEstrategia.ShowRoom,
            _idEstrategia.HerramientaVenta)) {

            _toastHelper.error("Debe seleccionar el tipo de Estrategia que permita esta funcionalidad.");
            return false;
        }

        return true;
    }
    var _cerrarTallaColor = function () {
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
            success: function (data) {
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
            error: function (data, error) {
                _toastHelper.error(data.message);
            }
        });
    }

    var _fnGrillaTC = function () {
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
                    formatter: _showActionsTC
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
            loadComplete: function () { },
            gridComplete: function () {
                showDialog("DialogTonoMarca");
            }
        });
        jQuery("#listTC").jqGrid("navGrid",
            "#pagerTC",
            { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listTC").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }

    var _ActualizarFlagIndividual = function (data) {
        data = data || {};
        if (data.FlagIndividual == 1 || data.FlagIndividual === true) {
            $("#chkFlagIndividual").attr("checked", true);
        } else {
            $("#chkFlagIndividual").removeAttr("checked");
        }

        _eventos.clickCheckFlagIndividual();

        data.Slogan = data.Slogan || "";
        $("#txtSlogan").val(data.Slogan);
    }

    // SHOWROOM-INICIO
    var _limpiarDatos = function () {
        $("#chkHabilitarOferta").removeAttr("checked");
        $("#chkEsSubCampania").removeAttr("checked");
    }

    var _limpiarDatosEventoShowRoomDetalle = function () {
        $("#hdEstrategiaProductoID").val("0");
        $("#txtCUVProductoDetalle").val("");
        $("#txtNombreProductoDetalle").val("");
        $("#txtDescripcion1Detalle").val("");

        $("#txtPrecioOfertaDetalle").val("0");
        $("#chkActivoOfertaDetalle").attr("checked", false);

        $("#ddlMarcaProductoDetalle").val("0");
        $("#imgProductoDetalle").attr("src", _config.imagenProductoVacio);
        $("#hdImagenDetalle").val("");
        $("#hdImagenDetalleAnterior").val("");
    }

    var _limpiarDatosEventoShowRoom = function () {
        $("#txtEventoNombre").val("");
        $("#txtEventoTema").val("");
        $("#txtEventoDiasAntes").val("");
        $("#txtEventoDiasDespues").val("");
        $("#txtEventoRutaShowRoomPopup").val("");
        $("#txtEventoRutaShowRoomBannerLateral").val("");

        $("#divPopupWebFondo").html("");
        $("#divPopupVentaImagenSet").html("");
        $("#divPopupWebImagenSet").html("");
        $("#divPopupTagLateralVentaImagenSet").html("");
        $("#divCabeceraPaginaProductos").html("");
        $("#divPestaniaNombreShowRoom").html("");
        $("#divPopupImagenPreventaDigital").html("");

        $("#chkEventoTieneSubCampania, #chkEventocompraXcompra").attr("checked", false);
    }

    var _cargarNiveles = function () {
        jQuery.ajax({
            type: "POST",
            url: _config.urlGetShowRoomNiveles,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            async: true,
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        $("#cbNivelEvento").empty();

                        if (response.data == "") {
                            $("#divPersonalizacion").css("display", "none");
                        } else {
                            var listaNiveles = response.data || new Array();

                            $("#cbNivelEvento").append('<option value="">-- Seleccionar --</option>');

                            $.each(listaNiveles, function (index, value) {
                                var html = '<option value="' + value.NivelId + '">' + value.Descripcion + "</option>";

                                $("#cbNivelEvento").append(html);
                            });

                            $("#divPersonalizacion").css("display", "");
                        }
                    } else {
                        $("#divPersonalizacion").css("display", "none");
                        alert(response.message);
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    alert(response.message);
                    closeWaitingDialog();
                }
            }
        });
    }

    var _cargarImagenes = function (showroomEvento) {
        if (showroomEvento.Imagen1 != "") {
            $("#divPopupWebFondo").html("");
            var htmlImagen1 = '<img src="' + showroomEvento.Imagen1 + '" alt="PopupWebFondo" style="width: 75px; height: 50px;" />';
            $("#divPopupWebFondo").html(htmlImagen1);
        }
        $("#hdImagen1").val(showroomEvento.Imagen1.replace(/^.*[\\\/]/, ""));
        $("#hdImagen1Anterior").val(showroomEvento.Imagen1.replace(/^.*[\\\/]/, ""));

        if (showroomEvento.ImagenVentaSetPopup != "") {
            $("#divPopupVentaImagenSet").html("");
            var htmlImagen2 = '<img src="' + showroomEvento.ImagenVentaSetPopup + '" alt="PopupVentaImagenSet" style="width: 75px; height: 50px;" />';
            $("#divPopupVentaImagenSet").html(htmlImagen2);
        }
        $("#hdImagenVentaSetPopup").val(showroomEvento.ImagenVentaSetPopup.replace(/^.*[\\\/]/, ""));
        $("#hdImagenVentaSetPopupAnterior").val(showroomEvento.ImagenVentaSetPopup.replace(/^.*[\\\/]/, ""));

        if (showroomEvento.Imagen2 != "") {
            $("#divPopupWebImagenSet").html("");
            var htmlImagen3 = '<img src="' + showroomEvento.Imagen2 + '" alt="Imagen2" style="width: 75px; height: 50px;" />';
            $("#divPopupWebImagenSet").html(htmlImagen3);
        }
        $("#hdImagen2").val(showroomEvento.Imagen2.replace(/^.*[\\\/]/, ""));
        $("#hdImagen2Anterior").val(showroomEvento.Imagen2.replace(/^.*[\\\/]/, ""));

        if (showroomEvento.ImagenVentaTagLateral != "") {
            $("#divPopupTagLateralVentaImagenSet").html("");
            var htmlImagen4 = '<img src="' + showroomEvento.ImagenVentaTagLateral + '" alt="PopupTagLateralVentaImagenSet" style="width: 75px; height: 50px;" />';
            $("#divPopupTagLateralVentaImagenSet").html(htmlImagen4);
        }
        $("#hdImagenVentaTagLateral").val(showroomEvento.ImagenVentaTagLateral.replace(/^.*[\\\/]/, ""));
        $("#hdImagenVentaTagLateralAnterior").val(showroomEvento.ImagenVentaTagLateral.replace(/^.*[\\\/]/, ""));

        if (showroomEvento.ImagenCabeceraProducto != "") {
            $("#divCabeceraPaginaProductos").html("");
            var htmlImagen5 = '<img src="' + showroomEvento.ImagenCabeceraProducto + '" alt="CabeceraPaginaProductos" style="width: 75px; height: 50px;" />';
            $("#divCabeceraPaginaProductos").html(htmlImagen5);
        }
        $("#hdImagenCabeceraProducto").val(showroomEvento.ImagenCabeceraProducto.replace(/^.*[\\\/]/, ""));
        $("#hdImagenCabeceraProductoAnterior").val(showroomEvento.ImagenCabeceraProducto.replace(/^.*[\\\/]/, ""));

        if (showroomEvento.ImagenPestaniaShowRoom != "") {
            $("#divPestaniaNombreShowRoom").html("");
            var htmlImagen6 = '<img src="' + showroomEvento.ImagenPestaniaShowRoom + '" alt="PestaniaNombreShowRoom" style="width: 75px; height: 50px;" />';
            $("#divPestaniaNombreShowRoom").html(htmlImagen6);
        }
        $("#hdImagenPestaniaShowRoom").val(showroomEvento.ImagenPestaniaShowRoom.replace(/^.*[\\\/]/, ""));
        $("#hdImagenPestaniaShowRoomAnterior").val(showroomEvento.ImagenPestaniaShowRoom.replace(/^.*[\\\/]/, ""));

        if (showroomEvento.ImagenPreventaDigital != "") {
            $("#divPopupImagenPreventaDigital").html("");
            var htmlImagen7 = '<img src="' + showroomEvento.ImagenPreventaDigital + '" alt="PopupImagenPreventaDigital" style="width: 75px; height: 50px;" />';
            $("#divPopupImagenPreventaDigital").html(htmlImagen7);
        }
        $("#hdImagenPreventaDigital").val(showroomEvento.ImagenPreventaDigital.replace(/^.*[\\\/]/, ""));
        $("#hdImagenPreventaDigitalAnterior").val(showroomEvento.ImagenPreventaDigital.replace(/^.*[\\\/]/, ""));
    }

    var _showActionsEvento = function (cellvalue, options, rowObject) {
        var edit = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listEvento').EditarEvento('" + options.rowId + "','" + rowObject.CampaniaID + "','" + rowObject.Estado + "','" + rowObject.TieneCategoria + "','" + rowObject.TieneCompraXcompra + "','" + rowObject.TieneSubCampania + "', " + rowObject.TienePersonalizacion + ");\" >" + "<img src='" + _config.imagenEdit + "' alt='Editar Evento ShowRoom' title='Editar Evento Show Room' border='0' /></a>";
        var del = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listEvento').DeshabilitarEvento('" + options.rowId + "','" + rowObject.CampaniaID + "');\" >" + "<img src='" + _config.imagenDeshabilitar + "' alt='Deshabilitar Evento ShowRoom' title='Deshabilitar Evento ShowRoom' border='0' /></a>";
        var remove = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listEvento').EliminarEvento('" + options.rowId + "','" + rowObject.CampaniaID + "');\" >" + "<img src='" + _config.imagenEliminar + "' alt='Eliminar Evento ShowRoom' title='Eliminar Evento ShowRoom' border='0' /></a>";

        var resultado = edit;

        if (rowObject.Estado == "1")
            resultado += del;

        if (rowObject.Estado == "1")
            resultado += remove;

        $("#hdEventoID").val(options.rowId);
        //Carga de Consultoras
        $("#hdCargaEventoID").val(options.rowId);
        $("#hdCargaCampaniaID").val(rowObject.CampaniaID);
        //Carga de Stock
        $("#hdCargaStockEventoID").val(options.rowId);
        //Carga de Descripcion de Sets
        $("#hdCargaDescripcionSetsEventoID").val(options.rowId);
        $("#hdCargaDescripcionSetsCampaniaID").val(rowObject.CampaniaID);
        //Carga de Productos Compra por Compra
        $("#hdCargarProductoCpcEventoID").val(options.rowId);
        $("#hdCargarProductoCpcCampaniaID").val(rowObject.CampaniaID);

        return resultado;
    }

    var _fnGrillaEvento = function () {
        jQuery("#listEvento").jqGrid({
            url: _config.urlConsultarShowRoom,
            hidegrid: false,
            datatype: "json",
            postData: ({
                PaisID: function () { return $("#ddlPais").val(); },
                CampaniaID: function () { return ($("#ddlCampania").val() == "" ? "0" : $("#ddlCampania").val()); }
            }),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["EventoID", "Nombre", "Tema", "Dias Antes Fact.", "Dias Despues Fact.", "Personalización", "# Perfiles", "Imagen1", "Imagen2", "ImagenCabeceraProducto", "ImagenVentaSetPopup", "ImagenVentaTagLateral", "ImagenPestaniaShowRoom", "ImagenPreventaDigital", ""],
            colModel: [
                { name: "id", width: 50, editable: true, resizable: false },
                { name: "Nombre", width: 80, editable: true, resizable: false },
                { name: "Tema", width: 80, editable: true, resizable: false },
                { name: "DiasAntes", width: 50, editable: true, resizable: false },
                { name: "DiasDespues", width: 50, editable: true, resizable: false },
                {
                    name: "TienePersonalizacion", width: 50, editable: true, resizable: false, formatter: function (cellvalue) {
                        return cellvalue == true ? "Activa" : "Inactiva";
                    }
                },
                { name: "NumeroPerfiles", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Imagen1", width: 65, editable: true, resizable: false, hidden: true },
                { name: "Imagen2", width: 65, editable: true, resizable: false, hidden: true },
                { name: "ImagenCabeceraProducto", width: 65, editable: true, resizable: false, hidden: true },
                { name: "ImagenVentaSetPopup", width: 65, editable: true, resizable: false, hidden: true },
                { name: "ImagenVentaTagLateral", width: 65, editable: true, resizable: false, hidden: true },
                { name: "ImagenPestaniaShowRoom", width: 65, editable: true, resizable: false, hidden: true },
                { name: "ImagenPreventaDigital", width: 65, editable: true, resizable: false, hidden: true },
                { name: "Options", width: 60, editable: true, sortable: false, align: "center", resizable: false, formatter: _showActionsEvento }
            ],
            jsonReader:
            {
                root: "rows",
                page: "page",
                total: "total",
                records: "records",
                repeatitems: false,
                cell: "",
                id: "id"
            },
            pager: jQuery("#pagerEvento"),
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
            width: 930,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function () {
            },
            gridComplete: function () {
                var cantidadRegistros = jQuery("#listEvento").jqGrid("getGridParam", "reccount");
                if (cantidadRegistros <= 0) {
                    $("#hdEventoID").val("0");
                    //Carga de Consultora
                    $("#hdCargaEventoID").val("0");
                    $("#hdCargaCampaniaID").val("");
                    //Carga de Stock
                    $("#hdCargaStockEventoID").val("0");
                    //Carga de Descripcion de Sets
                    $("#hdCargaDescripcionSetsEventoID").val("0");
                    $("#hdCargaDescripcionSetsCampaniaID").val("");
                    //Carga de Productos Compra por Compra
                    $("#hdCargarProductoCpcEventoID").val("0");
                    $("#hdCargarProductoCpcCampaniaID").val("");

                    $("#divShowRoomEventoNuevo").css("display", "");
                } else {
                    $("#divShowRoomEventoNuevo").css("display", "none");

                    // Listar Productos ShowRoom
                    _fnGrilla();

                    var showroomEvento = jQuery("#listEvento").jqGrid("getRowData")[0];
                    _cargarImagenes(showroomEvento);

                    _cargarNiveles();
                }
            }
        });
        jQuery("#listEvento").jqGrid("navGrid", "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listEvento").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }

    var _cargarEventoShowRoom = function () {
        $("#divPersonalizacion").css("display", "none");
        _limpiarDatosEventoShowRoom();

        var msjex = "";
        if ($("#ddlPais").val() === "")
            msjex += " - Debe seleccionar un País .\n";
        if ($("#ddlCampania").val() === "")
            msjex += " - Debe seleccionar un Campania .\n";

        if (msjex === "") {
            _fnGrillaEvento();

            $("#divShowRoomEvento").css("display", "");
        }
        else {
            alert(msjex);
            return false;
        }
    };

    var _limpiarDatosShowRoomDetalle = function () {
        $("#txtPaisDetalle").val("");
        $("#txtCampaniaDetalle").val("");
        $("#txtCUVDetalle").val("");
        $("#txtDescripcionDetalle").val("");
        $("#txtPrecioValorizadoDetalle").val("");
    }

    var _guardarShowRoomEvento = function () {
        var eventoID = $("#hdEventoID").val();
        var campaniaID = $("#txtEventoCampaniaID").val();
        var nombre = $("#txtEventoNombre").val();
        var tema = $("#txtEventoTema").val();
        var diasAntes = $("#txtEventoDiasAntes").val();
        var diasDespues = $("#txtEventoDiasDespues").val();
        var numeroPerfiles = 0;
        var estado = $("#chkEventoEstado").is(":checked");
        var tieneCategoria = 0;
        var tieneCompraXcompra = $("#chkEventocompraXcompra").is(":checked");
        var tieneSubCampania = $("#chkEventoTieneSubCampania").is(":checked");
        var tienePersonalizacion = true;

        var showRoom = {
            EventoID: eventoID == "" || eventoID == undefined ? 0 : eventoID,
            CampaniaID: campaniaID,
            Nombre: nombre,
            Tema: tema,
            DiasAntes: parseInt(diasAntes),
            DiasDespues: parseInt(diasDespues),
            NumeroPerfiles: parseInt(numeroPerfiles),
            Estado: estado,
            TieneCategoria: tieneCategoria,
            TieneCompraXcompra: tieneCompraXcompra,
            TieneSubCampania: tieneSubCampania,
            TienePersonalizacion: tienePersonalizacion
        };

        waitingDialog({ title: "Procesando" });
        jQuery.ajax({
            type: "POST",
            url: _config.urlGuardarShowRoom,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(showRoom),
            async: true,
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        closeWaitingDialog();
                        var id = response.data;

                        if ($("#hdEventoID").val() == "0")
                            _fnGrilla();

                        $("#hdEventoID").val(id);
                        //Cargar de Consultoras
                        $("#hdCargaEventoID").val(id);
                        $("#hdCargaCampaniaID").val(campaniaID);
                        //Carga de Stock
                        $("#hdCargaStockEventoID").val(id);
                        //Carga de Descripcion de Sets
                        $("#hdCargaDescripcionSetsEventoID").val(id);
                        $("#hdCargaDescripcionSetsCampaniaID").val(campaniaID);
                        //Carga de Productos Compra por Compra
                        $("#hdCargarProductoCpcEventoID").val(id);
                        $("#hdCargarProductoCpcCampaniaID").val(campaniaID);

                        HideDialog("DialogDatosShowRoom");
                        jQuery("#listEvento").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                        alert(response.message);
                    } else {
                        alert(response.message);
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    alert(response.message);
                    closeWaitingDialog();
                }
            }
        });
    }

    var _insertarImagenPersonalizacion = function (personalizacionId) {
        var elementoPadre = $('.div-3[data-idpersonalizacion="' + personalizacionId + '"]');
        var elementoAgregarImagen = $(elementoPadre).find(".fpPopupImagenPersonalizacion")[0];
        var elementoDivVerImagen = $(elementoPadre).find(".divPopupImagenPersonalizacion")[0];
        var elementoHiddenValor = $(elementoPadre).find(".hdValor")[0];
        $.ajaxSetup({ cache: false });
        var uploader = new qq.FileUploader({
            allowedExtensions: ["jpg", "png", "jpeg", "gif"],
            element: elementoAgregarImagen,
            action: _config.urlImageMatrizUpload,
            onComplete: function (id, fileName, responseJSON) {
                if (checkTimeout(responseJSON)) {
                    $(".qq-upload-list").css("display", "none");
                    if (responseJSON.success) {
                        var rutaImagen = _config.rutaImagenTemporal + responseJSON.name;

                        $(elementoHiddenValor).val(responseJSON.name);

                        var html = '<img  alt="" src="' + rutaImagen + '" style="width: auto; height: 60px; max-width: 300px !important;"/>';
                        $(elementoDivVerImagen).html(html);
                    } else {
                        alert(responseJSON.message);
                    }
                }
            },
            onSubmit: function (id, fileName) { $(".qq-upload-list").css("display", "none"); },
            onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
            onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
        });
    }

    var _registrarShowRoomPersonalizacionNivel = function (eventoId, nivelId) {
        var lista = $("#DialogPersonalizacionDetalle .div-3[data-idpersonalizacion]");
        var array = new Array();

        $.each(lista, function (index, value) {
            var personalizacionNivelId = $(value).find(".hdPersonalizacionNivelId").val();
            var personalizacionId = $(value).attr("data-idpersonalizacion");
            var atributo = $(value).find(".hdAtributo").val();

            var valor = "";
            var esImagen = false;
            var tipoAtributo = $(value).find(".hdTipoAtributo").val();

            if (tipoAtributo == "IMAGEN") {
                valor = $(value).find(".hdValor").val();
                esImagen = true;
            } else {
                valor = $(value).find(".txtAtributoPersonalizacion").val();
            }

            var item = {
                PersonalizacionNivelId: personalizacionNivelId,
                PersonalizacionId: personalizacionId,
                EventoId: eventoId,
                NivelId: nivelId,
                CategoriaId: 0,
                Atributo: atributo,
                Valor: valor,
                ValorAnterior: $(value).find(".hdValorAnterior").val(),
                EsImagen: esImagen
            };

            array.push(item);
        });

        jQuery.ajax({
            type: "POST",
            url: _config.urlGuardarPersonalizacionNivelShowRoom,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(array),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        alert(data.message);

                        HideDialog("DialogPersonalizacionDetalle");
                    }
                    else {
                        alert(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert(data.message);
                }
            }
        });
    }

    var _fnGrillaOfertaShowRoomDetalle = function (campaniaId, cuv, estrategiaId) {
        $("#listShowRoomDetalle").jqGrid("clearGridData");

        var parametros = {
            estrategiaId: estrategiaId
        };

        $("#listShowRoomDetalle").setGridParam({ postData: parametros });
        $("#hdEstrategiaID").val(estrategiaId);

        jQuery("#listShowRoomDetalle").jqGrid({
            url: _config.urlConsultarOfertaShowRoomDetalle,
            hidegrid: false,
            datatype: "json",
            postData: (parametros),
            mtype: "GET",
            contentType: "application/json; charset=utf-8",
            colNames: ["EstrategiaProductoId", "EstrategiaId", "CampaniaID", "CUV", "Nombre", "Descripcion1", "Foto", "Marca", "", "", "", ""],
            colModel: [
                { name: "EstrategiaProductoId", index: "EstrategiaProductoId", width: 50, editable: true, resizable: false, hidden: true },
                { name: "EstrategiaId", index: "Estrategia", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Campania", index: "Campania", width: 50, editable: true, resizable: false, hidden: true },
                { name: "CUV", index: "CUV", width: 50, editable: true, resizable: false, hidden: false },
                { name: "NombreProducto", index: "NombreProducto", width: 80, editable: true, resizable: false },
                { name: "Descripcion1", index: "Descripcion1", width: 80, editable: true, resizable: false },
                { name: "ImagenProducto", index: "ImagenProducto", width: 60, editable: true, resizable: false, sortable: false, align: "center", formatter: _showImageDetalle },
                { name: "IdMarca", index: "IdMarca", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Precio", index: "Precio", width: 50, editable: true, resizable: false, hidden: true },
                { name: "PrecioValorizado", index: "PrecioValorizado", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Activo", index: "Activo", width: 50, editable: true, resizable: false, hidden: true },
                { name: "Options", index: "Options", width: 40, editable: true, sortable: false, align: "center", resizable: false, formatter: _showActionsDetalle }
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
            pager: jQuery("#pagerShowRoomDetalle"),
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
            width: 840,
            pgtext: "Pág: {0} de {1}",
            altRows: true,
            altclass: "jQGridAltRowClass",
            loadComplete: function () {
            },
            gridComplete: function () {
            }
        });
        jQuery("#listShowRoomDetalle").jqGrid("navGrid", "#pagerShowRoomDetalle", { edit: false, add: false, refresh: false, del: false, search: false });
        jQuery("#listShowRoomDetalle").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
    }

    var _showImageDetalle = function (cellvalue, options, rowObject) {
        var image = "";
        if (rowObject[6] != "") {
            image = '<img src="' + rowObject[6] + '" alt="" width="70px" height="60px" title="" border="0" />';
        } else {
            image = '<img src="' + _config.imagenProductoVacio + '" alt="" width="60px" height="60px" title="" border="0" />';
        }
        return image;
    }

    var _showActionsDetalle = function (cellvalue, options, rowObject) {
        var id = rowObject[0];
        var estrategiaId = rowObject[1];
        var cuv = rowObject[3];
        var imagen = rowObject[6];

        var edit = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listShowRoomDetalle').EditarProductoDetalle('" + id + "','" + imagen + "');\" >" + "<img src='" + _config.rutaImagenEdit + "' alt='Editar Producto' title='Editar Producto' border='0' /></a>";
        var remove = "";

        if (rowObject[10] == "1") {
            remove = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listShowRoomDetalle').EliminarProductoDetalle('" + id + "','" + estrategiaId + "','" + cuv + "');\" >" + "<img src='" + _config.rutaImagenDisable + "' alt='Deshabilitar Producto' title='Deshabilitar Producto' border='0' /></a>";
        }

        return edit + remove;
    }

    var _registrarOfertaShowRoomDetalle = function () {
        var accion;

        if ($("#hdEstrategiaProductoID").val() == "0")
            accion = _config.urlInsertOfertaShowRoomDetalle;
        else
            accion = _config.urlUpdateOfertaShowRoomDetalle;

        var isActive = ($("#chkActivoOfertaDetalle").val()) ? "1" : "0";

        var item = {
            EstrategiaProductoID: $("#hdEstrategiaProductoID").val(),
            EstrategiaID: $("#hdEstrategiaID").val(),
            Campania: $("#txtCampaniaDetalle").val(),
            CUV2: $("#txtCUVDetalle").val(),
            CUV: $("#txtCUVProductoDetalle").val(),
            Precio: $("#txtPrecioOfertaDetalle").val(),
            NombreProducto: $("#txtNombreProductoDetalle").val(),
            Descripcion1: $("#txtDescripcion1Detalle").val(),
            IdMarca: $("#ddlMarcaProductoDetalle").val(),
            Activo: isActive,
            ImagenProducto: $("#hdImagenDetalle").val(),
            ImagenAnterior: $("#hdImagenDetalleAnterior").val()
        };

        console.log(item);

        waitingDialog({ title: "Procesando" });
        jQuery.ajax({
            type: "POST",
            url: accion,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        alert(data.message);
                        HideDialog("DialogRegistroOfertaShowRoomDetalleEditar");
                        _limpiarDatos();
                        jQuery("#listShowRoomDetalle").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                    }
                    else {
                        alert(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert(data.message);
                    HideDialog("DialogRegistroOfertaShowRoomDetalleEditar");
                }
            }
        });
    }


    var _vistaNuevoProductoShowroon = function () {
        $("#seccionTallaColor").hide();
        $("#seccionOfertaUltimoMinuto").hide();
        $("#seccionImagenMiniatura").show();
        $("#seccionEsSubCampania").show();
        $("#lblMensaje").text("Tip de Negocio:");
    }

    var _vistaNuevoProductoGeneral = function () {
        $("#seccionEsSubCampania").hide();
        $("#seccionImagenMiniatura").hide();
        $("#seccionTallaColor").show();
        $("#seccionOfertaUltimoMinuto").show();
        $("#lblMensaje").text("Mensaje Adicional:");
    }

    var _uploadFileSetStrategyShowroom = function () {
        waitingDialog();
        var formData = new FormData();
        var totalFiles = document.getElementById("fileDescMasivo").files.length;
        if (totalFiles <= 0) {
            _toastHelper.error("Seleccione al menos un archivo.");
            closeWaitingDialog();
            return false;
        }

        formData.append("Documento", document.getElementById("fileDescMasivo").files[0]);
        formData.append("Pais", $("#ddlPais").val());
        formData.append("CampaniaId", $("#ddlCampania").val());
        formData.append("TipoEstrategia", $("#ddlTipoEstrategia").val());

        $.ajax({
            url: _config.urlUploadFileStrategyShowroom,
            type: "POST",
            dataType: "JSON",
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {
                $("#listCargaDescMasiva").jqGrid("GridUnload");
                var mensaje = "";
                if (data.listActualizado == 0 && data.listInsertado == 0) {
                    mensaje = 'No se realizó ninguna actualización ni inserción (Verificar que los CUVs existan en la tabla "ods.OfertasPersonalizadas").';
                }
                else {
                    mensaje = "El procedimiento culmino con éxito, <br /> - Se actualizaron " + data.listActualizado + " Set(s) <br /> - Se insertaron " + data.listInsertado + " Set(s)";
                }
                closeWaitingDialog();
                $("#estadoCargaMasiva").css("color", "black");
                $("#estadoCargaMasiva").html(mensaje);
                $("#divDescMasivoPaso1").fadeOut(function () {
                    $("#divDescMasivoPaso2").fadeIn();
                });

            },
            error: function (data) {
                $("#estadoCargaMasiva").css("color", "red");
                $("#estadoCargaMasiva").html(data.statusText);
                $("#divDescMasivoPaso1").fadeOut(function () {
                    $("#divDescMasivoPaso2").fadeIn();
                });
                closeWaitingDialog();
            }
        });
    }

    var _uploadFileProductStrategyShowroom = function () {
        waitingDialog({});
        var formData = new FormData();
        var totalFiles = document.getElementById("fileDescMasivo").files.length;
        if (totalFiles <= 0) {
            _toastHelper.error("Seleccione al menos un archivo.");
            closeWaitingDialog();
            return false;
        }

        formData.append("Documento", document.getElementById("fileDescMasivo").files[0]);
        formData.append("Pais", $("#ddlPais").val());
        formData.append("CampaniaId", $("#ddlCampania").val());
        formData.append("TipoEstrategia", $("#ddlTipoEstrategia").val());

        $.ajax({
            url: _config.urlUploadFileProductStrategyShowroom,
            type: "POST",
            dataType: "JSON",
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {
                $("#listCargaDescMasiva").jqGrid("GridUnload");
                var mensaje = '';
                if (data.listActualizado == 0) {
                    mensaje = 'No se realizó ninguna actualización (Verificar que los CUVs existan en la tabla "ods.EstrategiaProducto").';
                }
                else {
                    mensaje = "El procedimiento culmino con éxito, se actualizaron " + data.listActualizado + " producto(s)";
                }
                closeWaitingDialog();
                $("#estadoCargaMasiva").css('color', 'black');
                $('#estadoCargaMasiva').html(mensaje);
                $("#divDescMasivoPaso1").fadeOut(function () {
                    $("#divDescMasivoPaso2").fadeIn();
                });

            },
            error: function (data) {
                $("#estadoCargaMasiva").css('color', 'red');
                $('#estadoCargaMasiva').html(data.statusText);
                $("#divDescMasivoPaso1").fadeOut(function () {
                    $("#divDescMasivoPaso2").fadeIn();
                });
                closeWaitingDialog();
            }
        });
    }
    // SHOWROOM-FIN

    // Binding events dialogs 
    var _iniDialog = function () {
        $("#DialogAdministracionEstrategia").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 830,
            close: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).show(); },
            draggable: false,
            title: "Registro de Estrategias",
            open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Guardar": function () {

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
                        aux2 !== 12 &&
                        aux2 !== 13 &&
                        aux2 !== 30) {
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

                    var NumeroPedidoAsociado = $(".checksPedidosAsociados input:checked").map(function () {
                        return $(this).val();
                    }).get().join(",");

                    if (NumeroPedidoAsociado == "" && $("#txtPedidoAsociado").length) {
                        NumeroPedidoAsociado = $("#txtPedidoAsociado").val();
                    }
                    //valores para el carrusel de la estrategia de lanzamiento
                    var imgFondoDesktop = $("#nombre-img-fondo-desktop").val();
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
                    var ImagenMiniaturaURL = $("#imgMiniSeleccionada").attr("src").substr($("#imgMiniSeleccionada").attr("src").lastIndexOf("/") + 1);
                    var EsSubCampania = ($("#chkEsSubCampania").attr("checked")) ? true : false;
                    var niveles = $("#hdNiveles").val() || "";
                    var flagIndividual = $("#chkFlagIndividual").is(":checked");
                    var slogan = $("#txtSlogan").val() || "";

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
                        RutaImagenCompleta: imagenEstrategiaProducto,
                        ImagenMiniaturaURL: ImagenMiniaturaURL,
                        ImagenMiniaturaURLAnterior: $("#hdImagenMiniaturaURLAnterior").val(),
                        EsSubCampania: EsSubCampania,
                        Niveles: niveles,
                        FlagIndividual: flagIndividual,
                        Slogan: slogan
                    };
                    jQuery.ajax({
                        type: "POST",
                        url: baseUrl + "AdministrarEstrategia/RegistrarEstrategia",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(params),
                        async: true,
                        success: function (data) {
                            closeWaitingDialog();
                            console.log(data);
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
                "Salir": function () {
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
            close: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).show(); },
            open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Guardar": function () {
                    var zonas = "";
                    $.jstree._reference($("#arbolRegionZona")).get_checked(null, true).each(function () {
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
                    _toastHelper.success("Se agregaron las zonas seleccionadas.");
                    $(this).dialog("close");
                },
                "Salir": function () {
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
                "Cerrar": function () {
                    if (_variables.isVistaPreviaOpened) {
                        var params = {
                            paisID: $("#ddlPais").val(),
                            EstrategiaID: $("#hdEstrategiaID").val(),
                            CampaniaID: $("#ddlCampania").val(),
                            TipoEstrategiaID: $("#ddlTipoEstrategia").val(),
                            CUV2: $("#txtCUV2").val()
                        };
                        _obtenerImagenes(params, 1, true).done(function () {
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
            close: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).show(); },
            open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
            buttons:
            {
                "Nueva Talla/Color": function () {
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
                "Guardar": function () {
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
                        success: function (data) {
                            if (data.success) {
                                _toastHelper.success(data.message);
                                _fnGrillaTC();
                                HideDialog("DialogEditarTallaColor");
                            } else {
                                _toastHelper.error(data.message);
                            }
                        },
                        error: function (data, error) {
                            _toastHelper.error(data.message);
                        }
                    });
                },
                "Salir": function () {
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

        $("#DialogBloqueoCuv").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 600,
            draggable: false,
            title: "Carga CUVs Bloqueados"
        });

        // SHOWROOM-INICIO
        $("#DialogDatosShowRoom").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 800,
            draggable: true,
            title: "Carga de Evento ShowRoom",
            buttons:
            {
                "Guardar": function () {
                    var vMessage = "";
                    if (jQuery.trim($("#txtEventoNombre").val()) == "")
                        vMessage += "- Debe ingresar el Nombre del Evento.\n";
                    if (jQuery.trim($("#txtEventoTema").val()) == "")
                        vMessage += "- Debe ingresar el Tema del Evento.\n";
                    if (jQuery.trim($("#txtEventoDiasAntes").val()) == "")
                        vMessage += "- Debe ingresar la cantidad de dias antes de la Facturación.\n";
                    if (parseInt(jQuery.trim($("#txtEventoDiasAntes").val())) <= 0)
                        vMessage += "- La cantidad de dias antes de la Facturación debe ser mayor a cero.\n";
                    if (jQuery.trim($("#txtEventoDiasDespues").val()) == "")
                        vMessage += "- Debe ingresar la cantidad de dias después de la Facturación.\n";
                    if (parseInt(jQuery.trim($("#txtEventoDiasDespues").val())) <= 0)
                        vMessage += "- La cantidad de dias después de la Facturación debe ser mayor a cero.\n";
                    
                    if (vMessage != "") {
                        alert(vMessage);
                        return false;
                    } else {
                        _guardarShowRoomEvento();
                    }
                },
                "Cancelar": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogPersonalizacionDetalle").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 800,
            draggable: true,
            title: "Detalle de Personalizacion por Nivel",
            buttons:
            {
                "Guardar": function () {
                    var vMessage = "";

                    var eventoId = $("#hdEventoID").val();
                    var nivelId = $("#cbNivelEvento").val();

                    if (eventoId == "")
                        vMessage += "- Debe seleccionar el evento.\n";

                    if (nivelId == "")
                        vMessage += "- Debe seleccionar el nivel de la personalización.\n";

                    if (vMessage != "") {
                        alert(vMessage);
                        return false;
                    }
                    else {
                        _registrarShowRoomPersonalizacionNivel(eventoId, nivelId);
                    }
                    return false;
                },
                "Cancelar": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#DialogRegistroOfertaShowRoomDetalle").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 900,
            draggable: true,
            title: "Edición de Productos"
        });

        $("#DialogRegistroOfertaShowRoomDetalleEditar").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            width: 800,
            draggable: true,
            title: "Registro / Edición de Productos",
            buttons:
            {
                "Guardar": function () {
                    var vMessage = "";
                    if (jQuery.trim($("#txtCUVProductoDetalle").val()) == "")
                        vMessage += "- Debe ingresar el CUV del Producto.\n";

                    if (jQuery.trim($("#ddlMarcaProductoDetalle").val()) == "0")
                        vMessage += "- Seleccione una marca del Producto.\n";

                    if (jQuery.trim($("#txtNombreProductoDetalle").val()) == "")
                        vMessage += "- Debe ingresar la el nombre del Producto.\n";

                    if (vMessage != "") {
                        alert(vMessage);
                        return false;
                    }
                    else {
                        _registrarOfertaShowRoomDetalle();
                    }
                    return false;
                },
                "Cancelar": function () {
                    $(this).dialog("close");
                }
            }
        });
        // SHOWROOM-FIN
    }
    var _eventos = {
        clickNuevo: function () {
            _variables.isNuevo = true;

            var tieneFlagNueva = $("#ddlTipoEstrategia option:selected").attr("flag-nueva");
            (tieneFlagNueva == "1") ? $(".chkEsOfertaIndependiente").show() : $(".chkEsOfertaIndependiente").hide();

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
            $("#imgMiniSeleccionada").attr("src", _config.rutaImagenVacia);
            $("#hdImagenMiniaturaURLAnterior").val("");
            $("#chkEsSubCampania").removeAttr("checked");

            var aux1 = $("#ddlTipoEstrategia").find(":selected").data("id");
            var aux2 = $("#ddlTipoEstrategia").find(":selected").data("codigo");

            if (aux1 == "4" || aux2 == "005" || aux2 == "007" || aux2 == "008" || aux2 == _codigoEstrategia.ShowRoom) {
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
            } else if (aux1 == "4" || aux1 == "5" || aux2 == "005" || aux2 == "007" || aux2 == "008" || aux2 == _codigoEstrategia.ShowRoom) {

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
            _limpiarCamposLanzamiento("img-fondo-mobile");
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

            if (aux2 == _codigoEstrategia.CodigoShowRoom) {
                _vistaNuevoProductoShowroon();
            } else {
                _vistaNuevoProductoGeneral();
            }

            HideDialog("DialogZona");
            showDialog("DialogAdministracionEstrategia");
            $("#linkAlcance").click();
            _ActualizarFlagIndividual();
            return true;
        },
        clickActivarDesactivar: function () {
            var proceder = confirm("¿ Desea habilitar/deshabiltar las estrategias?");
            if (!proceder)
                return false;

            waitingDialog();

            var estrategias = jQuery("#list").jqGrid("getDataIDs", "EstrategiaID");
            var estrategiasSeleccionadas = jQuery("#list").jqGrid("getGridParam", "selarrrow");
            var estrategiasNoSeleccionadas = estrategias.filter(function (obj) {
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
                success: function (data) {
                    _toastHelper.success(data.message);
                    _fnGrilla();
                    closeWaitingDialog();
                },
                error: function (data, error) {
                    _toastHelper.error(data.message);
                    closeWaitingDialog();
                }
            });
            return true;
        },
        clickBuscar: function () {
            if (!_basicFieldsValidation()) return false;
            $("#hdEstrategiaIDConsulta").val($("#ddlTipoEstrategia").val());
            $("#hdTipoConsulta").val("1");
            $("#hdEstrategiaCodigo").val($("#ddlTipoEstrategia option:selected").data("codigo"));
            $("#list").html("");
            $("#divShowRoomEvento").hide();
            $("#divShowRoomEventoNuevo").hide();
            $("#divPersonalizacion").hide();
            $("#divSeccionProductos").hide();

            _variables.paisNombre = $("#ddlPais option:selected").text();
            var codigo = $("#ddlTipoEstrategia").find(":selected").data("codigo");
            if (codigo === _codigoEstrategia.ShowRoom) {
                _cargarEventoShowRoom();
            }
            else {
                _fnGrilla();
            }

            if (codigo == _codigoEstrategia.OfertaParaTi ||
                codigo == _codigoEstrategia.OfertaDelDia ||
                codigo == _codigoEstrategia.Lanzamiento ||
                codigo == _codigoEstrategia.OfertasParaMi ||
                codigo == _codigoEstrategia.PackAltoDesembolso ||
                codigo == _codigoEstrategia.GuiaDeNegocio ||
                codigo == _codigoEstrategia.LosMasVendidos ||
                codigo == _codigoEstrategia.ShowRoom) {
                $("#mensajeActivarDesactivar").show();
            } else {
                $("#mensajeActivarDesactivar").hide();
            }

            return true;
        },
        clickBuscarNemotencnico: function () {
            _buscarNemotecnico();
        },
        clickLimipiarNemotecnico: function () {
            _limpiarBusquedaNemotecnico();
        },
        clickClassEstrategiaImagen: function () {
            var id = $(this).attr("data-id");
            if ($(this).attr("checked")) {
                $("#ImagenProducto").val($(this).val());
                $('.chk-estrategia-imagen[data-id!="' + id + '"]').removeAttr("checked");
            }
        },
        clickClassActivarDesactivar: function () {
            if (!$(this).attr("checked")) {
                $(this).parent().parent().find("input").each(function () {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", true);
                });
                $(this).parent().parent().find("select").each(function () {
                    $(this).val("");
                    $(this).attr("disabled", true);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            } else {
                $(this).parent().parent().find("input").each(function () {
                    $(this).val("");
                    $("#chkEstrella").attr("checked", false);
                    $(this).attr("disabled", false);
                });
                $(this).parent().parent().find("select").each(function () {
                    $(this).val("");
                    $(this).attr("disabled", false);
                });
                $(this).attr("disabled", false);
                _paletaColores();
            }
        },
        clickDescripcionMasivo: function () {
            $("#hdTipoCargaShowroom").val("SetShowroom");
            $("#fileDescMasivo").val("");
            if (_validarMasivo()) {
                if ($("#ddlTipoEstrategia").find(":selected").data("codigo") === _codigoEstrategia.ShowRoom) {
                    $("#ui-id-10").text("Carga masiva de Showroom");
                } else {
                    $("#ui-id-10").text("Carga masiva de descripciones de Estrategias");
                }

                $("#divDescMasivoPaso1").show();
                $("#divDescMasivoPaso2").hide();

                if ($("#ddlTipoEstrategia").find(":selected").data("codigo") == _codigoEstrategia.ShowRoom) {
                    $("#seccionFormatoArchivoShowroon").show();
                    $("#seccionFormatoArchivoSetShowroon").show();
                    $("#seccionFormatoArchivoGeneral").hide();
                    $("#seccionFormatoArchivoProductoShowroon").hide();
                } else {
                    $("#seccionFormatoArchivoGeneral").show();
                    $("#seccionFormatoArchivoSetShowroon").hide();
                    $("#seccionFormatoArchivoProductoShowroon").hide();
                }

                showDialog("DialogDescMasivo");
            }
        },
        clickCancelarDescMasivo1: function () {
            HideDialog("DialogDescMasivo");
        },
        clickAceptarDescMasivo1: function () {
            $("#divDescMasivoPaso1").show();
            $("#divDescMasivoPaso2").hide();
            $("#estadoCargaMasiva").text("");
            if ($("#ddlTipoEstrategia").find(":selected").data("codigo") == _codigoEstrategia.ShowRoom) {
                if ($("#hdTipoCargaShowroom").val() == "SetShowroom") {
                    _uploadFileSetStrategyShowroom();
                } else {
                    _uploadFileProductStrategyShowroom();
                }
            } else {
                _uploadFileCvs();
            }
        },
        clickImagenEstrategia: function () {
            $(this).css("color", "white");
            $(this).css("background", "#00A2E8");

            $("#divInformacionAdicionalEstrategia").css("color", "#702789");
            $("#divInformacionAdicionalEstrategia").css("background", "#D0D0D0");

            $("#divImagenEstrategiaContenido").show();
            $("#divInformacionAdicionalEstrategiaContenido").hide();
        },
        clickInformacionAdicionalEstrategia: function () {
            $(this).css("color", "white");
            $(this).css("background", "#00A2E8");

            $("#divImagenEstrategia").css("color", "#702789");
            $("#divImagenEstrategia").css("background", "#D0D0D0");

            $("#divInformacionAdicionalEstrategiaContenido").show();
            $("#divImagenEstrategiaContenido").hide();
        },
        clickLinkTallaColor: function () {
            if ($.trim($("#txtCUV2").val()) == "") {
                _toastHelper.error("Debe ingresar un valor para CUV2");
                return false;
            }
            _fnGrillaTC();
            showDialog("DialogTonoMarca");
            return false;
        },
        clickChkImagenProducto: function () {

            _variables.imagen = "";

            $(".chkImagenProducto").prop("checked", false);
            $(this).attr("checked", "checked");
            _variables.imagen = $(this).attr("value");
            $("#imgSeleccionada").attr("src", _variables.imagen);
        },
        clickImgSeleccionada: function () {
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
        clickBuscarPersonalizacionNivel: function () {
            var eventoId = $("#hdEventoID").val();
            var nivelId = $("#cbNivelEvento").val();

            if (eventoId == undefined || eventoId == 0) {
                alert("Evento no se puedo identificar");
                return false;
            }

            if (nivelId == undefined || nivelId == 0) {
                alert("Debe seleccionar un Nivel");
                return false;
            }

            var item = { eventoId: eventoId, nivelId: nivelId };

            waitingDialog({ title: "Procesando" });
            jQuery.ajax({
                type: "POST",
                url: _config.urlGetShowRoomPersonalizacionNivel,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(item),
                async: true,
                success: function (response) {
                    if (checkTimeout(response)) {
                        if (response.success) {
                            closeWaitingDialog();

                            $("#divPersonalizacionDetalleDesktop").html("");
                            $("#divPersonalizacionDetalleMobile").html("");
                            var listaPersonalizacion = response.listaPersonalizacion;

                            var listaPersonalizacionDesktop = listaPersonalizacion.Find("TipoAplicacion", "Desktop");
                            var listaPersonalizacionMobile = listaPersonalizacion.Find("TipoAplicacion", "Mobile");

                            $.each(listaPersonalizacionMobile, function (index, value) {
                                var htmlPersonalizacion = "";
                                htmlPersonalizacion += '<div class="div-3" data-idpersonalizacion="' + value.PersonalizacionId + '">';
                                htmlPersonalizacion += '<input type="hidden" class="hdPersonalizacionNivelId" value="' + value.PersonalizacionNivelId + '"/>';

                                var valor = value.TipoAtributo == "IMAGEN" ? value.Valor.replace(/^.*[\\\/]/, "") : value.Valor;
                                htmlPersonalizacion += '<input type="hidden" class="hdValor" value="' + valor + '"/>';
                                htmlPersonalizacion += '<input type="hidden" class="hdValorAnterior" value="' + valor + '"/>';

                                htmlPersonalizacion += '<input type="hidden" class="hdAtributo" value="' + value.Atributo + '"/>';
                                htmlPersonalizacion += '<input type="hidden" class="hdTipoAtributo" value="' + value.TipoAtributo + '"/>';

                                if (value.TipoAtributo == "IMAGEN") {

                                    htmlPersonalizacion += '<div class="titC" style="width: 250px; margin-top: 15px;">' + value.TextoAyuda + "</div>";
                                    htmlPersonalizacion += '<div class="titC" style="padding: 0; width: 230px;">';
                                    htmlPersonalizacion += '<div class="input_search">';
                                    htmlPersonalizacion += '<div class="fpPopupImagenPersonalizacion">';
                                    htmlPersonalizacion += "</div>";
                                    htmlPersonalizacion += "</div>";
                                    htmlPersonalizacion += '<div class="divPopupImagenPersonalizacion" style="width: 100px; height: 60px; float: right;">';

                                    if (value.PersonalizacionNivelId != 0 && value.Valor != "") {
                                        htmlPersonalizacion += '<img  alt="" src="' + value.Valor + '" style="width: auto; height: 60px; max-width: 300px !important;"/>';
                                    }

                                    htmlPersonalizacion += "</div>";
                                    htmlPersonalizacion += "</div>";
                                } else {

                                    htmlPersonalizacion += '<div class="titC" style="width: 250px;">' + value.TextoAyuda + "</div>";
                                    htmlPersonalizacion += '<div class="selectP2 borde_redondeado" style="width: 400px;">';
                                    htmlPersonalizacion += '<input type="text" class="txtAtributoPersonalizacion" value="' + value.Valor + '" style="width: 400px;"/>';
                                    htmlPersonalizacion += "</div>";
                                }

                                htmlPersonalizacion += "</div>";

                                $("#divPersonalizacionDetalleMobile").append(htmlPersonalizacion);

                                if (value.TipoAtributo == "IMAGEN") {
                                    _insertarImagenPersonalizacion(value.PersonalizacionId);
                                }
                            });

                            $.each(listaPersonalizacionDesktop, function (index, value) {
                                var htmlPersonalizacion = "";
                                htmlPersonalizacion += '<div class="div-3" data-idpersonalizacion="' + value.PersonalizacionId + '">';
                                htmlPersonalizacion += '<input type="hidden" class="hdPersonalizacionNivelId" value="' + value.PersonalizacionNivelId + '"/>';

                                var valor = value.TipoAtributo == "IMAGEN" ? value.Valor.replace(/^.*[\\\/]/, "") : value.Valor;
                                htmlPersonalizacion += '<input type="hidden" class="hdValor" value="' + valor + '"/>';
                                htmlPersonalizacion += '<input type="hidden" class="hdValorAnterior" value="' + valor + '"/>';

                                htmlPersonalizacion += '<input type="hidden" class="hdAtributo" value="' + value.Atributo + '"/>';
                                htmlPersonalizacion += '<input type="hidden" class="hdTipoAtributo" value="' + value.TipoAtributo + '"/>';

                                if (value.TipoAtributo == "IMAGEN") {

                                    htmlPersonalizacion += '<div class="titC" style="width: 250px; margin-top: 15px;">' + value.TextoAyuda + "</div>";
                                    htmlPersonalizacion += '<div class="titC" style="padding: 0; width: 230px;">';
                                    htmlPersonalizacion += '<div class="input_search">';
                                    htmlPersonalizacion += '<div class="fpPopupImagenPersonalizacion">';
                                    htmlPersonalizacion += "</div>";
                                    htmlPersonalizacion += "</div>";
                                    htmlPersonalizacion += '<div class="divPopupImagenPersonalizacion" style="width: 100px; height: 60px; float: right;">';

                                    if (value.PersonalizacionNivelId != 0 && value.Valor != "") {
                                        htmlPersonalizacion += '<img  alt="" src="' + value.Valor + '" style="width: auto; height: 60px; max-width: 300px !important;"/>';
                                    }

                                    htmlPersonalizacion += "</div>";
                                    htmlPersonalizacion += "</div>";
                                } else {

                                    htmlPersonalizacion += '<div class="titC" style="width: 250px;">' + value.TextoAyuda + "</div>";
                                    htmlPersonalizacion += '<div class="selectP2 borde_redondeado" style="width: 400px;">';
                                    htmlPersonalizacion += '<input type="text" class="txtAtributoPersonalizacion" value="' + value.Valor + '" style="width: 400px;"/>';
                                    htmlPersonalizacion += "</div>";
                                }

                                htmlPersonalizacion += "</div>";

                                $("#divPersonalizacionDetalleDesktop").append(htmlPersonalizacion);

                                if (value.TipoAtributo == "IMAGEN") {
                                    _insertarImagenPersonalizacion(value.PersonalizacionId);
                                }
                            });

                            showDialog("DialogPersonalizacionDetalle");
                        } else {
                            closeWaitingDialog();
                        }
                    }
                },
                error: function (response, error) {
                    if (checkTimeout(response)) {
                        alert(response.message);
                        closeWaitingDialog();
                    }
                }
            });
        },
        clickNuevoShowRoom: function () {
            _limpiarDatosEventoShowRoom();
            $("#txtEventoPaisID").val(_variables.paisNombre);
            $("#txtEventoCampaniaID").val($("#ddlCampania").val());

            $("#divEventoEstado").css("display", "none");

            showDialog("DialogDatosShowRoom");
        },
        clickNuevoDetalle: function () {
            _limpiarDatosEventoShowRoomDetalle();

            $("#txtCUVProductoDetalle").attr("readonly", false);
            $("#txtPrecioOfertaDetalle").attr("readonly", false);

            showDialog("DialogRegistroOfertaShowRoomDetalleEditar");
        },
        clickDescripcionMasivoProd: function () {
            $("#hdTipoCargaShowroom").val("ProductoShowroom");
            $("#fileDescMasivo").val("");
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
                if (estrategiaId !== 4 && estrategiaId !== 20 && estrategiaId !== 9 &&
                    estrategiaId !== 10 && estrategiaId !== 11 && estrategiaId !== 7 &&
                    estrategiaId !== 12 && estrategiaId != 22 && estrategiaId !== 30) {
                    _toastHelper.error("Debe seleccionar el tipo de Estrategia que permita esta funcionalidad.");
                    return false;
                }
            }
            $("#ui-id-10").text("Carga masiva de productos Showroom");
            $("#divDescMasivoPaso2").hide();
            $("#seccionFormatoArchivoSetShowroon").hide();
            $("#seccionFormatoArchivoGeneral").hide();
            $("#divDescMasivoPaso1").show();
            $("#seccionFormatoArchivoProductoShowroon").show();
            showDialog("DialogDescMasivo");
        },
        clickBloqueoCuv: function () {
            if (_basicFieldsValidation()) {
                document.getElementById("fileBloqueoCuv").value = "";
                $("#divCuvsBloqueados").hide();
                $("#divCuvsBloqueados").show();
                $("#titleCuvBloqueado").html("Cuvs cargados:");
                $("#listCuvsBloqueados").html("");
                var params = {
                    campaniaId: parseInt($("#ddlCampania").val())
                };

                jQuery.ajax({
                    type: "POST",
                    url: baseUrl + "AdministrarEstrategia/GetCuvsBloqueados",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        if (data.success && data.valor != null && data.valor !== "") {
                            $("#divCuvsBloqueados").show();
                            $("#listCuvsBloqueados").html(data.valor);
                        } else {
                            $("#divCuvsBloqueados").hide();
                        }
                    },
                    error: function (data, error) {
                        _toastHelper.error(data.message);
                    }
                });

                $("#divBloqueoCuvPaso1").show();
                $("#divBloqueoCuvPaso2").hide();
                if ($("#ddlTipoEstrategia").find(":selected").data("codigo") !== _codigoEstrategia.GuiaDeNegocio) {
                    _toastHelper.error("Seleccionar Tipo de Estrategia Guia de Negocio.");
                } else {
                    $("#divBloqueoCuvPaso2").hide();
                    showDialog("DialogBloqueoCuv");
                }
            }
        },
        clickAceptarBloqueoCuv1: function () {
            _uploadFileBloqueoCuv();
        },

        changeTipoEstrategia: function () {
            var aux2 = $("#ddlTipoEstrategia").find(":selected").data("codigo") || "";
            $("#btnActivarDesactivar").hide();
            $("#btnNuevoMasivo").hide();
            $("#btnDescripcionMasivo").hide();
            $("#btnActualizarTonos").hide();
            $("#btnCargaBloqueoCuv").hide();

            if (aux2.in(_codigoEstrategia.OfertaParaTi,
                _codigoEstrategia.OfertaDelDia,
                _codigoEstrategia.LosMasVendidos,
                _codigoEstrategia.Lanzamiento,
                _codigoEstrategia.OfertasParaMi,
                _codigoEstrategia.PackAltoDesembolso,
                _codigoEstrategia.GuiaDeNegocio,
                _codigoEstrategia.ShowRoom,
                _codigoEstrategia.HerramientaVenta)) {

                $("#btnActivarDesactivar").show();
                $("#btnNuevoMasivo").show();
                $("#btnDescripcionMasivo").show();

                if (aux2 !== _codigoEstrategia.HerramientaVenta) $("#btnActualizarTonos").show();
                if (aux2 === _codigoEstrategia.GuiaDeNegocio) $("#btnCargaBloqueoCuv").show();
                if (aux2 === _codigoEstrategia.ShowRoom) {
                    $("#btnDescripcionMasivo").val("Descrip. Masivo Set");
                    $("#btnDescripcionMasivoProd").show();
                } else {
                    $("#btnDescripcionMasivo").val("Descrip. Masivo");
                    $("#btnDescripcionMasivoProd").hide();
                }
            }

            _seleccionarTipoOferta();
            _pedidoAsociadoChecks();
        },
        changePais: function () {
            $("#hdTipoConsulta").attr("value", "0");
            $("#list").jqGrid("clearGridData", true).trigger("reloadGrid");
            var Id = $(this).val();
            waitingDialog();
            $.ajaxSetup({ cache: false });
            $.ajax({
                type: "GET",
                url: baseUrl + "AdministrarEstrategia/ObtenterCampanias",
                data: "PaisID=" + (Id == "" ? 0 : Id),
                cache: false,
                dataType: "Json",
                success: function (data) {
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
                        cargarArbol();
                        closeWaitingDialog();
                    }
                },
                error: function (x, xh, xhr) {
                    if (checkTimeout(x)) {
                        closeWaitingDialog();
                    }
                }
            });

            $.getJSON(baseUrl + "MatrizComercial/ObtenerISOPais",
                { paisID: Id },
                function (data) {
                    closeWaitingDialog();
                });

        },
        keyUpCuv: function () {
            if ($(this).val().length == 5) {

                if ($("#txtCUV2").val() == "") {
                    _toastHelper.error("Debe ingresar un valor para el CUV2");
                    return false;
                }

                waitingDialog();
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
                    success: function (data) {
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
                    error: function (data, error) {
                        $("#mensajeErrorCUV").val(data.message);
                        _toastHelper.error($("#mensajeErrorCUV").val());
                        closeWaitingDialog();
                    }
                });
            }
            return true;
        },
        keyUpCuvTc: function () {
            if ($(this).val().length == 5) {

                if ($("#txtCUV2").val() == "") {
                    _toastHelper.error("Debe ingresar un valor para el CUV2");
                    return false;
                }

                waitingDialog();
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
                    success: function (data) {
                        if (data.message == "OK") {
                            $("#txtDescripcionCUVTC").val(data.descripcion);
                            $("#txtPrecioCUVTC").val(parseFloat(data.precio).toFixed(2));
                            closeWaitingDialog();
                        } else {
                            _toastHelper.error(data.message);
                            closeWaitingDialog();
                        }
                    },
                    error: function (data, error) {
                        $("#mensajeErrorCUV").val(data.message);
                        _toastHelper.error($("#mensajeErrorCUV").val());
                        closeWaitingDialog();
                    }
                });
            }
            return true;
        },
        keyUpCuv2: function () {
            var cuvIngresado = $(this).val();
            $("#imgSeleccionada").attr("src", _config.rutaImagenVacia);
            $("#imgSeleccionada").attr("data-id", "0");
            _mostrarInformacionCuv(cuvIngresado);
        },
        clickAlcance: function () {
            var strZonas = $("#hdZonas").val();
            if (strZonas != "") {
                $.jstree._reference($("#arbolRegionZona")).uncheck_all();
                var strZonasArreglo = strZonas.split(",");
                for (var i = 0; i < strZonasArreglo.length; i++) {
                    $("#arbolRegionZona").jstree("check_node", "#" + strZonasArreglo[i], true);
                }
                $("#chkSeleccionar").attr("checked", true);
                $.jstree._reference($("#arbolRegionZona")).get_unchecked(null, true).each(function () {
                    if (this.className.toLowerCase().indexOf("jstree-leaf") == -1) {
                        return true;
                    }
                    $("#chkSeleccionar").attr("checked", false);
                });
            } else {
                $.jstree._reference($("#arbolRegionZona")).check_all();
                var zonas = "";
                $.jstree._reference($("#arbolRegionZona")).get_checked(null, true).each(function () {
                    if (this.className.toLowerCase().indexOf("jstree-leaf") == -1) {
                        return true;
                    }
                    zonas += this.id + ",";
                });
                if (zonas != "") {
                    zonas = zonas.substring(0, zonas.length - 1);
                }
                $("#hdZonas").val(zonas);
                $("#chkSeleccionar").attr("checked", true);
            }
            $('#arbolRegionZona').jstree('close_all');
            showDialog("DialogZona");
            return false;
        },
        clickCheckFlagIndividual: function () {
            if ($("#chkFlagIndividual").is(":checked")) {
                $("#seccionSlogan").show();
            }
            else {
                $("#seccionSlogan").hide();
                $("#txtSlogan").val("");
            }
        },
    }

    var _bindingEvents = function () {
        $("body").on("click", "#btnNuevo", _eventos.clickNuevo);
        $("body").on("click", "#btnBuscar", _eventos.clickBuscar);
        $("body").on("click", "#btnActivarDesactivar", _eventos.clickActivarDesactivar);
        $("body").on("click", ".chk-estrategia-imagen", _eventos.clickClassEstrategiaImagen);
        $("body").on("click", ".activar-desactivar", _eventos.clickClassActivarDesactivar);
        $("body").on("click", "#btnDescripcionMasivo", _eventos.clickDescripcionMasivo);
        $("body").on("click", "#btnCancelarDescMasivo1", _eventos.clickCancelarDescMasivo1);
        $("body").on("click", "#btnAceptarDescMasivo1", _eventos.clickAceptarDescMasivo1);
        $("body").on("click", "#divImagenEstrategia", _eventos.clickImagenEstrategia);
        $("body").on("click", "#divInformacionAdicionalEstrategia", _eventos.clickInformacionAdicionalEstrategia);
        $("body").on("click", "#linkTallaColor", _eventos.clickLinkTallaColor);
        $("body").on("click", "#btnBuscarPersonalizacionNivel", _eventos.clickBuscarPersonalizacionNivel);
        $("body").on("click", "#btnNuevoShowRoom", _eventos.clickNuevoShowRoom);
        $("body").on("click", "#btnNuevoDetalle", _eventos.clickNuevoDetalle);
        $("body").on("click", "#imgMiniSeleccionada", _eventos.clickImgSeleccionada);
        $("body").on("click", "#btnDescripcionMasivoProd", _eventos.clickDescripcionMasivoProd);
        $("body").on("click", "#btnCargaBloqueoCuv", _eventos.clickBloqueoCuv);
        $("body").on("click", "#btnAceptarBloqueoCuv1", _eventos.clickAceptarBloqueoCuv1);
        $("body").on("click", "#linkAlcance", _eventos.clickAlcance);

        $("#matriz-comercial-header").on("click", "#matriz-busqueda-nemotecnico #btnBuscarNemotecnico", _eventos.clickBuscarNemotencnico);
        $("#matriz-comercial-header").on("click", "#matriz-busqueda-nemotecnico #btnLimpiarBusquedaNemotecnico", _eventos.clickLimipiarNemotecnico);
        $(".chkImagenProducto").on("click", _eventos.clickChkImagenProducto);
        $("#imgSeleccionada").on("click", _eventos.clickImgSeleccionada);
        $("#matriz-comercial-images").on("click", ".img-matriz-preview", _eventos.clickImgSeleccionada);
        $("#matriz-comercial-images").on("click", ".chkImagenProducto", _eventos.clickChkImagenProducto);
        $("#divImagenEstrategia").on("click", _eventos.clickImagenEstrategia);
        $("#divInformacionAdicionalEstrategia").on("click", _eventos.clickInformacionAdicionalEstrategia);

        $("body").on("change", "#ddlTipoEstrategia", _eventos.changeTipoEstrategia);
        $("body").on("change", "#ddlPais", _eventos.changePais);

        $("body").on("keyup", "#txtCUV", _eventos.keyUpCuv);
        $("body").on("keyup", "#txtCUVTC", _eventos.keyUpCuvTc);
        $("body").on("keyup", "#txtCUV2", _eventos.keyUpCuv2);


        $("body").on("click", "#chkFlagIndividual", _eventos.clickCheckFlagIndividual);

        var idPais = $("#ddlPais").val();
        if (idPais > 0) {
            $("#ddlPais").change();
        }
    }

    function cargarArbol() {
        $("#arbolRegionZona").jstree({
            json_data: {
                ajax: {
                    url: _config.urlCargarArbolRegionesZonas,
                    data: function (n) {
                        return { pais: $("#ddlPais").val(), region: 0, zona: 0 };
                    },
                    type: "GET",
                    error: function (XMLHttpRequest, textStatus, errorThrown) { },
                    success: function (data, textStatus, jqXHR) { },
                    complete: function () {
                        $("#arbolRegionZona").jstree("set_theme", "apple", _config.rutastylejstree);
                        closeWaitingDialog();
                    }
                }
            },
            "themes": {
                "theme": "apple",
                "dots": true,
                "icons": false
            },
            plugins: ["themes", "json_data", "ui", "checkbox"]
        });
    }
    
    function Editar(id, event) {
        event.preventDefault();
        event.stopPropagation();

        if (id != 0)
            _variables.isNuevo = false;

        if (id) {
            _limpiarFiltrosNemotecnico();

            waitingDialog();

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
    }
    function Deshabilitar(id, event) {
        event.preventDefault();
        event.stopPropagation();

        var elimina = confirm("¿Está seguro que desea deshabiltar la estrategia seleccionada?");
        if (!elimina)
            return false;

        if (id) {
            waitingDialog();

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
                success: function (data) {
                    _toastHelper.success(data.message);
                    _fnGrilla();
                    closeWaitingDialog();
                },
                error: function (data, error) {
                    _toastHelper.error(data.message);
                    closeWaitingDialog();
                }
            });
        }
        return false;
    }

    function Remover(id, event) {
        event.preventDefault();
        event.stopPropagation();
        var elimina = confirm("¿Está seguro que desea eliminar el set seleccionado?");
        if (!elimina) {
            return false;
        }
        if (id) {
            waitingDialog();
            $("#hdEstrategiaID").val(id);
            var params = { EstrategiaID: $("#hdEstrategiaID").val() };
            jQuery.ajax({
                type: "POST",
                url: _config.urlEliminarEstrategia,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                success: function (data) {
                    alert(data.message);
                    _fnGrilla();
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

    function ActualizarParNemotecnico(val) {
        _config.habilitarNemotecnico = val;
        _matrizFileUploader.actualizarParNemotecnico(val);
    }

    function EditarDescripcionComercial(idImagen) {
        _editarDescripcionComercial(idImagen);
    }

    function EditarEvento(ID, campaniaID, estado, tieneCategoria, tieneCompraXCompra, tieneSubCampania, tienePersonalizacion) {
        $("#txtEventoPaisID").val(_variables.paisNombre);
        $("#txtEventoCampaniaID").val(campaniaID);
        $("#txtEventoNombre").val(jQuery("#listEvento").jqGrid("getCell", ID, "Nombre"));
        $("#txtEventoTema").val(jQuery("#listEvento").jqGrid("getCell", ID, "Tema"));
        $("#txtEventoDiasAntes").val(jQuery("#listEvento").jqGrid("getCell", ID, "DiasAntes"));
        $("#txtEventoDiasDespues").val(jQuery("#listEvento").jqGrid("getCell", ID, "DiasDespues"));
        $("#txtEventoRutaShowRoomPopup").val(jQuery("#listEvento").jqGrid("getCell", ID, "RutaShowRoomPopup"));
        $("#txtEventoRutaShowRoomBannerLateral").val(jQuery("#listEvento").jqGrid("getCell", ID, "RutaShowRoomBannerLateral"));
        $("#chkEventoEstado").prop("checked", estado == "1");
        $("#chkEventocompraXcompra").prop("checked", tieneCompraXCompra == "True");
        $("#chkEventoTieneSubCampania").prop("checked", tieneSubCampania == "True");
        $("#divEventoEstado").css("display", "");
        showDialog("DialogDatosShowRoom");
    }

    function DeshabilitarEvento(ID, CampaniaID) {
        var deshabilitar = confirm("¿ Está seguro que desea deshabilitar el evento?");
        if (!deshabilitar)
            return false;

        var item = {
            campaniaID: CampaniaID,
            eventoID: ID
        };

        waitingDialog();
        jQuery.ajax({
            type: "POST",
            url: urlDeshabilitarShowRoomEvento,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == true) {
                        alert(data.message);
                        jQuery("#listEvento").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                    } else
                        alert(data.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
        return false;
    }

    function EliminarEvento(ID, CampaniaID) {
        var eliminar = confirm("¿ Está seguro que desea eliminar el evento?");
        if (!eliminar)
            return false;

        $("#divShowRoomPerfil").css("display", "none");

        var item = {
            campaniaID: CampaniaID,
            eventoID: ID
        };

        waitingDialog();
        jQuery.ajax({
            type: "POST",
            url: _config.urlEliminarShowRoomEvento,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == true) {
                        $("#divCargaArchivos").css("display", "none");
                        $("#divOfertasShowRoom").css("display", "none");
                        _limpiarDatosEventoShowRoom();
                        alert(data.message);
                        jQuery("#listEvento").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                    } else
                        alert(data.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
        return false;
    }

    function EditarProducto(ID, CampaniaID, CUV, event) {


        if (event) {
            event.preventDefault();
            event.stopPropagation();
        }

        _limpiarDatosShowRoomDetalle();

        $("#txtPaisDetalle").val(_variables.paisNombre);
        $("#txtCampaniaDetalle").val(CampaniaID);
        $("#txtCUVDetalle").val(CUV);
        $("#txtDescripcionDetalle").val(jQuery("#list").jqGrid("getCell", ID, "DescripcionCUV2"));
        $("#txtPrecioValorizadoDetalle").val(jQuery("#list").jqGrid("getCell", ID, "Precio2"));

        showDialog("DialogRegistroOfertaShowRoomDetalle");

        _fnGrillaOfertaShowRoomDetalle(CampaniaID, CUV, ID);
        return false;
    }

    function EliminarProducto(EstrategiaID, event) {
        if (event) {
            event.preventDefault();
            event.stopPropagation();
        }

        var eliminar = confirm("¿ Está seguro que desea deshabilitar todos los productos del set ?");
        if (!eliminar)
            return false;

        var item = {
            estrategiaID: EstrategiaID
        };

        console.log(item);

        waitingDialog();
        jQuery.ajax({
            type: "POST",
            url: _config.urlEliminarOfertaShowRoomDetalleAll,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == true) {
                        alert(data.message);
                    } else
                        alert(data.message);
                }

                return false;
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
        return false;
    }

    function EditarProductoDetalle(ID, Imagen) {
        $("#hdEstrategiaProductoID").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "EstrategiaProductoId"));
        $("#hdEstrategiaID").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "EstrategiaId"));
        $("#txtCUVProductoDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "CUV"));
        $("#txtNombreProductoDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "NombreProducto"));
        $("#txtDescripcion1Detalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "Descripcion1"));
        $("#txtPrecioOfertaDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "Precio"));
        $("#ddlMarcaProductoDetalle").val(jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "IdMarca"));

        var isActive = (jQuery("#listShowRoomDetalle").jqGrid("getCell", ID, "Activo") == "1");
        $("#chkActivoOfertaDetalle").attr("checked", isActive);

        $("#txtCUVProductoDetalle").attr("readonly", true);
        $("#txtPrecioOfertaDetalle").attr("readonly", true);

        if (typeof Imagen !== "undefined") {
            var imagen = Imagen.replace(/^.*[\\\/]/, "");

            if (imagen != "prod_grilla_vacio.png") {
                $("#hdImagenDetalle").val(imagen);
                $("#hdImagenDetalleAnterior").val(imagen);
                $("#imgProductoDetalle").attr("src", Imagen);
            } else {
                $("#hdImagenDetalle").val("");
                $("#hdImagenDetalleAnterior").val("");
                $("#imgProductoDetalle").attr("src", _config.imagenProductoVacio);
            }
        }
        else {
            $("#hdImagenDetalle").val("");
            $("#hdImagenDetalleAnterior").val("");
            $("#imgProductoDetalle").attr("src", _config.imagenProductoVacio);
        }

        showDialog("DialogRegistroOfertaShowRoomDetalleEditar");
    }

    function EliminarProductoDetalle(ID, EstrategiaID, CUV) {
        var eliminar = confirm("¿ Está seguro que desea deshabilitar el producto ?");
        if (!eliminar)
            return false;

        var item = {
            estrategiaId: EstrategiaID,
            cuv: CUV
        };

        console.log(item);

        waitingDialog();
        jQuery.ajax({
            type: "POST",
            url: _config.urlEliminarOfertaShowRoomDetalle,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == true) {
                        alert(data.message);
                        jQuery("#listShowRoomDetalle").setGridParam({ datatype: "json", page: 1 }).trigger("reloadGrid");
                    } else
                        alert(data.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
    }

    function AddTitleCustom() {
        $('[name^=picture-]').each(function () {
            var img = document.getElementById($(this).attr('id'));
            var uri = (img.src.substring(img.src.lastIndexOf("/") + 1)).toUpperCase();
            if (img.src === "unknown") {
                img.src = _config.rutaImagenVacia;
            }
            if (uri.indexOf(".") == -1) {
                img.src = _config.rutaImagenVacia;
            }
            var extension = (img.src.substring(img.src.lastIndexOf(".") + 1)).toUpperCase();
            var nombre = img.src.match(/[-_\w]+[.][\w]+$/i)[0];
            img.title = extension + ' (' + img.naturalWidth + ' x ' + img.naturalHeight + ' pixels)';
            if (nombre == 'prod_grilla_vacio.png') {
                img.title = '';
            }
            if (img.naturalWidth == 0) {
                img.title = '';
            }
        });
    }

    function Inicializar() {
        _iniDialog();
        _bindingEvents();
        _fnGrilla();
        _activarDesactivarChecks();
        _paletaColores();

        _uploadFileLanzamineto("img-fondo-desktop");
        _uploadFileLanzamineto("img-fondo-mobile");
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
        Remover: Remover,
        ActualizarParNemotecnico: ActualizarParNemotecnico,
        EditarDescripcionComercial: EditarDescripcionComercial,
        EditarEvento: EditarEvento,
        DeshabilitarEvento: DeshabilitarEvento,
        EliminarEvento: EliminarEvento,
        EditarProducto: EditarProducto,
        EliminarProducto: EliminarProducto,
        EditarProductoDetalle: EditarProductoDetalle,
        EliminarProductoDetalle: EliminarProductoDetalle
    }
});