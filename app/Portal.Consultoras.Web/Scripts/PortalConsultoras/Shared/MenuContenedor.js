﻿
var elementos = {
    claseActivo: "activo",
    claseActivoP: "titulo-menu",
    menu2: "[data-layout-menu2]",
    menu2Ul: "[data-layout-menu2] ul",
    menu2Li: "[data-layout-menu2] ul li",
    menu1Li: "[data-layout-menu1] ul li",
};

$(document).ready(function () {

    $("body").on("click", "[data-layout-menu1] ul li", function (e) {
        $(elementos.menu2Li).hide();
        var objClick = $(this);
        var listaMenus = $(elementos.menu2Ul).find("li[data-campania='" + objClick.data("campania") + "']");
        listaMenus.css({ display: "block" });
        if (listaMenus.length == 0) {
            $(elementos.menu2).hide();
        }
        else {
            $(elementos.menu2).show();
        }

        var menuCheck = {
            campania: objClick.data("campania"),
            codigo: ''
        };

        MenuContenedorGuardar(menuCheck);

        var urlAccion = $.trim(objClick.data("url"));
        if (urlAccion == "") {
            urlAccion = "Ofertas";
        }
        window.location = "/" + (isMobile() ? "Mobile/" : "") + urlAccion;
    });

    MenuContenedor();

    $('ul.sbmenu_estrategia ul li a').hover(function (e) {
        $(this).find('p').css('font-weight', 'bolder');
    }, function (e) {
        $(this).find('p').css('font-weight', 'normal');
    });

    var alturaH = $("header").innerHeight();
    var alturaE = alturaH + $('.bc_menu_estrategia').innerHeight();

    $(window).on('scroll', function () {
        if ($(window).scrollTop() > alturaE) {
            $('.op-menu-vertical').addClass('menu-fixed');
            $('.op-menu-vertical').css('top', alturaH + "px");
        } else {
            $('.op-menu-vertical').removeClass('menu-fixed');
            $('.op-menu-vertical').css('top', "");
        }
    });
});

function MenuContenedor() {
    //$(elementos.menu2Li).hide();
    //$(elementos.menu2Li).removeClass(elementos.claseActivo);
    //$(elementos.menu1Li).removeClass(elementos.claseActivo);
    //$(elementos.menu2Li).attr("data-activo", "0");

    //var menuCheck = MenuContenedorObtener();
    //menuCheck.CampaniaId = menuCheck.CampaniaId || 0;
    //if (menuCheck.CampaniaId <= 0) {
    //    var primerMenu = $(elementos.menu1Li);
    //    if (primerMenu.length > 0) {
    //        primerMenu = $(primerMenu).get(0);
    //    }
    //    else {
    //        // fix PL20
    //        var omenu2 = $(elementos.menu2Li);
    //        if (omenu2.length > 0)
    //            primerMenu = $(omenu2).get(0);
    //    }

    //    var primerSubMenu = $(elementos.menu2Li);
    //    if (primerSubMenu.length > 0) {
    //        primerSubMenu = $(primerSubMenu).get(0);
    //    }

    //    menuCheck = {
    //        campania: $(primerMenu).data("campania"),
    //        codigo: $(primerSubMenu).data("codigo")
    //    };

    //    MenuContenedorGuardar(menuCheck);
    //}

    //console.log(menuCheck);
    //$(elementos.menu1Li + "[data-campania='" + (menuCheck.CampaniaId || menuCheck.campania) + "'] a").addClass(elementos.claseActivo);
    //var subMenus = $(elementos.menu2Li + "[data-campania='" + (menuCheck.CampaniaId || menuCheck.campania) + "']");
    //if (subMenus.length == 0) {
    //    $(elementos.menu2).hide();
    //}
    //else {
    //    subMenus.show();
    //    subMenus.attr("data-activo", "1");
    //    $(elementos.menu2Ul
    //        + " li[data-campania=" + (menuCheck.CampaniaId || menuCheck.campania)
    //        + "][data-codigo='" + (menuCheck.Codigo || menuCheck.codigo) + "'] a").addClass(elementos.claseActivo);
    //    $(elementos.menu2Ul
    //       + " li[data-campania=" + (menuCheck.CampaniaId || menuCheck.campania)
    //       + "][data-codigo='" + (menuCheck.Codigo || menuCheck.codigo) + "'] a p").addClass(elementos.claseActivoP);
    //}

    if (isMobile()) {
        $(elementos.menu2Li + "[data-campania='" + (menuCheck.CampaniaId || menuCheck.campania) + "'][data-activo='0']").remove();
        MenuContenedorCarrusel();
    }

    LayoutHeaderFin();
}

function MenuContenedorClick(e, url) {
    var objHtmlEvent = $(e.target);
    if (objHtmlEvent.length == 0) objHtmlEvent = $(e);

    if ($(objHtmlEvent).data("es-ancla") == true) {

    } else {
        window.location = url;
    }
    //if ($(objHtmlEvent).data("campania") == undefined) {
    //    objHtmlEvent = $(objHtmlEvent).parents("[data-campania]");
    //}

    //var codigoLocal = {
    //    campania: $(objHtmlEvent).data("campania"),
    //    codigo: $(objHtmlEvent).data("codigo")
    //};

    //MenuContenedorGuardar(codigoLocal);

  
}

function MenuContenedorGuardar(codigoLocal) {
    $.ajaxSetup({
        cache: false
    });

    var detalle;

    codigoLocal.campania = codigoLocal.campania || 0;
    codigoLocal.codigo = $.trim(codigoLocal.codigo);

    $.ajax({
        type: 'POST',
        url: "/Ofertas/GuardarMenuContenedor",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(codigoLocal),
        async: false,
        success: function (data) {
            detalle = data.success || false;
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });

    return detalle;
}

function MenuContenedorObtener() {
    $.ajaxSetup({
        cache: false
    });

    var detalle = {};

    $.ajax({
        type: 'POST',
        url: "/Ofertas/ObtenerMenuContenedor",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            detalle = data.data || {};
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });

    return detalle;
}

function MenuContenedorCarrusel() {

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

    //divProd.find(sElementos.listadoProductos).css("overflow-y", "visible");
}
