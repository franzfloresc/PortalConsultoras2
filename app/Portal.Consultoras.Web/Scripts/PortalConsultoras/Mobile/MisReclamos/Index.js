var misReclamos;

$(document).ready((function (cerrarRechazado) {
    return function () {
        'use strict';

        var PortalConsultorasReclamos;

        PortalConsultorasReclamos = function () {

            var me = this;

            me.Variables = {
                IrPaso1: '#IrPaso1',
                VerDetalleCDR: ".abrir_detallemb",
                cdrweb_id: ".cdrweb_id",
                registro_solicitud_cdr: ".registro_solicitud_cdr",
                cdrweb_pedidoid: ".cdrweb_pedidoid",
                cdrweb_estado: ".cdrweb_estado",
                cdrweb_formatoFechaCulminado: ".cdrweb_formatoFechaCulminado",
                cdrweb_formatocampania: ".cdrweb_formatocampania",
                cdrweb_CantidadAprobados: ".cdrweb_CantidadAprobados",
                cdrweb_CantidadRechazados: ".cdrweb_CantidadRechazados"
            };

            me.Eventos = {

                bindEvents: function () {

                    $(document).on('click', me.Variables.IrPaso1, function () {
                        if (mensajeGestionCdrInhabilitada != '') {
                            $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').html(mensajeGestionCdrInhabilitada);
                            $('#popupInformacionSB2Error').show();

                            return false;
                        }

                        window.location.href = urlReclamo;
                    });

                    $(document).on("click", me.Variables.VerDetalleCDR, function () {
                        var elemento = $(this);
                        var parent = $(elemento).parents(".registro_solicitud_cdr");
                        var _OrigenDetalle = "1";
                        var _CDRWebID = $(parent).find(me.Variables.cdrweb_id).val();
                        var _PedidoID = $(parent).find(me.Variables.cdrweb_pedidoid).val();
                        var _Estado = $(parent).find(me.Variables.cdrweb_estado).val();
                        var _FechaCulminado = $(parent).find(me.Variables.cdrweb_formatoFechaCulminado).val();
                        var _Campania = $(parent).find(me.Variables.cdrweb_formatocampania).val();
                        var _CantidadAprobados = $(parent).find(me.Variables.cdrweb_CantidadAprobados).val();
                        var _CantidadRechazados = $(parent).find(me.Variables.cdrweb_CantidadRechazados).val();

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

                            ShowLoading();
                            $.ajax({
                                type: 'Post',
                                url: urlValidarCargaDetalle,
                                data: JSON.stringify(obj),
                                dataType: 'json',
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    CloseLoading();
                                    if (checkTimeout(data)) {
                                        if (data.success == true)
                                            window.location.href = baseUrl + "Mobile/MisReclamos/Detalle";
                                    }
                                },
                                error: function (data, error) {
                                    CloseLoading();
                                    if (checkTimeout(data))
                                        cerrarRechazado = '0';
                                }
                            });
                        }
                    });
                }
            };

            me.Constantes = {
            };

            me.Funciones = {
            };

            me.Inicializar = function () {
                me.Eventos.bindEvents();
            };
        };

        misReclamos = new PortalConsultorasReclamos();
        misReclamos.Inicializar();

    };
})(cerrarRechazado));
