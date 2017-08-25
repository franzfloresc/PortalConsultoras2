var misReclamos;

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
                    console.log('Mostrar el mensaje');
                    if (mensajeGestionCdrInhabilitada != '') {

                        $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(mensajeGestionCdrInhabilitada);
                        $('#popupInformacionSB2Error').show();

                        return false;
                    }
                    console.log('Proceder con el registro');
                    window.location.href = urlReclamo;
                });

                $(document).on("click", me.Variables.VerDetalleCDR, function () {
                    var _OrigenDetalle = "1";
                    var _CDRWebID = $("#cdrweb_id").val();
                    var _PedidoID = $("#cdrweb_pedidoid").val();
                    var _FechaCulminado = $("#cdrweb_formatoFechaCulminado").val();
                    var _Campania = $("#cdrweb_formatocampania").val();
                    var _CantidadAprobados = $("#cdrweb_CantidadAprobados").val();
                    var _CantidadRechazados = $("#cdrweb_CantidadRechazados").val();

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
                    

                    //FORMA ANTIGUO
                    //localStorage.removeItem("CDRWebID");
                    //localStorage.removeItem("PedidoID");
                    //localStorage.removeItem('OrigenDetalle');

                    //localStorage.setItem('OrigenDetalle', "1");
                    //localStorage.setItem('CDRWebID', $("#cdrweb_id").val());
                    //localStorage.setItem('PedidoID', $("#cdrweb_pedidoid").val());
                    //window.location.href = baseUrl + "Mobile/MisReclamos/Detalle";
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
