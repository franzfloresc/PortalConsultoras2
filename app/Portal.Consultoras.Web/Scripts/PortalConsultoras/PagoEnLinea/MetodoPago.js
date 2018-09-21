var PagoEnLineaMetodoPago;
var colorBoton = colorBoton || "";
var metodoPagoPasarelaVisa = metodoPagoPasarelaVisa || "";
var metodoPagoPasarelaBelcorpPayU = metodoPagoPasarelaBelcorpPayU || "";
var tipoOrigenPantalla = tipoOrigenPantalla || 0;
var urlPasarelaPago = urlPasarelaPago || "";

$(document).ready(function () {
    //'use strict';
 
    listarBancos();
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
                    //$(document).on('click', '.area_activa_barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                    $(document).on('click', '.opcionPagoMobile', me.Eventos.MostrarDetalleTipoPago);
                    $(document).on('click', '.opcionPagoDesktop', me.Eventos.MostrarDetalleTipoPago);
                    $(document).on('click', 'button[data-metodopago]', me.Eventos.ContinuarPasarelaPago);
                    $(document).on('click', 'a[data-tipovisualizacion]', me.Eventos.AbrirPopupTerminosYCondiciones);
                    $(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
                    $(document).on('click', '.enlace_ver_mas_opciones_banca_por_internet', me.Eventos.VerMasOpcionesBancaPorInternet);
                },
                InicializarAcciones: function () {
                    //me.globals.barraActivacion.toggleClass('activado');
                    var boton = $("button[type='submit']")[0];

                    if (boton) {
                        $(boton).css("background", colorBoton);
                        $(boton).addClass("btn_pago_tarjeta_credito");
                        $(boton).addClass("w-100");
                        $(boton).addClass("text-uppercase");
                        $(boton).addClass("text-bold");
                        //$(boton).css("width", "100%");
                        //$(boton).css("font-family", "Lato");
                        //$(boton).css("border-radius", "0%");
                        //$(boton).css("letter-spacing", "0.5px");

                        //if (tipoOrigenPantalla == 1)
                        //    $(boton).css("max-width", "308px");

                        $(boton).html("PAGA CON VISA");
                    }

                    var esPagoEnLineaMobile = window.matchMedia("(max-width:991px)").matches;

                    if (esPagoEnLineaMobile) {
                        var listaOpcionPago = me.globals.listaOpcionPagoMobile;
                    } else {
                        var listaOpcionPago = me.globals.listaOpcionPagoDesktop;
                    }

                    if (listaOpcionPago) {
                        var cantidad = listaOpcionPago.length;

                        if (cantidad > 0) {
                            $(listaOpcionPago)[0].click();
                        }
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
                MostrarDetalleTipoPago: function () {
                    var siTipoPagoDetalleSeMuestra = $(this).next().css('display');

                    if (siTipoPagoDetalleSeMuestra == 'block') {
                        $(this).next().slideUp(200);
                        $(this).find('.icono_flecha_despliegue').removeClass('girar180');
                        if (window.matchMedia("(max-width:991px)").matches) {
                            if (!($('.enlace_ver_mas_opciones_banca_por_internet').is(':visible'))) {
                                $('.segundo_listado').fadeOut(100);
                                $('.enlace_ver_mas_opciones_banca_por_internet').delay(50);
                                $('.enlace_ver_mas_opciones_banca_por_internet').fadeIn(100);
                            }
                        }
                    } else {
                        $('.opcion_pago_contenido_visible_al_desplegar').slideUp(200);
                        $('.icono_flecha_despliegue').removeClass('girar180');
                        $(this).next().slideDown(200);
                        $(this).find('.icono_flecha_despliegue').addClass('girar180');
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
                ContinuarPasarelaPago: function (e) {
                    e.preventDefault();

                    var metodoPago = $(this).data("metodopago");

                    if (metodoPago == metodoPagoPasarelaBelcorpPayU) {
                        var medioPago = $(this).data("mediopago");
                        var cardType = $(this).data("tipotarjeta");
                        window.location.href = urlPasarelaPago + "?cardType=" + cardType + "&medio=" + medioPago;
                    }

                    //alert("123");
                },
                VerMasOpcionesBancaPorInternet: function(e) {
                    e.preventDefault();
                    $(this).fadeOut(100);
                    $('.segundo_listado').delay(50);
                    $('.segundo_listado').fadeIn(100);
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

function listarBancos() {
    var raiz = document.getElementById("hdfUrlRaiz").value;
    var urlBase = window.location.protocol + '//' + window.location.host + raiz;
    window.sessionStorage.setItem("urlBase", urlBase);

    var content = "";
    $.ajax({
        type: 'POST',
        url: urlBase + 'PagoEnLinea/ObtenerBancos',
        dataType: "Text",
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response == '1') {
                document.getElementById('divOpciones').style.display = 'block'; 
                return false;
            }
            var result = response.split('¬');
            content += "<p class='texto_informativo_lista_bancos'>Te redireccionaremos al banco que elijas.</p>";
            content += "<ul class='listado_bancos'>";
            for (var i = 0; i < result.length; i++) {
                var fila = result[i].split('¦');
                content += "<li class='banco_nombre'>";
                content += "<a href='" + fila[1] + "' title='" + fila[0]+"' class='enlace_banco' target='_blank'>";
                content += " <img src=" + fila[2] + " alt='" + fila[0] + "' /> </a> </li>";
            }
            content += "</ul>";
            document.getElementById('ullistaBancos').innerHTML = content;
            document.getElementById('divBancaPorInternet').style.display = 'block';
            document.getElementById('divOpciones').style.display = 'block'; 
        },
        error: function () {
            alert("error");
        }
    });

}