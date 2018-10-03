var BusquedaProductoModule = (function () {

    var _elementos = {
       body: "body",
        opcionOrdenar: "#dpw-ordenar",
       footer: "footer",
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
                _funciones.ProcesarListaProductos(data.productos);
            }).fail(function(data, error) {
                console.error(error.toString());
            });
        },
        ProcesarListaProductos: function(productos) {
            $.each(productos, function (index, item) {
                item.posicion = index + 1;
                if (item.Descripcion.length > _config.maxCaracteresDesc) {
                    item.Descripcion = item.Descripcion.substring(0, _config.maxCaracteresDesc) + "...";
                }
                console.log(item.Descripcion);
            });
            // setear handlebar aqui lista data.productos
        },
        ValidarScroll: function() {
            var footerH = $(window).scrollTop() + $(window).height();
            footerH += $(_elementos.footer).innerHeight() || 0;
            return footerH >= $(document).height();
        }
        
    };
    var _eventos = {
    	Ordenar: function () {
            var dpw_ordenar = document.getElementById('dpw-ordenar');
            dpw_ordenar.classList.toggle(_elementos.desplegado);

            var ul_ordenar = document.getElementById('ul-ordenar');
            ul_ordenar.classList.toggle('d-none');
        },

        ClickOrdenar: function () {
            _config.ordenCampo = "";
            _config.ordenTipo = "";
            _config.numeroPaginaActual = 0;
            
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    _funciones.ProcesarListaProductos(data.productos);
                }).fail(function (data, error) {
                    console.error(error.toString());
                });
            
        },
        ScrollPage: function () {
            console.log("Scroll page" + _config.totalProductos);
            _config.numeroPaginaActual = 0;
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    _funciones.ProcesarListaProductos(data.productos);
                }).fail(function (data, error) {
                    console.error(error.toString());
                });
        }
    };

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        _funciones.CargarProductos();
    }

    function ScrollPagina() {
        if (_funciones.ValidarScroll()) {
          //  _eventos.ScrollPage();
        }
    }

    return {
        Inicializar: Inicializar,
        ScrollPagina: ScrollPagina
    };
})();

$(document).ready(function () {

    BusquedaProductoModule.Inicializar();

    $(window).scroll(function () {
        BusquedaProductoModule.ScrollPagina();
    });

    $(window).scroll();
});