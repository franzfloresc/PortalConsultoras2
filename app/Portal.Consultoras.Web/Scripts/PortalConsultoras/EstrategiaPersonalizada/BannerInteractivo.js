var BannerInteractivo = (function () {
    'use strict';

    var fnConsultaRedireccionaLanding = function (objeto) {
        var popup = $(objeto).data('popup'),
            landing = $(objeto).data('landing'),
            //cuv = $(objeto).data('cuv'),
            url = baseUrl + landing;// + '/' + cuv

        if (popup) {
            messageConfirmacion(
                '¿Quieres eliminar el que tenías y empezar de nuevo?',
                'Recuerda que solo puedes armar 1 pack',
                function () {
                    window.location.href = url;
                }
            );
        }
        else {
            window.location.href = url;
        }
    };

    return {
        ConsultaRedireccionaLanding: fnConsultaRedireccionaLanding
    };
});