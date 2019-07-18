var BuscadorPortalConsultoras;
var CategoriaProductosDatos;
var xhr = null;
var baseUrl = baseUrl || "";

var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();

var BuscadorModule = (function () {

    var _keys = [
        { name: 'tab', val: 9 },
        { name: "shift", val: 16 },
        { name: "ctrl", val: 17 },
        { name: "alt", val: 18 },
        { name: "pause", val: 19 },
        { name: "caps ", val: 20 },
        { name: "page up", val: 33 },
        { name: "page down", val: 34 },
        { name: "page down", val: 35 },
        { name: "end", val: 36 },
        { name: "home", val: 37 },
        { name: "up arrow", val: 38 },
        { name: "right arrow", val: 39 },
        { name: "down arrow", val: 40 },
        { name: "insert", val: 45 },
        { name: "left window key", val: 91 },
        { name: "right window key", val: 92 },
        { name: "num lock", val: 144 },
        { name: "f1", val: 112 },
        { name: "f2", val: 113 },
        { name: "f3", val: 114 },
        { name: "f4", val: 115 },
        { name: "f5", val: 116 },
        { name: "f6", val: 117 },
        { name: "f7", val: 118 },
        { name: "f8", val: 119 },
        { name: "f9", val: 120 },
        { name: "f10", val: 121 },
        { name: "f11", val: 122 },
        { name: "f12", val: 123 }
    ];
    var _elementos = {
        body: "body",
        campoBuscadorProductos: "#CampoBuscadorProductos",
        opcionLimpiarBusqueda: ".opcion_limpiar_campo_busqueda_productos",
        agregarProducto: ".agregarProductoBuscador",
        redireccionarFicha: ".redireccionarFicha",
        botonVerTodos: "#BotonVerTodosResultados",
        logoPaginaResponsive: '.logoPaginaResponsive',
        valueJSON: ".hdBuscadorJSON"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        caracteresBuscador: CaracteresBuscador,
        caracteresBuscadorNumerico: CaracteresBuscadorNumerico,
        mostrarPalabrasMenoresACuatro: MostrarPalabrasMenoresACuatro,
        totalResultadosBuscador: TotalResultadosBuscador,
        urlBusquedaProducto: "/BusquedaProductos",
        aplicarLogicaCantidadBotonVerTodos: (AplicarLogicaCantidadBotonVerTodos === 'true'),
        contadorBusqueda: 0,
        isHome: true,
        categorias: 'categoriasBuscadorMobile',
        isSuscrita: 'suscritaBuscadorMobile'
    };
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
            if (!_config.isMobile) {
                $(document).on("click", _elementos.body, _eventos.CerrarResultadosBusqueda);
                $(document).on("focus", _elementos.campoBuscadorProductos, _eventos.OcultarTooltipInformativo);
            } else {
                _funciones.CargarCategorias();
            }

            $(document).on("keyup", _elementos.campoBuscadorProductos, _eventos.AccionesCampoBusquedaAlDigitar);
            $(document).on("click", _elementos.opcionLimpiarBusqueda, _eventos.LimpiarCampoBusqueda);
            $(document).on("click", _elementos.agregarProducto, _eventos.AgregarProducto);
            $(document).on("click", _elementos.redireccionarFicha, _eventos.RedireccionarAFichaDeFotoYDescripcion);
            $(document).on("click", _elementos.botonVerTodos, _eventos.ClickVerTodos);
            $(document).on("click", _elementos.logoPaginaResponsive, _eventos.RedireccionarMenuPrincipal);

        },
        CampoDeBusquedaConCaracteres: function (campoBuscador) {
            if (campoBuscador !== undefined) $(campoBuscador).addClass("campo_buscador_productos_activo");
            if (_config.isMobile) {
                $(".vistaResultadosBusquedaMobile").delay(50);
                $(".vistaResultadosBusquedaMobile").fadeIn(100);
                $(".enlace_busqueda_filtros").fadeOut(100);
            } else {
                $(".campo_busqueda_fondo_on_focus").fadeIn(100);
                $(".lista_resultados_busqueda_productos").delay(50);
                $(".lista_resultados_busqueda_productos").fadeIn(100);
                $(".enlace_busqueda_productos").fadeOut(100);
            }
            $(".opcion_limpiar_campo_busqueda_productos").delay(50);
            $(".opcion_limpiar_campo_busqueda_productos").fadeIn(100);
        },
        CampoDeBusquedaSinCaracteres: function (element) {
            if (_config.isMobile) {
                $(".vistaResultadosBusquedaMobile").fadeOut(100);
                $(element).fadeOut(100);
                $(".enlace_busqueda_filtros").delay(50);
                $(".enlace_busqueda_filtros").fadeIn(100);
                $("#ResultadoBuscador").html("");
            } else {
                $(".lista_resultados_busqueda_productos").fadeOut(100);
                $(".lista_resultados_busqueda_productos").animate({
                    'min-height': "95px",
                    'height': "auto"
                }, 100);
                $(".campo_busqueda_fondo_on_focus").delay(50);
                $(".campo_busqueda_fondo_on_focus").fadeOut(100);
                $(_elementos.campoBuscadorProductos).removeClass("campo_buscador_productos_activo");
                $(".opcion_limpiar_campo_busqueda_productos").fadeOut(100);
                $(".enlace_busqueda_productos").delay(50);
                $(".enlace_busqueda_productos").fadeIn(100);
            }
        },
        AccionesLimpiarBusqueda: function (campoBuscador, resultadoBuscador) {
            _funciones.CampoDeBusquedaSinCaracteres(campoBuscador);
            $(campoBuscador).val("");
            $(resultadoBuscador).html("");
        },
        ModificarAnchoBuscadorFiltros: function () {

            var enlacesVisiblesMenuLateralDerechoSegunVista = $(".visibilidadEnlaceMenu:visible");

            if ($(".new_menu").first().find("a").attr("title") == "SOCIA EMPRESARIA") {
                $(".wrapper_header").addClass("wrapper_header_se");
                if (enlacesVisiblesMenuLateralDerechoSegunVista.length > 2) {
                    $(".buscador_productos").addClass("buscador_productos_con_enlace_menu_socia_empresaria_vista_pedido");
                } else {
                    if (window.location.href.indexOf("Bienvenida") > -1) {
                        $(".buscador_productos").addClass("buscador_productos_con_enlace_menu_socia_empresaria_vista_bienvenida");
                    } else {
                        $(".buscador_productos").addClass("buscador_productos_con_enlace_menu_socia_empresaria");
                    }
                }
            } else {
                $(".menu_new_esika").addClass("anchoMenu_sinEnlaceSociaEmpresaria");
                if (enlacesVisiblesMenuLateralDerechoSegunVista.length > 2) {
                    $(".buscador_productos").addClass("buscador_productos_sin_enlace_menu_socia_empresaria_vista_pedido");
                } else {
                    if (window.location.href.indexOf("Bienvenida") > -1) {
                        $(".buscador_productos").addClass("buscador_productos_sin_enlace_menu_socia_empresaria_vista_bienvenida");
                    } else {
                        $(".buscador_productos").addClass("buscador_productos_sin_enlace_menu_socia_empresaria");
                    }
                }
            }
        },
        LlamarAnalyticsBarraBusqueda: function () {
            if (!(typeof AnalyticsPortalModule === "undefined"))
                AnalyticsPortalModule.MarcaBarraBusqueda();
        },
        LlamarAnalyticsSeleccionarContenido: function (textobusqueda) {
            if (!(typeof AnalyticsPortalModule === "undefined"))
                AnalyticsPortalModule.MarcaSeleccionarContenidoBusqueda(textobusqueda);
        },
        LlamarAnalyticsElijeUnaOpcion: function (urlDetalle, textobusqueda) {
            if (!(typeof AnalyticsPortalModule === "undefined"))
                AnalyticsPortalModule.MarcaEligeUnaOpcion(urlDetalle, textobusqueda);
        },
        CargarCategorias: function () {
            if (!(typeof FlagBuscarPorCategoria === 'undefined') && FlagBuscarPorCategoria == true) {
                $(".seccion_categorias_productos_busqueda_wrapper").fadeIn(150);

                CategoriaProductosDatos = get_local_storage(_config.categorias);

                var isSuscritaLocal = get_local_storage(_config.isSuscrita);

                if (isSuscritaLocal == boolSuscrita || isSuscritaLocal == null) {
                    set_local_storage(boolSuscrita, _config.isSuscrita);

                } else if (isSuscritaLocal != boolSuscrita) {
                    set_local_storage(boolSuscrita, _config.isSuscrita);
                    CategoriaProductosDatos = null;
                }

                if (CategoriaProductosDatos == null) {
                    var model = {}

                    xhr = $.ajax({
                        type: "POST",
                        url: baseUrl + "Buscador/ListarCategorias",
                        data: JSON.stringify(model),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                        }
                    });

                    var successBusqueda = function (datos) {
                        set_local_storage(datos, _config.categorias);
                        SetHandlebars("#js-categoriasProductos", datos, "#CategoriaProductos");
                    };

                    xhr.then(successBusqueda, function (e) {
                    });

                } else {
                    SetHandlebars("#js-categoriasProductos", CategoriaProductosDatos, "#CategoriaProductos");
                }
            } else {
                $(".seccion_categorias_productos_busqueda_wrapper").fadeOut(150);
            }
        },
        EsAlfanumericoLetras: function (valorBusqueda) {
            var letras = "abcdefghyjklmnñopqrstuvwxyzáéíóú";
            var esAlfaNumerico = false;
            valorBusqueda = valorBusqueda.toLowerCase();
            for (i = 0; i < valorBusqueda.length; i++) {
                if (letras.indexOf(valorBusqueda.charAt(i), 0) != -1) {
                    esAlfaNumerico = true;
                    break;
                }
            }
            return esAlfaNumerico;
        },
        EsCantidadCaracteresMenoresACuatro: function (valorBusqueda) {
            var letrasCaracterMenorACuatro = _config.mostrarPalabrasMenoresACuatro;
            var esMenorACuatro = false;
            var lista = letrasCaracterMenorACuatro.split(',');
            valorBusqueda = valorBusqueda.toLowerCase();
            for (var a = 0; a < lista.length; a++) {
                if (valorBusqueda.trim() == lista[a].trim()) {
                    esMenorACuatro = true;
                    break;
                }
            }
            return esMenorACuatro;
        },
        CargarBusqueda: function (valorBusqueda) {
            _funciones.CampoDeBusquedaConCaracteres($("#CampoBuscadorProductos"));
            if (_config.contadorBusqueda === 0) {
                _funciones.LlamarAnalyticsBarraBusqueda();
                _config.contadorBusqueda++;
            }
            $(".seccion_categorias_productos_busqueda_wrapper").fadeOut(150);
            $(".spinner").fadeIn(150);
            if (xhr && xhr.readyState !== 4) {
                xhr.abort();
            }

            delay(function () {
                var model = {
                    textoBusqueda: valorBusqueda,
                    Paginacion: {
                        NumeroPagina: 0,
                        Cantidad: _config.totalResultadosBuscador
                    },
                    Orden: {
                        Campo: 'orden',
                        Tipo: 'asc'
                    },
                    IsMobile: _config.isMobile,
                    IsHome: _config.isHome
                }

                xhr = $.ajax({
                    type: "POST",
                    url: baseUrl + "Buscador/BusquedaProductos",
                    data: JSON.stringify(model),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function (msg) {

                    }
                });

                var successBusqueda = function (r) {

                    if (r.total == 0) {
                        $(".spinner").fadeOut(150);
                        $(".busqueda_sin_resultados").fadeIn(60);

                        if (!(typeof AnalyticsPortalModule === 'undefined'))
                            AnalyticsPortalModule.MarcaBusquedaSinResultadosBuscador(valorBusqueda);
                    } else {

                        $.each(r.productos, function (index, item) {
                            item.posicion = index + 1;
                            if (item.Descripcion.length > TotalCaracteresEnListaBuscador) {
                                item.Descripcion = item.Descripcion.substring(0, TotalCaracteresEnListaBuscador) + "...";
                            }
                        });
                        var finalProductos = RedimPromociones(r.productos); //Agregamos promociones

                        SetHandlebars("#js-ResultadoBuscador", finalProductos, "#ResultadoBuscador");

                        if ($('.searchCarousel').length > 0) {
                            const settings = {
                                dots: false,
                                infinite: false,
                                arrows: true,
                                prevArrow: '<div class="arrow prev"><div class="arrow-top"></div><div class="arrow-bottom"></div></div>',
                                nextArrow: '<div class="arrow next"><div class="arrow-top"></div><div class="arrow-bottom"></div></div>',
                            }
                            $('.searchCarousel').slick(settings); /* [Tesla-178 - Search Carousel] / start carousel */
                        }

                        setTimeout(function () {
                            if ($(".busqueda_sin_resultados").is(":visible")) {
                                $(".busqueda_sin_resultados").fadeOut(60);
                            }
                            $(".spinner").fadeOut(150);
                            $("#ResultadoBuscador").delay(50);
                            $("#ResultadoBuscador").fadeIn(100, function () {

                                if ($('.searchCarousel').length > 0) {
                                    $('.searchCarousel').slick('setPosition'); /* [Tesla-178 - Search Carousel] / Recalculate position slick */
                                }
                            });
                            if (!_config.isMobile) {
                                $(".lista_resultados_busqueda_productos").animate({
                                    'min-height': $("#ResultadoBuscador").height() + 29
                                },
                                    100);
                            }
                        }, 400);

                        // si está activa la lógica para ocultar BotonVerTodos
                        if (_config.aplicarLogicaCantidadBotonVerTodos && r.total < _config.totalResultadosBuscador) {
                            $('.ver_todos_los_resultados_wrapper').hide();
                        }
                    }
                };

                xhr.then(successBusqueda, function (e) {
                });

            }, 200);
        }
    };
    var _eventos = {
        AccionesCampoBusquedaAlDigitar: function (event) {
            if ($(".tooltip_informativo_sobre_opcion_busqueda_prod").is(":visible") && !_config.isMobile) {
                $(".tooltip_informativo_sobre_opcion_busqueda_prod").fadeOut(100);
            }

            var key = false;
            $.each(_keys, function (i, value) {
                if (value.val === event.which) key = true;
            });
            if (key) return false;

            $("#ResultadoBuscador").html("");

            if (event.which === 27 && !_config.isMobile) {
                if ($(".lista_resultados_busqueda_productos").length > 0) {
                    _funciones.AccionesLimpiarBusqueda($("#CampoBuscadorProductos"), $("#ResultadoBuscador"));
                    return false;
                }
            }

            var valorBusqueda = $(this).val();

            localStorage.setItem('valorBuscador', valorBusqueda);

            if (valorBusqueda.length >= _config.caracteresBuscador && _funciones.EsAlfanumericoLetras(valorBusqueda)) {

                _funciones.CargarBusqueda(valorBusqueda);
            }
            else if (_funciones.EsCantidadCaracteresMenoresACuatro(valorBusqueda) && _funciones.EsAlfanumericoLetras(valorBusqueda)) {
                _funciones.CargarBusqueda(valorBusqueda);
            }
            else if (valorBusqueda.length == _config.caracteresBuscadorNumerico) {
                _funciones.CargarBusqueda(valorBusqueda);
            }

            else {
                if (!_config.isMobile) _funciones.CampoDeBusquedaSinCaracteres($(this));
                if ($(".busqueda_sin_resultados").is(":visible")) {
                    $(".busqueda_sin_resultados").fadeOut(60);
                }
                $("#ResultadoBuscador").fadeOut(150);
                if (_config.isMobile) _funciones.CampoDeBusquedaSinCaracteres($(".opcion_limpiar_campo_busqueda_productos"));
                else _funciones.CampoDeBusquedaSinCaracteres($("#CampoBuscadorProductos"));

                if (!(typeof FlagBuscarPorCategoria === 'undefined') && FlagBuscarPorCategoria == true) {
                    $(".seccion_categorias_productos_busqueda_wrapper").fadeIn(150);
                }
            }
        },
        LimpiarCampoBusqueda: function (e) {
            e.preventDefault();
            if (_config.isMobile) _funciones.CampoDeBusquedaSinCaracteres($(".opcion_limpiar_campo_busqueda_productos"));
            else _funciones.CampoDeBusquedaSinCaracteres($("#ResultadoBuscador"));
            $("#CampoBuscadorProductos").val("");
            $("#CampoBuscadorProductos").focus();
            $("#ResultadoBuscador").html("");

            if (!(typeof FlagBuscarPorCategoria === 'undefined') && FlagBuscarPorCategoria == true) {
                $(".seccion_categorias_productos_busqueda_wrapper").fadeIn(150);
            }
        },
        CerrarResultadosBusqueda: function (e) {
            var buscadorProductos = $(".buscador_productos");
            var seMuestraListaResultadosBusqueda = $(".lista_resultados_busqueda_productos").css("display") == "block";
            if (seMuestraListaResultadosBusqueda) {
                if ((!buscadorProductos.is(e.target) && buscadorProductos.has(e.target).length === 0)) {
                    _funciones.AccionesLimpiarBusqueda($("#CampoBuscadorProductos"), $("#ResultadoBuscador"));
                }
            }
        },
        OcultarTooltipInformativo: function () {
            if ($(".tooltip_informativo_sobre_opcion_busqueda_prod").is(":visible")) {
                $(".tooltip_informativo_sobre_opcion_busqueda_prod").fadeOut(100);
            }
        },
        AgregarProducto: function (e) {
            e.preventDefault();
            AbrirLoad();
            var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
            var textoBusqueda = $(_elementos.campoBuscadorProductos).val();
            _funciones.LlamarAnalyticsSeleccionarContenido(textoBusqueda);
            PedidoRegistroModule.RegistroProductoBuscador(divPadre, _elementos.valueJSON, "Desplegable");
        },
        RedireccionarAFichaDeFotoYDescripcion: function (e) {
            e.preventDefault();
            var textoBusqueda = $(_elementos.campoBuscadorProductos).val();
            _funciones.LlamarAnalyticsSeleccionarContenido(textoBusqueda);
            var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
            var codigoEstrategia = $(divPadre).find(".hdBuscadorCodigoTipoEstrategia").val();
            var codigoCampania = $(divPadre).find(".hdBuscadorCampaniaID").val();
            var codigoCuv = $(divPadre).find(".hdBuscadorCUV").val();
            var OrigenPedidoWeb = $(divPadre).find(".hdBuscadorOrigenPedidoWeb").val();
            var descripcionProducto = $(divPadre).find(".hdBuscadorDescripcion").val();
            var tipoPersonalizacionProducto = $(divPadre).find(".hdBuscadorTipoPersonalizacion").val();

            var codigo = ["030", "005", "001", "007", "008", "009", "010", "011"];
            var tipoPersonalizacion = ["CAT"];

            if (textoBusqueda != "")
                localStorage.setItem('valorBuscador', textoBusqueda);

            var UrlDetalle = "";
            if (codigo.indexOf(codigoEstrategia) >= 0) {
                UrlDetalle = FichaVerDetalle.GetPalanca(codigoEstrategia, OrigenPedidoWeb);
            }
            if (UrlDetalle == "" && tipoPersonalizacion.indexOf(tipoPersonalizacionProducto) >= 0) {
                UrlDetalle = FichaVerDetalle.GetUrlTipoPersonalizacion(tipoPersonalizacionProducto);
                //
                var key = ConstantesModule.KeysLocalStorage.DescripcionProductoCatalogo(codigoCampania, codigoCuv);
                if (descripcionProducto != '') localStorage.setItem(key, descripcionProducto);
            }

            if (UrlDetalle === "") return false;

            UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
            _funciones.LlamarAnalyticsElijeUnaOpcion(UrlDetalle, textoBusqueda);

            window.location = UrlDetalle;

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaEligeTuOpcionBuscador(descripcionProducto + ' - ' + $(_elementos.campoBuscadorProductos).val());

            return true;
        },
        ClickVerTodos: function () {
            var valorBusqueda = $(_elementos.campoBuscadorProductos).val();
            var url = _config.urlBusquedaProducto + "?q=" + valorBusqueda;

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaVerTodosLosResultadosBuscador(valorBusqueda);

            localStorage.setItem('valorBuscador', valorBusqueda);

            window.location.href = url;
        },
        RedireccionarMenuPrincipal: function (e) {
            e.preventDefault();

            if (!_config.isMobile) {
                window.location.href = baseUrl + 'Bienvenida';
            }
            else {
                window.location.href = baseUrl + 'Mobile/Bienvenida';
            }
        }
    };

    //Realiza un ajuste al resultado del busqueda para agregar promociones si hay en forma de un array.
    function RedimPromociones(productos) {
        productos = productos || "";
        totalItems = productos.length;

        var finalProductos = [];
        var promociones = [];
        if (productos !== "") {
            $.each(productos, function (index, item) {
                if (item.TienePremio) {
                    promociones.push(item);
                }
            });
        }
        var notPromo = productos.filter(function (promo) {
            return promo.TienePremio == false;
        });
        var misPromociones = { "Promociones": promociones };

        //notPromo.push(misPromociones);
        if (notPromo.length == 1)
            notPromo.insert(1, misPromociones);
        else if (notPromo.length == 0)
            notPromo.insert(0, misPromociones);
        else
            notPromo.insert(2, misPromociones);
        
        finalProductos = notPromo;

        return finalProductos;
    }
    Array.prototype.insert = function (index, item) {
        this.splice(index, 0, item);
    };

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        setTimeout(function () {
            _funciones.ModificarAnchoBuscadorFiltros();
        }, 1000);
    }

    return {
        Inicializar: Inicializar
    };
})();

$(document).ready(function () {

    BuscadorModule.Inicializar();

});