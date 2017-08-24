
var misReclamosRegistro

$(document).ready(function () {
    'use strict';

    var PortalConsultorasReclamoRegistro;
    PortalConsultorasReclamoRegistro = function () {
        var me = this;

        me.Variables = {
            alturaListaMiSolicitud: $(document).height(),
            datosSolicitudOpened: ".datos_solicitud_opened",
            miSolicitudCDR: ".mi_solicitud_cdr",
            numSolicitudes: ".num_solicitudes",
            pestaniaVerMiSolicitud: ".pestania_ver_mi_solicitud",
            listadoProductosAgregados: ".listado_productos_agregados"
        };

        me.Eventos = {
            bindEvents: function () {

                $(me.Variables.miSolicitudCDR).click(function (e) {

                    e.stopPropagation();

                    $(me.Variables.numSolicitudes).fadeOut(150);

                    $(me.Variables.pestaniaVerMiSolicitud).addClass("crece");

                    $(me.Variables.miSolicitudCDR).animate({

                        "width": "222px"

                    }, 120, function () {

                        $(me.Variables.miSolicitudCDR).animate({

                            "height": "291px"

                        }, 220);

                    });

                    setTimeout(function () {

                        $(me.Variables.datosSolicitudOpened).fadeIn(200);

                    }, 220);

                });

                $("body, .ocultar_mi_solicitud").click(function (e) {

                    e.stopPropagation();

                    $(me.Variables.datosSolicitudOpened).fadeOut(200);

                    $(me.Variables.miSolicitudCDR).animate({

                        "height": "35px"

                    }, 220, function () {

                        $(me.Variables.pestaniaVerMiSolicitud).removeClass("crece");

                        $(me.Variables.miSolicitudCDR).animate({

                            "width": "35px"

                        }, 120);

                    });

                    setTimeout(function () {

                        $(me.Variables.numSolicitudes).fadeIn(200);

                    }, 450);

                });

                $(".enlace_ir_al_final a").click(function (e) {

                    e.preventDefault();
                    $(me.Variables.listadoProductosAgregados).animate({
                        scrollTop: me.Variables.alturaListaMiSolicitud + "px"
                    }, 500);

                });
            }
        };

        me.Constantes = {
            //PromocionNoDisponible: "Esta promoción no se encuentra disponible."
        };

        me.Funciones = {
            //BuscarPorCUV: function (CUV) { }
        };

        me.Inicializar = function () {
            me.Eventos.bindEvents();
        };
    };

    misReclamosRegistro = new PortalConsultorasReclamoRegistro();
    misReclamosRegistro.Inicializar();
});
