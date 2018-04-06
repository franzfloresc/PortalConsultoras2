﻿var tipoOfertaFinal_Log = "";
var gap_Log = 0;
var tipoOrigen = '2';

var esPedidoValidado = false;

var belcorp = belcorp || {}
belcorp.mobile = belcorp.mobile || {}
belcorp.mobile.pedido = belcorp.mobile.pedido || {}
belcorp.mobile.pedido.initialize = function () {
    var self = this;
    var detalles = [];

    self.getDetalles = function () {
        return detalles;
    }

    self.setDetalles = function (detallesInput) {
        for (var i = 0; i < detallesInput.length; i++) {
            detallesInput[i].CantidadTemporal = detallesInput[i].Cantidad;
            detallesInput[i].FlagValidacion = "1";
        }

        detalles = detallesInput;
    }

    self.getDetalleById = function (detalleId) {
        detalleId = Number(detalleId);
        if (detalleId === 0)
            return false;

        var result = detalles.filter(function (item, index) {
            return item.PedidoDetalleID === detalleId;
        });
        if (result.length > 0)
            return result[0];

        return false;
    }

    self.getDetalleBySetId = function (setId) {
        setId = Number(setId);
        var result = detalles.filter(function (item, index) {
            return item.SetID === setId;
        });
        if (result.length > 0)
            return result[0];

        return false;
    }

    self.setDetalleById = function (detalle) {
        for (var i = 0; i < detalles.length; i++) {
            if (detalles[i].PedidoDetalleID === detalle.PedidoDetalleID
                && detalles[i].SetID === detalle.SetID) {
                detalles[i] = detalle;
            }
        }
    }
}

$(document).ready(function () {
    belcorp.mobile.pedido.initialize();
    ReservadoOEnHorarioRestringido(false);
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
            belcorp.mobile.pedido.setDetalles(data.data.ListaDetalleModel);

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

function GetProductoEntidad(detalleId, setId) {
    var detalle = belcorp.mobile.pedido.getDetalleById(detalleId);
    if (detalle)
        return detalle;
    else {
        if (setId)
            return belcorp.mobile.pedido.getDetalleBySetId(setId);

        return false;
    }
}

function UpdateLiquidacionEvento(evento) {
    var target = $(evento.currentTarget);
    var targetRow = $(evento.currentTarget).closest(".contenedor_items_pedido");
    var id = $.trim(target.attr("data-pedidodetalleid")) || "0";
    var setId = $.trim(target.attr("data-setId"));
    var obj = GetProductoEntidad(id, setId);
    if (!obj) {
        return false;
    }

    var cantidadElement = $(targetRow).find(".Cantidad");
    var cantidad = $(cantidadElement).val() || "";
    var cantidadAnterior = obj.CantidadTemporal;

    if (cantidad.length == 0 || isNaN(cantidad)) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        $(cantidadElement).val(cantidadAnterior);
        return false;
    }

    if (parseInt(cantidad) <= 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        $(cantidadElement).val(cantidadAnterior);
        return false;
    }

    if (cantidad == cantidadAnterior) {
        return false;
    }
    
    UpdateLiquidacionSegunTipoOfertaSis(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.FlagValidacion, obj.CantidadTemporal, obj.EsBackOrder, obj.PrecioUnidad, obj, targetRow);
}

function UpdateLiquidacionSegunTipoOfertaSis(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder, PrecioUnidad, detalleObj, elementRow) {
    var urlAccion = TipoOfertaSisID == ofertaLiquidacion
        ? urlValidarUnidadesPermitidasPedidoProducto
        : TipoOfertaSisID == ofertaShowRoom
            ? urlValidarUnidadesPermitidasPedidoProductoShowRoom
            : TipoOfertaSisID == ofertaAccesorizate
                ? urlValidarUnidadesPermitidasPedidoProducto2
                : "";

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
        UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder, PrecioUnidad, detalleObj, elementRow);
    }
    else {
        ShowLoading();
        if (ReservadoOEnHorarioRestringido()) {
            detalleObj.Cantidad = detalleObj.CantidadTemporal;
            belcorp.mobile.pedido.setDetalleById(detalleObj);
            CloseLoading();
            return false;
        }

        var cantidadElement = $(elementRow).find(".Cantidad");
        var Cantidad = $(cantidadElement).val() || "";
        var cantidadAnterior = detalleObj.CantidadTemporal;
        
        if (Cantidad == cantidadAnterior) {
            CloseLoading();
            return false;
        }

        var CantidadSoli = Cantidad;
        if (TipoOfertaSisID) {
            CantidadSoli = (Cantidad - cantidadAnterior);
        }

        var param = ({
            MarcaID: 0,
            CUV: CUV,
            PrecioUnidad: PrecioUnidad,
            Descripcion: 0,
            Cantidad: CantidadSoli,
            IndicadorMontoMinimo: 0,
            TipoOferta: TipoOfertaSisID || 0
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
                    Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, EsBackOrder, detalleObj, elementRow);
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

function UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder, PrecioUnidad, detalleObj, elementRow) {
    var cantidadElement = $(elementRow).find(".Cantidad");
    var valCant = $(cantidadElement).val() || "";
    var valTemp = detalleObj.CantidadTemporal;

    if (valCant === "" || valTemp === "" || isNaN(valCant) || isNaN(valTemp))
        return false;

    var cantidadActual = parseInt(valCant);
    var cantidadAnterior = parseInt(valTemp);

    if (cantidadActual == cantidadAnterior)
        return false;

    if ($.trim(cantidadActual).length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        $(cantidadElement).val(cantidadAnterior);
        return false;
    }

    if (cantidadActual <= 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        $(cantidadElement).val(cantidadAnterior);
        return false;
    }

    ShowLoading();

    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    if (HorarioRestringido()) {
        CloseLoading();
        return false;
    }

    $.ajaxSetup({ cache: false });

    var CliID = detalleObj.ClienteID;
    var CliDes = detalleObj.Nombre;
    var DesProd = detalleObj.DescripcionProd;
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
                $(cantidadElement).val(CantidadModi);
            } else
                $(cantidadElement).val(cantidadAnterior);

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
            var CantidadActual = $(cantidadElement).val();
            var CantidadaValidar = CantidadActual - cantidadAnterior;
            if (parseInt(data.Stock) < CantidadaValidar) {
                if (PROL == "1") {
                    UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV, EsBackOrder, detalleObj);
                    $(cantidadElement).val(CantidadModi);
                } else
                    $(cantidadElement).val(cantidadAnterior);

                messageInfoMalo("Lamentablemente, no puede actualizar la cantidad del Producto (" + CUV + "), ya que sobrepasa el stock actual (" + data.Stock + "), verifique.");

                CloseLoading();
                return false;
            }

            var PrecioUnidad = detalleObj.PrecioUnidad;
            var Unidad = $(cantidadElement).val();
            var Total = DecimalToStringFormat(parseFloat(cantidadActual * Unidad));
            $(elementRow).find(".ImporteTotal").html(Total);

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

            PedidoUpdate(item, PROL, detalleObj, elementRow);
        });
    });

}

function UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV, EsBackOrder, detalleObj, elementRow) {
    var cantidadElement = $(elementRow).find(".Cantidad");
    var CliID = detalleObj.ClienteID;
    var CliDes = detalleObj.Nombre;
    var Cantidad = $(cantidadElement).val() === "" ? 0 : $(cantidadElement).val();
    var CantidadAnti = detalleObj.CantidadTemporal;
    var DesProd = detalleObj.DescripcionProd;

    if (FlagValidacion == "1") { //obs: siempre sera "1"
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

    var Cantidad = CantidadModi;
    var PrecioUnidad = detalleObj.PrecioUnidad;
    var Total = DecimalToStringFormat(parseFloat(Cantidad * PrecioUnidad));
    $(elementRow).find(".ImporteTotal").html(Total);

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
function ConfigurarPopUpConfirmacion() {
    var regalo = GetUpSellingGanado();

    if (ofertaFinalEstado == 'True' && ofertaFinalAlgoritmo == 'OFR' && regalo) {
        $('#mensaleAvisoRegalo').show();
    }
    else {
        $('#mensaleAvisoRegalo').hide();
    }

    $("#popup-eliminar-item").show();


}

function EliminarPedidoEvento(evento, esBackOrder) {
    var target = $(evento.currentTarget);
    var id = $.trim(target.attr("data-pedidodetalleid")) || "0";
    var setId = $.trim(target.attr("data-setId"));

    var obj = GetProductoEntidad(id, setId);
    if (!obj) {
        return false;
    }

    EliminarPedido(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.CantidadTemporal, obj.DescripcionProd, obj.PrecioUnidad, obj.MarcaID, obj.DescripcionOferta, esBackOrder, obj.SetID);
}

function EliminarPedido(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, Cantidad, DescripcionProd, PrecioUnidad, MarcaID, DescripcionOferta, esBackOrder, setId) {

    ConfigurarPopUpConfirmacion();

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
            EsBackOrder: esBackOrder == 'true',
            SetId: setId
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
                var descripcionMarca = GetDescripcionMarca(MarcaID);
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
            },
            error: function (data, error) {
                CloseLoading();
            }
        });
    };
}

function ConfirmaEliminarPedido() {
    $("#popup-eliminar-item").hide();

    if (ReservadoOEnHorarioRestringido())
        return false;

    if ($.isFunction(fnEliminarProducto)) {
        fnEliminarProducto();
    }
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

            ActualizarGanancia(data.DataBarra);
            TrackingJetloreRemoveAll(listaDetallePedido);
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
function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, EsBackOrder, detalleObj, elementRow) {
    var cantidadElement = $(elementRow).find(".Cantidad");
    var CliID = detalleObj.ClienteID;
    var CliDes = detalleObj.Nombre;
    var Cantidad = $(cantidadElement).val();
    var CantidadAnti = detalleObj.CantidadAnterior;
    var DesProd = detalleObj.DescripcionProd;

    if (Cantidad.length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (FlagValidacion == "1") { //obs: siempre sera "1"
        if (CantidadAnti == Cantidad)
            return false;
    }
    //else {
    //    if (ClienteAnti == CliDes) //todo: Obs ClienteAnti no esta declarado ni se usa
    //        return false;
    //}

    if (CliDes.length == 0) {
        CliID = 0;
    }

    var PrecioUnidad = detalleObj.PrecioUnidad;
    var Cantidad = $(cantidadElement).val();
    var Total = DecimalToStringFormat(parseFloat(Cantidad * PrecioUnidad));
    $(elementRow).find(".ImporteTotal").html(Total);

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

    PedidoUpdate(item, null, detalleObj, elementRow);
}

function PedidoUpdate(item, PROL, detalleObj, elementRow) {
    var cantidadElement = $(elementRow).find(".Cantidad");
    var Cantidad = $(cantidadElement).val();
    var CantidadAnti = detalleObj.CantidadTemporal;
    item.SetID = detalleObj.SetID;

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

            if (PROL == "0") {
                detalleObj.CantidadTemporal = $(cantidadElement).val();
                belcorp.mobile.pedido.setDetalleById(detalleObj);
            }
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

    for (var j, i = nuevoNumero.length - 1, j = 0; i >= 0; i--, j++)
        resultado = nuevoNumero.charAt(i) + ((j > 0) && (j % 3 == 0) ? "." : "") + resultado;

    if (numero.indexOf(",") >= 0) resultado += numero.substring(numero.indexOf(","));

    if (numero[0] == "-") return "-" + resultado;
    return resultado;
}

function EjecutarPROL(cuvOfertaProl) {
    cuvOfertaProl = cuvOfertaProl || "";
    if (gTipoUsuario == '2') {
        var msgg = "Recuerda que este pedido no se va a facturar. Pronto podrás acceder a todos los beneficios de Somos Belcorp.";
        $('#popupInformacionSB2Malo').find('#mensajeInformacionSB2_Malo').text(msgg);
        $('#popupInformacionSB2Malo').show();
    }
    else {
        if (ReservadoOEnHorarioRestringido(true)) {
            return false;
        }

        if (cuvOfertaProl != "") {
            EjecutarServicioPROL();
        } else {
            if (($("#divContenidoDetalle > div") || []).length > 0) {
                if ($('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').hasClass('icono_alerta check_icono_mobile')) {
                    $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').removeClass("icono_alerta check_icono_mobile");
                    $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').addClass("icono_alerta exclamacion_icono_mobile");
                    $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html("<b>IMPORTANTE</b>");
                }
                EjecutarServicioPROL();
            } else {
                messageInfoMalo('No existen productos en su Pedido.');
            }
        }
    }
}

function EjecutarServicioPROL() {
    ShowLoading();

    jQuery.ajax({
        type: 'POST',
        url: urlEjecutarServicioPROL,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                RespuestaEjecutarServicioPROL(response);
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                var mensaje_ = "Por favor, vuelva a intentarlo";
                messageInfoMalo('<h3>' + mensaje_ + '</h3>')
            }
        }
    })
    .always(function () {
        CloseLoading();
    });
}

function EjecutarServicioPROLSinOfertaFinal() {
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlEjecutarServicioPROL,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.flagCorreo == "1") {
                    EnviarCorreoPedidoReservado();
                }
                RespuestaEjecutarServicioPROL(response, false);
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                var mensaje_ = "Por favor, vuelva a intentarlo";
                messageInfoMalo('<h3>' + mensaje_ + '</h3>')
            }
        }
    });
}

function RespuestaEjecutarServicioPROL(response, inicio) {
    inicio = inicio == null || inicio == undefined ? true : inicio;
    var model = response.data;

    var montoEscala = model.MontoEscala;
    var montoPedido = model.Total - model.MontoDescuento;

    if (!model.ValidacionInteractiva) {
        messageInfoMalo('<h3 class="">' + model.MensajeValidacionInteractiva + '</h3>');
        return false;
    }

    $("hdfPROLSinStock").val(model.ProlSinStock == true ? "1" : "0");
    $("hdfModificaPedido").val(model.EsModificacion == true ? "1" : "0");

    var mensajePedidoCheckout = ConstruirObservacionesPROL(model);

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
            var tipoMensaje = codigoMensajeProl == "00" ? 1 : 2;
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
            if (inicio) {
                cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
            }

            if (cumpleOferta.resultado) {
                esPedidoValidado = response.data.ProlSinStock != true;
            } else {
                if (response.data.ProlSinStock == true) {
                    messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
                    AnalyticsGuardarValidar(response);
                    CargarPedido();
                    return true;
                }

                messageInfoBueno('<h3>Tu pedido fue reservado con éxito.</h3>');
                if (estaRechazado == "2") {
                    cerrarMensajeEstadoPedido();
                }

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
            var tipoMensaje = codigoMensajeProl == "00" ? 1 : 2;
            cumpleOferta = CumpleOfertaFinalMostrar(montoPedido, montoEscala, tipoMensaje, codigoMensajeProl, response.data.ListaObservacionesProl);
        }

        if (cumpleOferta.resultado) {
            esPedidoValidado = response.data.ProlSinStock != true;
        } else {
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
        var msg = ""
        if (model.CodigoIso == "VE" && model.ZonaNuevoProlM) {
            msg = '<h3>Tu pedido se guardó con éxito</h3>';
            msg += '<p class="text-small">Te recordamos que el monto mínimo para pasar pedido es de Bs.700.</p>';
            msg += '<p class="text-small">Los productos EXPOFERTAS e IMPERDIBLES CYZONE no suman para el monto mínimo.</p>';
        } else if (model.CodigoIso == "CO" && model.ZonaNuevoProlM) {
            msg = '<h3>Tu pedido se guardó con éxito</h3>';
            msg += '<p>' + mensajeGuardarCO + '</p>';
        } else {
            msg = '<h3>Tu pedido se guardó con éxito</h3>';
        }
        messageInfoBueno(msg);
        AnalyticsGuardarValidar(response);
    }

    CargarPedido();
    return true;
}

function ConstruirObservacionesPROL(model) {

    var mensajePedido = "";
    if (model.ErrorProl) {
        mensajePedido += "-1 " + model.ListaObservacionesProl[0].Descripcion;

        $("#modal-prol-titulo").html("ERROR");
        $("#modal-prol-contenido").html(mensajePedido);

        return mensajePedido;
    }

    if (model.ObservacionRestrictiva == false && model.ObservacionInformativa == false) {

        if (model.ProlSinStock) {
            $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').removeClass("icono_alerta exclamacion_icono_mobile");
            $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').addClass("icono_alerta check_icono_mobile");
            $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html("¡LO <b>LOGRASTE</b>!");
            mensajePedido += "Tu pedido fue guardado con éxito.";

            $("#modal-prol-titulo").html(mensajePedido);
            $("#modal-prol-contenido").html(mensajePedido);

        } else {
            $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').removeClass("icono_alerta exclamacion_icono_mobile");
            $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').addClass("icono_alerta check_icono_mobile");
            $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html("¡LO <b>LOGRASTE</b>!");
            mensajePedido += "Tu pedido fue guardado con éxito.";

            $("#modal-prol-titulo").html(mensajePedido);
            $("#modal-prol-contenido").html("Tu pedido fue guardado con éxito. Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.");

            mensajePedido += " Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.";
        }

        mensajePedido = "-1 " + mensajePedido;

        return mensajePedido;

    }

    if (model.EsDiaProl) {
        $("#modal-prol-titulo").html("IMPORTANTE");
    } else {
        $("#modal-prol-titulo").html("AVISO");
    }

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
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if ($('#hdfPROLSinStock').val() == 1) {
                        $('#popup-observaciones-prol').hide();
                        messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
                        CargarPedido();
                    } else
                        document.location = urlPedidoValidado;
                } else {
                    messageInfoMalo(data.message);
                }
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                messageInfoMalo("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
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
    //alert("seguimiento Alan, copiar el caso para hacer seguimiento de donde se llama a este metodo");
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

            setTimeout(function () { }, 2000);

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
};

function MostrarMensajeProl(data) {

    if (data.Reserva != true) {
        $('#modal-prol-botonesAceptarCancelar').hide();
        $('#modal-prol-botoneAceptar').show();
        $('#popup-observaciones-prol').show();

        CargarPedido();
        return true;
    }

    if (data.ZonaValida == true) {
        if (data.ObservacionInformativa == false) {
            if (data.ProlSinStock == true) {
                messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
                CargarPedido();
                return true;
            }

            messageInfoBueno('<h3>Tu pedido fue reservado con éxito.</h3>');
            setTimeout(function () {
                document.location = urlPedidoValidado;
            }, 2000);
            return true;
        }

        $('#modal-prol-botonesAceptarCancelar').show();
        $('#modal-prol-botoneAceptar').hide();
        $('#popup-observaciones-prol').show();

        CargarPedido();
        return true;
    }

    var msg = ""
    if (data.CodigoIso == "VE" && data.ZonaNuevoProlM) {
        msg = '<h3>Tu pedido se guardó con éxito</h3>';
        msg += '<p class="text-small">Te recordamos que el monto mínimo para pasar pedido es de Bs.700.</p>';
        msg += '<p class="text-small">Los productos EXPOFERTAS e IMPERDIBLES CYZONE no suman para el monto mínimo.</p>';
    } else if (data.CodigoIso == "CO" && data.ZonaNuevoProlM) {
        msg = '<h3>Tu pedido se guardó con éxito</h3>';
        msg += '<p>' + mensajeGuardarCO + '</p>';
    } else {
        msg = '<h3>Tu pedido se guardó con éxito</h3>';
    }
    messageInfoBueno(msg);

    CargarPedido();
    return true;
}

function ValidarPermiso(obj) {
    var permiso = $(obj).attr("disabled") || "";
    if (permiso != "") {
        return false;
    }
    return true;
};

