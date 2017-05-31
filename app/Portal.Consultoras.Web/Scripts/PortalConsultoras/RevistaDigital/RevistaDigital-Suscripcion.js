
$(document).ready(function () {
    $("[data-campania1]").html(campaniaNro + 1);
    $("[data-campania2]").html(campaniaNro + 2);
});

function RDPopupCerrar() {
    AbrirLoad();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'RevistaDigital/PopupCerrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDSuscripcion() {
    AbrirLoad();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'RevistaDigital/Suscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success == true) {
                CerrarPopup("#PopRDSuscripcion");
                $("#PopRDInscrita [data-usuario]").html($.trim(usuarioNombre).toUpperCase());
                AbrirPopupFade("#PopRDInscrita");
                MostrarMenu(data.CodigoMenu);
            }
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDDesuscripcion() {
    AbrirLoad();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'RevistaDigital/Desuscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success == true) {
                location.href = "/";
            }
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDPopupNoVolverMostrar() {
    CerrarPopup("#PopRDSuscripcion");
    AbrirLoad();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'RevistaDigital/PopupNoVolverMostrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDInformacion() {
    location.href = urlInformacionSuscripcion;
}

function RDSuscripcionRedireccionar() {
    var url = urlRevistaDigital;
    window.location = url;
    //CerrarPopup("#PopRDInscrita");
}
function RDRedireccionarDesuscripcion() {
    var url = urlRevistaDigital;
    var divPosition = '#divAnularSuscripcion';
    window.location = url + divPosition;
    //CerrarPopup("#PopRDInscrita");
}
function MostrarTerminos() {
    var win = window.open(urlTerminosCondicionesRD, '_blank');
    if (win) {
        //Browser has allowed it to be opened
        win.focus();
    } else {
        //Browser has blocked it
        //alert('Please allow popups for this website');
        console.log("Habilitar mostrar popup");
    }
}