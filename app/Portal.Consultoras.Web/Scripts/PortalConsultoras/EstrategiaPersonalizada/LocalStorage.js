﻿
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
    var listaProd = sl.response.listaLan.Find("CUV2", cuv) || new Array();
    if (listaProd.length == 0) {
        listaProd = sl.response.lista.Find("CUV2", cuv) || new Array();
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

        if (tipo == "" || tipo == undefined) {
            return false;
        }
        if (cuv == "" || cuv == undefined) {
            return false;
        }
        if (valor == undefined) {
            return false;
        }

        if (tipo == "rd") {
            var listaCuv = cuv.split('|');
            $.each(listaCuv, function (ind, cuvItem) {
                var cuvx = cuvItem.split(';')[0];
                var lista = "ListaRD";
                var indCampania = indCampania || 0;

                ok = ActualizarLocalStorageIsAgregado(cuvx, valor, lista, indCampania);
            });
        }

        if (tipo == "gn") {
            var listaCuv = cuv.split('|');
            $.each(listaCuv, function (ind, cuvItem) {
                var cuvx = cuvItem.split(';')[0];
                var lista = "GNDLista";
                var indCampania = indCampania || 0;

                ok = ActualizarLocalStorageIsAgregado(cuvx, valor, lista, indCampania);
            });
        }
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

        ok = actualizarIsAgregado(data.response.listaLan, cuv, valor);

        if (!ok) {
            ok = actualizarIsAgregado(data.response.lista, cuv, valor);
        }

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
                item.IsAgregado = valor;
                ok = true;
                if (cuv != "todo") {
                    return false;
                }
            }
        });
    }

    return ok
}