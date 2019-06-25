var variablesPortal = variablesPortal || {};
var localStorageModule = LocalStorageModule()

var DetalleEstrategiaProvider = function () {
    var _urlDetalleEstrategia = ConstantesModule.UrlDetalleEstrategia;
    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _tipoEstrategiaTexto = ConstantesModule.TipoEstrategiaTexto;
    //var _tipoAccionNavegar = ConstantesModule.TipoAccionNavegar;

    var _promiseObternerComponentes = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: "POST",
                url: _urlDetalleEstrategia.obtenerComponentes,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: false,
                cache: false,
                success: function (data) {
                    if (data.success) {
                        dfd.resolve(data);
                    }
                    else {
                        dfd.reject(data);
                    }
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

        } catch (e) {
            dfd.reject({}, {});
        }
        return dfd.promise();
    };

    var _promiseObternerDetallePedido = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: 'post',
                url: _urlDetalleEstrategia.obtenerPedidoWebSetDetalle,
                datatype: 'json',
                contenttype: 'application/json; charset=utf-8',
                data: params,
                success: function (data) {
                    if (data.success) {
                        dfd.resolve(data);
                    }
                    else {
                        dfd.reject(data);
                    }
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

        } catch (e) {
            dfd.reject({}, {});
        }
        return dfd.promise();
    };

    var _promiseObternerModelo = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: "POST",
                url: _urlDetalleEstrategia.obtenerModelo,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: false,
                cache: false,
                success: function (data) {
                    if (data.success) {
                        dfd.resolve(data);
                    }
                    else {
                        dfd.reject(data);
                    }
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

        } catch (e) {
            dfd.reject({}, {});
        }
        return dfd.promise();
    };

    //var _promiseObternerEstrategiaFicha = function (params) {
    //    var dfd = $.Deferred();

    //    $.ajax({
    //        type: "POST",
    //        url: _urlDetalleEstrategia.obtenerEstrategiaFicha,
    //        dataType: "json",
    //        contentType: "application/json; charset=utf-8",
    //        data: JSON.stringify(params),
    //        async: false,
    //        cache: false,
    //        success: function (data) {
    //            dfd.resolve(data);
    //        },
    //        error: function (data, error) {
    //            dfd.reject(data, error);
    //        }
    //    });

    //    return dfd.promise();
    //};

    var _getEstrategia = function (params) {
        var sigueTexto = '_getEstrategia';
        console.log(sigueTexto);
        var estrategia = {};

        _promiseObternerModelo({
            palanca: params.palanca,
            campaniaId: params.campania,
            cuv: params.cuv,
            origen: params.origen,
            esEditable: params.esEditable
        }).done(function (data) {
            estrategia = data.data || {};
            estrategia.Error = data.success === false;
        }).fail(function (data, error) {
            GeneralModule.consoleLog(['_promiseObternerModelo', data, error]);
            throw "DetalleEstrategiaProvider._getEstrategia";
        });

        if (estrategia.Error !== false) {
            return estrategia;
        }

        sigueTexto += '_promiseObternerModelo';
        console.log(sigueTexto);
        estrategia.ConfiguracionContenedor = estrategia.ConfiguracionContenedor || {};
        estrategia.BreadCrumbs = estrategia.BreadCrumbs || {};
        //
        var _objTipoPalanca = ConstantesModule.DiccionarioTipoEstrategia.find(function (x) { return x.texto === params.palanca });
        var _fichaServicioApi = (variablesPortal.MsFichaEstrategias && _objTipoPalanca) ? (variablesPortal.MsFichaEstrategias.indexOf(_objTipoPalanca.codigo) > -1) : false;
        //
        sigueTexto += '_objTipoPalanca + _fichaServicioApi';
        console.log(sigueTexto, _fichaServicioApi + "-" + estrategia.TieneSession);
        if (!_fichaServicioApi && !estrategia.TieneSession) {
            var estrategiaTmp = localStorageModule.ObtenerEstrategia(params.cuv, params.campania, params.palanca);

            sigueTexto += 'estrategiaTmp';
            console.log(sigueTexto, estrategiaTmp);

            if ((typeof estrategiaTmp === "undefined" || estrategiaTmp === null) && estrategia.Palanca === _tipoEstrategiaTexto.OfertasParaMi) {
                estrategiaTmp = localStorageModule.ObtenerEstrategia(params.cuv, params.campania, _tipoEstrategiaTexto.Ganadoras);
                sigueTexto += 'get Ganadoras';
                console.log(sigueTexto, estrategiaTmp);
            }

            if (typeof estrategiaTmp === "undefined" || estrategiaTmp == null) throw "estrategia is null";

            estrategia = $.extend(estrategia, estrategiaTmp);
        }

        if (!estrategia || !estrategia.EstrategiaID) throw 'no obtiene oferta desde api';

        if (typeof estrategia.CodigoVariante != "undefined" &&
            estrategia.CodigoVariante != null &&
            estrategia.CodigoVariante != "") {
            var paramsObtenerComponente = {
                estrategiaId: estrategia.EstrategiaID,
                cuv2: estrategia.CUV2,
                campania: params.campania,
                codigoVariante: estrategia.CodigoVariante,
                codigoEstrategia: estrategia.CodigoEstrategia,
                lstHermanos: estrategia.Hermanos
            };

            _promiseObternerComponentes(paramsObtenerComponente)
                .done(function (data) {
                    estrategia.Hermanos = data.componentes;
                    estrategia.EsMultimarca = data.esMultimarca;
                }).fail(function (data, error) {
                    estrategia.Hermanos = [];
                    estrategia.EsMultimarca = false;

                    GeneralModule.consoleLog(['_promiseObternerComponentes', data, error]);
                    throw "DetalleEstrategiaProvider._GetEstrategia : promiseObternerComponentes";
                });

        }
        else {
            estrategia.Hermanos = [];
            estrategia.EsMultimarca = false;
        }

        estrategia.Hermanos = estrategia.Hermanos || [];

        //estrategia.esCampaniaSiguiente = estrategia.CampaniaID !== _obtenerCampaniaActual();
        $.each(estrategia.Hermanos, function (idx, hermano) {
            hermano = estrategia.Hermanos[idx];
            //hermano.esCampaniaSiguiente = estrategia.esCampaniaSiguiente;
        });

        if (estrategia.Hermanos.length === 1) {
            if (estrategia.Hermanos[0].Hermanos) {
                if (estrategia.Hermanos[0].Hermanos.length > 0) {
                    if (estrategia.Hermanos[0].FactorCuadre === 1) {
                        estrategia.CodigoVariante = _codigoVariedad.IndividualVariable;
                    }
                }
                else {
                    estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
                }
            }
            else {
                estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
            }

        }
        else if (estrategia.Hermanos.length > 1) {
            if (estrategia.CodigoVariante === _codigoVariedad.IndividualVariable) {
                estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
            }
        }
        else if (estrategia.Hermanos.length === 0) {
            estrategia.CodigoVariante = "";
        }

        estrategia.ClaseBloqueada = "btn_desactivado_general";
        estrategia.ClaseBloqueadaRangos = "contenedor_rangos_desactivado";
        estrategia.RangoInputEnabled = "disabled";
        //estrategia.esEditable = _config.esEditable;
        //estrategia.setId = _config.setId || 0;
        //estrategia.TieneStock = _config.esEditable || estrategia.TieneStock;

        //estrategia = $.extend(modeloFicha, estrategia);
        estrategia.TipoPersonalizacion = estrategia.CodigoEstrategia;
        estrategia.MostarTabsFichaEnriquecidaSinDetalle = estrategia.Hermanos.length == 1;

        _esMultimarca = estrategia.EsMultimarca; // General.js/ifVerificarMarca

        return estrategia;
    };

    return {
        promiseObternerComponentes: _promiseObternerComponentes,
        promiseObternerDetallePedido: _promiseObternerDetallePedido,
        promiseObternerModelo: _promiseObternerModelo,
        //promiseObtenerEstrategiaFicha: _promiseObternerEstrategiaFicha,
        promiseGetEstrategia: _getEstrategia
    };
}();