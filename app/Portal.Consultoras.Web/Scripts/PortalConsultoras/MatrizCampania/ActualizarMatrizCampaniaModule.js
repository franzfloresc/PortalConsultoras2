/// <reference path="../../jQuery-1.11.2.js" />

var actualizarMatrizCampaniaModule = (function () {
    "use strict"
    var _settings = {
        habilitarRegalo: '',
        consultarDescripcionUrl: '',
        cargarCampaniaUrl: '',
        insertarProductoDescripcionUrl: '',
        actualizarMatrizComercialUrl: '',
        habilitarNemotecnico: false,
        getImagesByCodigoSapUrl: '',
    };

    var _constants = {
        BUSCAR: 'Buscar',
        BUSCAR_OTRO: 'Buscar Otro',
    };

    var _elements = {
        ddlPais: '#ddlPais',
        ddlCampania: '#ddlCampania',
        txtCodVenta: '#txtCodVenta',
        btnBuscar: '#btnBuscar',
        hdnSap: '#hdnSap',
        hdnIdMatrizComercial: '#hdnIdMatrizComercial',
        hdnIdMatrizComercialImagen: '#hdnIdMatrizComercialImagen',
        txtDescripcion: '#txtDescripcion',
        txtPrecio: '#txtPrecio',
        txtFactorRepeticion: '#txtFactorRepeticion',
        txtDescripcionNueva: '#txtDescripcionNueva',
        txtPrecioNuevo: '#txtPrecioNuevo',
        txtFactorRepeticionNuevo: '#txtFactorRepeticionNuevo',
        txtRegaloDescripcion: '#txtRegaloDescripcion',
        imgSeleccionada: '#imgSeleccionada',
        matrizComercial: '#matriz-comercial',
        fileUpload: '#file-upload',
        matrizImagenesPaginacion: '#matriz-imagenes-paginacion',
        matrizComercialImages: '#matriz-comercial-images',
        matrizComercialItemTemplate: '#matriz-comercial-item-template',
        chkImagenProducto: '.chkImagenProducto',
        imgMatrizPreview: '.img-matriz-preview',
        divVistaPrevia: 'divVistaPrevia',
        imgZonaEstrategia: '#imgZonaEstrategia',
        btnGrabar: '#btnGrabar',
    }

    var _nemotecnicoComponent = null;
    var _matrizFileUploaderComponent = null;
    var _paginadorComponent = null;


    var _initializer = function (settings) {
        _settings.habilitarRegalo = settings.habilitarRegalo;
        _settings.consultarDescripcionUrl = settings.consultarDescripcionUrl;
        _settings.cargarCampaniaUrl = settings.cargarCampaniaUrl;
        _settings.insertarProductoDescripcionUrl = settings.insertarProductoDescripcionUrl;
        _settings.actualizarMatrizComercialUrl = settings.actualizarMatrizComercialUrl;
        _settings.habilitarNemotecnico = settings.habilitarNemotecnico;
        _settings.getImagesByCodigoSapUrl = settings.getImagesByCodigoSapUrl;
        _initDialogs();
        _bindEvents();
        _nemotecnicoComponent = Nemotecnico({
            expresionValidacion: ''
        });
        _matrizFileUploaderComponent = MatrizComercialFileUpload({
            actualizarMatrizComercialAction: _settings.actualizarMatrizComercialUrl,
            habilitarNemotecnico: _settings.habilitarNemotecnico,
            nemotecnico: _nemotecnicoComponent
        });
        _paginadorComponent = Paginador({
            elementId: 'matriz-imagenes-paginacion',
            elementClick: _paginadorClick
        });
    };

    var _initDialogs = function () {
        $('#' + _elements.divVistaPrevia).dialog({
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
                    HideDialog(_elements.divVistaPrevia);
                    //$(this).dialog('close');
                }
            }
        });
    }

    var _bindEvents = function () {

        $(_elements.ddlPais).change(function () {
            var Id = $(this).val();
            if (Id != null) {
                waitingDialog({});
                $.ajaxSetup({ cache: false });
                $.getJSON(_settings.cargarCampaniaUrl, { paisId: Id == "" ? 0 : Id }, function (data) {
                    if (checkTimeout(data)) {
                        _limpiarDependencias(Id);
                        if (Id != "") {
                            var ddlCampania = $(_elements.ddlCampania);
                            if (data.DropDownListCampania.length > 0) {
                                for (var item in data.DropDownListCampania) {
                                    if (data.DropDownListCampania[item].CampaniaID) {
                                        ddlCampania.append($('<option/>', {
                                            value: data.DropDownListCampania[item].CampaniaID,
                                            text: data.DropDownListCampania[item].Codigo
                                        }));
                                    }
                                }
                            }
                        }
                        closeWaitingDialog();
                    }
                });
            }
        });
        $(_elements.txtCodVenta).keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                _preBuscar();
            }
            if (charCode <= 13) {
                return false;
            }
            else {
                var keyChar = String.fromCharCode(charCode);
                var re = /[0-9]/;
                return re.test(keyChar);
            }
        });
        $(_elements.btnBuscar).click(function () { _preBuscar(); });

        $(_elements.txtDescripcion).keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                return false;
            }
            else {
                var keyChar = String.fromCharCode(charCode);
                var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]/;
                return re.test(keyChar);
            }
        });

        $(_elements.txtPrecioNuevo).keypress(function (e) {
            var theEvent = e || window.event;
            var key = theEvent.keyCode || theEvent.which;
            var character = (key != 8 ? String.fromCharCode(key) : "")
            var newValue = this.value + character;
            if (isNaN(newValue) || hasDecimalPlace(newValue, 3)) {
                return false;
            }
        });
        $(_elements.txtFactorRepeticionNuevo).keyup(function (e) {
            var theEvent = e || window.event;
            var key = theEvent.keyCode || theEvent.which;
            key = String.fromCharCode(key);
            var regex = /[0-9]|\./;
            if (!regex.test(key)) {
                theEvent.returnValue = false;
                if (theEvent.preventDefault) theEvent.preventDefault();
            }
        });
        $(_elements.txtFactorRepeticionNuevo).keypress(function (e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });

        if (_settings.habilitarRegalo) {
            $(_elements.imgSeleccionada).on("click", _imageOnClick);
            $(_elements.matrizComercialImages).on("click", _elements.imgMatrizPreview, _imageOnClick);
            $(_elements.matrizComercialImages).on("click", _elements.chkImagenProducto, function () {
                $(_elements.chkImagenProducto).prop('checked', false);
                $(this).attr('checked', 'checked');
                $(_elements.imgSeleccionada).attr("src", $(this).attr('value'));
            });
        }


        $(_elements.btnGrabar).click(function () {
            var vMessage = "";
            if ($.trim($(_elements.txtDescripcion).val()) == "") {
                vMessage += "- Debe ingresar descripción el producto.\n";
                $(_elements.btnBuscar).focus();
                alert(vMessage);
                return false;
            }
            if ($(_elements.btnBuscar)[0].value == _constants.BUSCAR) {
                vMessage += "- Debe realizar la busqueda de la descripción primero.\n";
                $(_elements.btnBuscar).focus();
                alert(vMessage);
                return false;
            }

            _grabar();
        });

        $(document).keydown(function (e) {
            if (e.keyCode == 8 && e.target.tagName != 'INPUT' && e.target.tagName != 'TEXTAREA') {
                e.preventDefault();
            }
        });
    };

    var _limpiarDependencias = function (id) {
        var ddlCampania = $(_elements.ddlCampania);
        ddlCampania.empty();

        ddlCampania.append($('<option/>', {
            value: "",
            text: "-- Seleccionar --"
        }));
    }

    var _preBuscar = function () {
        if ($(_elements.btnBuscar)[0].value == _constants.BUSCAR) {
            var vMessage = "";
            if ($.trim($(_elements.ddlPais).val()) == "") {
                vMessage += "- Debe seleccionar el país.\n";
                $(_elements.ddlPais).focus();
                alert(vMessage);
                return false;
            }
            if ($.trim($(_elements.ddlCampania).val()) == "") {
                vMessage += "- Debe seleccionar la campaña.\n";
                $(_elements.ddlCampania).focus();
                alert(vMessage);
                return false;
            }
            if ($.trim($(_elements.txtCodVenta).val()) == "") {
                vMessage += "- Debe ingresar código único de venta.\n";
                alert(vMessage);
                $(_elements.txtCodVenta).focus();
                return false;
            }
            _buscar();
            return false;
        }

        $(_elements.btnBuscar)[0].value = _constants.BUSCAR;
        $(_elements.ddlPais)[0].disabled = false;
        $(_elements.ddlCampania)[0].disabled = false;
        $(_elements.txtCodVenta)[0].disabled = false;
        _limpiarFormulario();
        return false;
    };

    var _buscar = function () {
        waitingDialog({});
        var _cuv = $(_elements.txtCodVenta).val();
        _cuv = _cuv.trim();
        $(_elements.txtCodVenta).val(_cuv);
        $.ajax({
            type: 'POST',
            url: _settings.consultarDescripcionUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                CUV: _cuv,
                IDCampania: $(_elements.ddlCampania).val(),
                paisID: $(_elements.ddlPais).val()
            }),
            async: true,
            cache: false,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();

                    if (data.success == false) {
                        alert(data.message);
                        return false;
                    }

                    $(_elements.btnBuscar)[0].value = _constants.BUSCAR_OTRO;
                    $(_elements.ddlPais)[0].disabled = true;
                    $(_elements.ddlCampania)[0].disabled = true;
                    $(_elements.txtCodVenta)[0].disabled = true;

                    if (data.lstProducto.length > 0) {
                        $(_elements.hdnSap).val(data.lstProducto[0].SAP);
                        $(_elements.hdnIdMatrizComercial).val(data.lstProducto[0].IdMatrizComercial);
                        $(_elements.txtDescripcion).val(data.lstProducto[0].Descripcion);
                        $(_elements.txtPrecio).val(data.lstProducto[0].PrecioProducto);
                        $(_elements.txtFactorRepeticion).val(data.lstProducto[0].FactorRepeticion);
                    }

                    if (data.lstProducto.length == 2) {
                        $(_elements.txtDescripcionNueva).val(data.lstProducto[1].Descripcion);
                        $(_elements.txtPrecioNuevo).val(data.lstProducto[1].PrecioProducto);
                        $(_elements.txtFactorRepeticionNuevo).val(data.lstProducto[1].FactorRepeticion);
                        if (_settings.habilitarRegalo) {
                            $(_elements.txtRegaloDescripcion).val(data.lstProducto[1].RegaloDescripcion);
                            if ($.trim(data.lstProducto[1].RegaloImagenUrl) != '') {
                                $(_elements.imgSeleccionada).attr("src", data.lstProducto[1].RegaloImagenUrl);
                            }
                        }

                    }

                    if (_settings.habilitarRegalo) {
                        _crearFileUploadAdd();
                        _obtenerImagenesByCodigoSAP(1, true).done(function () {
                            $(_elements.fileUpload).show();
                            $(_elements.matrizComercial).show();
                        });
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("ERROR");
                }
            }
        });
    };

    var _crearFileUploadAdd = function () {
        var data = {
            elementId: 'file-upload',
            idMatrizComercial: function () { return ($(_elements.hdnIdMatrizComercial).val()); },
            idImagenMatriz: 0,
            paisID: $(_elements.ddlPais).val(),
            codigoSAP: $(_elements.hdnSap).val(),
            maxConnections: $(_elements.hdnIdMatrizComercial).val() == '0' ? 1 : 3,
            multiple: $(_elements.hdnIdMatrizComercial).val() != '0',
            onComplete: _uploadComplete
        };
        _matrizFileUploaderComponent.crearFileUpload(data);
        $("#file-upload .qq-upload-button span").text("Nueva Imagen");
    };

    var _uploadComplete = function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").css("display", "none");
            if (response.success) {
                var IdMatrizComercialAnterior = $(_elements.hdnIdMatrizComercial).val();
                $(_elements.hdnIdMatrizComercial).val(response.idMatrizComercial);
                if (IdMatrizComercialAnterior == '0')
                    _crearFileUploadAdd();
                $(_elements.matrizImagenesPaginacion).empty();
                _obtenerImagenesByCodigoSAP(1, true)
            } else {
                alert(response.message);
            };
        }
        closeWaitingDialog();
    };

    var _obtenerImagenesByCodigoSAP = function (pagina, recargarPaginacion) {
        var params = {
            paisID: $(_elements.ddlPais).val(),
            codigoSAP: $(_elements.hdnSap).val(),
            pagina: pagina
        };
        return $
            .post(_settings.getImagesByCodigoSapUrl, params)
            .done(_obtenerImagenesByCodigoSAPSuccess(recargarPaginacion));
    };

    var _obtenerImagenesByCodigoSAPSuccess = function (recargarPaginacion) {
        return function (data, textStatus, jqXHR) {
            if (recargarPaginacion) {
                $(_elements.matrizImagenesPaginacion).empty();
            }
            _mostrarPaginacion(data.totalRegistros);
            _mostrarListaImagenes(data);
            marcarCheckRegistro($(_elements.imgSeleccionada).attr('src'));
            closeWaitingDialog();
        };
    };

    var _mostrarPaginacion = function (numRegistros) {
        if ($(_elements.matrizImagenesPaginacion).children().length !== 0) {
            return false;
        }

        _paginadorComponent.paginar(numRegistros);
    };

    var _mostrarListaImagenes = function (data) {
        SetHandlebars(_elements.matrizComercialItemTemplate, data, _elements.matrizComercialImages);
        $(".qq-upload-list").css("display", "none");
    };

    function marcarCheckRegistro(imgRow) {
        $('.chkImagenProducto[value="' + imgRow + '"]').first().attr('checked', 'checked');
        $(_elements.imgSeleccionada).attr("src", imgRow);
    }

    var _limpiarFormulario = function () {
        $(_elements.txtCodVenta).val("");
        $(_elements.hdnSap).val("");
        $(_elements.hdnIdMatrizComercial).val("");
        $(_elements.hdnIdMatrizComercialImagen).val("");
        $(_elements.txtDescripcion).val("");
        $(_elements.txtPrecio).val("");
        $(_elements.txtFactorRepeticion).val("");
        $(_elements.txtDescripcionNueva).val("");
        $(_elements.txtPrecioNuevo).val("");
        $(_elements.txtFactorRepeticionNuevo).val("");
        $(_elements.txtRegaloDescripcion).val("");
        $(_elements.imgSeleccionada).attr("src", rutaImagenVacia);
        $(_elements.matrizComercial).hide();
        $(_elements.matrizImagenesPaginacion).empty();
        $(_elements.fileUpload).hide();
        $(_elements.matrizComercialImages).empty();
        $(_elements.imgZonaEstrategia).attr("src", rutaImagenVacia);
    };

    var _paginadorClick = function (page) {
        _obtenerImagenesByCodigoSAP(page, false)
            .done(function () {
                closeWaitingDialog();
            });
    };

    var _imageOnClick = function () {
        $(_elements.imgZonaEstrategia).attr("src", $(this).attr("src"));
        showDialog(_elements.divVistaPrevia);
    }

    var _grabar = function () {
        var msj = "";

        if ($(_elements.txtDescripcionNueva).val() == "")
            msj += "- Debe ingresar la nueva Descripción del Producto \n";

        if ($(_elements.txtPrecioNuevo).val() == "")
            msj += "- Debe ingresar el Nuevo Precio del Producto \n";

        if ($(_elements.txtFactorRepeticionNuevo).val() == "")
            msj += "- Debe ingresar el Nuevo Factor Repetición del Producto \n";

        if (msj != "") {
            alert(msj);
            return false;
        }

        waitingDialog({});
        var item = {
            CUV: $(_elements.txtCodVenta).val().trim(),
            CampaniaID: $(_elements.ddlCampania).val().trim(),
            Descripcion: $(_elements.txtDescripcionNueva).val(),
            PaisID: $(_elements.ddlPais).val().trim(),
            PrecioProducto: $(_elements.txtPrecioNuevo).val(),
            FactorRepeticion: $(_elements.txtFactorRepeticionNuevo).val()
        };
        if (_settings.habilitarRegalo) {
            item.RegaloDescripcion = $(_elements.txtRegaloDescripcion).val();
            var imagen = $(_elements.imgSeleccionada).attr('src');
            if (imagen != '' && imagen.indexOf('prod_grilla_vacio.png') == -1)
                item.RegaloImagenUrl = imagen.substr(imagen.lastIndexOf("/") + 1);
        }
        $.ajax({
            type: 'POST',
            url: _settings.insertarProductoDescripcionUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        _limpiarFormulario();
                        $(_elements.btnBuscar)[0].value = _constants.BUSCAR;
                        $(_elements.ddlPais)[0].disabled = false;
                        $(_elements.ddlCampania)[0].disabled = false;
                        $(_elements.txtCodVenta)[0].disabled = false;
                        alert(data.message);
                    }
                    else
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
    };

    return {
        ini: function (settings) {
            _initializer(settings);
        }
    };
})();


