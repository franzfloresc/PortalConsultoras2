var FichaEnriquecidaPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.fichaEnriquecidaView === "undefined" || config.fichaEnriquecidaView === null) throw "config.fichaEnriquecidaView is null or undefined";

    var _config = {
        fichaEnriquecidaView: config.fichaEnriquecidaView
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

    var _showPopupFichaEnriquecida = function (event) {
        var componente = $(event.target).parents("[data-componente-grupo]").find("[data-componente]").data("componente");
        _config.fichaEnriquecidaView.showPopup(componente);
    };

    var _hidePopupFichaEnriquecida = function () {
        _config.fichaEnriquecidaView.hidePopup();
    };

    var _onFichaResponsiveModelLoaded = function (estrategiaModel) {
        if (typeof estrategiaModel === "undefined" || estrategiaModel === null) throw "estrategiaModel is null or undefined";

        _estrategiaModel(estrategiaModel);

        var model = _estrategiaModel();

        if (model.MostrarFichaEnriquecida &&
            model.MostarTabsFichaEnriquecidaSinDetalle &&
            !_config.fichaEnriquecidaView.renderFichaEnriquecida(model.Hermanos[0])) throw "fichaEnriquecidaView don't render ficha enriquecida.";

        return true;
    }

    return {
        onFichaResponsiveModelLoaded: _onFichaResponsiveModelLoaded,
        showPopupFichaEnriquecida: _showPopupFichaEnriquecida,
        hidePopupFichaEnriquecida: _hidePopupFichaEnriquecida
    }
}