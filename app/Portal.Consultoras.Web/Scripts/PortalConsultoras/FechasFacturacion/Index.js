var FechasFacturacionView = (function () {
    var _elementos = {
        tab: ".nav__tab__sb__link--fechasFacturacion",
        claseTabActivo: "nav__tab__sb__link--active",
        tabContenido: ".tab__content__sb"
    };

    var _funciones = {
        InicializarEventos: function () {
            $(document).on("click", _elementos.tab, _eventos.mostrarContenidoTabCorrespondiente);
            _eventos.ocultarSinotieneDatos;
        }
    };

    var _eventos = {
        mostrarContenidoTabCorrespondiente: function (e) {
            e.preventDefault();
            var idTab = $(this).attr("href");
            $(_elementos.tab).removeClass(_elementos.claseTabActivo);
            $(this).addClass(_elementos.claseTabActivo);
            $(_elementos.tabContenido).fadeOut(100);
            setTimeout(function () {
                $(idTab).fadeIn(100);
            }, 150);
        },

        ocultarSinotieneDatos: function () {

            if (tieneAnteriores == 0) {
                $('#li-tab-anterior').hide();
            }
            if (tieneProximas == 0) {
                $('#li-tab-proximo').hide();
            }
        }
    };





    function Inicializar() {
        _funciones.InicializarEventos();
    }

    return {
        Inicializar: Inicializar
    }

})();

$(document).ready(function () {
    FechasFacturacionView.Inicializar();
});