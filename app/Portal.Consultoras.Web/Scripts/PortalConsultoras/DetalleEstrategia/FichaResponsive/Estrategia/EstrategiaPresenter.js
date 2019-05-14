var EstrategiaPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.estrategiaView === "undefined" || config.estrategiaView === null) throw "config.estrategiaView is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.fichaResponsiveEvents === "undefined" || config.fichaResponsiveEvents === null) throw "config.fichaResponsiveEvents is null or undefined";

    var _config = {
        estrategiaView: config.estrategiaView,
        //armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        fichaResponsiveEvents: config.fichaResponsiveEvents
    };

    var _estrategiaInstance = null;
    var _estrategiaModel = function (value) {
        if (typeof value === "undefined") {
            return _estrategiaInstance;
        } else if (value !== null) {
            value.isMobile = isMobile();

            _estrategiaInstance = value;
        }
    };

    var _onEstrategiaModelLoaded = function (estrategiaModel) {
        if (typeof estrategiaModel === "undefined" || estrategiaModel === null) throw "estrategiaModel is null or undefined";

        _estrategiaModel(estrategiaModel);
        
        if(!_config.estrategiaView.render(_estrategiaModel())) throw "estrategiaView do not render model";

        return true;
    };

    return {
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
    };
};