var TuVozOnlineView = (function () {
    var me = {};

    var _elementos = {
        campoCorreoElectronico: '#NuevoCorreo',
        campoCorreoActualizado: '#correoActualizado',
        actualizarMail: '#btnActualizarMail',
        reenviarCorreo: '#btnReenviarCorreo',
        cambiarCorreo: '#btnCambiarCorreo',
        vistaIngresoEmail: '#VistaIngresoCorreo',
        vistaConfirmacion: '#VistaConfirmacionCorreo'
    };
    var _funciones = {
        InicializarEventos: function() {
            $(document).on("keyup", _elementos.campoCorreoElectronico, _eventos.CampoConDatos);
            $(document).on("click", _elementos.actualizarMail, _eventos.actualizarEmail);
            $(document).on("click", _elementos.reenviarCorreo, _eventos.actualizarEmail);
            $(document).on("click", _elementos.reenviarCorreo, _eventos.actualizarEmail);
            $(document).on("click", _elementos.cambiarCorreo, _eventos.cambiarCorreo);
        }
    };
    var _eventos = {
        CampoConDatos: function (e) {
            var campoDatos = $(this).val();
            if (campoDatos) {
                $(this).addClass('text__field__sb--withContent');
            } else {
                $(this).removeClass('text__field__sb--withContent');
            }
        },
        actualizarEmail: function() {
            me.actualizarCorreoService.actualizarEnviarCorreo(function () {
                var email = $(_elementos.campoCorreoElectronico).html();
                $(_elementos.campoCorreoActualizado).html(email);
                $(_elementos.vistaIngresoEmail).hide();
                $(_elementos.vistaConfirmacion).show();
            });
        },
        cambiarCorreo: function() {
            $(_elementos.vistaConfirmacion).hide();
            $(_elementos.vistaIngresoEmail).show();
            $(_elementos.campoCorreoElectronico).html('');
            $(_elementos.campoCorreoElectronico).focus();
        }
    }

    //Public functions
    function Inicializar(mailService) {
        me.actualizarCorreoService = mailService;
        _funciones.InicializarEventos();

        var inputEmail = document.getElementById('NuevoCorreo');
        FuncionesGenerales.AvoidingCopyingAndPasting('NuevoCorreo');
        FuncionesGenerales.AutoCompletarEmailAPartirDeArroba(inputEmail);
    }

    return {
        Inicializar: Inicializar
    };

})();
