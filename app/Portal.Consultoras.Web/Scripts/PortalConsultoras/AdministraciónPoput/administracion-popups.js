/*
 1 -->  Nuevo
 2 -->  MOdificar
 */

jQuery(document).ready(function () {

    var valorAccion = $("hdValueAction").val();
    if (valorAccion == 2) {
        CargarCamposEdicion();
    }

});


function CargarCamposEdicion() {

    var comunicadoId = $("hdComunicadoId").val();
    $.ajax({
        async: false,
        type: 'post',
        url: 'GestionPopup/GetCargaEdicionPoput',
        data: { comunicadoId: comunicadoId },
        success: function (data) {
            if (!data) {
                alert(data);
                return;
            }
            todoMenus = data.menu;
        },
        error: function (request, status, error) {
            alert(jQuery.parseJSON(request.responseText).Message);
        }
    });

}