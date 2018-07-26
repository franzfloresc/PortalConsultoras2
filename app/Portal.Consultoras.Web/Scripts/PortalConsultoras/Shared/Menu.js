﻿
function RedirectMenu(ActionName, ControllerName, Flag, Descripcion, parametros) {
    if (ControllerName == "ShowRoom") {
        var pEventoIDVenta = $("#hdEventoIDShowRoomVenta").val();
        if (ActionName == "Index") {
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

        window.location.href = URL;
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

function modificarAnchoBuscadorFiltros() {
    if (window.location.href.indexOf("Pedido") > -1) {
        if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
            $('.buscador_filtros').addClass('buscador_filtros_con_enlace_menu_socia_empresaria_vista_pedido');
        } else {
            $('.buscador_filtros').addClass('buscador_filtros_sin_enlace_menu_socia_empresaria_vista_pedido');
        }
    } else if (window.location.href.indexOf("Ofertas") > -1) {
        if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
            $('.buscador_filtros').addClass('buscador_filtros_con_enlace_menu_socia_empresaria_vista_ofertas');
        } else {
            $('.buscador_filtros').addClass('buscador_filtros_sin_enlace_menu_socia_empresaria_vista_ofertas');
        }    
    } else {
        if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
            $('.buscador_filtros').addClass('buscador_filtros_con_enlace_menu_socia_empresaria');
        } else {
            $('.buscador_filtros').addClass('buscador_filtros_sin_enlace_menu_socia_empresaria');
        }
    }
}

function accionesCampoBusquedaAlDigitar() {
    $('body').on('keyup', '#CampoBuscadorProductos', function () {
        var cantidadCaracteresParaMostrarSugerenciasBusqueda = $('#CampoBuscadorProductos').val().length;
        if (cantidadCaracteresParaMostrarSugerenciasBusqueda > 3) {
            $('.enlace_busqueda_filtros').fadeOut(250);
            $('.opcion_limpiar_campo_busqueda_productos').delay(150);
            $('.opcion_limpiar_campo_busqueda_productos').fadeIn(250);
        } else {
            $('.opcion_limpiar_campo_busqueda_productos').fadeOut(250);
            $('.enlace_busqueda_filtros').delay(150);
            $('.enlace_busqueda_filtros').fadeIn(250);
        }
    });

    $('body').on('click', '.opcion_limpiar_campo_busqueda_productos', function (e) {
        e.preventDefault();
        $('.opcion_limpiar_campo_busqueda_productos').fadeOut(250);
        $('.enlace_busqueda_filtros').delay(150);
        $('.enlace_busqueda_filtros').fadeIn(250);
        $('#CampoBuscadorProductos').val('');
    });
}

accionesCampoBusquedaAlDigitar();
modificarAnchoBuscadorFiltros();
