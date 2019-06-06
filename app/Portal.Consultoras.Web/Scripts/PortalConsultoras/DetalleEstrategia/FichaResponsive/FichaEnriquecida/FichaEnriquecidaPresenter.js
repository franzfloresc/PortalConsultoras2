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

    var _showPopupFichaEnriquecida = function (grupo, cuv) {
        var _estrategia = _estrategiaModel();
        var _componente = _estrategia.Hermanos.filter(function(hermano){
            return hermano.Grupo === grupo && hermano.Cuv === cuv;
        })[0];

        if(_componente === undefined) throw("componente doesn't exist.");

        _config.fichaEnriquecidaView.showPopup(_componente);

        return true;
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

    var _reloadCarruselVideosFichaEnriquecida = function (seccionTipo) {
        if (seccionTipo == ConstantesModule.TipoSeccion.Video &&
            !_config.fichaEnriquecidaView.reloadCarouselVideos()) throw "carousel videos don't render in ficha enriquecida";
    }

    return {
        onFichaResponsiveModelLoaded: _onFichaResponsiveModelLoaded,
        showPopupFichaEnriquecida: _showPopupFichaEnriquecida,
        hidePopupFichaEnriquecida: _hidePopupFichaEnriquecida,
        reloadCarruselVideosFichaEnriquecida: _reloadCarruselVideosFichaEnriquecida
    }
}