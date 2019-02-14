var RUTA_MADRE = "~/";
var VistaAdministracionPopups;
var URL_BUSCAR_POPUTS = baseUrl + 'AdministracionPopups/GetCargaListadoPoput';
var URL_ADJUNTAR_ARCHIVO = baseUrl + 'AdministracionPopups/GetCargarArchivoCSV';
var URL_GUARDAR_POPUT = baseUrl + 'AdministracionPopups/GetGuardarPoput';
var URL_DETALLE_POPUT = baseUrl + 'AdministracionPopups/GetDetallePoput';
var VistaAdministracionPopups;

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
                $("#fechaMin").datepicker(
                    {
                        minDate: new Date(),
                        changeMonth: true,
                        numberOfMonths: 1,
                        onClose: function (selectedDate) {
                            $("#fechaMax").datepicker("option", "minDate", selectedDate);
                        }
                    });

                $("#fechaMax").datepicker(
                    {
                        minDate: new Date(),
                        changeMonth: true,
                        numberOfMonths: 1,
                    });
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
                    $("#hdAccion").val(1)
                    LimpiarCamposPoput();
                    $("#hdAccion").val(1);
                    $('#modalTitulo').html($(this).attr('title'));
                    $('#AgregarPopup').fadeIn(100);
                    $('#AgregarPopup').scrollTop(0);
                    $('#AgregarPopup').css('display', 'flex');
                    $('body').css('overflow-y', 'hidden');
                },
            AbrirPopupModificar: function (e) {
                    e.preventDefault();
                    $("#hdAccion").val(2)
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
        let partes = (e.target.value || '').split('/');
        if (partes.length != 3) {
            alert("Por favor ingrese una fecha válida");
            e.target.value = "";
        }
    });


    $('#fechaMax').change(function (e) {
        let partes = (e.target.value || '').split('/');
        if (partes.length != 3) {
            alert("Por favor ingrese una fecha válida");
            e.target.value = "";
        }
        if ($.trim($("#fechaMin").val()) == "") {
            alert("Por favor ingrese la fecha mínima");
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

    $("#targetImg").attr('src', (data.UrlImagen));
    $("#description").html(data.NombreImagen);
    $("#imgPreview").show();

    $("#txtTituloPrincipal").val(data.Descripcion);
    $("#txtDescripcion").val("");
    $("#txtUrl").val(data.DescripcionAccion);
    $("#nameArchivo").html(data.NombreArchivoCCV);
    $("#fechaMin").val(data.FechaInicio_);
    $("#fechaMax").val(data.FechaFin_);
    
    if (data.TipoDispositivo == 1) {
        document.getElementById('checkMobile').checked = true;
        document.getElementById('checkDesktop').checked = false;
    }
    if (data.TipoDispositivo == 2) {
        document.getElementById('checkMobile').checked = false;
        document.getElementById('checkDesktop').checked = true;
    }
    if (data.TipoDispositivo == 0) {
        document.getElementById('checkMobile').checked = true;
        document.getElementById('checkDesktop').checked = true;
    }


}



$("#imgPoputs").change(function () {

    var File = this.files;
  var objRespuesta = ValidaImagen(File);
    	    if (objRespuesta.mensaje == undefined) {
        	        if (File && File[0])
            	            ReadImage(File[0]);
        
    } else {
        	        $("#description").html(objRespuesta.mensaje);
        	        return false;
        
    }
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
            $("#description").html(file.name /*"Formato de archivo JPG." + "<br/>" + "(" + height + "x" + width + "píxeles)"*/);
            $("#imgPreview").show();
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
            
            $("#nameArchivo").html(msg.archivo);
              getCargarArchivoCSVPoputLocalStorage(msg);
        },
        error: function (error) {
            alert("errror");
        }
    });
}









/*Inseriones*/

    $("#btnGuardar").click(function () {


        /*Validaciones*/


        if ($.trim($("#description").html()) == "") {
            alert("No seleccionó una imagen");
            return false;
        }

        if ($.trim($("#txtTituloPrincipal").val()) == "") {
            alert("No ingresó el Título principal.");
            return false;
        }

        if ($.trim($("#txtDescripcion").val()) == "") {
            alert("No ingresó la descripcón.");
            return false;
        }

        if ($("#txtDescripcion").val().length > 290) {
            alert("Sobrepasó la cantidad ceptada de caracteres");
            return false;
        }

        if ($.trim($("#txtUrl").val()) == "") {
            alert("No ingresó una URL");
            return false;
        }

        if ($.trim($("#fechaMin").val()) == "") {
            alert("No ingresó una fecha mínima.");
            return false;
        }

        if ($.trim($("#fechaMax").val()) == "") {
            alert("No ingresó una fecha máxima.");
            return false;
        }


        /*****************************************************************/

        if (parseInt($("#hdAccion").val()) == 2) {
            var cambio = respuestaValidacionCambios();
            if (!cambio) {
                alert("No existe ningún cambio realizado");
                return false;
            }
        }
        if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked != true) {
            alert("No seelccionó un tipo de dispositivo");
            return false;
        }


        /*carga de datos*/
        /*Zona de archivos*/
        var frmData = new FormData();
        if (document.getElementById("imgPoputs") != null)
            frmData.append("imagen", document.getElementById("imgPoputs").files[0]);

        /*Zona de campos*/
        frmData.append("imagenAnterior", localStorage.getItem('datosPoput') != null ? JSON.parse(localStorage.getItem('datosPoput')).NombreImagen : "");
        frmData.append("comunicadoId", $("#hdComunicadoId").val());
        frmData.append("txtTituloPrincipal", $("#txtTituloPrincipal").val());
        frmData.append("txtDescripcion", $("#txtDescripcion").val());
        frmData.append("txtUrl", $("#txtUrl").val());
        frmData.append("fechaMax", $("#fechaMax").val());
        frmData.append("fechaMin", $("#fechaMin").val());
        frmData.append("checkMobile", document.getElementById('checkMobile').checked);
        frmData.append("checkDesktop", document.getElementById('checkDesktop').checked);
        frmData.append("nombreArchivo", $("#nameArchivo").html());
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
                    alert("Se registró de forma satisfactoria");
                }
            },
            error: function (error) {
                alert("errror");
            }
        });



    });


    function respuestaValidacionCambios() {
        var acumuladoValidacion = 0;
        if (JSON.parse(localStorage.getItem('datosPoput')).NombreImagen != $("#description").html())
            acumuladoValidacion += 1;
        if (JSON.parse(localStorage.getItem('datosPoput')).NombreArchivoCCV != $("#nameArchivo").html())
            acumuladoValidacion += 1;
        if (JSON.parse(localStorage.getItem('datosPoput')).Descripcion != $("#txtTituloPrincipal").val())
            acumuladoValidacion += 1;
        if (JSON.parse(localStorage.getItem('datosPoput')).DescripcionAccion != $("#txtUrl").val())
            acumuladoValidacion += 1;
        if (JSON.parse(localStorage.getItem('datosPoput')).FechaInicio_ != $("#fechaMin").val())
            acumuladoValidacion += 1;
        if (JSON.parse(localStorage.getItem('datosPoput')).FechaFin_ != $("#fechaMax").val())
            acumuladoValidacion += 1;

        if (JSON.parse(localStorage.getItem('datosPoput')).TipoDispositivo == 1) {
            if (document.getElementById('checkMobile').checked == true && document.getElementById('checkDesktop').checked == true)
                acumuladoValidacion += 1;
            if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked == true)
                acumuladoValidacion += 1;
            if (document.getElementById('checkMobile').checked != true && document.getElementById('checkDesktop').checked != true)
                acumuladoValidacion += 1;
        }

        if (JSON.parse(localStorage.getItem('datosPoput')).TipoDispositivo == 2) {
            if (document.getElementById('checkDesktop').checked == true && document.getElementById('checkMobile').checked == true)
                acumuladoValidacion += 1;
            if (document.getElementById('checkDesktop').checked != true && document.getElementById('checkMobile').checked == true)
                acumuladoValidacion += 1;
            if (document.getElementById('checkDesktop').checked != true && document.getElementById('checkMobile').checked != true)
                acumuladoValidacion += 1;
        }

        if (JSON.parse(localStorage.getItem('datosPoput')).TipoDispositivo == 0) {
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
    $("#description").html("");
    $("#targetImg").attr("src", "");

    var uploadFile = file[0];


    if (!window.FileReader) {
        $("#description").html("El navegador no soporta tal lectura de archivos");
        return false;

    }

    if (!(/\.(jpg|png|gif)$/i).test(uploadFile.name)) {
        $("#description").html("El archivo a adjuntar no es una imagen");
        return false;

    } else {
        var objRespuesta = new Object();

        if (!window.FileReader)
            objRespuesta.mensaje = "El navegador no soporta tal lectura de archivos";

        if (file.length == 0 || !(/\.(jpg|png)$/i).test(uploadFile.name))
            objRespuesta.mensaje = "Ingrese una imagen con alguno de los siguientes formatos: .jpeg/.jpg/.png.";


        if (!(/\.(jpg|png|gif)$/i).test(uploadFile.name))
            objRespuesta.mensaje = "El archivo a adjuntar no es una imagen";
        else {
            var img = new Image();
            img.onload = function () {

                if (this.width.toFixed(0) != 200 && this.height.toFixed(0) != 200) {
                    $("#description").html("Las medidas deben ser: 200 * 200'");
                    return false;

                } else if (uploadFile.size > 20000) {
                    $("#description").html("El peso de la imagen no puede exceder los 200kb");
                    return false;

                } else
                    return true;

                if (this.width.toFixed(0) != 326 && this.height.toFixed(0) != 418)
                    objRespuesta.mensaje = "Las medidas deben ser: 326 x 418'";
                else if (uploadFile.size > 20000)
                    objRespuesta.mensaje = "El peso de la imagen no puede exceder los 200kb";

            };

        }

        return objRespuesta;

    }

}
