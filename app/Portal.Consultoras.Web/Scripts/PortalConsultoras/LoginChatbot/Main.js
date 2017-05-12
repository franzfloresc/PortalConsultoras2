var arrayDeferred = [];
function CargarEventosExternos() {
    if (!webViewFallBack) {
        var d1 = $.Deferred();
        arrayDeferred.push(d1);
        window.extAsyncInit = function () { console.log('extAsyncInit'); d1.resolve(); };
    }
    if (cargaApiFacebook) {
        var d2 = $.Deferred();
        arrayDeferred.push(d2);
        window.fbAsyncInit = function () { console.log('fbAsyncInit'); d2.resolve(); };
    }
    console.log(arrayDeferred);
}
CargarEventosExternos();

$(document).ready(function () { CargarPlugins(); });

function CargarPlugins() {
    if (arrayDeferred.length > 0){
        ShowLoading();
        $.when.apply($, arrayDeferred).then(function () {
            console.log('Terminó CargarPlugins');
            CloseLoading();
            MainInit();
        });
    }
    else MainInit();
}
function MainInit() {
    $('#ddlPais').on('change', function () {
        var paisISO = $(this).val();
        if (IsNullOrEmpty(paisISO)) {
            $('#css-main').attr('href', cssMainEsika);
            $('#div_select_pais').css('background-image', '');
            $('#tooltip_usuario').css('display', 'none');
            $('#tooltip_password').css('display', 'none');
        }
        else {
            $('#css-main').attr('href', paisesEsika.indexOf(paisISO) >= 0 ? cssMainEsika : cssMainLbel);
            $('#div_select_pais').css('background-image', urlFormatImagenBandera.replace(/\{0\}/g, paisISO));
            $('#tooltip_usuario').css('display', '').html(listTooltipUsuario[paisISO]);
            $('#tooltip_password').css('display', '').html(listTooltipPassword[paisISO]);
        }
    });

    if (typeof Init != 'undefined' && $.isFunction(Init)) Init();
}

function ValidarLoginNormal(fnFinal) {
    var paisISO = $('#ddlPais').val();
    var user = $('#txtUsuario').val();
    var password = $('#txtPassword').val();

    var arrayMessage = [];
    if (IsNullOrEmpty(paisISO)) arrayMessage.push('Seleccione un pais');
    if (IsNullOrEmpty(user)) arrayMessage.push('Ingrese su código de usuario');
    if (IsNullOrEmpty(password)) arrayMessage.push('Ingrese su password');

    if (arrayMessage.length > 0) MostrarArrayMensaje(arrayMessage);
    else if ($.isFunction(fnFinal)) {
        var paisID = $('#ddlPais option:selected').data('id');
        fnFinal(paisID, paisISO, user, password);
    }
}

function ResponderBotmaker(url, data) {
    ShowLoading();

    data['userToken'] = tokenBotmaker;
    console.log(url);
    console.log(data);
    $.post(url, data)
        .done(function (response) {
            console.log(response);
            if (!webViewFallBack) {
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

function MessageInfoError(message, fnAceptar) {
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
    MessageInfoError(message);
}

function IsNullOrEmpty(valor) {
    return valor == null || valor == "";
}