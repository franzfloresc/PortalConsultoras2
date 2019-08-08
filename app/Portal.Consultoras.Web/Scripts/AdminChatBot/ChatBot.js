var _elemento = {
    TablaId: '#tblChatBot',
    TablaPagina: '#pagertblChatBot',
    DialogRegistro: 'DialogMantenimientoHistoriaDatos',
    DialogRegistroHtml: '#dialog-content-historia-datos',
    BtnNuevo: '#btnCrearRegistro',
    DdlComponente: '#ddlComponente',
    DdlCampania: '#ddlCampania',
    DivFormulario: '#divMantDatos',
    ChbxEstado: '#Estado',
    PopupTitulo: '#divPalancaDatos_Titulo',
    DialogImagen: 'DialogImagen',
}

var _texto = {
    Cargando: 'Cargando datos...',
    RegistroPaginar: '{0} - {1} de {2} Registros',
    SinResultados: 'No hay resultados',
    TituloDialogRegistro: 'Editar',
    ProcesoError: 'Error al procesar la solicitud.',
    ProcesoConforme: 'Se procesó con éxito su solicitud.',
    PopupTituloNuevo: 'Nuevo Registro',
    PopupTituloEditar: 'Actualizar Registro'
};

var _url = {
    UrlGrilla: baseUrl + 'ChatBot/ComponenteListar',

};

var CargarGrilla = function () {
    $(_elemento.TablaId).jqGrid('GridUnload');

    jQuery(_elemento.TablaId).jqGrid({
        url: _url.UrlGrilla,
        hidegrid: false,
        datatype: 'json',
        postData: ({
            PaisID: function () { return jQuery.trim($("#ddlPais").val()); },
            Consultora: function () { return jQuery.trim($("#txtCodConsultora").val()); },
            NombreOperador: function () { return jQuery.trim($("#txtNombreOperador").val()); },
            FechaInicio: function () { return $("#txtFechaInicio").val(); },
            FechaFin: function () { return $("#txtFechaFin").val(); },
        }),
        mtype: 'GET',
        contentType: 'application/json; charset=utf-8',
        multiselect: false,
        colNames: [
            'ID',
            'Código<br>Consultora',
            'Pais',
            'ID Conversación',
            'Fecha',
            'Fecha Fin',
            'Usuario <br>Operador',
            'Respuesta <br>Pregunta 1',
            'Respuesta <br>Pregunta 2',
            'Respuesta <br>Pregunta 3',
            'Respuesta Cualitativa<br>Pregunta 1',
            'Respuesta Cualitativa<br>Pregunta 2',
            'Respuesta Cualitativa<br>Pregunta 3',
            'Canal'
        ],
        colModel: [
            { name: 'ResultadosID', index: 'ResultadosID',  width: 0, align: 'center',resizable: false, sortable: false, hidden: true },
            { name: 'CodigoConsultora', index: 'CodigoConsultora', width: 100, align: 'center', resizable: false, sortable: false },
            { name: 'Pais', index: 'Pais', width: 50, align: 'center', resizable: false, sortable: false },
            { name: 'ConversacionID', index: 'ConversacionID', width: 400, align: 'center', resizable: false, sortable: false },
            { name: 'FechaInicio', index: 'FechaInicio', width: 150, align: 'center', resizable: false, sortable: false },
            { name: 'FechaFin', index: 'FechaFin', width: 150, align: 'center', resizable: false, sortable: false, hidden: true },
            { name: 'NombreOperador', index: 'NombreOperador', width: 120, align: 'center', resizable: false, sortable: false },
            { name: 'Resp1', index: 'Resp1', width: 90, align: 'center', resizable: false, sortable: false },
            { name: 'Resp2', index: 'Resp2', width: 90, align: 'center', resizable: false, sortable: false },
            { name: 'Resp3', index: 'Resp3', width: 90, align: 'center', resizable: false, sortable: false },
            { name: 'RespDescrip1', index: 'RespDescrip1', width: 180, align: 'center', resizable: false, sortable: false },
            { name: 'RespDescrip2', index: 'RespDescrip2', width: 180, align: 'center', resizable: false, sortable: false },
            { name: 'RespDescrip3', index: 'RespDescrip3', width: 180, align: 'center', resizable: false, sortable: false },
            { name: 'CanalDescripcion', index: 'CanalDescripcion', width: 100, align: 'center', resizable: false, sortable: false },
            
        ],
        pager: jQuery(_elemento.TablaPagina),
        loadtext: _texto.Cargando,
        recordtext: _texto.RegistroPaginar,
        emptyrecords: _texto.SinResultados,
        rowNum: 15,
        scrollOffset: 0,
        rowList: [15, 20, 30, 40, 50],
        viewrecords: true,
        pgtext: 'Pág: {0} de {1}',
        sortname: 'Orden',
        sortorder: 'asc',
        height: 'auto',
        width: 1190,
        altRows: true,
        altclass: 'jQGridAltRowClass'
    });
    jQuery(_elemento.TablaId).jqGrid('navGrid', _elemento.TablaPagina, { edit: false, add: false, refresh: false, del: false, search: false });
};



var _evento = function () {
    CargarGrilla();
};
var _initializar = function (param) {
   
    _evento();
};


jQuery(document).ready(function () {
    $("#txtCodConsultora").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ]/;
            return re.test(keyChar);
        }
    });

    $("#txtFechaInicio, #txtFechaFin").datepicker({
        showOn: "button",
        buttonImage: '/Content/Images/calendar.png',
        buttonImageOnly: true,
        dateFormat: 'dd/mm/yy'
    }).mask('99/99/9999');

    $("#btnBuscar").click(function () {
        if ($("#ddlPais").val() == "") {
            alert("Debe seleccionar un País, verifique");
            return false;
        }
        CargarGrilla();
    });

    _initializar();


    $.jgrid.extend({
      //  EditarOfertas: ModificarDetalle,
    });

});