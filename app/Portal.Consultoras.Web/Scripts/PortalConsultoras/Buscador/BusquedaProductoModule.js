var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        layoutContent: '.layout__content',
        opcionOrdenar: "#dpw-ordenar, .opcion__ordenamiento__label",
        opcionFiltrar: "#opcionFiltrar",
        opcionCerrarFiltrosMobile: '#cerrarFiltros, .filtro__btn--aplicar',
        opcionLimpiarFiltros: '.filtro__btn--limpiar',
        filtroCheckbox: '.filtro__item__checkbox',
        backgroundAlMostrarFiltrosMobile: '.background__filtros__mobile',
        seccionFiltros: '.layout__content__filtros',
        filtroTipoTitulo: '.filtro__tipo__titulo',
        footer: "footer",
        spanTotalProductos: "#TotalProductos",
        itemDropDown: ".opcion__ordenamiento__dropdown__item",
        linkItemDropDown: ".opcion__ordenamiento__dropdown__link",
        btnAgregar: ".FichaAgregarProductoBuscador",
        divContenedorFicha: "#FichasProductosBuscador",
        scriptHandleBarFicha: "#js-FichaProductoBuscador",
        scriptHandleBarFiltros: '#js-fichaFiltros',
        redireccionarFicha: '.redireccionarFicha',
        dataToggle: '[data-toggle]',
        filtrosCategorias: '#filtrosCategorias',
        filtrosMarcas: '#filtrosMarcas'
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
            $(document).on("click", _elementos.opcionFiltrar, _eventos.MostrarFiltrosMobile);
            $(document).on("click", _elementos.opcionCerrarFiltrosMobile, _eventos.CerrarFiltrosMobile);
            $(document).on("click", _elementos.filtroTipoTitulo, _eventos.MostrarOcultarContenidoTipoFiltro);
            $(document).on("click", _elementos.opcionLimpiarFiltros, _eventos.LimpiarFiltros);
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
                    // Filtros categorias
                    if (data.total > 0) SetHandlebars(_elementos.scriptHandleBarFiltros, data.filtros.categorias, _elementos.filtrosCategorias);
                    // Filtros Marcas
                    if (data.total > 0) SetHandlebars(_elementos.scriptHandleBarFiltros, data.filtros.marcas, _elementos.filtrosMarcas);
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
                    var fichaProducto = element.closest('article');
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

        MostrarFiltrosMobile: function(e){
            e.preventDefault();
            $(_elementos.body).css({'overflow-y':'hidden'});
            $(_elementos.layoutContent).css({ 'z-index': '2000' });
            $(_elementos.backgroundAlMostrarFiltrosMobile).fadeIn(100);
            $(_elementos.seccionFiltros).fadeIn(80);
            $(_elementos.seccionFiltros).delay(30);
            $(_elementos.seccionFiltros).animate({
                left : 0 + '%'
            }, 150);
        },

        CerrarFiltrosMobile: function(e){
            e.preventDefault();
            $(_elementos.body).css({ 'overflow-y': '' });
            $(_elementos.seccionFiltros).animate({
                left: -100 + '%'
            }, 150);
            $(_elementos.backgroundAlMostrarFiltrosMobile).delay(100);
            $(_elementos.backgroundAlMostrarFiltrosMobile).fadeOut(100);
            setTimeout(function () {
                $(_elementos.layoutContent).css({ 'z-index': '2' });
            }, 400);
            $(_elementos.seccionFiltros).scrollTop(0);
        },

        MostrarOcultarContenidoTipoFiltro: function (e) {
            var filtroTipo = $(this).parent();
            var contenidoTipoFiltro = $(this).next();

            if (contenidoTipoFiltro.css('display') == 'none') {
                filtroTipo.animate({
                    'padding-bottom': 18 + 'px'
                }, 100);
            } else {
                filtroTipo.animate({
                    'padding-bottom': 9 + 'px'
                }, 100);
            }

            $(this).toggleClass('filtro__tipo__titulo--mostrarContenido');
            contenidoTipoFiltro.slideToggle(250);
        },

        LimpiarFiltros: function(){
            $(_elementos.filtroCheckbox).removeAttr('checked');
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