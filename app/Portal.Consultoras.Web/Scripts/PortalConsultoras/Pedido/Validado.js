$(document).ready(function () {
    history.pushState(null, null, document.location.href);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.location.href);
    });

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

    $('.ValidaNumeralPedido').live('keyup', function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });
    $('.ValidaNumeralPedido').live('keypress', function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });
    $('#producto-faltante-busqueda-cuv, #producto-faltante-busqueda-descripcion').on('keypress', function (e) {
        if (e.which == 13) CargarProductoAgotados(0);
    });

    $('#ddlCategoriaProductoAgotado, #ddlCatalogoRevistaProductoAgotado').on('change', function (e) {
        CargarProductoAgotados(0);
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
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Ecommerce',
                        'action': 'Modificar Pedido',
                        'label': '(not available)'
                    });
                    location.href = baseUrl + 'Pedido/Index';
                }
                else {
                    closeWaitingDialog();
                    messageInfoError(data.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
    return false;
}

function CerrarProductoAgotados() {
    $('#divProductoAgotado').hide();
    $('#producto-faltante-busqueda-cuv').val('');
    $('#producto-faltante-busqueda-descripcion').val('');
}

function CargarProductoAgotados(identificador ) {

    var filtro = identificador == undefined ? 0 : identificador;

    if (filtro == 1)
        CargarFiltrosProductoAgotados();


    var data = {
        cuv             : $('#producto-faltante-busqueda-cuv').val(),
        descripcion     : $('#producto-faltante-busqueda-descripcion').val(),
        categoria       : $('#ddlCategoriaProductoAgotado').val() == null ? "" : $('#ddlCategoriaProductoAgotado').val(),
        revista         : $('#ddlCatalogoRevistaProductoAgotado').val() == "" ? "" : $("#ddlCatalogoRevistaProductoAgotado option:selected").text() 
    }

    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetProductoFaltante',
        dataType: 'json',
        data: data,
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) return false;
            closeWaitingDialog();
            if (response.result) {
                SetHandlebars("#productos-faltantes-template", response.data, '#tblProductosFaltantes');

                if (response.data.Detalle.length == 0)
                    $("#tblProductosFaltantes table").find("#tfoot").removeClass("hidden");
                else
                    $("#tblProductosFaltantes table").find("#tfoot").addClass("hidden"); 

                $("#divProductoAgotado").show();
            }
            else alert_msg(response.data);
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
}

function CargarFiltrosProductoAgotados() {
    $("#ddlCategoriaProductoAgotado").find('option').remove();
    $("#ddlCatalogoRevistaProductoAgotado").find('option').remove();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetFiltrosProductoFaltante',
        dataType: 'json',
        data: {},
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) return false;
            if (response.result) {
                $("#ddlCategoriaProductoAgotado").CreateSelected(response.data, "CodigoCategoria", "DescripcionCategoria");
                $("#ddlCatalogoRevistaProductoAgotado").CreateSelected(response.data1, "CodigoCatalogo", "Descripcion");
            }
            else alert(response.data);
        },
        error: function (data, error) { AjaxError(data); }
    });
}

$.fn.CreateSelected = function (array, val, text, etiqueta, index) {
    var obj = this.selector;
    try {
        $(obj).find('option').remove();
        if (index === undefined || index == false) {
            if (etiqueta === undefined)
                $(obj).append('<option value="" selected="selected"> -- Seleccione --</option>');
            else
                $(obj).append('<option value="0" selected="selected"> -- ' + etiqueta + ' --</option>');
        }

        $.each(array, function (i, item) {
            var objtemp = item;
            $(obj).append('<option value="' + item[val] + '">' + item[text] + '</option>');
        });
    } catch (e) {
        toastr.error(e.message.toString(), Basetitle);
    }

};

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
        alert_msg("No tiene una cuenta de correo registrada");
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
                alert_msg(data.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert("ERROR al enviar correo.");
            }
        }
    });
    return false;
}

function ModificarPedido() {
    if ($("#hdfModificacionPedidoProl").val() === "0")
        ConfirmarModificar();
    else
        showDialog("divConfirmValidarPROL");
    return false;
}


function CargarListado(page, rows) {

    $('#divListado').html('<div style="text-align: center; margin-top:20px; margin-bottom:17px;">Cargando Listado<br><img src="' + urlLoad + '" /></div>');

    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 20,
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/CargarDetallePedidoValidado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {

                    var data = response.data;

                    var html = ArmarListado(data.ListaDetalleFormato);
                    $('#divListadoPedido').html(html);

                    var htmlPaginador = ArmarListadoPaginador(data);
                    $('#paginadorCab').html(htmlPaginador);

                    $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 20);

                    MostrarBarra(response);
                }
            }
        },
        error: function (data, error) { }
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

function MostrarDetalleGanancia() {
    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').show();
}