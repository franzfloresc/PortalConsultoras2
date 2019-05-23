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
                componente.HermanosSeleccionados = [];
                componente.cantidadSeleccionados = componente.cantidadSeleccionados || 0;
                componente.selectedQuantityText = "0 Seleccionados";
                if (componente.FactorCuadre == 1) {
                    componente.selectComponentText = "Elige 1 opción";
                    componente.selectComponentTitle = "Elige 1 opción";
                }
                else {
                    componente.selectComponentText = "Elige " + componente.FactorCuadre + " opciones";
                    componente.selectComponentTitle = "Elige " + componente.FactorCuadre + " opciones";
                }
                $.each(componente.Hermanos, function (idxTipoTono, tipoTono) {
                    tipoTono.FactorCuadre = componente.FactorCuadre || 0;
                    tipoTono.HermanosSeleccionados = [];
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
        // debugger;
        result = _config.componentesView.setTitle(selectedComponent.selectComponentTitle) &&
            _config.componentesView.setSelectedQuantityText(selectedComponent.selectedQuantityText) &&
            _config.componentesView.showComponentTypesAndTones(selectedComponent) &&
            _config.componentesView.showTypesAndTonesModal();

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
                    if (tipoTono.Cuv == cuv ) {
                        componente.HermanosSeleccionados.push(tipoTono);
                        debugger;
                        componente.cantidadSeleccionados++;
                        tipoTono.cantidadSeleccionados++;
                        result = _config.componentesView.showQuantitySelector(
                            tipoTono.Grupo,
                            tipoTono.Cuv,
                            tipoTono.cantidadSeleccionados);
                        return false;
                    }
                });
                return false;
            }
        });

        _estrategiaModel(model);
        
        //console.log(_estrategiaModel());

        return result;
    };



    return {
        estrategiaModel: _estrategiaModel,
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        showTypesAndTonesModal: _showTypesAndTonesModal,
        addTypeOrTone: _addTypeOrTone,
    };
};