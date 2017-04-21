﻿


function RedirectMenu(ActionName, ControllerName, Flag, Descripcion, parametros) {
    if (ControllerName == "ShowRoom") {
        var pEventoID = $("#hdEventoIDShowRoom").val();
        var pEventoIDVenta = $("#hdEventoIDShowRoomVenta").val();
        if (ActionName == "Index") {
            var container = $('#PopShowroomVenta');
            var pnombreedescripcion = $("#spnShowRoomEventoVenta").val();
            var pnombreeventodescripcion = $("#spnShowRoomEventoDescripcionVenta").val();
            
            dataLayer.push({
                'event': 'promotionClick',                'ecommerce': {
                    'promoView': [
                        {
                            'id': pEventoIDVenta,
                            'name': pnombreedescripcion + ' ' + pnombreeventodescripcion + ' ' + '- Compra ya',
                            'position': 'Desktop menu - 1',
                            'creative': 'Menu'
                        }                    ]                }
            });

        }
        if (ActionName == "Intriga") {
            var container = $('#PopShowroomIntriga');
            var pnombreedescripcion = $("#spnShowRoomEvento").val();
            var pnombreeventodescripcion = $("#spnShowRoomEventoDescripcion").val();

            dataLayer.push({
                'event': 'promotionClick',                'ecommerce': {
                    'promoView': [
                        {
                            'id': pEventoIDVenta,
                            'name': pnombreedescripcion + ' ' + pnombreeventodescripcion + ' ' + '- Entérate primero',
                            'position': 'Desktop menu - 1',
                            'creative': 'Menu'
                        }                    ]
                }
            });
        }



    }

    var URL = '';
    if (ControllerName == '') URL = ActionName;
    else
    {
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

function MostrarMensajeConsultora() {
    showDialog("DialogMensajeProducto");
    $("#DialogMensajeProducto").siblings(".ui-dialog-titlebar").hide();
}

function MostrarMensajeConsultoraValidacion() {
    showDialog("DialogMensajeValidacion");
    $("#DialogMensajeValidacion").siblings(".ui-dialog-titlebar").hide();
}
