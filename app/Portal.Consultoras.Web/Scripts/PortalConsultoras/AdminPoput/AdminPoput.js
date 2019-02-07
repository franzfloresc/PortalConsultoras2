var VistaAdministracionPopups;
var URL_CARGAR_CAMPAÑAS = baseUrl + 'AdministracionPopups/GetCargaCampañas';
var URL_BUSCAR_POPUTS = baseUrl + 'AdministracionPopups/GetCargaListadoPoput';
var URL_ADJUNTAR_ARCHIVO = baseUrl + 'AdministracionPopups/GetCargarArchivoCSV';
var VistaAdministracionPopups;

$(document).ready(function () {
    //document.getElementById("rbtActivo").checked = true;
    debugger;
    var vistaAdPop;

    vistaAdPop = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('click', '.btn__agregar, .enlace__editar', me.Eventos.AbrirPopup);
                $('body').on('click', '.btn__modal--guardar, .btn__modal--descartar', me.Eventos.CerrarPopup);
            }
        },
            me.Eventos = {
                AbrirPopup: function (e) {
                    e.preventDefault();
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
            }
    }

    VistaAdministracionPopups = new vistaAdPop();
    VistaAdministracionPopups.Inicializar();
});

$("#imgPoputs").change(function () {
    debugger;
    var File = this.files;
    var resultado = ValidaImagen(File);
    if (resultado) {
        if (File && File[0])
            ReadImage(File[0]);
    }
});

function ValidaImagen(file) {
    var uploadFile = file[0];
    debugger;
  
    if (!window.FileReader) {
        $("#description").html("El navegador no soporta tal lectura de archivos");
        return false;
    }

    if (!(/\.(jpg|png|gif)$/i).test(uploadFile.name)) {
        $("#description").html("El archivo a adjuntar no es una imagen");
        return false;
    } else {
        var img = new Image();
        img.onload = function () {
            debugger;
            if (this.width.toFixed(0) != 200 && this.height.toFixed(0) != 200) {
                $("#description").html("Las medidas deben ser: 200 * 200'");
                return false;
            } else if (uploadFile.size > 20000) {
                $("#description").html("El peso de la imagen no puede exceder los 200kb");
                return false;
            } else
                return true;
        };
    }   
}

var ReadImage = function (file) {
    debugger;

   
    var reader = new FileReader;
    var image = new Image;

    reader.readAsDataURL(file);
    reader.onload = function (_file) {
        debugger;
        image.src = _file.target.result;
        image.onload = function () {
            var height = this.height;
            var width = this.width;
            var type = file.type;   
            var size = ~~(file.size / 1024) + "KB";

            $("#targetImg").attr('src', _file.target.result);
            $("#description").html("Formato de archivo JPG." + "<br/>" + "(" + height + "x" + width + "píxeles)");
            $("#imgPreview").show();
        }
    }
}
var ClearView = function () {
    debugger;
    $("#description").val('');
    $("#imgPoputs").val('');
    $("#imgPreview").hide();
}

function ClearFileView() {

}

function getFileCSV() {
    debugger;
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
        },
        error: function (error) {
            alert("errror");
        }
    });
}

$('input[type=radio]').on('change', function () {
    GetCargaListadoPoput();
});



function GetCargaListadoPoput() {
    var ddlCampania = $('#ddlCampania').val();
    var rbtActivo = $('#rbtActivo').val();

    var object = {
        Campania: ddlCampania,
        Estado: rbtActivo ? 1 : 0
    };

    $.ajax({
        type: "POST",
        url: URL_BUSCAR_POPUTS,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(object),
        dataType: "json",
        cache: false,
        success: function (data) {
            debugger;
            if (checkTimeout(data)) {
                ConstruyeGrillaPoput(data);
            }
        },
        error: function (x, xh, xhr) {
            if (checkTimeout(x)) {
                closeWaitingDialog();
            }
        }
    });
}

$('#ddlCampania').change(function () {
    GetCargaListadoPoput();
});

function ConstruyeGrillaPoput(data) {


    $("#divTabla").empty();
    var listColumnas = ["N*", "Fondo", "Duración", "Título", "Ruta", "Estado", "Editar"];

    /*Cabecera*/
    var cantidadPoputs = "<h2 class='d__block text__bold administracion__popups__grilla__titulo'>" + (parseInt(data.length) + (data.length == 1 ? " Poput" : " Poputs") + " agregados") + "</h2 >";
    var cabecera = "<div class='background__color__m row__grilla administracion__popups__grilla__cabecera'>";
    listColumnas.forEach(function (element) {
        cabecera += "<div class='col__grilla col__grilla--" + (element.toString() == "N*" ? "numero" : element.toString()) + " text__center'>" + element.toString() + "</div>";
    });
    cabecera += "</div>";

    /*Detalle*/
    var detalle = "<div class='d__block administracion__popups__grilla__contenido'>";
    detalle += "<div class='background__color__m__lighter row__grilla'><div class='col__grilla col__grilla--numero' ><div class='row__grilla row__grilla__texto text__center'>1</div></div ><div class='col__grilla col__grilla--fondo'> <div class='row__grilla row__grilla__texto text__center'> CL_20190142913.png</div></div><div class='col__grilla col__grilla--duracion'><div class='row__grilla row__grilla__texto text__center'>25/03/2019  -  09/04/2019</div></div> <div class='col__grilla col__grilla--titulo'><div class='row__grilla row__grilla__texto text__center'>¡Gana un viaje a Punta Cana! comprando más...</div></div><div class='col__grilla col__grilla--ruta'><div class='row__grilla row__grilla__texto text__center'> https://www.sbepdqa.somosbelcorp.com </div> </div><div class='col__grilla col__grilla--estado'><div class='row__grilla row__grilla__texto text__center'> Activo </div> </div><div class='col__grilla col__grilla--editar'><div class='row__grilla row__grilla__texto text__center'><a href='' title='Editar' class='d__block enlace__editar'><img src='/Content/Images/Edit.png' alt='Editar' title='Editar' class='d__block'></a></div> </div></div>";
    for (var i = 0; i < data.length; i++) {
        detalle += "<div class='background__color__m__lighter row__grilla'>";
        detalle += "<div class='col__grilla col__grilla--numero'><div class='row__grilla row__grilla__texto text__center' >" + data[i].Numero + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--fondo'><div class='row__grilla row__grilla__texto text__center' >" + data[i].UrlImagen + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--duracion'><div class='row__grilla row__grilla__texto text__center' >" + (data[i].FechaInicio_ + "-" + data[i].FechaFin_) + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--titulo'><div class='row__grilla row__grilla__texto text__center' >" + data[i].Titulo + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--ruta'><div class='row__grilla row__grilla__texto text__center' >" + data[i].DescripcionAccion + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--estado'><div class='row__grilla row__grilla__texto text__center' >" + (data[i].Estado ? "Activo" : "Inactivo") + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--editar'><div class='row__grilla row__grilla__texto text__center' ><a href='' title='Editar' class='d__block enlace__editar'> <img src='/Content/Images/Edit.png' alt='Editar' title='Editar' class='d__block'></a></div></div >";
        detalle += "</div>";
    }
    detalle += "</div>";
    $("#divTabla").append(cabecera + detalle);
}