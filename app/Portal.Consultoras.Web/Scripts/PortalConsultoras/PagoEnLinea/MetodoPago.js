var PagoEnLineaMetodoPago;
var colorBoton = colorBoton || "";
var metodoPagoPasarelaVisa = metodoPagoPasarelaVisa || "";
var tipoOrigenPantalla = tipoOrigenPantalla || 0;

$(document).ready(function () {
    //'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.globals = {
            barraActivacion: $('.barra_activacion')
        },
            me.Funciones = {
                InicializarEventos: function () {
                    //$(document).on('click', '.area_activa_barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                    $(document).on('click', 'button[data-metodopago]', me.Eventos.ContinuarPasarelaPago);
                    $(document).on('click', '#lnkAceptaTerminosCondiciones', me.Eventos.AbrirPopupTerminosYCondiciones);
                    $(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
                },
                InicializarAcciones: function () {
                    //me.globals.barraActivacion.toggleClass('activado');
                    var boton = $("button[type='submit']")[0];

                    if (boton) {
                        $(boton).css("background", colorBoton);
                        $(boton).css("width", "100%");
                        $(boton).css("font-family", "Lato");
                        $(boton).css("border-radius", "0%");
                        $(boton).css("letter-spacing", "0.5px");

                        if (tipoOrigenPantalla == 1)
                            $(boton).css("max-width", "308px");

                        $(boton).html("PAGA CON VISA");
                    }
                }
            },
            me.Eventos = {
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
                    $('body').css({ "overflow-y": "hidden" });
                    $('.fondo_modal').fadeIn(300);
                },
                CerrarPopupTerminosYCondiciones: function (e) {
                    e.preventDefault();
                    $('body').css({ "overflow-y": "auto" });
                    $('.fondo_modal').fadeOut(300);
                },
                ContinuarPasarelaPago: function (e) {
                    e.preventDefault();

                    var metodoPago = $(this).data("metodopago");

                    //alert("123");
                }
            },
            me.Inicializar = function () {
                me.Funciones.InicializarEventos();
                me.Funciones.InicializarAcciones();
            }
    }

    PagoEnLineaMetodoPago = new mainPL();
    PagoEnLineaMetodoPago.Inicializar();
});