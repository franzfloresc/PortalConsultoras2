
function ValidarSuscripcionSE(fnSuccess,isMobile) {

    ShowCarga(isMobile);
   jQuery.ajax({
        type: 'POST',
        url: urlValidarSuscripcionSE,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;

            if (!data.success) messageInfo('Ocurrió un error al intentar cargar los pedidos exclusivos para Socia Empresaria.');
            else if ($.isFunction(fnSuccess)) fnSuccess();
            ShowCarga(isMobile);
        },
       error: function () { messageInfo('Ocurrió un error de conexion al intentar cargar los pedidos exclusivos para Socia Empresaria.'); ShowCarga(isMobile);}
    });
    
}

function ShowCarga(isMobile) {
    if (!isMobile) AbrirSplash();
}
function HideCarga(isMobile) {
    if (!isMobile) CerrarSplash();
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
