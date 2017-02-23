$(document).ready(function () {
    //if (checkTimeout()) {
    //    fnGrilla();
    //    IniDialog();
    //}

    $(".input-correo").keypress(
        function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                return false;
            }
            else {
                var keyChar = String.fromCharCode(charCode);
                var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
                $('#divNotiCorreo').hide();
                $('#divNotiCorreo2').hide();
                return re.test(keyChar);

            }
        });

    //$(".ui-pg-input").keypress(
    //function (evt) {
    //    var charCode = (evt.which) ? evt.which : window.event.keyCode;
    //    if (charCode <= 13) {
    //        return false;
    //    }
    //    else {
    //        var keyChar = String.fromCharCode(charCode);
    //        var re = /[0-9]/;
    //        return re.test(keyChar);
    //    }
    //});

    $(".input-nombre").keypress(
        function (evt) {
            var charCode = (evt.which) ? evt.which : window.event.keyCode;
            if (charCode <= 13) {
                return false;
            }
            else {
                var keyChar = String.fromCharCode(charCode);
                var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ _.\/-]/;
                $('#divNotiNombre').hide();
                $('#divNotiNombre2').hide();
                return re.test(keyChar);
            }
        });

    //$("#txtBusqueda").keypress(
    //function (evt) {
    //    var charCode = (evt.which) ? evt.which : window.event.keyCode;
    //    if (charCode <= 13) {
    //        return false;
    //    }
    //    else {
    //        var keyChar = String.fromCharCode(charCode);
    //        var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ _.\/-]/;
    //        return re.test(keyChar);
    //    }
    //});

    //$("#btnBuscar").click(function () {
    //    if (checkTimeout()) {
    //        fnGrilla();
    //        $("#txtBusqueda").focus();
    //    }
    //});

    $("#txtBusqueda").keypress(function (e) {
        if (e.which == 13) {
            if (checkTimeout()) {
                CargarListaCliente();
                //$("#txtBusqueda").focus();
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

function alert_msg(message, titulo) {
    titulo = titulo || "MENSAJE";
    $('#DialogMensajes .terminos_title_2').html(titulo);
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
    CerrarSplash();
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
                //var data = response.data;

                //ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

                //$("#pCantidadProductosPedido").html(data.TotalProductos);

                //Index
                /*
                $("#hdnRegistrosPaginar").val(data.Registros);
                $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
                $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
                $("#hdnPaginaPaginar").val(data.Pagina);
                $("#hdnPaginaDePaginar").val(data.PaginaDe);
                */

                //ListadoPedido
                /*
                $("#hdnRegistros").val(data.Registros);
                $("#hdnRegistrosDe").val(data.RegistrosDe);
                $("#hdnRegistrosTotal").val(data.RegistrosTotal);
                $("#hdnPagina").val(data.Pagina);
                $("#hdnPaginaDe").val(data.PaginaDe);
                */

                //Listado Cliente en la Vista ListadoPedido
                //var htmlCliente = "";

                //$("#ddlClientes").empty();

                /*
                $.each(data.ListaCliente, function (index, value) {
                    if (value.ClienteID == -1) {
                        htmlCliente += '<option value="-1">Cliente</option>';
                    } else {
                        htmlCliente += '<option value="' + value.ClienteID + '">' + value.Nombre + '</option>';
                    }
                });
                */

                /*
                $("#ddlClientes").append(htmlCliente);
                $("#ddlClientes").val(clienteId);
                */

                var html = ArmarListaCliente(data.rows);
                $('#divListaCliente').html(html);

                var htmlPaginador = ArmarListaClientePaginador(data);
                $('#paginadorCab').html(htmlPaginador);
                $('#paginadorPie').html(htmlPaginador);

                $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

                //MostrarInformacionCliente(clienteId);

                //if (tieneMicroefecto)
                //MostrarMicroEfecto();
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

function showDivAgregar() {
    $('#divAgregarCliente').show();
}

function ShowDivEditar(obj) {
    var div = $(obj).parents('.content_listado_notificaciones');
    var id = $(div).find('.cliente_id').html();
    var nombre = $(div).find('.nombre_cliente_sb').html();
    var correo = $(div).find('.correo_clientes').html();

    $('#divEditarCliente').find('#hdeClienteID').val(id);
    $('#divEditarCliente').find('#Nombres2').val(nombre);
    $('#divEditarCliente').find('#Correo2').val(correo);

    $('#divEditarCliente').show();
}

function ShowDivEliminar(id) {

    $('#divEliminarCliente').find('#hdeClienteID').val(id);

    $('#divEliminarCliente').show();
}

function MantenerCliente(opt) {

    debugger;

    var div = (opt == 1) ? $('#divAgregarCliente') : $('#divEditarCliente');
    //var vMessage = "";
    var vcont = 0;

    if (opt == 1) {
        
        if (jQuery.trim($(div).find('#Nombres').val()) == "") {
            //vMessage += "- Debe ingresar el Nombre del Cliente.\n";
            vcont++;
            $('#divNotiNombre').show();
        }

        if (jQuery.trim($(div).find('#Correo').val()) != "") {
            if (!validateEmail($(div).find('#Correo').val())) {
                //vMessage += "- Debe ingresar un correo con la estructura válida.\n";
                vcont++;
                $('#divNotiCorreo').show();
            }
        }
    }
    else {
        if (jQuery.trim($(div).find('#Nombres2').val()) == "") {
            //vMessage += "- Debe ingresar el Nombre del Cliente.\n";
            vcont++;
            $('#divNotiNombre2').show();
        }

        if (jQuery.trim($(div).find('#Correo2').val()) != "") {
            if (!validateEmail($(div).find('#Correo2').val())) {
                //vMessage += "- Debe ingresar un correo con la estructura válida.\n";
                vcont++;
                $('#divNotiCorreo2').show();
            }
        }
    }

    if (vcont > 0) {

        //$(div).find('#divValidationSummary').html(vMessage);
       // $(div).find('#divValidationSummary').show()
        
        //alert_msg(vMessage);

        //$('#Nombres').focus();
        return false;
    }

    var id = 0;
    var nombre = "";
    var correo = "";

    if (opt == 1) {
        nombre = $(div).find('#Nombres').val();
        correo = $(div).find('#Correo').val();
    }

    if (opt == 2) {
        id = $(div).find('#hdeClienteID').val();
        nombre = $(div).find('#Nombres2').val();
        correo = $(div).find('#Correo2').val();
    }

    //alert('OK');
    //return;

    //if ($('#hdNombreAnt').val().toUpperCase() == jQuery('#Nombres').val().toUpperCase())
    //    $("#hdFlag").val("0");
    //else
    //    $("#hdFlag").val("1");

    var item = {
        ClienteID: id,
        Nombre: nombre,
        eMail: correo,
        FlagValidate: opt
    };

    //debugger;

    AbrirSplash();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Cliente/Mantener',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            //debugger;
            // valida si ha habido un timeout
            if (checkTimeout(data)) {
                // si no ha habido timeout continua el procesamiento normal
                if (data.success == true) {
                    //if (jQuery('#hdClienteId').val() == "0") {
                    //}
                    //else {
                    //}

                    //var item = data.items;
                    //alert(data.message);
                    alert_msg(data.message);
                    //HideDialog("DialogClientes");
                    CerrarSplash();

                    $(div).hide();

                    Limpiar();
                    CargarListaCliente();
                    // jQuery("#list").setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');

                    ///*2505 DCG*/
                    //dataLayer.push({
                    //    'event': 'virtualEvent',
                    //    'category': 'Clientes',
                    //    'action': 'Agregar',
                    //    'label': 'Satisfactorio',
                    //});

                }
                else {
                    alert(data.message);
                    CerrarSplash();
                }
            }
        },
        error: function (data, error) {
            //debugger;
            // valida si ha habido un timeout
            if (checkTimeout(data)) {
  
                $(div).hide();
                
                // si no ha habido timeout continua el procesamiento normal
                alert(data.message);
                //HideDialog("DialogClientes");
            }
        }
    });
}

function EliminarCliente() {

    //var elimina = confirm('¿ Está seguro que desea eliminar el registro seleccionado?');
    //if (!elimina)
    //    return false;
    //waitingDialog({});

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
                //closeWaitingDialog();
                Limpiar();

                CerrarSplash();

                if (data.success == true) {
                    //alert(data.message);
                    alert_msg(data.message);

                    $('#divEliminarCliente').hide();

                    CargarListaCliente();
                    //jQuery("#list").setGridParam({ datatype: 'json', page: 1 }).trigger('reloadGrid');
                }
                else {
                    //alert(data.message);
                    alert_msg(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //closeWaitingDialog();
                alert("ERROR");
            }
        }
    });
}

function CerrarDiv(opt) {
    switch(opt) {
        case 1:
            $('#divAgregarCliente').hide();
            break;
        case 2:
            $('#divEditarCliente').hide();
            break;
        case 3:
            $('#divEliminarCliente').hide();
            break;
    }

    if (opt == 1) {
        $('#divNotiNombre').hide();
        $('#divNotiCorreo').hide();
    }
    else {
        $('#divNotiNombre2').hide();
        $('#divNotiCorreo2').hide();
    }

    Limpiar();
}

function Limpiar() {
    $('#hdeClienteID').val("0");
    $('#Nombres').val("");
    $('#Correo').val("");
    $('#divValidationSummary').html("");
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
        alert_msg("No hay datos para poder generar el archivo.");
        return false;
    }
}