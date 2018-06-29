var PagoEnLineaMetodoPago;

$(document).ready(function () {

    'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        //me.globals = {
        //    barraActivacion: $('.barra_activacion')
        //},
        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('click', 'button[data-metodopago]', me.Eventos.ContinuarPasarelaPago);
            },
            InicializarAcciones: function () {

            }
        },
            me.Eventos = {
                ContinuarPasarelaPago: function (e) {
                    e.preventDefault();
                }
                //SeleccionarTipoPago: function () {
                //    var opcionSeleccionada = $(this).find('input[type="radio"]');
                //    opcionSeleccionada.prop('checked', true);

                //    var esPagoTotal = $("#rbPagoTotal").is(':checked');

                //    if (esPagoTotal) {
                //        $("#spnMontoGastosAdministrativos").html($("#hdMontoGastosAdministrativosString").val());
                //        $("#txtMontoParcial").val("");
                //    } else {
                //        $("#spnMontoGastosAdministrativos").html(DecimalToStringFormat(0));
                //    }
                //}
            },
            me.Inicializar = {
                me.Funciones.InicializarEventos();
                me.Funciones.InicializarAcciones();
            }
    }

    PagoEnLineaMetodoPago = new mainPL();
    PedidoEnLinea.Inicializar();
});