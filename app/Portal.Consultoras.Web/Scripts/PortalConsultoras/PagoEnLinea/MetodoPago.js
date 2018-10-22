var PagoEnLineaMetodoPago;
var tipoOrigenPantalla = tipoOrigenPantalla || 0;
var urlPagoMonto = urlPagoMonto || "";
var rutaGuardarDatosPago = rutaGuardarDatosPago || '';

$(document).ready(function () {
    //'use strict';

    var mainPL;

    mainPL = function () {
        var me = this;

        me.globals = {
            barraActivacion: $('.barra_activacion'),
            listaOpcionPagoMobile: $(".opcionPagoMobile"),
            listaOpcionPagoDesktop: $(".opcionPagoDesktop")
        };
        me.Funciones = {
            InicializarEventos: function() {
                //$(document).on('click', '.area_activa_barra_activacion', me.Eventos.AceptarTerminosYCondiciones);
                $(document).on('click', '.opcionPagoMobile', me.Eventos.MostrarDetalleTipoPago);
                $(document).on('click', '.opcionPagoDesktop', me.Eventos.MostrarDetalleTipoPago);
                //$(document).on('click', 'a[data-tipovisualizacion]', me.Eventos.AbrirPopupTerminosYCondiciones);
                //$(document).on('click', '.cerrar_popup_terminos_y_condiciones', me.Eventos.CerrarPopupTerminosYCondiciones);
                //$(document).on('click', '.enlace_ver_mas_opciones_banca_por_internet', me.Eventos.VerMasOpcionesBancaPorInternet);
            },
            InicializarAcciones: function() {
                me.Funciones.listarBancos();
            },
            listarBancos: function() {
                var raiz = document.getElementById("hdfUrlRaiz").value;
                var urlBase = window.location.protocol + '//' + window.location.host + raiz;

                var content = "";
                $.ajax({
                    type: 'POST',
                    url: urlBase + 'PagoEnLinea/ObtenerBancos',
                    dataType: "Text",
                    contentType: 'application/json; charset=utf-8',
                    success: function(response) {
                        if (response == '1') {
                            document.getElementById('divOpciones').style.display = 'block';
                            return false;
                        }
                        var result = response.split('¬');
                        content +=
                            "<p class='texto_informativo_lista_bancos'>Te redireccionaremos al banco que elijas.</p>";
                        content += "<ul class='listado_bancos'>";
                        var rutaIcono = "";
                        for (var i = 0; i < result.length; i++) {
                            var fila = result[i].split('¦');
                            content += "<li class='banco_nombre'>";
                            content += "<a href='" +
                                fila[1] +
                                "' title='" +
                                fila[0] +
                                "' class='enlace_banco' target='_blank'>";
                            content += " <img src=" + fila[2] + " alt='" + fila[0] + "' /> </a> </li>";
                            rutaIcono = fila[3];
                        }
                        document.getElementById('divIcono').innerHTML =
                            "<img src='" + rutaIcono + "' alt= 'Pagos Banca por Internet' /> ";

                        content += "</ul>";
                        document.getElementById('ullistaBancos').innerHTML = content;
                        document.getElementById('divBancaPorInternet').style.display = 'block';
                        document.getElementById('divOpciones').style.display = 'block';
                    },
                    error: function() {
                        alert("error");
                    }
                });

            },
            GuardarMetodoPago: function(parametros) {

                jQuery.ajax({
                    type: 'POST',
                    url: rutaGuardarDatosPago,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(parametros),
                    async: true,
                    success: function(response) {
                        if (response.success) {
                            dataLayer.push({
                                'event': 'virtualEvent',
                                'category': 'Pago en Línea',
                                'action': 'Clic en Botón',
                                'label': 'Continuar a Confirmar Monto'
                            });

                            window.location.href = urlPagoMonto;
                        }
                    },
                    error: function(data, error) {
                        if (checkTimeout(data)) {
                        }
                    }
                });
            }
        };
        me.Eventos = {
            AceptarTerminosYCondiciones: function(e) {
                me.globals.barraActivacion.toggleClass('activado');
                if (me.globals.barraActivacion.is('.activado')) {
                    me.globals.barraActivacion.attr('data-estado', 1);
                    $('.tooltip_terminos_y_condiciones').fadeOut();
                    $("#divTooltipTerminosCondiciones").hide();
                } else {
                    me.globals.barraActivacion.attr('data-estado', 0);
                }
            },
            MostrarDetalleTipoPago: function() {
                var elm = $(this);
                var content = $.trim(elm.next().html());
                if (content == '') {
                    var parametros = {
                        id: elm.data("mediopagoid"),
                    };
                    me.Funciones.GuardarMetodoPago(parametros);

                    return;
                }

                var div = $(this);
                var element = div.next();
                var arrow = div.find('.icono_flecha_despliegue');

                if (element.is(':visible')) {
                    element.slideUp(200);
                    arrow.addClass('girar90n');
                } else {
                    arrow.removeClass('girar90n');
                    element.slideDown(200);
                }
            },
            VerMasOpcionesBancaPorInternet: function(e) {
                e.preventDefault();
                $(this).fadeOut(100);
                $('.segundo_listado').delay(50);
                $('.segundo_listado').fadeIn(100);
            }
        };
        me.Inicializar = function() {
            me.Funciones.InicializarEventos();
            me.Funciones.InicializarAcciones();
        };
    }

    PagoEnLineaMetodoPago = new mainPL();
    PagoEnLineaMetodoPago.Inicializar();
});