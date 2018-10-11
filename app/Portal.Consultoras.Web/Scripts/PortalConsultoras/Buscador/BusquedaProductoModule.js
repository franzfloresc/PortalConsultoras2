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
        redireccionarFicha: '.redireccionarFicha',
        dataToggle: '[data-toggle]'
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
        productosPorPagina: totalProductosPagina,
        numeroPaginaActual: 0,
        ordenCampo: "orden",
        ordenTipo: "asc",
        cargandoProductos: false,
        maxCaracteresDesc: totalCaracteresDescripcion
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
            $(document).on("click", _elementos.body, _eventos.DropDownCerrar);
            $(document).on("keyup", _elementos.body, _eventos.DropDownCerrar);
            $(document).on("click", _elementos.opcionOrdenar, _eventos.DropDownOrdenar);
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
            AbrirLoad();

            _config.cargandoProductos = true;
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    $(_elementos.spanTotalProductos).html(data.total);
                    _funciones.ProcesarListaProductos(data.productos);
                    SetHandlebars(_elementos.scriptHandleBarFicha, data.productos, _elementos.divContenedorFicha);
                    _funciones.UpadteFichaProducto();
                    _config.totalProductos = data.total;
                    _config.cargandoProductos = false;
                    CerrarLoad();
                }).fail(function (data, error) {
                    console.error(error.toString());
                    _config.cargandoProductos = false;
                    CerrarLoad();
                });
        },
        ProcesarListaProductos: function (productos) {
            $.each(productos, function (index, item) {
                if (item.Descripcion.length > _config.maxCaracteresDesc) {
                    item.Descripcion = item.Descripcion.substring(0, _config.maxCaracteresDesc) + "...";
                }
            });
        },
        ValidarScroll: function () {
            if (_config.totalProductos === 0) return false;
            if (_config.cargandoProductos) return false;
            if (_config.numeroPaginaActual >= (Math.ceil(_config.totalProductos / _config.productosPorPagina) - 1)) return false;
            var documentHeight = $(document).height();
            var footerHeight = $(window).scrollTop() + $(window).height();
            footerHeight += $(_elementos.footer).innerHeight() || 0;
            return footerHeight >= documentHeight;
        },
        GetSize: function (url, callback) {
            var img = new Image();
            img.src = url;
            img.onload = function () { callback(this.width, this.height); }
        },
        UpadteFichaProducto: function () {

            $('.lazy').Lazy({
                scrollDirection: 'vertical',
                effect: 'fadeIn',
                effectTime: 100,
                threshold: 0,
                afterLoad: function (element) {

                    var imgProducto = element.attr('src');
                    var fichaProducto = element.closest('article');

                    console.log(imgProducto);

                    _funciones.GetSize(imgProducto, function (width, height) {

                        var aspect_ratio = width / height;

                        switch (true) {
                            case aspect_ratio == 1:
                                classRatio = 'ficha__producto--delgada';
                                break;
                            case aspect_ratio > 1.3:
                                classRatio = 'ficha__producto--ancha';
                                break;
                            case aspect_ratio < 1:
                                classRatio = 'ficha__producto--alta';
                                break;
                        }

                        fichaProducto.addClass(classRatio);
                    });
                },
                onError: function (element) {
                    element.attr('src', element.data('src-error'));
                    fichaProducto.addClass('ficha__producto--delgada');
                }
            });

           
        }
    };
    var _eventos = {
        DropDownOrdenar: function () {
            var dpw_ordenar = document.getElementById('dpw-ordenar');
            dpw_ordenar.classList.toggle(_modificador.itemDropDowndesplegado);

            var ul_ordenar = document.getElementById('ul-ordenar');
            ul_ordenar.classList.toggle('d-none');
        },

        DropDownCerrar: function (evt) {

            var dpwOrdenar = $('#dpw-ordenar');

            evt = evt || window.event;
            var isEscape = false;
            if ("key" in evt) {
                isEscape = (evt.key == "Escape" || evt.key == "Esc");
            } else {
                isEscape = (evt.keyCode == 27);
            }

            if (isEscape) {
                if ((!dpwOrdenar.is(evt.target) && dpwOrdenar.has(evt.target).length === 0)) {
                    $('#dpw-ordenar').removeClass('opcion__ordenamiento__dropdown--desplegado');
                    $('#ul-ordenar').addClass('d-none');
                }
            }
            else {
                if ((!dpwOrdenar.is(evt.target) && dpwOrdenar.has(evt.target).length === 0)) {
                    $('#dpw-ordenar').removeClass('opcion__ordenamiento__dropdown--desplegado');
                    $('#ul-ordenar').addClass('d-none');
                }
            }

        },

        ClickItemOrdenar: function () {
            AbrirLoad();

            $(_elementos.linkItemDropDown).removeClass(_modificador.linkItemDropDown);
            $(this).children().addClass(_modificador.linkItemDropDown);
            var valorOrdenamiento = $(this).data("value");
            var array = valorOrdenamiento.split("-");
            _config.ordenCampo = array[0].trim();
            _config.ordenTipo = array[1].trim();
            _config.numeroPaginaActual = 0;

            var textoOrdenamiento = $(this).attr('title');
            
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    _funciones.ProcesarListaProductos(data.productos);
                    SetHandlebars(_elementos.scriptHandleBarFicha, data.productos, _elementos.divContenedorFicha);
                    _funciones.UpadteFichaProducto();
                    CerrarLoad();
                }).fail(function (data, error) {
                    console.error(error.toString());
                    CerrarLoad();
                });

            $('.ul-seleccionado').html(textoOrdenamiento);
            
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
                    _funciones.UpadteFichaProducto();
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
            var model = JSON.parse($(divPadre).find(".hdBuscadorJSON").val());

            var codigoEstrategia = model.CodigoTipoEstrategia;
            var codigoCampania = model.CampaniaID;
            var codigoCuv = model.CUV;
            var origenPedidoWeb = model.OrigenPedidoWeb;

            var codigo = ['030', '005', '001', '007', '008', '009', '010', '011'];

            if (codigo.indexOf(codigoEstrategia) >= 0) {
                var UrlDetalle = GetPalanca(codigoEstrategia);
                if (UrlDetalle == "") return false;
                UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + origenPedidoWeb;
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