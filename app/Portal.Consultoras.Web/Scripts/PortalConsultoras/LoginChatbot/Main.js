$(document).ready(function () { CargarPlugins(); })

function CargarPlugins() {
    var arrayDeferred = [];
    if (webViewFallBack == 0) {
        var d1 = $.Deferred();
        arrayDeferred.push(d1);
        window.extAsyncInit = function () { d1.resolve(); };
    }
    if (cargaApiFacebook == 1) {
        var d2 = $.Deferred();
        arrayDeferred.push(d2);
        window.fbAsyncInit = function () { d2.resolve(); };
    }

    if (arrayDeferred.length > 0){
        ShowLoading();
        $.when.apply($, arrayDeferred).then(function () {
            CloseLoading();
            CallInit();
        });
    }
    else CallInit();
}
function CallInit() { if (typeof Init != 'undefined' && $.isFunction(Init)) Init(); }

function ResponderBotmaker(url, data) {
    ShowLoading();

    data['userToken'] = tokenBotmaker;
    console.log(url);
    console.log(data);
    $.post(url, data)
        .done(function (response) {
            console.log(response);
            if (webViewFallBack == 0) {
                MessengerExtensions.requestCloseBrowser(
                    function success() { },
                    function error(err) { console.warn('Problems closing browser:' + err); }
                );
            }
            else CloseWindow();
        })
        .fail(function (a, b, c) {
            console.log(a); console.log(b); console.log(c);
            console.log("error");
        })
        .always(function (a, b, c) {
            console.log(a); console.log(b); console.log(c);
            console.log("finished");
        });
}

function ShowLoading() { $("#loading-spin").fadeIn(); }
function CloseLoading() { $("#loading-spin").fadeOut("fast"); }
function CloseWindow() { window.location.href = urlBotmakerChat; }

function messageInfoError(message, fnAceptar) {
    $('#mensajeInformacionSB2_Error').html(message);
    $('#popupInformacionSB2Error .btn-aceptar').off('click');
    if ($.isFunction(fnAceptar)) $('#popupInformacionSB2Error .btn-aceptar').on('click', fnAceptar);
    
    $('#popupInformacionSB2Error').show();
}
function MostrarArrayMensaje(arrayMessage) {
    var message = '';
    $.each(arrayMessage, function (i, value) {
        if (i > 0) message += '<br/>';
        message += value;
    });
    messageInfoError(message);
}

function IsNullOrEmpty(valor) {
    return valor == null || valor == "";
}