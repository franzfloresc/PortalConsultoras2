﻿var BuscadorPortalConsultoras;

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
                        $('.buscador_filtros').addClass('buscador_filtros_con_enlace_menu_socia_empresaria_vista_pedido');
                    } else {
                        $('.buscador_filtros').addClass('buscador_filtros_sin_enlace_menu_socia_empresaria_vista_pedido');
                    }
                } else if (window.location.href.indexOf("Ofertas") > -1) {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_filtros').addClass('buscador_filtros_con_enlace_menu_socia_empresaria_vista_ofertas');
                    } else {
                        $('.buscador_filtros').addClass('buscador_filtros_sin_enlace_menu_socia_empresaria_vista_ofertas');
                    }
                } else {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_filtros').addClass('buscador_filtros_con_enlace_menu_socia_empresaria');
                    } else {
                        $('.buscador_filtros').addClass('buscador_filtros_sin_enlace_menu_socia_empresaria');
                    }
                }
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaAlDigitar: function () {
                var cantidadCaracteresParaMostrarSugerenciasBusquedaMobile = $(this).val().length;
                if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= 3) {
                    $('.enlace_busqueda_filtros').fadeOut(250);
                    $('.opcion_limpiar_campo_busqueda_productos').delay(150);
                    $('.opcion_limpiar_campo_busqueda_productos').fadeIn(250);
                } else {
                    $('.opcion_limpiar_campo_busqueda_productos').fadeOut(250);
                    $('.enlace_busqueda_filtros').delay(150);
                    $('.enlace_busqueda_filtros').fadeIn(250);
                }
            },
            LimpiarCampoBusqueda: function (e) {
                e.preventDefault();
                $(this).fadeOut(250);
                $('.enlace_busqueda_filtros').delay(150);
                $('.enlace_busqueda_filtros').fadeIn(250);
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