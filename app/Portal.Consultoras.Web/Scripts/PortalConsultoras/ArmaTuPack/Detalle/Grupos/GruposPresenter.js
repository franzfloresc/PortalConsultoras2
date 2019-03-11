var GruposPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    //
    if (typeof config.gruposView === "undefined" || config.gruposView === null) throw "config.gruposView is null or undefined";
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";
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
            _packComponentsModel = value;
        }
    };

    var _onGruposLoaded = function (packComponents) {
        _packComponents(packComponents);
        _config.gruposView.renderGrupos(packComponents);
    };

    var _addComponente = function (cuvGrupo, cuvComponente) {

    };

    return {
        onGruposLoaded: _onGruposLoaded,
        addComponente: _addComponente
    };
};