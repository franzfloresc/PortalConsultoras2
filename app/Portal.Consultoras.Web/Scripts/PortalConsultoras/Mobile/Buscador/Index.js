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
                if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile > 0) {
                    $('.vistaResultadosBusquedaMobile').delay(50);
                    $('.vistaResultadosBusquedaMobile').fadeIn(100);
                    $('.enlace_busqueda_filtros').fadeOut(100);
                    $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                    $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);
                } else {
                    $('.vistaResultadosBusquedaMobile').fadeOut(100);
                    $('.opcion_limpiar_campo_busqueda_productos').fadeOut(100);
                    $('.enlace_busqueda_filtros').delay(50);
                    $('.enlace_busqueda_filtros').fadeIn(100);
                }

                if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= CaracteresBuscador) {
                    console.log($(this).val());
                    //aquí va el metodo que llama el api
                }
            },
            LimpiarCampoBusqueda: function (e) {
                e.preventDefault();
                $('.vistaResultadosBusquedaMobile').fadeOut(100);
                $(this).fadeOut(100);
                $('.enlace_busqueda_filtros').delay(50);
                $('.enlace_busqueda_filtros').fadeIn(100);
                $('#CampoBuscadorProductosMobile').val('');
                $('#CampoBuscadorProductosMobile').trigger('focus');
            }


        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    BuscadorPortalConsultorasMobile = new BuscadorSBMobile();
    BuscadorPortalConsultorasMobile.Inicializar();

});