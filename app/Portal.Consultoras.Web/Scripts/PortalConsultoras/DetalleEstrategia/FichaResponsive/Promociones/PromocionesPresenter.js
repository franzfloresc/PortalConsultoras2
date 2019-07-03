var PromocionesPresenter = function (config) {
    if (typeof config === "undefined" || config == null) throw "config is null or undefined";
    if (typeof config.promocionesView === "undefined" || config.promocionesView == null) throw "config.promocionesView is null or undefined";

    var _config = {
        promocionesView: config.promocionesView
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

        var estrategia = _estrategiaModel();

        _config.promocionesView.hideBanner();
        if (estrategia.MostrarPromociones) {
            _config.promocionesView.showBanner();
        }

        return true;
    };
    var _onShowModalPromocionesClicked = function () {
        _config.promocionesView.showModalPromociones();

    };

    return {
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        onShowModalPromocionesClicked: _onShowModalPromocionesClicked
    };
};