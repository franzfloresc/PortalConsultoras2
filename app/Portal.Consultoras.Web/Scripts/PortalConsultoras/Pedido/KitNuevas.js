﻿
function ValidarKitNuevas(fnSuccess) {
    jQuery.ajax({
        type: 'POST',
        url: urlValidarKitNuevas,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;

            if (!data.success) AbrirMensaje('Ocurrió un error al intentar cargar el Kit de Nuevas.');
            else if ($.isFunction(fnSuccess)) fnSuccess();
        },
        error: function () { AbrirMensaje('Ocurrió un error de conexion al intentar cargar el Kit de Nuevas.'); }
    });
}
