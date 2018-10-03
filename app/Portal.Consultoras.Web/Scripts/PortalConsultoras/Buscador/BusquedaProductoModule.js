var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        opcionOrdenar: "#dpw-ordenar",
        desplegado: "opcion__ordenamiento__dropdown--desplegado"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,

    };
    var _provider = {
        BusquedaProductoPromise: function (params) {
            var dfd = jQuery.Deferred();

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "Buscador/BusquedaProductos",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                cache: false,
                success: function (data) {
                    dfd.resolve(data);
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

            return dfd.promise();
        }
    }
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
            $(document).on("click", _elementos.opcionOrdenar, _eventos.Ordenar);
        },
        ConstruirModeloBusqueda: function() {
            var modelo = {
                TextoBusqueda: "lab",
                Paginacion: {
                    Cantidad: 20,
                    NuemroPagina: 0
                },
                Orden: {
                    Campo: "Orden",
                    Tipo: "Desc"
                }
            }
            return modelo;
        },
        CargarProductos: function () {
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
            .done(function(data) {
                $.each(data, function (index, item) {
                    item.posicion = index + 1;
                    //if (item.Descripcion.length > TotalCaracteresEnListaBuscador) {
                    //    item.Descripcion = item.Descripcion.substring(0, TotalCaracteresEnListaBuscador) + "...";
                    //}
                    console.log(item.toString());
                });
            }).fail(function(data, error) {
                    console.error(error.toString());
            });
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
        _funciones.CargarProductos();
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