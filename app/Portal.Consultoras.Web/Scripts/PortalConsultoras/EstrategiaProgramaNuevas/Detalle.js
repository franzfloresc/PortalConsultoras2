var mensajeErrorCUV = "";

$("#CUV").keyup(function () {
    var cuvIngresado = $(this).val();
    $("#imgSeleccionada").attr("src", rutaImagenVacia);
    $("#imgSeleccionada").attr("data-id", "0");

    if (cuvIngresado.length == 5) {
        waitingDialog({});

        var params = {
            CampaniaID: $("#CampaniaInicio").val(),
            CUV2: $("#CUV").val(),
            TipoEstrategiaID: $("#hdnTipoEstrategiaID").val(),
            CUV1: "0",
            flag: '0',
            FlagNueva: '0',
            FlagRecoProduc: '0',
            FlagRecoPerfil: '0'
        };

        mensajeErrorCUV = "";
        $("#DescripcionCUV").val("");
        $("#Precio").val("0");
        $("#Valorizado").val("0");
        $("#Ganancia").val("0");

        jQuery.ajax({
            type: 'POST',
            cache: false,
            url: baseUrl + 'AdministrarEstrategia/GetOfertaByCUV',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                closeWaitingDialog();

                if (data.message == "OK") {
                    $("#DescripcionCUV").val(data.descripcion);

                    if (data.wsprecio > 0) {
                        $("#Precio").val(parseFloat(data.wsprecio).toFixed(2));
                        $("#Valorizado").val(data.precio);
                        $("#Ganancia").val(data.ganancia);

                        $("#Mensaje").focus();
                    }
                    else if (data.wsprecio === 0.0) {
                        $("#Precio").val(parseFloat(data.precio).toFixed(2));
                        $("#Valorizado").focus();
                    }
                    else if (data.wsprecio == -1) {
                        alert("No se pudo  obtener el precio del producto. Por favor, comunicarse con Soporte Digital Consultoras");

                        $("#Precio").focus();
                    }
                    else if (data.wsprecio == -2) {
                        $("#Precio").val("");
                        $("#Precio").focus();
                    }

                    $("#CodigoSAP").val(data.codigoSAP)

                    fnObtenerImagenes($("#CodigoSAP").val(), 1)
                } else {
                    mensajeErrorCUV = data.message;
                    alert(mensajeErrorCUV);
                }
            },
            error: function (data, error) {
                closeWaitingDialog();
            }
        });
    }
});

var CurrentPage = 1;
function fnObtenerImagenes(codigoSAP, pagina) {
    waitingDialog({});
    var params = { paisID: $("#hdnPaisID").val(), codigoSAP: codigoSAP, pagina: pagina };
    $.post(baseUrl + 'MatrizComercial/GetImagesByCodigoSAP', params).done(function (data) {
        fnImagenes_Construir(data)
        fnImagenes_Paginador(data);
        fnImagenes_AsignarEventos();
        fnImagenes_FileUpload({
            idMatrizComercial: data.idMatrizComercial,
            codigoSAP: params.codigoSAP,
            paisID: params.paisID
        });
        closeWaitingDialog();
    });
}
function fnImagenes_Construir(data) {
    $(".EstrategiaTabDetail").html("");

    var htmlImagenes = '<div id="file-uploader"></div>';
    htmlImagenes += '<div class="div-3">';

    for (var row = 0; row < data.imagenes.length; row++) {
        htmlImagenes += '<div style="float:left">';
        htmlImagenes += '<div class="pdr_modal borde_redondeado"><img src="' + data.imagenes[row].Foto + '" class="img-matriz-preview"></div>';
        htmlImagenes += '<div><input type="checkbox" class="checkImage" data-image="' + data.imagenes[row].Foto + '"></div>'
        htmlImagenes += '</div>';
    }

    htmlImagenes += '</div>';

    $(".EstrategiaTabDetail").html(htmlImagenes);
}
function fnImagenes_AsignarEventos() {
    $('.checkImage').unbind("click");
    $(".checkImage").click(function (e) {
        var currentCheck = $(this);
        $(".checkImage").attr('checked', false);
        setTimeout(function () {
            currentCheck.attr('checked', true);
            $("#imgSeleccionada").attr("src", currentCheck.attr("data-image"));
        }, 100)
        e.preventDefault();
        return false;
    });

    $('.EstrategiaTabFooter .div-3 div').unbind("click");
    $(".EstrategiaTabFooter .div-3 div").click(function (e) {
        if ($(this).attr('class') == "active") return;
        CurrentPage = $(this).html();
        fnObtenerImagenes($("#CodigoSAP").val(), CurrentPage);
    });
}
function fnImagenes_Paginador(data) {
    $(".EstrategiaTabFooter").html("");

    var htmlPaginador = '<div class="div-3">';

    for (var pag = 1; pag <= data.totalPaginas; pag++) {
        if (pag == CurrentPage) htmlPaginador += "<div class='active'>" + pag + "</div>";
        else htmlPaginador += "<div>" + pag + "</div>";
    }

    htmlPaginador += '</div>';

    $(".EstrategiaTabFooter").html(htmlPaginador);
}
function fnImagenes_FileUpload(data) {

    var uploader = new qq.FileUploader({
        allowedExtensions: ['jpg', 'png', 'jpeg'],
        element: document.getElementById("file-uploader"),
        action: baseUrl + 'MatrizComercial/ActualizarMatrizComercial',
        params: {
            IdMatrizComercial: data.idMatrizComercial,
            IdMatrizComercialImagen: undefined,
            Foto: undefined,
            PaisID: data.paisID,
            CodigoSAP: data.codigoSAP,
            DescripcionOriginal: undefined,
            DescripcionComercial: undefined,
            NemotecnicoActivo: false
        },
        onComplete: function (id, fileName, response) {
            if (checkTimeout(response)) {
                $(".qq-upload-list").remove();
                if (response.success) {
                    fnObtenerImagenes($("#CodigoSAP").val(), CurrentPage);
                } else {
                    alert(response.message);
                };
            }
        },
        onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
        onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
        onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
    });

    $(".qq-upload-button span").html("Nueva Imagen");
}

$("#btnGuardar").click(function (e) {
    e.preventDefault();

    if ($.trim($("#CodigoPrograma").val()) == "") {
        alert("Ingrese el valor del código de programa");
        $("#CodigoPrograma").focus();
        return;
    }
    if ($("#CampaniaFin").val() == "") {
        alert("Seleccione la campaña de vigencia final.");
        $("#CampaniaFin").focus();
        return;
    }
    var campaniaIni = $("#CampaniaInicio").val();
    var campaniaFin = $("#CampaniaFin").val();
    if (parseInt(campaniaFin) < parseInt(campaniaIni)) {
        alert("La campaña de vigencia final  no puede ser menor a la campaña de inicio.");
        $("#CampaniaFin").focus();
        return;
    }
    var CUV = $.trim($("#CUV").val());
    if (CUV == "") {
        alert("Ingrese el valor del CUV");
        $("#CUV").focus();
        return;
    }
    if (mensajeErrorCUV.length > 0) {
        alert(mensajeErrorCUV);
        $("#CUV").focus();
        return;
    }
    var DescripcionCUV2 = $.trim($("#DescripcionCUV").val());
    if (DescripcionCUV2 == "") {
        alert("Ingrese el valor del CUV2 para obtener la descripción o ingrese una.");
        $("#DescripcionCUV").focus()
        return;
    }
    if ($("#Orden").val() <= 0) {
        alert("Ingrese un valor para el orden a mostrar mayor a cero.");
        $("#Orden").focus();
        return;
    }

    var rutaImagen = $("#imgSeleccionada").attr("src");
    var imagenCorrecta = true;
    var imagenSeleccionada = "";
    if (rutaImagen == null || rutaImagen == "" || rutaImagen == rutaImagenVacia) imagenCorrecta = false;
        if (!imagenCorrecta) {
            alert("Seleccione una imagen a mostrar.");
            return;
        }
    if (imagenCorrecta) imagenSeleccionada = rutaImagen.substr(rutaImagen.lastIndexOf("/") + 1);

    if ($.trim($("#Precio").val()) == "") $("#Precio").val("0");
    if ($.trim($("#Valorizado").val()) == "") $("#Valorizado").val("0");
    if ($.trim($("#Ganancia").val()) == "") $("#Ganancia").val("0");

    var Mensaje = $.trim($("#Mensaje").val());

    var params = {
        EstrategiaID: $("#EstrategiaID").val(),
        TipoEstrategiaID: $("#hdnTipoEstrategiaID").val(),
        CampaniaID: $("#CampaniaInicio").val(),
        CampaniaIDFin: $("#CampaniaFin").val(),
        NumeroPedido: "0",
        Activo: $("#Activo").attr("checked") ? "1" : "0",
        ImagenURL: imagenSeleccionada,
        LimiteVenta: "0",
        DescripcionCUV2: DescripcionCUV2,
        FlagDescripcion: (DescripcionCUV2 != "") ? "1" : "0",
        CUV: "",
        EtiquetaID: "0",
        Precio: $.trim($("#Valorizado").val()),
        FlagCEP: "0",
        CUV2: CUV,
        EtiquetaID2: "0",
        Precio2: $.trim($("#Precio").val()),
        FlagCEP2: (CUV != "") ? "1" : "0",
        TextoLibre: Mensaje,
        FlagTextoLibre: (Mensaje != "") ? "1" : "0",
        Cantidad: "0",
        FlagCantidad: "0",
        Zona: "",
        Orden: $.trim($("#Orden").val()),
        ColorFondo: "",
        FlagEstrella: "0",
        CodigoTipoEstrategia: "021",
        ImgFondoDesktop: "",
        ImgPrevDesktop: "",
        ImgFichaDesktop: "",
        UrlVideoDesktop: "",
        ImgFondoMobile: "",
        ImgFichaMobile: "",
        UrlVideoMobile: "",
        ImgFichaFondoDesktop: "",
        ImgFichaFondoMobile: "",
        ImgHomeDesktop: "",
        ImgHomeMobile: "",
        PrecioAnt: "",
        EsOfertaIndependiente: "0",
        Ganancia: $.trim($("#Ganancia").val()),
        CodigoPrograma: $.trim($("#CodigoPrograma").val()),
        RutaImagenCompleta: rutaImagen
    };

    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'AdministrarEstrategia/RegistrarEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (data) {
            closeWaitingDialog();

            if (data.success) {
                alert(data.message);
                $("#btnCancelar").click();
                fnGrilla();
            } else {
                alert(data.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
});
$("#btnCancelar").click(function (e) {
    e.preventDefault();
    $("#divAgregar").html("");
    HideDialog("divAgregar");
});

$("#imgSeleccionada").click(function (e) {
    e.preventDefault();
    $("#imgZonaEstrategia").attr("src", $(this).attr("src"));
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

if ($("#EstrategiaID").val() != "0") fnObtenerImagenes($("#CodigoSAP").val(), 1);