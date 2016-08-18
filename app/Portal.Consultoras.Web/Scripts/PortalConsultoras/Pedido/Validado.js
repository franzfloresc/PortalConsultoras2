$(document).ready(function () {

    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        title: ":: Mensaje ::",
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    $('#divConfirmValidarPROL').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 550,
        draggable: true,
        title: "",
        close: function (event, ui) {
            $(this).dialog('close');
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

    CargarListado();

});

function MostrarMensaje(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}

function CerrarDialogo(dialog) {
    $('#' + dialog).dialog('close');
}

function ConfirmarModificar() {
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/PedidoValidadoDeshacerReserva?Tipo=PV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    _gaq.push(['_trackEvent', 'Pedido', 'Modificar-Pedido']);
                    dataLayer.push({
                        'event': 'pageview',
                        'virtualUrl': '/Pedido/Modificar-Pedido'
                    });
                    location.href = baseUrl + 'Pedido/Index';
                }
                else {
                    closeWaitingDialog();
                    alert(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
    return false;
}

function CargarProductoAgotados() {
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetProductoFaltante',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (response) {
            closeWaitingDialog();

            if (!checkTimeout(response)) {
                return false;
            }

            if (response.result) {
                $("#tblProductoSugerido").html('');
                var html = '<table>';
                html += '<tr>';
                html += '<th class="codigo_productoAgotado">Código</th>';
                html += '<th class="producto_productoAgotado">Producto</th>';
                html += '</tr>';

                var lista = response.data;

                $.each(lista, function (index, value) {
                    html += '<tr>';
                    html += '<td class="codigo_productoAgotado">' + value.CUV + '</td>';
                    html += '<td class="producto_productoAgotado">' + value.Descripcion + '</td>';
                    html += '</tr>';
                });

                html += '</table>';

                $("#tblProductoSugerido").html(html);
                $("#divProductoAgotado").show();
            } else {
                alert(response.data);
            }

            return true;
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
}

function Imprimir() {
    waitingDialog({});
    setTimeout(function () {
        var content = baseUrl + "Pedido/PedidoValidadoExportarPdf";

        var iframe_ = document.createElement("iframe");
        iframe_.style.display = "none";
        iframe_.setAttribute("src", content);

        if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {
            // Si es Internet Explorer
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
    }, 0);
}

function EnviarCorreo() {
    waitingDialog({});
    if (jQuery.trim(correoElectronico) == "") {
        alert("No tiene una cuenta de correo registrada");
        closeWaitingDialog();
        return false;
    }
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/PedidoValidadoEnviarCorreo',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ correo: jQuery.trim(correoElectronico) }),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    alert(data.message);
                }
                else
                    alert(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("ERROR al enviar correo.");
            }
        }
    });
    return false
}

function ModificarPedido() {
    if ($("#hdfModificacionPedidoProl").val() === "0")
        ConfirmarModificar();
    else
        showDialog("divConfirmValidarPROL");
    return false;
}


function CargarListado(page, rows) {

    $('#divListado').html('<div style="text-align: center;">Cargando Listado<br><img src="' + urlLoad + '" /></div>');

    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 10,
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/CargarDetallePedidoValidado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            
            if (response.success) {

                var data = response.data;
                console.log("CargarDetallePedidoValidado - OK")

                var html = ArmarListado(data.ListaDetalle);
                $('#divListado').html(html);

                var htmlPaginador = ArmarListadoPaginador(data);
                $('#paginadorCab').html(htmlPaginador);
                //$('#paginadorPie').html(htmlPaginador);

                $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                //$("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);
            }
        },
        error: function (error) {
            alert(error);
        }
    });
}

function ArmarListado(array) {
    return SetHandlebars("#producto-template", array);
}

function ArmarListadoPaginador(data) {
    return SetHandlebars("#paginador-template", data);
}


function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    CargarListado(rpt.page, rpt.rows);
    return true;
}