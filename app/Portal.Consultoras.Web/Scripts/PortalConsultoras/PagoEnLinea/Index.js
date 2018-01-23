var PedidoEnLinea;

var rutaPagoVisa = rutaPagoVisa || '';
var rutaGuardarDatosPago = rutaGuardarDatosPago || '';

$(document).ready(function () {
    'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.globals = {
            barraActivacion : $('.barra_activacion')
        }

        me.Funciones = {
            InicializarEventos: function () {
                //$(document).on('click', '.barra_activacion_edicion_monto_a_pagar', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.opcion_pago', me.Eventos.SeleccionarTipoPago);
                $(document).on('click', '.area_activa_barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.ver_terminos_y_condiciones', me.Eventos.AbrirPopupTerminosYCondiciones);
                $(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
                $(document).on('click', '.btn_continuar', me.Eventos.MostrarTooltipAceptarTerminosYCondiciones);
                $(document).on('keyup', '#txtMontoParcial', me.Eventos.ObtenerMontosPagoParcial);
                $(document).on('click', '#btnPagarVisa', me.Eventos.PagarConVisaPaso1);
            }
        },
        me.Eventos = {
            SeleccionarTipoPago: function () {
                var opcionSeleccionada = $(this).find('input[type="radio"]');
                opcionSeleccionada.prop('checked', true);

                var esPagoTotal = $("#rbPagoTotal").is(':checked');

                if (esPagoTotal) {                    
                    $("#spnMontoGastosAdministrativos").html($("#hdMontoGastosAdministrativosString").val());
                    $("#spnMontoDeudaConGastosString").html($("#hdMontoDeudaConGastosString").val());
                    //$("#hdMontoFinal").val($("#hdMontoDeudaConGastos").val());
                } else {
                    $("#spnMontoGastosAdministrativos").html(DecimalToStringFormat(0));
                    $("#spnMontoDeudaConGastosString").html(DecimalToStringFormat(0));
                    //$("#hdMontoFinal").val(0);
                }
            },
            MostrarTooltipAceptarTerminosYCondiciones: function(){
                if (!(me.globals.barraActivacion).is('.activado')) {
                    $('body,html').animate({
                        scrollTop: $(document).height()
                    }, 1000);
                    $('.tooltip_terminos_y_condiciones').fadeIn();
                } else {
                    $('.tooltip_terminos_y_condiciones').fadeOut();
                }
            },
            AceptarTerminosYCondiciones: function (e) {
                me.globals.barraActivacion.toggleClass('activado');
                if (me.globals.barraActivacion.is('.activado')) {
                    me.globals.barraActivacion.attr('data-estado', 1);
                    $('.tooltip_terminos_y_condiciones').fadeOut();
                    console.log('Has aceptado los términos y condiciones');
                } else {
                    me.globals.barraActivacion.attr('data-estado', 0);
                    console.log('No has aceptado los términos y condiciones');
                }
            },
            AbrirPopupTerminosYCondiciones: function (e) {
                e.preventDefault();
                $('body').css({"overflow-y":"hidden"});
                $('.fondo_modal').fadeIn(300);
            },
            CerrarPopupTerminosYCondiciones: function (e) {
                e.preventDefault();
                $('body').css({ "overflow-y": "auto" });
                $('.fondo_modal').fadeOut(300);
            },
            ObtenerMontosPagoParcial: function (e) {
                var montoParcial = $(this).val();
                var porcentaje = parseFloat($("#spnPorcentajeGastosAdministrativos").html());

                var montoGastos = montoParcial * (porcentaje / 100);
                var montoParcialConGastos = montoParcial * (1 + porcentaje / 100);

                $("#spnMontoGastosAdministrativos").html(DecimalToStringFormat(montoGastos))

                //$("#hdMontoFinal").val(montoParcialConGastos)
                $("#spnMontoDeudaConGastosString").html(DecimalToStringFormat(montoParcialConGastos))
            },
            PagarConVisaPaso1: function (e) {
                e.preventDefault();

                var montoDeuda = 0;
                var esPagoTotal = $("#rbPagoTotal").is(':checked');

                if(esPagoTotal){
                    montoDeuda = $.trim($("#hdMontoDeuda").val());
                }else{
                    montoDeuda = $.trim($("#txtMontoParcial").val());
                }

                var parametros = {
                    MontoDeuda: montoDeuda,
                    PorcentajeGastosAdministrativos: $("#spnPorcentajeGastosAdministrativos").html()
                };

                jQuery.ajax({
                    type: 'POST',
                    url: rutaGuardarDatosPago,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(parametros),
                    async: true,
                    success: function (response) {
                        if (response.success)
                            window.location.href = rutaPagoVisa;
                    },
                    error: function (data, error) {                        
                        if (checkTimeout(data)) {
                        }
                    }
                });
            },
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    PedidoEnLinea = new mainPL();

    PedidoEnLinea.Inicializar();

});