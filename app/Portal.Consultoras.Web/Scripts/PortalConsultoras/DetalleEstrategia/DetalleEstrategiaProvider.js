var variablesPortal = variablesPortal || {};
var localStorageModule = LocalStorageModule()

var DetalleEstrategiaProvider = function () {

    var _urlDetalleEstrategia = {
        obtenerComponentes: '/DetalleEstrategia/ObtenerComponentes',
        obtenerComponenteDetalle: '/DetalleEstrategia/ObtenerComponenteDetalle',
        obtenerModelo: '/DetalleEstrategia/ObtenerModelo',
        obtenerEstrategiaMongo: '/DetalleEstrategia/ObtenerEstrategiaMongo',
        obtenerPedidoWebSetDetalle: '/Pedido/ObtenerPedidoWebSetDetalle'
    }

    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _tipoEstrategiaTexto = ConstantesModule.TipoEstrategiaTexto;

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
                    //if (data.success) {
                    dfd.resolve(data);
                    //}
                    //else {
                    //    dfd.reject(data);
                    //}
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

    var _getEstrategiaTemporal = function (params, estrategia) {

        var estrategiaTemporal = null;
        if (typeof LocalStorageListadoObtenerJson != 'undefined') {
            estrategiaTemporal = LocalStorageListadoObtenerJson(ConstantesModule.KeysLocalStorage.EstrategiaTemporal, null, 1);
        }

        if (estrategiaTemporal == null) {
            return estrategia;
        }

        if (estrategiaTemporal.Cuv == params.cuv && estrategiaTemporal.Palanca == params.palanca) {
            estrategia = $.extend(estrategia, estrategiaTemporal.Estrategia);
            estrategia.Error = false;
        }

        return estrategia;

    };

    var _getEstrategia = function (params) {
        var sigueTexto = '_getEstrategia';
        console.log(sigueTexto, params);
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

        sigueTexto += '_promiseObternerModelo';
        console.log(sigueTexto);
        estrategia.ConfiguracionContenedor = estrategia.ConfiguracionContenedor || {};
        estrategia.BreadCrumbs = estrategia.BreadCrumbs || {};

        var _objTipoPalanca = ConstantesModule.DiccionarioTipoEstrategia.find(function (x) { return x.texto === params.palanca });
        var _fichaServicioApi = (variablesPortal.MsFichaEstrategias && _objTipoPalanca) ? (variablesPortal.MsFichaEstrategias.indexOf(_objTipoPalanca.codigo) > -1) : false;

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

            if (typeof estrategiaTmp === "undefined" || estrategiaTmp == null) {

                estrategia.Error = true;
                //throw "estrategia is null";
            }
            else {
                estrategia = $.extend(estrategia, estrategiaTmp);
            }

        }

        if (estrategia.Error) {
            estrategia = _getEstrategiaTemporal(params, estrategia);
            if (estrategia.Error) {
                return estrategia;
            }
        }

        if (!estrategia || (_objTipoPalanca.codigo != ConstantesModule.TipoPersonalizacion.Catalogo && !estrategia.EstrategiaID)) throw 'no obtiene oferta desde api';

        estrategia.TextoLibre = estrategia.TextoLibre || '';

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

            //if (estrategia.Hermanos.length === 1) {
            //    if (estrategia.Hermanos[0].Hermanos) {
            //        if (estrategia.Hermanos[0].Hermanos.length > 0) {
            //            if (estrategia.Hermanos[0].FactorCuadre === 1) {
            //                estrategia.CodigoVariante = _codigoVariedad.IndividualVariable;
            //            }
            //        }

            _promiseObternerComponentes(paramsObtenerComponente)
                .done(function (data) {
                    estrategia.Hermanos = data.componentes;
                    estrategia.EsMultimarca = data.esMultimarca;

                    if (typeof estrategia.Hermanos != "undefined" && estrategia.Hermanos != null) {
                        $.each(estrategia.Hermanos, function (idx, componente) {

                            if (estrategia.CodigoEstrategia === ConstantesModule.TipoPersonalizacion.Catalogo) {
                                componente.FotosCarrusel = [];
                            } else {
                                componente.FotosCarrusel = componente.FotosCarrusel || [];
                            }
                        });

                        if (estrategia.Hermanos.length === 1) {
                            estrategia.FotosCarrusel = estrategia.Hermanos[0].FotosCarrusel;
                        }
                    }

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
        estrategia.FotosCarrusel = estrategia.FotosCarrusel || [];
        estrategia.Hermanos = estrategia.Hermanos || [];

        $.each(estrategia.Hermanos, function (idx, hermano) {
            hermano = estrategia.Hermanos[idx];
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
        estrategia.TipoPersonalizacion = estrategia.CodigoEstrategia;
        estrategia.MostarTabsFichaEnriquecidaSinDetalle = estrategia.Hermanos.length == 1;

        _esMultimarca = estrategia.EsMultimarca; // General.js/ifVerificarMarca

        if (_objTipoPalanca.codigo == ConstantesModule.TipoPersonalizacion.Catalogo) {
            estrategia.BreadCrumbs.Palanca.Url += "?q=" + localStorage.getItem('valorBuscador');
            //
            var key = ConstantesModule.KeysLocalStorage.DescripcionProductoCatalogo(estrategia.Campania, estrategia.CUV2);
            var descripcionCompleta = localStorage.getItem(key);
            if (descripcionCompleta != '') {
                estrategia.DescripcionCompleta = descripcionCompleta;
                if (estrategia.Hermanos.length > 0) estrategia.Hermanos[0].NombreComercial = descripcionCompleta;
            }
        }


        return estrategia;
    };

    var _promiseObternerEstrategiaMongo = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: "POST",
                url: _urlDetalleEstrategia.obtenerEstrategiaMongo,
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

    return {
        promiseObternerComponentes: _promiseObternerComponentes,
        promiseObternerDetallePedido: _promiseObternerDetallePedido,
        promiseObternerModelo: _promiseObternerModelo,
        promiseGetEstrategia: _getEstrategia,
        promiseObternerEstrategiaMongo: _promiseObternerEstrategiaMongo
    };
}();