var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        opcionOrdenar: "#dpw-ordenar",
        desplegado: "opcion__ordenamiento__dropdown--desplegado"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,

    };
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
            $(document).on("click", _elementos.opcionOrdenar, _eventos.Ordenar);
        },
        CargarProductos: function () {

        }
    };
    var _eventos = {
        Ordenar: function () {
            var element = document.getElementById('dpw-ordenar');
            element.classList.toggle(_elementos.desplegado);

            var element2 = document.getElementById('ul-ordenar');
            element2.classList.toggle('d-none');
        }
    };


    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
    }

    function MostrarProductos() {
        console.log("Scroll page");
    }

    return {
        Inicializar: Inicializar,
        MostrarProductos: MostrarProductos
    };
})();

$(document).ready(function () {

    BusquedaProductoModule.Inicializar();

    $(window).scroll(function () {
        BusquedaProductoModule.MostrarProductos();
    });

    $(window).scroll();
});