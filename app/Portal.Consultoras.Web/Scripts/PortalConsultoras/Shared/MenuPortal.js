jQuery(document).ready(function () {

    $("header").resize(function () {
        LayoutMenu();
    });

});

function LayoutHeader() {
    LayoutHeaderFin();
    $(document).ajaxStop(function () {
        LayoutHeaderFin();
    });
}

function LayoutHeaderFin() {
    var wtop = $("header").innerHeight() || 0;
    $("[data-content]").css("margin-top", (wtop) + "px");
}

function LayoutMenu() {
    LayoutMenuFin();
    $(document).ajaxStop(function () {
        LayoutMenuFin();
    });
}

function LayoutMenuFin() {

    // validar si sale en dos lineas
    var idMenus = "#ulNavPrincipal-0 > li";

    if ($(idMenus).length == 0) {
        return false;
    }

    var idnMenuHeader = ".wrapper_header";
    var menuParte1 = "[data-menu-header='parte1']";
    var menuParte2 = "[data-menu-header='parte2']";
    var menuParte3 = "[data-menu-header='parte3']";

    $(idnMenuHeader).css("max-width", "");
    $(idnMenuHeader).css("width", "");
    $(menuParte1).css("width", "");
    $(menuParte2).css("width", "");
    $(menuParte3).css("width", "");
    $(idMenus).css("margin-left", "0px");

    var wt = $(idnMenuHeader).width();
    var wl = $(menuParte1).innerWidth();
    var wr = $(menuParte3).innerWidth() + 1;
    $(idnMenuHeader).css("max-width", wt + "px");
    $(idnMenuHeader).css("width", wt + "px");

    $(menuParte1).css("width", wl + "px");
    $(menuParte3).css("width", wr + "px");

    wt = wt - wl - wr;
    $(menuParte2).css("width", wt + "px");

    var h = $(idnMenuHeader).height();

    if (h > 61) {
        $(idMenus + " a").css("font-size", "9px");
    }

    wr = 0;
    $.each($(idMenus), function (ind, menupadre) {
        wr += $(menupadre).innerWidth();
    });

    if (wt == wr) {
        $(idMenus + " a").css("font-size", "9px");
        wr = 0;
        $.each($(idMenus), function (ind, menupadre) {
            wr += $(menupadre).innerWidth();
        });
    }

    if (wt < wr) {
        $(idMenus + " a").css("font-size", "10.5px");
    }
    else if (wt > wr) {
        wr = (wt - wr) / $(idMenus).length;
        wr = parseInt(wr * 10) / 10;
        wr = Math.min(wr, 20);

        $.each($(idMenus), function (ind, menupadre) {
            if (ind > 0 && ind + 1 < $(idMenus).length) {
                $(menupadre).css("margin-left", wr + "px");
            }
        });
    }

    // caso no entre en el menu
    // poner en dos renglones
    if ($(idnMenuHeader).height() > 61) {
        //
    }

    LayoutHeader();
}

function OcultarMenu(codigo) {
    MostrarMenu(codigo, 0);
}

function MostrarMenu(codigo, accion) {
    codigo = $.trim(codigo);
    if (codigo == "")
        return false;

    var idMenus = "#ulNavPrincipal-0";
    var menu = $(idMenus).find("[data-codigo='" + codigo + "']");
    menu = menu.length == 0 ? $(idMenus).find("[data-codigo='" + codigo.toLowerCase() + "']") : menu;
    menu = menu.length == 0 ? $(idMenus).find("[data-codigo='" + codigo.toUpperCase() + "']") : menu;

    if (menu.length == 0) {
        // puede implementarse para los iconos de la parte derecha
        return false;
    }

    if (accion == 0) {
        $(menu).addClass("oculto");
    }
    else {
        $(menu).removeClass("oculto");
    }

    LayoutMenu();

}
