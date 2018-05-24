var MiPerfil;

$(document).ready(function () {
    'use strict';

    var vistaMiPerfil;

    vistaMiPerfil = function () {
        var me = this;

        me.Globals = {

        },
        me.Funciones = {
            InicializarEventos: function () {

            }
        },
        me.Eventos = {

        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    MiPerfil = new vistaMiPerfil();
    MiPerfil.Inicializar();

});