
var menuModule = (function () {

    var _elem = {
        layout: {
            header: "header",
            menu: "[data-layout='menu']",
            menuContenedor: "data-layout='menuContenedor']",
            contenido: "[data-layout='contenido']",
            ubicacionWeb: "[data-layout='ubicacionWeb']",
            body: "[data-layout='body']",
            footerData: "[data-layout='footer']",
            footer: "footer"
        },
        menu: {

        }
    }

    var elementos = {
        html: "html, body",
        claseActivo: "activado",
        claseActivoP: "titulo-menu",
        claseimgSeleccionado: ".imgSeleccionado",
        claseimgNoSeleccionado: ".imgNoSeleccionado",
        menu2: "[data-layout-menu2]",
        menu2Ul: "[data-layout-menu2] ul",
        menu2Li: "[data-layout-menu2] ul li",
        seccionMenuMobile: "#seccion-menu-mobile",
        seccionMenuMobile2: "#seccion-menu-mobile2",
        seccionMenuMobile2Name: "seccion-menu-mobile2",
        seccionMenuFija: "#seccion-fixed-menu",
        header: "header",
        subnavegadorUl: "ul.subnavegador",

        mobContent: "#mob-content-layout",
        menuMobHome: ".opcion_home_vistaOfertas"
    }

    var anchorMark = "#";
    var anchorValue;
    var tagIsAnchor = "es-ancla";
    var urlIni;
    var navbarHeight;
    var seccionFixedMenuHeigt;
    var scr = false;

    var _var = {
        Mobile: false,
        AnchoMobile: function () {
            return $(document).outerWidth(true) <= 990;
        }
    }

    //var paddingTab = {
    //    Mobile: 3,
    //    Desktop: 1.5
    //}

    function _getHeight(element) {
        return $(element).outerHeight(true);
    }

    function _moverSubMenuContenedorOfertasMobile() {
        if (_var.Mobile || _var.AnchoMobile) {
            if ($(elementos.menu2Ul).length) {
                var menuContendorActivo = $(elementos.menu2Ul + " li").find("." + elementos.claseActivo)[0];
                var posicionMenu = $(menuContendorActivo).parent("li").attr("data-slick-index");
                $(elementos.menu2Ul).slick("slickGoTo", parseInt(posicionMenu));
            }
        }
    }

    function _animateScrollTo(codigo, topHeight) {
        var top = $(codigo).length > 0 ? $(codigo).offset().top - topHeight : 0;
        $(elementos.html).animate({ scrollTop: top }, 1000);
    }

    function init() {
        _var.Mobile = isMobile();
        navbarHeight = _getHeight(elementos.header);
        seccionFixedMenuHeigt = _getHeight(elementos.seccionMenuFija) || 0;

        var esSuscrita = $(elementos.subnavegadorUl).data("es-suscrita");
        if (esSuscrita) {
            elementos.claseActivo = "activado-dorado";
        }

        urlIni = document.location.href;
        var currentLocation = window.location.href.toLowerCase();
        _claseImgSeleccionado(currentLocation.indexOf("#") <= -1);
        setCarrouselMenu();

    }

    function setCarrouselMenu() {

        $(elementos.menu2Ul + ".slick-initialized").slick("unslick");
        if (_carrouselContenedorValidarAncho()) {
            $(elementos.menu2Ul).not(".slick-initialized").slick({
                infinite: false,
                vertical: false,
                slidesToScroll: 1,
                autoplay: false,
                speed: 260,
                variableWidth: true,
                prevArrow: '<a class="bc-menu-vertical-prev" style="display: block;left: 0; height: auto;">'
                    + '<img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                nextArrow: '<a class="bc-menu-vertical-next" style="display: block;right:0; height: auto;">'
                    + '<img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            });
        }
    }

    function _carrouselContenedorValidarAncho() {

        if ($(elementos.menu2Ul).length > 0) {
            var listaMenu = $(elementos.menu2Li);
            var anchoTotal = 0;
            $.each(listaMenu, function (ind, menuCont) {
                anchoTotal = anchoTotal + $(menuCont).innerWidth() + 1;
            });
            var anchoMain = $(_elem.layout.header).innerWidth() - 100;
            if (anchoTotal > anchoMain) {
                return true;
            }
        }
        return false;
    }

    function checkAnchor() {
        if (urlIni.indexOf(anchorMark) > -1) {

            var menuHeight = navbarHeight + seccionFixedMenuHeigt;

            var strippedUrl = urlIni.toString().split(anchorMark);

            $(elementos.menu2Li).find("a").removeClass(elementos.claseActivo);

            if (strippedUrl.length > 1) {
                anchorValue = $.trim(strippedUrl[1]).toUpperCase();

                if (anchorValue !== "") {
                    $(elementos.html).find("[data-codigo=" + anchorValue + "]").find("a").addClass(elementos.claseActivo);

                    _updateParentAttribute(anchorValue);

                    if ($(anchorMark + anchorValue).length > 0) {
                        _animateScrollTo(anchorMark + anchorValue, menuHeight);
                    } else {
                        _animateScrollTo(elementos.html, menuHeight);
                    }
                }
            }
        }

        _moverSubMenuContenedorOfertasMobile();

    }
    function _updateParentAttribute(codigo) {
        var tituloMenu = 'Contenedor - ' + $(elementos.menu2Ul).find("[data-codigo=" + codigo + "]").find("a").attr("title");
        if (codigo === "ODD") $('ul.subnavegador li a').attr('parent', tituloMenu);
        if (codigo === "LAN") $('ul.subnavegador li a').attr('parent', tituloMenu);
        if (codigo.indexOf("INICIO") > -1) $('ul.subnavegador li a').attr('parent', tituloMenu);
    }

    function menuClick(e, url) {
        var objHtmlEvent = $(e);
        var esAncla = objHtmlEvent.data(tagIsAnchor);
        var codigo = objHtmlEvent.data("codigo") || "";
        codigo = codigo.toUpperCase();

        var currentLocation = window.location.href.toLowerCase();
        var originLocation = window.location.origin;
        var menuHeight = navbarHeight;

        objHtmlEvent.siblings("li").find("a").removeClass(elementos.claseActivo);
        objHtmlEvent.find("a").addClass(elementos.claseActivo);

        if (esAncla === "True") {
            if (currentLocation.indexOf("/ofertas") > -1) {
                if ($(elementos.seccionMenuFija).css("position") === "fixed") menuHeight += seccionFixedMenuHeigt;
                _animateScrollTo(anchorMark + codigo, menuHeight);
                _moverSubMenuContenedorOfertasMobile();
                setTimeout(function () {
                    _updateParentAttribute(codigo);
                }, 1000);
            } else {

                var urlFin = originLocation + "/" + (_var.Mobile ? "Mobile/" : "");

                if (currentLocation.indexOf("/revisar") > -1)
                    urlFin = urlFin + "Ofertas/Revisar#" + codigo;
                else
                    urlFin = urlFin + "Ofertas#" + codigo;

                window.location = urlFin;
            }

            _claseImgSeleccionado(codigo.indexOf("INICIO") > -1);

        }
        else {
            if (codigo.indexOf("INICIO") > -1) {
                _claseImgSeleccionado(true);
                _animateScrollTo(elementos.html, menuHeight);
                setTimeout(function () {
                    _updateParentAttribute(codigo);
                }, 1000);
            }

            if (typeof AnalyticsPortalModule !== "undefined") {
                AnalyticsPortalModule.ClickTabGanadoras(codigo);
            }

            url = $.trim(url);
            url = url[0] !== "/" ? "/" + url : url;
            if (window.location.pathname.toLowerCase() === url.toLowerCase()) return;

            if (ConstantesModule.CodigoPalanca.ATP == codigo) {
                BannerInteractivo.ConsultaAjaxRedireccionaLanding(function () {
                    var codigoubigeoPortal = $('#ATP').attr('data-codigoubigeoportal') + "";
                    if (!(typeof AnalyticsPortalModule === 'undefined'))
                        if (codigoubigeoPortal === ConstantesModule.CodigoUbigeoPortal.GuionContenedorGuionArmaTuPack)
                            AnalyticsPortalModule.MarcaPromotionClickArmaTuPack(codigoubigeoPortal, "Aceptar", "Pop up Modifica tu Pack");

                    window.location = window.location.origin + url;
                });
                return false;
            }

            window.location = window.location.origin + url;
        }
    }
    function _claseImgSeleccionado(estado) {
        if (estado) {
            $(elementos.claseimgSeleccionado).show();
            $(elementos.claseimgNoSeleccionado).hide();
        }
        else {
            $(elementos.claseimgSeleccionado).hide();
            $(elementos.claseimgNoSeleccionado).show();
        }
    }

    function sectionClick(url, titulo, elem, event) {
        if (typeof event !== "undefined") {
            event.stopPropagation();
        }

        url = url || "";
        if (_var.Mobile && url.indexOf("Mobile") < 0) {
            url = "/Mobile" + url;
        }

        if (typeof AnalyticsPortalModule !== "undefined") {
            titulo = titulo || "";
            var OrigenPedidoWeb = "";
            var texto = _sectionClickTexto(elem);
            var clicEnBanner = false;

            OrigenPedidoWeb = EstrategiaAgregarModule.GetOrigenPedidoWeb($(elem), false);

            if (url.indexOf(ConstantesModule.TipoEstrategiaTexto.Ganadoras) > 0) {
                if (titulo === "BannerMG") {
                    AnalyticsPortalModule.MarcarClickMasOfertasPromotionClickMG();
                }
            }

            if (url.indexOf(ConstantesModule.TipoEstrategiaTexto.LiquidacionWeb) > 0) {
                OrigenPedidoWeb = CodigoOrigenPedidoWeb.CodigoEstructura.Dispositivo.Desktop
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Liquidacion
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel;
            }

            else if (url.indexOf(ConstantesModule.TipoEstrategiaTexto.SR) > 0) {
                if (titulo === "BotonVerMasEspecialesHome") {
                    OrigenPedidoWeb = CodigoOrigenPedidoWeb.CodigoEstructura.Dispositivo.Desktop
                        + CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home
                        + CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Showroom
                        + CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel;
                }
            }

            else if (url.indexOf(ConstantesModule.TipoEstrategiaTexto.GuiaNegocio) > 0) {
                OrigenPedidoWeb = CodigoOrigenPedidoWeb.CodigoEstructura.Dispositivo.Desktop
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Contenedor
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.GND
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel;
            }
            else if (url.indexOf(ConstantesModule.CodigoPalanca.LAN) > 0) {
                OrigenPedidoWeb = CodigoOrigenPedidoWeb.CodigoEstructura.Dispositivo.Desktop
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Home
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.Lanzamientos
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Carrusel;
            }

            else if (url.indexOf(ConstantesModule.TipoEstrategia.DP) > -1) {
                OrigenPedidoWeb = CodigoOrigenPedidoWeb.CodigoEstructura.Dispositivo.Desktop
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Contenedor
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Palanca.DuoPerfecto
                    + CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.Banner;
                if (titulo !== "ClicVerMas") {
                    clicEnBanner = true;
                }
            }
            OrigenPedidoWeb = OrigenPedidoWeb || "";
            AnalyticsPortalModule.MarcaClicVerMasOfertas(url, OrigenPedidoWeb, texto, clicEnBanner);
        }
        else {
            document.location = url;
        }

    }
    function _sectionClickTexto(e) {
        var texto = ((e || {}).innerText || "").trim();
        if (texto === "") {
            texto = $(e).find("[data-seccion-btn-vermas]").html() || "";
        }
        return texto.replace('+', '');
    }

    return {
        init: init,
        setCarrouselMenu: setCarrouselMenu,
        checkAnchor: checkAnchor,
        menuClick: menuClick,
        sectionClick: sectionClick
    };
})();

$(document).ready(function () {
    menuModule.init();
    $(document).ajaxStop(function () {
        menuModule.checkAnchor();
    });
    window.onresize = function (event) {
        menuModule.setCarrouselMenu();
    };
});
