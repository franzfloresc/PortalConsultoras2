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

    if (email !== '') {
        if (!validateEmail(email)) {
            $('#Email').focus();
            alert("El formato del correo electrónico ingresado no es correcto.\n");
            return false;
        }
    }

    if (celular !== '') {
        AbrirLoad();
        if (!ValidarTelefono(celular)) {
            alert('El formato del celular no es correcto.');
            CerrarLoad();
            return false;
        }
        CerrarLoad();

        var tieneCantidadMinimaCaracteres = limitarMinimo(celular, $("#hdn_CaracterMinimo").val(), 2);
        if (!tieneCantidadMinimaCaracteres) {
            $('#txtCelularMD').focus();
            alert('El formato del celular no es correcto.');
            return false;
        }
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

function ValidarTelefono(celular) {
    var resultado = false;

    var item = {
        Telefono: celular
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/ValidadTelefonoConsultora',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                resultado = false;
            else
                resultado = data.success;
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) { }
        }
    });

    return resultado;
}

function limitarMaximo(e, contenido, caracteres, id) {
    var unicode = e.keyCode ? e.keyCode : e.charCode;
    if (unicode == 8 || unicode == 46 || unicode == 13 || unicode == 9 || unicode == 37 ||
        unicode == 39 || unicode == 38 || unicode == 40 || unicode == 17 || unicode == 67 || unicode == 86)
        return true;

    if (contenido.length >= caracteres) {
        selectedText = document.getSelection();
        if (selectedText == contenido) {
            $("#" + id).val("");
            return true;
        } else if (selectedText != "") {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

function limitarMinimo(contenido, caracteres, a) {
    if (contenido.length < caracteres && contenido.trim() != "") {
        var texto = a == 1 ? "teléfono" : a == 2 ? "celular" : "otro teléfono";
        alert('El número de ' + texto + ' debe tener como mínimo ' + caracteres + ' números.');
        return false;
    }
    return true;
}