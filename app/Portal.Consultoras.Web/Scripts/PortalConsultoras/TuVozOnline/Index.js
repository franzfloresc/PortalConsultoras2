var TuVozOnlineView = (function () {

    var _elementos = {
        campoCorreoElectronico: '#CorreoElectronicoCampo'
    };
    var _funciones = {
        InicializarEventos: function() {
            $(document).on("keyup", _elementos.campoCorreoElectronico, _eventos.CampoConDatos);
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
        }
    }

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
    }

    return {
        Inicializar: Inicializar
    };

})();

$(document).ready(function () {
    TuVozOnlineView.Inicializar();
});