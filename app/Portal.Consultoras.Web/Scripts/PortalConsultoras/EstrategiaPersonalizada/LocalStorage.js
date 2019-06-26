var LocalStorageModule = (function () {
    'use strict';
    var _tipoEstrategiaTexto = ConstantesModule.TipoEstrategiaTexto;
    var _tipoEstrategia = ConstantesModule.TipoEstrategia;
    var _codigoPalanca = ConstantesModule.CodigoPalanca;
    var _keyLocalStorage = ConstantesModule.KeysLocalStorage;

    var _urlObtenerEstrategia = ConstantesModule.UrlObtenerEstrategia;

    var _obtenerKey = function (palanca, campania) {

        switch (palanca) {
            case _tipoEstrategiaTexto.RevistaDigital:
            case _tipoEstrategiaTexto.OfertaParaTi:
            case _tipoEstrategiaTexto.OfertasParaMi:
                return _keyLocalStorage.RevistaDigital + campania;
            case _tipoEstrategiaTexto.GuiaDeNegocioDigitalizada:
                return _keyLocalStorage.GuiaDeNegocio + campania;
            case _tipoEstrategiaTexto.Lanzamiento:
                return _keyLocalStorage.Lanzamiento + campania;
            case _tipoEstrategiaTexto.HerramientasVenta:
                return _keyLocalStorage.HerramientasVenta + campania;
            case _tipoEstrategiaTexto.Ganadoras:
                return _keyLocalStorage.Ganadoras + campania;

            default:
                return null;
        }
    };

    var _obtenerKeyName2 = function (codigoPalanaca, campania) {
        switch (codigoPalanaca) {
            case _codigoPalanca.RD:
            case _tipoEstrategia.RevistaDigital:
            case _tipoEstrategia.OfertaParaTi:
            case _tipoEstrategia.OfertasParaMi:
            case _tipoEstrategia.PackAltoDesembolso:
                return _keyLocalStorage.RevistaDigital;
            case _codigoPalanca.GND:
            case _tipoEstrategia.GuiaDeNegocioDigitalizada:
                return _keyLocalStorage.GuiaDeNegocio;
            case _codigoPalanca.LAN:
            case _tipoEstrategia.Lanzamiento:
                return _keyLocalStorage.Lanzamiento;
            case _codigoPalanca.HV:
            case _tipoEstrategia.HerramientasVenta:
                return _keyLocalStorage.HerramientasVenta;
            case _codigoPalanca.MG:
            case _tipoEstrategia.MasGanadoras:
                return _keyLocalStorage.Ganadoras;
            //INI HD-3908
            case _codigoPalanca.PN:
            case _tipoEstrategia.PackNuevas:
                return _keyLocalStorage.PackNuevas;
            case _codigoPalanca.DP:
                //case _tipoEstrategia.PackNuevas:
                return _keyLocalStorage.DuoPerfecto;
            //FIN HD-3908
            default:
                return null;
        }
    };

    var _promiseObternerEstrategia = function (urlEstrategia, params) {
        var dfd = $.Deferred();

        $.ajax({
            type: "POST",
            url: urlEstrategia,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: false,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _existeItem = function (nombreKey) {
        return localStorage.getItem(nombreKey) !== null || localStorage.hasOwnProperty(nombreKey);
    };

    var _buscarEstrategiaPorCuv = function (cuv, palanca, listaLocalStorage) {
        var arrayEstrategia;

        if (palanca === _tipoEstrategiaTexto.Lanzamiento) {
            arrayEstrategia = (listaLocalStorage.response.listaLan || []).Find("CUV2", cuv) || new Array();
        } else {
            arrayEstrategia = (listaLocalStorage.response.lista || []).Find("CUV2", cuv) || new Array();
        }

        if (arrayEstrategia.length > 0) return arrayEstrategia[0];
        else return null;
    };

    var _obtenerUrlEstrategia = function (palanca) {
        switch (palanca) {
            case _tipoEstrategiaTexto.RevistaDigital:
            case _tipoEstrategiaTexto.OfertasParaMi:
                return _urlObtenerEstrategia.OfertasParaMi;
            case _tipoEstrategiaTexto.OfertaParaTi:
                return _urlObtenerEstrategia.OfertaParaTi;
            case _tipoEstrategiaTexto.GuiaDeNegocioDigitalizada:
                return _urlObtenerEstrategia.GuiaDeNegocioDigitalizada;
            case _tipoEstrategiaTexto.Lanzamiento:
                return _urlObtenerEstrategia.Lanzamiento;
            case _tipoEstrategiaTexto.HerramientasVenta:
                return _urlObtenerEstrategia.HerrameintasVenta;
            case _tipoEstrategiaTexto.Ganadoras:
                return _urlObtenerEstrategia.MasGanadoras;
            default:
                return null;
        }
    };

    var _crearBaseEstrategiaItem = function (campania) {
        var localStorageItem = {}
        localStorageItem.CampaniaID = campania;
        localStorageItem.IsLoad = false;
        localStorageItem.UrlCargarProductos = "";
        localStorageItem.VarListaStorage = "";
        return localStorageItem;
    };

    var _cargarEstrategias = function (campania, palanca, nombreKey) {
        var localStorageItem = _crearBaseEstrategiaItem(campania);
        var param = {
            CampaniaID: campania,
            IsMobile: isMobile()
        };
        var urlEstrategia = _obtenerUrlEstrategia(palanca);
        if (urlEstrategia == null || urlEstrategia == "") {
            return false;
        }
        var resppuesta = true;
        _promiseObternerEstrategia(urlEstrategia, param).done(function (data) {

            if (data.success !== true) {
                resppuesta = false;
            }
            else {
                localStorageItem.response = data;
                localStorageItem.UrlCargarProductos = urlEstrategia;
                localStorageItem.VarListaStorage = nombreKey;

                if (palanca == _tipoEstrategiaTexto.Lanzamiento) {
                    localStorageItem.response.listaLan = localStorageItem.response.lista || localStorageItem.response.listaLan;
                    localStorageItem.response.lista = [];
                }

                localStorage.setItem(nombreKey, JSON.stringify(localStorageItem));
            }

        }).fail(function (data, error) {
            resppuesta = false;
        });

        return resppuesta;
    };

    var ObtenerEstrategiasNoLS = function (campania, palanca) {
        var result = [];
        var urlEstrategia = _obtenerUrlEstrategia(palanca);
        if (urlEstrategia == null || urlEstrategia == "") {
            return result;
        }

        var param = {
            CampaniaID: campania,
            IsMobile: isMobile()
        };
        
        _promiseObternerEstrategia(urlEstrategia, param).done(function (data) {

            if (data.success === true) {
                result = data.lista;
            }

        }).fail(function (data, error) {
            result = [];
        });

        return result;
    };

    var _actualizarAgregado = function (lista, estrategiaId, valor) {
        var updated = false;
        if (lista !== undefined) {
            $.each(lista, function (index, estrategia) {
                if (estrategia.EstrategiaID === parseInt(estrategiaId)) {
                    estrategia.IsAgregado = valor;
                    updated = true;
                    return false;
                }
            });
        }
        return updated;
    };

    var ObtenerEstrategia = function (cuv, campania, palanca) {
        try {
            var nombreKey = _obtenerKey(palanca, campania);

            if (IsNullOrEmpty(nombreKey))
                return null;

            if (!_existeItem(nombreKey)) {
                if (!_cargarEstrategias(campania, palanca, nombreKey)) {
                    return null;
                }
            }

            var listaLocalStorage = JSON.parse(localStorage.getItem(nombreKey));

            return _buscarEstrategiaPorCuv(cuv, palanca, listaLocalStorage);

        } catch (e) {
            console.error("error al cargar productos de local storage : " + e);
        }
        return null;
    };

    var ActualizarCheckAgregado = function (estrategiaId, campania, codigoPalanaca, valor) {
        try {
            var nombreKey = _obtenerKeyName2(codigoPalanaca);
            var nombreKeyLocalStorage = nombreKey + campania;
            var valLocalStorage = localStorage.getItem(nombreKeyLocalStorage);

            //INI HD-3908
            if (valLocalStorage == null && codigoPalanaca === _tipoEstrategia.PackNuevas) {
                nombreKey = _keyLocalStorage.DuoPerfecto;
                nombreKeyLocalStorage = nombreKey + campania;
                valLocalStorage = localStorage.getItem(nombreKeyLocalStorage);
            }
            //FIN HD-3908
            if (valLocalStorage != null) {
                var data = JSON.parse(valLocalStorage);
                var updated;
                if (codigoPalanaca === _tipoEstrategia.Lanzamiento || codigoPalanaca === _codigoPalanca.LAN)
                    updated = _actualizarAgregado(data.response.listaLan, estrategiaId, valor);
                else
                    updated = _actualizarAgregado(data.response.lista, estrategiaId, valor);

                if (updated) localStorage.setItem(nombreKeyLocalStorage, JSON.stringify(data));

                if (!updated && codigoPalanaca == _tipoEstrategia.OfertasParaMi) {
                    ActualizarCheckAgregado(estrategiaId, campania, "MG", valor);
                }
            }


            if (typeof filtroCampania !== "undefined") {
                var nombreKeyJs = nombreKey + (indCampania || 0);
                var listaPalanca = filtroCampania[nombreKeyJs];
                if (listaPalanca != undefined) {
                    _actualizarAgregado(listaPalanca.response.lista, estrategiaId, valor);
                    filtroCampania[nombreKeyJs] = listaPalanca;
                }
            }

            return true;
        } catch (e) {
            console.error("error al cargar productos de local storage : " + e);
            return false;
        }
    };

    return {
        ObtenerEstrategia: ObtenerEstrategia,
        ActualizarCheckAgregado: ActualizarCheckAgregado,
        ObtenerEstrategiasNoLS: ObtenerEstrategiasNoLS
    };
});

var lsListaRD = lsListaRD || "";

function LocalStorageListado(key, valor, accion) {
    // accion => 0 insertar => 1 obtener => 2 eliminar
    accion = accion || 0;

    if (accion == 0) {
        if (valor != undefined) {
            localStorage.setItem(key, JSON.stringify(valor));
        }
    }
    else if (accion == 1) {
        return localStorage.getItem(key);
    }

    if (accion == 2) {
        localStorage.removeItem(key);
    }
}

function LocalStorageListadoObtenerJson(key, valor, accion) {
    var str = LocalStorageListado(key, valor, accion) || "";

    if (str === '') {
        return null;
    }

    return JSON.parse(str);
}

function GetProductoStorage(cuv, campania, nombreKey) {
    nombreKey = nombreKey || lsListaRD;
    var sl = LocalStorageListado(nombreKey + campania, '', 1);
    if (sl == null || sl == undefined) {

        var model = $("[data-item-cuv=" + cuv + "]").find("[data-estrategia]").attr("data-estrategia");
        if (model == undefined || model.length === 0) {
            model = $("[data-item-cuv=" + cuv + "]").attr("data-estrategia");
        }
        if (model == undefined) return model;

        model = JSON.parse(model);
        if (model != null) return model;
        else return null;
    }

    sl = JSON.parse(sl);
    var listaProd = (sl.response.listaLan || []).Find("CUV2", cuv) || new Array();
    if (listaProd.length == 0) {
        listaProd = (sl.response.lista || []).Find("CUV2", cuv) || new Array();
    }
    if (listaProd.length > 0) {
        listaProd[0].Posicion = 0;
        return listaProd[0];
    }

    return {};
}

function ActualizarLocalStoragePalancas(cuv, valor) {
    ActualizarLocalStorageAgregado("RD", cuv, valor);
    ActualizarLocalStorageAgregado("GND", cuv, valor);
    ActualizarLocalStorageAgregado("HV", cuv, valor);
    ActualizarLocalStorageAgregado("LAN", cuv, valor);
    ActualizarLocalStorageAgregado("MG", cuv, valor);
    //INI HD-3908
    ActualizarLocalStorageAgregado("PN", cuv, valor);
    ActualizarLocalStorageAgregado("DP", cuv, valor);
    //FIN HD-3908
}

function ActualizarLocalStorageAgregado(tipo, cuv, valor) {
    var ok = false;
    try {
        tipo = $.trim(tipo);
        cuv = $.trim(cuv);

        if (tipo === "" || cuv === "" || valor == undefined) {
            return false;
        }

        var listaCuv = cuv.split('|');
        var indCampania = indCampania || 0;
        var lista = "";
        if (tipo == ConstantesModule.CodigoPalanca.RD) {
            lista = ConstantesModule.KeysLocalStorage.RevistaDigital;
        }
        else if (tipo == ConstantesModule.CodigoPalanca.GND) {
            lista = ConstantesModule.KeysLocalStorage.GuiaDeNegocio;
        }
        else if (tipo == ConstantesModule.CodigoPalanca.HV) {
            lista = ConstantesModule.KeysLocalStorage.HerramientasVenta;
        }
        else if (tipo == ConstantesModule.CodigoPalanca.LAN) {
            lista = ConstantesModule.KeysLocalStorage.Lanzamiento;
        }
        else if (tipo == ConstantesModule.CodigoPalanca.MG) {
            lista = ConstantesModule.KeysLocalStorage.Ganadoras;
        }
        //INI HD-3908
        else if (tipo == ConstantesModule.CodigoPalanca.PN) {
            lista = ConstantesModule.KeysLocalStorage.PackNuevas;
        }
        else if (tipo == ConstantesModule.CodigoPalanca.DP) {
            lista = ConstantesModule.KeysLocalStorage.DuoPerfecto;
        }
        //FIN HD-3908
        if (lista == "") {
            return;
        }

        $.each(listaCuv, function (ind, cuvItem) {
            var cuvx = cuvItem.split(';')[0];
            ok = ActualizarLocalStorageIsAgregado(cuvx, valor, lista, indCampania);
            ActualizaCuvAgregado(cuvx, valor, lista, indCampania);
        });

    } catch (e) {
        console.log(e);
    }
    return ok;
}

function ActualizaCuvAgregado(cuv, valor, lista, indCampania) {
    if (typeof filtroCampania !== "undefined") {
        var listaPalanca = filtroCampania[lista + indCampania];
        if (listaPalanca !== undefined) {
            $.each(listaPalanca.response.lista, function (index, item) {
                if (item.CUV2 == cuv || cuv == "todo") {
                    if (item.ClaseBloqueada !== "" && valor === true) {
                        item.IsAgregado = false;
                    }
                    else {
                        item.IsAgregado = valor;
                    }

                    if (cuv != "todo") {
                        return false;
                    }
                }
            });
        }
        filtroCampania[lista + indCampania] = listaPalanca;
    }
}

function ActualizarLocalStorageIsAgregado(cuv, valor, lista, indCampania) {
    var ok = false;

    var valLocalStorage = localStorage.getItem(lista + campaniaCodigo);

    if (valLocalStorage != null) {
        var data = JSON.parse(valLocalStorage);

        ok = actualizarIsAgregado(data.response.listaLan, cuv, valor);
        ok = ok || actualizarIsAgregado(data.response.lista, cuv, valor);

        if (ok) {
            localStorage.setItem(lista + campaniaCodigo, JSON.stringify(data));
        }
    }

    return ok;
}

function actualizarIsAgregado(lista, cuv, valor) {
    var ok = false;

    if (lista !== undefined) {
        $.each(lista, function (index, item) {
            if (item.CUV2 == cuv || cuv == "todo") {
                if (item.ClaseBloqueada !== "" && valor === true) {
                    item.IsAgregado = false;
                }
                else {
                    item.IsAgregado = valor;
                }

                ok = true;
                if (cuv != "todo") {
                    return false;
                }
            }
        });
    }

    return ok;
}

function RDActualizarTipoAccionAgregar(revistaDigital, key) {
    var valLocalStorage = LocalStorageListado(key, null, 1);
    if (valLocalStorage == null)
        return false;

    valLocalStorage = JSON.parse(valLocalStorage);

    $.each(valLocalStorage.response.listaPerdio, function (ind, item) {
        if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            item.TipoAccionAgregar = 5;
        if (!revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            item.TipoAccionAgregar = 4;
    });

    LocalStorageListado(key, valLocalStorage, 0);
}