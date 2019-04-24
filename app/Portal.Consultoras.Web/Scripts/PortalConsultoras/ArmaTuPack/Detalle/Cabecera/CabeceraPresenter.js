var CabeceraPresenter = function (config) { 
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.cabeceraView === "undefined" || config.cabeceraView === null) throw "config.gruposView is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";

    var _config = {
        cabeceraView: config.cabeceraView,
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };

    var _packComponentsModel = null;

    var _packComponents = function (value) {
        if (typeof value === "undefined") {
            return _packComponentsModel;
        } else if (value !== null) {
            value.componentes = value.componentes || [];
            value.subTituloCabecera = value.subTituloCabecera || "";
            value.eligeComponentes = "ELIGE :";
            value.colorTexto = 'color: ' + value.colorTexto + ';';

            $.each(value.componentes, function (idx, grupo) {
                grupo.FactorCuadre = grupo.FactorCuadre || 0;
                grupo.DescripcionPlural = grupo.DescripcionPlural || "";
                grupo.DescripcionSingular = grupo.DescripcionSingular || "";

                value.eligeComponentes += " " + grupo.FactorCuadre + " ";
                if (grupo.FactorCuadre > 1) {
                    value.eligeComponentes += grupo.DescripcionPlural;
                } else {
                    value.eligeComponentes += grupo.DescripcionSingular;
                }

                if (idx + 1 < value.componentes.length) {
                    value.eligeComponentes += " +"
                }
            });

            _packComponentsModel = value;
        }
    };

    var _onGruposLoaded = function (packComponents) {
        if (typeof packComponents === "undefined" || packComponents === null) {
            throw "packComponents is null or undefined";
        }

        if (!Array.isArray(packComponents.componentes) || packComponents.componentes.length === 0) {
            throw "packComponents has no components";
        }
        _packComponents(packComponents);
        _config.cabeceraView.renderTitle(packComponents);
    };

    return {
        onGruposLoaded: _onGruposLoaded
    };
};