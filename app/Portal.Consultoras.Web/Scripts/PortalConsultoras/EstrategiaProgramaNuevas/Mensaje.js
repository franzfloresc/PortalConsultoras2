$("#btnCancelar").click(function (e) {
    e.preventDefault();
    $("#divConfigMensaje").html("");
    HideDialog("divConfigMensaje");
});

$("#CodigoPrograma").keyup(function () {
    var codigoPrograma = $(this).val();
    if (codigoPrograma.length != 3) return;

    waitingDialog({});

    $("#ConfiguracionProgramaNuevasAppID").val("");
    $("#TextoCupon").val("");
    $("#TextoCuponIndependiente").val("");

    jQuery.ajax({
        type: 'GET',
        cache: false,
        url: baseUrl + 'AdministrarEstrategia/ProgramaNuevasMensajeConsultar?CodigoPrograma=' + codigoPrograma,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            closeWaitingDialog();

            if (response.success) {
                if (response.data != null) {
                    $("#ConfiguracionProgramaNuevasAppID").val(response.data.ConfiguracionProgramaNuevasAppID);
                    $("#TextoCupon").val(response.data.TextoCupon);
                    $("#TextoCuponIndependiente").val(response.data.TextoCuponIndependiente);
                }
            } else {
                alert(response.message);
            }

            $("#TextoCupon").focus();
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
});

$("#btnGuardar").click(function (e) {
    e.preventDefault();

    var ConfiguracionProgramaNuevasAppID = $("#ConfiguracionProgramaNuevasAppID").val();
    var CodigoPrograma = $.trim($("#CodigoPrograma").val());
    var TextoCupon = $.trim($("#TextoCupon").val());
    var TextoCuponIndependiente = $.trim($("#TextoCuponIndependiente").val());

    if (CodigoPrograma == "") {
        alert("Ingrese el valor del código de programa");
        $("#CodigoPrograma").focus();
        return;
    }
    if (TextoCupon == "" && TextoCuponIndependiente == "") {
        alert("Debe ingresar por lo menos un texto.");
        $("#TextoCupon").focus();
        return;
    }

    var params = {
        ConfiguracionProgramaNuevasAppID: ConfiguracionProgramaNuevasAppID,
        CodigoPrograma: CodigoPrograma,
        TextoCupon: TextoCupon,
        TextoCuponIndependiente: TextoCuponIndependiente
    };

    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'AdministrarEstrategia/ProgramaNuevasMensajeInsertar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (data) {
            closeWaitingDialog();

            if (data.success) {
                alert(data.message);
                $("#btnCancelar").click();
            } else {
                alert(data.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
});