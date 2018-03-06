$(document).ready(function () {
    
    $(".popup_confirmacion_datos .form-datos .input input#Email").on("keyup", function (event) {
        event.stopPropagation();
        ValidateButton();
    });
    
    $(".popup_confirmacion_datos .form-datos .input input#Celular").on("keyup", function (event) {
        event.stopPropagation();
        ValidateButton();
    });
    
    $(".popup_confirmacion_datos .form-datos .input input#Email").on("blur", function (event) {
        event.stopPropagation();
        CheckEmail();
    });

    $(".popup_confirmacion_datos .form-datos .input input#Celular").on("blur", function (event) {
        event.stopPropagation();
        CheckPhone();
    });
    
    $("#chkinput").on("change", function (event) {
        event.stopPropagation();
        CheckTermCondiciones();
    });
    
    $("#buttonConfirmarDatos").on("click", function (event) {
        event.stopPropagation();
        RDConfirmarDatos();
    });
    
    $("a[data-popup-close=PopRDSuscripcion]").on("click", function () {
        rdAnalyticsModule.CerrarPopUp("ConfirmarDatos");
        window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
    });
});

function CheckTermCondiciones() {
    if ($("#chkinput").attr("checked")) {
        $("label[for='chkinput']").css("border", "none");
        return true;
    } else {
        $("label[for='chkinput']").css("border", "1px solid red");
        return false;
    }
}

function CheckEmail() {
    var email = $.trim($("#Email").val()).toString();
    if (email !== "") {
        if (!validateEmail(email)) {
            $("#Email").focus();
            $("#errorEmail").text("El formato del correo ingresado no es correcto.").fadeIn();
            return false;
        } else LimpiarError();

    } else LimpiarError();
    return true;
}

function CheckPhone() {
    var celular = $.trim($("#Celular").val()).toString();
    if (celular !== "") {
        var error = false;

        if (!limitarMinimo(celular, $("#hdn_CaracterMinimo").val(), 2)) {
            $("#txtCelularMD").focus();
            $("#errorPhone").text("El formato del celular no es correcto.").fadeIn();
            error = true;
        } else {
            if (!ValidarTelefono(celular)) {
                $("#errorPhone").text("El número de celular ya está en uso.").fadeIn();
                error = true;
            }
        }
        if (error) return false;
        else LimpiarError();
    } else LimpiarError();
    return true;
}

function LimpiarError() {
    $("#errorPhone").fadeOut();
    $("#errorEmail").fadeOut();
    $("#errorCampos").fadeOut();
}

function ValidateButton() {
    if ($(".popup_confirmacion_datos .form-datos .input input#Email").val() != "" || $(".popup_confirmacion_datos .form-datos .input input#Celular").val() != "") {
        $(".popup_confirmacion_datos .form-datos button").removeAttr("disabled");
        $(".popup_confirmacion_datos .form-datos button").addClass("activar_boton_popup_confirma_datos");
        $(".popup_confirmacion_datos .form-datos button").removeClass("desactivar_boton_popup_confirma_datos");
    }
    else {
        $(".popup_confirmacion_datos .form-datos button").attr("disabled", "disabled");
        $(".popup_confirmacion_datos .form-datos button").addClass("desactivar_boton_popup_confirma_datos");
        $(".popup_confirmacion_datos .form-datos button").removeClass("activar_boton_popup_confirma_datos");
        LimpiarError();
    }
}
function RDConfirmarDatos() {
    AbrirLoad();
    if (CheckTermCondiciones() && CheckEmail() && CheckPhone()) {
        AbrirLoad();
        var correoAnterior = $.trim($("#CorreoAnterior").val());
        var celular = $.trim($("#Celular").val()).toString();
        var email = $.trim($("#Email").val()).toString();

        var confirmarDatosModel = {
            Email: email,
            Celular: celular,
            CorreoAnterior: correoAnterior
        }

        rdAnalyticsModule.GuardarDatos();
        RDConfirmarDatosPromise(confirmarDatosModel).then(
            function(data) {
                CerrarLoad();
                //alert(data.message);
                window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
            },
            function(xhr, status, error) {
                CerrarLoad();
            }
        );
    } else {
        CerrarLoad();
    }
} 

function RDConfirmarDatosPromise(confirmarDatosModel) {

    var d = $.Deferred();

    var promise = $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/ActualizarDatos",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
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
        type: "POST",
        url: baseUrl + "Bienvenida/ValidadTelefonoConsultora",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
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
        return false;
    } 
    return true;
}