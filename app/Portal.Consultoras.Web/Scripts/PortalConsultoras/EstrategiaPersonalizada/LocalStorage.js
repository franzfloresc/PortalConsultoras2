
function LocalStorageListado(key, valor, accion) {
    // accion => 0 insertar => 1 obtener => 2 eliminar
    accion = accion || 0;

    if (accion == 0) {
        if (valor != undefined) {
            localStorage.setItem(key, valor);
        }
    }
    else if (accion == 1) {
        return localStorage.getItem(key);
    }

    if (accion == 3) {
        localStorage.removeItem(key);
    }
}

function GetProductoStorage(cuv, campania) {
    var sl = LocalStorageListado(lsListaRD + campania, '', 1);
    if (sl == null || sl == undefined) {
        var model = CargarEstrategiaCuv(cuv);
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
