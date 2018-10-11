var BuscadorPortalConsultoras;
var xhr = null;

var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();

var BuscadorModule = (function(){

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
        botonVerTodos: "#BotonVerTodosResultados"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        caracteresBuscador: CaracteresBuscador,
        totalResultadosBuscador: TotalResultadosBuscador,
        urlBusquedaProducto: "/BusquedaProductos",
        aplicarLogicaCantidadBotonVerTodos: (AplicarLogicaCantidadBotonVerTodos === 'true')

};
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
            if (!_config.isMobile) {
                $(document).on("click", _elementos.body, _eventos.CerrarResultadosBusqueda);
                $(document).on("focus", _elementos.campoBuscadorProductos, _eventos.OcultarTooltipInformativo);
            }

            $(document).on("keyup", _elementos.campoBuscadorProductos, _eventos.AccionesCampoBusquedaAlDigitar);
            $(document).on("click", _elementos.opcionLimpiarBusqueda, _eventos.LimpiarCampoBusqueda);
            $(document).on("click", _elementos.agregarProducto, _eventos.AgregarProducto);
            $(document).on("click", _elementos.redireccionarFicha, _eventos.RedireccionarAFichaDeFotoYDescripcion);
            $(document).on("click", _elementos.botonVerTodos, _eventos.ClickVerTodos);
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

            if (valorBusqueda.length >= _config.caracteresBuscador) {
                _funciones.CampoDeBusquedaConCaracteres($("#CampoBuscadorProductos"));
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
                        }
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
                        } else {

                            $.each(r.productos, function (index, item) {
                                item.posicion = index + 1;
                                if (item.Descripcion.length > TotalCaracteresEnListaBuscador) {
                                    item.Descripcion = item.Descripcion.substring(0, TotalCaracteresEnListaBuscador) + "...";
                                }
                            });                            

                            SetHandlebars("#js-ResultadoBuscador", r.productos, "#ResultadoBuscador");

                            setTimeout(function () {
                                if ($(".busqueda_sin_resultados").is(":visible")) {
                                    $(".busqueda_sin_resultados").fadeOut(60);
                                }
                                $(".spinner").fadeOut(150);
                                $("#ResultadoBuscador").delay(50);
                                $("#ResultadoBuscador").fadeIn(100);
                                if (!_config.isMobile) {
                                    $(".lista_resultados_busqueda_productos").animate({
                                        'min-height': $("#ResultadoBuscador").height() + 43
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

            } else {
                if(!_config.isMobile) _funciones.CampoDeBusquedaSinCaracteres($(this));
                if ($(".busqueda_sin_resultados").is(":visible")) {
                    $(".busqueda_sin_resultados").fadeOut(60);
                }
                $("#ResultadoBuscador").fadeOut(150);
                if (_config.isMobile) _funciones.CampoDeBusquedaSinCaracteres($(".opcion_limpiar_campo_busqueda_productos"));
                else _funciones.CampoDeBusquedaSinCaracteres($("#CampoBuscadorProductos"));
            }
        },
        LimpiarCampoBusqueda: function (e) {
            e.preventDefault();
            if (_config.isMobile) _funciones.CampoDeBusquedaSinCaracteres($(".opcion_limpiar_campo_busqueda_productos"));
            else _funciones.CampoDeBusquedaSinCaracteres($("#ResultadoBuscador"));
            $("#CampoBuscadorProductos").val("");
            $("#CampoBuscadorProductos").focus();
            $("#ResultadoBuscador").html("");
        },
        CerrarResultadosBusqueda: function (e) {
            //e.preventDefault();
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
            BuscadorProvider.RegistroProductoBuscador(divPadre);
        },
        RedireccionarAFichaDeFotoYDescripcion: function (e) {
            e.preventDefault();
            var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
            var codigoEstrategia = $(divPadre).find(".hdBuscadorCodigoTipoEstrategia").val();
            var codigoCampania = $(divPadre).find(".hdBuscadorCampaniaID").val();
            var codigoCuv = $(divPadre).find(".hdBuscadorCUV").val();
            var OrigenPedidoWeb = $(divPadre).find(".hdBuscadorOrigenPedidoWeb").val();

            var codigo = ["030", "005", "001", "007", "008", "009", "010", "011"];

            if (codigo.indexOf(codigoEstrategia) >= 0) {
                var UrlDetalle = GetPalanca(codigoEstrategia);
                if (UrlDetalle == "") return false;
                UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
                //console.log(UrlDetalle);
                window.location = UrlDetalle;
                return true;
            }
        },
        ClickVerTodos: function() {
            var valorBusqueda = $(_elementos.campoBuscadorProductos).val();
            var url = _config.urlBusquedaProducto + "?q=" + valorBusqueda;
            window.location.href = url;
        }
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