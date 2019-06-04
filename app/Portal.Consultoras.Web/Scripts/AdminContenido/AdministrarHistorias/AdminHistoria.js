
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

var _obj_mensaje = {
    seleccionImagen: "No seleccionó una imagen",
    seleccionCampania: "Debe seleccionar una Campaña"
}

jQuery(document).ready(function () {
    admHistoriaDatos.ini();
    IniDialogDetalle();
    UploadFile();
    

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
        width: 550,
        draggable: false,
        title: "Nuevo",
        close: function () {
            HideDialog("DialogMantenimientoDetalle");
        },
        open: function (event, ui) { },
        buttons:
            {
            "Guardar": function () {
               var Proc = $("#Proc").val();    
                var CodigoDetalle = "";
                if ($("#nombre-desktop-detalle").val() == "") {
                    showDialogMensaje(_obj_mensaje.seleccionImagen, 'Alerta');
                    return false;
                }
                if ($("#ddlCampaniaDetalle").val() === "0") {
                    showDialogMensaje(_obj_mensaje.seleccionCampania, 'Alerta');
                    return false;
                }

                if ($("#ddlAccion").val() == "VER_MAS") {
                    CodigoDetalle = $("#ddlCodigoDetalle").val();
                }
                else if ($("#ddlAccion").val() == "AGR_CAR") {
                    CodigoDetalle = $("#txtCUV").val();
                }       
                   
                var params = {
                    Proc: Proc,
                    RutaContenido: $("#nombre-desktop-detalle").val(),
                    IdContenidoDeta: $("#IdContenidoDeta").val(),
                    IdContenido: $("#IdContenido").val(),
                    Campania: $("#ddlCampaniaDetalle").val(),
                    Accion: $("#ddlAccion").val(),
                    CodigoDetalle: CodigoDetalle,
                       
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
    ModificarDetalle(1, IdContenido);
}

function ModificarDetalle(Proc, IdContenido) {

    waitingDialog();
    $.ajax({
        url: baseUrl + "AdministrarHistorias/GetDetalle",
        type: "GET",
        dataType: "html",
        data: {
            Proc: Proc,
            IdContenido: IdContenido 
        },
        contentType: "application/json; charset=utf-8",
        success: function (result) {
           
            closeWaitingDialog();

            $("#dialog-content-detalle").empty();
            $("#dialog-content-detalle").html(result).ready(function () {
                UploadFileDetalle("desktop-detalle");
            });
            $('#DialogMantenimientoDetalle').dialog('option', 'title', "Nuevo");
            showDialog("DialogMantenimientoDetalle");
        },
        error: function (request, status, error) { closeWaitingDialog(); _toastHelper.error("Error al cargar la ventana."); }
    });
}

function UploadFileDetalle(tag) {
    var tipoFile = ["jpg", "png", "jpeg"];
    var tipoFileTag = $("#nombre-" + tag).attr("data-tipofile");
    if (tipoFileTag === "imggif") {
        tipoFile.push("gif");
    }

    var params = {};
    params["width"] = $("#nombre-" + tag).attr("imagewidth");
    params["height"] = $("#nombre-" + tag).attr("imageheight");
    params["messageSize"] = $("#nombre-" + tag).attr("messageSize");

    new qq.FileUploader({
        allowedExtensions: tipoFile,
        element: document.getElementById("img-" + tag),
        action: rutaFileUpload,
        params: params,
        messages: {
            typeError: $("#nombre-" + tag).attr("messageFormat")
        },
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
function UploadFile() {    
                      
    var params = {};
    params["width"] = $("#NombreImagen").attr("imagewidth");
    params["height"] = $("#NombreImagen").attr("imageheight");
    params["messageSize"] = $("#NombreImagen").attr("messageSize");
    
    new qq.FileUploader({                                      

        allowedExtensions: ['jpg', 'png', 'jpeg'],
        element: document.getElementById('file-uploader'),
        action: rutaFileUpload,
        params: params,
        messages: {
            typeError: $("#NombreImagen").attr("messageFormat")
        },
        onComplete: function (id, fileName, responseJSON) {
            if (checkTimeout(responseJSON)) {
                $(".qq-upload-list").css("display", "none");
                if (responseJSON.success) {
                    $('#NombreImagen').val(responseJSON.name);
                    $('#preview').attr('src', rutaTemporal + responseJSON.name);
                }
                else {
                    alert(responseJSON.message);
                }
            }
        },
        onSubmit: function (id, fileName) { $(".qq-upload-list").css("display", "none"); },
        onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").css("display", "none"); },
        onCancel: function (id, fileName) { $(".qq-upload-list").css("display", "none"); }
    });
                     

    return false;
}