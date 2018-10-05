﻿var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        opcionOrdenar: "#dpw-ordenar, .opcion__ordenamiento__label",
        footer: "footer",
        spanTotalProductos: "#TotalProductos",
        itemDropDown: ".opcion__ordenamiento__dropdown__item",
        linkItemDropDown: ".opcion__ordenamiento__dropdown__link",
        btnAgregar: ".FichaAgregarProductoBuscador",
        divContenedorFicha: "#FichasProductosBuscador",
        scriptHandleBarFicha: "#js-FichaProductoBuscador",
        redireccionarFicha: '.redireccionarFicha'
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
            $(document).on("click", _elementos.body, _eventos.OcultarDropDownOrdenar);
            $(document).on("click", _elementos.itemDropDown, _eventos.ClickItemOrdenar);
            $(document).on("click", _elementos.btnAgregar, _eventos.RegistrarProducto);
            $(document).on('click', _elementos.redireccionarFicha, _eventos.RedireccionarAFichaDeFotoYDescripcion);
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

        OcultarDropDownOrdenar: function () {
            //$("#dpw-ordenar").removeClass("opcion__ordenamiento__dropdown--desplegado");
            //$("#ul-ordenar").addClass("d-none");
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
        ScrollCargarProductos: function () {
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
        },
        RegistrarProducto: function (e) {
            e.preventDefault();
            AbrirLoad();
            var divPadre = $(this).parents("[data-item='BuscadorFichasProductos']").eq(0);
            BuscadorProvider.RegistroProductoBuscador(divPadre);
        },
        RedireccionarAFichaDeFotoYDescripcion: function (e) {
            e.preventDefault();
            var divPadre = $(this).parents("[data-item='BuscadorFichasProductos']").eq(0);
            var codigoEstrategia = $(divPadre).find('.hdBuscadorCodigoTipoEstrategia').val();
            var codigoCampania = $(divPadre).find('.hdBuscadorCampaniaID').val();
            var codigoCuv = $(divPadre).find('.hdBuscadorCUV').val();
            var OrigenPedidoWeb = $(divPadre).find('.hdBuscadorOrigenPedidoWeb').val();

            var codigo = ['030', '005', '001', '007', '008', '009', '010', '011'];

            if (codigo.indexOf(codigoEstrategia) >= 0) {
                var UrlDetalle = GetPalanca(codigoEstrategia);
                if (UrlDetalle == "") return false;
                UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
                //console.log(UrlDetalle);
                window.location = UrlDetalle;
                return true;
            }
        }
    };

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        _funciones.CargarProductos();
    }

    function ScrollPagina() {
        if (_funciones.ValidarScroll()) {
            _eventos.ScrollCargarProductos();
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