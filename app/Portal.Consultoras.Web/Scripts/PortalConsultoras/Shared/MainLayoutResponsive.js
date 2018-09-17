var Layout;

$(document).ready(function () {
    'use strict';

    var mainLR;

    mainLR = function () {
        var me = this;

        me.globals = {
            iconoMenuMobile: $('.header__icono__menu'),
            iconoCerrarMenuMobile: $('.icono__cerrar'),
            menuPrincipal: $('.header__menu--lateralIzquierdo'),
            isMobile: window.matchMedia('(max-width:991px)').matches
        },

        me.Funciones = {
            InicializarEventos: function () {
                if (me.globals.isMobile) {
                    $(me.globals.iconoMenuMobile).on('click', me.Eventos.MostrarMenuMobile);
                    $(me.globals.iconoCerrarMenuMobile).on('click', me.Eventos.CerrarMenuMobile);
                }
            }
        },

        me.Eventos = {
            MostrarMenuMobile: function (e) {
                e.preventDefault();
                $(me.globals.menuPrincipal).animate({
                    left: 0 + '%'
                }, 200);
            },
            CerrarMenuMobile: function (e) {
                e.preventDefault();
                $(me.globals.menuPrincipal).animate({
                    left: -100 + '%'
                }, 200);
            }
        },

        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    Layout = new mainLR();
    Layout.Inicializar();

});