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
            value.componentes = value.componentes || [];
            $.each(value.componentes, function (idx, grupo) {
                grupo.cantidadSeleccionados = grupo.cantidadSeleccionados || 0;
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

    var _addComponente = function (cuvGrupo, cuvComponente) {
        if (typeof cuvGrupo === "undefined" || cuvGrupo === null) throw "cuvGrupo is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";

        var model =_packComponents();
        var compSelCounter = model.componentesSeleccionados.length;
        
        $.each(model.componentes,function(idx,grupo){
            if(grupo.Cuv == cuvGrupo){
                $.each(grupo.Hermanos,function(idx,componente){
                    //grupo.HermanosSeleccionados = grupo.HermanosSeleccionados || [];
                    if(componente.Cuv == cuvComponente && grupo.cantidadSeleccionados < componente.FactorCuadre){
                        model.componentesSeleccionados.push(componente);
                        grupo.cantidadSeleccionados++;
                        //grupo.HermanosSeleccionados.push(componente);
                    }
                    });
                }
            });
        
            if (compSelCounter < model.componentesSeleccionados.length) {
                _packComponents(model);
                _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, model);
            }
        };

    var _deleteComponente = function (grupoCuv, cuvComponente) {
        if (typeof grupoCuv === "undefined" || grupoCuv === null) throw "Grupo is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";

        var model = _packComponents();
        var componenteSeleccionadoIndex = -1;

        $.each(model.componentes, function (idx, grupo) {
            if (grupo.Grupo == grupoCuv) {
                $.each(model.componentesSeleccionados, function (idx, componenteSeleccionado) {
                    if (componenteSeleccionado.Cuv == cuvComponente) {
                        componenteSeleccionadoIndex = idx;
                        grupo.cantidadSeleccionados = grupo.cantidadSeleccionados > 0 ? (grupo.cantidadSeleccionados - 1) : 0;
                    }
                });
            }
        });

        if (componenteSeleccionadoIndex != -1) {
            model.componentesSeleccionados.splice(componenteSeleccionadoIndex, 1);
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