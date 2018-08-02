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
            },
            CampoDeBusquedaMobileConCaracteres: function () {
                $('.vistaResultadosBusquedaMobile').delay(50);
                $('.vistaResultadosBusquedaMobile').fadeIn(100);
                $('.enlace_busqueda_filtros').fadeOut(100);
                $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);
            },
            CampoDeBusquedaMobileSinCaracteres: function (element) {
                $('.vistaResultadosBusquedaMobile').fadeOut(100);
                $(element).fadeOut(100);
                $('.enlace_busqueda_filtros').delay(50);
                $('.enlace_busqueda_filtros').fadeIn(100);
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaMobileAlDigitar: function () {
                var cantidadCaracteresParaMostrarSugerenciasBusquedaMobile = $(this).val().length;
                 if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= CaracteresBuscador) {
                    me.Funciones.CampoDeBusquedaMobileConCaracteres();
                    $('.spinner').fadeIn(150);
                    setTimeout(function () {
                        $('.spinner').delay(400);
                        $('.spinner').fadeOut(150);
                        $('#ResultadoBuscadorMobile').fadeIn(150);
                    }, 400);
                    console.log($(this).val());
                    //aquí va el metodo que llama el api
                 } else {
                    $('#ResultadoBuscadorMobile').fadeOut(150);
                    me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                }
            },
            LimpiarCampoBusqueda: function (e) {
                e.preventDefault();
                me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                $('#CampoBuscadorProductosMobile').val('');
                $('#CampoBuscadorProductosMobile').focus();
            }


        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    BuscadorPortalConsultorasMobile = new BuscadorSBMobile();
    BuscadorPortalConsultorasMobile.Inicializar();

});