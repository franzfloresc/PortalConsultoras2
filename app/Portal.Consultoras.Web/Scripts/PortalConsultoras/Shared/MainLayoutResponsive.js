var MainLayoutResponsiveModule = (function() {
    var _elements = {
        iconoMenuMobile: ".header__icono__menu",
        iconoCerrarMenuMobile: ".icono__cerrar",
        menuPrincipal: ".header__menu--lateralMobile",
        enlaceConSubmenuMobile: ".menu__link--conSubmenuMobile",
        itemFooter: ".layout__footer--mobile .footer__item__title",
        idUrlContactanos: "#urlContactanos",
        belcorpResponde: "·aBelcorpResponde"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
    };
    var _eventos = {
        MostrarMenuMobile: function(e) {
            e.preventDefault();
            $(_elements.menuPrincipal).animate({
                    left: 0 + "%"
                },
                150);
        },
        CerrarMenuMobile: function(e) {
            e.preventDefault();
            $(_elements.menuPrincipal).animate({
                    left: -100 + "%"
                },
                150);
            $(_elements.enlaceConSubmenuMobile).next().slideUp(80);
        },
        AbrirSubmenuMobile: function(e) {
            e.preventDefault();
            var subMenuMobile = $(this).next();
            $(_elements.enlaceConSubmenuMobile).next().slideUp(80);
            if (subMenuMobile.css("display") == "block") {
                subMenuMobile.slideUp(80);
            } else {
                subMenuMobile.slideDown(130);
            }

        },
        ToogleMenuFooter: function(e) {
            e.preventDefault();
            $(this).next().slideToggle("fast");
            $(this).toggleClass("footer__item__title--desplegado");
        }
    };
    var _funciones = { //private functions
        InicializarEventos: function() {
            $(_elements.iconoMenuMobile).on("click", _eventos.MostrarMenuMobile);
            $(_elements.iconoCerrarMenuMobile).on("click", _eventos.CerrarMenuMobile);
            $(_elements.enlaceConSubmenuMobile).on("click", _eventos.AbrirSubmenuMobile);
            $(_elements.itemFooter).on("click", _eventos.ToogleMenuFooter);
        },
        SetUrlContactanos : function() {
            if ($(_elements.idUrlContactanos).length) {
                $(_elements.belcorpResponde).attr("href", $(_elements.idUrlContactanos).data("url-contactanos"));
            } 
        }
    };
    
    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        if (_config.isMobile) {
            document.getElementById("pUrlProductosPedido").href = "/Mobile/Pedido/Detalle";
        }
        _funciones.SetUrlContactanos();
    }
    
    return {
        Inicializar: Inicializar
    };
})();

$(document).ready(function () {
    MainLayoutResponsiveModule.Inicializar();
});