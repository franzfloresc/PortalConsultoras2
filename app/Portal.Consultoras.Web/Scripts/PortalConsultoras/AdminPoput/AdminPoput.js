var RUTA_MADRE = "~/";
var VistaAdministracionPopups;
var URL_BUSCAR_POPUTS = baseUrl + 'AdministracionPopups/GetCargaListadoPoput';
var URL_ADJUNTAR_ARCHIVO = baseUrl + 'AdministracionPopups/GetCargarArchivoCSV';
var URL_GUARDAR_POPUT = baseUrl + 'AdministracionPopups/GetGuardarPoput';
var URL_DETALLE_POPUT = baseUrl + 'AdministracionPopups/GetDetallePoput';
var VistaAdministracionPopups;

$(document).ready(function () {
    GetCargaListadoPoput();
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
            }
        },
            me.Eventos = {
            AbrirPopupNuevo: function (e) {
                debugger;
                e.preventDefault();
                $("#hdAccion").val(1)
                LimpiarCamposPoput();
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
    debugger;
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
            debugger;
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

function GetCamposCargadosPoput(data) {
    debugger;
    $("#targetImg").attr('src', (data.UrlImagen));
    $("#description").html(data.NombreImagen);
    $("#imgPreview").show();

    $("#txtTituloPrincipal").val("");
    $("#txtDescripcion").val(data.Descripcion);
    $("#txtUrl").val(data.DescripcionAccion);
    $("#nameArchivo").html(data.NombreArchivoCCV);
    $("#fechaMin").val(data.FechaInicio_);
    $("#fechaMax").val(data.FechaFin_);
    if (data.TipoDispositivo == 1) {
        document.getElementById('checkMobile').checked = true;
        document.getElementById('checkMobile').checked = false;
    }
    if (data.TipoDispositivo == 2) {
        document.getElementById('checkMobile').checked = false;
        document.getElementById('checkMobile').checked = true;
    }
    if (data.TipoDispositivo == 0) {
        document.getElementById('checkMobile').checked = false;
        document.getElementById('checkMobile').checked = false;
    }





}


$("#imgPoputs").change(function () {
    debugger;
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

function ValidaImagen(file) {
    $("#description").html("");
    $("#targetImg").attr("src", "");

    var uploadFile = file[0];
    var objRespuesta = new Object();
    
    if (!window.FileReader) 
        objRespuesta.mensaje="El navegador no soporta tal lectura de archivos";

    if (file.length == 0 || !(/\.(jpg|png)$/i).test(uploadFile.name)) 
        objRespuesta.mensaje = "Ingrese una imagen con alguno de los siguientes formatos: .jpeg/.jpg/.png.";
    

    if (!(/\.(jpg|png|gif)$/i).test(uploadFile.name)) 
        objRespuesta.mensaje="El archivo a adjuntar no es una imagen";
     else {
        var img = new Image();
        img.onload = function () {
            debugger;
            if (this.width.toFixed(0) != 326 && this.height.toFixed(0) != 418) 
                objRespuesta.mensaje ="Las medidas deben ser: 326 x 418'";
             else if (uploadFile.size > 20000) 
                objRespuesta.mensaje ="El peso de la imagen no puede exceder los 200kb";
        };
    }

    return objRespuesta;
}

var ReadImage = function (file) {
    debugger;
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
    debugger;
    $("#description").html("");
    $("#imgPoputs").val("");
    $("#imgPreview").val("");
    $("#targetImg").attr("src","");

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
            debugger;
            $("#nameArchivo").html(msg.archivo); 
            getCargarArchivoCSVPoputLocalStorage(msg);

        },
        error: function (error) {
            alert("errror");
        }
    });
}

$('#ddlCampania, #ddlEstado').change(function () {
    
    GetCargaListadoPoput();
});

function GetCargaListadoPoput() {
    var ddlCampania = $('#ddlCampania').val();
    var ddlEstado = parseInt( $('#ddlEstado').val());

    var object = {
        Campania: ddlCampania,
        Estado: ddlEstado 
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





function ConstruyeGrillaPoput(data) {


    $("#divTabla").empty();
   // var listColumnas = ["N*", "Fondo", "Duración", "Título", "Ruta", "Estado", "Editar"];
    var listColumnas = [
        {
            tituloColumna: 'N°',
            claseColumna: 'col__grilla--numero'
        },
        {
            tituloColumna: 'Fondo',
            claseColumna: 'col__grilla--fondo'
        },
        {
            tituloColumna: 'Duración',
            claseColumna: 'col__grilla--duracion'
        },
        {
            tituloColumna: 'Título',
            claseColumna: 'col__grilla--titulo'
        },
        {
            tituloColumna: 'Ruta',
            claseColumna: 'col__grilla--ruta'
        },
        {
            tituloColumna: 'Estado',
            claseColumna: 'col__grilla--estado'
        },
        {
            tituloColumna: 'Editar',
            claseColumna: 'col__grilla--editar'
        }
    ];
    /*Cabecera*/
    var cantidadPoputs = "<h2 class='d__block text__bold administracion__popups__grilla__titulo'>" + (parseInt(data.length) + (data.length == 1 ? " Poput" : " Poputs") + " agregados") + "</h2 >";
    var cabecera = "<div class='background__color__m row__grilla administracion__popups__grilla__cabecera'>";
    listColumnas.forEach(function (element) {
        //if ((element.tituloColumna).toString() == "Estado") {
        //    cabecera += "<div class='col__grilla col__grilla--estado text__center'><a href = '' class='col__grilla__despliegue__opciones col__grilla__despliegue__opciones--estado' title = 'Seleccionar Estado' ><span class='d__inline__block'>Estado</span><span class='d__inline__block'><img src='/Content/Images/flecha_desplegable_grilla.svg')' alt='Desplegar opciones' /></span></a ><ul class='d__block ml__auto mr__auto lista__opciones__filtro__estado'><li class='d__block w__100 empty__space'></li><li class='d__block opcion__filtro__estado opcion__filtro__estado--activo'><a href='' class='d__block opcion__filtro__estado__enlace' title='Activo'>Activo</a></li><li class='d__block opcion__filtro__estado opcion__filtrar__por__estado--inactivo'><a href='' class='d__block opcion__filtro__estado__enlace' title='Inactivo'>Inactivo</a></li></ul></div>";
        //} else
        cabecera += "<div class='col__grilla " + (element.claseColumna).toString() + " text__center'>" + (element.tituloColumna).toString() + "</div>";
    });
    cabecera += "</div>";

    /*Detalle*/
    var detalle = "<div class='d__block administracion__popups__grilla__contenido'>";
    //detalle += "<div class='background__color__m__lighter row__grilla'><div class='col__grilla col__grilla--numero' ><div class='row__grilla row__grilla__texto text__center'>1</div></div ><div class='col__grilla col__grilla--fondo'> <div class='row__grilla row__grilla__texto text__center'> CL_20190142913.png</div></div><div class='col__grilla col__grilla--duracion'><div class='row__grilla row__grilla__texto text__center'>25/03/2019  -  09/04/2019</div></div> <div class='col__grilla col__grilla--titulo'><div class='row__grilla row__grilla__texto text__center'>¡Gana un viaje a Punta Cana! comprando más...</div></div><div class='col__grilla col__grilla--ruta'><div class='row__grilla row__grilla__texto text__center'> https://www.sbepdqa.somosbelcorp.com </div> </div><div class='col__grilla col__grilla--estado'><div class='row__grilla row__grilla__texto text__center'> Activo </div> </div><div class='col__grilla col__grilla--editar'><div class='row__grilla row__grilla__texto text__center'><a href='' title='Editar' class='d__block enlace__editar'><img src='/Content/Images/Edit.png' alt='Editar' title='Editar' class='d__block'></a></div> </div></div>";
    for (var i = 0; i < data.length; i++) {
        detalle += "<div class='background__color__m__lighter row__grilla'>";
        detalle += "<div class='col__grilla col__grilla--numero'><div class='row__grilla row__grilla__texto text__center' >" + data[i].Numero + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--fondo'><div class='row__grilla row__grilla__texto text__center' >" + data[i].UrlImagen + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--duracion'><div class='row__grilla row__grilla__texto text__center' >" + (data[i].FechaInicio_ + "-" + data[i].FechaFin_) + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--titulo'><div class='row__grilla row__grilla__texto text__center' >" + data[i].Titulo + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--ruta'><div class='row__grilla row__grilla__texto text__center' >" + data[i].DescripcionAccion + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--estado'><div class='row__grilla row__grilla__texto text__center' >" + (data[i].Activo ? "Activo" : "Inactivo") + "</div ></div >";
        detalle += "<div  class='col__grilla col__grilla--editar'><div class='row__grilla row__grilla__texto text__center' ><a href=''   title='Editar' class='d__block enlace__editar'> <img  ComunicadoId=" + data[i].ComunicadoId.toString() + " src='@Url.Content(' / Content / Images / Edit.png')' alt='Editar' title='Editar' class='d__block'></a></div></div >";
        detalle += "</div>";
    }
    detalle += "</div>";
    $("#divTabla").append(cabecera + detalle);
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



/*Inseriones*/

$("#btnGuardar").click(function () {
    debugger;

    /*Validaciones*/
    if ($.trim(txtTituloPrincipal) == "") {
        alert("No ingresó el Título principal.");
        return false;
    }

    if ($.trim(txtDescripcion) == "") {
        alert("No ingresó la descripcón.");
        return false;
    }

    if (txtDescripcion.length > 290) {
        alert("Sobrepasó la cantidad ceptada de caracteres");
        return false;
    }

    if ($.trim(txtUrl) == "") {
        alert("No ingresó una URL");
        return false;
    }


    /*****************************************************************/


    /*carga de datos*/
    /*Zona de archivos*/
    var frmData = new FormData();
    var imagen = document.getElementById("fileCSV").files[0];
    frmData.append("imagen", imagen);

    /*Zona de campos*/
    frmData.append("comunicadoId", $("#hdComunicadoId").val());
    frmData.append("txtTituloPrincipal", $("#txtTituloPrincipal").val());
    frmData.append("txtDescripcion", $("#txtDescripcion").val());
    frmData.append("txtUrl", $("#txtUrl").val());
    frmData.append("fechaMax", $("#fechaMax").val());
    frmData.append("fechaMin", $("#fechaMin").val());
    frmData.append("checkMobile", document.getElementById('checkMobile').checked );
    frmData.append("checkDesktop", document.getElementById('checkDesktop').checked);
    frmData.append("nombreArchivo", $("#description").html());
    frmData.append("codigoCampania", $("#ddlCampania").val());
    frmData.append("accionID", $("#hdAccion").val());
    frmData.append("datosCSV", localStorage.getItem("datosCSV"));
   
    $.ajax({
        type: "POST",
        url: URL_GUARDAR_POPUT,
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



});






