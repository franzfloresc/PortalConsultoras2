//import { debug } from "util";
var VistaAdministracionPopups;
var URL_CARGAR_CAMPAÑAS = baseUrl + 'AdministracionPopups/GetCargaCampañas'
var URL_BUSCAR_POPUTS = baseUrl + 'AdministracionPopups/GetCargaListadoPoput'
var VistaAdministracionPopups;
debugger;
$(document).ready(function () {
    document.getElementById("rbtActivo").checked = true;
    debugger;
    var vistaAdPop;

    vistaAdPop = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('click', '.btn__agregar, .enlace__editar', me.Eventos.AbrirPopup);
                $('body').on('click', '.btn__modal--guardar, .btn__modal--descartar', me.Eventos.CerrarPopup);
            },
            CargarDatePicker: function() {
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
            me.Funciones.CargarDatePicker();
        }
    }

    VistaAdministracionPopups = new vistaAdPop();
    VistaAdministracionPopups.Inicializar();
});


$("#imgPoputs").change(function () {

    var File = this.files;

    if (File && File[0]) {
        ReadImage(File[0]);
    }
});


var ReadImage = function (file) {

    var reader = new FileReader;
    var image = new Image;

    reader.readAsDataURL(file);
    reader.onload = function (_file) {

        image.src = _file.target.result:
        image.onload = function () {
            var height = this.height;
            var width = this.width;
            var type = file.type;
            var size = ~~(file.size / 1024) + "KB";


        }
    }
}






$('input[type=radio]').on('change', function () {
    GetCargaListadoPoput();
});

$("#btnNuevo").click(function () {
    debugger;
    $.ajaxSetup({ cache: false });
    $("#rbtActivo").attr("checked", true);
    $("#rbtInactivo").attr("checked", false);

    var ComunicadoId = 1;/*Hidden*/
    showDialog("DialogAdministracionTipoEstrategia");
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