
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
            seccionBannerMobile: "#seccion-banner-mobile",
            header: "header",
            bcMenuEstrategia: ".bc_menu_estrategia",
            aHover: "ul.subnavegador li a"
        },
        anchorMark = "#",
        anchorValue,
        url,
        lastScrollTop = 0,
        delta = 5,
        navbarHeight,
        seccionMenuMobileOuterHeight,
        seccionMenuMobileHeight,
        alturaH,
        alturaE;

    function _getheight(element) {
        return $(element).outerHeight(true);
    }

    function init() {
        navbarHeight = _getheight(elementos.header);
        seccionMenuMobileHeight = _getheight(elementos.seccionBannerMobile);
        seccionMenuMobileOuterHeight = _getheight(elementos.seccionBannerMobile);
        alturaH = _getheight(elementos.header);
        alturaE = alturaH + _getheight(elementos.bcMenuEstrategia);
        url = document.location.href;
    }

    function setHover() {
        $(elementos.aHover).hover(function (e) {
            var img = $.trim($(this).find('.contenedorImagen img').attr("src"));
            if (img != "") {
                img = img.replace("_normal.", "_hover.");
                $(this).find('.contenedorImagen img').attr("src", img)
            }
        }, function (e) {
            var img = $.trim($(this).find('.contenedorImagen img').attr("src"));
            if (img != "") {
                img = img.replace("_hover.", "_normal.");
                $(this).find('.contenedorImagen img').attr("src", img)
            }
        });
    }

    function hasScrolledMobile(st) {
        if (Math.abs(lastScrollTop - st) <= delta)
            return;
        //Scroll dowm
        if (st > lastScrollTop && st > (seccionMenuMobileHeight)) {
            //fix the menu 
            $(elementos.seccionMenuMobile).css("position", "fixed");
            $(elementos.seccionBannerMobile).css("display", "none");
            $(elementos.menu2Ul).css("position", "fixed").css("top", navbarHeight + "px");
        } else {
            // Scroll Up
            if (st < navbarHeight) {
                //console.log("we are onteh most top ");
                $(elementos.seccionMenuMobile).css("position", "");
                $(elementos.seccionBannerMobile).css("display", "");
                $(elementos.menu2Ul).css("position", "").css("top", "");
            } else if (st > (seccionMenuMobileHeight) && st + $(window).height() < $(document).height()) {
                //console.log("scroll up");
                $(elementos.seccionBannerMobile).css("display", "").css("top", navbarHeight + "px");
                $(elementos.menu2Ul).css("position", "fixed").css("top", (navbarHeight + seccionMenuMobileHeight) + "px");
            }
        }
        lastScrollTop = st;
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
        if (url.indexOf(anchorMark) > -1) {
            var strippedUrl = url.toString().split(anchorMark);
            if (strippedUrl.length > 1) anchorValue = strippedUrl[1];
            $(elementos.menu2Li).find("a").removeClass(elementos.claseActivo);
            $(elementos.html).find("[data-codigo=" + anchorValue + "]").find("a").addClass(elementos.claseActivo);
        }
    }
    function menuClick(e, url) {
        var objHtmlEvent = $(e.target);
        if (objHtmlEvent.length === 0) objHtmlEvent = $(e);
        objHtmlEvent.siblings("li").children("a").removeClass("activo");
        objHtmlEvent.find("a").addClass("activo");

        var esAncla = $(objHtmlEvent).data("es-ancla");
        if (esAncla === "True") {
            var codigo = $(objHtmlEvent).data("codigo");
            if (window.location.href.indexOf("/Ofertas") > -1) {
                $('html, body').animate({
                        scrollTop: $('#' + codigo).offset().top - 60
                    },
                    1000);
            } else {
                window.location = window.location.origin + "/" + (isMobile() ? "Mobile/" : "") + "Ofertas#" + codigo;
            }
        } else {
            url = $.trim(url);
            url = url[0] !== "/" ? "/" + url : url;
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
        setCarrouselMenu: setCarrouselMenu
    };
})();

$(document).ready(function () {

    if ($('.bc_para_ti-menu ul li a').hasClass('activo')) {
        $('.bc_para_ti-menu ul li a.activo').find('img.hover').css('display', 'none');
        $('.bc_para_ti-menu ul li a.activo').find('img.default').css('display', 'none');
        $('.bc_para_ti-menu ul li a.activo').find('img.click-menu').css('display', 'inline');
    }

    if ($('.bc_para_ti-menu-opciones ul li a').hasClass('activo')) {
        $('.bc_para_ti-menu-opciones ul li a.activo').find('p::after').css('display', 'block');
    }
    else {
        $('.bc_para_ti-menu-opciones ul li a.activo').find('p::after').css('display', 'none');
    }

    menuModule.init();
    menuModule.setHover();
    menuModule.checkAnchor();
    menuModule.setCarrouselMenu();
    LayoutHeaderFin();
    $(window).on('scroll', function () {
        if (isMobile()) {
            menuModule.hasScrolledMobile($(window).scrollTop());
        } else {
            menuModule.hasScrolledDesktop($(window).scrollTop());
        }
    });
});
