﻿var misReclamos;

$(document).ready(function () {
    'use strict';

    var PortalConsultorasReclamos;

    PortalConsultorasReclamos = function () {

        var me = this;
        
        me.Variables = {
            //BtnAgregar: '#btnAgregar',
            IrPaso1: '#IrPaso1',
            VerDetalleCDR: ".abrir_detallemb",
        };
        
        me.Eventos = {
            
            bindEvents: function () {

                $(document).on('click', me.Variables.IrPaso1, function () {
                    if (mensajeGestionCdrInhabilitada != '') {
                        //var _chat = "<span class=\"enlace_chat belcorpChat\"><a>Chat en Línea</a></span>";
                        $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(mensajeGestionCdrInhabilitada);
                        $('#popupInformacionSB2Error').show();

                        return false;
                    }
                    console.log('Proceder con el registro');
                    window.location.href = urlReclamo;
                });

                $(document).on("click", me.Variables.VerDetalleCDR, function () {
                    var elemento = $(this);
                    var parent = $(elemento).parents(".registro_solicitud_cdr");
                    var _OrigenDetalle = "1";
                    var _CDRWebID = $(parent).find(".cdrweb_id").val();
                    var _PedidoID = $(parent).find(".cdrweb_pedidoid").val();
                    var _Estado = $(parent).find(".cdrweb_estado").val();
                    var _FechaCulminado = $(parent).find(".cdrweb_formatoFechaCulminado").val();
                    var _Campania = $(parent).find(".cdrweb_formatocampania").val();
                    var _CantidadAprobados = $(parent).find(".cdrweb_CantidadAprobados").val();
                    var _CantidadRechazados = $(parent).find(".cdrweb_CantidadRechazados").val();
                    
                    if (_Estado === "1") {
                        window.location.href = urlReclamo + "?pedidoId=" + _PedidoID;
                    } else {
                        var obj = {
                            OrigenCDRDetalle: _OrigenDetalle,
                            CDRWebID: _CDRWebID,
                            PedidoID: _PedidoID,
                            FormatoFechaCulminado: _FechaCulminado,
                            FormatoCampaniaID: _Campania,
                            CantidadAprobados: _CantidadAprobados,
                            CantidadRechazados: _CantidadRechazados
                        };

                        $.ajax({
                            type: 'Post',
                            url: urlValidarCargaDetalle,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                if (checkTimeout(data)) {
                                    if (data.success == true)
                                        window.location.href = baseUrl + "Mobile/MisReclamos/Detalle";
                                }
                            },
                            error: function (data, error) {
                                if (checkTimeout(data))
                                    cerrarRechazado = '0';
                            }
                        });
                    }
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

    misReclamos = new PortalConsultorasReclamos();
    misReclamos.Inicializar();

});
