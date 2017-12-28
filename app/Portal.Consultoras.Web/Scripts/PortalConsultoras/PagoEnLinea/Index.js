var PedidoEnLinea;

$(document).ready(function () {
    'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('click', '.barra_activacion_edicion_monto_a_pagar', me.Eventos.ActivarOpcion);
                $(document).on('click', '.barra_activacion.barra_activacion_terminos_condiciones', me.Eventos.ActivarOpcion);
            }
        },
        me.Eventos = {
            ActivarOpcion: function () {
                $(this).toggleClass('activado');
                if ($(this).is('.activado')) {
                    $(this).attr('data-estado', 1);
                    // $('.tooltip_terminos_y_condiciones').fadeOut();
                    console.log('Se activó opción');
                } else {
                    $(this).attr('data-estado', 0);
                    console.log('Se desactivó opción');
                }
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    PedidoEnLinea = new mainPL();

    PedidoEnLinea.Inicializar();

});