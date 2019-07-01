
var ComponentesAnalyticsPresenter = function (config) {

    if (typeof config.analyticsPortal === "undefined" || config.analyticsPortal == null) throw "config.analyticsPortal is null or undefined";

    var _config = {
        analyticsPortal: config.analyticsPortal,
    };

    var _const = {
        tipoSelector: {
            Paleta: 1,
            Panel: 2
        },
        tipoShowMedioPanel: {
            Elige: 1,
            Cambio: 2
        }
    };

    var _applySelectedAnalytics = function (componente, tipo) {
        componente = componente || {};

        var modeloMarcar = {
            Const: {
                TipoSelector: _const.tipoSelector
            },
            TipoSelectorTono: tipo || _const.tipoSelector.Panel,
            Label: componente.NombreComercial
        };

        _config.analyticsPortal.VirtualEventFichaAplicarSeleccionTono(modeloMarcar);
    };

    var _showTypesAndTonesModalAnalytics = function (componente, tipo) {
        componente = componente || {};

        var modeloMarcar = {
            Const: {
                TipoShowMedioPanel: _const.tipoShowMedioPanel
            },
            TipoShowPanelTono: tipo || _const.tipoShowMedioPanel.Cambio,
            Label: componente.NombreComercial
        };

        _config.analyticsPortal.VirtualEventFichaMostrarPanelTono(modeloMarcar);
    };

    return {
        applySelectedAnalytics: _applySelectedAnalytics,
        showTypesAndTonesModalAnalytics: _showTypesAndTonesModalAnalytics
    };
};