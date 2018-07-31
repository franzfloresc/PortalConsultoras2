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
            },
            CampoBusquedaConCaracteres: function (campoBuscador) {
                $(campoBuscador).addClass('campo_buscador_productos_activo');
                $('.campo_busqueda_fondo_on_focus').fadeIn(100);
                $('.lista_resultados_busqueda_productos').delay(50);
                $('.lista_resultados_busqueda_productos').fadeIn(100);
                $('.enlace_busqueda_productos').fadeOut(100);
                $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);
            },
            CampoBusquedaSinCaracteres: function (element) {
                $('.lista_resultados_busqueda_productos').fadeOut(100);
                $('.campo_busqueda_fondo_on_focus').delay(50);
                $('.campo_busqueda_fondo_on_focus').fadeOut(100);
                $(element).removeClass('campo_buscador_productos_activo');
                $('.opcion_limpiar_campo_busqueda_productos').fadeOut(100);
                $('.enlace_busqueda_productos').delay(50);
                $('.enlace_busqueda_productos').fadeIn(100);
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaAlDigitar: function () {
                var cantidadCaracteresParaMostrarSugerenciasBusqueda = $(this).val().length;
                if (cantidadCaracteresParaMostrarSugerenciasBusqueda > 0) {
                    me.Funciones.CampoBusquedaConCaracteres($('#CampoBuscadorProductos'));
                    if (cantidadCaracteresParaMostrarSugerenciasBusqueda >= CaracteresBuscador) {
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
                    me.Funciones.CampoBusquedaSinCaracteres($(this));
                }
            },
            LimpiarCampoBusqueda: function (e) {
                e.preventDefault();
                me.Funciones.CampoBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                $('#CampoBuscadorProductos').val('');
                $('#CampoBuscadorProductos').trigger('focus');
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