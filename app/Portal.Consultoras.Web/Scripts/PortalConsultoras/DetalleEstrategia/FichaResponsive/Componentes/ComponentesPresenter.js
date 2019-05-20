var ComponentePresenter = function (config) {
    var _config = {
        componenteView: config.componenteView
    };

    var _estrategiaInstance = null;
    var _estrategiaModel = function (value) {
        if (typeof value === "undefined") {
            return _estrategiaInstance;
        } else if (value !== null) {
            _estrategiaInstance = value;
        }
    };

    var _onEstrategiaModelLoaded = function (estrategiaModel) {
        _estrategiaModel(estrategiaModel);
        _estrategiaInstance = _estrategiaModel();

        if (!_config.componenteView.renderComponente(_estrategiaInstance)) throw "componenteView do not render model";

        return true;
    };

    return {
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
    };
};