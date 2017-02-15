
var arrayOfertasParaTi = [];

$(document).ready(function () {
    ReservadoOEnHorarioRestringido(false);
    $("#divProductoMantenedor").hide();
    $(".btn_verMiPedido").on("click", function () {
        window.location.href = baseUrl + "Mobile/Pedido/Detalle";
    });
    $("#txtCodigoProducto").on("keyup", function () {
        $('#divMensajeCUV').hide();
        posicion = -1;
        var codigo = $("#txtCodigoProducto").val();

        $("#txtCantidad").removeAttr("disabled");
        $("#divProductoMantenedor").hide();
        $("#divResumenPedido").hide();
        $("#btnAgregarProducto").hide();
        $('#PopSugerido').hide();

        if (codigo == "") {
            VisibleEstrategias(true);
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });
        } else {
            VisibleEstrategias(false);
            $("footer").hide();
        };

        if (codigo.length == 5) {
            $("#txtCodigoProducto").blur();
            BuscarByCUV(codigo);
        };
    });
    $(".ValidaAlfabeto").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return true;
        } else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-ZñÑáéíóúÁÉÍÓÚ' ]/;
            return re.test(keyChar);
        }
    });
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
    $("#btnAgregarProducto").click(function () {
        var cantidad = $.trim($("#txtCantidad").val());
        if (cantidad == "" || cantidad[0] == "-") {
            alert_msg("Ingrese una cantidad mayor que cero.");
            return false;
        }
        if (!isInt(cantidad)) {
            alert_msg("Ingrese una cantidad mayor que cero.");
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            alert_msg("Ingrese una cantidad mayor que cero.");
            return false;
        }

        var cantidadProductos = $.trim($("#txtCantidad").val()) || 0;
        if (cantidadProductos > 0) {
            AgregarProductoListado();
        };
    });

    $("body").on("click", ".btnAgregarSugerido", function () {
        ShowLoading();

        var divPadre = $(this).parents("[data-item='producto']").eq(0);
        var cuv = $(divPadre).find(".hdSugeridoCuv").val();
        var cantidad = $(divPadre).find(".rango_cantidad_pedido").val();
        var tipoOfertaSisID = $(divPadre).find(".hdSugeridoTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdSugeridoConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdSugeridoIndicadorMontoMinimo").val();
        var tipo = $(divPadre).find(".hdSugeridoTipo").val();
        var marcaID = $(divPadre).find(".hdSugeridoMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdSugeridoPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdSugeridoDescripcionProd").val();
        var pagina = $(divPadre).find(".hdSugeridoPagina").val();
        var descripcionCategoria = $(divPadre).find(".hdSugeridoDescripcionCategoria").val();
        var descripcionMarca = $(divPadre).find(".hdSugeridoDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdSugeridoDescripcionEstrategia").val();
        var OrigenPedidoWeb = MobilePedidoSugerido;

        if (!isInt(cantidad)) {
            alert_msg("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $(divPadre).find('.rango_cantidad_pedido').val(1);
            CloseLoading();
            //limpiarInputsPedido();
            return false;
        }
        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            $(divPadre).find('.rango_cantidad_pedido').val(1);
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
            EsSugerido: true,
            OrigenPedidoWeb: OrigenPedidoWeb
        };
        InsertarProductoSugerido(marcaID, cuv, precioUnidad, descripcionProd, cantidad, indicadorMontoMinimo, tipoOfertaSisID, OrigenPedidoWeb);
    });
    
    $("#linkAgregarCliente").on("click", function () {
        CerrarMantenerCliente();
        $("#divAgregarClientePedido").show();
    });

    CargarCarouselEstrategias("");

    var CuvEnSession = $.trim($("#hdCuvEnSession").val());
    if (CuvEnSession != "") {
        $("#txtCodigoProducto").val(CuvEnSession);
        $("#txtCodigoProducto").keyup();
    }

});

/** Buscar Producto **/
function ValidarPermiso(obj) {
    var permiso = $(obj).attr("disabled") || "";
    if (permiso != "") {
        return false;
    }
    return true;
};

function BuscarByCUV(cuv) {
    if (cuv == $('#hdfCUV').val()) {
        if (productoSugerido) {
            if (productoAgotado) MostrarMensaje("mensajeCUVAgotado");
            else $('#PopSugerido').show();
        }
        else {
            $("#divProductoMantenedor").show();
            $("#btnAgregarProducto").show();
        }
        return false;
    }

    $("#divProductoObservaciones").html('');
    productoSugerido = false;

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlFindByCUV,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ CUV: cuv }),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }

            $("#txtCantidad").removeAttr("disabled");
            var item = data[0];
            if (item.MarcaID == 0) {
                MostrarMensaje("mensajeCUVNoExiste");
                $("#divProductoInformacion").hide();
                $('#hdfCUV').val(cuv);
                $("#divProductoMantenedor").show();
                CloseLoading();
                if (item.TieneSugerido != 0) ObtenerProductosSugeridos(cuv);
                return false;
            }

            $("#hdTipoOfertaSisID").val(item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(item.ConfiguracionOfertaID);
            $("#hdTipoEstrategiaID").val(item.TipoEstrategiaID);

            CloseLoading();
            ObservacionesProducto(item);
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();

                if (data.message == "" || data.message === undefined) {
                    location.href = urlSesionExperirada;
                } else {
                    console.error(data);
                }
            }
        }
    });
};
function ObservacionesProducto(item) {
    $("#hdfValorFlagNueva").val(item.FlagNueva);
    if (item.FlagNueva == 1) {
        $("#txtCantidad").attr("disabled", "disabled");
    }

    if (item.TipoOfertaSisID == "1707") {
        if (sesionEsShowRoom == "1") {
            MostrarMensaje("mensajeCUVShowRoom", "Producto disponible sólo desde la sección de Pre-venta Digital.");
        } else {
            MostrarMensaje("mensajeCUVShowRoom", "Esta promoción no se encuentra disponible.");
        }

        $("#divProductoInformacion").hide();
        return false;
    }
    if (item.TieneSugerido != 0) {
        ObtenerProductosSugeridos(item.CUV);
        return false;
    }
    if (item.TieneStock === true) {
    	if (item.EsExpoOferta == true) MostrarMensaje("mensajeEsExpoOferta");
        if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
            MostrarMensaje("mensajeCUVOfertaEspecial");
        };

        var tipoOferta = $("#hdTipoOfertaSisID").val();
        if (tipoOferta == ofertaLiquidacion) {
            MostrarMensaje("mensajeCUVLiquidacion");
            return false;
        }
    }
    else {
        MostrarMensaje("mensajeCUVAgotado");
        return false;
    }

    $("#hdfCUV").val(item.CUV);
    $("#hdfDescripcionCategoria").val(item.DescripcionCategoria);

    $("#hdfDescripcionEstrategia").val(item.DescripcionEstrategia);
    $("#hdfDescripcionMarca").val(item.DescripcionMarca);
    $("#hdLimiteVenta").val(item.LimiteVenta);

    $("#hdfIndicadorMontoMinimo").val(item.IndicadorMontoMinimo);
    $("#hdfMarcaID").val(item.MarcaID);
    $("#hdfPrecioUnidad").val(item.PrecioCatalogo);
    $("#hdfDescripcionProd").val(item.Descripcion);
    $("#txtCodigoProducto").val(item.CUV);
    $("#txtCantidad").val("1");

    //Validar Si es nueva oferta para deshabilitar el input de cantidad
    $("#txtCantidad, #suma, #resta").attr("disabled", item.FlagNueva == "1");

    $("#spnPrecio").html(simbolo + " " + DecimalToStringFormat(item.PrecioCatalogo));

    //var paisColombia = "4";
    //if (paisColombia == paisIDSesion) {
    //    $("#spnPrecio").html(simbolo + " " + SeparadorMiles(parseFloat(item.PrecioCatalogo).toFixed(0)));
    //} else {
    //    $("#spnPrecio").html(simbolo + " " + parseFloat(item.PrecioCatalogo).toFixed(2));
    //}

    $("#divNombreProducto").html(item.Descripcion);

    $("#btnAgregarProducto").show();
    $("#btnAgregarProducto").removeAttr("disabled");
    $("#divProductoInformacion").show();
    $("#divProductoMantenedor").show();
};
function IngresoFAD(producto) {
    var item = {
        CUV: producto.CUV,
        PrecioUnidad: producto.PrecioCatalogo
    };

    jQuery.ajax({
        type: 'POST',
        url: urlIngresoFAD,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });
};
function ObtenerEstrategiaCoincidente(cuv) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);

    var estratgiaEncontrada;

    $.each(listaRecomendados, function (index, value) {
        if (cuv === value.CUV2) {
            estratgiaEncontrada = value;
        }
    });

    return estratgiaEncontrada;
};
function ObtenerProductosSugeridos(CUV) {
    $('.js-slick-prev-h').remove();
    $('.js-slick-next-h').remove();
    $('#divCarruselSugerido.slick-initialized').slick('unslick');
    
    $('#divCarruselSugerido').html('<div style="text-align: center;">Actualizando Productos Destacados<br><img src="' + urlLoad + '" /></div>');
    $("#divProductoInformacion").hide();

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerProductosSugeridos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ CUV: CUV }),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) { CloseLoading(); return false };
            $('#hdfCUV').val(CUV);
            productoSugerido = true;

            var lista = data;
            if (lista.length <= 0) {
                productoAgotado = true;
                MostrarMensaje("mensajeCUVAgotado");
                CloseLoading();
                return false;
            }
            productoAgotado = false;

            $("#divCarruselSugerido").html('');
            $('#PopSugerido').show();
            SetHandlebars("#js-CarruselSugerido", lista, '#divCarruselSugerido');
            //$("#divProductoObservaciones").html("");

            $('#divCarruselSugerido').slick({
                infinite: true,
                vertical: false,
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: false,
                speed: 300,
                prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: -13%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png"></a>',
                nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right: -13%;"><img src="/Content/Images/mobile/Esika/next.png")"/></a>'
            });
            $('#divCarruselSugerido').prepend($(".js-slick-prev-h"));
            $('#divCarruselSugerido').prepend($(".js-slick-next-h"));
            CloseLoading();
        },
        error: function (data, error) {
            CloseLoading();
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
function CancelarProductosSugeridos() {
    $("#txtCodigoProducto").val('');
    $("#txtCodigoProducto").trigger("keyup")
}
function InsertarProductoSugerido(marcaID, cuv, precioUnidad, descripcion, cantidad, indicadorMontoMinimo, tipoOferta, OrigenPedidoWeb) {
    ShowLoading();
    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    jQuery.ajax({
        type: 'POST',
        url: urlPedidoInsert,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
            MarcaID: marcaID,
            CUV: cuv,
            PrecioUnidad: precioUnidad,
            Descripcion: descripcion,
            Cantidad: cantidad,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            TipoOferta: tipoOferta,
            OrigenPedidoWeb: OrigenPedidoWeb
        }),
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

            ActualizarGanancia(data.DataBarra);
            var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
            if (existeError == "1") {
                alert_msg("Ocurrió un error al ejecutar la operación.");
                CloseLoading();
                return false;
            }

            CloseLoading();
            //$("#divMensajeProductoAgregado").show();
            
            $("#divProductoObservaciones").html("");
            VisibleEstrategias(true);
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });
            $('#PopSugerido').hide();

            CargarCarouselEstrategias(cuv);
            $("#txtCodigoProducto").val("");
            $("#hdCuvEnSession").val("");
            if (data.modificoBackOrder) messageInfo('Recuerda que debes volver a validar tu pedido.');
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                alert_msg(data);
            }
        }
    });
};

/** Insertar Pedido **/
function AgregarProductoListado() {
    ShowLoading();
    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    var CUV = $('#hdfCUV').val();
    $("#hdCuvRecomendado").val(CUV);
    $("#btnAgregarProducto").attr("disabled", "disabled");
    $("#btnAgregarProducto").hide();

    var tipoOferta = $("#hdTipoOfertaSisID").val();

    var Cantidad = $("#txtCantidad").val();

    var param = ({
        MarcaID: 0,
        CUV: CUV,
        PrecioUnidad: 0,
        Descripcion: 0,
        Cantidad: Cantidad,
        IndicadorMontoMinimo: 0,
        TipoOferta: $("#hdTipoEstrategiaID").val()
    });

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                MostrarMensaje("mensajeCUVCantidadMaxima", datos.message);
                CloseLoading();
            } else {
                InsertarProducto();
                return true;
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                $("#btnAgregarProducto").show();
                $("#btnAgregarProducto").removeAttr("disabled");
                console.error(data);
            }
        }
    });
};
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
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    ShowLoading();
                    location.href = urlValidadoPedido;
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    messageInfo(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) {
                messageInfo(data.message);
            }
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
};
function alert_msg(message, fnClose) {
    messageInfoValidado('<h3>' + message + '</h3>', fnClose);
};
function InsertarProducto() {
    var esOfertaNueva = $("#hdfValorFlagNueva").val() === "1";
    var urlInsertar = esOfertaNueva ? urlPedidoInsertZe : urlPedidoInsert;
    var model;
       
    if (!esOfertaNueva) {
        model = {
            Tipo: 1,
            CUVComplemento: "",
            MarcaIDComplemento: 0,
            PrecioUnidadComplemento: 0,
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
            ConfiguracionOfertaID: $("#hdConfiguracionOfertaID").val(),
            Registros: "",
            RegistrosDe: "",
            RegistrosTotal: "",
            Pagina: "",
            PaginaDe: "",
            ClienteID_: "",
            DescripcionEstrategia: "",
            DescripcionLarga: "",
            CUV: $("#hdfCUV").val(),
            MarcaID: $("#hdfMarcaID").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            DescripcionProd: $("#divNombreProducto").html(),
            Cantidad: $("#txtCantidad").val(),
            ClienteID: $("#ddlClientes").val(),
            ClienteDescripcion: $("#ddlClientes option:selected").text()
        };

    } else {
        model = {
            MarcaID: $("#hdfMarcaID").val(),
            CUV: $("#hdfCUV").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            Descripcion: $("#divNombreProducto").html(),
            Cantidad: $("#txtCantidad").val(),
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoOferta: $("#hdTipoOfertaSisID").val(),
            tipoEstrategiaImagen: esOfertaNueva ? 2 : $("#hdfValorFlagNueva").val()
        };
    }

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

            if (data.success != true) {
                $("#btnAgregarProducto").removeAttr("disabled", "disabled");
                $("#btnAgregarProducto").show();
                messageInfoError(data.message);
                CloseLoading();
                return false;
            }

            CloseLoading();

            setTimeout(function () {
                //$("#divMensajeProductoAgregado").show();
            }, 2000);

            ActualizarGanancia(data.DataBarra);
            var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
            if (existeError == "1") {
                $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Ocurrió un error al ejecutar la operación.</div>');
                $("#btnAgregarProducto").show();
                $("#btnAgregarProducto").removeAttr("disabled");
                CloseLoading();
                return false;
            }
            $('#divMensajeCUV').hide();
            $("#divProductoObservaciones").html("");
            $("#divProductoMantenedor").hide();
            $("#btnAgregarProducto").hide();
            VisibleEstrategias(true);
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });

            var cuv = $("#hdfCUV").val();
            CargarCarouselEstrategias(cuv);

            PedidoOnSuccess();
            if (data.modificoBackOrder) messageInfo('Recuerda que debes volver a validar tu pedido.');

            $("#hdCuvEnSession").val("");

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
                            'variant': data.data.DescripcionOferta == "" ? "Estándar" : data.data.DescripcionOferta,
                            'quantity': Number(model.Cantidad),
                            'position': 1
                        }]
                    }
                }
            });

        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });

};

function VisibleEstrategias(accion) {
    accion == accion || false;
    if (accion) {
        if ($.trim($('#divListadoEstrategia').html()).length > 0) {
            $("#divListaEstrategias").show();
        }
    }
    else {
        $("#divListaEstrategias").hide();
    }
}

function PedidoOnSuccess() {
    var ItemCantidad = $("#txtCantidad").val();
    var ItemPrecio = $("#spnPrecio").html();
    var ItemTotal = parseFloat(ItemCantidad * ItemPrecio).toFixed(2);

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#hdfCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#spnPrecio").val("");
    $("#divNombreProducto").html("");
    $("#txtCantidad").val("");
    $("#txtCodigoProducto").val("");
    $("#btnAgregarProducto").attr("disabled", "disabled");
    $("#divProductoObservaciones").html("");
};
function TagManagerClickAgregarProducto(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, posicion) {
    var cuvSesion = $.trim($("#hdCuvEnSession").val());
    var descripcionTitulo = "";
    if (cuvSesion == "") {
        descripcionTitulo = "Productos destacados – Pedido";
        if (posicion == -1) {
            posicion = 1;
            descripcionTitulo = "Estándar";
        }
    } else { //viene de la pagina productos recomendados
        descripcionTitulo = "Productos destacados";
        var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
        var listaRecomendados = JSON.parse(cadListaRecomendados);

        for (var i = 0; i < listaRecomendados.length; i++) {
            var recomendado = listaRecomendados[i];
            var cuv = recomendado.CUV2;
            if (cuv == cuvSesion) {
                variant = recomendado.DescripcionEstrategia;
                posicion = recomendado.ID;
                break;
            }
        }
    }

    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }

        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': descripcionTitulo },
                    'products': [
                        {
                            'name': DescripcionProd,
                            'price': Precio,
                            'brand': Marca,
                            'id': CUV,
                            'category': Categoria,
                            'variant': variant,
                            'quantity': parseInt(Cantidad),
                            'position': parseInt(posicion)
                        }
                    ]
                }
            }
        });
    }

    posicion = -1;
};

/** Insertar Estrategia **/
function TagManagerCarruselClickAgregarEstrategia(boton) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);

    var article = $(boton).parents("[data-item]").eq(0);
    var valorPosicion = $(article).find(".valorPosicionCarrusel").val();

    var recomendado = listaRecomendados[valorPosicion - 1] || new Object();

    var valorFlagNueva = $(article).find(".valorFlagNueva").val();
    $("#hdfValorFlagNueva").val(valorFlagNueva);

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': 'Productos destacados – Pedido', 'action': 'click' },
                'products': [
                    {
                        'name': recomendado.DescripcionCUV2,
                        'id': recomendado.CUV2,
                        'category': 'NO DISPONIBLE',
                        'variant': recomendado.DescripcionEstrategia,
                        'position': recomendado.ID
                    }
                ]
            }
        }
    });
};

/** Funciones de Google Tag Manager Carrousel**/
function TagManagerCarruselInicio() {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);
    var cantidadRecomendados = $(".slick-active").length;

    var arrayEstrategia = new Array();
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = listaRecomendados[i] || new Object();
        var impresionRecomendado = {
            'name': recomendado.DescripcionCUV2,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Productos destacados – Pedido',
            'position': recomendado.ID
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
};
function TagManagerCarruselPrevia(esDrag) {
    return;
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);

    var primeraEstrategia = $(".slick-active").get(0);
    var posicionEstrategia = $(primeraEstrategia).find(".valorPosicionCarrusel").val();

    if (!esDrag) {
        if (posicionEstrategia == 1) {
            posicionEstrategia = listaRecomendados.length;
        } else {
            posicionEstrategia = posicionEstrategia - 1;
        }
    }
    posicionEstrategia = posicionEstrategia < 0 ? 0 : posicionEstrategia >= listaRecomendados.length ? listaRecomendados.length - 1 : posicionEstrategia;
    var recomendado = listaRecomendados[posicionEstrategia] || new Object();
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCUV2,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Productos destacados – Pedido',
        'position': recomendado.ID
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
};
function TagManagerCarruselSiguiente(esDrag) {
    return;
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);
    var cantidadRecomendadosVisibles = $(".slick-active").length;

    var ultimaEstrategia = $(".slick-active").get(cantidadRecomendadosVisibles - 1);
    var posicionEstrategia = $(ultimaEstrategia).find(".valorPosicionCarrusel").val();

    if (!esDrag) {
        if (posicionEstrategia == listaRecomendados.length) {
            posicionEstrategia = 1;
        } else {
            posicionEstrategia = parseInt(posicionEstrategia) + 1;
        }
    }

    posicionEstrategia = posicionEstrategia < 0 ? 0 : posicionEstrategia >= listaRecomendados.length ? listaRecomendados.length - 1 : posicionEstrategia;
    var recomendado = listaRecomendados[posicionEstrategia] || new Object();
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCUV2,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Productos destacados – Pedido',
        'position': recomendado.ID
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
};

function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
};
function MostrarMensaje(tipoMensaje, message) {
    switch (tipoMensaje) {
        case "mensajeCUVNoExiste":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVNoExiste);
            $divMensaje.show();
            break;
        case "mensajeCUVAgotado":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVAgotado);
            $divMensaje.show();
            break;
        case "mensajeCUVOfertaEspecial":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr('class', 'icono_aprobacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVOfertaEspecial);
            $divMensaje.show();
            break;
        case "mensajeCUVLiquidacion":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVLiquidacion);
            $divMensaje.show();
            break;
        case "mensajeCUVCantidadMaxima":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr("class", "icono_exclamacion");
            $divMensaje.find("#divMensaje").html(message);
            $divMensaje.show();
            break;
        case "mensajeEsExpoOferta":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html("Producto de ExpoOferta.");
            $divMensaje.show();
            break;
        case "mensajeCUVShowRoom":
            var $divMensaje = $('#divMensajeCUV');
            $divMensaje.find("#divIcono").attr("class", "icono_exclamacion");
            $divMensaje.find("#divMensaje").html(message);
            $divMensaje.show();
            break;
    };
};

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

// Agregar Cliente
function CerrarMantenerCliente() {
    $("#divAgregarClientePedido input[type='text']").val("");
    $("#divAgregarClientePedido input[type='email']").val("");
    $("#divAgregarClientePedido").hide();
}
function AgregarMantenerCliente() {
    var entidad = ValidarMantenerCliente();
    if (entidad.Error) return false;

    var item = {
        ClienteID: 0,
        Nombre: entidad.nombre,
        eMail: entidad.correo,
        FlagValidate: 1
    };

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Cliente/Mantener',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == false) {
                    alert_msg(data.message);
                    CloseLoading();
                    return false;
                }

                CargarListaCliente();

                $.each($("#ddlClientes option"), function (ind, cli) {
                    if ($(cli).text() == entidad.nombre) {
                        $(cli).attr("selected", "selected");
                    }
                });
                CerrarMantenerCliente();

                $("#popupClienteIngresado").show();
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Clientes',
                    'action': 'Agregar',
                    'label': 'Satisfactorio'
                });
            }
            CloseLoading();
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                alert(data.message);
            }
        }
    });
}

function ValidarMantenerCliente() {
    var nombre = $.trim($('#Nombres').val());
    var correo = $.trim($('#Correo').val());
    var entidad = new Object();
    entidad.Error = false;

    $('#divNotiNombre, #divNotiEmail').hide();
    if (nombre == "") {
        $('#divNotiNombre').show();
        entidad.Error = true;
    }
    if (correo != "") {
        if (!validateEmail(correo)) {
            $('#divNotiEmail').show();
            entidad.Error = true;
        }
    }
    entidad.nombre = nombre;
    entidad.correo = correo;
    return entidad;
}

function CargarListaCliente() {
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Cliente/ObtenerTodosClientes',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                $("#ddlClientes option[value!='0']").remove();

                if (data.success == false) {
                    return false;
                }
                data.lista = data.lista || new Array();
                $.each(data.lista, function (ind, cli) {
                    $("#ddlClientes").append(new Option(cli.Nombre, cli.ClienteID));
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert(data.message);
            }
        }
    });
}

// Fin Agregar Cliente

//Google Analytics
function TagManagerCarruselInicio(arrayItems) {
    var cantidadRecomendados = $('#divListadoEstrategia').find(".slick-active").length;

    var arrayEstrategia = [];
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = arrayItems[i];
        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – Pedido',
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}
function TagManagerClickAgregarProducto() {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Ofertas para ti – Pedido' },
                'products': [
                    {
                        'name': $("#txtCantidadZE").attr("est-descripcion"),
                        'price': $("#txtCantidadZE").attr("est-precio2"),
                        'brand': $("#txtCantidadZE").attr("est-descripcionMarca"),
                        'id': $("#txtCantidadZE").attr("est-cuv2"),
                        'category': 'NO DISPONIBLE',
                        'variant': $("#txtCantidadZE").attr("est-descripcionEstrategia"),
                        'quantity': parseInt($("#txtCantidadZE").val()),
                        'position': parseInt($("#txtCantidadZE").attr("est-posicion"))
                    }
                ]
            }
        }
    });
}
function TagManagerCarruselPrevia() {
    var posicionPrimerActivo = $($('#divListadoEstrategia').find(".slick-active")[0]).find('.PosicionEstrategia').val();
    var posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length - 1 : posicionPrimerActivo - 2;
    var recomendado = arrayOfertasParaTi[posicionEstrategia];
    var arrayEstrategia = new Array();


    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Ofertas para ti – Pedido',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Pedido',
        'action': 'Ofertas para ti',
        'label': 'Ver anterior'
    });

}
function TagManagerCarruselSiguiente() {
    var posicionUltimoActivo = $($('#divListadoEstrategia').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
    var posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
    var recomendado = arrayOfertasParaTi[posicionEstrategia];
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCompleta,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Ofertas para ti – Pedido',
        'position': recomendado.Posicion
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Pedido',
        'action': 'Ofertas para ti',
        'label': 'Ver siguiente'
    });

}


function maxLengthCheck(object, cantidadMaxima) {
    if (object.value.length > cantidadMaxima)
        object.value = object.value.slice(0, cantidadMaxima);
}