﻿$(document).ready(function () {
    $('body').on('click', ".icono_kitNuevas a", function (e) {
        var mostrar = $(this).next();
        if (mostrar.css("display") == "none") mostrar.fadeIn(200);
        else mostrar.fadeOut(200);
    });

    ValidarKitNuevas();
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
            else CargarPedido();
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error de conexion al intentar cargar el pedido. Por favor inténtelo mas tarde.');
        }
    });
}

function CargarPedido() {
    var obj = {
        sidx: "",
        sord: "",
        page: 1,
        rows: -1,
        clienteId: -1,
        mobil: true
    };

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

            //var divMensajeCierreCampania = $("#divMensajeCierreCampania").html();
            //divMensajeCierreCampania = divMensajeCierreCampania.ReplaceAll("&lt;p&gt;", "<p>");
            //divMensajeCierreCampania = divMensajeCierreCampania.ReplaceAll("&lt;b&gt;", "<b>");
            //divMensajeCierreCampania = divMensajeCierreCampania.ReplaceAll("&lt;/b&gt;", "</b>");
            //divMensajeCierreCampania = divMensajeCierreCampania.ReplaceAll("&lt;/p&gt;", "</b>");
            //$("#divMensajeCierreCampania").html(divMensajeCierreCampania);

            if ($('#divContenidoDetalle').find(".icono_advertencia_notificacion").length > 0) {
                $("#iconoAdvertenciaNotificacion").show();
            }

            $(".tooltip_noOlvidesGuardarTuPedido").show();
            $(".btn_guardarPedido").show();
            $("footer").hide();
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
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
        DescripcionOferta: $("#DescripcionOferta_" + id).val()
    };
}

// Actualizar pedido delsde el detalle => Cantidad Detalle

function UpdateLiquidacionEvento(evento) {
    var obj = $(evento.currentTarget);
    var id = $.trim(obj.attr("data-pedidodetalleid")) || "0";
    if (parseInt(id, 10) <= 0 || parseInt(id, 10) == NaN) {
        return false;
    }

    var obj = GetProductoEntidad(id);

    UpdateLiquidacionSegunTipoOfertaSis(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.FlagValidacion, obj.CantidadInicial);

}

function UpdateLiquidacionSegunTipoOfertaSis(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi) {

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
        UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi);
    }
    else {

        var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
        var cantidadAnterior = $('#CantidadTemporal_' + PedidoDetalleID).val();

        if (Cantidad.length == 0 || parseInt(Cantidad) == NaN) {
            messageInfo('Por favor ingrese una cantidad válida.');
            $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
            return false;
        }

        if (parseInt(Cantidad) <= 0) {
            messageInfo('Por favor ingrese una cantidad mayor a cero.');
            $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
            return false;
        }

        var param = ({
            MarcaID: 0,
            CUV: CUV,
            PrecioUnidad: 0,
            Descripcion: 0,
            Cantidad: Cantidad,
            IndicadorMontoMinimo: 0,
            TipoOferta: 1
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
                CloseLoading();
                if (!datos.result) {
                    messageInfo(datos.message);
                    $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
                    return false;
                }

                Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV);
                
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data))
                    console.error(data);
            }
        });
    }
}

function UpdateLiquidacionTipoOfertaSis(urls ,CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi) {

    var cantidadActual = parseInt($('#Cantidad_' + PedidoDetalleID).val());
    var cantidadAnterior = parseInt($('#CantidadTemporal_' + PedidoDetalleID).val());

    if (cantidadActual == cantidadAnterior || cantidadActual == NaN || cantidadAnterior == NaN)
        return false;
        
    if ($.trim(cantidadActual).length == 0) {
        messageInfo('Por favor ingrese una cantidad válida.');
        $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
        return false;
    }

    if (cantidadActual <= 0) {
        messageInfo('Por favor ingrese una cantidad mayor a cero.');
        $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
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

    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();
    var Flag = 0;
    var StockNuevo = 0;
    var PROL = falgValidacionPedido;
      
    if (cantidadAnterior > cantidadActual) {
        Flag = 1;
        StockNuevo = cantidadAnterior - cantidadActual;
    } else if (cantidadActual > cantidadAnterior) {
        Flag = 2;
        StockNuevo = cantidadActual - cantidadAnterior;
    }
    
    if (CliDes.length == 0) 
        CliID = 0;
    
    $.getJSON(urls.urlValidarUnidadesPermitidas, { CUV: CUV }, function (data) {
        var Saldo = data.Saldo;
        var UnidadesPermitidas = data.UnidadesPermitidas;
        var CantidadPedida = data.CantidadPedida || 0;
        var Cantidad = cantidadActual + parseInt(CantidadPedida);

        if (parseInt(data.UnidadesPermitidas) < Cantidad) {
            if (PROL == "1") {
                UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV);
                $('#Cantidad_' + PedidoDetalleID).val(CantidadModi);
            } else
                $('#Cantidad_' + PedidoDetalleID).val($('#CantidadTemporal_' + PedidoDetalleID).val());

            if (Saldo == UnidadesPermitidas)
                messageInfo("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto " + CUV + ".");
            else {
                if (Saldo == "0")
                    messageInfo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto (" + CUV + ") a su pedido, verifique.");
                else
                    messageInfo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto (" + CUV + ") a su pedido, verifique.");
            }

            CloseLoading();
            return false;
        }

        $.getJSON(urls.urlObtenerStockActual, { CUV: CUV }, function (data) {
            var CantidadActual = $('#Cantidad_' + PedidoDetalleID).val();
            var CantidadaValidar = CantidadActual - cantidadAnterior;
            if (parseInt(data.Stock) < CantidadaValidar) {
                if (PROL == "1") {
                    UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV);
                    $('#Cantidad_' + PedidoDetalleID).val(CantidadModi);
                } else
                    $('#Cantidad_' + PedidoDetalleID).val($('#CantidadTemporal_' + PedidoDetalleID).val());

                messageInfo("Lamentablemente, no puede actualizar la cantidad del Producto (" + CUV + "), ya que sobrepasa el stock actual (" + data.Stock + "), verifique.");

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
                ClienteID_: "-1"
            };

            PedidoUpdate(item, PROL);

        });

    });

}

function UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV) {

    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
    var CantidadAnti = $('#CantidadTemporal_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad)
            return false;
    }

    if (Cantidad.length == 0) {
        messageInfo('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        messageInfo('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (CliDes.length == 0) {
        CliID = 0;
    }

    var Cantidad = CantidadModi;
    var PrecioUnidad = $('#PrecioUnidad_' + PedidoDetalleID).val();
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
        ClienteDescripcion: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: "-1",
        CUV: CUV
    };
    PedidoUpdate(item);
}

// fin Actualizar pedido delsde el detalle => Cantidad Detalle

// Eliminar detalle pedido

function EliminarPedidoEvento(evento) {
    var obj = $(evento.currentTarget);
    var id = $.trim(obj.attr("data-pedidodetalleid")) || "0";
    if (parseInt(id, 10) <= 0 || parseInt(id, 10) == NaN) {
        return false;
    }

    var obj = GetProductoEntidad(id);
    
    EliminarPedido(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.CantidadInicial, obj.DescripcionProd, obj.PrecioUnidad, obj.MarcaID, obj.DescripcionOferta);

}

function EliminarPedido(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, Cantidad, DescripcionProd, PrecioUnidad, MarcaID, DescripcionOferta) {

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
            CUVReco: ""
        });

        ShowLoading();

        jQuery.ajax({
            type: 'POST',
            url: urlPedidoDelete,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(param),
            async: true,
            success: function (html) {
                ActualizarGanancia(html.DataBarra);
                CloseLoading();
                CargarPedido();
                var descripcionMarca = GetDescripcionMarca(MarcaID);
                TagManagerClickEliminarProducto(DescripcionProd, CUV, PrecioUnidad, descripcionMarca, DescripcionOferta, Cantidad);

                TrackingJetloreRemove(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                messageDelete('El producto fue Eliminado.');
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data))
                    console.error(data);
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

function messageDelete(message) {
    $('#mensajeInformacionEliminar').html(message);
    $("#popup-eliminar-mensaje").modal("show");
    setTimeout(function () {
        $("#popup-eliminar-mensaje").modal("hide");
    }, 2000);
}
// fin Eliminar detalle pedido

// Eliminar Todo Pedido

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
            ActualizarGanancia({ MontoGananciaStr: DecimalToStringFormat(0) });
            TrackingJetloreRemoveAll(listaDetallePedido);
            if (checkTimeout(data)) {
                messageDelete("Se eliminaron todos productos del pedido.");
                location.reload();
            }
            CloseLoading();
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                alert_msg(data.message);
            }
        }
    });
}
// Fin Eliminar Todo Pedido

// validaciones

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {

            if (checkTimeout(data)) {
                if (data.success == false)
                    restringido = false;
                else {
                    if (data.pedidoReservado) {
                        var fnRedireccionar = function () {
                            ShowLoading();
                            location.href = urlPedidoValidado;
                        }
                        if (mostrarAlerta == true) 
                            alert_msg(data.message, fnRedireccionar);                        

                        else fnRedireccionar();

                    }
                    else if (mostrarAlerta == true) alert_msg(data.message);
                }
            }
        },
        error: function (error) {
            console.log(error);
            alert_msg('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
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
                // SI esta en horario restringido
                if (response.success == true) {
                    if (mostrarAlerta == true)
                        window.messageInfo(response.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (response, error) {
            if (checkTimeout(response))
                console.error(response);           
        }
    });
    return horarioRestringido;
}

// Fin validaciones

// Actualizar
function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV) {

    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
    var CantidadAnti = $('#CantidadTemporal_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();
    
    if (Cantidad.length == 0) {
        messageInfo('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        messageInfo('Por favor ingrese una cantidad mayor a cero.');
        return false;
    }

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad)
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
        ClienteDescripcion: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: "-1",
        CUV: CUV
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
            if (checkTimeout(data)) {
                if (data.success == true) {
                    ActualizarGanancia(data.DataBarra);
                    
                    if (PROL == "0")
                        $('#CantidadTemporal_' + item.PedidoDetalleID).val($('#Cantidad_' + item.PedidoDetalleID).val());
                    CargarPedido();
                    
                    var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
                    if (diferenciaCantidades > 0)
                        TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), item.CUV);
                    else if (diferenciaCantidades < 0)
                        TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), item.CUV);
                }
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data))
                console.error(data);
        }
    });
}

// Fin Actualizar

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

function alert_msg(message, fnClose) {
    messageInfoValidado('<h3 class="text-primary">' + message + '</h3>', fnClose);
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

// PROL

function EjecutarPROL() {
    if (ReservadoOEnHorarioRestringido(true)) {
        return false;
    }
    
    //Se Valida que existan productos
    if (($("#divContenidoDetalle > div") || []).length > 0) {
        EjecutarServicioPROL();
    } else {
        messageInfo('<h3 class="text-primary">No existen productos en su Pedido.</h3>');
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
            var model = response.data;
            CloseLoading();

            if (!model.ValidacionInteractiva) {
                messageInfo('<h3 class="text-primary">' + model.MensajeValidacionInteractiva + '</h3>');
                return false;
            }

            $("hdfPROLSinStock").val(model.ProlSinStock == true ? "1" : "0");
            $("hdfModificaPedido").val(model.EsModificacion == true ? "1" : "0");

            var mensajePedidoCheckout = ConstruirObservacionesPROL(model);

            $('#btnGuardarPedido').text(model.Prol);

            if (model.Reserva != true) {

                $('#modal-prol-botonesAceptarCancelar').hide();
                $('#modal-prol-botoneAceptar').show();
                $('#popup-observaciones-prol').modal("show");

                CargarPedido();
                return true;
            }

            if (model.ZonaValida == true) {
                if (model.ObservacionInformativa == false) {
                    if (model.ProlSinStock == true) {
                        messageInfo('<h3 class="text-primary">Tu pedido se guardó con éxito</h3>');
                        CargarPedido();
                        return true;
                    }

                    messageInfo('<h3 class="text-primary">Tu pedido fue validado con éxito</h3><p>Tus productos fueron reservados.</p>');
                    window.setTimeout(function () {
                            location.href = urlPedidoValidado;
                        }, 2000);                    
                    return true;
                }

                $('#modal-prol-botonesAceptarCancelar').show();
                $('#modal-prol-botoneAceptar').hide();
                $('#popup-observaciones-prol').modal("show");

                CargarPedido();                
                return true;
            }

            var msg = ""
            if (model.CodigoIso == "VE" && model.ZonaNuevoProlM) {
                msg = '<h3 class="text-primary">Tu pedido se guardó con éxito</h3>';
                msg += '<p class="text-small">Te recordamos que el monto mínimo para pasar pedido es de Bs.700.</p>';
                msg += '<p class="text-small">Los productos EXPOFERTAS e IMPERDIBLES CYZONE no suman para el monto mínimo.</p>';
            } else if (model.CodigoIso == "CO" && model.ZonaNuevoProlM) {
                msg = '<h3 class="text-primary">Tu pedido se guardó con éxito</h3>';
                msg += '<p>' + mensajeGuardarCO + '</p>';
            } else {
                msg = '<h3 class="text-primary">Tu pedido se guardó con éxito</h3>';
            }
            messageInfo(msg);
            CargarPedido();
            return true;
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                var mensaje_ = "Por favor, vuelva a intentarlo";
                if (data.mensaje != undefined || data.mensaje != null) {
                    mensaje_ = data.mensaje;
                }
                messageInfo('<h3 class="text-primary">' + mensaje_ + '</h3>')
                console.error(data);
            }
        }
    });
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
            mensajePedido += "Tu pedido fue guardado con éxito.";

            $("#modal-prol-titulo").html(mensajePedido);
            $("#modal-prol-contenido").html("");

        } else {
            mensajePedido += "Tu pedido fue guardado con éxito.";

            $("#modal-prol-titulo").html(mensajePedido);
            $("#modal-prol-contenido").html("Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.");

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

    var htmlObservacionesPROL = "<ul class='text-left' style='padding-left: 15px;'>";
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
        } else {
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
                        $('#popup-observaciones-prol').modal('hide');
                        messageInfo('<h3 class="text-primary">Tu pedido se guardó con éxito</h3>');
                        CargarPedido();
                    } else
                        location.href = urlPedidoValidado;
                } else {
                    messageInfo(data.message);
                }
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data))
                messageInfo("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
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
                        $('#popup-observaciones-prol').modal('hide');
                    } else {
                        messageInfo(data.message);
                    }
                }
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data))
                    messageInfo("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");                
            }
        });
    } else {
        $('#popup-observaciones-prol').modal('hide');
    }
}
// Fin PROL