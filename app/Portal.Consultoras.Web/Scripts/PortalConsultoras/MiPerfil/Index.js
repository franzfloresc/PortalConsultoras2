var MiPerfil;

$(document).ready(function () {

    var vistaMiPerfil;

    vistaMiPerfil = function () {
        var me = this;

        //me.Globals = {

        //},
        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('blur', '.grupo_form_cambio_datos input', me.Eventos.LabelActivo);
                $('body').on('click', '.enlace_agregar_num_adicional', me.Eventos.AgregarOtroNumero);
                $('body').on('click', '.enlace_eliminar_numero_adicional', me.Eventos.EliminarNumeroAdicional);
                $('body').on('click', '.enlace_ver_password', me.Eventos.MostrarPassword);
            },
            CamposFormularioConDatos: function () {
                var camposFormulario = $('.grupo_form_cambio_datos input');
                $.map(camposFormulario, function (campoFormulario, key) {
                    if ($(campoFormulario).val() != '') {
                        $(campoFormulario).addClass('campo_con_datos');
                    }
                });
            },
            mostrarTelefono: function () {
                if ($('#txtTelefonoTrabajoMD').val() != '') {
                    $('.enlace_agregar_num_adicional').fadeOut(150);
                    $('.label_num_adicional').fadeIn(100);
                    $('.contenedor_campos_num_adicional').fadeIn(150);
                }
            },
            PuedeActualizar: function () {
                if ($('#hdn_PuedeActualizar').val() == '0') {
                    $('#txtSobrenombreMD').prop('disabled', true);
                    $('#txtEMailMD').prop('disabled', true);
                    $('#txtCelularMD').prop('disabled', true);
                    $('#txtTelefonoMD').prop('disabled', true);
                    $('#txtTelefonoTrabajoMD').prop('disabled', true);
                    $('#btnCambiarCelular').bind('click', false);
                    $('#btnCambiarEmail').bind('click', false);
                    $('#btnAgregarOtroNumero').bind('click', false);
                    $('#btnGuardar').prop('disabled', true);
                }
            },
            PuedeCambiarTelefono: function () {
                if ($('#hdn_ServicioSMS').val() == '0') {
                    $('#btnCambiarCelular').bind('click', false);
                } else {
                    $('#CelularConsultora').prop('readonly', true);
                }
            }
        },
        me.Eventos = {
            LabelActivo: function () {
                var campoDatos = $(this).val();
                if(campoDatos != ''){
                    $(this).addClass('campo_con_datos');
                } else {
                    $(this).removeClass('campo_con_datos');
                }
            },
            AgregarOtroNumero: function (e) {
                e.preventDefault();
                $(this).fadeOut(150);
                $('.label_num_adicional').fadeIn(100);
                $('.contenedor_campos_num_adicional').fadeIn(150);
            },
            EliminarNumeroAdicional: function (e) {
                e.preventDefault();
                $('.contenedor_campos_num_adicional').fadeOut(150);
                $('.label_num_adicional').fadeOut(100);
                $('.enlace_agregar_num_adicional').fadeIn(150);
                $('.contenedor_campos_num_adicional input').val('');
            },
            MostrarPassword: function (e) {
                e.preventDefault();
                var _this = e.target;
                var campoPassword = $(_this).parent().find('input');
                if (campoPassword.val() != '') {
                    if ($(_this).is('.icono_ver_password_activo')) {
                        $(_this).removeClass('icono_ver_password_activo');
                        campoPassword.attr('type', 'password');
                    } else {
                        $(_this).addClass('icono_ver_password_activo');
                        campoPassword.attr('type', 'text');
                    }
                }
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
            me.Funciones.CamposFormularioConDatos();
            me.Funciones.mostrarTelefono();
            me.Funciones.PuedeActualizar();
            me.Funciones.PuedeCambiarTelefono();
        }
    }

    MiPerfil = new vistaMiPerfil();
    MiPerfil.Inicializar();

    $("#btnCambiarPass").click(function () { CambiarContrasenia(); });

    $("#btnGuardar").click(function () { actualizarDatos(); });

    $("#txtTelefonoMD").keypress(function (evt) {
        //var charCode = (evt.which) ? evt.which : window.event.keyCode;
        var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
        if (!charCode) return false;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });

    $("#txtTelefonoTrabajoMD").keypress(function (evt) {
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

    $("#txtCelularMD").keypress(function (evt) {
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

    $("#txtEMailMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /^[a-zA-Z@._0-9\-]*$/;
            return re.test(keyChar);
        }
    });

    $("#txtSobrenombreMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ _.-]/;
            return re.test(keyChar);
        }
    });
});

function actualizarDatos() {
    if (jQuery.trim($('#txtEMailMD').val()) == "") {
        $('#txtEMailMD').focus();
        alert("Debe ingresar EMail.\n");
        return false;
    }

    if (!validateEmail(jQuery.trim($('#txtEMailMD').val()))) {
        $('#txtEMailMD').focus();
        alert("El formato del correo electrónico ingresado no es correcto.\n");
        return false;
    }

    if (($('#txtTelefonoMD').val() == null || $.trim($('#txtTelefonoMD').val()) == "") &&
        ($('#txtCelularMD').val() == null || $.trim($('#txtCelularMD').val()) == "")) {
        $('#txtTelefonoMD').focus();
        alert('Debe ingresar al menos un número de contacto: celular o teléfono.');
        return false;
    }

    if (jQuery.trim($('#txtCelularMD').val()) != "") {
        if (!ValidarTelefono($("#txtCelularMD").val())) {
            alert('El celular que está ingresando ya se encuenta registrado.');
            return false;
        }
    }

    var MinCaracterCelular = limitarMinimo($('#txtCelularMD').val(), $("#hdn_CaracterMinimo").val(), 2);
    if (!MinCaracterCelular) {
        $('#txtCelularMD').focus();
        alert('El formato del celular no es correcto.');
        return false;
    }

    if ($("#txtTelefonoTrabajoMD").val().trim() != "") {
        var MinCaracterOtroTelefono = limitarMinimo($('#txtTelefonoTrabajoMD').val(), $("#hdn_CaracterMinimo").val(), 3);
        if (!MinCaracterOtroTelefono) {
            return false;
        }
    }

    if (!$('#chkAceptoContratoMD').is(':checked')) {
        alert('Debe aceptar los términos y condiciones para poder actualizar sus datos.');
        return false;
    }

    waitingDialog({});

    var item = {
        CodigoUsuario: jQuery('#hdn_CodigoUsuarioReal').val(),
        EMail: $.trim(jQuery('#txtEMailMD').val()),
        Telefono: jQuery('#txtTelefonoMD').val(),
        TelefonoTrabajo: jQuery('#txtTelefonoTrabajoMD').val(),
        Celular: jQuery('#txtCelularMD').val(),
        Sobrenombre: jQuery('#txtSobrenombreMD').val(),
        CorreoAnterior: $.trim(jQuery('#hdn_CorreoMD').val()),
        NombreCompleto: jQuery('#hdn_NombreCompletoMD').val(),
        CompartirDatos: false,
        AceptoContrato: $('#chkAceptoContratoMD').is(':checked')
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisDatos/ActualizarDatos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert(data.message);
                window.location = $('#volverBienbenida').attr('href');
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("ERROR");
            }
        }
    });
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
        }
    });

    return resultado;
}

function limitarMinimo(contenido, caracteres, a) {
    if (contenido.length < caracteres && contenido.trim() != "") {
        var texto = a == 1 ? "teléfono" : a == 2 ? "celular" : "otro teléfono";
        alert('El número de ' + texto + ' debe tener como mínimo ' + caracteres + ' números.');
        return false;
    }
    return true;
}

function limitarMaximo(e, contenido, caracteres, id) {
    var unicode = e.keyCode ? e.keyCode : e.charCode;
    if (unicode == 8 || unicode == 46 || unicode == 13 || unicode == 9 || unicode == 37 ||
        unicode == 39 || unicode == 38 || unicode == 40 || unicode == 17 || unicode == 67 || unicode == 86)
        return true;

    if (contenido.length >= caracteres) {
        var selectedText = document.getSelection();
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

function CambiarContrasenia() {
    var oldPassword = $("#txtContraseniaAnterior").val();
    var newPassword01 = $("#txtNuevaContrasenia01").val();
    var newPassword02 = $("#txtNuevaContrasenia02").val();
    var vMessage = "";

    if (oldPassword == "")
        vMessage += "- Debe ingresar la Contraseña Anterior.\n";

    if (newPassword01 == "")
        vMessage += "- Debe ingresar la Nueva Contraseña.\n";

    if (newPassword02 == "")
        vMessage += "- Debe repetir la Nueva Contraseña.\n";

    if (newPassword01.length <= 3)
        vMessage += "- La Nueva Contraseña debe de tener mas de 6 caracteres.\n";

    if (newPassword01 != "" && newPassword02 != "") {
        if (newPassword01 != newPassword02)
            vMessage += "- Los campos de la nueva contraseña deben ser iguales, verifique.\n";
    }

    if (vMessage != "") {
        alert(vMessage);
        return false;
    } else {

        var item = {
            OldPassword: oldPassword,
            NewPassword: newPassword01
        };

        waitingDialog({});
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'MisDatos/CambiarContrasenia',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        if (data.message == "0") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("La contraseña anterior ingresada es inválida");
                        } else if (data.message == "1") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente.");
                        } else if (data.message == "2") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');

                            $("#contentPass").fadeOut(200);
                            $("#contentPassChange").delay(200);
                            $("#contentPassChange").fadeIn(200);
                        }
                        return false;
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("Error en el Cambio de Contraseña");
                }
            }
        });
    }
}