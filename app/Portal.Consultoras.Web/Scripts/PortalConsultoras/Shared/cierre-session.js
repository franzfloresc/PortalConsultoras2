﻿$(function() {
    if (noPedidoReservado()) {
        registerCloseEvent();
    }
    configureTimeoutPopup();
});

function configureTimeoutPopup() {
    $(document).idleTimeout({
        redirectUrl: baseUrl + 'Login/LogOut',       // redirect to this url
        idleTimeLimit: 1860,            // 15 seconds 'No activity' time limit in seconds.
        activityEvents: 'click keypress scroll wheel mousewheel',    // separate each event with a space
        dialogDisplayLimit: 48,       // Time to display the warning dialog before logout (and optional callback) in seconds
        sessionKeepAliveTimer: false  // Set to false to disable pings.
    });
}

function irReservarPedido() {
    var url = baseUrl + (isMobile() ? 'Mobile/Pedido/Detalle' : 'Pedido');

    $.fn.idleTimeout().reset();
    window.location.href = url;
}

function getPopupCierreSession() {
    return $('#PopupCierreSesion');
}

function registerCloseEvent() {
    window.onbeforeunload = function(e) {
        var dialogText = "Tienes un pedido pendiente, ¿Deseas reservarlo?";
        e.returnValue = dialogText;
        e.cancelBubble = true;
        CerrarSesionValidado();
        return dialogText;
    };
}

function continuarSession() {
    var urlKeepAlive = baseUrl + 'Bienvenida/KeepAlive';
    $.fn.idleTimeout().reset();
    $.get(urlKeepAlive);
}

function noPedidoReservado() {
    if (typeof NoReservoPedido === 'undefined') {
        return false;
    }
    
    return NoReservoPedido;
}

function CerrarSesionValidado() {

    if (noPedidoReservado()) {
        showPopupCierreSesion(1);

        return;
    }

    if (typeof CerrarSesion === 'function') {
        CerrarSesion();
    } else {
        location.href = baseUrl + 'Login/LogOut';
    }

    $.fn.idleTimeout().logout();
}

function showPopupFinSesion() {
    showPopupCierreSesion(4);
}

function showPopupCierreSesion(tipo) {
    SetupPopupCierreSesion(tipo);
    getPopupCierreSession().fadeIn(100);
}

function SetupPopupCierreSesion(tipo) {
    var popup = getPopupCierreSession();
    var body = popup.find('.popup_cierre_sesion_mensaje');
    var icono = popup.find('.popup_cierre_sesion_icono');
    popup.find('button').hide();
    popup.find('a').hide();
    icono.removeClass('icono_sesion_por_finalizar').removeClass('icono_alerta_cierre_sesion');
    popup.data('tipo', tipo);

    switch (tipo) {
        case 1:
            body.html('Tienes un pedido pendiente <br /> ¿Deseas reservarlo?');
            icono.addClass('icono_alerta_cierre_sesion');
            popup.find('.popup_cierre_sesion_btn_reservar_pedido').show();
            popup.find('[sb-cerrar]').show();

            break;
        case 2:
            body.html('Tu sesión finalizará en : <span class="text-bold" id="countdownDisplay"></span> <br />¿Deseas continuar?');
            icono.addClass('icono_sesion_por_finalizar');
            popup.find('.popup_cierre_sesion_btn_continuar').show();
            popup.find('[sb-cerrar]').show();
            break;
        case 3:
            body.html('Tu sesión finalizará en : <span class="text-bold" id="countdownDisplay"></span> <br /> Y tienes un pedido pendiente ¿Deseas reservarlo?');
            icono.addClass('icono_sesion_por_finalizar');
            popup.find('.popup_cierre_sesion_btn_reservar_pedido').show();
            popup.find('[sb-cerrar]').show();
            break;
        case 4:
            body.html('Se ha finalizado tu sesión. Ingresa nuevamente a tu cuenta.');
            icono.addClass('icono_alerta_cierre_sesion');
            popup.find('[sb-ingresar]').show();
            break;
    }
}