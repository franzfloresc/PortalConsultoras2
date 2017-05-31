﻿$(document).ready(function () {
    //$(".input-correo").keypress(
    //    function (evt) {
    //        var charCode = (evt.which) ? evt.which : window.event.keyCode;
    //        if (charCode <= 13) {
    //            return false;
    //        }
    //        else {
    //            var keyChar = String.fromCharCode(charCode);
    //            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
    //            $('#divNotiCorreo').hide();
    //            $('#divNotiCorreo2').hide();
    //            return re.test(keyChar);

    //        }
    //    });

    //$(".input-nombre").keypress(
    //    function (evt) {
    //        var charCode = (evt.which) ? evt.which : window.event.keyCode;
    //        if (charCode <= 13) {
    //            return false;
    //        }
    //        else {
    //            var keyChar = String.fromCharCode(charCode);
    //            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ _.\/-]/;
    //            $('#divNotiNombre').hide();
    //            $('#divNotiNombre2').hide();
    //            return re.test(keyChar);
    //        }
    //    });

    $("#txtBusqueda").keypress(function (e) {
        if (e.which == 13) {
            if (checkTimeout()) {
                CargarListaCliente();
            }
        }
    });

    $("body").on("click", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "back" || accion === "next") {
            CambioPagina(obj);
        }
    });

    $("body").on("change", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "page" || accion === "rows") {
            CambioPagina(obj);
        }
    });

    CrearDialogs();

    CargarListaCliente();
});

function CrearDialogs() {
    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    closeWaitingDialog();
}

function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    var rows = rpt.rows.replace('ver ', '');

    CargarListaCliente(rpt.page, rows);
    return true;
}

function CargarListaCliente(page, rows) {
    //$(".pMontoCliente").css("display", "none");

    $('#divListaCliente').html('<div style="text-align: center;">Cargando Lista de Clientes<br><img src="' + urlLoad + '" /></div>');

    //var clienteId = $("#ddlClientes").val() || -1;
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 10,
        vBusqueda: $('#txtBusqueda').val()
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Cliente/Consultar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                var html = ArmarListaCliente(data.rows);
                $('#divListaCliente').html(html);

                var htmlPaginador = ArmarListaClientePaginador(data);
                $('#paginadorCab').html(htmlPaginador);
                $('#paginadorPie').html(htmlPaginador);

                $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert(error);
            }
        }
    });
}

function ArmarListaCliente(array) {
    return SetHandlebars("#cliente-template", array);
}

function ArmarListaClientePaginador(data) {
    return SetHandlebars("#paginador-template", data);
}

var ClienteDetalleOK = null;
function showClienteDetalle(fila)
{
    if (gTipoUsuario == '2') {
        var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
        $('#dialog_MensajePostulante #tituloContenido').text("LO SENTIMOS");
        $('#dialog_MensajePostulante #mensajePostulante').text(mesg);
        $('#dialog_MensajePostulante').show();
        return false;
    }

    var cliente = {};
    
    if (fila != null)
    {
        var div = $(fila).parents('.content_listado_notificaciones');
        var id = $(div).find('.cliente_id').html();
        var codigo = $(div).find('.codigo_cliente').html();
        var nombre = $(div).find('.nombre_cliente_sb').html();
        var correo = $(div).find('.correo_clientes').html();
        var telefono = $(div).find('.telefonofijo_cliente_sb').html();
        var celular = $(div).find('.celular_cliente_sb').html();

        cliente.ClienteID = id;
        cliente.CodigoCliente = codigo;
        cliente.Nombre = nombre;
        cliente.eMail = correo;
        cliente.Telefono = telefono;
        cliente.Celular = celular;
    }

    var url = baseUrl + "Cliente/Detalle";
    $.ajax({
        type: 'GET',
        dataType: 'html',
        cache: false,
        url: url,
        data: cliente,
        success: function (data) {
            $("#divDetalleCliente").html(data);
            $('#divAgregarCliente').show();

            ClienteDetalleOK = function (cliente) {
                //alert(JSON.stringify(cliente));
                CargarListaCliente();
            };
        },
        error: function (xhr, ajaxOptions, error) {
            alert('Error: ' + xhr.status + " - " + xhr.responseText);
        }
    });
}

//function showDivAgregar() {
//    if (gTipoUsuario == '2') {
//        var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
//        $('#dialog_MensajePostulante #tituloContenido').text("LO SENTIMOS");
//        $('#dialog_MensajePostulante #mensajePostulante').text(mesg);
//        $('#dialog_MensajePostulante').show();
//        return false;
//    }

//    $('#divAgregarCliente').show();
//}

//function ShowDivEditar(obj) {
//    var div = $(obj).parents('.content_listado_notificaciones');
//    var id = $(div).find('.cliente_id').html();
//    var codigo = $(div).find('.codigo_cliente').html();
//    var nombre = $(div).find('.nombre_cliente_sb').html();
//    var correo = $(div).find('.correo_clientes').html();
//    var telefono = $(div).find('.telefonofijo_cliente_sb').html();
//    var celular = $(div).find('.celular_cliente_sb').html();

//    $('#divEditarCliente').find('#hdeClienteID').val(id);
//    $('#divEditarCliente').find('#Nombres2').val(nombre);
//    $('#divEditarCliente').find('#Correo2').val(correo);
//    $('#divEditarCliente').find('#Telefono2').val(telefono);
//    $('#divEditarCliente').find('#Celular2').val(celular);

//    $('#divEditarCliente').show();
//}

function ShowDivEliminar(id) {
    $('#divEliminarCliente').find('#hdeClienteID').val(id);
    $('#divEliminarCliente').show();
}

//function MantenerCliente(opt) {

//    var div = (opt == 1) ? $('#divAgregarCliente') : $('#divEditarCliente');
//    //var vMessage = "";
//    var vcont = 0;

//    if (opt == 1) {
        
//        if (jQuery.trim($(div).find('#Nombres').val()) == "") {
//            //vMessage += "- Debe ingresar el Nombre del Cliente.\n";
//            vcont++;
//            $('#divNotiNombre').show();
//        }

//        $("#divValidationSummary").html("");
//        if (jQuery.trim($(div).find('#Telefono').val()) == "" && jQuery.trim($(div).find('#Celular').val()) == "")
//        {
//            vcont++;
//            $("#divValidationSummary").html("* Debes Ingresar al menos un teléfono de contacto");
//        }

//        if (jQuery.trim($(div).find('#Correo').val()) != "") {
//            if (!validateEmail($(div).find('#Correo').val())) {
//                //vMessage += "- Debe ingresar un correo con la estructura válida.\n";
//                vcont++;
//                $('#divNotiCorreo').show();
//            }
//        }
//    }
//    else {
//        if (jQuery.trim($(div).find('#Nombres2').val()) == "") {
//            //vMessage += "- Debe ingresar el Nombre del Cliente.\n";
//            vcont++;
//            $('#divNotiNombre2').show();
//        }


//        $("#divValidationSummary2").html("");
//        if (jQuery.trim($(div).find('#Telefono2').val()) == "" && jQuery.trim($(div).find('#Celular2').val()) == "") {
//            vcont++;
//            $("#divValidationSummary2").html("* Debes Ingresar al menos un teléfono de contacto");
//        }

//        if (jQuery.trim($(div).find('#Correo2').val()) != "") {
//            if (!validateEmail($(div).find('#Correo2').val())) {
//                //vMessage += "- Debe ingresar un correo con la estructura válida.\n";
//                vcont++;
//                $('#divNotiCorreo2').show();
//            }
//        }
//    }

//    if (vcont > 0) {
//        return false;
//    }

//    var id = 0;
//    var nombre = "";
//    var correo = "";
//    var telefono = "";
//    var celular = "";

//    if (opt == 1) {
//        nombre = $(div).find('#Nombres').val();
//        correo = $(div).find('#Correo').val();
//        telefono = $(div).find('#Telefono').val();
//        celular = $(div).find('#Celular').val();
//    }

//    if (opt == 2) {
//        id = $(div).find('#hdeClienteID').val();
//        nombre = $(div).find('#Nombres2').val();
//        correo = $(div).find('#Correo2').val();
//        telefono = $(div).find('#Telefono2').val();
//        celular = $(div).find('#Celular2').val();
//    }

//    var item = {
//        ClienteID: id,
//        Nombre: nombre,
//        eMail: correo,
//        FlagValidate: opt,
//        Telefono: telefono,
//        Celular: celular
//    };

//    AbrirSplash();

//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'Cliente/Mantener',
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(item),
//        async: true,
//        success: function (data) {
//            if (checkTimeout(data)) {
//                if (data.success == true) {
//                    AbrirMensaje(data.message);
//                    CerrarSplash();

//                    $(div).hide();

//                    Limpiar();
//                    CargarListaCliente();

//                }
//                else {
//                    alert(data.message);
//                    CerrarSplash();
//                }
//            }
//        },
//        error: function (data, error) {
//            if (checkTimeout(data)) {
//                $(div).hide();
//                alert(data.message);
//            }
//        }
//    });
//}

function EliminarCliente() {
    var id = $('#divEliminarCliente').find('#hdeClienteID').val();

    AbrirSplash();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Cliente/Eliminar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ ClienteID: id }),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                Limpiar();

                CerrarSplash();

                if (data.success == true) {
                    AbrirMensaje(data.message);
                    $('#divEliminarCliente').hide();
                    CargarListaCliente();
                }
                else {
                    AbrirMensaje(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert("ERROR");
            }
        }
    });
}

function CerrarDiv(opt) {
    switch(opt) {
        //case 1:
        //    $('#divAgregarCliente').hide();
        //    break;
        //case 2:
        //    $('#divEditarCliente').hide();
        //    break;
        case 3:
            $('#divEliminarCliente').hide();
            break;
    }

    //if (opt == 1) {
    //    $('#divNotiNombre').hide();
    //    $('#divNotiCorreo').hide();
    //}
    //else {
    //    $('#divNotiNombre2').hide();
    //    $('#divNotiCorreo2').hide();
    //}

    Limpiar();
}

function Limpiar() {
    $('#hdeClienteID').val("0");
    //$('#Nombres').val("");
    //$('#Correo').val("");
    //$('#Telefono').val("");
    //$('#Celular').val("");
    //$('#divValidationSummary').html("");
}

function DownloadAttachExcelMC() {
    if (!checkTimeout()) {
        return false;
    }

    var content = baseUrl + "Cliente/ExportarExcelMisClientes";
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    iframe_.setAttribute("src", content);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
        iframe_.onreadystatechange = function () {
            switch (this.readyState) {
                case "loading":
                    waitingDialog({});
                    break;
                case "complete":
                case "interactive":
                case "uninitialized":
                    closeWaitingDialog();
                    break;
                default:
                    closeWaitingDialog();
                    break;
            }
        };
    }
    else {
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
}

function validarExportarMC()
{
    if ($('#divListaCliente .content_listado_notificaciones').length > 0) {
        DownloadAttachExcelMC();
    } else {
        AbrirMensaje("No hay datos para poder generar el archivo.");
        return false;
    }
}