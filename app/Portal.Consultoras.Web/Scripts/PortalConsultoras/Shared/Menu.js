﻿
var menuContenedorActivo = "MenuContenedorActivo";

$(document).ready(function () {

    $("body").on("click", "[data-layout-menu1] ul li", function (e) {
        $("[data-layout-menu2] ul li").hide();
        var objClick = $(this);
        var listaMenus = $('[data-layout-menu2] ul').find("li[data-campania='" + objClick.data("campania") + "']");
        listaMenus.css({ display: "block" });
        if (listaMenus.length == 0) {
            $('[data-layout-menu2]').hide();
        }
        else {
            $('[data-layout-menu2]').show();
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
});

function MenuContenedor() {
    $("[data-layout-menu2] ul li").hide();
    $("[data-layout-menu2] ul li").removeClass("seleccionado");
    $("[data-layout-menu1] ul li").removeClass("seleccionado");

    var menuCheck = MenuContenedorObtener();
    menuCheck.CampaniaID = menuCheck.CampaniaID || 0;
    if (menuCheck.CampaniaID <= 0) {
        var primerMenu = $("[data-layout-menu1] ul li");
        if (primerMenu.length > 0) {
            primerMenu = $(primerMenu).get(0);
        }
        else {
            // fix PL20
            var omenu2 = $("[data-layout-menu2] ul li");
            if (omenu2.length > 0)
                primerMenu = $(omenu2).get(0);
        }

        var primerSubMenu = $("[data-layout-menu2] ul li");
        if (primerSubMenu.length > 0) {
            primerSubMenu = $(primerSubMenu).get(0);
        }

        menuCheck = {
            campania: $(primerMenu).data("campania"),
            codigo: $(primerSubMenu).data("codigo")
        };

        MenuContenedorGuardar(menuCheck);
    }

    console.log(menuCheck);

    $("[data-layout-menu1] ul li[data-campania='" + (menuCheck.CampaniaID || menuCheck.campania) + "']").addClass("seleccionado");
    var subMenus = $("[data-layout-menu2] ul li[data-campania='" + (menuCheck.CampaniaID || menuCheck.campania) + "']");
    if (subMenus.length == 0) {
        $("[data-layout-menu2]").hide();
    }
    else {
        subMenus.show();
        $("[data-layout-menu2] ul "
            + "li[data-campania=" + (menuCheck.CampaniaID || menuCheck.campania)
            + "][data-codigo='" + (menuCheck.Codigo || menuCheck.codigo) + "']").addClass("seleccionado");
    }

    LayoutHeaderFin();
}

function MenuContenedorClick(e, url) {
    var objHtmlEvent = $(e.target);
    if (objHtmlEvent.length == 0) objHtmlEvent = $(e);
    if ($(objHtmlEvent).data("campania") == undefined) {
        objHtmlEvent = $(objHtmlEvent).parents("[data-campania]");
    }

    var codigoLocal = {
        campania: $(objHtmlEvent).data("campania"),
        codigo: $(objHtmlEvent).data("codigo")
    };

    MenuContenedorGuardar(codigoLocal);

    window.location = url;
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


function RedirectMenu(ActionName, ControllerName, Flag, Descripcion, parametros) {
    if (ControllerName == "ShowRoom") {
        var pEventoID = $("#hdEventoIDShowRoom").val();
        var pEventoIDVenta = $("#hdEventoIDShowRoomVenta").val();
        if (ActionName == "Index") {
            var container = $('#PopShowroomVenta');
            var pnombreedescripcion = $("#spnShowRoomEventoVenta").val();
            var pnombreeventodescripcion = $("#spnShowRoomEventoDescripcionVenta").val();
            
            dataLayer.push({
                'event': 'promotionClick',
                'ecommerce': {
                    'promoView': [
                        {
                            'id': pEventoIDVenta,
                            'name': pnombreedescripcion + ' ' + pnombreeventodescripcion + ' ' + '- Compra ya',
                            'position': 'Desktop menu - 1',
                            'creative': 'Menu'
                        }
                    ]
                }
            });

        }
        if (ActionName == "Intriga") {
            var container = $('#PopShowroomIntriga');
            var pnombreedescripcion = $("#spnShowRoomEvento").val();
            var pnombreeventodescripcion = $("#spnShowRoomEventoDescripcion").val();

            dataLayer.push({
                'event': 'promotionClick',
                'ecommerce': {
                    'promoView': [
                        {
                            'id': pEventoIDVenta,
                            'name': pnombreedescripcion + ' ' + pnombreeventodescripcion + ' ' + '- Entérate primero',
                            'position': 'Desktop menu - 1',
                            'creative': 'Menu'
                        }
                    ]
                }
            });
        }



    }

    var URL = '';

    if (gTipoUsuario == '2' && (ControllerName == 'MiAcademia' || ControllerName == 'ConsultoraOnline')) {
        var message = 'Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.';
        $('#dialog_ErrorMainLayout #mensajeInformacionSB2_Error').html(message);
        $('#dialog_ErrorMainLayout').show();
        return false;
    } else {
        if (ControllerName == '') URL = ActionName;
        else {
            if (ActionName == "Index") URL = location.protocol + "//" + location.host + "/" + ControllerName;
            else URL = location.protocol + "//" + location.host + "/" + ControllerName + "/" + ActionName;
        }

        if (parametros != null && parametros != '') URL += "?" + parametros;

        if (Descripcion != "Pedidos") {
            if ($("#hdFlagOfertaWeb").val() == "1") {
                MostrarMensajeConsultora();
                return false;
            }
            if ($("#hdFlagOfertaLiquidacion").val() == "1") {
                MostrarMensajeConsultora();
                return false;
            }
        }

        if ($("#hdFlagValidacion").val() == "1") {
            if ($('#hdFlagValidacionReserva').val() == "1") {
                MostrarMensajeConsultoraValidacion();
            }
            return false;
        }

        if (Flag == "1") {
            window.open(URL, '_blank');
            return false;
        }

        location.href = URL;
        return true;
    }
}

function MostrarMensajeConsultora() {
    showDialog("DialogMensajeProducto");
    $("#DialogMensajeProducto").siblings(".ui-dialog-titlebar").hide();
}

function MostrarMensajeConsultoraValidacion() {
    showDialog("DialogMensajeValidacion");
    $("#DialogMensajeValidacion").siblings(".ui-dialog-titlebar").hide();
}
