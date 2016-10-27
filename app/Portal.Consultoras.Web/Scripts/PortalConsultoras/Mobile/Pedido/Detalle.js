var tipoOfertaFinal_Log = "";
var gap_Log = 0;
var tipoOrigen = '2';

var esPedidoValidado = false; /* SB20-565 */

$(document).ready(function () {

    ReservadoOEnHorarioRestringido(false);
    $('body').on('click', ".icono_kitNuevas a", function (e) {
        var mostrar = $(this).next();
        if (mostrar.css("display") == "none") mostrar.fadeIn(200);
        else mostrar.fadeOut(200);
    });

    ValidarKitNuevas();

    /* SB20-565 - INICIO */

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

    $("body").on("click", ".agregarOfertaFinal", function () {
        ShowLoading();

        var divPadre = $(this).parents("[data-item='ofertaFinal']").eq(0);
        var cuv = $(divPadre).find(".hdOfertaFinalCuv").val();
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var tipoOfertaSisID = $(divPadre).find(".hdOfertaFinalTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdOfertaFinalConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdOfertaFinalIndicadorMontoMinimo").val();
        var tipo = $(divPadre).find(".hdOfertaFinalTipo").val();
        var marcaID = $(divPadre).find(".hdOfertaFinalMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdOfertaFinalPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdOfertaFinalDescripcionProd").val();
        var pagina = $(divPadre).find(".hdOfertaFinalPagina").val();
        var descripcionCategoria = $(divPadre).find(".hdOfertaFinalDescripcionCategoria").val();
        var descripcionMarca = $(divPadre).find(".hdOfertaFinalDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdOfertaFinalDescripcionEstrategia").val();

        if (!isInt(cantidad)) {
            alert_msg("La cantidad ingresada debe ser un número mayor que cero, verifique");
            CloseLoading();
            return false;
        }

        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            CloseLoading();
            return false;
        }

        var model = {
            TipoOfertaSisID: tipoOfertaSisID,
            ConfiguracionOfertaID: configuracionOfertaID,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            MarcaID: marcaID,
            Cantidad: cantidad,
            PrecioUnidad: precioUnidad,
            CUV: cuv,
            Tipo: tipo,
            DescripcionProd: descripcionProd,
            Pagina: pagina,
            DescripcionCategoria: descripcionCategoria,
            DescripcionMarca: descripcionMarca,
            DescripcionEstrategia: descripcionEstrategia,
            EsSugerido: false,
            OrigenPedidoWeb: MobilePedidoOfertaFinal
        };

        InsertarProducto(model);
        AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_Log, gap_Log, 1);
        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
        
        setTimeout(function () {
            $("#popupOfertaFinal").hide();
            EjecutarServicioPROLSinOfertaFinal();
        }, 1000);
        
    });

    $('#btnNoGraciasOfertaFinal, #lnkCerrarPopupOfertaFinal').click(function () {
        var esMontoMinimo = $("#divIconoOfertaFinal").attr("class") == "icono_exclamacion";

        $("#popupOfertaFinal").hide();
        if (!esMontoMinimo) {
            var data = $("#btnNoGraciasOfertaFinal")[0].data;
            MostrarMensajeProl(data);
        }
    });

    /* SB20-565 - FIN */
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
        DescripcionOferta: $("#DescripcionOferta_" + id).val(),
        EsBackOrder: $("#EsBackOrder_" + id).val()
    };
}

// Actualizar pedido delsde el detalle => Cantidad Detalle

function UpdateLiquidacionEvento(evento) {
    var obj = $(evento.currentTarget);    
    var id = $.trim(obj.attr("data-pedidodetalleid")) || "0";
    if (parseInt(id, 10) <= 0 || parseInt(id, 10) == NaN) {
        return false;
    }

    if (ReservadoOEnHorarioRestringido()) {     
        $('#Cantidad_'+id).val($("#CantidadTemporal_" + id).val());
        return false;
    }

    var obj = GetProductoEntidad(id);

    UpdateLiquidacionSegunTipoOfertaSis(obj.CampaniaID, obj.PedidoID, obj.PedidoDetalleID, obj.TipoOfertaSisID, obj.CUV, obj.FlagValidacion, obj.CantidadInicial, obj.EsBackOrder);

}

function UpdateLiquidacionSegunTipoOfertaSis(CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder) {

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
        UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder);
    }
    else {

        var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
        var cantidadAnterior = $('#CantidadTemporal_' + PedidoDetalleID).val();

        if (Cantidad.length == 0 || parseInt(Cantidad) == NaN) {
            messageInfoMalo('Por favor ingrese una cantidad válida.');
            $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
            return false;
        }

        if (parseInt(Cantidad) <= 0) {
            messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
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
                    messageInfoMalo(datos.message);
                    $('#Cantidad_' + PedidoDetalleID).val(cantidadAnterior);
                    return false;
                }

                Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, EsBackOrder);
                
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data))
                    console.error(data);
            }
        });
    }
}

function UpdateLiquidacionTipoOfertaSis(urls, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, EsBackOrder) {

    var cantidadActual = parseInt($('#Cantidad_' + PedidoDetalleID).val());
    var cantidadAnterior = parseInt($('#CantidadTemporal_' + PedidoDetalleID).val());

    if (cantidadActual == cantidadAnterior || cantidadActual == NaN || cantidadAnterior == NaN)
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
    var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
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
        CUV: CUV,
        EsBackOrder: EsBackOrder
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
            success: function (data) {
                CloseLoading();
                if (!checkTimeout(data))
                    return false;

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
                alert_msg(data.message);
                return false;
            }

            ShowLoading();
            ActualizarGanancia(data.DataBarra);
            CargarPedido();
            messageDelete('Te entregaremos el producto en la siguiente campaña.');
            CloseLoading();
        },
        error: function (data, error) { CloseLoading(); }
    });
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
            location.reload();
          
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
function Update(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, EsBackOrder) {
    var CliID = $('#ClienteID_' + PedidoDetalleID).val();
    var CliDes = $('#ClienteNombre_' + PedidoDetalleID).val();
    var Cantidad = $('#Cantidad_' + PedidoDetalleID).val();
    var CantidadAnti = $('#CantidadTemporal_' + PedidoDetalleID).val();
    var DesProd = $('#DescripcionProducto_' + PedidoDetalleID).html();
    
    if (Cantidad.length == 0) {
        messageInfoMalo('Por favor ingrese una cantidad válida.');
        return false;
    }

    if (Cantidad == 0) {
        messageInfoMalo('Por favor ingrese una cantidad mayor a cero.');
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
            if (item.EsBackOrder == 'true') messageInfo('Recuerda que debes volver a validar tu pedido.');
                    
            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
                TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), item.CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), item.CUV);
                
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
    messageInfoValidado('<h3>' + message + '</h3>', fnClose);
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
        if ($('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').hasClass('icono_alerta check_icono_mobile'))
        {
            $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').removeClass("icono_alerta check_icono_mobile");
            $('#popup-observaciones-prol .content_mensajeAlerta #iconoPopupMobile').addClass("icono_alerta exclamacion_icono_mobile");
            $('#popup-observaciones-prol .content_mensajeAlerta .titulo_compartir').html("<b>IMPORTANTE</b>");
        }
        EjecutarServicioPROL();
    } else {
        messageInfoMalo('No existen productos en su Pedido.');
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
            RespuestaEjecutarServicioPROL(response);
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                var mensaje_ = "Por favor, vuelva a intentarlo";
                if (data.mensaje != undefined || data.mensaje != null) {
                    mensaje_ = data.mensaje;
                }
                messageInfoMalo('<h3>' + mensaje_ + '</h3>')
                //console.error(data);
            }
        }
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
            RespuestaEjecutarServicioPROL(response, false);
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                var mensaje_ = "Por favor, vuelva a intentarlo";
                if (data.mensaje != undefined || data.mensaje != null) {
                    mensaje_ = data.mensaje;
                }
                messageInfoMalo('<h3>' + mensaje_ + '</h3>')
                console.error(data);
            }
        }
    });
}

function RespuestaEjecutarServicioPROL(response, inicio) {
    inicio = inicio == null || inicio == undefined ? true : inicio;
    var model = response.data;

    var montoEscala = model.MontoEscala;
    var montoPedido = model.Total - model.MontoDescuento;

    CloseLoading();

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
        $("#btnNoGraciasOfertaFinal")[0].data = response.data;
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

                messageInfoBueno('<h3>Tu pedido fue validado con éxito</h3><p>Tus productos fueron reservados.</p>');
                //PEDIDO VALIDADO
                AnalyticsGuardarValidar(response);
                AnalyticsPedidoValidado(response);
                setTimeout(function () {
                    location.href = urlPedidoValidado;
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

/* SB20-565 - FIN */

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
                        $('#popup-observaciones-prol').hide();
                        messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
                        CargarPedido();
                    } else
                        location.href = urlPedidoValidado;
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
// Fin PROL

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

    //$('#tituloGanancia').text($('#hdeCabezaEscala').val());
    //$('#lbl1DetaGanancia').text($('#hdeLbl1DetaGanancia').val());
    //$('#lbl2DetaGanancia').text($('#hdeLbl2DetaGanancia').val());
    //$('#pieGanancia').text($('#hdePieEscala').val());

    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').show();
}


/* SB20-565 - INICIO */

function InsertarProducto(model) {
    jQuery.ajax({
        type: 'POST',
        url: urlPedidoInsert,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: true,
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

            setTimeout(function () {
                //$("#divMensajeProductoAgregado").show();
            }, 2000);

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
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });

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

            messageInfoBueno('<h3>Tu pedido fue validado con éxito</h3><p>Tus productos fueron reservados.</p>');
            //PEDIDO VALIDADO
            //AnalyticsGuardarValidar(response);
            //AnalyticsPedidoValidado(response);
            setTimeout(function () {
                location.href = urlPedidoValidado;
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
    //AnalyticsGuardarValidar(response);
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

/* SB20-565 - FIN */
