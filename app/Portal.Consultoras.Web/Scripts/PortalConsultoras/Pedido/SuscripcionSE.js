
function ValidarSuscripcionSE(fnSuccess) {
 jQuery.ajax({
        type: 'POST',
        url: urlValidarSuscripcionSE,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;

            if (!data.success) messageInfo('Ocurrió un error al intentar cargar los pedidos exclusivos para Socia Empresaria.');
            else if ($.isFunction(fnSuccess)) fnSuccess();
        },
        error: function () { messageInfo('Ocurrió un error de conexion al intentar cargar los pedidos exclusivos para Socia Empresaria.'); }
    });
}

function ValidarSuscripcionSEPromise() {
    var d = $.Deferred();
    var promise = jQuery.ajax({
        type: 'POST',
        url: urlValidarSuscripcionSE,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        error: function () { messageInfo('Ocurrió un error de conexion al intentar cargar los pedidos exclusivos para Socia Empresaria.'); }
    });

    promise.done(function (data) {
        if (!checkTimeout(data)) return false;
        if (!data.success) messageInfo('Ocurrió un error al intentar cargar los pedidos exclusivos para Socia Empresaria.');
    });
    promise.fail(function (data, error) {
        console.error(error.toString());
        messageInfo('Ocurrió un error de conexion al intentar cargar los pedidos exclusivos para Socia Empresaria.');
    });
    return d.promise();
}
