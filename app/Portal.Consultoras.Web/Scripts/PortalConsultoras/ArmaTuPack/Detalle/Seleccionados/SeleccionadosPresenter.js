var SeleccionadosPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.seleccionadosView === "undefined" || config.seleccionadosView === null) throw "config.seleccionadosView is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";

    var _config = {
        seleccionadosView: config.seleccionadosView,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents,
        generalModule: config.generalModule
    };

    var _packComponentsModel = null;

    var _packComponents = function (value) {
        if (typeof value === "undefined") {
            return _packComponentsModel;
        } else if (value !== null) {
            value.componentesSeleccionados = value.componentesSeleccionados || [];
            value.componentesNoSeleccionados = value.componentesNoSeleccionados || [];
            value.componentes = value.componentes || [];
            var GrupoFactorCuadre = 0;
            $.each(value.componentes, function (idx, grupo) {
                grupo.cantidadSeleccionados = grupo.cantidadSeleccionados || 0;
                GrupoFactorCuadre = GrupoFactorCuadre + grupo.FactorCuadre;
            });

            if (value.componentesSeleccionados.length == 0) {
                if (value.componentesNoSeleccionados.length == 0) {
                    for (var i = 0; i < GrupoFactorCuadre; i++) {
                        value.componentesNoSeleccionados.push({ ImagenBulk: "" });
                    }
                }
            }

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
        _config.seleccionadosView.renderSeleccionados(_packComponentsModel);
    };

    var _onSelectedComponentsChanged = function (packComponents) {
        if (typeof packComponents === "undefined" || packComponents === null) {
            throw "packComponents is null or undefined";
        }

        if (!Array.isArray(packComponents.componentes) || packComponents.componentes.length === 0) {
            throw "packComponents has no components";
        }
        _packComponents(packComponents);
        _config.seleccionadosView.refreshSeleccionados(packComponents);
    };

    var _deleteComponente = function (grupoComponente, cuvComponente, indiceComponente) {
        if (typeof grupoComponente === "undefined" || grupoComponente === null) throw "grupoComponente is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";
        if (typeof indiceComponente === "undefined" || indiceComponente === null) throw "indiceComponente is null or undefined";

        var model = _packComponents();

        $.each(model.componentes, function (idx, grupo) {
            if (grupo.Grupo == grupoComponente) {
                $.each(grupo.Hermanos, function (idxComponente, componente) {
                    if (componente.Cuv == cuvComponente && componente.cantidadSeleccionados > 0) {
                        grupo.cantidadSeleccionados--;
                        componente.cantidadSeleccionados--;
                        model.componentesSeleccionados.splice(indiceComponente, 1);
                        model.componentesNoSeleccionados.push({ ImagenBulk: "" });
                        return false;
                    }
                });
            }
        });

        _packComponents(model);
        _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, model);
    };

    return {
        onGruposLoaded: _onGruposLoaded,
        onSelectedComponentsChanged: _onSelectedComponentsChanged,
        deleteComponente: _deleteComponente
    };
};