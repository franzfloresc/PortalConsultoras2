/// <reference path="componentesanalyticspresenter.js" />
/// <reference path="../Componentes/ComponentesView.js" />

var ComponentesPresenter = function (config) {
    if (typeof config === "undefined" || config == null) throw "config is null or undefined";
    if (typeof config.componentesView === "undefined" || config.componentesView == null) throw "config.componentesView is null or undefined";
    if (typeof config.componentesAnalyticsPresenter === "undefined" || config.componentesAnalyticsPresenter == null) throw "config.componentesAnalyticsPresenter is null or undefined";

    var _config = {
        componentesView: config.componentesView,
        analyticsPresenter: config.componentesAnalyticsPresenter,
    };

    var _const = {
        tipoSelector: {
            Paleta: 1,
            Panel: 2
        },
        tipoShowMedioPanel: {
            Elige: 1,
            Cambio: 2
        }
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
    var _estrategiaAnteriorInstance = null;
    var _estrategiaAnteriorModel = function (value) {
        if (typeof value === "undefined") {
            return _estrategiaAnteriorInstance;
        } else if (value !== null) {
            _estrategiaAnteriorInstance = JSON.parse(JSON.stringify(value));
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
        _estrategiaAnteriorModel(estrategia); // Guarda el estado antes que se abra el popup
        _config.componentesView.cleanTiposTonosModal(); // Se limpia la seleccion de tonos
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

        _config.analyticsPresenter.showTypesAndTonesModalAnalytics(selectedComponent, _const.tipoShowMedioPanel.Elige);

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
            result = result && _config.componentesView.unblockApplySelection(grupo);

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
                        var tipoTonoSeleccionado = $.extend(true, {}, tipoTono, { cantidadSeleccionados: 1 });
                        componente.HermanosSeleccionados.push(tipoTonoSeleccionado);
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

    var _onPaletaSelectItemClick = function (grupo, cuv) {
        if (typeof grupo === "undefined" || grupo === null) throw "grupo is null or undefined";
        if (typeof cuv === "undefined" || cuv === null) throw "cuv is null or undefined";

        _addTypeOrTone(grupo, cuv);
        _applySelectedTypesOrTones(grupo, _const.tipoSelector.Paleta);
        return true;
    };

    var _getResumenAplicadosVisualizar = function (opcionesAplicadas) {
        opcionesAplicadas = opcionesAplicadas || [];
        if (opcionesAplicadas.length === 0) return opcionesAplicadas;

        var componentesAplicados = [];
        var estaEnResumen = false;

        $.each(opcionesAplicadas, function (idxOpcionAplicada, opcionAplicada) {
            estaEnResumen = false;
            $.each(componentesAplicados, function (idxComponenteAplicado, componenteAplicado) {
                if (componenteAplicado.Grupo == opcionAplicada.Grupo &&
                    componenteAplicado.Cuv == opcionAplicada.Cuv) {

                    estaEnResumen = true;
                    componenteAplicado.cantidadAplicada++;
                    //
                    return false;
                }
            });

            if (!estaEnResumen) {
                opcionAplicada.cantidadAplicada = 0;
                opcionAplicada.cantidadAplicada++;
                componentesAplicados.push(opcionAplicada);
            }
        });

        return componentesAplicados;
    };

    var _updateTypeOrToneSelectedQuantity = function (typesOrTones, selectedQuantity) {
        typesOrTones = typesOrTones || [];

        $.each(typesOrTones, function (idxOpcion, opcion) {
            opcion.cantidadSeleccionados = selectedQuantity;
        });

        return typesOrTones;
    };

    var _applySelectedTypesOrTones = function (grupo, tipo) {
        if (typeof grupo === "undefined" || grupo === null) throw "grupo is null or undefined";
        
        var result = false;
        var model = _estrategiaModel();

        var selectedComponent = {};
        $.each(model.Hermanos, function (idxComponente, componente) {
            if (componente.Grupo == grupo &&
                componente.FactorCuadre == componente.cantidadSeleccionados) {
                selectedComponent = componente;
                componente.resumenAplicados = componente.HermanosSeleccionados;
                componente.resumenAplicadosVisualizar = _getResumenAplicadosVisualizar(componente.resumenAplicados);

                componente.HermanosSeleccionados = [];
                componente.cantidadSeleccionados = 0;
                componente.cantidadFaltantes = componente.FactorCuadre;
                componente.Hermanos = _updateTypeOrToneSelectedQuantity(componente.Hermanos, 0);

                result = true;
                result = result && _config.componentesView.renderResumen(componente);

                if (ConstantesModule.CodigoVariedad.IndividualVariable === model.CodigoVariante) {
                    result = result && _config.componentesView.showBorderItemSelected(componente);
                }

                result = result && _config.componentesView.hideTypeAndTonesModal();

                return false;
            }
        });
        
        _estrategiaModel(model);
        _config.componentesView.verifyButtonAceptar(model.CodigoVariante);

        tipo = tipo || '';
        _config.analyticsPresenter.applySelectedAnalytics(selectedComponent, tipo);

        return result;
    };

    var _changeAppliedTypesOrTones = function (grupo) {
        if (typeof grupo === "undefined" || grupo === null) throw "grupo is null or undefined";

        var result = false;
        var model = _estrategiaModel();

        _estrategiaAnteriorModel(model); // Guarda el estado antes que se abra el popup
        _config.componentesView.cleanTiposTonosModal(); // Se limpia la seleccion de tonos

        var selectedComponent = {};
        $.each(model.Hermanos, function (idxComponente, componente) {
            if (componente.Grupo == grupo) {
                selectedComponent = componente;
                result = true;

                result = result && 
                    _config.componentesView.showTypesAndTonesModal() &&
                    _config.componentesView.showComponentTypesAndTones(selectedComponent);

                $.each(componente.resumenAplicados, function (idxOpcion, opcion) {
                    _addTypeOrTone(opcion.Grupo, opcion.Cuv);
                });

                componente.selectComponentTitle = "";
                if (componente.FactorCuadre == 1)
                    componente.selectComponentTitle = "Cambia tu opción";

                if (componente.FactorCuadre > 1)
                    componente.selectComponentTitle = "Cambia tus " + componente.FactorCuadre + " opciones";

                result = result && _config.componentesView.setTitle(componente.selectComponentTitle);

                //
                return false;
            }
        });

        _estrategiaModel(model);

        _config.analyticsPresenter.showTypesAndTonesModalAnalytics(selectedComponent, _const.tipoShowMedioPanel.Cambio);

        return result;
    };

    var _removeTypeOrToneAssigned = function(){
        _estrategiaModel(_estrategiaAnteriorModel());
    };

    var _cleanContainer = _config.componentesView.cleanContainer;

    return {
        estrategiaModel: _estrategiaModel,
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        showTypesAndTonesModal: _showTypesAndTonesModal,
        addTypeOrTone: _addTypeOrTone,
        onPaletaSelectItemClick: _onPaletaSelectItemClick,
        removeTypeOrTone: _removeTypeOrTone,
        applySelectedTypesOrTones: _applySelectedTypesOrTones,
        changeAppliedTypesOrTones: _changeAppliedTypesOrTones,
        removeTypeOrToneAssigned: _removeTypeOrToneAssigned,
        cleanContainer: _cleanContainer
    };
};