

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
        //AbrirSplash();
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
            //$('.liquidacion_rango_cantidad_pedido').val(1);
            //CerrarSplash();
            CloseLoading();
            //limpiarInputsPedido();
            return false;
        }

        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            //$('.liquidacion_rango_cantidad_pedido').val(1);
            //CerrarSplash();
            CloseLoading();
            return false;
        } else {
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
                EsSugerido: false
            };

            console.log('agregar:');
            console.log(model);
            //AgregarProducto('Insert', model, "", false);
            AgregarProductoListado(model);

            setTimeout(function () {
                $("#popupOfertaFinal").hide();
                EjecutarServicioPROLSinOfertaFinal();
            }, 1000);
        }
    });

    $('#btnNoGraciasOfertaFinal, #lnkCerrarPopupOfertaFinal').click(function () {
        var esMontoMinimo = $("#divIconoOfertaFinal").attr("class") == "icono_exclamacion";

        if (esMontoMinimo) {
            $("#popupOfertaFinal").hide();
        } else {
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

    if (ReservadoOEnHorarioRestringido()) {     
        $('#Cantidad_'+id).val($("#CantidadTemporal_" + id).val());
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
                UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV);
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
                    UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, CUV);
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
                TrackingJetloreRemove(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                dataLayer.push({
                    'event': 'removeFromCart',
                    'ecommerce': {
                        'remove': {
                            'products': [{
                                'name': html.data.DescripcionProducto,
                                'id': html.data.CUV,
                                'price': html.data.Precio,
                                'brand': html.data.DescripcionMarca,
                                'category': 'NO DISPONIBLE',
                                'variant': html.data.DescripcionOferta,
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
            if (checkTimeout(data)) {
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
        messageInfoMalo('<h3>No existen productos en su Pedido.</h3>');
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

            /*SB20-565 - INICIO */
            var codigoMensajeProl = response.data.CodigoMensajeProl;
            var cumpleOferta;
            /*SB20-565 - FIN */

            if (model.Reserva != true) {

                /* SB20-565 - INICIO */
                //$('#modal-prol-botonesAceptarCancelar').hide();
                //$('#modal-prol-botoneAceptar').show();                 
                //$('#popup-observaciones-prol').show();
                
                //$('#DivObsBut').css({ "display": "block" });
                //$('#DivObsInfBut').css({ "display": "none" });
                                
                $("#btnNoGraciasOfertaFinal")[0].data = response.data;
                codigoMensajeProl = response.data.CodigoMensajeProl;

                cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 2, codigoMensajeProl, response.data.ListaObservacionesProl);
                //console.log(cumpleOferta);

                if (cumpleOferta.resultado) {
                    MostrarPopupOfertaFinal(cumpleOferta, 2);
                } else {
                    //showDialog("divObservacionesPROL");
                    //$("#divObservacionesPROL").css("width", "600px").parent().css("left", "372px");

                    $('#modal-prol-botonesAceptarCancelar').hide();
                    $('#modal-prol-botoneAceptar').show();
                    $('#popup-observaciones-prol').show();
                }
                //CargarDetallePedido();
                /* SB20-565 - FIN */

                CargarPedido();
                return true;
            }

            if (model.ZonaValida == true) {
                console.log('ZonaValida == true');
                if (model.ObservacionInformativa == false) {
                   // console.log('ObservacionInformativa == false')

                    //if (model.ProlSinStock == true) {
                    //    messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
                    //    CargarPedido();
                    //    return true;
                    //}

                    /* SB20-565 - INICIO */
                    cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
                    //console.log(cumpleOferta);

                    if (cumpleOferta.resultado) {
                        esPedidoValidado = response.data.ProlSinStock != true;
                        MostrarPopupOfertaFinal(cumpleOferta, 1);
                    } else {
                        if (response.data.ProlSinStock == true) {
                            //showDialog("divReservaSatisfactoria3");
                            //CargarDetallePedido();

                            messageInfoBueno('<h3>Tu pedido se guardó con éxito</h3>');
                            CargarPedido();
                            return true;
                        }
                    }
                    /* SB20-565 - FINAL */

                    messageInfoBueno('<h3>Tu pedido fue validado con éxito</h3><p>Tus productos fueron reservados.</p>');
                    //PEDIDO VALIDADO
                    AnalyticsGuardarValidar(response);
                    AnalyticsPedidoValidado(response);
                    setTimeout(function () {
                        location.href = urlPedidoValidado;
                    }, 2000);

                    return true;
                }

                /* SB20-565 - INICIO */
                cumpleOferta = CumpleOfertaFinal(response.data.MontoEscala, 1, codigoMensajeProl, response.data.ListaObservacionesProl);
                console.log(cumpleOferta);

                if (cumpleOferta.resultado) {
                    esPedidoValidado = response.data.ProlSinStock != true;
                    MostrarPopupOfertaFinal(cumpleOferta, 1);
                } else {
                    $('#modal-prol-botonesAceptarCancelar').show();
                    $('#modal-prol-botoneAceptar').hide();
                    $('#popup-observaciones-prol').show();

                    CargarPedido();
                    return true;
                }
            }
            
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
            var model = response.data;
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

            if (model.Reserva != true) {
                $('#modal-prol-botonesAceptarCancelar').hide();
                $('#modal-prol-botoneAceptar').show();
                $('#popup-observaciones-prol').show();
                AnalyticsGuardarValidar(response);
                CargarPedido();
                return true;
            }

            if (model.ZonaValida == true) {
                if (model.ObservacionInformativa == false) {
                    if (model.ProlSinStock == true) {
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
                    return true;
                }

                $('#modal-prol-botonesAceptarCancelar').show();
                $('#modal-prol-botoneAceptar').hide();
                $('#popup-observaciones-prol').show();

                AnalyticsGuardarValidar(response);
                CargarPedido();
                return true;
            }

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
            AnalyticsGuardarValidar(response);
            messageInfoBueno(msg);
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
                messageInfoMalo('<h3>' + mensaje_ + '</h3>')
                console.error(data);
            }
        }
    });
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
function AgregarProductoListado(model) {
    console.log('AgregarProductoListado');
    ShowLoading();

    //if (ReservadoOEnHorarioRestringido()) {
    //    CloseLoading();
    //    return false;
    //}

    //var CUV = $('#hdfCUV').val();
    //$("#hdCuvRecomendado").val(CUV);
    //$("#btnAgregarProducto").attr("disabled", "disabled");
    //$("#btnAgregarProducto").hide();

    //var tipoOferta = $("#hdTipoOfertaSisID").val();

    //var Cantidad = $("#txtCantidad").val();

    //var param = ({
    //    MarcaID: 0,
    //    CUV: CUV,
    //    PrecioUnidad: 0,
    //    Descripcion: 0,
    //    Cantidad: Cantidad,
    //    IndicadorMontoMinimo: 0,
    //    TipoOferta: $("#hdTipoEstrategiaID").val()
    //});

    //jQuery.ajax({
    //    type: 'POST',
    //    url: urlValidarStockEstrategia,
    //    dataType: 'json',
    //    contentType: 'application/json; charset=utf-8',
    //    //data: JSON.stringify(param),
    //    data: JSON.stringify(model),
    //    async: true,
    //    success: function (datos) {
    //        if (!datos.result) {
    //            MostrarMensaje("mensajeCUVCantidadMaxima", datos.message);
    //            CloseLoading();
    //        } else {
    //            InsertarProducto();
    //            return true;
    //        }
    //    },
    //    error: function (data, error) {
    //        CloseLoading();
    //        if (checkTimeout(data)) {
    //            //$("#btnAgregarProducto").show();
    //            //$("#btnAgregarProducto").removeAttr("disabled");
    //            console.error(data);
    //        }
    //    }
    //});

    InsertarProducto(model);
};

function InsertarProducto(model) {
    console.log('InsertarProducto');

    //var esOfertaNueva = $("#hdfValorFlagNueva").val() === "1";
    //var urlInsertar = esOfertaNueva ? urlInsertOfertaNueva : urlInsert;
    //var model;

    //if (!esOfertaNueva) {
    //    model = {
    //        Tipo: 1,
    //        CUVComplemento: "",
    //        MarcaIDComplemento: 0,
    //        PrecioUnidadComplemento: 0,
    //        IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
    //        TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
    //        ConfiguracionOfertaID: $("#hdConfiguracionOfertaID").val(),
    //        Registros: "",
    //        RegistrosDe: "",
    //        RegistrosTotal: "",
    //        Pagina: "",
    //        PaginaDe: "",
    //        ClienteID_: "",
    //        DescripcionEstrategia: "",
    //        DescripcionLarga: "",
    //        CUV: $("#hdfCUV").val(),
    //        MarcaID: $("#hdfMarcaID").val(),
    //        PrecioUnidad: $("#hdfPrecioUnidad").val(),
    //        DescripcionProd: $("#divNombreProducto").html(),
    //        Cantidad: $("#txtCantidad").val(),
    //        ClienteID: $("#ddlClientes").val(),
    //        ClienteDescripcion: $("#ddlClientes option:selected").text()
    //    };

    //} else {
    //    model = {
    //        MarcaID: $("#hdfMarcaID").val(),
    //        CUV: $("#hdfCUV").val(),
    //        PrecioUnidad: $("#hdfPrecioUnidad").val(),
    //        Descripcion: $("#divNombreProducto").html(),
    //        Cantidad: $("#txtCantidad").val(),
    //        IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
    //        TipoOferta: $("#hdTipoOfertaSisID").val(),
    //        tipoEstrategiaImagen: esOfertaNueva ? 2 : $("#hdfValorFlagNueva").val()
    //    };
    //}

    jQuery.ajax({
        type: 'POST',
        url: urlInsertar,
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

            CloseLoading();

            if (data.success == true) {
                setTimeout(function () {
                    //$("#divMensajeProductoAgregado").show();
                }, 2000);

                ActualizarGanancia(data.DataBarra);

                //var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
                //if (existeError == "1") {
                //    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Ocurrió un error al ejecutar la operación.</div>');
                //    $("#btnAgregarProducto").show();
                //    $("#btnAgregarProducto").removeAttr("disabled");
                //    CloseLoading();
                //    return false;
                //}
                //$('#divMensajeCUV').hide();
                //$("#divProductoObservaciones").html("");
                //$("#divProductoMantenedor").hide();
                //$("#btnAgregarProducto").hide();
                //$("#divListaEstrategias").show();
                //$("#divResumenPedido").show();
                //$("footer").show();
                //$(".footer-page").css({ "margin-bottom": "0px" });

                //var cuv = $("#hdfCUV").val();
                //CargarCarouselEstrategias(cuv);

                //PedidoOnSuccess();

                //$("#hdCuvEnSession").val("");

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

            } else {
                //$("#btnAgregarProducto").removeAttr("disabled", "disabled");
                //$("#btnAgregarProducto").show();
                messageInfoMalo(data.message);
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });

};

function MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar) {
    //$('.js-slick-prev-of').remove();
    //$('.js-slick-next-of').remove();

    $('.js-slick-prev-h').remove();
    $('.js-slick-next-h').remove();

    $('#divCarruselOfertaFinal.slick-initialized').slick('unslick');

    $('#divCarruselOfertaFinal').html('<div style="text-align: center;">Actualizando Productos de Oferta Final<br><img src="' + urlLoad + '" /></div>');

    SetHandlebars("#ofertaFinal-template", cumpleOferta.productosMostrar, "#divCarruselOfertaFinal");

    //$("#divOfertaFinal").show();

    $('#divCarruselOfertaFinal').slick({
        infinite: true,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        //centerMode: false,
        //centerPadding: '0',
        //tipo: 'p', // popup
        speed: 300,
        //prevArrow: '<a class="previous_ofertas js-slick-prev-of"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
        //nextArrow: '<a class="previous_ofertas next js-slick-next-of"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
        prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: 0.5%; top: 7%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png" style="width:100%; height:auto;" /></a>',
        nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right: 0.5%; top: 7%;"><img src="/Content/Images/mobile/Esika/next.png" style="width:100%; height:auto;" /></a>'
    });

    //$('#divCarruselOfertaFinal').prepend($(".js-slick-prev-of"));
    //$('#divCarruselOfertaFinal').prepend($(".js-slick-next-of"));

    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-h"));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-h"));

    CargandoValoresPopupOfertaFinal(tipoPopupMostrar, cumpleOferta.montoFaltante, cumpleOferta.porcentajeDescuento);
}

function CargandoValoresPopupOfertaFinal(tipoPopupMostrar, montoFaltante, porcentajeDescuento) {
    var formatoMontoFaltante = DecimalToStringFormat(montoFaltante);
    if (tipoPopupMostrar == 1) {
        $("#divIconoOfertaFinal").addClass("icono_aprobacion");
        $("#spnTituloOfertaFinal").html("GUARDASTE TU <b>PEDIDO CON ÉXITO !</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $("#spnMensajeOfertaFinal").html("para ganar más esta campaña.");
        if (viewBagPaisID == 11) {
            $("#spnSubTituloOfertaFinal").html("Gana mas con estas ofertas que tenemos solo para ti");
        } else if (viewBagPaisID == 3) {
            $("#spnSubTituloOfertaFinal").html("Gana mas con estas ofertas que tenemos solo para ti");
        }
    }
    else {
        $("#divIconoOfertaFinal").addClass("icono_exclamacion");
        $("#spnTituloOfertaFinal").html("TODAVIA<b>&nbsp;TE FALTA UN POCO</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $("#spnMensajeOfertaFinal").html("&nbsp;para llegar al monto mínimo y guardar tu pedido");
        if (viewBagPaisID == "11") {
            $("#spnSubTituloOfertaFinal").html("Completa tu pedido con estas ofertas que tenemos solo para ti.");
        } else if (viewBagPaisID == "3") {
            $("#spnSubTituloOfertaFinal").html("Completa tu pedido con estos productos que tenemos para ti.");
        }
    }

    $("#popupOfertaFinal").show();
}

function CumpleOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var resultado = false;
    var productosMostrar = new Array();
    var montoFaltante = 0;
    var porcentajeDescuento = 0;

    var tipoOfertaFinal = $("#hdOfertaFinal").val();
    var esOfertaFinalZonaValida = $("#hdEsOfertaFinalZonaValida").val();
    var esFacturacion = $("#hdEsFacturacion").val();

    if (tipoOfertaFinal == "1" || tipoOfertaFinal == "2")
        resultado = true;

    if (resultado) {
        if (esFacturacion == "True" && esOfertaFinalZonaValida == "True")
            resultado = true;
        else
            resultado = false;
    }

    if (resultado) {
        var cumpleParametria = CumpleParametriaOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
        if (cumpleParametria.resultado) {
            montoFaltante = cumpleParametria.montoFaltante;
            porcentajeDescuento = cumpleParametria.porcentajeDescuento;
            var productoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);
            var listaProductoOfertaFinal = productoOfertaFinal.lista;
            var limite = productoOfertaFinal.limite;

            if (listaProductoOfertaFinal != null) {
                var contador = 0;
                $.each(listaProductoOfertaFinal, function (index, value) {
                    if (value.PrecioCatalogo >= montoFaltante && value.PrecioCatalogo > cumpleParametria.precioMinimoOfertaFinal) {
                        productosMostrar.push(value);
                        contador++;
                        //return false;

                        if (contador >= limite)
                            return false;
                    }
                });

                if (productosMostrar.length == 0) {
                    resultado = false;
                } else {
                    resultado = true;
                }
            } else {
                resultado = false;
            }
        }
        else
            resultado = false;
    }

    return {
        resultado: resultado,
        productosMostrar: productosMostrar,
        montoFaltante: montoFaltante,
        porcentajeDescuento: porcentajeDescuento
    };
}

function CumpleParametriaOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var resultado = false;
    var montoFaltante = 0;
    var porcentajeDescuento = 0;
    var precioMinimoOfertaFinal = 0;

    //Escala
    if (tipoPopupMostrar == 1) {
        var esConsultoraNueva = $("#hdEsConsultoraNueva").val();
        if (esConsultoraNueva == "False") {
            if (codigoMensajeProl == "00") {
                var escalaDescuento = null;
                var escalaDescuentoSiguiente = null;

                $.each(listaEscalaDescuento, function (index, value) {
                    if (value.MontoHasta >= monto) {
                        escalaDescuento = value;

                        if (index <= listaEscalaDescuento.length - 1) {
                            escalaDescuentoSiguiente = listaEscalaDescuento[index + 1];
                        } else {
                            escalaDescuentoSiguiente = null;
                        }

                        return false;
                    }
                });

                if (escalaDescuento == null) {
                    resultado = false;
                } else {
                    var diferenciaMontoEd = escalaDescuento.MontoHasta - monto;
                    var parametriaEd = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "E" + escalaDescuento.PorDescuento) : null;

                    if (parametriaEd != null && parametriaEd.length != 0) {
                        if (parametriaEd[0].MontoDesde <= diferenciaMontoEd && parametriaEd[0].MontoHasta >= diferenciaMontoEd) {
                            montoFaltante = diferenciaMontoEd;
                            porcentajeDescuento = escalaDescuentoSiguiente.PorDescuento;
                            precioMinimoOfertaFinal = parametriaEd[0].PrecioMinimo;
                            resultado = true;
                        } else {
                            resultado = false;
                        }
                    } else {
                        resultado = false;
                    }
                }
            }
        }
    } else {
        //Monto Minimo y Maximo
        if (codigoMensajeProl == "01") {
            if (listaObservacionesProl.length == 1) {
                var tipoError = listaObservacionesProl[0].Caso;

                if (tipoError == 95) {
                    //var mensajePedido = listaObservacionesProl[0].Descripcion || "";
                    var mensajeCUV = listaObservacionesProl[0].CUV;

                    if (mensajeCUV == "XXXXX") {
                        var montoMinimo = parseFloat($("#hdMontoMinimo").val());
                        var diferenciaMonto = montoMinimo - monto;

                        var parametria = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "MM") : null;

                        if (parametria != null && parametria.length != 0) {
                            if (parametria[0].MontoDesde <= diferenciaMonto && parametria[0].MontoHasta >= diferenciaMonto) {
                                montoFaltante = diferenciaMonto;
                                precioMinimoOfertaFinal = parametria[0].PrecioMinimo;
                                resultado = true;
                            } else {
                                resultado = false;
                            }
                        } else {
                            resultado = false;
                        }
                    } else {
                        resultado = false;
                    }
                } else {
                    resultado = false;
                }
            }
            else {
                resultado = false;
            }
        }
    }

    return {
        resultado: resultado,
        montoFaltante: montoFaltante,
        porcentajeDescuento: porcentajeDescuento,
        precioMinimoOfertaFinal: precioMinimoOfertaFinal
    };
}

function ObtenerProductosOfertaFinal(tipoOfertaFinal) {
    var item = { tipoOfertaFinal: tipoOfertaFinal };

    var lista = null;
    var limite = 0;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerProductosOfertaFinal',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    lista = response.data;
                    limite = response.limiteJetlore;
                } else {
                    lista = null;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
                lista = null;
                //CerrarSplash();
            }
        }
    });

    return {
        lista: lista,
        limite: limite
    };
}

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