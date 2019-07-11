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
            value.EsPromocion || false;
            value.MostrarPromociones || false;
            value.Promocion = value.Promocion || {};
            value.Promocion.Condiciones = value.Promocion.Condiciones || [];
            value.Promocion.lista = value.Promocion.Condiciones;
            //
            _estrategiaInstance = value;
        }
    };

    var _onEstrategiaModelLoaded = function (estrategiaModel) {
        _estrategiaModel(estrategiaModel);

        var estrategia = _estrategiaModel();

        _config.promocionesView.hideBanner();
        if (typeof estrategia.MostrarPromociones != "undefined" &&
            estrategia.MostrarPromociones &&
            (typeof estrategia.Promocion != "undefined" && estrategia.Promocion != null) &&
            estrategia.Condiciones.length > 0) {
            _config.promocionesView.showBanner(estrategia);
        }

        return true;
    };
    var _onShowModalPromocionesClicked = function () {
        var estrategia = _estrategiaModel();

        if (estrategia.Promocion == null || estrategia.Condiciones.length == 0) return true;

        _config.promocionesView.showModalPromociones();
        _config.promocionesView.showConditions(estrategia.Promocion);
        _config.promocionesView.showPromotion(estrategia.Promocion);

        return true;
    };

    return {
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        onShowModalPromocionesClicked: _onShowModalPromocionesClicked
    };
};