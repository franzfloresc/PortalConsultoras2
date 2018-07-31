var BuscadorPortalConsultoras;

$(document).ready(function () {
    'use strict';

    var BuscadorSB;

    BuscadorSB = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('keyup', '#CampoBuscadorProductos', me.Eventos.AccionesCampoBusquedaAlDigitar);
                $(document).on('click', '.opcion_limpiar_campo_busqueda_productos', me.Eventos.LimpiarCampoBusqueda);
            },
            ModificarAnchoBuscadorFiltros: function () {
                if (window.location.href.indexOf("Pedido") > -1) {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria_vista_pedido');
                    } else {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria_vista_pedido');
                    }
                } else if (window.location.href.indexOf("Ofertas") > -1) {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria_vista_ofertas');
                    } else {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria_vista_ofertas');
                    }
                } else {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria');
                    } else {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria');
                    }
                }
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaAlDigitar: function () {
                var cantidadCaracteresParaMostrarSugerenciasBusquedaMobile = $(this).val().length;
                if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile > 0) {
                    $(this).addClass('campo_buscador_productos_activo');
                    $('.campo_busqueda_fondo_on_focus').fadeIn(100);
                    $('.lista_resultados_busqueda_productos').delay(50);
                    $('.lista_resultados_busqueda_productos').fadeIn(100);
                    $('.enlace_busqueda_productos').fadeOut(100);
                    $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                    $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);

                    if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= CaracteresBuscador) {
                        var service = $.ajax({
                            url: baseUrl + "Buscador/BusquedaProductos",
                            method: 'POST',
                            data: {
                                busqueda: $(this).val()
                            }
                        });

                        var successBusqueda = function (r) {
                            console.log(r);
                        }

                        service.then(successBusqueda, function (e) {
                            console.log(e);
                        });
                    }

                } else {
                    $('.lista_resultados_busqueda_productos').fadeOut(100);
                    $('.campo_busqueda_fondo_on_focus').delay(50);
                    $('.campo_busqueda_fondo_on_focus').fadeOut(100);
                    $(this).removeClass('campo_buscador_productos_activo');
                    $('.opcion_limpiar_campo_busqueda_productos').fadeOut(100);
                    $('.enlace_busqueda_productos').delay(50);
                    $('.enlace_busqueda_productos').fadeIn(100);
                }
            },
            LimpiarCampoBusqueda: function (e) {
                e.preventDefault();
                $(this).fadeOut(100);
                $('.enlace_busqueda_filtros').delay(50);
                $('.enlace_busqueda_filtros').fadeIn(100);
                $('#CampoBuscadorProductos').val('');
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
            me.Funciones.ModificarAnchoBuscadorFiltros();
        }
    }

    BuscadorPortalConsultoras = new BuscadorSB();
    BuscadorPortalConsultoras.Inicializar();

});