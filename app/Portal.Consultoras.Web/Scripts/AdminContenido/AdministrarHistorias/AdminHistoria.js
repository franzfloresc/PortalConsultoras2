
var _toastHelper = ToastHelper();
var _listPalanca = ["LAN", "RDR", "RD", "OPT"];
var _palanca = {
    showroom: "SR",
    odd: "ODD",
    pn: "PN",
    dp: "DP"
}

var _tipopresentacion = {
    showroom: "5",
    odd: "6",
    banner: "4",
    bannerInterativo: "10"
}

jQuery(document).ready(function () {
    admHistoriaDatos.ini();
    IniDialogDetalle();

    $.jgrid.extend({
        EditarOfertas: ModificarDetalle,
    });

});

function IniDialogDetalle() {

    $("#DialogMantenimientoDetalle").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 830,
        draggable: false,
        title: "Nuevo",
        close: function () {
            HideDialog("DialogMantenimientoDetalle");
        },
        open: function (event, ui) {
            DialogOfertasHomeOpen(event, ui);
        },
        buttons:
            {
            "Guardar": function () {
                
                    var params = {
                        RutaContenido: $("#nombre-desktop-detalle").val(),
                        IdContenido: $("#IdContenido").val()                      
                };
          
                    waitingDialog({});

                    jQuery.ajax({
                        type: "POST",
                        url: baseUrl + "AdministrarHistorias/Detalle",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(params),
                        async: true,
                        success: function (data) {
                            console.log("save=>",data);
                            closeWaitingDialog();
                            if (data.success) {
                                HideDialog("DialogMantenimientoDetalle");
                                //_toastHelper.success("Solicitud realizada sin problemas.");
                                showDialogMensaje(data.message, '');
                                $('#tblHistoriaDet').trigger('reloadGrid');
                            } else {
                                showDialogMensaje(data.message, '');
                                //_toastHelper.error("Error al procesar la Solicitud.");
                            }
                        },
                        error: function (data, error) {
                            closeWaitingDialog();
                            console.log(data);
                            _toastHelper.error("Error al procesar la Solicitud.");
                        }
                    });

                },
                "Salir": function () {
                    HideDialog("DialogMantenimientoDetalle");
                }
            }
    });
}

function NuevoDetalle(IdContenido) {
    ModificarDetalle(0, IdContenido);
}

function ModificarDetalle(id, IdContenido) {
    waitingDialog();

    $.ajax({
        url: baseUrl + "AdministrarHistorias/GetDetalle",
        type: "GET",
        dataType: "html",
        data: {
            id: id,
            IdContenido: IdContenido 
        },
        contentType: "application/json; charset=utf-8",
        success: function (result) {
           
            closeWaitingDialog();

            $("#dialog-content-detalle").empty();
            $("#dialog-content-detalle").html(result).ready(function () {
                UploadFileDetalle("desktop-detalle");
            });

            showDialog("DialogMantenimientoDetalle");
        },
        error: function (request, status, error) { closeWaitingDialog(); _toastHelper.error("Error al cargar la ventana."); }
    });
}

function UploadFileDetalle(tag) {
    //console.log(tag);
    //alert(rutaFileUpload);
    //return;
    var tipoFile = ["jpg", "png", "jpeg"];
    var tipoFileTag = $("#nombre-" + tag).attr("data-tipofile");
    if (tipoFileTag === "imggif") {
        tipoFile.push("gif");
    }

    new qq.FileUploader({
        allowedExtensions: tipoFile,
        element: document.getElementById("img-" + tag),
        action: rutaFileUpload,
        onComplete: function (id, fileName, responseJSON) {
            if (checkTimeout(responseJSON)) {
                if (responseJSON.success) {
                    $("#nombre-" + tag).val(responseJSON.name);

                    $("#src-" + tag).attr("src", rutaTemporal + responseJSON.name);
                } else alert(responseJSON.message);
            }
            return false;
        },
        onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
        onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
        onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
    });
    if ($("#nombre-" + tag).val() !== "") {
        $("#src-" + tag).attr("src", urlS3 + $("#nombre-" + tag).val());
    }

    return false;
}
