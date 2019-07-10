var EncuestaSatisfaccion = (function () {

    var _elementos = {
        encuestaSatisfaccion: "#EncuestaSatisfaccion",
        estadoEncuestaSatisfaccion: ".encuesta__satisfaccion__estado__enlace",
        motivosCalificacion: ".seccion__encuesta__satisfaccion__motivosCalificacion",
        enlaceCerrarEncuestaSatisfaccion: ".enlace__cerrar__encuesta__satisfaccion",
        btnConfirmar: "#btnConfirmaMotivo"
    };

    var _config = {

    };

    var _funciones = {
        InicializarEventos: function () {
            $(document).on("click", _elementos.estadoEncuestaSatisfaccion, _eventos.abrirEncuestaSatisfaccionConMotivosCalificacion);
            $(document).on("click", _elementos.enlaceCerrarEncuestaSatisfaccion, _eventos.cerrarEncuestaSatisfaccion);
            $(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion--ocultar');
            $(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion--mostrar');
        },
        mostrarMotivosCalificacionSegunEstado: function (e) {
            $(_elementos.motivosCalificacion).removeClass('seccion__encuesta__satisfaccion__motivosCalificacion--mostrar');
            $(_elementos.motivosCalificacion).fadeOut(15);
            $(_elementos.motivosCalificacion).fadeIn(15);
            $(_elementos.motivosCalificacion).addClass('seccion__encuesta__satisfaccion__motivosCalificacion--mostrar');
        }
    };

    var _eventos = {
        abrirEncuestaSatisfaccionConMotivosCalificacion: function (e) {
            e.preventDefault();
            if (!$(_elementos.encuestaSatisfaccion).is('.seccion__encuesta__satisfaccion__expandir')) {
                $(this).parents(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion__expandir');
                $(_elementos.btnConfirmar).fadeIn(100);
            }
            $(_elementos.estadoEncuestaSatisfaccion).addClass('encuesta__satisfaccion__disabled');
            $(this).removeClass('encuesta__satisfaccion__disabled');
            _funciones.mostrarMotivosCalificacionSegunEstado();
        },
        cerrarEncuestaSatisfaccion: function (e) {
            e.preventDefault();
            $(_elementos.btnConfirmar).fadeOut(100);
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