var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        textBusqueda: function () { return $('.textoProductoBuscado') },
        totalProducto: function () { return $('.totalProductosEncontrados') }
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

        },
        ConstruirModeloBusqueda: function () {
            var texto = _elementos.textBusqueda().val();
            //Para el caso de la cantidad de productos se esta poniendo en duro TotalResultadosBuscador, variable declara en el layout
            var modelo = {
                TextoBusqueda: texto,
                Paginacion: {
                    Cantidad: TotalResultadosBuscador,
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
                .done(function (data) {
                    console.log(data);
                    $.each(data, function (index, item) {
                        item.posicion = index + 1;
                        //if (item.Descripcion.length > TotalCaracteresEnListaBuscador) {
                        //    item.Descripcion = item.Descripcion.substring(0, TotalCaracteresEnListaBuscador) + "...";
                        //}
                        console.log(item.toString());
                    });
                }).fail(function (data, error) {
                    console.error(error.toString());
                });
        }
    };
    var _eventos = {
        Ordenar: function () {

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