/// <reference path="../../../shared/constantesmodule.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Estrategia/EstrategiaView.js" />

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

        var model = _estrategiaModel();

        if (!_config.estrategiaView.renderBreadcrumbs(model) ||
            !_config.estrategiaView.renderEstrategia(model)) throw "estrategiaView do not render model";

        if (model.CodigoEstrategia == ConstantesModule.TipoEstrategia.Lanzamiento &&
            !_config.estrategiaView.renderBackgroundAndStamp(model)) 
            throw "estrategiaView do not render background and stamp";

        if (model.TieneReloj &&
            !_config.estrategiaView.renderReloj(model)) throw "estrategiaView don't render reloj.";

        if (model.TieneReloj &&
            !_config.estrategiaView.renderRelojStyle(model)) throw "estrategiaView don't render style of reloj.";

        if (!_config.estrategiaView.renderAgregar(model)) throw "estrategiaView don't render agregar.";

        if (!_config.estrategiaView.showTitleAgregado(model)) throw "estrategiaView don't show title Agregado.";

        if(!_config.estrategiaView.setEstrategiaTipoBotonAgregar(model)) throw "estrategiaView don't set type button Agregado.";
  
        _config.estrategiaView.showCarrusel();
        _config.estrategiaView.fixButtonAddProduct();
        return true;
    };

    var _onEstrategiaModelClick = function (event, popup, limite, esFicha, esEditable) {
        if (!(event instanceof Event)) throw  "event is undefined";
        if (!(typeof popup === "boolean")) throw  "popup is undefined";
        if (!(typeof limite === "number")) throw  "limite is undefined";
        if (!(typeof esFicha === "boolean")) throw  "esFicha is undefined";
        if (!(typeof esEditable === "boolean")) throw  "esEditable is undefined";

        var model = _estrategiaModel();

        EstrategiaAgregarModule.EstrategiaAgregar(event, popup, limite, esFicha, esEditable, model);
    };

    return {
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        onEstrategiaModelClick: _onEstrategiaModelClick
    };
};