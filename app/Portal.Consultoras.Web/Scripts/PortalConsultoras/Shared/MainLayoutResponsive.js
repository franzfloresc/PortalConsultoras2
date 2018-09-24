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

                    document.getElementById('pUrlProductosPedido').href = '/Mobile/Pedido/Detalle';
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
            },
            AbrirSubmenuMobile: function (e) {
                e.preventDefault();
                var subMenuMobile = $(this).next();
                $('.menu__link--conSubmenuMobile').next().slideUp();
                if(subMenuMobile.css('display') == 'block'){
                    subMenuMobile.slideUp();
                } else {
                    subMenuMobile.slideDown();
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