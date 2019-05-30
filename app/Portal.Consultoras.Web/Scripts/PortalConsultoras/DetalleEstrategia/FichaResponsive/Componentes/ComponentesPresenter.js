/// <reference path="../Componentes/ComponentesView.js" />

var ComponentesPresenter = function (config) {
    if (typeof config === "undefined" || config == null) throw "config is null or undefined";
    if (typeof config.componentesView === "undefined" || config.componentesView == null) throw "config.componentesView is null or undefined";

    var _config = {
        componentesView: config.componentesView
    };

    var _estrategiaInstance = null;
    var _estrategiaModel = function (value) {
        if (typeof value === "undefined") {
            return _estrategiaInstance;
        } else if (value !== null) {
            value.Hermanos = value.Hermanos || [];
            $.each(value.Hermanos, function (idxComponente, componente) {
                componente.FactorCuadre = componente.FactorCuadre || 0;
                componente.HermanosSeleccionados = componente.HermanosSeleccionados || [];
                componente.cantidadSeleccionados = componente.cantidadSeleccionados || 0;
                componente.cantidadFaltantes = componente.FactorCuadre - componente.cantidadSeleccionados;
                componente = _updateSelectComponentText(componente);
                componente = _updateSelectComponentTitle(componente);
                componente = _updateSelectQuantityText(componente);
                $.each(componente.Hermanos, function (idxTipoTono, tipoTono) {
                    tipoTono.FactorCuadre = componente.FactorCuadre || 0;
                    tipoTono.cantidadSeleccionados = tipoTono.cantidadSeleccionados || 0;
                });
            });
            _estrategiaInstance = value;
        }
    };

    var _onEstrategiaModelLoaded = function (estrategiaModel) {
        _estrategiaModel(estrategiaModel);

        if (!_config.componentesView.renderComponente(_estrategiaModel())) throw "componenteView do not render model";

        return true;
    };

    var _showTypesAndTonesModal = function (cuvComponente) {
        if (typeof cuvComponente == "undefined" ||
            cuvComponente == null ||
            cuvComponente == "")
            throw "cuvComponente is null or undefined";

        var estrategia = _estrategiaModel();
        var selectedComponent = null;
        $.each(estrategia.Hermanos, function (cidx, component) {
            if (component.Cuv == cuvComponente) {
                selectedComponent = component;
                return false;
            }
        });

        if (selectedComponent == null) throw "estrategia no tiene componente seleccionado";

        var result = false;

        result = _config.componentesView.setTitle(selectedComponent.selectComponentTitle) &&
            _config.componentesView.setSelectedQuantityText(selectedComponent.selectedQuantityText) &&
            _config.componentesView.showComponentTypesAndTones(selectedComponent) &&
            _config.componentesView.showTypesAndTonesModal();

        return result;
    };

    var _updateSelectComponentText = function (componente) {
        if (typeof componente === "undefined" || componente === null) return componente;

        if (componente.FactorCuadre > 1) {
            componente.selectComponentText = "Elige " + componente.FactorCuadre + " opciones";
        } else {
            componente.selectComponentText = "Elige " + componente.FactorCuadre + " opción";
        }

        return componente;
    };

    var _updateSelectComponentTitle = function (componente) {
        if (typeof componente === "undefined" || componente === null) return componente;

        if (componente.cantidadFaltantes < 0) return componente;

        if (componente.cantidadFaltantes == componente.FactorCuadre) {
            if (componente.FactorCuadre > 1) {
                componente.selectComponentTitle = "Elige " + componente.FactorCuadre + " opciones";
            } else {
                componente.selectComponentTitle = "Elige " + componente.FactorCuadre + " opción";
            }
        } else if (componente.cantidadFaltantes > 0) {
            if (componente.cantidadFaltantes > 1) {
                componente.selectComponentTitle = "Te falta " + componente.cantidadFaltantes + " opciones";
            } else {
                componente.selectComponentTitle = "Te falta " + componente.cantidadFaltantes + " opción";
            }
        } else if (componente.cantidadFaltantes == 0) {
            if (componente.FactorCuadre == 1) {
                componente.selectComponentTitle = "<h3>¡Listo! <span>ya tienes tu</span> opción</h3>";
            } else {
                componente.selectComponentTitle = "<h3>¡Listo! <span>ya tienes tus</span> " + componente.FactorCuadre + " opciones</h3>";
            }
        }

        return componente;
    };

    var _updateSelectQuantityText = function (componente) {
        if (typeof componente === "undefined" || componente === null) return componente;

        if (componente.cantidadSeleccionados < 0) return componente;

        if (componente.cantidadSeleccionados == 1) {
            componente.selectedQuantityText = componente.cantidadSeleccionados + " Seleccionado";
        } else {
            componente.selectedQuantityText = componente.cantidadSeleccionados + " Seleccionados";
        }

        return componente;
    };

    var _updateView = function (componente, tipoTono) {
        var result = false;

        var grupo = tipoTono.Grupo;
        var cuv = tipoTono.Cuv;
        var cantidadSeleccionados = tipoTono.cantidadSeleccionados;

        if (tipoTono.cantidadSeleccionados == 0) {
            result = _config.componentesView.showChooseIt(grupo, cuv);
        } else if (tipoTono.cantidadSeleccionados == 1 && componente.FactorCuadre == 1) {
            result = _config.componentesView.showChoosen(grupo, cuv);
        } else if (tipoTono.cantidadSeleccionados >= 1 && componente.FactorCuadre > 1) {
            result = _config.componentesView.showQuantitySelector(grupo, cuv, cantidadSeleccionados);
        }

        if (componente.cantidadSeleccionados < componente.FactorCuadre) {
            result = result && _config.componentesView.unblockTypesOrTones();
            result = result && _config.componentesView.blockApplySelection();
        } else {
            result = result && _config.componentesView.blockTypesOrTones();
            result = result && _config.componentesView.unblockApplySelection();
        }

        result = result && _config.componentesView.setTitle(componente.selectComponentTitle) &&
            _config.componentesView.setSelectedQuantityText(componente.selectedQuantityText) &&
            _config.componentesView.showSelectedTypesOrTones(componente);

        return result;
    };

    var _addTypeOrTone = function (grupo, cuv) {
        if (typeof grupo === "undefined" || grupo === null) throw "grupo is null or undefined";
        if (typeof cuv === "undefined" || cuv === null) throw "cuv is null or undefined";

        var result = false;
        var model = _estrategiaModel();

        $.each(model.Hermanos, function (idxComponente, componente) {
            if (componente.Grupo == grupo) {
                $.each(componente.Hermanos, function (idxTipoTono, tipoTono) {
                    if (tipoTono.Cuv == cuv &&
                        componente.cantidadSeleccionados < componente.FactorCuadre) {
                        componente.HermanosSeleccionados.push(tipoTono);
                        componente.cantidadSeleccionados++;
                        componente.cantidadFaltantes--;
                        tipoTono.cantidadSeleccionados++;
                        componente = _updateSelectComponentTitle(componente);
                        componente = _updateSelectQuantityText(componente);
                        
                        result = _updateView(componente, tipoTono);

                        return false;
                    }
                });
                return false;
            }
        });

        _estrategiaModel(model);

        return result;
    };

    var _removeSelectedItem = function (selectedItems, selectedItem, selectedIndex) {
        if (typeof selectedItems == "undefined" || typeof selectedItem == "undefined") return selectedItems;

        if (typeof selectedIndex == undefined) {
            var tmp = $.extend(true, [], selectedItems);
            tmp = tmp.reverse();
            selectedIndex = -1;
            $.each(tmp, function (idxTmpSelectedItem, tmpSelectedItem) {
                if (selectedItem.Grupo == tmpSelectedItem.Grupo && selectedItem.Cuv == tmpSelectedItem.Cuv) {
                    selectedIndex = idxTmpSelectedItem;
                    return false;
                }
            });

            if (selectedIndex >= 0) selectedIndex = selectedItems.length - selectedIndex - 1;
        }

        selectedItems.splice(selectedIndex, 1);

        return selectedItems;
    };

    var _removeTypeOrTone = function (grupo, cuv, selectedIndex) {
        if (typeof grupo === "undefined" || grupo === null) throw "grupo is null or undefined";
        if (typeof cuv === "undefined" || cuv === null) throw "cuv is null or undefined";

        var result = false;
        var model = _estrategiaModel();

        $.each(model.Hermanos, function (idxComponente, componente) {
            if (componente.Grupo == grupo) {
                $.each(componente.Hermanos, function (idxTipoTono, tipoTono) {
                    if (tipoTono.Cuv == cuv &&
                        componente.cantidadSeleccionados > 0) {
                        componente.HermanosSeleccionados = _removeSelectedItem(componente.HermanosSeleccionados, componente, selectedIndex);
                        componente.cantidadSeleccionados--;
                        componente.cantidadFaltantes++;
                        tipoTono.cantidadSeleccionados--;
                        componente = _updateSelectComponentTitle(componente);
                        componente = _updateSelectQuantityText(componente);

                        result = _updateView(componente, tipoTono);

                        return false;
                    }
                });
                return false;
            }
        });

        _estrategiaModel(model);

        return result;
    };

    var _onPaletaSelectItemClick = function (event, cuv) {
        var paletaItem = $(event.target);
        var cuvPadre = String(paletaItem.length > 0 ? paletaItem.parents("[data-tono-div]").data("tono-div") : "");

        $.each(_estrategiaInstance.Hermanos, function (iComponente, hermano) {
            if (cuvPadre === hermano.Cuv) {
                var componente = _estrategiaInstance.Hermanos[iComponente];

                componente.resumenAplicados = [];

                $.each(componente.Hermanos, function (i, item) {
                    item.cantidadSeleccionada = 0;

                    if (cuv === item.Cuv) {
                        componente.resumenAplicados.push(item);
                        item.cantidadSeleccionada = 1;
                    }
                });

                _aplicarOpciones(true, componente);

                //#region Marcación Analytics (EPM-1442)
                AnalyticsPortalModule.MarcarImagenProducto(_estrategiaInstance, componente.resumenAplicados);
                //#endregion

                return true;
            }
        });

        return true;
    };

    function _aplicarOpciones(callFromSeleccionarPaletaOpcion, _componente) {
        _actualizarCantidadAplicada(_estrategiaInstance.CodigoVariante, _componente);
        _config.componentesView.renderResumen(_componente);

        //var callCloseElegirOpcionesModal = callFromSeleccionarPaletaOpcion ? !callFromSeleccionarPaletaOpcion : true;

        if (ConstantesModule.CodigoVariedad.IndividualVariable === _estrategiaInstance.CodigoVariante) {
            _config.componentesView.showBorderItemSelected(_componente);
        }
        //if (_estrategiaInstance.CodigoVariante.in(ConstantesModule.CodigoVariedad.CompuestaVariable, ConstantesModule.CodigoVariedad.IndividualVariable)) {
        //    _config.componentesView.verifyButtonActive();
        //}

        //#region Marcación Analytics
        //if (callCloseElegirOpcionesModal) {
        //    var nombreConcat = "";

        //    if (_componente.FactorCuadre === 1) {
        //        AnalyticsPortalModule.MarcarBotonAplicarSeleccion(_estrategiaInstance, _componente);
        //    } else {
        //        $.each(_componente.resumenAplicados, function (index, opcion) {
        //            if (opcion.cantidadSeleccionada > 0) {
        //                nombreConcat += " " + _estrategiaInstance.DescripcionCompleta + " " + opcion.NombreBulk + " |";
        //            }
        //        });

        //        nombreConcat = Left(nombreConcat, nombreConcat.length - 1).trim();

        //        AnalyticsPortalModule.MarcarPopupBotonAplicarSeleccionVariasOpciones(nombreConcat);
        //    }
        //}

        //#region TODO: consultar
        //var isDesactivado = $('#btnAgregalo').hasClass(_estrategiaInstance.ClaseBloqueada);

        //if (!isDesactivado) {
        //    fichaModule.SetChangeFichaAnalytics(true, null, null);
        //}
        //#endregion
        //#endregion

        return true;
    }

    function _actualizarCantidadAplicada(codigoVariante, _componente) {
        var resumenAplicadosVisualizar = [];

        $.each(_componente.Hermanos, function (index, hermano) {
            hermano.cantidadAplicada = 0;
            hermano.CodigoVariante = codigoVariante || 0;
        });

        $.each(_componente.resumenAplicados, function (index, item) {
            $.each(_componente.Hermanos, function (index2, hermano) {
                if (hermano.Cuv === item.Cuv) {
                    hermano.cantidadAplicada++;

                    var estaEnResumen = false;
                    $.each(resumenAplicadosVisualizar, function (index3, item2) {
                        if (hermano.Cuv === item2.Cuv) {
                            item2.cantidadAplicada++;
                            estaEnResumen = true;
                        }
                    });

                    if (!estaEnResumen) {
                        resumenAplicadosVisualizar.push(jQuery.extend(true, {}, hermano));
                    }
                }
            });
        });

        _componente.resumenAplicadosVisualizar = resumenAplicadosVisualizar;

        return false;
    };

    return {
        estrategiaModel: _estrategiaModel,
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        showTypesAndTonesModal: _showTypesAndTonesModal,
        addTypeOrTone: _addTypeOrTone,
        onPaletaSelectItemClick: _onPaletaSelectItemClick,
        removeTypeOrTone: _removeTypeOrTone
    };
};