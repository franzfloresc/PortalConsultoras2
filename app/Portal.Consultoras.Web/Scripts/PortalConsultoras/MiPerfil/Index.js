var MiPerfil;

$(document).ready(function () {
    'use strict';

    var vistaMiPerfil;

    vistaMiPerfil = function () {
        var me = this;

        //me.Globals = {

        //},
        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('blur', '.grupo_form_cambio_datos input', me.Eventos.LabelActivo);
            }
        },
        me.Eventos = {
            LabelActivo: function () {
                var campoDatos = $(this).val();
                if(campoDatos != ''){
                    $(this).addClass('campo_con_datos');
                } else {
                    $(this).removeClass('campo_con_datos');
                }
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    MiPerfil = new vistaMiPerfil();
    MiPerfil.Inicializar();

});