jQuery(document).ready(function () {
    IniDialog();

    $("#btnNuevo").click(function () {
        //validacion de los campos 
        $.ajax({
            url: 'AdministrarPalanca/Get',
            type: 'POST',
            dataType: 'json',
            data: { idConfiguracionPais: '1'}, //cambiar por el id correcto
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                $("#dialog-content-palanca").empty();
                $("#dialog-content-palanca").html(result);
                showDialog("DialogMantenimientoPalanca");
            },
            error: function (request, status, error) {
                //Do something
            }
        });
        showDialog("DialogMantenimientoPalanca");
    });

  
    $("#ddlTipoEstrategia").change(function () {
      
    });
});


function IniDialogs() {
    $('#DialogMantenimientoPalanca').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 530,
        close: function () {},
        draggable: false,
        title: "Modificar Palanca",
        open: function (event, ui) { $(".ui-dialog-titlebar-close", ui.dialog).hide(); },
        buttons:
        {
            "Guardar": function () {
                //valores para el carrusel de la estrategia de lanzamiento
                var configuracionPaisID = $("#").val();
                var codigo = $("#").val();
                var excluyente = $("#").val();
                var descripcion = $("#").val();
                var estado = $("#").val();
                var tienePerfil = $("#").val();
                var desdeCampania = $("#").val();
                var tipoEstrategia = $("#").val();
                var mostrarCampaniaSiguiente = $("#").val();
                var mostrarPagInformativa = $("#").val();
                var hImagenFondo = $("#").val();
                var hTipoPresentacion = $("#").val();
                var hMaxProductos = $("#").val();
                var hTipoEstrategia = $("#").val();

                var params = {
                    ConfiguracionPaisID: configuracionPaisID,
                    Codigo: codigo,
                    Excluyente: excluyente,
                    Descripcion: descripcion,
                    Estado: estado,
                    TienePerfil: tienePerfil,
                    DesdeCampania: desdeCampania,
                    TipoEstrategia: tipoEstrategia,
                    MostrarCampaniaSiguiente: mostrarCampaniaSiguiente,
                    MostrarPagInformativa: mostrarPagInformativa,
                    HImagenFondo: hImagenFondo,
                    HTipoPresentacion: hTipoPresentacion,
                    HMaxProductos: hMaxProductos,
                    HTipoEstrategia: hTipoEstrategia
                };
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'AdministrarPalanca/Update',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        if (data.success) {
                            HideDialog("DialogMantenimientoPalanca");
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function (data, error) {
                        alert(data.message);
                    }
                });

            },
            "Salir": function () {
                $("#ddlTipoEstrategia").val($("#hdEstrategiaIDConsulta").val());
                $(this).dialog('close');
            }
        }
    });
}