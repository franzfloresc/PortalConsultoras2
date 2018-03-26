﻿
var menuModule = (function () {
    var elementos = {
        html: "html, body",
        claseActivo: "activo",
        claseActivoP: "titulo-menu",
        menu2: "[data-layout-menu2]",
        menu1: "[data-layout-menu1]",
        menu2Ul: "[data-layout-menu2] ul",
        menu2Li: "[data-layout-menu2] ul li",
        menu1Li: "[data-layout-menu1] ul li",
        seccionMenuMobile: "#seccion-menu-mobile",
        seccionMenuMobile2: "#seccion-menu-mobile2",
        seccionMenuMobile2Name: "seccion-menu-mobile2",
        seccionBannerMobile: "#seccion-banner-mobile",
        seccionMenuFija: "#seccion-fixed-menu",
        header: "header",
        bcMenuEstrategia: ".bc_menu_estrategia",
        subnavegadorUl: "ul.subnavegador",
        aHover: "ul.subnavegador li a",
        aMenuActivo: function () {
            return "ul.subnavegador li a." + this.claseActivo;
        },//"ul.subnavegador li a.activo",
        bcParaTiMenu: ".op_menu-horizontal ul li a",    
        bcParaTiMenuActivo: function () {
            return ".op_menu-horizontal ul li a." + this.claseActivo;
        },//".op_menu-horizontal ul li a.activo",
        mobContent: "#mob-content-layout",
        menuMobHome: ".opcion_home_vistaOfertas"
    },
        anchorMark = "#",
        anchorValue,
        tagIsAnchor = "es-ancla",
        url,
        lastScrollTop = 0,
        delta = 10,
        navbarHeight,
        seccionMenuMobileHeight,
        seccionFixedMenuHeigt,
        alturaH,
        scr = false,
        alturaE;
    var paddingTab = "1.5px";

    function _getHeight(element) {
        return $(element).outerHeight(true);
    }
    function _moverSubMenuContenedorOfertasMobile() {
        if ($(elementos.menu2Ul).length) {
            var menuContendorActivo = $(elementos.menu2Ul + " li").find(".activo")[0];
            var posicionMenu = $(menuContendorActivo).parent("li").attr("data-slick-index");
            $(elementos.menu2Ul).slick("slickGoTo", parseInt(posicionMenu));
        }
    }
    function _changeLogoMenuDesktopAndMobile() {
        if (!isMobile())_changeLogoMenu(elementos.subnavegadorUl);
        if (isMobile())_changeLogoMenu(elementos.menuMobHome);
    }
    function _changeLogoMenu(selector) {
        var img = $.trim($(selector).find("img").attr("src"));
        if (img !== "") {
            img = img.replace("_hover.", "_normal.");
            $(selector).find("img").attr("src", img);
        }
    }
    function _animateScrollTo(codigo, topHeight) {
        var top = $(codigo).length > 0 ? $(codigo).offset().top - topHeight : 0;
        $(elementos.html).animate({
            scrollTop: top
        },
        1000);
    }
    function init() {
        navbarHeight = _getHeight(elementos.header);
        seccionMenuMobileHeight = _getHeight(elementos.seccionBannerMobile);
        seccionFixedMenuHeigt = _getHeight(elementos.seccionMenuFija);
        alturaH = _getHeight(elementos.header);
        alturaE = alturaH + _getHeight(elementos.bcMenuEstrategia);

        var esSuscrita = $(elementos.subnavegadorUl).data("es-suscrita");
        //var esActiva = $(elementos.subnavegadorUl).data("es-activa");
        if (esSuscrita) {
            elementos.claseActivo = "activo-dorado";
        }

        url = document.location.href;
        $(elementos.seccionMenuMobile).height(_getHeight(elementos.seccionMenuFija) + 5);
        if ($(elementos.bcParaTiMenu).hasClass(elementos.claseActivo)) {
            $(elementos.bcParaTiMenuActivo).find("img.hover").css("display", "none");
            $(elementos.bcParaTiMenuActivo).find("img.default").css("display", "none");
            $(elementos.bcParaTiMenuActivo).find("img.click-menu").css("display", "inline");
        }
        if ($(elementos.aHover).hasClass(elementos.claseActivo)) {
            var img = $.trim($(elementos.aMenuActivo()).find("img").attr("src"));
            if (img !== "") {
                img = img.replace("_normal.", "_hover.");
                $(elementos.aMenuActivo()).find("img").attr("src", img);
            }
        }
    }
    function setHover() {
        $(elementos.aHover).hover(function (e) {
            var img = $.trim($(this).find(".contenedorImagen img").attr("src"));
            if (img !== "") {
                img = img.replace("_normal.", "_hover.");
                $(this).find(".contenedorImagen img").attr("src", img);
            }
        }, function (e) {
            if (!$(this).hasClass(elementos.claseActivo)) {
                var img = $.trim($(this).find(".contenedorImagen img").attr("src"));
                if (img !== "") {
                    img = img.replace("_hover.", "_normal.");
                    $(this).find(".contenedorImagen img").attr("src", img);
                }
            }
        });
        $(elementos.bcParaTiMenu).hover(function (e) {
            $(this).find("img.hover").css("display", "inline");
            $(this).find("img.default").css("display", "none");
            $(this).find("img.click-menu").css("display", "none");
        }, function (e) {
            if (!$(this).hasClass(elementos.claseActivo)) {
                $(this).find("img.hover").css("display", "none");
                $(this).find("img.default").css("display", "inline");
                $(this).find("img.click-menu").css("display", "none");
            }
        });
    }
    function hasScrolledMobile(st) {
        if (Math.abs(lastScrollTop - st) <= delta)
            return false;

        if (scr) return false;
        scr = true;

        //Scroll dowm
        if (st > lastScrollTop) {
            //fix the menu 
            if (st > seccionMenuMobileHeight) {
                $(elementos.seccionMenuFija).css("position", "fixed")
                    .css("top", navbarHeight - seccionMenuMobileHeight);
            }
        } else {   // Scroll Up
            if (st < delta) {
                $(elementos.seccionMenuFija).css("position", "").css("top", "");
            } else if (st > seccionMenuMobileHeight) {
                $(elementos.seccionMenuFija).css("position", "fixed").css("top", navbarHeight);
            }
        }
        lastScrollTop = st;
        scr = false;
    }
    function hasScrolledDesktop(st) {
        if (st > alturaE) {
            $(".op-menu-vertical").addClass("menu-fixed");
            $(".op-menu-vertical").css("top", alturaH + "px");
        } else {
            $(".op-menu-vertical").removeClass("menu-fixed");
            $(".op-menu-vertical").css("top", "");
        }
    }
    function checkAnchor() {
        var menuHeight = navbarHeight;
        if (isMobile()) {
            menuHeight += seccionFixedMenuHeigt;
            _moverSubMenuContenedorOfertasMobile();
        }

        if (url.indexOf(anchorMark) > -1) {
            var strippedUrl = url.toString().split(anchorMark);

            $(elementos.menu2Li).find("a").removeClass(elementos.claseActivo);

            if (strippedUrl.length > 1) {
                anchorValue = $.trim(strippedUrl[1]);

                if (anchorValue !== "") {
                    $(elementos.html).find("[data-codigo=" + anchorValue + "]").find("a").addClass(elementos.claseActivo);

                    if ($(anchorMark + anchorValue).length > 0) {
                        _animateScrollTo(anchorMark + anchorValue, menuHeight);
                    } else {
                        _animateScrollTo(elementos.html, menuHeight);
                    }
                }
                _changeLogoMenuDesktopAndMobile();
            }
        }
    }
    function menuClick(e, url) {
        var objHtmlEvent = $(e);
        var esAncla = objHtmlEvent.data(tagIsAnchor);
        var codigo = objHtmlEvent.data("codigo") || "";
        var currentLocation = window.location.href.toLowerCase();
        var originLocation = window.location.origin;
        var menuHeight = navbarHeight;

        objHtmlEvent.siblings("li").find("a").removeClass(elementos.claseActivo);
        objHtmlEvent.find("a").addClass(elementos.claseActivo);

        if (esAncla === "True") {
            _changeLogoMenuDesktopAndMobile();
            if (currentLocation.indexOf("/ofertasparati") > -1) {
                var indexOf = currentLocation.replace("?", "&").indexOf("&campaniaid=");
                var controller = "Ofertas#";
                if (indexOf > 0) {
                    indexOf = currentLocation.split("&campaniaid=")[1];
                    indexOf = indexOf.split("&")[0];
                    if (indexOf !== campaniaCodigo) {
                        controller = "Ofertas/Revisar#";
                    }
                }
                window.location = originLocation + "/" + (isMobile() ? "Mobile/" : "") + controller + codigo;
            } else if (currentLocation.indexOf("/ofertas") > -1) {
                if ($(elementos.seccionMenuFija).css("position") === "fixed") menuHeight += seccionFixedMenuHeigt;
                _animateScrollTo(anchorMark + codigo, menuHeight);
                if (isMobile()) _moverSubMenuContenedorOfertasMobile();


            } else {
                if (currentLocation.indexOf("/revisar") > -1)
                    window.location = originLocation + "/" + (isMobile() ? "Mobile/" : "") + "Ofertas/Revisar#" + codigo;
                else
                    window.location = originLocation + "/" + (isMobile() ? "Mobile/" : "") + "Ofertas#" + codigo;
            }
        } else {
            url = $.trim(url);
            url = url[0] !== "/" ? "/" + url : url;
            if (codigo.indexOf("INICIO") > -1) {
                var img = $.trim($(elementos.menuMobHome).find("img").attr("src"));
                if (img !== "") {
                    img = img.replace("_normal.", "_hover.");
                    $(elementos.menuMobHome).find("img").attr("src", img);
                }
                _animateScrollTo(elementos.html, menuHeight);
            }

            if (window.location.pathname.toLowerCase() === url.toLowerCase()) return;

            window.location = window.location.origin + url;
        }
    }
    function tabClick(element, url, pantalla) {
        if (window.location.pathname.toLowerCase() === url.toLowerCase()) return;
        var campania = $(element).data("campania") || "";
        var codigo = $(element).data("codigo") || "";
        if (typeof rdAnalyticsModule !== "undefined") {
            rdAnalyticsModule.Tabs(codigo, campania, pantalla);
        }
        window.location = window.location.origin + url;
    }
    function setCarrouselMenu() {
        if (isMobile()) {
            $(elementos.menu2Ul + ".slick-initialized").slick("unslick");
            $(elementos.menu2Ul).not(".slick-initialized").slick({
                infinite: false,
                vertical: false,
                slidesToScroll: 1,
                autoplay: false,
                speed: 260,
                variableWidth: true,
                prevArrow: '<a class="bc-menu-vertical-prev" style="display: block;left: 0; height: auto;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                nextArrow: '<a class="bc-menu-vertical-next" style="display: block;right:0; height: auto;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            });
        }
    }
    function sectionClick(url, titulo) {
        if (typeof rdAnalyticsModule !== "undefined") {
            rdAnalyticsModule.ContendorSection(titulo);
        }
        window.location.href = url;
    }
    function tabResize() {

        var listaMenu = $(elementos.menu1Li);
        if (listaMenu.length === 0)
            return false;
        
        var anchoMenu = $(elementos.menu1).outerWidth(true);
        if (anchoMenu <= 0)
            return false;

        var anchoTab = anchoMenu / listaMenu.length;
        $.each(listaMenu, function (ind, menuTab) {
            $(menuTab).css("width", anchoTab + "px");
            if (ind === 0) {
                $(menuTab).css("padding-right", paddingTab);
            }
            else if (ind === listaMenu.length - 1) {
                $(menuTab).css("padding-left", paddingTab);
            }
            else {
                $(menuTab).css("padding-left", paddingTab);
                $(menuTab).css("padding-right", paddingTab);
            }
        });
        
    }
    return {
        init: init,
        setHover: setHover,
        hasScrolledMobile: hasScrolledMobile,
        hasScrolledDesktop: hasScrolledDesktop,
        checkAnchor: checkAnchor,
        menuClick: menuClick,
        setCarrouselMenu: setCarrouselMenu,
        tabClick: tabClick,
        sectionClick: sectionClick,
        Resize: tabResize
    };
})();

$(document).ready(function () {
    menuModule.init();
    menuModule.setHover();
    menuModule.setCarrouselMenu();
    LayoutHeaderFin();
    $(window).on("scroll",
        function () {
            if (isMobile()) {
                menuModule.hasScrolledMobile($(window).scrollTop());
            } else {
                menuModule.hasScrolledDesktop($(window).scrollTop());
            }
        });

    $(document).ajaxStop(function () {
        menuModule.checkAnchor();
    });

});
