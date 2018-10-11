var tipoOfertaFinal_Log = "";
var gap_Log = 0;
var tipoOrigen = '2';

$(document).ready(function () {
    $('body').on('click', ".icono_kitNuevas a", function (e) {
        var mostrar = $(this).next();
        if (mostrar.css("display") == "none") mostrar.fadeIn(200);
        else mostrar.fadeOut(200);
    });

    ValidarKitNuevas();

    $("#suma, #resta").click(function (event) {
        if (!ValidarPermiso(this)) {
            event.preventDefault();
            return false;
        }
        var cambio = $(this).attr("id") == "suma" ? +1 : -1;
        var numactual = $("#txtCantidad").val();
        numactual = Number(numactual) + cambio;
        numactual = numactual < 1 ? 1 : numactual > 99 ? 99 : numactual;
        $("#txtCantidad").val(numactual);
    });


});

function MensajeGuardar() {
    messageInfoBueno('Tu pedido fue guardado con éxito.');
}

function ValidarKitNuevas() {
    jQuery.ajax({
        type: 'POST',
        url: urlValidarKitNuevas,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (!data.success) messageInfo('Ocurrió un error de conexion al intentar cargar el pedido. Por favor inténtelo mas tarde.');
            else CargarPedido(true);
        },
        error: function (error) {
            messageInfo('Ocurrió un error de conexion al intentar cargar el pedido. Por favor inténtelo mas tarde.');
        }
    });
}

function CargarPedido(firstLoad) {
    
    var obj = {
        sidx: "",
        sord: "",
        page: 1,
        rows: -1,
        clienteId: -1,
        mobil: true
    };
    ShowLoading();

    jQuery.ajax({
        type: 'POST',
        url: urlDetallePedido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            SetHandlebars("#template-Detalle", data.data, '#divProductosDetalle');

            if ($('#divContenidoDetalle').find(".icono_advertencia_notificacion").length > 0) {
                $("#iconoAdvertenciaNotificacion").show();
            }

            $(".tooltip_noOlvidesGuardarTuPedido").show();
            $(".btn_guardarPedido").show();
            $("footer").hide();

            cuponModule.actualizarContenedorCupon();

            if (firstLoad && autoReservar) { EjecutarPROL(); }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
            }
        }
    }).always(function () {
        CloseLoading();
    });
}

function GetProductoEntidad(id) {
    return {
        CampaniaID: $("#CampaniaID_" + id).val(),
        PedidoID: $("#PedidoID_" + id).val(),
        PedidoDetalleID: id,
        TipoOfertaSisID: $("#TipoOfertaSisID_" + id).val(),
        CUV: $("#CUV_" + id).val(),
        FlagValidacion: "1",
        CantidadInicial: $("#CantidadTemporal_" + id).val(),
        DescripcionProd: $("#DescripcionProd_" + id).val(),
        PrecioUnidad: $("#PrecioUnidad_" + id).val(),
        MarcaID: $("#MarcaID_" + id).val(),
        DescripcionOferta: $("#DescripcionOferta_" + id).val(),
        EsBackOrder: $("#EsBackOrder_" + id).val()
    };
}

function UpdateLiquidacionEvento(evento) {

    var obj0 = $(evento.currentTarget);
    var id = $.trim(obj0.attr("data-pedidodetalleid")) || "0";
    if (isNaN(id) || parseInt(id, 10) <= 0) {
        return false;
    }

    var obj = GetProductoEntidad(id);


    UpdateLiquidacionSegunTipoOfertaSis(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.FlagValidacion, obj.CantidadInicial, obj.EsBackOrder, obj.PrecioUnidad);

}

function UpdateLiquidacionSegunTipoOfertaSis(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder, PrecioUnidad) {


    var urls = new Object();
    if (TipoOfertaSisID == ofertaLiquidacion) {
        urls.urlValidarUnidadesPermitidas = urlValidarUnidadesPermitidasPedidoProducto;
        urls.urlObtenerStockActual = urlObtenerStockActualProducto;
    }
    else if (TipoOfertaSisID == ofertaShowRoom) {
        urls.urlValidarUnidadesPermitidas = urlValidarUnidadesPermitidasPedidoProductoShowRoom;
        urls.urlObtenerStockActual = urlObtenerStockActualProductoShowRoom;
    }
    else if (TipoOfertaSisID == ofertaAccesorizate) {
        urls.urlValidarUnidadesPermitidas = urlValidarUnidadesPermitidasPedidoProducto2;
        urls.urlObtenerStockActual = urlObtenerStockActualProducto2;
    }

    urls.urlValidarUnidadesPermitidas = $.trim(urls.urlValidarUnidadesPermitidas);
    if (urls.urlValidarUnidadesPermitidas != "") {
        UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder, PrecioUnidad);
    }
    else {

        var Cantidad = $('#Cantidad_' + PedidoDetalleID).val() || "";
        var cantidadAnterior = $('#CantidadTemporal_' + PedidoDetalleID).val();

        if (Cantidad.length == 0 || isNaN(Cantidad)) {
            messageInfoMalo('Por favor ingrese una cantidad válida.');
            $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
            return false;
        }

        if (parseInt(Cantidad) <= 0) {
            messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
            $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
            return false;
        }

        var CantidadSoli = Cantidad;
        if (TipoOfertaSisID) {
            CantidadSoli = (Cantidad - cantidadAnterior);
        }

        var param = ({
            CUV: CUV,
            PrecioUnidad: PrecioUnidad,
            Cantidad: CantidadSoli,
            TipoOferta: TipoOfertaSisID || 0,
            enRangoProgNuevas: false
        });
        ShowLoading();

        jQuery.ajax({
            type: 'POST',
            url: urlValidarStockEstrategia,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(param),
            async: true,
            success: function (datos) {
                if (checkTimeout(datos)) {
                    CloseLoading();
                    if (!datos.result) {
                        messageInfoMalo(datos.message);
                        CargarPedido();
                        return false;
                    }
                    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, EsBackOrder);
                    if (datos.message.length > 3)
                        messageInfoMalo(datos.message);
                }
            },
            error: function (data, error) {
                CloseLoading();
            }
        });
    }
}

function UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder, PrecioUnidad) {
    
    var valCant = $.trim($('#Cantidad_' + PedidoDetalleID).val());
    var valTemp = $.trim($('#CantidadTemporal_' + PedidoDetalleID).val());

    if (valCant === "" || valTemp === "" || isNaN(cantVal) || isNaN(valTemp)) 
        return false;

    var cantidadActual = parseInt(valCant);
    var cantidadAnterior = parseInt(valTemp);

    if (cantidadActual == cantidadAnterior)
        return false;

    if ($.trim(cantidadActual).length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
        return false;
    }

    if (cantidadActual <= 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
        return false;
    }

    ShowLoading();
    
    $.ajaxSetup({ cache: false });

    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();
    var Flag = 2;
    var StockNuevo = cantidadActual - cantidadAnterior;
    var PROL = falgValidacionPedido;
    
    if (CliDes.length == 0)
        CliID = 0;

    $.getJSON(urls.urlValidarUnidadesPermitidas, { CUV: CUV, Cantidad: StockNuevo, PrecioUnidad: PrecioUnidad }, function (data) {
        if (data.message.length > 0) {
            CloseLoading();
            messageInfoMalo(data.message);
            CargarPedido();
            if (!data.result)
                return false;
        }

        var Saldo = data.Saldo;
        var UnidadesPermitidas = data.UnidadesPermitidas;
        var CantidadPedida = data.CantidadPedida || 0;
        var Cantidad = cantidadActual + parseInt(CantidadPedida);

        if (parseInt(data.UnidadesPermitidas) < Cantidad) {
            if (PROL == "1") {
                UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV, EsBackOrder);
                $('#Cantidad_' + PedidoDetalleID).val(CantidadModi);
            } else
                $('#Cantidad_' + PedidoDetalleID).val($('#CantidadTemporal_' + PedidoDetalleID).val());

            if (Saldo == UnidadesPermitidas)
                messageInfoMalo("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto " + CUV + ".");
            else {
                if (Saldo == "0")
                    messageInfoMalo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto (" + CUV + ") a su pedido, verifique.");
                else
                    messageInfoMalo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto (" + CUV + ") a su pedido, verifique.");
            }

            CloseLoading();
            return false;
        }

        $.getJSON(urls.urlObtenerStockActual, { CUV: CUV }, function (data) {
            var CantidadActual = $('#Cantidad_' + PedidoDetalleID).val();
            var CantidadaValidar = CantidadActual - cantidadAnterior;
            if (parseInt(data.Stock) < CantidadaValidar) {
                if (PROL == "1") {
                    UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV, EsBackOrder);
                    $('#Cantidad_' + PedidoDetalleID).val(CantidadModi);
                } else
                    $('#Cantidad_' + PedidoDetalleID).val($('#CantidadTemporal_' + PedidoDetalleID).val());

                messageInfoMalo("Lamentablemente, no puede actualizar la cantidad del Producto (" + CUV + "), ya que sobrepasa el stock actual (" + data.Stock + "), verifique.");

                CloseLoading();
                return false;
            }


            var PrecioUnidad = $('#PrecioUnidad_' + PedidoDetalleID).val();
            var Unidad = $('#Cantidad_' + PedidoDetalleID).val();
            var Total = DecimalToStringFormat(parseFloat(cantidadActual * Unidad));
            $('#ImporteTotal_' + PedidoDetalleID).html(Total);

            var item = {
                CampaniaID: CampaniaID,
                PedidoID: PedidoID,
                PedidoDetalleID: PedidoDetalleID,
                ClienteID: CliID,
                Cantidad: cantidadActual,
                PrecioUnidad: PrecioUnidad,
                ClienteDescripcion: CliDes,
                DescripcionProd: DesProd,
                Stock: StockNuevo,
                Flag: Flag,
                TipoOfertaSisID: TipoOfertaSisID,
                CUV: CUV,
                ClienteID_: "-1",
                EsBackOrder: EsBackOrder
            };

            PedidoUpdate(item, PROL);
        });
    });

}

function UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV, EsBackOrder) {
    
    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var Cantidad = $('#Cantidad_' + PedidoDetalleID).val() == "" ? 0 : $('#Cantidad_' + PedidoDetalleID).val();
    var CantidadAnti = $('#CantidadTemporal_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad)
            return false;
    }

    if (Cantidad.length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (CliDes.length == 0) {
        CliID = 0;
    }

    var Cantidad_ = CantidadModi;
    var PrecioUnidad = $('#PrecioUnidad_' + PedidoDetalleID).val();
    var Total = DecimalToStringFormat(parseFloat(Cantidad_ * PrecioUnidad));
    $('#ImporteTotal_' + PedidoDetalleID).html(Total);
    $('#ImporteTotalMinimo_' + PedidoDetalleID).html(Total);

    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        ClienteDescripcion: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: "-1",
        CUV: CUV,
        EsBackOrder: EsBackOrder
    };
    PedidoUpdate(item);
}

function EliminarPedidoEvento(evento, esBackOrder) {
    
    var obj0 = $(evento.currentTarget);
    var id = $.trim(obj0.attr("data-pedidodetalleid")) || "0";
    if (isNaN(id) || parseInt(id, 10) <= 0) {
        return false;
    }

    var obj = GetProductoEntidad(id);

    EliminarPedido(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.CantidadInicial, obj.DescripcionProd, obj.PrecioUnidad, obj.MarcaID, obj.DescripcionOferta, esBackOrder);
}

function EliminarPedido(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, Cantidad, DescripcionProd, PrecioUnidad, MarcaID, DescripcionOferta, esBackOrder) {
    
    $("#popup-eliminar-item").show();

    fnEliminarProducto = function () {
        var param = ({
            CampaniaID: CampaniaID,
            PedidoID: PedidoID,
            PedidoDetalleID: PedidoDetalleID,
            TipoOfertaSisID: TipoOfertaSisID,
            CUV: CUV,
            Cantidad: Cantidad,
            Pagina: 0,
            PaginaDe: 0,
            Registros: 0,
            RegistrosDe: 0,
            RegostrosTotal: 0,
            ClienteID: "-1",
            CUVReco: "",
            EsBackOrder: esBackOrder == 'true'
        });

        ShowLoading();
        jQuery.ajax({
            type: 'POST',
            url: urlPedidoDelete,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(param),
            async: true,
            success: function (data) {
                CloseLoading();
                if (!checkTimeout(data)) return false;

                if (data.success != true) {
                    messageInfoError(data.message);
                    return false;
                }

                ActualizarGanancia(data.DataBarra);
                CargarPedido();
               
                TrackingJetloreRemove(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                dataLayer.push({
                    'event': 'removeFromCart',
                    'ecommerce': {
                        'remove': {
                            'products': [{
                                'name': data.data.DescripcionProducto,
                                'id': data.data.CUV,
                                'price': data.data.Precio,
                                'brand': data.data.DescripcionMarca,
                                'category': 'NO DISPONIBLE',
                                'variant': data.data.DescripcionOferta,
                                'quantity': Number(Cantidad)
                            }]
                        }
                    }
                });
                cuponModule.actualizarContenedorCupon();
                messageDelete('El producto fue Eliminado.');

                ActualizarLocalStorageAgregado("rd", data.data.CUV, false);
                ActualizarLocalStorageAgregado("gn", data.data.CUV, false);
                ActualizarLocalStorageAgregado("hv", data.data.CUV, false);
                ActualizarLocalStorageAgregado("lan", data.data.CUV, false);
            },
            error: function (data, error) {
                CloseLoading();
            }
        });
    };
}

function ConfirmaEliminarPedido() {
    $("#popup-eliminar-item").hide();    
        fnEliminarProducto();
}

function AceptarBackOrder(campaniaId, pedidoId, pedidoDetalleId, clienteId) {
    if (ReservadoOEnHorarioRestringido(true)) {
        return false;
    }

    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        ClienteID_: clienteId
    };

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlPedidoAceptarBackOrder,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            ShowLoading();
            if (!checkTimeout(data)) return false;
            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            ShowLoading();
            ActualizarGanancia(data.DataBarra);
            CargarPedido();
            CloseLoading();
        },
        error: function (data, error) {
            CloseLoading();
        }
    });
}

function messageDelete(message) {
    $('#mensajeInformacionEliminar').html(message);
    $("#popup-eliminar-mensaje").modal("show");
    setTimeout(function () {
        $("#popup-eliminar-mensaje").modal("hide");
    }, 2000);
}

function PedidoDetalleEliminarTodoConfirmar() {    
    var total = parseFloat($('#sTotal').html());
    if (total != 0) {
        $("#divConfirmEliminarTotal").show();
    }
}

function EliminarPedidoTotalNo() {
    $('#divConfirmEliminarTotal').hide();
}

function EliminarPedidoTotalSi() {    
    EliminarPedidoTotalNo();
    PedidoDetalleEliminarTodo();
}

function PedidoDetalleEliminarTodo() {
        
    ShowLoading();
    if (HorarioRestringido()) {
        CloseLoading();
        return false;
    }

    var listaDetallePedido = new Array();
    var campania = $("#hdCampaniaCodigo").val();

    $.each($("#divContenidoDetalle .contenedor_items_pedido"), function (index, value) {
        var cuv = $(value).find(".cod_prod").html();
        var cantidad = $(value).find(".ValidaNumeral").val();

        var detalle = {
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        };

        listaDetallePedido.push(detalle);
    });    
    var item = {};
    jQuery.ajax({
        type: 'POST',
        url: urlPedidoDeleteAll,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }

            if (data.success != true) {
                messageInfoError(data.message);
                CloseLoading();
                return false;
            }
            
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ingresa tu pedido',
                'action': 'Eliminar pedido completo',
                'label': '(not available)'
            });
            messageDelete("Se eliminaron todos productos del pedido.");

            ActualizarLocalStorageAgregado("rd", "todo", false);
            ActualizarLocalStorageAgregado("gn", "todo", false);
            ActualizarLocalStorageAgregado("hv", "todo", false);
            ActualizarLocalStorageAgregado("lan", "todo", false);

            location.reload();

            CloseLoading();
        },
        error: function (data, error) {
            CloseLoading();
        }
    });
}

function HorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;

    var horarioRestringido = false;
    jQuery.ajax({
        type: 'GET',
        url: urlHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success == true) {
                    if (mostrarAlerta == true)
                        window.messageInfo(response.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (response, error) { }
    });
    return horarioRestringido;
}
function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, EsBackOrder) {

    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var Cantidad_ = $('#Cantidad_' + PedidoDetalleID).val();
    var CantidadAnti = $('#CantidadTemporal_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();

    if (Cantidad_.length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad_ == 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad_)
            return false;
    } else {
        if (ClienteAnti == CliDes)
            return false;
    }

    if (CliDes.length == 0) {
        CliID = 0;
    }

    var PrecioUnidad = $('#PrecioUnidad_' + PedidoDetalleID).val();
    var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
    var Total = DecimalToStringFormat(parseFloat(Cantidad * PrecioUnidad));
    $('#ImporteTotal_' + PedidoDetalleID).html(Total);
    $('#ImporteTotalMinimo_' + PedidoDetalleID).html(Total);

    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        Nombre: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: "-1",
        CUV: CUV,
        EsBackOrder: EsBackOrder
    };

    PedidoUpdate(item);
}

function PedidoUpdate(item, PROL) {
        
    var Cantidad = $('#Cantidad_' + item.PedidoDetalleID).val();
    var CantidadAnti = $('#CantidadTemporal_' + item.PedidoDetalleID).val();

    ShowLoading();
    PROL = PROL || "0";
    jQuery.ajax({
        type: 'POST',
        url: urlPedidoUpdate,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CloseLoading();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }

            ActualizarGanancia(data.DataBarra);

            if (PROL == "0") $('#CantidadTemporal_' + item.PedidoDetalleID).val($('#Cantidad_' + item.PedidoDetalleID).val());
            CargarPedido();

            if (data.modificoBackOrder) {
                messageInfo('Recuerda que debes volver a validar tu pedido.');
            }

            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
                TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), item.CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), item.CUV);

        },
        error: function (data, error) {
            CloseLoading();
        }
    });
}

function GetDescripcionMarca(marcaId) {
    var result = "";

    switch (marcaId) {
        case 1:
            result = "Lbel";
            break;
        case 2:
            result = "Esika";
            break;
        case 3:
            result = "Cyzone";
            break;
        case 4:
            result = "S&M";
            break;
        case 5:
            result = "Home Collection";
            break;
        case 6:
            result = "Finart";
            break;
        case 7:
            result = "Generico";
            break;
        case 8:
            result = "Glance";
            break;
        default:
            result = "NO DISPONIBLE";
            break;
    }

    return result;
}

function TagManagerClickEliminarProducto(descripcionProd, cuv, precioUnidad, descripcionMarca, descripcionOferta, cantidad) {
    var variant = "Estándar";
    if (descripcionOferta != "") {
        descripcionOferta = descripcionOferta.replace('[', '').replace(']', '');
        variant = $.trim(descripcionOferta);
    }

    dataLayer.push({
        'event': 'removeFromCart',
        'ecommerce': {
            'remove': {
                'products': [{
                    'name': descripcionProd,
                    'id': cuv,
                    'price': precioUnidad.toString(),
                    'brand': descripcionMarca,
                    'category': 'NO DISPONIBLE',
                    'variant': variant,
                    'quantity': cantidad
                }]
            }
        }
    });
}

function SeparadorMiles(pnumero) {
   
    var resultado = "";
    var numero = pnumero.replace(/\,/g, '');
    var nuevoNumero = numero.replace(/\./g, '');

    if (numero[0] == "-") nuevoNumero = nuevoNumero.substring(1);

    if (numero.indexOf(",") >= 0) nuevoNumero = nuevoNumero.substring(0, nuevoNumero.indexOf(","));

    for (var  i = nuevoNumero.length - 1, j = 0; i >= 0; i--, j++)
        resultado = nuevoNumero.charAt(i) + ((j > 0) && (j % 3 == 0) ? "." : "") + resultado;

    if (numero.indexOf(",") >= 0) resultado += numero.substring(numero.indexOf(","));

    if (numero[0] == "-") return "-" + resultado;
    return resultado;
}

function EjecutarPROL(cuvOfertaProl) {
    
    AbrirMensaje("Su pedido ha sido guardado correctamente.");
}

function EjecutarServicioPROL() {
    ShowLoading();    
    AbrirMensaje("Su pedido ha sido guardado correctamente.");

}

function EjecutarServicioPROLSinOfertaFinal() {
    
    AbrirMensaje("Su pedido ha sido guardado correctamente.");
}

function RespuestaEjecutarServicioPROL(response, inicio) {
    var tipoMensaje;
    inicio = inicio == null || inicio == undefined ? true : inicio;
    var model = response.data;

    var montoEscala = model.MontoEscala;
    var montoPedido = model.Total - model.MontoDescuento;

    if (!model.ValidacionInteractiva) {
        messageInfoMalo('<h3 class="">' + model.MensajeValidacionInteractiva + '</h3>');
        return false;
    }

    $("hdfModificaPedido").val(model.EsModificacion == true ? "1" : "0");
    
    ConstruirObservacionesPROL(model);
    
    $('#btnGuardarPedido').text(model.Prol);
    var tooltips = model.ProlTooltip.split('|');
    $('.tooltip_noOlvidesGuardarTuPedido')[0].children[0].innerHTML = tooltips[0];
    $('.tooltip_noOlvidesGuardarTuPedido')[0].children[1].innerHTML = tooltips[1];

    var codigoMensajeProl = "";
    var cumpleOferta = { resultado: false };

    if (inicio) {
        codigoMensajeProl = response.data.CodigoMensajeProl;
    }

    if (model.Reserva != true) {
        if (inicio) {
            tipoMensaje = codigoMensajeProl == "00" ? 1 : 2;
            cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, tipoMensaje, codigoMensajeProl, response.data.ListaObservacionesProl);
        }
        if (!cumpleOferta.resultado) {
            $('#modal-prol-botonesAceptarCancelar').hide();
            $('#modal-prol-botoneAceptar').show();
            $('#popup-observaciones-prol').show();
            AnalyticsGuardarValidar(response);
        }

        CargarPedido();
        return true;
    }

    if (model.ZonaValida == true) {

        if (model.ObservacionInformativa == false) {
            if (inicio) cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);

            if (!cumpleOferta.resultado) {
                messageInfoBueno('<h3>Tu pedido fue reservado con éxito.</h3>');
                if (estaRechazado == "2") cerrarMensajeEstadoPedido();

                AnalyticsGuardarValidar(response);
                AnalyticsPedidoValidado(response);
                setTimeout(function () {
                    ShowLoading();
                    document.location = urlPedidoValidado;
                }, 2000);
            }
            return true;
        }

        if (inicio) {
            tipoMensaje = codigoMensajeProl == "00" ? 1 : 2;
            cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, tipoMensaje, codigoMensajeProl, response.data.ListaObservacionesProl);
        }

        if (!cumpleOferta.resultado) {
            $('#modal-prol-botonesAceptarCancelar').show();
            $('#modal-prol-botoneAceptar').hide();
            $('#popup-observaciones-prol').show();
        }
        AnalyticsGuardarValidar(response);
        CargarPedido();
        return true;
    }
    if (inicio) {
        cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
    }

    if (!cumpleOferta.resultado) {
        messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
        AnalyticsGuardarValidar(response);
    }

    CargarPedido();
    return true;
}

function ConstruirObservacionesPROL(model) {    
    var mensajePedido = "";
    if (model.ErrorProl) {
        mensajePedido = model.ListaObservacionesProl[0].Descripcion;
        $("#modal-prol-titulo").html(model.AvisoProl ? "AVISO" : "ERROR");
        $("#modal-prol-contenido").html(mensajePedido);
        return mensajePedido;
    }

    if (!model.ObservacionRestrictiva && !model.ObservacionInformativa) {
        $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').removeClass("icono_alerta exclamacion_icono_mobile");
        $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').addClass("icono_alerta check_icono_mobile");
        $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html("¡LO <b>LOGRASTE</b>!");
        mensajePedido += "Tu pedido fue guardado con éxito.";
        $("#modal-prol-titulo").html(mensajePedido);
        $("#modal-prol-contenido").html("Tu pedido fue guardado con éxito. Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.");
        mensajePedido += " Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.";
        return "-1 " + mensajePedido;
    }

    if (model.EsDiaProl) $("#modal-prol-titulo").html("IMPORTANTE");
    else $("#modal-prol-titulo").html("AVISO");

    var htmlObservacionesPROL = "<ul style='padding-left: 15px; list-style-type: none; text-align: center;'>";
    if (model.ListaObservacionesProl.length == 0) {
        htmlObservacionesPROL += "<li>Tu pedido tiene observaciones, por favor revísalo.</li>";
        mensajePedido += "-1" + " " + "Tu pedido tiene observaciones, por favor revísalo." + " ";
    }
    else {
        $.each(model.ListaObservacionesProl, function (index, item) {
            if (model.CodigoIso == "BO" || model.CodigoIso == "MX") {
                if (item.Caso == 6 || item.Caso == 8 || item.Caso == 9 || item.Caso == 10) {
                    item.Caso = 105;
                }
            }

            if (item.Caso == 95 || item.Caso == 105) {
                htmlObservacionesPROL += "<li>" + item.Descripcion + "</li>";
                mensajePedido += item.Caso + " " + item.Descripcion + " ";
                return false;
            }
            else {
                if (menuNotificaciones == 0 && item.Caso == 0 && model.ObservacionInformativa) {
                    htmlObservacionesPROL += "<li>" + item.Descripcion + "</li>";
                    mensajePedido += item.Caso + " " + item.Descripcion + " ";
                } else {
                    htmlObservacionesPROL += "<li>Tu pedido tiene observaciones, por favor revísalo.</li>";
                    mensajePedido += "-1" + " " + "Tu pedido tiene observaciones, por favor revísalo." + " ";
                    return false;
                }
            }
        });
    }
    htmlObservacionesPROL += "</ul>";

    $("#modal-prol-contenido").html(htmlObservacionesPROL);

    return mensajePedido;
}

function AceptarObsInformativas() {
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlInsertarDesglose,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            CloseLoading();
            if (!checkTimeout(data)) return;

            if (data.success) location.href = urlPedidoValidado;
            else messageInfoMalo(data.message);
        },
        error: function (data, error) {
            CloseLoading();
            if (!checkTimeout(data)) return;

            messageInfoMalo("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
        }
    });
}

function CancelarObsInformativas() {
    if ($('#hdfModificaPedido').val() != 1) {
        ShowLoading();
        jQuery.ajax({
            type: 'POST',
            url: urlDeshacerReservaPedidoReservado + '?Tipo=PI',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true,
            success: function (data) {
                CloseLoading();
                if (checkTimeout(data)) {
                    if (data.success == true) {
                        $('#popup-observaciones-prol').hide();
                    } else {
                        messageInfoMalo(data.message);
                    }
                }
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data))
                    messageInfoMalo("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        });
    } else {
        $('#popup-observaciones-prol').hide();
    }
}

function AnalyticsGuardarValidar(data) {
    var arrayEstrategiasAnalytics = [];
    var accion = $('#hdAccionBotonProl').val();

    $.each(data.pedidoDetalle, function (index, value) {
        var estrategia = {
            'name': value.name,
            'id': value.id,
            'price': value.price.toString(),
            'brand': value.brand,
            'category': 'NO DISPONIBLE',
            'variant': value.variant == "" ? "Estándar" : value.variant,
            'quantity': value.quantity
        };
        arrayEstrategiasAnalytics.push(estrategia);
    });

    dataLayer.push({
        'event': 'productCheckout',
        'action': accion == 'guardar' ? 'Guardar' : 'Validar',
        'label': data.mensajeAnalytics,
        'ecommerce': {
            'checkout': {
                'actionField': {
                    'step': accion == 'guardar' ? 1 : 2,
                    'option': data.mensajeAnalytics
                },
                'products': arrayEstrategiasAnalytics
            }
        }
    });
}
function AnalyticsPedidoValidado(data) {
    var arrayEstrategiasAnalytics = [];

    $.each(data.pedidoDetalle, function (index, value) {
        var estrategia = {
            'name': value.name,
            'id': value.id,
            'price': value.price.toString(),
            'brand': value.brand,
            'category': 'NO DISPONIBLE',
            'variant': value.variant == "" ? "Estándar" : value.variant,
            'quantity': value.quantity
        };
        arrayEstrategiasAnalytics.push(estrategia);
    });

    dataLayer.push({
        'event': 'productCheckout',
        'action': 'Validado',
        'ecommerce': {
            'checkout': {
                'actionField': { 'step': 3 },
                'products': arrayEstrategiasAnalytics
            }
        }
    });
}

function MostrarDetalleGanancia() {

    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').show();
}

function InsertarProducto(model, asyncX) {
    alert("seguimiento Alan, copiar el caso para hacer seguimiento de donde se llama a este metodo");
    var retorno = new Object();

    jQuery.ajax({
        type: 'POST',
        url: urlPedidoInsert,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: asyncX == undefined || asyncX == null ? true : asyncX,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }

            if (data.success != true) {
                messageInfoError(data.message);
                CloseLoading();
                return false;
            }

            CloseLoading();

            setTimeout(function () {}, 2000);

            ActualizarGanancia(data.DataBarra);

            TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
            dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                    'add': {
                        'actionField': { 'list': 'Estándar' },
                        'products': [{
                            'name': data.data.DescripcionProd,
                            'price': String(data.data.PrecioUnidad),
                            'brand': data.data.DescripcionLarga,
                            'id': data.data.CUV,
                            'category': 'NO DISPONIBLE',
                            'variant': data.data.DescripcionOferta,
                            'quantity': Number(model.Cantidad),
                            'position': 1
                        }]
                    }
                }
            });

            CargarPedido();

            retorno = data;
        },
        error: function (data, error) {
            CloseLoading();
        }
    });

    return retorno;
}

function ValidarPermiso(obj) {
    var permiso = $(obj).attr("disabled") || "";
    if (permiso != "") {
        return false;
    }
    return true;
}

