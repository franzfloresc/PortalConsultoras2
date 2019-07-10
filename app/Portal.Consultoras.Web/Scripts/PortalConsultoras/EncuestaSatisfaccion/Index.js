var EncuestaSatisfaccion = (function () {

    var _elementos = {
        encuestaSatisfaccion: "#EncuestaSatisfaccion",
        estadoEncuestaSatisfaccion: ".encuesta__satisfaccion__estado__enlace",
        motivosCalificacion: ".seccion__encuesta__satisfaccion__motivosCalificacion",
        enlaceCerrarEncuestaSatisfaccion: ".enlace__cerrar__encuesta__satisfaccion",
        enlaceVolverAtras: ".enlace__volver__atras__encuesta__satisfaccion"
    };

    var _config = {

    };

    var _funciones = {
        InicializarEventos: function () {
            $(document).on("click", _elementos.estadoEncuestaSatisfaccion, _eventos.mostrarMotivosCalificacion);
            $(document).on("click", _elementos.enlaceVolverAtras, _eventos.volverAtras);
            $(document).on("click", _elementos.enlaceCerrarEncuestaSatisfaccion, _eventos.cerrarEncuestaSatisfaccion);
        }
    };

    var _eventos = {
        mostrarMotivosCalificacion: function (e) {
            e.preventDefault();
            $(_elementos.enlaceCerrarEncuestaSatisfaccion).fadeOut(100);
            $(_elementos.enlaceVolverAtras).fadeIn(100);
            $(this).parents(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion__expandir');
            $(_elementos.estadoEncuestaSatisfaccion).parents('.encuesta__satisfaccion__estado').addClass('encuesta__satisfaccion__disabled');
            $(this).parents('.encuesta__satisfaccion__estado').removeClass('encuesta__satisfaccion__disabled');
            if (!$(_elementos.motivosCalificacion).is(':visible')) {
                $(_elementos.motivosCalificacion).show();
                $(_elementos.motivosCalificacion).delay(280);
                $(_elementos.motivosCalificacion).animate({
                    'opacity': 1,
                    'top': 0
                }, 300);
            }
        },
        volverAtras: function (e) {
            e.preventDefault();
            $(_elementos.motivosCalificacion).animate({
                'opacity': 0,
                'top': -30
            }, 350);
            $(_elementos.motivosCalificacion).hide();
            $(_elementos.estadoEncuestaSatisfaccion).parents('.encuesta__satisfaccion__estado').removeClass('encuesta__satisfaccion__disabled');
            $(_elementos.enlaceVolverAtras).fadeOut(100);
            $(this).parents(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion__expandir');
            $(_elementos.enlaceCerrarEncuestaSatisfaccion).fadeIn(100);
        },
        cerrarEncuestaSatisfaccion: function (e) {
            e.preventDefault();
            $(_elementos.encuestaSatisfaccion).animate({
                'bottom': -138 + 'px',
                'opacity': 0
            }, 350);
            $(_elementos.encuestaSatisfaccion).delay(380);
            $(_elementos.encuestaSatisfaccion).fadeOut(100);
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