var uploaderCupon = null;
var uploaderPremio = null;

$("#btnCancelar").click(function (e) {
    e.preventDefault();
    $("#divConfigBanner").html("");
    HideDialog("divConfigBanner");
});

uploaderCupon = new qq.FileUploader({
    allowedExtensions: ['jpg'],
    element: document.getElementById("file-uploader-cupon"),
    multiple: false,
    action: baseUrl + 'AdministrarEstrategia/ProgramaNuevasBannerActualizar',
    //params: {
    //    TipoBanner: tipoBanner,
    //    CodigoPrograma: $.trim($("#CodigoPrograma").val()),
    //    CodigoNivel: $.trim($("#CodigoNivel").val())
    //},
    onComplete: function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").remove();
            if (response.success) {
                $("#imgBannerCupon").attr("src", response.extra);
            } else {
                alert(response.message);
            };
        }
    },
    onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
    onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
    onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
});

uploaderPremio = new qq.FileUploader({
    allowedExtensions: ['jpg'],
    element: document.getElementById("file-uploader-premio"),
    multiple: false,
    action: baseUrl + 'AdministrarEstrategia/ProgramaNuevasBannerActualizar',
    //params: {
    //    TipoBanner: tipoBanner,
    //    CodigoPrograma: $.trim($("#CodigoPrograma").val()),
    //    CodigoNivel: $.trim($("#CodigoNivel").val())
    //},
    onComplete: function (id, fileName, response) {
        if (checkTimeout(response)) {
            $(".qq-upload-list").remove();
            if (response.success) {
                $("#imgBannerPremio").attr("src", response.extra);
            } else {
                alert(response.message);
            };
        }
    },
    onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
    onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
    onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
});

$(".qq-upload-button").click(function (e) {
    var CodigoPrograma = $.trim($("#CodigoPrograma").val());
    var CodigoNivel = $.trim($("#CodigoNivel").val());

    if (CodigoPrograma == "") {
        alert("Ingrese el valor del código de programa");
        $("#CodigoPrograma").focus();
        return false;
    }
    else if (CodigoNivel == "") {
        alert("Ingrese el valor del código de nivel");
        $("#CodigoNivel").focus();
        return false;
    }

    return true;
});

$("#CodigoPrograma").keyup(function () {
    var codigoPrograma = $(this).val();
    if (codigoPrograma.length != 3) return;

    fn_CargarImagen();
});

$("#CodigoNivel").change(function () {
    fn_CargarImagen();
});

function fn_CargarImagen() {
    var CodigoPrograma = $.trim($("#CodigoPrograma").val());
    var CodigoNivel = $.trim($("#CodigoNivel").val());

    if (CodigoPrograma == "" || CodigoNivel == "") return;

    uploaderCupon.setParams({
        TipoBanner: 1,
        CodigoPrograma: $.trim($("#CodigoPrograma").val()),
        CodigoNivel: $("#CodigoNivel").val()
    });
    uploaderPremio.setParams({
        TipoBanner: 2,
        CodigoPrograma: $.trim($("#CodigoPrograma").val()),
        CodigoNivel: $("#CodigoNivel").val()
    });

    $("#imgBannerCupon").attr("src", "");
    $("#imgBannerPremio").attr("src", "");

    waitingDialog({});

    jQuery.ajax({
        type: 'GET',
        cache: false,
        url: baseUrl + 'AdministrarEstrategia/ProgramaNuevasBannerObtener?CodigoPrograma=' + CodigoPrograma + "&CodigoNivel=" + CodigoNivel,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            closeWaitingDialog();

            if (response.success) {
                if (response.extra != null) {
                    $("#imgBannerCupon").attr("src", response.extra.ImgBannerCupon);
                    $("#imgBannerPremio").attr("src", response.extra.ImgBannerPremio);
                }
            } else {
                alert(response.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            alert(data.message);
        }
    });
}

$(".img-matriz-preview").click(function (e) {
    e.preventDefault();
    $("#imgVistaPrevia").attr("src", $(this).attr("src"));
    showDialog("divVistaPrevia");
})
$("#btnSalir").click(function (e) {
    HideDialog("divVistaPrevia");
});
$('#divVistaPrevia').dialog({
    autoOpen: false,
    resizable: false,
    modal: true,
    closeOnEscape: true,
    width: 250,
    draggable: false,
    title: "VISTA PREVIA"
});