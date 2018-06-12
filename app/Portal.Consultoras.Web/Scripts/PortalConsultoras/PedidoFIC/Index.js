var tieneMicroefecto = false;
var animacion = true;
$(document).ready(function () {
    $('#txtClienteDescripcion').autocomplete({
        source: baseUrl + "Pedido/AutocompleteByCliente",
        minLength: 4,
        select: function (event, ui) {
            ui.item.ClienteID = ui.item.ClienteID || 0;
            if (ui.item.ClienteID == 0) {
                return false;
            }

            if (ui.item.ClienteID != -1) {
                $("#hdfClienteID").val(ui.item.ClienteID);
                $("#hdnClienteID_").val(ui.item.ClienteID);
                $("#txtClienteDescripcion").val(ui.item.Nombre);
                $("#hdfClienteDescripcion").val(ui.item.Nombre);
            } else {
                $('#Nombres').val($("#txtClienteDescripcion").val());
                $("#divClientes").show();
            }
            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.Nombre + "</a>")
            .appendTo(ul);
    };
    $('#txtDescripcionProd').keyup(function (evt) {
        $("#divObservaciones").html("");
    });
    $('#txtDescripcionProd').autocomplete({
        source: baseUrl + "PedidoFIC/AutocompleteByProductoDescripcion",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.CUV == "0") {
                return false;
            }

            $("#txtDescripcionProd").val(ui.item.Descripcion);
            $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
            $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
            $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
            ObservacionesProducto(ui.item);

            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.Descripcion + "</a>")
            .appendTo(ul);
    };
    $("#txtCUV").keyup(function (evt) {
        $("#txtCantidad").val("");
        $("#hdfDescripcionProd").val("");
        $("#txtDescripcionProd").val("");
        $("#btnAgregar").attr("disabled", "disabled");
        $("#divMensaje").text("");
        $("#txtPrecioR").val("");
        $("#hdfPrecioUnidad").val("");

        if ($(this).val().length == 5) {
            BuscarByCUV($(this).val());
        } else {
            $("#hdfCUV").val("");

            $("#divObservaciones").html("");
        }
    });
    $('#txtCUV').autocomplete({
        source: baseUrl + "PedidoFIC/AutocompleteByProductoCUV",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.MarcaID != 0) {
                $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
                $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
                $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
                $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
                ObservacionesProducto(ui.item);
            }
            event.preventDefault();
            return false;
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.CUV + "</a>")
            .appendTo(ul);
    };

    $(".ValidaAlfanumerico").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return true;
        } else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ' ]/;
            return re.test(keyChar);
        }
    });
    $("body").on("mouseleave", ".cantidad_detalle_focus", function () {
        var idPed = $(this).find("input.liquidacion_rango_cantidad_pedido").attr('data-pedido');
        var cant = $('#txtLPCant' + idPed).val();
        var cantAnti = $('#txtLPTempCant' + idPed).val();
        if (cant == cantAnti) {
            return false;
        }
        $(this).find("input.liquidacion_rango_cantidad_pedido").focus();
        $(this).find("input.liquidacion_rango_cantidad_pedido").select();
        $('#txtCUV').focus();
    });

    $('#frmInsertPedido').on('submit', function () {
        if (!$(this).valid()) {
            AbrirMensaje("Argumentos no validos");
            return false;
        }
        if (HorarioRestringido()) return false;

        AbrirSplash();
        var form = FuncionesGenerales.GetDataForm(this);
        InsertarProducto(form);
        $("#btnAgregar").removeAttr("disabled");
        return false;
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

    $('#btnValidarPROL').click(function () {
        if ($('#tbobyDetallePedido>div').length > 0 && indicadorOfertaFIC) showDialog('divOfertaFIC');
        else AbrirMensaje("Su pedido ha sido guardado correctamente.");
    });
    $('#btnAgregarOferfaFIC').click(function () {
        GuardarOfertaFICenPedido();
        $('#divOfertaFIC').dialog('close');
    });
    $('#btnCancelarOferfaFIC').click(function () {
        $('#divOfertaFIC').dialog('close');
    });

    CrearDialogs();
    CargarDetallePedido();
    CargarAutocomplete();
});

function CrearDialogs() {
    $('#divConfirmEliminarTotal').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
        title: "",
        close: function (event, ui) {
            $(this).dialog('close');
        }
    });

    $('#divOfertaFIC').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 'auto',
        height: 'auto',
        draggable: true
    });
}

function CargarDetallePedido(page, rows) {
    $(".pMontoCliente").css("display", "none");
    $('#tbobyDetallePedido').html('<div><div style="width:100%;"><div style="text-align: center;"><br>Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></div></div>');

    var clienteId = $("#ddlClientes").val() || -1;
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 10,
        clienteId: clienteId
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'PedidoFIC/CargarDetallePedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                var data = response.data;
                ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

                $("#hdnRegistrosPaginar").val(data.Registros);
                $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
                $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
                $("#hdnPaginaPaginar").val(data.Pagina);
                $("#hdnPaginaDePaginar").val(data.PaginaDe);

                $("#hdnRegistros").val(data.Registros);
                $("#hdnRegistrosDe").val(data.RegistrosDe);
                $("#hdnRegistrosTotal").val(data.RegistrosTotal);
                $("#hdnPagina").val(data.Pagina);
                $("#hdnPaginaDe").val(data.PaginaDe);

                var htmlCliente = "";

                $("#ddlClientes").empty();

                $.each(data.ListaCliente, function (index, value) {
                    if (value.ClienteID == -1) {
                        htmlCliente += '<option value="-1">Cliente</option>';
                    } else {
                        htmlCliente += '<option value="' + value.ClienteID + '">' + value.Nombre + '</option>';
                    }
                });

                $("#ddlClientes").append(htmlCliente);
                $("#ddlClientes").val(clienteId);

                data.ListaDetalleModel = data.ListaDetalleModel || new Array();
                $.each(data.ListaDetalleModel, function (ind, item) {
                    item.EstadoSimplificacionCuv = data.EstadoSimplificacionCuv;
                });

                var html = ArmarDetallePedido(data.ListaDetalleModel);
                $('#tbobyDetallePedido').html(html);

                var htmlPaginador = ArmarDetallePedidoPaginador(data);
                $('#paginadorCab').html(htmlPaginador);
                $('#paginadorPie').html(htmlPaginador);

                $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

                MostrarInformacionCliente(clienteId);
                CargarAutocomplete();
            }
        },
        error: function (data, error) { }
    });
}

function MostrarInformacionCliente(clienteId) {
    $("#hdnClienteID_").val(clienteId);
    var nomCli = $("#ddlClientes option:selected").text();
    var monto = $("#hdfTotalCliente").val();

    $(".pMontoCliente").css("display", "none");
    if ($("#hdnClienteID_").val() != "-1") {
        $(".pMontoCliente").css("display", "block");
        $("#spnNombreCliente").html(nomCli + " :");
        $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
    }
}

function InsertarProducto(form) {
    $.ajax({
        url: form.url,
        type: form.type,
        data: form.data,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success == true) {
                    $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);
                    tieneMicroefecto = true;
                    CargarDetallePedido();
                } else {
                    alert(response.message);
                }

                PedidoOnSuccess();

                CerrarSplash();
            }
        },
        error: function (response, x, xh, xhr) { }
    });
}

function MostrarMicroEfecto() {
    if (animacion) {
        animacion = false;
        var obj = $("#frmInsertPedido");
        var button = $("#btnAgregar", obj);
        var efecto = '<div class="btn_animado"><img src="' + urlImagenMicroEfecto + '" alt="" /></div>';
        var trFirst = $("#tbobyDetallePedido tr:first-child");

        $("body").prepend(efecto);

        $(".btn_animado").css({
            'top': button.offset().top,
            'left': button.offset().left
        }).show().animate({
            'top': trFirst.offset().top,
            'left': trFirst.offset().left + (trFirst.width() / 2),
            'opacity': 0
        }, 1500, 'swing', function () {
            $(this).remove();

            trFirst.addClass("no_mostrar");

            $(".no_mostrar").fadeIn();

            trFirst.removeClass("no_mostrar");
            animacion = true;
            tieneMicroefecto = false;
        });
    }
}

function ActualizarMontosPedido(formatoTotal, total, formatoTotalCliente) {
    if (formatoTotal != undefined) $("#sTotal").html(formatoTotal);
    if (total != undefined) $("#hdfTotal").val(total);
    if (formatoTotalCliente != undefined) $("#hdfTotalCliente").val(formatoTotalCliente);
}

function ArmarDetallePedidoPaginador(data) {
    return SetHandlebars("#paginador-template", data);
}

function ArmarDetallePedido(array) {
    return SetHandlebars("#producto-template", array);
}

function AgregarProductoListado() {
    $("#btnAgregar").attr("disabled", "disabled");
    $('form#frmInsertPedido').submit();
    return false;
}



function ValidarCUV() {
    if ($("#hdfCUV").val() != "" && $("#txtCUV").val() != "") {
        if ($("#txtCUV").val() != $("#hdfCUV").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        if ($("#txtCUV").val().length !== 5) {
            $("#txtCantidad").val("");
            $("#hdfCUV").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtDescripcionProd").val("");
            $("#btnAgregar").attr("disabled", "disabled");
            $("#divMensaje").text("");
            $("#txtPrecioR").val("");
            $("#hdfPrecioUnidad").val("");
        }

    }
}

function ValidarDescripcion() {
    if ($("#hdfDescripcionProd").val() != "" && $("#txtDescripcionProd").val() != "") {
        if ($("#txtDescripcionProd").val() != $("#hdfDescripcionProd").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        $("#txtCantidad").val("");
        $("#hdfCUV").val("");
        $("#txtCUV").val("");
        $("#hdfDescripcionProd").val("");
        $("#btnAgregar").attr("disabled", "disabled");
        $("#divMensaje").text("");
    }
}

function PreValidarCUV(event) {
    event = event || window.event;

    if (event.keyCode == 13) {
        if ($("#btnAgregar")[0].disabled == false) {
            AgregarProductoListado();
        }
    }
}

function ValidarCliente() {
    if ($("#hdfClienteDescripcion").val() != "" && $("#txtClienteDescripcion").val() != "") {
        if ($("#txtClienteDescripcion").val() != $("#hdfClienteDescripcion").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un cliente válido.");
        }
    } else {
        $("#hdfClienteDescripcion").val("");
        $("#hdfClienteID").val("0");
        $("#divMensaje").text("");
    }
}

function ValidarClienteFocus(event) {
    event = event || window.event;

    if (event.keyCode == 9) {
        if ($("#btnAgregar")[0].disabled == true) {
            if (event.preventDefault)
                event.preventDefault();
            else
                event.returnValue = false;
            $("#txtCUV").focus();
        }
    }
}

function Tabular(event) {
    event = event || window.event;

    if (event.keyCode == 9) {
        if (event.preventDefault)
            event.preventDefault();
        else
            event.returnValue = false;
        $("#txtCUV").focus();
    }
}

function SeleccionarContenido(control) {
    control.select();
}



function AbrirModalCliente() {
    $('#divClientes #Nombres').val($('#txtClienteDescripcion').val());
    $('#divClientes #Correo').val();
    $("#divClientes").show();
}

function ValidarRegistroCliente() {
    var vMessage = "";

    if (jQuery.trim($('#Nombres').val()) == "") {
        vMessage += "- Debe ingresar el Nombre del Cliente.\n";
    }

    if (jQuery.trim($('#Correo').val()) != "") {
        if (!validateEmail($('#Correo').val())) {
            vMessage += "- Debe ingresar un correo con la estructura válida.\n";
        }
    }

    if (vMessage != "") {
        AbrirMensaje(vMessage);
        $('#Nombres').focus();
        return false;
    }

    GuardarCliente();
}

function GuardarCliente() {
    var item = {
        Nombre: $('#Nombres').val(),
        eMail: $('#Correo').val()
    };
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/RegistrarCliente',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $("#hdfClienteID").val(data.extra);
                    $("#txtClienteDescripcion").val($('#Nombres').val());
                    $("#hdfClienteDescripcion").val($('#Nombres').val());
                    $('#Nombres').val("");
                    $('#Correo').val("");
                    $("#divClientes").hide();
                }
                AbrirMensaje(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $("#divClientes").hide();
            }
        }
    });
}




function PedidoOnSuccess() {
    $("#divObservaciones").html("");
    $("#hdnDescripcionEstrategia").val("");
    $("#hdnDescripcionLarga").val("");
    $("#hdnDescripcionProd").val("");

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#txtCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtPrecioR").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val($("#hdfClienteDescripcion").val());
    $("#btnAgregar").attr("disabled", "disabled");

    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#ddlClientes").val($("#hdnClienteID2_").val());
    $("#hdnClienteID_").val($("#hdnClienteID2_").val());

    CalcularTotal();
    $("#txtCUV").focus();
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    closeWaitingDialog();
}

function BuscarByCUV(CUV) {
    if (CUV != $('#hdfCUV').val()) {
        var item = {
            CUV: CUV
        };

        AbrirSplash();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'PedidoFIC/FindByCUV',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            cache: false,
            success: function (data) {
                CerrarSplash();
                if (!checkTimeout(data)) {
                    return false;
                }

                $("#divObservaciones").html("");

                if (data[0].MarcaID != 0) {
                    $("#hdTipoOfertaSisID").val(data[0].TipoOfertaSisID);
                    $("#hdConfiguracionOfertaID").val(data[0].ConfiguracionOfertaID);
                    ObservacionesProducto(data[0]);
                    if (data[0].ObservacionCUV != null && data[0].ObservacionCUV != "") {
                        $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>" + data[0].ObservacionCUV + "</div></div>");
                    }
                } else {
                    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>" + data[0].CUV + "</div></div>");

                    if (data[0].TieneSugerido != 0)
                        ObtenerProductosSugeridos(CUV);
                }
            },
            error: function (data, error) {
                CerrarSplash();
                if (checkTimeout(data)) {
                    if (data.message == "" || data.message === undefined) {
                        location.href = baseUrl + "Login/SesionExpirada";
                    }
                }
            }
        });
    }
}

function CambiarCliente(elem) {
    var rows = $($('[data-paginacion="rows"]')[0]).val() || 10;
    CargarDetallePedido(1, rows);
}

function ObservacionesProducto(item) {
    $("#btnAgregar").removeAttr("disabled");

    $("#txtCUV").val(item.CUV);
    $("#hdfCUV").val(item.CUV);
    $("#hdfDescripcionCategoria").val(item.DescripcionCategoria);
    $("#hdfDescripcionEstrategia").val(item.DescripcionEstrategia);
    $("#hdfDescripcionMarca").val(item.DescripcionMarca);
    $("#hdfIndicadorMontoMinimo").val(item.IndicadorMontoMinimo);
    $("#hdfMarcaID").val(item.MarcaID);
    $("#txtCantidad").val("1");
    $("#hdfPrecioUnidad").val(item.PrecioCatalogo);

    $("#txtPrecioR").val(DecimalToStringFormat(item.PrecioCatalogo));

    $("#txtDescripcionProd").val(item.Descripcion.split('|')[0]);
    $("#hdfDescripcionProd").val(item.Descripcion.split('|')[0]);
    $("#hdFlagNueva").val(item.FlagNueva);
    $("#hdTipoEstrategiaID").val(item.TipoEstrategiaID);
    $("#OfertaTipoNuevo").val("");

    $("#divMensaje").text("");
    $("#txtCantidad").focus();
}


function HorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var horarioRestringido = false;
    $.ajaxSetup({
        cache: false
    });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/EnHorarioRestringido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (mostrarAlerta == true)
                        AbrirMensaje(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) { }
    });
    return horarioRestringido;
}

function CargarAutocomplete() {
    var array = $(".classClienteNombre");
    for (var i = 0; i < array.length; i++) {
        $('#' + array[i].id).focus(function () {
            if (HorarioRestringido())
                this.blur();
        });
        $('#' + array[i].id).autocomplete({
            source: baseUrl + "Pedido/AutocompleteByClienteListado",
            minLength: 4,
            select: function (event, ui) {
                if (ui.item.ClienteID != 0) {
                    $(this).val(ui.item.Nombre);
                    var hdf = this.id.replace('txtLPCli', 'hdfLPCli');
                    var hdfDes = this.id.replace('txtLPCli', 'hdfLPCliDes');
                    $('#' + hdf).val(ui.item.ClienteID);
                    $('#' + hdfDes).val(ui.item.Nombre);
                }

                isShown = false;
                event.preventDefault();
                return false;
            }
        }).data("autocomplete")._renderItem = function (ul, item) {
            ul.mouseover(function () {
                isShown = true;
            }).mouseout(function () {
                isShown = false;
            });
            return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a>" + item.Nombre + "</a>")
                .appendTo(ul);
        };
    }
}

function CalcularTotal() {
    $('#sSimbolo').html($('#hdfSimbolo').val());
    $('#sSimbolo_minimo').html($('#hdfSimbolo').val());
    $("#divListadoPedido").find('a[class="imgIndicadorCUV"]').tooltip({
        content: "<img src='" + baseUrl + "Content/Images/aviso.png" + "' />",
        position: { my: "left bottom", at: "left top-20%", collision: "flipfit" }
    });
    CargarResumenCampaniaHeader();
}

function DeletePedido(campaniaId, pedidoId, pedidoDetalleId, tipoOfertaSisId, cuv, cantidad, clienteId, cuvReco) {
    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        TipoOfertaSisID: tipoOfertaSisId,
        CUV: cuv,
        Cantidad: cantidad,
        ClienteID_: clienteId,
        CUVReco: cuvReco
    };

    AbrirSplash();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'PedidoFic/Delete',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    CargarDetallePedido();
                    CerrarSplash();
                } else {
                    CerrarSplash();
                    alert(response.message);
                }
            }

            window.OfertaDelDia.CargarODDEscritorio();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarSplash();
            }
        }
    });
}

function CargandoProductos() {
    $('#tbobyDetallePedido').html('<tr><td colspan="7"><div style="text-align: center;">Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></td></tr>');
}

function MostrarEliminarPedidoTotal() {
    var total = parseFloat($('#sTotal').html());
    if (total != 0) {
        showDialog("divConfirmEliminarTotal");
    }
}
function EliminarPedidoTotalSi() {
    EliminarPedidoTotalNo();
    EliminarPedido();
}
function EliminarPedidoTotalNo() {
    $('#divConfirmEliminarTotal').dialog('close');
}

function EliminarPedido() {
    AbrirSplash();
    if (HorarioRestringido()) {
        CerrarSplash();
        return;
    }

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'PedidoFIC/DeleteAll',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({}),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                location.href = baseUrl + 'PedidoFIC/Index';
                CerrarSplash();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarSplash();
            }
        }
    });
}

function ValidarUpdate(PedidoDetalleID, FlagValidacion) {
    var CliDes = $('#txtLPCli' + PedidoDetalleID).val();
    var CliDesVal = $('#hdfLPCliDes' + PedidoDetalleID).val();
    var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
    var CantidadAnti = $('#txtLPTempCant' + PedidoDetalleID).val();
    var ClienteAnti = $('#hdfLPTempCliDes' + PedidoDetalleID).val();
  

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad)
            return false;
    } else {
        if (ClienteAnti == CliDes)
            return false;
    }

    if (Cantidad.length == 0) {
        AbrirMensaje('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        AbrirMensaje('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (CliDes.length != 0 && CliDes != CliDesVal) {
        AbrirMensaje('Por favor ingrese un cliente válido.');
        return false;
    }

    return true;
}

function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {
    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion);
    if (!val) return false;

    var CliID = $('#hdfLPCli' + PedidoDetalleID).val();
    var CliDes = $('#txtLPCli' + PedidoDetalleID).val();
    var Cantidad = $('#txtLPCant' + PedidoDetalleID).val();
    var DesProd = $('#lblLPDesProd' + PedidoDetalleID).html();
    var ClienteID_ = $('#ddlClientes').val();

    var PrecioUnidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    if (CliDes.length == 0) {
        CliID = 0;
    }

    var Unidad = $('#hdfLPPrecioU' + PedidoDetalleID).val();
    var Total = parseFloat(Cantidad * Unidad).toFixed(2)
    $('#lblLPImpTotal' + PedidoDetalleID).html(DecimalToStringFormat(Total));
    $('#lblLPImpTotalMinimo' + PedidoDetalleID).html(Total);
    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        ClienteDescripcion: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: ClienteID_
    };

    AbrirSplash();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'PedidoFIC/Update',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) return false;
            if (data.success != true) return false;

            if ($('#txtLPCli' + PedidoDetalleID).val().length == 0) {
                $('#hdfLPCliDes' + PedidoDetalleID).val($('#hdfNomConsultora').val());
                $('#txtLPCli' + PedidoDetalleID).val($('#hdfNomConsultora').val());
            }
            $('#txtLPTempCant' + PedidoDetalleID).val($('#txtLPCant' + PedidoDetalleID).val());

            var nomCli = $("#ddlClientes option:selected").text();
            var monto = data.TotalCliente;

            $(".pMontoCliente").css("display", "none");
            if (data.ClienteID_ != "-1") {
                $(".pMontoCliente").css("display", "block");
                $("#spnNombreCliente").html(nomCli + " :");
                $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
            }
            ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);
        },
        error: function (data, error) {
            CerrarSplash();
        }
    });
}

function UpdateLiquidacion(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi) {

    AbrirSplash();
    if (HorarioRestringido()) {
        CerrarSplash();
        return false;
    }

    var cant = $('#txtLPCant' + PedidoDetalleID).val();
    var cantAnti = $('#txtLPTempCant' + PedidoDetalleID).val();

    if (cant == cantAnti) {
        CerrarSplash();
        return false;
    }

    if (cant == "" || cant == "0") {
        AbrirMensaje("Ingrese una cantidad mayor que cero.");
        $('#txtLPCant' + PedidoDetalleID).val("1");
        CerrarSplash();
        return false;
    }

    if (isNaN(cant)) {
        CerrarSplash();
        return false;
    }

    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
}

function BlurF(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {
    if (isShown) return true;

    var cliAnt = $("#hdfLPCliIni" + PedidoDetalleID).val();
    var cliNue = $("#hdfLPCli" + PedidoDetalleID).val();
    if (cliAnt == cliNue) {
        $("#txtLPCli" + PedidoDetalleID).val($("#hdfLPCliDes" + PedidoDetalleID).val());
        return true;
    }

    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
}

function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    CargarDetallePedido(rpt.page, rpt.rows);
    return true;
}

function AjaxError(data) {
    CerrarSplash();
    if (checkTimeout(data)) {
        AbrirMensaje(data.message);
    }
}

function GuardarOfertaFICenPedido() {
    waitingDialog();
    $.ajax({
        type: "POST",
        url: baseUrl + "PedidoFIC/Insertar",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();

                if (data.success == true) {
                    AbrirMensaje(data.message);
                }
                else
                    AbrirMensaje(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                AbrirMensaje("Ocurrió un error inesperado al momento de registrar los datos. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
}
