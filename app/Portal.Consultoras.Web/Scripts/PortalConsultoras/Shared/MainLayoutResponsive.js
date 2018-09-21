var MainLayoutResponsiveModule = (function() {
    var me = this;

    me.Elements = {
        iconoMenuMobile: ".header__icono__menu",
        iconoCerrarMenuMobile: ".icono__cerrar",
        menuPrincipal: ".header__menu--lateralIzquierdo",
            enlaceConSubmenuMobile: $('.menu__link--conSubmenuMobile')
    },
    me.Config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
                    $(me.globals.enlaceConSubmenuMobile).on('click', me.Eventos.AbrirSubmenuMobile);
    },
    me.Eventos = {
        MostrarMenuMobile: function(e) {
            e.preventDefault();
            $(me.Elements.menuPrincipal).animate({
                    left: 0 + "%"
                },
                200);
        },
        CerrarMenuMobile: function(e) {
            e.preventDefault();
            $(me.Elements.menuPrincipal).animate({
                    left: -100 + "%"
                },  200);
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
    me.Funciones = { //private functions
        InicializarEventos: function() {
            if (me.Config.isMobile) {
                $(me.Elements.iconoMenuMobile).on("click", me.Eventos.MostrarMenuMobile);
                $(me.Elements.iconoCerrarMenuMobile).on("click", me.Eventos.CerrarMenuMobile);
                $(me.globals.enlaceConSubmenuMobile).on('click', me.Eventos.AbrirSubmenuMobile);
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