var DetallePresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    //
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";

    var _config = {
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };

    var _elementos = {
        dataEstrategia: {
            id: "#data-estrategia",
            dataEstrategia: "data-estrategia"
        }
    };

    var _getEstrategia = function () {
        var estrategia = { IsMobile: false };
        if ($(_elementos.dataEstrategia.id).length > 0) {
            var strJson = $(_elementos.dataEstrategia.id).attr(_elementos.dataEstrategia.dataEstrategia) || "";
            estrategia = JSON.parse(strJson);
        }
        return estrategia;
    };

    var _getPackComponents = function () {
        var estrategia = _getEstrategia();

        var params = {
            estrategiaId: estrategia.EstrategiaID,
            cuv2: estrategia.CUV2,
            campania: estrategia.CampaniaID,
            codigoVariante: estrategia.CodigoVariante,
            codigoEstrategia: estrategia.CodigoEstrategia
        };

        var urlReturn = !estrategia.IsMobile ? "/ofertas" : "/mobile/ofertas";

        _config.armaTuPackProvider
            .getPackComponentsPromise(params)
            .done(function (data) {

                if (typeof data === "undefined" || data === null ||
                    !Array.isArray(data.componentes) || data.componentes.length === 0) {
                    _config.generalModule.redirectTo(urlReturn);
                    return false;
                }
                var dataClone = jQuery.extend(true, {}, data);
                dataClone.estrategia = jQuery.extend(true, {}, estrategia);
                dataClone.subTituloCabecera = estrategia.SubTitulo || "";
                dataClone.colorTexto = estrategia.ColorTexto;

                $.each(data.componentes, function (idx, grupo) {
                    if (typeof grupo.Hermanos === "undefined" || grupo.Hermanos === null || 
                    !Array.isArray(grupo.Hermanos) || grupo.Hermanos.length === 0) {
                        $.each(dataClone.componentes, function (idxClone, grupoClone) {
                            if (grupo.Grupo === grupoClone.Grupo) {
                                dataClone.componentes.splice(idxClone, 1);
                                return false;
                            }
                        });
                    }
                });

                _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onGruposLoaded, dataClone);
            })
            .fail(function (data, error) {
                _config.generalModule.redirectTo(urlReturn);
            });
    };

    var _init = function () {
        _getPackComponents();
    };

    return {
        init: _init
    };
};