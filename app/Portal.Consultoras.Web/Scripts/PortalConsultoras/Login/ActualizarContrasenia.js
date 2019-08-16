var CodigoIngresado;
var correoOriginal = null;

$(document).ready(function () {
    Inicializar();

});


function Inicializar() {
    $("#btnActualizarCorreo").click(function (event) {

        var form = $("#formContrasenia").valid();
        if (!form) {
            return false;
        }
        event.preventDefault();

        ContraseniaRepetida();
    });

    $("#btnConfirmarCambioPassword").click(function () {
        if (CodigoIngresado.length < 6) {
            AbrirAlert('Complete el código');
            return false;
        }
        VerificarCodigo(CodigoIngresado);
    });


    $(".campo_ingreso_codigo").keypress(
        function (evt) {
            if (evt.charCode >= 48 && evt.charCode <= 57) {
                var oID = $(this).attr("id");
                var indicadorID = oID.substring(1, 2);
                var nextfocus = parseInt(oID.substring(0, 1)) + 1;
                $("#" + nextfocus + indicadorID + "Digito").focus();
                return true;
            } else {
                AbrirAlert('Ingrese solo números');
                return false;
            }
        });

    $(".campo_ingreso_codigo").keydown(
        function (e) {
            var tecla = (document.all) ? e.keyCode : e.which;
            if (tecla == 8) {
                var oID = $(this).attr("id");
                var a = oID.substring(1, 2);
                if ($("#" + oID).val() == "") {
                    var backfocus = parseInt(oID.substring(0, 1)) - 1
                    $("#" + backfocus + a + "Digito").focus();
                    return false;
                }
                else return true;
            }
        });

    $(".campo_ingreso_codigo").keyup(
        function (e) {
            $(".IconoError").hide();
            var oID = $(this).attr("id");
            var a = oID.substring(1, 2);
            $('#btnConfirmarCambioPassword').addClass('btn__sb--disabled');
            if ($("#1" + a + "Digito").val() == "")
                return false;
            if ($("#2" + a + "Digito").val() == "")
                return false;
            if ($("#3" + a + "Digito").val() == "")
                return false;
            if ($("#4" + a + "Digito").val() == "")
                return false;
            if ($("#5" + a + "Digito").val() == "")
                return false;
            if ($("#6" + a + "Digito").val() == "")
                return false;
            CodigoIngresado = $("#1" + a + "Digito").val() + $("#2" + a + "Digito").val() + $("#3" + a + "Digito").val() + $("#4" + a + "Digito").val() + $("#5" + a + "Digito").val() + $("#6" + a + "Digito").val();
            $('#btnConfirmarCambioPassword').removeClass('btn__sb--disabled');
        });


    $('.contrasenia').on('input', function (e) {
        var boton = $("#btnActualizarCorreo");
        var form = $("#formContrasenia").valid();
        if (form) {
            boton.removeClass('btn__sb--disabled');
        } else {
            boton.addClass('btn__sb--disabled');
        }

        if ($('#Contrasenia').valid()) {
            $('#passValid').css('display', 'block');
        } else {
            $('#passValid').css('display', 'none');
        }

        if ($('#ConfirmaContrasenia').valid()) {
            $('#passValid2').css('display', 'block');
        } else {
            $('#passValid2').css('display', 'none');
        }

    });

    $('#btnReenviarCorreo').click(function () {
        RecibirPinVerficiacionCorreo(true);
    });

    $('#IrASomosBelcorp').click(function () {
        window.location = urlLogin;
    });

    $('.contrasenia').bind('input', function () {
        var thiss = $(this);
        if (thiss.val().trim() == '') {
            thiss.removeClass('text__field__sb--withContent');
        } else {
            thiss.addClass('text__field__sb--withContent');
        }
    });

    $('#txtCorreoAlCualSeEnvioCodigo').on('input', function (e) {
        if (correoOriginal == null) {
            return false;
        }
        if ($(this).val().trim().length > 0) {
            $('#btnReenviarCorreo').addClass('linkAcentuadoReenvioCodigo');
        } else {
            $('#btnReenviarCorreo').removeClass('linkAcentuadoReenvioCodigo');
        }
    });
}


function mostrarContrasenia(currentElement) {
    var contraseniaType = $(currentElement).parent().find('.text__field__sb')[0].type;

    if ($(currentElement).next().val() != 0) {
        if (contraseniaType === "password") {
            $(currentElement).addClass('enlace__verPassword--mostrar');
            $(currentElement).parent().find('.text__field__sb')[0].type = "text";
        } else {
            $(currentElement).removeClass('enlace__verPassword--mostrar');
            $(currentElement).parent().find('.text__field__sb')[0].type = "password";
        }
    }

}

function activarEditarCorreo() {
    var correo = $('#txtCorreoAlCualSeEnvioCodigo');
    if (correo.is('[readonly]') ) {
        correo.attr("readonly", false);
        correo.focus();
    } else {
        correo.attr("readonly", true);
        correo.blur();
    }
}



function RecibirPinVerficiacionCorreo(reenvio) {
    var correoEnvio = $("#txtCorreoAlCualSeEnvioCodigo").val().trim().toLowerCase();
    var regex = /[\w-\.]{2,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;
    if (!regex.test(correoEnvio) && correoOriginal != null ) {
        AbrirAlert('Ingrese un formato de correo váldo');
        return false;
    }

    $(".seccion").hide();
    $("#VistaPrecarga").show();
    
    var parametros = {
        emailNuevo: (correoOriginal == null) ? null : ((correoOriginal.trim().toLowerCase() == correoEnvio) ? null : correoEnvio)
    };
 
    jQuery.ajax({
        type: 'POST',
        url: urlRecibirPinCambioContrasenia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (data) {            
            $(".seccion").hide();
            $("#Paso2ActualizacionPassword").show();
            $("#txtCorreoAlCualSeEnvioCodigo").val(data.correo);
            $("#Email").val(data.correo);
            if (correoOriginal == null) {
                correoOriginal = data.correo                
            } 
            
            if (!data.success) {
                AbrirAlert(data.menssage);
                return;
            }

            if (reenvio) {
                $('.campo_ingreso_codigo').val('');
                $('#btnConfirmarCambioPassword').addClass('btn__sb--disabled');
                AbrirAlert('Se reenvió el nuevo código');
            }

        },
        error: function (data, error) {
            if (reenvio) {
                $(".seccion").hide();
                AbrirAlert('Error al reenviar el código');
                $("#Paso1ActualizacionPassword").show();
                return;
            }
            if (checkTimeout(data)) {
                $(".seccion").hide();
                AbrirAlert('Error en el Cambio de Contraseña');
                $("#Paso1ActualizacionPassword").show();
            }
        }
    });
}

function VerificarCodigo(CodIngresado) {
    var form = $("#formContrasenia").valid();
    if (!form) {
        $(".seccion").hide();
        $("#Paso1ActualizacionPassword").show();
        AbrirAlert('Error al validar la contraseña, vuelva a intentar');
        return false;
    }

    $(".seccion").hide();
    $("#VistaPrecarga").show();
    var parametros = {
        Codigoingresado: CodIngresado
    };

    $.ajax({
        type: 'POST',
        url: urlVerificarCodigoGenerado,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(parametros),
        async: true,
        success: function (data) {
            if (!data.success) {
                $(".seccion").hide()
                AbrirAlert('Error en la verificacion de código');
                $("#Paso2ActualizacionPassword").show();
                return false;
            }

            CambiarContrasenia();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirAlert('Error en la verificacion de código');
                $(".seccion").hide()
                $("#Paso2ActualizacionPassword").show();
            }
        }
    });

}

function CambiarContrasenia() {
    $(".seccion").hide();
    $("#VistaPrecarga").show();

    jQuery.ajax({
        type: 'POST',
        url: urlCambiaContrasenia,
        dataType: 'json',
        //contentType: 'application/json; charset=utf-8',
        data: $("#formContrasenia").serialize(),
        async: true,
        cache: false,
        //headers: { RequestVerificationToken: token },
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (data.message == "0") {
                        $("#Contrasenia").val('');
                        $("#ConfirmaContrasenia").val('');
                        AbrirAlert('La contraseña anterior ingresada es inválida');
                    } else if (data.message == "1") {
                        $("#Contrasenia").val('');
                        $("#ConfirmaContrasenia").val('');
                        AbrirAlert('Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente');
                    } else if (data.message == "2") {
                        $("#Contrasenia").val('');
                        $("#ConfirmaContrasenia").val('');
                        
                        $(".seccion").hide();
                        $("#Paso3").show();
                        AbrirAlert('Se cambió satisfactoriamente la contraseña');
                    }
                    return false;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $(".seccion").hide()
                $("#Paso2ActualizacionPassword").show();
                AbrirAlert('Error en el Cambio de Contraseña');
            }
        }
    });
}


function ContraseniaRepetida() {
    $(".seccion").hide();
    $("#VistaPrecarga").show();
    var actualizaContrasenia = {
        CodigoIso: $('#CodigoIso').val(),
        CodigoUsuario: $('#CodigoUsuario').val(),
        Contrasenia: $('#Contrasenia').val()
    }
    jQuery.ajax({
        type: 'POST',
        url: urlContraseniaRepetida,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(actualizaContrasenia),
        async: true,
        success: function (data) {
            $(".seccion").hide();
            if (!data.repetido) {
                RecibirPinVerficiacionCorreo();
            } else {
                $(".seccion").hide();
                $("#Paso1ActualizacionPassword").show();
                AbrirAlert(data.menssage);
            }

        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $(".seccion").hide();
                AbrirAlert('Error al validar contraseña');
                $("#Paso1ActualizacionPassword").show();
            }
        }
    });

}