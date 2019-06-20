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
                hideDialogMensaje();
            }
        }
    });
});

function showDialogMensaje(mensaje, titulo) {
    titulo = titulo || "Mensaje";
    $("#DialogMensajeAdm").dialog('option', 'title', titulo);
    $("#DialogMensajeAdm").find("#mensajeMostrar").html(mensaje);
    showDialog("DialogMensajeAdm");
    setTimeout(hideDialogMensaje, 5000);
}
function hideDialogMensaje() {
    HideDialog("DialogMensajeAdm");
}