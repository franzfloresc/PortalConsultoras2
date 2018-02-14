﻿var PedidoEnLinea;

var rutaPagoVisa = rutaPagoVisa || '';
var rutaGuardarDatosPago = rutaGuardarDatosPago || '';
var tipoOrigenPantalla = tipoOrigenPantalla || 0;

$(document).ready(function () {
    'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.globals = {
            barraActivacion : $('.barra_activacion')
        },

        me.Funciones = {
            InicializarEventos: function () {                
                $(document).on('click', '.opcion_pago', me.Eventos.SeleccionarTipoPago);
                $(document).on('click', '.opcionPagoDesktop', me.Eventos.SeleccionarTipoPago);
                $(document).on('click', '.area_activa_barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.ver_terminos_y_condiciones', me.Eventos.AbrirPopupTerminosYCondiciones);
                $(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
                $(document).on('click', '.btn_continuar', me.Eventos.MostrarTooltipAceptarTerminosYCondiciones);
                $(document).on('keyup', '#txtMontoParcial', me.Eventos.ObtenerMontosPagoParcial);
                $(document).on('click', '#btnPagarVisa', me.Eventos.PagarConVisaPaso1);
            },
            InicializarAcciones: function () {
                me.globals.barraActivacion.toggleClass('activado');
                me.globals.barraActivacion.attr('data-estado', 1);
                //$('.tooltip_terminos_y_condiciones').fadeOut();
                //$("#divTooltipTerminosCondiciones").hide();
            }
        },
        me.Eventos = {
            SeleccionarTipoPago: function () {
                var opcionSeleccionada = $(this).find('input[type="radio"]');
                opcionSeleccionada.prop('checked', true);

                var esPagoTotal = $("#rbPagoTotal").is(':checked');

                if (esPagoTotal) {
                    $("#spnMontoGastosAdministrativos").html($("#hdMontoGastosAdministrativosString").val());
                    $("#txtMontoParcial").val("");
                } else {
                    $("#spnMontoGastosAdministrativos").html(DecimalToStringFormat(0));
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
                    $("#divTooltipTerminosCondiciones").hide();                    
                } else {
                    me.globals.barraActivacion.attr('data-estado', 0);                    
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

                $("#spnMontoGastosAdministrativos").html(DecimalToStringFormat(montoGastos))
            },
            PagarConVisaPaso1: function (e) {
                e.preventDefault();

                var montoDeuda = 0;
                var esPagoTotal = $("#rbPagoTotal").is(':checked');

                if (esPagoTotal) {
                    montoDeuda = $.trim($("#hdMontoDeuda").val());
                } else {
                    montoDeuda = $.trim($("#txtMontoParcial").val());
                }

                if ($.trim(montoDeuda) == "" || parseFloat(montoDeuda).toFixed(2) < 0.50) {
                    AbrirMensaje("El monto a pagar debe ser mayor o igual a 0.50");
                    return false;
                }

                var montoTotal = $.trim($("#hdMontoDeuda").val());
                if (parseFloat(montoDeuda).toFixed(2) > parseFloat(montoTotal)) {
                    AbrirMensaje("El monto a pagar excede tu deuda, por favor ingresa otro monto");
                    return false;
                }

                if (!(me.globals.barraActivacion).is('.activado')) {

                    if (tipoOrigenPantalla == 2) {
                        $('body,html').animate({
                            scrollTop: $(document).height()
                        }, 1000);
                    }
                    
                    $('.tooltip_terminos_y_condiciones').fadeIn();

                    return false;
                } else {
                    $('.tooltip_terminos_y_condiciones').fadeOut();
                }

                var parametros = {
                    MontoDeuda: parseFloat(montoDeuda).toFixed(2),
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
            me.Funciones.InicializarAcciones();
        }
    }

    PedidoEnLinea = new mainPL();

    PedidoEnLinea.Inicializar();

});