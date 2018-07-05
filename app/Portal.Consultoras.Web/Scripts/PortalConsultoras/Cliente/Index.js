$(document).ready(function () {

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
    $('#divListaCliente').html('<div style="text-align: center;">Cargando Lista de Clientes<br><img src="' + urlLoad + '" /></div>');

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
        error: function (data, error) { }
    });
}

function ArmarListaCliente(array) {
    return SetHandlebars("#cliente-template", array);
}

function ArmarListaClientePaginador(data) {
    return SetHandlebars("#paginador-template", data);
}

var ClienteDetalleOK = null;
function showClienteDetalle(fila) {
    if (gTipoUsuario == '2') {
        var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
        $('#dialog_MensajePostulante #tituloContenido').text("LO SENTIMOS");
        $('#dialog_MensajePostulante #mensajePostulante').text(mesg);
        $('#dialog_MensajePostulante').show();
        return false;
    }

    var cliente = {};
    if (fila != null) {
        var div = $(fila).parents('.content_listado_notificaciones');

        cliente.ClienteID = $(div).find('.cliente_id').html();
        cliente.CodigoCliente = $(div).find('.codigo_cliente').html();
        cliente.NombreCliente = $(div).find('.nombre_cliente_sb').html();
        cliente.Nombre = cliente.NombreCliente;
        cliente.eMail = $(div).find('.correo_clientes').html();
        cliente.Telefono = $(div).find('.telefonofijo_cliente_sb').html();
        cliente.Celular = $(div).find('.celular_cliente_sb').html();
    }

    $.ajax({
        type: 'GET',
        dataType: 'html',
        cache: false,
        url: baseUrl + "Cliente/Detalle",
        data: cliente,
        success: function (data) {
            CerrarSplash();

            $("#divDetalleCliente").html(data);
            $('#divAgregarCliente').show();

            ClienteDetalleOK = function (cliente) {
                CargarListaCliente();
            };
        },
        error: function (xhr, ajaxOptions, error) {
            CerrarSplash();
        }
    });
}

function ShowDivEliminar(id) {
    $('#divEliminarCliente').find('#hdeClienteID').val(id);
    $('#divEliminarCliente').show();
}

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
    switch (opt) {
        case 3:
            $('#divEliminarCliente').hide();
            break;
    }

    Limpiar();
}

function Limpiar() {
    $('#hdeClienteID').val("0");
}

function DownloadAttachExcelMC() {
    if (!checkTimeout()) {
        return false;
    }

    var content = baseUrl + "Cliente/ExportarExcelMisClientes";
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    iframe_.setAttribute("src", content);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {
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

function validarExportarMC() {
    if ($('#divListaCliente .content_listado_notificaciones').length > 0) {
        DownloadAttachExcelMC();
    } else {
        AbrirMensaje("No hay datos para poder generar el archivo.");
        return false;
    }
}