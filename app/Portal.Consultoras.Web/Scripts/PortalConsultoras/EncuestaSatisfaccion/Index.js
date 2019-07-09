var EncuestaSatisfaccion = (function () {

    var _elementos = {
        encuestaSatisfaccion: "#EncuestaSatisfaccion",
        estadoEncuestaSatisfaccion: ".encuesta__satisfaccion__estado__enlace",
        motivosCalificacion: ".seccion__encuesta__satisfaccion__motivosCalificacion"
    };

    //var _config = {

    //};

    var _funciones = {
        InicializarEventos: function () {
            $(document).on("click", _elementos.estadoEncuestaSatisfaccion, _eventos.mostrarMotivosCalificacion);
        }
    };

    var _eventos = {
        mostrarMotivosCalificacion: function (e) {
            e.preventDefault();
            $(this).parents(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion__expandir');
            $(_elementos.estadoEncuestaSatisfaccion).parents('.encuesta__satisfaccion__estado').addClass('encuesta__satisfaccion__disabled');
            $(this).parents('.encuesta__satisfaccion__estado').removeClass('encuesta__satisfaccion__disabled');
            if (!$(_elementos.motivosCalificacion).is(':visible')) {
                $(_elementos.motivosCalificacion).show();
                $(_elementos.motivosCalificacion).delay(300);
                $(_elementos.motivosCalificacion).animate({
                    'opacity': 1,
                    'top': 0
                }, 350);
            }
        }
    };

    function Inicializar() {
        _funciones.InicializarEventos();
    }

    return {
        Inicializar: Inicializar
    };

})();

$(document).ready(function () {

    EncuestaSatisfaccion.Inicializar();

});