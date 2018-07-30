var cantidadRegistros = 10;
var offset = 0;
var puedeCargar = true;
$(document).ready(function () {
    $(document).on('click', '#boton_vermas', function () {
        puedeCargar = false;
        CargarOfertasLiquidacion();
    });
    $(window).scroll(function () {
        if ($(this).scrollTop() > 70) {
            $('.productos_fixed').addClass("fixed");
        } else {
            $('.productos_fixed').removeClass("fixed");
        }
    });

    CargarOfertasLiquidacion();

    $(".footer-page").css({ "margin-bottom": "54px" });

    $("body").on("click", ".suma", function () {
        var article = $(this).parents("article").eq(0);
        var cantidad = $(article).find(".txtCantidad").val();
        var cajaTexto = $(article).find(".txtCantidad");
        if (cantidad == 99)
            $(cajaTexto).val(Number(99));
        else
            $(cajaTexto).val(Number(cantidad) + 1);
    });
    $("body").on("click", ".resta", function () {
        var article = $(this).parents("article").eq(0);
        var cantidad = $(article).find(".txtCantidad").val();
        var cajaTexto = $(article).find(".txtCantidad");
        if (cantidad == 1)
            $(cajaTexto).val(Number(1));
        else
            $(cajaTexto).val(Number(cantidad) - 1);
    });

    $("body").on("click", ".btnAgregarOfertaProducto", function (e) {
        if (ReservadoOEnHorarioRestringido())
            return;
        var article = $(this).parents(".liquidacion_item").eq(0);
        AgregarOfertaProducto(article);
        e.preventDefault();
        (this).blur();
    });
    
});
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
                        if (mostrarAlerta == true) {
                            CloseLoading();
                            AbrirPopupPedidoReservado(data.message, '2')
                        }
                        else fnRedireccionar();
                    }
                    else if (mostrarAlerta == true)
                        AbrirMensaje(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
            }
        }
    });
    return restringido;
}
function CargarOfertasLiquidacion() {
    $.ajax({
        type: 'GET',
        url: urlGetJSONLiquidaciones,
        data: { offset: offset, cantidadregistros: cantidadRegistros, origen: 'OfertaLiquidacion' },
        dataType: 'json',
        beforeSend: function () {
            $('#loader').show();
            $('#boton_vermas').hide();
        },
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                ArmarCarouselLiquidaciones(data.lista);
                if (data.verMas == true) {
                    $('#boton_vermas').show();
                }
                offset += cantidadRegistros;
            }
        },
        complete: function (data) {
            $('#loader').hide();
            puedeCargar = true;
        },
        error: function (data) {
            if (checkTimeout(data)) {
                puedeCargar = true;
                $('#boton_vermas').show();
                $('#loader').hide();
            }
        }
    });
}
function ArmarCarouselLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#OfertasLiquidacionMobile-template", data);
    $('#liquidacionMobile').append(htmlDiv);

    EstablecerAccionLazyImagen("img[data-lazy-seccion-liquidacion]");
}
function EstructurarDataCarouselLiquidaciones(array) {
    var contadorLq = 1;
    $.each(array, function (i, item) {
        item.Descripcion = (item.Descripcion.length > 60 ? item.Descripcion.substring(0, 60) + "..." : item.Descripcion);
        item.Posicion = contadorLq;

        item.TallaColor = $.trim(item.TallaColor);
        if (item.TallaColor.length > 2 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TieneTallaColor = false;
        };
        contadorLq++;
    });

    return array;
}
function AgregarOfertaProducto(article) {
    var cantidad = $(article).find("#txtCantidad").val();
    var CUV = $(article).find(".valorCUV").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
    var divProductoAgregado = "Agregado";
    var DescripcionProd = $(article).find(".DescripcionProd").val();
    var DescripcionMarca = $(article).find(".DescripcionMarca").val();
    var DescripcionCategoria = $(article).find(".DescripcionCategoria").val();
    var DescripcionEstrategia = $(article).find(".DescripcionEstrategia").val();
    var posicionEstrategia = $(article).find(".posicionEstrategia").val();

    if (cantidad == "" || cantidad == 0) {
        messageInfo("La cantidad ingresada debe ser mayor que 0, verifique.");
    } else {
        ShowLoading();

        $.ajaxSetup({ cache: false });
        $.getJSON(urlValidarUnidadesPermitidasPedidoProducto, { CUV: CUV, Cantidad: cantidad, PrecioUnidad: PrecioUnidad }, function (data) {
            if (data.message.length > 0) {
                CloseLoading();
                messageInfo(data.message);
                return false;
            }
            if (parseInt(data.Saldo) < parseInt(cantidad)) {
                var Saldo = data.Saldo;
                var UnidadesPermitidas = data.UnidadesPermitidas;

                $.getJSON(urlObtenerStockActualProducto, { CUV: CUV }, function (data) {

                    $(article).find(".claseStock").text(data.Stock);

                    CloseLoading();
                    if (Saldo == UnidadesPermitidas) {
                        messageInfo("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                    }
                    else {
                        if (Saldo == "0")
                            messageInfo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                        else
                            messageInfo("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                    }
                });
            } else {
                var Item = {
                    MarcaID: MarcaID,
                    Cantidad: cantidad,
                    PrecioUnidad: PrecioUnidad,
                    CUV: CUV,
                    ConfiguracionOfertaID: ConfiguracionOfertaID,
                    OrigenPedidoWeb: MobileLiquidacion
                };

                $.ajaxSetup({ cache: false });
                $.getJSON(urlObtenerStockActualProducto, { CUV: CUV }, function (data) {

                    if (parseInt(data.Stock) < parseInt(cantidad)) {
                        $(article).find(".claseStock").text(data.Stock);

                        CloseLoading();
                        messageInfo("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.");
                    }
                    else {
                        jQuery.ajax({
                            type: 'POST',
                            url: urlInsertOfertaWebPortal,
                            dataType: 'json',
                            contentType: 'application/json; charset=utf-8',
                            data: JSON.stringify(Item),
                            async: true,
                            success: function (response) {
                                CloseLoading();
                                if (checkTimeout(response)) {
                                    if (response.success == true) {
                                        $("#divMensajeProductoAgregado").show();
                                        $(divProductoAgregado).css('display', 'block');

                                        var stockRestante = parseInt(data.Stock) - parseInt(cantidad);
                                        if (stockRestante < 1) {
                                            $(article).find(".resta").attr('disabled', 'disabled');
                                            $(article).find(".suma").attr('disabled', 'disabled');
                                            $(article).find(".txtCantidad").attr('disabled', 'disabled');
                                            $(article).find(".btnAgregarOfertaProducto").attr('disabled', 'disabled');

                                            $(article).find(".claseStock").text("0");
                                            $(article).find(".txtCantidad").val("0");
                                        } else {
                                            $(article).find(".claseStock").text(stockRestante);
                                            $(article).find(".txtCantidad").val("1");
                                        }

                                        InfoCommerceGoogle(parseFloat(cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, cantidad, DescripcionMarca, DescripcionEstrategia, posicionEstrategia);
                                        CargarCantidadProductosPedidos();

                                        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), CUV);

                                        setTimeout(function () {
                                            $("#divMensajeProductoAgregado").fadeOut();
                                        }, 2000);
                                    }
                                    else messageInfoError(response.message);
                                }
                            },
                            error: function (response, error) {
                                if (checkTimeout(response)) {
                                    CloseLoading();
                                }
                            }
                        });
                    }
                });
            }
        });
    }
}
function HorarioRestringido() {
    var horarioRestringido = false;
    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    window.messageInfo(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) { }
    });
    return horarioRestringido;
}
function ActualizarCantidadTotalPedido() {
    jQuery.ajax({
        type: 'POST',
        url: urlActualizarCantidadTotalPedido,
        dataType: 'json',
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    var data = response.data;
                    console.log('OfertaLiquidacion - Index.js - ActualizarCantidadTotalPedido', data);
                    $(".num-menu-shop").html(data.CantidadProductos);
                } else {
                    window.messageInfo(response.message);
                }
            }
        },
        error: function (response, error) { }
    });
}
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, posicion) {
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "" || variant == "NO DISPONIBLE") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': 'Liquidación Web' },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': 'NO DISPONIBLE',
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': parseInt(posicion)
                    }]
                }
            }
        })
    }
}
function TagManagerOfertaLiquidacion() {
    var cadListaofertaLiquidadas = $("#hdListaProductosEnLiquidacion").val();
    var listaofertaLiquidadas = JSON.parse(cadListaofertaLiquidadas);
    var cantidadofertaLiquidadas = $('.panel-product').length;

    var arrayEstrategia = new Array();
    var position = 1;
    for (var i = 0; i < cantidadofertaLiquidadas; i++) {
        var variant = "";
        var ofertaLiquidada = listaofertaLiquidadas[i];
        if (ofertaLiquidada.DescripcionEstrategia == null || ofertaLiquidada.DescripcionEstrategia == "" ||
            ofertaLiquidada.DescripcionEstrategia == "NO DISPONIBLE") {
            variant = "Estándar";
        } else {
            variant = ofertaLiquidada.DescripcionEstrategia;
        }
        var impresionofertaLiquidada = {

            'name': ofertaLiquidada.Descripcion,
            'id': ofertaLiquidada.CUV,
            'price': ofertaLiquidada.PrecioOferta.toString(),
            'brand': ofertaLiquidada.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': variant,
            'list': 'Liquidación Web',
            'position': position

        };
        position++;
        arrayEstrategia.push(impresionofertaLiquidada);
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