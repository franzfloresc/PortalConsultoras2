$(document).ready(function () {

    $("ul.menu_estrategia li[data-activo='True']").addClass("seleccionado");
    $($("ul.sbmenu_estrategia li[data-activo='True']").get(0)).addClass("seleccionado");
    $("ul.sbmenu_estrategia li").hide();
    var campania = $("ul.menu_estrategia li[data-activo='True']").data("campania");
    $("ul.sbmenu_estrategia li[data-campania='" + campania + "']").show();

    if ($("ul.menu_estrategia li[data-activo='True']").length == 0) {
        $("ul.sbmenu_estrategia li").show();
    }

    $('ul.menu_estrategia li').hover(function (e) {
        $(this).find('p').css('color', 'white');
        $('ul.sbmenu_estrategia li a p').css('color', '#333');
    }, function (e) {
        /*$(this).find('p').css('color', 'rgba(255, 255, 255, 0.59)')*/
    });

    $('ul.menu_estrategia li').hover(function (e) {
        $('ul.sbmenu_estrategia li').hide();
        $('ul.sbmenu_estrategia').find("li[data-campania='" + $(this).data("campania") + "']").css({
            display: "block"
        });
    }, function (e) {
        var campania = $("ul.menu_estrategia li[data-activo='True']").data("campania");
        $("ul.sbmenu_estrategia li").hide();
        $("ul.sbmenu_estrategia li[data-campania='" + campania + "']").show();
    });

    $('ul.sbmenu_estrategia li a').hover(function (e) {
        $(this).find('p').css('font-weight', 'bolder');
    }, function (e) {
        $(this).find('p').css('font-weight', 'normal');
        $("ul.sbmenu_estrategia li.seleccionado a p").css('font-weight', 'bolder');
    });
});


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
