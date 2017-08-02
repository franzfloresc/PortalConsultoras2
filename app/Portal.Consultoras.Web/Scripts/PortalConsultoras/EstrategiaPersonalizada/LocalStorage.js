
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
        var model = EstrategiaCargarCuv(cuv);
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
        cuv = $.trim(cuv);
        if (tipo == "rd") {
            if (cuv == "" || valor == undefined) {
                return false;
            }
           
            var listaCuv = cuv.split('|');
            $.each(listaCuv, function (ind, cuvItem) {
                var cuvx = cuvItem.split(';')[0];
                ok = RDActualizarLocalStorageAgragado(cuvx, valor);
            });
            
        }
    } catch (e) {
        console.log(e);
    }
    return ok;
}

function RDActualizarLocalStorageAgragado(cuv, valor) {
    var ok = false;
    cuv = $.trim(cuv);
    var lsListaRD = lsListaRD || "ListaRD";
    var indCampania = indCampania || 0;
    var valLocalStorage = localStorage.getItem(lsListaRD + campaniaCodigo);
    if (valLocalStorage != null) {
        var data = JSON.parse(valLocalStorage);

        $.each(data.response.listaLan, function (ind, item) {
            if (item.CUV2 == cuv || cuv == "todo") {
                item.IsAgregado = valor;
                if (cuv != "todo") {
                    ok = true;
                    return false;
                }
            }
        });

        if (!ok) {
            $.each(data.response.lista, function (ind, item) {
                if (item.CUV2 == cuv || cuv == "todo") {
                    item.IsAgregado = valor;
                    if (cuv != "todo") {
                        ok = true;
                        return false;
                    }
                }
            });
        }

        if (cuv == "todo") {
            ok = true;
        }

        if (ok) {
            localStorage.setItem(lsListaRD + campaniaCodigo, JSON.stringify(data));
        }
    }
    return ok;
}