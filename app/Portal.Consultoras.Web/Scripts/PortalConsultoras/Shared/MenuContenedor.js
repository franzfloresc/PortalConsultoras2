
var menuModule = (function () {
    var elementos = {
        html: "html, body",
        claseActivo: "activado",
        claseActivoP: "titulo-menu",
        claseimgSeleccionado: ".imgSeleccionado",
        claseimgNoSeleccionado:".imgNoSeleccionado",
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
        },
        bcParaTiMenu: ".op_menu-horizontal ul li a",
        bcParaTiMenuActivo: function () {
            return ".op_menu-horizontal ul li a." + this.claseActivo;
        },
        mobContent: "#mob-content-layout",
        menuMobHome: ".opcion_home_vistaOfertas"
    }

    var anchorMark = "#",
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

    var _var = {
        Mobile: false
    }

    var paddingTab = {
        Mobile: 3,
        Desktop: 1.5
    }

    function _getHeight(element) {
        return $(element).outerHeight(true);
    }
    function _moverSubMenuContenedorOfertasMobile() {
        if ($(elementos.menu2Ul).length) {
            var menuContendorActivo = $(elementos.menu2Ul + " li").find("." + elementos.claseActivo)[0];
            var posicionMenu = $(menuContendorActivo).parent("li").attr("data-slick-index");
            $(elementos.menu2Ul).slick("slickGoTo", parseInt(posicionMenu));
        }
    }
    function _changeLogoMenuDesktopAndMobile() {
        if (_var.Mobile)
            _changeLogoMenu(elementos.menuMobHome);
        else
            _changeLogoMenu(elementos.subnavegadorUl);
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
        _var.Mobile = isMobile();
        navbarHeight = _getHeight(elementos.header);
        seccionMenuMobileHeight = _getHeight(elementos.seccionBannerMobile);
        seccionFixedMenuHeigt = _getHeight(elementos.seccionMenuFija);
        alturaH = _getHeight(elementos.header);
        alturaE = alturaH + _getHeight(elementos.bcMenuEstrategia);
        var currentLocation = window.location.href.toLowerCase();

        var esSuscrita = $(elementos.subnavegadorUl).data("es-suscrita");

        if (esSuscrita) {
            elementos.claseActivo = "activado-dorado";
        }

        url = document.location.href;
        $(elementos.seccionMenuMobile).height(_getHeight(elementos.seccionMenuFija) + 5);
        if ($(elementos.bcParaTiMenu).hasClass(elementos.claseActivo)) {
            $(elementos.bcParaTiMenuActivo).find("img.hover").css("display", "none");
            $(elementos.bcParaTiMenuActivo).find("img.default").css("display", "none");
            $(elementos.bcParaTiMenuActivo).find("img.click-menu").css("display", "inline");
        }
         
        

        if (currentLocation.indexOf("#") > -1) {
            $(elementos.claseimgSeleccionado).hide();
            $(elementos.claseimgNoSeleccionado).show();
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
        if (_var.Mobile) {
            menuHeight += seccionFixedMenuHeigt;
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
            }
        }
        if (_var.Mobile) {
            _moverSubMenuContenedorOfertasMobile();
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

            if (currentLocation.indexOf("/ofertas") > -1) {
                if ($(elementos.seccionMenuFija).css("position") === "fixed") menuHeight += seccionFixedMenuHeigt;
                _animateScrollTo(anchorMark + codigo, menuHeight);
                if (_var.Mobile) _moverSubMenuContenedorOfertasMobile();


            } else {
                if (currentLocation.indexOf("/revisar") > -1)
                    window.location = originLocation + "/" + (_var.Mobile ? "Mobile/" : "") + "Ofertas/Revisar#" + codigo;
                else
                    window.location = originLocation + "/" + (_var.Mobile ? "Mobile/" : "") + "Ofertas#" + codigo;
            }
            
            if (codigo.indexOf("INICIO") > -1) {
                $(elementos.claseimgSeleccionado).show();
                $(elementos.claseimgNoSeleccionado).hide();

            }
            else {
                $(elementos.claseimgSeleccionado).hide();
                $(elementos.claseimgNoSeleccionado).show();
            }


        } else {
             

            url = $.trim(url);
            url = url[0] !== "/" ? "/" + url : url;
            if (codigo.indexOf("INICIO") > -1) {
                
                $(elementos.claseimgSeleccionado).show();
                $(elementos.claseimgNoSeleccionado).hide();
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
        if (_var.Mobile) {
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

        var padTab = _var.Mobile ? paddingTab.Mobile : paddingTab.Desktop;

        var anchoTab = ((anchoMenu - (padTab * (listaMenu.length - 1))) / listaMenu.length) - (_var.Mobile ? 0 : 1);
        $.each(listaMenu, function (ind, menuTab) {
            $(menuTab).css("width", anchoTab + "px");
            if (ind > 0) {
                $(menuTab).css("padding-left", padTab + "px");
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
    LayoutHeaderFin();
    $(window).on("scroll",
        function () {
            if (isMobile()) {
                menuModule.hasScrolledMobile($(window).scrollTop());
            } else {
                menuModule.hasScrolledDesktop($(window).scrollTop());
            }
        });
    menuModule.setCarrouselMenu();
    menuModule.Resize();
    $(document).ajaxStop(function () {
        menuModule.checkAnchor();
    });
    window.onresize = function (event) {
        menuModule.Resize();
    };
});
