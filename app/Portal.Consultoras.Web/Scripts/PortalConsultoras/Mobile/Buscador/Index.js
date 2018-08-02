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
                $('.enlace_busqueda_filtros').fadeOut(100);
                $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);
            },
            CampoDeBusquedaMobileSinCaracteres: function (element) {
                $(element).fadeOut(100);
                $('.enlace_busqueda_filtros').delay(50);
                $('.enlace_busqueda_filtros').fadeIn(100);
                $('#ResultadoBuscadorMobile').html('');
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaMobileAlDigitar: function () {
                var cantidadCaracteresParaMostrarSugerenciasBusquedaMobile = $(this).val().length;
                 if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= CaracteresBuscador) {
                    me.Funciones.CampoDeBusquedaMobileConCaracteres();
                     $('.spinner').fadeIn(150);

                     var service = $.ajax({
                         url: baseUrl + "Mobile/Buscador/BusquedaProductos",
                         method: 'POST',
                         data: {
                             busqueda: $(this).val()
                         }
                     });


                     var successBusqueda = function (r) {

                         $.each(r, function (index, item) {
                             item.posicion = index + 1;
                             if (item.Descripcion.length > TotalCaracteresEnListaBuscador) {
                                 item.Descripcion = item.Descripcion.substring(0, TotalCaracteresEnListaBuscador) + '...';
                             }
                         });

                         var lista = r;

                         if (lista.length <= 0) {
                             $('#ResultadoBuscadorMobile').fadeOut(150);
                             me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                         } else {
                             $('#ResultadoBuscadorMobile').html('');
                             SetHandlebars('#js-ResultadoBuscadorMobile', lista, '#ResultadoBuscadorMobile');
                         }

                         setTimeout(function () {
                             $('.spinner').delay(50);
                             $('.spinner').fadeOut(150);
                             $('#ResultadoBuscadorMobile').fadeIn(150);
                         }, 400);
                     }
                     service.then(successBusqueda, function (e) {
                         console.log(e);
                     });                    
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
            },
            AgregarProducto: function (e) {
                e.preventDefault();

            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    BuscadorPortalConsultorasMobile = new BuscadorSBMobile();
    BuscadorPortalConsultorasMobile.Inicializar();

});