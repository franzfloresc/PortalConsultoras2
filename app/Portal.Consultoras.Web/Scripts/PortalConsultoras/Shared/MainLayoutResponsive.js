var MainLayoutResponsiveModule = (function() {
    var me = this;

    me.Elements = {
        iconoMenuMobile: ".header__icono__menu",
        iconoCerrarMenuMobile: ".icono__cerrar",
        menuPrincipal: ".header__menu--lateralIzquierdo",
        enlaceConSubmenuMobile: ".menu__link--conSubmenuMobile",
        itemFooter: ".footer__item__title"
    },
    me.Config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
    },
    me.Eventos = {
        MostrarMenuMobile: function(e) {
            e.preventDefault();
            $(me.Elements.menuPrincipal).animate({
                    left: 0 + "%"
                }, 150);
        },
        CerrarMenuMobile: function(e) {
            e.preventDefault();
            $(me.Elements.menuPrincipal).animate({
                    left: -100 + "%"
            }, 150);
            $(me.Elements.enlaceConSubmenuMobile).next().slideUp(80);
        },
        AbrirSubmenuMobile: function (e) {
            e.preventDefault();
            var subMenuMobile = $(this).next();
            $(me.Elements.enlaceConSubmenuMobile).next().slideUp(80);
            if(subMenuMobile.css('display') == 'block'){
                subMenuMobile.slideUp(80);
            } else {
                subMenuMobile.slideDown(130);
            }
                
        },
        ToogleMenuFooter : function(e) {
            e.preventDefault();
            $(this).next().slideToggle("fast");
        }
    },
    me.Funciones = { //private functions
        InicializarEventos: function() {
            if (me.Config.isMobile) {
                $(me.Elements.iconoMenuMobile).on("click", me.Eventos.MostrarMenuMobile);
                $(me.Elements.iconoCerrarMenuMobile).on("click", me.Eventos.CerrarMenuMobile);
                $(me.Elements.enlaceConSubmenuMobile).on("click", me.Eventos.AbrirSubmenuMobile);
                $(me.Elements.itemFooter).on("click", me.Eventos.ToogleMenuFooter);
            }
        }
    };
    
    //Public functions
    function Inicializar() {
        me.Funciones.InicializarEventos();
    }
    
    return {
        Inicializar: Inicializar
    };
})();

$(document).ready(function () {
    MainLayoutResponsiveModule.Inicializar();
});