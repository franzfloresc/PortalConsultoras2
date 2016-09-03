$(document).ready(function () {
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

    $('#txtClienteDescripcion').autocomplete({
        source: baseUrl + "PedidoFIC/AutocompleteByCliente",
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
    
    CrearDialogs();
    CargarDetallePedido();
    CargarAutocomplete();
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

    $('#divMensajeCUV').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 364,
        height: 158,
        draggable: true,
        title: "Importante"
    });

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

    $('#divObservacionesPROL').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
    });

    $('#divConfirmValidarPROL').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 550,
        draggable: true,
        close: function (event, ui) {
            $(this).dialog('close');
        }
    });

    $('#divReservaSatisfactoria').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
    });

    $('#divReservaSatisfactoria2').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
    });

    $('#divReservaSatisfactoria3').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true
    });

    $('#divReservaSatisfactoriaVE').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 550,
        height: 230,
        draggable: true,
    });

    $('#divReservaSatisfactoriaCO').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 550,
        height: 230,
        draggable: true,
    });

    $('#divVistaPrevia').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 350,
        draggable: false,
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        }
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
            var data = response.data;

            ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

            $("#pCantidadProductosPedido").html(data.TotalProductos);

            //Index
            $("#hdnRegistrosPaginar").val(data.Registros);
            $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
            $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
            $("#hdnPaginaPaginar").val(data.Pagina);
            $("#hdnPaginaDePaginar").val(data.PaginaDe);

            //ListadoPedido
            $("#hdnRegistros").val(data.Registros);
            $("#hdnRegistrosDe").val(data.RegistrosDe);
            $("#hdnRegistrosTotal").val(data.RegistrosTotal);
            $("#hdnPagina").val(data.Pagina);
            $("#hdnPaginaDe").val(data.PaginaDe);

            //Listado Cliente en la Vista ListadoPedido
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

            var html = ArmarDetallePedido(data.ListaDetalleModel);
            $('#tbobyDetallePedido').html(html);

            var htmlPaginador = ArmarDetallePedidoPaginador(data);
            $('#paginadorCab').html(htmlPaginador);
            $('#paginadorPie').html(htmlPaginador);

            $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
            $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

            MostrarInformacionCliente(clienteId);
            //if (tieneMicroefecto)
            //MostrarMicroEfecto();
            CargarAutocomplete();
        },
        error: function (error) {
            //alert(error);
        }
    });
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    closeWaitingDialog();
}

function ObservacionesProducto(item) {
    if (item.TieneStock == true) {
        if (item.TieneSugerido != 0) {
            $("#divObservaciones").html("");

            $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>Lo sentimos, este producto está agotado.</div></div>");
            //$("#divObservaciones").append("<div class='noti'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");

            $("#btnAgregar").attr("disabled", "disabled");
            ObtenerProductosSugeridos(item.CUV);
        } else {
            $("#divObservaciones").html("");
            if (item.EsExpoOferta == true) {
                _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Producto-expoferta']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Pedido/Mensajes/Producto-expoferta'
                });

                $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto de ExpoOferta.</div></div>");
                //$("#divObservaciones").append("<div class='noti'><div class='noti_message red_texto_size'>Producto de ExpoOferta.</div></div>");
            }
            if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
                _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Producto-revista']);
                dataLayer.push({
                    'event': 'pageview',
                    'virtualUrl': '/Pedido/Mensajes/Producto-revista'
                });
                if (isEsika) {
                    $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto en la Guía de Negocio Ésika con oferta especial.</div></div>");
                } else {
                    $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto en la revista Somos Belcorp con oferta especial.</div></div>");
                }
            }

            if (item.MensajeCUV != null) {
                if (item.MensajeCUV != "") {
                    //$("#divMensajeCUV").html(item.MensajeCUV);
                    //showDialog("divMensajeCUV");
                    alert_msg(item.MensajeCUV, "IMPORTANTE");
                }
            }

            $("#btnAgregar").removeAttr("disabled");
        }
    } else {
        _gaq.push(['_trackEvent', 'Pedido', 'Mensajes', 'Producto-agotado']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Pedido/Mensajes/Producto-agotado'
        });

        $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");
        //$("#divObservaciones").html("<div class='noti'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");
        $("#btnAgregar").attr("disabled", "disabled");
        IngresoFAD(item);

        if (item.TieneSugerido != 0)
            ObtenerProductosSugeridos(item.CUV);
    }

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

    if (item.FlagNueva == 1) {
        var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

        pedidosData.each(function (indice, valor) {
            if (valor.value == 1) {
                var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                    $('#hdnPagina').val(), ";",
                    $('#hdnClienteID2_').val());

                $("#OfertaTipoNuevo").val(OfertaTipoNuevo)
                return;
            }
        });
    }
    $("#divMensaje").text("");
    $("#txtCantidad").focus();
}

function ArmarDetallePedidoPaginador(data) {
    return SetHandlebars("#paginador-template", data);
}

function BuscarByCUV(CUV) {
    if (CUV != $('#hdfCUV').val()) {
        var item = {
            CUV: CUV
        };

        AbrirSplash();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'Pedido/FindByCUV',
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
                        location.href = baseUrl + "SesionExpirada.html";
                    } else {
                        alert_msg(data.message);
                    }
                }
            }
        });
    }
}

function ActualizarMontosPedido(formatoTotal, total, formatoTotalCliente) {
    if (formatoTotal != undefined) {
        //$("#sTotal").html(formatoTotal);
        //$("#spPedidoWebAcumulado").text(vbSimbolo + " " + formatoTotal);
    }

    if (total != undefined)
        $("#hdfTotal").val(total);

    if (formatoTotalCliente != undefined)
        $("#hdfTotalCliente").val(formatoTotalCliente);
}

function ValidarCUV() {
    if ($("#hdfCUV").val() != "" && $("#txtCUV").val() != "") {
        if ($("#txtCUV").val() != $("#hdfCUV").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        if ($("#txtCUV").val().length == 5) {
            //BuscarByCUV($("#txtCUV").val());
        } else {
            $("#txtCantidad").val("");
            $("#hdfCUV").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtDescripcionProd").val("");
            $("#btnAgregar").attr("disabled", "disabled");
            $("#divMensaje").text("");
            $("#txtPrecioR").val("");
            $("#hdfPrecioUnidad").val("");

            //if ($("#txtCUV").val().length == 0) {
            //    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Debe ingresar un CUV.</div></div>");
            //}
        }
    }
}

function CargarAutocomplete() {
    var array = $(".classClienteNombre");
    for (var i = 0; i < array.length; i++) {
        $('#' + array[i].id).focus(function () {
            //alert('No se puede');
            if (HorarioRestringido())
                this.blur();
        });
        $('#' + array[i].id).autocomplete({
            source: baseUrl + "Pedido/AutocompleteByClienteListado",
            minLength: 4,
            select: function (event, ui) {
                //
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
            //
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

function ArmarDetallePedido(array) {
    return SetHandlebars("#producto-template", array);
}

function MostrarInformacionCliente(clienteId) {
    $("#hdnClienteID_").val(clienteId);
    var nomCli = $("#ddlClientes option:selected").text();
    var simbolo = $("#hdfSimbolo").val();
    var monto = $("#hdfTotalCliente").val();

    $(".pMontoCliente").css("display", "none");

    //$(".caja_montos div.info_extra_Validado").css({ 'top': '0%', 'right': '99%' });

    if ($("#hdnClienteID_").val() != "-1") {
        $(".pMontoCliente").css("display", "block");
        //$(".caja_montos div.info_extra_Validado").css({ 'top': '31%', 'right': '53%' });
        $("#spnNombreCliente").html(nomCli + " :");
        $("#spnTotalCliente").html(simbolo + monto);
    }
}