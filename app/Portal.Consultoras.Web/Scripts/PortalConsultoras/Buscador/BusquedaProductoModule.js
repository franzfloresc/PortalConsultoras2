﻿var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        opcionOrdenar: "#dpw-ordenar, .opcion__ordenamiento__label",
        footer: "footer",
        spanTotalProductos: "#TotalProductos",
        itemDropDown: ".opcion__ordenamiento__dropdown__item",
        linkItemDropDown: ".opcion__ordenamiento__dropdown__link",
        divContenedorFicha : "#FichasProductosBuscador",
        scriptHandleBarFicha: "#js-FichaProductoBuscador"
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
        cargandoProductos: false,
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
        },
        ConstruirModeloBusqueda: function () {
            var modelo = {
                TextoBusqueda: _config.textoBusqueda,
                Paginacion: {
                    Cantidad: _config.productosPorPagina,
                    NumeroPagina: _config.numeroPaginaActual
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
                    SetHandlebars(_elementos.scriptHandleBarFicha, data.productos, _elementos.divContenedorFicha);
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
            });
        },
        ValidarScroll: function () {
            if (_config.totalProductos === 0) return false;
            if (_config.cargandoProductos) return false;
            if (_config.numeroPaginaActual === Math.ceil(_config.totalProductos / _config.productosPorPagina)) return false;
            var documentHeight = $(document).height();
            var footerHeight = $(window).scrollTop() + $(window).height();
            footerHeight += $(_elementos.footer).innerHeight() || 0;
            return footerHeight >= documentHeight;
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
            var array = valorOrdenamiento.split("-");
            _config.ordenCampo = array[0].trim();
            _config.ordenTipo = array[1].trim();
            _config.numeroPaginaActual = 0;

            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    _funciones.ProcesarListaProductos(data.productos);
                    SetHandlebars(_elementos.scriptHandleBarFicha, data.productos, _elementos.divContenedorFicha);
                }).fail(function (data, error) {
                    console.error(error.toString());
                });

        },
        ScrollPage: function () {
            _config.cargandoProductos = true;
            _config.numeroPaginaActual++;
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    _funciones.ProcesarListaProductos(data.productos);
                    var htmlDiv = SetHandlebars(_elementos.scriptHandleBarFicha, data.productos);
                    $(_elementos.divContenedorFicha).append(htmlDiv);
                    _config.cargandoProductos = false;
                }).fail(function (data, error) {
                    _config.cargandoProductos = false;
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
            _eventos.ScrollPage();
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