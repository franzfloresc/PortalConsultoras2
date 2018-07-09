﻿var LocalStorageModule = (function() {
    'use strict';
    var _codigoPalanca = ConstantesModule.CodigosPalanca;

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
        //localStorageItem.CantMostrados = 15;
        //localStorageItem.CantTotal = 0;
        //localStorageItem.Completo = 0;
        //localStorageItem.ListaFiltro = [];
        //localStorageItem.Ordenamiento = { Tipo: "" };
        //localStorageItem.Palanca = "";
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

    var ObtenerEstrategia = function(cuv, campania, palanca) {
        try {
            
            var nombreKey = _obtenerKey(palanca, campania);

            if (IsNullOrEmpty(nombreKey)) throw "Palanca no tiene asignado key local storage.";

            if (!_existeItem(nombreKey)) _cargarEstrategias(campania, palanca, nombreKey);

            var listaLocalStorage = JSON.parse(localStorage.getItem(nombreKey));

            return _buscarEstrategiaPorCuv(cuv, palanca, listaLocalStorage);
            
        } catch (e) {
           console.error("error al cargar productos de local storage : " + e);
        } 
         return null;
    }
    
    return{
        ObtenerEstrategia: ObtenerEstrategia
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
        if (tipo == "rd") {
            var lista = "RDLista";
        }
        else if (tipo == "gn") {
            var lista = "GNDLista";
        }
        else if (tipo == "hv") {
            var lista = "HVLista";
        }
        else if (tipo == "lan") {
            var lista = "LANLista";
        }

        $.each(listaCuv, function (ind, cuvItem) {
            var cuvx = cuvItem.split(';')[0];
            ok = ActualizarLocalStorageIsAgregado(cuvx, valor, lista, indCampania);
        });

    } catch (e) {
        console.log(e);
    }
    return ok;
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