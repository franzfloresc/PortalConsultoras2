/// <reference path="../../pedido/pedidoprovider.js" />
var UR_DESHACERRECEPCION_PEDIDO = baseUrl + "Pedido/DeshacerRecepcionPedidoRequest",
    URL_VERIFICAR_CONSULTORA_DIGITAL = baseUrl + "Pedido/VerificarConsultoraDigitalRequest"
var tipoOfertaFinal_Log = "";
var gap_Log = 0;
var tipoOrigen = '2';
var arrayProductosGuardadoExito = [];

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
    
    ValidarSuscripcionSE(function () { ValidarKitNuevas(function () { CargarPedido(true); }) }, 1);
    //FIN HD-4200



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

    $(window).bind("load", function () { //se ejecuta al finalizar la carga de la p�gina
        if (typeof cantPedidosPendientes !== "undefined" && typeof esDiaProl !== "undefined") {
            if (cantPedidosPendientes > 0 && esDiaProl) {
                $("#spnCantidadPendientes").text(cantPedidosPendientes);
                $("#accionIgnorar").hide();
                setTimeout(function () {
                    $("#PopupPedidosPendientes").fadeIn(250);
                }, 200);
            }
        }
    });

});

var pedidoProvider = PedidoProvider();

function CargarPedido(firstLoad) {
    var pageParams = {
        sidx: "",
        sord: "",
        page: 1,
        rows: -1,
        clienteId: -1,
        mobil: true
    };
    ShowLoading();
    pedidoProvider
        .cargarDetallePedidoPromise(pageParams)
        .done(function (data) {
            if (!checkTimeout(data)) {
                return false;
            }
            CargarPedidoRespuesta(data, firstLoad);
        })
        .fail(function (data, error) {
            if (checkTimeout(data)) {
                messageInfo('Ocurri� un error al intentar validar el horario restringido o si el pedido est� reservado. Por favor int�ntelo en unos minutos.');
            }
        })
        .then(function () {
            CloseLoading();
        });
}

function CargarPedidoRespuesta(data, firstLoad) {
    SetHandlebars("#template-pedidototal-superior", data.data, '#divPedidoTotalSuperior');
    SetHandlebars("#template-detalle", data.data, '#divProductosDetalle');
    SetHandlebars("#template-pedidototal-inferior", data.data, '#divPedidoTotalInferior');
    belcorp.mobile.pedido.setDetalles(data.data.ListaDetalleModel);
    MostrarBarra(data);

    if ($('#divContenidoDetalle').find(".icono_advertencia_notificacion").length > 0) {
        $("#iconoAdvertenciaNotificacion").show();
    }

    $(".tooltip_noOlvidesGuardarTuPedido").show();
    $(".btn_guardarPedido").show();
    $("footer").hide();

    cuponModule.actualizarContenedorCupon();

    if (firstLoad && autoReservar) { EjecutarPROL(); }


    /* Switch Consultora 100% */
    doWhatYouNeed()
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
    debugger;
    var target = $(evento.currentTarget);
    var targetRow = $(evento.currentTarget).closest(".contenedor_items_pedido");
    var id = $.trim(target.attr("data-pedidodetalleid")) || "0";
    var setId = $.trim(target.attr("data-setId"));
    var obj = GetProductoEntidad(id, setId);
    if (!obj) return false;

    var cantidadElement = $(targetRow).find(".Cantidad");
    var cantidad = $(cantidadElement).val() || "";
    var cantidadAnterior = obj.CantidadTemporal;

    if (cantidad.length == 0 || isNaN(cantidad)) {
        messageInfoMalo('Por favor ingrese una cantidad v�lida.');
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

    UpdateLiquidacionSegunTipoOfertaSis(obj, targetRow);
}

function UpdateLiquidacionSegunTipoOfertaSis(obj, elementRow) {
    var urls = new Object();
    switch (obj.TipoOfertaSisID) {
        case ofertaLiquidacion:
            urls.urlValidarUnidadesPermitidas = urlValidarUnidadesPermitidasPedidoProducto;
            urls.urlObtenerStockActual = urlObtenerStockActualProducto;
            break;
        case ofertaShowRoom:
            urls.urlValidarUnidadesPermitidas = urlValidarUnidadesPermitidasPedidoProductoShowRoom;
            urls.urlObtenerStockActual = urlObtenerStockActualProductoShowRoom;
            break;
        case ofertaAccesorizate:
            urls.urlValidarUnidadesPermitidas = urlValidarUnidadesPermitidasPedidoProducto2;
            urls.urlObtenerStockActual = urlObtenerStockActualProducto2;
            break;
    }

    urls.urlValidarUnidadesPermitidas = $.trim(urls.urlValidarUnidadesPermitidas);
    if (urls.urlValidarUnidadesPermitidas != "") {
        UpdateLiquidacionTipoOfertaSis(urls, obj, elementRow);
    }
    else {
        ShowLoading();

        var cantidadElement = $(elementRow).find(".Cantidad");
        var Cantidad = $(cantidadElement).val() || "";
        var cantidadAnterior = obj.CantidadTemporal;

        if (Cantidad == cantidadAnterior) {
            CloseLoading();
            return false;
        }

        var CantidadSoli = (Cantidad - cantidadAnterior);

        obj.Stock = CantidadSoli;

        Update(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.FlagValidacion, obj.CUV, obj.EsBackOrder, obj, elementRow);

    }
}

function UpdateLiquidacionTipoOfertaSis(urls, obj, elementRow) {
    var cantidadElement = $(elementRow).find(".Cantidad");
    var valCant = $(cantidadElement).val() || "";
    var valTemp = obj.CantidadTemporal;

    if (valCant === "" || valTemp === "" || isNaN(valCant) || isNaN(valTemp))
        return false;

    var cantidadActual = parseInt(valCant);
    var cantidadAnterior = parseInt(valTemp);

    if (cantidadActual == cantidadAnterior)
        return false;

    if ($.trim(cantidadActual).length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad v�lida.');
        $(cantidadElement).val(cantidadAnterior);
        return false;
    }

    if (cantidadActual <= 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        $(cantidadElement).val(cantidadAnterior);
        return false;
    }

    ShowLoading();
    
    $.ajaxSetup({ cache: false });

    var CliID = obj.ClienteID;
    var CliDes = obj.Nombre;
    var DesProd = obj.DescripcionProd;
    var Flag = 2;
    var StockNuevo = cantidadActual - cantidadAnterior;
    var PROL = falgValidacionPedido;

    if (CliDes.length == 0)
        CliID = 0;

    $.getJSON(urls.urlValidarUnidadesPermitidas, { CUV: obj.CUV, Cantidad: StockNuevo, PrecioUnidad: obj.PrecioUnidad }, function (data) {
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
                UpdateConCantidad(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.FlagValidacion, obj.CantidadTemporal, obj.CUV, obj.EsBackOrder);
                $(cantidadElement).val(obj.CantidadTemporal);
            } else
                $(cantidadElement).val(cantidadAnterior);

            if (Saldo == UnidadesPermitidas)
                messageInfoMalo("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto " + obj.CUV + ".");
            else {
                if (Saldo == "0")
                    messageInfoMalo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar m�s, debido a que ya agreg� este producto (" + obj.CUV + ") a su pedido, verifique.");
                else
                    messageInfoMalo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") m�s, debido a que ya agreg� este producto (" + obj.CUV + ") a su pedido, verifique.");
            }

            CloseLoading();
            return false;
        }

        $.getJSON(urls.urlObtenerStockActual, { CUV: obj.CUV }, function (data) {
            var CantidadActual = $(cantidadElement).val();
            var CantidadaValidar = CantidadActual - cantidadAnterior;
            if (parseInt(data.Stock) < CantidadaValidar) {
                if (PROL == "1") {
                    UpdateConCantidad(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.FlagValidacion, obj.CantidadTemporal, obj.CUV, obj.EsBackOrder, obj);
                    $(cantidadElement).val(obj.CantidadTemporal);
                } else
                    $(cantidadElement).val(cantidadAnterior);

                messageInfoMalo("Lamentablemente, no puede actualizar la cantidad del Producto (" + obj.CUV + "), ya que sobrepasa el stock actual (" + data.Stock + "), verifique.");

                CloseLoading();
                return false;
            }
            
            var Unidad = $(cantidadElement).val();
            var Total = DecimalToStringFormat(parseFloat(cantidadActual * Unidad));
            $(elementRow).find(".ImporteTotal").html(Total);

            var item = {
                CampaniaID: obj.CampaniaID,
                PedidoID: obj.PedidoID,
                PedidoDetalleID: obj.PedidoDetalleID,
                ClienteID: CliID,
                Cantidad: cantidadActual,
                PrecioUnidad: obj.PrecioUnidad,
                ClienteDescripcion: CliDes,
                DescripcionProd: DesProd,
                Stock: StockNuevo,
                Flag: Flag,
                TipoOfertaSisID: obj.TipoOfertaSisID,
                CUV: obj.CUV,
                ClienteID_: "-1",
                EsBackOrder: obj.EsBackOrder
            };

            PedidoUpdate(item, PROL, obj, elementRow);
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
        messageInfoMalo('Por favor ingrese una cantidad v�lida.');
        return false;
    }

    if (Cantidad == 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (CliDes.length == 0) {
        CliID = 0;
    }
    
    var PrecioUnidad = detalleObj.PrecioUnidad;
    var Total = DecimalToStringFormat(parseFloat(CantidadModi * PrecioUnidad));
    $(elementRow).find(".ImporteTotal").html(Total);

    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: CantidadModi,
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
    var target = $(evento.currentTarget);
    var id = $.trim(target.attr("data-pedidodetalleid")) || "0";
    var setId = $.trim(target.attr("data-setId"));
    var obj = GetProductoEntidad(id, setId);
    if (!obj) return false;

    ConfigurarFnEliminarProducto(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.CantidadTemporal, obj.DescripcionProd, obj.PrecioUnidad, obj.MarcaID, obj.DescripcionOferta, esBackOrder, obj.SetID);
    ValidDeleteElectivoNuevas(obj, function (esElecMultiple) {
        if (esElecMultiple) fnEliminarProducto();
        else ConfirmaEliminarPedido();
    });
}

function ValidDeleteElectivoNuevas(obj, fnDelete) {
    if (!$.isFunction(fnDelete)) fnDelete = function () { };

    if (!obj.EsElecMultipleNuevas) fnDelete(false);
    else messageConfirmacionDuoPerfecto(mensajeElecMultipleEliminar, function () { fnDelete(true); });
}

function ConfigurarFnEliminarProducto(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, Cantidad, DescripcionProd, PrecioUnidad, MarcaID, DescripcionOferta, esBackOrder, setId) {
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

        var campaniaId = CampaniaID;
        ShowLoading();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + "PedidoRegistro/DeleteTransaction",
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

                var ActualizaGananciasLoad = typeof ActualizaGanancias === 'function';
                if (ActualizaGananciasLoad) {
                    ActualizaGanancias(data);
                }

                MostrarBarra(data);
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
                messageDelete('El producto fue eliminado.');
                
                if (!data.EsAgregado) {
                    var localStorageModule = new LocalStorageModule();
                    localStorageModule.ActualizarCheckAgregado($.trim(data.data.EstrategiaId), campaniaId, data.data.TipoEstrategiaCodigo, false);
                }

                ActualizarLocalStoragePalancas(data.data.CUV, false);
            },
            error: function (data, error) {
                CloseLoading();
            }
        });
    };
}

function ConfirmaEliminarPedido() {
    
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

            MostrarBarra(data);
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


            MostrarBarra(data);
            TrackingJetloreRemoveAll(listaDetallePedido);

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaEliminarPedidoCompleto(data.ListaMarcaciones);

            messageDelete("Se eliminaron todos productos del pedido.");

            ActualizarLocalStoragePalancas("todo", false);

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
        messageInfoMalo('Por favor ingrese una cantidad v�lida.');
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

    if (CliDes.length == 0) {
        CliID = 0;
    }

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
        Nombre: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: "-1",
        CUV: CUV,
        EsBackOrder: EsBackOrder,
        TipoOfertaSisID: detalleObj.TipoOfertaSisID,
        Stock: detalleObj.Stock
    };

    PedidoUpdate(item, null, detalleObj, elementRow);
}

function PedidoUpdate(item, PROL, detalleObj, elementRow) {

    var cantidadElement = $(elementRow).find(".Cantidad");
    var Cantidad = $(cantidadElement).val();
    var CantidadAnti = detalleObj.CantidadTemporal;
    var _mensajeModificarPedido = ConstantesModule.MensajeModificarPedido;

    item.SetID = detalleObj.SetID;

    ShowLoading();
    PROL = PROL || "0";
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + "PedidoRegistro/UpdateTransaction",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CloseLoading();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                debugger;
                messageInfoError(data.message);
                /*  INICIO -  TESLA-320   */
                $(cantidadElement).val(CantidadAnti);
            /*  FIN -  TESLA-320   */
                return false;
            }

            var prevTotal = mtoLogroBarra || 0;
            MostrarBarra(data);
            
            CargarPedido();
            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
	            TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), item.CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), item.CUV);

            if (PROL == "0") {
                detalleObj.CantidadTemporal = $(cantidadElement).val();
                belcorp.mobile.pedido.setDetalleById(detalleObj);
            }
            
            var isReservado = data.EsReservado || false;
            var mensaje = '';
            if (isReservado) {
                mensaje = _mensajeModificarPedido.reservado;
            } else {
                mensaje = _mensajeModificarPedido.normal;
            }
            ActualizaGanancias(data);

            AbrirMensaje25seg(mensaje);

            setTimeout(function () {
		            showPopupNivelSuperado(data.DataBarra, prevTotal);
		            if (data.mensajeCondicional) {
			            AbrirMensajeImagen(data.mensajeCondicional);
		            }
		            if (data.modificoBackOrder) {
			            messageInfo('Recuerda que debes volver a validar tu pedido.');
		            }
	            },
	            2500);
        },
        error: function (data, error) {
            CloseLoading();
        }
    });
}

function TagManagerClickEliminarProducto(descripcionProd, cuv, precioUnidad, descripcionMarca, descripcionOferta, cantidad) {
    var variant = "Est�ndar";
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

    for (var i = nuevoNumero.length - 1, j = 0; i >= 0; i-- , j++)
        resultado = nuevoNumero.charAt(i) + ((j > 0) && (j % 3 == 0) ? "." : "") + resultado;

    if (numero.indexOf(",") >= 0) resultado += numero.substring(numero.indexOf(","));

    if (numero[0] == "-") return "-" + resultado;
    return resultado;
}

function EjecutarPROL(cuvOfertaProl) {
    if (gTipoUsuario == '2') {
        var msgg = "Recuerda que este pedido no se va a facturar. Pronto podr�s acceder a todos los beneficios de Somos Belcorp.";
        $('#popupInformacionSB2Malo').find('#mensajeInformacionSB2_Malo').text(msgg);
        $('#popupInformacionSB2Malo').show();
        return;
    }

    cuvOfertaProl = cuvOfertaProl || "";
    var pedidoVacio = (($("#divContenidoDetalle > div") || []).length === 0);
    if (cuvOfertaProl == "" && pedidoVacio) {
        messageInfoMalo(mensajePedidoVacio);
        return;
    }
    if (ReservadoOEnHorarioRestringido(true)) return;

    var objIconoPopup = $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile');
    if (cuvOfertaProl == "" && !pedidoVacio && objIconoPopup.hasClass('icono_alerta check_icono_mobile')) {
        objIconoPopup.removeClass("icono_alerta check_icono_mobile");
        objIconoPopup.addClass("icono_alerta exclamacion_icono_mobile");
        $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html("<b>IMPORTANTE</b>");
    }
    EjecutarServicioPROL();
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
            CloseLoading();
            if (!checkTimeout(response)) return;
            if (!response.success) {               
                messageInfoMalo(mensajeErrorReserva);
                return false;
            }

            if (response.mensajeCondicional) {
                AbrirMensajeImagen(response.mensajeCondicional);
            }

            RespuestaEjecutarServicioPROL(response, function () { return CumpleOfertaFinalMostrar(response); });
        },
        error: function (data, error) {
            CloseLoading();
            messageInfoMalo(mensajeSinConexionReserva);
        }
    })
}

function EjecutarServicioPROLSinOfertaFinal() {
    ShowLoading();
    pedidoProvider
        .ejecutarServicioProlPromise()
        .done(function (response) {

            if (!checkTimeout(response)) return;
            if (!response.success) {
                messageInfoMalo(mensajeErrorReserva);
                return;
            }

            RespuestaEjecutarServicioPROL(response, function () { return false; });
        })
        .fail(function (data, error) {
            messageInfoMalo(mensajeSinConexionReserva);
        })
        .then(function () {
            CloseLoading();
        })
}

function RespuestaEjecutarServicioPROL(response, fnOfertaFinal) {
    if (ConstruirObservacionesPROL(response.data)) return;

    arrayProductosGuardadoExito = response;

    var cumpleOferta = fnOfertaFinal();
    if (cumpleOferta) {
        return;
    }
    var res = response.data;
    if (!res.Reserva) {
        if (res.hasOwnProperty("MostrarMensajeExito")) {
            console.info(res.MostrarMensajeExito);
            if (res.MostrarMensajeExito) {
                var idPedidoGuardado = "#PopupPedidoGuardado", idPedidoPendiente = "#PopupPedidosPendientes", accionIgnorar = "#accionIgnorar";
                $(accionIgnorar).hide();
                $(idPedidoGuardado).fadeIn(250);
                setContainerLluvia(idPedidoGuardado);
                mostrarLluvia();
                setTimeout(function () {
                    var cantidad = res.hasOwnProperty("CantPedidosPendientes") ? res.CantPedidosPendientes : 0;
                    $(idPedidoGuardado).fadeOut(700);
                    if (cantidad > 0) {
                        $(idPedidoPendiente).delay(300);
                        $(idPedidoPendiente).fadeIn(700);
                    }
                }, 3750);
                return false;
            }
        } else {
            ShowPopupObservacionesReserva();
            return false;
        }
    }

    EjecutarAccionesReservaExitosa(response);
}

function EjecutarAccionesReservaExitosa(response) {
    if (response.flagCorreo == '1') EnviarCorreoPedidoReservado();
    if (estaRechazado == "2") cerrarMensajeEstadoPedido();
   
    var ultimoDiaFacturacion = response.UltimoDiaFacturacion || false;
    
    if (!response.data.IsEmailConfirmado) {
        configActualizarCorreo.UrlPedidoValidado = (!ultimoDiaFacturacion) ? configActualizarCorreo.UrlPedido: configActualizarCorreo.UrlPedidoValidado;
        new Pedido_ActualizarCorreo(configActualizarCorreo).Inicializar();

    }
    else {
         var idPedidoGuardado = "#PopupPedidoGuardado", msgReservado = "#msgPedidoReservado", msgGuardado = "#msgPedidoGuardado";
         $(msgGuardado).hide();
         $(msgReservado).show();

         setContainerLluvia(idPedidoGuardado);
         mostrarLluvia();
         $(idPedidoGuardado).fadeIn(250);
    	 if (ultimoDiaFacturacion) {
	    RedirigirPedidoValidado();
    	 } else {
	    location.reload();
    	 }
    }
    

}

function ConstruirObservacionesPROL(model) {
    if (model.ErrorProl) {
        MostrarPopupErrorReserva(model.ListaObservacionesProl[0].Descripcion, model.AvisoProl);
        return true;
    }
    var mensajeBloqueante = true;

    if (!model.ZonaValida) messageInfoBueno('<h3>Tu pedido se guard&oacute; con &eacute;xito.</h3>');
    else if (!model.ValidacionInteractiva) messageInfoMalo('<h3 class="">' + model.MensajeValidacionInteractiva + '</h3>');
    else {
        mensajeBloqueante = false;
        if (model.ObservacionRestrictiva) CrearPopupObservaciones(model);
        else {
            model.MostrarMensajeExito = true;
            $("#spnCantidadPendientes").text(model.CantPedidosPendientes);
            //ArmarPopupObsReserva(true, '!LO <b>LOGRASTE</b>!', 'Tu pedido fue guardado con &eacute;xito. Recuerda, al final de tu campa&ntilde;a valida tu pedido para reservar tus productos.');
        }

    }

    CargarPedido();
    AlmacenarRespuestaReservaEnHidden(model);
    ActualizarBtnGuardar(model);
    return mensajeBloqueante;
}

function CrearPopupObservaciones(model) {
    var mensaje = "<ul style='padding-left: 15px; list-style-type: none; text-align: center;'>";
    if (model.ListaObservacionesProl.length == 0) mensaje += "<li>Tu pedido tiene observaciones, por favor rev&iacute;salo.</li>";
    else {
        $.each(model.ListaObservacionesProl, function (index, item) {
            if (model.CodigoIso == "BO" || model.CodigoIso == "MX") {
                if (item.Caso == 6 || item.Caso == 8 || item.Caso == 9 || item.Caso == 10) {
                    item.Caso = 105;
                }
            }

            if (item.Caso == 95 || item.Caso == 105) mensaje += "<li>" + item.Descripcion + "</li>";
            else mensaje += "<li>Tu pedido tiene observaciones, por favor rev&iacute;salo.</li>";

            return false;
        });
    }
    mensaje += "</ul>";

    ArmarPopupObsReserva(false, model.EsDiaProl ? 'IMPORTANTE' : 'AVISO', mensaje)
}

function ArmarPopupObsReserva(esIconCheck, titulo, mensaje) {
    $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html(titulo);
    $("#modal-prol-contenido").html(mensaje);

    var objIcon = $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile');
    objIcon.removeClass('check_icono_mobile exclamacion_icono_mobile');
    objIcon.addClass(esIconCheck ? 'check_icono_mobile' : 'exclamacion_icono_mobile');
}
function MostrarPopupErrorReserva(mensajePedido, esAviso) {
    if (typeof esAviso !== 'undefined') esAviso = false;
    ArmarPopupObsReserva(false, esAviso ? 'AVISO' : 'ERROR', mensajePedido);

    $('#popup-observaciones-prol').show();
}

function ShowPopupObservacionesReserva() {
    $('#popup-observaciones-prol').show();
}
function ShowPopupQuestionModificarPedido() {
	$('#popupInformacionSB2Question').show();
}

function AlmacenarRespuestaReservaEnHidden(model) {
    $("hdfModificaPedido").val(model.EsModificacion == true ? "1" : "0");
}
function ActualizarBtnGuardar(model) {
    var tooltips = model.ProlTooltip.split('|');
    $('.tooltip_noOlvidesGuardarTuPedido')[0].children[0].innerHTML = tooltips[0];
    $('.tooltip_noOlvidesGuardarTuPedido')[0].children[1].innerHTML = tooltips[1];
    $('#btnGuardarPedido').text(model.Prol);
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
                    messageInfoMalo("Ocurri� un error al ejecutar la acci�n. Por favor int�ntelo de nuevo.");
            }
        });
    } else {
        $('#popup-observaciones-prol').hide();
    }
}

function MostrarDetalleGanancia() {

    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').show();
}

function ValidarPermiso(obj) {
    var permiso = $(obj).attr("disabled") || "";
    if (permiso != "") {
        return false;
    }
    return true;
}

function RedirigirPedidoValidado() {
	
    setTimeout(function () {
        ShowLoading();
        document.location = urlPedidoValidado;
    }, 2000);
}

function closeDialogObservacionesProl() {


    arrayProductosGuardadoExito = arrayProductosGuardadoExito || "";
    if (arrayProductosGuardadoExito !== "")
        if (!(typeof AnalyticsPortalModule === 'undefined'))
            AnalyticsPortalModule.MarcaGuardarPedidoExito(arrayProductosGuardadoExito);


    $('#popup-observaciones-prol').hide();
}

function PedidosPendientesPorAprobar() {
    if (!(typeof AnalyticsPortalModule === 'undefined'))
        AnalyticsPortalModule.ClickBotonPedidosPendientes('Click Bot�n', 'Pedidos por aprobar');
}
function AccionConfirmarModificarPedido() {

	$('#popupInformacionSB2Question').hide();

	ShowLoading();
	jQuery.ajax({
		type: 'POST',
		url: urlDeshacerReservaPedidoReservado + '?Tipo=PV',
		dataType: 'json',
		contentType: 'application/json; charset=utf-8',
		async: true,
		success: function (data) {
			if (checkTimeout(data)) {
				if (data.success == true) {
					location.reload();
				} else {
					CloseLoading();
                    
					messageInfoError(data.message);

				}
			}
		},
		error: function (data, error) {
			if (checkTimeout(data)) {
				CloseLoading();
				messageInfo("Ocurri� un problema de conectividad. Por favor int�ntelo mas tarde.");
			}
		}
	});
}

function ActualizaGanancias(data) {

    data = data || "";
    if (data !== "") {
        $('#div-ganancia-totalMontoGanancia').text(data.PedidoWeb.FormatoTotalMontoGananciaStr);
        $('#div-ganancia-totalGananciaCatalogo').text(data.PedidoWeb.FormatoTotalMontoAhorroCatalogoStr);
        $('#div-ganancia-totalGananciaRevista').text(data.PedidoWeb.FormatoTotalGananciaRevistaStr);
        $('#div-ganancia-totalGananciaWeb').text(data.PedidoWeb.FormatoTotalGananciaWebStr);
        $('#div-ganancia-totalGananciaOtros').text(data.PedidoWeb.FormatoTotalGananciaOtrosStr);
    }
}



/* Switch Consultora 100% --- */
function doWhatYouNeed() {
    var object = { codigoConsultora: userData.codigoConsultora }
    
    $.ajax({
        type: "POST",
        url: URL_VERIFICAR_CONSULTORA_DIGITAL,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(object),
        dataType: "json",
        cache: false,
        success: function (data) {

            if (checkTimeout(data)) {
                if (data != null) {
                    if (data.IndicadorConsultoraDigital) {
                        if (document.querySelectorAll("div.montos_resumen")[0].children[2].children[1] != undefined && parseInt(document.querySelectorAll("div.montos_resumen")[0].children[2].children[1].innerHTML) > 0  ) {
                            if (data.IndicadorRecepcion) {
                                $("div.contenedor_info_recepcion_pedido").css("display", "flex");
                                $(".info_recepcion_pedido").css("display", "block");
                                $(".switch__control").prop("checked", true);
                                cargarDatosrecepcion(data);
                            } else {
                                $("div.contenedor_info_recepcion_pedido").css("display", "flex");
                                $(".info_recepcion_pedido").css("display", "none");
                                $(".switch__control").prop("checked", false);
                            }

                        } else {
                            $("div.contenedor_info_recepcion_pedido").css("display", "none");
                            $(".info_recepcion_pedido").css("display", "none");
                            $(".switch__control").prop("checked", false);
                        }
                    } else $("div.contenedor_info_recepcion_pedido").css("display", "none")
                }
            }
        },
        error: function (x, xh, xhr) {
            if (checkTimeout(x)) {
                closeWaitingDialog();
            }
        }
    });


}
$("input:checkbox[class=switch__control]").change(function () {
        if (!document.querySelectorAll("input[type=checkbox]:not(:checked )").length) {
        LimpiarCamposRecepcionPoput();
        $('#PopupRecepcionPedido').fadeIn(100);
    } else {
        DeshacerRecepcionpedido();
    }

});


function DeshacerRecepcionpedido() {
    $.ajax({
        type: "POST",
        url: UR_DESHACERRECEPCION_PEDIDO,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data > 0) {
                    $(".info_recepcion_pedido").css("display", "none");
                }
            }
        },
        error: function (x, xh, xhr) {
            if (checkTimeout(x)) {
                closeWaitingDialog();
            }
        }
    });
}

function cargarDatosrecepcion(object) {
    var ListChildren = document.getElementsByClassName("datos__receptor__pedido")[0].children;
    ListChildren[0].textContent = object.nombreYApellido;
    ListChildren[1].textContent = object.numeroDocumento;
}


function LimpiarCamposRecepcionPoput() {
    $("#txtNombreYApellido").removeClass('text__field__sb--withContent');
    $("#txtNumeroDocumento").removeClass('text__field__sb--withContent');
    document.getElementsByClassName("form__group__fields--nombreApellido")[0].children[2].textContent = "";
    document.getElementsByClassName("form__group__fields--numeroDocumento")[0].children[2].textContent = "";
    $("#txtNombreYApellido").val("");
    $("#txtNumeroDocumento").val("");
    $(".btn__sb__primary--multimarca").addClass("btn__sb--disabled");

    object = {};
}

$(".popup__somos__belcorp__icono__cerrar--popupRecepcionPedido").click(function () {
    ActualizarCheck();
})

$(".btn__sb--cambiarPersona").click(function () {
    $("#txtNombreYApellido").addClass('text__field__sb--withContent');
    $("#txtNumeroDocumento").addClass('text__field__sb--withContent');
    $("#txtNombreYApellido").val(document.getElementsByClassName("datos__receptor__pedido")[0].children[0].textContent);
    $("#txtNumeroDocumento").val(document.getElementsByClassName("datos__receptor__pedido")[0].children[1].textContent);
    $(".btn__sb__primary--multimarca").removeClass("btn__sb--disabled");
});


function ActualizarCheck() {
    LimpiarCamposRecepcionPoput();
    if ($(".info_recepcion_pedido").css("display") == "none") {
        $(".switch__control").prop("checked", false);
    }
}

/*FIN - Switch Consultora 100% */
