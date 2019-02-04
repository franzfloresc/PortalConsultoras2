var BusquedaProductoModule = (function () {

    var _elementos = {
        body: "body",
        layoutContent: '.layout__content',
        contenedorEtiquetas: '',
        eliminarEtiquetaCriterioElegido: '.enlace__eliminar__etiqueta',
        opcionOrdenar: "#dpw-ordenar, .opcion__ordenamiento__label",
        opcionFiltrar: "#opcionFiltrar",
        opcionCerrarFiltrosMobile: '#cerrarFiltros, .filtro__btn--aplicar, .background__filtros__mobile',
        opcionAplicarFiltrosMobile: '.filtro__btn--aplicar',
        opcionLimpiarFiltros: '.filtro__btn--limpiar',
        filtroCheckbox: '.filtro__item__checkbox',
        backgroundAlMostrarFiltrosMobile: '.background__filtros__mobile',
        seccionFiltros: '.layout__content__filtros',
        filtroTipoTitulo: '.filtro__tipo__titulo',
        footer: "footer",
        spanTotalProductos: "#TotalProductos",
        divCantidadProductoMobile: '.cantidadProductoMobile',
        itemDropDown: ".opcion__ordenamiento__dropdown__item",
        linkItemDropDown: ".opcion__ordenamiento__dropdown__link",
        btnAgregar: ".FichaAgregarProductoBuscador",
        divContenedorFicha: "#FichasProductosBuscador",
        scriptHandleBarFicha: "#js-FichaProductoBuscador",
        scriptHandleBarFiltros: '#js-fichaFiltros',
        scriptHandleBarCriterios: '#js-labelCriteriosFiltros',
        redireccionarFicha: '.redireccionarFicha',
        dataToggle: '[data-toggle]',
        enlaceLimpiarEtiquetasFiltros: '.enlace__limpiar__filtros, .filtro__btn--limpiar',
        buscadorFiltrosSeleccionar: '.buscadorFiltrosSeleccionar',
        preCargaFiltros: '.layout__precarga--actualizacionFiltros',
        criteriosBuscadorMobile: '.criteriosBuscadorMobile',
        criteriosBuscadorDesktop: '.criteriosBuscadorDesktop',
        mostrarLayoutCriterios: '.layout__content__etiquetas__criteriosElegidos',
        etiquetaCriterioElegido: '.icono__eliminar__criterioElegido',
        filtroBtnMobileWrapper: '.filtro__btn__mobile__wrapper',
        valueJSON: ".hdBuscadorJSON",
        filtroListaHandleBar: ".filtros__lista-handleBar",
        textoBusquedaMostar: "#TextoBusqueda"
    };
    var _modificador = {
        itemDropDowndesplegado: "opcion__ordenamiento__dropdown--desplegado",
        linkItemDropDown: "opcion__ordenamiento__dropdown__link--seleccionada"
    }
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        textoBusqueda: textoBusqueda,
        categoriaBusqueda: categoriaBusqueda,
        totalProductos: 0,
        totalPaginas: 0,
        productosPorPagina: totalProductosPagina,
        numeroPaginaActual: 0,
        ordenCampo: "orden",
        ordenTipo: "asc",
        cargandoProductos: false,
        maxCaracteresDesc: totalCaracteresDescripcion,
        isHome: false,
        filtros: [],
        filtrosLocalStorage: 'filtrosLocalStorage',
        nombreGrupo: "Categorías",
        categoriaLocalStorage: "categoriasBuscadorMobile"
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
            $(document).on("click", _elementos.opcionAplicarFiltrosMobile, _eventos.AplicarFiltrosMobile);
            $(document).on("click", _elementos.filtroTipoTitulo, _eventos.MostrarOcultarContenidoTipoFiltro);
            $(document).on("click", _elementos.opcionLimpiarFiltros, _eventos.LimpiarFiltros);
            $(document).on("click", _elementos.itemDropDown, _eventos.ClickItemOrdenar);
            $(document).on("click", _elementos.btnAgregar, _eventos.RegistrarProducto);
            $(document).on("click", _elementos.redireccionarFicha, _eventos.RedireccionarAFichaDeFotoYDescripcion);
            $(document).on("click", _elementos.buscadorFiltrosSeleccionar, _eventos.FiltrosSelecionados);
            $(document).on("click", _elementos.eliminarEtiquetaCriterioElegido, _eventos.EliminarEtiquetaCriterioElegido);
            $(document).on("click", _elementos.enlaceLimpiarEtiquetasFiltros, _eventos.LimpiarEtiquetasFiltros);
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
                Filtro: _config.filtros,
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
                    $(_elementos.divCantidadProductoMobile).html(data.total + ' Resultados');
                    _funciones.ProcesarListaProductos(data.productos);
                    SetHandlebars(_elementos.scriptHandleBarFicha, data.productos, _elementos.divContenedorFicha);
                    _funciones.validacionDataCategoria(data.filtros);
                    SetHandlebars(_elementos.scriptHandleBarFiltros, data.filtros, _elementos.filtroListaHandleBar);

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
            _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
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
        AgregarEtiquetaFiltroSeleccionado: function (id, texto) {
            if (_config.isMobile) {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
                $('.layout__content__etiquetas__criteriosElegidosMobile').slideDown(100);
            } else {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosDesktop').find('.lista__etiquetas__criteriosElegidos');
                $('.layout__content__etiquetas__criteriosElegidosDesktop').fadeIn(100);
            }

            var etiquetaFiltroSeleccionadoHtml =
                '<li class="row flex-row justify-content-center align-items-center etiqueta__criterioElegido" id="criterio' + id + '" data-item="buscadorCriterios">'
                + '<input type="hidden" class="CriteriosFiltrosId" value="' + id + '" />'
                + '<input type="hidden" class="CriteriosFiltrosLabel" value="' + texto + '" />'
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
        quitarFiltroMarcado: function (idFiltro) {
            var filtro = get_local_storage(_config.filtrosLocalStorage);
            var conteo = 0;
            filtro = !filtro ? [] : filtro;

            for (var i = 0; i < filtro.length; i++) {
                var item = filtro[i];
                for (var j = 0; j < item.Opciones.length; j++) {
                    var fil = item.Opciones[j];
                    if (fil.IdFiltro == idFiltro) {
                        item.Opciones.splice(j, 1);
                        j += item.Opciones.length;
                    }
                }
                if (item.Opciones.length == 0) {
                    filtro.splice(i, 1);
                    i = filtro.length;
                }
            }

            set_local_storage(filtro, _config.filtrosLocalStorage)
        },
        accionFiltrosCriterio: function () {
            var filtro = get_local_storage(_config.filtrosLocalStorage);
            _config.numeroPaginaActual = 0;
            _config.filtros = !filtro ? [] : filtro;

            if (_config.isMobile) {
                $(_elementos.preCargaFiltros).css({ 'width': 90 + '%', 'max-width': '280px' });
            }

            _funciones.CargarProductos();
        },
        validacionDataCategoria: function (dataFiltro) {
            var data = dataFiltro;
            if (_config.categoriaBusqueda.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    if (data[i].NombreGrupo == _config.nombreGrupo) {
                        dataFiltro.splice(i, 1);
                        break;
                    }
                }
            }
            return dataFiltro;
        },
        buscarPorCategoria: function () {
            if (_config.categoriaBusqueda.length > 0) {

                var categorias = get_local_storage("categoriasBuscadorMobile");
                var nombreFiltro = "";

                for (var i = 0; i < categorias.length; i++) {
                    if (categorias[i].Codigo == _config.categoriaBusqueda) {
                        nombreFiltro = categorias[i].Nombre;
                        i += categorias.length;
                    }
                }

                $(_elementos.textoBusquedaMostar).html(nombreFiltro);

                var filtroDuro = [{
                    NombreGrupo: _config.nombreGrupo,
                    Opciones: [
                        {
                            IdFiltro: _config.categoriaBusqueda,
                            NombreFiltro: nombreFiltro,
                            Min: 0,
                            Max: 0
                        }]
                }];

                set_local_storage(filtroDuro, _config.filtrosLocalStorage);

                _config.numeroPaginaActual = 0;
                _config.filtros = filtroDuro;
            }
        }
    };
    var _eventos = {
        MarcarFiltros: function (data, filtroSeleccionado) {
            switch (data[0]) {
                case 'cat':
                    if (!(typeof AnalyticsPortalModule === 'undefined'))
                        AnalyticsPortalModule.MarcaFiltroPorCategoria(filtroSeleccionado.NombreFiltro);
                    break;
                case 'mar':
                    if (!(typeof AnalyticsPortalModule === 'undefined'))
                        AnalyticsPortalModule.MarcaFiltroPorMarca(filtroSeleccionado.NombreFiltro);
                    break;
                case 'pre':
                    if (!(typeof AnalyticsPortalModule === 'undefined'))
                        AnalyticsPortalModule.MarcaFiltroPorPrecio(filtroSeleccionado.NombreFiltro);
                    break;
            }
        },
        EliminarEtiquetaCriterioElegido: function (e) {
            e.preventDefault();

            var divPadre = $(this).parents("[data-item='buscadorCriterios']").eq(0);
            var idFiltro = $(divPadre).find(".CriteriosFiltrosId").val();
            var filtroLabel = $(divPadre).find(".CriteriosFiltrosLabel").val();

            var filtroCriterio = _funciones.quitarFiltroMarcado(idFiltro)

            if (_config.isMobile) {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
            } else {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosDesktop').find('.lista__etiquetas__criteriosElegidos');
            }

            var etiquetaCriterioPorEliminar = $(this).parents('.etiqueta__criterioElegido');
            etiquetaCriterioPorEliminar.fadeOut(70);

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaEliminarEtiqueta(filtroLabel);

            if (_config.isMobile) {
                var capturarAnchoEtiquetaPorEliminarMobile = etiquetaCriterioPorEliminar.outerWidth() + 10;
                _funciones.ActualizarAnchoContenedorEtiquetasCriteriosElegidosMobile(capturarAnchoEtiquetaPorEliminarMobile);
            }

            setTimeout(function () {
                etiquetaCriterioPorEliminar.remove();
                if (_elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length == 0) {
                    if (!(_config.isMobile)) {
                        _elementos.contenedorEtiquetas.next().fadeOut(70);
                    }
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
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosMobile').find('.lista__etiquetas__criteriosElegidos');
                _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').fadeOut(70);
            } else {
                _elementos.contenedorEtiquetas = $('.layout__content__etiquetas__criteriosElegidosDesktop').find('.lista__etiquetas__criteriosElegidos');
                _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').fadeOut(70);
                $(this).fadeOut(70);
            }

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaLimpiarFiltros();


            setTimeout(function () {
                _elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').remove();
                if (_elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length == 0) {
                    _elementos.contenedorEtiquetas.find('.lista__etiquetas__criteriosElegidos').css('width', '');
                    _elementos.contenedorEtiquetas.parent().delay(70);
                    _elementos.contenedorEtiquetas.parent().slideUp(80);
                }
            }, 100);

            set_local_storage([], _config.filtrosLocalStorage);

            if (_config.categoriaBusqueda.length > 0) _funciones.buscarPorCategoria();

            _funciones.accionFiltrosCriterio();
        },
        DropDownOrdenar: function (e) {
            e.preventDefault();
            var dpw_ordenar = document.getElementById('dpw-ordenar');
            dpw_ordenar.classList.toggle(_modificador.itemDropDowndesplegado);

            var ul_ordenar = document.getElementById('ul-ordenar');
            if (ul_ordenar.classList.contains('d-none')) {
                ul_ordenar.classList.remove('d-none');
            } else {
                ul_ordenar.classList.add('d-none');
            }
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

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaClicOpcionesFiltrarBuscador(textoOrdenamiento);

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
            if (_config.isMobile) {
                $(_elementos.filtroBtnMobileWrapper).delay(100);
                $(_elementos.filtroBtnMobileWrapper).addClass('filtro__btn__mobile__wrapper--fixed');
            }

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaBotonFiltro();

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
            if (_config.isMobile) {
                $(_elementos.filtroBtnMobileWrapper).removeClass('filtro__btn__mobile__wrapper--fixed');
                $(_elementos.preCargaFiltros).css({ 'width': '', 'max-width': '' });
            }

            //if (!(typeof AnalyticsPortalModule === 'undefined'))
            //    AnalyticsPortalModule.MarcaBotonAplicarFiltro();

            $(_elementos.backgroundAlMostrarFiltrosMobile).fadeOut(100);
            setTimeout(function () {
                $(_elementos.layoutContent).css({ 'z-index': '2' });
            }, 400);
            $(_elementos.seccionFiltros).scrollTop(0);
        },
        AplicarFiltrosMobile: function (e) {
            e.preventDefault();

            var seleccionados = get_local_storage(_config.filtrosLocalStorage);
            var opcionesFiltros = "";

            if (seleccionados.length > 0) {
                $.each(seleccionados, function (i, item) {

                    if (item.Opciones.length > 0) {

                        $.each(item.Opciones, function (i, itemChild) {
                            opcionesFiltros += itemChild.NombreFiltro + " - ";
                        });
                    }
                    opcionesFiltros = opcionesFiltros.substr(0, opcionesFiltros.length - 3);
                    opcionesFiltros += " | ";                    
                });
                opcionesFiltros = opcionesFiltros.substr(0, opcionesFiltros.length - 3);

                AnalyticsPortalModule.MarcaBotonAplicarFiltro(opcionesFiltros);
            }


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

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaLimpiarFiltros();

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
            BuscadorProvider.RegistroProductoBuscador(divPadre, _elementos.valueJSON);
        },
        RedireccionarAFichaDeFotoYDescripcion: function (e) {
            e.preventDefault();

            var divPadre = $(this).parents("[data-item='BuscadorFichasProductos']").eq(0);
            var model = JSON.parse($(divPadre).find(".hdBuscadorJSON").val());

            var codigoEstrategia = model.CodigoTipoEstrategia;
            var codigoCampania = model.CampaniaID;
            var codigoCuv = model.CUV;
            var origenPedidoWeb = model.OrigenPedidoWeb;
            var descripcionProducto = model.DescripcionCompleta;

            var codigo = ['030', '005', '001', '007', '008', '009', '010', '011'];

            localStorage.setItem('valorBuscador', _config.textoBusqueda);

            if (codigo.indexOf(codigoEstrategia) >= 0) {
                var UrlDetalle = GetPalanca(codigoEstrategia, origenPedidoWeb);
                var UrlGeneral = "";

                if (UrlDetalle == "") return false;

                UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + origenPedidoWeb;

                if (_config.isMobile) {
                    UrlGeneral = "/Mobile" + UrlDetalle;
                } else {
                    UrlGeneral = UrlDetalle;
                }

                window.location = UrlGeneral;

                if (!(typeof AnalyticsPortalModule === 'undefined'))
                    AnalyticsPortalModule.MarcaEligeTuOpcionBuscador(descripcionProducto + ' - ' + _config.textoBusqueda);

                return true;
            }
        },
        FiltrosSelecionados: function (e) {
            e.preventDefault();

            var divPadre = $(this).parents("[data-item='BuscadorFiltros']").eq(0);
            var idFiltro = $(divPadre).find(".BuscadorFiltroID").val();
            var nombreSeccion = $(divPadre).find(".BuscadorSeccionFiltro").val();
            var nombreFiltro = $(divPadre).find(".BuscadorFiltroLabel").val();
            var splited = idFiltro.split('-');
            var min = splited[1] == undefined ? 0 : splited[1];
            var max = splited[2] == undefined ? 0 : splited[2];
            var filtroSeleccionado = {
                IdFiltro: idFiltro,
                NombreFiltro: nombreFiltro,
                Min: min,
                Max: max
            };

            _eventos.MarcarFiltros(splited, filtroSeleccionado);

            var seleccionados = get_local_storage(_config.filtrosLocalStorage);
            var opcionesFiltros = [];

            seleccionados = !seleccionados ? [] : seleccionados;

            for (var i = 0; i < seleccionados.length; i++) {
                var item = seleccionados[i];
                if (item.NombreGrupo == nombreSeccion) {
                    opcionesFiltros = item.Opciones;
                    seleccionados.splice(i, 1);
                    break;
                }
            }

            var element = $('#' + idFiltro);
            var criterio = $('#criterio' + idFiltro);

            if (element.is(':checked')) {
                _funciones.quitarFiltroMarcado(idFiltro);
                criterio.fadeOut(70);
                if (_config.isMobile) {
                    var capturarAnchoEtiquetaPorEliminarMobile = criterio.outerWidth() + 10;
                    _funciones.ActualizarAnchoContenedorEtiquetasCriteriosElegidosMobile(capturarAnchoEtiquetaPorEliminarMobile);
                }
                setTimeout(function () {
                    criterio.remove();
                    if (_elementos.contenedorEtiquetas.find('.etiqueta__criterioElegido').length == 0) {
                        if (!(_config.isMobile)) {
                            _elementos.contenedorEtiquetas.next().fadeOut(70);
                        }
                        _elementos.contenedorEtiquetas.css('width', '');
                        _elementos.contenedorEtiquetas.parent().delay(70);
                        _elementos.contenedorEtiquetas.parent().slideUp(80);
                    }
                }, 100);
            } else {
                opcionesFiltros.push(filtroSeleccionado);
                seleccionados.push({
                    NombreGrupo: nombreSeccion,
                    Opciones: opcionesFiltros
                });
                set_local_storage(seleccionados, _config.filtrosLocalStorage);

                _funciones.AgregarEtiquetaFiltroSeleccionado(idFiltro, nombreFiltro);
                if (_config.isMobile) {
                    _funciones.AnchoContenedorEtiquetasCriteriosElegidosMobile();
                }
            }
            _funciones.accionFiltrosCriterio();
        }
    };
    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        set_local_storage([], _config.filtrosLocalStorage);
        _funciones.buscarPorCategoria();
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