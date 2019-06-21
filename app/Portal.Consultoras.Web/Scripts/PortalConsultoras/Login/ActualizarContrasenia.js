var CodigoIngresado;

$(document).ready(function () {
    Inicializar();

});


function Inicializar() {
    $("#btnActualizarCorreo").click(function (event) {
        debugger;

        var form = $("#formContrasenia").valid();
        if (!form) {
            return false;
        }
        event.preventDefault();

        ContraseniaRepetida();
    });

    $("#btnConfirmarCambioPassword").click(function () {
        if (CodigoIngresado.length < 6) {
            alert('Complete el código');
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
                alert("Ingrese solo números.")
                return false;
            }
        });

    $(".campo_ingreso_codigo").keydown(
        function (e) {
            tecla = (document.all) ? e.keyCode : e.which;
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
            //VerificarCodigo(CodigosmsIngresado);
        });


    $('.contrasenia').on('input', function (e) {
        var boton = $("#btnActualizarCorreo");
        var form = $("#formContrasenia").valid();
        if (form) {
            boton.removeClass('btn__sb--disabled');
        } else {
            boton.addClass('btn__sb--disabled');
        }
    }); 

    $('#btnReenviarCorreo').click(function () {
        RecibirPinVerficiacionCorreo(true);
    });

    $('#IrASomosBelcorp').click(function () {
        window.location = urlLogin;
    });
}







function RecibirPinVerficiacionCorreo(reenvio) {
    $(".seccion").hide();
    $("#VistaPrecarga").show();
    debugger;
    jQuery.ajax({
        type: 'POST',
        url: urlRecibirPinCambioContrasenia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: null,
        async: true,
        success: function (data) {
            $(".seccion").hide();
            $("#Paso2ActualizacionPassword").show();
            $("#txtCorreoAlCualSeEnvioCodigo").val(data.correo);

            if (reenvio) {
                $('.campo_ingreso_codigo').val('');
                $('#btnConfirmarCambioPassword').addClass('btn__sb--disabled');
                alert('Se reenvió el nuevo código');
            }
            
        },
        error: function (data, error) {
            if (reenvio) {
                $(".seccion").hide();
                alert("Error al reenviar el código");
                $("#Paso2ActualizacionPassword").show();
                return;
            }
            if (checkTimeout(data)) {
                $(".seccion").hide();
                alert("Error en el Cambio de Contraseña");
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
        alert('Error al validar la contraseña, vuelva a intentar')
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
                alert("Error en la verificacion de código");
                $("#Paso2ActualizacionPassword").show();
                return false;
            }
            //$(".seccion").hide();
            //$("#Paso3").show();
            CambiarContrasenia();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert("Error en la verificacion de código");
                $(".seccion").hide()
                $("#Paso2ActualizacionPassword").show();
            }
        }
    });

}

function CambiarContrasenia() {
    debugger;
    $(".seccion").hide();
    $("#VistaPrecarga").show();

    jQuery.ajax({
        type: 'POST',
        url: urlCambiaContrasenia,
        dataType: 'json',
        //contentType: 'application/json; charset=utf-8',
        data:$("#formContrasenia").serialize(),  
        async: true,
        cache: false,
        //headers: { RequestVerificationToken: token },
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (data.message == "0") {
                        $("#Contrasenia").val('');
                        $("#ConfirmaContrasenia").val('');
                        alert("La contraseña anterior ingresada es inválida");
                    } else if (data.message == "1") {
                        $("#Contrasenia").val('');
                        $("#ConfirmaContrasenia").val('');
                        alert("Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente.");
                    } else if (data.message == "2") {
                        $("#Contrasenia").val('');
                        $("#ConfirmaContrasenia").val('');

                        //$(".campos_cambiarContrasenia").fadeOut(200);
                        //$(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
                        //$(".campos_actualizarDatos").delay(200);
                        //$(".campos_actualizarDatos").fadeIn(200);
                        $(".seccion").hide();
                        $("#Paso3").show();
                        alert("Se cambió satisfactoriamente la contraseña.");
                    }
                    return false;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $(".seccion").hide()
                $("#Paso2ActualizacionPassword").show();
                alert("Error en el Cambio de Contraseña");
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
    debugger;
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
                alert(data.menssage);
            }                       

        },
        error: function (data, error) {           
            if (checkTimeout(data)) {
                $(".seccion").hide();
                alert("Error al validar contraseña");
                $("#Paso1ActualizacionPassword").show();
            }
        }
    });

}