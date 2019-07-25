var expiredSession = false;

$(function() {
    //if (noPedidoReservado()) {
    //    registerCloseEvent();
    //}
    configureTimeoutPopup();

    $(document).ajaxComplete(function( event, xhr, settings ) {
        if (!settings || !settings.url || settings.crossDomain) {
            return;
        }

        var url = settings.url || '';
        if (url.toLowerCase().startsWith('/login')) {
            return;
        }

        if (window.idleTimeout) {
            window.idleTimeout.restarTimer();
        }
    });
});

function configureTimeoutPopup() {
    if (typeof SessionTimeout === 'undefined') {
        return;
    }
    var timeoutSeconds = (SessionTimeout * 60) - 60;
    var timeShowPopup = 48;

    window.idleTimeout = $.fn.idleTimeout({
        redirectUrl: baseUrl + 'Login/LogOut',       // redirect to this url
        idleTimeLimit: timeoutSeconds - timeShowPopup,            // 15 seconds 'No activity' time limit in seconds.
        dialogDisplayLimit: timeShowPopup,       // Time to display the warning dialog before logout (and optional callback) in seconds
        sessionKeepAliveTimer: false,  // Set to false to disable pings.
        endSessionCallback: function() {
            forceCloseSession();
        }
    });
}

function irReservarPedido() {
    var url = baseUrl + (isMobile() ? 'Mobile/Pedido/Detalle' : 'Pedido');

    window.idleTimeout.reset();
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
	window.idleTimeout.reset();
    callKeepAlive();
}

function closeCierreSession() {
    if (expiredSession) {
        CerrarSesion();
    } else {
        continuarSession();
    }
}

function callKeepAlive() {
    var urlKeepAlive = baseUrl + 'Bienvenida/KeepAlive';

    return $.get(urlKeepAlive).then(function(result) {
        checkTimeout(result);
    });
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

    window.idleTimeout.logout();
}

function forceCloseSession() {
    $.get(baseUrl + 'Login/LogOut');

    if (typeof history === 'undefined') return;

    for (var i = 0; i < 50; i++) {
        history.pushState({}, '', '');
    }
}

function showPopupFinSesion() {
    expiredSession = true;
    showPopupCierreSesion(4);
}

function showPopupCierreSesion(tipo) {
    SetupPopupCierreSesion(tipo);
    getPopupCierreSession().fadeIn(100);
}

function SetupPopupCierreSesion(tipo) {
    var popup = getPopupCierreSession();
    var body = popup.find('.popup__somos__belcorp__mensaje--cierreSesion');
    var icono = popup.find('.popup__somos__belcorp__icono--cierreSesion');
    popup.find('button').hide();
    popup.find('a').hide();
    icono.removeClass('popup__somos__belcorp__icono--sesionPorFinalizar').removeClass('popup__somos__belcorp__icono--alertaCierreSesion');
    popup.data('tipo', tipo);

    switch (tipo) {
        case 1:
            body.html('Recuerda que aún no reservas tu pedido <br /><span class="text-bold">¿Deseas reservarlo?</span>');
            icono.addClass('popup__somos__belcorp__icono--alertaCierreSesion');
            popup.find('.popup__somos__belcorp__btn--reservarPedido').show();
            popup.find('[sb-cerrar]').show();

            break;
        case 2:
            body.html('Tu sesión finalizará en : <span class="text-bold" id="countdownDisplay"></span><br /><span class="text-bold">¿Deseas continuar?</span>');
            icono.addClass('popup__somos__belcorp__icono--sesionPorFinalizar');
            popup.find('.popup__somos__belcorp__btn--continuar').show();
            popup.find('[sb-cerrar]').show();
            break;
        case 3:
            body.html('<span class="info__tiempo__cierreSesion">Tu sesión finalizará en : <span class="text-bold" id="countdownDisplay"></span></span><span class="text-bold">Recuerda que aún no reservas tu pedido<br/>¿Deseas reservar?</span>');
            icono.addClass('popup__somos__belcorp__icono--alertaCierreSesion');
            popup.find('.popup__somos__belcorp__btn--reservarPedido').show();
            popup.find('[sb-cerrar]').show();
            break;
        case 4:
            body.html('Se ha finalizado tu sesión.<br />Ingresa nuevamente a tu cuenta.');
            icono.addClass('popup__somos__belcorp__icono--sesionPorFinalizar');
            popup.find('[sb-ingresar]').show();
            break;
    }
}
