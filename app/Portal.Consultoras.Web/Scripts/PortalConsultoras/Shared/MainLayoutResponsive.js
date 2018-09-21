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
            enlaceConSubmenuMobile: $('.menu__link--conSubmenuMobile'),
            isMobile: window.matchMedia('(max-width:991px)').matches
        },

        me.Funciones = {
            InicializarEventos: function () {
                if (me.globals.isMobile) {
                    $(me.globals.iconoMenuMobile).on('click', me.Eventos.MostrarMenuMobile);
                    $(me.globals.iconoCerrarMenuMobile).on('click', me.Eventos.CerrarMenuMobile);
                    $(me.globals.enlaceConSubmenuMobile).on('click', me.Eventos.AbrirSubmenuMobile);
                }
            }
        },

        me.Eventos = {
            MostrarMenuMobile: function (e) {
                e.preventDefault();
                $(me.globals.menuPrincipal).animate({
                    left: 0 + '%'
                }, 150);
            },
            CerrarMenuMobile: function (e) {
                e.preventDefault();
                $(me.globals.menuPrincipal).animate({
                    left: -100 + '%'
                }, 150);
                $('.menu__link--conSubmenuMobile').next().slideUp(80);
            },
            AbrirSubmenuMobile: function (e) {
                e.preventDefault();
                var subMenuMobile = $(this).next();
                $('.menu__link--conSubmenuMobile').next().slideUp(80);
                if(subMenuMobile.css('display') == 'flex'){
                    subMenuMobile.slideUp(80);
                } else {
                    subMenuMobile.css('display', 'flex');
                    subMenuMobile.slideDown(130);
                }
            }
        },

        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
        }
    }

    Layout = new mainLR();
    Layout.Inicializar();

});