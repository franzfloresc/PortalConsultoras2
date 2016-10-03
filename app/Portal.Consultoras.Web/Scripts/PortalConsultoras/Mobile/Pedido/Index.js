
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
            $("#divListaEstrategias").show();
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });
        } else {
            $("#divListaEstrategias").hide();
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

    var CuvEnSession = $("#hdCuvEnSession").val();
    if (CuvEnSession != null) {
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
        url: urlInsertar,
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
            $("#divListaEstrategias").show();
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });
            $('#PopSugerido').hide();

            CargarCarouselEstrategias(cuv);
            $("#txtCodigoProducto").val("");
            $("#hdCuvEnSession").val("");
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
    var urlInsertar = esOfertaNueva ? urlInsertOfertaNueva : urlInsert;
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

            CloseLoading();

            if (data.success == true) {
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
                $("#divListaEstrategias").show();
                $("#divResumenPedido").show();
                $("footer").show();
                $(".footer-page").css({ "margin-bottom": "0px" });

                var cuv = $("#hdfCUV").val();
                CargarCarouselEstrategias(cuv);

                PedidoOnSuccess();

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

            } else {
                $("#btnAgregarProducto").removeAttr("disabled", "disabled");
                $("#btnAgregarProducto").show();
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

function CargarCarouselEstrategias(cuv) {
    $('#slick-prev').remove();
    $('#slick-next').remove();
    $('#divContenidoEstrategias.slick-initialized').slick('unslick');

    $('#divContenidoEstrategias').html('<div style="text-align: center;">Cargando Productos Destacados<br><img src="' + urlLoad + '" /><br /></div>');

    jQuery.ajax({
        type: 'GET',
        url: urlCargarListaEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ cuv: cuv }),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                ArmarCarouselEstrategias(data);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });
};
function ArmarCarouselEstrategias(data) {
    data = EstructurarDataCarousel(data);
    arrayOfertasParaTi = data;

    SetHandlebars("#estrategia-template", data, "#divContenidoEstrategias");

    if ($.trim($('#divContenidoEstrategias').html()).length == 0) {
        $('.fondo_gris').hide();
    } else {
        $('#divContenidoEstrategias').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            dots: false,
            prevArrow: '<span class="previous_ofertas_mobile" id="slick-prev" style="margin-left:-13%;"><img src="' + urlCarruselPrev + '")" alt="-"/></span>',
            nextArrow: '<span class="previous_ofertas_mobile" id="slick-next" style="margin-right:-13%; text-align:right; right:0;"><img src="' + urlCarruselNext + '" alt="-"/></span>',
            infinite: true,
            speed: 300,
            responsive: [
                {
                    breakpoint: 960,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 680,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                },
                {
                    breakpoint: 380,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            var accion;
            if (nextSlide == 0 && currentSlide + 1 == arrayOfertasParaTi.length) {
                accion = 'next';
            } else if (currentSlide == 0 && nextSlide + 1 == arrayOfertasParaTi.length) {
                accion = 'prev';
            } else if (nextSlide > currentSlide) {
                accion = 'next';
            } else {
                accion = 'prev';
            };

            if (accion == 'prev') {
                //TagManager
                var posicionPrimerActivo = $($('#divContenidoEstrategias').find(".slick-active")[0]).find('.PosicionEstrategia').val();
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
                    'event': 'virtualEvent',
                    'category': 'Pedido',
                    'action': 'Ofertas para ti',
                    'label': 'Ver anterior'
                });
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });                
            } else if (accion == 'next') {
                //TagManager
                var posicionUltimoActivo = $($('#divContenidoEstrategias').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
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
                    'event': 'virtualEvent',
                    'category': 'Pedido',
                    'action': 'Ofertas para ti',
                    'label': 'Ver siguiente'
                });
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });                
            };

        });
        TagManagerCarruselInicio(data);
    }
};
function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        item.DescripcionCompleta = item.DescripcionCUV2;
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        };
        item.Posicion = i + 1;
    });

    return array;
};
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

function CargarProductoDestacado(objParameter, objInput) {   
    ShowLoading();
   
    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;
    var cantidadIngresada = $(objInput).parent().find("input.rango_cantidad_pedido").val();
    var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: urlFiltrarEstrategiasPedido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {
            var flagEstrella = (datos.data.FlagEstrella == 0) ? "hidden" : "visible";
            $("#imgTipoOfertaEdit").attr("src", datos.data.ImagenURL);
            $("#imgEstrellaEdit").css({ "visibility": flagEstrella });
            $("#imgZonaEstrategiaEdit").attr("src", datos.data.FotoProducto01);

            if (datos.data.Precio != "0") {
                $(".zona2Edit").html(datos.data.EtiquetaDescripcion + ' ' + datos.data.Simbolo + '' + datos.precio);
            } else {
                $(".zona2Edit").html("");
            }

            if (datos.data.Precio2 != "0") {
                $(".zona3Edit_1").html(datos.data.EtiquetaDescripcion2);
                $(".zona3Edit_2").html('<span>' + datos.data.Simbolo + '' + datos.precio2 + '</span>');
            } else {
                $(".zona3Edit_1").html("");
                $(".zona3Edit_2").html("");
            }

            if (datos.data.TextoLibre != "") {
                $(".zona4Edit").html(datos.data.TextoLibre);
            } else {
                $(".zona4Edit").html("");
            }

            if (datos.data.ColorFondo != "") {
                $("#divVistaPrevia").css({ "background-color": datos.data.ColorFondo });
            } else {
                $("#divVistaPrevia").css({ "background-color": "#FFF" });
            }

            $("#txtCantidadZE").val(cantidadIngresada);
            $("#txtCantidadZE").attr("est-cantidad", datos.data.LimiteVenta);
            $("#txtCantidadZE").attr("est-cuv2", datos.data.CUV2);
            $("#txtCantidadZE").attr("est-marcaID", datos.data.MarcaID);
            $("#txtCantidadZE").attr("est-precio2", datos.data.Precio2);
            $("#txtCantidadZE").attr("est-montominimo", datos.data.IndicadorMontoMinimo);
            $("#txtCantidadZE").attr("est-tipooferta", datos.data.TipoOferta);
            $("#txtCantidadZE").attr("est-descripcionMarca", datos.data.DescripcionMarca);
            $("#txtCantidadZE").attr("est-descripcionEstrategia", datos.data.DescripcionEstrategia);
            $("#txtCantidadZE").attr("est-descripcionCategoria", datos.data.DescripcionCategoria);
            $("#txtCantidadZE").attr("est-posicion", posicionItem);

            $("#ddlTallaColor").empty();
            $(".zona0Edit").html(datos.data.DescripcionMarca);

            /*Validar Programa Ofertas Nuevas*/
            $("#hdnProgramaOfertaNuevo").val(false);
            $("#OfertasResultados li").hide();
            $("#OfertaTipoNuevo").val("");
           
            if (datos.data.FlagNueva == 1) {
                $(".zona4Edit").hide();
                $(".zonaCantidad").hide();
                $("#hdnProgramaOfertaNuevo").val(true);
                var nroPedidos = false;
                var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

                pedidosData.each(function (indice, valor) {
                    if (valor.value == 1) {
                        nroPedidos = true;
                        var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                            $('#hdnPagina').val(), ";",
                            $('#hdnClienteID2_').val());

                        $("#OfertaTipoNuevo").val(OfertaTipoNuevo);
                        return;
                    }
                });

                if (nroPedidos) {
                    $(".zona4Edit").text(datos.data.TextoLibre);
                    $(".zona4Edit").show();
                }

                var ofertas = datos.data.DescripcionCUV2.split('|');
                $(".zona1Edit").html(ofertas[0]);
                $("#txtCantidadZE").attr("est-descripcion", ofertas[0]);
                $("#OfertasResultados li").remove(); // Limpiar la lista.

                $.each(ofertas, function (i) {
                    if (i != 0 && $.trim(ofertas[i]) != "") {
                        $("#OfertasResultados").append("<li>" + ofertas[i] + "</li>");
                    }
                });

                CloseLoading();
                AgregarProductoDestacado(tipoEstrategiaImagen);
            } else {
                $(".zona4Edit").show();
                $(".zonaCantidad").show();
                $(".zona1Edit").html(datos.data.DescripcionCUV2);
                $("#txtCantidadZE").attr("est-descripcion", datos.data.DescripcionCUV2);
                var option = "";
                $(".tallaColor").hide();
                if (datos.data.TallaColor != "") {
                    var arrOption = datos.data.TallaColor.split('</>');
                    if (arrOption.length > 2) {
                        for (var i = 0; i < arrOption.length; i++) {
                            if (arrOption[i] != "") {
                                option = "<option ";
                                var strOption = arrOption[i].split('|');
                                var strCuv = strOption[0];
                                var strDescCuv = strOption[1];
                                var strDescTalla = strOption[2];
                                option += " value='" + strCuv + "' desc-talla='" + strDescCuv + "' >" + strDescTalla + "</option>";
                                $("#ddlTallaColor").append(option);
                            }
                        }

                        $(".tallaColor").show();
                    }
                }
                if (option == "") {
                    AgregarProductoDestacado(tipoEstrategiaImagen);                    
                } else {
                    CloseLoading();
                }
            }

            InfoCommerceGoogleDestacadoProductClick(datos.data.DescripcionCUV2, datos.data.CUV2, datos.data.DescripcionCategoria, datos.data.DescripcionEstrategia, posicionItem);
            CloseLoading();
        },
        error: function (data, error) {
            alert(datos.data.message);
            CloseLoading();
        }
    });
};
function AgregarProductoDestacado(tipoEstrategiaImagen) {
    var cantidad = $("#txtCantidadZE").val();
    var cantidadLimite = $("#txtCantidadZE").attr("est-cantidad");
    var cuv = $("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $("#txtCantidadZE").attr("est-marcaID");
    var precio = $("#txtCantidadZE").attr("est-precio2");
    var descripcion = $("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $("#txtCantidadZE").attr("est-montominimo");
    var tipoOferta = $("#txtCantidadZE").attr("est-tipooferta");
    var categoria = $("#txtCantidadZE").attr("est-descripcionCategoria");
    var variant = $("#txtCantidadZE").attr("est-descripcionEstrategia");
    var marca = $("#txtCantidadZE").attr("est-descripcionMarca");
    var posicion = $("#txtCantidadZE").attr("est-posicion");
    var urlImagen = $("#imgZonaEstrategiaEdit").attr("src");
    var OrigenPedidoWeb = MobilePedidoOfertasParaTi;

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            messageInfo("Por favor, seleccione la Talla/Color del producto.");
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        messageInfo("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        messageInfo("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        messageInfo("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        $("#loadingScreen").dialog('close');
        return false;
    }

    ShowLoading();

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0,
        OrigenPedidoWeb: OrigenPedidoWeb
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
                messageInfo(datos.message);
                CloseLoading();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: urlAgregarProducto,
                    dataType: 'html',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (checkTimeout(data)) {
                            ActualizarGanancia(JSON.parse(data).DataBarra);
                            ShowLoading();                            
                            CargarCarouselEstrategias(cuv);
                            TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                            TagManagerClickAgregarProducto();
                            CloseLoading();
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CloseLoading();
                        }
                    }
                });
            }           
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
            }
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
    var cantidadRecomendados = $('#divContenidoEstrategias').find(".slick-active").length;

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
    var posicionPrimerActivo = $($('#divContenidoEstrategias').find(".slick-active")[0]).find('.PosicionEstrategia').val();
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
    var posicionUltimoActivo = $($('#divContenidoEstrategias').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
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