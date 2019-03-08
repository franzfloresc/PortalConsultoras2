var GruposPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    //
    if (typeof config.gruposView === "undefined" || config.gruposView === null) throw "config.gruposView is null or undefined";
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";

    var _config = {
        gruposView: config.gruposView,
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };


    var _onGruposLoaded = function (PackComponents) {
        _config.gruposView.renderGrupos(PackComponents);
    };

    return {
        onGruposLoaded: _onGruposLoaded
    };
};