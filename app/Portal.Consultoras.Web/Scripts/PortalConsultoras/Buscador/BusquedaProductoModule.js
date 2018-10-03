var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        textBusqueda: function () { return $('.textoProductoBuscado') },
        totalProducto: function () { return $('.totalProductosEncontrados') }
        opcionOrdenar: "#dpw-ordenar",
        spanTotalProductos: "#TotalProductos"
        desplegado: "opcion__ordenamiento__dropdown--desplegado"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        textoBusqueda: textoBusqueda,
        totalProductos: 0,
        totalPaginas: 0,
        productosPorPagina: 20,
        numeroPaginaActual: 0,
        ordenCampo: "orden",
        ordenTipo: "desc",
        maxCaracteresDesc: TotalCaracteresEnListaBuscador
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
                TextoBusqueda: _config.textoBusqueda,
                Paginacion: {
                    Cantidad: _config.productosPorPagina,
                    NuemroPagina: _config.numeroPaginaActual
                },
                Orden: {
                    Campo: _config.ordenCampo,
                    Tipo: _config.ordenTipo
                }
            }
            return modelo;
        },
        CargarProductos: function () {

            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
            .done(function (data) {
                _config.totalProductos = data.total;
                $(_elementos.spanTotalProductos).html(data.total);
                $.each(data.productos, function (index, item) {
                    item.posicion = index + 1;
                    if (item.Descripcion.length > _config.maxCaracteresDesc) {
                        item.Descripcion = item.Descripcion.substring(0, _config.maxCaracteresDesc) + "...";
                    }
                    console.log(item.Descripcion);
                    });
                
                // setear handlebar aqui lista data.productos
                }).fail(function (data, error) {
                console.error(error.toString());
                });
            
        }
    };
    var _eventos = {
        Ordenar: function () {
            var dpw_ordenar = document.getElementById('dpw-ordenar');
            dpw_ordenar.classList.toggle(_elementos.desplegado);

            var ul_ordenar = document.getElementById('ul-ordenar');
            ul_ordenar.classList.toggle('d-none');
        }
    };

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        _funciones.CargarProductos();
    }

    function MostrarProductos() {
        console.log("Scroll page" + _config.totalProductos);
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