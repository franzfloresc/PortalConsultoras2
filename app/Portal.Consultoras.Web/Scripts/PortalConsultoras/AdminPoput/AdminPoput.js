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
                // Cambia el idioma a calendario
                $.datepicker.regional['es'] = {
                    closeText: 'Cerrar',
                    prevText: '<Ant',
                    nextText: 'Sig>',
                    currentText: 'Hoy',
                    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
                    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
                    dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
                    weekHeader: 'Sm',
                    dateFormat: 'dd/mm/yy',
                    firstDay: 1,
                    isRTL: false,
                    showMonthAfterYear: false,
                    yearSuffix: ''
                };
                $.datepicker.setDefaults($.datepicker.regional['es']);
                // Fin - Cambia el idioma a calendario

                $('#fechaMin').datepicker();
                $('#fechaMax').datepicker();
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
                $("#hdAccion").val(1);
                $('#modalTitulo').html($(this).attr('title'));
                $('#AgregarPopup').fadeIn(100);
                $('#AgregarPopup').scrollTop(0);
                $('#AgregarPopup').css('display', 'flex');
                $('body').css('overflow-y', 'hidden');
            },
            AbrirPopupModificar: function (e) {
                
                var comunicadoid = e.target.getAttribute("comunicadoid")
                GetCargaDetallePoput(comunicadoid);
                e.preventDefault();
                $("#hdAccion").val(1);
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
            if (checkTimeout(data)) {
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
    $("#targetImg").attr('src', (RUTA_MADRE + data.UrlImagen));
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
    
    var File = this.files;
    //var resultado = ValidaImagen(File);
    //if (resultado) {
        if (File && File[0])
            ReadImage(File[0]);
    //}
});

function ValidaImagen(file) {
    var uploadFile = file[0];
    
  
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
    $("#description").val('');
    $("#imgPoputs").val('');
    $("#imgPreview").hide();

    $("#txtTituloPrincipal").val("");
    $("#txtDescripcion").val("");
    $("#txtUrl").val("");
    $("#txtUrl").val("");
    $("#nameArchivo").html("");
    $("#fechaMin").val("");
    $("#fechaMax").val("");
    document.getElementById('checkMobile').checked = false;
    document.getElementById('checkDesktop').checked = false;
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
         $("#nameArchivo").html(msg.archivo); 
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
    //var listColumnas = ["N*", "Fondo", "Duración", "Título", "Ruta", "Estado", "Editar"];
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
    var detalle = "<div id='swappable' class='d__block administracion__popups__grilla__contenido'>";
    //detalle += "<div class='background__color__m__lighter row__grilla'><div class='col__grilla col__grilla--numero' ><div class='row__grilla row__grilla__texto text__center'>1</div></div ><div class='col__grilla col__grilla--fondo'> <div class='row__grilla row__grilla__texto text__center'> CL_20190142913.png</div></div><div class='col__grilla col__grilla--duracion'><div class='row__grilla row__grilla__texto text__center'>25/03/2019  -  09/04/2019</div></div> <div class='col__grilla col__grilla--titulo'><div class='row__grilla row__grilla__texto text__center'>¡Gana un viaje a Punta Cana! comprando más...</div></div><div class='col__grilla col__grilla--ruta'><div class='row__grilla row__grilla__texto text__center'> https://www.sbepdqa.somosbelcorp.com </div> </div><div class='col__grilla col__grilla--estado'><div class='row__grilla row__grilla__texto text__center'> Activo </div> </div><div class='col__grilla col__grilla--editar'><div class='row__grilla row__grilla__texto text__center'><a href='' title='Editar' class='d__block enlace__editar'><img src='/Content/Images/Edit.png' alt='Editar' title='Editar' class='d__block'></a></div> </div></div>";
    for (var i = 0; i < data.length; i++) {
        detalle += "<div class='d__block background__color__m__lighter ui-state-default row__grilla'>";
        detalle += "<div class='col__grilla col__grilla--numero'><div class='row__grilla row__grilla__texto text__center' >" + data[i].Numero + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--fondo'><div class='row__grilla row__grilla__texto text__center' >" + data[i].UrlImagen + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--duracion'><div class='row__grilla row__grilla__texto text__center' >" + (data[i].FechaInicio_ + "-" + data[i].FechaFin_) + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--titulo'><div class='row__grilla row__grilla__texto text__center' >" + data[i].Titulo + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--ruta'><div class='row__grilla row__grilla__texto text__center' >" + data[i].DescripcionAccion + "</div ></div >";
        detalle += "<div class='col__grilla col__grilla--estado'><div class='row__grilla row__grilla__texto text__center' >" + (data[i].Activo ? "Activo" : "Inactivo") + "</div ></div >";
        detalle += "<div  class='col__grilla col__grilla--editar'><div class='row__grilla row__grilla__texto text__center' ><a href='' title='Editar Popup' class='d__block enlace__editar'><img ComunicadoId=" + data[i].ComunicadoId.toString() + " src='/Content/Images/Edit.png')' alt='Editar Popup' title='Editar Popup' class='d__block'></a></div></div >";
        detalle += "</div>";
    }
    detalle += "</div>";
    $("#divTabla").append(cabecera + detalle);
    VistaAdministracionPopups.Funciones.OrdenamientoPersonalizadoFilasGrilla();
}



/*Inseriones*/

$("#btnGuardar").click(function () {
    /*Zona de archivos*/
    var frmData = new FormData();
    var archivoCSV = document.getElementById("fileCSV").files[0];
    var archivoImagen = document.getElementById("imgPoputs").files[0];
    frmData.append("fileCSV", archivoCSV);
    frmData.append("fileCSV", archivoImagen);

    /*Zona de campos*/
    var txtTituloPrincipal = $("#txtTituloPrincipal").val();
    var txtDescripcion = $("#txtDescripcion").val();
    var txtUrl = $("#txtUrl").val();
    var fechaMax = $("#fechaMax").val();
    var fechaMin = $("#fechaMin").val();
    var checkMobile = $("#checkMobile").val();
    var checkDesktop = $("#checkDesktop").val();
    var accionID = $("#hdAccion").val()
    /*Validaciones*/
    if (txtTituloPrincipal.length == 0) {
        alert("No ingresó Título principal");
        return false;
    }
    if (txtDescripcion.length == 0) {
        alert("No ingresó descripción");
        return false;
    }

    if (txtUrl.length == 0) {
        alert("No ingresó una URL");
        return false;
    }

    /*Validaciones de fecha*/
    if (fechaMin.length == 0) {
        alert("No ingresó una fecha de inicio");
        return false;
    }

    if (fechaMax.length == 0) {
        alert("No ingresó una fecha final");
        return false;
    }
    /*****************************************************************/


    /*carga de datos*/
    frmData.append("tituloPrincipal", txtTituloPrincipal);
    frmData.append("descripcion", txtDescripcion);
    frmData.append("Url", txtUrl);
    frmData.append("fechaMax", fechaMax);
    frmData.append("fechaMin", fechaMin);
    frmData.append("mobile", checkMobile);
    frmData.append("desktop", checkDesktop);
    frmData.append("accionID", accionID );

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






