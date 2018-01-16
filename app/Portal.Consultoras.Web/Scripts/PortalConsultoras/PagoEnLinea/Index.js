var PedidoEnLinea;

$(document).ready(function () {
    'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                //$(document).on('click', '.barra_activacion_edicion_monto_a_pagar', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.opcion_pago', me.Eventos.SeleccionarTipoPago);
                $(document).on('click', '.area_activa_barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.ver_terminos_y_condiciones', me.Eventos.AbrirPopupTerminosYCondiciones);
                $(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
            }
        },
        me.Eventos = {
            SeleccionarTipoPago: function () {
                var opcionSeleccionada = $(this).find('input[type="radio"]');
                opcionSeleccionada.prop('checked', true);
            },
            AceptarTerminosYCondiciones: function (e) {
                var barraActivacion = $('.barra_activacion');
                barraActivacion.toggleClass('activado');
                if (barraActivacion.is('.activado')) {
                    barraActivacion.attr('data-estado', 1);
                    // $('.tooltip_terminos_y_condiciones').fadeOut();
                    console.log('Has aceptado los términos y condiciones');
                } else {
                    barraActivacion.attr('data-estado', 0);
                    console.log('No has aceptado los términos y condiciones');
                }
            },
            AbrirPopupTerminosYCondiciones: function (e) {
                e.preventDefault();
                $('.fondo_modal').fadeIn(300);
            },
            CerrarPopupTerminosYCondiciones: function (e) {
                e.preventDefault();
                $('.fondo_modal').fadeOut(300);
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    PedidoEnLinea = new mainPL();

    PedidoEnLinea.Inicializar();

});