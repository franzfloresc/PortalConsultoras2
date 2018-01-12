$(document).ready(function () {
    $("a[data-popup-close=PopRDSuscripcion]").on("click", function () {
        window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
    });
});

function RDConfirmarDatos() {
    var correoAnterior = $.trim($('#CorreoAnterior').val());
    var email = $.trim($('#Email').val());
    var celular = $.trim($('#Celular').val());

    if (email === '' && celular === '') {
        alert('Debe ingresar al menos un campo.');
        return false;
    }

    var confirmarDatosModel = {
        Email: email,
        Celular: celular,
        CorreoAnterior: correoAnterior
    }

    AbrirLoad();
    RDConfirmarDatosPromise(confirmarDatosModel).then(
        function (data) {
            CerrarLoad();
            alert(data.message);
            window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        function (xhr, status, error) {
            CerrarLoad();
            console.log(xhr.responseText);
        }
    );
} 

function RDConfirmarDatosPromise(confirmarDatosModel) {

    var d = $.Deferred();

    var promise = $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/ActualizarDatos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(confirmarDatosModel),
        async: true
    });

    promise.done(function (response) {
        d.resolve(response);
    })

    promise.fail(d.reject);

    return d.promise();
}