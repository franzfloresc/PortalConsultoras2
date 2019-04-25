﻿
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
        //menu1: "[data-layout-menu1]",
        menu2Ul: "[data-layout-menu2] ul",
        menu2Li: "[data-layout-menu2] ul li",
        //menu1Li: "[data-layout-menu1] ul li",
        seccionMenuMobile: "#seccion-menu-mobile",
        seccionMenuMobile2: "#seccion-menu-mobile2",
        seccionMenuMobile2Name: "seccion-menu-mobile2",
        //seccionBannerMobile: "#seccion-banner-mobile",
        seccionMenuFija: "#seccion-fixed-menu",
        header: "header",
        //bcMenuEstrategia: ".bc_menu_estrategia",
        subnavegadorUl: "ul.subnavegador",
        //aHover: "ul.subnavegador li a",
        //aMenuActivo: function () {
        //    return "ul.subnavegador li a." + this.claseActivo;
        //},
        //bcParaTiMenu: ".op_menu-horizontal ul li a",
        //bcParaTiMenuActivo: function () {
        //    return ".op_menu-horizontal ul li a." + this.claseActivo;
        //},
        mobContent: "#mob-content-layout",
        menuMobHome: ".opcion_home_vistaOfertas"
    }

    var anchorMark = "#";
    var anchorValue;
    var tagIsAnchor = "es-ancla";
    var urlIni;
    //var lastScrollTop = 0;
    //var delta = 10;
    var navbarHeight;
    //var seccionMenuMobileHeight;
    var seccionFixedMenuHeigt;
    //var alturaH;
    var scr = false;
    //var alturaE;

    var _var = {
        Mobile: false,
        AnchoMobile: function () {
            return $(document).outerWidth(true) <= 990;
        }
    }

    var paddingTab = {
        Mobile: 3,
        Desktop: 1.5
    }

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
    //function _changeLogoMenuDesktopAndMobile() {
    //    if (_var.Mobile)
    //        _changeLogoMenu(elementos.menuMobHome);
    //    else
    //        _changeLogoMenu(elementos.subnavegadorUl);
    //}
    //function _changeLogoMenu(selector) {
    //    var img = $.trim($(selector).find("img").attr("src"));
    //    if (img !== "") {
    //        img = img.replace("_hover.", "_normal.");
    //        $(selector).find("img").attr("src", img);
    //    }
    //}
    function _animateScrollTo(codigo, topHeight) {
        var top = $(codigo).length > 0 ? $(codigo).offset().top - topHeight : 0;
        $(elementos.html).animate({ scrollTop: top }, 1000);
    }

    function init() {
        _var.Mobile = isMobile();
        navbarHeight = _getHeight(elementos.header);
        //seccionMenuMobileHeight = _getHeight(elementos.seccionBannerMobile);
        seccionFixedMenuHeigt = _getHeight(elementos.seccionMenuFija) || 0;
        //alturaH = _getHeight(elementos.header);
        //alturaE = alturaH + _getHeight(elementos.bcMenuEstrategia);

        var esSuscrita = $(elementos.subnavegadorUl).data("es-suscrita");
        if (esSuscrita) {
            elementos.claseActivo = "activado-dorado";
        }

        //$(elementos.seccionMenuMobile).height(_getHeight(elementos.seccionMenuFija) + 5);
        //if ($(elementos.bcParaTiMenu).hasClass(elementos.claseActivo)) {
        //    $(elementos.bcParaTiMenuActivo).find("img.hover").css("display", "none");
        //    $(elementos.bcParaTiMenuActivo).find("img.default").css("display", "none");
        //    $(elementos.bcParaTiMenuActivo).find("img.click-menu").css("display", "inline");
        //}

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
                anchoTotal = anchoTotal + $(menuCont).innerWidth();
            });
            var anchoMain = $(_elem.layout.header).innerWidth();
            if (anchoTotal > anchoMain) {
                return true;
            }
        }
        return false;
    }

    //function setHover() {
    //    $(elementos.aHover).hover(function (e) {
    //        var img = $.trim($(this).find(".contenedorImagen img").attr("src"));
    //        if (img !== "") {
    //            img = img.replace("_normal.", "_hover.");
    //            $(this).find(".contenedorImagen img").attr("src", img);
    //        }
    //    }, function (e) {
    //        if (!$(this).hasClass(elementos.claseActivo)) {
    //            var img = $.trim($(this).find(".contenedorImagen img").attr("src"));
    //            if (img !== "") {
    //                img = img.replace("_hover.", "_normal.");
    //                $(this).find(".contenedorImagen img").attr("src", img);
    //            }
    //        }
    //    });
    //    $(elementos.bcParaTiMenu).hover(function (e) {
    //        $(this).find("img.hover").css("display", "inline");
    //        $(this).find("img.default").css("display", "none");
    //        $(this).find("img.click-menu").css("display", "none");
    //    }, function (e) {
    //        if (!$(this).hasClass(elementos.claseActivo)) {
    //            $(this).find("img.hover").css("display", "none");
    //            $(this).find("img.default").css("display", "inline");
    //            $(this).find("img.click-menu").css("display", "none");
    //        }
    //    });
    //}
    //function hasScrolledMobile(st) {
    //    if (Math.abs(lastScrollTop - st) <= delta)
    //        return false;

    //    if (scr) return false;
    //    scr = true;

    //    //Scroll dowm
    //    if (st > lastScrollTop) {
    //        //fix the menu 
    //        if (st > seccionMenuMobileHeight) {
    //            $(elementos.seccionMenuFija).css("position", "fixed")
    //                .css("top", navbarHeight - seccionMenuMobileHeight);
    //        }
    //    } else {   // Scroll Up
    //        if (st < delta) {
    //            $(elementos.seccionMenuFija).css("position", "").css("top", "");
    //        } else if (st > seccionMenuMobileHeight) {
    //            $(elementos.seccionMenuFija).css("position", "fixed").css("top", navbarHeight);
    //        }
    //    }
    //    lastScrollTop = st;
    //    scr = false;
    //}
    //function hasScrolledDesktop(st) {
    //    if (st > alturaE) {
    //        $(".op-menu-vertical").addClass("menu-fixed");
    //        $(".op-menu-vertical").css("top", alturaH + "px");
    //    } else {
    //        $(".op-menu-vertical").removeClass("menu-fixed");
    //        $(".op-menu-vertical").css("top", "");
    //    }
    //}

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

    function menuClick(e, url, confirmar) {
        var objHtmlEvent = $(e);
        var esAncla = objHtmlEvent.data(tagIsAnchor);
        var codigo = objHtmlEvent.data("codigo") || "";
        codigo = codigo.toUpperCase();

        confirmar = _mostrarConfirmar(codigo, confirmar);

        if (confirmar) {
            return false;
        }

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
                    window.location = window.location.origin + url;
                });
                return false;
            }

            window.location = window.location.origin + url;
        }
    }
    function _mostrarConfirmar(codigo, confirmar) {

        confirmar = confirmar === undefined ? true : confirmar;
        if (confirmar ) {

            if (typeof BannerInteractivo != "undefined") {
                //BannerInteractivo.ConsultaRedireccionaLanding(this);
                //return true;
            }
        }
        return false;

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

    //function tabClick(element, url, pantalla) {
    //    if (window.location.pathname.toLowerCase() === url.toLowerCase()) return;
    //    var campania = $(element).data("campania") || "";
    //    var codigo = $(element).data("codigo") || "";
    //    if (typeof rdAnalyticsModule !== "undefined") {
    //        rdAnalyticsModule.Tabs(codigo, campania, pantalla);
    //    }
    //    window.location = window.location.origin + url;
    //}

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
                OrigenPedidoWeb = ConstantesModule.OrigenPedidoWebEstructura.Dispositivo.Desktop
                    + ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
                    + ConstantesModule.OrigenPedidoWebEstructura.Palanca.Liquidacion
                    + ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel;
            }

            else if (url.indexOf(ConstantesModule.TipoEstrategiaTexto.SR) > 0) {
                if (titulo === "BotonVerMasEspecialesHome") {
                    OrigenPedidoWeb = ConstantesModule.OrigenPedidoWebEstructura.Dispositivo.Desktop
                        + ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
                        + ConstantesModule.OrigenPedidoWebEstructura.Palanca.Showroom
                        + ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel;
                }
            }

            else if (url.indexOf(ConstantesModule.TipoEstrategiaTexto.GuiaNegocio) > 0) {
                OrigenPedidoWeb = ConstantesModule.OrigenPedidoWebEstructura.Dispositivo.Desktop
                    + ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor
                    + ConstantesModule.OrigenPedidoWebEstructura.Palanca.GND
                    + ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel;
            }
            else if (url.indexOf(ConstantesModule.CodigoPalanca.LAN) > 0) {
                OrigenPedidoWeb = ConstantesModule.OrigenPedidoWebEstructura.Dispositivo.Desktop
                    + ConstantesModule.OrigenPedidoWebEstructura.Pagina.Home
                    + ConstantesModule.OrigenPedidoWebEstructura.Palanca.Lanzamientos
                    + ConstantesModule.OrigenPedidoWebEstructura.Seccion.Carrusel;
            }
            //HD-3473 EINCA 
            else if (url.indexOf(ConstantesModule.TipoEstrategia.DP) > -1) {
                OrigenPedidoWeb = ConstantesModule.OrigenPedidoWebEstructura.Dispositivo.Desktop
                    + ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor
                    + ConstantesModule.OrigenPedidoWebEstructura.Palanca.DuoPerfecto
                    + ConstantesModule.OrigenPedidoWebEstructura.Seccion.Banner;
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
    //function tabResize() {

    //    var listaMenu = $(elementos.menu1Li);
    //    if (listaMenu.length === 0)
    //        return false;

    //    var anchoMenu = $(elementos.menu1).outerWidth(true);
    //    if (anchoMenu <= 0)
    //        return false;

    //    var padTab = _var.Mobile ? paddingTab.Mobile : paddingTab.Desktop;

    //    var anchoTab = ((anchoMenu - (padTab * (listaMenu.length - 1))) / listaMenu.length) - (_var.Mobile ? 0 : 1);
    //    $.each(listaMenu, function (ind, menuTab) {
    //        $(menuTab).css("width", anchoTab + "px");
    //        if (ind > 0) {
    //            $(menuTab).css("padding-left", padTab + "px");
    //        }
    //    });

    //}
    return {
        init: init,
        setCarrouselMenu: setCarrouselMenu,
        //setHover: setHover,
        //hasScrolledMobile: hasScrolledMobile,
        //hasScrolledDesktop: hasScrolledDesktop,
        checkAnchor: checkAnchor,
        menuClick: menuClick,
        //tabClick: tabClick,
        sectionClick: sectionClick,
        //Resize: tabResize
    };
})();

$(document).ready(function () {
    menuModule.init();
    //menuModule.Resize();
    //LayoutHeaderFin();
    //$(window).on("scroll",
    //    function () {
    //        if (isMobile()) {
    //            menuModule.hasScrolledMobile($(window).scrollTop());
    //        } else {
    //            menuModule.hasScrolledDesktop($(window).scrollTop());
    //        }
    //    });
    //menuModule.setCarrouselMenu();
    $(document).ajaxStop(function () {
        menuModule.checkAnchor();
    });
    window.onresize = function (event) {
        //menuModule.Resize();
        menuModule.setCarrouselMenu();
    };
});
