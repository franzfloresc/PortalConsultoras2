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
                $(document).on('click', '.barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.ver_terminos_y_condiciones', me.Eventos.AbrirPopupTerminosYCondiciones);
            }
        },
        me.Eventos = {
            SeleccionarTipoPago: function () {
                var opcionSeleccionada = $(this).find('input[type="radio"]');
                opcionSeleccionada.prop('checked', true);
            },
            AceptarTerminosYCondiciones: function () {
                $(this).toggleClass('activado');
                if ($(this).is('.activado')) {
                    $(this).attr('data-estado', 1);
                    // $('.tooltip_terminos_y_condiciones').fadeOut();
                    console.log('Has aceptado los términos y condiciones');
                } else {
                    $(this).attr('data-estado', 0);
                    console.log('No has aceptado los términos y condiciones');
                }
            },
            AbrirPopupTerminosYCondiciones: function () {
                console.log("Mostrar popup de términos y condiciones");
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    PedidoEnLinea = new mainPL();

    PedidoEnLinea.Inicializar();

});