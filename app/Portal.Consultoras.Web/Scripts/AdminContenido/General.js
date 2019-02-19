jQuery(document).ready(function() {

    $("#DialogMensajeAdm").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: false,
        title: "Mensaje",
        buttons:
        {
            "Aceptar": function() {
                HideDialog("DialogMensajeAdm");
            }
        }
    });
});

function showDialogMensaje(mensaje, titulo) {
    titulo = titulo || "Mensaje";
    $("#DialogMensajeAdm").dialog('option', 'title', titulo);
    $("#DialogMensajeAdm").find("#mensajeMostrar").html(mensaje);
    showDialog("DialogMensajeAdm");
    setTimeout(hideDialogo, 5000);
}
function hideDialogo() {
    HideDialog("DialogMensajeAdm");
}