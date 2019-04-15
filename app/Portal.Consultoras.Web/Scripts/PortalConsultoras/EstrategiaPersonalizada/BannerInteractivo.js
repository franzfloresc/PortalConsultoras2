var BannerInteractivo = (function () {
    'use strict';
    var ConstanteUrl = {
        ValidaExisteTipoEstrategiaEnPedido: '/Pedido/ValidaExisteTipoEstrategiaEnPedido'
        //Landing: '/ArmaTuPack/Detalle'
    };

    var _fnMensaje = function (fn) {
        messageConfirmacion(
            '¿Quieres eliminar el pack que tienes y empezar de nuevo?',
            'Recuerda que solo puedes armar 1 pack',
            fn
        );
    }
    var _fnValidaExisteTipoEstrategiaEnPedido = function () {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: ConstanteUrl.ValidaExisteTipoEstrategiaEnPedido,
            data: JSON.stringify({
                te: ConstantesModule.CodigoPalanca.ATP
            }),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: false
        });
        promise.done(function (response) {
            d.resolve(response);
        });
        promise.fail(d.reject);

        return d.promise();
    }

    var fnConsultaRedireccionaLanding = function (objeto) {
        var popup = $(objeto).data('popup');
        var landing = $(objeto).data('landing');
        var url = baseUrl + landing;

        if (popup) {
            _fnMensaje(function () {
                window.location.href = url;
            });
        }
        else {
            window.location.href = url;
        }
    };
    var fnConsultaAjaxRedireccionaLanding = function (fn) {
        var promesa = _fnValidaExisteTipoEstrategiaEnPedido();

        var resultado = false;

        $.when(promesa)
            .then(function (response) {
                if (response.TienePedido) {
                    _fnMensaje(fn);
                    resultado = true;
                }
            });

        if (!resultado) {
            fn();
        }

        return resultado;
    };

    return {
        ConsultaRedireccionaLanding: fnConsultaRedireccionaLanding,
        ConsultaAjaxRedireccionaLanding: fnConsultaAjaxRedireccionaLanding
    };
})();