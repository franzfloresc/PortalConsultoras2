var BuscadorPortalConsultorasMobile;

$(document).ready(function () {
    'use strict';

    var BuscadorSBMobile;

    BuscadorSBMobile = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {                
                $(document).on('keyup', '#CampoBuscadorProductosMobile', me.Eventos.AccionesCampoBusquedaMobileAlDigitar);
                $(document).on('click', '.opcion_limpiar_campo_busqueda_productos', me.Eventos.LimpiarCampoBusqueda);
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaMobileAlDigitar: function () {
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
                $('#CampoBuscadorProductosMobile').val('');
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    BuscadorPortalConsultorasMobile = new BuscadorSBMobile();
    BuscadorPortalConsultorasMobile.Inicializar();

});