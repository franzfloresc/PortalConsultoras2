var PopupRecepcionPedido = (function () {

    var _elementos = {
        camposPopupRecepcionPedido: '.text__field__sb'
    };
    var _funciones = {
        InicializarEventos: function () {
            $(document).on("blur", _elementos.camposPopupRecepcionPedido, _eventos.CampoConDatos);
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
    PopupRecepcionPedido.Inicializar();
});