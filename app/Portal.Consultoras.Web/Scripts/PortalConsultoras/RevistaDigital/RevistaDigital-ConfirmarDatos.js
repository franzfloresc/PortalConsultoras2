$(document).ready(function () {
    $("a[data-popup-close=PopRDSuscripcion]").on("click", function () {
        rdAnalyticsModule.CerrarPopUp("ConfirmarDatos");
        window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
    });

    $("#Celular").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });

    $("#Email").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
            return re.test(keyChar);
        }
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

    rdAnalyticsModule.GuardarDatos();
    
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

    promise.done(function(response) {
        d.resolve(response);
    });

    promise.fail(d.reject);

    return d.promise();
}