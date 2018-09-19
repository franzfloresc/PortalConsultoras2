var PedidoEnLinea;

var urlPasarelaPago = urlPasarelaPago || '';
var rutaGuardarDatosPago = rutaGuardarDatosPago || '';
var tipoOrigenPantalla = tipoOrigenPantalla || 0;

$(document).ready(function () {
    'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.globals = {
            barraActivacion: $('.barra_activacion'),
            listaOpcionPagoMobile: $(".opcionPagoMobile"),
            listaOpcionPagoDesktop: $(".opcionPagoDesktop")
        },

        me.Funciones = {
            InicializarEventos: function () {                
                $(document).on('click', '.opcionPagoMobile', me.Eventos.MostrarDetalleTipoPago);
                $(document).on('click', '.opcionPagoDesktop', me.Eventos.MostrarDetalleTipoPago);
                $(document).on('click', 'a[data-tipovisualizacion]', me.Eventos.AbrirPopupTerminosYCondiciones);
                $(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
                $(document).on('keyup', '#txtMontoParcial', me.Eventos.ObtenerMontosPagoParcial);
                $(document).on('click', '#txtMontoParcial', me.Eventos.OnClickTxtMontoParcial);
                //$(document).on('click', '#btnPagarVisa', me.Eventos.PagarConVisaPaso1);
                $(document).on('click', '#divMetodoPagoVisa', me.Eventos.MarcacionMetodoPago);
                $(document).on('click', '#btnPagoTotal', me.Eventos.PagoTotal);
                $(document).on('click', '#btnPagoParcial', me.Eventos.PagoParcial);
            },
            InicializarAcciones: function () {
                me.globals.barraActivacion.toggleClass('activado');
                me.globals.barraActivacion.attr('data-estado', 1);

                var esPagoEnLineaMobile = tipoOrigenPantalla == 2;

                var listaOpcionPago;
                if (esPagoEnLineaMobile) {
                    listaOpcionPago = me.globals.listaOpcionPagoMobile;
                } else {
                    listaOpcionPago = me.globals.listaOpcionPagoDesktop;
                }
                
                if (listaOpcionPago) {
                    var cantidad = listaOpcionPago.length;

                    if (cantidad > 0) {
                        $(listaOpcionPago)[0].click();
                    }
                }
            },
            GuardarMontos: function(montoDeuda, porcentajeGastosAdministrativos) {

                var parametros = {
                    MontoDeuda: parseFloat(montoDeuda).toFixed(2),
                    PorcentajeGastosAdministrativos: porcentajeGastosAdministrativos
                };

                jQuery.ajax({
                    type: 'POST',
                    url: rutaGuardarDatosPago,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(parametros),
                    async: false,
                    success: function (response) {
                        if (response.success) {
                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Pago en Línea',
                                'action': 'Clic en Botón',
                                'label': 'Continuar a Confirmar Monto'
                            });
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            resultado = "";
                        }
                    }
                });
            },
            RealizarPago: function() {
                if (pasarelaActual == metodoPagoPasarelaVisa) {
                    window.location.href = rutaPagoVisa;

                    return;
                }

                if (pasarelaActual == metodoPagoPasarelaBelcorpPayU) {

                    window.location.href = urlPasarelaPago;
                    return;
                }
            },
            CargarPasarelaVisa: function() {

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
            MostrarDetalleTipoPago: function () {
                var siTipoPagoDetalleSeMuestra = $(this).next().css('display');

                if (siTipoPagoDetalleSeMuestra == 'block') {
                    $(this).next().slideUp(200);
                    $(this).find('.icono_flecha_despliegue').removeClass('girar180');
                } else {
                    $('.opcion_pago_contenido_visible_al_desplegar').slideUp(200);
                    $('.icono_flecha_despliegue').removeClass('girar180');
                    $(this).next().slideDown(200);
                    $(this).find('.icono_flecha_despliegue').addClass('girar180');
                }
            },
            OnClickTxtMontoParcial: function(e) {
                var visible = $('#pnParcial').is(':visible');
                if (visible) {
                    e.preventDefault();
                    e.stopPropagation();
                } else {
                    $('.opcion_pago_contenido_visible_al_desplegar').slideUp(200);
                    $('.icono_flecha_despliegue').removeClass('girar180');
                    $(this).next().slideDown(200);
                    $(this).find('.icono_flecha_despliegue').addClass('girar180');
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

                var contenedorPadre = $(this).parents('.aceptar_terminos_y_condiciones')[0];

                var htmlTerminosCondiciones = $(contenedorPadre).find('input[data-terminos]').val();
                $('#divContenidoTerminosCondiciones').html(htmlTerminosCondiciones);
                $('.proceso_de_pago_en_linea').fadeOut(200);
                $('body,html').animate({
                    scrollTop: 47
                }, 200);
                $('.popup_terminos_y_condiciones').fadeIn(200);
            },
            CerrarPopupTerminosYCondiciones: function (e) {
                e.preventDefault();
                $(this).parents('.popup_terminos_y_condiciones').fadeOut(200);
                $('.proceso_de_pago_en_linea').fadeIn(200);
            },
            ObtenerMontosPagoParcial: function (e) {
                var montoParcial = parseFloat($(this).val());
                var porcentaje = parseFloat($("#hdPorcentajeGastosAdministrativos").val());

                var montoGastos = montoParcial * (porcentaje / 100);                

                $("#spnMontoParcial").html(DecimalToStringFormat(montoParcial));
                $("#spnMontoGastosAdministrativos").html(DecimalToStringFormat(montoGastos));
                $("#spnMontoParcialConGastos").html(DecimalToStringFormat(montoParcial + montoGastos));
            },
            PagoTotal: function (e) {
                e.preventDefault();
                e.stopPropagation();

                var montoDeuda = $.trim($("#hdMontoDeuda").val());

                if ($.trim(montoDeuda) == "" || parseFloat(montoDeuda).toFixed(2) < 0.50) {
                    AbrirMensaje("El monto a pagar debe ser mayor o igual a 0.50");
                    return false;
                }

                var porcentajeGastosAdministrativos = $("#hdPorcentajeGastosAdministrativos").val();
                me.Funciones.GuardarMontos(montoDeuda, porcentajeGastosAdministrativos);

                me.Funciones.RealizarPago();
            },
            PagoParcial: function (e) {
                e.preventDefault();
                e.stopPropagation();

                var montoDeuda = $.trim($("#txtMontoParcial").val());

                if ($.trim(montoDeuda) == "" || parseFloat(montoDeuda).toFixed(2) < 0.50) {
                    AbrirMensaje("El monto a pagar debe ser mayor o igual a 0.50");
                    return false;
                }

                var montoTotal = $.trim($("#hdMontoDeuda").val());
                if (parseFloat(montoDeuda).toFixed(2) > parseFloat(montoTotal)) {
                    AbrirMensaje("El monto a pagar excede tu deuda, por favor ingresa otro monto");
                    return false;
                }

                var porcentajeGastosAdministrativos = $("#hdPorcentajeGastosAdministrativos").val();
                me.Funciones.GuardarMontos(montoDeuda, porcentajeGastosAdministrativos);  

                me.Funciones.RealizarPago();
            },
            MarcacionMetodoPago: function (e) {
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Pago en Línea',
                    'action': 'Clic en Método de Pago',
                    'label': 'Tarjeta de Crédito Visa'
                });
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
            me.Funciones.InicializarAcciones();
        }
    }

    PedidoEnLinea = new mainPL();

    PedidoEnLinea.Inicializar();
});