function InsertarProductoIncentivo() {
    HorarioRestringido(function () {
        DesreservarPedido(function () {
            AgregarCuv(function () {
                messageInfoBueno(mensajeRegistroSatisfactorio, RedirectToPedido, RedirectToPedido);
            });
        });
    });
}
function HorarioRestringido(fnSuccess) {
    ShowLoading();
    $.post(urlHorarioRestringido)
        .always(function () { CloseLoading(); })
        .fail(function (jqXHR, textStatus, error) {
            if (!checkTimeout(jqXHR)) return false;

            console.error(jqXHR, textStatus, error);
            messageInfoError(mensajePostFail);
        })
        .done(function (response) {
            if (!checkTimeout(response)) return false;
            if (response.success) {
                messageInfoError(response.message);
                return false;
            }

            if ($.isFunction(fnSuccess)) fnSuccess();
        });
}
function DesreservarPedido(fnSuccess) {
    ShowLoading();
    $.post(urlDesreservarPedido)
        .always(function () { CloseLoading(); })
        .fail(function (jqXHR, textStatus, error) {
            if (!checkTimeout(jqXHR)) return false;

            console.error(jqXHR, textStatus, error);
            messageInfoError(mensajePostFail);
        })
        .done(function (response) {
            if (!checkTimeout(response)) return false;
            if (!response.success) {
                messageInfoError(response.message);
                return false;
            }

            if ($.isFunction(fnSuccess)) fnSuccess();
        });
}
function AgregarCuv(fnSuccess) {
    ShowLoading();
    $.post(urlPedidoInsert, productoModel)
        .always(function () { CloseLoading(); })
        .fail(function (jqXHR, textStatus, error) {
            if (!checkTimeout(jqXHR)) return false;

            console.error(jqXHR, textStatus, error);
            messageInfoError(mensajePostFail);
        })
        .done(function (response) {
            if (!checkTimeout(response)) return false;
            if (!response.success) {
                messageInfoError(response.message);
                return false;
            }

            if ($.isFunction(fnSuccess)) fnSuccess();
        });
}
function RedirectToPedido() {
    ShowLoading();
    if (/Mobi/.test(navigator.userAgent)) location.href = urlPedidoMobile;
    else location.href = urlPedidoWeb;
}

function ShowLoading() { $("#loading-spin").fadeIn(); }
function CloseLoading() { $("#loading-spin").fadeOut("fast"); }

function messageInfoBueno(message, fnAceptar, fnCancelar) {
    $('#mensajeInformacionSB2Bueno').html(message);
    $('#popupInformacionSB2Bueno').show();
    $('#popupInformacionSB2Bueno .btn_ok_mobile').off('click');
    $('#popupInformacionSB2Bueno .cerrar_popMobile').off('click');

    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionSB2Bueno .btn_ok_mobile').on('click', fnAceptar);
    }
    if ($.isFunction(fnCancelar)) {
        $('#popupInformacionSB2Bueno .cerrar_popMobile').on('click', fnCancelar);
    }
}
function messageInfoError(message, fnAceptar) {
    $('#mensajeInformacionSB2_Error').html(message);
    $('#popupInformacionSB2Error').show();
    $('#popupInformacionSB2Error .btn-aceptar').off('click');

    if ($.isFunction(fnAceptar)) {
        $('#popupInformacionSB2Error .btn-aceptar').on('click', fnAceptar);
    }
}