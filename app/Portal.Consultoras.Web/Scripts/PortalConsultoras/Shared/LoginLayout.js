var showUser = false;
var val_Usuario = false;
var val_Password = false;

window.history.forward(0);

function noback() {
    window.history.forward(0);
}

$(document).ready(function () {

    // sirve para limpiar LocalStorage
    LocalStorageLimpiar();
    /*
    if (esPaisEsika == 'True') {
        $('#cssStyle>link').attr('disabled', false);
        $('#cssStyleLbel>link').attr('disabled', true);
    }
    if (esPaisLbel == 'True') {
        $('#cssStyle>link').attr('disabled', true);
        $('#cssStyleLbel>link').attr('disabled', false);
    }*/

    $(".DropDown").change(function () {
        val_Usuario = false;
        val_Password = false;
        EjecutarMensajes();
    });

    EjecutarMensajes();

    $(".content-alerta-red-user > div").click(function (e) {
        e.stopPropagation();
        AbrirMensajeLogin(1, true);
    });

    $(".content-alerta-red-clave > div").click(function (e) {
        e.stopPropagation();
        AbrirMensajeLogin(2, true);
    });

    $(".content-alerta-red-user, .content-alerta-red-clave").click(function (e) {
        if ($(window).width() > 1093) {
            $(this).hide();
        }
        var element = $(document.elementFromPoint(e.clientX, e.clientY));
        var parent = element.parent();

        if (parent.is("a")) parent.trigger("click");
        $(this).show();
    });

    $(".nav0")
        .mouseover(function () { $(this).find("img").attr("src", "Images/login/ico0_b.png"); })
        .mouseout(function () { $(this).find("img").attr("src", "Images/login/ico0.png"); });
    $(".nav1")
        .mouseover(function () { $(this).find("img").attr("src", "Images/login/ico1_b.png"); })
        .mouseout(function () { $(this).find("img").attr("src", "Images/login/ico1.png"); });
    $(".nav2")
        .mouseover(function () { $(this).find("img").attr("src", "Images/login/ico2_b.png"); })
        .mouseout(function () { $(this).find("img").attr("src", "Images/login/ico2.png"); });
    $(".nav3")
        .mouseover(function () { $(this).find("img").attr("src", "Images/login/ico3_b.png"); })
        .mouseout(function () { $(this).find("img").attr("src", "Images/login/ico3.png"); });
});

function Jqueryplaceholder(Control) {
    $('#' + Control).val('');
    $('#' + Control).focus(function () {
        var placeholdertext = $(this).attr('placeholder');
        var pass = $('<input id="' + Control + '" class="inputForm" type="password" placeholder="' + placeholdertext + '">');
        $(this).replaceWith(pass);
        $('#' + Control).focus();
        $('#' + Control).blur(function () {
            if ($(this).val().length == 0) {
                var placeholdertext = $(this).attr('placeholder');
                var pass = $('<input id="' + Control + '" class="inputForm" type="password" value="' + placeholdertext + '" placeholder="' + placeholdertext + '">');
                $(this).replaceWith(pass);
                Jqueryplaceholder(Control);
            }
        })
    });
}

function EjecutarMensajes() {

    var dpIso = $(".DropDown").val();
    if (dpIso == null) return;

    $('div.content-alerta-red-user > div').removeClass("alerta_red_block");
    $('div.content-alerta-red-clave > div').removeClass("alerta_red_block");

    if ($(".DropDown").val() != "00") {
        var result = $('#hdfPaises').val().indexOf($(".DropDown").val());
        if (result == -1) {
            if ($(".DropDown").val() == "BR") {
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Login/Belcorp-BR'
                });
                location.href = "http://www.somosbelcorp.com.br";
            }
        }
        else {

            switch ($(".DropDown").val()) {
                case "PE": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "BO": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "CL": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "PA": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "GT": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "CR": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "SV": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "PR": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "DO": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "MX": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "inline-block" }); break;
                case "AR": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "EC": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "VE": $('#PagoLinea').css({ "display": "none" }); $('#DespachosCobranza').css({ "display": "none" }); break;
                case "CO": $('#PagoLinea').css({ "display": "inline-block" }); $('#DespachosCobranza').css({ "display": "none" }); break;
            }
        }
    }
    else {
        $('#PagoLinea').css({ "display": "none" });
        $('#DespachosCobranza').css({ "display": "none" });
    }
}

function openDialog() {
    _gaq.push(['_trackEvent', 'Link', 'Crear-cuenta']);
    analytics.invocarEventoPixel("CreaCorreoAqui");

    document.getElementById("bg_1").style.display = "block";
}

function closeit() {
    document.getElementById("bg_1").style.display = "none";
}

function openMant() {
    document.getElementById("divMant").style.display = "block";
}

function closeMant() {
    document.getElementById("divMant").style.display = "none";
}

function RedirectComunidadVirtual() {
    analytics.invocarEventoPixel("ComunidadVirtual");

    window.open('http://comunidad.somosbelcorp.com', '_self');
    return false;
}
function RedirectBelcorpResponde() {
    _gaq.push(['_trackEvent', 'Link', 'Belcorp-Responde']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Login/Belcorp-Responde'
    });
    window.open('https://www2.somosbelcorp.com/belcorpresponde/belcorp-responde.asp', '_blank');
    return false;
}
function RedirectDespachosCobranza() {
    window.open('https://www.somosbelcorp.com/WebPages/DespachosCobranza.aspx', '_blank');
    return false;
}
function RedirectPagoLinea() {
    _gaq.push(['_trackEvent', 'Link', 'Pago-Linea']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Login/Pago-Linea'
    });
    window.open('https://www.zonapagos.com/t_belstar/pagos.asp', '_blank');
    return false;
}
function RedirectUneteaBelcorp() {
    _gaq.push(['_trackEvent', 'Link', 'Unete-Belcorp']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Login/Unete-Belcorp'
    });
    analytics.invocarEventoPixel("UneteABelcorp");

    window.open('http://www.uneteabelcorp.com/', '_blank');
    return false;
}

function RedirectAdministrador() {
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Login/Administrador'
    });
    //window.open('https://identidad.belcorp.biz/adfs/ls/?wa=wsignin1.0&wtrealm=https://sts.somosbelcorp.com/adfs/services/trust', '_self');
    //return false;
}

function RedirectRecuperarClave() {
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Login/RecuperarClave'
    });
    window.open('https://www.somosbelcorp.com/WebPages/RecuperarClave.aspx', '_blank');
    return false;
}

function GALogOut() {
    _gaq.push(['_trackPageview', '/Somosbelcorp/Logout']);
    location.href = 'https://www.somosbelcorp.com';
}

function Ayuda(Tipo) {
    if (Tipo == 1) {
        _gaq.push(['_trackEvent', 'Login', 'Ayuda', 'Usuario']);
    }
    if (Tipo == 2) {
        _gaq.push(['_trackEvent', 'Login', 'Ayuda', 'Clave']);
    }
}

function Correo(Tipo) {
    if (Tipo == 1) {
        _gaq.push(['_trackEvent', 'Login', 'Crear-cuenta', 'GMail']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Login/Crear-cuenta-GMail'
        });
        window.open('http://www.gmail.com', '_blank');
    }
    if (Tipo == 2) {
        _gaq.push(['_trackEvent', 'Login', 'Crear-cuenta', 'Yahoo']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Login/Crear-cuenta-Yahoo'
        });
        window.open('https://login.yahoo.com/config/login_verify2?.intl=pe&.src=ym', '_blank');
    }
    if (Tipo == 3) {
        _gaq.push(['_trackEvent', 'Login', 'Crear-cuenta', 'Hotmail']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Login/Crear-cuenta-Hotmail'
        });
        window.open('https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=11&ct=1362435576&rver=6.1.6206.0&wp=MBI&wreply=http:%2F%2Fmail.live.com%2Fdefault.aspx&lc=3082&id=64855&mkt=es-es&cbcxt=mai&snsc=1', '_blank');
    }
    if (Tipo == 4) {
        _gaq.push(['_trackEvent', 'Login', 'Crear-cuenta', 'Outlook']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Login/Crear-cuenta-Outlook'
        });
        window.open('https://login.live.com/login.srf?wa=wsignin1.0&ct=1362435602&rver=6.1.6206.0&sa=1&ntprob=-1&wp=MBI_SSL_SHARED&wreply=https:%2F%2Fmail.live.com%2F%3Fowa%3D1%26owasuffix%3Dowa%252f&id=64855&snsc=1&cbcxt=mail', '_blank');
    }
}

function AbrirFooter(Marca, Url) {
    _gaq.push(['_trackEvent', 'Link', Marca, 'Site']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Login/' + Marca
    });
    window.open(Url, '_blank');
    return false;
}

/**
 * Problema de seguridad como: 
 * Uncaught SecurityError: Failed to read the 'localStorage' property from 'Window': Access is denied for this document.
 * @param storage {Storage}
 * return true|false {Bolean}
 * uso: storageIsSuport(window.localStorage)
 */
function storageIsSuport(storage) {
    try {
        const key = "__some_random_value__";
        storage.setItem(key, key);
        storage.removeItem(key);
        return true;
    } catch (e) {
        return false;
    }
}

function LocalStorageLimpiar() {

    if (typeof (Storage) !== 'undefined' && storageIsSuport(window.localStorage)) {
        var itemSBTokenPais = localStorage.getItem('SBTokenPais');
        var itemSBTokenPedido = localStorage.getItem('SBTokenPedido');
        var itemChatEConnected = localStorage.getItem('connected');//add
        var itemChatEConfigParams = localStorage.getItem('ConfigParams');//add

        localStorage.clear();

        if (typeof (itemSBTokenPais) !== 'undefined' && itemSBTokenPais !== null) {
            localStorage.setItem('SBTokenPais', itemSBTokenPais);
        }

        if (typeof (itemSBTokenPedido) !== 'undefined' && itemSBTokenPedido !== null) {
            localStorage.setItem('SBTokenPedido', itemSBTokenPedido);
        }

        if (typeof (itemChatEConnected) !== 'undefined' && itemChatEConnected !== null) {//add
            localStorage.setItem('connected', itemChatEConnected);
        }

        if (typeof (itemChatEConfigParams) !== 'undefined' && itemChatEConfigParams !== null) {//add
            localStorage.setItem('ConfigParams', itemChatEConfigParams);
        }
    }
};
