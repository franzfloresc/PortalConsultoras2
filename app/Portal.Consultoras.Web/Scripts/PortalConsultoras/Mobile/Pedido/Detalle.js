
$(document).ready(function () {
    CargarPedido();
});

function CargarPedido() {
    ShowLoading();
    $('#divProductosDetalle').empty();
    jQuery.ajax({
        type: 'POST',
        url: urlDetallePedido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            CloseLoading();
            if (!checkTimeout(data)) {
                return false;
            }

            SetHandlebars("#template-Detalle", data.data, '#divProductosDetalle');

            var divMensajeCierreCampania = $("#divMensajeCierreCampania").html();
            divMensajeCierreCampania = divMensajeCierreCampania.replace("&lt;p&gt;", "<p>");
            divMensajeCierreCampania = divMensajeCierreCampania.replace("&lt;b&gt;", "<b>");
            divMensajeCierreCampania = divMensajeCierreCampania.replace("&lt;/b&gt;", "</b>");
            divMensajeCierreCampania = divMensajeCierreCampania.replace("&lt;/p&gt;", "</b>");
            $("#divMensajeCierreCampania").html(divMensajeCierreCampania);

            if ($('#divProductosDetalle').find(".icono_advertencia_notificacion").length > 0) {
                $("#iconoAdvertenciaNotificacion").show();
            }

            $(".btn_guardarPedido").show();
            $("footer").hide();
        },
        error: function (error) {
            console.log(error);
            alert_msg('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
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

                Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion);
                
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
                UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi);
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
                    UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi);
                    $('#Cantidad_' + PedidoDetalleID).val(CantidadModi);
                } else
                    $('#Cantidad_' + PedidoDetalleID).val($('#CantidadTemporal_' + PedidoDetalleID).val());

                messageInfo("Lamentablemente, no puede actualizar la cantidad del Producto (" + CUV + "), ya que sobrepasa el stock actual (" + data.Stock + "), verifique.");

                CloseLoading();
                return false;
            }


            var PrecioUnidad = $('#PrecioUnidad_' + PedidoDetalleID).val();
            var Unidad = $('#PrecioUnidad_' + PedidoDetalleID).val();
            var Total = parseFloat(cantidadActual * Unidad).toFixed(2);
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

function UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi) {

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
    var Total = parseFloat(Cantidad * PrecioUnidad).toFixed(2);

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
        ClienteID_: "-1"
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

    $("#popup-eliminar-item").modal("show");

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
            dataType: 'html',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(param),
            async: true,
            success: function (html) {
                CloseLoading();
                CargarPedido();
                ActualizarCantidadTotalPedido();
                var descripcionMarca = GetDescripcionMarca(MarcaID);
                TagManagerClickEliminarProducto(DescripcionProd, CUV, PrecioUnidad, descripcionMarca, DescripcionOferta, Cantidad);
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
    $("#popup-eliminar-item").modal("hide");

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
        $("#divConfirmEliminarTotal").modal("show");
    }
}

function EliminarPedidoTotalNo() {
    $('#divConfirmEliminarTotal').modal("hide");
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
    var item = {};
    jQuery.ajax({
        type: 'POST',
        url: urlPedidoDeleteAll,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
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
function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion) {

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
    var Total = parseFloat(Cantidad * PrecioUnidad).toFixed(2);
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
        ClienteID_: "-1"
    };

    PedidoUpdate(item);
}

function PedidoUpdate(item, PROL) {
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
                    if (PROL == "0")
                        $('#CantidadTemporal_' + item.PedidoDetalleID).val($('#Cantidad_' + item.PedidoDetalleID).val());

                    CalcularTotalPedido(data.TotalFormato, data.Total_Minimo);
                    ActualizarCantidadTotalPedido();
                    CargarPedido();
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

function CalcularTotalPedido(Total, Total_Minimo) {

    $('#lblDescripcionTotal').html(Total);
}

function ActualizarCantidadTotalPedido() {
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlActualizarCantidadTotalPedido,
        dataType: 'json',
        async: true,
        success: function (response) {
            CloseLoading();
            if (checkTimeout(response)) {
                if (response.success) {
                    var data = response.data;
                    $(".num-menu-shop").html(data.CantidadProductos);
                    $(".lblCantidadProducto").html(data.CantidadProductos);
                    $(".lblDescripcionTotal").html(data.DescripcionTotal);
                } else {
                    window.messageInfo(response.message);
                }
            }
        },
        error: function (response, error) {
            CloseLoading();
            if (checkTimeout(response)) {
                console.error(response);
            }
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
        success: function (model) {

            CloseLoading();

            if (!model.ValidacionInteractiva) {
                messageInfo('<h3 class="text-primary">' + model.MensajeValidacionInteractiva + '</h3>');
                return false;
            }

            $("hdfPROLSinStock").val(model.PROLSinStock == true ? "1" : "0");
            $("hdfModificaPedido").val(model.EsModificacion == true ? "1" : "0");

            //var step = 0;
            //var botonEjecutarPROL = $.trim($('#btnGuardarPedido').text()).toLowerCase();
            var mensajePedidoCheckout = ConstruirObservacionesPROL(model);

            //if (!model.ErrorPROL) {
            //    if (model.ObservacionRestrictiva == false && model.ObservacionInformativa == false) {
            //        if (botonEjecutarPROL == "guardar pedido") {
            //            mensajePedidoCheckout = "Guardado con éxito";
            //        } else if (botonEjecutarPROL == "validar pedido") {
            //            mensajePedidoCheckout = "Satisfactoriamente";
            //        }
            //    }

            //    if (botonEjecutarPROL == "guardar pedido") {
            //        step = 1;
            //    } else if (botonEjecutarPROL == "validar pedido") {
            //        step = 2;
            //    }
            //}

            //var arrayProductoGuardado = new Array();
            //if (model.ListaProductos.length > 0 && step > 0) {

                //$.each(model.ListaProductos, function (index, item) {
                //    if (item.DescripcionEstrategia == null || item.DescripcionEstrategia == "") {
                //        item.DescripcionEstrategia = "Estándar";
                //    }

                //    if (item.Categoria == null || item.Categoria == "") {
                //        item.Categoria = "Sin Categoría";
                //    }

                //    arrayProductoGuardado.push({
                //        name: item.DescripcionProd,
                //        id: item.CUV,
                //        price: item.PrecioUnidad.toString(),
                //        brand: item.DescripcionMarca,
                //        category: item.Categoria,
                //        variant: item.DescripcionEstrategia,
                //        quantity: item.Cantidad
                //    });
                //});

                //var dataLayerAccion = 'Validar';
                //var dataLayerStep = 0;
                //if (botonEjecutarPROL == "guardar pedido") {
                //    dataLayerStep = 2;
                //    if (model.PeriodoAnalisisPedido == "Venta") {
                //        dataLayerAccion = 'Guardar';
                //        dataLayerStep = 1;
                //    }
                //}
                //else {
                //    if (botonEjecutarPROL == "validar pedido") {
                //        if (model.PeriodoAnalisisPedido == "Facturacion") {
                //            dataLayerStep = 2;
                //        }
                //    }
                //}

                //if (dataLayerStep > 0) {
                //    dataLayer.push({
                //        'event': 'productCheckout',
                //        'action': dataLayerAccion,
                //        'label': mensajePedidoCheckout,
                //        'ecommerce': {
                //            'checkout': {
                //                'actionField': { 'step': dataLayerStep, 'option': mensajePedidoCheckout },
                //                'products': arrayProductoGuardado
                //            }
                //        }
                //    });
                //}
            //}

            $('#btnGuardarPedido').text(model.BotonPROL);

            if (model.Reserva != true) {

                $('#modal-prol-botonesAceptarCancelar').hide();
                $('#modal-prol-botoneAceptar').show();
                $('#popup-observaciones-prol').modal("show");

                CargarPedido();
                return true;
            }

            if (model.ZonaValida == true) {
                if (model.ObservacionInformativa == false) {
                    if (model.PROLSinStock == true) {
                        messageInfo('<h3 class="text-primary">Tu pedido se guardó con éxito</h3>');
                        CargarPedido();
                        return true;
                    }

                    //dataLayer.push({
                    //    'event': 'productCheckout',
                    //    'action': 'Validado',
                    //    'ecommerce': {
                    //        'checkout': {
                    //            'actionField': { 'step': 3 },
                    //            'products': arrayProductoGuardado
                    //        }
                    //    }
                    //});

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
            if (model.CodigoISO == "VE" && model.ZonaNuevoProlM) {
                msg = '<h3 class="text-primary">Tu pedido se guardó con éxito</h3>';
                msg += '<p class="text-small">Te recordamos que el monto mínimo para pasar pedido es de Bs.700.</p>';
                msg += '<p class="text-small">Los productos EXPOFERTAS e IMPERDIBLES CYZONE no suman para el monto mínimo.</p>';
            } else if (model.CodigoISO == "CO" && model.ZonaNuevoProlM) {
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

    if (model.ErrorPROL) {
        mensajePedido += "-1 " + model.ListaObservacionesPROL[0].Descripcion;

        $("#modal-prol-titulo").html("ERROR");
        $("#modal-prol-contenido").html(mensajePedido);

        return mensajePedido;
    }

    if (model.ObservacionRestrictiva == false && model.ObservacionInformativa == false) {

        if (model.PROLSinStock) {
            mensajePedido += "¡Lo lograste! Tu pedido fue guardado con éxito.";

            $("#modal-prol-titulo").html(mensajePedido);
            $("#modal-prol-contenido").html("");

        } else {
            mensajePedido += "¡Lo lograste! Tu pedido fue guardado con éxito.";

            $("#modal-prol-titulo").html(mensajePedido);
            $("#modal-prol-contenido").html("Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.");

            mensajePedido += " Recuerda, al final de tu campaña valida tu pedido para reservar tus productos.";
        }

        mensajePedido = "-1 " + mensajePedido;

        return mensajePedido;

    }

    if (model.EsDiaPROL) {
        $("#modal-prol-titulo").html("IMPORTANTE");
    } else {
        $("#modal-prol-titulo").html("AVISO");
    }

    var htmlObservacionesPROL = "<ul class='text-left' style='padding-left: 15px;'>";
    $.each(model.ListaObservacionesPROL, function (index, item) {

        if (model.CodigoISO == "BO" || model.CodigoISO == "MX") {

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