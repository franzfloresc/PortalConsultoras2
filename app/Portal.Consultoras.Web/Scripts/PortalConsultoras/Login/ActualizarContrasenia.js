
$(document).ready(function () {
    Inicualizar();

});

function Inicualizar() {
    $("#btnActualizarCorreo").click(function () { CambiarContrasenia(); });
}


function CambiarContrasenia() {
    var newPassword01 = $("#txtNuevoPassword").val();
    var newPassword02 = $("#txtConfirmarNuevoPassword").val();

    var item = {
        nuevaContrasenia: newPassword01,
        codigoUsuario: emt_id ,
        codigoISO: emt_country
    };

    waitingDialog();
    jQuery.ajax({
        type: 'POST',
        url: urlCambiaContrasenia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    if (data.message == "0") {                        
                        $("#txtNuevoPassword").val('');
                        $("#txtConfirmarNuevoPassword").val('');
                        alert("La contraseña anterior ingresada es inválida");
                    } else if (data.message == "1") {                        
                        $("#txtNuevoPassword").val('');
                        $("#txtConfirmarNuevoPassword").val('');
                        alert("Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente.");
                    } else if (data.message == "2") {                        
                        $("#txtNuevoPassword").val('');
                        $("#txtConfirmarNuevoPassword").val('');

                        //$(".campos_cambiarContrasenia").fadeOut(200);
                        //$(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
                        //$(".campos_actualizarDatos").delay(200);
                        //$(".campos_actualizarDatos").fadeIn(200);
                        alert("Se cambió satisfactoriamente la contraseña.");
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