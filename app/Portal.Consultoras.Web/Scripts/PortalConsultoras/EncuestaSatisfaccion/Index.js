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
            $(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion--ocultar');
            $(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion--mostrar');
        }
    };

    var _eventos = {
        mostrarMotivosCalificacion: function (e) {
            e.preventDefault();
            $(_elementos.enlaceCerrarEncuestaSatisfaccion).fadeOut(100);
            $(_elementos.enlaceVolverAtras).fadeIn(100);
            $(this).parents(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion__expandir');
            $(_elementos.estadoEncuestaSatisfaccion).addClass('encuesta__satisfaccion__disabled');
            $(this).removeClass('encuesta__satisfaccion__disabled');
            if (!$(_elementos.motivosCalificacion).is(':visible')) {
                $(_elementos.motivosCalificacion).show();
                $(_elementos.motivosCalificacion).addClass('seccion__encuesta__satisfaccion__motivosCalificacion--mostrar');
            }
        },
        volverAtras: function (e) {
            e.preventDefault();
            $(_elementos.motivosCalificacion).removeClass('seccion__encuesta__satisfaccion__motivosCalificacion--mostrar');
            $(_elementos.motivosCalificacion).hide();
            $(_elementos.estadoEncuestaSatisfaccion).removeClass('encuesta__satisfaccion__disabled');
            $(_elementos.enlaceVolverAtras).fadeOut(100);
            $(this).parents(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion__expandir');
            $(_elementos.enlaceCerrarEncuestaSatisfaccion).fadeIn(100);
        },
        cerrarEncuestaSatisfaccion: function (e) {
            e.preventDefault();
            $(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion--mostrar');
            $(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion--ocultar');
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