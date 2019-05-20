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
            $.each(value.Hermanos, function (idx, hermano) {
                hermano.FactorCuadre = hermano.FactorCuadre || 0;
                if(hermano.FactorCuadre == 1)
                    hermano.selectComponentTitle = "Elige 1 opción";
                else
                    hermano.selectComponentTitle = "Elige " + hermano.FactorCuadre + " opciones";
            });
            _estrategiaInstance = value;
        }
    };

    var _onEstrategiaModelLoaded = function (estrategiaModel) {
        _estrategiaModel(estrategiaModel);

        if (!_config.componentesView.renderComponente(_estrategiaModel())) throw "componenteView do not render model";

        return true;
    };

    return {
        estrategiaModel: _estrategiaModel,
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
    };
};