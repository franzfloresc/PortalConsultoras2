﻿var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        opcionOrdenar: "#dpw-ordenar, .opcion__ordenamiento__label",
        footer: "footer",
        spanTotalProductos: "#TotalProductos",
        itemDropDown: ".opcion__ordenamiento__dropdown__item",
        linkItemDropDown: ".opcion__ordenamiento__dropdown__link",
        btnAgregar: ".FichaAgregarProductoBuscador"
       
    };
    var _modificador = {
        itemDropDowndesplegado: "opcion__ordenamiento__dropdown--desplegado",
        linkItemDropDown: "opcion__ordenamiento__dropdown__link--seleccionada"
    }
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        textoBusqueda: textoBusqueda,
        totalProductos: 0,
        totalPaginas: 0,
        productosPorPagina: 20,
        numeroPaginaActual: 0,
        ordenCampo: "orden",
        ordenTipo: "asc",
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
            $(document).on("click", _elementos.opcionOrdenar, _eventos.DropDownOrdenar);
            $(document).on("click", _elementos.itemDropDown, _eventos.ClickItemOrdenar);
            $(document).on("click", _elementos.btnAgregar, _eventos.RegistratProducto);
        },
        ConstruirModeloBusqueda: function () {
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

                }).fail(function (data, error) {
                    console.error(error.toString());
                });
        },
        ProcesarListaProductos: function (productos) {
            $.each(productos, function (index, item) {
                item.posicion = index + 1;
                if (item.Descripcion.length > _config.maxCaracteresDesc) {
                    item.Descripcion = item.Descripcion.substring(0, _config.maxCaracteresDesc) + "...";
                }
                console.log(item.Descripcion);
            });

            SetHandlebars("#js-FichaProductoBuscador", productos, "#FichasProductosBuscador");
        },
        ValidarScroll: function () {
            var footerH = $(window).scrollTop() + $(window).height();
            footerH += $(_elementos.footer).innerHeight() || 0;
            return footerH >= $(document).height();
        }

    };
    var _eventos = {
        DropDownOrdenar: function () {
            var dpw_ordenar = document.getElementById('dpw-ordenar');
            dpw_ordenar.classList.toggle(_modificador.itemDropDowndesplegado);

            var ul_ordenar = document.getElementById('ul-ordenar');
            ul_ordenar.classList.toggle('d-none');
        },

        ClickItemOrdenar: function () {
            
            $(_elementos.linkItemDropDown).removeClass(_modificador.linkItemDropDown);
            $(this).children().addClass(_modificador.linkItemDropDown);
            var valorOrdenamiento = $(this).data("value");
            console.log("valorOrdenamiento: " + valorOrdenamiento);
            var array = valorOrdenamiento.split("-");
            _config.ordenCampo = array[0].trim();
            _config.ordenTipo = array[1].trim();
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
        },
        RegistratProducto: function (e) {
            e.preventDefault();
            AbrirLoad();
            var divPadre = $(this).parents("[data-item='BuscadorFichasProductos']").eq(0);
            BuscadorProvider.RegistroProductoBuscador(divPadre);
        }
    };

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        _funciones.CargarProductos();
    }

    function ScrollPagina() {
        if (_funciones.ValidarScroll()) {
          // _eventos.ScrollPage();
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