/*Creado por : Paquirri Seperak
 Fecha Creación : 14_02_2019
 */
/***********************************************DECLARACIÓN DE VARIABLES GLOBALES****************************************************************************************/
var VistaAdministracionPopups
    , VistaAdministracionPopups
    , URL_ADJUNTAR_ARCHIVO = baseUrl + 'AdministracionPopups/GetCargarArchivoCSV'
    , URL_GUARDAR_POPUT = baseUrl + 'AdministracionPopups/GetGuardarPopup'
    , URL_DETALLE_POPUT = baseUrl + 'AdministracionPopups/GetDetallePopup'
    , URL_ACTUALIZA_ORDEN = baseUrl + 'AdministracionPopups/ActualizaOrden'
    , URL_ELIMINA_ARCHIVOCSV = baseUrl + 'AdministracionPopups/EliminarArchivoCsv'
    , URL_AGREGAR_IMAGEN = baseUrl + 'AdministracionPopups/AgregarImagenUpload'
    , URL_BUSCAR_POPUTS = baseUrl + 'AdministracionPopups/GetCargaListadoPopup'
    , TIPO_ACCION_NUEVO = 1
    , TIPO_ACCION_MODIFICAR = 2;

var OBJETO_MENJASE = new ObjetoMensajes();

function ObjetoMensajes() {
    this.seleccionCampaña = "Tiene que seleccionar una campaña";
    this.ingresarFecha = "Por favor ingrese una fecha válida";
    this.igualdadFecha = "Ambas fechas no pueden ser las mismas";
    this.fechaValida = "Por favor ingrese una fecha válida";
    this.fechaMinima = "Por favor ingrese la fecha mínima";
    this.fechaMaxima = "Por favor ingrese la fecha máxima";
    this.sinCambios = "No existe ningún cambio realizado";
    this.seleccionImagen = "No seleccionó una imagen";
    this.ingresoTituloPrincipal = "No ingresó el Título principal.";
    this.ingresoDescripcion = "No ingresó la descripcón.";
    this.maximocaracteres = "Sobrepasó la cantidad aceptada de caracteres";
    this.ingresoURL = "No ingresó una URL";
    this.ingresoTipoDispositivo = "No seelccionó un tipo de dispositivo";
    this.guardarDatos = "Deseas guardar los datos ingresados";
    this.cargando = "Cargando";
    this.espera = "Espere por favor";
    this.registroSatisfactorio = "Se registró de forma satisfactoria";
    this.errorRegistro = "Ocurrió un error al guardar los datos";
    this.tamañoSuperadoImagen = "El tamaño supera el limite permitido";
    this.formatoInvalidoImagen = "Ingrese una imagen con formato .png.";
    this.dimensionesImagen = "Las medidas deben ser: 326 x 418";
    this.validaArchivoCsv = "Formato de archivo csv";
    this.validarFechaPasada = "Ingrese una fecha mayor o igual a la de hoy";
}

/******************************************************MÉTODOS Y OPERACIONES*********************************************************************************/
$(document).ready(function () {
    var vistaAdPop;
    vistaAdPop = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('click', '.btn__agregar', me.Eventos.AbrirPopupNuevo);
                $('body').on('click', '.enlace__editar', me.Eventos.AbrirPopupModificar);
                $('body').on('click', '.btn__modal--descartar', me.Eventos.CerrarPopup);
            },
            CargarDatePicker: function () {
                var dateFormat = "mm/dd/yy",
                    from = $("#fechaMin")
                        .datepicker({
                            // defaultDate: "+1w",
                            changeMonth: true,
                            numberOfMonths: 1
                        })
                        .on("change", function () {
                            var fecha = to.val();
                            to.datepicker("option", "minDate", getDate(this));
                            to.val(fecha);
                        }),
                    to = $("#fechaMax").datepicker({
                        //  defaultDate: "+1w",
                        changeMonth: true,
                        numberOfMonths: 1
                    })
                        .on("change", function () {
                            from.datepicker("option", "maxDate", getDate(this));
                        });
                function getDate(element) {
                    var date;
                    try {
                        date = $.datepicker.parseDate(dateFormat, element.value);
                    } catch (error) {
                        date = null;
                    }
                    return date;
                }
            },
            OrdenamientoPersonalizadoFilasGrilla: function () {
                $("#swappable").swappable({
                    placeholder: 'ui-state-highlight',
                    items: '.ui-state-default',
                    cursorAt: { top: -5 }
                });
                $("#swappable").disableSelection();
            }
        },
            me.Eventos = {
                AbrirPopupNuevo: function (e) {
                    e.preventDefault();
                    if ($("#ddlCampania").val().length > 0) {
                        document.getElementById("imgPreview").style.display = "none";
                        LimpiarCamposPoput();
                        $("#description").html("Formato de archivo JPG.<br /> (326 x 418 píxeles)");
                        $("#nameArchivo").html(OBJETO_MENJASE.validaArchivoCsv);
                        $("#hdAccion").val(TIPO_ACCION_NUEVO);
                        $('#modalTitulo').html($(this).attr('title'));
                        $('#AgregarPopup').fadeIn(100);
                        $('#AgregarPopup').scrollTop(0);
                        $('#AgregarPopup').css('display', 'flex');
                        $('body').css('overflow-y', 'hidden');
                    } else alert(OBJETO_MENJASE.seleccionCampaña);
                },
                AbrirPopupModificar: function (e) {
                    e.preventDefault();
                    $("#hdAccion").val(TIPO_ACCION_MODIFICAR)
                    LimpiarCamposPoput();
                    var comunicadoid = e.target.getAttribute("comunicadoid")
                    $("#hdComunicadoId").val(comunicadoid)
                    GetCargaDetallePoput(comunicadoid);
                    $('#modalTitulo').html($(this).attr('title'));
                    $('#AgregarPopup').fadeIn(100);
                    $('#AgregarPopup').scrollTop(0);
                    $('#AgregarPopup').css('display', 'flex');
                    $('body').css('overflow-y', 'hidden');
                },
                CerrarPopup: function (e) {
                    e.preventDefault();
                    $('#AgregarPopup').fadeOut(100);
                    $('body').css('overflow-y', '');
                }
            },
            me.Inicializar = function () {
                me.Funciones.InicializarEventos();
                me.Funciones.CargarDatePicker();
            }
    }

    VistaAdministracionPopups = new vistaAdPop();
    VistaAdministracionPopups.Inicializar();

    $('#fechaMin').change(function (e) {
        var partes = (e.target.value || '').split('/');
        if (partes.length != 3) {
            alert(OBJETO_MENJASE.ingresarFecha);
            e.target.value = "";
        }
    });

    $('#fechaMax,#fechaMin').change(function (e) {
        var idFecha = e.target.id;
        var valorFecha = e.target.value;
        var dateFormat = "mm/dd/yy";

        switch (idFecha) {
            case "fechaMin":
                var fechaMaxima = $("#fechaMax").val();
                if (fechaMaxima == valorFecha) {
                    alert(OBJETO_MENJASE.igualdadFecha);
                    $("#fechaMin").val("");
                    return false;
                }
                var hoy = new Date();
                var hoy = new Date((hoy.getMonth() + 1).toString() + "/" + hoy.getDate() + "/" + hoy.getFullYear().toString());
                var date = new Date(valorFecha);
                if (date < hoy) {
                    alert(OBJETO_MENJASE.validarFechaPasada);
                    $("#fechaMin").val("");
                    return false;
                }

                break;
            case "fechaMax":
                var fechaMinima = $("#fechaMin").val();
                if (fechaMinima == valorFecha) {
                    alert(OBJETO_MENJASE.igualdadFecha);
                    $("#fechaMax").val("");
                    return false;
                }


                break;
        }

        let partes = (e.target.value || '').split('/');
        if (partes.length != 3) {
            alert(OBJETO_MENJASE.ingresarFecha);
            e.target.value = "";
            return false;
        }
        if ($.trim($("#fechaMin").val()) == "") {
            alert(OBJETO_MENJASE.fechaMaxima);
            e.target.value = "";
            return false;
        }

    });

});

function GetCargaDetallePoput(comunicadoid) {

    var object = {
        Comunicadoid: comunicadoid,
    };

    $.ajax({
        type: "POST",
        url: URL_DETALLE_POPUT,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(object),
        dataType: "json",
        cache: false,
        success: function (data) {
            if (checkTimeout(data)) {
                getCargarDetallePoputLocalStorage(data);
                GetCamposCargadosPoput(data);
            }
        },
        error: function (x, xh, xhr) {
            if (checkTimeout(x)) {
                closeWaitingDialog();
            }
        }
    });
}

function getCargarDetallePoputLocalStorage(data) {
    localStorage.setItem('datosPoput', JSON.stringify(data));
}

function getCargarArchivoCSVPoputLocalStorage(data) {
    localStorage.removeItem("datosCSV");
    if (data["listArchivo"] != undefined) {
        localStorage.setItem('datosCSV', JSON.stringify(data["listArchivo"]));
    }
}

function GetCamposCargadosPoput(data) {

    if (data.NombreImagen.length > 0) {
        document.getElementById("imgPreview").style.display = "block";
        $("#targetImg").attr('src', (data.UrlImagen));
        $("#description").html(data.NombreImagen);
        $("#imgPreview").show();
    } else $("#description").html("Formato de archivo JPG.<br /> (326 x 418 píxeles)");

    $("#txtTituloPrincipal").val(data.Descripcion);
    $("#txtDescripcion").val(data.Comentario);
    $("#txtUrl").val(data.DescripcionAccion);
    $("#nameArchivo").html(data.NombreArchivoCCV);
    $("#fechaMin").val(data.FechaInicio_);
    $("#fechaMax").val(data.FechaFin_);

    if (data.TipoDispositivo == 1) {/*Desktop*/
        document.getElementById('checkMobile').checked = false;
        document.getElementById('checkDesktop').checked = true;
    }
    if (data.TipoDispositivo == 2) {/*Mobile*/
        document.getElementById('checkMobile').checked = true;
        document.getElementById('checkDesktop').checked = false;
    }
    if (data.TipoDispositivo == 0) {/*Todos*/
        document.getElementById('checkMobile').checked = true;
        document.getElementById('checkDesktop').checked = true;
    }

    if (data.NombreArchivoCCV.length > 0)
        document.getElementById("EliminarArchivo").style.display = "block";
    else
        $("#nameArchivo").html(OBJETO_MENJASE.validaArchivoCsv);


}

$("#imgPoputs").change(function () {
    ValidaImagen(this.files);
});

var ReadImage = function (file) {

    var reader = new FileReader;
    var image = new Image;

    reader.readAsDataURL(file);
    reader.onload = function (_file) {

        image.src = _file.target.result;
        image.onload = function () {
            var height = this.height;
            var width = this.width;
            var type = file.type;
            var size = ~~(file.size / 1024) + "KB";

            $("#targetImg").attr('src', _file.target.result);
            $("#description").html(file.name);
            $("#imgPreview").show();
            $("#hdvalorImagenActual").val(file.name);
        }
    }
}

$("#btnDescartar").click(function () {
    LimpiarCamposPoput();
});

function LimpiarCamposPoput() {
    $("#description").html("");
    $("#imgPoputs").val("");
    $("#imgPreview").val("");
    $("#targetImg").attr("src", "");


    $("#txtTituloPrincipal").val("");
    $("#txtDescripcion").val("");
    $("#txtUrl").val("");
    $("#txtUrl").val("");
    $("#nameArchivo").html("");
    $("#fechaMin").val("");
    $("#fechaMax").val("");
    document.getElementById('checkMobile').checked = false;
    document.getElementById('checkDesktop').checked = false;
    document.getElementById("EliminarArchivo").style.display = "none";
    document.getElementById("imgPreview").style.display = "none";
    localStorage.removeItem("datosPoput");
    localStorage.removeItem("datosCSV");
}

var ClearView = function () {

    $("#description").val('');
    $("#imgPoputs").val('');
    $("#imgPreview").hide();

}

function ClearFileView() {
    var inputImage = document.getElementById("imgPoputs").value = "";
    var inputImage = document.getElementById("targetImg").value = "";
    var inputImage = document.getElementById("targetImg").src = "";
    $("#imgPreview").hide();
    $("#description").html("Formato de archivo JPG.<br /> (326 x 418 píxeles)");
}

function getFileCSV() {
    var frmData = new FormData();
    var file = document.getElementById("fileCSV").files[0];
    frmData.append("fileCSV", file);
    $.ajax({
        type: "POST",
        url: URL_ADJUNTAR_ARCHIVO,
        data: frmData,
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function (msg) {

            if (msg.dataerror) {
                alert(msg.archivo);
                document.getElementById("EliminarArchivo").style.display = "none";
                $("#nameArchivo").html(OBJETO_MENJASE.validaArchivoCsv);
            } else {
                document.getElementById("EliminarArchivo").style.display = "block";
                $("#nameArchivo").html(msg.archivo);
            }
            getCargarArchivoCSVPoputLocalStorage(msg);
        },
        error: function (error) {
            alert("errror");
        }
    });
}

$("#btnGuardar").click(function () {

    if (parseInt($("#hdAccion").val()) == 2) {
        var cambio = respuestaValidacionCambios();
        if (!cambio) {
            alert(OBJETO_MENJASE.sinCambios);
            return false;
        }
    }

    if (document.getElementById("targetImg").getAttribute("src").length == 0) {
        alert(OBJETO_MENJASE.seleccionImagen);
        return false;
    }

    if ($.trim($("#txtTituloPrincipal").val()) == "") {
        alert(OBJETO_MENJASE.ingresoTituloPrincipal);
        return false;
    }

    if ($.trim($("#txtDescripcion").val()) == "") {
        alert(OBJETO_MENJASE.ingresoDescripcion);
        return false;
    }

    if ($("#txtDescripcion").val().length > 290) {
        alert(OBJETO_MENJASE.maximocaracteres);
        return false;
    }

    if ($.trim($("#txtUrl").val()) == "") {
        alert(OBJETO_MENJASE.ingresoURL);
        return false;
    }

    if ($.trim($("#fechaMin").val()) == "") {
        alert(OBJETO_MENJASE.fechaMinima);
        return false;
    }

    if ($.trim($("#fechaMax").val()) == "") {
        alert(OBJETO_MENJASE.fechaMaxima);
        return false;
    }

    if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked != true) {
        alert(OBJETO_MENJASE.ingresoTipoDispositivo);
        return false;
    }
    var bool = confirm(OBJETO_MENJASE.guardarDatos);
    if (bool) {
        waitingDialog({ "title": OBJETO_MENJASE.cargando, "message": OBJETO_MENJASE.espera });

        /*Zona de archivos*/
        var frmData = new FormData();
        if (document.getElementById("imgPoputs") != null)
            frmData.append("imagen", document.getElementById("imgPoputs").files[0]);

        /*Zona de campos*/
        frmData.append("imagenAnterior", localStorage.getItem('datosPoput') != null ? JSON.parse(localStorage.getItem('datosPoput')).UrlImagen : "");
        frmData.append("comunicadoId", $("#hdComunicadoId").val());
        frmData.append("txtTituloPrincipal", $("#txtTituloPrincipal").val());
        frmData.append("txtDescripcion", $("#txtDescripcion").val());
        frmData.append("txtUrl", $("#txtUrl").val());
        frmData.append("fechaMax", $("#fechaMax").val());
        frmData.append("fechaMin", $("#fechaMin").val());
        frmData.append("checkMobile", document.getElementById('checkMobile').checked);
        frmData.append("checkDesktop", document.getElementById('checkDesktop').checked);
        frmData.append("nombreArchivo", $("#nameArchivo").html().trim().toString() != OBJETO_MENJASE.validaArchivoCsv.trim().toString() ? $("#nameArchivo").html().trim().toString() : "");
        frmData.append("codigoCampania", $("#ddlCampania").val());
        frmData.append("accionID", $("#hdAccion").val());
        if (localStorage.getItem("datosCSV") != null)
            frmData.append("datosCSV", localStorage.getItem("datosCSV"));
        else
            frmData.append("datosCSV", null);

        $.ajax({
            type: "POST",
            url: URL_GUARDAR_POPUT,
            data: frmData,
            dataType: 'json',
            contentType: false,
            processData: false,
            success: function (msg) {
                if (parseInt(msg) > 0) {
                    alert(OBJETO_MENJASE.registroSatisfactorio);
                    window.location.reload(true);
                } else {
                    alert(OBJETO_MENJASE.errorRegistro);
                    closeWaitingDialog();
                }
            },
            error: function (error) {
                alert("errror");
            }
        });
    }
});

function respuestaValidacionCambios() {
    var acumuladoValidacion = 0;

    if (JSON.parse(localStorage.getItem('datosPoput')).NombreImagen != $("#description").html())
        acumuladoValidacion += 1;
    if (JSON.parse(localStorage.getItem('datosPoput')).NombreArchivoCCV != ($("#nameArchivo").html() == OBJETO_MENJASE.validaArchivoCsv ? "" : $("#nameArchivo").html()))
        acumuladoValidacion += 1;   
    if (JSON.parse(localStorage.getItem('datosPoput')).Descripcion != $("#txtTituloPrincipal").val())
        acumuladoValidacion += 1;
    if (JSON.parse(localStorage.getItem('datosPoput')).DescripcionAccion != $("#txtUrl").val())
        acumuladoValidacion += 1;
    if (JSON.parse(localStorage.getItem('datosPoput')).FechaInicio_ != $("#fechaMin").val())
        acumuladoValidacion += 1;
    if (JSON.parse(localStorage.getItem('datosPoput')).FechaFin_ != $("#fechaMax").val())
        acumuladoValidacion += 1;
    if (JSON.parse(localStorage.getItem('datosPoput')).Comentario != $("#txtDescripcion").val())
        acumuladoValidacion += 1;


    if (JSON.parse(localStorage.getItem('datosPoput')).TipoDispositivo == 1) {/*Mobile*/
        if (document.getElementById('checkDesktop').checked == true && document.getElementById('checkMobile').checked == true)
            acumuladoValidacion += 1;
        if (document.getElementById('checkDesktop').checked != true && document.getElementById('checkMobile').checked == true)
            acumuladoValidacion += 1;
        if (document.getElementById('checkDesktop').checked != true && document.getElementById('checkMobile').checked != true)
            acumuladoValidacion += 1;
    }

    if (JSON.parse(localStorage.getItem('datosPoput')).TipoDispositivo == 2) {/*Desktop*/
        if (document.getElementById('checkMobile').checked == true && document.getElementById('checkDesktop').checked == true)
            acumuladoValidacion += 1;
        if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked == true)
            acumuladoValidacion += 1;
        if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked != true)
            acumuladoValidacion += 1;
    }



    if (JSON.parse(localStorage.getItem('datosPoput')).TipoDispositivo == 0) { /*Todos*/
        if (document.getElementById('checkMobile').checked == true && document.getElementById('checkDesktop').checked != true)
            acumuladoValidacion += 1;
        if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked == true)
            acumuladoValidacion += 1;
        if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked != true)
            acumuladoValidacion += 1;
    }

    if (acumuladoValidacion > 0) return true; else return false;
}

function ValidaImagen(file) {
    $("#description").html("Formato de archivo JPG.<br /> (326 x 418 píxeles)");
    $("#targetImg").attr("src", "");
    $("#imgPreview").hide();

    var sizeByte = file[0].size;
    var siezekiloByte = parseInt(sizeByte / 1024);
    var foto = file[0];

    if (siezekiloByte > 52) {
        alert(OBJETO_MENJASE.tamañoSuperadoImagen);
        return false;
    }

    if (file.length == 0 || !(/\.(png)$/i).test(foto.name)) {
        alert(OBJETO_MENJASE.formatoInvalidoImagen);
        return false;
    }

    if ($("#imgPoputs").width() > 326) {
        alert(OBJETO_MENJASE.dimensionesImagen);
        return false;
    }

    if ($("#imgPoputs").height() > 418) {
        alert(OBJETO_MENJASE.dimensionesImagen);
        return false;
    }

    var frmData = new FormData();
    frmData.append("imagen", document.getElementById("imgPoputs").files[0]);
    frmData.append("nombreImagen", document.getElementById("imgPoputs").files[0].name);
    $.ajax({
        url: URL_AGREGAR_IMAGEN,
        type: 'POST',
        data: frmData,
        processData: false,
        contentType: false,
        success: function (data) {
        }
    });
    ReadImage(file[0]);
}

$(".eliminarArchivo").click(function () {

    var comunicadoid = $("#hdComunicadoId").val() == "" ? 0 : $("#hdComunicadoId").val();
    var object = {
        Comunicadoid: parseInt(comunicadoid)
    };

    $.ajax({
        type: "POST",
        url: URL_ELIMINA_ARCHIVOCSV,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(object),
        dataType: "json",
        async: true,
        success: function (msg) {
            localStorage.removeItem("datosCSV");
            $("#nameArchivo").html("");
            $("#fileCSV").val("");
            document.getElementById("EliminarArchivo").style.display = "none";
            $("#nameArchivo").html(OBJETO_MENJASE.validaArchivoCsv);
        },
        error: function (error) {
            alert("errror");
        }
    });
});

/***************************************************************************************************************************************/

