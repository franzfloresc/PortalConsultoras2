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
                AbrirPopup("#PopRDInscrita");
            }
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDDesuscripcion() {

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
    var url = location.href + "/";
    url = url.toUpperCase();
    if (url.indexOf("/BIENVENIDA/") < 0) {
        window.location = "/";
    }
    else {
        CerrarPopup("#PopRDInscrita");
    }
}