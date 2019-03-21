var BannerInteractivo = (function () {
    'use strict';

    var fnConsultaRedireccionaLanding = function (objeto) {
        var popup = $(objeto).data('popup');
        var landing = $(objeto).data('landing');
        var url = baseUrl + landing;

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
})();