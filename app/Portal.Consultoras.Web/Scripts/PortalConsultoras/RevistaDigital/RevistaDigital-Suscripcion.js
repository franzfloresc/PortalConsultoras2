
$(document).ready(function () {
    $("[data-campania1]").html(campaniaNro + 1);
    $("[data-campania2]").html(campaniaNro + 2);
});

function RDPopupCerrar(tipo) {
    AbrirLoad();
    if (tipo == 1) {
        CerrarPopUpRDAnalytics('Banner Inscripción Exitosa');
        location.href = "/";
        return false;
    }

    CerrarPopUpRDAnalytics('Banner Inscribirme a Ésika para mí');
    
    $.ajax({
        type: 'POST',
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

function RDSuscripcion(accion) {
    AbrirLoad();
    InscripcionRDAnalytics();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Suscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success == true) {

                accion = accion || 0;
                if (accion == 0) {
                    CerrarPopup("#PopRDSuscripcion");
                    $("#PopRDInscrita [data-usuario]").html($.trim(usuarioNombre).toUpperCase());
                    AbrirPopupFade("#PopRDInscrita");
                    SuscripcionExistosaRDAnalytics();
                    MostrarMenu(data.CodigoMenu);
                    if (!isMobile()) {
                        CargarBanners();
                    }
                }
                else if (accion == 1) {

                }
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
    CancelarSuscripcionRDAnalytics();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Desuscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success == true) {
                //location.href = "/";
                $('#divAnularSuscripcion').hide();
                $('#divMensajeAnularSuscripcion').show();
                $('html, body').animate({
                    scrollTop: $(window).scrollTop() - 200
                }, 1000, 'swing');
            }
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDPopupNoVolverMostrar() {
    CerrarPopUpRDAnalytics('Banner Inscribirme a Ésika para mí');
    CerrarPopup("#PopRDSuscripcion");
    AbrirLoad();
    $.ajax({
        type: 'POST',
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
    SaberMasRDAnalytics();
    var url = urlRevistaDigital;
    window.location = url;
    //CerrarPopup("#PopRDInscrita");
}
function RDRedireccionarDesuscripcion() {
    IrCancelarSuscripcionRDAnalytics();
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

function MostrarPopupRDAnalytics() {
    dataLayer.push({
        'event': 'promotionView',
        'ecommerce': {
            'promoView': {
                'promotions': [
                    {
                        'id': '1',
                        'name': 'Revista Online - Inscribirme a Ésika para mí',
                        'position': 'Home pop-up - 1',
                        'creative': 'Banner'
                    }]
            }
        }
    });
}

function InscripcionRDAnalytics() {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                    {
                        'id': '1',
                        'name': 'Revista Online - Inscribirme a Ésika para mí',
                        'position': 'Home pop-up - 1',
                        'creative': 'Banner'
                    }]
            }
        }
    });
}

function SuscripcionExistosaRDAnalytics() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Revista Online',
        'action': 'Suscripción Exitosa',
        'label': '(not available)'
    });
}

function SaberMasRDAnalytics() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Revista Online',
        'action': 'Click Botón',
        'label': 'Saber más de Ésika para mí'
    });
}

function CerrarPopUpRDAnalytics(tipoBanner) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Revista Online',
        'action': 'Cerrar popup',
        'label': tipoBanner
    });
}

function IrCancelarSuscripcionRDAnalytics() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Revista Online',
        'action': 'Click Link Cancelar Suscripción',
        'label': 'Banner'
    });
}

function CancelarSuscripcionRDAnalytics() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Revista Online',
        'action': 'Cancelar inscripción',
        'label': '(not available)'
    });
}

