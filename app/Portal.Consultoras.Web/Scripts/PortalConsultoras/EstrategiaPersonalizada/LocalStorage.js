﻿var LocalStorageModule = (function() {
    'use strict';
    var _codigoPalanca = ConstantesModule.CodigosPalanca;
    var _constantesPalanca = ConstantesModule.ConstantesPalanca;
    var _tipoEstrategiaPalanca = ConstantesModule.TipoEstrategia;
    var _keyLocalStorage = ConstantesModule.KeysLocalStorage;

    var _urlObtenerEstrategia = ConstantesModule.UrlObtenerEstrategia;
    
    var _obtenerKey = function(palanca, campania) {
        switch (palanca) {
            case _codigoPalanca.RevistaDigital:
            case _codigoPalanca.OfertaParaTi:
            case _codigoPalanca.OfertasParaMi:
                return _keyLocalStorage.RevistaDigital + campania;
            case _codigoPalanca.GuiaDeNegocioDigitalizada:
                return _keyLocalStorage.GuiaDeNegocio + campania;
            case _codigoPalanca.Lanzamiento:
                return _keyLocalStorage.Lanzamiento + campania;
            case _codigoPalanca.HerramientasVenta:
                return _keyLocalStorage.HerramientasVenta + campania;
            case _codigoPalanca.Ganadoras:
                return _keyLocalStorage.Ganadoras + campania;

            default:
                return null;
        }
    }
    var _obtenerKeyName = function(codigoPalanaca, campania) {
        switch (codigoPalanaca) {
            case _constantesPalanca.RevistaDigital:
            case _constantesPalanca.OfertaParaTi:
            case _constantesPalanca.OfertasParaMi:
            case _constantesPalanca.PackAltoDesembolso:
                return _keyLocalStorage.RevistaDigital;
            case _constantesPalanca.GuiaDeNegocioDigitalizada:
                return _keyLocalStorage.GuiaDeNegocio;
            case _constantesPalanca.Lanzamiento:
                return _keyLocalStorage.Lanzamiento;
            case _constantesPalanca.HerramientasVenta:
                return _keyLocalStorage.HerramientasVenta;
        default:
            return null;
        }
    }

    var _obtenerKeyName2 = function (codigoPalanaca, campania) {
        switch (codigoPalanaca) {
            case _tipoEstrategiaPalanca.RD:
            case _constantesPalanca.RevistaDigital:
            case _constantesPalanca.OfertaParaTi:
            case _constantesPalanca.OfertasParaMi:
            case _constantesPalanca.PackAltoDesembolso:
                return _keyLocalStorage.RevistaDigital;
            case _tipoEstrategiaPalanca.GND:
            case _constantesPalanca.GuiaDeNegocioDigitalizada:
                return _keyLocalStorage.GuiaDeNegocio;
            case _tipoEstrategiaPalanca.LAN:
            case _constantesPalanca.Lanzamiento:
                return _keyLocalStorage.Lanzamiento;
            case _tipoEstrategiaPalanca.HV:
            case _constantesPalanca.HerramientasVenta:
                return _keyLocalStorage.HerramientasVenta;
            case _tipoEstrategiaPalanca.MG:
            case _constantesPalanca.MasGanadoras:
                return _keyLocalStorage.Ganadoras;
            default:
                return null;
        }
    }

    var _promiseObternerEstrategia = function (urlEstrategia, params) {
        var dfd = $.Deferred();

        $.ajax({
            type: "POST",
            url:urlEstrategia,
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
    }

    var _buscarEstrategiaPorCuv = function (cuv, palanca, listaLocalStorage) {
        var arrayEstrategia;

        if (palanca === _codigoPalanca.Lanzamiento) {
            arrayEstrategia = (listaLocalStorage.response.listaLan || []).Find("CUV2", cuv) || new Array();
        } else {
            arrayEstrategia = (listaLocalStorage.response.lista || []).Find("CUV2", cuv) || new Array();
        }

        if (arrayEstrategia.length > 0) return arrayEstrategia[0];
        else return null;
    }
    
    var _obtenerUrlEstrategia = function(palanca) {
        switch (palanca) {
            case _codigoPalanca.RevistaDigital:
            case _codigoPalanca.OfertasParaMi:
                return _urlObtenerEstrategia.OfertasParaMi;
            case _codigoPalanca.OfertaParaTi:
                return _urlObtenerEstrategia.OfertaParaTi;
            case _codigoPalanca.GuiaDeNegocioDigitalizada:
                return _urlObtenerEstrategia.GuiaDeNegocioDigitalizada;
            case _codigoPalanca.Lanzamiento:
                return _urlObtenerEstrategia.Lanzamiento;
            case _codigoPalanca.HerramientasVenta:
                return _urlObtenerEstrategia.HerrameintasVenta;
            default:
                return null;
        }
    }
    
    var _crearBaseEstrategiaItem = function (campania) {
        var localStorageItem = {}
        localStorageItem.CampaniaID = campania;
        localStorageItem.IsLoad = false;
        localStorageItem.UrlCargarProductos = "";
        localStorageItem.VarListaStorage = "";
        return localStorageItem;
    }
    
    var _cargarEstrategias = function (campania, palanca, nombreKey) {
        var localStorageItem = _crearBaseEstrategiaItem(campania);
        var param = {
            CampaniaID: campania,
            IsMobile: isMobile()
        };
        var urlEstrategia = _obtenerUrlEstrategia(palanca);
        _promiseObternerEstrategia(urlEstrategia, param).done(function (data) {
            localStorageItem.response = data;
            localStorageItem.UrlCargarProductos = urlEstrategia;
            localStorageItem.VarListaStorage = nombreKey;
            localStorage.setItem(nombreKey, JSON.stringify(localStorageItem));
        }).fail(function (data, error) {
            localStorageItem.response = {};
        });

        return true;
    }

    var _actualizarAgregado = function(lista, estrategiaId, valor) {
        var updated = false;
        if (lista !== undefined) {
            $.each(lista, function(index, estrategia) {
                if (estrategia.EstrategiaID === parseInt(estrategiaId)) {
                    estrategia.IsAgregado = valor;
                    updated =true;
                    return false;
                }
            });
        }  
        return updated;
    }
    
    var ObtenerEstrategia = function(cuv, campania, palanca) {
        try {
            
            var nombreKey = _obtenerKey(palanca, campania);

            if (IsNullOrEmpty(nombreKey))
                return null;

            if (!_existeItem(nombreKey)) _cargarEstrategias(campania, palanca, nombreKey);

            var listaLocalStorage = JSON.parse(localStorage.getItem(nombreKey));

            return _buscarEstrategiaPorCuv(cuv, palanca, listaLocalStorage);
            
        } catch (e) {
           console.error("error al cargar productos de local storage : " + e);
        } 
        return null;
    }
    
    var ActualizarCheckAgregado = function(estrategiaId, campania, codigoPalanaca, valor) {
        try {
            var nombreKey = _obtenerKeyName2(codigoPalanaca);
            var nombreKeyLocalStorage = nombreKey + campania;
            var valLocalStorage = localStorage.getItem(nombreKeyLocalStorage);

            if (valLocalStorage != null) {
                var data = JSON.parse(valLocalStorage);
                var updated;
                if (codigoPalanaca === _constantesPalanca.Lanzamiento || codigoPalanaca === _tipoEstrategiaPalanca.LAN)
                    updated = _actualizarAgregado(data.response.listaLan, estrategiaId,  valor);
                else 
                    updated = _actualizarAgregado(data.response.lista, estrategiaId, valor);
        
                if (updated) localStorage.setItem(nombreKeyLocalStorage, JSON.stringify(data));

                if (!updated && codigoPalanaca == "007") {
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
    }
    
    return{
        ObtenerEstrategia: ObtenerEstrategia,
        ActualizarCheckAgregado: ActualizarCheckAgregado
    }
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

    return new Object();
}

function ActualizarLocalStoragePalancas(cuv, valor) {
    ActualizarLocalStorageAgregado("RD", cuv, valor);
    ActualizarLocalStorageAgregado("GND", cuv, valor);
    ActualizarLocalStorageAgregado("HV", cuv, valor);
    ActualizarLocalStorageAgregado("LAN", cuv, valor);
    ActualizarLocalStorageAgregado("MG", cuv, valor);
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
        if (tipo == "RD") {
            var lista = "RDLista";
        }
        else if (tipo == "GND") {
            var lista = "GNDLista";
        }
        else if (tipo == "HV") {
            var lista = "HVLista";
        }
        else if (tipo == "LAN") {
            var lista = "LANLista";
        }
        else if (tipo == "MG") {
            var lista = "MGLista";
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

        ok = actualizarIsAgregado(data.response.listaLan, cuv,  valor);
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

    return ok
}

function RDActualizarTipoAccionAgregar(revistaDigital, key){
    var valLocalStorage = LocalStorageListado(key,null,1);
    if (valLocalStorage == null)
        return false;

    valLocalStorage = JSON.parse(valLocalStorage);

    $.each(valLocalStorage.response.listaPerdio, function(ind, item) {
        if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            item.TipoAccionAgregar = 5;
        if (!revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            item.TipoAccionAgregar = 4;
    });

    LocalStorageListado(key, valLocalStorage, 0);
}