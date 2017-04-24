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

            AbrirMensaje(data.message);
            if (data.success == true) {
                PopupCerrar("PopRDSuscripcion");
            }
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("PopRDSuscripcion");
        }
    });
}

function RDDesuscripcion() {

}

function RDPopupNoVolverMostrar() {
    CerrarPopup("PopRDSuscripcion");
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

