﻿
var menuModule = (function () {
    var elementos = {
            html: "html, body",
            claseActivo: "activo",
            claseActivoP: "titulo-menu",
            menu2: "[data-layout-menu2]",
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
            aHover: "ul.subnavegador li a",
            aMenuActivo: "ul.subnavegador li a.activo",
            bcParaTiMenu: ".op_menu-horizontal ul li a",
            bcParaTiMenuActivo: ".op_menu-horizontal ul li a.activo",
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
        seccionMenuMobileOuterHeight,
        seccionMenuMobileHeight,
        seccionFixedMenuHeigt,
        seccionMenu2Heigt,
        alturaH,
        scr = false,
        alturaE;

    function _getHeight(element) {
        return $(element).outerHeight(true);
    }
    function _moverSubMenuContenedorOfertasMobile() {
        if ($(elementos.menu2Ul).length) {
            var menuContendorActivo = $(elementos.menu2Ul + " li").find(".activo")[0];
            var posicionMenu = $(menuContendorActivo).parent("li").attr("data-slick-index");
            $(elementos.menu2Ul).slick('slickGoTo', parseInt(posicionMenu));
        }
    }
    function _changeLogoMobile() {
        var img = $.trim($(elementos.menuMobHome).find('img').attr("src"));
        if (img !== "") {
            img = img.replace("_hover.", "_normal.");
            $(elementos.menuMobHome).find('img').attr("src", img);
        }
    }
    function init() {
        navbarHeight = _getHeight(elementos.header);
        seccionMenuMobileHeight = _getHeight(elementos.seccionBannerMobile);
        seccionMenuMobileOuterHeight = _getHeight(elementos.seccionBannerMobile);
        seccionMenu2Heigt = _getHeight(elementos.menu2);
        seccionFixedMenuHeigt = _getHeight(elementos.seccionMenuFija);
        alturaH = _getHeight(elementos.header);
        alturaE = alturaH + _getHeight(elementos.bcMenuEstrategia);
        
        url = document.location.href;
        $(elementos.seccionMenuMobile).height(_getHeight(elementos.seccionMenuFija) + 5);
        if ($(elementos.bcParaTiMenu).hasClass(elementos.claseActivo)) {
            $(elementos.bcParaTiMenuActivo).find('img.hover').css('display', 'none');
            $(elementos.bcParaTiMenuActivo).find('img.default').css('display', 'none');
            $(elementos.bcParaTiMenuActivo).find('img.click-menu').css('display', 'inline');
        }
        if ($(elementos.aHover).hasClass(elementos.claseActivo)) {
            var img = $.trim($(elementos.aMenuActivo).find('img').attr("src"));
            if (img !== "") {
                img = img.replace("_normal.", "_hover.");
                $(elementos.aMenuActivo).find('img').attr("src", img);
            }
        }
    }
    function setHover() {
        $(elementos.aHover).hover(function (e) {
            var img = $.trim($(this).find('.contenedorImagen img').attr("src"));
            if (img !== "") {
                img = img.replace("_normal.", "_hover.");
                $(this).find('.contenedorImagen img').attr("src", img);
            }
        }, function (e) {
            if (!$(this).hasClass(elementos.claseActivo)) {
                var img = $.trim($(this).find('.contenedorImagen img').attr("src"));
                if (img !== "") {
                    img = img.replace("_hover.", "_normal.");
                    $(this).find('.contenedorImagen img').attr("src", img);
                }
            }
        });
        $(elementos.bcParaTiMenu).hover(function (e) {
            $(this).find('img.hover').css('display', 'inline');
            $(this).find('img.default').css('display', 'none');
            $(this).find('img.click-menu').css('display', 'none');
        }, function (e) {
            if (!$(this).hasClass(elementos.claseActivo)) {
                $(this).find('img.hover').css('display', 'none');
                $(this).find('img.default').css('display', 'inline');
                $(this).find('img.click-menu').css('display', 'none');
            }
        });
    }
    function hasScrolledMobile(st) {
        
        if (Math.abs(lastScrollTop - st) <= delta)
            return false;

        if (scr) return false;
        scr = true;

        //var divOffSet = $(elementos.seccionBannerMobile).offset().top - navbarHeight + seccionMenuMobileHeight;
        //Scroll dowm
        if (st > lastScrollTop) {
            //fix the menu 
            if (st > seccionMenuMobileHeight) {
                //$(elementos.seccionMenuMobile).show();
                $(elementos.seccionMenuFija).css("position", "fixed")
                    .css("top", navbarHeight - seccionMenuMobileHeight);
            }

        } else {   // Scroll Up
            if (st < delta) {
                $(elementos.seccionMenuFija).css("position", "").css("top", "");
            }else if (st > seccionMenuMobileHeight) {
                $(elementos.seccionMenuFija).css("position", "fixed").css("top", navbarHeight);
            }  
        }
        lastScrollTop = st;
        scr = false;
    }
    function hasScrolledDesktop(st) {
        if (st > alturaE) {
            $('.op-menu-vertical').addClass('menu-fixed');
            $('.op-menu-vertical').css('top', alturaH + "px");
        } else {
            $('.op-menu-vertical').removeClass('menu-fixed');
            $('.op-menu-vertical').css('top', "");
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
           
            if (strippedUrl.length > 1) anchorValue = strippedUrl[1];

            $(elementos.menu2Li).find("a").removeClass(elementos.claseActivo);
            $(elementos.html).find("[data-codigo=" + anchorValue + "]").find("a").addClass(elementos.claseActivo);
            
            $(elementos.html).animate({
                scrollTop: $(anchorMark + anchorValue).offset().top - menuHeight
                },
                1000);
            _changeLogoMobile();
        }
    }
    function menuClick(e, url) {
        var objHtmlEvent = $(e);
        var esAncla = objHtmlEvent.data(tagIsAnchor);
        var codigo = objHtmlEvent.data("codigo");
        var currentLocation = window.location.href.toLowerCase();
        var originLocation = window.location.origin;

        objHtmlEvent.siblings("li").find("a").removeClass(elementos.claseActivo);
        objHtmlEvent.find("a").addClass(elementos.claseActivo);
        
        if (esAncla === "True") {
            _changeLogoMobile();
            if (currentLocation.indexOf("/ofertasparati") > -1) {
                var indexOf = currentLocation.replace("?", "&").indexOf("&campaniaid=");
                var controller = "Ofertas#";
                if (indexOf > 0) {
                    indexOf = currentLocation.split("&campaniaid=")[1];
                    indexOf = indexOf.split("&")[0];
                    if (indexOf != campaniaCodigo) {
                        controller = "Ofertas/Revisar#";
                    }
                }
                window.location = originLocation + "/" + (isMobile() ? "Mobile/" : "") + controller + codigo;
            } else if (currentLocation.indexOf("/ofertas") > -1) {
                var menuHeight = navbarHeight;
                if ($(elementos.seccionMenuFija).css("position") === "fixed") menuHeight += seccionFixedMenuHeigt;
                $(elementos.html).animate({
                        scrollTop: $('#' + codigo).offset().top - menuHeight
                    },
                    1000);
                if (isMobile())
                    _moverSubMenuContenedorOfertasMobile();
            } else {
                if (currentLocation.indexOf("/revisar") > -1)
                    window.location = originLocation + "/" + (isMobile() ? "Mobile/" : "") + "Ofertas/Revisar#" + codigo;
                else
                    window.location = originLocation + "/" + (isMobile() ? "Mobile/" : "") + "Ofertas#" + codigo;
            }
        } else {
            url = $.trim(url);
            url = url[0] !== "/" ? "/" + url : url;
            try {
                if (codigo.indexOf("INICIO" > -1)) {
                    var img = $.trim($(elementos.menuMobHome).find('img').attr("src"));
                    if (img !== "") {
                        img = img.replace("_normal.", "_hover.");
                        $(elementos.menuMobHome).find('img').attr("src", img);
                    }
                }
            } catch (e) {
                console.log("error index of ");
            } 
           
            if (window.location.pathname.toLowerCase() === url.toLowerCase()) {
                return;
            }

            window.location = window.location.origin + url;
        }
    }
    function setCarrouselMenu() {
        if (isMobile()) {
            $(elementos.menu2Ul + '.slick-initialized').slick('unslick');
            $(elementos.menu2Ul).not('.slick-initialized').slick({
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
    return {
        init: init,
        setHover: setHover,
        hasScrolledMobile: hasScrolledMobile,
        hasScrolledDesktop: hasScrolledDesktop,
        checkAnchor: checkAnchor,
        menuClick: menuClick,
        setCarrouselMenu: setCarrouselMenu,
    };
})();

$(document).ready(function() {
    menuModule.init();
    menuModule.setHover();
    menuModule.setCarrouselMenu();
    LayoutHeaderFin();
    $(window).on('scroll',
        function() {
            if (isMobile()) {
                menuModule.hasScrolledMobile($(window).scrollTop());
            } else {
                menuModule.hasScrolledDesktop($(window).scrollTop());
            }
        });
 
    $(document).ajaxStop(function() {
        menuModule.checkAnchor();
    });

});
