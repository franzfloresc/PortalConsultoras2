function RDConfirmarDatos() {
    AbrirLoad();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Desuscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RedireccionarVista(Vista) {

    vista = $.trim(Vista);
    window.location = (isMobile() ? "/Mobile" : "") + "/" + vista;
}