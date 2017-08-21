var misReclamos;

$(document).ready(function () {
    'use strict';

    var PortalConsultorasReclamos;

    PortalConsultorasReclamos = function () {

        var me = this;

        me.Variables = {
            //BtnAgregar: '#btnAgregar',
            IrPaso1: '#IrPaso1'
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
