jQuery(document).ready(function () {
   
    RegistrarConstrains();
    RegistrarEventos();
   
});
function RegistrarConstrains() {

    $("#CodigoPrograma").on('keypress', function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        var inputVal = $(this).val();
        var keyChar = String.fromCharCode(charCode);
        var re = /[0-9]/;
        return re.test(keyChar);
    });

    $("#CodigoPrograma").on('dragover drop', function (e) {
        e.preventDefault();
        return false;
    });

    $("#btnCancelar").click(function (e) {
        e.preventDefault();
        $("#divAgregar").html("");
        HideDialog("divAgregar");
    });
}
function GetData() {
    var checkbox = {};
    var input = {};
    $('input:checkbox').map(function () {
        checkbox[this.name] = this.checked ? this.value : "false";
    });
    var data = $('#frmPremio').serializeArray();
    $.each(data, function (key, value) {
        input[value.name] = value.value;
    });

    return $.extend({}, input, checkbox);

}
function RegistrarEventos() {

    $("#btnGuardar").click(function (e) {
        e.preventDefault();
        if ($("#AnoCampanaIni").val() == "") {

            alert("Debe seleccionar la Campaña, verifique.");
            return false;
        }
        if ($("#AnoCampanaFin").val() == "") {

            alert("Debe seleccionar la Campaña Fin, verifique.");
            return false;
        }
        if ($("#Nivel").val() == "") {

            alert("Debe seleccionar un Nivel, verifique.");
            return false;
        }
        if ($("#CodigoPrograma").val() == "") {

            alert("Debe ingresar un codigo de programa, verifique.");
            return false;
        }
        if ($("#AnoCampanaFin").val() < $("#AnoCampanaIni").val()) {

            alert("La campaña final no puede ser menor a la campaña inicial, verifique.");
            return false;
        }
        var data = GetData();

        waitingDialog({});
        jQuery.ajax({
            type: 'POST',
            url: UrlOperacionPremio,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            async: true,
            success: function (data) {
                closeWaitingDialog();

                if (data.success) {
                    alert(data.message);
                    $("#btnCancelar").click();
                    ReloadGrid();
                } else {
                    alert(data.message);
                }
            },
            error: function (data, error) {
                closeWaitingDialog();
            }
        });
    
    });




}