var GruposPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    //
    if (typeof config.gruposView === "undefined" || config.gruposView === null) throw "config.gruposView is null or undefined";
    //if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";

    var _config = {
        gruposView: config.gruposView,
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };

    var _packComponentsModel = null;

    var _packComponents = function (value) {
        if (typeof value === "undefined") {
            return _packComponentsModel;
        } else if (value !== null) {
            value.componentesSeleccionados = value.componentesSeleccionados || [];
            value.componentesNoSeleccionados = value.componentesNoSeleccionados || [];
            value.componentes = value.componentes || [];

            $.each(value.componentes, function (idx, grupo) {
                grupo.cantidadSeleccionados = grupo.cantidadSeleccionados || 0;
                if(grupo.mensajeEligeopciones === undefined){
                    if (grupo.FactorCuadre == 1) {
                        grupo.mensajeEligeopciones = "Elige 1 opción";
                    }
                    else {
                        grupo.mensajeEligeopciones = "Elige " + grupo.FactorCuadre + " opciones";
                    }
                }
            });

            _packComponentsModel = value;
        }
    };

    var _onGruposLoaded = function (packComponents) {
        if (typeof packComponents === "undefined" || packComponents === null) {
            throw "packComponents is null or undefined";
        }

        if (!Array.isArray(packComponents.componentes) || packComponents.componentes.length === 0) {
            throw "packComponents has no components";
        }
        _packComponents(packComponents);
        _config.gruposView.renderGrupos(packComponents);
    };

    var _updateGroupView = function(cantidadSeleccionados,factorCuadre,cuvGrupo,cuvComponente){
        if (cantidadSeleccionados == 0) {
            _config.gruposView.showChooseIt(cuvComponente);
            _config.gruposView.showGroupOptions(cuvGrupo);
            _config.gruposView.hideGroupReady(cuvGrupo);
            _config.gruposView.unblockGroup(cuvGrupo);
        }
        else if (cantidadSeleccionados < factorCuadre) {
            _config.gruposView.showQuantitySelector(cuvComponente);
            _config.gruposView.showGroupOptions(cuvGrupo);
            _config.gruposView.hideGroupReady(cuvGrupo);
            _config.gruposView.unblockGroup(cuvGrupo);
        }
        else if (cantidadSeleccionados == factorCuadre) {
            _config.gruposView.showQuantitySelector(cuvComponente);
            _config.gruposView.hideGroupOptions(cuvGrupo);
            _config.gruposView.showGroupReady(cuvGrupo);
            _config.gruposView.blockGroup(cuvGrupo);
        }
    };

    var _addComponente = function (cuvGrupo, cuvComponente) {
        if (typeof cuvGrupo === "undefined" || cuvGrupo === null) throw "cuvGrupo is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";

        cuvGrupo = $.trim(cuvGrupo);
        cuvComponente = $.trim(cuvComponente);

        var model = _packComponents();
        var compSelCounter = model.componentesSeleccionados.length;

        $.each(model.componentes, function (idx, grupo) {
            if (grupo.Cuv == cuvGrupo) {
                $.each(grupo.Hermanos, function (idx, componente) {
                    if (componente.Cuv == cuvComponente && grupo.cantidadSeleccionados < componente.FactorCuadre) {
                        model.componentesSeleccionados.push(componente);
                        model.componentesNoSeleccionados.splice(0, 1);
                        grupo.cantidadSeleccionados++;
                        _updateGroupView(grupo.cantidadSeleccionados,
                            grupo.FactorCuadre,
                            cuvGrupo,
                            cuvComponente);
                        return;
                    }
                });
                return;
            }
        });

        if (compSelCounter < model.componentesSeleccionados.length) {
            _packComponents(model);
            _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, model);
        }
    };

    var _deleteComponente = function (cuvGrupo, cuvComponente) {
        if (typeof cuvGrupo === "undefined" || cuvGrupo === null) throw "cuvGrupo is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";

        var model = _packComponents();
        var componenteSeleccionadoIndex = -1;

        for (var idxComponenteSeleccionado = model.componentesSeleccionados.length - 1; idxComponenteSeleccionado >= 0; idxComponenteSeleccionado--) {
            var componenteSeleccionado = model.componentesSeleccionados[idxComponenteSeleccionado];

            if (componenteSeleccionado.Cuv == cuvComponente) {
                componenteSeleccionadoIndex = idxComponenteSeleccionado;
                break;
            }
        }

        $.each(model.componentes, function (idxGrupo, grupo) {
            if (grupo.Cuv == cuvGrupo) {
                $.each(grupo.Hermanos, function (idxComponente, componente) {
                    if (componente.Cuv == cuvComponente && grupo.cantidadSeleccionados > 0) {
                        grupo.cantidadSeleccionados--;
                        _updateGroupView(grupo.cantidadSeleccionados,
                            grupo.FactorCuadre,
                            cuvGrupo,
                            cuvComponente);
                        return false;
                    }
                });
                return false;
            }
        });

        if (componenteSeleccionadoIndex != -1) {
            model.componentesSeleccionados.splice(componenteSeleccionadoIndex, 1);
            model.componentesNoSeleccionados.push({ ImagenBulk: ""});
            _packComponents(model);
            _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, model);
        }
    };

    return {
        onGruposLoaded: _onGruposLoaded,
        addComponente: _addComponente,
        packComponents: _packComponents,
        deleteComponente: _deleteComponente
    };
};