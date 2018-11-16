var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        layoutContent: '.layout__content',
        contenedorEtiquetas: '',
        eliminarEtiquetaCriterioElegido: '.enlace__eliminar__etiqueta',
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
        scriptHandleBarCriterios: '#js-labelCriteriosFiltros',
        redireccionarFicha: '.redireccionarFicha',
        dataToggle: '[data-toggle]',
        filtrosCategorias: '#filtrosCategorias',
        filtrosMarcas: '#filtrosMarcas',
        filtrosPrecios: '#filtrosPrecios',
        enlaceLimpiarEtiquetasFiltros: '.enlace__limpiar__filtros, .filtro__btn--limpiar',
        buscadorFiltrosSeleccionar: '.buscadorFiltrosSeleccionar',
        preCargaFiltros: '.layout__precarga--actualizacionFiltros',
        criteriosBuscadorMobile: '.criteriosBuscadorMobile',
        criteriosBuscadorDesktop: '.criteriosBuscadorDesktop',
        mostrarLayoutCriterios: '.layout__content__etiquetas_criteriosElegidos',
        etiquetaCriterioElegido: '.icono__eliminar__criterioElegido'
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
        maxCaracteresDesc: totalCaracteresDescripcion,
        isHome: false,
        categoria: [],
        marca: [],
        precio: [],
        localStorageCategoria: 'filtrosCategorias',
        localStorageMarca: 'filtrosMarcas',
        localStoragePrecio: 'filtrosPrecios',
        localStorageCriterio: 'filtrosCriterios'
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
            $(document).on("click", _elementos.redireccionarFicha, _eventos.RedireccionarAFichaDeFotoYDescripcion);
            $(document).on("click", _elementos.buscadorFiltrosSeleccionar, _eventos.FiltrosSelecionados);
            $(document).on("click", _elementos.eliminarEtiquetaCriterioElegido, _eventos.EliminarEtiquetaCriterioElegido);
            $(document).on("click", _elementos.enlaceLimpiarEtiquetasFiltros, _eventos.LimpiarEtiquetasFiltros);
            //$(document).on("click", _elementos.etiquetaCriterioElegido, _eventos.eliminarCriterio);
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
                },
                Filtro: {
                    categoria: _config.categoria,
                    marca: _config.marca,
                    precio: _config.precio
                },
                IsMobile: _config.isMobile,
                IsHome: _config.isHome
            }
            return modelo;
        },
        CargarProductos: function () {
            _funciones.abrirCargaFiltros();

            _config.cargandoProductos = true;
            var modelo = _funciones.ConstruirModeloBusqueda();
            _provider.BusquedaProductoPromise(modelo)
                .done(function (data) {
                    $(_elementos.spanTotalProductos).html(data.total);
                    _funciones.ProcesarListaProductos(data.productos);
                    SetHandlebars(_elementos.scriptHandleBarFicha, data.productos, _elementos.divContenedorFicha);
                    if (data.total > 0) {
                        set_local_storage(data.filtros.categorias, _config.localStorageCategoria);
                        set_local_storage(data.filtros.marcas, _config.localStorageMarca);
                        set_local_storage(data.filtros.precios, _config.localStoragePrecio);
                        if (data.total > 0) SetHandlebars(_elementos.scriptHandleBarFiltros, _funciones.validarFiltrosCantidad(data.filtros.categorias), _elementos.filtrosCategorias);
                        if (data.total > 0) SetHandlebars(_elementos.scriptHandleBarFiltros, _funciones.validarFiltrosCantidad(data.filtros.marcas), _elementos.filtrosMarcas);
                        if (data.total > 0) SetHandlebars(_elementos.scriptHandleBarFiltros, _funciones.validarFiltrosCantidad(data.filtros.precios), _elementos.filtrosPrecios)
                    }
                    _funciones.UpadteFichaProducto();
                    _config.totalProductos = data.total;
                    _config.cargandoProductos = false;
                    _funciones.cerrarCargafiltros();
                }).fail(function (data, error) {
                    console.error(error.toString());
                    _config.cargandoProductos = false;
                    _funciones.cerrarCargafiltros();
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
        },
        AnchoContenedorEtiquetasCriteriosElegidosMobile: function () {
            _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
            var sumAnchoEtiquetas = 0;
            _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').each(function () {
                sumAnchoEtiquetas += $(this).outerWidth() + 12;
            });
            setTimeout(function () {
                _elementos.contenedorEtiquetas.css('width', sumAnchoEtiquetas);
            }, 100);
        },
        ActualizarAnchoContenedorEtiquetasCriteriosElegidosMobile: function (AnchoEtiquetaCriterioEliminadoMobile) {
            var anchoContenedorEtiquetasActualizadoMobile = _elementos.contenedorEtiquetas.outerWidth() - AnchoEtiquetaCriterioEliminadoMobile;
            _elementos.contenedorEtiquetas.css('width', anchoContenedorEtiquetasActualizadoMobile);
        },
        AgregarEtiquetaFiltroSeleccionado: function (texto) {
            if (_config.isMobile) {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
                $('.layout__content__etiquetas_criteriosElegidosMobile').slideDown(100);
            } else {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosDesktop').find('.lista__etiquetas__criteriosElegidos');
                $('.layout__content__etiquetas_criteriosElegidosDesktop').fadeIn(100);
            }

            var etiquetaFiltroSeleccionadoHtml =
                '<li class="row flex-row justify-content-center align-items-center etiqueta__criterioElegido">'
                + '<span class="etiqueta__criterioElegido_descrip">'
                + texto
                + '</span>'
                + '<a class="d-block enlace__eliminar__etiqueta icono__eliminar__criterioElegido" title="Eliminar etiqueta">'
                + '<img src="/Content/Images/cerrar-tag-icono.svg" alt="Eliminar etiqueta" class="d-block" />'
                + '</a>'
                + '</li>';

            _elementos.contenedorEtiquetas.append(etiquetaFiltroSeleccionadoHtml);

            if (_elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length > 0 && _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length < 2) {
                $(_elementos.enlaceLimpiarEtiquetasFiltros).fadeIn(100);
            }
        },
        abrirCargaFiltros: function () {
            $(_elementos.preCargaFiltros).fadeIn(100);
        },
        cerrarCargafiltros: function () {
            $(_elementos.preCargaFiltros).fadeOut(100);
        },
        validarFiltrosCantidad: function (val) {
            var array = [];
            for (var i = 0; i < val.length; i++) {
                if (val[i].cantidad > 0) array.push(val[i]);
            }
            return array;
        },
        validarFiltrosMarcados: function (tipo) {
            var array = [];
            var criterios = get_local_storage(_config.localStorageCriterio);
            for (var i = 0; i < criterios.length; i++) {
                var x = criterios[i].idFiltro;
                x = x.substring(0, 3).toLowerCase();
                if (x == tipo) {
                    array.push(criterios[i]);
                }
            }

            return array;
        },
        marcarFiltro: function (idFiltro, _localStorage, criterio) {
            var dataCriterios = get_local_storage(_config.localStorageCriterio);
            dataCriterios.push(criterio);

            var data = get_local_storage(_localStorage);
            data = !data ? [] : data;

            for (var i = 0; i < data.length; i++) {
                if (data[i].idFiltro == idFiltro) {
                    data[i].marcado = true;
                    i += data.length;
                }
            }

            set_local_storage(data, _localStorage);
            set_local_storage(dataCriterios, _config.localStorageCriterio);

            return dataCriterios;
        },
        quitarFiltroMarcado: function (idFiltro, _localStorage) {
            var array = [];
            var dataCriterios = get_local_storage(_config.localStorageCriterio);

            var data = get_local_storage(_localStorage);
            data = !data ? [] : data;

            for (var i = 0; i < dataCriterios.length; i++) {
                if (idFiltro != dataCriterios[i].idFiltro) array.push(dataCriterios[i]);
            }

            for (var i = 0; i < data.length; i++) {
                if (data[i].idFiltro == idFiltro) data[i].marcado = false;
            }

            set_local_storage(data, _localStorage);
            set_local_storage(array, _config.localStorageCriterio);

            return array;
        },
        devuelveNombreLocalStorage: function (idFiltro) {
            var filtro = idFiltro.substring(0, 3).toLowerCase();
            var _localStorage = '';
            switch (filtro) {
                case 'cat':
                    _localStorage = _config.localStorageCategoria
                    break;
                case 'mar':
                    _localStorage = _config.localStorageMarca;
                    break;
                case 'pre':
                    _localStorage = _config.localStoragePrecio;
                    break;
            }
            return _localStorage;
        },
        mostrarUOcultarCriterios: function (filtroCriterio) {
            console.log('filtroCriterio', filtroCriterio);
            if (filtroCriterio.length > 0) {
                if (_config.isMobile) {
                    SetHandlebars(_elementos.scriptHandleBarCriterios, filtroCriterio, _elementos.criteriosBuscadorMobile);
                } else {
                    SetHandlebars(_elementos.scriptHandleBarCriterios, filtroCriterio, _elementos.criteriosBuscadorDesktop);
                }
                $(_elementos.mostrarLayoutCriterios).fadeIn(100);
            } else {
                $(_elementos.mostrarLayoutCriterios).fadeOut(100);
            }
        },
        accionFiltrosCriterio: function () {
            var filtroCategoria = _funciones.validarFiltrosMarcados('cat');
            var filtroMarca = _funciones.validarFiltrosMarcados('mar');
            var filtroPrecio = _funciones.validarFiltrosMarcados('pre');

            _config.categoria = filtroCategoria;
            _config.marca = filtroMarca;
            _config.precio = filtroPrecio;

            _funciones.CargarProductos();
        }
    };
    var _eventos = {

        EliminarEtiquetaCriterioElegido: function (e) {
            e.preventDefault();

            var divPadre = $(this).parents("[data-item='buscadorCriterios']").eq(0);
            var idFiltro = $(divPadre).find(".CriteriosFiltrosId").val();
            var _localStorage = _funciones.devuelveNombreLocalStorage(idFiltro);
            var filtroCriterio = _funciones.quitarFiltroMarcado(idFiltro, _localStorage)

            if (_config.isMobile) {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
            } else {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosDesktop').find('.lista__etiquetas__criteriosElegidos');
            }
            var etiquetaCriterioPorEliminar = $(this).parents('.etiqueta__criterioElegido');
            etiquetaCriterioPorEliminar.fadeOut(70);

            if (_config.isMobile) {
                var capturarAnchoEtiquetaPorEliminarMobile = etiquetaCriterioPorEliminar.outerWidth() + 10;
                _funciones.ActualizarAnchoContenedorEtiquetasCriteriosElegidosMobile(capturarAnchoEtiquetaPorEliminarMobile);
            }

            setTimeout(function () {
                etiquetaCriterioPorEliminar.remove();
                if (_elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length == 0) {
                    _elementos.contenedorEtiquetas.next().fadeOut(70);
                    _elementos.contenedorEtiquetas.css('width', '');
                    _elementos.contenedorEtiquetas.parent().delay(70);
                    _elementos.contenedorEtiquetas.parent().slideUp(80);
                }
            }, 100);

            _funciones.accionFiltrosCriterio();
        },
        LimpiarEtiquetasFiltros: function (e) {
            e.preventDefault();

            if (_config.isMobile) {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
                _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').fadeOut(70);
            } else {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas_criteriosElegidosDesktop').find('.lista__etiquetas__criteriosElegidos');
                _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').fadeOut(70);
                $(this).fadeOut(70);
            }
            setTimeout(function () {
                _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').remove();
                if (_elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length == 0) {
                    _elementos.contenedorEtiquetas.find('.lista__etiquetas__criteriosElegidos').css('width', '');
                    _elementos.contenedorEtiquetas.parent().delay(70);
                    _elementos.contenedorEtiquetas.parent().slideUp(80);
                }
            }, 100);

            _config.categoria = [];
            _config.marca = [];
            _config.precio = [];

            set_local_storage([], _config.localStorageCriterio);

            _funciones.CargarProductos();
        },
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
            _funciones.abrirCargaFiltros();

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
                    _funciones.cerrarCargafiltros();
                }).fail(function (data, error) {
                    console.error(error.toString());
                    _funciones.cerrarCargafiltros();
                });

            $('.ul-seleccionado').html(textoOrdenamiento);

        },
        MostrarFiltrosMobile: function (e) {
            e.preventDefault();
            $(_elementos.body).css({ 'overflow-y': 'hidden' });
            $(_elementos.layoutContent).css({ 'z-index': '2000' });
            $(_elementos.backgroundAlMostrarFiltrosMobile).fadeIn(100);
            $(_elementos.seccionFiltros).fadeIn(80);
            $(_elementos.seccionFiltros).delay(30);
            $(_elementos.seccionFiltros).animate({
                right: 0 + '%'
            }, 150);
            setTimeout(function () {
                _funciones.AnchoContenedorEtiquetasCriteriosElegidosMobile();
            }, 150);
        },
        CerrarFiltrosMobile: function (e) {
            e.preventDefault();
            $(_elementos.body).css({ 'overflow-y': '' });
            $(_elementos.seccionFiltros).animate({
                right: -100 + '%'
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
        LimpiarFiltros: function () {
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
            _funciones.abrirCargaFiltros();
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
        },
        eliminarCriterio: function (e) {
            e.preventDefault();

            var divPadre = $(this).parents("[data-item='buscadorCriterios']").eq(0);
            var idFiltro = $(divPadre).find(".CriteriosFiltrosId").val();
            var _localStorage = _funciones.devuelveNombreLocalStorage(idFiltro);
            /*var filtroCriterio = _funciones.quitarFiltroMarcado(idFiltro, _localStorage);

            _funciones.mostrarUOcultarCriterios(filtroCriterio);
            _funciones.accionFiltrosCriterio();   */
        },
        FiltrosSelecionados: function (e) {
            e.preventDefault();

            var divPadre = $(this).parents("[data-item='BuscadorFiltros']").eq(0);
            var idFiltro = $(divPadre).find(".BuscadorFiltroID").val();

            var nombreFiltro = $(divPadre).find(".BuscadorFiltroLabel").val();
            var splited = idFiltro.split('-');
            var min = splited[1] == undefined ? 0 : splited[1];
            var max = splited[2] == undefined ? 0 : splited[2];
            var filtroCriterio = [];
            var filtroSeleccionado = {
                idFiltro: idFiltro,
                nombreFiltro: nombreFiltro,
                min: min,
                max: max
            };

            var _localStorage = _funciones.devuelveNombreLocalStorage(idFiltro);

            if ($('#' + idFiltro).is(':checked')) {
                filtroCriterio = _funciones.quitarFiltroMarcado(idFiltro, _localStorage);
            } else {
                filtroCriterio = _funciones.marcarFiltro(idFiltro, _localStorage, filtroSeleccionado);
            }

            //_funciones.mostrarUOcultarCriterios(filtroCriterio);
            _funciones.AgregarEtiquetaFiltroSeleccionado(nombreFiltro);
            if (_config.isMobile) {
                _funciones.AnchoContenedorEtiquetasCriteriosElegidosMobile();
            }
            _funciones.accionFiltrosCriterio();
        }
    };
    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        _funciones.CargarProductos();
        set_local_storage([], _config.localStorageCriterio);
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