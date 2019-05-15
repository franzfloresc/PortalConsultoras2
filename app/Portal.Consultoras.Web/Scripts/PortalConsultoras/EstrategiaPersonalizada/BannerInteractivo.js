var BannerInteractivo = (function () {
    'use strict';
    var ConstanteUrl = {
        ValidaExisteTipoEstrategiaEnPedido: '/Pedido/ValidaExisteTipoEstrategiaEnPedido'
        //Landing: '/ArmaTuPack/Detalle'
    };

    var fnCancelar = function () {
        
        var codigoubigeoPortal = $('#ATP').attr('data-codigoubigeoportal') + "";
        if (!(typeof AnalyticsPortalModule === 'undefined')) 
            if (codigoubigeoPortal === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPackGuion) 
                AnalyticsPortalModule.MarcaPromotionClickArmaTuPack(codigoubigeoPortal, "Cancelar", "Pop up Modifica tu Pack" );
        
    };

    var _fnMensaje = function (fn) {
         
        messageConfirmacion(
            '¿Quieres eliminar el pack que tienes y empezar de nuevo?',
            'Recuerda que solo puedes armar 1 pack',
            fn, fnCancelar
        );
    }
    var _fnValidaExisteTipoEstrategiaEnPedido = function () {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: ConstanteUrl.ValidaExisteTipoEstrategiaEnPedido,
            data: JSON.stringify({
                te: ConstantesModule.TipoEstrategia.ArmaTuPack
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
        
        fnLunchAnalytics($(objeto));
        if (popup) {
            _fnMensaje(function () {
                           
                //**ANALYTICS**//
                //console.log('analytic2-aceptar [banner interactivo] ANT');
                var codigoubigeoPortal = $('#ATP').attr('data-codigoubigeoportal') + "";
                if (!(typeof AnalyticsPortalModule === 'undefined'))
                    if (codigoubigeoPortal === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPackGuion) 
                        AnalyticsPortalModule.MarcaPromotionClickArmaTuPack(codigoubigeoPortal, "Aceptar", "Pop up Modifica tu Pack");



                window.location.href = url;
            });
        }
        else {
            window.location.href = url;
        }
    };
    var fnLunchAnalytics = function (obj) {
        
        var codigoubigeoPortal = $('#ATP').attr('data-codigoubigeoportal')+ "";
        
        if (codigoubigeoPortal !== "")
            if (!(typeof AnalyticsPortalModule === 'undefined')) {
                if (codigoubigeoPortal === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPackGuion) {
                    var textButton = $('button.atp_button').text();
                    AnalyticsPortalModule.MarcaPromotionClickArmaTuPack(codigoubigeoPortal, textButton, "Click Botón");
                    AnalyticsPortalModule.MarcaPromotionViewArmaTuPack(codigoubigeoPortal, textButton == "Comienza", true);
                }
            }
    }
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